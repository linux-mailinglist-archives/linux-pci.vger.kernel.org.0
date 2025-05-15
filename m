Return-Path: <linux-pci+bounces-27790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD58AB86BF
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6D189AF6D
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E929A339;
	Thu, 15 May 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7ZEUV4S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB529A31D;
	Thu, 15 May 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313181; cv=none; b=rxptRuRxfJZpNn+H53AKV8fKsZIRzhRKOpnpY0d1JZCXaiTgVqJSJpoG7SOiM58DkZ0oKuRAqautUEJFP70CqdsarmvN++njkaSL1mfVADuSy8prJ8CKOwF8YeYNON1qjEjgcJCqQV1riB2FCI/jxlQ1JroccOUbsOVFMAaYMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313181; c=relaxed/simple;
	bh=OIj+PWlwAqawizPqQ/lX/FY4UjwOhKLrL4BOVLrF9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDKRQ72+9MwoSO5opdjXbH4FqZswbwe3IxQcAoeP2TCtnx+LriKwDKwcNrBravi6zndUx240UuGCLM29CpFCaA8Bdq4UtChQggPiixMZxFwYCuuoM29GoSZCXtisxGb/k2JRy/UtD8YQajqzIP+tdBKgOE3cpalu7wjIX7yl4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7ZEUV4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C755EC4CEEB;
	Thu, 15 May 2025 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313180;
	bh=OIj+PWlwAqawizPqQ/lX/FY4UjwOhKLrL4BOVLrF9ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7ZEUV4Sb+nmr9V/jQMpt2+w/fKyprPN375uq4ZEjn/eIEaFNC9z/+OYaFmm4/5RH
	 g6U9btkrbWQUcbIi3M3gis4/HpJYwMtFJcjJpgVM8uhtnp7Q5z3oIlV2B8kpTJ1z/x
	 88uv6q0NCq5t2XxnRAU0wD9NcYDt1A4aUfSpUIaehUULteUeEPRwSSTe7VeAfSByxX
	 LZuQ0BpUkNctrtTSh7+yec5oZYJ/xN2tXXwkfoObZDMeRtw/J7iOdInSiMLlIcyJlp
	 fRjSNojPYjWZgQG2VuCS6HW8SkGz2TF/ha6XgH8A17Mw/9dgdpzBBUw3VP71dYZ6y7
	 Lu0I47kke6gYw==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/7] PCI: Remove hybrid devres nature from request functions
Date: Thu, 15 May 2025 14:45:59 +0200
Message-ID: <20250515124604.184313-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515124604.184313-2-phasta@kernel.org>
References: <20250515124604.184313-2-phasta@kernel.org>
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


