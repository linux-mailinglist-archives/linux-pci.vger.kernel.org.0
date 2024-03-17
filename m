Return-Path: <linux-pci+bounces-4861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC887DC63
	for <lists+linux-pci@lfdr.de>; Sun, 17 Mar 2024 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6A1C2093D
	for <lists+linux-pci@lfdr.de>; Sun, 17 Mar 2024 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2B79E5;
	Sun, 17 Mar 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLOnx9Qv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48A7484
	for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710655774; cv=none; b=cFzSTT6PvqQHk1X0C0AyhvYGnB0YK8wRJhusUZqjPSWhdLZcdjX9kZOnR809nU1Cp8Rkf80ydGO3AnCe1jg4YkJZAtrYShrojXiDV7oFqAyjHQzjAczSo4hhOwXALMgtAPXlZrRn9eXs4YoyRGhICDglI2Y4C2d6YCJWaO/HvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710655774; c=relaxed/simple;
	bh=yK34zrA/WJggvtJfYCVzPTkGmWC8n6raCQ+cro+YR5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XJHqzw3zKuKSmrmAv63P0tMfJt6+ZEzNEzDn8BJd1byF7qOc+Z87anGxGKQ6GnQys9wCG2PNbyA8sxxKVoPX+bws9FqXI6pUP+4ow9JPyaZtropS7l1SdYe8XGO43qc8OPgwbam2URyDrfhvqeuLdsF5oaXA5xwQmHp556tvr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLOnx9Qv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso2825229b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 16 Mar 2024 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710655771; x=1711260571; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azX2qXyX3bctQx0gbKYp0MYglRBytL/R8kGklVmW2kU=;
        b=pLOnx9QvSBQPbAoBVZ8B51Dbi/kn9xzi6GYWxiJGV3Yqc5GPfWpOqgZLV+3TSpUQto
         9PRA96k2xT3bP8cX54lIaAah5yQOzX/MHoNkRVxrhpOWptq/yo57trIrGZxh/+pJqojl
         QVBJbP7BsaAgnwJPl/SDDrf8vN/U+tTBtu9GGeS/1a3XFyRqx584Gsbkskisx4X3JMvf
         WyQ/3Hd+igzCLhCKzBB6IVVLAdP3HM1rvmwaeHwChJnFTFxvgm3LIH+rGTU+BAQJInYv
         Ju2MwEhStw7UjhsSJplYAgwXYxFP1gOtMywLTdSURWmUdinc6tn1/wf1vPO3i+JBnlVj
         eiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710655771; x=1711260571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azX2qXyX3bctQx0gbKYp0MYglRBytL/R8kGklVmW2kU=;
        b=fmivOH1jdrO7p6AzinRJEN7Aa+6zVyxYKHr0VSA4r7mQnq4dcPi3eQJMQ4w0OwXiiA
         5MNH6a+2UMmAFpQR985abmS2JfnP4wjVOq6v6OID30pO8g0i4BLg6UoTQ2hDboTO617n
         AwnZX52luMgmSHXoa0WutlIJTOq09SNps2iO/0XTfEGU6SKa19mZLAPLTgucKH8wUEYR
         uJ7JqzFSCKDXOIvll80y1D3lK7WH4JrArhZhaNZAEeSgyv+O5fKzldL7TxEwy9FJZ6pq
         wrge7hxZ2eDQzKTkd4oIKWaYBRZgJSsormglAxFpsSExFBlfXB1pRj/IQy54D3xVhOAM
         X7uQ==
X-Gm-Message-State: AOJu0YzMZ6wrmhB7U/sI9U8O3z+4C45pzOnqI2Cmf4VuwZ3IapRRkUyB
	kOjXn+O4/1KUUv/OsKgHY/xWDeXS4VQOPdxt00UbjdbpqQwxk31OEnsa4Xetag==
X-Google-Smtp-Source: AGHT+IERQPvkqGVllorynHD0K4qYEazSf0TUlMFbOK5rAiNINE8kvCC9uafioe0wim7z6IlGXggSmg==
X-Received: by 2002:a17:902:da89:b0:1dc:cd2e:fc68 with SMTP id j9-20020a170902da8900b001dccd2efc68mr9212062plx.27.1710655771342;
        Sat, 16 Mar 2024 23:09:31 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:aa:9a0c:d51b:1655:f9a7:7b1])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001dcad9cbf8bsm6687147plv.239.2024.03.16.23.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 23:09:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Sun, 17 Mar 2024 11:39:17 +0530
