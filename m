Return-Path: <linux-pci+bounces-41544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3CCC6BD4F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD76435B598
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021A2E36F4;
	Tue, 18 Nov 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRU6ILbM"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE00306491
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504016; cv=none; b=RRC2sHshhHuFRxNFcATfFgL6CGhhxh1A33QJBRs4FXQTnwUC/0lBet2e5xboU514myDDSTp69b7CugDgLkHXdMs74WUv0NuOuVtbchk3rZoj1jPIlIZxPGg9I1uOQjaCv/7/+irFcfgti5XUKxt+4FsE0uuTH0G1rSDJZS4Cv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504016; c=relaxed/simple;
	bh=nemxYTaxgz18cpW0AyxrnvFOgq9KjnE+stmhda3X/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzQMqSTF1FV3z426t3l2nZbWMRMU4/ru3O9Q4p8THeDQe0Q8yW20bSnVKx3ypwpvAZLZXlcjaIh2zhEa+lU1XnJFD0VclrVP7GhGjkOSQEQLrw4wJgoo43d+kewl3vCWREbYlvmfzLsxnEo2i8Pfr2/GQOl3+nuBY/wVuS/dB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRU6ILbM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763504013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GQmSWJXWqWL3qxm9AX9CXgB8VtCo4TJcQ8Q4ntTz+0=;
	b=RRU6ILbM0aywH8swyKfRa5hPPwJLYHQWLSpwOw+aSGRHajaSAyFF5GIoYFvW4C8JwgG4nR
	G0et5IstwRsgoho/t8oWszzxb8itP94cTizOmVFio0xSBQaQVcW/x9iNVBuNIrsZXekMvH
	AxcQAsnYkV8K18BeIiaPk/37CTi/Bos=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-aIUV0x0aMsyvzeu3_78doQ-1; Tue,
 18 Nov 2025 17:13:29 -0500
X-MC-Unique: aIUV0x0aMsyvzeu3_78doQ-1
X-Mimecast-MFC-AGG-ID: aIUV0x0aMsyvzeu3_78doQ_1763504008
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C958195608A;
	Tue, 18 Nov 2025 22:13:28 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42675180049F;
	Tue, 18 Nov 2025 22:13:26 +0000 (UTC)
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
Subject: [PATCH 1/2] PCI: host-common: Do not set drvdata in pci_host_common_init()
Date: Tue, 18 Nov 2025 17:12:43 -0500
Message-ID: <20251118221244.372423-2-rrendec@redhat.com>
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

Currently pci_host_common_init() uses the platform device's drvdata to
store the pointer to the allocated struct pci_host_bridge. This makes
sense for drivers that use pci_host_common_{probe,remove}() directly as
the platform probe/remove functions, but leaves no option for more
complex drivers to store a pointer to their own private data.

Change pci_host_common_init() to return the pointer to the allocated
struct pci_host_bridge, and move the platform_set_drvdata() call to
pci_host_common_probe(). This way, drivers that implement their own
probe function can still use pci_host_common_init() but store their own
pointer in the platform device's drvdata.

For symmetry, move the release code to a new function that takes a
pointer to struct pci_host_bridge, and make pci_host_common_release() a
wrapper to it that extracts the pointer from the platform device's
drvdata. This way, drivers that store their own private pointer in the
platform device's drvdata can still use the library release code.

No functional change to the existing users of pci-host-common is
intended, with the exception of the pcie-apple driver, which is modified
in a subsequent patch.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 drivers/pci/controller/pci-host-common.c | 36 ++++++++++++++++--------
 drivers/pci/controller/pci-host-common.h |  6 ++--
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 810d1c8de24e9..86002195c93ac 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -52,25 +52,24 @@ struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(pci_host_common_ecam_create);
 
-int pci_host_common_init(struct platform_device *pdev,
-			 const struct pci_ecam_ops *ops)
+struct pci_host_bridge *pci_host_common_init(struct platform_device *pdev,
+					     const struct pci_ecam_ops *ops)
 {
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
+	int rc;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	of_pci_check_probe_only();
 
-	platform_set_drvdata(pdev, bridge);
-
 	/* Parse and map our Configuration Space windows */
 	cfg = pci_host_common_ecam_create(dev, bridge, ops);
 	if (IS_ERR(cfg))
-		return PTR_ERR(cfg);
+		return (struct pci_host_bridge *)cfg;
 
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
@@ -78,31 +77,46 @@ int pci_host_common_init(struct platform_device *pdev,
 	bridge->disable_device = ops->disable_device;
 	bridge->msi_domain = true;
 
-	return pci_host_probe(bridge);
+	rc = pci_host_probe(bridge);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(pci_host_common_init);
 
 int pci_host_common_probe(struct platform_device *pdev)
 {
 	const struct pci_ecam_ops *ops;
+	struct pci_host_bridge *bridge;
 
 	ops = of_device_get_match_data(&pdev->dev);
 	if (!ops)
 		return -ENODEV;
 
-	return pci_host_common_init(pdev, ops);
+	bridge = pci_host_common_init(pdev, ops);
+	if (IS_ERR(bridge))
+		return PTR_ERR(bridge);
+
+	platform_set_drvdata(pdev, bridge);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
-void pci_host_common_remove(struct platform_device *pdev)
+void pci_host_common_release(struct pci_host_bridge *bridge)
 {
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
-
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
 }
+EXPORT_SYMBOL_GPL(pci_host_common_release);
+
+void pci_host_common_remove(struct platform_device *pdev)
+{
+	pci_host_common_release(platform_get_drvdata(pdev));
+}
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 51c35ec0cf37d..018e593bafe47 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -11,11 +11,13 @@
 #define _PCI_HOST_COMMON_H
 
 struct pci_ecam_ops;
+struct pci_host_bridge;
 
 int pci_host_common_probe(struct platform_device *pdev);
-int pci_host_common_init(struct platform_device *pdev,
-			 const struct pci_ecam_ops *ops);
+struct pci_host_bridge *pci_host_common_init(struct platform_device *pdev,
+					     const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
+void pci_host_common_release(struct pci_host_bridge *bridge);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
-- 
2.51.1


