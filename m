Return-Path: <linux-pci+bounces-10558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122F937DDD
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 00:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E41281FEA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 22:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92E81487FF;
	Fri, 19 Jul 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGxbAswK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75098824AF;
	Fri, 19 Jul 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721429097; cv=none; b=R8pFM3EJh9XYt+EfNFie1ATf6UgLVu5vBsZTsoXC091BnXyyB6Srb0ZGOhqtBHSqeAcFibJS/cv3j+TdkkGmqV/v203emfiQrLCd379H4Wy4CflZsU/yVlwF72xe/cOIaG9b+Q20jWWQgbXERb6GF2+RuQLosJiykIGDdu3t2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721429097; c=relaxed/simple;
	bh=EYMo3BN4sUnKI5E8b44fmemewq4X4eQM0kTmnxJHc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Coosty5QkQPNdJ1o0PKxA39XFGzpoygS5k8BbNvIzIXlYQ97BNHxEcye3MTdi3qbVf3jPvmAZGPfpNdD8XTy0T3/A+lxLJqAN6hnItV/aRyMrAiF/cT74U9LS/VLo6C49Eb4397qSH517Bs9vtFeKjAzG/y4zpS45HjchG3Y+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGxbAswK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313DAC4AF09;
	Fri, 19 Jul 2024 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721429096;
	bh=EYMo3BN4sUnKI5E8b44fmemewq4X4eQM0kTmnxJHc6g=;
	h=Date:From:To:Cc:Subject:From;
	b=sGxbAswKpYYLViISM5n9SXGxuXIJ9qND5OGcYFZYZuWbXGRDgX010Pt9dTlfSm2v/
	 sOyuu+O2mkd8yaLCW3ChTDpA4PWNE1iGOaX/3HXWMFXAHiAFivuS39jvesOnNT7PsZ
	 cKsTMqe6mMjF3ARyw15+fjLD/GN9MvqIk5n6fOHGKLfMz1pgWQXH2i4s54Kn27Dv30
	 kx0BfV/IvD5shNqca5i4R6+Tcl24MvyT9k586PamOGAUxZAFdaURyT6HH5ObU4TX15
	 kSoCnbnacYXqUTlmZHBo7MLBpZ9as4SFNilEIa8pAuom57EF8Yv4fbnYKi1tsCt1aJ
	 q5OoM3TA0PgyA==
Date: Fri, 19 Jul 2024 17:44:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.11
Message-ID: <20240719224454.GA657774@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.11-changes

for you to fetch changes up to 45659274e60864f9acabba844468e405362bdc8c:

  Merge branch 'pci/misc' (2024-07-19 10:10:33 -0500)


