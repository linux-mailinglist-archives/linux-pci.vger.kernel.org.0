Return-Path: <linux-pci+bounces-7041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD648BACEC
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDE283885
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975015357A;
	Fri,  3 May 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Dr1jEoli"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CB8495;
	Fri,  3 May 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741215; cv=none; b=AwBWOMaFSaoVSKcXa71N/RPvyBQsOETx+BgPfMh6dpPadrwKy2IcgbD3Pc1pIW6qnKQZMtcSqLIBQ72HLzEp8aHbYm+RkdqUXAus1DX6JmL4p//FDQcuqx9yM6UJ7alJKptkOLKhQUZDIpMfwqW25EiItpq77VuYEpHAJs8HDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741215; c=relaxed/simple;
	bh=ubwiLHVhxCwuesD7tw6htqXw1VA70BTat0Rd5e9jFTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2fQWoDkD4P7KYIpgzB1Rew6wKeDRv3ndYUfKFbx4llfMrQkoM8dtpYogeAJVXBtF9jW0nRN3ciXWMdHPwMkSCA0V1ywwtbhYY+6kbwfew+Sgfho8ESh8L+B+4H0xVoclNYzJmP7CdYVPd1Ruxp06gv4NR+OfXcSNU9ztvaLb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Dr1jEoli; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 8461C100004;
	Fri,  3 May 2024 15:59:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1714741193; bh=4fb++Ufh5MrxM3NX9sK5JICEIsVHhNOWuQoiN8sDtPE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Dr1jEoliF9pWDNQU9K2L3v+Sw6op61GqDrgCPeVrcq90chC7XDXXNLYkGmxcrYaY1
	 8laj2A90Q2Up8/2dPspKEiA7CsKUd6pecPF5rmlwCokwpr9U9Ya8KpXzO7eJThDqdA
	 14955qF5t0tPeD7ONSxC6AYQa1e+2pSTobd+dg2ww+SvEP2K3ERDFa04dh6EVV3F3B
	 V5ty7OlQ1sDetuwmYtNZuJlcQAEsVH53BN2wEaSGesMleluzHuiW3OZ+ca02nuiqVi
	 fisKkTuAjYfBYa53HXQsKHWk81Vj/DnGNFFFOn5dljHHRh6p3BdaYJFdnV2jzyyd6d
	 V8zk/xisoiLKg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  3 May 2024 15:58:27 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 15:57:33 +0300
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
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Bjorn Helgaas
	<helgaas@kernel.org>
Subject: [PATCH v3] PCI: dwc: keystone: Fix NULL pointer dereference in case of DT error in ks_pcie_setup_rc_app_regs()
Date: Fri, 3 May 2024 15:57:26 +0300
Message-ID: <20240503125726.46116-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 185041 [May 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/03 12:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/05/03 04:26:00 #25076703
X-KSMG-AntiVirus-Status: Clean, skipped

If IORESOURCE_MEM is not provided in Device Tree due to any error,
resource_list_first_type() will return NULL and
pci_parse_request_of_pci_ranges() will just emit a warning.
This will cause a NULL pointer dereference.
Fix this bug by adding NULL return check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Add return code processing as suggested by Bjorn
v2->v3: Return -ENODEV instead of -EINVAL as suggested by Manivannan

 drivers/pci/controller/dwc/pci-keystone.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..381f7b2b74ca 100644
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
+		return -ENODEV;
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
+	if (ret)
+		return ret;
+
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
-- 
2.30.2


