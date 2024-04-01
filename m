Return-Path: <linux-pci+bounces-5503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A78947A5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 01:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EF4280FDD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF35730D;
	Mon,  1 Apr 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuOd7go4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0F57307;
	Mon,  1 Apr 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013814; cv=none; b=U2G0YPIu0X2HcZkLvLnvvZbj1adVOF1IBmCBWMgf+92NXOy+NhajuX/nP6qz/WGqCw2lFaC6r8u0aK16HM75H0tRnIu4zroJpSV9qrCqC4tj5+33/5rQeFypNJuiL3E2m0hDSbylwxl4kuB5l2eUi1odBTn7eWI8lcHj5/Yk93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013814; c=relaxed/simple;
	bh=SZKdCKJHtrda+SBS6OSH1JBEZg5Aizx7ZUuvFo0C4QE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqeVJVkGpluVh9i7hDaObw1eE796zSz1zqQWwc/NJ/bWrGFaKhJT9xb0Th9QmZMIYOH17z2ikkf/EtCW6YMi5OOv24vpOQAsvtirsKyv3HOlMxCXQS/K8I7tUKCpZtsrC6+WnTP5S55ci51Bds2r3xt4WrdYQIE/p0CCrSYEQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuOd7go4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DFEC43390;
	Mon,  1 Apr 2024 23:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712013814;
	bh=SZKdCKJHtrda+SBS6OSH1JBEZg5Aizx7ZUuvFo0C4QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuOd7go47p2H+11mlx6V600mWddRnAQiYX+XObWFEzEGcZg9nWRhKKQOEx+r2LSWE
	 XNOPiq6efjRbTotw2IBIl3J67X3qyqjTsyWM28OyXIUxcoXy7beQ/ZNl8108a2xsdx
	 zdgGDHqz+b+wqDGY4vwVxik+b+d36l/UBYq26/wAlWNbe1t3M68hqgi8DfT7Gzv9TO
	 xRvS1Y/Vd9lAQj7IYRX3FPfADT6pUUGLl7paaYsvM9YwB4fznwvOT89h2lfNwnD04f
	 K9AEX9lhHhmr09tP8bmEDcmsFjLi1EGjnPByJOzp5lyeBhAdgSA++YsWZy/iG6rFg/
	 v14kiMsILBnVg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] Revert "PCI/MSI: Provide stubs for IMS functions"
Date: Mon,  1 Apr 2024 18:23:24 -0500
Message-Id: <20240401232326.1794707-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401232326.1794707-1-helgaas@kernel.org>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 41efa431244f6498833ff8ee8dde28c4924c5479.

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.  If this is
re-added later, this could be squashed with these commits:

  0194425af0c8 ("PCI/MSI: Provide IMS (Interrupt Message Store) support")
  c9e5bea27383 ("PCI/MSI: Provide pci_ims_alloc/free_irq()")

which added the non-stub implementations.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..abbef75b2b92 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1658,8 +1658,6 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
-struct msi_domain_template;
-
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
@@ -1692,11 +1690,6 @@ void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data);
-struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
-				 const struct irq_affinity_desc *affdesc);
-void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1760,25 +1753,6 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
-
-static inline bool pci_create_ims_domain(struct pci_dev *pdev,
-					 const struct msi_domain_template *template,
-					 unsigned int hwsize, void *data)
-{ return false; }
-
-static inline struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,
-					       union msi_instance_cookie *icookie,
-					       const struct irq_affinity_desc *affdesc)
-{
-	struct msi_map map = { .index = -ENOSYS, };
-
-	return map;
-}
-
-static inline void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map)
-{
-}
-
 #endif
 
 /**
@@ -2690,6 +2664,14 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+struct msi_domain_template;
+
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
+
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
-- 
2.34.1


