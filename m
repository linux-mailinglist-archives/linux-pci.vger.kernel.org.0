Return-Path: <linux-pci+bounces-24957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A9A74D47
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 16:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E071899BD2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04335972;
	Fri, 28 Mar 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIf/mGm/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38194409;
	Fri, 28 Mar 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174191; cv=none; b=XTvAPO6gVgH+7wXw4+AGF2eBogwGW+kjHYNYbfrWdhYuk/ZkVrBrwQijpI771LdcUrDF26N8sJ7TdGMGdW/G5KVtZ5Wy/d+r3hlEZXXD4AtXCp1190/dvFtyrGtVM957wbPV+E6bRYvW7qTPzHh16IILnvRCenum4iP7ywqAM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174191; c=relaxed/simple;
	bh=NmjBOvh9oXBZC8byXcE+ayWw2uog0qfVojOhoaz9cOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aNdU/siULYa2TVLQWuGFLh9BJOvm3xOFlDGYDjYFNAowqCv+vC/vspUL6I9dMuIiaD3SfHoaKiwvZRzxFSFKZgPvL/O/QvR0HP6xe0c3LOwEdVYtirC3YnG48p5GOSvNuR9FXO76odMEwoTXEjt/t9MUqHqmp6pOU09vIBwuGNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIf/mGm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823FC4CEE4;
	Fri, 28 Mar 2025 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743174190;
	bh=NmjBOvh9oXBZC8byXcE+ayWw2uog0qfVojOhoaz9cOo=;
	h=Date:From:To:Cc:Subject:From;
	b=lIf/mGm/nXO4zYoY12RuBHmMZctaaO9tcvpH97itWZmk2WmNDT2+kBUHujkNbuLWF
	 oMtlgkoF0Xbsey2BjkntcsIfDe2Af1NF5dMekjZRMAvJ2iEQ7xHQjZ/UvWueMiFdkr
	 K0s+Q/KVJsyRX/3TOVbM1tJ6eR0BqdMLdh8wEaKjJWJ1WmzjWwSLI17AQGXE05egu4
	 NCgStyYF++B8Ni/h/5ZMEEDhEpAiSU9TxWmWfDcWAyAu1zuX5Nlejbp/pT4ZaXAJrs
	 qTaSxeLDwawV7ITHYNgwMiPAu7eByXnSoBQH9tVC9iTRcrrzMsfO/qtlfLoOVzpRuD
	 JpzyjibO6i3Kw==
Date: Fri, 28 Mar 2025 10:03:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.15
Message-ID: <20250328150308.GA1504545@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.15-changes

for you to fetch changes up to dea140198b846f7432d78566b7b0b83979c72c2b:

  Merge branch 'pci/misc' (2025-03-27 13:15:05 -0500)

----------------------------------------------------------------

Enumeration:

  - Enable Configuration RRS SV, which makes device readiness visible,
    early instead of during child bus scanning (Bjorn Helgaas)

  - Log debug messages about reset methods being used (Bjorn Helgaas)

  - Avoid reset when it has been disabled via sysfs (Nishanth Aravamudan)

  - Add common pci-ep-bus.yaml schema for exporting several peripherals of
    a single PCI function via devicetree (Andrea della Porta)

  - Create DT nodes for PCI host bridges to enable loading device tree
    overlays to create platform devices for PCI devices that have several
    features that require multiple drivers (Herve Codina)

Resource management:

  - Enlarge devres table[] to accommodate bridge windows, ROM, IOV BARs,
    etc., and validate BAR index in devres interfaces (Philipp Stanner)

  - Fix typo that repeatedly distributed resources to a bridge instead of
    iterating over subordinate bridges, which resulted in too little space
    to assign some BARs (Kai-Heng Feng)

  - Relax bridge window tail sizing for optional resources, e.g., IOV BARs,
    to avoid failures when removing and re-adding devices (Ilpo Järvinen)

  - Allow drivers to enable devices even if we haven't assigned optional
    IOV resources to them (Ilpo Järvinen)

  - Rework handling of optional resources (IOV BARs, ROMs) to reduce
    failures if we can't allocate them (Ilpo Järvinen)

  - Fix a NULL dereference in the SR-IOV VF creation error path (Shay
    Drory)

  - Fix s390 mmio_read/write syscalls, which didn't cause page faults in
    some cases, which broke vfio-pci lazy mapping on first access (Niklas
    Schnelle)

  - Add pdev->non_mappable_bars to replace CONFIG_VFIO_PCI_MMAP, which was
    disabled only for s390 (Niklas Schnelle)

  - Support mmap of PCI resources on s390 except for ISM devices (Niklas
    Schnelle)

