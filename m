Return-Path: <linux-pci+bounces-28987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275ABACE2D5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259D93A647B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9BF1F0E47;
	Wed,  4 Jun 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq8DhPJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565532C85;
	Wed,  4 Jun 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057182; cv=none; b=FZ36Fnm1lUdROX72c01cjxudFONGn69+81ApurqQE2hz/TauC+1ECYZqqgaNkRB/EV9XfTjalqeK9NAFpZRmfMUVqEPOdgRoWVybVj0XiOUt5/ST6CsLcGWHemXPrOf1KkRRL6C8LzUnPUqeqTGSofVAq0pVAUr35gKONmmS55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057182; c=relaxed/simple;
	bh=zenKx8uoevSrDIqPqROPm+UNn1VyyWz9jPqh6BVPk2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MerQt6KsiSFVze8Q/PoP4LGFa+MpWbY2vG9wYwo0qi/1ximcgSwSGgP3447DmCw1XqMYSqDNk/dDjyQ4zR7EJzUUoK3o0SKIB8CUrJVG4i1d1kuFgiWTn/AgNUfr4sdZYlUxgyRDIGRLqk0FTBJahmOPeJ0cJsdmwv6MXz5ojG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq8DhPJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE56BC4CEE4;
	Wed,  4 Jun 2025 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749057182;
	bh=zenKx8uoevSrDIqPqROPm+UNn1VyyWz9jPqh6BVPk2U=;
	h=Date:From:To:Cc:Subject:From;
	b=uq8DhPJPlbkWclEEXa9bizuMHAqiYWoL8ow61EJFVQ2CZ934Zsi5GsvTdxnGgnIlO
	 j3zNM1GneNje8o1RcArDMzxWQjIGAJCBgH09k0ubY7vHQik4gENj9ShqVf78vdF+L4
	 iDofSO3zq6v7Wb36jwG+XDnLVwiqGwhiuiH0t3IpY4KXj0+vS1m2OmMl/IE/wGPmJu
	 TgjaITgNmpYSnUCdzjdhYOINkjYnZremmoLLde6NG5UInDyt2g5uesUx9Zuc+aYCXB
	 abjF+vQf+sS9qTc6q1pr8S5rr+U/td45Wj2UJ/lQqZD9WElkWtFGsWEniOt/x0C1Jd
	 NwTYbKjLfwBnw==
