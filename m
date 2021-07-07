Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0573BF17C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhGGVpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 17:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGGVpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 17:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D414961C94;
        Wed,  7 Jul 2021 21:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625694162;
        bh=+Q+mYhXOJkdvBhONPOGw0MrCiDQXHRW5YTw/H/s6sxs=;
        h=Date:From:To:Cc:Subject:From;
        b=lDYeiGm9BRypGOQTRMyWXxTPLpwbp/iUSb658mrkfYmiVyGXivceUDv31M+8qKxtY
         HaSgOxwCgeqKipGy4KWNoVHUa8QsW6w7tkecIcdHrqk6y4SzTn1zOh0dp6IDPgnRFi
         H81HG1+uIUxsyVPhr22GijVjgJq/G17UheU2CeXtWZyCDvFmvA8Hf+AlWr/LQmL820
         7X+/zF4/bcMLfU6sbzkq+oL8hxHohZEtZm7t5x8nslYdun3Ukwitipdf4nmkA8R1e7
         d4WDu97eM2F9Zxkmm7EuT+5FozRdHL9OSgEvewFHdEBJEJ8LoCfrjM7gaVd+9vE/cq
         5czmZ9hkdkLjA==
Date:   Wed, 7 Jul 2021 16:42:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.14
Message-ID: <20210707214240.GA937039@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-changes

for you to fetch changes up to d58b2061105956f6e69691bf0259b1dd1e9fb601:

  Merge branch 'remotes/lorenzo/pci/mobiveil' (2021-07-06 10:56:32 -0500)

----------------------------------------------------------------

Enumeration:
  - Fix dsm_label_utf16s_to_utf8s() buffer overrun (Krzysztof Wilczyński)
  - Rely on lengths from scnprintf(), dsm_label_utf16s_to_utf8s()
    (Krzysztof Wilczyński)
  - Use sysfs_emit() and sysfs_emit_at() in "show" functions (Krzysztof
    Wilczyński)
  - Fix 'resource_alignment' newline issues (Krzysztof Wilczyński)
  - Add 'devspec' newline (Krzysztof Wilczyński)
  - Dynamically map ECAM regions (Russell King)

Resource management:
  - Coalesce host bridge contiguous apertures (Kai-Heng Feng)

PCIe native device hotplug:
  - Ignore Link Down/Up caused by DPC (Lukas Wunner)

Power management:
  - Leave Apple Thunderbolt controllers on for s2idle or standby
    (Konstantin Kharlamov)

Virtualization:
  - Work around Huawei Intelligent NIC VF FLR erratum (Chiqijun)
  - Clarify error message for unbound IOV devices (Moritz Fischer)
  - Add pci_reset_bus_function() Secondary Bus Reset interface (Raphael
    Norwitz)

Peer-to-peer DMA:
  - Simplify distance calculation (Christoph Hellwig)
  - Finish RCU conversion of pdev->p2pdma (Eric Dumazet)
  - Rename upstream_bridge_distance() and rework doc (Logan Gunthorpe)
  - Collect acs list in stack buffer to avoid sleeping (Logan Gunthorpe)
  - Use correct calc_map_type_and_dist() return type (Logan Gunthorpe)
  - Warn if host bridge not in whitelist (Logan Gunthorpe)
  - Refactor pci_p2pdma_map_type() (Logan Gunthorpe)
  - Avoid pci_get_slot(), which may sleep (Logan Gunthorpe)

Altera PCIe controller driver:
  - Add Joyce Ooi as Altera PCIe maintainer (Joyce Ooi)

Broadcom iProc PCIe controller driver:
  - Fix multi-MSI base vector number allocation (Sandor Bodo-Merle)
  - Support multi-MSI only on uniprocessor kernel (Sandor Bodo-Merle)

Freescale i.MX6 PCIe controller driver:
  - Limit DBI register length for imx6qp PCIe (Richard Zhu)
  - Add "vph-supply" for PHY supply voltage (Richard Zhu)
  - Enable PHY internal regulator when supplied >3V (Richard Zhu)
  - Remove imx6_pcie_probe() redundant error message (Zhen Lei)

Intel Gateway PCIe controller driver:
  - Fix INTx enable (Martin Blumenstingl)

Marvell Aardvark PCIe controller driver:
  - Fix checking for PIO Non-posted Request (Pali Rohár)
  - Implement workaround for the readback value of VEND_ID (Pali Rohár)