ASPM:

  - Delay pcie_link_state deallocation to avoid dangling pointers that
    cause invalid references during hot-unplug (Daniel Stodden)

Power management:

  - Allow PCI bridges to go to D3Hot when suspending on all non-x86 systems
    (Manivannan Sadhasivam)

Power control:

  - Create pwrctrl devices in pci_scan_device() to make it more symmetric
    with pci_pwrctrl_unregister() and make pwrctrl devices for PCI bridges
    possible (Manivannan Sadhasivam)

  - Unregister pwrctrl devices in pci_destroy_dev() so DOE, ASPM, etc. can
    still access devices after pci_stop_dev() (Manivannan Sadhasivam)

  - If there's a pwrctrl device for a PCI device, skip scanning it because
    the pwrctrl core will rescan the bus after the device is powered on
    (Manivannan Sadhasivam)

  - Add a pwrctrl driver for PCI slots based on voltage regulators
    described via devicetree (Manivannan Sadhasivam)

Bandwidth control:

  - Add set_pcie_speed.sh to TEST_PROGS to fix issue when executing the
    set_pcie_cooling_state.sh test case (Yi Lai)

  - Avoid a NULL pointer dereference when we run out of bus numbers to
    assign for a bridge secondary bus (Lukas Wunner)

Hotplug:

  - Drop superfluous pci_hotplug_slot_list, try_module_get() calls, and
    NULL pointer checks (Lukas Wunner)

  - Drop shpchp module init/exit logging, replace shpchp dbg() with
    ctrl_dbg(), and remove unused dbg(), err(), info(), warn() wrappers
    (Ilpo Järvinen)

  - Drop 'shpchp_debug' module parameter in favor of standard dynamic
    debugging (Ilpo Järvinen)

  - Drop unused cpcihp .get_power(), .set_power() function pointers
    (Guilherme Giacomo Simoes)

  - Disable hotplug interrupts in portdrv only when pciehp is not enabled
    to avoid issuing two hotplug commands too close together (Feng Tang)

  - Skip pciehp 'device replaced' check if the device has been removed to
    address a deadlock when resuming after a device was removed during
    system sleep (Lukas Wunner)

  - Don't enable pciehp hotplug interupt when resuming in poll mode (Ilpo
    Järvinen)

Virtualization:

  - Fix bugs in 'pci=config_acs=' kernel command line parameter (Tushar
    Dave)

DOE:

  - Expose supported DOE features via sysfs (Alistair Francis)

  - Allow DOE support to be enabled even if CXL isn't enabled (Alistair
    Francis)

Endpoint framework:

  - Convert PCI device data so pci-epf-test works correctly on big-endian
    endpoint systems (Niklas Cassel)

  - Add BAR_RESIZABLE type to endpoint framework and add DWC core support
    for EPF drivers to set BAR_RESIZABLE type and size (Niklas Cassel)

  - Fix pci-epf-test double free that causes an oops if the host reboots
    and PERST# deassertion restarts endpoint BAR allocation (Christian
    Bruel)

  - Fix endpoint BAR testing so tests can skip disabled BARs instead of
    reporting them as failures (Niklas Cassel)

  - Widen endpoint test BAR size variable to accommodate BARs larger than
    INT_MAX (Niklas Cassel)

  - Remove unused tools 'pci' build target left over after moving tests to
    tools/testing/selftests/pci_endpoint (Jianfeng Liu)

Altera PCIe controller driver:

  - Add DT binding and driver support for Agilex family (P-Tile, F-Tile,
    R-Tile) (Matthew Gerlach and D M, Sharath Kumar)

AMD MDB PCIe controller driver:

  - Add DT binding and driver for AMD MDB (Multimedia DMA Bridge)
    (Thippeswamy Havalige)

