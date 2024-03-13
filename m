Return-Path: <linux-pci+bounces-4790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDB487A9DF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 15:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5171C21ABF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6441740;
	Wed, 13 Mar 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh5gs3Hu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783017483;
	Wed, 13 Mar 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341972; cv=none; b=hOISN/LJS7ChWksGP+B4uegz0Zc2lBasPdJeFREwbdZEYateqnIIRprfnYqscQ6eCOrO9ZKYCD8GdzrdznEbA2rXSw5WrNIihtUIxbNVbFIBlwoSBACbNYaCsZSwkxcZo9yWgcsCuuuR3MF7gz7F4s5BSIJn+0zmRzIF9wQRDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341972; c=relaxed/simple;
	bh=LZLp5RrHmMyULHvEPNz65qxqnQ0PaY3rtOZLS9J+fVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MGGKWLlKfBlT38vmHA+uh6W1dEghXvlXDa98vHrxwtVXKAo+aoXcpRquTvr5koSXaQyhcPz8yu8ODR2kTzCWn8pvt04Tcyp8UeGQ9lq2WWIJUhQAyXAM7zZec1WggY7nnytdLBwJ9ZB+IbySc/1cCuYhu5GSdT+0nqF+FE7giN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh5gs3Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BABC433F1;
	Wed, 13 Mar 2024 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710341972;
	bh=LZLp5RrHmMyULHvEPNz65qxqnQ0PaY3rtOZLS9J+fVE=;
	h=Date:From:To:Cc:Subject:From;
	b=jh5gs3HuWRleradC0rqbQBubdBJxmuLiEF/rkfwkTme4KEFXjh/RTaA/N3mZIb8/3
	 1GCQDkuwuoaoNo1SjA+DFt/K9tlYoaaNf6jfHnIm6wsGwv9ngURfHq4lLTwPW3PRtN
	 rq3bHRi9lhC+8MPjqtjnYQiBlE/Woz5NhX4GVRk5ffCBj5VtCg5avDl2SW5Fgq2On/
	 4spOjTgwwAtRfoyiQgfREwDmQMGB9sszyNKejtWWvYo/o2IBMGbp/u7WNI4KwR4tgi
	 nCIQOFEFW0DcXQRW0HJncsqU1ojQl6kLVz0VGnDoDqECtHtdi06/pCW4ALbEWlKdQR
	 7Q1Z3n3qsOW7g==
Date: Wed, 13 Mar 2024 09:59:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.9
Message-ID: <20240313145930.GA918008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.9-changes

for you to fetch changes up to aabf7173cdfed20ba8677548b601ee6d966712aa:

  Merge branch 'pci/controller/qcom' (2024-03-12 12:14:26 -0500)

----------------------------------------------------------------

Enumeration:

  - Consolidate interrupt related code in irq.c (Ilpo Järvinen)

  - Reduce kernel size by replacing sysfs resource macros with functions
    (Ilpo Järvinen)

  - Reduce kernel size by compiling sysfs support only when CONFIG_SYSFS=y
    (Lukas Wunner)

  - Avoid using Extended Tags on 3ware-9650SE Root Port to work around an
    apparent hardware defect (Jörg Wedekind)

Resource management:

  - Fix an MMIO mapping leak in pci_iounmap() (Philipp Stanner)

  - Move pci_iomap.c and other PCI-specific devres code to drivers/pci
    (Philipp Stanner)

  - Consolidate PCI devres code in devres.c (Philipp Stanner)

Power management:

  - Avoid D3cold on Asus B1400 PCI-NVMe bridge, where firmware doesn't know
    how to return correctly to D0, and remove previous quirk that wasn't as
    specific (Daniel Drake)

  - Allow runtime PM when the driver enables it but doesn't need any
    runtime PM callbacks (Raag Jadav)

  - Drain runtime-idle callbacks before driver removal to avoid races
    between .remove() and .runtime_idle(), which caused intermittent page
    faults when the rtsx .runtime_idle() accessed registers that its
    .remove() had already unmapped (Rafael J. Wysocki)

