Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585603742D4
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhEEQsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 12:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235994AbhEEQpZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 12:45:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 573D761931;
        Wed,  5 May 2021 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232573;
        bh=GNE46FwybbDNoekacRkSMORa/S/s/o84e+64lGvXz1A=;
        h=Date:From:To:Cc:Subject:From;
        b=M2LioRnDCM2y+tEV9PdN3gOS35V0P/z+9xWRBZMyYQ+z0qAGzAt5/14Mv0uPwQoWK
         NX8Z08+nXZwizFUFqzmqAyGPOhB+kNKfNc1SBeX0iUiOd/g3+Bxzq0vxdlMUW+Bntg
         EesOXyxtpe/tWAOvid2oa27FyrlQgkBwsA2ZeJ7PFC8+GOSLIgkP5DIZnl1gRpNS60
         SkNMMOGezct6iQKdG8EFQmNqwn038v+06zl1zLbDo/feASPENm+P8K8HwLXSejIYJs
         jyLP5BUILHJf4XB02c99iHOxSNKx2Ao0oX4RfygfN2Ygsqj9kaGEygAQuJWHPPKro2
         ALVPEJRvFsRhA==
Date:   Wed, 5 May 2021 11:36:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.13
Message-ID: <20210505163611.GA1310028@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-changes

for you to fetch changes up to 882862aaacefcb9f723b0f7817ddafc154465d8f:

  Merge branch 'pci/tegra' (2021-05-04 10:43:32 -0500)

----------------------------------------------------------------

Enumeration:
  - Release OF node when pci_scan_device() fails (Dmitry Baryshkov)
  - Add pci_disable_parity() (Bjorn Helgaas)
  - Disable Mellanox Tavor parity reporting (Heiner Kallweit)
  - Disable N2100 r8169 parity reporting (Heiner Kallweit)
  - Fix RCiEP device to RCEC association (Qiuxu Zhuo)
  - Convert sysfs "config", "rom", "reset", "label", "index", "acpi_index" to
    static attributes to help fix races in device enumeration (Krzysztof
    Wilczyński)
  - Convert sysfs "vpd" to static attribute (Heiner Kallweit, Krzysztof
    Wilczyński)
  - Use sysfs_emit() in "show" functions (Krzysztof Wilczyński)
  - Remove unused alloc_pci_root_info() return value (Krzysztof Wilczyński)

PCI device hotplug:
  - Fix acpiphp reference count leak (Feilong Lin)

Power management:
  - Fix acpi_pci_set_power_state() debug message (Rafael J. Wysocki)
  - Fix runtime PM imbalance (Dinghao Liu)

Virtualization:
  - Increase delay after FLR to work around Intel DC P4510 NVMe erratum
    (Raphael Norwitz)

MSI:
  - Convert rcar, tegra, xilinx to MSI domains (Marc Zyngier)
  - For rcar, xilinx, use controller address as MSI doorbell (Marc Zyngier)
  - Remove unused hv msi_controller struct (Marc Zyngier)
  - Remove unused PCI core msi_controller support (Marc Zyngier)
  - Remove struct msi_controller altogether (Marc Zyngier)
  - Remove unused default_teardown_msi_irqs() (Marc Zyngier)
  - Let host bridges declare their reliance on MSI domains (Marc Zyngier)
  - Make pci_host_common_probe() declare its reliance on MSI domains (Marc
    Zyngier)
  - Advertise mediatek lack of built-in MSI handling (Thomas Gleixner)
  - Document ways of ending up with NO_MSI (Marc Zyngier)
  - Refactor HT advertising of NO_MSI flag (Marc Zyngier)

VPD:
  - Remove obsolete Broadcom NIC VPD length-limiting quirk (Heiner Kallweit)
  - Remove sysfs VPD size checking dead code (Heiner Kallweit)
  - Convert VPF sysfs file to static attribute (Heiner Kallweit)
  - Remove unnecessary pci_set_vpd_size() (Heiner Kallweit)
  - Tone down "missing VPD" message (Heiner Kallweit)

Endpoint framework:
  - Fix NULL pointer dereference when epc_features not implemented (Shradha
    Todi)
  - Add missing destroy_workqueue() in endpoint test (Yang Yingliang)

