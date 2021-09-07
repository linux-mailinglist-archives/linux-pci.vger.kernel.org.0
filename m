Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E005440305C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhIGVkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 17:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhIGVkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 17:40:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F63A61100;
        Tue,  7 Sep 2021 21:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631050784;
        bh=Lu7Xp3hmRjwGl2SPgWLc6Aj62QQIf8UW8mVtX9gyvm8=;
        h=Date:From:To:Cc:Subject:From;
        b=jVBT+QmLc9zkX7h02LXj61ZTeDusCnUZOkgEyVEJ7BZBzVSj8z8H+Ysv67AG0v+fr
         VD4FVeMWgX7rTO+a99CsncSYhGccrYydiYGmd0n2boEvAS2OFni0yQmP7l7RcJdR5B
         wxhRJwBLprJknPMvh14JEUA/CHsa0teuIH/EduLJpoGvw+oFFkdvLAGD8oMhcQBBO7
         HYzfp9e3w9sJbqoiAxv/Uf60BPRFz+zr8288hRDXtlnCEBo7otupHO63iPFuzQIa1C
         CyySHEN/hURuaErHAcDlJhHXm1cCld5n/JKgUTrX/FJdVEUSo/sJulIkaqXvYm14GH
         kkqv6D5T4tjog==
Date:   Tue, 7 Sep 2021 16:39:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.15
Message-ID: <20210907213943.GA822380@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.15-changes

for you to fetch changes up to 742a4c49a82a8fe1369e4ec2af4a9bf69123cb88:

  Merge branch 'remotes/lorenzo/pci/tools' (2021-09-02 14:56:52 -0500)

----------------------------------------------------------------

You should see a few conflicts:

  drivers/net/ethernet/broadcom/bnxt/bnxt.c
  drivers/net/ethernet/broadcom/bnx2.c
    Fallout from the VPD changes below.  These include both PCI core and
    driver changes, and the driver changes got merged via the net tree and
    then reverted so everything would be merged via the PCI tree.

  MAINTAINERS
    Should be trivial.

----------------------------------------------------------------

Enumeration:
  - Convert controller drivers to generic_handle_domain_irq() (Marc
    Zyngier)
  - Simplify VPD (Vital Product Data) access and search (Heiner Kallweit)
  - Update bnx2, bnx2x, bnxt, cxgb4, cxlflash, sfc, tg3 drivers to use
    simplified VPD interfaces (Heiner Kallweit)
  - Run Max Payload Size quirks before configuring MPS; work around ASMedia
    ASM1062 SATA MPS issue (Marek Behún)

Resource management:
  - Refactor pci_ioremap_bar() and pci_ioremap_wc_bar() (Krzysztof
    Wilczyński)
  - Optimize pci_resource_len() to reduce kernel size (Zhen Lei)

PCI device hotplug:
  - Fix a double unmap in ibmphp (Vishal Aslot)

PCIe port driver:
  - Enable Bandwidth Notification only if port supports it (Stuart Hayes)

Sysfs/proc/syscalls:
  - Add schedule point in proc_bus_pci_read() (Krzysztof Wilczyński)
  - Return ~0 data on pciconfig_read() CAP_SYS_ADMIN failure (Krzysztof
    Wilczyński)
  - Return "int" from pciconfig_read() syscall (Krzysztof Wilczyński)

Virtualization:
  - Extend "pci=noats" to also turn on Translation Blocking to protect
    against some DMA attacks (Alex Williamson)
  - Add sysfs mechanism to control the type of reset used between device
    assignments to VMs (Amey Narkhede)
  - Add support for ACPI _RST reset method (Shanker Donthineni)
  - Add ACS quirks for Cavium multi-function devices (George Cherian)
  - Add ACS quirks for NXP LX2xx0 and LX2xx2 platforms (Wasim Khan)
  - Allow HiSilicon AMBA devices that appear as fake PCI devices to use
    PASID and SVA (Zhangfei Gao)

