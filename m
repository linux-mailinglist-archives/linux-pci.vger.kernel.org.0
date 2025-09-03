Return-Path: <linux-pci+bounces-35367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BD7B41DD0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465DF1BA6821
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3242FCC04;
	Wed,  3 Sep 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWyjwSdC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773E2FCBE5
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900384; cv=none; b=aSIXqEOVByxGH5V9NnVidQ7snSfVFiEiiczWsykp0isA0sYUwUpAa//PINdKAL1bUpsGmx8RsGe6S2OWwv00xqNnjOTzXrGIACY3NQxB5lcIxfuBt8AK8gwrn/kRASgNArTwOnWm6RW0j/dmJCT4/0c5I7Xqsq0KVI2ohFvOR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900384; c=relaxed/simple;
	bh=TukmfdyP2molOXm+ejnaRWVZfFfZMMLUhTb0qHlzFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgiA/06pu5ix3CsWEDhmvwXajSNXGvoGDRrg+oZNYR/bkQPY9LtnSkbRLIrBRwLL+G+K35GE389qh9LVMNQx8O6yWFQsWXJg7f5H0IWW2mrlTgh49imtH3wcYZ9vf3DYpvQ0EJu1XxtwOpjREHZWNSsiMJ96BI9zaCT8u/fYVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWyjwSdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CC7C4CEF0;
	Wed,  3 Sep 2025 11:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756900383;
	bh=TukmfdyP2molOXm+ejnaRWVZfFfZMMLUhTb0qHlzFCc=;
	h=From:To:Cc:Subject:Date:From;
	b=hWyjwSdCjVHgQm3hLhdWHJBd4SJSup1had/7YRQ4BPDBEMovsBvqGtC4/3KmAhYCs
	 KC8e7lrX5OqG5yl1oEh/ORL4GARPXopuLx62wZFC2MEZIPpEV4g6/yyw+1oMsSbg4y
	 wPQfXhGOdIVUCX2SHh/R7JP9257k5wY8burJ7j9+hfMw/ZjhEEejLWIU6gAjpw5PZP
	 UrtGG4TcWAxj/+3A/m2yUfmzIWihx0vAr1qpGGcyG+IHghqE47OAogKC7UUGMo52S8
	 ibuKKIHYDbR/axXIRdTsfSTc+ltm6TUbkb2TcydjK+T2SFMap4B5ONS7KnTPfi1u27
	 6R6hmUXuyQ3Gw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-pci@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH] PCI/P2PDMA: Reduce scope of pci_has_p2pmem function
Date: Wed,  3 Sep 2025 14:52:56 +0300
Message-ID: <d40f3f1decf54c9236bc38b48a6aae612a5c182f.1756900291.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

pci_has_p2pmem() function is not used outside of p2pdma.c and there is
no need in EXPORT_SYMBOL_GPL for this function at all.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c       | 3 +--
 include/linux/pci-p2pdma.h | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 3fa1292c8d91..988e7788c68e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -787,7 +787,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_distance_many);
  * pci_has_p2pmem - check if a given PCI device has published any p2pmem
  * @pdev: PCI device to check
  */
-bool pci_has_p2pmem(struct pci_dev *pdev)
+static bool pci_has_p2pmem(struct pci_dev *pdev)
 {
 	struct pci_p2pdma *p2pdma;
 	bool res;
@@ -799,7 +799,6 @@ bool pci_has_p2pmem(struct pci_dev *pdev)
 
 	return res;
 }
-EXPORT_SYMBOL_GPL(pci_has_p2pmem);
 
 /**
  * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index dea98baee5ce..b9ba63c40e51 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -71,7 +71,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		u64 offset);
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose);
-bool pci_has_p2pmem(struct pci_dev *pdev);
 struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients);
 void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size);
 void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size);
@@ -101,10 +100,6 @@ static inline int pci_p2pdma_distance_many(struct pci_dev *provider,
 {
 	return -1;
 }
-static inline bool pci_has_p2pmem(struct pci_dev *pdev)
-{
-	return false;
-}
 static inline struct pci_dev *pci_p2pmem_find_many(struct device **clients,
 						   int num_clients)
 {
-- 
2.51.0


