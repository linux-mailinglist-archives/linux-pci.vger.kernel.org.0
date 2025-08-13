Return-Path: <linux-pci+bounces-33919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C831CB23FD8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D0C3B1712
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2112C0323;
	Wed, 13 Aug 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jQH6d4OO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6F2BF016;
	Wed, 13 Aug 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060360; cv=none; b=MxrplY6/D0XzXVupLa988J2j0dcMMU+bFLnBXB9lx/6V5pA47kOqJ5WE3uuGMUQN+xGmkSaYwaDvN3szO60smqUmpdZURSYuEqwMuU8r07P2/FlLD/owJRcv4vhEFBY5yi2032Oag54G8uE9kTalmsBXJ6WZX74vya4xtFvQKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060360; c=relaxed/simple;
	bh=WaqClp0fPwTnNk3GVbw7PHXnJKqzvZJc3y3PKvO5tSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0cLsEKur1MvhM8PhrC/0AuO4yI3BbQZ8u/IyCLTdPIk0TNWgduB8O3gLgMxiEpg8Zcv2ol2LEYfN6HghiPwDpISY/btKgmUwil4C/spx9Mfe25VJouh4CNuPou0dNVWjB2Fn4BVNb6HwiVEuCCkmmMjc9xdpXygB0cJtnkXoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jQH6d4OO; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/u
	gQBPOrIhrF7NA9jCfCbT5Ubnzjqah7KP20uWhckXo=; b=jQH6d4OOibpUGP/+kX
	BhPu6WgeoyGSUxYJf5ZXo0RZf+GIdSwg+U2F2LVy1oFho44xMKwsihtcg9u2yX0P
	OiB+2Qt6zzGFq9M2awiADGFPzBw5Msrgq61mB3IipfLbURpYvSxRvJQgBKC6t00h
	y5LV0uGl6K026D5v80mG9XTJ8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S6;
	Wed, 13 Aug 2025 12:45:37 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 04/13] PCI: imx6: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:22 +0800
Message-Id: <20250813044531.180411-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4UCFyxtw18XF48Xr1fZwb_yoWrXr13pa
	y2vrnayF48JF4F9w4kAa95ZF13t3Z3CF4UGanrKwnaqFy2yry7tayjy343tF4xGFWjyryj
	9w1Utw47J3WYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinYFZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQw6oo2icD7TgwQAAso

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..38c4e1534059 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -939,7 +939,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u32 tmp;
 	int ret;
 
 	if (!(imx_pcie->drvdata->flags &
@@ -954,10 +953,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
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
@@ -970,18 +968,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 
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
@@ -1302,7 +1298,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
-	u32 val;
 
 	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
 		/*
@@ -1317,9 +1312,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
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


