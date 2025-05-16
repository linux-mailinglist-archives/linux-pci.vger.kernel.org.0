Return-Path: <linux-pci+bounces-27885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD528ABA20D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57E33B428E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56447274FD0;
	Fri, 16 May 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4mWpOAb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAC1B6D06;
	Fri, 16 May 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417316; cv=none; b=pThMupHdU53xKqoYRzH9tErn/3NtIlHf95XqyGhDovXqRWQe12Pczx1r00AlEGE1gbuYbYdWOxoYAav0i4OfvBZ8Ae5TjRW0YNsgeN6DOxP/CW1a1KuwYEV+/m8xD0EhpcAoZ9P/WDO2JUdrw2EboH6K7yyoXOlNruds98aZQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417316; c=relaxed/simple;
	bh=fdV4EBB0Ubivi1ebzVTZviSinak1zsr42O6eeHj5myE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FemFVHCGA+vAjiSpn7UK6NrjgmoVm1IHlZ7P/jRzAFEHX+zYM3I+JDY5IJg0GnoS6QkqLi+Q4LPGtVlz5kSzdOglfpBGCqAUaV4d4vt8ljj90p57UEGMsi4p535XZ457BqmItkKz2MNndZMBpgfIbfOUADb741xxzWxAT3nTWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4mWpOAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E845C4CEEF;
	Fri, 16 May 2025 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747417313;
	bh=fdV4EBB0Ubivi1ebzVTZviSinak1zsr42O6eeHj5myE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4mWpOAba+9nr+nvF8VFs3M8ftLXq87LCe2FC945zYKgH51AGP8sQxGoWezSW0+Y8
	 sbvTfpdO0jHjy9cq6nqbnJrWbihHm+5uQ/3y8m5exfbL/8Guh3KmpvPsnXU9BtdL9h
	 Qe2OLyNHIC1aeSeeFnGzuOtIPm/Nk3AeONa6Qz2dc/HBWe5urgTHwbZPvESPzoZndi
	 +oBEJP0/bST3mokrJCAleYBbQLe7A/6g52pZQdSmOaqlNJpC9ATv4QgIzXK/N6bhVs
	 yWw2RgsL+KC6n4/PPgm0WUFVxCPvsNY6MhxA67vQW00VvY5LWZHjJ8ppC9pvdoUieH
	 jwci8IOoAd9JA==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/6] PCI: Remove hybrid devres nature from request functions
Date: Fri, 16 May 2025 19:41:36 +0200
Message-ID: <20250516174141.42527-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516174141.42527-1-phasta@kernel.org>
References: <20250516174141.42527-1-phasta@kernel.org>
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


