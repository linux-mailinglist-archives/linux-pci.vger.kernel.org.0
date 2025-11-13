Return-Path: <linux-pci+bounces-41152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1EAC59605
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF41E421E4F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA835A147;
	Thu, 13 Nov 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/Iv46p7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EC2F8BF7;
	Thu, 13 Nov 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056925; cv=none; b=m3YDeeR7qJtvC46My2lSPfQmv1tJf5WcK7/o+lFYPRU7U6EjfZRYRB29f2ogloizgLYzorUVH48EqX+NfzG73k7V9B9NFupQmH3zTds4pB0B2IWRkKkTjdnIDya1xt3Dr6lKbk7pKb6xrN32WwDkbYkfRUxmcni2jaof9CzjsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056925; c=relaxed/simple;
	bh=/KmtHteVBach0SNg6WkFUl1qwsEvVTIUJJw0hcwVH50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFaWMOyJe793N3AW8aXX3Rk8en9OEZ4YoSdAbjJvAKh6Ct2CJCvMM8ZHglz45xUwpAlZ8HTHbWcHlwIwnb2Y+pDyOAlhz+LORtYCG4V4Gkq28oJFYWJVANfVZo0FjWeEZKf3xmJXdjYJCaObXaZlZDeLfdxEy1IWqC0bpgq7f7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/Iv46p7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056923; x=1794592923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/KmtHteVBach0SNg6WkFUl1qwsEvVTIUJJw0hcwVH50=;
  b=c/Iv46p7Ss4moy8gzFZ2hyhdzmcrptfA/TZGKg1ZG0gdMrBRAIP8AvhE
   ETJTmmS0A/uF1u2SuElNhEaUyzHvXrV294tArD+XR1hQHp1txTHESWYs/
   unGnyQQ+p/1BgvUQc1F4hoBc3xmpV32KsZ4MAZl8Nt9H1Vky1gPD8Aear
   2xWoqXxWwAO/aSaoOZdFlenRWu2onon9uOG43ua42QtonfWmCxFJzlzE0
   KaKH/sZRj6vo/ExVqc9r8GszbRJ9B9KzI3qe9GW3teM7ohSujiDC50jzk
   WBEKWjTFybEgiWmSQ2jeqx7MXo0llfbku9bIYmcrEKR1J2hwG8qns6wG0
   g==;
X-CSE-ConnectionGUID: gQFxMml8Q3qSKc+z33qQ1Q==
X-CSE-MsgGUID: i23WXLqpRDe9J+ijTq1vnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="52711081"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="52711081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:02:03 -0800
X-CSE-ConnectionGUID: brgJPEi+RZ2fZ9Q30qgudw==
X-CSE-MsgGUID: KdwCgf3ETrCQzL3C4QS/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189574156"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:55 -0800
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
Subject: [PATCH v4 04/11] PCI: Improve Resizable BAR functions kernel doc
Date: Thu, 13 Nov 2025 20:00:46 +0200
Message-Id: <20251113180053.27944-5-ilpo.jarvinen@linux.intel.com>
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

Fix the copy-pasted errors in the Resizable BAR handling functions kernel
doc and generally improve wording choices.

Fix the formatting errors of the Return: line.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/rebar.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 8b291d3e0ad4..e5c0ea6d6063 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -53,13 +53,15 @@ void pci_rebar_init(struct pci_dev *pdev)
 }
 
 /**
- * pci_rebar_find_pos - find position of resize ctrl reg for BAR
+ * pci_rebar_find_pos - find position of resize control reg for BAR
  * @pdev: PCI device
  * @bar: BAR to find
  *
- * Helper to find the position of the ctrl register for a BAR.
- * Returns -ENOTSUPP if resizable BARs are not supported at all.
- * Returns -ENOENT if no ctrl register for the BAR could be found.
+ * Helper to find the position of the control register for a BAR.
+ *
+ * Return:
+ * * %-ENOTSUPP if resizable BARs are not supported at all,
+ * * %-ENOENT if no control register for the BAR could be found.
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 {
@@ -92,12 +94,14 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 }
 
 /**
- * pci_rebar_get_possible_sizes - get possible sizes for BAR
+ * pci_rebar_get_possible_sizes - get possible sizes for Resizable BAR
  * @pdev: PCI device
  * @bar: BAR to query
  *
- * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
+ * Get the possible sizes of a resizable BAR as bitmask.
+ *
+ * Return: A bitmask of possible sizes (bit 0=1MB, bit 31=128TB), or %0 if
+ *	   BAR isn't resizable.
  */
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 {
@@ -121,12 +125,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
 
 /**
- * pci_rebar_get_current_size - get the current size of a BAR
+ * pci_rebar_get_current_size - get the current size of a Resizable BAR
  * @pdev: PCI device
- * @bar: BAR to set size to
+ * @bar: BAR to get the size from
  *
- * Read the size of a BAR from the resizable BAR config.
- * Returns size if found or negative error code.
+ * Reads the current size of a BAR from the Resizable BAR config.
+ *
+ * Return: BAR Size if @bar is resizable (0=1MB, 31=128TB), or negative on
+ *         error.
  */
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
 {
@@ -142,13 +148,14 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
 }
 
 /**
- * pci_rebar_set_size - set a new size for a BAR
+ * pci_rebar_set_size - set a new size for a Resizable BAR
  * @pdev: PCI device
  * @bar: BAR to set size to
- * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ * @size: new size as defined in the PCIe spec (0=1MB, 31=128TB)
  *
  * Set the new size of a BAR as defined in the spec.
- * Returns zero if resizing was successful, error code otherwise.
+ *
+ * Return: %0 if resizing was successful, or negative on error.
  */
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 {
-- 
2.39.5


