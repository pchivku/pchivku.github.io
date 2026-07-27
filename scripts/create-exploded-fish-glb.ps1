param(
  [string]$InputPath = "files/AGMPUFL/Fish_changed.glb",
  [string]$OutputPath = "files/AGMPUFL/Fish_changed_Exploded.glb"
)

$ErrorActionPreference = "Stop"

function Add-Float32 {
  param(
    [System.Collections.Generic.List[byte]]$Target,
    [float]$Value
  )

  $Target.AddRange([BitConverter]::GetBytes($Value))
}

$inputFullPath = (Resolve-Path -LiteralPath $InputPath).Path
$bytes = [System.IO.File]::ReadAllBytes($inputFullPath)

if ([Text.Encoding]::ASCII.GetString($bytes, 0, 4) -ne "glTF") {
  throw "Input is not a binary glTF file."
}

$jsonLength = [BitConverter]::ToUInt32($bytes, 12)
$jsonText = [Text.Encoding]::UTF8.GetString($bytes, 20, $jsonLength).TrimEnd([char]0, [char]32)
$gltf = $jsonText | ConvertFrom-Json

# The main lid, rotor cover, and servo shell share the exterior body material.
$exteriorNodeNames = @(
  "C_lid_switch_2holes-1",
  "Rotor_cover-1",
  "shell_curve_Servo2-1"
)
$exteriorMaterialIndices = foreach ($node in $gltf.nodes) {
  if ($node.name -in $exteriorNodeNames -and $null -ne $node.mesh) {
    $gltf.meshes[[int]$node.mesh].primitives |
      ForEach-Object { [int]$_.material }
  }
}

foreach ($materialIndex in @($exteriorMaterialIndices | Select-Object -Unique)) {
  $material = $gltf.materials[$materialIndex].pbrMetallicRoughness
  $material.baseColorFactor = @(1.0, 1.0, 1.0, 1.0)
  $material.metallicFactor = 0.4
}

$binHeaderOffset = 20 + $jsonLength
$binLength = [BitConverter]::ToUInt32($bytes, $binHeaderOffset)
$binType = [BitConverter]::ToUInt32($bytes, $binHeaderOffset + 4)
if ($binType -ne 0x004E4942) {
  throw "Expected a BIN chunk after the JSON chunk."
}

$binOffset = $binHeaderOffset + 8
$animationBytes = [System.Collections.Generic.List[byte]]::new()
while ((($binLength + $animationBytes.Count) % 4) -ne 0) {
  $animationBytes.Add(0)
}

$bufferViews = [System.Collections.ArrayList]::new()
foreach ($item in $gltf.bufferViews) { [void]$bufferViews.Add($item) }
$accessors = [System.Collections.ArrayList]::new()
foreach ($item in $gltf.accessors) { [void]$accessors.Add($item) }

$timeByteOffset = $binLength + $animationBytes.Count
Add-Float32 $animationBytes 0.0
Add-Float32 $animationBytes 3.0

$timeViewIndex = $bufferViews.Count
[void]$bufferViews.Add([pscustomobject]@{
  buffer = 0
  byteOffset = $timeByteOffset
  byteLength = 8
})
$timeAccessorIndex = $accessors.Count
[void]$accessors.Add([pscustomobject]@{
  bufferView = $timeViewIndex
  componentType = 5126
  count = 2
  type = "SCALAR"
  min = @(0.0)
  max = @(3.0)
})

$sceneRootIndices = @($gltf.scenes[[int]$gltf.scene].nodes)
$rootIndex = $sceneRootIndices |
  Where-Object { $gltf.nodes[[int]$_].name -eq "Fish_assembly" } |
  Select-Object -First 1
if ($null -eq $rootIndex) {
  throw "Could not find the Fish_assembly scene root."
}
$root = $gltf.nodes[[int]$rootIndex]
$children = @($root.children)
$center = @(0.704, 0.921, 1.359)
$channels = [System.Collections.ArrayList]::new()
$samplers = [System.Collections.ArrayList]::new()