Subject: [PATCH] PCI: endpoint: Migrate to Genalloc framework for outbound
 window memory allocation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAyJ9mUC/x3MSwqAIBRG4a3EHXche9BjK9FA7LcuhIpCBNLek
 4bf4JxMCVGQaKkyRdySxLsCVVdkTu0OsOzF1DZt33Rq5GCEEfiA09flDVs9zXZAP43oqFQhwsr
 zH9ftfT8XBCfOYQAAAA==
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=14617;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=yK34zrA/WJggvtJfYCVzPTkGmWC8n6raCQ+cro+YR5Y=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl9okXoeUBESmnVyIPD9QtZZ4gxacmfIIEe/+qd
 PF+weeW5OGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfaJFwAKCRBVnxHm/pHO
 9e1fB/4448XkxB6sF0Kx1lvBghr3aUhbIxKpFf2WcXDrkm24+IM5GLrrS/en1Lz6Z3RMEEYtBAt
 TXAi5q8yCRP1ToyDYglqFn5JNjrx8lABJbnGtL7ppn5fpJWZsjYOtlQc9EhxcEYHx8cT94GSXwJ
 0Zq9LOL2vdK/c9t4G6OnWdgj9ozabO8w3v0YTUmiP5fxJZPx+lgnVLSu44wPdTm8Z3zf3t+qzax
 sr5FnByaYfoqrVqVsV/TiR3t+lJQx/Nrhv7zZRhP7VO6vrgZ66urwiLC5T4FEz1X/qPYyxemioB
 nm4ttiHAE3p5/VM125ztxyNtEUmLYORIqvzO9ksB5Vt1TEE/
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As proposed during the last year 'PCI Endpoint Subsystem Open Items
Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
framework for managing the endpoint outbound window memory allocation.

PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
driver from the start for managing the memory required to map the host
address space (outbound) in endpoint. Even though it works well, it
completely defeats the purpose of the 'Genalloc framework', a general
purpose memory allocator framework created to avoid various custom memory
allocators in the kernel.

The migration to Genalloc framework is done is such a way that the existing
API semantics are preserved. So that the callers of the EPC mem APIs do not
need any modification (apart from the pcie-designware-epc driver that
queries page size).

Internally, the EPC mem driver now uses Genalloc framework's
'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
based on the requested size as like the previous allocator. And the
page size passed during pci_epc_mem_init() API is used as the minimum order
for the memory allocations.

During the migration, 'struct pci_epc_mem' is removed as it is seems
redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
is now used to hold the address windows of the endpoint controller.

[1] https://lpc.events/event/17/contributions/1419/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
 drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
 include/linux/pci-epc.h                         |  25 +---
 3 files changed, 81 insertions(+), 140 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..37c612282eb6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	}
-	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
+	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
 	msg_addr = ((u64)msg_addr_upper) << 32 |
 			(msg_addr_lower & ~aligned_offset);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  epc->mem->window.page_size);
+				  epc->windows[0]->page_size);
 	if (ret)
 		return ret;
 
@@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return -EPERM;
 	}
 
-	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
 	msg_addr &= ~aligned_offset;
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  epc->mem->window.page_size);
+				  epc->windows[0]->page_size);
 	if (ret)
 		return ret;
 
@@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 	dw_pcie_edma_remove(pci);
 
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
-			      epc->mem->window.page_size);
+			      epc->windows[0]->page_size);
 
 	pci_epc_mem_exit(epc);
 
@@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	}
 
 	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
-					     epc->mem->window.page_size);
+					     epc->windows[0]->page_size);
 	if (!ep->msi_mem) {
 		ret = -ENOMEM;
 		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
@@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 err_free_epc_mem:
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
-			      epc->mem->window.page_size);
+			      epc->windows[0]->page_size);
 
 err_exit_epc_mem:
 	pci_epc_mem_exit(epc);
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a9c028f58da1..f9e6e1a6aeaa 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -4,37 +4,18 @@
  *
  * Copyright (C) 2017 Texas Instruments
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * Copyright (C) 2024 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <linux/genalloc.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
 #include <linux/pci-epc.h>
 
