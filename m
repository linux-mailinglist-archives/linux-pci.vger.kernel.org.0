Return-Path: <linux-pci+bounces-41156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA01C59575
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 479AA34EB59
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187435A123;
	Thu, 13 Nov 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wvwp5olN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456B30215B;
	Thu, 13 Nov 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056978; cv=none; b=e2vr6fei+c1CC/KzS78HTF851bs+4s3vscN06FEgCy53/D2/bzxjrBl3BbOfjZYXbZ7RfXdr5ViXqlIHUJ9XsGvsW2bqE5hRkIJTK8qA2C2GwkYkDFbtUoonjS6hMiPaBnysTwXdptYPGPhobO/nmUNTSz3OpRwnvd7GmKdJBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056978; c=relaxed/simple;
	bh=l0j9ML8iHiATiqtmWBVUlBorQSkfSz4beQCfgWXYnN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlYJ0GbZfLPTQ2GapCIFdvHzTywvjIAnNwULKF1x59ks+0lcuffIZRmq9IrMUcvs11EgNtTDP2Wkt2wrEPIpqqReTiGiLcznE5zJnLUNDppPp28+uL1tjR64/h3GglrDZV7gdhxG0TjZ6JgOpUx0gcun1ddhnqnEjgRFtYm2slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wvwp5olN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056977; x=1794592977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l0j9ML8iHiATiqtmWBVUlBorQSkfSz4beQCfgWXYnN4=;
  b=Wvwp5olNeqgSmZdHYu/1vNhJ/htcMZX02Bh74iTo95RVjryfLUsBK2yM
   T8JunuyH0F9dHduPoSQ6muEtJ0ec+kIU9bgNSc6UtbTJOEOs71uHAsFwB
   SCFb9hVTuOf42ukc/6lomKJsYNRxOQYjEW7VbqhRGGvggivnCnv1SB6wP
   K3VjXIW9c6N/qsUsJjQM5viKhbAyNR7I6xjL2OSqIKGDA4jHr1bzuxDo9
   4WUTBVbtJIGmKtVAYpHX5PruOresyAiIH16c8Nb7P6L/9QxaRKfB6tpJu
   YoJC+CzAaBxtecZ8Hdh4GtQ7HSnz3I19m8BqQrglMGs9yl9FmIkvlfC7O
   A==;
X-CSE-ConnectionGUID: Upj92HXRQ++bqcvYd6bM9A==
X-CSE-MsgGUID: mcv+EykOSEayTk9rlmNYjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76490856"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="76490856"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:02:54 -0800
X-CSE-ConnectionGUID: OZKbIj+1QzunwNdade7fiw==
X-CSE-MsgGUID: nvag0MhwTguX3yOZqHme5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189407984"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:02:47 -0800
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
Subject: [PATCH v4 08/11] PCI: Add pci_rebar_get_max_size()
Date: Thu, 13 Nov 2025 20:00:50 +0200
Message-Id: <20251113180053.27944-9-ilpo.jarvinen@linux.intel.com>
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

Add pci_rebar_get_max_size() to allow simplifying code that wants to know
the maximum possible size for a Resizable BAR.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/rebar.c | 23 +++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 0e7bf2d380cf..d85d458c7007 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -5,6 +5,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/ioport.h>
@@ -142,6 +143,28 @@ bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
 }
 EXPORT_SYMBOL_GPL(pci_rebar_size_supported);
 
+/**
+ * pci_rebar_get_max_size - get the maximum supported size of a BAR
+ * @pdev: PCI device
+ * @bar: BAR to query
+ *
+ * Get the largest supported size of a resizable BAR as a size.
+ *
+ * Returns: the maximum BAR size as defined in the PCIe spec (0=1MB, 31=128TB),
+ *	     or %-NOENT on error.
+ */
+int pci_rebar_get_max_size(struct pci_dev *pdev, int bar)
+{
+	u32 sizes;
+
+	sizes = pci_rebar_get_possible_sizes(pdev, bar);
+	if (!sizes)
+		return -ENOENT;
+
+	return __fls(sizes);
+}
+EXPORT_SYMBOL_GPL(pci_rebar_get_max_size);
+
 /**
  * pci_rebar_get_current_size - get the current size of a Resizable BAR
  * @pdev: PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ef827cfaf0c..898bc3a4e8e7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1425,6 +1425,7 @@ int pci_rebar_bytes_to_size(u64 bytes);
 resource_size_t pci_rebar_size_to_bytes(int size);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size);
+int pci_rebar_get_max_size(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
 				     int exclude_bars);
 
-- 
2.39.5