MediaTek PCIe controller driver:
  - Remove redundant error printing in mtk_pcie_subsys_powerup() (Zhen Lei)

MediaTek PCIe Gen3 controller driver:
  - Add missing MODULE_DEVICE_TABLE (Zou Wei)

Microchip PolarFlare PCIe controller driver:
  - Make struct event_descs static (Krzysztof Wilczyński)

Microsoft Hyper-V host bridge driver:
  - Fix race condition when removing the device (Long Li)
  - Remove bus device removal unused refcount/functions (Long Li)

Mobiveil PCIe controller driver:
  - Remove unused readl and writel functions (Krzysztof Wilczyński)

NVIDIA Tegra PCIe controller driver:
  - Add missing MODULE_DEVICE_TABLE (Zou Wei)

NVIDIA Tegra194 PCIe controller driver:
  - Fix tegra_pcie_ep_raise_msi_irq() ill-defined shift (Jon Hunter)
  - Fix host initialization during resume (Vidya Sagar)

Rockchip PCIe controller driver:
  - Register IRQ handlers after device and data are ready (Javier Martinez
    Canillas)

----------------------------------------------------------------
Bjorn Helgaas (26):
      PCI: xgene: Annotate __iomem pointer
      Merge branch 'pci/enumeration'
      Merge branch 'pci/error'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/host/imx6'
      Merge branch 'pci/host/intel-gw'
      Merge branch 'pci/host/rockchip'
      Merge branch 'pci/host/tegra'
      Merge branch 'pci/host/tegra194'
      Merge branch 'pci/host/xgene'
      Merge branch 'pci/kernel-doc'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/ftpci100'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/mediatek-gen3'
      Merge branch 'remotes/lorenzo/pci/microchip'
      Merge branch 'remotes/lorenzo/pci/mobiveil'

Chiqijun (1):
      PCI: Work around Huawei Intelligent NIC VF FLR erratum

Christoph Hellwig (1):
      PCI/P2PDMA: Simplify distance calculation

Eric Dumazet (1):
      PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma

Javier Martinez Canillas (1):
      PCI: rockchip: Register IRQ handlers after device and data are ready

Jon Hunter (1):
      PCI: tegra194: Fix tegra_pcie_ep_raise_msi_irq() ill-defined shift

Joyce Ooi (1):
      MAINTAINERS: Add Joyce Ooi as Altera PCIe maintainer

Kai-Heng Feng (1):
      PCI: Coalesce host bridge contiguous apertures

Konstantin Kharlamov (1):
      PCI: Leave Apple Thunderbolt controllers on for s2idle or standby

Krzysztof Wilczyński (9):
      PCI: microchip: Make the struct event_descs static
      PCI: mobiveil: Remove unused readl and writel functions
      PCI/sysfs: Fix dsm_label_utf16s_to_utf8s() buffer overrun
      PCI/sysfs: Rely on lengths from scnprintf(), dsm_label_utf16s_to_utf8s()
      PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
      PCI/sysfs: Fix 'resource_alignment' newline issues
      PCI/sysfs: Add 'devspec' newline
      PCI: cpcihp: Declare cpci_debug in header file
      PCI: Fix kernel-doc formatting

Logan Gunthorpe (6):
      PCI/P2PDMA: Rename upstream_bridge_distance() and rework doc
      PCI/P2PDMA: Collect acs list in stack buffer to avoid sleeping
      PCI/P2PDMA: Use correct calc_map_type_and_dist() return type
      PCI/P2PDMA: Warn if host bridge not in whitelist
      PCI/P2PDMA: Refactor pci_p2pdma_map_type()
      PCI/P2PDMA: Avoid pci_get_slot(), which may sleep

Long Li (2):
      PCI: hv: Fix a race condition when removing the device
      PCI: hv: Remove bus device removal unused refcount/functions

Lukas Wunner (1):
      PCI: pciehp: Ignore Link Down/Up caused by DPC

Martin Blumenstingl (1):
      PCI: intel-gw: Fix INTx enable

Moritz Fischer (1):
      PCI/IOV: Clarify error message for unbound devices

Niklas Schnelle (1):
      PCI: Print a debug message on PCI device release

Pali Rohár (2):
      PCI: aardvark: Fix checking for PIO Non-posted Request
      PCI: aardvark: Implement workaround for the readback value of VEND_ID

