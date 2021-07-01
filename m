Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668453B9013
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhGAJ64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhGAJ64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 05:58:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD1C061756;
        Thu,  1 Jul 2021 02:56:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s13so244913plg.12;
        Thu, 01 Jul 2021 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGp58ukWUgFNLNhUEszoUgod+B2Y1jdAd3W7aV7VkJY=;
        b=P+LXl628SjFB1WBcCwQqlE8yK8NlzFZQiqyTYD+MCvEoLbY3EaT2185B0CHnG0mQFu
         ICeefTCt4X3H8na7ouxyOEpaPmGTSBM3pUSJYnoa63He45FQQ9tAEtwIGdHrWL+fAIrr
         +xuLhCKFSZf5Y/pI7TQNA6cBWbecqJtHFuEZ4b7FiBo55/q4FIa35L/emGvN2fpxj/NN
         atZQ+FxqAORG6KpEXORWH5PAwNLfU2Sct7oi23868vKyi/C6AYMMw1jdfGRqflys9o/k
         hyClQWdlKAsTiFWQuMxT0XCbBaDmBdEenbwq4ATrAcTmJFijcvbGUc81ZM3OWTUq9Ox9
         bHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGp58ukWUgFNLNhUEszoUgod+B2Y1jdAd3W7aV7VkJY=;
        b=OpmR2zOggRLEjahs98/KidW3mDjpClN3BTF2uFgax5nm3Y89lOrr/1nZeTiUD1cOli
         Xqk14B+5iqFn53WJjQbaWeNwqPs/hwVez8VruRrDQ1GcYhUYyA390/kH/oHGFu8kemEX
         y3UrgSd83jOfRRQenx6+Gn6bNW7sdJLPbJLUxXgfMz0G2T54LzG30pRonjFHAA/MHbUh
         blDWuy1GAezUyB2L0Jkty2DAH3qZdZ9cKsVQJDagW/RsxOA2BbG0ND8YnT2158krbD1v
         6MNEi6h2e850FY/hlGNHpF89Ef5duXrjbXJT7YH5n2ZtGwd7ypJCU6cDBHXUV14+0nuA
         rleA==
X-Gm-Message-State: AOAM532rHy1zhwCTQ0Aqpc7DVwcKLY2EIIFnU523/9gVncCWSNIl7Zjt
        bQl1pHxZx7SUihHHngNiskU=
X-Google-Smtp-Source: ABdhPJyK0CF8WcXv4dauRF8S/8oRWmloHOS5zUBljTdoBpJsYxZlCkjJ9/XnVHZVvBdfghHZhRM3Bw==
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr19098332pjq.148.1625133385610;
        Thu, 01 Jul 2021 02:56:25 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:76c6:e9cb:e399:2879])
        by smtp.gmail.com with ESMTPSA id cl14sm1842213pjb.40.2021.07.01.02.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:56:25 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: finish RCU conversion of pdev->p2pdma
Date:   Thu,  1 Jul 2021 02:56:21 -0700
Message-Id: <20210701095621.3129283-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

While looking at pci_alloc_p2pmem() I found rcu protection
was not properly applied there, as pdev->p2pdma was
potentially read multiple times.

I decided to fix pci_alloc_p2pmem(), add __rcu qualifier
to p2pdma field of struct pci_dev, and fix all
other accesses to this field with proper rcu verbs.

Fixes: 1570175abd16 ("PCI/P2PDMA: track pgmap references per resource, not globally")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/p2pdma.c | 101 ++++++++++++++++++++++++++++++-------------
 include/linux/pci.h  |   2 +-
 2 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1963826303631465da2956b0e3abcec3e0fcfbc4..89095aa5c674f5b8237d543c7af2bbdc2c176e5a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -48,10 +48,14 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_p2pdma *p2pdma;
 	size_t size = 0;
 
-	if (pdev->p2pdma->pool)
-		size = gen_pool_size(pdev->p2pdma->pool);
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (p2pdma && p2pdma->pool)
+		size = gen_pool_size(p2pdma->pool);
+	rcu_read_unlock();
 
 	return scnprintf(buf, PAGE_SIZE, "%zd\n", size);
 }
@@ -61,10 +65,14 @@ static ssize_t available_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_p2pdma *p2pdma;
 	size_t avail = 0;
 
-	if (pdev->p2pdma->pool)
-		avail = gen_pool_avail(pdev->p2pdma->pool);
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (p2pdma && p2pdma->pool)
+		avail = gen_pool_avail(p2pdma->pool);
+	rcu_read_unlock();
 
 	return scnprintf(buf, PAGE_SIZE, "%zd\n", avail);
 }
@@ -74,9 +82,16 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_p2pdma *p2pdma;
+	bool published = false;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (p2pdma)
+		published = p2pdma->p2pmem_published;
+	rcu_read_unlock();
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 pdev->p2pdma->p2pmem_published);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", published);
 }
 static DEVICE_ATTR_RO(published);
 
@@ -95,8 +110,9 @@ static const struct attribute_group p2pmem_group = {
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
-	struct pci_p2pdma *p2pdma = pdev->p2pdma;
+	struct pci_p2pdma *p2pdma;
 
+	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
 	if (!p2pdma)
 		return;
 
@@ -128,16 +144,14 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (error)
 		goto out_pool_destroy;
 
-	pdev->p2pdma = p2p;
-
 	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
 	if (error)
 		goto out_pool_destroy;
 
+	rcu_assign_pointer(pdev->p2pdma, p2p);
 	return 0;
 
 out_pool_destroy:
-	pdev->p2pdma = NULL;
 	gen_pool_destroy(p2p->pool);
 out:
 	devm_kfree(&pdev->dev, p2p);
@@ -159,6 +173,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct dev_pagemap *pgmap;
+	struct pci_p2pdma *p2pdma;
 	void *addr;
 	int error;
 
@@ -200,7 +215,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		goto pgmap_free;
 	}
 
