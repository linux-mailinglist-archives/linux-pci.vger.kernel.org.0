Return-Path: <linux-pci+bounces-8720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D3D906CD6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4FC28335C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9B1482F3;
	Thu, 13 Jun 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N47oFeH1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5411474B6
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279454; cv=none; b=rbfyJOaNGdAyLlzjmu9XhxD5ELsy+AIesgWQRmZBzkFuSZVKZQ6WsroJE2d6xy1Md46UWyRY6J5/Jz25yPFBq1q9WZzKwlem8Q4RGMmA245XLrCFoamqY62Hxs3t0QF6RV4P4qRQ8fpbOwdLKjvZ98DxoxBJokAjElyJpIu9bZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279454; c=relaxed/simple;
	bh=uWUzFsdvpSHc64lHKkPsUVgfWCCMYvJqUAk/DiCtcSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntcAjnAFDEpMs9yRvXBkcokC4C8vnvFnfvtDtEI6ZFftXWYJEuGTGRdaPMcZCqZ2WppI7T0vFqVMQrsgjUD/hJV65o6iLhtjuN5vq6UMX1oGN8yNZvUUW7QQ0LJ42I2hDYdG1A1xCwzmBwJI1aFENzEUZXb0qXFiu2k1yAWE5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N47oFeH1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owM7d9MOt/jRqhqh2hkOR6CRgSB25b9Tr8ToAYjipS8=;
	b=N47oFeH1BChznm1zV8b8bLKZoJGnx5MxftjyDSCf5bsNPjRm5GcN6L2fg97oNXZWa4aR4W
	zvyu3X4dXhlvFUdU13jS40FCjUM0ApB4S/ItM5DzXlBQP3nD3+c4HeudKXlS46vm+Ei2yO
	XgOqYaLc5kxwNVoaNI8SnFqb2wSiOKQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-I4tkmnKEMR-nVGKcEjzOzw-1; Thu, 13 Jun 2024 07:50:49 -0400
X-MC-Unique: I4tkmnKEMR-nVGKcEjzOzw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36073543200so107616f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279448; x=1718884248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owM7d9MOt/jRqhqh2hkOR6CRgSB25b9Tr8ToAYjipS8=;
        b=WylfyTIZintg17hIWChGC3srgsSq4VM1sJ4Pc1CPBaSdr8RJO5/G7rXeCOKqbvzugo
         ELLU2AR/u0uGXDaq69Kjg54hSJW+Emrn+Yq0flHllzrxc9GI2jsZtNYGBfcJZsDQQ/qb
         4RFo1qxEp7LfnM+Jbgifkdf3EjFHZuz5eejCnOcUtbKxE/OA/7IGhPqSEoVPcvPn/kPz
         Bl2UcN//NMwhyCRDpr0rtc+UQAAmr/MKvMPU1etBpdZAO5udUjHXqTxyf7X70eJLx/Ap
         yumF5GVK9rzn3AE1iBOjAi6yoWHXYKNGGnbYEz7bRY3H1OXunsqLF+QvIVtxSq03Wi/H
         zDZw==
X-Forwarded-Encrypted: i=1; AJvYcCUfy1JPWo0/WaV5xdQSCS/gOM8SfrskEXTgsbrKy/F5kzPZWg+bnxbBMTDosYaQjrMoTR6R1Pia6ZQqDVui+/jiP6lB4H6JtcMz
X-Gm-Message-State: AOJu0YwYqanq+fr6IMXR1kJZ1m2JQDKmh3Q94lpggrDEyBwY0SfeNvyh
	wDqoFOiqVDfXxB42tZVKblspv6AqjQRvJ/zKQ/y3BtaWJcF+fGGAGtYy1HorJ1EJmZ0mwZepI6O
	uruxRfOxgoxlcSX6k665awTCVmbO8EbHWxE66LjADVHVmBTYITjLU0xppag==
X-Received: by 2002:a05:6000:1565:b0:35f:306f:1580 with SMTP id ffacd0b85a97d-360799b1549mr219956f8f.0.1718279448137;
        Thu, 13 Jun 2024 04:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9cmmBRW9Stdsi/0+iK7+da7RrjIrMU5kxwu1c5epv9+cZ27afQqEVK8UIzXm69jHmn71+7Q==
