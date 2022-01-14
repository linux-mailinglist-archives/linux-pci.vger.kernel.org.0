Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1418C48ED77
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 16:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiANP4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 10:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiANP4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 10:56:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD64C061574;
        Fri, 14 Jan 2022 07:56:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B55BFB8295E;
        Fri, 14 Jan 2022 15:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE31C36AE5;
        Fri, 14 Jan 2022 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642175770;
        bh=WtSCeaa/1R/guodGEVbiN9+NeCm6silVxwX52okMdQg=;
        h=Date:From:To:Cc:Subject:From;
        b=QhlokzJ/FvFGk8p1spQ90Uxct+HsLJ76X0fACBRAnemGU+S0fn1UBh6hOLVRHcu+L
         XLCYXtUTlvugeN2vqd2ZX8DEYr8QfO1LHR+vnCGkdQdWw+BgfoK7SpN/QhtPLmMP41
         LANw4Y1xC/Dbq8ahXw/j2PFhMrRANuKcQJs1YU9YfoomFjxhSkIjBHBse9aK504YAv
         7uPtLVwJ3Rp1mb73OnQhdFRx7T8FWLYpK6t+Lz5qB0Fsc8oP3WQ62s/0s6edRyLgzC
         0WMmBczDiMmgtEL2hVxFIfg1qX6nO5qqal0AJZFXL+H3DVue/dtEHtkGPGwgJ/JmK6
         Fgzmc76G5LX0g==
Date:   Fri, 14 Jan 2022 09:56:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.17
Message-ID: <20220114155608.GA557997@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-changes

for you to fetch changes up to 87c71931633bd15e9cfd51d4a4d9cd685e8cdb55:

  Merge branch 'pci/driver-cleanup' (2022-01-13 09:57:53 -0600)

----------------------------------------------------------------

You should see the following conflicts:

  drivers/pci/controller/Kconfig

    44ddb791f8f4 ("PCI: mt7621: Allow COMPILE_TEST for all arches") enables
    tristate again and removes arch dependencies; this conflicts with
    aa50faff4416 ("PCI: mt7621: Convert driver into 'bool'"), which
    appeared in v5.16-rc6

    My resolution: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/controller/Kconfig?h=v5.17-merge&id=868fafd67742#n334

  Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml

    d91e775e661f ("dt-bindings: PCI: ti,am65: Fix
    "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument") adds
    argument to ti,syscon-pcie-mode; this conflicts with dcd49679fb3a
    ("dt-bindings: PCI: Fix 'unevaluatedProperties' warnings") from the
    devicetree tree, which removed num-ib-windows, num-ob-windows

    My resolution: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml?h=v5.17-merge&id=868fafd67742#n72

----------------------------------------------------------------

Enumeration:
  - Use pci_find_vsec_capability() instead of open-coding it (Andy
    Shevchenko)
  - Convert pci_dev_present() stub from macro to static inline to avoid
    'unused variable' errors (Hans de Goede)
  - Convert sysfs slot attributes from default_attrs to default_groups
    (Greg Kroah-Hartman)
  - Use DWORD accesses for LTR, L1 SS to avoid BayHub OZ711LV2 erratum
    (Rajat Jain)
  - Remove unnecessary initialization of static variables (Longji Guo)

Resource management:
  - Always write Intel I210 ROM BAR on update to work around device defect
    (Bjorn Helgaas)

PCIe native device hotplug:
  - Fix pciehp lockdep errors on Thunderbolt undock (Hans de Goede)
  - Fix infinite loop in pciehp IRQ handler on power fault (Lukas Wunner)

Power management:
  - Convert amd64-agp, sis-agp, via-agp from legacy PCI power management to
    generic power management (Vaibhav Gupta)

IOMMU:
  - Add function 1 DMA alias quirk for Marvell 88SE9125 SATA controller so
    it can work with an IOMMU (Yifeng Li)

Error handling:
  - Add PCI_ERROR_RESPONSE and related definitions for signaling and
    checking for transaction errors on PCI (Naveen Naidu)
  - Fabricate PCI_ERROR_RESPONSE data (~0) in config read wrappers, instead
    of in host controller drivers, when transactions fail on PCI (Naveen
    Naidu)
  - Use PCI_POSSIBLE_ERROR() to check for possible failure of config reads
    (Naveen Naidu)