Virtualization:

  - Avoid Secondary Bus Reset on LSI FW643 so it can be assigned to VMs
    with VFIO, e.g., for professional audio software on many Apple
    machines, at the cost of leaking state between VMs (Edmund Raile)

Error handling:

  - Print all logged TLP Prefixes, not just the first, after AER or DPC
    errors (Ilpo Järvinen)

  - Quirk the DPC PIO log size for Intel Raptor Lake Root Ports, which
    still don't advertise a legal size (Paul Menzel)

  - Ignore expected DPC Surprise Down errors on hot removal (Smita
    Koralahalli)

  - Block runtime suspend while handling AER errors to avoid races that
    prevent the device form being resumed from D3hot (Stanislaw Gruszka)

Peer-to-peer DMA:

  - Use atomic XA allocation in RCU read section (Christophe JAILLET)

ASPM:

  - Collect bits of ASPM-related code that we need even without
    CONFIG_PCIEASPM into aspm.c (David E. Box)

  - Save/restore L1 PM Substates config for suspend/resume (David E. Box)

  - Update save_save when ASPM config is changed, so a .slot_reset() during
    error recovery restores the changed config, not the .probe()-time
    config (Vidya Sagar)

Endpoint framework:

  - Refactor and improve pci_epf_alloc_space() API (Niklas Cassel)

  - Clean up endpoint BAR descriptions (Niklas Cassel)

  - Fix ntb_register_device() name leak in error path (Yang Yingliang)

  - Return actual error code for pci_vntb_probe() failure (Yang Yingliang)

Broadcom STB PCIe controller driver:

  - Fix MDIO write polling, which previously never waited for completion
    (Jonathan Bell)

Cadence PCIe endpoint driver:

  - Clear the ARI "Next Function Number" of last function (Jasko-EXT
    Wojciech)

Freescale i.MX6 PCIe controller driver:

  - Simplify by replacing switch statements with function pointers for
    different hardware variants (Frank Li)

  - Simplify by using clk_bulk*() API (Frank Li)

  - Remove redundant DT clock and reg/reg-name details (Frank Li)

  - Add i.MX95 DT and driver support for both Root Complex and Endpoint
    mode (Frank Li)

Microsoft Hyper-V host bridge driver:

  - Reduce memory usage by limiting ring buffer size to 16KB instead of 4
    pages (Michael Kelley)

Qualcomm PCIe controller driver:

  - Add X1E80100 DT and driver support (Abel Vesa)

  - Add DT 'required-opps' for SoCs that require a minimum performance
    level (Johan Hovold)

  - Make DT 'msi-map-mask' optional, depending on how MSI interrupts are
    mapped (Johan Hovold)

  - Disable ASPM L0s for sc8280xp, sa8540p and sa8295p because the PHY
    configuration isn't tuned correctly for L0s (Johan Hovold)

  - Split dt-binding qcom,pcie.yaml into qcom,pcie-common.yaml and separate
    files for SA8775p, SC7280, SC8180X, SC8280XP, SM8150, SM8250, SM8350,
    SM8450, SM8550 for easier reviewing (Krzysztof Kozlowski)

  - Enable BDF to SID translation by disabling bypass mode (Manivannan
    Sadhasivam)

  - Add endpoint MHI support for Snapdragon SA8775P SoC (Mrinmay Sarkar)

Synopsys DesignWare PCIe controller driver:

  - Allocate 64-bit MSI address if no 32-bit address is available (Ajay
    Agarwal)

  - Fix endpoint Resizable BAR to actually advertise the required 1MB size
    (Niklas Cassel)

MicroSemi Switchtec management driver:

  - Release resources if the .probe() fails (Christophe JAILLET)

Miscellaneous:

  - Make pcie_port_bus_type const (Ricardo B. Marliere)

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller
      PCI: qcom: Add X1E80100 PCIe support

Ajay Agarwal (1):
      PCI: dwc: Strengthen the MSI address allocation logic

Bjorn Helgaas (19):
      PCI/ASPM: Disable L1 before configuring L1 Substates
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/devres'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/misc'
      Merge branch 'pci/controller/broadcom'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/hyperv'
      Merge branch 'pci/controller/imx'
      Merge branch 'pci/controller/qcom'