X-Received: by 2002:a05:6000:1565:b0:35f:306f:1580 with SMTP id ffacd0b85a97d-360799b1549mr219936f8f.0.1718279447676;
        Thu, 13 Jun 2024 04:50:47 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:47 -0700 (PDT)
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
Subject: [PATCH v9 03/13] PCI: Add partial-BAR devres support
Date: Thu, 13 Jun 2024 13:50:16 +0200
Message-ID: <20240613115032.29098-4-pstanner@redhat.com>
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

With the current PCI devres API implementing a managed version of
pci_iomap_range() is impossible.

Furthermore, the PCI devres API currently is inconsistent and
complicated. This is in large part due to the fact that there are hybrid
functions which are only sometimes managed via devres, and functions
IO-mapping and requesting several BARs at once and returning mappings
through a separately administrated table.

This table's indexing mechanism does not support partial-BAR mappings.

Another notable problem is that there are no separate managed
counterparts for region-request functions such as pci_request_region(),
as they exist for other PCI functions (e.g., pci_iomap() <->
pcim_iomap()). Instead, functions based on __pci_request_region() change
their internal behavior and suddenly become managed functions when
pcim_enable_device() instead of pci_enable_device() is used.

This API is hard to understand and potentially bug-provoking. Hence, it
should be made more consistent.

This patch adds the necessary infrastructure for partial-BAR mappings
managed with devres. That infrastructure also serves as a ground layer
for significantly simplifying the PCI devres API in subsequent patches
which can then cleanly separate managed and unmanaged API.

When having the long term goal of providing always managed functions
prefixed with "pcim_" and never managed functions prefixed with "pci_"
and, thus, separating managed and unmanaged APIs cleanly, new PCI devres
infrastructure cannot use __pci_request_region() and its wrappers since
those would then again interact with PCI devres and, consequently,
prevent the managed nature from being removed from the pci_* functions
in the first place. Thus, it's necessary to provide an alternative to
__pci_request_region().

This patch addresses the following problems of the PCI devres API:

  a) There is no PCI devres infrastructure on which a managed counter
     part to pci_iomap_range() could be based on.

  b) The vast majority of the users of plural functions such as
     pcim_iomap_regions() only ever sets a single bit in the bit mask,
     consequently making them singular functions anyways.

  c) region-request functions being sometimes managed and sometimes not
     is bug-provoking. pcim_* functions should always be managed, pci_*
     functions never.

Add a new PCI device resource, pcim_addr_devres, that serves to
encapsulate all device resource types related to region requests and
IO-mappings since those are very frequently created together.

Add a set of alternatives cleanly separated from the hybrid mechanism in
__pci_request_region() and its respective wrappers:
  - __pcim_request_region_range()
  - __pcim_release_region_range()
  - __pcim_request_region()
  - __pcim_release_region()

Add the following PCI-internal devres functions based on the above:
  - pcim_iomap_region()
  - pcim_iounmap_region()
  - _pcim_request_region()
  - pcim_request_region()
  - pcim_release_region()
  - pcim_request_all_regions()
  - pcim_release_all_regions()

Add new needed helper pcim_remove_bar_from_legacy_table().

Rework the following public interfaces using the new infrastructure
listed above:
  - pcim_iomap_release()
  - pcim_iomap()
  - pcim_iounmap()
  - pcim_iomap_regions()
  - pcim_iomap_regions_request_all()
  - pcim_iounmap_regions()

Update API documentation.

