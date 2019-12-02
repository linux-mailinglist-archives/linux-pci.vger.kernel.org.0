Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE810F388
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 00:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfLBXl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 18:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfLBXl0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Dec 2019 18:41:26 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB34206F0;
        Mon,  2 Dec 2019 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575330085;
        bh=i4X9LRZwFJ9MlvLPSePt1eY1uv03fmnwp4xD1eMj6j4=;
        h=Date:From:To:Cc:Subject:From;
        b=ku8tm359cE86DykX/noeXOdsUwhBHJ92P/aSDdhS3FtrsFTkMeuIg5KAS1s28aHvo
         +r8WN1vzSW4yoXixLw+ByNrO/yiciq2lrMqcIGbjEQIGjGaj06rxWof5CMDCfszQyr
         5yF7FBeCDbPiOx0uPZVDIoQ0x2KccFGjgGETwHnM=
Date:   Mon, 2 Dec 2019 17:41:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.5
Message-ID: <20191202234123.GA146608@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.5-changes

for you to fetch changes up to 7e124c40517218e079e580909de2652bddb60ff5:

  Merge branch 'pci/trivial' (2019-11-28 08:54:55 -0600)

----------------------------------------------------------------

You should see minor conflicts in arch/powerpc/include/asm/Kbuild (powerpc
added early_ioremap.h, we removed msi.h) and Documentation/power/pci.rst
(PM wrapped long lines, we removed things mentioned in those lines).  My
resolution is at [1] if you're interested.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v5.5-merge

Enumeration:

  - Warn if a host bridge has no NUMA info (Yunsheng Lin)

  - Add PCI_STD_NUM_BARS for the number of standard BARs (Denis Efremov)

Resource management:

  - Fix boot-time Embedded Controller GPE storm caused by incorrect
    resource assignment after ACPI Bus Check Notification (Mika Westerberg)

  - Protect pci_reassign_bridge_resources() against concurrent
    addition/removal (Benjamin Herrenschmidt)

  - Fix bridge dma_ranges resource list cleanup (Rob Herring)

  - Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters to control the
    MMIO and prefetchable MMIO window sizes of hotplug bridges
    independently (Nicholas Johnson)

  - Fix MMIO/MMIO_PREF window assignment that assigned more space than
    desired (Nicholas Johnson)

  - Only enforce bus numbers from bridge EA if the bridge has EA devices
    downstream (Subbaraya Sundeep)

  - Consolidate DT "dma-ranges" parsing and convert all host drivers to use
    shared parsing (Rob Herring)

Error reporting:

  - Restore AER capability after resume (Mayurkumar Patel)

  - Add PoisonTLPBlocked AER counter (Rajat Jain)

  - Use for_each_set_bit() to simplify AER code (Andy Shevchenko)

  - Fix AER kernel-doc (Andy Shevchenko)

  - Add "pcie_ports=dpc-native" parameter to allow native use of DPC even
    if platform didn't grant control over AER (Olof Johansson)

Hotplug:

  - Avoid returning prematurely from sysfs requests to enable or disable a
    PCIe hotplug slot (Lukas Wunner)

  - Don't disable interrupts twice when suspending hotplug ports (Mika
    Westerberg)

  - Fix deadlocks when PCIe ports are hot-removed while suspended (Mika
    Westerberg)

