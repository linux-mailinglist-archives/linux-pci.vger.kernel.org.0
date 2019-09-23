Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54354BBEA9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 00:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfIWW61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 18:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbfIWW61 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 18:58:27 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDC721971;
        Mon, 23 Sep 2019 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569279505;
        bh=+T6SXgfbrBUwzMFS5UV+Sf/Q9vGJeKcUUBFpDPW/JSw=;
        h=Date:From:To:Cc:Subject:From;
        b=F6cEOylWQ2PlXlX6GXhCETwj0nYNVzh1svJUvNeCjoGA6C4bCNXL0zvBbWmB33L3d
         zRC7yg5nAeEWxtB7KE0GcOZeJ66It11Svn9puHwsqxTK2/rR893EwfJDQuw5XANoN5
         jeyBE6C9ghMXzU561LYcL+oW5d/WPyRmazcJPxIc=
Date:   Mon, 23 Sep 2019 17:58:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.4
Message-ID: <20190923225822.GC11938@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.4-changes

for you to fetch changes up to c5048a73b4770304699cb15e3ffcb97acab685f7:

  Merge branch 'pci/trivial' (2019-09-23 16:10:31 -0500)

----------------------------------------------------------------

You should see minor conflicts in drivers/pci/Kconfig and
drivers/pci/controller/pci-hyperv.c related to some changes merged via
the net tree.


Enumeration:

  - Consolidate _HPP/_HPX stuff in pci-acpi.c and simplify it (Krzysztof
    Wilczynski)

  - Fix incorrect PCIe device types and remove dev->has_secondary_link to
    simplify code that deals with upstream/downstream ports (Mika
    Westerberg)

  - After suspend, restore Resizable BAR size bits correctly for 1MB BARs
    (Sumit Saxena)

  - Enable PCI_MSI_IRQ_DOMAIN support for RISC-V (Wesley Terpstra)

Virtualization:

  - Add ACS quirks for iProc PAXB (Abhinav Ratna), Amazon Annapurna Labs
    (Ali Saidi)

  - Move sysfs SR-IOV functions to iov.c (Kelsey Skunberg)

  - Remove group write permissions from sysfs sriov_numvfs,
    sriov_drivers_autoprobe (Kelsey Skunberg)

Hotplug:

  - Simplify pciehp indicator control (Denis Efremov)

Peer-to-peer DMA:

  - Allow P2P DMA between root ports for whitelisted bridges (Logan
    Gunthorpe)

  - Whitelist some Intel host bridges for P2P DMA (Logan Gunthorpe)

  - DMA map P2P DMA requests that traverse host bridge (Logan Gunthorpe)

Amazon Annapurna Labs host bridge driver:

  - Add DT binding and controller driver (Jonathan Chocron)

Hyper-V host bridge driver:

  - Fix hv_pci_dev->pci_slot use-after-free (Dexuan Cui)

  - Fix PCI domain number collisions (Haiyang Zhang)

  - Use instance ID bytes 4 & 5 as PCI domain numbers (Haiyang Zhang)

  - Fix build errors on non-SYSFS config (Randy Dunlap)

i.MX6 host bridge driver:

  - Limit DBI register length (Stefan Agner)

Intel VMD host bridge driver:

  - Fix config addressing issues (Jon Derrick)

Layerscape host bridge driver:

  - Add bar_fixed_64bit property to endpoint driver (Xiaowei Bao)

  - Add CONFIG_PCI_LAYERSCAPE_EP to build EP/RC drivers separately (Xiaowei
    Bao)

Mediatek host bridge driver:

  - Add MT7629 controller support (Jianjun Wang)

Mobiveil host bridge driver:

  - Fix CPU base address setup (Hou Zhiqiang)

  - Make "num-lanes" property optional (Hou Zhiqiang)

Tegra host bridge driver:

  - Fix OF node reference leak (Nishka Dasgupta)

  - Disable MSI for root ports to work around design problem (Vidya Sagar)

  - Add Tegra194 DT binding and controller support (Vidya Sagar)

  - Add support for sideband pins and slot regulators (Vidya Sagar)

  - Add PIPE2UPHY support (Vidya Sagar)

Misc:

  - Remove unused pci_block_cfg_access() et al (Kelsey Skunberg)

  - Unexport pci_bus_get(), etc (Kelsey Skunberg)

  - Hide PM, VC, link speed, ATS, ECRC, PTM constants and interfaces in the
    PCI core (Kelsey Skunberg)

  - Clean up sysfs DEVICE_ATTR() usage (Kelsey Skunberg)

  - Mark expected switch fall-through (Gustavo A. R. Silva)

  - Propagate errors for optional regulators and PHYs (Thierry Reding)

  - Fix kernel command line resource_alignment parameter issues (Logan
    Gunthorpe)


