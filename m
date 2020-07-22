Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFFE228E11
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgGVCZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36413 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgGVCZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:50 -0400
Received: by mail-io1-f66.google.com with SMTP id t131so879661iod.3;
        Tue, 21 Jul 2020 19:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=np3nvy9/fZz73VqXI9ThmVn27stIXuKqAUSjtJ/i32Y=;
        b=i8kyif0yUjC3G3YhILH6iWz7ovb3EQWKzg66x0swTuq0Jc2ZAw/oJniS3ReBqPAxSn
         sXbwsgNNp4zLwdP5m7b956MsvfOLZT9pS07ywyGoi38cS2qKfkHVAu8n8dapo+cf58NB
         +7yeke2Ibe0wL9Abd3zyRwWsFVaB98FeZcs7v+RH+Mgy2wI5Y6HQS+Sv6BKkAxCwCiHV
         OASwRrdr4/r2MwYBndQ4KKnBLbr1TEEZ7PLQoo2MElRJS80jnCz9T4AuJWmgJPgF7DwR
         7MbOkrcMJkidUTOgBUevgRcufaQPOjI7k3MEtYspCgSLiXzY1GBhwigY/He2p2ntljjU
         DIBQ==
X-Gm-Message-State: AOAM532ntMINf6QL1l1GlOVK/jJdnD4cgo41ouqq2Wk1QePW+iwicIvh
        OVqx8DM5IS+ILbd3GkTlaw==
X-Google-Smtp-Source: ABdhPJxOOSSVvaL0MVT3rmsUbxxwRG1d0ASvsh0fZr4SPfQAI5vPpcBrPK1VmklnoR/sUruUvTcbZA==
X-Received: by 2002:a05:6638:22d0:: with SMTP id j16mr34632125jat.92.1595384749012;
        Tue, 21 Jul 2020 19:25:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:48 -0700 (PDT)
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
Subject: [PATCH 09/19] PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:25:04 -0600
Message-Id: <20200722022514.1283916-10-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_is_root_bus() rather than tracking the root bus number to
determine if the bus is the root bus or not. This removes storing
duplicated data as well as the need for the host bridge driver to have
to care about the bus numbers in most cases.

Also, bridge->busnr is never set so effectively the root bus must be 0.
This will be fixed by a subsequent commit.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 17 +++++++----------
 drivers/pci/controller/pcie-rockchip.h      |  1 -
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index fb88030161f2..9a30d08976d8 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -72,14 +72,14 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 				      struct pci_bus *bus, int dev)
 {
 	/* access only one slot on each root port */
-	if (bus->number == rockchip->root_bus_nr && dev > 0)
+	if (pci_is_root_bus(bus) && dev > 0)
 		return 0;
 
 	/*
 	 * do not read more than one device on the bus directly attached
 	 * to RC's downstream side.
 	 */
-	if (bus->primary == rockchip->root_bus_nr && dev > 0)
+	if (pci_is_root_bus(bus->parent) && dev > 0)
 		return 0;
 
 	return 1;
@@ -170,7 +170,7 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	if (bus->parent->number == rockchip->root_bus_nr)
+	if (pci_is_root_bus(bus->parent))
 		rockchip_pcie_cfg_configuration_accesses(rockchip,
 						AXI_WRAPPER_TYPE0_CFG);
 	else
@@ -201,7 +201,7 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 	if (!IS_ALIGNED(busdev, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (bus->parent->number == rockchip->root_bus_nr)
+	if (pci_is_root_bus(bus->parent))
 		rockchip_pcie_cfg_configuration_accesses(rockchip,
 						AXI_WRAPPER_TYPE0_CFG);
 	else
@@ -230,7 +230,7 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	if (bus->number == rockchip->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return rockchip_pcie_rd_own_conf(rockchip, where, size, val);
 
 	return rockchip_pcie_rd_other_conf(rockchip, bus, devfn, where, size,
@@ -245,7 +245,7 @@ static int rockchip_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number == rockchip->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return rockchip_pcie_wr_own_conf(rockchip, where, size, val);
 
 	return rockchip_pcie_wr_other_conf(rockchip, bus, devfn, where, size,
@@ -950,7 +950,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
-	struct resource *bus_res;
 	int err;
 
 	if (!dev->of_node)
@@ -991,12 +990,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_deinit_port;
 
 	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, &bus_res);
+					      &bridge->dma_ranges, NULL);
 	if (err)
 		goto err_remove_irq_domain;
 
-	rockchip->root_bus_nr = bus_res->start;
-
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
 		goto err_remove_irq_domain;
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 4012543bafbe..c7d0178fc8c2 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -298,7 +298,6 @@ struct rockchip_pcie {
 	struct	gpio_desc *ep_gpio;
 	u32	lanes;
 	u8      lanes_map;
-	u8	root_bus_nr;
 	int	link_gen;
 	struct	device *dev;
 	struct	irq_domain *irq_domain;
-- 
2.25.1

