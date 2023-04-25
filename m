Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6F6EE8D3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 22:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjDYUJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 16:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjDYUJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 16:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDE7694;
        Tue, 25 Apr 2023 13:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8830963012;
        Tue, 25 Apr 2023 20:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D990C433EF;
        Tue, 25 Apr 2023 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682453377;
        bh=zV8esPaqUOVudECHUdTN7Hbep+5lRQ22cwaPXeb9sHY=;
        h=Date:From:To:Cc:Subject:From;
        b=bDdhWWbwA2ZYypqbJzBoRstS5iWNi59Dh0A3pwvvI/FRwEdB7S1njeelb9J/6tQVq
         ru2FYHSHmpZA/Zgoio96FHRJUeej1gwMccrduSZLvIHWA6Jcoc1Trj5MDRjZib3F0I
         4TqqSXJT5Ux73mf92UWxjljk/yV1ezwYEpeNiw3eYrl8yEYEYFO9FP96AtZsJQnmKV
         H3O+hEZSsXlr6D9lDbCeQ7+PmrPGi9GIWONbvSJ922S+VcOsA5lc0JVB6z5J/FSB2S
         KOuEawlLJah3A9dWPibQhEL1tD3zFv/3KRvqrS+1wgump6AMsrmtg1OMplV5EeowzT
         HNLfBXW4w975g==
Date:   Tue, 25 Apr 2023 15:09:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: [GIT PULL] PCI changes for v6.4
Message-ID: <20230425200936.GA66754@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-changes

for you to fetch changes up to 09a8e5f01dfb30667a8f05e35c1cc073cb4fd134:

  Merge branch 'pci/controller/kconfig' (2023-04-20 16:19:37 -0500)