-/**
- * pci_epc_mem_get_order() - determine the allocation order of a memory size
- * @mem: address space of the endpoint controller
- * @size: the size for which to get the order
- *
- * Reimplement get_order() for mem->page_size since the generic get_order
- * always gets order with a constant PAGE_SIZE.
- */
-static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
-{
-	int order;
-	unsigned int page_shift = ilog2(mem->window.page_size);
-
-	size--;
-	size >>= page_shift;
-#if BITS_PER_LONG == 32
-	order = fls(size);
-#else
-	order = fls64(size);
-#endif
-	return order;
-}
-
 /**
  * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
  * @epc: the EPC device that invoked pci_epc_mem_init
@@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 			   struct pci_epc_mem_window *windows,
 			   unsigned int num_windows)
 {
-	struct pci_epc_mem *mem = NULL;
-	unsigned long *bitmap = NULL;
-	unsigned int page_shift;
+	struct pci_epc_mem_window *window = NULL;
 	size_t page_size;
-	int bitmap_size;
-	int pages;
 	int ret;
 	int i;
 
-	epc->num_windows = 0;
-
 	if (!windows || !num_windows)
 		return -EINVAL;
 
@@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
 		page_size = windows[i].page_size;
 		if (page_size < PAGE_SIZE)
 			page_size = PAGE_SIZE;
-		page_shift = ilog2(page_size);
-		pages = windows[i].size >> page_shift;
-		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 
-		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
-		if (!mem) {
+		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
+		if (!windows[i].pool) {
 			ret = -ENOMEM;
-			i--;
-			goto err_mem;
+			goto err_free_mem;
+		}
+
+		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
+				  NULL);
+
+		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
+		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
+					windows[i].phys_base, windows[i].size, -1);
+		if (ret) {
+			iounmap(windows[i].virt_base);
+			gen_pool_destroy(epc->windows[i]->pool);
+			goto err_free_mem;
 		}
 
-		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-		if (!bitmap) {
+		window = kzalloc(sizeof(*window), GFP_KERNEL);
+		if (!window) {
 			ret = -ENOMEM;
-			kfree(mem);
-			i--;
-			goto err_mem;
+			iounmap(windows[i].virt_base);
+			gen_pool_destroy(epc->windows[i]->pool);
+			goto err_free_mem;
 		}
 
-		mem->window.phys_base = windows[i].phys_base;
-		mem->window.size = windows[i].size;
-		mem->window.page_size = page_size;
-		mem->bitmap = bitmap;
-		mem->pages = pages;
-		mutex_init(&mem->lock);
-		epc->windows[i] = mem;
+		window->phys_base = windows[i].phys_base;
+		window->size = windows[i].size;
+		window->page_size = page_size;
+		window->pool = windows[i].pool;
+		epc->windows[i] = window;
 	}
 
-	epc->mem = epc->windows[0];
 	epc->num_windows = num_windows;
 
 	return 0;
 
-err_mem:
-	for (; i >= 0; i--) {
-		mem = epc->windows[i];
-		kfree(mem->bitmap);
-		kfree(mem);
+err_free_mem:
+	for (--i; i >= 0; i--) {
+		iounmap(windows[i].virt_base);
+		gen_pool_destroy(epc->windows[i]->pool);
+		kfree(epc->windows[i]);
 	}
+
 	kfree(epc->windows);
 
 	return ret;
@@ -128,14 +109,15 @@ EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size)
 {
-	struct pci_epc_mem_window mem_window;
+	struct pci_epc_mem_window window;
 
-	mem_window.phys_base = base;
-	mem_window.size = size;
-	mem_window.page_size = page_size;
+	window.phys_base = base;
+	window.size = size;
+	window.page_size = page_size;
 
-	return pci_epc_multi_mem_init(epc, &mem_window, 1);
+	return pci_epc_multi_mem_init(epc, &window, 1);
 }
+
 EXPORT_SYMBOL_GPL(pci_epc_mem_init);
 
 /**
@@ -147,21 +129,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
  */
 void pci_epc_mem_exit(struct pci_epc *epc)
 {
-	struct pci_epc_mem *mem;
 	int i;
 
 	if (!epc->num_windows)
 		return;
 
 	for (i = 0; i < epc->num_windows; i++) {
-		mem = epc->windows[i];
-		kfree(mem->bitmap);
-		kfree(mem);
+		iounmap(epc->windows[i]->virt_base);
+		gen_pool_destroy(epc->windows[i]->pool);
+		kfree(epc->windows[i]);
 	}
+
 	kfree(epc->windows);
 
 	epc->windows = NULL;
-	epc->mem = NULL;
 	epc->num_windows = 0;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
@@ -178,55 +159,42 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
 void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size)
 {
+	struct pci_epc_mem_window *window;
 	void __iomem *virt_addr = NULL;
-	struct pci_epc_mem *mem;
-	unsigned int page_shift;
+	struct gen_pool *genpool;
 	size_t align_size;
-	int pageno;
-	int order;
 	int i;
 
 	for (i = 0; i < epc->num_windows; i++) {
-		mem = epc->windows[i];
-		mutex_lock(&mem->lock);
-		align_size = ALIGN(size, mem->window.page_size);
-		order = pci_epc_mem_get_order(mem, align_size);
-
-		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
-						 order);
-		if (pageno >= 0) {
-			page_shift = ilog2(mem->window.page_size);
-			*phys_addr = mem->window.phys_base +
-				((phys_addr_t)pageno << page_shift);
-			virt_addr = ioremap(*phys_addr, align_size);
-			if (!virt_addr) {
-				bitmap_release_region(mem->bitmap,
-						      pageno, order);
-				mutex_unlock(&mem->lock);
-				continue;
-			}
-			mutex_unlock(&mem->lock);
-			return virt_addr;
-		}
-		mutex_unlock(&mem->lock);
+		window = epc->windows[i];
+		genpool = window->pool;
+		align_size = ALIGN(size, window->page_size);
+
+		virt_addr = (void __iomem *)gen_pool_alloc(genpool, align_size);
+		if (!virt_addr)
+			continue;
+
+		*phys_addr = gen_pool_virt_to_phys(genpool, (unsigned long)virt_addr);
+
+		break;
 	}
 
 	return virt_addr;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
 
