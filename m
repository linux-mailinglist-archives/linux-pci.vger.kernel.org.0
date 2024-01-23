Return-Path: <linux-pci+bounces-2465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16265838ABB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA18828B0DE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359055A788;
	Tue, 23 Jan 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHUuyG0w"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45A5A116
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003098; cv=none; b=hVAS/PGjZ3nYHzK6Y9KEJG1QwMqzIE6M3iBlVNMyhM23bN7vQwh2puqi6B5tnL8Qy74iIvA93qEVcRfkTy5pXVQP6PwsMq2Qhk6p0vhZ57W/Y29iAWDlNLl0ofranZ0bz0HlzJTL+/J3KnQVa/kwvEtoPtyQTNLfKrp4mzF3eTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003098; c=relaxed/simple;
	bh=rKqKx2xzj55JuQB/eV+Awt0kJSYANwr5bj8CjGzxCrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lz5vfkflnOmkQ4DkUpkQm9AIi+BhdPD+RFE/JWK11UxhphSJK9t4/AKU1OHJoET9RCi4HO+zSUgsb1NDwAAmdJcHrQoMZHAHTyjTFRbTfDS29viz44wTrunkKa/w4vnhC+DWvEPAB/vcsQMbb70AvCdBd90dPo/1vF0qzYMxNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHUuyG0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EoIsZMzaud9t26sivTeCHJdwdosgvCL2VSONhiwz3c=;
	b=ZHUuyG0woi3ZmVxl6pijE5GKRGMPSlPTwaX+iaJtfM76UhVR2H9VwJ81XHZK8fLhCh92/g
	4AEHvusqwFwyzul68/CXoer0VaNRrAGowa8cgOlLl1s3cTkaEhgbOue0yKNcjpSFpObv2h
	ujrrr+HYLSzeEnLUtAB9T29Sn74BXyc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-_sbvkBEiMiq5dYmh-H_25Q-1; Tue, 23 Jan 2024 04:44:52 -0500
X-MC-Unique: _sbvkBEiMiq5dYmh-H_25Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7831a20711dso100521085a.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 01:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003092; x=1706607892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EoIsZMzaud9t26sivTeCHJdwdosgvCL2VSONhiwz3c=;
        b=v31aemotekZ0A2qWGDX5Xc/0/9hbMZSZtjysFF0ChD9x7pSeRHxN8Lqt3fh7a8bjFv
         PV8l+5imeTIe+XM1lCJb20rhEtzdPr9Iv/d0Jlu42MS9CvDeqqlU3TLzAkDEgh56sfOq
         kWAd3KDWU4oLveN//tCXtgFWZ1ZB432fVRx4TBy120NkwGbTiT2IKXfXHk79atMsnAW0
         FuIkDKCvUbcCLaxlZEvK5AVhzM60ZmyJZ9la1PecgzJ1/uyx2zqT3x7I6417+SsjsgPU
         ARCclMqI5cU5ojiauUPJPLFbiJ9fdSjVTIzDjvynAFk8wMzo89B15BLyng5a7YUDfHrQ
         qBUw==
X-Gm-Message-State: AOJu0YxR/TB3rnIoMKw+AH0W3tKnAiBi/af3QgRrF7qVBjLCTLAsQVGS
	Q3TlH48H3kugFVJGm9+MeaLdy+pDTIwwWa/kkEFUIqdimM3gJPXDyr57WPXOrA3udT93cD/hCBc
	SkJ1G6KoqrAzLZXGIcsUaZEl+3qja5t+xvojNAZHQP2d6ElIGtqAzRLvylg==
X-Received: by 2002:a05:6214:c6e:b0:686:90f0:2a33 with SMTP id t14-20020a0562140c6e00b0068690f02a33mr5644881qvj.5.1706003091677;
        Tue, 23 Jan 2024 01:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPwBecVC6FieQ1xp9U2Y6NBmb5GNR/o+qtX9gU0WfvrCMFDX+wPNNnUyTl0yQMJj1YP7+7Og==
X-Received: by 2002:a05:6214:c6e:b0:686:90f0:2a33 with SMTP id t14-20020a0562140c6e00b0068690f02a33mr5644861qvj.5.1706003091343;
        Tue, 23 Jan 2024 01:44:51 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:44:51 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 03/10] PCI: warn users about complicated devres nature
Date: Tue, 23 Jan 2024 10:43:00 +0100
Message-ID: <20240123094317.15958-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123094317.15958-1-pstanner@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
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
index b7faf22ec8f5..0b7fcc2f7a49 100644
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
index 2899df77a285..7ca860acf351 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3907,6 +3907,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3918,6 +3920,13 @@ EXPORT_SYMBOL(pci_release_region);
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
@@ -3966,6 +3975,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3973,6 +3984,12 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
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
@@ -3998,6 +4015,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
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
@@ -4023,6 +4047,14 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
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
@@ -4031,6 +4063,20 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
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
@@ -4048,7 +4094,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4080,6 +4125,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4089,6 +4136,12 @@ EXPORT_SYMBOL(pci_request_regions);
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
@@ -4420,6 +4473,11 @@ void pci_disable_parity(struct pci_dev *dev)
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
2.43.0


