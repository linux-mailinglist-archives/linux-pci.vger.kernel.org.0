Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D664C0A5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 00:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiLMXa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 18:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiLMXa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 18:30:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA89B80;
        Tue, 13 Dec 2022 15:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F543B8124B;
        Tue, 13 Dec 2022 23:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945EEC433F0;
        Tue, 13 Dec 2022 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974252;
        bh=sUWNVYIWWUapDgaT28L9vWOquF7nZbV9SgSPrRLsOHI=;
        h=Date:From:To:Cc:Subject:From;
        b=adWEg4LUcqn+LA5NVQqAZPpkxRpSKk+45S5cDe1MAVLrP3nNT2y9GKGKDcJONclNb
         gdAukhYGNLKRU9YgRVsPqLIMv914fXgdCAwcgiwfo55eI0oPUt7DkB2Ip0yTFq+Xm3
         p5XOauxUJe7OvfkzUiEDclYWxYmdH0L8EaUVwW/pfXMZ62tr7WlB5EY1J8Y2FetYYR
         wCNzDmMZS+kEeLZg2ytV/JxwLUEppc7gEF6YuYna5e/bEI2kHuiaWC1W/KlJkTPC+P
         +sGW37wPsfqlFtb6M5RxkqFYDKkhbjR1dvxq5QBunsLEI+UpLj4nez+iPvAinwBtui
         vi/KY5n1XT/Bw==
Date:   Tue, 13 Dec 2022 17:30:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [GIT PULL] PCI changes for v6.2
Message-ID: <20221213233050.GA218218@bhelgaas>
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

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.2-changes

for you to fetch changes up to f826afe5eae856b3834cbc65db6178cccd4a3142:

  Merge branch 'pci/kbuild' (2022-12-10 10:36:52 -0600)


You will see a merge conflict in
Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml between these:

  5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
  4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")

5c3741492d2e is already in your tree via arm-soc, and 4cc13eedb892 is in
this pull request.  The resolution I suggest is to use 4cc13eedb892, which
means we'll lose the addition of "ecam" from 5c3741492d2e.  This resolution
has been in linux-next for a week or so and is available here if you're
interested:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=v6.2-merge&id=f64171fdd171

----------------------------------------------------------------

Enumeration:

  - Squash portdrv_{core,pci}.c into portdrv.c to ease maintenance and make
    more things static.

  - Make portdrv bind to Switch Ports that have AER.  Previously, if these
    Ports lacked MSI/MSI-X, portdrv failed to bind, which meant the Ports
    couldn't be suspended to low-power states.  AER on these Ports doesn't
    use interrupts, and the AER driver doesn't need to claim them.

  - Assign PCI domain IDs using ida_alloc(), which makes host bridge
    add/remove work better.

Resource management:

  - To work better with recent BIOSes that use EfiMemoryMappedIO for PCI
    host bridge apertures, remove those regions from the E820 map (E820
    entries normally prevent us from allocating BARs).  In v5.19, we added
    some quirks to disable E820 checking, but that's not very maintainable.
    EfiMemoryMappedIO means the OS needs to map the region for use by EFI
    runtime services; it shouldn't prevent OS from using it.

PCIe native device hotplug:

  - Build pciehp by default if USB4 is enabled, since Thunderbolt/USB4 PCIe
    tunneling depends on native PCIe hotplug.

  - Enable Command Completed Interrupt only if supported to avoid user
    confusion from lspci output that says this is enabled but not
    supported.

  - Prevent pciehp from binding to Switch Upstream Ports; this happened
    because of interaction with acpiphp and caused devices below the
    Upstream Port to disappear.

Power management:

  - Convert AGP drivers to generic power management.  We hope to remove
    legacy power management from the PCI core eventually.

Virtualization:

  - Fix pci_device_is_present(), which previously always returned "false"
    for VFs, causing virtio hangs when unbinding the driver.

Miscellaneous:

  - Convert drivers to gpiod API to prepare for dropping some legacy code.

  - Fix DOE fencepost error for the maximum data object length.

Baikal-T1 PCIe controller driver:

  - Add driver and DT bindings.

Broadcom STB PCIe controller driver:

  - Enable Multi-MSI.

  - Delay 100ms after PERST# deassert to allow power and clocks to
    stabilize.

  - Configure Read Completion Boundary to 64 bytes.

Freescale i.MX6 PCIe controller driver:

  - Initialize PHY before deasserting core reset to fix a regression in
    v6.0 on boards where the PHY provides the reference.

  - Fix imx6sx and imx8mq clock names in DT schema.