Endpoint framework:
  - Add support for SR-IOV Endpoint devices (Kishon Vijay Abraham I)
  - Zero-initialize endpoint test tool parameters so we don't use random
    parameters (Shunyong Yang)

APM X-Gene PCIe controller driver:
  - Remove redundant dev_err() call in xgene_msi_probe() (ErKun Yang)

Broadcom iProc PCIe controller driver:
  - Don't fail devm_pci_alloc_host_bridge() on missing 'ranges' because
    it's optional on BCMA devices (Rob Herring)
  - Fix BCMA probe resource handling (Rob Herring)

Cadence PCIe driver:
  - Work around J7200 Link training electrical issue by increasing delays
    in LTSSM (Nadeem Athani)

Intel IXP4xx PCI controller driver:
  - Depend on ARCH_IXP4XX to avoid useless config questions (Geert
    Uytterhoeven)

Intel Keembay PCIe controller driver:
  - Add Intel Keem Bay PCIe controller (Srikanth Thokala)

Marvell Aardvark PCIe controller driver:
  - Work around config space completion handling issues (Evan Wang)
  - Increase timeout for config access completions (Pali Rohár)
  - Emulate CRS Software Visibility bit (Pali Rohár)
  - Configure resources from DT 'ranges' property to fix I/O space access
    (Pali Rohár)
  - Serialize INTx mask/unmask (Pali Rohár)

MediaTek PCIe controller driver:
  - Add MT7629 support in DT (Chuanjia Liu)
  - Fix an MSI issue (Chuanjia Liu)
  - Get syscon regmap ("mediatek,generic-pciecfg"), IRQ number ("pci_irq"),
    PCI domain ("linux,pci-domain") from DT properties if present (Chuanjia
    Liu)

Microsoft Hyper-V host bridge driver:
  - Add ARM64 support (Boqun Feng)
  - Support "Create Interrupt v3" message (Sunil Muthuswamy)

NVIDIA Tegra PCIe controller driver:
  - Use seq_puts(), move err_msg from stack to static, fix OF node leak
    (Christophe JAILLET)

NVIDIA Tegra194 PCIe driver:
  - Disable suspend when in Endpoint mode (Om Prakash Singh)
  - Fix MSI-X address programming error (Om Prakash Singh)
  - Disable interrupts during suspend to avoid spurious AER link down (Om
    Prakash Singh)

Renesas R-Car PCIe controller driver:
  - Work around hardware issue that prevents Link L1->L0 transition (Marek
    Vasut)
  - Fix runtime PM refcount leak (Dinghao Liu)

Rockchip DesignWare PCIe controller driver:
  - Add Rockchip RK356X host controller driver (Simon Xue)

TI J721E PCIe driver:
  - Add support for J7200 and AM64 (Kishon Vijay Abraham I)

Toshiba Visconti PCIe controller driver:
  - Add Toshiba Visconti PCIe host controller driver (Nobuhiro Iwamatsu)

Xilinx NWL PCIe controller driver:
  - Enable PCIe reference clock via CCF (Hyun Kwon)

Miscellaneous:
  - Convert sta2x11 from 'pci_' to 'dma_' API (Christophe JAILLET)
  - Fix pci_dev_str_match_path() alloc while atomic bug (used for kernel
    parameters that specify devices) (Dan Carpenter)
  - Remove pointless Precision Time Management warning when PTM is present
    but not enabled (Jakub Kicinski)
  - Remove surplus "break" statements (Krzysztof Wilczyński)

----------------------------------------------------------------
Alex Williamson (1):
      PCI/ACS: Enforce pci=noats with Transaction Blocking

Amey Narkhede (6):
      PCI: Cache PCIe Device Capabilities register
      PCI: Add pcie_reset_flr() with 'probe' argument
      PCI: Add array to track reset method ordering
      PCI: Remove reset_fn field from pci_dev
      PCI: Allow userspace to query and set device reset mechanism
      PCI: Change the type of probe argument in reset functions

