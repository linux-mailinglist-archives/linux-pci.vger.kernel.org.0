Return-Path: <linux-pci+bounces-6663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02888B1E57
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DF6285EE0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694484E0D;
	Thu, 25 Apr 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="THniLMa7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FA28F7;
	Thu, 25 Apr 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038426; cv=none; b=Qdesylhg19Lqigk+P6x2IjYf/mjHaxeUbyJtsb9febjzNixmqYYvDrwJ6G2lVPHyMDVELgPX/kViV8l43WlMXcYCfFdIHqcygpz5tOeopQ8V1nSkaGEAP/MfKFve/pwAnb/++5hSWCo2V4MNR2Bf0YK4geXakfzQMRQTXCLxkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038426; c=relaxed/simple;
	bh=cWcKy8wTf68qm1RgtwCQ421qsXZI/HZiPuKSe+DWeVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JK6qKqQd5iLM+UrkeBko0HLwvTfTlSks4yfI6rTRAw/iEJ+ptYflwwR7zMwagP1DS+ogF7MOuk3nFUpMLLpmFLmhihTECpdJGb6Pq34tnEA5kbBBm2nY02q72OboAdRufGlsYipqtUTNovfrC65o6X5Tg04M9hWRRvoqNL1Jg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=THniLMa7; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id A8FE0100002;
	Thu, 25 Apr 2024 12:46:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1714038403; bh=0095HjdshMuyZmQBsZxSIJdEf89TFu4eDlupLRN2pos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=THniLMa7kVAsoWHHt1N22NXKUvRGedGQuSJKmkuu+SaW6Y60w1QD1jOvxybOKfuY5
	 G6bna1OX7+Y+141AxzhVvYXqvIg4KLCLFTZO/65iJv+Q2pa+pLX/cDtv9ttPc5VjXY
	 QRJSYO+s0P/hN9QcvAcJBHThL6aHMnG0WgxTzT4t/5GxSkUUOSzONoeeoKiwAhnpL0
	 xaRZOzKSiE3v414CG7gDUuPF5vbDi+DE89Bx75AmlgtPd+Ha5YO58u6YpKAMKHuhiQ
	 uECKC41VgYk9MLIukL8D4O5jeAMTX4u/KRX4uwfYirhx0XiA3ty0ePzobHUPdBOzN9
	 0X3+/1vPJYLjA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 25 Apr 2024 12:45:55 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 12:45:46 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Jonathan Chocron <jonnyc@amazon.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] PCI: dwc: al: Fix potential NULL dereference
Date: Thu, 25 Apr 2024 12:45:38 +0300
Message-ID: <20240425094538.15570-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240328180126.23574-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184913 [Apr 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/25 08:19:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/24 23:31:00 #24963607
X-KSMG-AntiVirus-Status: Clean, skipped

In al_pcie_config_prepare() resource_list_first_type() may return
NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Add return code processing

 drivers/pci/controller/dwc/pcie-al.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 6dfdda59f328..933854c3575b 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -242,18 +242,24 @@ static struct pci_ops al_child_pci_ops = {
 	.write = pci_generic_config_write,
 };
 
-static void al_pcie_config_prepare(struct al_pcie *pcie)
+static int al_pcie_config_prepare(struct al_pcie *pcie)
 {
 	struct al_pcie_target_bus_cfg *target_bus_cfg;
 	struct dw_pcie_rp *pp = &pcie->pci->pp;
 	unsigned int ecam_bus_mask;
+	struct resource_entry *ft;
 	u32 cfg_control_offset;
+	struct resource *bus;
 	u8 subordinate_bus;
 	u8 secondary_bus;
 	u32 cfg_control;
 	u32 reg;
-	struct resource *bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
 
+	ft = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!ft)
+		return -EINVAL;
+
+	bus = ft->res;
 	target_bus_cfg = &pcie->target_bus_cfg;
 
 	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
@@ -287,6 +293,8 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
 
 	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
+
+	return 0;
 }
 
 static int al_pcie_host_init(struct dw_pcie_rp *pp)
@@ -305,7 +313,9 @@ static int al_pcie_host_init(struct dw_pcie_rp *pp)
 	if (rc)
 		return rc;
 
-	al_pcie_config_prepare(pcie);
+	rc = al_pcie_config_prepare(pcie);
+	if (rc < 0)
+		return rc;
 
 	return 0;
 }
-- 
2.30.2