Power management:

  - Remove unnecessary ASPM locking (Bjorn Helgaas)

  - Add support for disabling L1 PM Substates (Heiner Kallweit)

  - Allow re-enabling Clock PM after it has been disabled (Heiner Kallweit)

  - Add sysfs attributes for controlling ASPM link states (Heiner Kallweit)

  - Remove CONFIG_PCIEASPM_DEBUG, including "link_state" and "clk_ctl"
    sysfs files (Heiner Kallweit)

  - Avoid AMD FCH XHCI USB PME# from D0 defect that prevents wakeup on USB
    2.0 or 1.1 connect events (Kai-Heng Feng)

  - Move power state check out of pci_msi_supported() (Bjorn Helgaas)

  - Fix incorrect MSI-X masking on resume and revert related nvme quirk for
    Kingston NVME SSD running FW E8FK11.T (Jian-Hong Pan)

  - Always return devices to D0 when thawing to fix hibernation with
    drivers like mlx4 that used legacy power management (previously we only
    did it for drivers with new power management ops) (Dexuan Cui)

  - Clear PCIe PME Status even for legacy power management (Bjorn Helgaas)

  - Fix PCI PM documentation errors (Bjorn Helgaas)

  - Use dev_printk() for more power management messages (Bjorn Helgaas)

  - Apply D2 delay as milliseconds, not microseconds (Bjorn Helgaas)

  - Convert xen-platform from legacy to generic power management (Bjorn
    Helgaas)

  - Removed unused .resume_early() and .suspend_late() legacy power
    management hooks (Bjorn Helgaas)

  - Rearrange power management code for clarity (Rafael J. Wysocki)

  - Decode power states more clearly ("4" or "D4" really refers to
    "D3cold") (Bjorn Helgaas)

  - Notice when reading PM Control register returns an error (~0) instead
    of interpreting it as being in D3hot (Bjorn Helgaas)

  - Add missing link delays required by the PCIe spec (Mika Westerberg)