Intel VMD host bridge driver:

  - Fix Secondary Bus Reset on VMD bridges, which allows reset of NVMe SSDs
    in VT-d pass-through scenarios.

  - Disable MSI remapping, which gets re-enabled by firmware during
    suspend/resume.

MediaTek PCIe Gen3 controller driver:

  - Add MT7986 and MT8195 support.

Qualcomm PCIe controller driver:

  - Add SC8280XP/SA8540P basic interconnect support.

Rockchip DesignWare PCIe controller driver:

  - Base DT schema on common Synopsys schema.

Synopsys DesignWare PCIe core:

  - Collect DT items shared between Root Port and Endpoint (PERST GPIO, PHY
    info, clocks, resets, link speed, number of lanes, number of iATU
    windows, interrupt info, etc) to snps,dw-pcie-common.yaml.

  - Add dma-ranges support for Root Ports and Endpoints.

  - Consolidate DT resource retrieval for "dbi", "dbi2", "atu", etc. to
    reduce code duplication.

  - Add generic names for clocks and resets to encourage more consistent
    naming across drivers using DesignWare IP.

  - Stop advertising PTM Responder role for Endpoints, which aren't allowed
    to be responders.

TI J721E PCIe driver:

  - Add j721s2 host mode ID to DT schema.

  - Add interrupt properties to DT schema.

Toshiba Visconti PCIe controller driver:

  - Fix interrupts array max constraints in DT schema.

----------------------------------------------------------------
Albert Zhou (1):
      PCI: pciehp: Enable by default if USB4 enabled

Bjorn Helgaas (47):
      PCI/portdrv: Squash into portdrv.c
      PCI/portdrv: Move private things to portdrv.c
      PCI/portdrv: Unexport pcie_port_service_register(), pcie_port_service_unregister()
      agp/efficeon: Convert to generic power management
      agp/intel: Convert to generic power management
      agp/amd-k7: Convert to generic power management
      agp/ati: Convert to generic power management
      agp/nvidia: Convert to generic power management
      agp/amd64: Update to DEFINE_SIMPLE_DEV_PM_OPS()
      agp/sis: Update to DEFINE_SIMPLE_DEV_PM_OPS()
      agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()
      PCI/PM: Remove unused 'state' parameter to pci_legacy_suspend_late()
      Revert "PCI: Clear PCI_STATUS when setting up device"
      PCI: altera-msi: Include <linux/irqdomain.h> explicitly
      PCI: microchip: Include <linux/irqdomain.h> explicitly
      PCI: mvebu: Include <linux/irqdomain.h> explicitly
      PCI: xgene-msi: Include <linux/irqdomain.h> explicitly
      PCI: Remove unnecessary <linux/of_irq.h> includes
      PCI: Drop of_match_ptr() to avoid unused variables
      PCI/portdrv: Allow AER service only for Root Ports & RCECs
      efi/x86: Remove EfiMemoryMappedIO from E820 map
      PCI: Skip allocate_resource() if too little space available
      x86/PCI: Tidy E820 removal messages
      x86/PCI: Fix log message typo
      x86/PCI: Use pr_info() when possible
      Merge branch 'pci/doe'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/pm'
      Merge branch 'pci/pm-agp'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/resource'
      Merge branch 'pci/sysfs'
      Merge branch 'remotes/lorenzo/pci/dt'
      Merge branch 'remotes/lorenzo/pci/brcmstb'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/mt7621'
      Merge branch 'remotes/lorenzo/pci/qcom'
      Merge branch 'remotes/lorenzo/pci/tegra'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'pci/ctrl/aardvark'
      Merge branch 'pci/ctrl/mvebu'
      Merge branch 'pci/ctrl/xilinx'
      Merge branch 'pci/kbuild'

Dmitry Torokhov (4):
      PCI: tegra: Switch to using devm_fwnode_gpiod_get
      PCI: histb: Switch to using gpiod API
      PCI: aardvark: Switch to using devm_gpiod_get_optional()
      PCI: mvebu: Switch to using gpiod API

Francisco Munoz (1):
      PCI: vmd: Fix secondary bus reset for Intel bridges

Frank Li (7):
      PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
      PCI: endpoint: pci-epf-vntb: Fix struct epf_ntb_ctrl indentation
      PCI: endpoint: pci-epf-vntb: Fix call pci_epc_mem_free_addr() in error path
      PCI: endpoint: pci-epf-vntb: Remove unused epf_db_phy struct member
      PCI: endpoint: pci-epf-vntb: Replace hardcoded 4 with sizeof(u32)
      PCI: endpoint: pci-epf-vntb: Fix sparse build warning for epf_db
      PCI: endpoint: pci-epf-vntb: Fix sparse ntb->reg build warning

