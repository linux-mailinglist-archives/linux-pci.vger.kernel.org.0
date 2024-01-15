Return-Path: <linux-pci+bounces-2188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF282E2C7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 23:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20184B2213F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1991B5BB;
	Mon, 15 Jan 2024 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lufNIUV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8D6FBB;
	Mon, 15 Jan 2024 22:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0220C433C7;
	Mon, 15 Jan 2024 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705359424;
	bh=jLLPMb+BVSeXGjRFG+EJAEgdOcrfDHwVZvAm+mw2Lig=;
	h=Date:From:To:Cc:Subject:From;
	b=lufNIUV8T/527ee+p2GKbFHEDJbhRU+5uY9In0N1vFbEqFdvYzE27ln49n42rBJ+q
	 Ct7imMTwmKqRMhef+JQbIc0Wy6hqvL4nx5i9XpTV3eZidJd7ENAiGeXVWV5qHHolTI
	 EWEK0GC2KOi723JzUz2KITbBZVlrxzT2NkkkvbjCa+ekxHSENtIw7RUKR+ljUxfDpA
	 AlfjqhHs8RFx9PKbnGrOK5lBkT5guTei/Nw7/4iDcLhx5setIWUnyFfJte5e15/wo1
	 Wr7DJa+i7PQ+4MCNlDFtJqE0GXUd3wuDcwupR0x3dZTROGMUj7v45wnByjP5llk8Du
	 bPsCkO0VMaskA==
Date: Mon, 15 Jan 2024 16:57:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.8
Message-ID: <20240115225703.GA73226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-changes

for you to fetch changes up to 7119ca35ee4a0129ae86ae9d36f357edc55aab2f:

  Merge branch 'pci/misc' (2024-01-15 12:10:41 -0600)

----------------------------------------------------------------

Enumeration:

  - Reserve ECAM so we don't assign it to PCI BARs; this works around bugs
    where BIOS included ECAM in a PNP0A03 host bridge window, didn't
    reserve it via a PNP0C02 motherboard device, and didn't allocate space
    for SR-IOV VF BARs (Bjorn Helgaas)

  - Add MMCONFIG/ECAM debug logging (Bjorn Helgaas)

  - Rename 'MMCONFIG' to 'ECAM' to match spec usage (Bjorn Helgaas)

  - Log device type (Root Port, Switch Port, etc) during enumeration (Bjorn
    Helgaas)

  - Log bridges before downstream devices so the dmesg order is more
    logical (Bjorn Helgaas)

  - Log resource names (BAR 0, VF BAR 0, bridge window, etc) consistently
    instead of a mix of names and "reg 0x10" (Puranjay Mohan, Bjorn
    Helgaas)
   
  - Fix 64GT/s effective data rate calculation to use 1b/1b encoding rather
    than the 8b/10b or 128b/130b used by lower rates (Ilpo Järvinen)

  - Use PCI_HEADER_TYPE_* instead of literals in x86, powerpc, SCSI lpfc
    (Ilpo Järvinen)

  - Clean up open-coded PCIBIOS return code mangling (Ilpo Järvinen)

Resource management:

  - Restructure pci_dev_for_each_resource() to avoid computing the address
    of an out-of-bounds array element (the bounds check was performed later
    so the element was never actually *read*, but it's nicer to avoid even
    computing an out-of-bounds address) (Andy Shevchenko)

Driver binding:

  - Convert pci-host-common.c platform .remove() callback to .remove_new()
    returning 'void' since it's not useful to return error codes here (Uwe
    Kleine-König)

  - Convert exynos, keystone, kirin from .remove() to .remove_new(), which
    returns void instead of int (Uwe Kleine-König)

  - Drop unused struct pci_driver.node member (Mathias Krause)

Virtualization:

  - Add ACS quirk for more Zhaoxin Root Ports (LeoLiuoc)

Error handling:

  - Log AER errors as "Correctable" (not "Corrected") or "Uncorrectable" to
    match spec terminology (Bjorn Helgaas)

  - Decode Requester ID when no error info found instead of printing the
    raw hex value (Bjorn Helgaas)

