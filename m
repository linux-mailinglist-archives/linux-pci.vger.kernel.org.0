Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA0A0485
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfH1OPF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 10:15:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 10:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dcNoVkLcOFSpqEkta3afgycql03d8kNzZhx1x576b6A=; b=PySZeX7Cm0TijaFvshcMXuwXM4
        uSy06EUr1VCggQ3gtbVTUi3M7BbJEuDt71eW09ylELoOXzKw/uA4ly37SFkn40z6oi7FzmOiDEfwZ
        ZQQaXd0hkW4BbbKcxiqT1HS/u5XpTxHqNpWGMzQY/YCTszPFh1VIAFMw6azNmraoawT7lpbC1+ipj
        KsS4DdpkfqHnoIXiWYIh2ZqaCMoSAzSTDynsTd+sh9Boax3avimOLzgOn/NA2UnOUANRIC2Natm0D
        WdzkKfQ4kQxuHi8WyDB13hlgjNbXzYTPe8ZG+2VdINBrC5tLUtgwwfmZ0K0Rv1n2liLKBDP64Tcot
        JfxdSzZQ==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2yj1-0000WZ-88; Wed, 28 Aug 2019 14:15:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     x86@kernel.org, joro@8bytes.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] x86/pci: Remove X86_DEV_DMA_OPS
Date:   Wed, 28 Aug 2019 16:14:43 +0200
Message-Id: <20190828141443.5253-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828141443.5253-1-hch@lst.de>
References: <20190828141443.5253-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are no users of X86_DEV_DMA_OPS left, so remove the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/Kconfig              |  3 ---
 arch/x86/include/asm/device.h | 10 ---------
 arch/x86/pci/common.c         | 38 -----------------------------------
 3 files changed, 51 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..35597dae38b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2905,9 +2905,6 @@ config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
 
-config X86_DEV_DMA_OPS
-	bool
-
 source "drivers/firmware/Kconfig"
 
 source "arch/x86/kvm/Kconfig"
diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index a8f6c809d9b1..3e6c75a6d070 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -11,16 +11,6 @@ struct dev_archdata {
 #endif
 };
 
-#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-struct dma_domain {
-	struct list_head node;
-	const struct dma_map_ops *dma_ops;
-	int domain_nr;
-};
-void add_dma_domain(struct dma_domain *domain);
-void del_dma_domain(struct dma_domain *domain);
-#endif
-
 struct pdev_archdata {
 };
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9acab6ac28f5..d2ac803b6c00 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -625,43 +625,6 @@ unsigned int pcibios_assign_all_busses(void)
 	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
 }
 
-#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-static LIST_HEAD(dma_domain_list);
-static DEFINE_SPINLOCK(dma_domain_list_lock);
-
-void add_dma_domain(struct dma_domain *domain)
-{
-	spin_lock(&dma_domain_list_lock);
-	list_add(&domain->node, &dma_domain_list);
-	spin_unlock(&dma_domain_list_lock);
-}
-EXPORT_SYMBOL_GPL(add_dma_domain);
-
-void del_dma_domain(struct dma_domain *domain)
-{
-	spin_lock(&dma_domain_list_lock);
-	list_del(&domain->node);
-	spin_unlock(&dma_domain_list_lock);
-}
-EXPORT_SYMBOL_GPL(del_dma_domain);
-
-static void set_dma_domain_ops(struct pci_dev *pdev)
-{
-	struct dma_domain *domain;
-
-	spin_lock(&dma_domain_list_lock);
-	list_for_each_entry(domain, &dma_domain_list, node) {
-		if (pci_domain_nr(pdev->bus) == domain->domain_nr) {
-			pdev->dev.dma_ops = domain->dma_ops;
-			break;
-		}
-	}
-	spin_unlock(&dma_domain_list_lock);
-}
-#else
-static void set_dma_domain_ops(struct pci_dev *pdev) {}
-#endif
-
 static void set_dev_domain_options(struct pci_dev *pdev)
 {
 	if (is_vmd(pdev->bus))
@@ -697,7 +660,6 @@ int pcibios_add_device(struct pci_dev *dev)
 		pa_data = data->next;
 		memunmap(data);
 	}
-	set_dma_domain_ops(dev);
 	set_dev_domain_options(dev);
 	return 0;
 }
-- 
2.20.1