Randy Dunlap (1):
      PCI: ftpci100: Rename macro name collision

Raphael Norwitz (1):
      PCI: Add pci_reset_bus_function() Secondary Bus Reset interface

Richard Zhu (3):
      PCI: imx6: Limit DBI register length for imx6qp PCIe
      dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
      PCI: imx6: Enable PHY internal regulator when supplied >3V

Russell King (1):
      PCI: Dynamically map ECAM regions

Sandor Bodo-Merle (2):
      PCI: iproc: Fix multi-MSI base vector number allocation
      PCI: iproc: Support multi-MSI only on uniprocessor kernel

Vidya Sagar (1):
      PCI: tegra194: Fix host initialization during resume

Wesley Sheng (1):
      Documentation: PCI: Fix typo in pci-error-recovery.rst

Yang Li (1):
      x86/pci: Return true/false (not 1/0) from bool functions

Yicong Yang (1):
      PCI/AER: Use consistent format when printing PCI device

Zhen Lei (2):
      PCI: mediatek: Remove redundant error printing in mtk_pcie_subsys_powerup()
      PCI: imx6: Remove imx6_pcie_probe() redundant error message

Zou Wei (2):
      PCI: mediatek-gen3: Add missing MODULE_DEVICE_TABLE
      PCI: tegra: Add missing MODULE_DEVICE_TABLE

 Documentation/PCI/pci-error-recovery.rst           |   2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   3 +
 MAINTAINERS                                        |   6 +-
 arch/x86/pci/mmconfig-shared.c                     |  10 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   7 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  25 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |  10 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   4 +-
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c |  11 -
 drivers/pci/controller/pci-aardvark.c              |  13 +-
 drivers/pci/controller/pci-ftpci100.c              |  30 +-
 drivers/pci/controller/pci-hyperv.c                |  64 ++--
 drivers/pci/controller/pci-tegra.c                 |   1 +
 drivers/pci/controller/pci-xgene.c                 |   4 +-
 drivers/pci/controller/pcie-iproc-msi.c            |  35 +-
 drivers/pci/controller/pcie-iproc.c                |  24 +-
 drivers/pci/controller/pcie-iproc.h                |  16 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |   1 +
 drivers/pci/controller/pcie-mediatek.c             |   4 +-
 drivers/pci/controller/pcie-microchip-host.c       |   2 +-
 drivers/pci/controller/pcie-rockchip-host.c        |  12 +-
 drivers/pci/ecam.c                                 |  54 ++-
 drivers/pci/hotplug/cpci_hotplug.h                 |   3 +
 drivers/pci/hotplug/cpci_hotplug_pci.c             |   2 -
 drivers/pci/hotplug/cpqphp_core.c                  |   7 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |   2 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |   8 +-
 drivers/pci/hotplug/pciehp.h                       |   3 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  36 ++
 drivers/pci/hotplug/rpadlpar_sysfs.c               |   4 +-
 drivers/pci/hotplug/shpchp_sysfs.c                 |  38 ++-
 drivers/pci/iov.c                                  |  23 +-
 drivers/pci/msi.c                                  |   8 +-
 drivers/pci/p2pdma.c                               | 376 +++++++++++----------
 drivers/pci/pci-label.c                            |  22 +-
 drivers/pci/pci-sysfs.c                            |   2 +-
 drivers/pci/pci.c                                  |  54 +--
 drivers/pci/pci.h                                  |   8 +-
 drivers/pci/pcie/aer.c                             |  24 +-
 drivers/pci/pcie/aspm.c                            |   4 +-
 drivers/pci/pcie/dpc.c                             |  74 +++-
 drivers/pci/probe.c                                |  53 ++-
 drivers/pci/quirks.c                               |  76 +++++
 drivers/pci/slot.c                                 |  18 +-
 drivers/pci/switch/switchtec.c                     |  18 +-
 include/linux/pci-ecam.h                           |   1 +
 include/linux/pci-ep-cfs.h                         |   2 +-
 include/linux/pci-epc.h                            |   5 +-
 include/linux/pci-epf.h                            |   5 +-
 include/linux/pci.h                                |   2 +-
 include/linux/pci_hotplug.h                        |   2 +
 include/uapi/linux/pcitest.h                       |   2 +-
 52 files changed, 789 insertions(+), 431 deletions(-)
