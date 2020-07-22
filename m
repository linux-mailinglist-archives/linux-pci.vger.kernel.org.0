Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07933228E14
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgGVCZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36422 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgGVCZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:52 -0400
Received: by mail-io1-f68.google.com with SMTP id t131so879803iod.3;
        Tue, 21 Jul 2020 19:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JR3yCDURRRB9CMW6k6M1NZAeXdyv2WOTtRYEb08qPM8=;
        b=Zg4IrIPoVhxl+n0yHNIuc0mQ2DFh0vWqquJBR2wDpff1w2JLLgbLgcYhxFFoICEyBq
         r5w5boyLEeYoEg9DgejNxo3aDBrzSXs0sgJ2A8ZfAANmxoE5ZzGc8L3vqEBd1xRARgvB
         SwIA35AtL9l1w3uvC0caR9wNtaODQDd6lsUNhEqQkGAafAjmLjQ9uHkt6GRH0tlGdmK4
         D6FbuZwaleduRHM11th++m2dDGznQJSwy5OMXlCuT6Ovydh9SgrpopHklFR7KjeZXmCd
         BtYxo7DLsCl5DgBusk3pXXg8Wx/yg82R1XZCml7Ehp9kxRC8maT/Lns9d57J40tiODu9
         GRpA==
X-Gm-Message-State: AOAM533K4JWSFNP93S7uFuN2R+ud+MVaxPjiyKIDSXagPEeU2cYuYU7d
        mBI3OKzs3bsh9POu1pS8zw==
X-Google-Smtp-Source: ABdhPJzml2tF082UAvEzJCr4xKgGe/WHUKeAlheKtAfO4iCpGmzBe+KJwCilqQNoTsfj2ulcrePV7A==
X-Received: by 2002:a02:3f41:: with SMTP id c1mr1706694jaf.29.1595384751707;
        Tue, 21 Jul 2020 19:25:51 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:51 -0700 (PDT)
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
Subject: [PATCH 10/19] PCI: rcar: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:25:05 -0600
Message-Id: <20200722022514.1283916-11-robh@kernel.org>
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

Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 3a8e749b4904..bf10f1cf04f4 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -54,7 +54,6 @@ struct rcar_pcie_host {
 	struct phy		*phy;
 	void __iomem		*base;
 	struct list_head	resources;
-	int			root_bus_nr;
 	struct clk		*bus_clk;
 	struct			rcar_msi msi;
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
@@ -100,22 +99,14 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		if (dev != 0)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
-		if (access_type == RCAR_PCI_ACCESS_READ) {
+		if (access_type == RCAR_PCI_ACCESS_READ)
 			*data = rcar_pci_read_reg(pcie, PCICONF(index));
-		} else {
-			/* Keep an eye out for changes to the root bus number */
-			if (pci_is_root_bus(bus) && (reg == PCI_PRIMARY_BUS))
-				host->root_bus_nr = *data & 0xff;
-
+		else
 			rcar_pci_write_reg(pcie, *data, PCICONF(index));
-		}
 
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	if (host->root_bus_nr < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	/* Clear errors */
 	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
 
@@ -124,7 +115,7 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
 
 	/* Enable the configuration access */
-	if (bus->parent->number == host->root_bus_nr)
+	if (pci_is_root_bus(bus->parent))
 		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
 	else
 		rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
@@ -215,6 +206,7 @@ static struct pci_ops rcar_pcie_ops = {
 static int rcar_pcie_setup(struct list_head *resource,
 			   struct rcar_pcie_host *host)
 {
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
 	struct resource_entry *win;
 	int i = 0;
 
@@ -232,7 +224,7 @@ static int rcar_pcie_setup(struct list_head *resource,
 			i++;
 			break;
 		case IORESOURCE_BUS:
-			host->root_bus_nr = res->start;
+			bridge->busnr = res->start;
 			break;
 		default:
 			continue;
@@ -338,7 +330,6 @@ static int rcar_pcie_enable(struct rcar_pcie_host *host)
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
 	bridge->sysdata = host;
-	bridge->busnr = host->root_bus_nr;
 	bridge->ops = &rcar_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-- 
2.25.1

