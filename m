Return-Path: <linux-pci+bounces-13904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34826992352
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B471C21B2B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8774430;
	Mon,  7 Oct 2024 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+nd7Q76"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978243C2F
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273807; cv=none; b=UoOmDjJUgmYyHjQ6bBcYN7hKLq7wWSQF7MflU3owknBslKH65oSoDAKtikUy4yqKBBhPLR44/AQBZg1L5S31L3kumObyBBnI1ZVzr+YiRkD7F1DJv8++8iJsSw7VUQzj1PkX814VapN1C4P2SbeVb9uWYQxR/k/MONF3/L4TU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273807; c=relaxed/simple;
	bh=qoR8yo6M7hX1O5vreks+sMkUAhiVyWxm12I+3OEZ1HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1okHrHqft0CF2dU/V8Mcb1Otmc26xeGqq+pmaYNZobTvAho/MTvw6glHoTdmH/3Eijv8H6a5cZCdloDpJI67H/eoA3n0gI6nuasYHX8wlbfqv8b80hhdcUJ48IYC5F9O/47wI8YD39Auo9XJsler03e9th6L1Fvdku6MhkEgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+nd7Q76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C27C4CED3;
	Mon,  7 Oct 2024 04:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273807;
	bh=qoR8yo6M7hX1O5vreks+sMkUAhiVyWxm12I+3OEZ1HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+nd7Q76HNzg3A0hxUHnPpXrgWO5xDA7JccinSWZ0e/phQUtxDBFdm5KDci/xym+t
	 FFelk5cs/+aPyNN0PZW+PeHJY172L21NMg0KFBhwTHDmGvvharzfBfzQVL2zh2afPW
	 nWnWqgAgRG/zb6gAHmFj2onZE6gaP2JPqXaCIKCZ76gI68gp2bHUQrgzIQo+GJnmv3
	 qW2BKqtfM6cROoieSYw47Vi9GIvCN7W1w3XdT75LG5di1ig2U2g3GlM6KuaDq2Ka5y
	 IbiX0N8hyo4luAUViEiKY7DyMxbu2KdH90oi2CrrnloRHGIlcpLEwsAs9ztWET0rL9
	 7ixzAvtjGsJwA==
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
Subject: [PATCH v4 2/7] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Date: Mon,  7 Oct 2024 13:03:14 +0900
Message-ID: <20241007040319.157412-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007040319.157412-1-dlemoal@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
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


