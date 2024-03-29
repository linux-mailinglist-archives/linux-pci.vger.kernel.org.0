Return-Path: <linux-pci+bounces-5369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D06891324
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 06:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993761F222D3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 05:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2D381CC;
	Fri, 29 Mar 2024 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="RTAzh/MR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1E2C19D;
	Fri, 29 Mar 2024 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711689730; cv=none; b=pIdl1nRvnokZe/dV36gq+ahuzpKElIm2zufzyrdlCaYdPS3riKmTq3xoV5wbIvl/ptQTw4yh9p0N3W5bUmk4j48ibi456Nlvs+mJzQyo/9Q72FOQgMxsDRMnfsRqv/smc6niq1D0YlmcgFDQ39GkI32YwV7uz6leMWF2mve5N20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711689730; c=relaxed/simple;
	bh=LHGMb9TOMihgp395z90F1PJE9iR/bXqLN9ckm74CRro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6qFLHeUp0Thpz+MxHwfhAIKDwwTPETKofUh7T964ehjZNavIZPkoVSRwJ/AYOkKfVefMEqTys4uHkxnNv92KApDOm5NFeTx2aEfsgL6K/84aPAyeMeWwtcQmuiSjRJqdjLpV2bVZOHhMXqbu3FvjeN+L0iLU+Vg446P8/NAjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=RTAzh/MR; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 530AB100002;
	Fri, 29 Mar 2024 08:21:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711689704; bh=olCvRaa/nkRVcZRj5DBHp7AjHPrGwTpg2wCSRtj7O6s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RTAzh/MRMn/z01yHxw+Izm/8lMqRUVi+wNeQqVkySEOELaX/KCNMZDM82OpC29rIE
	 /fRtP0gF9Im26c31vjAyW+uLNBCrJwHNcRQZ9G0CBGrN279nvYXEemoJPD5C9ixwsx
	 4vsy7ogrxIRmDTZ2KnwULNb4/hHHeq1qOHBcWCWPoAIzTGKeLCPquESnK+Pp4Iuwur
	 Dxr0erKwPCHGLdegvDssK+8/ilbnbIlR86RUjSimDY+rkbeO4ZlWT3bzbzmwk1da+B
	 YfiRVyOJhcmje/Gr2Ov63GHIimWGFhudJs5m4B0vNVN5Fw8nURGoA6mWefcgJYUSSm
	 brwSK8pV8C9fw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 29 Mar 2024 08:20:20 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 29 Mar
 2024 08:19:59 +0300
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
Subject: [PATCH] PCI: dwc: keystone: Fix potential NULL dereference
Date: Fri, 29 Mar 2024 08:19:47 +0300
Message-ID: <20240329051947.28900-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184478 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/29 03:32:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/29 02:35:00 #24501233
X-KSMG-AntiVirus-Status: Clean, skipped

In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/pci/controller/dwc/pci-keystone.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..00d616654171 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -392,7 +392,11 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	struct resource *mem;
 	int i;
 
-	mem = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM)->res;
+	struct resource_entry *ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	if (!ft)
+		return;
+
+	mem = ft->res;
 	start = mem->start;
 	end = mem->end;
 
-- 
2.30.2


