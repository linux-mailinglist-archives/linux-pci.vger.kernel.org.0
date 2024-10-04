Return-Path: <linux-pci+bounces-13797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1046F98FCE4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66593283B41
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BD5FBB1;
	Fri,  4 Oct 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnhVCia+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710528F3
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018467; cv=none; b=QIHtLM/rWKf5qiL02Z7lru6PeSSzQU7nWPr6fd1pZh3UAfhp74y9g0fTy9rfQAVOJFOk+jWVsPAtKTWhTaSo/gb/BK2osOdWrc46E3vtCtjwVQMckZ2+cdwK0qANs9/zUEjUnvXPEZJI5TaYeZAXagRdiqYe0c0gK3ix891wvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018467; c=relaxed/simple;
	bh=OEJNUJ+A1DCBBOwnLmpeP8AJh0oB7xPkq284SDdeLs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf7PrrjLcNfI/Eex/N9v445gWSe1Ihe8dFYBTJg5pqdF2c0bPGx5UAv/YzdvSjlNeXcvWEcaqWejzLJucRGkUdCX1ffM1NUVx46UKbUiPwnM8aMJmpnkmRRlPBURm+AUD/u452QM2x3A3YWsaFYSFhGYFnTPn1kYIbMi/ShJxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnhVCia+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A33EC4CECD;
	Fri,  4 Oct 2024 05:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018467;
	bh=OEJNUJ+A1DCBBOwnLmpeP8AJh0oB7xPkq284SDdeLs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnhVCia+BLT9nmoo1mf5SfKX0+u/o1UhJqCctZEvzty2PgpCPtt/myeYRsLdM2Qul
	 ouBgpKsoi40C1ayi6RCoG+Z3OyqIyOy3X4VkPR9GXEjJDixXqLcnMYtIdA4mu0VNjL
	 SniUkgrLO3Q9ufMFgnqAh0iZmRQqurbO8xeKOoWvpoiaKCV08sy2i/kfoJzTe9d2PF
	 46smVlKhIz63tJK9tCZBM2UOCCosoGE4rDLjhELyKjWZiXIfmwFG/K2wRYYdLhqtyn
	 z3mHlFbwfADr9zIbGBBfYlUw0fI9Adsh54UnEehiHkMQXTxmHSscFGb2pe+zJWauAW
	 RekYL7GZLiJ+Q==
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
Subject: [PATCH v3 2/7] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Date: Fri,  4 Oct 2024 14:07:37 +0900
Message-ID: <20241004050742.140664-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004050742.140664-1-dlemoal@kernel.org>
References: <20241004050742.140664-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in attempting to allocate memory from an endpoint
controller memory window if the requested size is larger than the window
size. Add a check to skip bitmap_find_free_region() calls for such case.
Also change the final return to return NULL to simplify the code.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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
2.46.2