Date: Wed, 4 Jun 2025 12:13:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.16
Message-ID: <20250604171300.GA533412@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit fdc348121f2465897792f946715a5da7887e5f97:

  irqdomain: pci: Switch to of_fwnode_handle() (2025-04-07 12:15:14 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-changes

for you to fetch changes up to 3de914864c0d53b7c49aaa94e4ccda9e1dd271d7:

  Merge branch 'pci/misc' (2025-06-04 10:50:45 -0500)


NB:

  - Rebased this morning to add Mani's email address change and update
    merge commit logs.

  - These are changes since fdc348121f24 ("irqdomain: pci: Switch to
    of_fwnode_handle()"), not the usual v6.15-rc1.

    I applied fdc348121f24 to the PCI tree, but Thomas picked it up
    via 6a08164de9fc ("Merge irq/cleanup fragments into irq/msi"), and
    you already merged it via 44ed0f35df34 ("Merge tag
    'irq-msi-2025-05-25' of
    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip").  Confused
    me a bit.

  - You should see the following conflicts:

    * MAINTAINERS between commit:

	0747c136753e ("MAINTAINERS: Move Manivannan Sadhasivam as PCI Native host bridge and endpoint maintainer")

      from upstream and commit:

	308f8c7a626e ("MAINTAINERS: Update Manivannan Sadhasivam email address")
      
      from the PCI tree.

    * drivers/pci/controller/pcie-apple.c between commit:

	5d627a9484ec ("PCI: apple: Convert to MSI parent infrastructure")

      from upstream and commit:

	3f1ccd6e85d7 ("PCI: apple: Abstract register offsets via a SoC-specific structure")

      from the PCI tree.

    * drivers/pci/pci.h between commit:

	d5124a9957b2 ("PCI/MSI: Provide a sane mechanism for TPH")

      and commits:

	51f6aec99cb0 ("PCI: Remove hybrid devres nature from request functions")
	8e9987485d9a ("PCI: Remove pcim_request_region_exclusive()")
	dfc970ad6197 ("PCI: Remove function pcim_intx() prototype from pci.h")

      from the PCI tree.

    * drivers/gpu/drm/xe/Kconfig between commit:

        e4931f8be347 ("drm/xe/vsec: fix CONFIG_INTEL_VSEC dependency")

      from the drm-xe tree (not merged to upstream yet AFAICS) and commit:

        8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency")

      from the PCI tree.

----------------------------------------------------------------

Enumeration:

  - Print the actual delay time in pci_bridge_wait_for_secondary_bus()
    instead of assuming it was 1000ms (Wilfred Mallawa)

  - Revert 'iommu/amd: Prevent binding other PCI drivers to IOMMU PCI
    devices', which broke resume from system sleep on AMD platforms and has
    been fixed by other commits (Lukas Wunner)

Resource management:

  - Remove mtip32xx use of pcim_iounmap_regions(), which is deprecated and
    unnecessary (Philipp Stanner)

  - Remove pcim_iounmap_regions() and pcim_request_region_exclusive() and
    related flags since all uses have been removed (Philipp Stanner)

  - Rework devres 'request' functions so they are no longer 'hybrid', i.e.,
    their behavior no longer depends on whether pcim_enable_device or
    pci_enable_device() was used, and remove related code (Philipp Stanner)

  - Warn (not BUG()) about failure to assign optional resources (Ilpo
    Järvinen)

Error handling:

  - Log the DPC Error Source ID only when it's actually valid (when
    ERR_FATAL or ERR_NONFATAL was received from a downstream device) and
    decode into bus/device/function (Bjorn Helgaas)

  - Determine AER log level once and save it so all related messages use
    the same level (Karolina Stolarek)

  - Use KERN_WARNING, not KERN_ERR, when logging PCIe Correctable Errors
    (Karolina Stolarek)

  - Ratelimit PCIe Correctable and Non-Fatal error logging, with sysfs
    controls on interval and burst count, to avoid flooding logs and RCU
    stall warnings (Jon Pan-Doh)

Power management:

  - Increment PM usage counter when probing reset methods so we don't try
    to read config space of a powered-off device (Alex Williamson)

  - Set all devices to D0 during enumeration to ensure ACPI opregion is
    connected via _REG (Mario Limonciello)

Power control:

  - Rename pwrctrl Kconfig symbols from 'PWRCTL' to 'PWRCTRL' to match the
    filename paths.  Retain old deprecated symbols for compatibility,
    except for the pwrctrl slot driver (PCI_PWRCTRL_SLOT) (Johan Hovold)

  - When unregistering pwrctrl, cancel outstanding rescan work before
    cleaning up data structures to avoid use-after-free issues (Brian
    Norris)

Bandwidth control:

  - Simplify link bandwidth controller by replacing the count of Link
    Bandwidth Management Status (LBMS) events with a PCI_LINK_LBMS_SEEN
    flag (Ilpo Järvinen)

  - Update the Link Speed after retraining, since the Link Speed may have
    changed (Ilpo Järvinen)

PCIe native device hotplug:

  - Ignore Presence Detect Changed caused by DPC.  pciehp already ignores
    Link Down/Up events caused by DPC, but on slots using in-band presence
    detect, DPC causes a spurious Presence Detect Changed event (Lukas
    Wunner)

  - Ignore Link Down/Up caused by Secondary Bus Reset.  On hotplug ports
    using in-band presence detect, the reset causes a Presence Detect
    Changed event, which mistakenly caused teardown and re-enumeration of
    the device.  Drivers may need to annotate code that resets their device
    (Lukas Wunner)

Virtualization:

  - Add an ACS quirk for Loongson Root Ports that don't advertise ACS but
    don't allow peer-to-peer transactions between Root Ports; the quirk
    allows each Root Port to be in a separate IOMMU group (Huacai Chen)

Endpoint framework:

  - For fixed-size BARs, retain both the actual size and the possibly
    larger size allocated to accommodate iATU alignment requirements
    (Jerome Brunet)

  - Simplify ctrl/SPAD space allocation and avoid allocating more space
    than needed (Jerome Brunet)

  - Correct MSI-X PBA offset calculations for DesignWare and Cadence
    endpoint controllers (Niklas Cassel)

  - Align the return value (number of interrupts) encoding for
    pci_epc_get_msi()/pci_epc_ops::get_msi() and
    pci_epc_get_msix()/pci_epc_ops::get_msix() (Niklas Cassel)

  - Align the nr_irqs parameter encoding for
    pci_epc_set_msi()/pci_epc_ops::set_msi() and
    pci_epc_set_msix()/pci_epc_ops::set_msix() (Niklas Cassel)

Common host controller library:

  - Convert pci-host-common to a library so platforms that don't need
    native host controller drivers don't need to include these helper
    functions (Manivannan Sadhasivam)

Apple PCIe controller driver:

  - Extract ECAM bridge creation helper from pci_host_common_probe() to
    separate driver-specific things like MSI from PCI things (Marc Zyngier)

  - Dynamically allocate RID-to_SID bitmap to prepare for SoCs with varying
    capabilities (Marc Zyngier)

  - Skip ports disabled in DT when setting up ports (Janne Grunau)

  - Add t6020 compatible string (Alyssa Rosenzweig)

  - Add T602x PCIe support (Hector Martin)

  - Directly set/clear INTx mask bits because T602x dropped the accessors
    that could do this without locking (Marc Zyngier)

  - Move port PHY registers to their own reg items to accommodate T602x,
    which moves them around; retain default offsets for existing DTs that
    lack phy%d entries with the reg offsets (Hector Martin)

  - Stop polling for core refclk, which doesn't work on T602x and the
    bootloader has already done anyway (Hector Martin)

  - Use gpiod_set_value_cansleep() when asserting PERST# in probe because
    we're allowed to sleep there (Hector Martin)

Cadence PCIe controller driver:

  - Drop a runtime PM 'put' to resolve a runtime atomic count underflow
    (Hans Zhang)

  - Make the cadence core buildable as a module (Kishon Vijay Abraham I)

  - Add cdns_pcie_host_disable() and cdns_pcie_ep_disable() for use by
    loadable drivers when they are removed (Siddharth Vadapalli)

Freescale i.MX6 PCIe controller driver:

  - Apply link training workaround only on IMX6Q, IMX6SX, IMX6SP (Richard
    Zhu)

  - Remove redundant dw_pcie_wait_for_link() from imx_pcie_start_link();
    since the DWC core does this, imx6 only needs it when retraining for a
    faster link speed (Richard Zhu)

  - Toggle i.MX95 core reset to align with PHY powerup (Richard Zhu)

  - Set SYS_AUX_PWR_DET to work around i.MX95 ERR051624 erratum: in some
    cases, the controller can't exit 'L23 Ready' through Beacon or PERST#
    deassertion (Richard Zhu)

  - Clear GEN3_ZRXDC_NONCOMPL to work around i.MX95 ERR051586 erratum:
    controller can't meet 2.5 GT/s ZRX-DC timing when operating at 8 GT/s,
    causing timeouts in L1 (Richard Zhu)

  - Wait for i.MX95 PLL lock before enabling controller (Richard Zhu)

  - Save/restore i.MX95 LUT for suspend/resume (Richard Zhu)

Mobiveil PCIe controller driver:

  - Return bool (not int) for link-up check in mobiveil_pab_ops.link_up()
    and layerscape-gen4, mobiveil (Hans Zhang)

NVIDIA Tegra194 PCIe controller driver:

  - Create debugfs directory for 'aspm_state_cnt' only when CONFIG_PCIEASPM
    is enabled, since there are no other entries (Hans Zhang)

Qualcomm PCIe controller driver:

  - Add OF support for parsing DT 'eq-presets-<N>gts' property for lane
    equalization presets (Krishna Chaitanya Chundru)

  - Read Maximum Link Width from the Link Capabilities register if DT lacks
    'num-lanes' property (Krishna Chaitanya Chundru)

  - Add Physical Layer 64 GT/s Capability ID and register offsets for 8,
    32, and 64 GT/s lane equalization registers (Krishna Chaitanya Chundru)

  - Add generic dwc support for configuring lane equalization presets
    (Krishna Chaitanya Chundru)

  - Add DT and driver support for PCIe on IPQ5018 SoC (Nitheesh Sekar)

Renesas R-Car PCIe controller driver:

  - Describe endpoint BAR 4 as being fixed size (Jerome Brunet)

  - Document how to obtain R-Car V4H (r8a779g0) controller firmware
    (Yoshihiro Shimoda)

Rockchip PCIe controller driver:

  - Reorder rockchip_pci_core_rsts because reset_control_bulk_deassert()
    deasserts in reverse order, to fix a link training regression (Jensen
    Huang)

  - Mark RK3399 as being capable of raising INTx interrupts (Niklas Cassel)

Rockchip DesignWare PCIe controller driver:

  - Check only PCIE_LINKUP, not LTSSM status, to determine whether the link
    is up (Shawn Lin)

  - Increase N_FTS (used in L0s->L0 transitions) and enable ASPM L0s for
    Root Complex and Endpoint modes (Shawn Lin)

  - Hide the broken ATS Capability in rockchip_pcie_ep_init() instead of
    rockchip_pcie_ep_pre_init() so it stays hidden after PERST# resets
    non-sticky registers (Shawn Lin)

  - Call phy_power_off() before phy_exit() in rockchip_pcie_phy_deinit()
    (Diederik de Haas)

Synopsys DesignWare PCIe controller driver:

  - Set PORT_LOGIC_LINK_WIDTH to one lane to make initial link training
    more robust; this will not affect the intended link width if all lanes
    are functional (Wenbin Yao)

  - Return bool (not int) for link-up check in dw_pcie_ops.link_up() and
    armada8k, dra7xx, dw-rockchip, exynos, histb, keembay, keystone, kirin,
    meson, qcom, qcom-ep, rcar_gen4, spear13xx, tegra194, uniphier,
    visconti (Hans Zhang)

  - Add debugfs support for exposing DWC device-specific PTM context
    (Manivannan Sadhasivam)

TI J721E PCIe driver:

  - Make j721e buildable as a loadable and removable module (Siddharth
    Vadapalli)

  - Fix j721e host/endpoint dependencies that result in link failures in
    some configs (Arnd Bergmann)

Device tree bindings:

  - Add qcom DT binding for 'global' interrupt (PCIe controller and
    link-specific events) for ipq8074, ipq8074-gen3, ipq6018, sa8775p,
    sc7280, sc8180x sdm845, sm8150, sm8250, sm8350 (Manivannan Sadhasivam)

  - Add qcom DT binding for 8 MSI SPI interrupts for msm8998, ipq8074,
    ipq8074-gen3, ipq6018 (Manivannan Sadhasivam)

  - Add dw rockchip DT binding for rk3576 and rk3562 (Kever Yang)

  - Correct indentation and style of examples in brcm,stb-pcie,
    cdns,cdns-pcie-ep, intel,keembay-pcie-ep, intel,keembay-pcie,
    microchip,pcie-host, rcar-pci-ep, rcar-pci-host, xilinx-versal-cpm
    (Krzysztof Kozlowski)

  - Convert Marvell EBU (dove, kirkwood, armada-370, armada-xp) and
    armada8k from text to schema DT bindings (Rob Herring)

  - Remove obsolete .txt DT bindings for content that has been moved to
    schemas (Rob Herring)

  - Add qcom DT binding for MHI registers in IPQ5332, IPQ6018, IPQ8074 and
    IPQ9574 (Varadarajan Narayanan)

  - Convert v3,v360epc-pci from text to DT schema binding (Rob Herring)

  - Change microchip,pcie-host DT binding to be 'dma-noncoherent' since
    PolarFire may be configured that way (Conor Dooley)

Miscellaneous:

  - Drop 'pci' suffix from intel_mid_pci.c filename to match similar files
    (Andy Shevchenko)

  - All platforms with PCI have an MMU, so add PCI Kconfig dependency on
    MMU to simplify build testing and avoid inadvertent build regressions
    (Arnd Bergmann)

  - Update Krzysztof Wilczyński's email address in MAINTAINERS (Krzysztof
    Wilczyński)

  - Update Manivannan Sadhasivam's email address in MAINTAINERS (Manivannan
    Sadhasivam)