Link: https://lore.kernel.org/r/20240605081605.18769-5-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 608 ++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.c    |  22 ++
 drivers/pci/pci.h    |   5 +
 3 files changed, 568 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 845d6fab0ce7..cf2c11b54ca6 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -4,14 +4,243 @@
 #include "pci.h"
 
 /*
- * PCI iomap devres
+ * On the state of PCI's devres implementation:
+ *
+ * The older devres API for PCI has two significant problems:
+ *
+ * 1. It is very strongly tied to the statically allocated mapping table in
+ *    struct pcim_iomap_devres below. This is mostly solved in the sense of the
+ *    pcim_ functions in this file providing things like ranged mapping by
+ *    bypassing this table, wheras the functions that were present in the old
+ *    API still enter the mapping addresses into the table for users of the old
+ *    API.
+ *
+ * 2. The region-request-functions in pci.c do become managed IF the device has
+ *    been enabled with pcim_enable_device() instead of pci_enable_device().
+ *    This resulted in the API becoming inconsistent: Some functions have an
+ *    obviously managed counter-part (e.g., pci_iomap() <-> pcim_iomap()),
+ *    whereas some don't and are never managed, while others don't and are
+ *    _sometimes_ managed (e.g. pci_request_region()).
+ *
+ *    Consequently, in the new API, region requests performed by the pcim_
+ *    functions are automatically cleaned up through the devres callback
+ *    pcim_addr_resource_release(), while requests performed by
+ *    pcim_enable_device() + pci_*region*() are automatically cleaned up
+ *    through the for-loop in pcim_release().
+ *
+ * TODO 1:
+ * Remove the legacy table entirely once all calls to pcim_iomap_table() in
+ * the kernel have been removed.
+ *
+ * TODO 2:
+ * Port everyone calling pcim_enable_device() + pci_*region*() to using the
+ * pcim_ functions. Then, remove all devres functionality from pci_*region*()
+ * functions and remove the associated cleanups described above in point #2.
  */
-#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
 
+/*
+ * Legacy struct storing addresses to whole mapped BARs.
+ */
 struct pcim_iomap_devres {
-	void __iomem *table[PCIM_IOMAP_MAX];
+	void __iomem *table[PCI_STD_NUM_BARS];
+};
+
+enum pcim_addr_devres_type {
+	/* Default initializer. */
+	PCIM_ADDR_DEVRES_TYPE_INVALID,
+
+	/* A requested region spanning an entire BAR. */
+	PCIM_ADDR_DEVRES_TYPE_REGION,
+
+	/*
+	 * A requested region spanning an entire BAR, and a mapping for
+	 * the entire BAR.
+	 */
+	PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING,
+
+	/*
+	 * A mapping within a BAR, either spanning the whole BAR or just a
+	 * range.  Without a requested region.
+	 */
+	PCIM_ADDR_DEVRES_TYPE_MAPPING,
 };
 
