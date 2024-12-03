Return-Path: <linux-pci+bounces-17569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB059E1B71
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF07B24469
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F101E0499;
	Tue,  3 Dec 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0nXHbhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8818784A
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220052; cv=none; b=hFaVKuvWhBPlkDMcgujSnL3N05OjTQGt/kNp4ONelKDyszqRCtSdnEtQQoeZL9SRjnxGL6UPrrqnSjNqN1cLHSwDvvO+f+vnDgb/xsNey1F7nhsjj9VRm7jfpTtDRADL6oovG8RPDU7sq46d3a1J4AGsDoznsmT23yD0JKxocsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220052; c=relaxed/simple;
	bh=ivsamSl8nq8BWXFs5jmDA/ONBCe3BCt+XAQUtqlR22w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsnT64p51Juq3kK7bewEKMPiEPYEtphgIG3cvAdMnCcKSLDf39g/vvGXNIBIuUddO53hqNcgWJj5it+jUsea0vFlp/gmMGlQhxRKCsnUw/M8I02c7vFGE/1wRadf5xqyChJvaL13DCvQ1CJ+WAT/ODC4e0elM3EIK9juPZb5xvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0nXHbhC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733220048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c/FWJ7vlBoF+Z00SYmXblfTyHBgUjE7V3Fp6vC4L/BI=;
	b=a0nXHbhCM120IVOHbHXquZhaeVMQBt1ehiWwAExetsx8hVroGpTyvxK2fH54CkymCQUA0R
	LcPn1j/CkrfIaE4wMySmJPLcUeglGmiZ4J9RkoagbN3LWPTS2rZGTkxHHJfU2LdLtdR6dQ
	m09sD064gv+BPRwBUI+4jtVEeaMe0Kc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-DR1S3dyDN12pZFg0Pk5sAA-1; Tue, 03 Dec 2024 05:00:47 -0500
X-MC-Unique: DR1S3dyDN12pZFg0Pk5sAA-1
X-Mimecast-MFC-AGG-ID: DR1S3dyDN12pZFg0Pk5sAA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee6df32602so3421758a91.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2024 02:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220046; x=1733824846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/FWJ7vlBoF+Z00SYmXblfTyHBgUjE7V3Fp6vC4L/BI=;
        b=SmmRppIyKjK+8QiID+xeHs7oLBsL4Mjjk7TTw8GtzuMyVdBb3ehYbF7Oz+XRlt0Jfc
         J8fIqhYHDz1yAksCbKtboh4DmZDhHWTUBvBdpVgTVGvXVj6wGapA867nNrRD1Zjrmmip
         FQgbzGfxNUYOAAFw9kDk23u6iyLqcAD5DcVKFKu2p1TQt10KbKoMGfbBLJF2Tyc38/Kf
         TXwxY/8T7BQfB+yuDIcf3ZK9sHdD0q9aL0znhgM70GYZ2kBRTKXs88fTXGJRSzyvsnPQ
         imFcV7wZq1ki/8a1jMMkRJU6sS9ielsmjfpdYNxswSFUgTsfA4pWLgHh9bStdxCo6T+S
         yihQ==
X-Gm-Message-State: AOJu0Yys4NFl3PpuIJznqfZvqNlfrdThEzxXbVrVUi8XAG1ZeMDejcHN
	PDsWqMtrhh4awX1Zdcjsa4Wrf9xnSyDBomJ+nQCpbA4nA+kF9g7iy2+kLJjdW0thcjuADxgRnwv
	p0QBJ79Wkkc62QjesCZtZqBS8iu34t+TjfdKBFuiVI52KI1TSUl7Ghrrp+g==
X-Gm-Gg: ASbGnctRh4adeLbiaHLFQ69hIBE4tf1jfszCGC42wnHZNiVcSd9JMdTnF1vp9Z8wuXX
	PjMFuRszeFgs2C7UCOYmWtErAxLdfM3rOsIzB1J6fYKwFJyKSWH/bFfr7QcO/RK+QJ0cKgV6hzR
	Y/PZ7no7rqt6A522AXE6hL43np1dAC5JBNwz4trm6clOmWM0Aan//v56TzhWzln4q6LZzErdueN
	MLNRr1wxRni+QFDrYPeAL+bTPMmKZX0zuefGGXl+FMxqSF13BrcfovrLkrpt2y4sTA9ANf7nXu4
	Cnuf3D1B
X-Received: by 2002:a17:90b:1802:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-2ef01215704mr3199271a91.20.1733220046398;
        Tue, 03 Dec 2024 02:00:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxchFL5kiEU3/VTtR4jg5j240q1TceSrLMGK2Uwlco4f+8XQlA9nxQr4rhvqs3wnt1pJwMlQ==
X-Received: by 2002:a17:90b:1802:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-2ef01215704mr3199230a91.20.1733220046026;
        Tue, 03 Dec 2024 02:00:46 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee78910df6sm6128561a91.51.2024.12.03.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:00:45 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] PCI: Improve parameter docu for request APIs
