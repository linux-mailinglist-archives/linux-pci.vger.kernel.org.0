Return-Path: <linux-pci+bounces-27958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE524ABBC59
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11D8189D12B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67616274FDE;
	Mon, 19 May 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnUN8J2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915A2629C;
	Mon, 19 May 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654228; cv=none; b=mDf8OA3osIQbtMSRO0H/AR5ausJ+jEo/hMll3wUZaftJHJpKU/HB8fsGaI59zmM/ZJryI98ApCOeUlZlp6KCZKXqGxEyUNVUEIi+l2ODdzoXn/OP9T4DH3xVA3WgIwlKpeFtUBOUIubrVfWTxzhCw3T7CpvJpqMVkH+/BtUmNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654228; c=relaxed/simple;
	bh=qwS3qxoPs9zP+KP5UE5JcbIR0eEtNBeA+RSPEGwLH9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiuStrrA3GS2s8liY9NNmgvx+2bpxLH0RIhINXkmb0czdT9LWB/fqzqIzlNDa2QUh0Hba5XreRnPzsNQQzkxDimf2CCRU52YVX4NaqQ8KkUuUbYRBNZxcvIPNTzfKhNG21UMUk1ebe9n2fbrTp0bYZ2sMDZRLy1EZMcYAmwLYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnUN8J2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E94C4CEF0;
	Mon, 19 May 2025 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747654226;
	bh=qwS3qxoPs9zP+KP5UE5JcbIR0eEtNBeA+RSPEGwLH9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnUN8J2uqC982h7RVGxfI7rM4OorjSFtPvwS7QJNCx35WizIoVkmTctX89VYvmNyt
	 s6fi8ys/pL+PgatvkDCkOWIQHmf62Ni8d4eOHNPwf/owf5U/x8jtWFo37OUCcbKNLf
	 JytMZeY7LlMTMHtK/jtkj3Hj1Mu56ciG07bqEg4veWi1/980xe5l8u0zCFHPtQrEvQ
	 BX+i2plyt2wk+RnmePlBQTzepEIgCarJtNSy6vIssGb6Kw9VKOsJrT9elue9jJL/do
	 /ZSTQ+6O145oa+lzuDTl4xqszcP+TLl7NRZpA461fYfR6Mas+0QCIjfwQ8Zyw5ggHw
	 KoK8YzN98aqWg==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/6] PCI: Remove hybrid devres nature from request functions
Date: Mon, 19 May 2025 13:29:55 +0200
Message-ID: <20250519112959.25487-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519112959.25487-2-phasta@kernel.org>
References: <20250519112959.25487-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All functions based on __pci_request_region() and its release counter
part support "hybrid mode", where the functions become managed if the
PCI device was enabled with pcim_enable_device().

Removing this undesirable feature requires to remove all users who
activated their device with that function and use one of the affected
request functions.

These users were:
	ASoC
	alsa
	cardreader
	cirrus
	i2c
	mmc
	mtd
	mtd
	mxser
	net
	spi
	vdpa
	vmwgfx

all of which have been ported to always-managed pcim_ functions by now.

The hybrid nature can, thus, be removed from the aforementioned PCI
functions.