Andy Shevchenko (1):
      PCI: Sync __pci_register_driver() stub for CONFIG_PCI=n

Arnd Bergmann (1):
      PCI: hv: Generify PCI probing

Bjorn Helgaas (35):
      PCI/VPD: Correct diagnostic for VPD read failure
      PCI/VPD: Check Resource Item Names against those valid for type
      PCI/VPD: Reject resource tags with invalid size
      PCI/VPD: Don't check Large Resource Item Names for validity
      PCI/VPD: Allow access to valid parts of VPD if some is invalid
      PCI: Make saved capability state private to core
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/iommu'
      Merge branch 'pci/irq'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/vpd'
      Merge branch 'pci/misc'
      Merge branch 'pci/artpec6'
      Merge branch 'pci/dwc'
      Merge branch 'pci/rockchip-dwc'
      Merge branch 'pci/visconti'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/hyper-v'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/keembay'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/tegra194'
      Merge branch 'remotes/lorenzo/pci/xgene'
      Merge branch 'remotes/lorenzo/pci/xilinx-nwl'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'remotes/lorenzo/pci/tools'

Boqun Feng (7):
      PCI: Introduce domain_nr in pci_host_bridge
      PCI: Support populating MSI domains of root buses via bridges
      arm64: PCI: Restructure pcibios_root_bridge_prepare()
      arm64: PCI: Support root bridge preparation for Hyper-V
      PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
      PCI: hv: Set up MSI domain at bridge probing time
      PCI: hv: Turn on the host bridge probing on ARM64

Christophe JAILLET (4):
      PCI: tegra: Fix OF node reference leak
      PCI: tegra: Use 'seq_puts' instead of 'seq_printf'
      PCI: tegra: make const array err_msg static
      x86/PCI: sta2x11: switch from 'pci_' to 'dma_' API

Chuanjia Liu (4):
      dt-bindings: PCI: mediatek: Update the Device tree bindings
      PCI: mediatek: Add new method to get shared pcie-cfg base address
      PCI: mediatek: Add new method to get irq number
      PCI: mediatek: Use PCI domain to handle ports detection

Dan Carpenter (1):
      PCI: Fix pci_dev_str_match_path() alloc while atomic bug

Dinghao Liu (1):
      PCI: rcar: Fix runtime PM imbalance in rcar_pcie_ep_probe()

ErKun Yang (1):
      PCI: xgene-msi: Remove redundant dev_err() call in xgene_msi_probe()

Evan Wang (1):
      PCI: aardvark: Fix checking for PIO status

Geert Uytterhoeven (1):
      PCI: controller: PCI_IXP4XX should depend on ARCH_IXP4XX

George Cherian (1):
      PCI: Add ACS quirks for Cavium multi-function devices