+/*
+ * This struct envelops IO or MEM addresses, i.e., mappings and region
+ * requests, because those are very frequently requested and released
+ * together.
+ */
+struct pcim_addr_devres {
+	enum pcim_addr_devres_type type;
+	void __iomem *baseaddr;
+	unsigned long offset;
+	unsigned long len;
+	short bar;
+};
+
+static inline void pcim_addr_devres_clear(struct pcim_addr_devres *res)
+{
+	memset(res, 0, sizeof(*res));
+	res->bar = -1;
+}
+
+/*
+ * The following functions, __pcim_*_region*, exist as counterparts to the
+ * versions from pci.c - which, unfortunately, can be in "hybrid mode", i.e.,
+ * sometimes managed, sometimes not.
+ *
+ * To separate the APIs cleanly, we define our own, simplified versions here.
+ */
+
+/**
+ * __pcim_request_region_range - Request a ranged region
+ * @pdev: PCI device the region belongs to
+ * @bar: BAR the range is within
+ * @offset: offset from the BAR's start address
+ * @maxlen: length in bytes, beginning at @offset
+ * @name: name associated with the request
+ * @req_flags: flags for the request, e.g., for kernel-exclusive requests
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ *
+ * Request a range within a device's PCI BAR.  Sanity check the input.
+ */
+static int __pcim_request_region_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long maxlen,
+		const char *name, int req_flags)
+{
+	resource_size_t start = pci_resource_start(pdev, bar);
+	resource_size_t len = pci_resource_len(pdev, bar);
+	unsigned long dev_flags = pci_resource_flags(pdev, bar);
+
+	if (start == 0 || len == 0) /* Unused BAR. */
+		return 0;
+	if (len <= offset)
+		return  -EINVAL;
+
+	start += offset;
+	len -= offset;
+
+	if (len > maxlen && maxlen != 0)
+		len = maxlen;
+
+	if (dev_flags & IORESOURCE_IO) {
+		if (!request_region(start, len, name))
+			return -EBUSY;
+	} else if (dev_flags & IORESOURCE_MEM) {
+		if (!__request_mem_region(start, len, name, req_flags))
+			return -EBUSY;
+	} else {
+		/* That's not a device we can request anything on. */
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __pcim_release_region_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long maxlen)
+{
+	resource_size_t start = pci_resource_start(pdev, bar);
+	resource_size_t len = pci_resource_len(pdev, bar);
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (len <= offset || start == 0)
+		return;
+
+	if (len == 0 || maxlen == 0) /* This an unused BAR. Do nothing. */
+		return;
+
+	start += offset;
+	len -= offset;
+
+	if (len > maxlen)
+		len = maxlen;
+
+	if (flags & IORESOURCE_IO)
+		release_region(start, len);
+	else if (flags & IORESOURCE_MEM)
+		release_mem_region(start, len);
+}
+
+static int __pcim_request_region(struct pci_dev *pdev, int bar,
+		const char *name, int flags)
+{
+	unsigned long offset = 0;
+	unsigned long len = pci_resource_len(pdev, bar);
+
+	return __pcim_request_region_range(pdev, bar, offset, len, name, flags);
+}
+
+static void __pcim_release_region(struct pci_dev *pdev, int bar)
+{
+	unsigned long offset = 0;
+	unsigned long len = pci_resource_len(pdev, bar);
+
+	__pcim_release_region_range(pdev, bar, offset, len);
+}
+
+static void pcim_addr_resource_release(struct device *dev, void *resource_raw)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_addr_devres *res = resource_raw;
+
+	switch (res->type) {
+	case PCIM_ADDR_DEVRES_TYPE_REGION:
+		__pcim_release_region(pdev, res->bar);
+		break;
+	case PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING:
+		pci_iounmap(pdev, res->baseaddr);
+		__pcim_release_region(pdev, res->bar);
+		break;
+	case PCIM_ADDR_DEVRES_TYPE_MAPPING:
+		pci_iounmap(pdev, res->baseaddr);
+		break;
+	default:
+		break;
+	}
+}
+
+static struct pcim_addr_devres *pcim_addr_devres_alloc(struct pci_dev *pdev)
+{
+	struct pcim_addr_devres *res;
+
+	res = devres_alloc_node(pcim_addr_resource_release, sizeof(*res),
+			GFP_KERNEL, dev_to_node(&pdev->dev));
+	if (res)
+		pcim_addr_devres_clear(res);
+	return res;
+}
+
+/* Just for consistency and readability. */
+static inline void pcim_addr_devres_free(struct pcim_addr_devres *res)
+{
+	devres_free(res);
+}
+
+/*
+ * Used by devres to identify a pcim_addr_devres.
+ */
+static int pcim_addr_resources_match(struct device *dev, void *a_raw, void *b_raw)
+{
+	struct pcim_addr_devres *a, *b;
+
+	a = a_raw;
+	b = b_raw;
+
+	if (a->type != b->type)
+		return 0;
+
+	switch (a->type) {
+	case PCIM_ADDR_DEVRES_TYPE_REGION:
+	case PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING:
+		return a->bar == b->bar;
+	case PCIM_ADDR_DEVRES_TYPE_MAPPING:
+		return a->baseaddr == b->baseaddr;
+	default:
+		return 0;
+	}
+}
 
 static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
 {
@@ -92,8 +321,8 @@ EXPORT_SYMBOL(devm_pci_remap_cfgspace);
  *
  * All operations are managed and will be undone on driver detach.
  *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example::
+ * Returns a pointer to the remapped memory or an IOMEM_ERR_PTR() encoded error
+ * code on failure. Usage example::
  *
  *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
@@ -172,6 +401,17 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_devres *this = res;
 	int i;
 
+	/*
+	 * This is legacy code.
+	 *
+	 * All regions requested by a pcim_ function do get released through
+	 * pcim_addr_resource_release(). Thanks to the hybrid nature of the pci_
+	 * region-request functions, this for-loop has to release the regions
+	 * if they have been requested by such a function.
+	 *
+	 * TODO: Remove this once all users of pcim_enable_device() PLUS
+	 * pci-region-request-functions have been ported to pcim_ functions.
+	 */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
 		if (mask_contains_bar(this->region_mask, i))
 			pci_release_region(dev, i);
@@ -258,19 +498,21 @@ EXPORT_SYMBOL(pcim_pin_device);
 
 static void pcim_iomap_release(struct device *gendev, void *res)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pcim_iomap_devres *this = res;
-	int i;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (this->table[i])
-			pci_iounmap(dev, this->table[i]);
+	/*
+	 * Do nothing. This is legacy code.
+	 *
+	 * Cleanup of the mappings is now done directly through the callbacks
+	 * registered when creating them.
+	 */
 }
 
 /**
  * pcim_iomap_table - access iomap allocation table
  * @pdev: PCI device to access iomap table for
  *
+ * Returns:
+ * Const pointer to array of __iomem pointers on success, NULL on failure.
+ *
  * Access iomap allocation table for @dev.  If iomap table doesn't
  * exist and @pdev is managed, it will be allocated.  All iomaps
  * recorded in the iomap table are automatically unmapped on driver
@@ -343,30 +585,67 @@ static void pcim_remove_mapping_from_legacy_table(struct pci_dev *pdev,
 	}
 }
 
+/*
+ * The same as pcim_remove_mapping_from_legacy_table(), but identifies the
+ * mapping by its BAR index.
+ */
+static void pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, short bar)
+{
+	void __iomem **legacy_iomap_table;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return;
+
+	legacy_iomap_table[bar] = NULL;
+}
+
 /**
  * pcim_iomap - Managed pcim_iomap()
  * @pdev: PCI device to iomap for
  * @bar: BAR to iomap
  * @maxlen: Maximum length of iomap
  *
- * Managed pci_iomap().  Map is automatically unmapped on driver
- * detach.
+ * Returns: __iomem pointer on success, NULL on failure.
+ *
+ * Managed pci_iomap(). Map is automatically unmapped on driver detach. If
+ * desired, unmap manually only with pcim_iounmap().
+ *
+ * This SHOULD only be used once per BAR.
+ *
+ * NOTE:
+ * Contrary to the other pcim_* functions, this function does not return an
+ * IOMEM_ERR_PTR() on failure, but a simple NULL. This is done for backwards
+ * compatibility.
  */
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 {
 	void __iomem *mapping;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return NULL;
+	res->type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
 
 	mapping = pci_iomap(pdev, bar, maxlen);
 	if (!mapping)
-		return NULL;
+		goto err_iomap;
+	res->baseaddr = mapping;
 
 	if (pcim_add_mapping_to_legacy_table(pdev, mapping, bar) != 0)
 		goto err_table;
 
+	devres_add(&pdev->dev, res);
 	return mapping;
 
 err_table:
 	pci_iounmap(pdev, mapping);
+err_iomap:
+	pcim_addr_devres_free(res);
 	return NULL;
 }
 EXPORT_SYMBOL(pcim_iomap);
