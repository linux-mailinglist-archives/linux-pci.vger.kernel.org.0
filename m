Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444D71BFF9
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEMX51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 19:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfEMX51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 May 2019 19:57:27 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D0682084D;
        Mon, 13 May 2019 23:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557791845;
        bh=QEMo7hBuvlqR87qOsJeMWIseN68EACHYDLmNBGCXyP8=;
        h=Date:From:To:Cc:Subject:From;
        b=upUsuinCqQ3KDgd75QPYMfPrQ/Q7xR0BDoRrXjBD6sDh1o3237Hcb+XdiZGcelOuk
         2ZDOUiXOddeImckvNesG5kFcCI8UmmjF8mcKxYBu4sL9qw7MsRVEDxbWn2eiPkxIXv
         QJP4VpH8DtEW4/jaahT37k+geja6Bm+NNBouzzS4=
Date:   Mon, 13 May 2019 18:57:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.2
Message-ID: <20190513235721.GA157967@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enumeration changes:

  - Add _HPX Type 3 settings support, which gives firmware more influence
    over device configuration (Alexandru Gagniuc)

  - Support fixed bus numbers from bridge Enhanced Allocation capabilities
    (Subbaraya Sundeep)

  - Add "external-facing" DT property to identify cases where we require
    IOMMU protection against untrusted devices (Jean-Philippe Brucker)

  - Enable PCIe services for host controller drivers that use managed host
    bridge alloc (Jean-Philippe Brucker)

  - Log PCIe port service messages with pci_dev, not the pcie_device
    (Frederick Lawler)

  - Convert pciehp from pciehp_debug module parameter to generic dynamic
    debug (Frederick Lawler)

Peer-to-peer DMA:

  - Add whitelist of Root Complexes that support peer-to-peer DMA between
    Root Ports (Christian König)

Native controller drivers:

  - Add PCI host bridge DMA ranges for bridges that can't DMA everywhere,
    e.g., iProc (Srinath Mannam)

  - Add Amazon Annapurna Labs PCIe host controller driver (Jonathan
    Chocron)

  - Fix Tegra MSI target allocation so DMA doesn't generate unwanted MSIs
    (Vidya Sagar)

  - Fix of_node reference leaks (Wen Yang)

  - Fix Hyper-V module unload & device removal issues (Dexuan Cui)

  - Cleanup R-Car driver (Marek Vasut)

  - Cleanup Keystone driver (Kishon Vijay Abraham I)

  - Cleanup i.MX6 driver (Andrey Smirnov)

Significant bug fixes:

  - Reset Lenovo ThinkPad P50 GPU so nouveau works after reboot (Lyude
    Paul)

  - Fix Switchtec firmware update performance issue (Wesley Sheng)

  - Work around Pericom switch link retraining erratum (Stefan Mätje)


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.2-changes

for you to fetch changes up to c7a1c2bbb65e25551d585fba0fd36a01e0a22690:

  Merge branch 'pci/trivial' (2019-05-13 18:34:48 -0500)

----------------------------------------------------------------
pci-v5.2-changes

----------------------------------------------------------------
Alexandru Gagniuc (4):
      PCI/ACPI: Do not export pci_get_hp_params()
      PCI/ACPI: Remove the need for 'struct hotplug_params'
      PCI/ACPI: Implement _HPX Type 3 Setting Record
      PCI/ACPI: Advertise _HPX Type 3 support via _OSC

Andrey Smirnov (11):
      PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
      PCI: imx6: Drop imx6_pcie_wait_for_link()
      PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
      PCI: imx6: Remove PCIE_PL_PFLR_* constants
      PCI: dwc: imx6: Share PHY debug register definitions
      PCI: imx6: Make use of BIT() in constant definitions
      PCI: imx6: Simplify bit operations in PHY functions
      PCI: imx6: Simplify pcie_phy_poll_ack()
      PCI: imx6: Restrict PHY register data to 16-bit
      PCI: imx6: Use flags to indicate support for suspend
      PCI: imx6: Use usleep_range() in imx6_pcie_enable_ref_clk()

Bjorn Helgaas (35):
      PCI/MSI: Remove unused __write_msi_msg() and write_msi_msg()
      PCI/MSI: Remove unused mask_msi_irq() and unmask_msi_irq()
      PCI: Cleanup register definition width and whitespace
      PCI: Fix comment typos
      CPER: Add UEFI spec references
      CPER: Remove unnecessary use of user-space types
      PCI: Use dev_printk() when possible
      PCI: pciehp: Remove pciehp_debug uses
      PCI: pciehp: Remove pointless PCIE_MODULE_NAME definition
      PCI: pciehp: Remove pointless MY_NAME definition
      Merge branch 'pci/aer'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/msi'
      Merge branch 'pci/misc'
      Merge branch 'pci/peer-to-peer'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/host/al'
      Merge branch 'remotes/lorenzo/pci/controller-fixes'
      Merge branch 'pci/dwc'
      Merge branch 'remotes/lorenzo/pci/imx'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/keystone'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/rockchip'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/xilinx'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'pci/iova-dma-ranges'
      Merge branch 'pci/printk'
      Merge branch 'pci/printk-portdrv'
      Merge branch 'pci/trivial'

