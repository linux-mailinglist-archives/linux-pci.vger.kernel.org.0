Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5023F4BD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Aug 2020 00:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGWE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 18:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGWE4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 18:04:56 -0400
Received: from localhost (130.sub-72-107-113.myvzw.com [72.107.113.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B31214F1;
        Fri,  7 Aug 2020 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596837894;
        bh=/F+8Mv7V8RgL5ifvHgNT5FqvVQI5mqpo0AjD4mlEnoU=;
        h=Date:From:To:Cc:Subject:From;
        b=M4VEOQ9DfxQELh3aaSwT2FVccPsb93gCmsPPDLqckpXjVbkaIz4b6fo9fLJKcbXJj
         9OLIE2oQpM685kqVdMqtrBkef+OEIHe6qwbBYY9+cjbkRPYUc5qZCP16BvLHXOL5Cv
         gBWjcRojytpw32ZOEBuGxCnFfK9pvx0sAaRtRlmI=
Date:   Fri, 7 Aug 2020 17:04:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.9
Message-ID: <20200807220453.GA778258@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-changes

for you to fetch changes up to 6f119ec8d9c8f68c0432d902312045a699c3e52a:

  Merge branch 'pci/irq-error' (2020-08-05 18:24:22 -0500)


You should see a conflict in drivers/net/ethernet/sfc/efx.c:

  - 16d79cd4e23b ("PCI: Use 'pci_channel_state_t' instead of 'enum
    pci_channel_state'") from my tree changed the interface of
    efx_io_error_detected()

  - 21ea21252edd ("sfc: commonise PCI error handlers") from the net tree
    moved efx_io_error_detected() to drivers/net/ethernet/sfc/efx_common.c

It's trivial, but my resolution is at
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v5.9-merge
and the diff from the merge commit is basically this:

  --- a/drivers/net/ethernet/sfc/efx_common.c
  +++ b/drivers/net/ethernet/sfc/efx_common.c
  ...
   +static pci_ers_result_t efx_io_error_detected(struct pci_dev *pdev,
  -                                             enum pci_channel_state state)
  ++                                            pci_channel_state_t state)
   +{

----------------------------------------------------------------

Enumeration:

  - Fix pci_cfg_wait queue locking problem (Bjorn Helgaas)

  - Convert PCIe capability PCIBIOS errors to errno (Bolarinwa Olayemi
    Saheed)

  - Align PCIe capability and PCI accessor return values (Bolarinwa Olayemi
    Saheed)

  - Fix pci_create_slot() reference count leak (Qiushi Wu)

  - Announce device after early fixups (Tiezhu Yang)

PCI device hotplug:

  - Make rpadlpar functions static (Wei Yongjun)

Driver binding:

  - Add device even if driver attach failed (Rajat Jain)

Virtualization:

  - xen: Remove redundant initialization of irq (Colin Ian King)

IOMMU:

  - Add pci_pri_supported() to check device or associated PF (Ashok Raj)

  - Release IVRS table in AMD ACS quirk (Hanjun Guo)

  - Mark AMD Navi10 GPU rev 0x00 ATS as broken (Kai-Heng Feng)

  - Treat "external-facing" devices themselves as internal (Rajat Jain)

MSI:

  - Forward MSI-X error code in pci_alloc_irq_vectors_affinity() (Piotr
    Stankiewicz)

Error handling:

  - Clear PCIe Device Status errors only if OS owns AER (Jonathan Cameron)

  - Log correctable errors as warning, not error (Matt Jolly)

  - Use 'pci_channel_state_t' instead of 'enum pci_channel_state' (Luc Van
    Oostenryck)

Peer-to-peer DMA:

  - Allow P2PDMA on AMD Zen and newer CPUs (Logan Gunthorpe)

ASPM:

  - Add missing newline in sysfs 'policy' (Xiongfeng Wang)

Native PCIe controllers:

  - Convert to devm_platform_ioremap_resource_byname() (Dejin Zheng)

  - Convert to devm_platform_ioremap_resource() (Dejin Zheng)

  - Remove duplicate error message from devm_pci_remap_cfg_resource()
    callers (Dejin Zheng)

  - Fix runtime PM imbalance on error (Dinghao Liu)

  - Remove dev_err() when handing an error from platform_get_irq()
    (Krzysztof Wilczyński)

  - Use pci_host_bridge.windows list directly instead of splicing in a
    temporary list for cadence, mvebu, host-common (Rob Herring)

  - Use pci_host_probe() instead of open-coding all the pieces for altera,
    brcmstb, iproc, mobiveil, rcar, rockchip, tegra, v3, versatile, xgene,
    xilinx, xilinx-nwl (Rob Herring)

  - Default host bridge parent device to the platform device (Rob Herring)

  - Use pci_is_root_bus() instead of tracking root bus number separately in
    aardvark, designware (imx6, keystone, designware-host), mobiveil,
    xilinx-nwl, xilinx, rockchip, rcar (Rob Herring)

  - Set host bridge bus number in pci_scan_root_bus_bridge() instead of
    each driver for aardvark, designware-host, host-common, mediatek, rcar,
    tegra, v3-semi (Rob Herring)

  - Move DT resource setup into devm_pci_alloc_host_bridge() (Rob Herring)

  - Set bridge map_irq and swizzle_irq to default functions; drivers that
    don't support legacy IRQs (iproc) need to undo this (Rob Herring)

ARM Versatile PCIe controller driver:

  - Drop flag PCI_ENABLE_PROC_DOMAINS (Rob Herring)

Cadence PCIe controller driver:

  - Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property (Kishon
    Vijay Abraham I)

  - Remove "mem" from reg binding (Kishon Vijay Abraham I)

  - Fix cdns_pcie_{host|ep}_setup() error path (Kishon Vijay Abraham I)

  - Convert all r/w accessors to perform only 32-bit accesses (Kishon Vijay
    Abraham I)

  - Add support to start link and verify link status (Kishon Vijay Abraham
    I)

  - Allow pci_host_bridge to have custom pci_ops (Kishon Vijay Abraham I)

  - Add new *ops* for CPU addr fixup (Kishon Vijay Abraham I)

  - Fix updating Vendor ID and Subsystem Vendor ID register (Kishon Vijay
    Abraham I)

  - Use bridge resources for outbound window setup (Rob Herring)

  - Remove private bus number and range storage (Rob Herring)

Cadence PCIe endpoint driver:

  - Add MSI-X support (Alan Douglas)

HiSilicon PCIe controller driver:

  - Remove non-ECAM HiSilicon hip05/hip06 driver (Rob Herring)

Intel VMD host bridge driver:

  - Use Shadow MEMBAR registers for QEMU/KVM guests (Jon Derrick)

Loongson PCIe controller driver:

  - Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk() (Tiezhu Yang)

Marvell Aardvark PCIe controller driver:

  - Indicate error in 'val' when config read fails (Pali Rohár)

  - Don't touch PCIe registers if no card connected (Pali Rohár)

Marvell MVEBU PCIe controller driver:

  - Setup BAR0 in order to fix MSI (Shmuel Hazan)

Microsoft Hyper-V host bridge driver:

  - Fix a timing issue which causes kdump to fail occasionally (Wei Hu)

  - Make some functions static (Wei Yongjun)

NVIDIA Tegra PCIe controller driver:

  - Revert tegra124 raw_violation_fixup (Nicolas Chauvet)

  - Remove PLL power supplies (Thierry Reding)

Qualcomm PCIe controller driver:

  - Change duplicate PCI reset to phy reset (Abhishek Sahu)

  - Add missing ipq806x clocks in PCIe driver (Ansuel Smith)

  - Add missing reset for ipq806x (Ansuel Smith)

  - Add ext reset (Ansuel Smith)

  - Use bulk clk API and assert on error (Ansuel Smith)

  - Add support for tx term offset for rev 2.1.0 (Ansuel Smith)

  - Define some PARF params needed for ipq8064 SoC (Ansuel Smith)

  - Add ipq8064 rev2 variant (Ansuel Smith)

  - Support PCI speed set for ipq806x (Sham Muthayyan)

Renesas R-Car PCIe controller driver:

  - Use devm_pci_alloc_host_bridge() (Rob Herring)

  - Use struct pci_host_bridge.windows list directly (Rob Herring)

  - Convert rcar-gen2 to use modern host bridge probe functions (Rob
    Herring)

TI J721E PCIe driver:

  - Add TI J721E PCIe host and endpoint driver (Kishon Vijay Abraham I)

Xilinx Versal CPM PCIe controller driver:

  - Add Versal CPM Root Port driver and YAML schema (Bharat Kumar Gogada)

MicroSemi Switchtec management driver:

  - Add missing __iomem and __user tags to fix sparse warnings (Logan
    Gunthorpe)

Miscellaneous:

  - Replace http:// links with https:// (Alexander A. Klimov)

  - Replace lkml.org, spinics, gmane with lore.kernel.org (Bjorn Helgaas)

  - Remove unused pci_lost_interrupt() (Heiner Kallweit)

  - Move PCI_VENDOR_ID_REDHAT definition to pci_ids.h (Huacai Chen)

  - Fix kerneldoc warnings (Krzysztof Kozlowski)

----------------------------------------------------------------
Abhishek Sahu (1):
      PCI: qcom: Change duplicate PCI reset to phy reset

Alan Douglas (1):
      PCI: cadence: Add MSI-X support to Endpoint driver

Alexander A. Klimov (1):
      PCI: Replace http:// links with https://

Ansuel Smith (10):
      PCI: qcom: Add missing ipq806x clocks in PCIe driver
      dt-bindings: PCI: qcom: Add missing clks
      PCI: qcom: Add missing reset for ipq806x
      dt-bindings: PCI: qcom: Add ext reset
      PCI: qcom: Use bulk clk api and assert on error
      PCI: qcom: Define some PARF params needed for ipq8064 SoC
      PCI: qcom: Add support for tx term offset for rev 2.1.0
      PCI: qcom: Add ipq8064 rev2 variant
      dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
      PCI: qcom: Replace define with standard value

Ashok Raj (1):
      PCI/ATS: Add pci_pri_supported() to check device or associated PF

Bharat Kumar Gogada (2):
      PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
      PCI: xilinx-cpm: Add Versal CPM Root Port driver

Bjorn Helgaas (26):
      PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
      PCI: Fix pci_cfg_wait queue locking problem
      PCI/AER: Simplify __aer_print_error()
      PCI/ERR: Rename pci_aer_clear_device_status() to pcie_clear_device_status()
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/error'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/peer-to-peer'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/switchtec'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/loongson'
      Merge branch 'remotes/lorenzo/pci/mvebu'
      Merge branch 'remotes/lorenzo/pci/runtime-pm'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'pci/xilinx-cpm'
      Merge branch 'pci/host-probe-refactor'
      Merge branch 'pci/doc'
      Merge branch 'pci/irq-error'

Bolarinwa Olayemi Saheed (2):
      PCI: Convert PCIe capability PCIBIOS errors to errno
      PCI: Align PCIe capability and PCI accessor return values

Colin Ian King (1):
      xen: Remove redundant initialization of irq

Dejin Zheng (4):
      PCI: controller: Convert to devm_platform_ioremap_resource_byname()
      PCI: controller: Convert to devm_platform_ioremap_resource()
      PCI: dwc: Convert to devm_platform_ioremap_resource_byname()
      PCI: controller: Remove duplicate error message

Dinghao Liu (4):
      PCI: dwc: pci-dra7xx: Fix runtime PM imbalance on error
      PCI: cadence: Fix runtime PM imbalance on error
      PCI: qcom: Fix runtime PM imbalance on error
      PCI: rcar: Fix runtime PM imbalance on error

Hanjun Guo (1):
      PCI: Release IVRS table in AMD ACS quirk

Heiner Kallweit (1):
      PCI: Remove unused pci_lost_interrupt()

Huacai Chen (1):
      PCI: Move PCI_VENDOR_ID_REDHAT definition to pci_ids.h

Jon Derrick (1):
      PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

Jonathan Cameron (1):
      PCI/ERR: Clear PCIe Device Status errors only if OS owns AER

Kai-Heng Feng (1):
      PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken

Kishon Vijay Abraham I (14):
      PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits" property
      PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path
      linux/kernel.h: Add PTR_ALIGN_DOWN macro
      PCI: cadence: Convert all r/w accessors to perform only 32-bit accesses
      PCI: cadence: Add support to start link and verify link status
      PCI: cadence: Allow pci_host_bridge to have custom pci_ops
      dt-bindings: PCI: cadence: Remove "mem" from reg binding
      PCI: cadence: Add new *ops* for CPU addr fixup
      PCI: cadence: Fix updating Vendor ID and Subsystem Vendor ID register
      dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC
      dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC
      PCI: j721e: Add TI J721E PCIe driver
      misc: pci_endpoint_test: Add J721E in pci_device_id table
      MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe

Krzysztof Kozlowski (1):
      PCI: Fix kerneldoc warnings

Krzysztof Wilczyński (1):
      PCI: Remove dev_err() when handing an error from platform_get_irq()

Liao Pingfang (1):
      PCI: Fix error in panic message

Logan Gunthorpe (3):
      PCI/P2PDMA: Allow P2PDMA on AMD Zen and newer CPUs
      PCI: switchtec: Add missing __iomem and __user tags to fix sparse warnings
      PCI: switchtec: Add missing __iomem tag to fix sparse warnings

Luc Van Oostenryck (1):
      PCI: Use 'pci_channel_state_t' instead of 'enum pci_channel_state'

Matt Jolly (1):
      PCI/AER: Log correctable errors as warning, not error

Nicolas Chauvet (1):
      PCI: tegra: Revert tegra124 raw_violation_fixup

Pali Rohár (2):
      PCI: aardvark: Indicate error in 'val' when config read fails
      PCI: aardvark: Don't touch PCIe registers if no card connected

Piotr Stankiewicz (1):
      PCI/MSI: Forward MSI-X error code in pci_alloc_irq_vectors_affinity()

Qiushi Wu (1):
      PCI: Fix pci_create_slot() reference count leak

Rajat Jain (4):
      PCI: Add device even if driver attach failed
      PCI: Reorder pci_enable_acs() and dependencies
      PCI: Cache ACS capability offset in device
      PCI: Treat "external-facing" devices themselves as internal

Rob Herring (35):
      PCI: cadence: Use struct pci_host_bridge.windows list directly
      PCI: mvebu: Use struct pci_host_bridge.windows list directly
      PCI: host-common: Use struct pci_host_bridge.windows list directly
      PCI: brcmstb: Use pci_host_probe() to register host
      PCI: mobiveil: Use pci_host_probe() to register host
      PCI: tegra: Use pci_host_probe() to register host
      PCI: v3: Use pci_host_probe() to register host
      PCI: versatile: Use pci_host_probe() to register host
      PCI: xgene: Use pci_host_probe() to register host
      PCI: altera: Use pci_host_probe() to register host
      PCI: iproc: Use pci_host_probe() to register host
      PCI: rcar: Use pci_host_probe() to register host
      PCI: rockchip: Use pci_host_probe() to register host
      PCI: xilinx-nwl: Use pci_host_probe() to register host
      PCI: xilinx: Use pci_host_probe() to register host
      PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
      PCI: Set default bridge parent device
      PCI: Drop unnecessary zeroing of bridge fields
      PCI: aardvark: Use pci_is_root_bus() to check if bus is root bus
      PCI: designware: Use pci_is_root_bus() to check if bus is root bus
      PCI: mobiveil: Use pci_is_root_bus() to check if bus is root bus
      PCI: xilinx-nwl: Use pci_is_root_bus() to check if bus is root bus
      PCI: xilinx: Use pci_is_root_bus() to check if bus is root bus
      PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus
      PCI: rcar: Use pci_is_root_bus() to check if bus is root bus
      PCI: Move setting pci_host_bridge.busnr out of host drivers
      PCI: cadence: Use bridge resources for outbound window setup
      PCI: cadence: Remove private bus number and range storage
      PCI: rcar: Use devm_pci_alloc_host_bridge()
      PCI: rcar: Use struct pci_host_bridge.windows list directly
      PCI: of: Reduce missing non-prefetchable memory region to a warning
      PCI: dwc: hisi: Remove non-ECAM HiSilicon hip05/hip06 driver
      PCI: rcar-gen2: Convert to use modern host bridge probe functions
      PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
      PCI: Set bridge map_irq and swizzle_irq to default functions

Sham Muthayyan (1):
      PCI: qcom: Support pci speed set for ipq806x

Shmuel Hazan (1):
      PCI: mvebu: Setup BAR0 in order to fix MSI

Thierry Reding (2):
      dt-bindings: pci: tegra: Remove PLL power supplies
      PCI: tegra: Remove PLL power supplies

Tiezhu Yang (2):
      PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()
      PCI: Announce device after early fixups

Wei Hu (1):
      PCI: hv: Fix a timing issue which causes kdump to fail occasionally

Wei Yongjun (2):
      PCI: hv: Make some functions static
      PCI: rpadlpar: Make functions static

Xiongfeng Wang (1):
      PCI/ASPM: Add missing newline in sysfs 'policy'

 Documentation/PCI/pci-error-recovery.rst           |   8 +-
 Documentation/PCI/pci.rst                          |   9 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml          |   8 +-
 .../bindings/pci/nvidia,tegra20-pcie.txt           |  12 -
 Documentation/devicetree/bindings/pci/pci.txt      |   4 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          |  15 +-
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |  94 ++++
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 113 ++++
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  99 ++++
 MAINTAINERS                                        |   4 +-
 arch/powerpc/kernel/eeh_driver.c                   |   2 +-
 arch/x86/pci/fixup.c                               |   4 +-
 arch/x86/pci/xen.c                                 |   2 +-
 drivers/block/rsxx/core.c                          |   2 +-
 drivers/dma/ioat/init.c                            |   6 +-
 drivers/gpu/drm/qxl/qxl_dev.h                      |   2 -
 drivers/iommu/intel/iommu.c                        |   8 +-
 drivers/media/pci/ngene/ngene-cards.c              |   2 +-
 drivers/misc/genwqe/card_base.c                    |   2 +-
 drivers/misc/pci_endpoint_test.c                   |   9 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c        |   4 +-
 drivers/net/ethernet/rocker/rocker_hw.h            |   1 -
 drivers/net/ethernet/sfc/efx.c                     |   2 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |   2 +-
 drivers/pci/access.c                               |  16 +-
 drivers/pci/ats.c                                  |  18 +-
 drivers/pci/bus.c                                  |   6 +-
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/cadence/Kconfig             |  23 +
 drivers/pci/controller/cadence/Makefile            |   1 +
 drivers/pci/controller/cadence/pci-j721e.c         | 485 ++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 137 ++++-
 drivers/pci/controller/cadence/pcie-cadence-host.c | 387 ++++++++++---
 drivers/pci/controller/cadence/pcie-cadence-plat.c |  16 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |  17 +-
 drivers/pci/controller/cadence/pcie-cadence.h      | 169 +++++-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  24 +-
 drivers/pci/controller/dwc/pci-exynos.c            |  15 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   8 +-
 drivers/pci/controller/dwc/pci-keystone.c          |  13 +-
 drivers/pci/controller/dwc/pci-meson.c             |   4 +-
 drivers/pci/controller/dwc/pcie-al.c               |  13 +-
 drivers/pci/controller/dwc/pcie-armada8k.c         |   5 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |  16 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  27 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   3 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   3 +-
 drivers/pci/controller/dwc/pcie-hisi.c             | 219 --------
 drivers/pci/controller/dwc/pcie-histb.c            |  11 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |   7 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |  24 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 198 ++++---
 drivers/pci/controller/dwc/pcie-spear13xx.c        |   6 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   4 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         |   3 +-
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c |   5 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c   |  41 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   1 -
 drivers/pci/controller/pci-aardvark.c              |  38 +-
 drivers/pci/controller/pci-ftpci100.c              |  14 +-
 drivers/pci/controller/pci-host-common.c           |  57 +-
 drivers/pci/controller/pci-hyperv.c                |  86 +--
 drivers/pci/controller/pci-loongson.c              |  14 +-
 drivers/pci/controller/pci-mvebu.c                 |  33 +-
 drivers/pci/controller/pci-rcar-gen2.c             | 166 ++----
 drivers/pci/controller/pci-tegra.c                 |  79 +--
 drivers/pci/controller/pci-v3-semi.c               |  30 +-
 drivers/pci/controller/pci-versatile.c             |  33 +-
 drivers/pci/controller/pci-xgene-msi.c             |   2 -
 drivers/pci/controller/pci-xgene.c                 |  25 +-
 drivers/pci/controller/pcie-altera-msi.c           |   4 +-
 drivers/pci/controller/pcie-altera.c               |  41 +-
 drivers/pci/controller/pcie-brcmstb.c              |  33 +-
 drivers/pci/controller/pcie-iproc-platform.c       |  10 +-
 drivers/pci/controller/pcie-iproc.c                |  21 +-
 drivers/pci/controller/pcie-iproc.h                |   2 -
 drivers/pci/controller/pcie-mediatek.c             |  20 +-
 drivers/pci/controller/pcie-rcar-host.c            |  95 +---
 drivers/pci/controller/pcie-rockchip-ep.c          |   1 +
 drivers/pci/controller/pcie-rockchip-host.c        |  54 +-
 drivers/pci/controller/pcie-rockchip.c             |   5 +-
 drivers/pci/controller/pcie-rockchip.h             |   2 -
 drivers/pci/controller/pcie-tango.c                |   4 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           | 611 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |  45 +-
 drivers/pci/controller/pcie-xilinx.c               |  35 +-
 drivers/pci/controller/vmd.c                       |  44 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   2 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |   2 +-
 drivers/pci/endpoint/pci-epc-core.c                |   2 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |   2 +-
 drivers/pci/endpoint/pci-epf-core.c                |   4 +-
 drivers/pci/hotplug/acpi_pcihp.c                   |   4 +-
 drivers/pci/hotplug/pciehp_core.c                  |   1 +
 drivers/pci/hotplug/rpadlpar_core.c                |   6 +-
 drivers/pci/irq.c                                  |  50 --
 drivers/pci/msi.c                                  |  22 +-
 drivers/pci/of.c                                   |  49 +-
 drivers/pci/p2pdma.c                               |  23 +-
 drivers/pci/pci-acpi.c                             |   9 +-
 drivers/pci/pci-label.c                            |   2 +-
 drivers/pci/pci-pf-stub.c                          |   2 +-
 drivers/pci/pci.c                                  | 286 +++++-----
 drivers/pci/pci.h                                  |  15 +-
 drivers/pci/pcie/Kconfig                           |   2 +-
 drivers/pci/pcie/aer.c                             |  87 +--
 drivers/pci/pcie/aer_inject.c                      |   2 +-
 drivers/pci/pcie/aspm.c                            |   1 +
 drivers/pci/pcie/err.c                             |   7 +-
 drivers/pci/pcie/portdrv_pci.c                     |   2 +-
 drivers/pci/probe.c                                |  17 +-
 drivers/pci/quirks.c                               |  33 +-
 drivers/pci/setup-bus.c                            |   3 +-
 drivers/pci/setup-res.c                            |   3 +-
 drivers/pci/slot.c                                 |   6 +-
 drivers/pci/switch/switchtec.c                     |  16 +-
 drivers/pci/vc.c                                   |   1 -
 drivers/scsi/aacraid/linit.c                       |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   6 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c                |   2 +-
 drivers/staging/qlge/qlge_main.c                   |   2 +-
 include/linux/kernel.h                             |   1 +
 include/linux/pci-ats.h                            |   4 +
 include/linux/pci.h                                |  30 +-
 include/linux/pci_ids.h                            |   2 +
 samples/vfio-mdev/mdpy-defs.h                      |   2 +-
 131 files changed, 2916 insertions(+), 1756 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.c
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