N.B. There should be a minor conflict in drivers/pci/pci.c between
c9d52fb313d3 ("PCI: Revert the cfg_access_lock lockdep mechanism"),
which is already upstream, and 920f6468924f ("PCI: Warn on missing
cfg_access_lock during secondary bus reset") which is included in this
pull request.

----------------------------------------------------------------

Enumeration:

  - Define PCIE_RESET_CONFIG_DEVICE_WAIT_MS for the generic 100ms required
    after reset before config access (Kevin Xie)

  - Define PCIE_T_RRS_READY_MS for the generic 100ms required after reset
    before config access (probably should be unified with
    PCIE_RESET_CONFIG_DEVICE_WAIT_MS) (Damien Le Moal)

Resource management:

  - Rename find_resource() to find_resource_space() to be more descriptive
    (Ilpo Järvinen)

  - Export find_resource_space() for use by PCI core, which needs to learn
    whether there is available space for a bridge window (Ilpo Järvinen)

  - Prevent double counting of resources so window size doesn't grow on
    each remove/rescan cycle (Ilpo Järvinen)

  - Relax bridge window sizing algorithm so a device doesn't break simply
    because it was removed and rescanned (Ilpo Järvinen)

  - Evaluate the ACPI PRESERVE_BOOT_CONFIG _DSM in
    pci_register_host_bridge() (not acpi_pci_root_create()) so we can unify
    it with similar DT functionality (Vidya Sagar)

  - Extend use of DT "linux,pci-probe-only" property so it works per-host
    bridge as well as globally (Vidya Sagar)

  - Unify support for ACPI PRESERVE_BOOT_CONFIG _DSM and the DT
    "linux,pci-probe-only" property in pci_preserve_config() (Vidya Sagar)

Driver binding:

  - Add devres infrastructure for managed request and map of partial BAR
    resources (Philipp Stanner)

  - Deprecate pcim_iomap_table() because uses like "pcim_iomap_table()[0]"
    have no good way to return errors (Philipp Stanner)

  - Add an always-managed pcim_request_region() for use instead of
    pci_request_region() and similar, which are sometimes managed depending
    on whether pcim_enable_device() has been called previously (Philipp
    Stanner)

  - Reimplement pcim_set_mwi() so it doesn't need to keep store MWI state
    (Philipp Stanner)

  - Add pcim_intx() for use instead of pci_intx(), which is sometimes
    managed depending on whether pcim_enable_device() has been called
    previously (Philipp Stanner)

  - Add managed pcim_iomap_range() to allow mapping of a partial BAR
    (Philipp Stanner)

  - Fix a devres mapping leak in drm/vboxvideo (Philipp Stanner)

Error handling:

  - Add missing bridge locking in device reset path and add a warning for
    other possible lock issues (Dan Williams)

  - Fix use-after-free on concurrent DPC and hot-removal (Lukas Wunner)

Power management:

  - Disable AER and DPC during suspend to avoid spurious wakeups if they
    share an interrupt with PME (Kai-Heng Feng)

PCIe native device hotplug:

  - Detect if a device was removed or replaced during system sleep so we
    don't assume a new device is the one that used to be there (Lukas
    Wunner)

Virtualization:

  - Add an ACS quirk for Broadcom BCM5760X multi-function NIC; it prevents
    transactions between functions even though it doesn't advertise ACS, so
    the functions can be attached individually via VFIO (Ajit Khaparde)

Peer-to-peer DMA:

  - Add a "pci=config_acs=" kernel command-line parameter to relax default
    ACS settings to enable additional peer-to-peer configurations.
    Requires expert knowledge of topology and ACS operation (Vidya Sagar)

Endpoint framework:

  - Remove unused struct pci_epf_group.type_group (Christophe JAILLET)

  - Fix error handling in vpci_scan_bus() and epf_ntb_epc_cleanup() (Dan
    Carpenter)

  - Make struct pci_epc_class constant (Greg Kroah-Hartman)

  - Remove unused pci_endpoint_test_bar_{readl,writel} functions (Jiapeng
    Chong)

  - Rename "BME" to "Bus Master Enable" (Manivannan Sadhasivam)

  - Rename struct pci_epc_event_ops.core_init() callback to epc_init()
    (Manivannan Sadhasivam)

  - Move DMA init to MHI .epc_init() callback for uniformity (Manivannan
    Sadhasivam)

  - Cancel EPF test delayed work when link goes down (Manivannan
    Sadhasivam)

  - Add struct pci_epc_event_ops.epc_deinit() callback for cleanup needed
    on fundamental reset (Manivannan Sadhasivam)

  - Add 64KB alignment to endpoint test to support Rockchip rk3588 (Niklas
    Cassel)

  - Optimize endpoint test by using memcpy() instead of readl() (Niklas
    Cassel) 

Device tree bindings:

  - Add generic "ats-supported" property to advertise that a PCIe Root
    Complex supports ATS (Jean-Philippe Brucker)

Amazon Annapurna Labs PCIe controller driver:

  - Validate IORESOURCE_BUS presence to avoid NULL pointer dereference
    (Aleksandr Mishin)

Axis ARTPEC-6 PCIe controller driver:

  - Rename .cpu_addr_fixup() parameter to reflect that it is a PCI address,
    not a CPU address (Niklas Cassel)

Freescale i.MX6 PCIe controller driver:

  - Convert to agnostic GPIO API (Andy Shevchenko)

Freescale Layerscape PCIe controller driver:

  - Make struct mobiveil_rp_ops constant (Christophe JAILLET)

  - Use new generic dw_pcie_ep_linkdown() to handle link-down events
    (Manivannan Sadhasivam)

