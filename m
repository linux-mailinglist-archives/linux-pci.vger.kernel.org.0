Return-Path: <linux-pci+bounces-13518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56B9861DF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D0F1F2C922
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666053770D;
	Wed, 25 Sep 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHBfZpop"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAB142E6F
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275542; cv=none; b=C2Nem4xrMKkRf5jC5iRbh8az6z94whEGOlZqnWnKTa3crvwoL4pPvYFk9vyJHchawNFK8ejRZfaHZuLnqQsGg6xBkaWeex8WevM40MqJqvCtFOQzHaNfiGg0KjaBxDrtGrnLBzy8THhVWD+ctjuA6vbeYxKSNm7UmUVd3NnqspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275542; c=relaxed/simple;
	bh=e5g2fnzWsdbQ4Znq2+0nMCPlwsOCrNHuDaldxM9Sekk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH+cU94R/iNNVMWxfhsus4/lP4n+TK1XYh6JxcJdDjRUOMFBkQ371fsVdxpeyqcvYoaQ66NiSnmmD5k6rZrWd8XPdd5/Wxuyd7XbrFEokXpdZQCjo/E1U7fIwJUV5DIpFAYubsviCtcb9NugswWruHFXG41hh2ZSSM8d4oaZ+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHBfZpop; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727275541; x=1758811541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e5g2fnzWsdbQ4Znq2+0nMCPlwsOCrNHuDaldxM9Sekk=;
  b=eHBfZpop0kzWscOPUh8xdX4dE7DUt6A39ijzp09h85NoiZKaG0hcB5KH
   wWps3Ujxg6DwR53MfqIRC16RIOuq6EoxhLshDDkIB+h/V+c61lYgcgbzp
   BLTOltsiIbDN1GzSV9SOy16jZZBYo02XPtKHgp39TBx0Ru+FY3tWUKdSW
   hgSEo+i2oVnYZBtOaLrDZl541ozroItVMJW7RL3FIVSroqtQCucr1SQq0
   z4up+TBtxZfScXeaaDo10PJoImljtOq4qFRzQs8KksfGcJYvbKe1w8ktS
   tr49Pq1SgfBAiGGrFUC5m5sAa1c2RexoMsQXlh0r1xiAvivuQNYQdnD4o
   w==;
X-CSE-ConnectionGUID: 8897FihuT0SCkxOajlSRvw==
X-CSE-MsgGUID: S40o8kTYTEqQMDS7aPRYEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26470615"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26470615"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:45:41 -0700
X-CSE-ConnectionGUID: 0Reib3ztTeGILgK0oLTj7A==
X-CSE-MsgGUID: DwgRaTpNRFCAUyRZUhE12g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71941560"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 25 Sep 2024 07:45:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Sep 2024 17:45:37 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/6] drm/i915/pm: Simplify pm hook documentation
Date: Wed, 25 Sep 2024 17:45:23 +0300
Message-ID: <20240925144526.2482-4-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Stop spelling out each variant of the hook ("" vs. "_late" vs.
"_early") and just say eg. "@thaw*" to indicate all of them.
Avoids having to update the docs whenever we start/stop using
one of the variants.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 9d557ff8adf5..1e5abf72dfc4 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1644,18 +1644,18 @@ const struct dev_pm_ops i915_pm_ops = {
 
 	/*
 	 * S4 event handlers
-	 * @freeze, @freeze_late    : called (1) before creating the
-	 *                            hibernation image [PMSG_FREEZE] and
-	 *                            (2) after rebooting, before restoring
-	 *                            the image [PMSG_QUIESCE]
-	 * @thaw, @thaw_early       : called (1) after creating the hibernation
-	 *                            image, before writing it [PMSG_THAW]
-	 *                            and (2) after failing to create or
-	 *                            restore the image [PMSG_RECOVER]
-	 * @poweroff, @poweroff_late: called after writing the hibernation
-	 *                            image, before rebooting [PMSG_HIBERNATE]
-	 * @restore, @restore_early : called after rebooting and restoring the
-	 *                            hibernation image [PMSG_RESTORE]
+	 * @freeze*   : called (1) before creating the
+	 *              hibernation image [PMSG_FREEZE] and
+	 *              (2) after rebooting, before restoring
+	 *              the image [PMSG_QUIESCE]
+	 * @thaw*     : called (1) after creating the hibernation
+	 *              image, before writing it [PMSG_THAW]
+	 *              and (2) after failing to create or
+	 *              restore the image [PMSG_RECOVER]
+	 * @poweroff* : called after writing the hibernation
+	 *              image, before rebooting [PMSG_HIBERNATE]
+	 * @restore*  : called after rebooting and restoring the
+	 *              hibernation image [PMSG_RESTORE]
 	 */
 	.freeze = i915_pm_freeze,
 	.freeze_late = i915_pm_freeze_late,
-- 
2.44.2