@@ -376,91 +655,291 @@ EXPORT_SYMBOL(pcim_iomap);
  * @pdev: PCI device to iounmap for
  * @addr: Address to unmap
  *
- * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
+ * Managed pci_iounmap(). @addr must have been mapped using a pcim_* mapping
+ * function.
  */
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 {
-	pci_iounmap(pdev, addr);
+	struct pcim_addr_devres res_searched;
+
+	pcim_addr_devres_clear(&res_searched);
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
+	res_searched.baseaddr = addr;
+
+	if (devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched) != 0) {
+		/* Doesn't exist. User passed nonsense. */
+		return;
+	}
 
 	pcim_remove_mapping_from_legacy_table(pdev, addr);
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
+/**
+ * pcim_iomap_region - Request and iomap a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: Index of a BAR to map
+ * @name: Name associated with the request
+ *
+ * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
+ *
+ * Mapping and region will get automatically released on driver detach. If
+ * desired, release manually only with pcim_iounmap_region().
+ */
+static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
+				       const char *name)
+{
+	int ret;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	res->type = PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING;
+	res->bar = bar;
+
+	ret = __pcim_request_region(pdev, bar, name, 0);
+	if (ret != 0)
+		goto err_region;
+
+	res->baseaddr = pci_iomap(pdev, bar, 0);
+	if (!res->baseaddr) {
+		ret = -EINVAL;
+		goto err_iomap;
+	}
+
+	devres_add(&pdev->dev, res);
+	return res->baseaddr;
+
+err_iomap:
+	__pcim_release_region(pdev, bar);
+err_region:
+	pcim_addr_devres_free(res);
+
+	return IOMEM_ERR_PTR(ret);
+}
+
+/**
+ * pcim_iounmap_region - Unmap and release a PCI BAR
+ * @pdev: PCI device to operate on
+ * @bar: Index of BAR to unmap and release
+ *
+ * Unmap a BAR and release its region manually. Only pass BARs that were
+ * previously mapped by pcim_iomap_region().
+ */
+static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+{
+	struct pcim_addr_devres res_searched;
+
+	pcim_addr_devres_clear(&res_searched);
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_REGION_MAPPING;
+	res_searched.bar = bar;
+
+	devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched);
+}
+
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to request and iomap
- * @name: Name used when requesting regions
+ * @name: Name associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
  *
  * Request and iomap regions specified by @mask.
  */
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 {
-	void __iomem * const *iomap;
-	int i, rc;
+	int ret;
+	short bar;
+	void __iomem *mapping;
 
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return -ENOMEM;
+	for (bar = 0; bar < DEVICE_COUNT_RESOURCE; bar++) {
+		if (!mask_contains_bar(mask, bar))
+			continue;
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long len;
+		mapping = pcim_iomap_region(pdev, bar, name);
+		if (IS_ERR(mapping)) {
+			ret = PTR_ERR(mapping);
+			goto err;
+		}
+		ret = pcim_add_mapping_to_legacy_table(pdev, mapping, bar);
+		if (ret != 0)
+			goto err;
+	}
 
-		if (!mask_contains_bar(mask, i))
-			continue;
+	return 0;
 
-		rc = -EINVAL;
-		len = pci_resource_len(pdev, i);
-		if (!len)
-			goto err_inval;
+err:
+	while (--bar >= 0) {
+		pcim_iounmap_region(pdev, bar);
+		pcim_remove_bar_from_legacy_table(pdev, bar);
+	}
 
-		rc = pci_request_region(pdev, i, name);
-		if (rc)
-			goto err_inval;
+	return ret;
+}
+EXPORT_SYMBOL(pcim_iomap_regions);
 
