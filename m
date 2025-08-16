Return-Path: <linux-pci+bounces-34126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8BB28F44
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F623BA193
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608FF226861;
	Sat, 16 Aug 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NinZjAYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E81B043C;
	Sat, 16 Aug 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755359239; cv=none; b=pBgtVvlr/aohesatvfFe5PnxW2lwbYMJQpYbuf8pSVXrKYhDbu4vxSigTHPbzIdjHdPlEg7Z1IboLZdS+z94gWh76RPX/RHyNRRZtUtZQyAf+H7CyxZ+ko0Iu8nwd7GSLbD5n39pzL2KeXlxb89Eyz+y3QoK/IGPMsUxbwsKAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755359239; c=relaxed/simple;
	bh=lvTKCTBw91HoAlCJPze5p+RxRyffn6wYsG6rgY8VTVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJuebHhTo0eEURNZ1rLGXhUUo5iftKrRC59Tn94x7CzkgvhmaGfV8Mo67rcFM383sH25irI3wTocUsgvFDRdt+daAC4dmuWavuWyhy600e5VN/cJNkoULPwmO7Y7i2F44V5RoOtJ5tUbSbHEcKmVwmmamZgSld+mc7cFU3KSwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NinZjAYy; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bW
	uUI9S8QYFB3nfyY0vQQR080x5RgbGFM4axB7wTYog=; b=NinZjAYy/53Vhb1Wsx
	cSWips5JUFc+pGPh/8JYJ8+xRYoEMSSVckIpOGUMgub8TtXsJBtMaf2mz4ViHj8K
	qCyZdW5Tf7TjrcSu7p2/DIzfkoj6Zc5O8EnVKVCrk++GFc/GkWoAv5cANof1fFkw
	rSWHbri5/4abWpIqOzSI5HnR0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHfLfip6BoVzqMBw--.15530S4;
	Sat, 16 Aug 2025 23:46:44 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 2/3] PCI: dwc: Simplify link speed configuration with macro
Date: Sat, 16 Aug 2025 23:46:32 +0800
Message-Id: <20250816154633.338653-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250816154633.338653-1-18255117159@163.com>
References: <20250816154633.338653-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHfLfip6BoVzqMBw--.15530S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW5ZFWxuw15Gr4fJryftFb_yoW8WryDpa
	y3AF18ZF48Ja13ZFs0gas7Za4UXFnxGF4DCFZ8W3ZagFy2ya9xWF10yrySq34akFZ2kr13
	uw17JrWUG3W7tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zZg4U5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwGro2ignM3xVwAAst

Replace switch-case based speed-to-register conversion in DesignWare
driver with the newly introduced PCIE_SPEED2LNKCTL2_TLS() macro.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..d99f3bde847d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -776,24 +776,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
 	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
 
-	switch (pcie_link_speed[pci->max_link_speed]) {
-	case PCIE_SPEED_2_5GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
-		break;
-	case PCIE_SPEED_5_0GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
-		break;
-	case PCIE_SPEED_8_0GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
-		break;
-	case PCIE_SPEED_16_0GT:
-		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
-		break;
-	default:
+	link_speed = pcie_link_speed[pci->max_link_speed];
+	link_speed = PCIE_SPEED2LNKCTL2_TLS(link_speed);
+	if (link_speed == 0) {
 		/* Use hardware capability */
 		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
 		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
-		break;
 	}
 
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
-- 
2.25.1