Amazon Annapurna Labs PCIe controller driver:
  - Fix compile testing without CONFIG_PCI_ECAM (Arnd Bergmann)
  - Fix "no symbols" warnings when compile testing with
    CONFIG_TRIM_UNUSED_KSYMS (Arnd Bergmann)

APM X-Gene PCIe controller driver:
  - Fix cfg resource mapping regression (Dejin Zheng)

Broadcom iProc PCIe controller driver:
  - Return zero for success of iproc_msi_irq_domain_alloc() (Pali Rohár)

Broadcom STB PCIe controller driver:
  - Add reset_control_rearm() stub for !CONFIG_RESET_CONTROLLER (Jim Quinlan)
  - Fix use of BCM7216 reset controller (Jim Quinlan)
  - Use reset/rearm for Broadcom STB pulse reset instead of deassert/assert
    (Jim Quinlan)
  - Fix brcm_pcie_probe() error return for unsupported revision (Wei Yongjun)

Cavium ThunderX PCIe controller driver:
  - Fix compile testing (Arnd Bergmann)
  - Fix "no symbols" warnings when compile testing with
    CONFIG_TRIM_UNUSED_KSYMS (Arnd Bergmann)

Freescale Layerscape PCIe controller driver:
  - Fix ls_pcie_ep_probe() syntax error (comma for semicolon) (Krzysztof
    Wilczyński)
  - Remove layerscape-gen4 dependencies on OF and ARM64, add dependency on
    ARCH_LAYERSCAPE (Geert Uytterhoeven)

HiSilicon HIP PCIe controller driver:
  - Remove obsolete HiSilicon PCIe DT description (Dongdong Liu)

Intel Gateway PCIe controller driver:
  - Remove unused pcie_app_rd() (Jiapeng Chong)

Intel VMD host bridge driver:
  - Program IRTE with Requester ID of VMD endpoint, not child device (Jon
    Derrick)
  - Disable VMD MSI-X remapping when possible so children can use more MSI-X
    vectors (Jon Derrick)

MediaTek PCIe controller driver:
  - Configure FC and FTS for functions other than 0 (Ryder Lee)
  - Add YAML schema for MediaTek (Jianjun Wang)
  - Export pci_pio_to_address() for module use (Jianjun Wang)
  - Add MediaTek MT8192 PCIe controller driver (Jianjun Wang)
  - Add MediaTek MT8192 INTx support (Jianjun Wang)
  - Add MediaTek MT8192 MSI support (Jianjun Wang)
  - Add MediaTek MT8192 system power management support (Jianjun Wang)
  - Add missing MODULE_DEVICE_TABLE (Qiheng Lin)

Microchip PolarFlare PCIe controller driver:
  - Make several symbols static (Wei Yongjun)

NVIDIA Tegra PCIe controller driver:
  - Add MCFG quirks for Tegra194 ECAM errata (Vidya Sagar)
  - Make several symbols const (Rikard Falkeborn)
  - Fix Kconfig host/endpoint typo (Wesley Sheng)

SiFive FU740 PCIe controller driver:
  - Add pcie_aux clock to prci driver (Greentime Hu)
  - Use reset-simple in prci driver for PCIe (Greentime Hu)
  - Add SiFive FU740 PCIe host controller driver and DT binding (Paul
    Walmsley, Greentime Hu)

Synopsys DesignWare PCIe controller driver:
  - Move MSI Receiver init to dw_pcie_host_init() so it is re-initialized
    along with the RC in resume (Jisheng Zhang)
  - Move iATU detection earlier to fix regression (Hou Zhiqiang)

TI J721E PCIe driver:
  - Add DT binding and TI j721e support for refclk to PCIe connector (Kishon
    Vijay Abraham I)
  - Add host mode and endpoint mode DT bindings for TI AM64 SoC (Kishon Vijay
    Abraham I)

TI Keystone PCIe controller driver:
  - Use generic config accessors for TI AM65x (K3) to fix regression (Kishon
    Vijay Abraham I)

Xilinx NWL PCIe controller driver:
  - Add support for coherent PCIe DMA traffic using CCI (Bharat Kumar Gogada)
  - Add optional "dma-coherent" DT property (Bharat Kumar Gogada)

Miscellaneous:
  - Fix kernel-doc warnings (Krzysztof Wilczyński)
  - Remove unused MicroGate SyncLink device IDs (Jiri Slaby)
  - Remove redundant dev_err() for devm_ioremap_resource() failure (Chen Hui)
  - Remove redundant initialization (Colin Ian King)
  - Drop redundant dev_err() for platform_get_irq() errors (Krzysztof
    Wilczyński)