----------------------------------------------------------------
Abhinav Ratna (1):
      PCI: Add ACS quirk for iProc PAXB

Alexey Kardashevskiy (1):
      PCI: Correct pci=resource_alignment parameter example

Ali Saidi (1):
      PCI: Add ACS quirk for Amazon Annapurna Labs root ports

Bjorn Helgaas (21):
      PCI: Fix typos and whitespace errors
      PCI: pciehp: Refer to "Indicators" instead of "LEDs" in comments
      Merge branch 'pci/aspm'
      Merge branch 'pci/encapsulate'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pciehp'
      Merge branch 'pci/resource'
      Merge branch 'remotes/lorenzo/pci/al'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/imx'
      Merge branch 'remotes/lorenzo/pci/layerscape'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'remotes/lorenzo/pci/mobiveil'
      Merge branch 'lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'pci/trivial'

Denis Efremov (6):
      PCI: Convert pci_resource_to_user() to a weak function
      PCI: Use PCI_SRIOV_NUM_BARS in loops instead of PCI_IOV_RESOURCE_END
      PCI: pciehp: Add pciehp_set_indicators() to set both indicators
      PCI: pciehp: Combine adjacent indicator updates
      PCI: pciehp: Remove pciehp_set_attention_status()
      PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()

Dexuan Cui (1):
      PCI: hv: Avoid use of hv_pci_dev->pci_slot after freeing it

Fuqian Huang (1):
      PCI: Use devm_add_action_or_reset()

Gustavo A. R. Silva (1):
      PCI: Mark expected switch fall-through

Haiyang Zhang (2):
      PCI: hv: Detect and fix Hyper-V PCI domain number collision
      PCI: hv: Use bytes 4 and 5 from instance ID as the PCI domain numbers

Herbert Xu (1):
      PCI: Add pci_irq_vector() and other stubs when !CONFIG_PCI

Hou Zhiqiang (5):
      PCI: mobiveil: Fix the CPU base address setup in inbound window
      dt-bindings: PCI: designware: Remove the num-lanes from Required properties
      PCI: dwc: Return directly when num-lanes is not found
      ARM: dts: ls1021a: Remove num-lanes property from PCIe nodes
      arm64: dts: fsl: Remove num-lanes property from PCIe nodes

Jianjun Wang (2):
      dt-bindings: PCI: Add support for MT7629
      PCI: mediatek: Add controller support for MT7629

Jon Derrick (2):
      PCI: vmd: Fix config addressing when using bus offsets
      PCI: vmd: Fix shadow offsets to reflect spec changes

Jonathan Chocron (6):
      PCI: Add Amazon's Annapurna Labs vendor ID
      PCI/VPD: Prevent VPD access for Amazon's Annapurna Labs Root Port
      PCI: Add quirk to disable MSI-X support for Amazon's Annapurna Labs Root Port
      dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
      PCI: dwc: al: Add Amazon Annapurna Labs PCIe controller driver
      PCI: dwc: Add validation that PCIe core is set to correct mode

Kelsey Skunberg (19):
      PCI: Remove pci_block_cfg_access() et al (unused)
      PCI: Unexport pci_bus_get() and pci_bus_put()
      PCI: Unexport pci_bus_sem
      PCI: Make PCI_PM_* delay times private
      PCI: Make pci_check_pme_status(), pci_pme_wakeup_bus() private
      PCI: Make pci_get_host_bridge_device(), pci_put_host_bridge_device() private
      PCI: Make pci_save_vc_state(), pci_restore_vc_state(), etc private
      PCI: Make pci_hotplug_io_size, mem_size, and bus_size private
      PCI: Make pci_bus_get(), pci_bus_put() private
      PCI: Make pcie_update_link_speed() private
      PCI: Make pci_ats_init() private
      PCI: Make pcie_set_ecrc_checking(), pcie_ecrc_get_policy() private
      PCI: Make pci_enable_ptm() private
      PCI: Make pci_set_of_node(), etc private
      PCI: sysfs: Define device attributes with DEVICE_ATTR*()
      PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()
      PCI: sysfs: Change permissions from symbolic to octal
      PCI/IOV: Move sysfs SR-IOV functions to iov.c
      PCI/IOV: Remove group write permission from sriov_numvfs, sriov_drivers_autoprobe

Krzysztof Wilczynski (7):
      PCI: Move ASPM declarations to linux/pci.h
      PCI/ACPI: Rename _HPX structs from hpp_* to hpx_*
      PCI/ACPI: Move _HPP & _HPX functions to pci-acpi.c
      PCI/ACPI: Remove unnecessary struct hotplug_program_ops
      PCI: Remove unnecessary returns
      PCI: Add pci_info_ratelimited() to ratelimit PCI separately
      PCI: Use static const struct, not const static struct

