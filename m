Return-Path: <linux-pci+bounces-42595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CECA1C72
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6535630056CC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD8E2D979B;
	Wed,  3 Dec 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PErBkCXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0322D47EF;
	Wed,  3 Dec 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799866; cv=none; b=eheSsr8vQfx+01L501sugn0fMsL34vhlcd+bibhfoTZ+dertxP3AfQpsNacaE4ZuQ0XkPgpzPdRMBML5X/fpg/kYfFMyPZYSPp957HoXuMxzFpgIX0Bgl+NQYjVBcDcVKTaT0/qeepFL0G32sKWUOWeMh0uH6PhPnSiAwjdtK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799866; c=relaxed/simple;
	bh=HnNxA6l0bIX+IXXv9MtAA3ljrczOJeLqGK9y/jHwFe0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iW/XJ+OS/mFg1z8BscZmGMDetq+qFdxdMx6U7dj2y7gVlBJ9VXVL7/HDwf9kzk8dOIEUiIvqc7+sLnY1xY9TzQjn/b2OE47MtkKi9/0rUU3O2k/fA8MFa3IyNjb/gplpkKHR89bZNSCOXB2wS7fq+zP2hlcnWBFuhzBlfeh42Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PErBkCXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7560C4CEF5;
	Wed,  3 Dec 2025 22:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764799864;
	bh=HnNxA6l0bIX+IXXv9MtAA3ljrczOJeLqGK9y/jHwFe0=;
	h=Date:From:To:Cc:Subject:From;
	b=PErBkCXNtHXgZmghmfi8GFg9TYfEVZsyPKJ790dihuBc1HxXRVyB/uyLo79NaqhD6
	 gPhnCrDGS/s67TXr6BXAP70J64v77es06/BECYZ6YSHb9Fu84Y8xGHJozYWtIpXkDA
	 yLJKERBh+BYaC2zUrYfTp5PBTIwq9LjnVE1EHx0XpuWQCip5YXlMV5dyiGHTTFb7x3
	 TycPkSZJC4/Bx1CGV7nePYpxE/rGxP5dgF/KXqZzwfu6h91qzXvoTcRsrQJHHXJfVm
	 yIvC6NHg+XWR5S7LuwGQKfH8KOBLYH/earuktVphK/gFlXg41c5DEr7qAtynJNqZcd
	 VTUhw690Mr6Sg==
Date: Wed, 3 Dec 2025 16:11:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.19
Message-ID: <20251203221103.GA3193083@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-changes

for you to fetch changes up to cd6b7c82b69139070ee1aaa73f768ecac99e4c3e:

  Merge branch 'pci/misc' (2025-12-03 14:18:46 -0600)

You should see these conflicts:

  MAINTAINERS
    upstream 2b6d546ba83e ("MAINTAINERS: update my email address")
    vs PCI   7eba05e79ca2 ("MAINTAINERS: Add Manivannan Sadhasivam as PCI/pwrctrl maintainer")

  drivers/gpu/drm/xe/xe_vram.c
    upstream d30203739be7 ("drm/xe: Move rebar to be done earlier")
    vs PCI   337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")

  drivers/pci/controller/dwc/pcie-designware-host.c
    upstream a1978b692a39 ("PCI: dwc: Use custom pci_ops for root bus DBI vs ECAM config access")
    vs PCI   3445d3820770 ("PCI: dwc: Implement .assert_perst() for dwc glue drivers")

My resolution is here:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=v6.19-merge&id=c45913e5dc66

----------------------------------------------------------------

Enumeration:

  - Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms (Dan
    Williams)

  - Switch vmd from custom domain number allocator to the common allocator
    to prevent a potential race with new non-VMD buses (Dan Williams)

  - Enable Precision Time Measurement (PTM) only if device advertises
    support for a relevant role, to prevent invalid PTM Requests that cause
    ACS violations that are reported as AER Uncorrectable Non-Fatal errors
    (Mika Westerberg)