Virtualization:

  - Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI (Bjorn Helgaas)

  - Allow VFs to use PRI (the PF PRI is shared by the VFs, but the code
    previously didn't recognize that) (Kuppuswamy Sathyanarayanan)

  - Allow VFs to use PASID (the PF PASID capability is shared by the VFs,
    but the code previously didn't recognize that) (Kuppuswamy
    Sathyanarayanan)

  - Disconnect PF and VF ATS enablement, since ATS in PFs and associated
    VFs can be enabled independently (Kuppuswamy Sathyanarayanan)

  - Cache PRI and PASID capability offsets (Kuppuswamy Sathyanarayanan)

  - Cache the PRI PRG Response PASID Required bit (Bjorn Helgaas)

  - Consolidate ATS declarations in linux/pci-ats.h (Krzysztof Wilczynski)

  - Remove unused PRI and PASID stubs (Bjorn Helgaas)

  - Removed unnecessary EXPORT_SYMBOL_GPL() from ATS, PRI, and PASID
    interfaces that are only used by built-in IOMMU drivers (Bjorn Helgaas)

  - Hide PRI and PASID state restoration functions used only inside the PCI
    core (Bjorn Helgaas)

  - Add a DMA alias quirk for the Intel VCA NTB (Slawomir Pawlowski)

  - Serialize sysfs sriov_numvfs reads vs writes (Pierre Crégut)

  - Update Cavium ACS quirk for ThunderX2 and ThunderX3 (George Cherian)

  - Fix the UPDCR register address in the Intel ACS quirk (Steffen
    Liebergeld)

  - Unify ACS quirk implementations (Bjorn Helgaas)

Amlogic Meson host bridge driver:

  - Fix meson PERST# GPIO polarity problem (Remi Pommarel)

  - Add DT bindings for Amlogic Meson G12A (Neil Armstrong)

  - Fix meson clock names to match DT bindings (Neil Armstrong)

  - Add meson support for Amlogic G12A SoC with separate shared PHY (Neil
    Armstrong)

  - Add meson extended PCIe PHY functions for Amlogic G12A USB3+PCIe combo
    PHY (Neil Armstrong)

  - Add arm64 DT for Amlogic G12A PCIe controller node (Neil Armstrong)

  - Add commented-out description of VIM3 USB3/PCIe mux in arm64 DT (Neil
    Armstrong)

Broadcom iProc host bridge driver:

  - Invalidate iProc PAXB address mapping before programming it (Abhishek
    Shah)

  - Fix iproc-msi and mvebu __iomem annotations (Ben Dooks)

Cadence host bridge driver:

  - Refactor Cadence PCIe host controller to use as a library for both host
    and endpoint (Tom Joseph)

Freescale Layerscape host bridge driver:

  - Add layerscape LS1028a support (Xiaowei Bao)

Intel VMD host bridge driver:

  - Add VMD bus 224-255 restriction decode (Jon Derrick)

  - Add VMD 8086:9A0B device ID (Jon Derrick)

  - Remove Keith from VMD maintainer list (Keith Busch)

Marvell ARMADA 3700 / Aardvark host bridge driver:

  - Use LTSSM state to build link training flag since Aardvark doesn't
    implement the Link Training bit (Remi Pommarel)

  - Delay before training Aardvark link in case PERST# was asserted before
    the driver probe (Remi Pommarel)

  - Fix Aardvark issues with Root Control reads and writes (Remi Pommarel)

  - Don't rely on jiffies in Aardvark config access path since interrupts
    may be disabled (Remi Pommarel)

  - Fix Aardvark big-endian support (Grzegorz Jaszczyk)

Marvell ARMADA 370 / XP host bridge driver:

  - Make mvebu_pci_bridge_emul_ops static (Ben Dooks)

Microsoft Hyper-V host bridge driver:

  - Add hibernation support for Hyper-V virtual PCI devices (Dexuan Cui)

  - Track Hyper-V pci_protocol_version per-hbus, not globally (Dexuan Cui)

  - Avoid kmemleak false positive on hv hbus buffer (Dexuan Cui)

Mobiveil host bridge driver:

  - Change mobiveil csr_read()/write() function names that conflict with
    riscv arch functions (Kefeng Wang)

NVIDIA Tegra host bridge driver:

  - Fix Tegra CLKREQ dependency programming (Vidya Sagar)

Renesas R-Car host bridge driver:

  - Remove unnecessary header include from rcar (Andrew Murray)

  - Tighten register index checking for rcar inbound range programming
    (Marek Vasut)

  - Fix rcar inbound range alignment calculation to improve packing of
    multiple entries (Marek Vasut)

  - Update rcar MACCTLR setting to match documentation (Yoshihiro Shimoda)

  - Clear bit 0 of MACCTLR before PCIETCTLR.CFINIT per manual (Yoshihiro
    Shimoda)

  - Add Marek Vasut and Yoshihiro Shimoda as R-Car maintainers (Simon
    Horman)

Rockchip host bridge driver:

  - Make rockchip 0V9 and 1V8 power regulators non-optional (Robin Murphy)

Socionext UniPhier host bridge driver:

  - Set uniphier to host (RC) mode always (Kunihiko Hayashi)

Endpoint drivers:

  - Fix endpoint driver sign extension problem when shifting page number to
    phys_addr_t (Alan Mikhak)

Misc:

  - Add NumaChip SPDX header (Krzysztof Wilczynski)

  - Replace EXTRA_CFLAGS with ccflags-y (Krzysztof Wilczynski)

  - Remove unused includes (Krzysztof Wilczynski)

  - Removed unused sysfs attribute groups (Ben Dooks)

  - Remove PTM and ASPM dependencies on PCIEPORTBUS (Bjorn Helgaas)

  - Add PCIe Link Control 2 register field definitions to replace magic
    numbers in AMDGPU and Radeon CIK/SI (Bjorn Helgaas)

  - Fix incorrect Link Control 2 Transmit Margin usage in AMDGPU and Radeon
    CIK/SI PCIe Gen3 link training (Bjorn Helgaas)

  - Use pcie_capability_read_word() instead of pci_read_config_word() in
    AMDGPU and Radeon CIK/SI (Frederick Lawler)

  - Remove unused pci_irq_get_node() Greg Kroah-Hartman)

  - Make asm/msi.h mandatory and simplify PCI_MSI_IRQ_DOMAIN Kconfig
    (Palmer Dabbelt, Michal Simek)

  - Read all 64 bits of Switchtec part_event_bitmap (Logan Gunthorpe)

  - Fix erroneous intel-iommu dependency on CONFIG_AMD_IOMMU (Bjorn
    Helgaas)

  - Fix bridge emulation big-endian support (Grzegorz Jaszczyk)

  - Fix dwc find_next_bit() usage (Niklas Cassel)

  - Fix pcitest.c fd leak (Hewenliang)

  - Fix typos and comments (Bjorn Helgaas)

  - Fix Kconfig whitespace errors (Krzysztof Kozlowski)

----------------------------------------------------------------
Abhishek Shah (1):
      PCI: iproc: Invalidate PAXB address mapping before programming it

Alan Mikhak (1):
      PCI: endpoint: Cast the page number to phys_addr_t