Peer-to-peer DMA:
  - Add Logan Gunthorpe as P2PDMA maintainer (Bjorn Helgaas)

ASPM:
  - Calculate link L0s and L1 exit latencies when needed instead of caching
    them (Saheed O. Bolarinwa)
  - Calculate device L0s and L1 acceptable exit latencies when needed
    instead of caching them (Saheed O. Bolarinwa)
  - Remove struct aspm_latency since it's no longer needed (Saheed O.
    Bolarinwa)

APM X-Gene PCIe controller driver:
  - Fix IB window setup, which was broken by the fact that IB resources are
    now sorted in address order instead of DT dma-ranges order (Rob
    Herring)

Apple PCIe controller driver:
  - Enable clock gating to save power (Hector Martin)
  - Fix REFCLK1 enable/poll logic (Hector Martin)

Broadcom STB PCIe controller driver:
  - Declare bitmap correctly for use by bitmap interfaces (Christophe
    JAILLET)
  - Clean up computation of legacy and non-legacy MSI bitmasks (Florian
    Fainelli)
  - Update suspend/resume/remove error handling to warn about errors and
    not fail the operation (Jim Quinlan)
  - Correct the "pcie" and "msi" interrupt descriptions in DT binding (Jim
    Quinlan)
  - Add DT bindings for endpoint voltage regulators (Jim Quinlan)
  - Split brcm_pcie_setup() into two functions (Jim Quinlan)
  - Add mechanism for turning on voltage regulators for connected devices
    (Jim Quinlan)
  - Turn voltage regulators for connected devices on/off when bus is added
    or removed (Jim Quinlan)
  - When suspending, don't turn off voltage regulators for wakeup devices
    (Jim Quinlan)

Freescale i.MX6 PCIe controller driver:
  - Add i.MX8MM support (Richard Zhu)

Freescale Layerscape PCIe controller driver:
  - Use DWC common ops instead of layerscape-specific link-up functions
    (Hou Zhiqiang)

Intel VMD host bridge driver:
  - Honor platform ACPI _OSC feature negotiation for Root Ports below VMD
    (Kai-Heng Feng)
  - Add support for Raptor Lake SKUs (Karthik L Gopalakrishnan)
  - Reset everything below VMD before enumerating to work around failure to
    enumerate NVMe devices when guest OS reboots (Nirmal Patel)

Bridge emulation (used by Marvell Aardvark and MVEBU):
  - Make emulated ROM BAR read-only by default (Pali Rohár)
  - Make some emulated legacy PCI bits read-only for PCIe devices (Pali
    Rohár)
  - Update reserved bits in emulated PCIe Capability (Pali Rohár)
  - Allow drivers to emulate different PCIe Capability versions (Pali
    Rohár)
  - Set emulated Capabilities List bit for all PCIe devices, since they
    must have at least a PCIe Capability (Pali Rohár)

Marvell Aardvark PCIe controller driver:
  - Add bridge emulation definitions for PCIe DEVCAP2, DEVCTL2, DEVSTA2,
    LNKCAP2, LNKCTL2, LNKSTA2, SLTCAP2, SLTCTL2, SLTSTA2 (Pali Rohár)
  - Add aardvark support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2
    registers (Pali Rohár)
  - Clear all MSIs at setup to avoid spurious interrupts (Pali Rohár)
  - Disable bus mastering when unbinding host controller driver (Pali
    Rohár)
  - Mask all interrupts when unbinding host controller driver (Pali Rohár)
  - Fix memory leak in host controller unbind (Pali Rohár)
  - Assert PERST# when unbinding host controller driver (Pali Rohár)
  - Disable link training when unbinding host controller driver (Pali
    Rohár)
  - Disable common PHY when unbinding host controller driver (Pali Rohár)
  - Fix resource type checking to check only IORESOURCE_MEM, not
    IORESOURCE_MEM_64, which is a flavor of IORESOURCE_MEM (Pali Rohár)

