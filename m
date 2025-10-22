Return-Path: <linux-pci+bounces-39019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA42BBFC3D8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BBD626F5E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20157348470;
	Wed, 22 Oct 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdHWhOsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A9347BD8;
	Wed, 22 Oct 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140094; cv=none; b=qTcEOYCBJ2nLgvHTXu1TCj2wtLBKblTDIcKFMhFkiU9fRYI9epU3HZwr1/hcqraha8dJto7GjpG2rR3ooOdzsh/yJ3WlekLKuL00h1J9Uz1kAC/HkYH6JzrfPqM1IvQRN7otZdCg7F5PjDvwpYfUdz2GRGHmI/FrqtIpxjTOojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140094; c=relaxed/simple;
	bh=h2Fhfh8UiaFwG9K8ze69qLMHeEgSfFO/h7elyAOg/0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc7zNczMpQU+YplQGA2eResfsOBxv7e+GnO9gMXGBVFF+R3GpKwDSn+uNAzxCJhPyl0eHf7P/kuD2l2SX1xAASpNncX/Fj6l4jC046JE5nOJOyjfK0FGGyM4NuILXd6lBgORQLbg0of/bSb3+1hEzOtkxxJDs47PCbjc56D/UkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdHWhOsh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140092; x=1792676092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2Fhfh8UiaFwG9K8ze69qLMHeEgSfFO/h7elyAOg/0w=;
  b=DdHWhOsh2li2tYB9xbQheix3nQfplO9lXPHWOsTOTw4mqrxyz5ctK0OV
   7I9PdaDtlgHVIgh0krivO9qlR+J32D+DjLuumvCQZqDgAhcL5pWStSeMU
   vpY4M2o07UwmIokN50ZBl3Z2du7/jIAX14b5vMQvLM7VxeTOjsCJJsBUR
   pBG1i+vRAvGq5Qky1v2agXK6tdcfT5A5AePt4XlJGf7yuZjSzLuxgVu7r
   TlVyus0iB69PCFREn8koD/7wfqs6uLffKtyaiMj+aUT2IMf13OM9NGjBc
   z6bws1KD1gM9LAyFcCT+/isibktmV9cUcCCuwFD74aWKXgI0oDOeGD2qX
   g==;
X-CSE-ConnectionGUID: Br4gN9xNQLakNiBVcTdWnw==
X-CSE-MsgGUID: UlKoQal1Rr+zmK0VptZOuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62317337"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="62317337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:50 -0700
X-CSE-ConnectionGUID: oPwrKvMlQlaAF0CWSOmDOw==
X-CSE-MsgGUID: fJFv78aGS3KYsH7qp1iVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214520399"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:43 -0700
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
Subject: [PATCH v3 05/11] PCI: Add pci_rebar_size_supported() helper
Date: Wed, 22 Oct 2025 16:33:25 +0300
Message-Id: <20251022133331.4357-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
References: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Many callers of pci_rebar_get_possible_sizes() are interested in
finding out if a particular BAR Size (PCIe r6.2 sec. 7.8.6.3) is
supported by the particular BAR.

Add pci_rebar_size_supported() into PCI core to make it easy for the
drivers to determine if the BAR Size is supported or not.

Use the new function in pci_resize_resource() and in
pci_iov_vf_bar_set_size().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/pci/iov.c   |  7 +------
 drivers/pci/rebar.c | 25 +++++++++++++++++++------
 include/linux/pci.h |  1 +
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 77dee43b7858..02f4e9cd3fbe 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1339,7 +1339,6 @@ EXPORT_SYMBOL_GPL(pci_sriov_configure_simple);
  */
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 {
-	u32 sizes;
 	int ret;
 
 	if (!pci_resource_is_iov(resno))
@@ -1348,11 +1347,7 @@ int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 	if (pci_iov_is_memory_decoding_enabled(dev))
 		return -EBUSY;
 
-	sizes = pci_rebar_get_possible_sizes(dev, resno);
-	if (!sizes)
-		return -ENOTSUPP;
-
-	if (!(sizes & BIT(size)))
+	if (!pci_rebar_size_supported(dev, resno, size))
 		return -EINVAL;
 
 	ret = pci_rebar_set_size(dev, resno, size);
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 17e7b664c4ce..067cd75b394b 100644
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
@@ -231,7 +249,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	struct resource *res = pci_resource_n(dev, resno);
 	struct pci_host_bridge *host;
 	int old, ret;
-	u32 sizes;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -245,11 +262,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
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
index 0a50912c5ce5..cf833daddaee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1424,6 +1424,7 @@ int pci_release_resource(struct pci_dev *dev, int resno);
 int pci_rebar_bytes_to_size(u64 bytes);
 resource_size_t pci_rebar_size_to_bytes(int size);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
+bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
-- 
2.39.5


