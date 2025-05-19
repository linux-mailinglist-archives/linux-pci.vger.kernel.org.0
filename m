Return-Path: <linux-pci+bounces-27924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38FABB6C7
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBB13B8530
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AA26A1AF;
	Mon, 19 May 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH7a/6pB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB426A1C1;
	Mon, 19 May 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642088; cv=none; b=KPKBQz7dFzk6hMDbjdaBhkc2JbgKXQcafzN0R0u+NRCjX6x9NILlTQekBQQRB4yaJx93p6mmOfqFNRvHIP80P4r41DwXZO+5XMS6mTzfHd5to1jjxMHqdiGZd0KQADe2SxLVU39SRRnVpPdQD6oPsD89vUCvDopwr6/vyN+mLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642088; c=relaxed/simple;
	bh=vczXuy0JrPmLKsdN7UNWySvHNr7K1/cB2Xirgh83u+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngIYUuB6C4jvJtzrXeQAzbhzVxZKnkwxKlqXI+rZNzwViEDrkyD9LsJkI1PJD/+lE8r1II0NSRtJJIKCrojfc5BaB3A1Z+SnFZsxZYlRDd7+EsLo+egDoybv0DnFbUTUOzFbJsm3uZsLtQy/f5/Qy1dGo75UC3JsyTjDj4hPUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZH7a/6pB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642087; x=1779178087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vczXuy0JrPmLKsdN7UNWySvHNr7K1/cB2Xirgh83u+M=;
  b=ZH7a/6pBoWcFmWZHNzlprUj/Lbn8UcDL6lsbJ1QafHBtVQI8DQ3RaMP9
   yOGUN7Kyt8Hqy8+cgi4V9irHPlQdbnqrzYTcCq93+smFF2zRW4XmkTqP3
   6bpMgYv48hjNLruq38VJLmN3iVDk2NiniTA1vmPNEfRkCwYQ8XlLVw7S3
   rdo6Qa3dzqiY+FcpiE3gJLDZ9sfBT2GNw5SO3CckFv7e1JnoLc73tGqvN
   3ZSmDyqQkgjICcdQhqbL/2diGyuOUHCVwb0LJZ19lw66AWffHjX9RAmZw
   d72JOMaI2DUUs6F9ickOTPQUXa61An5quXlAK7Dw+DveiU2yRgu0Lbj1v
   w==;
X-CSE-ConnectionGUID: NXsP6fFcRHKiOX71RWJP4Q==
X-CSE-MsgGUID: RV9jjUdtSmy0Cg5cFuyvUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="52163601"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52163601"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:08:05 -0700
X-CSE-ConnectionGUID: zRGc68evT6a616cWv1DiGQ==
X-CSE-MsgGUID: Cl5PE9tbTD673ELpE7pOxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139205833"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:08:02 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 5/5] ALSA: hda: hda-intel: add Wildcat Lake support
Date: Mon, 19 May 2025 11:08:55 +0300
Message-ID: <20250519080855.16977-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
References: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One more PCI ID.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d7651a75c629..e6df706f740d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2549,6 +2549,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Panther Lake-H */
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	/* Wildcat Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.49.0