Marvell MVEBU PCIe controller driver:
  - Implement pci_remap_iospace() for ARM so mvebu can use
    devm_pci_remap_iospace() instead of the previous ARM-specific
    pci_ioremap_io() interface (Pali Rohár)
  - Use the standard pci_host_probe() instead of the device-specific
    mvebu_pci_host_probe() (Pali Rohár)
  - Replace all uses of ARM-specific pci_ioremap_io() with the ARM
    implementation of the standard pci_remap_iospace() interface and remove
    pci_ioremap_io() (Pali Rohár)
  - Skip initializing invalid Root Ports (Pali Rohár)
  - Check for errors from pci_bridge_emul_init() (Pali Rohár)
  - Ignore any bridges at non-zero function numbers (Pali Rohár)
  - Return ~0 data for invalid config read size (Pali Rohár)
  - Disallow mapping interrupts on emulated bridges (Pali Rohár)
  - Clear Root Port Memory & I/O Space Enable and Bus Master Enable at
    initialization (Pali Rohár)
  - Make type bits in Root Port I/O Base register read-only (Pali Rohár)
  - Disable Root Port windows when base/limit set to invalid values (Pali
    Rohár)
  - Set controller to Root Complex mode (Pali Rohár)
  - Set Root Port Class Code to PCI Bridge (Pali Rohár)
  - Update emulated Root Port secondary bus numbers to better reflect the
    actual topology (Pali Rohár)
  - Add PCI_BRIDGE_CTL_BUS_RESET support to emulated Root Ports so
    pci_reset_secondary_bus() can reset connected devices (Pali Rohár)
  - Add PCI_EXP_DEVCTL Error Reporting Enable support to emulated Root
    Ports (Pali Rohár)
  - Add PCI_EXP_RTSTA PME Status bit support to emulated Root Ports (Pali
    Rohár)
  - Add DEVCAP2, DEVCTL2 and LNKCTL2 support to emulated Root Ports on
    Armada XP and newer devices (Pali Rohár)
  - Export mvebu-mbus.c symbols to allow pci-mvebu.c to be a module (Pali
    Rohár)
  - Add support for compiling as a module (Pali Rohár)

MediaTek PCIe controller driver:
  - Assert PERST# for 100ms to allow power and clock to stabilize (qizhong
    cheng)

MediaTek PCIe Gen3 controller driver:
  - Disable Mediatek DVFSRC voltage request since lack of DVFSRC to respond
    to the request causes failure to exit L1 PM Substate (Jianjun Wang)

MediaTek MT7621 PCIe controller driver:
  - Declare mt7621_pci_ops static (Sergio Paracuellos)
  - Give pcibios_root_bridge_prepare() access to host bridge windows (Sergio
    Paracuellos)
  - Move MIPS I/O coherency unit setup from driver to
    pcibios_root_bridge_prepare() (Sergio Paracuellos)
  - Add missing MODULE_LICENSE() (Sergio Paracuellos)
  - Allow COMPILE_TEST for all arches (Sergio Paracuellos)

Microsoft Hyper-V host bridge driver:
  - Add hv-internal interfaces to encapsulate arch IRQ dependencies (Sunil
    Muthuswamy)
  - Add arm64 Hyper-V vPCI support (Sunil Muthuswamy)

Qualcomm PCIe controller driver:
  - Undo PM setup in qcom_pcie_probe() error handling path (Christophe
    JAILLET)
  - Use __be16 type to store return value from cpu_to_be16() (Manivannan
    Sadhasivam)
  - Constify static dw_pcie_ep_ops (Rikard Falkeborn)

Renesas R-Car PCIe controller driver:
  - Fix aarch32 abort handler so it doesn't check the wrong bus clock
    before accessing the host controller (Marek Vasut)

TI Keystone PCIe controller driver:
  - Add register offset for ti,syscon-pcie-id and ti,syscon-pcie-mode DT
    properties (Kishon Vijay Abraham I)

MicroSemi Switchtec management driver:
  - Add Gen4 automotive device IDs (Kelvin Cao)
  - Declare state_names[] as static so it's not allocated and initialized
    for every call (Kelvin Cao)

Host controller driver cleanups:
  - Use of_device_get_match_data(), not of_match_device(), when we only
    need the device data in altera, artpec6, cadence, designware-plat,
    dra7xx, keystone, kirin (Fan Fei)
  - Drop pointless of_device_get_match_data() cast in j721e (Bjorn Helgaas)
  - Drop redundant struct device * from j721e since struct cdns_pcie
    already has one (Bjorn Helgaas)
  - Rename driver structs to *_pcie in intel-gw, iproc, ls-gen4,
    mediatek-gen3, microchip, mt7621, rcar-gen2, tegra194, uniphier, xgene,
    xilinx, xilinx-cpm for consistency across drivers (Fan Fei)
  - Fix invalid address space conversions in hisi, spear13xx (Bjorn
    Helgaas)

