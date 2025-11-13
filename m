Return-Path: <linux-pci+bounces-41153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0487C597AA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B6E7503F73
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A11351FB4;
	Thu, 13 Nov 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DszZ9EAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C13043B8;
	Thu, 13 Nov 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056939; cv=none; b=HDS+QFXa1Vw5r/2ow1aBE6PHRErUEwet1+c1m+jC3E91ATqAzT022A7+1VYTVsJqa9mpbFdNp89/iMGTrLYFFXHsROgispzWfQ3Hd9i/ZyfaYxHY1H+skPrMvbc1FNxqHRz9QpRhX9xfGgXzC3oSUK7P7T/oQf7qr+C3HFRgSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056939; c=relaxed/simple;
	bh=KWVOrKsnU84ElVsjEKI0K/T3KtiSa/Dqo7sQOK27lBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5J3wOOvDHXvm1TaFkVMMH0Lv/rl8BgQnfpQ5qSvq/7B8LgunmrONgT32B1gp1lkX36tAGyHg1XGzZkq+W7x9etitZzMVindsGSAwRSJ78NaaNSIS1lZU825gMNaJlQEEknSDQNLsd7cwqvu5ts8d+dm3XH/ffZP+Sr0rkzo+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DszZ9EAY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056937; x=1794592937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWVOrKsnU84ElVsjEKI0K/T3KtiSa/Dqo7sQOK27lBk=;
  b=DszZ9EAY18JjrG8FXOHL8ec1Z8Z1/2SZYdPtX/Xu8AIiiRqDkRwgVNSm
   yToEGBsKUiVMwiYHYge4Ilgy4WHtDMIJiJZyJrWc2f3FPFl4kGe1EIimm
   6C26TG2XbGR76g8Z5Ao9OSK7B9qMpjavsSMHO2B51P+u39QPKORgRFrom
   8LO5py2qqqIwRqtNGmrpWHIS9T2bfrVJFOCEZN87SdInN9WvMgi9Nyhwd
   2uUYuO4DohWw4jvxVmOswecAOujCgOMu383+Rkkxqkj03vwZuoMTFyYXo
   OUQu04oRvESHCCUGpXsZ9D3U0DS6DqevN8Ad0fJZlX/DZubSfRj7k419j
   g==;
X-CSE-ConnectionGUID: N9+9JxL1Qie/IbuvZ3f+6w==
X-CSE-MsgGUID: PP6GDi79QvK5LWklr1LSKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75826984"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75826984"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:02:16 -0800
X-CSE-ConnectionGUID: Y7CnD/rTTVepfEB7EGIrsQ==
X-CSE-MsgGUID: XnANxvDfQWuTaAIM0jt+6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="188823097"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:02:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 05/11] PCI: Add pci_rebar_size_supported() helper
Date: Thu, 13 Nov 2025 20:00:47 +0200
Message-Id: <20251113180053.27944-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
References: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Many callers of pci_rebar_get_possible_sizes() are interested in finding
out if a particular encoded BAR Size (PCIe r7.0, sec 7.8.6.3) is supported
by the particular BAR.

Add pci_rebar_size_supported() into PCI core to make it easy for the
drivers to determine if the BAR size is supported or not.

Use the new function in pci_resize_resource() and in
pci_iov_vf_bar_set_size().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/pci/iov.c   |  8 +-------
 drivers/pci/rebar.c | 25 +++++++++++++++++++------
 include/linux/pci.h |  1 +
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 04b675e90963..71ed85d38508 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1339,19 +1339,13 @@ EXPORT_SYMBOL_GPL(pci_sriov_configure_simple);
  */
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 {
-	u32 sizes;
-
 	if (!pci_resource_is_iov(resno))
 		return -EINVAL;
 
 	if (pci_iov_is_memory_decoding_enabled(dev))
 		return -EBUSY;
 
-	sizes = pci_rebar_get_possible_sizes(dev, resno);
-	if (!sizes)
-		return -ENOTSUPP;
-
-	if (!(sizes & BIT(size)))
+	if (!pci_rebar_size_supported(dev, resno, size))
 		return -EINVAL;
 
 	return pci_rebar_set_size(dev, resno, size);
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index e5c0ea6d6063..0e7bf2d380cf 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -3,6 +3,7 @@
  * PCI Resizable BAR Extended Capability handling.
  */
 
+#include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -124,6 +125,23 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 }
 EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
 
+/**
+ * pci_rebar_size_supported - check if size is supported for BAR
+ * @pdev: PCI device
+ * @bar: BAR to check
+ * @size: size as defined in the PCIe spec (0=1MB, 31=128TB)
+ *
+ * Return: %true if @bar is resizable and @size is a supported, otherwise
+ *	   %false.
+ */
+bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
+{
+	u64 sizes = pci_rebar_get_possible_sizes(pdev, bar);
+
+	return BIT(size) & sizes;
+}
+EXPORT_SYMBOL_GPL(pci_rebar_size_supported);
+
 /**
  * pci_rebar_get_current_size - get the current size of a Resizable BAR
  * @pdev: PCI device
@@ -252,7 +270,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 {
 	struct pci_host_bridge *host;
 	int old, ret;
-	u32 sizes;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -262,11 +279,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 	if (pci_resize_is_memory_decoding_enabled(dev, resno))
 		return -EBUSY;
 
-	sizes = pci_rebar_get_possible_sizes(dev, resno);
-	if (!sizes)
-		return -ENOTSUPP;
-
-	if (!(sizes & BIT(size)))
+	if (!pci_rebar_size_supported(dev, resno, size))
 		return -EINVAL;
 
 	old = pci_rebar_get_current_size(dev, resno);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33b27e0c4f3e..0ef827cfaf0c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1424,6 +1424,7 @@ int pci_release_resource(struct pci_dev *dev, int resno);
 int pci_rebar_bytes_to_size(u64 bytes);
 resource_size_t pci_rebar_size_to_bytes(int size);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
+bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
 				     int exclude_bars);
 
-- 
2.39.5