Date: Tue,  3 Dec 2024 11:00:24 +0100
Message-ID: <20241203100023.31152-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI region request functions have a @name parameter (sometimes called
"res_name"). It is used in a log message to inform drivers about request
collisions, i.e., when another driver has requested that region already.

This message is only useful when it contains the actual owner of the
region, i.e., which driver requested it. So far, a great many drivers
misuse the @name parameter and just pass pci_name(), which doesn't
result in useful debug information.

Rename "res_name" to "name".

Detail @name's purpose in the docstrings.

Improve formatting a bit.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 12 ++++----
 drivers/pci/pci.c    | 69 +++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3b59a86a764b..ffaffa880b88 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -101,7 +101,7 @@ static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
  * @bar: BAR the range is within
  * @offset: offset from the BAR's start address
  * @maxlen: length in bytes, beginning at @offset
- * @name: name associated with the request
+ * @name: name of the resource requestor
  * @req_flags: flags for the request, e.g., for kernel-exclusive requests
  *
  * Returns: 0 on success, a negative error code on failure.
@@ -723,7 +723,7 @@ EXPORT_SYMBOL(pcim_iounmap);
  * pcim_iomap_region - Request and iomap a PCI BAR
  * @pdev: PCI device to map IO resources for
  * @bar: Index of a BAR to map
- * @name: Name associated with the request
+ * @name: Name of the resource requestor
  *
  * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
  *
@@ -790,7 +790,7 @@ EXPORT_SYMBOL(pcim_iounmap_region);
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to request and iomap
- * @name: Name associated with the requests
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, negative error code on failure.
  *
@@ -857,7 +857,7 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
  * pcim_request_region - Request a PCI BAR
  * @pdev: PCI device to requestion region for
  * @bar: Index of BAR to request
- * @name: Name associated with the request
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, a negative error code on failure.
  *
@@ -876,7 +876,7 @@ EXPORT_SYMBOL(pcim_request_region);
  * pcim_request_region_exclusive - Request a PCI BAR exclusively
  * @pdev: PCI device to requestion region for
  * @bar: Index of BAR to request
- * @name: Name associated with the request
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, a negative error code on failure.
  *
@@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
 /**
  * pcim_request_all_regions - Request all regions
  * @pdev: PCI device to map IO resources for
- * @name: name associated with the request
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, negative error code on failure.
  *
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e..cb96d12571a8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3941,15 +3941,14 @@ EXPORT_SYMBOL(pci_release_region);
  * __pci_request_region - Reserved PCI I/O and memory resource
  * @pdev: PCI device whose resources are to be reserved
  * @bar: BAR to be reserved
- * @res_name: Name to be associated with resource.
+ * @name: Name of the resource requestor
  * @exclusive: whether the region access is exclusive or not
  *
  * Returns: 0 on success, negative error code on failure.
  *
- * Mark the PCI region associated with PCI device @pdev BAR @bar as
- * being reserved by owner @res_name.  Do not access any
- * address inside the PCI regions unless this call returns
- * successfully.
+ * Mark the PCI region associated with PCI device @pdev BAR @bar as being
+ * reserved by owner @name. Do not access any address inside the PCI regions
+ * unless this call returns successfully.
  *
  * If @exclusive is set, then the region is marked so that userspace
  * is explicitly not allowed to map the resource via /dev/mem or
@@ -3959,13 +3958,13 @@ EXPORT_SYMBOL(pci_release_region);
  * message is also printed on failure.
  */
 static int __pci_request_region(struct pci_dev *pdev, int bar,
-				const char *res_name, int exclusive)
+				const char *name, int exclusive)
 {
 	if (pci_is_managed(pdev)) {
 		if (exclusive == IORESOURCE_EXCLUSIVE)
-			return pcim_request_region_exclusive(pdev, bar, res_name);
+			return pcim_request_region_exclusive(pdev, bar, name);
 
-		return pcim_request_region(pdev, bar, res_name);
+		return pcim_request_region(pdev, bar, name);
 	}
 
 	if (pci_resource_len(pdev, bar) == 0)
@@ -3973,11 +3972,11 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
 		if (!request_region(pci_resource_start(pdev, bar),
-			    pci_resource_len(pdev, bar), res_name))
+			    pci_resource_len(pdev, bar), name))
 			goto err_out;
 	} else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 		if (!__request_mem_region(pci_resource_start(pdev, bar),
-					pci_resource_len(pdev, bar), res_name,
+					pci_resource_len(pdev, bar), name,
 					exclusive))
 			goto err_out;
 	}
@@ -3994,14 +3993,13 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * pci_request_region - Reserve PCI I/O and memory resource
  * @pdev: PCI device whose resources are to be reserved
  * @bar: BAR to be reserved
- * @res_name: Name to be associated with resource
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, negative error code on failure.
  *