Frank Wunderlich (2):
      dt-bindings: PCI: mediatek-gen3: add SoC based clock config
      dt-bindings: PCI: mediatek-gen3: add support for mt7986

Ian Cowan (1):
      PCI: shpchp: Remove unused get_mode1_ECC_cap callback

Jianjun Wang (1):
      dt-bindings: PCI: mediatek-gen3: Support mt8195

Jim Quinlan (5):
      PCI: brcmstb: Enable Multi-MSI
      PCI: brcmstb: Wait for 100ms following PERST# deassert
      PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
      PCI: brcmstb: Drop needless 'inline' annotations
      PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits

Johan Hovold (3):
      dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
      PCI: qcom: Add basic interconnect support
      dt-bindings: PCI: qcom: Allow 'dma-coherent' property

John Thomson (1):
      PCI: mt7621: Add sentinel to quirks table

Kunihiko Hayashi (1):
      PCI: pci-epf-test: Register notifier if only core_init_notifier is enabled

Li Ming (1):
      PCI/DOE: Fix maximum data object length miscalculation

Maciej W. Rozycki (1):
      PCI: Access Link 2 registers only for devices with Links

Manivannan Sadhasivam (1):
      PCI: qcom: Fix error message for reset_control_assert()

Matt Ranostay (3):
      dt-bindings: PCI: ti,j721e-pci-host: add interrupt controller definition
      dt-bindings: PCI: ti,j721e-pci-*: Add missing interrupt properties
      dt-bindings: PCI: Add host mode device-id for j721s2 platform

Michael S. Tsirkin (1):
      PCI: Fix pci_device_is_present() for VFs by checking PF

Michal Simek (1):
      PCI: xilinx-nwl: Fix coding style violations

Nirmal Patel (1):
      PCI: vmd: Disable MSI remapping after suspend

Pali Rohár (2):
      PCI: Assign PCI domain IDs by ida_alloc()
      PCI: pciehp: Enable Command Completed Interrupt only if supported

Rafael J. Wysocki (2):
      PCI/portdrv: Set PCIE_PORT_SERVICE_HP for Root and Downstream Ports only
      PCI: acpiphp: Avoid setting is_hotplug_bridge for PCIe Upstream Ports

Sascha Hauer (2):
      PCI/sysfs: Fix double free in error path
      PCI: imx6: Initialize PHY before deasserting core reset

Serge Semin (20):
      dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
      dt-bindings: visconti-pcie: Fix interrupts array max constraints
      dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
      dt-bindings: PCI: dwc: Remove bus node from the examples
      dt-bindings: PCI: dwc: Add phys/phy-names common properties
      dt-bindings: PCI: dwc: Add max-link-speed common property
      dt-bindings: PCI: dwc: Apply generic schema for generic device only
      dt-bindings: PCI: dwc: Add max-functions EP property
      dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
      dt-bindings: PCI: dwc: Add reg/reg-names common properties
      dt-bindings: PCI: dwc: Add clocks/resets common properties
      dt-bindings: PCI: dwc: Add dma-coherent property
      dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
      dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
      PCI: dwc: Introduce dma-ranges property support for RC-host
      PCI: dwc: Introduce generic controller capabilities interface
      PCI: dwc: Introduce generic resources getter
      PCI: dwc: Combine iATU detection procedures
      PCI: dwc: Introduce generic platform clocks and resets
      PCI: dwc: Add Baikal-T1 PCIe controller support

Shunsuke Mie (1):
      PCI: endpoint: Fix Kconfig indent style

Vidya Sagar (4):
      PCI: dwc: Fix n_fts[] array overrun
      PCI: Add PCI_PTM_CAP_RES macro
      PCI: designware-ep: Disable PTM capabilities for EP mode
      PCI: dwc: Use dev_info for PCIe link down event logging

Yipeng Zou (1):
      PCI/ACPI: Use METHOD_NAME__UID instead of plain string

Yoshihiro Shimoda (1):
      PCI: endpoint: Fix WARN() when an endpoint driver is removed