Resource management:

  - Prevent resource tree corruption when BAR resize fails (Ilpo Järvinen)

  - Restore BARs to the original size if a BAR resize fails (Ilpo Järvinen)

  - Remove BAR release from BAR resize attempts by the xe, i915, and amdgpu
    drivers so the PCI core can restore BARs if the resize fails (Ilpo
    Järvinen)

  - Move Resizable BAR code to rebar.c (Ilpo Järvinen)

  - Add pci_rebar_size_supported() and use it in i915 and xe (Ilpo
    Järvinen)

  - Add pci_rebar_get_max_size() and use it in xe and amdgpu (Ilpo
    Järvinen)

Power management and error handling:

  - For drivers using PCI legacy suspend, save config state at suspend so
    that state (not any earlier state from enumeration, probe, or error
    recovery) will be restored when resuming (Lukas Wunner)

  - For devices with no driver or a driver that lacks power management,
    save config state at hibernate so that state (not any earlier state
    from enumeration, probe, or error recovery) will be restored when
    resuming (Lukas Wunner)

  - Save device config space on device addition, before driver binding, so
    error recovery works more reliably (Lukas Wunner)

  - Drop pci_save_state() from several drivers that no longer need it since
    the PCI core always does it and pci_restore_state() no longer
    invalidates the saved state (Lukas Wunner)

  - Document use of pci_save_state() by drivers to capture the state they
    want restored during error recovery (Lukas Wunner)

Power control:

  - Add a struct pci_ops.assert_perst() function pointer to assert/deassert
    PCIe PERST# and implement it for the qcom driver (Krishna Chaitanya
    Chundru)

  - Add DT binding and pwrctrl driver for the Toshiba TC9563 PCIe switch,
    which must be held in reset after poweron so the pwrctrl driver can
    configure the switch via I2C before bringing up the links (Krishna
    Chaitanya Chundru)

Endpoint framework:

  - Convert the endpoint doorbell test to use a threaded IRQ to fix a
    'sleeping while atomic' issue (Bhanu Seshu Kumar Valluri)

  - Add endpoint VNTB MSI doorbell support to reduce latency between host
    and endpoint (Frank Li)

New native PCIe controller drivers:

  - Add CIX Sky1 host controller DT binding and driver (Hans Zhang)

  - Add NXP S32G host controller DT binding and driver (Vincent Guittot)

  - Add Renesas RZ/G3S host controller DT binding and driver (Claudiu
    Beznea)

  - Add SpacemiT K1 host controller DT binding and driver (Alex Elder)

Amlogic Meson PCIe controller driver:

  - Update DT binding to name DBI region 'dbi', not 'elbi', and update
    driver to support both (Manivannan Sadhasivam)

Apple PCIe controller driver:

  - Move struct pci_host_bridge allocation from pci_host_common_init() to
    callers, which significantly simplifies pcie-apple (Marc Zyngier)

Broadcom STB PCIe controller driver:

  - Disable advertising ASPM L0s support correctly (Jim Quinlan)

  - Add a panic/die handler to print diagnostic info in case PCIe caused an
    unrecoverable abort (Jim Quinlan)

Cadence PCIe controller driver:

  - Add module support for Cadence platform host and endpoint controller
    driver (Manikandan K Pillai)

  - Split headers into 'legacy' (LGA) and 'high perf' (HPA) to prepare for
    new CIX Sky1 driver (Manikandan K Pillai)

MediaTek PCIe controller driver:

  - Convert DT binding to YAML schema (Christian Marangi)

  - Add Airoha AN7583 DT compatible and driver support (Christian Marangi)

Qualcomm PCIe controller driver:

  - Add Qualcomm Kaanapali to SM8550 DT binding (Qiang Yu)

  - Add required 'power-domains' and 'resets' to qcom sa8775p, sc7280,
    sc8280xp, sm8150, sm8250, sm8350, sm8450, sm8550, x1e80100 DT schemas
    (Krzysztof Kozlowski)

  - Look up OPP using both frequency and data rate (not just frequency) so
    RPMh votes can account for both (Krishna Chaitanya Chundru)