Heiner Kallweit (37):
      PCI/VPD: Treat initial 0xff as missing EEPROM
      PCI/VPD: Remove pci_vpd_size() old_size argument
      PCI/VPD: Make pci_vpd_wait() uninterruptible
      PCI/VPD: Remove struct pci_vpd.flag
      PCI/VPD: Reorder pci_read_vpd(), pci_write_vpd()
      PCI/VPD: Remove struct pci_vpd_ops
      PCI/VPD: Remove struct pci_vpd.valid member
      PCI/VPD: Embed struct pci_vpd in struct pci_dev
      PCI/VPD: Determine VPD size in pci_vpd_init()
      PCI/VPD: Treat invalid VPD like missing VPD capability
      PCI/VPD: Add pci_vpd_alloc()
      PCI/VPD: Add pci_vpd_find_ro_info_keyword()
      PCI/VPD: Add pci_vpd_check_csum()
      sfc: Read VPD with pci_vpd_alloc()
      sfc: Search VPD with pci_vpd_find_ro_info_keyword()
      tg3: Read VPD with pci_vpd_alloc()
      tg3: Validate VPD checksum with pci_vpd_check_csum()
      tg3: Search VPD with pci_vpd_find_ro_info_keyword()
      sfc: falcon: Read VPD with pci_vpd_alloc()
      sfc: falcon: Search VPD with pci_vpd_find_ro_info_keyword()
      bnx2: Search VPD with pci_vpd_find_ro_info_keyword()
      bnx2: Replace open-coded byte swapping with swab32s()
      bnx2x: Read VPD with pci_vpd_alloc()
      bnx2x: Search VPD with pci_vpd_find_ro_info_keyword()
      bnxt: Read VPD with pci_vpd_alloc()
      bnxt: Search VPD with pci_vpd_find_ro_info_keyword()
      cxgb4: Validate VPD checksum with pci_vpd_check_csum()
      cxgb4: Remove unused vpd_param member ec
      cxgb4: Search VPD with pci_vpd_find_ro_info_keyword()
      scsi: cxlflash: Search VPD with pci_vpd_find_ro_info_keyword()
      PCI/VPD: Stop exporting pci_vpd_find_tag()
      PCI/VPD: Stop exporting pci_vpd_find_info_keyword()
      PCI/VPD: Include post-processing in pci_vpd_find_tag()
      PCI/VPD: Add pci_vpd_find_id_string()
      cxgb4: Use pci_vpd_find_id_string() to find VPD ID string
      PCI/VPD: Clean up public VPD defines and inline functions
      PCI/VPD: Use unaligned access helpers

Hyun Kwon (1):
      PCI: xilinx-nwl: Enable the clock through CCF

Jakub Kicinski (1):
      PCI/PTM: Remove error message at boot

Jonathan Cameron (1):
      PCI: Correct the pci_iomap.h header guard #endif comment

Kishon Vijay Abraham I (12):
      dt-bindings: PCI: pci-ep: Add binding to specify virtual function
      PCI: endpoint: Add support to add virtual function in endpoint core
      PCI: endpoint: Add support to link a physical function to a virtual function
      PCI: endpoint: Add virtual function number in pci_epc ops
      PCI: cadence: Simplify code to get register base address for configuring BAR
      PCI: cadence: Add support to configure virtual functions
      misc: pci_endpoint_test: Populate sriov_configure ops to configure SR-IOV device
      Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV
      PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
      PCI: j721e: Add PCIe support for J7200
      PCI: j721e: Add PCIe support for AM64
      misc: pci_endpoint_test: Add deviceID for AM64 and J7200

Krzysztof Wilczyński (9):
      PCI: Refactor pci_ioremap_bar() and pci_ioremap_wc_bar()
      PCI: tegra: Remove unused struct tegra_pcie_bus
      PCI: Return ~0 data on pciconfig_read() CAP_SYS_ADMIN failure
      PCI: Return int from pciconfig_read() syscall
      x86/PCI: Add pci_numachip_init() declaration
      PCI: Add schedule point in proc_bus_pci_read()
      PCI: artpec6: Remove surplus break statement after return
      PCI: artpec6: Remove local code block from switch statement
      PCI: dwc: Remove surplus break statement after return

Marc Zyngier (1):
      PCI: Bulk conversion to generic_handle_domain_irq()

Marek Behún (2):
      PCI: Call Max Payload Size-related fixup quirks early
      PCI: Restrict ASMedia ASM1062 SATA Max Payload Size Supported

Marek Vasut (1):
      PCI: rcar: Add L1 link state fix into data abort hook

Michal Simek (1):
      dt-bindings: pci: xilinx-nwl: Document optional clock property

Nadeem Athani (1):
      PCI: cadence: Add quirk flag to set minimum delay in LTSSM Detect.Quiet state