Broadcom STB PCIe controller driver:

  - Add BCM2712 MSI-X DT binding and interrupt controller drivers and add
    softdep on irq_bcm2712_mip driver to ensure that it is loaded first
    (Stanimir Varbanov)

  - Expand inbound window map to 64GB so it can accommodate BCM2712
    (Stanimir Varbanov)

  - Add BCM2712 support and DT updates (Stanimir Varbanov)

  - Apply link speed restriction before bringing link up, not after (Jim
    Quinlan)

  - Update Max Link Speed in Link Capabilities via the internal writable
    register, not the read-only config register (Jim Quinlan)

  - Handle regulator_bulk_get() error to avoid panic when we call
    regulator_bulk_free() later (Jim Quinlan)

  - Disable regulators only when removing the bus immediately below a Root
    Port because we don't support regulators deeper in the hierarchy (Jim
    Quinlan)

  - Make const read-only arrays static (Colin Ian King)

Cadence PCIe endpoint driver:

  - Correct MSG TLP generation so endpoints can generate INTx messages
    (Hans Zhang)

Freescale i.MX6 PCIe controller driver:

  - Identify the second controller on i.MX8MQ based on devicetree
    'linux,pci-domain' instead of DBI 'reg' address (Richard Zhu)

  - Remove imx_pcie_cpu_addr_fixup() since dwc core can now derive the ATU
    input address (using parent_bus_offset) from devicetree (Frank Li)

Freescale Layerscape PCIe controller driver:

  - Drop deprecated 'num-ib-windows' and 'num-ob-windows' and unnecessary
    'status' from example (Krzysztof Kozlowski)

  - Correct the syscon_regmap_lookup_by_phandle_args("fsl,pcie-scfg")
    arg_count to fix probe failure on LS1043A (Ioana Ciornei)

HiSilicon STB PCIe controller driver:

  - Call phy_exit() to clean up if histb_pcie_probe() fails (Christophe
    JAILLET)

Intel Gateway PCIe controller driver:

  - Remove intel_pcie_cpu_addr() since dwc core can now derive the ATU
    input address (using parent_bus_offset) from devicetree (Frank Li)

Intel VMD host bridge driver:

  - Convert vmd_dev.cfg_lock from spinlock_t to raw_spinlock_t so
    pci_ops.read() will never sleep, even on PREEMPT_RT where spinlock_t
    becomes a sleepable lock, to avoid calling a sleeping function from
    invalid context (Ryo Takakura)

MediaTek PCIe Gen3 controller driver:

  - Remove leftover mac_reset assert for Airoha EN7581 SoC (Lorenzo
    Bianconi)

  - Add EN7581 PBUS controller 'mediatek,pbus-csr' DT property and program
    host bridge memory aperture to this syscon node (Lorenzo Bianconi)

Qualcomm PCIe controller driver:

  - Add qcom,pcie-ipq5332 binding (Varadarajan Narayanan)

  - Add qcom i.MX8QM and i.MX8QXP/DXP optional DMA interrupt (Alexander
    Stein)

  - Add optional dma-coherent DT property for Qualcomm SA8775P (Dmitry
    Baryshkov)

  - Make DT iommu property required for SA8775P and prohibited for SDX55
    (Dmitry Baryshkov)

  - Add DT IOMMU and DMA-related properties for Qualcomm SM8450 (Dmitry
    Baryshkov)

  - Add endpoint DT properties for SAR2130P and enable endpoint mode in
    driver (Dmitry Baryshkov)

  - Describe endpoint BAR0 and BAR2 as 64-bit only and BAR1 and BAR3 as
    RESERVED (Manivannan Sadhasivam)

Rockchip DesignWare PCIe controller driver:

  - Describe rk3568 and rk3588 BARs as Resizable, not Fixed (Niklas Cassel)

Synopsys DesignWare PCIe controller driver:

  - Add debugfs-based Silicon Debug, Error Injection, Statistical Counter
    support for DWC (Shradha Todi)

  - Add debugfs property to expose LTSSM status of DWC PCIe link (Hans
    Zhang)

  - Add Rockchip support for DWC debugfs features (Niklas Cassel)

  - Add dw_pcie_parent_bus_offset() to look up the parent bus address of a
    specified 'reg' property and return the offset from the CPU physical
    address (Frank Li)

  - Use dw_pcie_parent_bus_offset() to derive CPU -> ATU addr offset via
    'reg[config]' for host controllers and 'reg[addr_space]' for endpoint
    controllers (Frank Li)

  - Apply struct dw_pcie.parent_bus_offset in ATU users to remove use of
    .cpu_addr_fixup() when programming ATU (Frank Li)

TI J721E PCIe driver:

  - Correct the 'link down' interrupt bit for J784S4 (Siddharth Vadapalli)

TI Keystone PCIe controller driver:

  - Describe AM65x BARs 2 and 5 as Resizable (not Fixed) and reduce
    alignment requirement from 1MB to 64KB (Niklas Cassel)