Rockchip DesignWare PCIe controller driver:

  - Add Rockchip RK3528 compatible strings in DT binding (Yao Zi)

STMicroelectronics STM32MP25 PCIe controller driver:

  - Fix a race between link training and endpoint register initialization
    (Christian Bruel)

  - Align endpoint allocations to match the ATU requirements (Christian
    Bruel)

Synopsys DesignWare PCIe controller driver:

  - Clear L1 PM Substate Capability 'Supported' bits unless glue driver
    says it's supported, which prevents users from enabling non-working
    L1SS.  Currently only qcom and tegra194 support L1SS (Bjorn Helgaas)

  - Remove now-superfluous L1SS disable code from tegra194 (Bjorn Helgaas)

  - Configure L1SS support in dw-rockchip when DT says 'supports-clkreq'
    (Shawn Lin)

TI Keystone PCIe controller driver:

  - Fail the probe instead of silently succeeding if ks_pcie_of_data didn't
    specify Root Complex or Endpoint mode (Siddharth Vadapalli)

  - Make keystone buildable as a loadable module, except on ARM32 where
    hook_fault_code() is __init (Siddharth Vadapalli)

----------------------------------------------------------------
Alex Elder (2):
      dt-bindings: pci: spacemit: Introduce PCIe host controller
      PCI: spacemit: Add SpacemiT PCIe host driver

Anand Moon (3):
      PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
      PCI: j721e: Use devm_clk_get_optional_enabled() to get and enable the clock
      PCI: j721e: Use 'pcie->reset_gpio' directly and drop the local variable

Andy Shevchenko (1):
      PCI: stm32: Don't use 'proxy' headers

Bartosz Golaszewski (1):
      MAINTAINERS: Add Manivannan Sadhasivam as PCI/pwrctrl maintainer

Bhanu Seshu Kumar Valluri (1):
      PCI: endpoint: pci-epf-test: Fix sleeping function being called from atomic context

Bjorn Helgaas (28):
      PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
      PCI: dwc: Advertise L1 PM Substates only if driver requests it
      PCI: tegra194: Remove unnecessary L1SS disable code
      Merge branch 'pci/enumeration'
      Merge branch 'pci/err'
      Merge branch 'pci/ptm'
      Merge branch 'pci/resource'
      Merge branch 'pci/dt-binding'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/host-common'
      Merge branch 'pci/controller/brcmstb'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dw-rockchip'
      Merge branch 'pci/controller/ixp4xx'
      Merge branch 'pci/controller/j721e'
      Merge branch 'pci/controller/keystone'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/meson'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar-gen2'
      Merge branch 'pci/controller/rzg3s-host'
      Merge branch 'pci/controller/s32g'
      Merge branch 'pci/controller/sg2042'
      Merge branch 'pci/controller/sky1'
      Merge branch 'pci/controller/spacemit-k1'
      Merge branch 'pci/controller/stm32'
      Merge branch 'pci/pwrctrl-tc9563'
      Merge branch 'pci/misc'

Christian Bruel (2):
      PCI: stm32: Fix LTSSM EP race with start link
      PCI: stm32: Fix EP page_size alignment

Christian Marangi (5):
      dt-bindings: PCI: mediatek: Convert to YAML schema
      dt-bindings: PCI: mediatek: Add support for Airoha AN7583
      PCI: mediatek: Convert bool to single quirks entry and bitmap
      PCI: mediatek: Use generic MACRO for TPVPERL delay
      PCI: mediatek: Add support for Airoha AN7583 SoC

Christophe JAILLET (1):
      PCI: sg2042: Fix a reference count issue in sg2042_pcie_remove()

Claudiu Beznea (2):
      dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
      PCI: Add Renesas RZ/G3S host controller driver

Dan Williams (2):
      PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
      PCI: vmd: Switch to pci_bus_find_emul_domain_nr()

