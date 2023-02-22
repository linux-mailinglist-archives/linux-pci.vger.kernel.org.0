Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696AA69FCEE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 21:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjBVUR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 15:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBVUR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 15:17:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312769EE5;
        Wed, 22 Feb 2023 12:17:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6B0EB81603;
        Wed, 22 Feb 2023 20:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277B8C433D2;
        Wed, 22 Feb 2023 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677097071;
        bh=EBLddN2Sv7VISAcqLeJtNAqxqwmv/57P5jiq+YTIheU=;
        h=Date:From:To:Cc:Subject:From;
        b=HP/FmmNex74c6BQEP+GTsZzSuSTSAV2F4phFBjur6PBy2XzFRxFNmvzPxygnWxkOJ
         D5KeuR9tKeMPhJxbO/EDzFieT8xFwpx6xIjs5Jb6UUIpBWNISP6bLg3a861OKBmImW
         yEA5NPcF4DLPtrAgpuq/BS5P3zCemRkyBgmTqqCcdjAwnTFvVNKnQ0YDVjcGRrovDX
         pJNhgEqd28BFrFT3vFPDThmiHmM7eAs0iUOvLapU18f1bvw5fJWeDQtf+8OY2MQ2Mv
         YYEHjTLBQRNx3pSEc5IvWYo3QjBv69oDrkC8p8KYCrd0fhdEg+G+jeJTmvBI0+PCJo
         +I+gS8g0TBKDQ==
Date:   Wed, 22 Feb 2023 14:17:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL] PCI changes for v6.3
Message-ID: <20230222201749.GA3798224@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This includes several Synopsys DesignWare eDMA controller driver changes
that are in drivers/dma, not drivers/pci.  These lead up to eDMA support in
PCIe Root Port and Endpoint drivers and have been acked by Vinod.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-changes

for you to fetch changes up to 3eb5d0f26f4ea604e83ca499a72c0d33638f4765:

  Merge branch 'pci/misc' (2023-02-22 13:47:32 -0600)

----------------------------------------------------------------
Enumeration:

  - Rework portdrv shutdown so it disables interrupts but doesn't disable
    bus mastering, which leads to hangs on Loongson LS7A.

  - Add mechanism to prevent Max_Read_Request_Size (MRRS) increases, again
    to avoid hardware issues on Loongson LS7A (and likely other devices
    based on DesignWare IP).

  - Ignore devices with a firmware (DT or ACPI) node that says the device
    is disabled.

Resource management:

  - Distribute spare resources to unconfigured hotplug bridges at boot-time
    (not just when hot-adding such a bridge), which makes hot-adding
    devices to docks work better.  Tried this in v6.1 but had to revert for 
    regressions, so try again.

  - Fix root bus issue that dropped resources that happened to end at 0,
    e.g., [bus 00].

PCI device hotplug:

  - Remove device locking when marking device as disconnected so this
    doesn't have to wait for concurrent driver bind/unbind to complete.

  - Quirk more Qualcomm bridges that don't fully implement the PCIe Slot
    Status 'Command Completed' bit.

Power management:

  - Account for _S0W of the target bridge in acpi_pci_bridge_d3() so we
    don't miss hot-add notifications for USB4 docks, Thunderbolt, etc.

Reset:

  - Observe delay after reset, e.g., resuming from system sleep, regardless
    of whether a bridge can suspend to D3cold at runtime.

  - Wait for secondary bus to become ready after a bridge reset.

Virtualization:

  - Avoid FLR on some AMD FCH AHCI adapters where it doesn't work.

  - Allow independent IOMMU groups for some Wangxun NICs that prevent
    peer-to-peer transactions but don't advertise an ACS Capability.

Error handling:

  - Configure End-to-End-CRC (ECRC) only if Linux owns the AER Capability.

  - Remove redundant Device Control Error Reporting Enable in the AER
    service driver since this is already done for all devices during
    enumeration.

ASPM:

  - Add pci_enable_link_state() interface to allow drivers to enable ASPM
    link state.

Endpoint framework:

  - Move dra7xx and tegra194 linkup processing from hard IRQ to threaded
    IRQ handler.

  - Add a separate lock for endpoint controller list of endpoint function
    drivers to prevent deadlock in callbacks.

  - Pass events from endpoint controller to endpoint function drivers via
    callbacks instead of notifiers.

