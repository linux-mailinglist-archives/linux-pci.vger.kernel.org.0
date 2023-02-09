Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557256912C1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 22:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBIVtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 16:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBIVtI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 16:49:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6925298;
        Thu,  9 Feb 2023 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675979347; x=1707515347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NoqEpFoUL5d6Nc9ZguuUCJqwt+fia9YkIka8An7cQKQ=;
  b=ddOJzlGOrNfOr+BTxcnooHpaswEG4kf5PU8Ff7xZQPS7yE+RiiQxy3aj
   xRQMD5zLvgS4YXgCOk1uS+No+P5IH5dZsNe6Ftb4yz0vzXdB6ZYzsoA8g
   WQNzkv6dRobVQr1VHA7Po9VvrTiqWxkKIoZ+HP1oJ0/hPdONGxbSL+ZsK
   nkla/+ZRm4/pFZKgXO30zCIK4mbwTU26dYKK2dInRhXdS4YSdBQxRaWXE
   31eOJUwiyAgXEo3+jQ1N6fhuSTngJQKAlZrXNbRnkxptnz63B7tr6BkU3
   HIDWnlXFTt6psIakqajVBuhd4UqtYbbS0Gak0HkfqbUTJnP70ESBB9Wzx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331554741"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="331554741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 13:49:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913299005"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="913299005"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 13:49:05 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, tglx@linutronix.de, kevin.tian@intel.com,
        darwi@linutronix.de, reinette.chatre@intel.com
Subject: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Date:   Thu,  9 Feb 2023 13:49:00 -0800
Message-Id: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_msix_alloc_irq_at() and pci_msix_free_irq() are not
declared when CONFIG_PCI_MSI is disabled.

Users of these two calls do not yet exist but when users
do appear (shown below is an attempt to use the new API
in vfio-pci) the following errors will be encountered when
compiling with CONFIG_PCI_MSI disabled:
drivers/vfio/pci/vfio_pci_intrs.c:461:4: error: implicit declaration of\
        function 'pci_msix_free_irq' is invalid in C99\
        [-Werror,-Wimplicit-function-declaration]
                           pci_msix_free_irq(pdev, msix_map);
                           ^
   drivers/vfio/pci/vfio_pci_intrs.c:461:4: note: did you mean 'pci_ims_free_irq'?
   include/linux/pci.h:2516:6: note: 'pci_ims_free_irq' declared here
   void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
        ^
drivers/vfio/pci/vfio_pci_intrs.c:511:15: error: implicit declaration of\
        function 'pci_msix_alloc_irq_at' is invalid in C99\
        [-Werror,-Wimplicit-function-declaration]
                   msix_map = pci_msix_alloc_irq_at(pdev, vector, NULL);
                                      ^
   drivers/vfio/pci/vfio_pci_intrs.c:511:15: note: did you mean 'pci_ims_alloc_irq'?
   include/linux/pci.h:2514:16: note: 'pci_ims_alloc_irq' declared here
   struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,\
                                    union msi_instance_cookie *icookie,

Provide definitions for pci_msix_alloc_irq_at() and pci_msix_free_irq() in
preparation for users that need to compile when CONFIG_PCI_MSI is
disabled.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---

checkpatch.pl warns about the usage of -ENOSYS but it does appear
to be the custom.

 include/linux/pci.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index adffd65e84b4..448482d1c4fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1621,6 +1621,19 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 
+static inline struct msi_map
+pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+		      const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOSYS };
+
+	return map;
+}
+
+static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map)
+{
+}
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
-- 
2.34.1