HiSilicon Kirin PCIe controller driver:

  - Convert to agnostic GPIO API (Andy Shevchenko)

  - Use _scoped() iterator for OF children to ensure refcounts are
    decremented at loop exit (Javier Carrasco)

Intel VMD host bridge driver:

  - Create sysfs "domain" symlink before downstream devices are exposed to
    userspace by pci_bus_add_devices() (Jiwei Sun)

Loongson PCIe controller driver:

  - Enable MSI when LS7A is used with new CPUs that have integrated PCIe
    Root Complex,  e.g., Loongson-3C6000, so downstream devices can use MSI
    (Huacai Chen)

Microchip AXI PolarFlare PCIe controller driver:

  - Move pcie-microchip-host.c to a new PLDA directory (Minda Chen)

  - Factor PLDA generic items out to a common
    plda,xpressrich3-axi-common.yaml binding (Minda Chen)

  - Factor PLDA generic data structures and code out to shared pcie-plda.h,
    pcie-plda-host.c (Minda Chen)

  - Add PLDA generic interrupt handling with a .request_event_irq()
    callback for vendor-specific events (Minda Chen)

  - Add PLDA generic host init/deinit and map bus functions for use by
    vendor-specific drivers (Minda Chen)

  - Rework to use PLDA core (Minda Chen)

Microsoft Hyper-V host bridge driver:

  - Return zero, not garbage, when reading PCI_INTERRUPT_PIN (Wei Liu)

NVIDIA Tegra194 PCIe controller driver:

  - Remove unused struct tegra_pcie_soc (Dr. David Alan Gilbert)

  - Set 64KB inbound ATU alignment restriction (Jon Hunter)

Qualcomm PCIe controller driver:

  - Make the MHI reg region mandatory for X1E80100, since all PCIe
    controllers have it (Abel Vesa)

  - Prevent use of uninitialized data and possible error pointer
    dereference (Dan Carpenter)

  - Return error, not success, if dev_pm_opp_find_freq_floor() fails (Dan
    Carpenter)

  - Add Operating Performance Points (OPP) support to scale performance
    state based on aggregate link bandwidth to improve SoC power efficiency
    (Krishna chaitanya chundru)

  - Vote for the CPU-PCIe ICC (interconnect) path to ensure it stays active
    even if other drivers don't vote for it (Krishna chaitanya chundru)

  - Use devm_clk_bulk_get_all() to get all the clocks from DT to avoid
    writing out all the clock names (Manivannan Sadhasivam)

  - Add DT binding and driver support for the SA8775P SoC (Mrinmay Sarkar)

  - Add HDMA support for the SA8775P SoC (Mrinmay Sarkar)

  - Override the SA8775P NO_SNOOP default to avoid possible memory
    corruption (Mrinmay Sarkar)

  - Make sure resources are disabled during PERST# assertion, even if the
    link is already disabled (Manivannan Sadhasivam)

  - Use new generic dw_pcie_ep_linkdown() to handle link-down events
    (Manivannan Sadhasivam)

  - Add DT and endpoint driver support for the SA8775P SoC (Mrinmay Sarkar)

  - Add Hyper DMA (HDMA) support for the SA8775P SoC and enable it in the
    EPF MHI driver (Mrinmay Sarkar)

  - Set PCIE_PARF_NO_SNOOP_OVERIDE to override the default NO_SNOOP
    attribute on the SA8775P SoC (both Root Complex and Endpoint mode) to
    avoid possible memory corruption (Mrinmay Sarkar)

Renesas R-Car PCIe controller driver:

  - Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup() to avoid
    unnecessary backtrace (Marek Vasut)

  - Add DT and driver support for R-Car V4H (R8A779G0) host and endpoint.
    This requires separate proprietary firmware (Yoshihiro Shimoda)

Rockchip PCIe controller driver:

  - Assert PERST# for 100ms after power is stable (Damien Le Moal)

  - Wait PCIE_T_RRS_READY_MS (100ms) after reset before starting
    configuration (Damien Le Moal)

  - Use GPIOD_OUT_LOW flag while requesting ep_gpio to fix a firmware crash
    on Qcom-based modems with Rockpro64 board (Manivannan Sadhasivam)

