Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800A7DE689
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbjKATvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbjKATvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 15:51:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7BDA;
        Wed,  1 Nov 2023 12:51:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C41C433C8;
        Wed,  1 Nov 2023 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698868272;
        bh=4Uq8DRzjbpzEP5hKT0iHuYQqztgGLaBzMBXjR/PbeH4=;
        h=Date:From:To:Cc:Subject:From;
        b=S6lIcRO++QsZiqwq3U0JS3pxOoONJpPrRMcx/ApaeWJo/Ux+4MZU/mIA5zeF526w4
         TlyGnt7ZRg/R93fxRJYdgW4XucJ7XlIW0kD+n6AJGdeTDQythQjpUTj3lfg3xiVLFy
         UeQb8R+FiGrKq3jG/yXeAWw369+lf1nvPnQXK235xId7DYwV9MKU8Q+6JzgkZKc/OG
         lk/mB6eab75IwvC+TSXFtYE1NeLhKBd1VtdUDxGGDCfqMQ0e/0TSGayb3qwxr0CHV3
         coxVL+rJKUlUTIkvXFH3ZXp3ggLXnAS9P+LVYw3UlIANlnNuBu5OWH/T2TWoi9JAWf
         bHMdybCCq9y7Q==
Date:   Wed, 1 Nov 2023 14:51:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.7
Message-ID: <20231101195110.GA93982@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-changes

for you to fetch changes up to 50b3ef14c26b20476e67af582e788b17512023cf:

  Merge branch 'pci/misc' (2023-10-28 13:31:05 -0500)

----------------------------------------------------------------

Enumeration:

  - Use acpi_evaluate_dsm_typed() instead of open-coding _DSM evaluation to
    learn device characteristics (Andy Shevchenko)

  - Tidy multi-function header checks using new PCI_HEADER_TYPE_MASK
    definition (Ilpo Järvinen)

  - Simplify config access error checking in various drivers (Ilpo
    Järvinen)

  - Use pcie_capability_clear_word() (not
    pcie_capability_clear_and_set_word()) when only clearing (Ilpo
    Järvinen)

  - Add pci_get_base_class() to simplify finding devices using base class
    only (ignoring subclass and programming interface) (Sui Jingfeng)

  - Add pci_is_vga(), which includes ancient PCI_CLASS_NOT_DEFINED_VGA
    devices from before the Class Code was added to PCI (Sui Jingfeng)

  - Use pci_is_vga() for vgaarb, sysfs "boot_vga", virtio, qxl to include
    ancient VGA devices (Sui Jingfeng)

Resource management:

  - Make pci_assign_unassigned_resources() non-init because sparc uses it
    after init (Randy Dunlap)

Driver binding:

  - Retain .remove() and .probe() callbacks (previously __init) because
    sysfs may cause them to be called later (Uwe Kleine-König)

  - Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device, so it
    can be claimed by dwc3 instead (Vicki Pfau)

PCI device hotplug:

  - Add Ampere Altra Attention Indicator extension driver for acpiphp
    (D Scott Phillips)

Power management:

  - Quirk VideoPropulsion Torrent QN16e with longer delay after reset
    (Lukas Wunner)

  - Prevent users from overriding drivers that say we shouldn't use D3cold
    (Lukas Wunner)

  - Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4 because
    wakeup interrupts from those states don't work if amd-pmc has put the
    platform in a hardware sleep state (Mario Limonciello)

IOMMU:

  - Disable ATS for Intel IPU E2000 devices with invalidation message
    endianness erratum (Bartosz Pawlowski)

Error handling:

  - Factor out interrupt enable/disable into helpers (Kai-Heng Feng)

Peer-to-peer DMA:

  - Fix flexible-array usage in struct pci_p2pdma_pagemap in case we ever
    use pagemaps with multiple entries (Gustavo A. R. Silva)

ASPM:

  - Revert a change that broke when drivers disabled L1 and users later
    enabled an L1.x substate via sysfs, and fix a similar issue when users
    disabled L1 via sysfs (Heiner Kallweit)

Endpoint framework:

  - Fix double free in __pci_epc_create() (Dan Carpenter)

  - Use IS_ERR_OR_NULL() to simplify endpoint core (Ruan Jinjie)

Cadence PCIe controller driver:

  - Drop unused "is_rc" member (Li Chen)

Freescale Layerscape PCIe controller driver:

  - Enable 64-bit addressing in endpoint mode (Guanhua Gao)