----------------------------------------------------------------
Alex Williamson (2):
      PM: runtime: Define pm_runtime_put cleanup helper
      PCI: Increment PM usage counter when probing reset methods

Alyssa Rosenzweig (1):
      dt-bindings: pci: apple,pcie: Add t6020 compatible string

Andy Shevchenko (1):
      x86/PCI: Drop 'pci' suffix from intel_mid_pci.c

Arnd Bergmann (2):
      PCI: Add CONFIG_MMU dependency
      PCI: j721e: Fix host/endpoint dependencies

Bjorn Helgaas (40):
      PCI/DPC: Initialize aer_err_info before using it
      PCI/DPC: Log Error Source ID only when valid
      PCI/AER: Factor COR/UNCOR error handling out from aer_isr_one_error()
      PCI/AER: Consolidate Error Source ID logging in aer_isr_one_error_type()
      PCI/AER: Extract bus/dev/fn in aer_print_port_info() with PCI_BUS_NUM(), etc
      PCI/AER: Move aer_print_source() earlier in file
      PCI/AER: Initialize aer_err_info before using it
      PCI/AER: Simplify pci_print_aer()
      PCI/AER: Update statistics before ratelimiting
      PCI/AER: Trace error event before ratelimiting
      PCI/ERR: Add printk level to pcie_print_tlp_log()
      PCI/AER: Convert aer_get_device_error_info(), aer_print_error() to index
      PCI/AER: Simplify add_error_device()
      Merge branch 'pci/aer'
      Merge branch 'pci/bwctrl'
      Merge branch 'pci/devres'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/irq'
      Merge branch 'pci/pci-acpi'
      Merge branch 'pci/pm'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/reset'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/apple'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dw-rockchip'
      Merge branch 'pci/controller/dwc-ep'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/mobiveil'
      Merge branch 'pci/controller/mvebu'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar-gen4'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/tegra194'
      Merge branch 'pci/ptm-debugfs'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/misc'

