Return-Path: <linux-pci+bounces-8723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A55906CDB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02321F25CCE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308B1487ED;
	Thu, 13 Jun 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e++wb/Ay"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472241482F1
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279457; cv=none; b=l3Ibz5YN+uC7kmT7hwhhcdupUqW9tsy1+QbCHxErc+8rr4G736Gg+M+xDxEiGoslHWQmpPtgzrMPSnXA4TNp096buFVbj1nTWN+rOteSzTPss0tkh2jBT5YnglDpEJXtzytdqOx+3vBBqbqP0q9QVJi/wHkLYGdG2BfQSduxVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279457; c=relaxed/simple;
	bh=5PE3+Mg+QJfwk/81MP4neUpiVdZJoI7gS0UJ6lgiki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=absZQUx5XfHEu9OWY76RP/cKBhEpvf1ZBCaxCIH2mHSI2fCUZUYEwxSJay1Se5xzr0nmDVVxkdssRyEK6rFE1AgZlFw1nX1DZklH7cUbqQZmeFXjOGDDc7cz62Fc1K66Pzg7q3/CZ569eSrv5WoW3lZx/0TN/B/0XWZA1GAWCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e++wb/Ay; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeDlmSjlnwr2O/aP5XCLyUukk4Ihvpzfb1AuxNmdg5k=;
	b=e++wb/Ayii81mKY/qGs4HIDWx44Wepvu9Jk7wZOD1DuQr37InJezBG+xwLywiDlG7ty3L3
	DMs+WqUCygZrnqERpchM2SWazcqUO21ZnpFndtncYlUdr0tmqw+YHG0jsycdkkI20bjezY
	AY26I5RpQ23FQJqBPSrg07J7n0w+E5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-DM6Oq8b7OO2WPmA-Kf3hPg-1; Thu, 13 Jun 2024 07:50:52 -0400
X-MC-Unique: DM6Oq8b7OO2WPmA-Kf3hPg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217e21bcd4so1585975e9.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279451; x=1718884251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeDlmSjlnwr2O/aP5XCLyUukk4Ihvpzfb1AuxNmdg5k=;
        b=SXOBGMRMi1IKejI4GI0tsEzGMozA6xO7UJk4ddymnNZqD7p41Nb7HbLk1XtHmXOGtb
         6kp68RQt2voQHW/SAFyhqlV9QAYxZ3eMv387DtTciWDw8SMyF16joPu/DtGRhrRyHnFb
         fI15D6KRMyhVOcZix6i797DpBXKOUdhbdcFipDAC98fyBKd5fkr1vi2yCvjOUvk/nLfc
         34B60eWWF3BwmH07/ki8s+ga1E9p4BPcj5ZXuxw2gT9oQjVqrNjeRFzwsLV8yT8Yslzy
         30xmOxwnzZDChPK/gHANfgQlXyceJiC2XYqzKQv94Dd3vJeCpWdC9qtkAStLJDsia9CN
         19+w==
X-Forwarded-Encrypted: i=1; AJvYcCVhKAM+IgQIJ03d9qbqUPOjdBQYo4vFSNHeFX3KKEFD+hKCAQ9jlhq+wD7UwfUgLfDlz7hz4JBpDbPmcm9zJlZnrMr1Tu/Gc4zU
X-Gm-Message-State: AOJu0YyM/eFXc3eGYH7Yt6onvDN8dkXdU+pNdRPqbKqFDhBTA+MA9VbD
	jnfhgPa1sC5bUit0B4BWlL6CUH9sMbh0CvbwORUwtAPCG8ae0wls3TvwBmL2e3OgbIeCY53Z3n1
	1lDeafWsrsYYf7RHIjulkXDiI0XxScwhBuPCRPZlhtvUwV8lvqNSrCoDvmQ==
X-Received: by 2002:a05:6000:1845:b0:35f:1f7e:892e with SMTP id ffacd0b85a97d-36079a5fdddmr172023f8f.7.1718279451483;
        Thu, 13 Jun 2024 04:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpv9lSaVfD9w56GIK9nZEr6kUGUg9N6/YznSMrwsXxnz492p2v4uVfvUh2ehH31as5XiaCgw==
X-Received: by 2002:a05:6000:1845:b0:35f:1f7e:892e with SMTP id ffacd0b85a97d-36079a5fdddmr172006f8f.7.1718279451134;
        Thu, 13 Jun 2024 04:50:51 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:50 -0700 (PDT)
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
Subject: [PATCH v9 06/13] PCI: Warn users about complicated devres nature
Date: Thu, 13 Jun 2024 13:50:19 +0200
Message-ID: <20240613115032.29098-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
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

This has already caused a bug (in 8558de401b5f) by confusing users, who
came to believe that all PCI functions, such as pci_iomap_range(), suddenly
are managed that way, which is not the case.

Add comments to the relevant functions' docstrings that warn users about
this behavior.

Link: https://lore.kernel.org/r/20240605081605.18769-8-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iomap.c | 16 ++++++++++++++++
 drivers/pci/pci.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index c9725428e387..a715a4803c95 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -23,6 +23,10 @@
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      int bar,
@@ -63,6 +67,10 @@ EXPORT_SYMBOL(pci_iomap_range);
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
@@ -106,6 +114,10 @@ EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device(). If you need automatic cleanup, use pcim_iomap().
  * */
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -127,6 +139,10 @@ EXPORT_SYMBOL(pci_iomap);
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
index 7013699db242..5e4f377411ec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3900,6 +3900,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3950,6 +3952,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3957,6 +3961,11 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
@@ -4007,6 +4016,13 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * @pdev: PCI device whose resources are to be reserved
  * @bars: Bitmask of BARs to be requested
  * @res_name: Name to be associated with resource
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *res_name)
@@ -4015,6 +4031,19 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 }
 EXPORT_SYMBOL(pci_request_selected_regions);
 
+/**
+ * pci_request_selected_regions_exclusive - Request regions exclusively
+ * @pdev: PCI device to request regions from
+ * @bars: bit mask of BARs to request
+ * @res_name: name to be associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
+ */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 					   const char *res_name)
 {
@@ -4032,7 +4061,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4064,6 +4092,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4073,6 +4103,11 @@ EXPORT_SYMBOL(pci_request_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning message is also
  * printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
@@ -4404,6 +4439,11 @@ void pci_disable_parity(struct pci_dev *dev)
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * NOTE:
+ * This is a "hybrid" function: It's normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance. This hybrid feature is
+ * DEPRECATED!
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.45.0