Intel VMD host bridge driver:

  - Fix multi-function header check (Ilpo Järvinen)

Microsoft Hyper-V host bridge driver:

  - Annotate struct hv_dr_state with __counted_by (Kees Cook)

NVIDIA Tegra194 PCIe controller driver:

  - Drop setting of LNKCAP_MLW (max link width) since dw_pcie_setup()
    already does this via dw_pcie_link_set_max_link_width() (Yoshihiro
    Shimoda)

Qualcomm PCIe controller driver:

  - Use PCIE_SPEED2MBS_ENC() to simplify encoding of link speed (Manivannan
    Sadhasivam)

  - Add a .write_dbi2() callback so DBI2 register writes, e.g., for setting
    the BAR size, work correctly (Manivannan Sadhasivam)

  - Enable ASPM for platforms that use 1.9.0 ops, because the PCI core
    doesn't enable ASPM states that haven't been enabled by the firmware
    (Manivannan Sadhasivam)

Renesas R-Car Gen4 PCIe controller driver:

  - Add DesignWare core support (set max link width, EDMA_UNROLL flag,
    .pre_init(), .deinit(), etc) for use by R-Car Gen4 driver (Yoshihiro
    Shimoda)

  - Add driver and DT schema for DesignWare-based Renesas R-Car Gen4
    controller in both host and endpoint mode (Yoshihiro Shimoda)

Xilinx NWL PCIe controller driver:

  - Update ECAM size to support 256 buses (Thippeswamy Havalige)

  - Stop setting bridge primary/secondary/subordinate bus numbers, since
    PCI core does this (Thippeswamy Havalige)

Xilinx XDMA controller driver:

  - Add driver and DT schema for Zynq UltraScale+ MPSoCs devices with
    Xilinx XDMA Soft IP (Thippeswamy Havalige)

Miscellaneous:

  - Use FIELD_GET()/FIELD_PREP() to simplify and reduce use of _SHIFT
    macros (Ilpo Järvinen, Bjorn Helgaas)

  - Remove logic_outb(), _outw(), outl() duplicate declarations (John
    Sanpe)

  - Replace unnecessary UTF-8 in Kconfig help text because menuconfig
    doesn't render it correctly (Liu Song)

----------------------------------------------------------------
Andy Shevchenko (1):
      PCI/ACPI: Use acpi_evaluate_dsm_typed()

Bartosz Pawlowski (2):
      PCI: Extract ATS disabling to a helper function
      PCI: Disable ATS for specific Intel IPU E2000 devices

Bjorn Helgaas (32):
      PCI/DPC: Use FIELD_GET()
      PCI: Use FIELD_GET()
      PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
      PCI/ATS: Show PASID Capability register width in bitmasks
      PCI/ATS: Use FIELD_GET()
      PCI/PME: Use FIELD_GET()
      PCI/PTM: Use FIELD_GET()
      PCI/VC: Use FIELD_GET()
      PCI/portdrv: Use FIELD_GET()
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/ats'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/reset'
      Merge branch 'pci/vga'
      Merge branch 'pci/controller/aspm'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/hyperv'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/qcom-ep'
      Merge branch 'pci/controller/rcar'
      Merge branch 'pci/controller/speed'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xilinx-ecam'
      Merge branch 'pci/controller/xilinx-xdma'
      Merge branch 'pci/config-errs'
      Merge branch 'pci/field-get'
      Merge branch 'pci/misc'

D Scott Phillips (2):
      PCI: acpiphp: Allow built-in drivers for Attention Indicators
      PCI: hotplug: Add Ampere Altra Attention Indicator extension driver

Dan Carpenter (1):
      PCI: endpoint: Fix double free in __pci_epc_create()

Guanhua Gao (1):
      PCI: layerscape-ep: Set 64-bit DMA mask

Gustavo A. R. Silva (1):
      PCI/P2PDMA: Fix undefined behavior bug in struct pci_p2pdma_pagemap

Heiner Kallweit (2):
      Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when driver, disables L1"
      PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()