Xilinx Versal CPM PCIe controller driver:

  - Free IRQ domain in probe error path to avoid leaking it (Thippeswamy
    Havalige)

  - Add DT .compatible "xlnx,versal-cpm5nc-host" and driver support for
    Versal Net CPM5NC Root Port controller (Thippeswamy Havalige)

  - Add driver support for CPM5_HOST1 (Thippeswamy Havalige)

Miscellaneous:

  - Convert fsl,mpc83xx-pcie binding to YAML (J. Neuschäfer)

  - Use for_each_available_child_of_node_scoped() to simplify apple, kirin,
    mediatek, mt7621, tegra drivers (Zhang Zekun)

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA interrupt

Alistair Francis (4):
      PCI/DOE: Rename DOE protocol to feature
      PCI/DOE: Rename Discovery Response Data Object Contents to type
      PCI/DOE: Expose DOE features via sysfs
      PCI/DOE: Allow enabling DOE without CXL

Andrea della Porta (1):
      dt-bindings: PCI: Add common schema for devices accessible through PCI BARs

Bjorn Helgaas (41):
      PCI: Log debug messages about reset method
      PCI: Fix typos
      PCI: Enable Configuration RRS SV early
      PCI: Cache offset of Resizable BAR capability
      PCI: dwc: Consolidate devicetree handling in dw_pcie_host_get_resources()
      PCI: dwc: ep: Call epc_create() early in dw_pcie_ep_init()
      PCI: dwc: ep: Consolidate devicetree handling in dw_pcie_ep_get_resources()
      Merge branch 'pci/acs'
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/bwctrl'
      Merge branch 'pci/devres'
      Merge branch 'pci/doe'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/pm'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/devtree-create'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/endpoint-test'
      Merge branch 'pci/epf-mhi'
      Merge branch 'pci/scoped-cleanup'
      Merge branch 'pci/controller/altera'
      Merge branch 'pci/controller/amd-mdb'
      Merge branch 'pci/controller/brcmstb'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/histb'
      Merge branch 'pci/controller/hyperv'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/j721e'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xilinx-cpm'
      Merge branch 'pci/controller/dwc-cpu-addr-fixup'
      Merge branch 'pci/misc'

Charles Han (1):
      PCI: mediatek-gen3: Fix inconsistent indentation

Christian Bruel (1):
      PCI: endpoint: pci-epf-test: Fix double free that causes kernel to oops

Christophe JAILLET (1):
      PCI: histb: Fix an error handling path in histb_pcie_probe()

Colin Ian King (1):
      PCI: brcmstb: Make const read-only arrays static

D M, Sharath Kumar (1):
      PCI: altera: Add Agilex support

Dan Carpenter (2):
      PCI: Remove stray put_device() in pci_register_host_bridge()
      PCI: dwc: ep: Return -ENOMEM for allocation failures

Daniel Stodden (1):
      PCI/ASPM: Fix link state exit during switch upstream function removal

Dmitry Baryshkov (6):
      dt-bindings: PCI: qcom-ep: Describe optional dma-coherent property
      dt-bindings: PCI: qcom-ep: Describe optional IOMMU
      dt-bindings: PCI: qcom-ep: Enable DMA for SM8450
      dt-bindings: PCI: qcom-ep: Consolidate DMA vs non-DMA cases
      dt-bindings: PCI: qcom-ep: Add SAR2130P compatible
      PCI: qcom-ep: Enable EP mode support for SAR2130P

Easwar Hariharan (1):
      PCI: hv: Correct a comment

Feng Tang (1):
      PCI/portdrv: Only disable pciehp interrupts early when needed

Frank Li (11):
      PCI: dwc: Use resource start as ioremap() input in dw_pcie_pme_turn_off()
      PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
      PCI: dwc: Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init()
      PCI: dwc: Add dw_pcie_parent_bus_offset()
      PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
      PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr offset
      PCI: dwc: ep: Use devicetree 'reg[addr_space]' to derive CPU -> ATU addr offset
      PCI: dwc: ep: Ensure proper iteration over outbound map windows
      PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()
      PCI: imx6: Remove imx_pcie_cpu_addr_fixup()
      PCI: intel-gw: Remove intel_pcie_cpu_addr()

Guilherme Giacomo Simoes (1):
      PCI: cpcihp: Remove unused .get_power() and .set_power()