-static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
+static struct pci_epc_mem_window *pci_epc_get_matching_window(struct pci_epc *epc,
 						       phys_addr_t phys_addr)
 {
-	struct pci_epc_mem *mem;
+	struct pci_epc_mem_window *window;
 	int i;
 
 	for (i = 0; i < epc->num_windows; i++) {
-		mem = epc->windows[i];
+		window = epc->windows[i];
 
-		if (phys_addr >= mem->window.phys_base &&
-		    phys_addr < (mem->window.phys_base + mem->window.size))
-			return mem;
+		if (phys_addr >= window->phys_base &&
+		    phys_addr < (window->phys_base + window->size))
+			return window;
 	}
 
 	return NULL;
@@ -244,27 +212,15 @@ static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size)
 {
-	struct pci_epc_mem *mem;
-	unsigned int page_shift;
-	size_t page_size;
-	int pageno;
-	int order;
+	struct pci_epc_mem_window *window;
 
-	mem = pci_epc_get_matching_window(epc, phys_addr);
-	if (!mem) {
+	window = pci_epc_get_matching_window(epc, phys_addr);
+	if (!window) {
 		pr_err("failed to get matching window\n");
 		return;
 	}
 
-	page_size = mem->window.page_size;
-	page_shift = ilog2(page_size);
-	iounmap(virt_addr);
-	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
-	size = ALIGN(size, page_size);
-	order = pci_epc_mem_get_order(mem, size);
-	mutex_lock(&mem->lock);
-	bitmap_release_region(mem->bitmap, pageno, order);
-	mutex_unlock(&mem->lock);
+	gen_pool_free(window->pool, (unsigned long)virt_addr, size);
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 40ea18f5aa02..37ea96ed3432 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -87,30 +87,19 @@ struct pci_epc_ops {
 /**
  * struct pci_epc_mem_window - address window of the endpoint controller
  * @phys_base: physical base address of the PCI address window
+ * @virt_base: virtual base address of the PCI address window
+ * @pool: memory pool descriptor
  * @size: the size of the PCI address window
  * @page_size: size of each page
  */
 struct pci_epc_mem_window {
 	phys_addr_t	phys_base;
+	void __iomem	*virt_base;
+	struct gen_pool *pool;
 	size_t		size;
 	size_t		page_size;
 };
 
-/**
- * struct pci_epc_mem - address space of the endpoint controller
- * @window: address window of the endpoint controller
- * @bitmap: bitmap to manage the PCI address space
- * @pages: number of bits representing the address region
- * @lock: mutex to protect bitmap
- */
-struct pci_epc_mem {
-	struct pci_epc_mem_window window;
-	unsigned long	*bitmap;
-	int		pages;
-	/* mutex to protect against concurrent access for memory allocation*/
-	struct mutex	lock;
-};
-
 /**
  * struct pci_epc - represents the PCI EPC device
  * @dev: PCI EPC device
@@ -118,9 +107,6 @@ struct pci_epc_mem {
  * @list_lock: Mutex for protecting pci_epf list
  * @ops: function pointers for performing endpoint operations
  * @windows: array of address space of the endpoint controller
- * @mem: first window of the endpoint controller, which corresponds to
- *       default address space of the endpoint controller supporting
- *       single window.
  * @num_windows: number of windows supported by device
  * @max_functions: max number of functions that can be configured in this EPC
  * @max_vfs: Array indicating the maximum number of virtual functions that can
@@ -134,8 +120,7 @@ struct pci_epc {
 	struct list_head		pci_epf;
 	struct mutex			list_lock;
 	const struct pci_epc_ops	*ops;
-	struct pci_epc_mem		**windows;
-	struct pci_epc_mem		*mem;
+	struct pci_epc_mem_window	**windows;
 	unsigned int			num_windows;
 	u8				max_functions;
 	u8				*max_vfs;

---
base-commit: 256833a66670ff28b7c1bddbd17973619e5281fd
change-id: 20240317-pci-ep-genalloc-fa89f5e487e3

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


