Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73C228E02
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbgGVCZc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43604 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgGVCZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:32 -0400
Received: by mail-io1-f68.google.com with SMTP id k23so840694iom.10;
        Tue, 21 Jul 2020 19:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dM76I8T2hvU/uGGdUwBCUr17ZUHx72+ziEfU2vyCYNg=;
        b=PeyOJBN9LIUFwZE2Al1AL/yNbk+NhyQ9fvtftD/wUpY//pXlb4Mzw/K/R2cZl4CMte
         q/nMG5Iik1ZwipuxxbkSHq0qtQkbEdLpMpewshurhIU1R8byUZRP77/+DwiABpLucfn/
         TVJvxGlNMMKeT9HYnebksX0gYIUCT/Y0eJurWVp6W/un+Pb8iAW1K1Lt1du0ihNECxb8
         lZGGDBf2Bu3zZDXSDFctkATl0EI+gAQACUkuohOjEM7/oBe+rz6KFpaA3EhAqFnv/1gO
         g8eLbL3dO8IBzuFix4N3VXUOai54oaOn+n7wSQcMm/HyCplwdHrue3IGryAnoCaIJ8uB
         L9+A==
X-Gm-Message-State: AOAM5327deLybu+IFUxaZtT/XVEDAQEYA6NFrUIfDThMANfkRLI3b7+n
        RcYoKYZo2s1aDh7BnEs86w==
X-Google-Smtp-Source: ABdhPJwcM6hSvOl1VwpNPgxDhDu2K5qss0HSHlvrXTBU5Uq0xUO+ETk79Jm1CUbZAU/HX2ngncgWkQ==
X-Received: by 2002:a92:9a4f:: with SMTP id t76mr30984574ili.174.1595384731436;
        Tue, 21 Jul 2020 19:25:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:30 -0700 (PDT)
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
Subject: [PATCH 04/19] PCI: aardvark: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:24:59 -0600
Message-Id: <20200722022514.1283916-5-robh@kernel.org>
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

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f38663af795c..07d4a75b5c8f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -195,7 +195,6 @@ struct advk_pcie {
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
 	u16 msi_msg;
-	int root_bus_nr;
 	int link_gen;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
@@ -641,7 +640,7 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 				  int devfn)
 {
-	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
+	if (pci_is_root_bus(bus) && PCI_SLOT(devfn) != 0)
 		return false;
 
 	return true;
@@ -659,7 +658,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	if (bus->number == pcie->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return pci_bridge_emul_conf_read(&pcie->bridge, where,
 						 size, val);
 
@@ -670,7 +669,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->primary ==  pcie->root_bus_nr)
+	if (pci_is_root_bus(bus->parent))
 		reg |= PCIE_CONFIG_RD_TYPE0;
 	else
 		reg |= PCIE_CONFIG_RD_TYPE1;
@@ -715,7 +714,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number == pcie->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return pci_bridge_emul_conf_write(&pcie->bridge, where,
 						  size, val);
 
@@ -729,7 +728,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->primary == pcie->root_bus_nr)
+	if (pci_is_root_bus(bus->parent))
 		reg |= PCIE_CONFIG_WR_TYPE0;
 	else
 		reg |= PCIE_CONFIG_WR_TYPE1;
@@ -1139,7 +1138,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to parse resources\n");
 		return ret;
 	}
-	pcie->root_bus_nr = bus->start;
+	bridge->busnr = bus->start;
 
 	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
 						       "reset-gpios", 0,
-- 
2.25.1