Andrew Murray (1):
      PCI: rcar: Remove unnecessary header include (../pci.h)

Andy Shevchenko (3):
      PCI/AER: Use for_each_set_bit() to simplify code
      PCI/AER: Fix kernel-doc warnings
      PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()

Ben Dooks (1):
      PCI: sysfs: Remove unused attribute groups

Ben Dooks (Codethink) (3):
      PCI: iproc-msi: Fix __iomem annotation in decode_msi_hwirq()
      PCI: mvebu: Make mvebu_pci_bridge_emul_ops static
      PCI: mvebu: mvebu_pcie_map_registers __iomem fix

Benjamin Herrenschmidt (1):
      PCI: Protect pci_reassign_bridge_resources() against concurrent addition/removal

Bjorn Helgaas (66):
      PCI/ASPM: Remove pcie_aspm_enabled() unnecessary locking
      iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
      PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI
      PCI/ATS: Cache PRI PRG Response PASID Required bit
      PCI/ATS: Remove unused PRI and PASID stubs
      PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()
      PCI/ATS: Make pci_restore_pri_state(), pci_restore_pasid_state() private
      PCI: Remove unnecessary includes
      PCI: Remove useless comments and tidy others
      PCI: Make ACS quirk implementations more uniform
      PCI: Unify ACS quirk desired vs provided checking
      PCI: Fix typos
      PCI/PM: Correct pci_pm_thaw_noirq() documentation
      PCI/PM: Clear PCIe PME Status even for legacy power management
      PCI/PM: Run resume fixups before disabling wakeup events
      PCI/PM: Make power management op coding style consistent
      PCI/PM: Note that PME can be generated from D0
      PCI/PM: Wrap long lines in documentation
      PCI/PM: Use PCI dev_printk() wrappers for consistency
      PCI/PM: Use pci_WARN() to include device information
      PCI/PM: Apply D2 delay as milliseconds, not microseconds
      PCI/PM: Expand PM reset messages to mention D3hot (not just D3)
      PCI/PM: Simplify pci_set_power_state()
      xen-platform: Convert to generic power management
      PCI/PM: Remove unused pci_driver.resume_early() hook
      PCI/PM: Remove unused pci_driver.suspend_late() hook
      PCI/PM: Decode D3cold power state correctly
      PCI/PM: Return error when changing power state from D3cold
      PCI/PTM: Remove spurious "d" from granularity message
      PCI/PTM: Remove dependency on PCIEPORTBUS
      PCI/ASPM: Remove dependency on PCIEPORTBUS
      PCI: Remove PCIe Kconfig dependencies on PCI
      PCI: Allow building PCIe things without PCIEPORTBUS
      PCI: Add #defines for Enter Compliance, Transmit Margin
      drm/amdgpu: Correct Transmit Margin masks
      drm/amdgpu: Replace numbers with PCI_EXP_LNKCTL2 definitions
      drm/radeon: Correct Transmit Margin masks
      drm/radeon: Replace numbers with PCI_EXP_LNKCTL2 definitions
      PCI/MSI: Move power state check out of pci_msi_supported()
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/pm'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/layerscape'
      Merge branch 'remotes/lorenzo/pci/meson'
      Merge branch 'remotes/lorenzo/pci/mobiveil'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/rockchip'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/uniphier'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/mmio-dma-ranges'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'pci/trivial'

Denis Efremov (1):
      PCI: Add PCI_STD_NUM_BARS for the number of standard BARs

Dexuan Cui (5):
      PCI/PM: Always return devices to D0 when thawing
      PCI: hv: Reorganize the code in preparation of hibernation
      PCI: hv: Add hibernation support
      PCI: hv: Change pci_protocol_version to per-hbus
      PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer

Frederick Lawler (2):
      drm/amdgpu: Prefer pcie_capability_read_word()
      drm/radeon: Prefer pcie_capability_read_word()

George Cherian (1):
      PCI: Apply Cavium ACS quirk to ThunderX2 and ThunderX3

Greg Kroah-Hartman (1):
      PCI/MSI: Remove unused pci_irq_get_node()