Rockchip DesignWare PCIe controller driver:

  - Factor common parts of rockchip-dw-pcie DT binding to be shared by Root
    Complex and Endpoint mode (Niklas Cassel)

  - Add missing INTx signals to common DT binding (Niklas Cassel)

  - Add eDMA items to DT binding for Endpoint controller (Niklas Cassel)

  - Fix initial dw-rockchip PERST# GPIO value to prevent unnecessary short
    assert/deassert that causes issues with some WLAN controllers (Niklas
    Cassel)

  - Refactor dw-rockchip and add support for Endpoint mode (Niklas Cassel)

  - Call pci_epc_init_notify() and drop dw_pcie_ep_init_notify() wrapper
    (Niklas Cassel)

  - Add error messages in .probe() error paths to improve user experience
    (Uwe Kleine-König)

Samsung Exynos PCIe controller driver:

  - Use bulk clock APIs to simplify clock setup (Shradha Todi)

StarFive PCIe controller driver:

  - Add DT binding and driver support for the StarFive JH7110 PLDA-based
    PCIe controller (Minda Chen)

Synopsys DesignWare PCIe controller driver:

  - Add generic support for sending PME_Turn_Off when system suspends
    (Frank Li)

  - Fix incorrect interpretation of iATU slot 0 after PERST#
    assert/deassert (Frank Li)

  - Use msleep() instead of usleep_range() while waiting for link (Konrad
    Dybcio)

  - Refactor dw_pcie_edma_find_chip() to enable adding support for Hyper
    DMA (HDMA) (Manivannan Sadhasivam)

  - Enable drivers to supply the eDMA channel count since some can't auto
    detect this (Manivannan Sadhasivam)

  - Call pci_epc_init_notify() and drop dw_pcie_ep_init_notify() wrapper
    (Manivannan Sadhasivam)

  - Pass the eDMA mapping format directly from drivers instead of
    maintaining a capability for it (Manivannan Sadhasivam)

  - Add generic dw_pcie_ep_linkdown() to notify EPF drivers about link-down
    events and restore non-sticky DWC registers lost on link down
    (Manivannan Sadhasivam)

  - Add vendor-specific "apb" reg name, interrupt names, INTx names to
    generic binding (Niklas Cassel)

  - Enforce DWC restriction that 64-bit BARs must start with an
    even-numbered BAR (Niklas Cassel)

  - Consolidate args of dw_pcie_prog_outbound_atu() into a structure
    (Yoshihiro Shimoda)

  - Add support for endpoints to send Message TLPs, e.g., for INTx
    emulation (Yoshihiro Shimoda)

TI DRA7xx PCIe controller driver:

  - Rename .cpu_addr_fixup() parameter to reflect that it is a PCI address,
    not a CPU address (Niklas Cassel)

TI Keystone PCIe controller driver:

  - Validate IORESOURCE_BUS presence to avoid NULL pointer dereference
    (Aleksandr Mishin)

  - Work around AM65x/DRA80xM Errata #i2037 that corrupts TLPs and causes
    processor hangs by limiting Max_Read_Request_Size (MRRS) and
    Max_Payload_Size (MPS) (Kishon Vijay Abraham I)

  - Leave BAR 0 disabled for AM654x to fix a regression caused by
    6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use
    add_bus"), which caused a 45-second boot delay (Siddharth Vadapalli)

Xilinx Versal CPM PCIe controller driver:

  - Fix overlapping bridge registers and 32-bit BAR addresses in DT binding
    (Thippeswamy Havalige)

MicroSemi Switchtec management driver:

  - Make struct switchtec_class constant (Greg Kroah-Hartman)

Miscellaneous:

  - Remove unused struct acpi_handle_node (Dr. David Alan Gilbert)

  - Add missing MODULE_DESCRIPTION() macros (Jeff Johnson)

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: PCI: qcom: x1e80100: Make the MHI reg region mandatory

Ajit Khaparde (1):
      PCI: Add ACS quirk for Broadcom BCM5760X NIC

Aleksandr Mishin (2):
      PCI: al: Check IORESOURCE_BUS existence during probe
      PCI: keystone: Fix NULL pointer dereference in case of DT error in ks_pcie_setup_rc_app_regs()

