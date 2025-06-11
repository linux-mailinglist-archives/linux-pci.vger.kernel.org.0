Return-Path: <linux-pci+bounces-29472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC88AD5C35
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3223A8CE5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7F20FAB0;
	Wed, 11 Jun 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CWejje5p"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675C202C5A;
	Wed, 11 Jun 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659534; cv=none; b=h1+7bSdfmGuKr6Wy7Np9M+4BFjBwY/BNP5WbmtLXOO3LlvRcvgvPh+s7RLD3E+fX9NcYVCLeZX/wALcTXXBn29PUok94yyKDSr7BqEe9mVPdNkXuL281bvF7vTNJsJ2P2phIR9ZDRxJUHYAPI76UGDopkgGny8vNnOCyeO+Daxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659534; c=relaxed/simple;
	bh=pI0l0YSyaG+iu/wKlfA/GQax2jc8og3id13WIdSvnbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVu8o+oEJ50c3n6q6XfDhP+f9uIrIR4YLSD4kkLMKMtHzVLsM8Z4pWO8NCoXnxj7wYVze0lf2QNSUVzIRuSxBUEanKtnMeMsZCVMR9s9ILmTtXiGfXm1pl6ODXvpSW0wN2BmQvmp4KCNV/zzIzTRVngxkQubKk29t0n2yop8dFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CWejje5p; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7u
	2cvwu+TRfW10klrZP0lybKTwAtimvuf2CQdNrVCxs=; b=CWejje5p1woFj3jirr
	vytfTZBRoGQHYeL3bLR5LwXkcDTFCfGHdPibGzyswdqzxE4XTbDrs/52vkLaWLrW
	qKgD8nh95p0/gcoMK3LN8ViIEUye508Mp99KleS198eMKLe4S00ZV3LddO8QRdxR
	J3+7bA2H45Ldqa/lCWvZ+IcgQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXz_tar0loK8sqHw--.17208S2;
	Thu, 12 Jun 2025 00:31:22 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 04/13] PCI: dwc: Refactor imx6 to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:31:21 +0800
Message-Id: <20250611163121.860619-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXz_tar0loK8sqHw--.17208S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4UCFyxtw18XF48Xr1fZwb_yoWrGFykpa
	y2vrnakF48JF4F9w4vya95XF13t3Z3CF4UGanrKwnaqFy2kr9rtayjy34ftFs7GFWjvryj
	9w18tw47J3WYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRHE_tUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxppo2hJrMxCHAAAsA

i.MX6 PCIe driver contains multiple read-modify-write sequences for
link training and speed configuration. These operations manually handle
bit masking and shifting to update specific fields in control registers,
particularly for link capabilities and speed change initiation.

Refactor link capability configuration and speed change handling using
dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
by encapsulating bit clear/set operations and eliminates intermediate
variables. For speed change control, replace explicit bit manipulation
with direct register updates through the helper.

Adopting the standard interface reduces code complexity in link training
paths and ensures consistent handling of speed-related bits. The change
also prepares the driver for future enhancements to Gen3 link training
by centralizing bit manipulation logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..3004e432f013 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 tmp;
 	int ret;
 
 	if (!(imx_pcie->drvdata->flags &
@@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
 	dw_pcie_dbi_ro_wr_en(pci);
-	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	tmp &= ~PCI_EXP_LNKCAP_SLS;
-	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
+				    PCI_EXP_LNKCAP_SLS,
+				    PCI_EXP_LNKCAP_SLS_2_5GB);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Start LTSSM. */
@@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 
 		/* Allow faster modes after the link is up */
 		dw_pcie_dbi_ro_wr_en(pci);
-		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-		tmp &= ~PCI_EXP_LNKCAP_SLS;
-		tmp |= pci->max_link_speed;
-		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
+					    PCI_EXP_LNKCAP_SLS,
+					    pci->max_link_speed);
 
 		/*
 		 * Start Directed Speed Change so the best possible
 		 * speed both link partners support can be negotiated.
 		 */
-		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-		tmp |= PORT_LOGIC_SPEED_CHANGE;
-		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+					    0, PORT_LOGIC_SPEED_CHANGE);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
 		ret = imx_pcie_wait_for_speed_change(imx_pcie);
@@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
-	u32 val;
 
 	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
 		/*
@@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		 * to 0.
 		 */
 		dw_pcie_dbi_ro_wr_en(pci);
-		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
+					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 }
-- 
2.25.1


