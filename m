Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721A5FA68A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJJUr4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJJUrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 16:47:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2DD73910;
        Mon, 10 Oct 2022 13:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0431CCE1122;
        Mon, 10 Oct 2022 20:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C45C433C1;
        Mon, 10 Oct 2022 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665434868;
        bh=VFPnTsOSPKpgkadgxZjyfzJrrMaNUdJ4ShlGHANk4QA=;
        h=Date:From:To:Cc:Subject:From;
        b=iIKg02P7MnYhXLUUZ/MNhO00eSM10yFvs1L3DAUn5VnkH/ZDLQsrSBuEMH+vWJz09
         KJyAN9qio8SLc3yuwsvl6zRaI4f05nwfGVfyI77Hu7Q8+WQbba5y/jYVK8AFcRh8SO
         lcnrqOXoiTiFrxrVDlBpj059zLjZfq60sGoTh70zbbQxIAz7vsYcDur7DxeRa5roNF
         o7K9ciQRNE8jVhe+l85+EieDpDyebexNdns5AZRWSeAsQb6tLAzD6vZ7b5nEMiS1WD
         8d42GevbrmPuUsBmEJfLDL+Jt3SLfYR3tNWTXbXrR4BBQR4L33CXSJDzOZmwPeYI1O
         HQamWXpQ4KrRg==
Date:   Mon, 10 Oct 2022 15:47:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] PCI changes for v6.1
Message-ID: <20221010204746.GA2935311@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-changes

for you to fetch changes up to 0e00a3aeae255416577fc69b9b49be4778c05464:

  Merge branch 'for-linus' into next (2022-10-06 16:06:56 -0500)

----------------------------------------------------------------
Resource management:

  - Distribute spare resources to unconfigured hotplug bridges at boot-time
    (not just when hot-adding such a bridge), which makes hot-adding
    devices to docks work better.

  - Revert to a BAR assignment inherited from firmware only when the
    address is actually reachable via any upstream bridges, which
    fixes some cases where firmware doesn't configure all devices.

  - Add a sysfs interface to resize BARs so this can be done before
    assigning devices to a VM through VFIO.

Power management: 

  - Disable Precision Time Management for all devices on suspend to enable
    lower-power PM state.  We previously did this just for Root Ports,
    which isn't enough because downstream devices can still generate PTM
    messages, which cause errors if it's disabled in the Root Port.

  - Save and restore the ASPM L1 PM Substates configuration for suspend/
    resume.  Previously this configuration was lost, so L1.x states likely
    stopped working after resume.

  - Check whether the L1 PM Substates Capability exists.  If it didn't
    exist, we previously read junk and tried to configure L1 Substates
    based on that.

  - Fix the LTR_L1.2_THRESHOLD computation, which previously set a
    threshold for entering L1.2 that was too low in some cases.

  - Reduce the delay after transitions to or from D3cold by using
    usleep_range() rather than msleep(), which often slept for ~19ms
    instead of the 10ms normally required.  The spec says 10ms is enough,
    but it's possible we could trip over devices that need a little more.

Error handling:

  - Work around a BIOS bug that caused Intel Root Ports to advertise a Root
    Port Programmed I/O (RP PIO) log size of zero, which caused annoying
    warnings and prevented the kernel from dumping log registers for
    DPC errors.

Qualcomm PCIe controller driver:

  - Add support for SC8280XP and SA8540P host controllers and SM8450
    endpoint controller.

  - Disable Master AXI clock on endpoint controllers to save power when
    link is idle or in L1.x.

  - Expose link state transition counts via debugfs to help debug issues
    with low-power states.

  - Add auto-loading module support.

Synopsys DesignWare PCIe controller driver:

  - Remove a dependency on ZONE_DMA32 by allocating the MSI target page
    differently.  There's more work to do related to eDMA controllers, so
    it's not completely settled.

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Expose PCIe Resizable BAR support via sysfs

Andy Shevchenko (1):
      PCI: dwc: Replace of_gpio_named_count() by gpiod_count()

Bjorn Helgaas (29):
      PCI/PTM: Cache PTM Capability offset
      PCI/PTM: Add pci_upstream_ptm() helper
      PCI/PTM: Separate configuration and enable
      PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
      PCI/PTM: Move pci_ptm_info() body into its only caller
      PCI/PTM: Preserve RsvdP bits in PTM Control register
      PCI/PTM: Reorder functions in logical order
      PCI/PTM: Consolidate PTM interface declarations
      PCI/PM: Always disable PTM for all devices during suspend
      PCI/ASPM: Factor out L1 PM Substates configuration
      PCI/ASPM: Ignore L1 PM Substates if device lacks capability
      PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation
      Merge branch 'pci/aspm'
      Merge branch 'pci/dpc'
      Merge branch 'pci/msi'
      Merge branch 'pci/pm'
      Merge branch 'pci/rebar'
      Merge branch 'pci/resource'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/apple'
      Merge branch 'remotes/lorenzo/pci/bridge-emul'
      Merge branch 'remotes/lorenzo/pci/dt'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/mvebu'
      Merge branch 'pci/qcom'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'pci/misc'
      Merge branch 'for-linus' into next

Conor Dooley (3):
      dt-bindings: PCI: fu740-pci: fix missing clock-names
      dt-bindings: PCI: microchip,pcie-host: fix missing clocks properties
      dt-bindings: PCI: microchip,pcie-host: fix missing dma-ranges

Dmitry Baryshkov (1):
      PCI: qcom-ep: Add MODULE_DEVICE_TABLE

