Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864EA7CCA35
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 19:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjJQR4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQR4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 13:56:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F039B;
        Tue, 17 Oct 2023 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697565406; x=1729101406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IiT0T9urHaaLctpoYEo5u8bWJoCO3zZAAlG/vZHqHnU=;
  b=WiQwDsdziVqmTDwpxxw7LmLEqlwdUcPCIk6efnEeBJDE7pOhLP3fyYMD
   iQIu/cbVgSU/oV+rOCfzkg7DxOHD8GWIPVMtPDzXGPlEttBC4egl5564x
   dCniDdQt/ArlHIe1R76I+crtK9l7OUMIAOs1+gRHEyRQQIKNFL+fURVQ4
   Q+uS+YpDgJvN+ndz/QlykKv0aLMVohOHydPGo0PCCdg1M6A1MkDKXGh/F
   za1H/6ELQbZfQD6noUPkf5ZQYrSbDxGZaduDMO7/8iPCL1RPkFttc9LzG
   36xc7gbIVJy52k4TzTBSNIGZlWFzvXtabnC82Sm4LytBkJZz3iC9npxkG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472073932"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="472073932"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="929848920"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="929848920"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:56:45 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, tglx@linutronix.de
Cc:     kevin.tian@intel.com, reinette.chatre@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] PCI/MSI: Provide stubs for IMS functions
Date:   Tue, 17 Oct 2023 10:56:38 -0700
Message-Id: <14ff656899a3757453f8584c1109d7a9b98fa258.1697564731.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IMS related functions (pci_create_ims_domain(),
pci_ims_alloc_irq(), and pci_ims_free_irq()) are not declared
when CONFIG_PCI_MSI is disabled.

Provide definitions of these functions for use when callers
are compiled with CONFIG_PCI_MSI disabled.

Fixes: 0194425af0c8 ("PCI/MSI: Provide IMS (Interrupt Message Store) support")
Fixes: c9e5bea27383 ("PCI/MSI: Provide pci_ims_alloc/free_irq()")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org      # v6.2+
---

This is a preparatory patch for the first caller of these
functions (VFIO) for which work is in progress:
https://lore.kernel.org/lkml/cover.1696609476.git.reinette.chatre@intel.com/

checkpatch.pl complains about the usage of ENOSYS but
it does appear to be the custom.

 include/linux/pci.h | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..b56417276042 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1624,6 +1624,8 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
+struct msi_domain_template;
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
@@ -1656,6 +1658,11 @@ void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1719,6 +1726,25 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
+
+static inline bool pci_create_ims_domain(struct pci_dev *pdev,
+					 const struct msi_domain_template *template,
+					 unsigned int hwsize, void *data)
+{ return false; }
+
+static inline struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,
+					       union msi_instance_cookie *icookie,
+					       const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOSYS, };
+
+	return map;
+}
+
+static inline void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map)
+{
+}
+
 #endif
 
 /**
@@ -2616,14 +2642,6 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
-struct msi_domain_template;
-
-bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
-			   unsigned int hwsize, void *data);
-struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
-				 const struct irq_affinity_desc *affdesc);
-void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
-
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
-- 
2.34.1