Miscellaneous:
  - Sort Intel Device IDs by value (Andy Shevchenko)
  - Change Capability offsets to hex to match spec (Baruch Siach)
  - Correct misspellings (Krzysztof Wilczyński)
  - Terminate statement with semicolon in pci_endpoint_test.c (Ming Wang)

----------------------------------------------------------------
Andy Shevchenko (2):
      PCI: Use pci_find_vsec_capability() when looking for TBT devices
      PCI: Sort Intel Device IDs by value

Baruch Siach (1):
      PCI: Change capability register offsets to hex

Bjorn Helgaas (41):
      MAINTAINERS: Add Logan Gunthorpe as P2PDMA maintainer
      PCI: j721e: Drop pointless of_device_get_match_data() cast
      PCI: j721e: Drop redundant struct device *
      PCI: iproc: Rename iproc_pcie_bcma_ to iproc_bcma_pcie_
      PCI: iproc: Rename iproc_pcie_pltfm_ to iproc_pltfm_pcie_
      PCI: ls-gen4: Rename ls_pcie_g4 to ls_g4_pcie
      PCI: microchip: Rename mc_port to mc_pcie
      PCI: mt7621: Rename mt7621_pci_ to mt7621_pcie_
      PCI: rcar-gen2: Rename rcar_pci_priv to rcar_pci
      PCI: xilinx-cpm: Rename xilinx_cpm_pcie_port to xilinx_cpm_pcie
      PCI: hisi: Avoid invalid address space conversions
      PCI: spear13xx: Avoid invalid address space conversions
      PCI: Work around Intel I210 ROM BAR overlap defect
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/legacy-pm-removal'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/apple'
      Merge branch 'pci/host/brcmstb'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'pci/host/hv'
      Merge branch 'remotes/lorenzo/pci/keystone'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/mediatek-gen3'
      Merge branch 'pci/host/mt7621'
      Merge branch 'remotes/lorenzo/pci/mvebu'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/rcar'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/xgene'
      Merge branch 'remotes/lorenzo/pci/xilinx-nwl'
      Merge branch 'remotes/lorenzo/pci/bridge-emul'
      Merge branch 'pci/misc'
      Merge branch 'pci/errors'
      Merge branch 'pci/driver-cleanup'

Bolarinwa O. Saheed (1):
      PCI/ASPM: Move pci_function_0() upward

Christophe JAILLET (5):
      PCI: qcom: Fix an error handling path in 'qcom_pcie_probe()'
      PCI: xgene-msi: Use bitmap_zalloc() when applicable
      PCI: xilinx-nwl: Simplify code and fix a memory leak
      PCI/P2PDMA: Use percpu_ref_tryget_live_rcu() inside RCU critical section
      PCI: brcmstb: Declare 'used' as bitmap, not unsigned long

Fan Fei (13):
      PCI: altera: Prefer of_device_get_match_data()
      PCI: artpec6: Prefer of_device_get_match_data()
      PCI: cadence: Prefer of_device_get_match_data()
      PCI: designware-plat: Prefer of_device_get_match_data()
      PCI: dra7xx: Prefer of_device_get_match_data()
      PCI: keystone: Prefer of_device_get_match_data()
      PCI: kirin: Prefer of_device_get_match_data()
      PCI: intel-gw: Rename intel_pcie_port to intel_pcie
      PCI: mediatek-gen3: Rename mtk_pcie_port to mtk_gen3_pcie
      PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie
      PCI: uniphier: Rename uniphier_pcie_priv to uniphier_pcie
      PCI: xgene: Rename xgene_pcie_port to xgene_pcie
      PCI: xilinx: Rename xilinx_pcie_port to xilinx_pcie

Florian Fainelli (1):
      PCI: brcmstb: Do not use __GENMASK

Greg Kroah-Hartman (1):
      PCI/sysfs: Use default_groups in kobj_type for slot attrs

Hans de Goede (2):
      PCI: Convert pci_dev_present() stub to static inline
      PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors

Hector Martin (2):
      PCI: apple: Enable clock gating
      PCI: apple: Fix REFCLK1 enable/poll logic

Hou Zhiqiang (1):
      PCI: layerscape: Change to use the DWC common link-up check function

Jianjun Wang (1):
      PCI: mediatek-gen3: Disable DVFSRC voltage request

