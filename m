Return-Path: <linux-pci+bounces-42278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12EC9330B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5545E4E2E02
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715562DC784;
	Fri, 28 Nov 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjiQoEVE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D292E7186
	for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364907; cv=none; b=pvp4vrrqBBR0wQ30tGfdtMUnkdRvH9UU19fpk4C2Bx/6MXXR34w9Ejn2w0pJPJhxq5tWkKjncNgh4q8w+6hIMdMTOUgX8IpT1C17/OiJHgIdQO0HevstpvHiUYatKIAS8JdE1hnXVNOEHMxpL1LwdeYI7LXQ2UjHIkkK90IL4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364907; c=relaxed/simple;
	bh=HR0mjuvAFCoPiKIDEaxTEF6mpphlp3ix+5hRURxUeXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L73tgUNhB+ko10v9eHen7Eb7zTZ5QkjLYVFun1p5aGFuklp8vUYBeS0Dd1kTl4TMym8d2fnyQOOBHenxQkhWOBbHaEb+S6TThIzR1wgU2I6n27SserGU03PD5E5OfqAKQfJEQhK6XQi0A5sxweAwmTfdu3msQwRNRUIYU1MjsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjiQoEVE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764364904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxSNQ6ba9bh+xHYQs2dla19F/krQL1PILIcViaY2SKM=;
	b=WjiQoEVEgVika4HZCpT52hwYc+NWrSXOmpTAmMjTdCumN1tnDiQyWZfkmbU3s0BUADfQmS
	Pqmlk49FxjlfqvkakboijbqOHZ0RxOveUt7BWfuXJkLFf5p2RxGCWa60LofQ7eXwW3J6jn
	/CFhOqOhWCcadhZhGTYFZ/T37tA8ZTs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-B4dGEvseNny7qq-YzyOCgA-1; Fri,
 28 Nov 2025 16:21:41 -0500
X-MC-Unique: B4dGEvseNny7qq-YzyOCgA-1
X-Mimecast-MFC-AGG-ID: B4dGEvseNny7qq-YzyOCgA_1764364899
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BDF71956053;
	Fri, 28 Nov 2025 21:21:39 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD01F1800876;
	Fri, 28 Nov 2025 21:21:36 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
Date: Fri, 28 Nov 2025 16:20:55 -0500
Message-ID: <20251128212055.1409093-4-rrendec@redhat.com>
In-Reply-To: <20251128212055.1409093-1-rrendec@redhat.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Leverage the interrupt redirection infrastructure to enable CPU affinity
support for MSI interrupts. Since the parent interrupt affinity cannot
be changed, affinity control for the child interrupt (MSI) is achieved
by redirecting the handler to run in IRQ work context on the target CPU.

This patch was originally prepared by Thomas Gleixner (see Link tag
below) in a patch series that was never submitted as is, and only
parts of that series have made it upstream so far.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index aa93acaa579a5..90d9cb45e7842 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -26,9 +26,27 @@ static struct pci_ops dw_pcie_ops;
 static struct pci_ops dw_pcie_ecam_ops;
 static struct pci_ops dw_child_pcie_ops;
 
+#ifdef CONFIG_SMP
+static void dw_irq_noop(struct irq_data *d) { }
+#endif
+
+static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				      struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+#ifdef CONFIG_SMP
+	info->chip->irq_ack = dw_irq_noop;
+	info->chip->irq_pre_redirect = irq_chip_pre_redirect_parent;
+#else
+	info->chip->irq_ack = irq_chip_ack_parent;
+#endif
+	return true;
+}
+
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
 				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
-				    MSI_FLAG_NO_AFFINITY		| \
 				    MSI_FLAG_PCI_MSI_MASK_PARENT)
 #define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
 				     MSI_FLAG_PCI_MSIX			| \
@@ -40,9 +58,8 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
 	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
-	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.prefix			= "DW-",
-	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+	.init_dev_msi_info	= dw_pcie_init_dev_msi_info,
 };
 
 /* MSI int handler */
@@ -63,7 +80,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			continue;
 
 		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
-			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
+			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
 
@@ -140,10 +157,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.name			= "DWPCI-MSI",
-	.irq_ack		= dw_pci_bottom_ack,
 	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
 	.irq_mask		= dw_pci_bottom_mask,
 	.irq_unmask		= dw_pci_bottom_unmask,
+#ifdef CONFIG_SMP
+	.irq_ack		= dw_irq_noop,
+	.irq_pre_redirect	= dw_pci_bottom_ack,
+	.irq_set_affinity	= irq_chip_redirect_set_affinity,
+#else
+	.irq_ack		= dw_pci_bottom_ack,
+#endif
 };
 
 static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.51.1