Grzegorz Jaszczyk (2):
      PCI: aardvark: Fix big endian support
      PCI: pci-bridge-emul: Fix big-endian support

Heiner Kallweit (5):
      PCI/ASPM: Add L1 PM substate support to pci_disable_link_state()
      PCI/ASPM: Allow re-enabling Clock PM
      PCI/ASPM: Add pcie_aspm_get_link()
      PCI/ASPM: Add sysfs attributes for controlling ASPM link states
      PCI/ASPM: Remove PCIEASPM_DEBUG Kconfig option and related code

Hewenliang (1):
      tools: PCI: Fix fd leakage

Jian-Hong Pan (2):
      PCI/MSI: Fix incorrect MSI-X masking on resume
      Revert "nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T"

Jon Derrick (2):
      PCI: vmd: Add bus 224-255 restriction decode
      PCI: vmd: Add device id for VMD device 8086:9A0B

Kai-Heng Feng (1):
      x86/PCI: Avoid AMD FCH XHCI USB PME# from D0 defect

Kefeng Wang (1):
      PCI: mobiveil: Fix csr_read()/write() build issue

Keith Busch (1):
      MAINTAINERS: Remove Keith from VMD maintainer

Krzysztof Kozlowski (1):
      PCI: Fix indentation

Krzysztof Wilczynski (5):
      PCI/ATS: Consolidate ATS declarations in linux/pci-ats.h
      x86/PCI: Add NumaChip SPDX GPL-2.0 to replace COPYING boilerplate
      x86/PCI: Correct SPDX comment style
      x86/PCI: Replace deprecated EXTRA_CFLAGS with ccflags-y
      PCI: Remove unused includes and superfluous struct declaration

Kunihiko Hayashi (1):
      PCI: uniphier: Set mode register to host mode

Kuppuswamy Sathyanarayanan (5):
      PCI/ATS: Handle sharing of PF PRI Capability with all VFs
      PCI/ATS: Handle sharing of PF PASID Capability with all VFs
      PCI/ATS: Disable PF/VF ATS service independently
      PCI/ATS: Cache PRI Capability offset
      PCI/ATS: Cache PASID Capability offset

Logan Gunthorpe (1):
      PCI/switchtec: Read all 64 bits of part_event_bitmap

Lukas Wunner (1):
      PCI: pciehp: Avoid returning prematurely from sysfs requests

Marek Vasut (2):
      PCI: rcar: Move the inbound index check
      PCI: rcar: Recalculate inbound range alignment for each controller entry

Michal Simek (1):
      asm-generic: Make msi.h a mandatory include/asm header

Mika Westerberg (5):
      PCI: pciehp: Do not disable interrupt twice on suspend
      PCI: pciehp: Prevent deadlock on disconnect
      ACPI / hotplug / PCI: Allocate resources directly under the non-hotplug bridge
      PCI/PM: Add pcie_wait_for_link_delay()
      PCI/PM: Add missing link delays required by the PCIe spec

Neil Armstrong (6):
      dt-bindings: pci: amlogic, meson-pcie: Add G12A bindings
      PCI: amlogic: Fix probed clock names
      PCI: amlogic: meson: Add support for G12A
      phy: meson-g12a-usb3-pcie: Add support for PCIe mode
      arm64: dts: meson-g12a: Add PCIe node
      arm64: dts: khadas-vim3: add commented support for PCIe

Nicholas Johnson (2):
      PCI: Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters
      PCI: Avoid double hpmemsize MMIO window assignment

Niklas Cassel (1):
      PCI: dwc: Fix find_next_bit() usage

Olof Johansson (1):
      PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control

Palmer Dabbelt (1):
      PCI: Remove PCI_MSI_IRQ_DOMAIN architecture whitelist

Patel, Mayurkumar (1):
      PCI/AER: Save AER Capability for suspend/resume

Pierre Crégut (1):
      PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes

Rafael J. Wysocki (5):
      PCI/PM: Move power state update away from pci_power_up()
      PCI/PM: Use pci_power_up() in pci_set_power_state()
      PCI/PM: Fold __pci_start_power_transition() into its caller
      PCI/PM: Avoid exporting __pci_complete_power_transition()
      PCI/PM: Fold __pci_complete_power_transition() into its caller

