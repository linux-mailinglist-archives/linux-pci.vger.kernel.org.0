Return-Path: <linux-pci+bounces-21062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFBA2E626
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49C21651D1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DA41BEF6D;
	Mon, 10 Feb 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlfCo4TQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BC1BEF66;
	Mon, 10 Feb 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175435; cv=none; b=TzykH9kPaQijLY7Wyad8yZ6xapCVGY+Dr4m7xfQ0nPIFNG+M3B62gF2zDEXB6DJyPL0as75XmMeDri1yrJ3dKDhygvDNPPdVVywQ87Nm77xWEAVutnzjxypXnVYLi0fzZLobDAqf+oxGdgo6jN3s19w/XVqQ9r8FQ6Y7wma8cTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175435; c=relaxed/simple;
	bh=15XwobDZ/nxt+VCdf6mkqla70g872PEAWLmuLKuwoJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr5tOuWmbaOGX6WT4beP3yD/u2K1GNTKv9QiYqiarxb9FCLno7sjoLHVrz8EQvz0aJ75LQYPRVXwg6qgh6vYJ7bBrQ4Vm71+OS/L/1iktciET+CFOXJyu9+EbOYGGwNOwA1Cm3waKuuI056mnszmiOhWHTt9MWypkghTCU6vuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlfCo4TQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739175434; x=1770711434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15XwobDZ/nxt+VCdf6mkqla70g872PEAWLmuLKuwoJg=;
  b=nlfCo4TQu1XVcvWOZ54M5jFM752f4i1GE737rL4lgFQU6y47usRUH9/f
   fBYaJsHydLOK/jMFrpFPmindVMRvTGziqEgLgAGljcJdpp4RjYqvjgBkT
   2Pi5eMQTRc9mcV97c5uOLWFY6WQ2i8aMIO6FctTYsnxL4bAwS7Rnc5go8
   nK8kTg1AHjqjcNo1OBdPGO5CDRV+nVIxRdiis2V24Z0Q6GwHJ+Hs58zJh
   /auBGQermNDYOfN4aAWy1dVwUY16Rk9yA2yPSChKhTrDSsNl9ZrYXCvuS
   v86/6bKj8/D8l7MDO8BjkZ2Gid5OlTJuzdbQnAgqyxl+fIX8ztGnh4NAt
   A==;
X-CSE-ConnectionGUID: rR4FemW+QZ6QO/giLZTRmA==
X-CSE-MsgGUID: oA2nA8QZREW1RGO6zegkXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39629889"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39629889"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:17:03 -0800
X-CSE-ConnectionGUID: f5sW2EIrQmGVNafj/FwA1A==
X-CSE-MsgGUID: tUbOo7EIQ/qtoCCV4NFEpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112638763"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:16:59 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
Date: Mon, 10 Feb 2025 10:17:29 +0200
Message-ID: <20250210081730.22916-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
References: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTL-H uses the same configuration as PTL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/pci-ptl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/pci-ptl.c b/sound/soc/sof/intel/pci-ptl.c
index 0aacdfac9fb4..c4fb6a2441b7 100644
--- a/sound/soc/sof/intel/pci-ptl.c
+++ b/sound/soc/sof/intel/pci-ptl.c
@@ -50,6 +50,7 @@ static const struct sof_dev_desc ptl_desc = {
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, &ptl_desc) }, /* PTL-H */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
-- 
2.48.1