Ilpo Järvinen (26):
      PCI: vmd: Correct PCI Header Type Register's multi-function check
      PCI: Add PCI_HEADER_TYPE_MFD definition
      PCI: Use PCI_HEADER_TYPE_* instead of literals
      PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
      PCI: mvebu: Use FIELD_PREP() with Link Width
      PCI: Add PCI_L1SS_CTL2 fields
      PCI/ASPM: Use FIELD_GET/PREP() to access PCIe capability fields
      PCI/ASPM: Return U32_MAX instead of bit magic construct
      PCI/ASPM: Use time constants
      PCI/ASPM: Use FIELD_MAX() instead of literals
      PCI/ASPM: Remove unnecessary includes
      PCI/ASPM: Convert printk() to pr_*() and add include
      alpha: Streamline convoluted PCI error handling
      sh: pci: Do PCI error check on own line
      atm: iphase: Do PCI error checks on own line
      PCI: Do error check on own line to split long "if" conditions
      PCI: xgene: Do PCI error check on own line & keep return value
      scsi: ipr: Do PCI error checks on own line
      PCI: Use FIELD_GET() to extract Link Width
      PCI: cadence: Use FIELD_GET()
      PCI: dwc: Use FIELD_GET/PREP()
      PCI: hotplug: Use FIELD_GET/PREP()
      PCI/DPC: Use defined fields with DPC_CTL register
      PCI/DPC: Use defines with DPC reason fields
      PCI/MSI: Use FIELD_GET/PREP()
      PCI: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()

John Sanpe (1):
      logic_pio: Remove logic_outb(), _outw(), outl() duplicate declarations

Kai-Heng Feng (1):
      PCI/AER: Factor out interrupt toggling into helpers

Kees Cook (1):
      PCI: hv: Annotate struct hv_dr_state with __counted_by

Li Chen (1):
      PCI: cadence: Drop unused member from struct cdns_plat_pcie

Liu Song (1):
      PCI: Replace unnecessary UTF-8 in Kconfig

Lukas Wunner (2):
      PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card
      PCI/sysfs: Protect driver's D3cold preference from user space

Manivannan Sadhasivam (6):
      PCI: qcom: Use PCIE_SPEED2MBS_ENC() macro for encoding link speed
      PCI: qcom-ep: Use PCIE_SPEED2MBS_ENC() macro for encoding link speed
      PCI: tegra194: Use Mbps_to_icc() macro for setting icc speed
      PCI: dwc: Add host_post_init() callback
      PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops
      PCI: qcom-ep: Add dedicated callback for writing to DBI2 registers

Mario Limonciello (1):
      x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4

Randy Dunlap (1):
      PCI: Make pci_assign_unassigned_resources() non-init

Ruan Jinjie (1):
      PCI: endpoint: Use IS_ERR_OR_NULL() helper function

Sui Jingfeng (11):
      PCI: Add pci_get_base_class() helper
      ALSA: hda: Use pci_get_base_class() to reduce duplicated code
      drm/nouveau: Use pci_get_base_class() to reduce duplicated code
      drm/amdgpu: Use pci_get_base_class() to reduce duplicated code
      drm/radeon: Use pci_get_base_class() to reduce duplicated code
      PCI: Add pci_is_vga() helper
      PCI/VGA: Use pci_is_vga() to identify VGA devices
      PCI/VGA: Select VGA devices earlier
      PCI/sysfs: Enable 'boot_vga' attribute via pci_is_vga()
      drm/virtio: Use pci_is_vga() to identify VGA devices
      drm/qxl: Use pci_is_vga() to identify VGA devices

Tadeusz Struk (1):
      PCI/P2PDMA: Remove redundant goto

Thippeswamy Havalige (7):
      PCI: xilinx-nwl: Remove redundant code that sets Type 1 header fields
      dt-bindings: PCI: xilinx-nwl: Modify ECAM size in the DT example
      PCI: xilinx-nwl: Rename the NWL_ECAM_VALUE_DEFAULT macro
      PCI: xilinx-nwl: Modify ECAM size to enable support for 256 buses
      PCI: xilinx-cpm: Move IRQ definitions to a common header
      dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx XDMA PCIe Root Port Bridge
      PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

Uwe Kleine-König (4):
      PCI: exynos: Don't discard .remove() callback
      PCI: kirin: Don't discard .remove() callback
      PCI: keystone: Don't discard .remove() callback
      PCI: keystone: Don't discard .probe() callback

Vicki Pfau (1):
      PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Xinghui Li (1):
      PCI: vmd: Fix inconsistent indentation in vmd_resume()

