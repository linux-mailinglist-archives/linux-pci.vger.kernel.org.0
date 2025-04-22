Return-Path: <linux-pci+bounces-26378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE3A9675C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C5166E57
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520627C17A;
	Tue, 22 Apr 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ffWwJuQl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812627BF8E;
	Tue, 22 Apr 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321362; cv=none; b=IZpbkyMont/P7fvWJNDEEcISDqDxZob/uwKjJxW14QcTX+bjXm+Ptlca6AEcuI0WrJG8zGjOLPENx/+IltawxTRG9wCFQDQBCc8Qmux1jdSrGIuEJuEW68JvKuXUx/uSmNpd6uN4AczwJsyDPppfmDtoc7lzdFwUSijFfMBPak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321362; c=relaxed/simple;
	bh=UkHWEuBBr+u8ftNbMm92bUAY3+Nu0EQHSO4PpBia6Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BooccKUcO+mwJdNWrbDd0oNC990snUjTlKBXGt4XD96MvWLww+Fy121a7B7Zc4MYbsn6vVFWcdG8E0eiV3DnAh7pMvrnlg8IpIoLUULnnzdGnv1S3YgZ6cHjwVnmF9zkXvo9i1hsmR4zHwih1zqWPLE/OVs4FJU2JqsOL3ajVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ffWwJuQl; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UcMbM
	shhTN629KReXGX3TYRD3YyfD5t4evcTtPI62xY=; b=ffWwJuQlVGRB3iU6gQehP
	RX2Fm49XILUdXAOPl3uNeKlx6gXE0ilHB2zMdPj2dzM7YpMicYUeWg95HUadpkIs
	1gdztOSczSG7t9OLwDcwdXfZffMRCt1z0vv3hJumHxuqBm2EYDpjgMgedGg1I9jc
	J35CogHN9LzIFOwnXMMHeU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXbK1gfQdoRW2NBg--.44191S5;
	Tue, 22 Apr 2025 19:28:38 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 3/3] PCI: dw-rockchip: Unify link status checks with FIELD_GET
Date: Tue, 22 Apr 2025 19:28:30 +0800
Message-Id: <20250422112830.204374-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422112830.204374-1-18255117159@163.com>
References: <20250422112830.204374-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXbK1gfQdoRW2NBg--.44191S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF15Gr13CFWxtr1UZr18Zrb_yoW5XFyxpa
	98AFWqkF48Gw409F1kCa98XrWFyFnI9ayUCrn7K3WxW3ZIyr1UW3WUWr9xtr4xJrs8CFy3
	Cw4rta4xJF43ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvdyUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwo3o2gHegppZgAAsB

Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
leading to code duplication. Centralize the logic using FIELD_GET. This
removes redundancy and abstracts hardware-specific bit masking, ensuring
consistent link state handling.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index cdc8afc6cfc1..2b26060af5c2 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -196,10 +196,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
-		return 1;
-
-	return 0;
+	return FIELD_GET(PCIE_LINKUP_MASK, val) == 3;
 }
 
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
@@ -499,7 +496,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	struct dw_pcie *pci = &rockchip->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
-	u32 reg, val;
+	u32 reg;
 
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -508,8 +505,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		val = rockchip_pcie_get_ltssm(rockchip);
-		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
@@ -526,7 +522,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	struct rockchip_pcie *rockchip = arg;
 	struct dw_pcie *pci = &rockchip->pci;
 	struct device *dev = pci->dev;
-	u32 reg, val;
+	u32 reg;
 
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -540,8 +536,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	}
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		val = rockchip_pcie_get_ltssm(rockchip);
-		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "link up\n");
 			dw_pcie_ep_linkup(&pci->ep);
 		}
-- 
2.25.1


