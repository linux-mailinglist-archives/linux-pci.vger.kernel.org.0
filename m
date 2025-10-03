Return-Path: <linux-pci+bounces-37552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA7BB7730
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 18:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4C61886318
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78882BEC31;
	Fri,  3 Oct 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsMDhdku"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D12BE029
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507550; cv=none; b=OCAvpP+u3zC4bySwJg5w5eFhHDwF/tKe3lwyawzlhs0+IHPjdNE3UPIEYF+Ix822sk2cSzslF3MEybRgponfQDvH5J949Eho7pNiPi9n4gB7rXQUmP1QaGOECBVP/yJuzXK+wGSwXz9rHaWvG5ovc5RdwMsn9+FmKNTrdaPKwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507550; c=relaxed/simple;
	bh=CkPAdLrlVh/ddleMtae0Bm+6tKcqVayNFDzb9Me1BGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVT6CpJf6NpByv+eTjInJLGXYJMs5OtQ1nbKtIMnAyWxKons5R21M02pL9oWNOJE3dQQHmqJOF7V+QSaT/lCLdrW6HJMCVXs43Bv9ak1IT/FAW9yGaGR7S+auUdFjKTi/bPS8eYtfyxDTRUA+pBeyzM0mJhqtZtTLCR9xxL8uOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsMDhdku; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759507548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELkbprrf23tmXGdQAfZaq2jr7uQN2PDNYwdGVW1XlsQ=;
	b=BsMDhdkucqDgeYTFjGv+jZqgYmrTlewZ41fnCRDy+icKWmW9xwJGivZdYd091Xt9UwHs5K
	9A8Gv8O4UnCulSz0VPhgM6lmSVWp84lgDVqlHjbo918IES7vt3YP3/fVtQzx5VH2XCrNAF
	xEV5qp1Kh96Zi5oi4lOCScAmXXBknc0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-jVL1QGJKO9mPod_L3kTvhA-1; Fri,
 03 Oct 2025 12:05:44 -0400
X-MC-Unique: jVL1QGJKO9mPod_L3kTvhA-1
X-Mimecast-MFC-AGG-ID: jVL1QGJKO9mPod_L3kTvhA_1759507543
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49B36180057B;
	Fri,  3 Oct 2025 16:05:43 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.65.162])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFEF719560B1;
	Fri,  3 Oct 2025 16:05:40 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: dwc: Enable MSI affinity support
Date: Fri,  3 Oct 2025 12:04:21 -0400
Message-ID: <20251003160421.951448-4-rrendec@redhat.com>
In-Reply-To: <20251003160421.951448-1-rrendec@redhat.com>
References: <20251003160421.951448-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Gleixner <tglx@linutronix.de>

Leverage the interrupt redirection infrastructure to enable CPU affinity
support for MSI interrupts. Since the parent interrupt affinity cannot
be changed, affinity control for the child interrupt (MSI) is achieved
by redirecting the handler to run in IRQ work context on the target CPU.

This patch was originally prepared by Thomas Gleixner (see Link tag
below) in a patch series that was never submitted as is, and only
parts of that series have made it upstream so far.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Co-developed-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3ee6a464726ec..a3d4b423a2ab9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -24,9 +24,21 @@
 static struct pci_ops dw_pcie_ops;
 static struct pci_ops dw_child_pcie_ops;
 
+static void dw_pcie_msi_ack(struct irq_data *d) { }
+
+static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				      struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	info->chip->irq_ack = dw_pcie_msi_ack;
+	info->chip->irq_pre_redirect = irq_chip_pre_redirect_parent;
+	return true;
+}
+
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
 				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
-				    MSI_FLAG_NO_AFFINITY		| \
 				    MSI_FLAG_PCI_MSI_MASK_PARENT)
 #define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
 				     MSI_FLAG_PCI_MSIX			| \
@@ -36,9 +48,8 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
 	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
-	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.prefix			= "DW-",
-	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+	.init_dev_msi_info	= dw_pcie_init_dev_msi_info,
 };
 
 /* MSI int handler */
@@ -59,7 +70,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			continue;
 
 		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
-			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
+			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
 
@@ -121,7 +132,9 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
 }
 
-static void dw_pci_bottom_ack(struct irq_data *d)
+static void dw_pci_bottom_ack(struct irq_data *d) { }
+
+static void dw_pci_pre_redirect(struct irq_data *d)
 {
 	struct dw_pcie_rp *pp  = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -140,6 +153,10 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
 	.irq_mask		= dw_pci_bottom_mask,
 	.irq_unmask		= dw_pci_bottom_unmask,
+#ifdef CONFIG_SMP
+	.irq_pre_redirect	= dw_pci_pre_redirect,
+	.irq_set_affinity	= irq_chip_redirect_set_affinity,
+#endif
 };
 
 static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.51.0


