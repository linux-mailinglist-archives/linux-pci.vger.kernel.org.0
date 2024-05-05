Return-Path: <linux-pci+bounces-7095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543528BBF69
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 08:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D220C281C3C
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD51FC4;
	Sun,  5 May 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="XjPssvqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF3184D;
	Sun,  5 May 2024 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714889864; cv=none; b=LzgpEk/rOkN8x7uttvEC0tDAaAZgy1Qb9jArEGLPVYNfiHXs/0FJiEjq2YufOc6+ymal6HrDeMmLz2c6Go6WXeB6vSTOXR08FUGvEG5gh2ELyztqvZEB8gTBcPSObCXRiWwV0Nv7YvtpP+CWqXU7dYZ363YJygNQe8G65ZmI5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714889864; c=relaxed/simple;
	bh=ZGeTVx2PorDAfHQ1Dxaam8AZyiVNKc4xHmndMzQM6dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLd4bmoGQ/d3an2xHLCzOTjb4mxBQ25khOhcLXpfRR7CeSzgM6nrLuPZzTHchiRuzEIN2w6i2yniG9cm/D1HfqzArfxpaIX94iRNCt6Y2qkz0tuRPSHsP/fa2P2PDbT4wxOYowtJu7CAqY1seP84iMVAh2trRVzOe5dJ2tp+paA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=XjPssvqJ; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id B9688100002;
	Sun,  5 May 2024 09:17:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1714889832; bh=l1wg2cMRfB+aqQwo9LCdnh4EN2rtpVp3ErpWHzpP/iw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XjPssvqJK3zYkRouEOZ0tKvpJYQsUdXiSrwZKNS/vLodBCe0ks3voUF6xvfaW0h60
	 IijaWoHgthylFx2f/YvFq7b2XVG7xdhKM8vChcoeBix/wHkod2MTNkeBYk92PRQnlc
	 6wwJ8e4qItxNjW1I+JAinvhksQKtN0GoE/rVfimgixKNIyBY0PJjm8VvQDC8xM9T3U
	 tXJalhVsD5JPnrDawymeWfXLxYl8YjQq7BKkag4UL5b16YQvqq8sutHJxVPwYWodv8
	 Z/W3C3SgKFeQbyXpA/4WJuvj7Uc3mmd5TqEFu5kOln4HGx5JKKpazv51W6V+uKMMaa
	 YGEsUUw21ybxg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Sun,  5 May 2024 09:15:44 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 5 May 2024
 09:15:24 +0300
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
Subject: [PATCH v4] PCI: dwc: keystone: Fix NULL pointer dereference in case  of DT error in ks_pcie_setup_rc_app_regs()
Date: Sun, 5 May 2024 09:15:17 +0300
Message-ID: <20240505061517.11527-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 185057 [May 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/05 05:27:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/05/05 03:18:00 #25094255
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
v1->v2: Add return code processing as suggested by Bjorn
v2->v3: Return -ENODEV instead of -EINVAL as suggested by Manivannan
v3->v4: Change variable name as suggested by Manivannan,
 add "Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>"

 drivers/pci/controller/dwc/pci-keystone.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..67415c1a93ff 100644
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
+	struct resource_entry *entry;
 	struct resource *mem;
+	u64 start, end;
 	int i;
 
-	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
+	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	if (!entry)
+		return -ENODEV;
+
+	mem = entry->res;
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