Yoshihiro Shimoda (16):
      PCI: Add T_PVPERL macro
      PCI: dwc: Add dw_pcie_link_set_max_link_width()
      PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
      PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
      PCI: dwc: endpoint: Add multiple PFs support for dbi2
      PCI: dwc: Add EDMA_UNROLL capability flag
      PCI: dwc: Expose dw_pcie_ep_exit() to module
      PCI: dwc: Expose dw_pcie_write_dbi2() to module
      PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
      dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
      dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
      dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
      PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode
      PCI: rcar-gen4: Add endpoint mode support
      MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
      misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

 .../devicetree/bindings/pci/rcar-gen4-pci-ep.yaml  | 115 +++
 .../bindings/pci/rcar-gen4-pci-host.yaml           | 127 ++++
 .../bindings/pci/snps,dw-pcie-common.yaml          |   4 +-
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |   4 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   4 +-
 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml     |   2 +-
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 114 +++
 MAINTAINERS                                        |   1 +
 arch/alpha/kernel/sys_miata.c                      |  17 +-
 arch/sh/drivers/pci/common.c                       |  11 +-
 arch/x86/pci/fixup.c                               |  59 ++
 drivers/atm/iphase.c                               |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  20 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |  11 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |  11 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |  20 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   2 +-
 drivers/misc/pci_endpoint_test.c                   |   4 +
 drivers/pci/Kconfig                                |   2 +-
 drivers/pci/ats.c                                  |   7 +-
 drivers/pci/controller/Kconfig                     |  11 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   9 +-
 drivers/pci/controller/cadence/pcie-cadence-plat.c |   5 -
 drivers/pci/controller/dwc/Kconfig                 |  25 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-exynos.c            |   4 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   8 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   2 +
 drivers/pci/controller/dwc/pci-layerscape.c        |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  52 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   3 +
 drivers/pci/controller/dwc/pcie-designware.c       | 102 +--
 drivers/pci/controller/dwc/pcie-designware.h       |   9 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   4 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  48 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  52 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        | 527 +++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c         |  27 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |   2 +-
 drivers/pci/controller/pci-hyperv.c                |   2 +-
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/controller/pci-xgene.c                 |   7 +-
 drivers/pci/controller/pcie-iproc.c                |   2 +-
 drivers/pci/controller/pcie-rcar-ep.c              |   2 +-
 drivers/pci/controller/pcie-rcar-host.c            |   2 +-
 drivers/pci/controller/pcie-xilinx-common.h        |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c           |  38 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 814 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |  18 +-
 drivers/pci/controller/vmd.c                       |  10 +-
 drivers/pci/endpoint/pci-epc-core.c                |  13 +-
 drivers/pci/hotplug/Kconfig                        |  12 +
 drivers/pci/hotplug/Makefile                       |   1 +
 drivers/pci/hotplug/acpiphp_ampere_altra.c         | 127 ++++
 drivers/pci/hotplug/acpiphp_core.c                 |   3 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |   6 +-
 drivers/pci/hotplug/cpqphp_pci.c                   |  22 +-
 drivers/pci/hotplug/ibmphp.h                       |   5 +-
 drivers/pci/hotplug/ibmphp_pci.c                   |   2 +-
 drivers/pci/hotplug/pciehp_core.c                  |   3 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   5 +-
 drivers/pci/hotplug/pnv_php.c                      |   3 +-
 drivers/pci/msi/msi.c                              |  10 +-
 drivers/pci/p2pdma.c                               |   3 +-
 drivers/pci/pci-acpi.c                             |  15 +-
 drivers/pci/pci-sysfs.c                            |  17 +-
 drivers/pci/pci.c                                  |  69 +-
 drivers/pci/pci.h                                  |   3 +
 drivers/pci/pcie/aer.c                             |  45 +-
 drivers/pci/pcie/aspm.c                            |  84 ++-
 drivers/pci/pcie/dpc.c                             |  42 +-
 drivers/pci/pcie/pme.c                             |   4 +-
 drivers/pci/pcie/portdrv.c                         |   7 +-
 drivers/pci/pcie/ptm.c                             |   5 +-
 drivers/pci/probe.c                                |  14 +-
 drivers/pci/quirks.c                               |  75 +-
 drivers/pci/search.c                               |  31 +
 drivers/pci/setup-bus.c                            |   2 +-
 drivers/pci/vc.c                                   |   9 +-
 drivers/pci/vgaarb.c                               |  14 +-
 drivers/scsi/ipr.c                                 |  12 +-
 include/linux/logic_pio.h                          |   3 -
 include/linux/pci.h                                |  29 +
 include/linux/pci_ids.h                            |   1 +
 include/uapi/linux/pci_regs.h                      |  24 +-
 sound/pci/hda/hda_intel.c                          |  16 +-
 88 files changed, 2613 insertions(+), 511 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c
 create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c