Zeng Heng (1):
      PCI: Check for alloc failure in pci_request_irq()

 .../devicetree/bindings/pci/baikal,bt1-pcie.yaml   | 168 ++++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  46 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml           |  77 ++-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  22 +
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |   4 +-
 .../bindings/pci/snps,dw-pcie-common.yaml          | 266 +++++++++
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   | 206 +++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      | 256 +++++---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |   7 +
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |  22 +
 .../bindings/pci/toshiba,visconti-pcie.yaml        |   7 +-
 arch/x86/kernel/resource.c                         |  12 +-
 arch/x86/pci/acpi.c                                |  39 +-
 arch/x86/platform/efi/efi.c                        |  46 ++
 drivers/char/agp/amd-k7-agp.c                      |  24 +-
 drivers/char/agp/amd64-agp.c                       |   6 +-
 drivers/char/agp/ati-agp.c                         |  22 +-
 drivers/char/agp/efficeon-agp.c                    |  16 +-
 drivers/char/agp/intel-agp.c                       |  11 +-
 drivers/char/agp/nvidia-agp.c                      |  24 +-
 drivers/char/agp/sis-agp.c                         |   7 +-
 drivers/char/agp/via-agp.c                         |   6 +-
 drivers/pci/access.c                               |   8 +-
 drivers/pci/bus.c                                  |   4 +
 drivers/pci/controller/cadence/pci-j721e.c         |   1 -
 drivers/pci/controller/dwc/Kconfig                 |   9 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-imx6.c              |  13 +-
 drivers/pci/controller/dwc/pci-layerscape.c        |   1 -
 drivers/pci/controller/dwc/pcie-armada8k.c         |   1 -
 drivers/pci/controller/dwc/pcie-bt1.c              | 643 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  48 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  47 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 266 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h       |  63 +-
 drivers/pci/controller/dwc/pcie-histb.c            |  39 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  78 ++-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   1 -
 drivers/pci/controller/pci-aardvark.c              |  22 +-
 drivers/pci/controller/pci-ftpci100.c              |   2 +-
 drivers/pci/controller/pci-mvebu.c                 |  52 +-
 drivers/pci/controller/pci-tegra.c                 |   9 +-
 drivers/pci/controller/pci-v3-semi.c               |   3 +-
 drivers/pci/controller/pci-xgene-msi.c             |   2 +-
 drivers/pci/controller/pci-xgene.c                 |   1 -
 drivers/pci/controller/pcie-altera-msi.c           |   2 +-
 drivers/pci/controller/pcie-brcmstb.c              |  85 +--
 drivers/pci/controller/pcie-iproc-platform.c       |   1 -
 drivers/pci/controller/pcie-iproc.c                |   1 -
 drivers/pci/controller/pcie-microchip-host.c       |   2 +-
 drivers/pci/controller/pcie-mt7621.c               |   3 +-
 drivers/pci/controller/pcie-rockchip-host.c        |   1 -
 drivers/pci/controller/pcie-xilinx-cpm.c           |   1 -
 drivers/pci/controller/pcie-xilinx-nwl.c           |   8 +-
 drivers/pci/controller/vmd.c                       |  27 +-
 drivers/pci/doe.c                                  |  20 +-
 drivers/pci/endpoint/functions/Kconfig             |  18 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      | 150 +++--
 drivers/pci/endpoint/pci-epc-core.c                |   7 +-
 drivers/pci/hotplug/Kconfig                        |   3 +
 drivers/pci/hotplug/TODO                           |   3 -
 drivers/pci/hotplug/acpiphp_glue.c                 |   8 +
 drivers/pci/hotplug/pciehp_hpc.c                   |   4 +-
 drivers/pci/hotplug/shpchp.h                       |   1 -
 drivers/pci/hotplug/shpchp_hpc.c                   |  18 -
 drivers/pci/irq.c                                  |   2 +
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/pci/pci-driver.c                           |   8 +-
 drivers/pci/pci-sysfs.c                            |  13 +-
 drivers/pci/pci.c                                  | 109 ++--
 drivers/pci/pci.h                                  |   1 +
 drivers/pci/pcie/Kconfig                           |   8 +-
 drivers/pci/pcie/Makefile                          |   2 +-
 drivers/pci/pcie/{portdrv_core.c => portdrv.c}     | 269 ++++++++-
 drivers/pci/pcie/portdrv.h                         |  19 -
 drivers/pci/pcie/portdrv_pci.c                     | 252 --------
 drivers/pci/probe.c                                |  10 +-
 drivers/pci/remove.c                               |   6 +
 include/linux/pci.h                                |   1 +
 include/uapi/linux/pci_regs.h                      |   1 +
 81 files changed, 2748 insertions(+), 928 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
 rename drivers/pci/pcie/{portdrv_core.c => portdrv.c} (68%)
 delete mode 100644 drivers/pci/pcie/portdrv_pci.c