Synopsys DesignWare eDMA controller driver (acked by Vinod):

  - Fix CPU vs PCI address issues.

  - Fix source vs destination address issues.

  - Fix issues with interleaved transfer semantics.

  - Fix channel count initialization issue (issue still exists in several
    other drivers).

  - Clean up and improve debugfs usage so it will work on platforms with
    several eDMA devices.

Baikal T-1 PCIe controller driver:

  - Set a 64-bit DMA mask.

Freescale i.MX6 PCIe controller driver:

  - Add i.MX8MM, i.MX8MQ, i.MX8MP endpoint mode DT binding and driver
    support.

Intel VMD host bridge driver:

  - Add quirk to configure PCIe ASPM and LTR.  This is normally done by
    BIOS, and will be for future products.

Marvell MVEBU PCIe controller driver:

  - Mark this driver as broken in Kconfig since bugs prevent its daily
    usage.

MediaTek MT7621 PCIe controller driver:

  - Delay PHY port initialization to improve boot reliability for ZBT
    WE1326, ZBT WF3526-P, and some Netgear models.

Qualcomm PCIe controller driver:

  - Add MSM8998 DT compatible string.

  - Unify MSM8996 and MSM8998 clock orderings.

  - Add SM8350 DT binding and driver support.

  - Add IPQ8074 Gen3 DT binding and driver support.

  - Correct qcom,perst-regs in DT binding.

  - Add qcom_pcie_host_deinit() so the PHY is powered off and regulators
    and clocks are disabled on late host-init errors.

Socionext UniPhier Pro5 controller driver:

  - Clean up uniphier-ep reg, clocks, resets, and their names in DT
    binding.

Synopsys DesignWare PCIe controller driver:

  - Restrict coherent DMA mask to 32 bits for MSI, but allow controller
    drivers to set 64-bit streaming DMA mask.

  - Add eDMA engine support in both Root Port and Endpoint controllers.

Miscellaneous:

  - Remove MODULE_LICENSE from boolean drivers so they don't look like
    modules so modprobe can complain about them.

----------------------------------------------------------------
Alexey V. Vissarionov (1):
      PCI/IOV: Enlarge virtfn sysfs name buffer

Bjorn Helgaas (23):
      PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
      PCI: switchtec: Return -EFAULT for copy_to_user() errors
      PCI/AER: Remove redundant Device Control Error Reporting Enable
      Merge branch 'pci/aer'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/iov'
      Merge branch 'pci/kbuild'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/mt7621'
      Merge branch 'pci/controller/mvebu'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/switchtec'
      Merge branch 'pci/controller/uniphier'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/misc'

Damien Le Moal (1):
      PCI: Avoid FLR for AMD FCH AHCI adapters

David E. Box (3):
      PCI: vmd: Use PCI_VDEVICE in device list
      PCI: vmd: Create feature grouping for client products
      PCI: vmd: Add quirk to configure PCIe ASPM and LTR

Dmitry Baryshkov (2):
      dt-bindings: PCI: qcom: Add SM8350
      PCI: qcom: Add SM8350 support

Geert Uytterhoeven (1):
      PCI: Fix dropping valid root bus resources with .end = zero

Huacai Chen (3):
      PCI/portdrv: Prevent LS7A Bus Master clearing on shutdown
      PCI: loongson: Prevent LS7A MRRS increases
      PCI: loongson: Add more devices that need MRRS quirk

Johan Hovold (1):
      PCI: qcom: Fix host-init error handling

Krzysztof Kozlowski (4):
      dt-bindings: PCI: qcom: Add oneOf to compatible match
      dt-bindings: PCI: qcom: Add MSM8998 specific compatible
      dt-bindings: PCI: qcom: Unify MSM8996 and MSM8998 clock order
      dt-bindings: PCI: qcom-ep: Correct qcom,perst-regs

Kunihiko Hayashi (1):
      dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their names

Logan Gunthorpe (1):
      PCI/P2PDMA: Annotate RCU dereference

Lukas Bulwahn (1):
      PCI: hv: Drop duplicate PCI_MSI dependency