Christian König (1):
      PCI/P2PDMA: Allow P2P DMA between any devices under AMD ZEN Root Complex

Chunfeng Yun (1):
      PCI: mediatek: Get optional clocks with devm_clk_get_optional()

Colin Ian King (1):
      PCI: rockchip: Fix rockchip_pcie_ep_assert_intx() bitwise operations

Dexuan Cui (3):
      PCI: hv: Fix a memory leak in hv_eject_device_work()
      PCI: hv: Add hv_pci_remove_slots() when we unload the driver
      PCI: hv: Add pci_destroy_slot() in pci_devices_present_work(), if necessary

Frederick Lawler (7):
      PCI/AER: Replace dev_printk(KERN_DEBUG) with dev_info()
      PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
      PCI/DPC: Log messages with pci_dev, not pcie_device
      PCI/AER: Log messages with pci_dev, not pcie_device
      PCI: pciehp: Replace pciehp_debug module param with dyndbg
      PCI: pciehp: Log messages with pci_dev, not pcie_device
      PCI: pciehp: Remove unused dbg/err/info/warn() wrappers

Gustavo A. R. Silva (1):
      PCI: Mark expected switch fall-throughs

Heiner Kallweit (8):
      PCI: Add pci_dev_id() helper
      r8169: use pci_dev_id() helper
      powerpc/powernv/npu: Use pci_dev_id() helper
      drm/amdkfd: Use pci_dev_id() helper
      iommu/amd: Use pci_dev_id() helper
      iommu/vt-d: Use pci_dev_id() helper
      stmmac: pci: Use pci_dev_id() helper
      platform/chrome: chromeos_laptop: use pci_dev_id() helper

Honghui Zhang (1):
      arm64: dts: mt2712: Remove un-used property for PCIe

James Prestwood (1):
      PCI: Mark Atheros AR9462 to avoid bus reset

Jean-Jacques Hiblot (1):
      tools: PCI: Exit with error code when test fails

Jean-Philippe Brucker (3):
      PCI: Init PCIe feature bits for managed host bridge alloc
      dt-bindings: Add "external-facing" PCIe port property
      PCI: OF: Support "external-facing" property

Jisheng Zhang (6):
      PCI/AER: Change pci_aer_init() stub to return void
      PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
      PCI: dwc: Free MSI IRQ page in dw_pcie_free_msi()
      PCI: dwc: Free MSI in dw_pcie_host_init() error path
      PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify code
      PCI: dwc: Save root bus for driver remove hooks

Johannes Thumshirn (1):
      PCI: Remove unused pci_request_region_exclusive()

Jonathan Chocron (1):
      PCI: al: Add Amazon Annapurna Labs PCIe host controller driver

Kangjie Lu (3):
      PCI: xilinx: Check for __get_free_pages() failure
      PCI: rcar: Fix a potential NULL pointer dereference
      PCI: endpoint: Fix a potential NULL pointer dereference

Kazufumi Ikeda (1):
      PCI: rcar: Add the initialization of PCIe link in resume_noirq()

