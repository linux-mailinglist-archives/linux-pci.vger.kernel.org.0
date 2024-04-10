Return-Path: <linux-pci+bounces-6090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 981498A0302
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07F5B249E2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C2190674;
	Wed, 10 Apr 2024 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhJbhlIg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FB19066E;
	Wed, 10 Apr 2024 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787198; cv=none; b=L9lyCHuXwzsnZM7ZFBhfmRZ+zi56g8kFZ1eQHuI5a0FAi0fa4nRryEjGgcjLulasYFmSri82Tg/IIitDpXeC9aXUD9kVaSjFkumdf31UrKlNSXo36xfK7VUYkfoRqitUz3W5VDQDl2TbjLhyZ9IC0vYc1RIvfIYGRY9u+3M9OGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787198; c=relaxed/simple;
	bh=LMCkQbnW2I5WGnGXZOS3NTRS12MF/ECBP2NGHKZbJ6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAEbvA7ZKD6x7Ka3IKo2oz/ni0QmiywWsLzCX6BfN2mu5Kl0th2rGK3iJT73eLMcArYnKSWe0goAyteXmX+wA07W1B9cqnxZ2HbubGrH1E6C+cksoR+AO7jREtYXTyiyHkDg0nHez91cf74I4IpsIC3TTkMufpFmomqjUSpyRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhJbhlIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95A4C433C7;
	Wed, 10 Apr 2024 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787198;
	bh=LMCkQbnW2I5WGnGXZOS3NTRS12MF/ECBP2NGHKZbJ6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhJbhlIgiyG3cvd73xQPqKhSqelnts7yNWcvULFDB0z6+ey+Hyrgavk4AtRdvT3MW
	 sr9cE5JpTnTXUlMZ0N7S8euyrT9ZJS2HQNYhDPrrObSaqt8+ZQanKKnu8j9vNsyX0s
	 ysrZ8rPpy9lvbO+WbcIdOTykTaLMGAADBeN8fqhufksz7rtDN7ksnyrq9YNHjW5Uog
	 9ZngjmsSdSJOaxsacq/sV8p1mSfoGsNKFACAM8FJGq3HMYTLLYLIEHw0XmS//pzqJl
	 96AW+VlYBpApwPl54DHWT1lvzx/cZWB5YkkZ0y35R/Y8SHsyAPc9YY5UK9Dg+C+IOT
	 q8XV8EABKuOyg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/7] Revert "PCI/MSI: Provide stubs for IMS functions"
Date: Wed, 10 Apr 2024 17:13:01 -0500
Message-Id: <20240410221307.2162676-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410221307.2162676-1-helgaas@kernel.org>
References: <20240410221307.2162676-1-helgaas@kernel.org>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


