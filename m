Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE49A0487
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfH1OPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 10:15:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfH1OO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UNjIsinlE8oqmYbJQIBJBGpyXDrDsScP7b7RPAv/kKo=; b=tVTEMnR6Tawd9xPItwcMznNdoQ
        X1NerjCg6JvnvZf7533qsVt7aY1aTCGMgGKKghHrdNqssZoJxTVOL6jHKE1mcz8EKhMJykYxqYvSS
        CDRc/f+tCAk8MLGnNsiJ/IBvados3y1TFHuKyyplAqexJWvvl5IaSAX5ht7R1Nlxx8oO49k9QLFiA
        Ff0y8jD1a0zgugBp2GBZldMcmEOAWOllb+D7Uanl6KDNIiKvKZEgCXt9eTlgyXrRDoJxOmt39ZLfk
        AU2hVLdlna1LnE73c9GncpIHICs4zPi35W7h5ySnphUhOlCJfrz48Qe2nVwXrYirRBkS3pwMacF33
        uVsssEmw==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2yis-0000Tf-Hu; Wed, 28 Aug 2019 14:14:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     x86@kernel.org, joro@8bytes.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] x86/pci: Add a to_pci_sysdata helper
Date:   Wed, 28 Aug 2019 16:14:40 +0200
Message-Id: <20190828141443.5253-3-hch@lst.de>
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

Various helpers need the pci_sysdata just to dereference a single field
in it.  Add a little helper that returns the properly typed sysdata
pointer to require a little less boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 6fa846920f5f..75fe28492290 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -35,12 +35,15 @@ extern int noioapicreroute;
 
 #ifdef CONFIG_PCI
 
+static inline struct pci_sysdata *to_pci_sysdata(struct pci_bus *bus)
+{
+	return bus->sysdata;
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->domain;
+	return to_pci_sysdata(bus)->domain;
 }
 
 static inline int pci_proc_domain(struct pci_bus *bus)
@@ -52,23 +55,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 {
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->fwnode;
+	return to_pci_sysdata(bus)->fwnode;
 }
 
 #define pci_root_bus_fwnode	_pci_root_bus_fwnode
 #endif
 
+#if IS_ENABLED(CONFIG_VMD)
 static inline bool is_vmd(struct pci_bus *bus)
 {
-#if IS_ENABLED(CONFIG_VMD)
-	struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->vmd_domain;
+	return to_pci_sysdata(bus)->vmd_domain;
+}
 #else
-	return false;
-#endif
+#define is_vmd(bus)		false
+#endif /* CONFIG_VMD */
 }
 
 /* Can be used to override the logic in pci_scan_bus for skipping
@@ -128,9 +128,7 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 /* Returns the node based on pci bus */
 static inline int __pcibus_to_node(const struct pci_bus *bus)
 {
-	const struct pci_sysdata *sd = bus->sysdata;
-
-	return sd->node;
+	return to_pci_sysdata(bus)->node;
 }
 
 static inline const struct cpumask *
-- 
2.20.1