Alexander Stein (1):
      Documentation: PCI: pci-endpoint: Fix EPF ops list

Andy Shevchenko (5):
      PCI: dra7xx: Add missing chained IRQ header inclusion
      PCI: aardvark: Remove unused of_gpio.h inclusion
      PCI: dwc: Remove unused of_gpio.h inclusion
      PCI: imx6: Convert to use agnostic GPIO API
      PCI: kirin: Convert to use agnostic GPIO API

Bjorn Helgaas (29):
      Merge branch 'pci/acs'
      Merge branch 'pci/devres'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/err'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/gpio'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/al'
      Merge branch 'pci/controller/artpec6'
      Merge branch 'pci/controller/dra7xx'
      Merge branch 'pci/controller/exynos'
      Merge branch 'pci/controller/hyperv'
      Merge branch 'pci/controller/keystone'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/loongson'
      Merge branch 'pci/controller/microchip'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar'
      Merge branch 'pci/controller/rcar-gen4'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/tegra194'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/misc'

Christophe JAILLET (2):
      PCI: endpoint: Remove unused field in struct pci_epf_group
      PCI: ls-gen4: Make struct mobiveil_rp_ops constant

Damien Le Moal (2):
      PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
      PCI: rockchip-host: Wait 100ms after reset before starting configuration

Dan Carpenter (5):
      PCI: endpoint: Clean up error handling in vpci_scan_bus()
      PCI: endpoint: Fix error handling in epf_ntb_epc_cleanup()
      PCI: qcom: Fix missing error code in qcom_pcie_probe()
      PCI: qcom: Prevent potential error pointer dereference
      PCI: qcom: Prevent use of uninitialized data in qcom_pcie_suspend_noirq()

Dan Williams (2):
      PCI: Warn on missing cfg_access_lock during secondary bus reset
      PCI: Add missing bridge lock to pci_bus_lock()

Dr. David Alan Gilbert (2):
      ACPI: PCI: Remove unused struct 'acpi_handle_node'
      PCI: tegra: Remove unused struct 'tegra_pcie_soc'

Frank Li (4):
      misc: pci_endpoint_test: Refactor dma_set_mask_and_coherent() logic
      PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
      PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
      PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend

Greg Kroah-Hartman (2):
      PCI: switchtec: Make switchtec_class constant
      PCI: endpoint: Make pci_epc_class struct constant

Huacai Chen (1):
      PCI: loongson: Enable MSI in LS7A Root Complex

Ilpo Järvinen (8):
      resource: Rename find_resource() to find_resource_space()
      resource: Document find_resource_space() and resource_constraint
      resource: Use typedef for alignf callback
      resource: Handle simple alignment inside __find_resource_space()
      resource: Export find_resource_space()
      PCI: Fix resource double counting on remove & rescan
      PCI: Make minimum bridge window alignment reference more obvious
      PCI: Relax bridge window tail sizing rules

Javier Carrasco (1):
      PCI: kirin: Convert kirin_pcie_parse_port() to scoped iterator

Jean-Philippe Brucker (1):
      dt-bindings: PCI: generic: Add ats-supported property

Jeff Johnson (3):
      PCI: acpiphp: Add missing MODULE_DESCRIPTION() macro
      PCI: Add missing MODULE_DESCRIPTION() macros
      PCI: controller: Add missing MODULE_DESCRIPTION() macros

Jiapeng Chong (1):
      misc: pci_endpoint_test: Remove unused pci_endpoint_test_bar_{readl,writel} functions

Jiwei Sun (1):
      PCI: vmd: Create domain symlink before pci_bus_add_devices()

Jon Hunter (1):
      PCI: tegra194: Set EP alignment restriction for inbound ATU

Kai-Heng Feng (2):
      PCI/AER: Disable AER service on suspend
      PCI/DPC: Disable DPC service on suspend

Kevin Xie (1):
      PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value

Kishon Vijay Abraham I (1):
      PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

Konrad Dybcio (1):
      PCI: dwc: Use msleep() in dw_pcie_wait_for_link()