Brian Norris (1):
      PCI/pwrctrl: Cancel outstanding rescan work when unregistering

Chen Ni (1):
      PCI: ls-gen4: Use to_delayed_work()

Conor Dooley (1):
      dt-bindings: PCI: microchip,pcie-host: Fix DMA coherency property

Diederik de Haas (1):
      PCI: dw-rockchip: Fix PHY function call sequence in rockchip_pcie_phy_deinit()

Hans Zhang (10):
      PCI: cadence: Fix runtime atomic count underflow
      PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG definition
      PCI: dw-rockchip: Reorganize register and bitfield definitions
      PCI: dw-rockchip: Use rockchip_pcie_link_up() to check link up instead of open coding
      PCI: tegra194: Create debugfs directory only when CONFIG_PCIEASPM is enabled
      PCI: dwc: ep: Use FIELD_GET() where applicable
      PCI: dwc: Return bool from link up check
      PCI: mobiveil: Return bool from link up check
      PCI: cadence: Simplify J721e link status check
      PCI: cadence: Remove duplicate message code definitions

Hector Martin (6):
      PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
      PCI: apple: Move port PHY registers to their own reg items
      PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
      PCI: apple: Use gpiod_set_value_cansleep in probe flow
      PCI: apple: Abstract register offsets via a SoC-specific structure
      PCI: apple: Add T602x PCIe support

