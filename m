Return-Path: <linux-pci+bounces-40063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD3C29050
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D83B09A1
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1F1547F2;
	Sun,  2 Nov 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bqL5aQwn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAE13635C;
	Sun,  2 Nov 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093963; cv=none; b=crpAyvURsHYrW5qVVh3cLu8Tg7YajEuub7+a0LdshFnF1lSejHfOg0A8yJXlh8ghg/hwwfsdagBHtUHhnksLM04fSumnItURIJ0QyLRPfJp+WQZ+0aqI/5EJt3CyBa/CuaB+E29R7hCdt9VjdhuYSwBNI19YIRr6FV56y53tDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093963; c=relaxed/simple;
	bh=s27eGuBOjSehs2VSpjzagnyOuK168w1Km3iqgB4Axv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzHcY8kYqXkxgrvRglWU2aILCgvQsx5gN2rtN7prTOTQ/l1EAJQKIwDxrvitQqCoo5dExi3TAFt6yRfXaZY1ULV6cS9F/2Lzwt2yuCkP4jjfB8NBoWXNaWFU1JrWIm7MxdZDlO3xer1R5mgmvFGjtInbOzu5SutsHiXBFY/An/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bqL5aQwn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SG
	vG/fGHW1BPmlWo1ZKpiTtP2XrTKwTIg+faOGSh7vE=; b=bqL5aQwnokDGDMbQiL
	asntsJHLLjR1xsUajOD7JWJCDBYxOos9Gurv60KYluiwNkk7bSCRhdcaufBhg1M1
	7NhgoAqmhAk3mrFhrr6e3JdmaHnY+QY+wC/HHgUs/KBmCBDxq9huWq8kAAixFy3H
	OtK2o7M4ZK+IXMZ5ivFGN7VGA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAH5VdpawdpqU+1BA--.1772S5;
	Sun, 02 Nov 2025 22:32:12 +0800 (CST)
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
Subject: [PATCH v4 3/3] PCI: dwc: Use common speed conversion function
Date: Sun,  2 Nov 2025 22:32:06 +0800
Message-Id: <20251102143206.111347-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102143206.111347-1-18255117159@163.com>
References: <20251102143206.111347-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5VdpawdpqU+1BA--.1772S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWDZFy3tr4UWF4ftw4xZwb_yoW8Ary5pa
	y3AF40vF18JF43ZFs0ga4kXFyUXFnxGrWDGFZ8Was3XFy2yasxWF10y34Sq34akrZ2yr1a
	9r13JrWUG3W7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR3kusUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwP5o2kHZmtoigAAsX

Replace the private switch-based speed conversion in
dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
function.

This eliminates duplicate conversion logic and ensures consistency with
other PCIe drivers, while handling invalid speeds by falling back to
hardware capabilities.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f6..20ba314e82d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -717,24 +717,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
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
+	link_speed = pci_bus_speed2lnkctl2(link_speed);
+	if (link_speed == 0) {
 		/* Use hardware capability */
 		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
 		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
-		break;
 	}
 
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
-- 
2.34.1