Jim Quinlan (7):
      PCI: brcmstb: Fix function return value handling
      dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
      dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
      PCI: brcmstb: Split brcm_pcie_setup() into two funcs
      PCI: brcmstb: Add mechanism to turn on subdev regulators
      PCI: brcmstb: Add control of subdevice voltage regulators
      PCI: brcmstb: Do not turn off WOL regulators on suspend

Kai-Heng Feng (1):
      PCI: vmd: Honor ACPI _OSC on PCIe features

Karthik L Gopalakrishnan (1):
      PCI: vmd: Add DID 8086:A77F for all Intel Raptor Lake SKU's

Kelvin Cao (2):
      PCI/switchtec: Add Gen4 automotive device IDs
      PCI/switchtec: Declare local state_names[] as static

Kishon Vijay Abraham I (2):
      dt-bindings: PCI: ti,am65: Fix "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
      PCI: keystone: Use phandle argument from "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"

Krzysztof Wilczyński (2):
      PCI: qcom-ep: Remove surplus dev_err() when using platform_get_irq_byname()
      PCI: Correct misspelled words

Li Chen (1):
      PCI: endpoint: Return -EINVAL when interrupts num is smaller than 1

Longji Guo (1):
      x86/PCI: Remove initialization of static variables to false

Lukas Wunner (1):
      PCI: pciehp: Fix infinite loop in IRQ handler upon power fault

Manivannan Sadhasivam (1):
      PCI: qcom: Use __be16 type to store return value from cpu_to_be16()

Marek Vasut (1):
      PCI: rcar: Check if device is runtime suspended instead of __clk_is_enabled()

Ming Wang (1):
      misc: pci_endpoint_test: Terminate statement with semicolon

Naveen Naidu (25):
      PCI: Add PCI_ERROR_RESPONSE and related definitions
      PCI: Set error response data when config read fails
      PCI: Use PCI_SET_ERROR_RESPONSE() for disconnected devices
      PCI: Drop error data fabrication when config read fails
      PCI: thunder: Drop error data fabrication when config read fails
      PCI: iproc: Drop error data fabrication when config read fails
      PCI: mediatek: Drop error data fabrication when config read fails
      PCI: exynos: Drop error data fabrication when config read fails
      PCI: histb: Drop error data fabrication when config read fails
      PCI: kirin: Drop error data fabrication when config read fails
      PCI: aardvark: Drop error data fabrication when config read fails
      PCI: mvebu: Drop error data fabrication when config read fails
      PCI: altera: Drop error data fabrication when config read fails
      PCI: rcar-host: Drop error data fabrication when config read fails
      PCI: rockchip-host: Drop error data fabrication when config read fails
      PCI/ERR: Use PCI_POSSIBLE_ERROR() to check config reads
      PCI: vmd: Use PCI_POSSIBLE_ERROR() to check config reads
      PCI: pciehp: Use PCI_POSSIBLE_ERROR() to check config reads
      PCI/DPC: Use PCI_POSSIBLE_ERROR() to check config reads
      PCI/PME: Use PCI_POSSIBLE_ERROR() to check config reads
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads
      PCI: Use PCI_ERROR_RESPONSE to identify config read errors
      PCI: keystone: Use PCI_ERROR_RESPONSE to identify config read errors
      PCI: hv: Use PCI_ERROR_RESPONSE to identify config read errors
      PCI: xgene: Use PCI_ERROR_RESPONSE to identify config read errors

Nirmal Patel (1):
      PCI: vmd: Clean up domain before enumeration