Heiner Kallweit (1):
      PCI: Remove pci_fixup_cardbus()

Huacai Chen (1):
      PCI: Add ACS quirk for Loongson PCIe

Ilpo Järvinen (7):
      PCI: Use PCI_STD_NUM_BARS instead of 6
      PCI: Fix lock symmetry in pci_slot_unlock()
      PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag
      PCI: Update Link Speed after retraining
      PCI: Remove unused pci_printk()
      PCI: WARN (not BUG()) when we fail to assign optional resources
      PCI: Remove unnecessary linesplit in __pci_setup_bridge()

Janne Grunau (1):
      PCI: apple: Set only available ports up

Jensen Huang (1):
      PCI: rockchip: Fix order of rockchip_pci_core_rsts

Jerome Brunet (3):
      PCI: rcar-gen4: set ep BAR4 fixed size
      PCI: endpoint: Retain fixed-size BAR size as well as aligned size
      PCI: endpoint: pci-epf-vntb: Simplify ctrl/SPAD space allocation

Johan Hovold (4):
      PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
      wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
      wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
      arm64: Kconfig: switch to HAVE_PWRCTRL

Jon Pan-Doh (4):
      PCI/AER: Rename aer_print_port_info() to aer_print_source()
      PCI/AER: Ratelimit correctable and non-fatal error logging
      PCI/AER: Add ratelimits to PCI AER Documentation
      PCI/AER: Add sysfs attributes for log ratelimits

Karolina Stolarek (3):
      PCI/AER: Check log level once and remember it
      PCI/AER: Reduce pci_print_aer() correctable error level to KERN_WARNING
      PCI/AER: Rename struct aer_stats to aer_info

Kever Yang (2):
      dt-bindings: PCI: dw: rockchip: Add rk3576 support
      dt-bindings: PCI: dwc: rockchip: Add rk3562 support

Kishon Vijay Abraham I (1):
      PCI: cadence: Add support to build pcie-cadence library as a kernel module

Krishna Chaitanya Chundru (4):
      PCI: of: Add of_pci_get_equalization_presets() API
      PCI: dwc: Update pci->num_lanes to maximum supported link width
      PCI: Add lane equalization register offsets
      PCI: dwc: Add support for configuring lane equalization presets

Krzysztof Kozlowski (2):
      dt-bindings: PCI: Correct indentation and style in DTS example
      dt-bindings: PCI: sifive,fu740-pcie: Fix include placement in DTS example

Krzysztof Wilczyński (1):
      MAINTAINERS: Update Krzysztof Wilczyński email address

Lukas Wunner (5):
      PCI: pciehp: Ignore Presence Detect Changed caused by DPC
      PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset
      PCI: hotplug: Drop superfluous #include directives
      Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices"
      PCI: Limit visibility of match_driver flag to PCI core