Endpoint framework:

  - Use a unique test pattern for each BAR in the pci_endpoint_test to make
    it easier to debug address translation issues (Niklas Cassel)

Broadcom STB PCIe controller driver:

  - Add DT property "brcm,clkreq-mode" and driver support for different
    CLKREQ# modes to make ASPM L1.x states possible (Jim Quinlan)

Freescale Layerscape PCIe controller driver:

  - Add suspend/resume support for Layerscape LS1043a and LS1021a,
    including software-managed PME_Turn_Off and transitions between L0,
    L2/L3_Ready Link states (Frank Li)

MediaTek PCIe controller driver:

  - Clear MSI interrupt status before handler to avoid missing MSIs that
    occur after the handler (qizhong cheng)

MediaTek PCIe Gen3 controller driver:

  - Update mediatek-gen3 translation window setup to handle MMIO space that
    is not a power of two in size (Jianjun Wang)

Qualcomm PCIe controller driver:

  - Increase qcom iommu-map maxItems to accommodate SDX55 (five entries)
    and SDM845 (sixteen entries) (Krzysztof Kozlowski)

  - Describe qcom,pcie-sc8180x clocks and resets accurately (Krzysztof
    Kozlowski)

  - Describe qcom,pcie-sm8150 clocks and resets accurately (Krzysztof
    Kozlowski)

  - Correct the qcom "reset-name" property, previously incorrectly called
    "reset-names" (Krzysztof Kozlowski)

  - Document qcom,pcie-sm8650, based on qcom,pcie-sm8550 (Neil Armstrong)

Renesas R-Car PCIe controller driver:

  - Replace of_device.h with explicit of.h include to untangle header usage
    (Rob Herring)

  - Add DT and driver support for optional miniPCIe 1.5v and 3.3v
    regulators on KingFisher (Wolfram Sang)

SiFive FU740 PCIe controller driver:

  - Convert fu740 CONFIG_PCIE_FU740 dependency from SOC_SIFIVE to
    ARCH_SIFIVE (Conor Dooley)

Synopsys DesignWare PCIe controller driver:

  - Align iATU mapping for endpoint MSI-X (Niklas Cassel)

  - Drop "host_" prefix from struct dw_pcie_host_ops members (Yoshihiro
    Shimoda)

  - Drop "ep_" prefix from struct dw_pcie_ep_ops members (Yoshihiro
    Shimoda)

  - Rename struct dw_pcie_ep_ops.func_conf_select() to .get_dbi_offset() to
    be more descriptive (Yoshihiro Shimoda)

  - Add Endpoint DBI accessors to encapsulate offset lookups (Yoshihiro
    Shimoda)

TI J721E PCIe driver:

  - Add j721e DT and driver support for 'num-lanes' for devices that
    support x1, x2, or x4 Links (Matt Ranostay)

  - Add j721e DT compatible strings and driver support for j784s4 (Matt
    Ranostay)

  - Make TI J721E Kconfig depend on ARCH_K3 since the hardware is specific
    to those TI SoC parts (Peter Robinson)

TI Keystone PCIe controller driver:

  - Hold power management references to all PHYs while enabling them to
    avoid a race when one provides clocks to others (Siddharth Vadapalli)

Xilinx XDMA PCIe controller driver:

  - Remove redundant dev_err(), since platform_get_irq() and
    platform_get_irq_byname() already log errors (Yang Li)

  - Fix uninitialized symbols in xilinx_pl_dma_pcie_setup_irq() (Krzysztof
    Wilczyński)

  - Fix xilinx_pl_dma_pcie_init_irq_domain() error return when
    irq_domain_add_linear() fails (Harshit Mogalapalli)

MicroSemi Switchtec management driver:

  - Do dma_mrpc cleanup during switchtec_pci_remove() to match its devm
    ioremapping in switchtec_pci_probe().  Previously the cleanup was done
    in stdev_release(), which used stale pointers if stdev->cdev happened
    to be open when the PCI device was removed (Daniel Stodden)