Nobuhiro Iwamatsu (2):
      PCI: visconti: Add Toshiba Visconti PCIe host controller driver
      MAINTAINERS: Add entries for Toshiba Visconti PCIe controller

Om Prakash Singh (5):
      PCI: tegra194: Fix handling BME_CHGED event
      PCI: tegra194: Fix MSI-X programming
      PCI: tegra194: Disable interrupts before entering L2
      PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode
      PCI: tegra194: Cleanup unused code

Pali Rohár (5):
      PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO response
      PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
      PCI: aardvark: Fix reporting CRS value
      PCI: aardvark: Configure PCIe resources from 'ranges' DT property
      PCI: aardvark: Fix masking and unmasking legacy INTx interrupts

Rob Herring (2):
      PCI: of: Don't fail devm_pci_alloc_host_bridge() on missing 'ranges'
      PCI: iproc: Fix BCMA probe resource handling

Shanker Donthineni (4):
      PCI: Add pci_set_acpi_fwnode() to set ACPI_COMPANION
      PCI: Use acpi_pci_power_manageable()
      PCI: Setup ACPI fwnode early and at the same time with OF
      PCI: Add support for ACPI _RST reset method

Shunyong Yang (1):
      tools: PCI: Zero-initialize param

Simon Xue (1):
      PCI: rockchip-dwc: Add Rockchip RK356X host controller driver

Srikanth Thokala (2):
      dt-bindings: PCI: Add Intel Keem Bay PCIe controller
      PCI: keembay: Add support for Intel Keem Bay

Stuart Hayes (1):
      PCI/portdrv: Enable Bandwidth Notification only if port supports it

Sunil Muthuswamy (1):
      PCI: hv: Support for create interrupt v3

Vishal Aslot (1):
      PCI: ibmphp: Fix double unmap of io_mem

Wasim Khan (1):
      PCI: Add ACS quirks for NXP LX2xx0 and LX2xx2 platforms

Zhangfei Gao (2):
      PCI: Allow PASID on fake PCIe devices without TLP prefixes
      PCI: Set dma-can-stall for HiSilicon chips

