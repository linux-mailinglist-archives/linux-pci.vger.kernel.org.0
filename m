Return-Path: <linux-pci+bounces-35870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93DAB52ADB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC5B178E7B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359E2C21D1;
	Thu, 11 Sep 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBmRQFhr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEA2C11FC;
	Thu, 11 Sep 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577435; cv=none; b=sOpxOSsCAribI+0PjAwncc5Zx1Uc7SvIfAUGcY/l+c4CF8oOb8laBKyYTx8X70zvuRrV+6w7jMNViS4SW7n8lB5HKkdJtLZG7CALA7/fVskqn7c+t6HCz0bqST0YuKEubhuWqGu4Kf9vUyu/eFuazc/fyyfcmVa3z4kT3A57dSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577435; c=relaxed/simple;
	bh=lE1YC+dX33i+aMnsuUWLhFtM6ENVPF0fEcJ9ldn7GHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNdekZqP7+pOeZQB1pdvV5Xng5Rn3favTQ3M7EayaWwgshQOD2+O6nJaVc46ExfgIS/gCGwxh/aQSp1395LlfiSjd5BJKu7VbiIPLFz/lq7fpxqQ12pjF1BqHmMvkMC9OueGuvIXUz11XewCOhFWbXmO5T8fiSlQLD3e2OKFYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBmRQFhr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577433; x=1789113433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lE1YC+dX33i+aMnsuUWLhFtM6ENVPF0fEcJ9ldn7GHw=;
  b=bBmRQFhrqcpErPbCXtRiTd+oqRJciv9VfPl+ZAhZ7CQABk2qEPNv93/o
   UaORi9kVMCt6a7pljD4KyklHfuRXYA5x5YVWfEGIBcasg9SDJWE3aP111
   EHijKzAcKaB0txHydbmpkQJTayqyj5Doxzh22aKiKERphto3BjxdtN16S
   Evflxamw5w+SxxPx0k5XzQpq1JBrg90DlsopgLKTbTqIfGI62+//2R6h2
   vQe3md2EeTfCeJJTm2mzgFP1PinbDVU+7ai9iBr7nRoMUip67+oN5YTb/
   i9MnSXtvfpOR0ky9CEx+TqjXrHtuYVHO2Z/l+DbQsRzOf/czDAeDKMjcx
   A==;
X-CSE-ConnectionGUID: 4kfvueONTU+MTaRDZ8tQmg==
X-CSE-MsgGUID: oqBHvdgnQ8iNYcZDDJ691Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="60012567"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="60012567"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:57:13 -0700
X-CSE-ConnectionGUID: YwZXk2OKQJuTD9OiEb/TCg==
X-CSE-MsgGUID: UemHOX5dRE2HANBySPjYbQ==
X-ExtLoop1: 1
Received: from opintica-mobl1 (HELO localhost) ([10.245.245.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:57:05 -0700
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
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/11] PCI: Improve Resizable BAR functions kernel doc
Date: Thu, 11 Sep 2025 10:55:58 +0300
Message-Id: <20250911075605.5277-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
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
---
 drivers/pci/rebar.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 020ed7a1b3aa..64315dd8b6bb 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -58,8 +58,9 @@ void pci_rebar_init(struct pci_dev *pdev)
  * @bar: BAR to find
  *
  * Helper to find the position of the ctrl register for a BAR.
- * Returns -ENOTSUPP if resizable BARs are not supported at all.
- * Returns -ENOENT if no ctrl register for the BAR could be found.
+ *
+ * Return: %-ENOTSUPP if resizable BARs are not supported at all,
+ *	   %-ENOENT if no ctrl register for the BAR could be found.
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 {
@@ -92,12 +93,15 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 }
 
 /**
- * pci_rebar_get_possible_sizes - get possible sizes for BAR
+ * pci_rebar_get_possible_sizes - get possible sizes for Resizable BAR
  * @pdev: PCI device
  * @bar: BAR to query
  *
  * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
+ * (bit 0=1MB, bit 31=128TB).
+ *
+ * Return: A bitmask of possible sizes (0=1MB, 31=128TB), or %0 if BAR isn't
+ *	   resizable.
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
+ * Return: BAR Size if @bar is resizable (bit 0=1MB, bit 31=128TB), or
+ *	   negative on error.
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