David Laight (1):
      PCI: Use max() instead of max_t() to ease static analysis

Frank Li (4):
      PCI: endpoint: Rename 'epf_bar::aligned_size' to 'epf_bar:mem_size'
      PCI: endpoint: Add pci_epf_get_required_bar_size() helper
      PCI: endpoint: Add pci_epf_assign_bar_space() API
      PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

Geert Uytterhoeven (1):
      PCI: rcar-gen2: Drop ARM dependency from PCI_RCAR_GEN2

Hans Zhang (3):
      dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
      PCI: sky1: Add PCIe host support for CIX Sky1
      MAINTAINERS: Add CIX Sky1 PCIe controller driver maintainer

Ilpo Järvinen (23):
      PCI: Prevent resource tree corruption when BAR resize fails
      PCI/IOV: Adjust ->barsz[] when changing BAR size
      PCI: Change pci_dev variable from 'bridge' to 'dev'
      PCI: Try BAR resize even when no window was released
      PCI: Free saved list without holding pci_bus_sem
      PCI: Fix restoring BARs on BAR resize rollback path
      PCI: Add kerneldoc for pci_resize_resource()
      drm/xe: Remove driver side BAR release before resize
      drm/i915: Remove driver side BAR release before resize
      drm/amdgpu: Remove driver side BAR release before resize
      PCI: Prevent restoring assigned resources
      PCI: Move Resizable BAR code to rebar.c
      PCI: Move pci_rebar_bytes_to_size() and clean it up
      PCI: Move pci_rebar_size_to_bytes() and export it
      PCI: Improve Resizable BAR functions kernel doc
      PCI: Add pci_rebar_size_supported() helper
      drm/i915/gt: Use pci_rebar_size_supported()
      drm/xe/vram: Use PCI rebar helpers in resize_vram_bar()
      PCI: Add pci_rebar_get_max_size()
      drm/xe/vram: Use pci_rebar_get_max_size()
      drm/amdgpu: Use pci_rebar_get_max_size()
      PCI: Convert BAR sizes bitmasks to u64
      PCI: Validate pci_rebar_size_supported() input

Jim Quinlan (3):
      PCI: brcmstb: Fix disabling L0s capability
      PCI: brcmstb: Add a way to indicate if PCIe bridge is active
      PCI: brcmstb: Add panic/die handler to driver

Krishna Chaitanya Chundru (6):
      PCI: qcom: Use frequency and level based OPP lookup
      dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch
      PCI: Add .assert_perst() to control PCIe PERST#
      PCI: dwc: Implement .assert_perst() for dwc glue drivers
      PCI: qcom: Implement .assert_perst()
      PCI: pwrctrl: Add power control driver for TC9563

Krzysztof Kozlowski (9):
      dt-bindings: PCI: qcom,pcie-sa8775p: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains and resets

Lukas Wunner (5):
      PCI/PM: Reinstate clearing state_saved in legacy and !PM codepaths
      PCI/PM: Stop needlessly clearing state_saved on enumeration and thaw
      PCI/ERR: Ensure error recoverability at all times
      treewide: Drop pci_save_state() after pci_restore_state()
      Documentation: PCI: Amend error recovery doc with pci_save_state() rules

Manikandan K Pillai (4):
      PCI: cadence: Add module support for platform controller driver
      PCI: cadence: Split PCIe controller header file
      PCI: cadence: Move PCIe RP common functions to a separate file
      PCI: cadence: Add support for High Perf Architecture (HPA) controller

Manivannan Sadhasivam (3):
      dt-bindings: PCI: Update the email address for Manivannan Sadhasivam
      dt-bindings: PCI: amlogic: Fix the register name of the DBI region
      PCI: meson: Fix parsing the DBI register region

Marc Zyngier (1):
      PCI: host-generic: Move bridge allocation outside of pci_host_common_init()

Mika Westerberg (1):
      PCI/PTM: Enable only if device advertises relevant role

Qiang Yu (1):
      dt-bindings: PCI: qcom,pcie-sm8550: Add Kaanapali compatible