Pali Rohár (39):
      arm: ioremap: Implement standard PCI function pci_remap_iospace()
      PCI: mvebu: Replace pci_ioremap_io() usage by devm_pci_remap_iospace()
      PCI: mvebu: Remove custom mvebu_pci_host_probe() function
      PCI: pci-bridge-emul: Add description for class_revision field
      PCI: pci-bridge-emul: Add definitions for missing capabilities registers
      PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
      PCI: aardvark: Clear all MSIs at setup
      PCI: aardvark: Comment actions in driver remove method
      PCI: aardvark: Disable bus mastering when unbinding driver
      PCI: aardvark: Mask all interrupts when unbinding driver
      PCI: aardvark: Fix memory leak in driver unbind
      PCI: aardvark: Assert PERST# when unbinding driver
      PCI: aardvark: Disable link training when unbinding driver
      PCI: aardvark: Disable common PHY when unbinding driver
      PCI: aardvark: Fix checking for MEM resource type
      PCI: pci-bridge-emul: Make expansion ROM Base Address register read-only
      PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config space
      PCI: pci-bridge-emul: Fix definitions of reserved bits
      PCI: pci-bridge-emul: Correctly set PCIe capabilities
      PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
      arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
      arm: ioremap: Remove unused ARM-specific function pci_ioremap_io()
      PCI: mvebu: Check for valid ports
      PCI: mvebu: Check for errors from pci_bridge_emul_init() call
      PCI: mvebu: Check that PCI bridge specified in DT has function number zero
      PCI: mvebu: Handle invalid size of read config request
      PCI: mvebu: Disallow mapping interrupts on emulated bridges
      PCI: mvebu: Fix support for bus mastering and PCI_COMMAND on emulated bridge
      PCI: mvebu: Do not modify PCI IO type bits in conf_write
      PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers
      PCI: mvebu: Setup PCIe controller to Root Complex mode
      PCI: mvebu: Set PCI Bridge Class Code to PCI Bridge
      PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge
      PCI: mvebu: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
      PCI: mvebu: Fix support for PCI_EXP_DEVCTL on emulated bridge
      PCI: mvebu: Fix support for PCI_EXP_RTSTA on emulated bridge
      PCI: mvebu: Fix support for DEVCAP2, DEVCTL2 and LNKCTL2 registers on emulated bridge
      bus: mvebu-mbus: Export symbols for public API window functions
      PCI: mvebu: Add support for compiling driver as module

Rajat Jain (1):
      PCI: Use DWORD accesses for LTR, L1 SS to avoid erratum

Richard Zhu (2):
      dt-bindings: imx6q-pcie: Add PHY phandles and name properties
      PCI: imx: Add the imx8mm pcie support

Rikard Falkeborn (1):
      PCI: qcom-ep: Constify static dw_pcie_ep_ops

Rob Herring (1):
      PCI: xgene: Fix IB window setup

Saheed O. Bolarinwa (3):
      PCI/ASPM: Stop caching link L0s, L1 exit latencies
      PCI/ASPM: Stop caching device L0s, L1 acceptable exit latencies
      PCI/ASPM: Remove struct aspm_latency

Sergio Paracuellos (5):
      PCI: mt7621: Declare mt7621_pci_ops static
      PCI: Let pcibios_root_bridge_prepare() access bridge->windows
      PCI: mt7621: Move MIPS setup to pcibios_root_bridge_prepare()
      PCI: mt7621: Add missing MODULE_LICENSE()
      PCI: mt7621: Allow COMPILE_TEST for all arches

Sunil Muthuswamy (2):
      PCI: hv: Make the code arch neutral by adding arch specific interfaces
      PCI: hv: Add arm64 Hyper-V vPCI support

Tim Harvey (1):
      PCI: dwc: Do not remap invalid res

Vaibhav Gupta (3):
      amd64-agp: convert to generic power management
      sis-agp: convert to generic power management
      via-agp: convert to generic power management

Vihas Mak (1):
      PCI: ibmphp: Remove commented-out functions

