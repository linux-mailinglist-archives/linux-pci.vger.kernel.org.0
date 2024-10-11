Return-Path: <linux-pci+bounces-14285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3399A323
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CAAB2362F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C44215F55;
	Fri, 11 Oct 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKPLMqeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63420B21A
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648084; cv=none; b=bdZXAoJl2UOb8aaIEXMtX2KdmFq+CR20Plvi8RjUVJfmQiCBnujxWrNm/ko/kTKOdNYWy2knNLxv0Qq14XdrDoN7TP9pL82b2+AsSB7m+7WejllC2hMdPd9FTiW6di4LjhKudkXNiwP3uLWjXDG01J90p7WWb6HVkGLi+OHj+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648084; c=relaxed/simple;
	bh=2pIMqO+1BPUWENwocGsBk0ugzEQ8nFRlLXw5YWuO6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUuFkEhjCCL+79yN9sf9lXOgHD1akZUVqNw4KfK1ruJTIRKeDlY7G2r/Js+ET77K9VALdEPI2vRSToFUlB7ElBo5WDpkyRpsXM8CLI7rBgyMuixuYtKw8VZOxcUpXtih/ES/lBBxSCS4zHJFlZVbGcDa+ZapUuyd6uif5Hi8YVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKPLMqeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D495C4CED2;
	Fri, 11 Oct 2024 12:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648083;
	bh=2pIMqO+1BPUWENwocGsBk0ugzEQ8nFRlLXw5YWuO6nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKPLMqeYFiApLkrmb9S3U2PK0PF9AeYvsNcMV4drjv0jVLtf3tbMmymJbSWnm/aVn
	 eEp2TR37X6Wk9CB2GbJWBcx8TJ26xJ2o8GCOXa7UeSVa2mrGtDwpe0dmNMQua52Te+
	 5UxCIk+/JCTDSgs6TgnmNlphj2RFK/trzBoQI8NoOCV5F3se2NLyG0bXypc844ojS0
	 +L5v9EgU3P1tFCF8iAmg/pTKrQ8Wl1YQpTv5KqbVzGFNDyIebBdZElF3EZBIzPkfr/
	 QyuXwJ70R+3E0dv0frKoG1sokF2wchiRZ578jZ05CHn6aj15jG23rELx2vQ3WPEbDd
	 q69I4XRP6BzRg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 2/6] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Date: Fri, 11 Oct 2024 21:01:11 +0900
Message-ID: <20241011120115.89756-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011120115.89756-1-dlemoal@kernel.org>
References: <20241011120115.89756-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in attempting to allocate memory from an endpoint
controller memory window if the requested size is larger than the memory
window size. Add a check to skip bitmap_find_free_region() calls for
such case. This check can be done without the mem->lock mutex held as
memory window sizes are constant and never modified at runtime.
Also change the final return to return NULL to simplify the code.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-mem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a9c028f58da1..218a60e945db 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -178,7 +178,7 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
 void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size)
 {
-	void __iomem *virt_addr = NULL;
+	void __iomem *virt_addr;
 	struct pci_epc_mem *mem;
 	unsigned int page_shift;
 	size_t align_size;
@@ -188,10 +188,13 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 
 	for (i = 0; i < epc->num_windows; i++) {
 		mem = epc->windows[i];
-		mutex_lock(&mem->lock);
+		if (size > mem->window.size)
+			continue;
+
 		align_size = ALIGN(size, mem->window.page_size);
 		order = pci_epc_mem_get_order(mem, align_size);
 
+		mutex_lock(&mem->lock);
 		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
 						 order);
 		if (pageno >= 0) {
@@ -211,7 +214,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 		mutex_unlock(&mem->lock);
 	}
 
-	return virt_addr;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
 
-- 
2.47.0


