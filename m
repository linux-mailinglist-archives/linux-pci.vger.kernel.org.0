Return-Path: <linux-pci+bounces-19176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BC9FFE97
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8367818835EC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608451BD01F;
	Thu,  2 Jan 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe621g88"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460F1B85CB
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842903; cv=none; b=LkqsSlK3gekmdWYjpfkp7dIE6CekTk+lqHzM54/RewhALatdzVET1Wcx5fxGl4mHepcHAYrEBWnqxnp62m5kdpylkd4yZjCoD3Br3+ZhPtBrUSKbZqaaH9V5xniyKuNtYz0t1eVfdnRjGVYMxh9RHPOIFMpBfM5VXlDu2Q6tUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842903; c=relaxed/simple;
	bh=zWluJE6IPTN0HImP1m8yrrAHZK9xXqdLQSdp85zrd3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBZV2M1fhu51MGHBkqYMu5gr27AYgYDJHKGSSoMQ2L+wbCtEWADodEbYBvNUEaaivE+nbiUNYc8AdpjDGxpEBkKovzg5l9OpAdXLkq5ATUmXbXKF+Wv/Q76ZczXpgJ6KxVMgSScpc9MW/eS0taPWxZ/X01DDKkN4gfhm6VpIoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qe621g88; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735842900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SHGdteiFmyxgI9gM7hyE7ge15QwlPvkhjCfqci3h5EU=;
	b=Qe621g88aQK2C99tK+CmaPBvxzR3vDITpafIUBE9rJI5kKPbLtcjg31VKLVTOQp6wX/QBM
	IdkkilCr/S4lPfdYRGsR7iKLtmSsZdxy1KPkgYJJjBrgHW7bEJdJSFBHAFj9F9liipr1j4
	hYqvJN+LBtbstPrSHCOYWiU1gvRvVBM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-mC7X7BDHOTylluFaUq3weA-1; Thu,
 02 Jan 2025 13:34:56 -0500
X-MC-Unique: mC7X7BDHOTylluFaUq3weA-1
X-Mimecast-MFC-AGG-ID: mC7X7BDHOTylluFaUq3weA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243F619560B9;
	Thu,  2 Jan 2025 18:34:55 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD24D1956088;
	Thu,  2 Jan 2025 18:34:52 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	precification@posteo.de,
	athul.krishna.kr@protonmail.com,
	regressions@lists.linux.dev
Subject: [PATCH] vfio/pci: Fallback huge faults for unaligned pfn
Date: Thu,  2 Jan 2025 11:32:54 -0700
Message-ID: <20250102183416.1841878-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The PFN must also be aligned to the fault order to insert a huge
pfnmap.  Test the alignment and fallback when unaligned.

Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219619
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
Reported-by: Precific <precification@posteo.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1ab58da9f38a..1a4ed5a357d3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1661,14 +1661,15 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
-	if (order && (vmf->address & ((PAGE_SIZE << order) - 1) ||
+	pfn = vma_to_pfn(vma) + pgoff;
+
+	if (order && (pfn & ((1 << order) - 1) ||
+		      vmf->address & ((PAGE_SIZE << order) - 1) ||
 		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
 		ret = VM_FAULT_FALLBACK;
 		goto out;
 	}
 
-	pfn = vma_to_pfn(vma);
-
 	down_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
@@ -1676,18 +1677,18 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 
 	switch (order) {
 	case 0:
-		ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
+		ret = vmf_insert_pfn(vma, vmf->address, pfn);
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff,
-							     PFN_DEV), false);
+		ret = vmf_insert_pfn_pmd(vmf,
+					 __pfn_to_pfn_t(pfn, PFN_DEV), false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff,
-							     PFN_DEV), false);
+		ret = vmf_insert_pfn_pud(vmf,
+					 __pfn_to_pfn_t(pfn, PFN_DEV), false);
 		break;
 #endif
 	default:
-- 
2.47.1