Miscellaneous:

  - Convert interrupt terminology from "legacy" to "INTx" to be more
    specific and match spec terminology (Damien Le Moal)

  - In dw-xdata-pcie, pci_endpoint_test, and vmd, replace usage of
    deprecated ida_simple_*() API with ida_alloc() and ida_free()
    (Christophe JAILLET)

----------------------------------------------------------------
Andy Shevchenko (1):
      PCI: Avoid potential out-of-bounds read in pci_dev_for_each_resource()

Bjorn Helgaas (43):
      x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02 _CRS
      x86/pci: Reword ECAM EfiMemoryMappedIO logging to avoid 'reserved'
      x86/pci: Add MCFG debug logging
      x86/pci: Rename 'MMCONFIG' to 'ECAM', use pr_fmt
      x86/pci: Rename acpi_mcfg_check_entry() to acpi_mcfg_valid_entry()
      x86/pci: Rename pci_mmcfg_check_reserved() to pci_mmcfg_reserved()
      x86/pci: Comment pci_mmconfig_insert() obscure MCFG dependency
      x86/pci: Return pci_mmconfig_add() failure early
      x86/pci: Reorder pci_mmcfg_arch_map() definition before calls
      PCI: Log device type during enumeration
      PCI: Move pci_read_bridge_windows() below individual window accessors
      PCI: Supply bridge device, not secondary bus, to read window details
      PCI: Log bridge windows conditionally
      PCI: Log bridge info when first enumerating bridge
      PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
      PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
      PCI/AER: Decode Requester ID when no error info found
      PCI/AER: Use explicit register sizes for struct members
      PCI: Fix kernel-doc issues
      Merge branch 'pci/aer'
      Merge branch 'pci/ecam'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/enumeration-logging'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/controller/broadcom'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/keystone'
      Merge branch 'pci/controller/kirin'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/rcar'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xilinx'
      Merge branch 'pci/controller/remove-void-return'
      Merge branch 'pci/irq-clean-up'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/remove-old-api'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/misc'

Christophe JAILLET (5):
      PCI: vmd: Remove usage of the deprecated ida_simple_xx() API
      PCI: kirin: Use devm_kasprintf() to dynamically allocate clock names
      PCI: vmd: Remove usage of the deprecated ida_simple_*() API
      misc: pci_endpoint_test: Remove usage of the deprecated ida_simple_*() API
      dw-xdata: Remove usage of the deprecated ida_simple_*() API

Conor Dooley (1):
      PCI: dwc: Convert SOC_SIFIVE to ARCH_SIFIVE

Damien Le Moal (14):
      PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
      PCI: endpoint: Use INTX instead of legacy
      PCI: endpoint: Rename LEGACY to INTX in test function driver
      misc: pci_endpoint_test: Use INTX instead of LEGACY
      PCI: dra7xx: Rename dra7xx_pcie_raise_legacy_irq()
      PCI: cadence: Use INTX instead of legacy
      PCI: dwc: Rename dw_pcie_ep_raise_legacy_irq()
      PCI: keystone: Use INTX instead of legacy
      PCI: dw-rockchip: Rename rockchip_pcie_legacy_int_handler()
      PCI: tegra194: Use INTX instead of legacy
      PCI: uniphier: Use INTX instead of legacy
      PCI: rockchip-ep: Use INTX instead of legacy
      PCI: rockchip-host: Rename rockchip_pcie_legacy_int_handler()
      PCI: xilinx-nwl: Use INTX instead of legacy

Daniel Stodden (1):
      PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Frank Li (4):
      PCI: layerscape: Add function pointer for exit_from_l2()
      PCI: layerscape: Add suspend/resume for ls1021a
      PCI: layerscape(ep): Rename pf_* as pf_lut_*
      PCI: layerscape: Add suspend/resume for ls1043a

Guilherme G. Piccoli (1):
      PCI: Only override AMD USB controller if required

Harshit Mogalapalli (1):
      PCI: xilinx-xdma: Fix error code in xilinx_pl_dma_pcie_init_irq_domain()

Heiko Stuebner (1):
      dt-bindings: PCI: dwc: rockchip: Document optional PCIe reference clock input