Manivannan Sadhasivam (17):
      dt-bindings: PCI: qcom,pcie-sm8150: Add 'global' interrupt
      dt-bindings: PCI: qcom,pcie-sm8250: Add 'global' interrupt
      dt-bindings: PCI: qcom,pcie-sm8350: Add 'global' interrupt
      dt-bindings: PCI: qcom,pcie-sa8775p: Add 'global' interrupt
      dt-bindings: PCI: qcom,pcie-sc7280: Add 'global' interrupt
      dt-bindings: PCI: qcom: Add 'global' interrupt for SDM845 SoC
      dt-bindings: PCI: qcom: Allow MSM8998 to use 8 MSI and one 'global' interrupt
      dt-bindings: PCI: qcom: Allow IPQ8074 to use 8 MSI and one 'global' interrupt
      dt-bindings: PCI: qcom: Allow IPQ6018 to use 8 MSI and one 'global' interrupt
      dt-bindings: PCI: qcom,pcie-sc8180x: Add 'global' interrupt
      PCI: Add debugfs support for exposing PTM context
      PCI: dwc: Pass DWC PCIe mode to dwc_pcie_debugfs_init()
      PCI: dwc: Add debugfs support for PTM context
      PCI: qcom-ep: Mask PTM_UPDATING interrupt
      PCI/ERR: Remove misleading TODO regarding kernel panic
      PCI: host-common: Convert to library for host controller drivers
      MAINTAINERS: Update Manivannan Sadhasivam email address

Marc Zyngier (5):
      PCI: host-generic: Extract an ECAM bridge creation helper from pci_host_common_probe()
      PCI: ecam: Allow cfg->priv to be pre-populated from the root port device
      PCI: apple: Move over to standalone probing
      PCI: apple: Dynamically allocate RID-to_SID bitmap
      PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private interrupts

Mario Limonciello (1):
      PCI: Explicitly put devices into D0 when initializing

Niklas Cassel (10):
      PCI: rockchip-ep: Mark RK3399 as intx_capable
      PCI: dwc: ep: Fix errno typo
      PCI: dwc: ep: Correct PBA offset in .set_msix() callback
      PCI: cadence-ep: Correct PBA offset in .set_msix() callback
      PCI: endpoint: Align pci_epc_get_msi(), pci_epc_ops::get_msi() return value encoding
      PCI: endpoint: Align pci_epc_get_msix(), pci_epc_ops::get_msix() return value encoding
      PCI: endpoint: Align pci_epc_set_msi(), pci_epc_ops::set_msi() nr_irqs encoding
      PCI: endpoint: Align pci_epc_set_msix(), pci_epc_ops::set_msix() nr_irqs encoding
      PCI: dw-rockchip: Replace PERST# sleep time with proper macro
      PCI: qcom: Replace PERST# sleep time with proper macro

Nitheesh Sekar (2):
      dt-bindings: PCI: qcom: Add IPQ5018 SoC
      PCI: qcom: Add support for IPQ5018

Philipp Stanner (9):
      mtip32xx: Remove unnecessary pcim_iounmap_regions() calls
      PCI: Remove pcim_iounmap_regions()
      PCI: Remove hybrid devres nature from request functions
      Documentation/driver-api: Update pcim_enable_device()
      PCI: Remove pcim_request_region_exclusive()
      PCI: Remove exclusive requests flags from _pcim_request_region()
      PCI: Remove redundant set of request functions
      PCI: Remove hybrid-devres usage warnings from kernel-doc
      PCI: Remove function pcim_intx() prototype from pci.h

Richard Zhu (7):
      PCI: imx6: Skip link up workaround for newer platforms
      PCI: imx6: Call dw_pcie_wait_for_link() from start_link() callback only when required
      PCI: imx6: Toggle the core reset for i.MX95 PCIe
      PCI: imx6: Add workaround for errata ERR051624
      PCI: imx6: Add workaround for errata ERR051586
      PCI: imx6: Add PLL lock check for i.MX95 SoC
      PCI: imx6: Save and restore the LUT setting during suspend/resume for i.MX95 SoC

Rick Wertenbroek (1):
      Documentation: Fix path for NVMe PCI endpoint target driver

Rob Herring (Arm) (5):
      PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
      dt-bindings: PCI: Convert Marvell EBU to schema
      dt-bindings: PCI: Convert marvell,armada8k-pcie to schema
      dt-bindings: PCI: Remove obsolete .txt docs
      dt-bindings: PCI: Convert v3,v360epc-pci to DT schema

Shawn Lin (3):
      PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
      PCI: dw-rockchip: Enable ASPM L0s capability for both RC and EP modes
      PCI: dw-rockchip: Move rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to dw_pcie_ep_ops::init()

