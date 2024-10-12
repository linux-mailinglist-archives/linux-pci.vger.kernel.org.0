Return-Path: <linux-pci+bounces-14385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBF99B483
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E141C20CA6
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78C1891B8;
	Sat, 12 Oct 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhJwBepZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBE156C69
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732772; cv=none; b=iY08WFubd4kysLZqZmni5TjPu9r3C6yiU3/MZSfhHdIc6ZQ/JWjWUtuiWVzn4XVz7eufyogUPVdY4Y50fXpvV9DGNf3aUJ6J9Y3/82nskZUnxs12+0pXVNS/gBWDD0pKb5kJv/E2/uOSr/qwKMGEkdncxjiocHfGR3G+p9HxkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732772; c=relaxed/simple;
	bh=2pIMqO+1BPUWENwocGsBk0ugzEQ8nFRlLXw5YWuO6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La+e6tPn91VQoVCM2ZoRev5dMVGy7i/WWxHwVk04GblyzeNDXW+boTgMeiHU+EtuxssmpJYsZ4vSmPBoZpOeMDivAJ2pduSw44pZiSeHqsi79i5Vf4ilIpBAvxI7lwdXCkVfzXKqmqW27JRKhIxCgMLmHIAA9RoQR2wZ09p7bP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhJwBepZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A40C4CEC7;
	Sat, 12 Oct 2024 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732772;
	bh=2pIMqO+1BPUWENwocGsBk0ugzEQ8nFRlLXw5YWuO6nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhJwBepZDyOJ+d4DiN24TD9uL59UbKONKOLhqDwuxk/Bah0NpdVYlWeBYbwE9bCEm
	 p8GJdq819dtN65eo1hO+CJoZf53M+wyRkbgiGUSoy36lshLD7IljKrrEP1ZC+hloDs
	 YmdHfq0zX5YmCbzF2wfybUXdppzTrgvF+v4nWYeo4Pb8LYD+FpMn09HIrmGHO4Vjib
	 kPzXa9z8Tl9vAgZZrnV2CVMmlT+oPBXQwWk4i6EB+HmcA3nx7Z7N/F++NIZgWGwgN8
	 DQYkdcAGNcOFdatEO4uIRzNLwU7bOLvj5ePecXVLs6UEMv62yOQYZoqWmcFaMs6l38
	 TZ+3/d+RMlXHQ==
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
Subject: [PATCH v6 2/6] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Date: Sat, 12 Oct 2024 20:32:42 +0900
Message-ID: <20241012113246.95634-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241012113246.95634-1-dlemoal@kernel.org>
References: <20241012113246.95634-1-dlemoal@kernel.org>
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


