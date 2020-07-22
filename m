Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899DC228DF4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgGVCZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39951 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgGVCZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:19 -0400
Received: by mail-io1-f68.google.com with SMTP id l17so860047iok.7;
        Tue, 21 Jul 2020 19:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVpjM+3Lpbcp75I5v0XW5iZgm+Uzzh+ISqSP/EdqLAY=;
        b=hIWbYCXFeBfy6V6QLpo1qaXQ+W6k3O3tghTGozblAzWsz5R07VRxcq3Ek/O7lh0fDS
         FoGGHs/G/gF5iA+qWrhM3ZuoLsCU98SlpVGJTWFw9teuoRFG7pK05f0fnzpHYsgmyLys
         hMDUWf0+cKyjQuMitlUuxYlen7tczK+WydrHcfZFEsl3XQ/bq6NYHsUqCGVYz6hxoJdz
         etAqWM4Q4/l3g26bNUi24vc+rdXANLxgG90/QKQo8F+PJSHequLAPu4k7MzbZBA90vgi
         l9gb0B0KWAhSWaUnHFhVBqA5ZOKOovNq3rds7bUw45oFgVju6rzNPwE7KoEOV8qgS/xR
         l/eg==
X-Gm-Message-State: AOAM531S/6IEJ0uabNVuFmZb3CV0lV7Agrm307ieT+pooBCI3NZLWu7C
        zk0XfV1DwEKir5tJq+7XrQ==
X-Google-Smtp-Source: ABdhPJxr05rMMRsQFoBitzl6yB3DcYcw69YY56hOTSjh7VzNAqLbMzXVJl4H+CDkJ9g9oe8zU/qUjQ==
X-Received: by 2002:a92:5a56:: with SMTP id o83mr31477790ilb.71.1595384717721;
        Tue, 21 Jul 2020 19:25:17 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 00/19] PCI: Another round of host clean-ups
Date:   Tue, 21 Jul 2020 20:24:55 -0600
Message-Id: <20200722022514.1283916-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Here's another round PCI host bridge clean-ups. This one aims to
reduce the amount of duplication in host probe functions by providing
more default initialization of the pci_host_bridge. With the prior
clean-ups, it's now possible to alloc and initialize the pci_host_bridge
struct from DT in one step.

Patches 2 and 3 drop some pci_host_bridge init. Patches 4-11 clean-up
handling of root bus number and bus ranges. Patches 12 and 13 are cleanups
for Cadence driver. Patches 14 and 15 are clean-ups for rCar driver. Patch
16 makes missing non-prefetchable region just a warning instead of an
error in order to work with rcar-gen2. Patch 17 converts rcar-gen2 to not
use the arm32 specific PCI setup. Patch 18 updates how the DT resource
parsing is done for all the controller drivers. Any other new controller
drivers will need updating. Patch 19 moves the default IRQ mapping to
the bridge init core code.

This is based on my previous series of clean-ups[1].

Compile tested only. Any testing would be appreciated as I don't have
any of this h/w (well, I have a rock960c, but have not gotten PCIe to work
on it).

Rob

[1] https://lore.kernel.org/linux-pci/20200522234832.954484-1-robh@kernel.org/

Rob Herring (19):
  PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
  PCI: Set default bridge parent device
  PCI: Drop unnecessary zeroing of bridge fields
  PCI: aardvark: Use pci_is_root_bus() to check if bus is root bus
  PCI: designware: Use pci_is_root_bus() to check if bus is root bus
  PCI: mobiveil: Use pci_is_root_bus() to check if bus is root bus
  PCI: xilinx-nwl: Use pci_is_root_bus() to check if bus is root bus
  PCI: xilinx: Use pci_is_root_bus() to check if bus is root bus
  PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus
  PCI: rcar: Use pci_is_root_bus() to check if bus is root bus
  PCI: Move setting pci_host_bridge.busnr out of host drivers
  PCI: cadence: Use bridge resources for outbound window setup
  PCI: cadence: Remove private bus number and range storage
  PCI: rcar: Use devm_pci_alloc_host_bridge()
  PCI: rcar: Use struct pci_host_bridge.windows list directly
  PCI: of: Reduce missing non-prefetchable memory region to a warning
  PCI: rcar-gen2: Convert to use modern host bridge probe functions
  PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
  PCI: Set bridge map_irq and swizzle_irq to default functions

 .../pci/controller/cadence/pcie-cadence-ep.c  |   6 +-
 .../controller/cadence/pcie-cadence-host.c    |  65 +++----
 drivers/pci/controller/cadence/pcie-cadence.c |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   8 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   4 +-
 .../pci/controller/dwc/pcie-designware-host.c |  28 +--
 drivers/pci/controller/dwc/pcie-designware.h  |   2 -
 .../controller/mobiveil/pcie-mobiveil-host.c  |  21 +--
 .../pci/controller/mobiveil/pcie-mobiveil.h   |   1 -
 drivers/pci/controller/pci-aardvark.c         |  25 +--
 drivers/pci/controller/pci-ftpci100.c         |  10 --
 drivers/pci/controller/pci-host-common.c      |  17 +-
 drivers/pci/controller/pci-loongson.c         |   8 -
 drivers/pci/controller/pci-mvebu.c            |   4 -
 drivers/pci/controller/pci-rcar-gen2.c        | 162 +++++-------------
 drivers/pci/controller/pci-tegra.c            |  10 --
 drivers/pci/controller/pci-v3-semi.c          |  12 --
 drivers/pci/controller/pci-versatile.c        |  13 +-
 drivers/pci/controller/pci-xgene.c            |   9 -
 drivers/pci/controller/pcie-altera.c          |  10 --
 drivers/pci/controller/pcie-brcmstb.c         |   9 -
 drivers/pci/controller/pcie-iproc-platform.c  |  10 +-
 drivers/pci/controller/pcie-iproc.c           |   3 -
 drivers/pci/controller/pcie-mediatek.c        |  16 --
 drivers/pci/controller/pcie-rcar-host.c       |  73 +-------
 drivers/pci/controller/pcie-rockchip-host.c   |  24 +--
 drivers/pci/controller/pcie-rockchip.h        |   1 -
 drivers/pci/controller/pcie-xilinx-nwl.c      |  20 +--
 drivers/pci/controller/pcie-xilinx.c          |  22 +--
 drivers/pci/of.c                              |  45 +++--
 drivers/pci/pci.h                             |   8 +
 drivers/pci/probe.c                           |   7 +
 include/linux/pci.h                           |  12 --
 34 files changed, 160 insertions(+), 516 deletions(-)

--
2.25.1
