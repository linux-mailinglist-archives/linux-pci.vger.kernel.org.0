Return-Path: <linux-pci+bounces-28000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FBCABC495
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88A71B60192
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE521288C2B;
	Mon, 19 May 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FD8dNOdP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C02882B9;
	Mon, 19 May 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672357; cv=none; b=gx+OUE3mBo2y4QbKuABTyNsw0RC2SsPnlGTEc9c9uNW11qoAOILZSYVqtAOtulNYLVb1OnDBzLm1gVJQPj00Sf0/oupEIOQiWPdh6jueCCSdz3jWJ2kpCuG8DoRioJRfxo2bxkfx0fu3OUq7DTk62z8KlUWQJ/UEMHQSURjepas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672357; c=relaxed/simple;
	bh=wd18m7ELW+3UjHnDRV1VpQgKTznLOu++NFPMRX2T/as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIqcw0EiUD7NEAtV+nHfv+c1Z20LHHCbQRLrjMWv+Ks87lKoEpEgn326DXxyM8IZjIo8cVbUU3YNCdSL8Gsu8Vxi8hT23JUPEvtO8WBcmW+FoqpZXMtfeggUxu2IXZrORQ0+WncrssmEkyxAxjUPCEGHLAwwsBVWtvT44EB1Rsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FD8dNOdP; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lf
	Om0h+1AOk1AidZgxJzloTWVu2I2j61f1wzvYEiDB8=; b=FD8dNOdPVeXkj2Zt2a
	06yIXZzEHnJHL35sSH8s2YTz5Z/MAFU6Yfn85RsbeJXqDxOI99wbTH55J4bbyMRY
	THIi1KaqW+zqZiRTdxvk+YsWGamO/LGHKUAk3SfpjzAGYLMAekxJuAMqH2UIgE+F
	0uJEOncp2BjxKTCdvgmVbO5bQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3vJ4CXStoPbk5Cg--.56045S4;
	Tue, 20 May 2025 00:32:04 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/3] PCI: dwc: Simplify link speed configuration with macro
Date: Tue, 20 May 2025 00:31:55 +0800
Message-Id: <20250519163156.217567-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519163156.217567-1-18255117159@163.com>
References: <20250519163156.217567-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vJ4CXStoPbk5Cg--.56045S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW5ZFWUuryxuF1fXF4ruFg_yoW8Xw1Dpa
	y3AFy8AF48JF43uFs0ga4kXa4UXFnxGFWDGFZ8W3Z3XFy2yasxX3W0yrySq34akFZ2yr1a
	9r17JrWUG3W7tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEGYLLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxlSo2grV+Vn7wAAse

Replace switch-case based speed-to-register conversion in DesignWare
driver with the newly introduced PCIE_SPEED2LNKCTL2_TLS_ENC macro.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc066..951e2ce69dfa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -754,24 +754,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
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
+	link_speed = PCIE_SPEED2LNKCTL2_TLS_ENC(link_speed);
+	if (link_speed == 0) {
 		/* Use hardware capability */
 		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
 		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
-		break;
 	}
 
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
-- 
2.25.1