Christophe JAILLET (2):
      PCI/P2PDMA: Fix a sleeping issue in a RCU read section
      PCI: switchtec: Fix an error handling path in switchtec_pci_probe()

Daniel Drake (2):
      PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
      Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

David E. Box (5):
      PCI/ASPM: Move pci_configure_ltr() to aspm.c
      PCI/ASPM: Always build aspm.c
      PCI/ASPM: Move pci_save_ltr_state() to aspm.c
      PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
      PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()

Edmund Raile (1):
      PCI: Mark LSI FW643 to avoid bus reset

Frank Li (13):
      PCI: imx6: Simplify clock handling by using clk_bulk*() function
      PCI: imx6: Simplify PHY handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
      PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET
      PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
      PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
      PCI: imx6: Simplify switch-case logic by introducing init_phy() callback
      dt-bindings: imx6q-pcie: Clean up duplicate clocks check
      dt-bindings: imx6q-pcie: Restruct reg and reg-name
      PCI: imx6: Add iMX95 PCIe Root Complex support
      PCI: imx6: Clean up addr_space retrieval code
      PCI: imx6: Add epc_features in imx6_pcie_drvdata
      dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
      PCI: imx6: Add iMX95 Endpoint (EP) support

Ilpo Järvinen (5):
      PCI/DPC: Print all TLP Prefixes, not just the first
      PCI: Place interrupt related code into irq.c
      PCI/sysfs: Demacrofy pci_dev_resource_resize_attr(n) functions
      PCI/AER: Use explicit register size for PCI_ERR_CAP
      PCI/AER: Generalize TLP Header Log reading

Jasko-EXT Wojciech (1):
      PCI: cadence: Clear the ARI Capability Next Function Number of the last function

Johan Hovold (5):
      PCI/AER: Fix rootport attribute paths in ABI docs
      PCI/AER: Clean up version indentation in ABI docs
      dt-bindings: PCI: qcom: Allow 'required-opps'
      dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
      PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p

Jonathan Bell (1):
      PCI: brcmstb: Fix broken brcm_pcie_mdio_write() polling

Jörg Wedekind (1):
      PCI: Mark 3ware-9650SE Root Port Extended Tags as broken

Krzysztof Kozlowski (9):
      dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8450: Move SM8450 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema
      dt-bindings: PCI: qcom,pcie-sc8180x: Move SC8180X to dedicated schema
      dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema

Lukas Wunner (2):
      PCI/sysfs: Compile pci-sysfs.c only if CONFIG_SYSFS=y
      PCI: Remove obsolete pci_cleanup_rom() declaration

Manivannan Sadhasivam (2):
      PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
      PCI: qcom: Enable BDF to SID translation properly

Michael Kelley (1):
      PCI: hv: Fix ring buffer size calculation

Mrinmay Sarkar (1):
      PCI: epf-mhi: Add support for SA8775P SoC

Niklas Cassel (7):
      PCI: endpoint: Refactor pci_epf_alloc_space() API
      PCI: endpoint: Improve pci_epf_alloc_space() API
      PCI: endpoint: pci-epf-test: Remove superfluous checks for pci_epf_alloc_space() API
      PCI: endpoint: pci-epf-vntb: Remove superfluous checks for pci_epf_alloc_space() API
      PCI: endpoint: Clean up hardware description for BARs
      PCI: endpoint: Drop only_64bit on reserved BARs
      PCI: dwc: endpoint: Fix advertised resizable BAR size

