Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19B3228E23
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgGVC0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:26:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36468 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbgGVC0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:26:11 -0400
Received: by mail-io1-f68.google.com with SMTP id t131so880839iod.3;
        Tue, 21 Jul 2020 19:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RXETcnjipP+8oLeDxXvLlltrH+ttPbWIrHJVUYWNNYw=;
        b=I0ma5eoS2Fu4ssnO9Nlyqh6rR+1ZJJwpiRgwzOT+sEIySgYXA3jDP9gCbH1Ohhnof3
         urE2mW9znfAcb++wxJ65VxUBURNnI/r022AFia0ym5ovvnh0A7l6He9WmgXXkckjvyhI
         BM/gF8uAWQHu2J17g3JJKT+1ImP8KKNlko3wo7AZuD2gzVTNPQ3GQWR9nNgV0BK/BICx
         bIgcf+P83juygJaZt/qakpdedGQf9jcti7jqkegfbu313SLDP816iFe8eOQtOP/wNrcN
         QsF4f5+6fyOfFPVIMQ7t+MHNpmbNMXsim76M2lJTXEoBR/TzNFaJHOaZHxLyjXuy102a
         pnnw==
X-Gm-Message-State: AOAM530GA77cUQvTIQPs1ZWKhe+TArNnDKOskNl9I8U234EkbaKZdrzk
        XVA1uDIxo3g/+3yQMdkDKw==
X-Google-Smtp-Source: ABdhPJx1PBfbdrTR8EDCpBeiH1ZDyq2MNA+2sxSJnY23nUstn2PPiOrmXIVCkGTujbAUG6lB8THf7w==
X-Received: by 2002:a5d:9b05:: with SMTP id y5mr30801250ion.59.1595384770914;
        Tue, 21 Jul 2020 19:26:10 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:26:10 -0700 (PDT)
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
Subject: [PATCH 15/19] PCI: rcar: Use struct pci_host_bridge.windows list directly
Date:   Tue, 21 Jul 2020 20:25:10 -0600
Message-Id: <20200722022514.1283916-16-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no need to create a temporary resource list and then splice it to
struct pci_host_bridge.windows list. Just use pci_host_bridge.windows
directly. The necessary clean-up is already handled by the PCI core.

Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 45 +++----------------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index c470bff5af0f..fa7b89378904 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -53,7 +53,6 @@ struct rcar_pcie_host {
 	struct device		*dev;
 	struct phy		*phy;
 	void __iomem		*base;
-	struct list_head	resources;
 	struct clk		*bus_clk;
 	struct			rcar_msi msi;
 	int			(*phy_init_fn)(struct rcar_pcie_host *host);
@@ -203,38 +202,6 @@ static struct pci_ops rcar_pcie_ops = {
 	.write	= rcar_pcie_write_conf,
 };
 
-static int rcar_pcie_setup(struct list_head *resource,
-			   struct rcar_pcie_host *host)
-{
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
-	struct resource_entry *win;
-	int i = 0;
-
-	/* Setup PCI resources */
-	resource_list_for_each_entry(win, &host->resources) {
-		struct resource *res = win->res;
-
-		if (!res->flags)
-			continue;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-		case IORESOURCE_MEM:
-			rcar_pcie_set_outbound(&host->pcie, i, win);
-			i++;
-			break;
-		case IORESOURCE_BUS:
-			break;
-		default:
-			continue;
-		}
-
-		pci_add_resource(resource, res);
-	}
-
-	return 1;
-}
-
 static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -292,6 +259,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 {
 	struct rcar_pcie *pcie = &host->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
 	struct resource_entry *win;
 	LIST_HEAD(res);
 	int i = 0;
@@ -300,7 +268,7 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 	rcar_pcie_force_speedup(pcie);
 
 	/* Setup PCI resources */
-	resource_list_for_each_entry(win, &host->resources) {
+	resource_list_for_each_entry(win, &bridge->windows) {
 		struct resource *res = win->res;
 
 		if (!res->flags)
@@ -319,12 +287,8 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
 static int rcar_pcie_enable(struct rcar_pcie_host *host)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
-	struct rcar_pcie *pcie = &host->pcie;
 
-	/* Try setting 5 GT/s link speed */
-	rcar_pcie_force_speedup(pcie);
-
-	rcar_pcie_setup(&bridge->windows, host);
+	rcar_pcie_hw_enable(host);
 
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
@@ -949,7 +913,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 	platform_set_drvdata(pdev, host);
 
-	err = pci_parse_request_of_pci_ranges(dev, &host->resources,
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
 					      &bridge->dma_ranges, NULL);
 	if (err)
 		return err;
@@ -1032,7 +996,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(dev);
-	pci_free_resource_list(&host->resources);
 
 	return err;
 }
-- 
2.25.1

