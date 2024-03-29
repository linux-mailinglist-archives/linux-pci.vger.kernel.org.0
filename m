Return-Path: <linux-pci+bounces-5376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A7D89156A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 10:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E19D285918
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151739AF9;
	Fri, 29 Mar 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUcoX29l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBED37711
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703391; cv=none; b=mrXQIzILCo75kHlMy3DLNrhgCk94lLslAeFZAM6LiccUN44uSMUMQzi3wnlzx0tAX8bW0dXKRPRUO9wm3xcQ2roCf72nDPGaziz+vH6DGRO4GxzVNTd0IptjMopf/NCZ2M8+27DCpjfCQvTr5QFwxa8C3R5NbqPxNRRMXAEFStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703391; c=relaxed/simple;
	bh=qCEbulFduSNumMtAvNmv8e5o53wv9ou11qaVvfYDl1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1CsBF4AkGNCfK5WJ2OhzooS76Ya49cl9Czu1x8GBJOAR6SZiU6tBjaWkzQ5UUGBfE06HshYFC1iC2I9EDrmARo8u3nP6GBNL4LZRF3VZcZn9D6yr1yvViE6Rkc0qVCzeK2HCTTIGeIM79Bk6ofEoipz4ryMNSEop0qlyhqMDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUcoX29l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B86C433F1;
	Fri, 29 Mar 2024 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703391;
	bh=qCEbulFduSNumMtAvNmv8e5o53wv9ou11qaVvfYDl1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUcoX29lxqP3o/uu5GkmylQ2N850ka0wERjw1dqVGb49wl7di7Chx0LGV2MOCRhbf
	 YqKB3lJs/srqXgJ5ESNp6dZ3FaLEnHfd+pvParjPRNtUsxYI28M4he6fNjxH8gGHLU
	 H7df1HYmk4+ztyZJNKs1EjUUKhQczPTNjirJVWAMAuMHc9MeH93nnv3IyBo0uDnm+s
	 7EqxmefJG217c4x1jln5dUCW03VRDdAiYRD3BQ7Z75YOdfz5LvQ0dKDfKTyiedV1+N
	 4wQszNQW/LElYGRNMZr9hT4j6WO/z4uUWXtfYFpRQxIxUnLDx4ZraHS11pnJymWiy3
	 9ywVSWSZXFotQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH 02/19] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Date: Fri, 29 Mar 2024 18:09:28 +0900
Message-ID: <20240329090945.1097609-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329090945.1097609-1-dlemoal@kernel.org>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
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
2.44.0


