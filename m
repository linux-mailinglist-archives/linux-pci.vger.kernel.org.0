Return-Path: <linux-pci+bounces-8518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A065901E51
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8806D1C22F29
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F77D06B;
	Mon, 10 Jun 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4EnQE0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0574BE4
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011934; cv=none; b=azqC4xK8GGHb0ciWgg7niZcsKyx9a/Ab0Dr1oV/fQzk7tYcX0BOqB3F3XHMKqBFJm2hJlJhXZdMhIMHpQriMizr6qryev/5ZX/wqDH5UWgTBzQ2Ov5FTr8PnVj/WWnjKgonKX7844Eb7KjS4KVI9GDqRk40+Y8At/hl/H0UGZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011934; c=relaxed/simple;
	bh=yZ5BKFpZwAyKkfsZmuzlsekm8L8yl3Htpr+3BjCRxJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB8Xzpx+XD+VycDyauP/RAdrGMTDHKS/G/vgaYx1PilFSu4wYR0847HgP7WXx4id/3uwLZDYTvjvbDOzxoI4I8qe3rrybAeUkjqs8CFZzxhNEWPhzCLgTRMBtJnJtsLSAnHMps5L02Zw++XmOenLFj/0nDOWDDw1DlbNzt6btn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4EnQE0V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9dFlyi1HoB9hw7OSY8YroyFypFphGOIBSX/wCz7lA0=;
	b=e4EnQE0V4bGIqeDkt4JCPzHV78J5STRBSe9mJ/5H+OWZJOKE2M5FTZzOs4kjejx+aGDqtE
	eAYoF4NOUK0rKXU+VPBUqGCWERntgAbuiwaGb4BxlPaOusLQjV2UQ5TmMSvZKEHWo6MTdL
	lTfe0/jHVrubtvHPEoiSOViasys17bI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-shirMVbDO-e6_PI2O8i6oA-1; Mon, 10 Jun 2024 05:32:07 -0400
X-MC-Unique: shirMVbDO-e6_PI2O8i6oA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so6355175e9.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011926; x=1718616726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9dFlyi1HoB9hw7OSY8YroyFypFphGOIBSX/wCz7lA0=;
        b=vUGdh3l6VdiHOuHKHhDI43FQ36h2Tc99xqPNaEfDiPnX0RjiBM1gBD+pTtddNPnw7L
         896NYamTt7UUqYtZZ+fzSWjx6HEifX3tw6x8j3gg97u4P1HezVYEmG7KCgIbXUkMII8g
         +AqMlEneJrKpgucon4JqUKaFKpqs4ThlxQekYVvW1VXR+y56miYe1GG9VkOOYkMOZHLw
         PcKtyjINdqI9g9gVqthuw3cE79rtYktGuEGdZBDhz8MkD5FWJjphqZCsY36Oypntv3Dx
         Nci6pwx5x/PmmbgYL9Eez9QptIfvb3DBid6swYGbzuNnGC8HIaH8Pojxnvp7rOt3Vvrc
         ctGw==
X-Forwarded-Encrypted: i=1; AJvYcCXLuHPnlXpEJmX5fFtG8kHCB79+44bHaQKw0cmB/Usid7FMUMOf7kxf2Lzpuaeo4OHUJbhNswcz/+HxG+S5qazOddtPTlI4s9Iu
X-Gm-Message-State: AOJu0YxLsiziwlDfJOBlb5tZhrQ72P7a2C5tqVi15zE3B4RYNB7Egs1F
	rQI1xZrtzMx9SRS0JRUrN8KASbrYt4IOJpbdV2bRzmnWVnTSUavTFg85/B6oXgXb4JdxkjqD+KX
	ldz+Yh4UOvL9/j+7ykuh0+Ou/gqWJsRiPxF6nJpmLKHV2TQ/+5YorbetiaQ==
X-Received: by 2002:a05:6000:1449:b0:35f:2584:770e with SMTP id ffacd0b85a97d-35f258478fdmr1253736f8f.0.1718011926175;
        Mon, 10 Jun 2024 02:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEziWNez2EK+YomAgaeshNAtde9wnxaSAihS2piYtCVgKznJZAQPET9dT+eD9H5nnkLmNWrZQ==
X-Received: by 2002:a05:6000:1449:b0:35f:2584:770e with SMTP id ffacd0b85a97d-35f258478fdmr1253715f8f.0.1718011925874;
        Mon, 10 Jun 2024 02:32:05 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:05 -0700 (PDT)
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
Subject: [PATCH v8 06/13] PCI: Warn users about complicated devres nature
Date: Mon, 10 Jun 2024 11:31:28 +0200
Message-ID: <20240610093149.20640-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
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
came to believe that all pci functions, such as pci_iomap_range(), suddenly
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