Rob Herring (Arm) (1):
      dt-bindings: PCI: amlogic,axg-pcie: Fix select schema

Shawn Lin (2):
      PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition
      PCI: dw-rockchip: Configure L1SS support

Siddharth Vadapalli (4):
      PCI: keystone: Exit ks_pcie_probe() for invalid mode
      PCI: Export pci_get_host_bridge_device() for use by pci-keystone
      PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
      PCI: keystone: Add support to build as a loadable module

Vincent Guittot (4):
      dt-bindings: PCI: s32g: Add NXP S32G PCIe controller
      PCI: dwc: Add register and bitfield definitions
      PCI: s32g: Add NXP S32G PCIe controller driver (RC)
      MAINTAINERS: Add NXP S32G PCIe controller driver maintainer

Yao Zi (1):
      dt-bindings: PCI: dwc: rockchip: Add RK3528 variant

 Documentation/PCI/pci-error-recovery.rst           |   15 +
 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  |   23 +-
 .../bindings/pci/cix,sky1-pcie-host.yaml           |   83 +
 .../bindings/pci/mediatek-pcie-mt7623.yaml         |  164 ++
 .../devicetree/bindings/pci/mediatek-pcie.txt      |  289 ----
 .../devicetree/bindings/pci/mediatek-pcie.yaml     |  438 +++++
 .../devicetree/bindings/pci/nxp,s32g-pcie.yaml     |  130 ++
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |    2 +-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |    2 +-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |    2 +-
 .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml |    2 +-
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml |    5 +-
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |    7 +-
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml |    2 +-
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           |    5 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |    7 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  |    7 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |    7 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |    7 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |    8 +-
 .../bindings/pci/qcom,pcie-x1e80100.yaml           |    7 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |    2 +-
 .../bindings/pci/renesas,r9a08g045-pcie.yaml       |  249 +++
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |    3 +
 .../bindings/pci/snps,dw-pcie-common.yaml          |    6 +-
 .../bindings/pci/spacemit,k1-pcie-host.yaml        |  157 ++
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  179 ++
 Documentation/driver-api/pci/pci.rst               |    3 +
 MAINTAINERS                                        |   25 +
 drivers/crypto/intel/qat/qat_common/adf_aer.c      |    2 -
 drivers/dma/ioat/init.c                            |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   20 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c        |   24 +-
 drivers/gpu/drm/xe/xe_vram.c                       |   37 +-
 drivers/net/ethernet/broadcom/bnx2.c               |    2 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    1 -
 drivers/net/ethernet/broadcom/tg3.c                |    1 -
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    2 -
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |    1 -
 drivers/net/ethernet/intel/e1000e/netdev.c         |    1 -
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |    6 -
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    1 -
 drivers/net/ethernet/intel/ice/ice_main.c          |    2 -
 drivers/net/ethernet/intel/igb/igb_main.c          |    2 -
 drivers/net/ethernet/intel/igc/igc_main.c          |    2 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    1 -
 drivers/net/ethernet/mellanox/mlx4/main.c          |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    1 -
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |    1 -
 drivers/net/ethernet/microchip/lan743x_main.c      |    1 -
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |    4 -
 drivers/net/ethernet/neterion/s2io.c               |    1 -
 drivers/pci/Makefile                               |    2 +-
 drivers/pci/bus.c                                  |    3 +
 drivers/pci/controller/Kconfig                     |   18 +-
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/cadence/Kconfig             |   21 +-
 drivers/pci/controller/cadence/Makefile            |   11 +-
 drivers/pci/controller/cadence/pci-j721e.c         |   33 +-
 drivers/pci/controller/cadence/pci-sky1.c          |  238 +++
 .../controller/cadence/pcie-cadence-host-common.c  |  288 ++++
 .../controller/cadence/pcie-cadence-host-common.h  |   46 +
 .../pci/controller/cadence/pcie-cadence-host-hpa.c |  368 ++++
 drivers/pci/controller/cadence/pcie-cadence-host.c |  278 +--
 .../pci/controller/cadence/pcie-cadence-hpa-regs.h |  193 +++
 drivers/pci/controller/cadence/pcie-cadence-hpa.c  |  167 ++
 .../pci/controller/cadence/pcie-cadence-lga-regs.h |  230 +++
 drivers/pci/controller/cadence/pcie-cadence-plat.c |    9 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |   12 +
 drivers/pci/controller/cadence/pcie-cadence.h      |  409 ++---
 drivers/pci/controller/cadence/pcie-sg2042.c       |    3 -
 drivers/pci/controller/dwc/Kconfig                 |   38 +-
 drivers/pci/controller/dwc/Makefile                |    5 +
 drivers/pci/controller/dwc/pci-keystone.c          |   80 +-
 drivers/pci/controller/dwc/pci-meson.c             |   18 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |    1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   12 +
 drivers/pci/controller/dwc/pcie-designware.c       |   36 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   21 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |   63 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c         |  406 +++++
 drivers/pci/controller/dwc/pcie-qcom.c             |   32 +-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c      |  357 ++++
 drivers/pci/controller/dwc/pcie-stm32-ep.c         |   43 +-
 drivers/pci/controller/dwc/pcie-stm32.c            |   14 +-
 drivers/pci/controller/dwc/pcie-stm32.h            |    3 +
 drivers/pci/controller/dwc/pcie-tegra194.c         |   48 +-
 drivers/pci/controller/pci-host-common.c           |   13 +-
 drivers/pci/controller/pci-host-common.h           |    1 +
 drivers/pci/controller/pci-hyperv.c                |   62 +-
 drivers/pci/controller/pci-ixp4xx.c                |    6 +
 drivers/pci/controller/pcie-apple.c                |   43 +-
 drivers/pci/controller/pcie-brcmstb.c              |  209 ++-
 drivers/pci/controller/pcie-mediatek.c             |  113 +-
 drivers/pci/controller/pcie-rzg3s-host.c           | 1761 ++++++++++++++++++++
 drivers/pci/controller/vmd.c                       |   40 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |    5 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  153 +-
 drivers/pci/endpoint/pci-epf-core.c                |  159 +-
 drivers/pci/host-bridge.c                          |    1 +
 drivers/pci/iov.c                                  |   25 +-
 drivers/pci/pci-driver.c                           |    6 +-
 drivers/pci/pci-sysfs.c                            |   19 +-
 drivers/pci/pci.c                                  |  172 +-
 drivers/pci/pci.h                                  |   14 +-
 drivers/pci/pcie/portdrv.c                         |    1 -
 drivers/pci/pcie/ptm.c                             |   23 +
 drivers/pci/probe.c                                |   13 +-
 drivers/pci/pwrctrl/Kconfig                        |   15 +
 drivers/pci/pwrctrl/Makefile                       |    2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           |  648 +++++++
 drivers/pci/rebar.c                                |  328 ++++
 drivers/pci/setup-bus.c                            |  126 +-
 drivers/pci/setup-res.c                            |   78 -
 drivers/scsi/bfa/bfad.c                            |    1 -
 drivers/scsi/csiostor/csio_init.c                  |    1 -
 drivers/scsi/ipr.c                                 |    1 -
 drivers/scsi/lpfc/lpfc_init.c                      |    6 -
 drivers/scsi/qla2xxx/qla_os.c                      |    5 -
 drivers/scsi/qla4xxx/ql4_os.c                      |    5 -
 drivers/tty/serial/8250/8250_pci.c                 |    1 -
 drivers/tty/serial/jsm/jsm_driver.c                |    1 -
 include/linux/pci-epf.h                            |   12 +-
 include/linux/pci.h                                |   27 +-
 include/linux/sizes.h                              |    1 +
 126 files changed, 7905 insertions(+), 1651 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c
 create mode 100644 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
 create mode 100644 drivers/pci/rebar.c