Ilpo Järvinen (5):
      x86/pci: Use PCI_HEADER_TYPE_* instead of literals
      powerpc/fsl-pci: Use PCI_HEADER_TYPE_MASK instead of literal
      scsi: lpfc: Use PCI_HEADER_TYPE_MFD instead of literal
      x86/pci: Clean up open-coded PCIBIOS return code mangling
      PCI: Fix 64GT/s effective data rate calculation

Jianjun Wang (1):
      PCI: mediatek-gen3: Fix translation window size calculation

Jim Quinlan (2):
      dt-bindings: PCI: brcmstb: Add property "brcm,clkreq-mode"
      PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device

Justin Stitt (1):
      PCI: iproc: Fix -Wvoid-pointer-to-enum-cast warning

Krzysztof Kozlowski (4):
      dt-bindings: PCI: qcom: Adjust iommu-map for different SoC
      dt-bindings: PCI: qcom: Correct clocks for SC8180x
      dt-bindings: PCI: qcom: Correct clocks for SM8150
      dt-bindings: PCI: qcom: Correct reset-names property

Krzysztof Wilczyński (1):
      PCI: xilinx-xdma: Fix uninitialized symbols in xilinx_pl_dma_pcie_setup_irq()

Lars-Peter Clausen (5):
      PCI: endpoint: Make struct pci_epf_ops in pci_epf_driver const
      PCI: endpoint: pci-epf-mhi: Make structs pci_epf_ops and pci_epf_event_ops const
      PCI: endpoint: pci-epf-ntb: Make struct pci_epf_ops const
      PCI: endpoint: pci-epf-vntb: Make struct pci_epf_ops const
      PCI: endpoint: pci-epf-test: Make struct pci_epf_ops const

LeoLiuoc (1):
      PCI: Add ACS quirk for more Zhaoxin Root Ports

Mathias Krause (1):
      PCI: Remove unused 'node' member from struct pci_driver

Matt Ranostay (5):
      dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes
      dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings
      PCI: j721e: Add per platform maximum lane settings
      PCI: j721e: Add PCIe 4x lane selection support
      PCI: j721e: Add TI J784S4 PCIe configuration

Neil Armstrong (1):
      dt-bindings: PCI: qcom: Document the SM8650 PCIe Controller

Niklas Cassel (2):
      PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
      misc: pci_endpoint_test: Use a unique test pattern for each BAR

Peter Robinson (1):
      PCI: j721e: Make TI J721E depend on ARCH_K3

Puranjay Mohan (2):
      PCI: Update BAR # and window messages
      PCI: Use resource names in PCI log messages

Rob Herring (1):
      PCI: rcar-gen4: Replace of_device.h with explicit of.h include

Siddharth Vadapalli (1):
      PCI: keystone: Fix race condition when initializing PHYs

Tadeusz Struk (1):
      PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()

Uwe Kleine-König (4):
      PCI: host-generic: Convert to platform remove callback returning void
      PCI: exynos: Convert to platform remove callback returning void
      PCI: keystone: Convert to platform remove callback returning void
      PCI: kirin: Convert to platform remove callback returning void

Wolfram Sang (2):
      dt-bindings: PCI: rcar-pci-host: Add optional regulators
      PCI: rcar-host: Add support for optional regulators

Yang Li (1):
      PCI: xilinx-xdma: Remove redundant dev_err()

Yoshihiro Shimoda (5):
      PCI: dwc: Drop host prefix from struct dw_pcie_host_ops members
      PCI: dwc: Rename .ep_init to .init in struct dw_pcie_ep_ops
      PCI: dwc: Rename .func_conf_select to .get_dbi_offset in struct dw_pcie_ep_ops
      PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
      PCI: rcar-gen4: Fix -Wvoid-pointer-to-enum-cast error

attreyee-muk (1):
      docs: PCI: Fix typos