----------------------------------------------------------------
Arnd Bergmann (3):
      PCI: al: Select CONFIG_PCI_ECAM
      PCI: thunder: Fix compile testing
      PCI: Avoid building empty drivers

Arun Easi (1):
      PCI: Allow VPD access for QLogic ISP2722

Bharat Kumar Gogada (2):
      PCI: xilinx-nwl: Enable coherent PCIe DMA traffic using CCI
      PCI: xilinx-nwl: Add optional "dma-coherent" property

Bjorn Helgaas (29):
      PCI: Add pci_disable_parity()
      PCI/sysfs: Rename "vpd" attribute accessors
      Merge branch 'pci/enumeration'
      Merge branch 'pci/error'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/pm'
      Merge branch 'pci/vpd'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/kernel-doc'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/misc'
      Merge branch 'remotes/lorenzo/pci/altera-msi'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/layerscape'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/microchip'
      Merge branch 'remotes/lorenzo/pci/risc-v'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/xgene'
      Merge branch 'remotes/lorenzo/pci/xilinx'
      Merge branch 'remotes/lorenzo/pci/msi'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'pci/brcmstb'
      Merge branch 'pci/tegra'

Chen Hui (1):
      PCI: altera-msi: Remove redundant dev_err call in altera_msi_probe()

Colin Ian King (1):
      PCI: endpoint: Remove redundant initialization of pointer dev

Dejin Zheng (1):
      PCI: xgene: Fix cfg resource mapping

Dinghao Liu (1):
      PCI: tegra: Fix runtime PM imbalance in pex_ep_event_pex_rst_deassert()

Dmitry Baryshkov (1):
      PCI: Release OF node in pci_scan_device()'s error path

Dongdong Liu (1):
      dt-bindings: PCI: hisi: Delete the obsolete HiSilicon PCIe file

Feilong Lin (1):
      ACPI / hotplug / PCI: Fix reference count leak in enable_slot()

Geert Uytterhoeven (1):
      PCI: mobiveil: Improve PCIE_LAYERSCAPE_GEN4 dependencies

Greentime Hu (5):
      clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
      clk: sifive: Use reset-simple in prci driver for PCIe driver
      MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
      dt-bindings: PCI: Add SiFive FU740 PCIe host controller
      riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC

Guobin Huang (1):
      PCI: cpqphp: Use DEFINE_SPINLOCK() for int15_lock

Heiner Kallweit (10):
      PCI/VPD: Remove obsolete Broadcom NIC quirk
      PCI/VPD: Remove sysfs accessor size checking dead code
      IB/mthca: Disable parity reporting
      ARM: iop32x: disable N2100 PCI parity reporting
      PCI/VPD: Remove pci_set_vpd_size()
      PCI/VPD: Make missing VPD message less alarming
      PCI/VPD: Change pci_vpd_init() return type to void
      PCI/VPD: Remove pci_vpd_find_tag() 'offset' argument
      PCI/VPD: Remove pci_vpd_find_tag() SRDT handling
      PCI/VPD: Add helper pci_get_func0_dev()

Hou Zhiqiang (1):
      PCI: dwc: Move iATU detection earlier

Jianjun Wang (7):
      dt-bindings: PCI: mediatek-gen3: Add YAML schema
      PCI: Export pci_pio_to_address() for module use
      PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
      PCI: mediatek-gen3: Add INTx support
      PCI: mediatek-gen3: Add MSI support
      PCI: mediatek-gen3: Add system PM support
      MAINTAINERS: Add Jianjun Wang as MediaTek PCI co-maintainer

Jiapeng Chong (2):
      PCI: shpchp: Remove unused shpc_writeb()
      PCI: dwc/intel-gw: Remove unused function

Jim Quinlan (3):
      reset: add missing empty function reset_control_rearm()
      ata: ahci_brcm: Fix use of BCM7216 reset controller
      PCI: brcmstb: Use reset/rearm instead of deassert/assert

Jiri Slaby (1):
      PCI: Remove MicroGate SyncLink device IDs

Jisheng Zhang (1):
      PCI: dwc: Move dw_pcie_msi_init() to dw_pcie_setup_rc()