-	error = gen_pool_add_owner(pdev->p2pdma->pool, (unsigned long)addr,
+	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
+	error = gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
 			range_len(&pgmap->range), dev_to_node(&pdev->dev),
 			pgmap->ref);
@@ -476,6 +492,7 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
 	enum pci_p2pdma_map_type map_type;
+	struct pci_p2pdma *p2pdma;
 
 	map_type = __upstream_bridge_distance(provider, client, dist,
 					      acs_redirects, acs_list);
@@ -486,10 +503,12 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-	if (provider->p2pdma)
-		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
-			 xa_mk_value(map_type), GFP_KERNEL);
-
+	rcu_read_lock();
+	p2pdma = rcu_dereference(provider->p2pdma);
+	if (p2pdma)
+		xa_store(&p2pdma->map_types, map_types_idx(client),
+			 xa_mk_value(map_type), GFP_ATOMIC);
+	rcu_read_unlock();
 	return map_type;
 }
 
@@ -595,7 +614,15 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_distance_many);
  */
 bool pci_has_p2pmem(struct pci_dev *pdev)
 {
-	return pdev->p2pdma && pdev->p2pdma->p2pmem_published;
+	struct pci_p2pdma *p2pdma;
+	bool res;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	res = p2pdma && p2pdma->p2pmem_published;
+	rcu_read_unlock();
+
+	return res;
 }
 EXPORT_SYMBOL_GPL(pci_has_p2pmem);
 
@@ -675,6 +702,7 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 {
 	void *ret = NULL;
 	struct percpu_ref *ref;
+	struct pci_p2pdma *p2pdma;
 
 	/*
 	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
@@ -682,16 +710,17 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 	 * read-lock.
 	 */
 	rcu_read_lock();
-	if (unlikely(!pdev->p2pdma))
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (unlikely(!p2pdma))
 		goto out;
 
-	ret = (void *)gen_pool_alloc_owner(pdev->p2pdma->pool, size,
+	ret = (void *)gen_pool_alloc_owner(p2pdma->pool, size,
 			(void **) &ref);
 	if (!ret)
 		goto out;
 
 	if (unlikely(!percpu_ref_tryget_live(ref))) {
-		gen_pool_free(pdev->p2pdma->pool, (unsigned long) ret, size);
+		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
 		ret = NULL;
 		goto out;
 	}
@@ -710,9 +739,9 @@ EXPORT_SYMBOL_GPL(pci_alloc_p2pmem);
 void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
 {
 	struct percpu_ref *ref;
+	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
 
-	gen_pool_free_owner(pdev->p2pdma->pool, (uintptr_t)addr, size,
-			(void **) &ref);
+	gen_pool_free_owner(p2pdma->pool, (uintptr_t)addr, size, (void **) &ref);
 	percpu_ref_put(ref);
 }
 EXPORT_SYMBOL_GPL(pci_free_p2pmem);
@@ -725,9 +754,12 @@ EXPORT_SYMBOL_GPL(pci_free_p2pmem);
  */
 pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr)
 {
+	struct pci_p2pdma *p2pdma;
+
 	if (!addr)
 		return 0;
-	if (!pdev->p2pdma)
+	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
+	if (!p2pdma)
 		return 0;
 
 	/*
@@ -735,7 +767,7 @@ pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr)
 	 * bus address as the physical address. So gen_pool_virt_to_phys()
 	 * actually returns the bus address despite the misleading name.
 	 */
-	return gen_pool_virt_to_phys(pdev->p2pdma->pool, (unsigned long)addr);
+	return gen_pool_virt_to_phys(p2pdma->pool, (unsigned long)addr);
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_virt_to_bus);
 
@@ -806,19 +838,30 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
  */
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
-	if (pdev->p2pdma)
-		pdev->p2pdma->p2pmem_published = publish;
+	struct pci_p2pdma *p2pdma;
+
+	rcu_read_lock();
+	p2pdma = rcu_dereference(pdev->p2pdma);
+	if (p2pdma)
+		p2pdma->p2pmem_published = publish;
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
 static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
 						    struct pci_dev *client)
 {
-	if (!provider->p2pdma)
-		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	enum pci_p2pdma_map_type type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	struct pci_p2pdma *p2pdma;
 
-	return xa_to_value(xa_load(&provider->p2pdma->map_types,
-				   map_types_idx(client)));
+	rcu_read_lock();
+	p2pdma = rcu_dereference(provider->p2pdma);
+
+	if (p2pdma)
+		type = xa_to_value(xa_load(&p2pdma->map_types,
+					   map_types_idx(client)));
+	rcu_read_unlock();
+	return type;
 }
 
 static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 24306504226ab665be7323549d0759da1b7ac715..6abdebe2aeb1676da08f03e05e5ecb26f0b08cd6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -497,7 +497,7 @@ struct pci_dev {
 	u16		pasid_features;
 #endif
 #ifdef CONFIG_PCI_P2PDMA
-	struct pci_p2pdma *p2pdma;
+	struct pci_p2pdma __rcu *p2pdma;
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
-- 
2.32.0.93.g670b81a890-goog