Kishon Vijay Abraham I (37):
      PCI: keystone: Cleanup interrupt related macros
      PCI: keystone: Add separate functions for configuring MSI and legacy interrupt
      PCI: keystone: Use hwirq to get the MSI IRQ number offset
      PCI: keystone: Cleanup ks_pcie_msi_irq_handler()
      PCI: dwc: Add support to use non default msi_irq_chip
      PCI: keystone: Use Keystone specific msi_irq_chip
      PCI: dwc: Remove Keystone specific dw_pcie_host_ops
      PCI: dwc: Remove default MSI initialization for platform specific MSI chips
      tools: PCI: Add 'h' in optstring of getopt()
      tools: PCI: Handle pcitest.sh independently from pcitest
      PCI: keystone: Add start_link()/stop_link() dw_pcie_ops
      PCI: keystone: Cleanup error_irq configuration
      dt-bindings: PCI: keystone: Add "reg-names" binding information
      PCI: keystone: Perform host initialization in a single function
      PCI: keystone: Use platform_get_resource_byname() to get memory resources
      PCI: keystone: Move resources initialization to prepare for EP support
      dt-bindings: PCI: Add dt-binding to configure PCIe mode
      PCI: keystone: Explicitly set the PCIe mode
      dt-bindings: PCI: Document "atu" reg-names
      PCI: dwc: Enable iATU unroll for endpoint too
      PCI: dwc: Fix ATU identification for designware version >= 4.80
      PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
      dt-bindings: PCI: Add PCI RC DT binding documentation for AM654
      PCI: keystone: Add support for PCIe RC in AM654x Platforms
      PCI: keystone: Invoke phy_reset() API before enabling PHY
      PCI: OF: Allow of_pci_get_max_link_speed() to be used by PCI Endpoint drivers
      PCI: keystone: Add support to set the max link speed from DT
      PCI: endpoint: Add support to specify alignment for buffers allocated to BARs
      PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
      PCI: dwc: Fix dw_pcie_ep_find_capability() to return correct capability offset
      PCI: dwc: Add callbacks for accessing dbi2 address space
      dt-bindings: PCI: Add PCI EP DT binding documentation for AM654
      PCI: keystone: Add support for PCIe EP in AM654x Platforms
      PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size
      PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
      misc: pci_endpoint_test: Add support to test PCI EP in AM654x
      misc: pci_endpoint_test: Fix test_reg_bar to be updated in pci_endpoint_test

Lucas Stach (1):
      PCI: imx6: Allow asynchronous probing

Lyude Paul (1):
      PCI: Reset Lenovo ThinkPad P50 nvgpu at boot if necessary

Marc Gonzalez (1):
      PCI: qcom: Use default config space read function

Marek Vasut (6):
      PCI: rcar: Clean up remaining macros defining bits
      PCI: rcar: Replace unsigned long with u32/unsigned int in register accessors
      PCI: rcar: Replace various variable types with unsigned ones for register values
      PCI: rcar: Replace (8 * n) with (BITS_PER_BYTE * n)
      PCI: rcar: Clean up debug messages
      PCI: rcar: Fix 64bit MSI message address handling

Mika Westerberg (1):
      PCI/LINK: Disable bandwidth notification interrupt during suspend

Mohan Kumar (2):
      PCI: Replace printk(KERN_INFO) with pr_info(), etc
      PCI: Replace dev_printk(KERN_DEBUG) with dev_info(), etc

Nicholas Johnson (1):
      PCI: Cleanup setup-bus.c comments and whitespace

Nikolai Kostrigin (1):
      PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken

Srinath Mannam (6):
      PCI: iproc: Add CRS check in config read
      PCI: iproc: Allow outbound configuration for 32-bit I/O region
      PCI: iproc: Enable iProc config read for PAXBv2
      PCI: Add dma_ranges window list
      iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
      PCI: iproc: Add sorted dma ranges resource entries to host bridge

Stefan Mätje (3):
      PCI: Factor out pcie_retrain_link() function
      PCI: Work around Pericom PCIe-to-PCI bridge Retrain Link erratum
      PCI: Rework pcie_retrain_link() wait loop

Subbaraya Sundeep (1):
      PCI: Assign bus numbers present in EA capability for bridges

Subrahmanya Lingappa (1):
      MAINTAINERS: Add Karthikeyan Mitran and Hou Zhiqiang for Mobiveil PCI

Tyrel Datwyler (2):
      PCI: rpadlpar: Fix leaked device_node references in add/remove paths
      PCI: rpaphp: Get/put device node reference during slot alloc/dealloc

Vidya Sagar (1):
      PCI: tegra: Use the DMA-API to get the MSI address

Wen Yang (7):
      PCI: dwc: pci-dra7xx: Fix a leaked reference by adding missing of_node_put()
      PCI: uniphier: Fix a leaked reference by adding missing of_node_put()
      PCI: dwc: layerscape: Fix a leaked reference by adding missing of_node_put()
      PCI: rockchip: Fix a leaked reference by adding missing of_node_put()
      PCI: aardvark: Fix a leaked reference by adding missing of_node_put()
      PCI: iproc: Fix a leaked reference by adding missing of_node_put()
      PCI: mediatek: Fix a leaked reference by adding missing of_node_put()

Wenwen Wang (1):
      x86/PCI: Fix PCI IRQ routing table memory leak

Wesley Sheng (2):
      switchtec: Increase PFF limit from 48 to 255
      switchtec: Fix unintended mask of MRPC event