Paul Menzel (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Philipp Stanner (4):
      pci_iounmap(): Fix MMIO mapping leak
      PCI: Move pci_iomap.c to drivers/pci/
      PCI: Move PCI-specific devres code to drivers/pci/
      PCI: Move devres code from pci.c to devres.c

Raag Jadav (1):
      PCI/PM: Allow runtime PM with no PM callbacks at all

Rafael J. Wysocki (1):
      PCI/PM: Drain runtime-idle callbacks before driver removal

Ricardo B. Marliere (2):
      PCI: endpoint: Make pci_epf_bus_type const
      PCI: Make pcie_port_bus_type const

Richard Zhu (1):
      dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

Smita Koralahalli (1):
      PCI/DPC: Ignore Surprise Down error on hot removal

Stanislaw Gruszka (1):
      PCI/AER: Block runtime suspend when handling errors

Vidya Sagar (1):
      PCI/ASPM: Update save_state when configuration changes

Yang Yingliang (2):
      NTB: fix possible name leak in ntb_register_device()
      PCI: epf-vntb: Return actual error code during pci_vntb_probe() failure

 .../ABI/testing/sysfs-bus-pci-devices-aer_stats    |  18 +-
 .../bindings/pci/fsl,imx6q-pcie-common.yaml        |  17 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml |  46 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  49 +-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 100 ++++
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 166 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 166 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 170 ++++++
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 158 +++++
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 173 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 184 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 178 ++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 ++++++
 .../bindings/pci/qcom,pcie-x1e80100.yaml           | 165 ++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 378 +-----------
 Documentation/driver-api/device-io.rst             |   3 -
 Documentation/driver-api/pci/pci.rst               |   6 +
 MAINTAINERS                                        |   1 -
 arch/x86/pci/fixup.c                               |  48 ++
 drivers/acpi/sleep.c                               |  12 -
 drivers/firmware/efi/cper.c                        |   4 +-
 drivers/ntb/core.c                                 |   8 +-
 drivers/pci/Kconfig                                |   5 +
 drivers/pci/Makefile                               |   7 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  14 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   6 +
 drivers/pci/controller/dwc/pci-imx6.c              | 636 ++++++++++++---------
 drivers/pci/controller/dwc/pci-keystone.c          |  12 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   5 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   7 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  21 +-
 drivers/pci/controller/dwc/pcie-keembay.c          |   8 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  42 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  10 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |  15 +-
 drivers/pci/controller/pci-hyperv.c                |   3 +-
 drivers/pci/controller/pcie-brcmstb.c              |   2 +-
 drivers/pci/controller/pcie-rcar-ep.c              |  14 +-
 drivers/pci/devres.c                               | 448 +++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |  21 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |   6 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  21 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  25 +-
 drivers/pci/endpoint/pci-epc-core.c                |  25 +-
 drivers/pci/endpoint/pci-epf-core.c                |  20 +-
 lib/pci_iomap.c => drivers/pci/iomap.c             |   5 +-
 drivers/pci/irq.c                                  | 204 +++++++
 drivers/pci/mmap.c                                 |  29 +
 drivers/pci/p2pdma.c                               |   2 +-
 drivers/pci/pci-driver.c                           |  23 +-
 drivers/pci/pci-sysfs.c                            | 167 +++---
 drivers/pci/pci.c                                  | 496 ++--------------
 drivers/pci/pci.h                                  |  55 +-
 drivers/pci/pcie/Makefile                          |   2 +-
 drivers/pci/pcie/aer.c                             |  20 +-
 drivers/pci/pcie/aspm.c                            | 268 ++++++++-
 drivers/pci/pcie/dpc.c                             |  76 ++-
 drivers/pci/pcie/err.c                             |  20 +
 drivers/pci/pcie/portdrv.h                         |   2 +-
 drivers/pci/probe.c                                |  66 +--
 drivers/pci/quirks.c                               |  11 +
 drivers/pci/setup-irq.c                            |  64 ---
 drivers/pci/switch/switchtec.c                     |   4 +-
 include/linux/aer.h                                |  11 +-
 include/linux/pci-epc.h                            |  39 +-
 include/linux/pci-epf.h                            |   4 +-
 include/linux/pci.h                                |   2 +-
 include/ras/ras_event.h                            |  10 +-
 lib/Kconfig                                        |   3 -
 lib/Makefile                                       |   1 -
 lib/devres.c                                       | 208 +------
 73 files changed, 3796 insertions(+), 1774 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
 create mode 100644 drivers/pci/devres.c
 rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)
 delete mode 100644 drivers/pci/setup-irq.c