Krishna chaitanya chundru (4):
      dt-bindings: PCI: qcom: Add OPP table
      PCI: qcom: Add ICC bandwidth vote for CPU to PCIe path
      PCI: Bring the PCIe speed to MBps logic to new pcie_dev_speed_mbps()
      PCI: qcom: Add OPP support to scale performance

Lukas Wunner (2):
      PCI: pciehp: Detect device replacement during system sleep
      PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal

Manivannan Sadhasivam (18):
      PCI: qcom: Use devm_clk_bulk_get_all() API
      PCI: dwc: Refactor dw_pcie_edma_find_chip() API
      PCI: dwc: Skip finding eDMA channels count for HDMA platforms
      PCI: dwc: Pass the eDMA mapping format flag directly from glue drivers
      PCI: endpoint: pci-epf-test: Make use of cached 'epc_features' in pci_epf_test_core_init()
      PCI: endpoint: pci-epf-test: Use 'msix_capable' flag directly in pci_epf_test_alloc_space()
      PCI: endpoint: Rename core_init() callback in 'struct pci_epc_event_ops' to epc_init()
      PCI: endpoint: Rename BME to Bus Master Enable
      PCI: endpoint: pci-epf-test: Refactor pci_epf_test_unbind() function
      PCI: endpoint: pci-epf-{mhi/test}: Move DMA initialization to EPC init callback
      PCI: endpoint: pci-epf-test: Handle Link Down event
      PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers
      PCI: qcom-ep: Disable resources unconditionally during PERST# assert
      PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper
      PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: layerscape-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
      PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio

Marek Vasut (1):
      PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()

Masahiro Yamada (1):
      PCI: Use array for .id_table consistently

Minda Chen (20):
      dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
      PCI: microchip: Move pcie-microchip-host.c to PLDA directory
      PCI: microchip: Move PLDA IP register macros to pcie-plda.h
      PCI: microchip: Add bridge_addr field to struct mc_pcie
      PCI: microchip: Rename PLDA structures to be generic
      PCI: microchip: Move PLDA structures to plda-pcie.h
      PCI: microchip: Rename PLDA functions to be generic
      PCI: microchip: Move PLDA functions to pcie-plda-host.c
      PCI: microchip: Rename interrupt related functions
      PCI: microchip: Add num_events field to struct plda_pcie_rp
      PCI: microchip: Add request_event_irq() callback function
      PCI: microchip: Add INTx and MSI event num to struct plda_event
      PCI: microchip: Add get_events() callback and PLDA get_event()
      PCI: microchip: Add event irqchip field to host port and add PLDA irqchip
      PCI: microchip: Move IRQ functions to pcie-plda-host.c
      PCI: plda: Add event bitmap field to struct plda_pcie_rp
      PCI: plda: Add host init/deinit and map bus functions
      PCI: plda: Pass pci_host_bridge to plda_pcie_setup_iomems()
      dt-bindings: PCI: Add StarFive JH7110 PCIe controller
      PCI: starfive: Add JH7110 PCIe controller

Mrinmay Sarkar (6):
      dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
      PCI: qcom-ep: Add support for SA8775P SOC
      PCI: qcom-ep: Add HDMA support for SA8775P SoC
      PCI: epf-mhi: Enable HDMA for SA8775P SoC
      PCI: qcom: Override NO_SNOOP attribute for SA8775P RC
      PCI: qcom-ep: Override NO_SNOOP attribute for SA8775P EP

Niklas Cassel (17):
      PCI: artpec6: Fix artpec6_pcie_cpu_addr_fixup() parameter name
      PCI: dra7xx: Fix dra7xx_pcie_cpu_addr_fixup() parameter name
      dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific reg-name
      dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific interrupt-names
      dt-bindings: PCI: snps,dw-pcie-ep: Add tx_int{a,b,c,d} legacy IRQs
      dt-bindings: PCI: rockchip-dw-pcie: Prepare for Endpoint mode support
      dt-bindings: PCI: rockchip-dw-pcie: Fix description of legacy IRQ
      dt-bindings: PCI: rockchip: Add DesignWare based PCIe Endpoint controller
      misc: pci_endpoint_test: Add support for Rockchip rk3588
      misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests
      PCI: dwc: ep: Enforce DWC specific 64-bit BAR limitation
      PCI: dw-rockchip: Fix initial PERST# GPIO value
      PCI: dw-rockchip: Fix weird indentation
      PCI: dw-rockchip: Add rockchip_pcie_get_ltssm() helper
      PCI: dw-rockchip: Refactor the driver to prepare for EP mode
      PCI: dw-rockchip: Add endpoint mode support
      PCI: dw-rockchip: Use pci_epc_init_notify() directly