Wolfram Sang (1):
      PCI: rcar: Do not shadow the 'irq' variable

 .../devicetree/bindings/pci/designware-pcie.txt    |   7 +-
 .../devicetree/bindings/pci/pci-keystone.txt       |  58 +-
 Documentation/devicetree/bindings/pci/pci.txt      |  50 ++
 MAINTAINERS                                        |   9 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   2 -
 arch/powerpc/platforms/powernv/npu-dma.c           |  14 +-
 arch/x86/pci/irq.c                                 |  10 +-
 drivers/acpi/pci_mcfg.c                            |  12 +
 drivers/acpi/pci_root.c                            |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   3 +-
 drivers/iommu/amd_iommu.c                          |   2 +-
 drivers/iommu/dma-iommu.c                          |  35 +-
 drivers/iommu/intel-iommu.c                        |   2 +-
 drivers/iommu/intel_irq_remapping.c                |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  18 +
 drivers/net/ethernet/realtek/r8169.c               |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   2 +-
 drivers/pci/Makefile                               |   2 +-
 drivers/pci/bus.c                                  |   5 +-
 drivers/pci/controller/dwc/Kconfig                 |  29 +-
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 144 ++--
 drivers/pci/controller/dwc/pci-keystone.c          | 926 +++++++++++++++------
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   2 +-
 drivers/pci/controller/dwc/pci-layerscape.c        |   1 +
 drivers/pci/controller/dwc/pcie-al.c               |  93 +++
 drivers/pci/controller/dwc/pcie-artpec6.c          |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  55 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 157 ++--
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  64 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  26 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  23 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         |  11 +-
 drivers/pci/controller/pci-aardvark.c              |  13 +-
 drivers/pci/controller/pci-host-generic.c          |   2 +-
 drivers/pci/controller/pci-hyperv.c                |  23 +
 drivers/pci/controller/pci-tegra.c                 |  37 +-
 drivers/pci/controller/pcie-iproc-msi.c            |   2 +-
 drivers/pci/controller/pcie-iproc.c                |  98 ++-
 drivers/pci/controller/pcie-mediatek.c             |  51 +-
 drivers/pci/controller/pcie-rcar.c                 |  85 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   2 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   1 +
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/pcie-xilinx.c               |  12 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  10 +-
 drivers/pci/endpoint/pci-epf-core.c                |  10 +-
 drivers/pci/hotplug/pciehp.h                       |  31 +-
 drivers/pci/hotplug/pciehp_core.c                  |  18 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   2 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  17 +-
 drivers/pci/hotplug/pciehp_pci.c                   |   2 +
 drivers/pci/hotplug/rpadlpar_core.c                |   4 +
 drivers/pci/hotplug/rpaphp_slot.c                  |   3 +-
 drivers/pci/msi.c                                  |   6 +-
 drivers/pci/of.c                                   |  58 +-
 drivers/pci/p2pdma.c                               |  38 +-
 drivers/pci/pci-acpi.c                             | 183 ++--
 drivers/pci/pci-stub.c                             |  10 +-
 drivers/pci/pci-sysfs.c                            |   3 +-
 drivers/pci/pci.c                                  | 344 ++++----
 drivers/pci/pci.h                                  |   2 +-
 drivers/pci/pcie/aer.c                             |  30 +-
 drivers/pci/pcie/aer_inject.c                      |  20 +-
 drivers/pci/pcie/aspm.c                            |  47 +-
 drivers/pci/pcie/bw_notification.c                 |  14 +
 drivers/pci/pcie/dpc.c                             |  37 +-
 drivers/pci/pcie/pme.c                             |  10 +-
 drivers/pci/probe.c                                | 230 ++++-
 drivers/pci/proc.c                                 |   1 +
 drivers/pci/quirks.c                               |  92 +-
 drivers/pci/search.c                               |  10 +-
 drivers/pci/setup-bus.c                            | 526 ++++++------
 drivers/pci/slot.c                                 |   2 +-
 drivers/pci/switch/switchtec.c                     |  42 +-
 drivers/pci/xen-pcifront.c                         |   9 +-
 drivers/platform/chrome/chromeos_laptop.c          |   2 +-
 include/linux/acpi.h                               |   3 +-
 include/linux/cper.h                               | 336 ++++----
 include/linux/msi.h                                |  18 -
 include/linux/pci-ecam.h                           |   1 +
 include/linux/pci-epc.h                            |   2 +
 include/linux/pci-epf.h                            |   3 +-
 include/linux/pci.h                                |   9 +-
 include/linux/pci_hotplug.h                        |  66 +-
 include/linux/switchtec.h                          |   2 +-
 include/uapi/linux/pci_regs.h                      | 138 +--
 include/uapi/linux/switchtec_ioctl.h               |  13 +-
 tools/pci/Makefile                                 |   8 +-
 tools/pci/pcitest.c                                |   8 +-
 92 files changed, 2911 insertions(+), 1621 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-al.c
