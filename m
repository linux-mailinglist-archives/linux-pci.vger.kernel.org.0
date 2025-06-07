Return-Path: <linux-pci+bounces-29135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C88AD0E4D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BA1890BD1
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3A1EF091;
	Sat,  7 Jun 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g5ybccpf"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E513E02A;
	Sat,  7 Jun 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311787; cv=none; b=UlGi4YAHZz9dSHv65Dv2JZsdxrZBZXT5uOmeO53zzZt+3rHheLJwKJT1O0XyHBIHEFTSzWMNDPfdpttSXMTLTKsfeLQnpBJxhVFZMBeh82cb5C8YrDcFPKG0dS8rIXAVCfPAG87lvOXM4lL4r/Q1FKlzJBxM5ZipYIslmL9MciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311787; c=relaxed/simple;
	bh=fFeDiADoe+sKeDqiwUsCZLbJgfwv5CvHPS3We/bA0TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZMMTwnPs6c+MypSeSvNtqbm9+HjakhWVIUJvwYM3KkoBguWm/Cy2ZugH0edQmLC+0bbLoDHhd5DZJxPBvsGybcxoay8xWwhhl1iM/CpcY6qSmEn+n5l1keaVWHSDGqLV3cg14sFGeBI/Z3sz3z/rfInf8PYwF6rpbKnO6Ig84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g5ybccpf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ue
	mAjLG+fq7E3m+VSfTHWSSRfPttGVg0NlJysUzuR4o=; b=g5ybccpfaEljW56lEj
	Ey+aPXDrUTgxaEpTpFkcDA3O4Z7j5nkSVGBQwPXZHPuQm/4ejvUp9odWTKL7JMfR
	7aEjGXSguuizi3kVkjsE9PUgHhaNnL7DFP3eb7klZ39G8731z7wq/uXeMRTyfpsN
	R1yGn8UKDeEHiq6YEPbvSexyA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3dpsKYURonH09Gw--.59622S4;
	Sat, 07 Jun 2025 23:55:56 +0800 (CST)
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
Subject: [PATCH v2 2/3] PCI: dwc: Simplify link speed configuration with macro
Date: Sat,  7 Jun 2025 23:55:44 +0800
Message-Id: <20250607155545.806496-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607155545.806496-1-18255117159@163.com>
References: <20250607155545.806496-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3dpsKYURonH09Gw--.59622S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW5ZFWxuF43AryrGr48Zwb_yoW8Xw15pa
	y3AFy8ZF48Ja13ZFs8Was7Za4UXFnxCFWDCFZ8W3Z3WFy2yasxWFy0yrySq34akFZ2yr13
	ury7JrWUG3W7tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zElksgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw9lo2hEWUa6AAAAsP

Replace switch-case based speed-to-register conversion in DesignWare
driver with the newly introduced PCIE_SPEED2LNKCTL2_TLS() macro.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d794964fa0f..da91b57ad744 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -768,24 +768,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
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