Jon Derrick (2):
      iommu/vt-d: Use Real PCI DMA device for IRTE
      PCI: vmd: Disable MSI-X remapping when possible

Kishon Vijay Abraham I (5):
      PCI: keystone: Let AM65 use the pci_ops defined in pcie-designware-host.c
      dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the connector
      dt-bindings: PCI: ti,j721e: Add host mode dt-bindings for TI's AM64 SoC
      dt-bindings: PCI: ti,j721e: Add endpoint mode dt-bindings for TI's AM64 SoC
      PCI: j721e: Add support to provide refclk to PCIe connector

Krzysztof Wilczyński (15):
      PCI: Fix kernel-doc errors
      PCI: microchip: Remove dev_err() when handing an error from platform_get_irq()
      PCI: layerscape: Correct syntax by changing comma to semicolon
      PCI/sysfs: Convert "config" to static attribute
      PCI/sysfs: Convert "rom" to static attribute
      PCI/sysfs: Convert "reset" to static attribute
      PCI/sysfs: Convert "vpd" to static attribute
      PCI/sysfs: Rename device_has_dsm() to device_has_acpi_name()
      PCI/sysfs: Define ACPI label attributes with DEVICE_ATTR*()
      PCI/sysfs: Define SMBIOS label attributes with DEVICE_ATTR*()
      PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes
      PCI/sysfs: Tidy SMBIOS & ACPI label attributes
      PCI/sysfs: Rearrange smbios_attr_group and acpi_attr_group
      PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
      x86/PCI: Remove unused alloc_pci_root_info() return value

Marc Zyngier (13):
      PCI: tegra: Convert to MSI domains
      PCI: rcar: Don't allocate extra memory for the MSI capture address
      PCI: rcar: Convert to MSI domains
      PCI: xilinx: Don't allocate extra memory for the MSI capture address
      PCI: xilinx: Convert to MSI domains
      PCI: hv: Drop msi_controller structure
      PCI/MSI: Drop use of msi_controller from core code
      PCI/MSI: Kill msi_controller structure
      PCI/MSI: Kill default_teardown_msi_irqs()
      PCI/MSI: Let PCI host bridges declare their reliance on MSI domains
      PCI/MSI: Make pci_host_common_probe() declare its reliance on MSI domains
      PCI/MSI: Document the various ways of ending up with NO_MSI
      PCI: Refactor HT advertising of NO_MSI flag

Pali Rohár (1):
      PCI: iproc: Fix return value of iproc_msi_irq_domain_alloc()

Paul Walmsley (1):
      PCI: fu740: Add SiFive FU740 PCIe host controller driver

Qiheng Lin (1):
      PCI: mediatek: Add missing MODULE_DEVICE_TABLE

Qiuxu Zhuo (1):
      PCI/RCEC: Fix RCiEP device to RCEC association

Rafael J. Wysocki (1):
      PCI/ACPI: Fix acpi_pci_set_power_state() debug message

Raphael Norwitz (1):
      PCI: Delay after FLR of Intel DC P4510 NVMe

Rikard Falkeborn (1):
      PCI: tegra: Constify static structs

Ryder Lee (1):
      PCI: mediatek: Configure FC and FTS for functions other than 0

Shradha Todi (1):
      PCI: endpoint: Fix NULL pointer dereference for ->get_features()

Thomas Gleixner (1):
      PCI: mediatek: Advertise lack of built-in MSI handling

Vidya Sagar (1):
      PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata

Wei Yongjun (2):
      PCI: microchip: Make some symbols static
      PCI: brcmstb: Fix error return code in brcm_pcie_probe()

Wesley Sheng (1):
      PCI: tegra: Fix typo for PCIe endpoint mode in Tegra194

Yang Yingliang (1):
      PCI: endpoint: Fix missing destroy_workqueue()