-		rc = -ENOMEM;
-		if (!pcim_iomap(pdev, i, 0))
-			goto err_region;
+static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
+		int request_flags)
+{
+	int ret;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return -ENOMEM;
+	res->type = PCIM_ADDR_DEVRES_TYPE_REGION;
+	res->bar = bar;
+
+	ret = __pcim_request_region(pdev, bar, name, request_flags);
+	if (ret != 0) {
+		pcim_addr_devres_free(res);
+		return ret;
 	}
 
+	devres_add(&pdev->dev, res);
 	return 0;
+}
 
- err_region:
-	pci_release_region(pdev, i);
- err_inval:
-	while (--i >= 0) {
-		if (!mask_contains_bar(mask, i))
-			continue;
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
+/**
+ * pcim_request_region - Request a PCI BAR
+ * @pdev: PCI device to requestion region for
+ * @bar: Index of BAR to request
+ * @name: Name associated with the request
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ *
+ * Request region specified by @bar.
+ *
+ * The region will automatically be released on driver detach. If desired,
+ * release manually only with pcim_release_region().
+ */
+static int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
+{
+	return _pcim_request_region(pdev, bar, name, 0);
+}
+
+/**
+ * pcim_release_region - Release a PCI BAR
+ * @pdev: PCI device to operate on
+ * @bar: Index of BAR to release
+ *
+ * Release a region manually that was previously requested by
+ * pcim_request_region().
+ */
+static void pcim_release_region(struct pci_dev *pdev, int bar)
+{
+	struct pcim_addr_devres res_searched;
+
+	pcim_addr_devres_clear(&res_searched);
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_REGION;
+	res_searched.bar = bar;
+
+	devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched);
+}
+
+
+/**
+ * pcim_release_all_regions - Release all regions of a PCI-device
+ * @pdev: the PCI device
+ *
+ * Release all regions previously requested through pcim_request_region()
+ * or pcim_request_all_regions().
+ *
+ * Can be called from any context, i.e., not necessarily as a counterpart to
+ * pcim_request_all_regions().
+ */
+static void pcim_release_all_regions(struct pci_dev *pdev)
+{
+	short bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		pcim_release_region(pdev, bar);
+}
+
+/**
+ * pcim_request_all_regions - Request all regions
+ * @pdev: PCI device to map IO resources for
+ * @name: name associated with the request
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * Requested regions will automatically be released at driver detach. If
+ * desired, release individual regions with pcim_release_region() or all of
+ * them at once with pcim_release_all_regions().
+ */
+static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+{
+	int ret;
+	short bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		ret = pcim_request_region(pdev, bar, name);
+		if (ret != 0)
+			goto err;
 	}
 
