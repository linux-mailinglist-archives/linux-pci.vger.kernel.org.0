Return-Path: <linux-pci+bounces-39018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45778BFC2D9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004BF19C6DA8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0D347BCD;
	Wed, 22 Oct 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMNahdaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B7347FF6;
	Wed, 22 Oct 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140079; cv=none; b=KnZQSChRbWJaLXSt/CJ42PYGvJAH1o5vO3JD40z6fkjFKTBMmFL3BOWg4JDWcfo8KKZkEzkbTjR3e59qGY2HEhLQR1eXutXq6jJlqeWQPdDoTECGDJO0sCJ3T4Xx2Ck32ejiJUk/2GIVmjPiqcdxcYREw4WT2ZqzabPlc85yj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140079; c=relaxed/simple;
	bh=7dDA5r45DpqR48Bjh2cAeEc+lrTwHi1nHyQ129++vzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5fxTi6of4c9MVm6NJGSsKGXD+aKD5LsVr43UZBgFxqlmT8xoufNL1eimItKamv8J6fnBUDhppUFx1ICuAFFYDAUTsdslFv5dLbU4yMET5DWjr8SSyQ+DXTVcv6tHfpgl83/kz0WrS4ONa9iJEI5Kbn6b4ScOhUt699vlGDWaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMNahdaT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140078; x=1792676078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7dDA5r45DpqR48Bjh2cAeEc+lrTwHi1nHyQ129++vzU=;
  b=OMNahdaTKgARisLg61ZlD8O+xHgQr2Sjbab/JuRYJjZrgqLG9moJrvar
   zcCOvvBAJO5arjO/xfoCPQVvRZRCqHkm669PZIabM3h8GbGqORltks673
   E44DB5DUanb4y8JMR6AkZvTYuIFBfrGgj8yAwc7wgeCkun18TsfiZ8MEW
   iJu0zloQTv/nB0D46dikhBXAMcz9RkTegPOTi92sLJqEx5uq9VSxLaqnu
   BlmNWHiV4OJsyxBRB49hY8v3WENJalotoajrTHlgXa6MGT5xstFbgeUXc
   /t+ZgGpbYUKeaKr7FxzESvBUWCuyDCqlXDJ/P9EdILQJM/tAkGi8AC6nD
   A==;
X-CSE-ConnectionGUID: vnZGmKwhTCGkQ0avaB3fFw==
X-CSE-MsgGUID: DoToZovMSLmcy2IDlgOsaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74406334"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="74406334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:37 -0700
X-CSE-ConnectionGUID: EHwmon55TJSRkDgCzrbW5g==
X-CSE-MsgGUID: pCR6JhyVQ0C4YwUBvp2OXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="187915991"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:34:30 -0700
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
Subject: [PATCH v3 04/11] PCI: Improve Resizable BAR functions kernel doc
Date: Wed, 22 Oct 2025 16:33:24 +0300
Message-Id: <20251022133331.4357-5-ilpo.jarvinen@linux.intel.com>
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

Fix the copy-pasted errors in the Resizable BAR handling functions
kernel doc and generally improve wording choices.

Fix the formatting errors of the Return: line.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/rebar.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 1d30dbb7fe82..17e7b664c4ce 100644
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


