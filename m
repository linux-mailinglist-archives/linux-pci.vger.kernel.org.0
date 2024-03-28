Return-Path: <linux-pci+bounces-5350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B58907DD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565031F262F2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F712F391;
	Thu, 28 Mar 2024 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="NnpMOJux"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F846549;
	Thu, 28 Mar 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648986; cv=none; b=LwUKf3H/+2NZQdTTfkVlLTMIRhemQcBmds12Nwgmez9D7RB1Vb5d/rouRUxN+dGsTJjnpTThsfeWOw4St1qAmqMP0WGfCOrgCx0YEF57u/4in98Dczqm3+7luG3PdyedSSItnn3/LuwlRpEuU5FMD9RKtSlmdUZiiTtuHH4MPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648986; c=relaxed/simple;
	bh=DTbZ+Y9jaC0uz8dR80S7Tj5E5VmybpfliaYZJV2ojCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUcHRrq86fOo4oKPnzfmOzHK16Fuii+5fHTHrt5yMivVHcJKxkgJFECT4L1/7JFIrakOoJLen4nHK3RKlIEopWidB5YkpKxK3X9Y+SBHWnouYDi4GW0+FoFVIreG46i2dxX4QTdsqZMlnIWQ+hjfx8PbvsO43e8PDEAdZb4h9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=NnpMOJux; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 376DE100002;
	Thu, 28 Mar 2024 21:02:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711648963; bh=SSfky+uq2rYnJ57PyR2zDM3Rz0HLw3/XFkx0D1YEnb8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NnpMOJuxSPu9KTqSrqj10q37r83Yv9mDdyfg+KRAVcOY9lG93hF3y11nRxRxIG1eY
	 0jcsE0Nn2+VxZG5nq15GE59cmm3AULNYty0cTLznSiCnhn0x2B9Ytn2CexeMRJThFO
	 I5rPtQrDlOQcqyRYNQp1C5dljaEmvcm1kabkZp4CC4TKC15sKgq0knQtLVkmglttDn
	 DDuAthOjId3w0A1OJH5sXZdXHPHgBqKZioicDkSYKc5WEkE7OkYuDlkMeRhKuDKyMp
	 XAx21hpqL0lj8yhqABznj8wg/WW10ovU01fR3ISQNf8VYRzjsF/8QZflyUa1mhYDd6
	 lFrqEeZLeDMhA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 28 Mar 2024 21:01:54 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Mar
 2024 21:01:34 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Jonathan Chocron <jonnyc@amazon.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] PCI: dwc: Fix potential NULL dereference
Date: Thu, 28 Mar 2024 21:01:26 +0300
Message-ID: <20240328180126.23574-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 184474 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 17:08:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/28 16:46:00 #24495495
X-KSMG-AntiVirus-Status: Clean, skipped

In al_pcie_config_prepare() resource_list_first_type() may return
NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/pci/controller/dwc/pcie-al.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 6dfdda59f328..29bc99d48295 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -252,7 +252,12 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
-	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
+
+	struct resource_entry *ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS); 
+	if (!ft)
+		return;
+
+	struct resource *bus = ft->res;
 
 	target_bus_cfg = &pcie->target_bus_cfg;
 
-- 
2.30.2