Remove all function guards and documentation in pci.c related to the
hybrid redirection. Adjust the visibility of pcim_release_region().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/devres.c | 39 ++++++++++++---------------------------
 drivers/pci/pci.c    | 42 ------------------------------------------
 drivers/pci/pci.h    |  1 -
 3 files changed, 12 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 73047316889e..5480d537f400 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -6,30 +6,13 @@
 /*
  * On the state of PCI's devres implementation:
  *
- * The older devres API for PCI has two significant problems:
+ * The older PCI devres API has one significant problem:
  *
- * 1. It is very strongly tied to the statically allocated mapping table in
- *    struct pcim_iomap_devres below. This is mostly solved in the sense of the
- *    pcim_ functions in this file providing things like ranged mapping by
- *    bypassing this table, whereas the functions that were present in the old
- *    API still enter the mapping addresses into the table for users of the old
- *    API.
- *
- * 2. The region-request-functions in pci.c do become managed IF the device has
- *    been enabled with pcim_enable_device() instead of pci_enable_device().
- *    This resulted in the API becoming inconsistent: Some functions have an
- *    obviously managed counter-part (e.g., pci_iomap() <-> pcim_iomap()),
- *    whereas some don't and are never managed, while others don't and are
- *    _sometimes_ managed (e.g. pci_request_region()).
- *
- *    Consequently, in the new API, region requests performed by the pcim_
- *    functions are automatically cleaned up through the devres callback
- *    pcim_addr_resource_release().
- *
- *    Users of pcim_enable_device() + pci_*region*() are redirected in
- *    pci.c to the managed functions here in this file. This isn't exactly
- *    perfect, but the only alternative way would be to port ALL drivers
- *    using said combination to pcim_ functions.
+ * It is very strongly tied to the statically allocated mapping table in struct
+ * pcim_iomap_devres below. This is mostly solved in the sense of the pcim_
+ * functions in this file providing things like ranged mapping by bypassing
+ * this table, whereas the functions that were present in the old API still
+ * enter the mapping addresses into the table for users of the old API.
  *
  * TODO:
  * Remove the legacy table entirely once all calls to pcim_iomap_table() in
@@ -89,10 +72,12 @@ static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
 
 /*
  * The following functions, __pcim_*_region*, exist as counterparts to the
- * versions from pci.c - which, unfortunately, can be in "hybrid mode", i.e.,
- * sometimes managed, sometimes not.
+ * versions from pci.c - which, unfortunately, were in the past in "hybrid
+ * mode", i.e., sometimes managed, sometimes not.
  *
- * To separate the APIs cleanly, we define our own, simplified versions here.
+ * To separate the APIs cleanly, we defined our own, simplified versions here.
+ *
+ * TODO: unify those functions with the counterparts in pci.c
  */
 
 /**
@@ -893,7 +878,7 @@ int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *nam
  * Release a region manually that was previously requested by
  * pcim_request_region().
  */
-void pcim_release_region(struct pci_dev *pdev, int bar)
+static void pcim_release_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..4acc23823637 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3937,16 +3937,6 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 	if (!pci_bar_index_is_valid(bar))
 		return;
 
-	/*
-	 * This is done for backwards compatibility, because the old PCI devres
-	 * API had a mode in which the function became managed if it had been
-	 * enabled with pcim_enable_device() instead of pci_enable_device().
-	 */
-	if (pci_is_managed(pdev)) {
-		pcim_release_region(pdev, bar);
-		return;
-	}
-
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
@@ -3984,13 +3974,6 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 	if (!pci_bar_index_is_valid(bar))
 		return -EINVAL;
 
-	if (pci_is_managed(pdev)) {
-		if (exclusive == IORESOURCE_EXCLUSIVE)
-			return pcim_request_region_exclusive(pdev, bar, name);
-
-		return pcim_request_region(pdev, bar, name);
-	}
-
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
 
@@ -4027,11 +4010,6 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *name)
 {
@@ -4084,11 +4062,6 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * @name: Name of the driver requesting the resources
  *
  * Returns: 0 on success, negative error code on failure.
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *name)
@@ -4104,11 +4077,6 @@ EXPORT_SYMBOL(pci_request_selected_regions);
  * @name: name of the driver requesting the resources
  *
  * Returns: 0 on success, negative error code on failure.
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 					   const char *name)
@@ -4144,11 +4112,6 @@ EXPORT_SYMBOL(pci_release_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_regions(struct pci_dev *pdev, const char *name)
 {
@@ -4173,11 +4136,6 @@ EXPORT_SYMBOL(pci_request_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning message is also
  * printed on failure.
- *
- * NOTE:
- * This is a "hybrid" function: It's normally unmanaged, but becomes managed
- * when pcim_enable_device() has been called in advance. This hybrid feature is
- * DEPRECATED! If you want managed cleanup, use the pcim_* functions instead.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *name)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..8c3e5fb2443a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1062,7 +1062,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 int pcim_intx(struct pci_dev *dev, int enable);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
 				  const char *name);
-void pcim_release_region(struct pci_dev *pdev, int bar);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
-- 
2.49.0


