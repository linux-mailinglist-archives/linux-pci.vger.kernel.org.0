Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8C228E1A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbgGVC0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:26:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34591 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbgGVC0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:26:02 -0400
Received: by mail-io1-f65.google.com with SMTP id q74so892444iod.1;
        Tue, 21 Jul 2020 19:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccw7aFBBvUSTsPhiZooV3eXUT4cuUiS9mQQvtImdqBg=;
        b=J2Jm01HhOEaUbNJDAsixBc/yKYRt1FdzmOx2QIGjBWVbLwIHHgHCWAxMF6j7uQevjF
         kzpnZTjs5waHf5gtRGDtSbEphZEoOTYJMmNxTMxc6SJQw30kc/ohhGTfkbEHOWXCKKxF
         qbL513AodBUsGqGqLhD2RH8vEmLXw6Dfs4s+q2FoQgngyznk4bebkvW07huQCz4tolcz
         liqYc9xrF+CqXlfB2JgSKf5TswomriIAF3x4Eebohoi0r1RgwFx0co5POcMRtfy+J/yt
         RpUIjLaye3OWNY07NN8rny5UWjAV+mM4USyrJJWUxp/c65w+kHz9WpfSFtDKmRQFJUTf
         TtOg==
X-Gm-Message-State: AOAM533JePXAWIRh2ZkuhesiGvogFDKJH6Ab09ARsQGrBloyAdfIvLIE
        iuJfmGsVEQP8PCTP7OaDJLufL0UyzQ==
X-Google-Smtp-Source: ABdhPJzG+g+FJ+7V/G0ulxl4gKTGV/ybyBwv8ARgKlZN6HgZPREI6DZWoupZ+Y7XgS/uX9htijqVDA==
X-Received: by 2002:a92:db44:: with SMTP id w4mr29799590ilq.306.1595384761267;
        Tue, 21 Jul 2020 19:26:01 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:26:00 -0700 (PDT)
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
Subject: [PATCH 12/19] PCI: cadence: Use bridge resources for outbound window setup
Date:   Tue, 21 Jul 2020 20:25:07 -0600
Message-Id: <20200722022514.1283916-13-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of parsing 'ranges' from DT again, use the bridge window
resources.

Cc: Tom Joseph <tjoseph@cadence.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../controller/cadence/pcie-cadence-host.c    | 37 ++++++++-----------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 84aaf8834e11..f485c0405fb5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -104,16 +104,14 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
 	struct resource *mem_res = pcie->mem_res;
 	struct resource *bus_range = rc->bus_range;
 	struct resource *cfg_res = rc->cfg_res;
-	struct device *dev = pcie->dev;
-	struct device_node *np = dev->of_node;
-	struct of_pci_range_parser parser;
-	struct of_pci_range range;
+	struct resource_entry *entry;
 	u32 addr0, addr1, desc1;
 	u64 cpu_addr;
-	int r, err;
+	int r;
 
 	/*
 	 * Reserve region 0 for PCI configure space accesses:
@@ -132,25 +130,22 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(0), addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(0), addr1);
 
-	err = of_pci_range_parser_init(&parser, np);
-	if (err)
-		return err;
-
 	r = 1;
-	for_each_of_pci_range(&parser, &range) {
-		bool is_io;
-
-		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
-			is_io = false;
-		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
-			is_io = true;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res = entry->res;
+		u64 pci_addr = res->start - entry->offset;
+
+		if (resource_type(res) == IORESOURCE_IO)
+			cdns_pcie_set_outbound_region(pcie, 0, r, true,
+						      pci_pio_to_address(res->start),
+						      pci_addr,
+						      resource_size(res));
 		else
-			continue;
+			cdns_pcie_set_outbound_region(pcie, 0, r, false,
+						      res->start,
+						      pci_addr,
+						      resource_size(res));
 
-		cdns_pcie_set_outbound_region(pcie, 0, r, is_io,
-					      range.cpu_addr,
-					      range.pci_addr,
-					      range.size);
 		r++;
 	}
 
-- 
2.25.1