for ($position = 0; $position -lt $children.Count; $position++) {
  $nodeIndex = [int]$children[$position]
  $node = $gltf.nodes[$nodeIndex]
  if ($null -eq $node.translation -or $node.translation.Count -ne 3) {
    continue
  }

  $original = @(
    ([double]$node.translation[0])
    ([double]$node.translation[1])
    ([double]$node.translation[2])
  )

  $direction = @(
    ($original[0] - $center[0])
    ($original[1] - $center[1])
    $original[2] - $center[2]
  )
  $length = [Math]::Sqrt(
    $direction[0] * $direction[0] +
    $direction[1] * $direction[1] +
    $direction[2] * $direction[2]
  )

  if ($length -lt 0.012 -or $length -gt 0.35) {
    $angle = (2.399963229728653 * $position)
    $direction = @(
      [Math]::Cos($angle)
      (($position % 5) - 2) * 0.32
      [Math]::Sin($angle)
    )
    $length = [Math]::Sqrt(
      $direction[0] * $direction[0] +
      $direction[1] * $direction[1] +
      $direction[2] * $direction[2]
    )
  }

  $distance = 0.12 + (0.012 * ($position % 4))
  $exploded = @(
    $original[0] + ($direction[0] / $length) * $distance
    $original[1] + ($direction[1] / $length) * $distance
    $original[2] + ($direction[2] / $length) * $distance
  )

  # Keep paired fins on a clean lateral axis and lift the lid vertically.
  switch ($node.name) {
    "Side_fin-1" {
      $exploded = @(
        $original[0]
        $original[1]
        ($original[2] - 0.18)
      )
    }
    "Side_fin-2" {
      $exploded = @(
        $original[0]
        $original[1]
        ($original[2] + 0.18)
      )
    }
    "C_lid_switch_2holes-1" {
      $exploded = @(
        $original[0]
        $original[1]
        ($original[2] + 0.18)
      )
    }
    "Tail_cross-1" {
      $exploded = @(
        ($original[0] + 0.24)
        $original[1]
        $original[2]
      )
    }
    "Cont_shell_curve_servo_tail4-1" {
      $exploded = @(
        ($original[0] + 0.12)
        $original[1]
        $original[2]
      )
    }
    "Cont_shell_curve_servo_horn_correct-1" {
      $exploded = @(
        $original[0]
        $original[1]
        ($original[2] - 0.18)
      )
    }
  }

  $outputByteOffset = $binLength + $animationBytes.Count
  foreach ($value in $original) { Add-Float32 $animationBytes ([float]$value) }
  foreach ($value in $exploded) { Add-Float32 $animationBytes ([float]$value) }

  $outputViewIndex = $bufferViews.Count
  [void]$bufferViews.Add([pscustomobject]@{
    buffer = 0
    byteOffset = $outputByteOffset
    byteLength = 24
  })
  $outputAccessorIndex = $accessors.Count
  [void]$accessors.Add([pscustomobject]@{
    bufferView = $outputViewIndex
    componentType = 5126
    count = 2
    type = "VEC3"
  })

  $samplerIndex = $samplers.Count
  [void]$samplers.Add([pscustomobject]@{
    input = $timeAccessorIndex
    output = $outputAccessorIndex
    interpolation = "CUBICSPLINE"
  })
  # CUBICSPLINE requires tangent data, so use smooth browser interpolation.
  $samplers[$samplerIndex].interpolation = "LINEAR"

  [void]$channels.Add([pscustomobject]@{
    sampler = $samplerIndex
    target = [pscustomobject]@{
      node = $nodeIndex
      path = "translation"
    }
  })
}

$gltf.bufferViews = @($bufferViews)
$gltf.accessors = @($accessors)
$gltf.buffers[0].byteLength = $binLength + $animationBytes.Count
$gltf | Add-Member -Force -NotePropertyName animations -NotePropertyValue @(
  [pscustomobject]@{
    name = "ExplodedAssembly"
    channels = @($channels)
    samplers = @($samplers)
  }
)

$newJson = $gltf | ConvertTo-Json -Depth 100 -Compress
$jsonBytes = [System.Collections.Generic.List[byte]]::new()
$jsonBytes.AddRange([Text.Encoding]::UTF8.GetBytes($newJson))
while (($jsonBytes.Count % 4) -ne 0) { $jsonBytes.Add(0x20) }

$newBin = [System.Collections.Generic.List[byte]]::new()
$newBin.AddRange([byte[]]$bytes[$binOffset..($binOffset + $binLength - 1)])
$newBin.AddRange($animationBytes)

$output = [System.Collections.Generic.List[byte]]::new()
$output.AddRange([Text.Encoding]::ASCII.GetBytes("glTF"))
$output.AddRange([BitConverter]::GetBytes([uint32]2))
$totalLength = 12 + 8 + $jsonBytes.Count + 8 + $newBin.Count
$output.AddRange([BitConverter]::GetBytes([uint32]$totalLength))
$output.AddRange([BitConverter]::GetBytes([uint32]$jsonBytes.Count))
$output.AddRange([BitConverter]::GetBytes([uint32]0x4E4F534A))
$output.AddRange($jsonBytes)
$output.AddRange([BitConverter]::GetBytes([uint32]$newBin.Count))
$output.AddRange([BitConverter]::GetBytes([uint32]0x004E4942))
$output.AddRange($newBin)

$outputFullPath = [IO.Path]::GetFullPath((Join-Path (Get-Location) $OutputPath))
[System.IO.File]::WriteAllBytes($outputFullPath, $output.ToArray())
Write-Host "Created $outputFullPath with $($channels.Count) animated subassemblies."