Philipp Stanner (13):
      PCI: Add and use devres helper for bit masks
      PCI: Add devres helpers for iomap table
      PCI: Add managed partial-BAR request and map infrastructure
      PCI: Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()
      PCI: Add managed pcim_request_region()
      PCI: Document hybrid devres hazards
      PCI: Remove struct pci_devres.enabled status bit
      PCI: Move struct pci_devres.pinned bit to struct pci_dev
      PCI: Give pcim_set_mwi() its own devres cleanup callback
      PCI: Add managed pcim_intx()
      PCI: Remove legacy pcim_release()
      PCI: Add managed pcim_iomap_range()
      drm/vboxvideo: fix mapping leaks

Sergio Paracuellos (1):
      dt-bindings: PCI: mediatek,mt7621-pcie: Add PCIe host topology ASCII graph

Shradha Todi (1):
      PCI: exynos: Adapt to use bulk clock APIs

Siddharth Vadapalli (2):
      PCI: keystone: Relocate ks_pcie_set/clear_dbi_mode()
      PCI: keystone: Don't enable BAR 0 for AM654x

Thippeswamy Havalige (1):
      dt-bindings: PCI: xilinx-cpm: Fix overlapping of bridge register and 32-bit BAR addresses

Tony Luck (1):
      PCI/PM: Switch to new Intel CPU model defines

Uwe Kleine-König (1):
      PCI: dw-rockchip: Add error messages in .probe() error paths

Vidya Sagar (5):
      PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()
      PCI: of: Add of_pci_preserve_config() for per-host bridge support
      PCI: Unify ACPI and DT 'preserve config' support
      PCI: Use preserve_config in place of pci_flags
      PCI: Extend ACS configurability

Wei Liu (1):
      PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN

Yoshihiro Shimoda (8):
      PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
      PCI: rcar-gen4: Add struct rcar_gen4_pcie_drvdata
      PCI: rcar-gen4: Add .ltssm_control() for other SoC support
      PCI: rcar-gen4: Add support for R-Car V4H
      misc: pci_endpoint_test: Document policy about adding pci_device_id
      PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
      PCI: dwc: Add outbound MSG TLPs support
      PCI: Add PCIE_MSG_CODE_ASSERT_INTx message macros

 Documentation/PCI/endpoint/pci-endpoint.rst        |   4 +-
 Documentation/PCI/pciebus-howto.rst                |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |  32 +
 .../devicetree/bindings/pci/host-generic-pci.yaml  |   6 +
 .../bindings/pci/mediatek,mt7621-pcie.yaml         |  29 +
 .../bindings/pci/microchip,pcie-host.yaml          |  55 +-
 .../bindings/pci/plda,xpressrich3-axi-common.yaml  |  75 ++
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  64 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |   4 +
 .../bindings/pci/qcom,pcie-x1e80100.yaml           |   3 +-
 .../bindings/pci/rockchip-dw-pcie-common.yaml      | 126 +++
 .../bindings/pci/rockchip-dw-pcie-ep.yaml          |  95 +++
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  93 +--
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |  13 +-
 .../bindings/pci/starfive,jh7110-pcie.yaml         | 120 +++
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |   2 +-
 .../translations/zh_CN/PCI/pciebus-howto.rst       |   2 +-
 MAINTAINERS                                        |  19 +-
 drivers/acpi/pci_root.c                            |  17 -
 drivers/gpu/drm/vboxvideo/vbox_main.c              |  20 +-
 drivers/misc/pci_endpoint_test.c                   |  87 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |   2 +-
 drivers/pci/bus.c                                  |  10 +-
 drivers/pci/controller/Kconfig                     |   9 +-
 drivers/pci/controller/Makefile                    |   2 +-
 drivers/pci/controller/dwc/Kconfig                 |  22 +-
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   8 +-
 drivers/pci/controller/dwc/pci-exynos.c            |  55 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  38 +-
 drivers/pci/controller/dwc/pci-keystone.c          | 202 +++--
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   4 +-
 drivers/pci/controller/dwc/pci-meson.c             |   1 -
 drivers/pci/controller/dwc/pcie-al.c               |  16 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |  10 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 155 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c  | 145 +++-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 121 +--
 drivers/pci/controller/dwc/pcie-designware.h       |  46 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 330 +++++++-
 drivers/pci/controller/dwc/pcie-keembay.c          |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c            | 126 +--
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  50 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 346 ++++----
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        | 308 ++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  10 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |   2 +-
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c |   2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   2 +-
 drivers/pci/controller/pci-aardvark.c              |   1 -
 drivers/pci/controller/pci-host-common.c           |   5 +-
 drivers/pci/controller/pci-host-generic.c          |   1 +
 drivers/pci/controller/pci-hyperv.c                |   4 +-
 drivers/pci/controller/pci-loongson.c              |  13 +
 drivers/pci/controller/pcie-altera-msi.c           |   1 +
 drivers/pci/controller/pcie-altera.c               |   1 +
 drivers/pci/controller/pcie-apple.c                |   1 +
 drivers/pci/controller/pcie-mediatek-gen3.c        |   1 +
 drivers/pci/controller/pcie-mediatek.c             |   1 +
 drivers/pci/controller/pcie-mt7621.c               |   1 +
 drivers/pci/controller/pcie-rcar-host.c            |   6 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   3 +
 drivers/pci/controller/pcie-rockchip.c             |   2 +-
 drivers/pci/controller/plda/Kconfig                |  30 +
 drivers/pci/controller/plda/Makefile               |   4 +
 .../controller/{ => plda}/pcie-microchip-host.c    | 615 ++------------
 drivers/pci/controller/plda/pcie-plda-host.c       | 651 +++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h            | 273 ++++++
 drivers/pci/controller/plda/pcie-starfive.c        | 488 +++++++++++
 drivers/pci/controller/vmd.c                       |   9 +-
 drivers/pci/devres.c                               | 921 +++++++++++++++++----
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |  48 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      | 117 ++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  19 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |   1 -
 drivers/pci/endpoint/pci-epc-core.c                |  79 +-
 drivers/pci/hotplug/acpiphp_ampere_altra.c         |   1 +
 drivers/pci/hotplug/pciehp.h                       |   4 +
 drivers/pci/hotplug/pciehp_core.c                  |  42 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   5 +
 drivers/pci/hotplug/pciehp_pci.c                   |   4 +
 drivers/pci/iomap.c                                |  16 +
 drivers/pci/of.c                                   |  60 +-
 drivers/pci/pci-acpi.c                             |  22 +
 drivers/pci/pci-mid.c                              |   4 +-
 drivers/pci/pci-pf-stub.c                          |   1 +
 drivers/pci/pci-stub.c                             |   1 +
 drivers/pci/pci.c                                  | 308 ++++---
 drivers/pci/pci.h                                  | 100 ++-
 drivers/pci/pcie/aer.c                             |  18 +
 drivers/pci/pcie/dpc.c                             |  60 +-
 drivers/pci/pcie/portdrv.c                         |   2 +-
 drivers/pci/probe.c                                |  36 +-
 drivers/pci/quirks.c                               |   4 +
 drivers/pci/setup-bus.c                            |  91 +-
 drivers/pci/switch/switchtec.c                     |  16 +-
 drivers/usb/cdns3/cdnsp-pci.c                      |   2 +-
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c           |   2 +-
 include/linux/ioport.h                             |  44 +-
 include/linux/pci-epc.h                            |  15 +-
 include/linux/pci-epf.h                            |  10 +-
 include/linux/pci.h                                |  10 +-
 include/linux/switchtec.h                          |   2 +-
 kernel/resource.c                                  |  68 +-
 105 files changed, 5208 insertions(+), 1932 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c