qizhong cheng (1):
      PCI: mediatek: Clear interrupt status before dispatching handler

 Documentation/PCI/boot-interrupts.rst              |   2 +-
 Documentation/PCI/msi-howto.rst                    |   2 +-
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |  18 ++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  63 +++++-
 .../devicetree/bindings/pci/rcar-pci-host.yaml     |  11 ++
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |   2 +
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |  39 +++-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |  39 +++-
 Documentation/driver-api/pci/p2pdma.rst            |  16 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   4 +-
 arch/x86/kernel/aperture_64.c                      |   3 +-
 arch/x86/kernel/early-quirks.c                     |   4 +-
 arch/x86/pci/acpi.c                                |   3 +
 arch/x86/pci/mmconfig-shared.c                     | 178 +++++++++--------
 arch/x86/pci/mmconfig_32.c                         |   2 +-
 arch/x86/pci/mmconfig_64.c                         |  42 ++--
 arch/x86/pci/pcbios.c                              |  28 ++-
 drivers/misc/dw-xdata-pcie.c                       |   6 +-
 drivers/misc/pci_endpoint_test.c                   |  50 +++--
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   1 -
 drivers/pci/controller/cadence/Kconfig             |   2 +
 drivers/pci/controller/cadence/pci-j721e.c         |  45 ++++-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  19 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |  12 +-
 drivers/pci/controller/dwc/Kconfig                 |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  14 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   8 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  17 +-
 drivers/pci/controller/dwc/pci-keystone.c          | 109 ++++++-----
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |  33 ++--
 drivers/pci/controller/dwc/pci-layerscape.c        | 193 +++++++++++++++---
 drivers/pci/controller/dwc/pci-meson.c             |   2 +-
 drivers/pci/controller/dwc/pcie-al.c               |   2 +-
 drivers/pci/controller/dwc/pcie-armada8k.c         |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |  12 +-
 drivers/pci/controller/dwc/pcie-bt1.c              |   4 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 197 +++++++------------
 drivers/pci/controller/dwc/pcie-designware-host.c  |  30 +--
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  13 +-
 drivers/pci/controller/dwc/pcie-designware.h       | 111 ++++++++++-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |   6 +-
 drivers/pci/controller/dwc/pcie-fu740.c            |   2 +-
 drivers/pci/controller/dwc/pcie-histb.c            |   2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c          |  15 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |  21 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  10 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   6 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |  23 ++-
 drivers/pci/controller/dwc/pcie-spear13xx.c        |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  21 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |  13 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         |  14 +-
 drivers/pci/controller/dwc/pcie-visconti.c         |   2 +-
 drivers/pci/controller/pci-host-common.c           |   4 +-
 drivers/pci/controller/pci-host-generic.c          |   2 +-
 drivers/pci/controller/pcie-brcmstb.c              |  96 ++++++++-
 drivers/pci/controller/pcie-iproc-platform.c       |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  89 +++++----
 drivers/pci/controller/pcie-mediatek.c             |  10 +-
 drivers/pci/controller/pcie-rcar-ep.c              |   7 +-
 drivers/pci/controller/pcie-rcar-host.c            |  18 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |  23 ++-
 drivers/pci/controller/pcie-rockchip-host.c        |   4 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        |  14 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  52 ++---
 drivers/pci/controller/vmd.c                       |   6 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |   6 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |   6 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  16 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |   9 +-
 drivers/pci/endpoint/pci-epc-core.c                |   6 +-
 drivers/pci/iov.c                                  |   7 +-
 drivers/pci/pci.c                                  |  85 ++++++--
 drivers/pci/pci.h                                  |   4 +-
 drivers/pci/pcie/aer.c                             |  21 +-
 drivers/pci/probe.c                                | 218 +++++++++++++--------
 drivers/pci/quirks.c                               |  34 +++-
 drivers/pci/setup-bus.c                            |  30 ++-
 drivers/pci/setup-res.c                            |  72 ++++---
 drivers/pci/switch/switchtec.c                     |  25 ++-
 drivers/scsi/lpfc/lpfc_sli.c                       |   2 +-
 include/linux/aer.h                                |   8 +-
 include/linux/pci-ecam.h                           |   2 +-
 include/linux/pci-epc.h                            |  13 +-
 include/linux/pci-epf.h                            |   4 +-
 include/linux/pci.h                                |  19 +-
 include/uapi/linux/pcitest.h                       |   3 +-
 88 files changed, 1519 insertions(+), 877 deletions(-)