Lukas Wunner (4):
      PCI/PM: Observe reset delay irrespective of bridge_d3
      PCI: Unify delay handling for reset and resume
      PCI/DPC: Await readiness of secondary bus after reset
      PCI: hotplug: Allow marking devices as disconnected during bind/unbind

Manivannan Sadhasivam (6):
      PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
      PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
      PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
      PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
      PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
      PCI: pciehp: Add Qualcomm quirk for Command Completed erratum

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun NICs

Michael Bottini (1):
      PCI/ASPM: Add pci_enable_link_state()

Mika Westerberg (3):
      PCI: Align extra resources for hotplug bridges properly
      PCI: Take other bus devices into account when distributing resources
      PCI: Distribute available resources for root buses, too

Nick Alcock (1):
      PCI: Remove MODULE_LICENSE so boolean drivers don't look like modules

Pali Roh·r (1):
      PCI: mvebu: Mark driver as BROKEN

Rafael J. Wysocki (1):
      PCI/ACPI: Account for _S0W of the target bridge in acpi_pci_bridge_d3()

Randy Dunlap (1):
      misc: pci_endpoint_test: Drop initial kernel-doc marker

Richard Zhu (8):
      dt-bindings: imx6q-pcie: Add i.MX8MM PCIe EP mode compatible string
      dt-bindings: imx6q-pcie: Add i.MX8MQ PCIe EP mode compatible string
      dt-bindings: imx6q-pcie: Add i.MX8MP PCIe EP mode compatible string
      misc: pci_endpoint_test: Add i.MX8 PCIe EP device support
      PCI: imx6: Add i.MX PCIe EP mode support
      PCI: imx6: Add i.MX8MQ PCIe EP support
      PCI: imx6: Add i.MX8MM PCIe EP support
      PCI: imx6: Add i.MX8MP PCIe EP support

Rob Herring (1):
      PCI: Honor firmware's device disabled status

Robert Marko (3):
      dt-bindings: PCI: qcom: Sort compatibles alphabetically
      dt-bindings: PCI: qcom: Add IPQ8074 Gen3 port
      PCI: qcom: Add IPQ8074 Gen3 port support

Serge Semin (29):
      dmaengine: Fix dma_slave_config.dst_addr description
      dmaengine: dw-edma: Release requested IRQs on failure
      dmaengine: dw-edma: Convert ll/dt phys address to PCI bus/DMA address
      dmaengine: dw-edma: Fix missing src/dst address of interleaved xfers
      dmaengine: dw-edma: Don't permit non-inc interleaved xfers
      dmaengine: dw-edma: Fix invalid interleaved xfers semantics
      dmaengine: dw-edma: Add CPU to PCI bus address translation
      dmaengine: dw-edma: Add PCI bus address getter to the remote EP glue driver
      dmaengine: dw-edma: Drop chancnt initialization
      dmaengine: dw-edma: Drop unnecessary debugfs reg casts
      dmaengine: dw-edma: Stop checking debugfs_create_*() return value
      dmaengine: dw-edma: Add dw_edma prefix to debugfs nodes descriptor
      dmaengine: dw-edma: Convert debugfs descs to being heap-allocated
      dmaengine: dw-edma: Rename debugfs dentry variables to 'dent'
      dmaengine: dw-edma: Simplify debugfs context CSRs init procedure
      dmaengine: dw-edma: Move eDMA data pointer to debugfs node descriptor
      dmaengine: dw-edma: Join read/write channels into a single device
      dmaengine: dw-edma: Use DMA engine device debugfs subdirectory
      dmaengine: dw-edma: Fix readq_ch() return value truncation
      dmaengine: dw-edma: Use non-atomic io-64 methods
      dmaengine: dw-edma: Drop DT-region allocation
      dmaengine: dw-edma: Replace chip ID number with device name
      dmaengine: dw-edma: Skip cleanup procedure if no private data found
      dmaengine: dw-edma: Add mem-mapped LL-entries support
      dmaengine: dw-edma: Depend on DW_EDMA instead of selecting it
      dmaengine: dw-edma: Prepare dw_edma_probe() for builtin callers
      PCI: dwc: Restrict only coherent DMA mask for MSI address allocation
      PCI: bt1: Set 64-bit DMA mask
      PCI: dwc: Add Root Port and Endpoint controller eDMA engine support

Sergio Paracuellos (1):
      PCI: mt7621: Delay phy ports initialization

