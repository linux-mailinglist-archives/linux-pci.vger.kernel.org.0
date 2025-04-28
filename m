Return-Path: <linux-pci+bounces-26931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D91A9F137
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8C05A359E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06AC26A0C5;
	Mon, 28 Apr 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jDzVAhjF"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE3269D13;
	Mon, 28 Apr 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844182; cv=none; b=Yuhg1j9UjAko2Wp6h/d515VUMsgoiAqU8AH0tYx5C5XGDhWj3aZyQYDLuP3h8fZB6qRuIpZOyMFiQ85/B79P4FbowpsHUFI9K8LEY7wtBYJdEUSUNrKTJgokZ0IJBlIkbAcfttzM9tajmnpME8ul4LI+YOnBlROsvgUcu9g5Gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844182; c=relaxed/simple;
	bh=yDz9n3TWyahGCVi9xPiIqDZuE2MgYN7oXN7oGplbqgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/YYDY5Cb0Upl0mSNzNbsQ2+SpX8VeDUqjHeJDu8ktILbOwERqUrttb7vBLV7HtN/kB8Bc+Wzjrqc/W3QHYPczj6+dOlIXrSX9LcB7Oz0z34IbHyZNozETB1gVHmEi7Onn9vWXRdgJCYxBpMCderm6Gqvwfe1wv5x5sllgyoWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jDzVAhjF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GoBfJ
	MIbIlI6zPaXaf2aHXumRMjBzcYSuUOqst3TWOg=; b=jDzVAhjF51fqsqiXmrycZ
	hvIRsk4TZcLWzi1JRxs7dm5odb8tcZp29PgxXZhPMjaXqcZab8RHNJh/3VOcHa8X
	OwVr4wVFeRuTY2SOw3aSfC4lOirDDH6zjI6FI08Bn5AlvcOXO8SLPULP0ixVwiIX
	dUPmjNLdy38Y/qDB4yzB3w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXClu3dw9oiuSODA--.26989S2;
	Mon, 28 Apr 2025 20:42:32 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] PCI: dwc: ep: Use FIELD_GET()
Date: Mon, 28 Apr 2025 20:42:30 +0800
Message-Id: <20250428124230.112648-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXClu3dw9oiuSODA--.26989S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar48Jryxur4DuF47GFyDWrg_yoW8uF18p3
	W8Can0kF1UJF45X3ykua93ZFn8GanxG3y8Aa93GrsIvF9Fvry0q3yqyF95K34xJF40vF45
	C3W7tw13WFsxA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimLvtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhg9o2gO9M4mjgABsJ

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value. No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
Changes for v2:
- The patch commit message were modified.
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

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.25.1