- * Mark the PCI region associated with PCI device @pdev BAR @bar as
- * being reserved by owner @res_name.  Do not access any
- * address inside the PCI regions unless this call returns
- * successfully.
+ * Mark the PCI region associated with PCI device @pdev BAR @bar as being
+ * reserved by owner @name. Do not access any address inside the PCI regions
+ * unless this call returns successfully.
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
@@ -4011,9 +4009,9 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * when pcim_enable_device() has been called in advance. This hybrid feature is
  * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
-int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
+int pci_request_region(struct pci_dev *pdev, int bar, const char *name)
 {
-	return __pci_request_region(pdev, bar, res_name, 0);
+	return __pci_request_region(pdev, bar, name, 0);
 }
 EXPORT_SYMBOL(pci_request_region);
 
@@ -4036,13 +4034,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 EXPORT_SYMBOL(pci_release_selected_regions);
 
 static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
-					  const char *res_name, int excl)
+					  const char *name, int excl)
 {
 	int i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (bars & (1 << i))
-			if (__pci_request_region(pdev, i, res_name, excl))
+			if (__pci_request_region(pdev, i, name, excl))
 				goto err_out;
 	return 0;
 
@@ -4059,7 +4057,7 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * pci_request_selected_regions - Reserve selected PCI I/O and memory resources
  * @pdev: PCI device whose resources are to be reserved
  * @bars: Bitmask of BARs to be requested
- * @res_name: Name to be associated with resource
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, negative error code on failure.
  *
@@ -4069,9 +4067,9 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
-				 const char *res_name)
+				 const char *name)
 {
-	return __pci_request_selected_regions(pdev, bars, res_name, 0);
+	return __pci_request_selected_regions(pdev, bars, name, 0);
 }
 EXPORT_SYMBOL(pci_request_selected_regions);
 
@@ -4079,7 +4077,7 @@ EXPORT_SYMBOL(pci_request_selected_regions);
  * pci_request_selected_regions_exclusive - Request regions exclusively
  * @pdev: PCI device to request regions from
  * @bars: bit mask of BARs to request
- * @res_name: name to be associated with the requests
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, negative error code on failure.
  *
@@ -4089,9 +4087,9 @@ EXPORT_SYMBOL(pci_request_selected_regions);
  * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
-					   const char *res_name)
+					   const char *name)
 {
-	return __pci_request_selected_regions(pdev, bars, res_name,
+	return __pci_request_selected_regions(pdev, bars, name,
 			IORESOURCE_EXCLUSIVE);
 }
 EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
@@ -4114,12 +4112,11 @@ EXPORT_SYMBOL(pci_release_regions);
 /**
  * pci_request_regions - Reserve PCI I/O and memory resources
  * @pdev: PCI device whose resources are to be reserved
- * @res_name: Name to be associated with resource.
+ * @name: Name of the resource requestor
  *
- * Mark all PCI regions associated with PCI device @pdev as
- * being reserved by owner @res_name.  Do not access any
- * address inside the PCI regions unless this call returns
- * successfully.
+ * Mark all PCI regions associated with PCI device @pdev as being reserved by
+ * owner @name. Do not access any address inside the PCI regions unless this
+ * call returns successfully.
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
@@ -4129,22 +4126,22 @@ EXPORT_SYMBOL(pci_release_regions);
  * when pcim_enable_device() has been called in advance. This hybrid feature is
  * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
-int pci_request_regions(struct pci_dev *pdev, const char *res_name)
+int pci_request_regions(struct pci_dev *pdev, const char *name)
 {
 	return pci_request_selected_regions(pdev,
-			((1 << PCI_STD_NUM_BARS) - 1), res_name);
+			((1 << PCI_STD_NUM_BARS) - 1), name);
 }
 EXPORT_SYMBOL(pci_request_regions);
 
 /**
  * pci_request_regions_exclusive - Reserve PCI I/O and memory resources
  * @pdev: PCI device whose resources are to be reserved
- * @res_name: Name to be associated with resource.
+ * @name: Name of the resource requestor
  *
  * Returns: 0 on success, negative error code on failure.
  *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
- * by owner @res_name.  Do not access any address inside the PCI regions
+ * by owner @name. Do not access any address inside the PCI regions
  * unless this call returns successfully.
  *
  * pci_request_regions_exclusive() will mark the region so that /dev/mem
@@ -4158,10 +4155,10 @@ EXPORT_SYMBOL(pci_request_regions);
  * when pcim_enable_device() has been called in advance. This hybrid feature is
  * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
-int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
+int pci_request_regions_exclusive(struct pci_dev *pdev, const char *name)
 {
 	return pci_request_selected_regions_exclusive(pdev,
-				((1 << PCI_STD_NUM_BARS) - 1), res_name);
+				((1 << PCI_STD_NUM_BARS) - 1), name);
 }
 EXPORT_SYMBOL(pci_request_regions_exclusive);
 
-- 
2.47.0