Dmitry Torokhov (1):
      PCI: apple: Do not leak reset GPIO on unbind/unload/error

Felix Fietkau (1):
      PCI: mediatek-gen3: Change driver name to mtk-pcie-gen3

Jianjun Wang (1):
      dt-bindings: PCI: mediatek-gen3: Add support for MT8188 and MT8195

Johan Hovold (10):
      dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
      dt-bindings: PCI: qcom: Add SC8280XP to binding
      dt-bindings: PCI: qcom: Add SA8540P to binding
      PCI: qcom: Add support for SC8280XP
      PCI: qcom: Add support for SA8540P
      PCI: qcom: Make all optional clocks optional
      PCI: qcom: Clean up IP configurations
      PCI: qcom: Sort device-id table
      PCI: qcom: Drop unused post_deinit callback
      PCI: qcom: Rename host-init error label

Josef Johansson (1):
      PCI/MSI: Correct 'can_mask' test in msi_add_msi_desc()

Krishna chaitanya chundru (1):
      dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks

Maciej W. Rozycki (1):
      PCI: Sanitise firmware BAR assignments behind a PCI-PCI bridge

Manivannan Sadhasivam (13):
      MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint reviewer
      PCI: qcom-ep: Add kernel-doc for qcom_pcie_ep structure
      PCI: qcom-ep: Rely on the clocks supplied by devicetree
      PCI: qcom-ep: Make use of the cached dev pointer
      PCI: qcom-ep: Disable IRQs during driver remove
      PCI: qcom-ep: Expose link transition counts via debugfs
      PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS
      PCI: qcom-ep: Disable Master AXI Clock when there is no PCIe traffic
      dt-bindings: PCI: qcom-ep: Make PERST separation optional
      PCI: qcom-ep: Make PERST separation optional
      dt-bindings: PCI: qcom-ep: Define clocks per platform
      dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
      PCI: qcom-ep: Add support for SM8450 SoC

Mika Westerberg (7):
      PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
      PCI: Pass available buses even if the bridge is already configured
      PCI: Move pci_assign_unassigned_root_bus_resources()
      PCI: Distribute available resources for root buses, too
      PCI: Fix whitespace and indentation
      PCI: Fix typo in pci_scan_child_bus_extend()
      PCI/DPC: Quirk PIO log size for certain Intel Root Ports

Pali Rohár (7):
      PCI: mvebu: Fix endianness when accessing PCI emul bridge members
      PCI: pci-bridge-emul: Set position of PCI capabilities to real HW value
      PCI: aardvark: Add support for PCI Bridge Subsystem Vendor ID on emulated bridge
      PCI: Add standard PCI Config Address macros
      PCI: ftpci100: Use PCI_CONF1_ADDRESS() macro
      PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro
      PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro

Rajvi Jingar (1):
      PCI/PM: Simplify pci_pm_suspend_noirq()

Richard Zhu (2):
      PCI: imx6: Add i.MX8MP PCIe support
      phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()

Russell Currey (1):
      MAINTAINERS: Add Mahesh J Salgaonkar as EEH maintainer

Sajid Dalvi (1):
      PCI/PM: Reduce D3hot delay with usleep_range()

Vidya Sagar (2):
      PCI/ASPM: Refactor L1 PM Substates Control Register programming
      PCI/ASPM: Save L1 PM Substates Capability for suspend/resume

Will McVicker (1):
      PCI: dwc: Drop dependency on ZONE_DMA32

Yang Yingliang (2):
      PCI/P2PDMA: Use for_each_pci_dev() helper
      PCI: qcom-ep: Check platform_get_resource_byname() return value

 Documentation/ABI/testing/sysfs-bus-pci            |  33 ++
 .../bindings/pci/mediatek-pcie-gen3.yaml           |  13 +-
 .../bindings/pci/microchip,pcie-host.yaml          |  31 ++
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  86 +++--
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  80 ++++-
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |   8 +
 MAINTAINERS                                        |   5 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  33 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  28 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c            |   4 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 164 +++++++--
 drivers/pci/controller/dwc/pcie-qcom.c             | 128 +++----
 drivers/pci/controller/pci-aardvark.c              |   4 +
 drivers/pci/controller/pci-ftpci100.c              |  21 +-
 drivers/pci/controller/pci-mvebu.c                 |  13 +-
 drivers/pci/controller/pci-tegra.c                 |  11 +-
 drivers/pci/controller/pcie-apple.c                |   4 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |   2 +-
 drivers/pci/controller/pcie-mt7621.c               |  17 +-
 drivers/pci/msi/msi.c                              |   2 +-
 drivers/pci/p2pdma.c                               |   2 +-
 drivers/pci/pci-bridge-emul.c                      |  48 ++-
 drivers/pci/pci-bridge-emul.h                      |   2 +
 drivers/pci/pci-driver.c                           |  32 +-
 drivers/pci/pci-sysfs.c                            | 108 ++++++
 drivers/pci/pci.c                                  |  49 +--
 drivers/pci/pci.h                                  |  63 +++-
 drivers/pci/pcie/aspm.c                            | 256 +++++++++-----
 drivers/pci/pcie/dpc.c                             |  15 +-
 drivers/pci/pcie/ptm.c                             | 384 ++++++++++++---------
 drivers/pci/probe.c                                |  13 +-
 drivers/pci/quirks.c                               |  36 ++
 drivers/pci/setup-bus.c                            | 290 ++++++++++------
 drivers/pci/setup-res.c                            |  11 +
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |   8 +-
 include/linux/pci.h                                |   3 +
 37 files changed, 1321 insertions(+), 687 deletions(-)