chakravarthikulkarni (1):
      PCI: acpiphp: Fix whitespace issue

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |   43 -
 .../bindings/pci/mediatek-pcie-gen3.yaml           |  181 ++++
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |  113 +++
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |    9 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |   20 +-
 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |    2 +
 MAINTAINERS                                        |   10 +-
 arch/arm/mach-iop32x/n2100.c                       |    8 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |   33 +
 arch/x86/pci/amd_bus.c                             |    2 +-
 drivers/acpi/pci_mcfg.c                            |    7 +
 drivers/ata/ahci_brcm.c                            |   46 +-
 drivers/clk/sifive/Kconfig                         |    2 +
 drivers/clk/sifive/fu740-prci.c                    |   11 +
 drivers/clk/sifive/fu740-prci.h                    |    2 +-
 drivers/clk/sifive/sifive-prci.c                   |   54 +
 drivers/clk/sifive/sifive-prci.h                   |   13 +
 drivers/iommu/intel/irq_remapping.c                |    3 +-
 drivers/net/ethernet/broadcom/bnx2.c               |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   14 -
 drivers/net/ethernet/sfc/efx.c                     |    2 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |    2 +-
 drivers/pci/ats.c                                  |    2 +-
 drivers/pci/controller/Kconfig                     |   17 +-
 drivers/pci/controller/Makefile                    |    8 +-
 drivers/pci/controller/cadence/pci-j721e.c         |   24 +-
 drivers/pci/controller/dwc/Kconfig                 |   12 +-
 drivers/pci/controller/dwc/Makefile                |   10 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   14 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |    2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |    2 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |    4 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   11 +-
 drivers/pci/controller/dwc/pcie-designware.h       |    1 +
 drivers/pci/controller/dwc/pcie-fu740.c            |  309 ++++++
 drivers/pci/controller/dwc/pcie-intel-gw.c         |    5 -
 drivers/pci/controller/dwc/pcie-tegra194.c         |  108 +-
 drivers/pci/controller/mobiveil/Kconfig            |    3 +-
 drivers/pci/controller/pci-host-common.c           |    1 +
 drivers/pci/controller/pci-hyperv.c                |    4 -
 drivers/pci/controller/pci-tegra.c                 |  371 +++----
 drivers/pci/controller/pci-thunder-ecam.c          |    2 +-
 drivers/pci/controller/pci-thunder-pem.c           |   13 +-
 drivers/pci/controller/pci-xgene.c                 |    3 +-
 drivers/pci/controller/pcie-altera-msi.c           |    4 +-
 drivers/pci/controller/pcie-brcmstb.c              |   20 +-
 drivers/pci/controller/pcie-iproc-msi.c            |    2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        | 1027 ++++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c             |    7 +-
 drivers/pci/controller/pcie-microchip-host.c       |   12 +-
 drivers/pci/controller/pcie-rcar-host.c            |  359 ++++---
 drivers/pci/controller/pcie-xilinx-nwl.c           |    7 +
 drivers/pci/controller/pcie-xilinx.c               |  248 ++---
 drivers/pci/controller/vmd.c                       |   63 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |   16 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   22 +-
 drivers/pci/endpoint/pci-epc-core.c                |    2 +
 drivers/pci/endpoint/pci-epf-core.c                |    2 +-
 drivers/pci/hotplug/acpi_pcihp.c                   |    2 +-
 drivers/pci/hotplug/acpiphp.h                      |    3 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |    1 +
 drivers/pci/hotplug/cpqphp_nvram.c                 |    5 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |    5 -
 drivers/pci/msi.c                                  |   57 +-
 drivers/pci/of.c                                   |   22 +-
 drivers/pci/pci-acpi.c                             |    2 +-
 drivers/pci/pci-label.c                            |  232 ++---
 drivers/pci/pci-sysfs.c                            |  260 +++--
 drivers/pci/pci.c                                  |   18 +
 drivers/pci/pci.h                                  |   24 +-
 drivers/pci/pcie/aer.c                             |    6 +-
 drivers/pci/pcie/pme.c                             |    2 +-
 drivers/pci/pcie/rcec.c                            |    2 +-
 drivers/pci/probe.c                                |    5 +-
 drivers/pci/quirks.c                               |   29 +-
 drivers/pci/remove.c                               |    2 +
 drivers/pci/vpd.c                                  |  232 ++---
 drivers/reset/Kconfig                              |    1 +
 drivers/scsi/cxlflash/main.c                       |    3 +-
 include/dt-bindings/clock/sifive-fu740-prci.h      |    1 +
 include/linux/msi.h                                |   17 +-
 include/linux/pci-ecam.h                           |    1 +
 include/linux/pci.h                                |    9 +-
 include/linux/pci_ids.h                            |    2 -
 include/linux/reset.h                              |    5 +
 89 files changed, 2957 insertions(+), 1298 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c
 create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c