Rajat Jain (1):
      PCI/AER: Add PoisonTLPBlocked to Uncorrectable error counters

Remi Pommarel (5):
      PCI: aardvark: Use LTSSM state to build link training flag
      PCI: aardvark: Wait for endpoint to be ready before training link
      PCI: aardvark: Fix PCI_EXP_RTCTL register configuration
      PCI: aardvark: Don't rely on jiffies while holding spinlock
      PCI: amlogic: Fix reset assertion via gpio descriptor

Rob Herring (26):
      PCI: Fix missing bridge dma_ranges resource list cleanup
      resource: Add a resource_list_first_type helper
      PCI: Export pci_parse_request_of_pci_ranges()
      PCI: aardvark: Use pci_parse_request_of_pci_ranges()
      PCI: altera: Use pci_parse_request_of_pci_ranges()
      PCI: dwc: Use pci_parse_request_of_pci_ranges()
      PCI: faraday: Use pci_parse_request_of_pci_ranges()
      PCI: iproc: Use pci_parse_request_of_pci_ranges()
      PCI: mediatek: Use pci_parse_request_of_pci_ranges()
      PCI: mobiveil: Use pci_parse_request_of_pci_ranges()
      PCI: rockchip: Use pci_parse_request_of_pci_ranges()
      PCI: rockchip: Drop storing driver private outbound resource data
      PCI: v3-semi: Use pci_parse_request_of_pci_ranges()
      PCI: xgene: Use pci_parse_request_of_pci_ranges()
      PCI: xilinx: Use pci_parse_request_of_pci_ranges()
      PCI: xilinx-nwl: Use pci_parse_request_of_pci_ranges()
      PCI: versatile: Use pci_parse_request_of_pci_ranges()
      PCI: versatile: Remove usage of PHYS_OFFSET
      PCI: versatile: Enable COMPILE_TEST
      PCI: of: Add inbound resource parsing to helpers
      PCI: ftpci100: Use inbound resources for setup
      PCI: v3-semi: Use inbound resources for setup
      PCI: xgene: Use inbound resources for setup
      PCI: iproc: Use inbound resources for setup
      PCI: rcar: Use inbound resources for setup
      PCI: Make devm_of_pci_get_host_bridge_resources() static

Robin Murphy (1):
      PCI: rockchip: Make some regulators non-optional

Simon Horman (1):
      MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE co-maintainers

Slawomir Pawlowski (1):
      PCI: Add DMA alias quirk for Intel VCA NTB

Steffen Liebergeld (1):
      PCI: Fix Intel ACS quirk UPDCR register address

Subbaraya Sundeep (1):
      PCI: Do not use bus number zero from EA capability

Tom Joseph (2):
      PCI: cadence: Refactor driver to use as a core library
      PCI: cadence: Move all files to per-device cadence directory

Vidya Sagar (2):
      PCI: tegra: Fix CLKREQ dependency programming
      PCI/PM: Move pci_dev_wait() definition earlier

Xiaowei Bao (2):
      dt-bindings: pci: layerscape-pci: add compatible strings "fsl, ls1028a-pcie"
      PCI: layerscape: Add LS1028a support

Yoshihiro Shimoda (1):
      PCI: rcar: Fix missing MACCTLR register setting in initialization sequence

