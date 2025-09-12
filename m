Return-Path: <linux-pci+bounces-36001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D82B548C7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256A7A078A0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323D2E03FF;
	Fri, 12 Sep 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m82ZGnTA"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EA2DF150;
	Fri, 12 Sep 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671715; cv=none; b=neR6kJim+ete+ZIrhJ63iJeEilwqUE959QgjD0mFCC5h3V0KcqpemFbeXcUwwoG63KR3hU+MBiW+LcgQXTipKz06BnexP9Tuqct6Kvttx2u3jCcPkap1Q3k8fqKr4I2acOY+0jS71STpdIOvVu9RdASHE/NvizScmlXUMhVklxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671715; c=relaxed/simple;
	bh=zq5xJZnF93omx3N6DnNKxmVlxwrZm3wubVridx+hST4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItC3shBAYRA6/XQKucRQ961/XuovFTUsJ1atD4BPxsnSpSKccrZhFiftWrg/N4mszkp5Eb+sxhLjpGFwI8EdLrr388yC8rxI/yg2Idc80KdPSWjLRr3xKejEEyFc7RmjF47V4W5lDr+P6nw2BfYTLsuyTGH1aEDLt94vaf4YOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m82ZGnTA; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CA8F8b498897;
	Fri, 12 Sep 2025 05:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757671695;
	bh=nkuV7aobCdIbkeyG47qx7I1Surx6uFb1AcdgHCLEWSg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=m82ZGnTA9oGzaNeaTQWEh1g2zm0aD42xFzy+ovmzBFZImQeh9dbvKnZzk3WL33YSt
	 EAsGc0QEZDSxdUpDCLgHfRNm7k9YxL9/qSUSM+w//1AnYVFdBIqAmX9/nKro5Si6HL
	 7Ye5Qk5Pj9bDXKszSF+YPFwWAJL4xdTbHu36O7kU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CA8F632696732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 05:08:15 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 05:08:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 05:08:14 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CA83MH3740807;
	Fri, 12 Sep 2025 05:08:09 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <sergio.paracuellos@gmail.com>,
        <18255117159@163.com>, <jirislaby@kernel.org>, <m-karicheri2@ti.com>,
        <santosh.shilimkar@ti.com>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/2] PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit
Date: Fri, 12 Sep 2025 15:37:58 +0530
Message-ID: <20250912100802.3136121-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912100802.3136121-1-s-vadapalli@ti.com>
References: <20250912100802.3136121-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Commit under Fixes introduced the IRQ handler for "ks-pcie-error-irq".
The interrupt is acquired using "request_irq()" but is never freed if
the driver exits due to an error. Although the section in the driver that
invokes "request_irq()" has moved around over time, the issue hasn't been
addressed until now.

Fix this by using "devm_request_irq()" which shall automatically release
the interrupt if the driver exits. Also, since the interrupt handler for
the "ks-pcie-error-irq" namely "ks_pcie_handle_error_irq() is only printing
the error and clearing the interrupt, there is no necessity to prefer
devm_request_threaded_irq() over devm_request_irq().

Fixes: 025dd3daeda7 ("PCI: keystone: Add error IRQ handler")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/r/3d3a4b52-e343-42f3-9d69-94c259812143@kernel.org
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2b2632e513b5..21808a9e5158 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1201,8 +1201,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
-			  "ks-pcie-error-irq", ks_pcie);
+	ret = devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
+			       "ks-pcie-error-irq", ks_pcie);
 	if (ret < 0) {
 		dev_err(dev, "failed to request error IRQ %d\n",
 			irq);
-- 
2.43.0