Logan Gunthorpe (17):
      PCI/P2PDMA: Introduce private pagemap structure
      PCI/P2PDMA: Add provider's pci_dev to pci_p2pdma_pagemap struct
      PCI/P2PDMA: Add constants for map type results to upstream_bridge_distance()
      PCI/P2PDMA: Factor out __upstream_bridge_distance()
      PCI/P2PDMA: Apply host bridge whitelist for ACS
      PCI/P2PDMA: Factor out host_bridge_whitelist()
      PCI/P2PDMA: Whitelist some Intel host bridges
      PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
      PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
      PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
      PCI/P2PDMA: Store mapping method in an xarray
      PCI/P2PDMA: dma_map() requests that traverse the host bridge
      PCI/P2PDMA: Allow IOMMU for host bridge whitelist
      PCI/P2PDMA: Update pci_p2pdma_distance_many() documentation
      PCI: Clean up resource_alignment parameter to not require static buffer
      PCI: Move pci_[get|set]_resource_alignment_param() into their callers
      PCI: Force trailing new line to resource_alignment_param in sysfs

Lorenzo Pieralisi (1):
      MAINTAINERS: Add PCI native host/endpoint controllers designated reviewer

Lubomir Rintel (1):
      PCI: OF: Correct of_irq_parse_pci() documentation

Mika Westerberg (2):
      PCI: Make pcie_downstream_port() available outside of access.c
      PCI: Get rid of dev->has_secondary_link flag

Nishka Dasgupta (2):
      PCI: tegra: Fix OF node reference leak
      PCI: kirin: Make structure kirin_dw_pcie_ops constant

Randy Dunlap (1):
      PCI: pci-hyperv: Fix build errors on non-SYSFS config

Stefan Agner (1):
      PCI: imx6: Limit DBI register length

Sumit Saxena (1):
      PCI: Restore Resizable BAR size bits correctly for 1MB BARs

Thierry Reding (6):
      PCI: rockchip: Propagate errors for optional regulators
      PCI: exynos: Propagate errors for optional PHYs
      PCI: imx6: Propagate errors for optional regulators
      PCI: armada8x: Propagate errors for optional PHYs
      PCI: histb: Propagate errors for optional regulators
      PCI: iproc: Propagate errors for optional PHYs

Vidya Sagar (19):
      PCI: Add #defines for some of PCIe spec r4.0 features
      PCI: Disable MSI for Tegra root ports
      PCI: dwc: Group DBI registers writes requiring unlocking
      PCI: dwc: Move config space capability search API
      PCI: dwc: Add extended configuration space capability search API
      PCI: dwc: Export dw_pcie_wait_for_link() API
      dt-bindings: PCI: designware: Add binding for CDM register check
      PCI: dwc: Add support to enable CDM register check
      dt-bindings: Add PCIe supports-clkreq property
      dt-bindings: PCI: tegra: Add device tree support for Tegra194
      dt-bindings: PHY: P2U: Add Tegra194 P2U block
      phy: tegra: Add PCIe PIPE2UPHY support
      PCI: tegra: Add Tegra194 PCIe support
      dt-bindings: PCI: tegra: Add sideband pins configuration entries
      dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
      PCI: tegra: Add support to configure sideband pins
      PCI: tegra: Add support to enable slot regulators
      arm64: tegra: Add configuration for PCIe C5 sideband signals
      arm64: tegra: Add PCIe slot supply information in p2972-0000 platform

Wesley Terpstra (1):
      PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for RISC-V