Yunsheng Lin (1):
      PCI: Warn if no host bridge NUMA node info

 Documentation/ABI/testing/sysfs-bus-pci            |  13 +
 Documentation/admin-guide/kernel-parameters.txt    |  11 +-
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  12 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |   1 +
 Documentation/power/pci.rst                        |  50 +--
 MAINTAINERS                                        |   4 +-
 arch/alpha/kernel/pci-sysfs.c                      |   8 +-
 arch/arc/include/asm/Kbuild                        |   1 -
 arch/arm/include/asm/Kbuild                        |   1 -
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  33 ++
 .../dts/amlogic/meson-g12b-a311d-khadas-vim3.dts   |  25 ++
 .../dts/amlogic/meson-g12b-s922x-khadas-vim3.dts   |  25 ++
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |   4 +
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |  25 ++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |   4 +
 arch/arm64/include/asm/Kbuild                      |   1 -
 arch/mips/include/asm/Kbuild                       |   1 -
 arch/powerpc/include/asm/Kbuild                    |   1 -
 arch/riscv/include/asm/Kbuild                      |   1 -
 arch/s390/include/asm/pci.h                        |   5 +-
 arch/s390/include/asm/pci_clp.h                    |   6 +-
 arch/s390/pci/pci.c                                |  16 +-
 arch/s390/pci/pci_clp.c                            |   6 +-
 arch/sparc/include/asm/Kbuild                      |   1 -
 arch/x86/pci/Makefile                              |   4 +-
 arch/x86/pci/common.c                              |   2 +-
 arch/x86/pci/fixup.c                               |  11 +
 arch/x86/pci/intel_mid_pci.c                       |   2 +-
 arch/x86/pci/numachip.c                            |   5 +-
 drivers/ata/pata_atp867x.c                         |   2 +-
 drivers/ata/sata_nv.c                              |   2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  95 ++++--
 drivers/gpu/drm/amd/amdgpu/si.c                    |  97 ++++--
 drivers/gpu/drm/radeon/cik.c                       |  94 ++++--
 drivers/gpu/drm/radeon/si.c                        |  97 ++++--
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/of_iommu.c                           |   2 +
 drivers/irqchip/irq-gic-v2m.c                      |   1 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |   1 +
 drivers/memstick/host/jmb38x_ms.c                  |   2 +-
 drivers/misc/pci_endpoint_test.c                   |   8 +-
 drivers/net/ethernet/intel/e1000/e1000.h           |   1 -
 drivers/net/ethernet/intel/e1000/e1000_main.c      |   2 +-
 drivers/net/ethernet/intel/ixgb/ixgb.h             |   1 -
 drivers/net/ethernet/intel/ixgb/ixgb_main.c        |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   4 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c     |   2 +-
 drivers/nvme/host/core.c                           |  10 -
 drivers/pci/Kconfig                                |  26 +-
 drivers/pci/Makefile                               |   3 +-
 drivers/pci/access.c                               |   2 +-
 drivers/pci/ats.c                                  | 207 ++++++------
 drivers/pci/controller/Kconfig                     |  31 +-
 drivers/pci/controller/Makefile                    |   4 +-
 drivers/pci/controller/cadence/Kconfig             |  45 +++
 drivers/pci/controller/cadence/Makefile            |   5 +
 .../pci/controller/{ => cadence}/pcie-cadence-ep.c |  96 +-----
 .../controller/{ => cadence}/pcie-cadence-host.c   |  97 +-----
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 174 ++++++++++
 .../pci/controller/{ => cadence}/pcie-cadence.c    |   0
 .../pci/controller/{ => cadence}/pcie-cadence.h    |  79 ++++-
 drivers/pci/controller/dwc/Kconfig                 |   6 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   2 +-
 drivers/pci/controller/dwc/pci-layerscape.c        |   1 +
 drivers/pci/controller/dwc/pci-meson.c             | 136 ++++++--
 drivers/pci/controller/dwc/pcie-artpec6.c          |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  41 +--
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   6 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         |  10 +
 drivers/pci/controller/pci-aardvark.c              | 133 ++++----
 drivers/pci/controller/pci-ftpci100.c              |  79 ++---
 drivers/pci/controller/pci-host-common.c           |   2 +-
 drivers/pci/controller/pci-hyperv.c                | 218 ++++++++++--
 drivers/pci/controller/pci-mvebu.c                 |   4 +-
 drivers/pci/controller/pci-thunder-pem.c           |   1 +
 drivers/pci/controller/pci-v3-semi.c               |  74 ++--
 drivers/pci/controller/pci-versatile.c             |  71 +---
 drivers/pci/controller/pci-xgene.c                 |  73 ++--
 drivers/pci/controller/pcie-altera.c               |  41 +--
 drivers/pci/controller/pcie-iproc-msi.c            |   5 +-
 drivers/pci/controller/pcie-iproc-platform.c       |   9 +-
 drivers/pci/controller/pcie-iproc.c                | 106 +++---
 drivers/pci/controller/pcie-mediatek.c             |  43 +--
 drivers/pci/controller/pcie-mobiveil.c             | 146 ++++----
 drivers/pci/controller/pcie-rcar.c                 |  92 +++--
 drivers/pci/controller/pcie-rockchip-host.c        | 158 +++------
 drivers/pci/controller/pcie-rockchip.h             |   7 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  21 +-
 drivers/pci/controller/pcie-xilinx.c               |  18 +-
 drivers/pci/controller/vmd.c                       |  34 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  10 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |   2 +-
 drivers/pci/hotplug/Kconfig                        |   2 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  12 +-
 drivers/pci/hotplug/pciehp.h                       |   8 +-
 drivers/pci/hotplug/pciehp_core.c                  |  36 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |  10 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  67 +++-
 drivers/pci/hotplug/rpaphp_core.c                  |   4 +-
 drivers/pci/iov.c                                  |   9 +-
 drivers/pci/msi.c                                  |  25 +-
 drivers/pci/of.c                                   |  67 +++-
 drivers/pci/pci-bridge-emul.c                      |  25 +-
 drivers/pci/pci-bridge-emul.h                      |  78 ++---
 drivers/pci/pci-driver.c                           | 198 +++++------
 drivers/pci/pci-sysfs.c                            |  28 +-
 drivers/pci/pci.c                                  | 372 ++++++++++++++-------
 drivers/pci/pci.h                                  |  48 +--
 drivers/pci/pcie/Kconfig                           |  10 -
 drivers/pci/pcie/aer.c                             |  88 ++++-
 drivers/pci/pcie/aspm.c                            | 245 +++++++++-----
 drivers/pci/pcie/dpc.c                             |   2 +-
 drivers/pci/pcie/portdrv.h                         |   2 +
 drivers/pci/pcie/portdrv_core.c                    |   7 +-
 drivers/pci/pcie/portdrv_pci.c                     |   8 +
 drivers/pci/pcie/ptm.c                             |   2 +-
 drivers/pci/probe.c                                |  60 ++--
 drivers/pci/proc.c                                 |   4 +-
 drivers/pci/quirks.c                               | 157 ++++++---
 drivers/pci/setup-bus.c                            |  70 ++--
 drivers/pci/switch/switchtec.c                     |   2 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |  70 +++-
 drivers/rapidio/devices/tsi721.c                   |   2 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |   2 +-
 drivers/scsi/pm8001/pm8001_init.c                  |   2 +-
 drivers/staging/gasket/gasket_constants.h          |   3 -
 drivers/staging/gasket/gasket_core.c               |  12 +-
 drivers/staging/gasket/gasket_core.h               |   4 +-
 drivers/tty/serial/8250/8250_pci.c                 |   8 +-
 drivers/usb/core/hcd-pci.c                         |   2 +-
 drivers/usb/host/pci-quirks.c                      |   2 +-
 drivers/vfio/pci/vfio_pci.c                        |  11 +-
 drivers/vfio/pci/vfio_pci_config.c                 |  32 +-
 drivers/vfio/pci/vfio_pci_private.h                |   4 +-
 drivers/video/fbdev/aty/radeon_pm.c                |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |   4 +-
 drivers/video/fbdev/efifb.c                        |   2 +-
 drivers/xen/platform-pci.c                         |  14 +-
 include/asm-generic/Kbuild                         |   1 +
 include/linux/aer.h                                |   4 +
 include/linux/of_pci.h                             |   5 +-
 include/linux/pci-ats.h                            |  77 ++---
 include/linux/pci-epc.h                            |   2 +-
 include/linux/pci.h                                |  59 ++--
 include/linux/pci_ids.h                            |   1 +
 include/linux/resource_ext.h                       |  12 +
 include/uapi/linux/pci_regs.h                      |   3 +
 lib/devres.c                                       |   2 +-
 tools/pci/pcitest.c                                |   1 +
 152 files changed, 2875 insertions(+), 2143 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/Kconfig
 create mode 100644 drivers/pci/controller/cadence/Makefile
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-ep.c (83%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-host.c (75%)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-plat.c
 rename drivers/pci/controller/{ => cadence}/pcie-cadence.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence.h (82%)