You should see a trivial conflict between f195fc1e9715 ("x86/PCI: Add quirk
for AMD XHCI controller that loses MSI-X state in D3hot"), which you
already have, and 606012dddebb ("PCI: Fix up L1SS capability for Intel
Apollo Lake Root Port"), which is included here.

----------------------------------------------------------------

Resource management:

  - Add pci_dev_for_each_resource() and pci_bus_for_each_resource()
    iterators.

PCIe native device hotplug:

  - Fix AB-BA deadlock between reset_lock and device_lock.

Power management:

  - Wait longer for devices to become ready after resume (as we do for reset)
    to accommodate Intel Titan Ridge xHCI devices.

  - Extend D3hot delay for NVIDIA HDA controllers to avoid unrecoverable
    devices after a bus reset.

Error handling:

  - Clear PCIe Device Status after EDR since generic error recovery now
    only clears it when AER is native.

ASPM:

  - Work around Chromebook firmware defect that clobbers Capability list
    (including ASPM L1 PM Substates Cap) when returning from D3cold to D0.

Freescale i.MX6 PCIe controller driver:

  - Install imprecise external abort handler only when DT indicates PCIe
    support.

Freescale Layerscape PCIe controller driver:

  - Add ls1028a endpoint mode support.

Qualcomm PCIe controller driver:

  - Add SM8550 DT binding and driver support.

  - Add SDX55 DT binding and driver support.

  - Use bulk APIs for clocks of IP 1.0.0, 2.3.2, 2.3.3.

  - Use bulk APIs for reset of IP 2.1.0, 2.3.3, 2.4.0.

  - Add DT "mhi" register region for supported SoCs.

  - Expose link transition counts via debugfs to help debug low power
    issues.

  - Support system suspend and resume; reduce interconnect bandwidth and
    turn off clock and PHY if there are no active devices.

  - Enable async probe by default to reduce boot time.

Miscellaneous:

  - Sort controller Kconfig entries by vendor.

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: PCI: qcom: Add SM8550 compatible
      PCI: qcom: Add SM8550 PCIe support

Alex Williamson (1):
      PCI/PM: Extend D3hot delay for NVIDIA HDA controllers

Andy Shevchenko (4):
      PCI: Introduce pci_resource_n()
      PCI: Document pci_bus_for_each_resource()
      PCI: Make pci_bus_for_each_resource() index optional
      EISA: Drop unused pci_bus_for_each_resource() index argument

Bjorn Helgaas (25):
      efi/cper: Remove unnecessary aer.h include
      PCI/EDR: Add edr_handle_event() comments
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/controller/dt'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/ixp4xx'
      Merge branch 'pci/controller/kirin'
      Merge branch 'pci/controller/layerscape'
      Merge branch 'pci/controller/mt7621'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rcar'
      PCI: meson: Add 'Amlogic' to Kconfig prompt
      PCI: hv: Add 'Microsoft' to Kconfig prompt
      PCI: xilinx-nwl: Add 'Xilinx' to Kconfig prompt
      PCI: Use consistent controller Kconfig menu entry language
      PCI: Sort controller Kconfig entries by vendor
      PCI: dwc: Sort Kconfig entries by vendor
      PCI: mobiveil: Sort Kconfig entries by vendor
      Merge branch 'pci/controller/kconfig'

Cai Huoqing (1):
      PCI/P2PDMA: Fix pci_p2pmem_find_many() kernel-doc

H. Nikolaus Schaller (1):
      PCI: imx6: Install the fault handler only on compatible match

Jean Delvare (1):
      PCI: xilinx: Drop obsolete dependency on COMPILE_TEST

Josh Triplett (1):
      PCI: kirin: Select REGMAP_MMIO

Kuppuswamy Sathyanarayanan (1):
      PCI/EDR: Clear Device Status after EDR error recovery

Lukas Bulwahn (1):
      PCI: rcar: Avoid defines prefixed with CONFIG

Lukas Wunner (1):
      PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock

Manivannan Sadhasivam (23):
      PCI: qcom: Fix the incorrect register usage in v2.7.0 config
      PCI: qcom: Remove PCIE20_ prefix from register definitions
      PCI: qcom: Sort and group registers and bitfield definitions
      PCI: qcom: Use bitfield definitions for register fields
      PCI: qcom: Add missing macros for register fields
      PCI: qcom: Use lower case for hex
      PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
      PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
      PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
      PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
      PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
      PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
      PCI: qcom: Use macros for defining total no. of clocks & supplies
      PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
      dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
      PCI: qcom: Expose link transition counts via debugfs
      PCI: qcom: Add support for system suspend and resume
      PCI: qcom: Enable async probe by default
      dt-bindings: PCI: qcom: Update maintainers entry
      dt-bindings: PCI: qcom: Add SDX55 SoC
      dt-bindings: PCI: qcom-ep: Fix the unit address used in example
      PCI: qcom: Add support for SDX55 SoC
      dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties

Mika Westerberg (3):
      PCI: Introduce pci_dev_for_each_resource()
      PCI/PM: Increase wait time after resume
      PCI/PM: Drop pci_bridge_wait_for_secondary_bus() timeout parameter

Neil Armstrong (1):
      dt-bindings: PCI: convert amlogic,meson-pcie.txt to dt-schema

Pali Rohár (1):
      PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro

Richard Zhu (1):
      dt-bindings: imx6q-pcie: Restruct i.MX PCIe schema

Rob Herring (1):
      PCI: Use of_property_present() for testing DT property presence

Ron Lee (1):
      PCI: Fix up L1SS capability for Intel Apollo Lake Root Port

Sergio Paracuellos (1):
      PCI: mt7621: Use dev_info() to log PCIe card detection

Xiaowei Bao (1):
      PCI: layerscape: Add EP mode support for ls1028a

 .clang-format                                      |    1 +
 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  |  134 +++
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |   70 --
 .../bindings/pci/fsl,imx6q-pcie-common.yaml        |  279 +++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml |   85 ++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  240 +---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |    2 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |   91 +-
 MAINTAINERS                                        |    2 +
 arch/alpha/kernel/pci.c                            |    5 +-
 arch/arm/kernel/bios32.c                           |   16 +-
 arch/arm/mach-dove/pcie.c                          |   10 +-
 arch/arm/mach-mv78xx0/pcie.c                       |   10 +-
 arch/arm/mach-orion5x/pci.c                        |   10 +-
 arch/mips/pci/ops-bcm63xx.c                        |    8 +-
 arch/mips/pci/pci-legacy.c                         |    3 +-
 arch/powerpc/kernel/pci-common.c                   |   21 +-
 arch/powerpc/platforms/4xx/pci.c                   |    8 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |    5 +-
 arch/powerpc/platforms/pseries/pci.c               |   16 +-
 arch/sh/drivers/pci/pcie-sh7786.c                  |   10 +-
 arch/sparc/kernel/leon_pci.c                       |    5 +-
 arch/sparc/kernel/pci.c                            |   10 +-
 arch/sparc/kernel/pcic.c                           |    5 +-
 arch/x86/pci/fixup.c                               |   59 +
 drivers/eisa/pci_eisa.c                            |    4 +-
 drivers/firmware/efi/cper-arm.c                    |    1 -
 drivers/pci/bus.c                                  |    7 +-
 drivers/pci/controller/Kconfig                     |  463 ++++----
 drivers/pci/controller/cadence/Kconfig             |   10 +-
 drivers/pci/controller/dwc/Kconfig                 |  517 ++++----
 drivers/pci/controller/dwc/pci-imx6.c              |    7 +
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |    1 +
 drivers/pci/controller/dwc/pcie-qcom.c             | 1246 ++++++++------------
 drivers/pci/controller/mobiveil/Kconfig            |   19 +-
 drivers/pci/controller/pci-ixp4xx.c                |   10 +-
 drivers/pci/controller/pci-tegra.c                 |    4 +-
 drivers/pci/controller/pcie-mediatek.c             |    2 +-
 drivers/pci/controller/pcie-mt7621.c               |    4 +-
 drivers/pci/controller/pcie-rcar-host.c            |    4 +-
 drivers/pci/controller/pcie-rcar.h                 |    2 +-
 drivers/pci/hotplug/pciehp_pci.c                   |   15 +
 drivers/pci/hotplug/rpaphp_core.c                  |    4 +-
 drivers/pci/hotplug/shpchp_sysfs.c                 |    8 +-
 drivers/pci/of.c                                   |    2 +-
 drivers/pci/p2pdma.c                               |    3 +-
 drivers/pci/pci-driver.c                           |    3 +-
 drivers/pci/pci.c                                  |   21 +-
 drivers/pci/pci.h                                  |    9 +-
 drivers/pci/pcie/dpc.c                             |    3 +-
 drivers/pci/pcie/edr.c                             |   12 +-
 drivers/pci/probe.c                                |    2 +-
 drivers/pci/quirks.c                               |   13 +
 drivers/pci/remove.c                               |    5 +-
 drivers/pci/setup-bus.c                            |   37 +-
 drivers/pci/setup-res.c                            |    4 +-
 drivers/pci/vgaarb.c                               |   17 +-
 drivers/pci/xen-pcifront.c                         |    4 +-
 drivers/pnp/quirks.c                               |   29 +-
 include/linux/pci.h                                |   71 +-
 60 files changed, 1923 insertions(+), 1745 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