Hans Zhang (2):
      PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload
      PCI: dwc: Add debugfs property to provide LTSSM status of the PCIe link

Herve Codina (5):
      driver core: Introduce device_{add,remove}_of_node()
      PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
      PCI: of_property: Add support for NULL pdev in of_pci_set_address()
      PCI: of_property: Constify parameter in of_pci_get_addr_flags()
      PCI: of: Create device tree PCI host bridge node

Ilpo Järvinen (40):
      PCI: Cleanup dev->resource + resno to use pci_resource_n()
      PCI: Remove add_align overwrite unrelated to size0
      PCI: Use min_align, not unrelated add_align, for size0
      PCI: Simplify size1 assignment logic
      PCI: Allow relaxed bridge window tail sizing for optional resources
      PCI: Fix old_size lower bound in calculate_iosize() too
      PCI: Use SZ_* instead of literals in setup-bus.c
      PCI: Use resource_set_{range,size}() helpers
      PCI: Check resource_size() separately
      PCI: Add pci_resource_num() helper
      PCI: Add dev & res local variables to resource assignment funcs
      PCI: Converge return paths in __assign_resources_sorted()
      PCI: Refactor pdev_sort_resources() & __dev_sort_resources()
      PCI: Use while loop and break instead of gotos
      PCI: Rename retval to ret
      PCI: Consolidate assignment loop next round preparation
      PCI: Remove incorrect comment from pci_reassign_resource()
      PCI: Add restore_dev_resource()
      PCI: Extend enable to check for any optional resource
      PCI: Always have realloc_head in __assign_resources_sorted()
      PCI: Indicate optional resource assignment failures
      PCI: Add debug print when releasing resources before retry
      PCI: Use res->parent to check if resource is assigned
      PCI: Perform reset_resource() and build fail list in sync
      PCI: Rework optional resource handling
      PCI: shpchp: Remove logging from module init/exit functions
      PCI: shpchp: Change dbg() -> ctrl_dbg()
      PCI: shpchp: Remove unused logging wrappers
      PCI: shpchp: Remove 'shpchp_debug' module parameter
      PCI/AER: Descope pci_printk() to aer_printk()
      PCI: Track Flit Mode Status & print it with link status
      PCI/ERR: Handle TLP Log in Flit mode
      PCI: Do not claim to release resource falsely
      PCI: Fix BAR resizing when VF BARs are assigned
      PCI: Move pci_rescan_bus_bridge_resize() declaration to pci/pci.h
      PCI: Move resource reassignment func declarations into pci/pci.h
      PCI: Make pci_setup_bridge() static
      PCI: Move cardbus IO size declarations into pci/pci.h
      PCI: pciehp: Don't enable HPIE when resuming in poll mode
      PCI/bwctrl: Fix pcie_bwctrl_select_speed() return type

Ioana Ciornei (1):
      PCI: layerscape: Fix arg_count to syscon_regmap_lookup_by_phandle_args()

J. Neuschäfer (1):
      dt-bindings: PCI: Convert fsl,mpc83xx-pcie to YAML

Jianfeng Liu (1):
      tools/Makefile: Remove pci target

Jim Quinlan (8):
      PCI: brcmstb: Set generation limit before PCIe link up
      PCI: brcmstb: Use internal register to change link capability
      PCI: brcmstb: Do not assume that register field starts at LSB
      PCI: brcmstb: Fix error path after a call to regulator_bulk_get()
      PCI: brcmstb: Fix potential premature regulator disabling
      PCI: brcmstb: Use same constant table for config space access
      PCI: brcmstb: Make two changes in MDIO register fields
      PCI: brcmstb: Make irq_domain_set_info() parameter cast explicit

Kai-Heng Feng (1):
      PCI: Use downstream bridges for distributing resources

Krzysztof Kozlowski (2):
      dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop deprecated windows
      dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop unnecessary status from example

Kunihiko Hayashi (6):
      selftests: pci_endpoint: Add GET_IRQTYPE checks to each interrupt test
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
      misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'
      misc: pci_endpoint_test: Do not use managed IRQ functions

Lorenzo Bianconi (3):
      PCI: mediatek-gen3: Remove leftover mac_reset assert for Airoha EN7581 SoC
      dt-bindings: PCI: mediatek-gen3: Add mediatek,pbus-csr phandle array property
      PCI: mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC

Lukas Wunner (7):
      PCI: hotplug: Drop superfluous pci_hotplug_slot_list
      PCI: hotplug: Drop superfluous try_module_get() calls
      PCI: hotplug: Drop superfluous NULL pointer checks in has_*_file()
      PCI: hotplug: Avoid backpointer dereferencing in has_*_file()
      PCI: hotplug: Inline pci_hp_{create,remove}_module_link()
      PCI: pciehp: Avoid unnecessary device replacement check
      PCI/bwctrl: Fix NULL pointer dereference on bus number exhaustion

Ma Ke (2):
      PCI: Fix reference leak in pci_register_host_bridge()
      PCI: Fix reference leak in pci_alloc_child_bus()

Manivannan Sadhasivam (8):
      PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
      PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
      PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created
      dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
      PCI/pwrctrl: Add pwrctrl driver for PCI slots
      PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
      perf/dwc_pcie: Move common DWC struct definitions to 'pcie-dwc.h'
      PCI: Allow PCI bridges to go to D3Hot on all non-x86

Matthew Gerlach (1):
      dt-bindings: PCI: altera: Add binding for Agilex

Michał Winiarski (1):
      PCI: Add pci_resource_is_iov() to identify IOV resources

Mrinmay Sarkar (1):
      PCI: epf-mhi: Update device ID for SA8775P

Niklas Cassel (24):
      PCI: dwc: Add Rockchip to the RAS DES allowed vendor list
      selftests: pci_endpoint: Skip disabled BARs
      misc: pci_endpoint_test: Fix pci_endpoint_test_bars_read_bar() error handling
      misc: pci_endpoint_test: Fix potential truncation in pci_endpoint_test_probe()
      misc: pci_endpoint_test: Give disabled BARs a distinct error code
      misc: pci_endpoint_test: Handle BAR sizes larger than INT_MAX
      PCI: endpoint: pci-epf-test: Handle endianness properly
      PCI: endpoint: Allow EPF drivers to configure the size of Resizable BARs
      PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
      PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
      PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable BARs
      PCI: keystone: Describe Resizable BARs as Resizable BARs
      PCI: keystone: Specify correct alignment requirement
      PCI: dw-rockchip: Describe Resizable BARs as Resizable BARs
      PCI: dwc: ep: Remove superfluous function dw_pcie_ep_find_ext_capability()
      PCI: endpoint: pcitest: Add IRQ_TYPE_* defines to UAPI header
      misc: pci_endpoint_test: Use IRQ_TYPE_* defines from UAPI header
      selftests: pci_endpoint: Use IRQ_TYPE_* defines from UAPI header
      PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
      PCI: dw-rockchip: Hide broken ATS capability for RK3588 running in EP mode
      PCI: endpoint: Add intx_capable to epc_features struct
      PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts
      PCI: endpoint: pci-epf-test: Expose supported IRQ types in CAPS register
      misc: pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO

Niklas Schnelle (3):
      s390/pci: Fix s390_mmio_read/write syscall page fault handling
      s390/pci: Introduce pdev->non_mappable_bars and replace VFIO_PCI_MMAP
      s390/pci: Support mmap() of PCI resources except for ISM devices

Nishanth Aravamudan (1):
      PCI: Avoid reset when disabled via sysfs

Philipp Stanner (2):
      PCI: Fix wrong length of devres array
      PCI: Check BAR index for validity

Richard Zhu (2):
      PCI: imx6: Identify controller via 'linux,pci-domain', not address
      PCI: imx6: Use devm_clk_bulk_get_all() to fetch clocks

Ryo Takakura (1):
      PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type

Shawn Lin (1):
      PCI: Add Rockchip Vendor ID

Shay Drory (1):
      PCI: Fix NULL dereference in SR-IOV VF creation error path

Shradha Todi (4):
      PCI: dwc: Add helper to find the Vendor Specific Extended Capability (VSEC)
      PCI: dwc: Add debugfs based Silicon Debug support for DWC
      PCI: dwc: Add debugfs based Error Injection support for DWC
      PCI: dwc: Add debugfs based Statistical Counter support for DWC

Siddharth Vadapalli (1):
      PCI: j721e: Fix the value of .linkdown_irq_regfield for J784S4

