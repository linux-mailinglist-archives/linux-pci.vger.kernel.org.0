Return-Path: <linux-pci+bounces-41151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50449C5976E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A29F502F5F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB52730748E;
	Thu, 13 Nov 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQGfWQC8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D712FBDE2;
	Thu, 13 Nov 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056911; cv=none; b=ObD8rhUX+Ut4GJVW4f+apOZfSefSWig0J1wAHK9+ZH7GAzelWYwMcouwS/6mvrKFA4F2B4aljX0aqTxogh4a36lpD4P4T8HA1Y7/cUlaP8T0Xk/ASpX+4hHoVpeNVKsRbWmrKFIM5n4F7tH4mfE51lr0GVb+P8e4DYCn5mFn7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056911; c=relaxed/simple;
	bh=DhatKJFXqqwKu6DghbCbpp5pfXLE9DijpjZOhPHBtYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7OW4/ErMPGFt8aC7/1kGldmKvA/ORotnrKWWLWWUXKsvEZvgwLS6M8oj++y4ZXwvB9XZbQX6uUql3RcpBSYTbU5T/2lBGQoBVoVo0tU0P6IAN7H+QrMKAES0X5kC6684Owq7OCdwUvPMaXA4jSmu4PhgQomLYRTT3/S4v7ovVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQGfWQC8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056910; x=1794592910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DhatKJFXqqwKu6DghbCbpp5pfXLE9DijpjZOhPHBtYk=;
  b=nQGfWQC80Agbo5tiaI3ViT8u745hyjpefvB65tgJjBWxpScSw4Mpdvie
   GA5Th9KDhHEv2QjOEaWKlcR8rqMw7aazO6WP73qHNPkk+n0TGZkDjfA4q
   xrjBsdIj+KUBCsdMRkr+56aHGSvgkBgIQMbMm5cl5gG9YIrhNUK3JQQ2o
   DPteINiyJEE7DI2icVzeIJv20CBNKO7h3Qr4J3ni7GJnk/1G9vzZH9BS3
   c/uFzQp+GpxJ/6teuuTA6v0+7yFxWzT+WNuUMBJ8xeP/j0d1FxzThv0AF
   8M+vaxAjReW3WneXsBuUp27/wcCVSor6e0xLjNdNIoBUUZB+izvt2pgNI
   g==;
X-CSE-ConnectionGUID: 0j1rasHKQLCAPZA2XOILSQ==
X-CSE-MsgGUID: QTnC0n0OTV2lFZCnM213tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="52711013"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="52711013"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:49 -0800
X-CSE-ConnectionGUID: C+c1PLI8Q2uZB2xzBtTl+A==
X-CSE-MsgGUID: fis5VgY/Ri2ayuh8e41zzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189574086"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:42 -0800
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
Subject: [PATCH v4 03/11] PCI: Move pci_rebar_size_to_bytes() and export it
Date: Thu, 13 Nov 2025 20:00:45 +0200
Message-Id: <20251113180053.27944-4-ilpo.jarvinen@linux.intel.com>
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

pci_rebar_size_to_bytes() is in drivers/pci/pci.h but would be useful for
endpoint drivers as well.

Move the function to rebar.c and export it.

In addition, convert the literal to where the number comes from
(PCI_REBAR_MIN_SIZE).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.h   |  4 ----
 drivers/pci/rebar.c | 12 ++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 41df35920632..a1e7dbeb0f2c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1024,10 +1024,6 @@ void pci_rebar_init(struct pci_dev *pdev);
 void pci_restore_rebar_state(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
-static inline u64 pci_rebar_size_to_bytes(int size)
-{
-	return 1ULL << (size + 20);
-}
 
 struct device_node;
 
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 0eb6fc445703..8b291d3e0ad4 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -35,6 +35,18 @@ int pci_rebar_bytes_to_size(u64 bytes)
 }
 EXPORT_SYMBOL_GPL(pci_rebar_bytes_to_size);
 
+/**
+ * pci_rebar_size_to_bytes - Convert BAR Size to bytes
+ * @size: BAR Size as defined in the PCIe spec (0=1MB, 31=128TB)
+ *
+ * Return: BAR size in bytes.
+ */
+resource_size_t pci_rebar_size_to_bytes(int size)
+{
+	return 1ULL << (size + ilog2(PCI_REBAR_MIN_SIZE));
+}
+EXPORT_SYMBOL_GPL(pci_rebar_size_to_bytes);
+
 void pci_rebar_init(struct pci_dev *pdev)
 {
 	pdev->rebar_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 628dda63b9e0..33b27e0c4f3e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1422,6 +1422,7 @@ int pci_release_resource(struct pci_dev *dev, int resno);
 
 /* Resizable BAR related routines */
 int pci_rebar_bytes_to_size(u64 bytes);
+resource_size_t pci_rebar_size_to_bytes(int size);
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
 int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
 				     int exclude_bars);
-- 
2.39.5