Zhen Lei (1):
      PCI: Optimize pci_resource_len() to reduce kernel size

 Documentation/ABI/testing/sysfs-bus-pci            |  17 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst    |  12 +-
 .../bindings/pci/intel,keembay-pcie-ep.yaml        |  69 +++
 .../bindings/pci/intel,keembay-pcie.yaml           |  97 ++++
 .../devicetree/bindings/pci/mediatek-pcie-cfg.yaml |  39 ++
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 208 +++++----
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |   7 +
 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   1 +
 MAINTAINERS                                        |   9 +
 arch/arm64/kernel/pci.c                            |  31 +-
 arch/x86/pci/numachip.c                            |   1 +
 arch/x86/pci/sta2x11-fixup.c                       |   3 +-
 drivers/crypto/cavium/nitrox/nitrox_main.c         |   4 +-
 drivers/misc/pci_endpoint_test.c                   |   9 +
 drivers/net/ethernet/broadcom/bnx2.c               |  46 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   1 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  89 +---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  49 +-
 drivers/net/ethernet/broadcom/tg3.c                | 115 ++---
 drivers/net/ethernet/broadcom/tg3.h                |   1 -
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 -
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |  85 ++--
 drivers/net/ethernet/sfc/efx.c                     |  82 +---
 drivers/net/ethernet/sfc/falcon/efx.c              |  83 +---
 drivers/pci/ats.c                                  |   2 +-
 drivers/pci/controller/Kconfig                     |   1 +
 drivers/pci/controller/cadence/pci-j721e.c         |  61 ++-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 200 ++++++---
 drivers/pci/controller/cadence/pcie-cadence-host.c |   3 +
 drivers/pci/controller/cadence/pcie-cadence.c      |  16 +
 drivers/pci/controller/cadence/pcie-cadence.h      |  29 +-
 drivers/pci/controller/dwc/Kconfig                 |  48 ++
 drivers/pci/controller/dwc/Makefile                |   3 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |  16 +-
 drivers/pci/controller/dwc/pci-keystone.c          |  14 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   7 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  36 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   9 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   1 -
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 279 ++++++++++++
 drivers/pci/controller/dwc/pcie-keembay.c          | 460 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c         |  54 ++-
 drivers/pci/controller/dwc/pcie-uniphier.c         |   8 +-
 drivers/pci/controller/dwc/pcie-visconti.c         | 332 ++++++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |  15 +-
 drivers/pci/controller/pci-aardvark.c              | 334 +++++++++++++-
 drivers/pci/controller/pci-ftpci100.c              |   2 +-
 drivers/pci/controller/pci-hyperv.c                | 153 +++++--
 drivers/pci/controller/pci-tegra.c                 |  38 +-
 drivers/pci/controller/pci-xgene-msi.c             |  10 +-
 drivers/pci/controller/pcie-altera-msi.c           |  10 +-
 drivers/pci/controller/pcie-altera.c               |  10 +-
 drivers/pci/controller/pcie-brcmstb.c              |   9 +-
 drivers/pci/controller/pcie-iproc-bcma.c           |  18 +-
 drivers/pci/controller/pcie-iproc-msi.c            |   4 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  13 +-
 drivers/pci/controller/pcie-mediatek.c             |  64 ++-
 drivers/pci/controller/pcie-microchip-host.c       |  18 +-
 drivers/pci/controller/pcie-rcar-ep.c              |  23 +-
 drivers/pci/controller/pcie-rcar-host.c            |  94 +++-
 drivers/pci/controller/pcie-rcar.h                 |   7 +
 drivers/pci/controller/pcie-rockchip-ep.c          |  18 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   8 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |   4 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  25 +-
 drivers/pci/controller/pcie-xilinx.c               |   9 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |  89 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c      |  74 +--
 drivers/pci/endpoint/pci-ep-cfs.c                  |  24 +
 drivers/pci/endpoint/pci-epc-core.c                | 134 ++++--
 drivers/pci/endpoint/pci-epf-core.c                | 146 +++++-
 drivers/pci/hotplug/TODO                           |   3 -
 drivers/pci/hotplug/ibmphp_ebda.c                  |   5 +-
 drivers/pci/hotplug/pciehp.h                       |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   2 +-
 drivers/pci/hotplug/pnv_php.c                      |   2 +-
 drivers/pci/of.c                                   |   2 +-
 drivers/pci/pci-acpi.c                             |  85 ++--
 drivers/pci/pci-bridge-emul.h                      |   2 +-
 drivers/pci/pci-sysfs.c                            |   3 +-
 drivers/pci/pci.c                                  | 331 ++++++++++----
 drivers/pci/pci.h                                  |  47 +-
 drivers/pci/pcie/aer.c                             |  12 +-
 drivers/pci/pcie/portdrv_core.c                    |   9 +-
 drivers/pci/pcie/ptm.c                             |   4 +-
 drivers/pci/probe.c                                |  29 +-
 drivers/pci/proc.c                                 |   1 +
 drivers/pci/quirks.c                               | 128 +++++-
 drivers/pci/remove.c                               |   1 -
 drivers/pci/syscall.c                              |   7 +-
 drivers/pci/vpd.c                                  | 500 +++++++++++----------
 drivers/scsi/cxlflash/main.c                       |  34 +-
 include/asm-generic/pci_iomap.h                    |   2 +-
 include/linux/pci-epc.h                            |  57 +--
 include/linux/pci-epf.h                            |  16 +-
 include/linux/pci.h                                | 165 +++----
 include/linux/pci_hotplug.h                        |   2 +-
 include/linux/pci_ids.h                            |   3 +-
 tools/pci/pcitest.c                                |   2 +-
 100 files changed, 3878 insertions(+), 1572 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
 create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c
 create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