Thomas Weiﬂschuh (1):
      PCI/sysfs: Constify struct kobj_type pci_slot_ktype

Vidya Sagar (1):
      PCI/AER: Configure ECRC only if AER is native

Yang Yingliang (1):
      PCI: endpoint: pci-epf-vntb: Add epf_ntb_mw_bar_clear() num_mws kernel-doc

 Documentation/admin-guide/kernel-parameters.txt    |   4 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   3 +
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |   6 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 103 ++++--
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  76 +++--
 drivers/acpi/device_pm.c                           |  19 ++
 drivers/dma/dw-edma/Kconfig                        |   5 +-
 drivers/dma/dw-edma/dw-edma-core.c                 | 198 +++++------
 drivers/dma/dw-edma/dw-edma-core.h                 |  10 +-
 drivers/dma/dw-edma/dw-edma-pcie.c                 |  56 ++--
 drivers/dma/dw-edma/dw-edma-v0-core.c              | 100 +++---
 drivers/dma/dw-edma/dw-edma-v0-core.h              |   1 -
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c           | 368 ++++++++++-----------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h           |   5 -
 drivers/misc/pci_endpoint_test.c                   |   4 +-
 drivers/pci/controller/Kconfig                     |   3 +-
 drivers/pci/controller/dwc/Kconfig                 |  23 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 200 ++++++++++-
 drivers/pci/controller/dwc/pcie-bt1.c              |   4 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  12 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  25 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 195 +++++++++++
 drivers/pci/controller/dwc/pcie-designware.h       |  21 ++
 drivers/pci/controller/dwc/pcie-histb.c            |   1 -
 drivers/pci/controller/dwc/pcie-qcom.c             |  15 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   9 +-
 .../pci/controller/mobiveil/pcie-mobiveil-plat.c   |   1 -
 drivers/pci/controller/pci-loongson.c              |  69 ++--
 drivers/pci/controller/pci-tegra.c                 |   1 -
 drivers/pci/controller/pci-versatile.c             |   1 -
 drivers/pci/controller/pcie-hisi-error.c           |   1 -
 drivers/pci/controller/pcie-microchip-host.c       |   1 -
 drivers/pci/controller/pcie-mt7621.c               |   2 +
 drivers/pci/controller/vmd.c                       |  97 ++++--
 drivers/pci/endpoint/functions/pci-epf-test.c      |  38 +--
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |   1 +
 drivers/pci/endpoint/pci-ep-cfs.c                  |   1 -
 drivers/pci/endpoint/pci-epc-core.c                |  33 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |   1 -
 drivers/pci/endpoint/pci-epf-core.c                |   1 -
 drivers/pci/hotplug/acpiphp_core.c                 |   1 -
 drivers/pci/hotplug/pciehp_hpc.c                   |   2 +
 drivers/pci/hotplug/shpchp_core.c                  |   1 -
 drivers/pci/iov.c                                  |   2 +-
 drivers/pci/p2pdma.c                               |   8 +-
 drivers/pci/pci-acpi.c                             |  45 ++-
 drivers/pci/pci-driver.c                           |   2 +-
 drivers/pci/pci.c                                  |  69 ++--
 drivers/pci/pci.h                                  |  59 ++--
 drivers/pci/pcie/aer.c                             |  51 +--
 drivers/pci/pcie/aspm.c                            |  54 +++
 drivers/pci/pcie/dpc.c                             |   4 +-
 drivers/pci/pcie/portdrv.c                         |  16 +-
 drivers/pci/probe.c                                |   4 +-
 drivers/pci/quirks.c                               |  23 ++
 drivers/pci/setup-bus.c                            | 248 ++++++++++----
 drivers/pci/slot.c                                 |   2 +-
 drivers/pci/switch/switchtec.c                     |  13 +-
 include/acpi/acpi_bus.h                            |   1 +
 include/linux/dma/edma.h                           |  25 +-
 include/linux/dmaengine.h                          |   2 +-
 include/linux/pci-epc.h                            |  10 +-
 include/linux/pci-epf.h                            |  19 +-
 include/linux/pci.h                                |   8 +
 include/linux/pci_ids.h                            |   2 +
 66 files changed, 1573 insertions(+), 814 deletions(-)