Xiaowei Bao (2):
      PCI: layerscape: Add the bar_fixed_64bit property to the endpoint driver
      PCI: layerscape: Add CONFIG_PCI_LAYERSCAPE_EP to build EP/RC separately

 Documentation/admin-guide/kernel-parameters.txt    |    5 +-
 .../devicetree/bindings/pci/designware-pcie.txt    |    6 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |    2 +-
 .../devicetree/bindings/pci/mediatek-pcie.txt      |    1 +
 .../bindings/pci/nvidia,tegra194-pcie.txt          |  171 ++
 .../devicetree/bindings/pci/pci-armada8k.txt       |    2 +-
 Documentation/devicetree/bindings/pci/pci.txt      |    5 +
 Documentation/devicetree/bindings/pci/pcie-al.txt  |   46 +
 .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |   28 +
 MAINTAINERS                                        |    4 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |    2 -
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |    1 -
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |    3 -
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |    6 -
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |    3 -
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |    4 -
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   24 +
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |    4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   38 +-
 arch/microblaze/include/asm/pci.h                  |    2 -
 arch/mips/include/asm/pci.h                        |    1 -
 arch/powerpc/include/asm/pci.h                     |    2 -
 arch/sparc/include/asm/pci.h                       |    2 -
 drivers/acpi/pci_root.c                            |    1 -
 drivers/char/xillybus/xillybus_pcie.c              |    1 -
 drivers/infiniband/core/rw.c                       |    6 +-
 drivers/net/ethernet/intel/e1000e/e1000.h          |    1 -
 drivers/net/ethernet/jme.c                         |    1 -
 drivers/net/ethernet/realtek/r8169_main.c          |    1 -
 drivers/net/wireless/ath/ath5k/pci.c               |    1 -
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    1 -
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |    1 -
 drivers/nvme/host/pci.c                            |   10 +-
 drivers/pci/Kconfig                                |    6 +-
 drivers/pci/access.c                               |    9 -
 drivers/pci/bus.c                                  |    2 -
 drivers/pci/controller/dwc/Kconfig                 |   42 +-
 drivers/pci/controller/dwc/Makefile                |    4 +-
 drivers/pci/controller/dwc/pci-exynos.c            |    2 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   37 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |    1 +
 drivers/pci/controller/dwc/pcie-al.c               |  365 +++++
 drivers/pci/controller/dwc/pcie-armada8k.c         |    7 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   45 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   30 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   96 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   12 +
 drivers/pci/controller/dwc/pcie-histb.c            |    4 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |    2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         | 1732 ++++++++++++++++++++
 drivers/pci/controller/pci-host-common.c           |    3 +-
 drivers/pci/controller/pci-hyperv.c                |   94 +-
 drivers/pci/controller/pci-tegra.c                 |   22 +-
 drivers/pci/controller/pcie-iproc-platform.c       |    9 +-
 drivers/pci/controller/pcie-mediatek.c             |   20 +-
 drivers/pci/controller/pcie-mobiveil.c             |   10 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   16 +-
 drivers/pci/controller/vmd.c                       |   25 +-
 drivers/pci/hotplug/cpci_hotplug_core.c            |    1 -
 drivers/pci/hotplug/cpqphp_core.c                  |    1 -
 drivers/pci/hotplug/cpqphp_ctrl.c                  |    4 -
 drivers/pci/hotplug/cpqphp_nvram.h                 |    5 +-
 drivers/pci/hotplug/ibmphp_res.c                   |    1 +
 drivers/pci/hotplug/pciehp.h                       |   11 +-
 drivers/pci/hotplug/pciehp_core.c                  |    9 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   39 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   87 +-
 drivers/pci/hotplug/rpadlpar_core.c                |    1 -
 drivers/pci/hotplug/rpaphp_core.c                  |    1 -
 drivers/pci/iov.c                                  |  171 +-
 drivers/pci/of.c                                   |    2 +-
 drivers/pci/p2pdma.c                               |  374 +++--
 drivers/pci/pci-acpi.c                             |  410 ++++-
 drivers/pci/pci-bridge-emul.c                      |    4 +-
 drivers/pci/pci-sysfs.c                            |  223 +--
 drivers/pci/pci.c                                  |   87 +-
 drivers/pci/pci.h                                  |   68 +-
 drivers/pci/pcie/aspm.c                            |    9 +-
 drivers/pci/pcie/err.c                             |    2 +-
 drivers/pci/probe.c                                |  326 +---
 drivers/pci/quirks.c                               |  106 +-
 drivers/pci/search.c                               |    1 -
 drivers/pci/setup-bus.c                            |    4 +-
 drivers/pci/vc.c                                   |    5 +-
 drivers/pci/vpd.c                                  |    6 +
 drivers/phy/tegra/Kconfig                          |    7 +
 drivers/phy/tegra/Makefile                         |    1 +
 drivers/phy/tegra/phy-tegra194-p2u.c               |  120 ++
 drivers/scsi/aacraid/linit.c                       |    1 -
 drivers/scsi/hpsa.c                                |    1 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    1 -
 include/linux/memremap.h                           |    1 -
 include/linux/pci-aspm.h                           |   36 -
 include/linux/pci-p2pdma.h                         |   28 +-
 include/linux/pci.h                                |  133 +-
 include/linux/pci_hotplug.h                        |  100 --
 include/linux/pci_ids.h                            |    3 +
 include/uapi/linux/pci_regs.h                      |   15 +-
 99 files changed, 4201 insertions(+), 1186 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c
 create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
 delete mode 100644 include/linux/pci-aspm.h
