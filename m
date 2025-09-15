Return-Path: <linux-pci+bounces-36128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919FB5746E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A15E4423C3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1732F5315;
	Mon, 15 Sep 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTXNgEvG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381C41760;
	Mon, 15 Sep 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927710; cv=none; b=RFxtzYjpA4X8l0JTv3FmaCyE8nlUl79U15NrxB6yEupqs4VZKkJQhQAOx0Y/4xVFT9cpKsL/MAVjclRpnxuIomGHmR0/3qf1DD9Tp8B5OoRqcz1UX+gRkQQuSN8uDixSa+XzQgZe1ivhAYDeP0G9awU5kw8HSp32O4jNd1KFaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927710; c=relaxed/simple;
	bh=UlW/x18WpVqJlBUnfB+fi675NCbfKMYpyYe6GsuO0Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmhBh675XvJIDPh8wna/z9eg4vspG8wkFEMoGVHwprETUqjuT32+M1pVczJAU1DKKdu2kIJjFjd33OY24a/43mS1+ccLMcMeUcUhhOPLdSAK/8XcaeS6wgsIcA81QSBPDqsr48PHYCgDgGH4RISofAwmTTH1YPln5FtuvF+rMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTXNgEvG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927709; x=1789463709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlW/x18WpVqJlBUnfB+fi675NCbfKMYpyYe6GsuO0Vs=;
  b=HTXNgEvGnhy7aEJK5pVzUsXMVX2s9MKIDRfT3cOnnG+IfBNIYu4+jbJq
   uAPM4OabVOmOt3eeBEmBFHYOSQuwVa5fFiJxGjkVzYpXi/tve8eFqhxVG
   iiiLDjhRTqCOYqn0zTGc7BPHvoT448eVC+FJsCyubXZPmuGr1Op0Kbmf4
   TIHUwVz2AXzrojH7VhxVxFxXYh9+YlTdcfXteQQNweuHLbJw09FwP0wwB
   oh61Fu7Buac3imR9rcwpZvdDgSzHLE7INGP37xsU0wQ5pjf/Nm4CRGI5t
   8wQLKv9lisBx6yKHPCgN1tptk4qAtoaqF0Jw6xbcMZO8FU/GPuj2qV9aC
   A==;
X-CSE-ConnectionGUID: L56/CbwVRDGDUDdQr6HNiw==
X-CSE-MsgGUID: i0O/DQxiSnCGgWed/5ihQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59870327"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59870327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:15:08 -0700
X-CSE-ConnectionGUID: 3T4YvfAtQv6PFR+x1hPa8A==
X-CSE-MsgGUID: Tqk5gVpMRDuLNJZCyLNGLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178917734"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:15:01 -0700
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
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/11] PCI: Improve Resizable BAR functions kernel doc
Date: Mon, 15 Sep 2025 12:13:51 +0300
Message-Id: <20250915091358.9203-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the copy-pasted errors in the Resizable BAR handling functions
kernel doc and generally improve wording choices.

Fix the formatting errors of the Return: line.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/rebar.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 0c943d9e3a08..b1bd24a72bcc 100644
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