Siddharth Vadapalli (3):
      PCI: cadence-host: Introduce cdns_pcie_host_disable() helper for cleanup
      PCI: cadence-ep: Introduce cdns_pcie_ep_disable() helper for cleanup
      PCI: j721e: Add support to build as a loadable module

Varadarajan Narayanan (1):
      dt-bindings: PCI: qcom: Add MHI registers for IPQ9574

Wenbin Yao (1):
      PCI: dwc: Make link training more robust by setting PORT_LOGIC_LINK_WIDTH to one lane

Wilfred Mallawa (1):
      PCI: Print the actual delay time in pci_bridge_wait_for_secondary_bus()

Yoshihiro Shimoda (1):
      PCI: rcar-gen4: Document how to obtain platform firmware

Zhe Qiao (1):
      PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()

 .mailmap                                           |   3 +
 Documentation/ABI/testing/debugfs-pcie-ptm         |  70 ++++
 ...devices-aer_stats => sysfs-bus-pci-devices-aer} |  44 +++
 Documentation/PCI/controller/index.rst             |  10 +
 .../PCI/controller/rcar-pcie-firmware.rst          |  32 ++
 Documentation/PCI/endpoint/pci-nvme-function.rst   |   2 +-
 Documentation/PCI/index.rst                        |   1 +
 Documentation/PCI/pcieaer-howto.rst                |  17 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |  33 +-
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |  81 ++--
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml |  16 +-
 .../bindings/pci/intel,keembay-pcie-ep.yaml        |  26 +-
 .../bindings/pci/intel,keembay-pcie.yaml           |  38 +-
 .../bindings/pci/marvell,armada8k-pcie.yaml        | 100 +++++
 .../bindings/pci/marvell,kirkwood-pcie.yaml        | 277 +++++++++++++
 .../bindings/pci/microchip,pcie-host.yaml          |  56 +--
 .../devicetree/bindings/pci/mvebu-pci.txt          | 310 ---------------
 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml      |   2 +-
 .../devicetree/bindings/pci/pci-armada8k.txt       |  48 ---
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 --------
 Documentation/devicetree/bindings/pci/pci-msi.txt  | 220 -----------
 Documentation/devicetree/bindings/pci/pci.txt      |  84 ----
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml |  10 +-
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |   9 +-
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml |  10 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |   9 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  |   9 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |   9 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  65 ++-
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |  34 +-
 .../devicetree/bindings/pci/rcar-pci-host.yaml     |  46 +--
 .../bindings/pci/rockchip-dw-pcie-common.yaml      |  10 +-
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  60 ++-
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |   2 +-
 .../bindings/pci/snps,dw-pcie-common.yaml          |   3 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   4 +-
 .../devicetree/bindings/pci/v3,v360epc-pci.yaml    | 100 +++++
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  76 ----
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 112 +++---
 Documentation/driver-api/driver-model/devres.rst   |   3 +-
 MAINTAINERS                                        |  50 +--
 arch/arm64/Kconfig.platforms                       |   2 +-
 arch/x86/pci/Makefile                              |   6 +-
 arch/x86/pci/{intel_mid_pci.c => intel_mid.c}      |   0
 drivers/accel/qaic/Kconfig                         |   1 -
 drivers/block/mtip32xx/mtip32xx.c                  |   7 +-
 drivers/firewire/Kconfig                           |   2 +-
 drivers/gpu/drm/Kconfig                            |   2 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |   3 +-
 drivers/gpu/drm/ast/Kconfig                        |   2 +-
 drivers/gpu/drm/gma500/Kconfig                     |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig            |   1 -
 drivers/gpu/drm/loongson/Kconfig                   |   2 +-
 drivers/gpu/drm/mgag200/Kconfig                    |   2 +-
 drivers/gpu/drm/nouveau/Kconfig                    |   3 +-
 drivers/gpu/drm/qxl/Kconfig                        |   2 +-
 drivers/gpu/drm/radeon/Kconfig                     |   2 +-
 drivers/gpu/drm/tiny/Kconfig                       |   2 +-
 drivers/gpu/drm/vmwgfx/Kconfig                     |   2 +-
 drivers/gpu/drm/xe/Kconfig                         |   2 +-
 drivers/iommu/amd/init.c                           |   3 -
 drivers/net/ethernet/broadcom/Kconfig              |   1 -
 drivers/net/wireless/ath/ath11k/Kconfig            |   2 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |   2 +-
 drivers/pci/Kconfig                                |   1 +
 drivers/pci/bus.c                                  |   4 +-
 drivers/pci/controller/Kconfig                     |   8 +-
 drivers/pci/controller/cadence/Kconfig             |  16 +-
 drivers/pci/controller/cadence/pci-j721e.c         |  40 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |  36 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c | 124 +++++-
 drivers/pci/controller/cadence/pcie-cadence.c      |  12 +
 drivers/pci/controller/cadence/pcie-cadence.h      |  25 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   4 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 213 ++++++++--
 drivers/pci/controller/dwc/pci-keystone.c          |   5 +-
 drivers/pci/controller/dwc/pci-meson.c             |   6 +-
 drivers/pci/controller/dwc/pcie-armada8k.c         |   6 +-
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 252 +++++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  30 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  81 +++-
 drivers/pci/controller/dwc/pcie-designware.c       |  29 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  32 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 102 +++--
 drivers/pci/controller/dwc/pcie-hisi.c             |   1 +
 drivers/pci/controller/dwc/pcie-histb.c            |   9 +-
 drivers/pci/controller/dwc/pcie-keembay.c          |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   7 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  10 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   7 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   3 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c        |   7 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  23 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         |   2 +-
 drivers/pci/controller/dwc/pcie-visconti.c         |   4 +-
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c |  12 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   2 +-
 drivers/pci/controller/pci-host-common.c           |  30 +-
 drivers/pci/controller/pci-host-common.h           |  20 +
 drivers/pci/controller/pci-host-generic.c          |   2 +
 drivers/pci/controller/pci-mvebu.c                 |  26 +-
 drivers/pci/controller/pci-thunder-ecam.c          |   2 +
 drivers/pci/controller/pci-thunder-pem.c           |   1 +
 drivers/pci/controller/pcie-apple.c                | 247 ++++++++----
 drivers/pci/controller/pcie-rcar-ep.c              |   8 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |  10 +-
 drivers/pci/controller/pcie-rockchip.h             |   7 +-
 drivers/pci/controller/plda/pcie-microchip-host.c  |   1 +
 drivers/pci/devres.c                               | 225 ++---------
 drivers/pci/ecam.c                                 |   2 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  26 +-
 drivers/pci/endpoint/pci-epc-core.c                |  26 +-
 drivers/pci/endpoint/pci-epf-core.c                |  22 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |  73 +++-
 drivers/pci/hotplug/pciehp.h                       |   1 +
 drivers/pci/hotplug/pciehp_core.c                  |  29 --
 drivers/pci/hotplug/pciehp_ctrl.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  78 ++--
 drivers/pci/iomap.c                                |  16 -
 drivers/pci/of.c                                   |  44 +++
 drivers/pci/pci-acpi.c                             |  23 +-
 drivers/pci/pci-driver.c                           |   8 +-
 drivers/pci/pci-sysfs.c                            |   4 +
 drivers/pci/pci.c                                  |  88 ++---
 drivers/pci/pci.h                                  |  75 +++-
 drivers/pci/pcie/aer.c                             | 438 +++++++++++++++------
 drivers/pci/pcie/bwctrl.c                          |  86 +---
 drivers/pci/pcie/dpc.c                             |  73 ++--
 drivers/pci/pcie/err.c                             |   1 -
 drivers/pci/pcie/ptm.c                             | 300 ++++++++++++++
 drivers/pci/pcie/tlp.c                             |   6 +-
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |  22 +-
 drivers/pci/pwrctrl/Makefile                       |   8 +-
 drivers/pci/pwrctrl/core.c                         |   2 +
 drivers/pci/quirks.c                               |  33 +-
 drivers/pci/setup-bus.c                            |  16 +-
 drivers/pcmcia/cardbus.c                           |   1 -
 drivers/scsi/bnx2fc/Kconfig                        |   1 -
 drivers/scsi/bnx2i/Kconfig                         |   1 -
 drivers/vfio/pci/Kconfig                           |   2 +-
 include/linux/pci-ecam.h                           |   6 -
 include/linux/pci-epc.h                            |  11 +-
 include/linux/pci-epf.h                            |   3 +
 include/linux/pci.h                                |  64 ++-
 include/linux/pm_runtime.h                         |   2 +
 include/uapi/linux/pci_regs.h                      |  12 +-
 148 files changed, 3401 insertions(+), 2220 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-pcie-ptm
 rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (72%)
 create mode 100644 Documentation/PCI/controller/index.rst
 create mode 100644 Documentation/PCI/controller/rcar-pcie-firmware.rst
 create mode 100644 Documentation/devicetree/bindings/pci/marvell,armada8k-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/v3,v360epc-pci.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
 rename arch/x86/pci/{intel_mid_pci.c => intel_mid.c} (100%)
 create mode 100644 drivers/pci/controller/pci-host-common.h

