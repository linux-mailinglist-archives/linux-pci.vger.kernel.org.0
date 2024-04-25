Return-Path: <linux-pci+bounces-6662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8128B1E21
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CE21C22C37
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FA84D3E;
	Thu, 25 Apr 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="O9cWtCRY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208D84D2D;
	Thu, 25 Apr 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037719; cv=none; b=tuVTsoMesUkajJklpcwPqnr0yzAvKQgYQ06buVGDSRnpC5/biRV6DGeEgR7k3ASMW92AgZvLJzzbhlL7I975YS6gAvGBJQq4j/0l9m9lKtrf/pSXmUC6Tw3GbrvQcmhYfB8uQamOe7HUK99zkFVZIKIUaEQkPRDdL1JkLGfP1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037719; c=relaxed/simple;
	bh=SI8dYxg4nlJIfknRlpUsqJy0WPDol6IUX4YbYt9uIGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7kB69BBQ10AF1r3hlK20MeINiYv2YmyUMB3b/JJPhf+TKYyevWLPcqpvdw7oloHtXuOWMMydmyfMaoLkLNhiJT3lF5tf2tjtl3RtMQQLKJd2RyZmelwnoLU4RZh7aF2QnQqXWHkDAFHdpQnjv4mbGACEkuLuojqLjnzpxlmq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=O9cWtCRY; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id BA7DE100002;
	Thu, 25 Apr 2024 12:23:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1714037026; bh=DPLnFAg5Eyfks9NW8S+aGjEu3lnapyvcLprsK9kTWQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=O9cWtCRYMZOPnwu/CbHaVCze+o3cfoGbTZWhj7JT4G+4hDDbXlptzxE/t0Dvkh2W5
	 Zi3F2LgoYBk9NGiMyhJhqLVt0QeKR4KSM2sHySwyT4NY7tFBJmVrcNDTzSi0Z6cEI3
	 91gntxVtarQVc65WNgmdWeLN9hT8n2oCU0+a5Lj/AzHUinFWnUPHEO23u7fINoBTdJ
	 zD+Ia/YgLB5fq/cu13J36uaG3ZYSWsveDdgrPG7devDZO0eTmVDkoWzVxhl9iG5tZ8
	 QxEq4mu4EbMgCOGc/yOzopjWRG4iWGY/+WBUxA+ZtkigqhtmWAHfkmuxcut62Nr14V
	 F72me3ZMmRe3g==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 25 Apr 2024 12:22:21 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 12:22:00 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Rob Herring <robh@kernel.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] PCI: dwc: keystone: Fix potential NULL dereference
Date: Thu, 25 Apr 2024 12:21:35 +0300
Message-ID: <20240425092135.13348-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240329051947.28900-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184912 [Apr 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/25 08:19:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/24 23:31:00 #24963607
X-KSMG-AntiVirus-Status: Clean, skipped

In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Add return code processing

 drivers/pci/controller/dwc/pci-keystone.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..5c6786d9f3e9 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -382,17 +382,22 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 	} while (val & DBI_CS2);
 }
 
-static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
+static int ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
-	u64 start, end;
+	struct resource_entry *ft;
 	struct resource *mem;
+	u64 start, end;
 	int i;
 
-	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
+	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	if (!ft)
+		return -EINVAL;
+
+	mem = ft->res;
 	start = mem->start;
 	end = mem->end;
 
@@ -403,7 +408,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	ks_pcie_clear_dbi_mode(ks_pcie);
 
 	if (ks_pcie->is_am6)
-		return;
+		return 0;
 
 	val = ilog2(OB_WIN_SIZE);
 	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
@@ -420,6 +425,8 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	val |= OB_XLAT_EN_VAL;
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+
+	return 0;
 }
 
 static void __iomem *ks_pcie_other_map_bus(struct pci_bus *bus,
@@ -814,7 +821,10 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 		return ret;
 
 	ks_pcie_stop_link(pci);
-	ks_pcie_setup_rc_app_regs(ks_pcie);
+	ret = ks_pcie_setup_rc_app_regs(ks_pcie);
+	if (ret < 0)
+		return ret;
+
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
-- 
2.30.2