-	return rc;
+	return 0;
+
+err:
+	pcim_release_all_regions(pdev);
+
+	return ret;
 }
-EXPORT_SYMBOL(pcim_iomap_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
- * @name: Name used when requesting regions
+ * @name: Name associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
  *
  * Request all PCI BARs and iomap regions specified by @mask.
+ *
+ * To release these resources manually, call pcim_release_region() for the
+ * regions and pcim_iounmap() for the mappings.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
 {
-	int request_mask = ((1 << 6) - 1) & ~mask;
-	int rc;
+	short bar;
+	int ret;
+	void __iomem **legacy_iomap_table;
 
-	rc = pci_request_selected_regions(pdev, request_mask, name);
-	if (rc)
-		return rc;
+	ret = pcim_request_all_regions(pdev, name);
+	if (ret != 0)
+		return ret;
 
-	rc = pcim_iomap_regions(pdev, mask, name);
-	if (rc)
-		pci_release_selected_regions(pdev, request_mask);
-	return rc;
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!mask_contains_bar(mask, bar))
+			continue;
+		if (!pcim_iomap(pdev, bar, 0))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	/*
+	 * If bar is larger than 0, then pcim_iomap() above has most likely
+	 * failed because of -EINVAL. If it is equal 0, most likely the table
+	 * couldn't be created, indicating -ENOMEM.
+	 */
+	ret = bar > 0 ? -EINVAL : -ENOMEM;
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+
+	while (--bar >= 0)
+		pcim_iounmap(pdev, legacy_iomap_table[bar]);
+
+	pcim_release_all_regions(pdev);
+
+	return ret;
 }
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
@@ -473,19 +952,14 @@ EXPORT_SYMBOL(pcim_iomap_regions_request_all);
  */
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 {
-	void __iomem * const *iomap;
-	int i;
+	short bar;
 
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
-		if (!mask_contains_bar(mask, i))
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!mask_contains_bar(mask, bar))
 			continue;
 
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
+		pcim_iounmap_region(pdev, bar);
+		pcim_remove_bar_from_legacy_table(pdev, bar);
 	}
 }
 EXPORT_SYMBOL(pcim_iounmap_regions);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59e0949fb079..d94445f5f882 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3883,6 +3883,17 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
 
+	/*
+	 * This devres utility makes this function sometimes managed
+	 * (when pcim_enable_device() has been called before).
+	 *
+	 * This is bad because it conflicts with the pcim_ functions being
+	 * exclusively responsible for managed PCI. Its "sometimes yes,
+	 * sometimes no" nature can cause bugs.
+	 *
+	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
+	 * a region request function have been ported to using pcim_ functions.
+	 */
 	dr = find_pci_dr(pdev);
 	if (dr)
 		dr->region_mask &= ~(1 << bar);
@@ -3927,6 +3938,17 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 			goto err_out;
 	}
 
+	/*
+	 * This devres utility makes this function sometimes managed
+	 * (when pcim_enable_device() has been called before).
+	 *
+	 * This is bad because it conflicts with the pcim_ functions being
+	 * exclusively responsible for managed pci. Its "sometimes yes,
+	 * sometimes no" nature can cause bugs.
+	 *
+	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
+	 * a region request function have been ported to using pcim_ functions.
+	 */
 	dr = find_pci_dr(pdev);
 	if (dr)
 		dr->region_mask |= 1 << bar;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..c09487f5550c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -826,6 +826,11 @@ struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
+
+	/*
+	 * TODO: remove the region_mask once everyone calling
+	 * pcim_enable_device() + pci_*region*() is ported to pcim_ functions.
+	 */
 	u32 region_mask;
 };
 
-- 
2.45.0