Stanimir Varbanov (8):
      PCI: brcmstb: Fix missing of_node_put() in brcm_pcie_probe()
      dt-bindings: interrupt-controller: Add BCM2712 MSI-X bindings
      dt-bindings: PCI: brcmstb: Update bindings for PCIe on BCM2712
      irqchip: Add Broadcom BCM2712 MSI-X interrupt controller
      PCI: brcmstb: Add a softdep to MIP MSI-X driver
      PCI: brcmstb: Reuse pcie_cfg_data structure
      PCI: brcmstb: Expand inbound window size up to 64GB
      PCI: brcmstb: Add BCM2712 support

Thippeswamy Havalige (7):
      dt-bindings: PCI: dwc: Add AMD Versal2 MDB SLCR support
      dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
      PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe
      dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal Net host
      PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port controller
      PCI: amd-mdb: Add AMD MDB Root Port driver
      PCI: xilinx-cpm: Add cpm_csr register mapping for CPM5_HOST1 variant

Tushar Dave (1):
      PCI/ACS: Fix 'pci=config_acs=' parameter

Varadarajan Narayanan (1):
      dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller

Yi Lai (1):
      selftests/pcie_bwctrl: Add 'set_pcie_speed.sh' to TEST_PROGS

Zhang Zekun (6):
      PCI: kirin: Use helper function for_each_available_child_of_node_scoped()
      PCI: kirin: Tidy up _probe() related function with dev_err_probe()
      PCI: mediatek: Use helper function for_each_available_child_of_node_scoped()
      PCI: mt7621: Use helper function for_each_available_child_of_node_scoped()
      PCI: apple: Use helper function for_each_child_of_node_scoped()
      PCI: tegra: Use helper function for_each_child_of_node_scoped()

Zhiyuan Dai (1):
      PCI: Increase Resizable BAR support from 512 GB to 128 TB

