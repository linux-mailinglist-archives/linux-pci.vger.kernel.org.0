Return-Path: <linux-pci+bounces-26331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA8FA95061
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 13:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB66188EAB8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8E1CAA62;
	Mon, 21 Apr 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dKoD5xUD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8FE1DB546;
	Mon, 21 Apr 2025 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236007; cv=none; b=a+dvFtrS52hzsr15GIYMXy+oo2XJUwZ/MxNqNlrw0MX0hSu4uUHd0Ymp4d36Cvu2RbhFJfwRp26hifKSqSEYQiGNTMU8E9yYDxr3hl54a4erFDxIUfCEYDMahKoVXf/fiI5TtPW9wUKb3ld8Iz/LwY8mWvX+UhVtJfCaf3DPH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236007; c=relaxed/simple;
	bh=LhoBD6Hk5Y8BDPmeOJbsXnEeNxeHWVAfgyR6c47ax/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDB2frWnhfpFVip4eMCd9IMXuZ90OM8pQvF0E05I04rF92tEybNmrUxWDPBQ5yoHAWesw5SuB9rHhsQy9+TuDu0A+eEiR5G5kabwV8v83pb1XENn7YHXYQahax4rviYEqacogPqTqpZAGrdIDSDbzWnTYp/S/yj9H6MHVErMGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dKoD5xUD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KXn/Q
	AXx6ktszUXP77q4WQFVEYAlsySZj6s3Mkg/SdA=; b=dKoD5xUDgYwc1EoQAAAjv
	HxJ8eZLGICvYnFDpZK97WykbiC3p4YlE4sqp9rUPXly4wcQxLXydOhUtcZFrFxhe
	9s3znTLk37XuNTcO4W85oVpT3o224SMBGXFFvxUBlfPQMWWSIJgBFDiCjIhhfsYw
	ORhrz4CVkGXLXRajUEFeDA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3zV_vLwZooPBmBg--.44597S2;
	Mon, 21 Apr 2025 19:45:52 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org,
	kw@linux.com
Cc: robh@kernel.org,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dwc: ep: Use FIELD_GET()
Date: Mon, 21 Apr 2025 19:45:48 +0800
Message-Id: <20250421114548.171803-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3zV_vLwZooPBmBg--.44597S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar45uF4kCFWxtw18Zr1fZwb_yoW8uFW3pF
	18Can0kF1UJF4UXws5ua93A3W5GanxG3y8Cas3GwsIvF9Fvryvq3yqyF9agw1xJF40vr45
	G3ZrtwnxWFsxA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRyq2_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx42o2gGKVyjFQAAsp

Use FIELD_GET() and FIELD_PREP() to remove dependences on the field
position, i.e., the shift value. No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
I referred to Bjorn Helgaas' submitted patch.
https://lore.kernel.org/all/20231010204436.1000644-2-helgaas@kernel.org/
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1a0bf9341542..f3daf46b5e63 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -256,11 +256,11 @@ static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
 		return offset;
 
 	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-	nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
 
 	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
 		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-		bar_index = reg & PCI_REBAR_CTRL_BAR_IDX;
+		bar_index = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, reg);
 		if (bar_index == bar)
 			return offset;
 	}
@@ -875,8 +875,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 
 	if (offset) {
 		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
-			PCI_REBAR_CTRL_NBAR_SHIFT;
+		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
 
 		/*
 		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
@@ -897,7 +896,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 			 * is why RESBAR_CAP_REG is written here.
 			 */
 			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-			bar = val & PCI_REBAR_CTRL_BAR_IDX;
+			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
 			if (ep->epf_bar[bar])
 				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
 			else

base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.25.1