Yifeng Li (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9125 SATA controller

qizhong cheng (1):
      PCI: mediatek: Assert PERST# for 100ms for power and clock to stabilize

 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |  27 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6 +
 .../devicetree/bindings/pci/ti,am65-pci-ep.yaml    |   8 +-
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml  |  16 +-
 MAINTAINERS                                        |  13 +
 arch/arm/include/asm/io.h                          |   5 +-
 arch/arm/mach-dove/pcie.c                          |   9 +-
 arch/arm/mach-iop32x/pci.c                         |   5 +-
 arch/arm/mach-mv78xx0/pcie.c                       |   5 +-
 arch/arm/mach-orion5x/pci.c                        |  10 +-
 arch/arm/mm/ioremap.c                              |  16 +-
 arch/arm64/include/asm/hyperv-tlfs.h               |   9 +
 arch/mips/ralink/mt7621.c                          |  31 ++
 arch/x86/include/asm/hyperv-tlfs.h                 |  33 ++
 arch/x86/include/asm/mshyperv.h                    |   7 -
 arch/x86/pci/acpi.c                                |   2 +-
 drivers/bus/mvebu-mbus.c                           |   5 +
 drivers/char/agp/amd64-agp.c                       |  24 +-
 drivers/char/agp/sis-agp.c                         |  25 +-
 drivers/char/agp/via-agp.c                         |  25 +-
 drivers/misc/pci_endpoint_test.c                   |   2 +-
 drivers/pci/Kconfig                                |   2 +-
 drivers/pci/access.c                               |  36 +-
 drivers/pci/controller/Kconfig                     |   6 +-
 drivers/pci/controller/cadence/pci-j721e.c         |  18 +-
 drivers/pci/controller/cadence/pcie-cadence-plat.c |   6 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   6 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  81 ++-
 drivers/pci/controller/dwc/pci-keystone.c          |  37 +-
 drivers/pci/controller/dwc/pci-layerscape.c        | 152 +-----
 drivers/pci/controller/dwc/pcie-artpec6.c          |   6 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   6 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   7 +-
 drivers/pci/controller/dwc/pcie-hisi.c             |  32 +-
 drivers/pci/controller/dwc/pcie-histb.c            |   4 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         | 204 ++++----
 drivers/pci/controller/dwc/pcie-kirin.c            |  10 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   6 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  14 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c        |   8 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         | 222 ++++-----
 drivers/pci/controller/dwc/pcie-uniphier.c         | 147 +++---
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c |  84 ++--
 drivers/pci/controller/pci-aardvark.c              |  79 ++-
 drivers/pci/controller/pci-hyperv.c                | 314 +++++++++++-
 drivers/pci/controller/pci-mvebu.c                 | 542 +++++++++++++++------
 drivers/pci/controller/pci-rcar-gen2.c             |  14 +-
 drivers/pci/controller/pci-thunder-ecam.c          |  46 +-
 drivers/pci/controller/pci-thunder-pem.c           |   4 +-
 drivers/pci/controller/pci-xgene-msi.c             |   6 +-
 drivers/pci/controller/pci-xgene.c                 |  58 +--
 drivers/pci/controller/pcie-altera.c               |  12 +-
 drivers/pci/controller/pcie-apple.c                |  10 +-
 drivers/pci/controller/pcie-brcmstb.c              | 304 ++++++++++--
 drivers/pci/controller/pcie-iproc-bcma.c           |  22 +-
 drivers/pci/controller/pcie-iproc-platform.c       |  16 +-
 drivers/pci/controller/pcie-iproc.c                |   4 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        | 382 ++++++++-------
 drivers/pci/controller/pcie-mediatek.c             |  18 +-
 drivers/pci/controller/pcie-microchip-host.c       |  42 +-
 drivers/pci/controller/pcie-mt7621.c               |  75 +--
 drivers/pci/controller/pcie-rcar-host.c            |  14 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   4 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |  44 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |  30 +-
 drivers/pci/controller/pcie-xilinx.c               | 158 +++---
 drivers/pci/controller/vmd.c                       |  61 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |   2 +-
 drivers/pci/endpoint/pci-epc-core.c                |   2 +-
 drivers/pci/hotplug/TODO                           |   5 -
 drivers/pci/hotplug/cpqphp_ctrl.c                  |   4 +-
 drivers/pci/hotplug/ibmphp_core.c                  |  74 ---
 drivers/pci/hotplug/pciehp.h                       |   3 +
 drivers/pci/hotplug/pciehp_core.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  38 +-
 drivers/pci/of.c                                   |   2 +-
 drivers/pci/p2pdma.c                               |   2 +-
 drivers/pci/pci-bridge-emul.c                      | 119 ++++-
 drivers/pci/pci.c                                  |  26 +-
 drivers/pci/pcie/aspm.c                            |  94 ++--
 drivers/pci/pcie/dpc.c                             |   4 +-
 drivers/pci/pcie/pme.c                             |   4 +-
 drivers/pci/probe.c                                |  32 +-
 drivers/pci/quirks.c                               |  26 +-
 drivers/pci/setup-res.c                            |   8 +-
 drivers/pci/slot.c                                 |   3 +-
 drivers/pci/switch/switchtec.c                     |  11 +-
 drivers/pcmcia/at91_cf.c                           |   6 +-
 include/asm-generic/hyperv-tlfs.h                  |  33 --
 include/linux/pci.h                                |  15 +-
 include/linux/pci_ids.h                            |  50 +-
 include/uapi/linux/pci_regs.h                      | 138 +++---
 94 files changed, 2612 insertions(+), 1733 deletions(-)
