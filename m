Return-Path: <linux-pci+bounces-41545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A4C6BD52
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A39D52C178
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7830BF7D;
	Tue, 18 Nov 2025 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9qPNszc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7C2E36F4
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504025; cv=none; b=co3aNl8F7V0qJkcS9GE/B0zF4dUatLUGN6G2VJFCWPvFBaaxMPSIsu7kXvHQTaD8aHRK3DM1DTWMH4KBCOU62E0NOuTieguKJ6FXh92Q1vCmmEUSC+PbXn3X5z56LNWo6NLE1K4oLYevPbIls8nkXGdmSsjcHyhFdPtvMorcO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504025; c=relaxed/simple;
	bh=a8bm08VYDcj/mmKPSImss1GDHgm0WbCyVNwe1Vw3XsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR7Id0sjPnmnlUK1RNcLtZqSBAgHBuZc/nM64ycmrWzj5NfnHekgDeg6kAlEjaE3Wnit/x25IafWBKIHK7ZhOKFeRxOntoq1o1EXL+DyAMKraqPqOf0Qlle1aYaTzdxtLRecZ5fL0nR+WEDgfQ+Zd/eCExiBSuctRlzo0G1ueVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9qPNszc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763504022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsSQ2wAGK0+ES4Vvtmq8MIPX2CBajCXRr5JRuygk4SM=;
	b=G9qPNszc2QH+9TEUHn/XsiWmkPM7SE56LvhIMHp6gRuakRWmVdXyO8SGbsyUBGrNGh7BhB
	GYRn1UvC6krfhlG8ballZ01cB/Pwh7MDgoNoZhGCqU0es6JxatMD5VzNHFSdbfL6UsaA0t
	EXl2FU8J6tG7qHawcZWtp+unGKKWxJk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-aPMkPPLCP_CZDDwSlMrQIg-1; Tue,
 18 Nov 2025 17:13:38 -0500
X-MC-Unique: aPMkPPLCP_CZDDwSlMrQIg-1
X-Mimecast-MFC-AGG-ID: aPMkPPLCP_CZDDwSlMrQIg_1763504017
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E89091956096;
	Tue, 18 Nov 2025 22:13:36 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FB90180047F;
	Tue, 18 Nov 2025 22:13:34 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: apple: Store private pointer in platform device's drvdata
Date: Tue, 18 Nov 2025 17:12:44 -0500
Message-ID: <20251118221244.372423-3-rrendec@redhat.com>
In-Reply-To: <20251118221244.372423-1-rrendec@redhat.com>
References: <20251118221244.372423-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Now pci_host_common_init() no longer uses the platform device's drvdata
to store the pointer to the allocated struct pci_host_bridge. Use the
drvdata to store the pointer to the driver's private data, which is the
struct apple_pcie allocated in apple_pcie_probe(). This eliminates the
need to store these pointers in a separate mapping table.

This reverts most of the changes in commit 643c0c9d0496 ("PCI: apple:
Add tracking of probed root ports"). No "Fixes" tag is added because
nothing is broken in that commit. This is just a simplification.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 drivers/pci/controller/pcie-apple.c | 53 ++++-------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 0380d300adca6..75bb6d51d31c2 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -187,7 +187,6 @@ struct apple_pcie {
 	const struct hw_info	*hw;
 	unsigned long		*bitmap;
 	struct list_head	ports;
-	struct list_head	entry;
 	struct completion	event;
 	struct irq_fwspec	fwspec;
 	u32			nvecs;
@@ -206,9 +205,6 @@ struct apple_pcie_port {
 	int			idx;
 };
 
-static LIST_HEAD(pcie_list);
-static DEFINE_MUTEX(pcie_list_lock);
-
 static void rmw_set(u32 set, void __iomem *addr)
 {
 	writel_relaxed(readl_relaxed(addr) | set, addr);
@@ -724,45 +720,13 @@ static int apple_msi_init(struct apple_pcie *pcie)
 	return 0;
 }
 
-static void apple_pcie_register(struct apple_pcie *pcie)
-{
-	guard(mutex)(&pcie_list_lock);
-
-	list_add_tail(&pcie->entry, &pcie_list);
-}
-
-static void apple_pcie_unregister(struct apple_pcie *pcie)
-{
-	guard(mutex)(&pcie_list_lock);
-
-	list_del(&pcie->entry);
-}
-
-static struct apple_pcie *apple_pcie_lookup(struct device *dev)
-{
-	struct apple_pcie *pcie;
-
-	guard(mutex)(&pcie_list_lock);
-
-	list_for_each_entry(pcie, &pcie_list, entry) {
-		if (pcie->dev == dev)
-			return pcie;
-	}
-
-	return NULL;
-}
-
 static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
 {
 	struct pci_config_window *cfg = pdev->sysdata;
-	struct apple_pcie *pcie;
+	struct apple_pcie *pcie = platform_get_drvdata(to_platform_device(cfg->parent));
 	struct pci_dev *port_pdev;
 	struct apple_pcie_port *port;
 
-	pcie = apple_pcie_lookup(cfg->parent);
-	if (WARN_ON(!pcie))
-		return NULL;
-
 	/* Find the root port this device is on */
 	port_pdev = pcie_find_root_port(pdev);
 
@@ -843,13 +807,9 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
-	struct apple_pcie *pcie;
+	struct apple_pcie *pcie = platform_get_drvdata(to_platform_device(dev));
 	int ret;
 
-	pcie = apple_pcie_lookup(dev);
-	if (WARN_ON(!pcie))
-		return -ENOENT;
-
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
@@ -876,6 +836,7 @@ static int apple_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct apple_pcie *pcie;
+	struct pci_host_bridge *bridge;
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -897,11 +858,11 @@ static int apple_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	apple_pcie_register(pcie);
+	bridge = pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
+	if (IS_ERR(bridge))
+		return PTR_ERR(bridge);
 
-	ret = pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
-	if (ret)
-		apple_pcie_unregister(pcie);
+	platform_set_drvdata(pdev, pcie);
 
 	return ret;
 }
-- 
2.51.1


