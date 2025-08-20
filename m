Return-Path: <linux-pci+bounces-34379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14AB2DB94
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D64574E50F7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33F2E2EED;
	Wed, 20 Aug 2025 11:47:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E46239E91
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690457; cv=none; b=S37YhJ27nbe9d2ORgRW5NcQptQ/Q1kjBL0kBv+YrJEpTRC2Nf4KNp2WLRZqMxOshu+ej0U3RsFn7dmo0yiCzM7vjG4teB0PIVEPllW/g/0E0XXw7Zz6EaMnwpyygkJZBJ6SVFygKCbCUocFifGbxWTuKRm1lbliOj4we/ISJsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690457; c=relaxed/simple;
	bh=HG6tS9AKF+IuFMqnPCMtpz7+FTclyTPfrQN/fCNQKAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrfHXmoFa/Nk4HW956A4h7JK7X5uphemKYQdlfewR5oAEkLvQEm3wUOVVBYwNrPvtz7/kXdzblFVUVmu2wxae2J6Af9L60hEvQ506c3KrBbVilUvohWBMt0tG0lWRwgj7WDpDlPeIoGAmqE7VzeuFS7iAkRAxIPjE47oirGL9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJIHd019122
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:18 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIr1f018798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:53 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:53 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 2/6] PCI: dwc: Add outbound ATU range check callback
Date: Wed, 20 Aug 2025 19:18:39 +0800
Message-ID: <20250820111843.811481-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820111843.811481-1-randolph@andestech.com>
References: <20250820111843.811481-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57KBJIHd019122

Introduce a callback for outbound ATU range checking to support
range validations specific to cases that deviate from the generic
check.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 18 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h |  3 +++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..f410aefaeb5e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -535,12 +535,20 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
-	limit_addr = parent_bus_addr + atu->size - 1;
+	if (pci->ops && pci->ops->outbound_atu_check) {
+		val = pci->ops->outbound_atu_check(pci, atu, &limit_addr);
+		if (val)
+			return val;
+	} else {
+		limit_addr = parent_bus_addr + atu->size - 1;
 
-	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
-	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
-	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
-		return -EINVAL;
+		if ((limit_addr & ~pci->region_limit) !=
+		    (parent_bus_addr & ~pci->region_limit) ||
+		    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+		    !IS_ALIGNED(atu->pci_addr, pci->region_align) ||
+		    !atu->size) {
+			return -EINVAL;
+		}
 	}
 
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..40dd2c83b1c7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -469,6 +469,9 @@ struct dw_pcie_ep {
 
 struct dw_pcie_ops {
 	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
+	u32	(*outbound_atu_check)(struct dw_pcie *pcie,
+				      const struct dw_pcie_ob_atu_cfg *atu,
+				      u64 *limit_addr);
 	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-- 
2.34.1