Zijun Hu (1):
      PCI: endpoint: Remove unused devm_pci_epc_destroy()

 Documentation/ABI/testing/debugfs-dwc-pcie         | 157 +++++
 Documentation/ABI/testing/sysfs-bus-pci            |  29 +
 Documentation/PCI/endpoint/pci-endpoint.rst        |   7 +-
 .../interrupt-controller/brcm,bcm2712-msix.yaml    |  60 ++
 .../bindings/pci/altr,pcie-root-port.yaml          |  10 +
 .../bindings/pci/amd,versal2-mdb-host.yaml         | 121 ++++
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   6 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   4 +
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml       |   3 -
 .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 113 ++++
 Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -
 .../bindings/pci/mediatek-pcie-gen3.yaml           |  17 +
 .../devicetree/bindings/pci/pci-ep-bus.yaml        |  58 ++
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 100 ++-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |   8 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   2 +
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +-
 MAINTAINERS                                        |   1 +
 arch/s390/Kconfig                                  |   4 +-
 arch/s390/include/asm/pci.h                        |   3 +
 arch/s390/pci/Makefile                             |   2 +-
 arch/s390/pci/pci_fixup.c                          |  23 +
 arch/s390/pci/pci_mmio.c                           |  18 +-
 drivers/base/core.c                                |  61 ++
 drivers/irqchip/Kconfig                            |  16 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-bcm2712-mip.c                  | 292 +++++++++
 drivers/misc/pci_endpoint_test.c                   | 131 ++--
 drivers/pci/Kconfig                                |   5 +-
 drivers/pci/bus.c                                  |  43 --
 drivers/pci/controller/cadence/pci-j721e.c         |   5 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  11 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   2 +-
 drivers/pci/controller/dwc/Kconfig                 |  21 +
 drivers/pci/controller/dwc/Makefile                |   2 +
 drivers/pci/controller/dwc/pci-imx6.c              | 106 +---
 drivers/pci/controller/dwc/pci-keystone.c          |   6 +-
 drivers/pci/controller/dwc/pci-layerscape.c        |   2 +-
 drivers/pci/controller/dwc/pcie-amd-mdb.c          | 476 +++++++++++++++
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 677 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 321 ++++++++--
 drivers/pci/controller/dwc/pcie-designware-host.c  |  61 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 142 ++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  82 ++-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  53 +-
 drivers/pci/controller/dwc/pcie-histb.c            |  12 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |   8 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |  50 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  17 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  12 +-
 drivers/pci/controller/pci-hyperv.c                |   2 +-
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/controller/pci-tegra.c                 |  80 +--
 drivers/pci/controller/pci-thunder-ecam.c          |   2 +-
 drivers/pci/controller/pci-xgene-msi.c             |   2 +-
 drivers/pci/controller/pcie-altera.c               | 257 +++++++-
 drivers/pci/controller/pcie-apple.c                |   4 +-
 drivers/pci/controller/pcie-brcmstb.c              | 202 +++---
 drivers/pci/controller/pcie-mediatek-gen3.c        |  64 +-
 drivers/pci/controller/pcie-mediatek.c             |  15 +-
 drivers/pci/controller/pcie-mt7621.c               |  15 +-
 drivers/pci/controller/pcie-rcar-host.c            |  10 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   2 +-
 drivers/pci/controller/pcie-rockchip.h             |   1 -
 drivers/pci/controller/pcie-xilinx-cpm.c           |  53 +-
 drivers/pci/controller/vmd.c                       |  12 +-
 drivers/pci/devres.c                               |  18 +-
 drivers/pci/doe.c                                  | 247 ++++++--
 drivers/pci/endpoint/Kconfig                       |   2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++--
 drivers/pci/endpoint/pci-epc-core.c                |  56 +-
 drivers/pci/endpoint/pci-epf-core.c                |   4 +
 drivers/pci/hotplug/Kconfig                        |   2 +-
 drivers/pci/hotplug/cpci_hotplug.h                 |   2 -
 drivers/pci/hotplug/cpci_hotplug_core.c            |  17 +-
 drivers/pci/hotplug/pci_hotplug_core.c             | 142 ++---
 drivers/pci/hotplug/pciehp_core.c                  |   5 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  11 +-
 drivers/pci/hotplug/shpchp.h                       |  18 +-
 drivers/pci/hotplug/shpchp_core.c                  |  13 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |   2 +-
 drivers/pci/iomap.c                                |  29 +-
 drivers/pci/iov.c                                  |  50 +-
 drivers/pci/msi/api.c                              |   2 +-
 drivers/pci/of.c                                   | 127 +++-
 drivers/pci/of_property.c                          | 115 +++-
 drivers/pci/pci-sysfs.c                            |  11 +-
 drivers/pci/pci.c                                  |  72 ++-
 drivers/pci/pci.h                                  |  89 ++-
 drivers/pci/pcie/aer.c                             |  79 +--
 drivers/pci/pcie/aspm.c                            |  17 +-
 drivers/pci/pcie/bwctrl.c                          |   6 +-
 drivers/pci/pcie/dpc.c                             |  18 +-
 drivers/pci/pcie/portdrv.c                         |   8 +-
 drivers/pci/pcie/tlp.c                             |  56 +-
 drivers/pci/probe.c                                |  78 ++-
 drivers/pci/proc.c                                 |   4 +
 drivers/pci/pwrctrl/Kconfig                        |  11 +
 drivers/pci/pwrctrl/Makefile                       |   3 +
 drivers/pci/pwrctrl/core.c                         |   2 +-
 drivers/pci/pwrctrl/slot.c                         |  93 +++
 drivers/pci/quirks.c                               |   4 +-
 drivers/pci/remove.c                               |   5 +-
 drivers/pci/setup-bus.c                            | 577 ++++++++++--------
 drivers/pci/setup-res.c                            |  24 +-
 drivers/pci/slot.c                                 |  44 --
 drivers/perf/dwc_pcie_pmu.c                        |  25 +-
 drivers/s390/net/ism_drv.c                         |   1 -
 drivers/vfio/pci/Kconfig                           |   4 -
 drivers/vfio/pci/vfio_pci_core.c                   |   2 +-
 include/linux/aer.h                                |  12 +-
 include/linux/device.h                             |   2 +
 include/linux/pci-epc.h                            |   8 +-
 include/linux/pci-epf.h                            |  17 +-
 include/linux/pci.h                                |  14 +-
 include/linux/pci_hotplug.h                        |   2 -
 include/linux/pci_ids.h                            |   3 +
 include/linux/pcie-dwc.h                           |  38 ++
 include/ras/ras_event.h                            |  12 +-
 include/uapi/linux/pci_regs.h                      |  13 +-
 include/uapi/linux/pcitest.h                       |   6 +
 tools/Makefile                                     |  13 +-
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  31 +-
 tools/testing/selftests/pcie_bwctrl/Makefile       |   2 +-
 126 files changed, 5062 insertions(+), 1464 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/fsl,pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 create mode 100644 arch/s390/pci/pci_fixup.c
 create mode 100644 drivers/irqchip/irq-bcm2712-mip.c
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 drivers/pci/pwrctrl/slot.c
 create mode 100644 include/linux/pcie-dwc.h

