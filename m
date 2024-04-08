Return-Path: <linux-pci+bounces-5864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D66789BA9D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99D51F22931
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC894086F;
	Mon,  8 Apr 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYRfPEna"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA163D0A3
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565879; cv=none; b=aRrss3FYFPN4KZ1Vuqk+ir2fFbyNaufPRjKHAd+K+0AJIjxYkTdbIrAN0DLwgQEoPsWmuf+Lyd5/a5BwvP9tvWHwVk5ocluDD1guzhO7IYTytZGeh6k0kt2BIKCDg475D9akvN+O45xIWxq8DUamWOu8yQDjTB8Jxd+epwzGSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565879; c=relaxed/simple;
	bh=nBKWG5c5FhCBx7bhOlD5JxIgz1Oj/+3VoPRHxP5kZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsRhmd0TALEbTZiYwhjPHHdI/YGwB9eaDuRva+cDrqgfOcxYkje/dPF7gyGF9x1WyFmMYujCNdmsYUdGWa7Qpdx1h/gKdHreJ5mu5aAOBTkr8lV744t2HWY2NSM67fEWSaqG0P0wJKaCoyRm1beUvhXtCfagOVLmEMKsocMoPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYRfPEna; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqd0XV6NVHg28KpejWCVVeMq/IoUZp7GtZTIzYnrVC8=;
	b=HYRfPEnaxcGRChN3kjaSjgqyhfo87RdxRqJZHrRqkp0YZ2iIjE92+NjYGERXxHwZym+WCm
	AsM51mk5t6ORM5RYyhpiPOnPPovkygv32b+mTfTvzEVevbne9ReSuv4yNCb4F6JkfGVbiY
	nfxwHs0SZnXmuER355J0saZ0hfH4Mgo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-pouIxVsLMFOQkvYoCqWfnw-1; Mon, 08 Apr 2024 04:44:35 -0400
X-MC-Unique: pouIxVsLMFOQkvYoCqWfnw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4349ba8bbfbso3798251cf.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 01:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565875; x=1713170675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqd0XV6NVHg28KpejWCVVeMq/IoUZp7GtZTIzYnrVC8=;
        b=xUSnss3EhtIVE2kzLgrL2ZsXoN/Tho9cFxDoWfMK5wbg5tTv4rbAj5W3d/GHyharFj
         Yzzd2cKuqq3joivJrtbSss6W3U4N7e2kk+uqaQQ/KuG6fVQHBKKNOXs7DwAfDZrRH4s7
         yC/V7YR6wRs9pfouA29vayHVw15fFlncifsdIFg/l8j1ETi3kPw8pKettMnEKdY4n5vY
         BH7qHk/WJy+SQ19u9PiN/NC1WInBblf9Kr7fDEjJU6tGCB8NDj6xyC+qOlurzBIj48LT
         OLCeXkQsHmThOl0/uZbiB7ih4O2rydJO889K6txdx6UmKjZzeD+V+d6v6vRn5Lw77shG
         nc3w==
X-Forwarded-Encrypted: i=1; AJvYcCXMwXuZ0+bTvXJFUl0FKC17NnP5GrDj37YEJw/CxyHzK8N3FlYtvGUqGygfFg/kBFE6HPeIGn5XM2E2Vk2KqVqS1NbgtFgysFom
X-Gm-Message-State: AOJu0YwHP5i3tBrwi8oDnrzrwbVkCY4JLKVRegrehKOKx5AxjI5HNGV1
	YGBb6aqcCvtUEvlwQNZ4TvJAMZgX2IyLmJQX+rWAIj7JVBI2pGzKte+mYgO+0C6ge1gdyBXpyZQ
	+BUjnzBTrmIUBR2lTKcRqYxgIfs5872GkyVvAawOUn6oWpHP1fJZOp5xQmA==
X-Received: by 2002:a05:620a:4590:b0:78a:1ee:5c0f with SMTP id bp16-20020a05620a459000b0078a01ee5c0fmr9642456qkb.6.1712565875266;
        Mon, 08 Apr 2024 01:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR7midRoJI1FNPA+UU8XSvGoaEgXHEXcx1Kf1HaHyevfXZ+2+YLJhdeNw61JvfoOji+zi2BQ==
X-Received: by 2002:a05:620a:4590:b0:78a:1ee:5c0f with SMTP id bp16-20020a05620a459000b0078a01ee5c0fmr9642439qkb.6.1712565874920;
        Mon, 08 Apr 2024 01:44:34 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:34 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v6 03/10] PCI: Warn users about complicated devres nature
Date: Mon,  8 Apr 2024 10:44:15 +0200
Message-ID: <20240408084423.6697-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI region-request functions become managed functions when
pcim_enable_device() has been called previously instead of
pci_enable_device().

This has already caused bugs by confusing users, who came to believe
that all pci functions, such as pci_iomap_range(), suddenly are managed
that way.

This is not the case.

Add comments to the relevant functions' docstrings that warn users about
this behavior.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c | 18 ++++++++++++++
 drivers/pci/pci.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index c9725428e387..ea3b9842132a 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -23,6 +23,11 @@
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
+ * If you need automatic cleanup, use pcim_iomap_range().
  * */
 void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      int bar,
@@ -63,6 +68,10 @@ EXPORT_SYMBOL(pci_iomap_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 int bar,
@@ -106,6 +115,11 @@ EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
+ * If you need automatic cleanup, use pcim_iomap().
  * */
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -127,6 +141,10 @@ EXPORT_SYMBOL(pci_iomap);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5d21d8207d6..9d9d09534efe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3903,6 +3903,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3914,6 +3916,13 @@ EXPORT_SYMBOL(pci_release_region);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you need to implement a new pci
+ * function that does automatic cleanup, write a new pcim_* function that uses
+ * devres directly.
  */
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *res_name, int exclusive)
@@ -3962,6 +3971,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3969,6 +3980,12 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
@@ -3994,6 +4011,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 }
 EXPORT_SYMBOL(pci_release_selected_regions);
 
+/*
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
+ */
 static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
 					  const char *res_name, int excl)
 {
@@ -4019,6 +4043,14 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * @pdev: PCI device whose resources are to be reserved
  * @bars: Bitmask of BARs to be requested
  * @res_name: Name to be associated with resource
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *res_name)
@@ -4027,6 +4059,20 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 }
 EXPORT_SYMBOL(pci_request_selected_regions);
 
+/**
+ * pci_request_selected_regions_exclusive - Request regions exclusively
+ * @pdev: PCI device to request regions from
+ * @bars: bit mask of bars to request
+ * @res_name: name to be associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
+ */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 					   const char *res_name)
 {
@@ -4044,7 +4090,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4076,6 +4121,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4085,6 +4132,12 @@ EXPORT_SYMBOL(pci_request_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning message is also
  * printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
@@ -4416,6 +4469,11 @@ void pci_disable_parity(struct pci_dev *dev)
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED!
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.44.0


