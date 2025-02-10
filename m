Return-Path: <linux-pci+bounces-21063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27721A2E627
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C496916529F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6D1BEF85;
	Mon, 10 Feb 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltiOUsZ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EF1C174E;
	Mon, 10 Feb 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175439; cv=none; b=NbaJr0L39AtGD6S5uwSrTvRCJJqVbSa8O5ZcnzGzPqnHJDknQexAx/Gsl7QqU0CYHXth3Q+uom6GZhpmC8OnBtjOjruebEtgPT55PhVBFR3uEBm86Ny13QZblzaZkSgQ5mB9Jw6mO2XIhEEUSaq3GB7R0UhgoU55Cx6LrXTm/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175439; c=relaxed/simple;
	bh=HG8zlBASEXEUuIM8+5uDp+WbCH7TbkKZFp993DRRXSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5nLuipmofVg3m53j/Znl8YRH1aAUmC4a8o7xxXFADX6qPKQIkzojVNZCuFglUSrTXc8h2IfHDWyVaX9wkvggZ66+it1inPRCyFBRolizzG0uj1MwaXhP5gE83gfXtwlZkuvyLsqzS3721g/FGXZafh2qdH5M3BA2qFMde8eEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltiOUsZ4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739175438; x=1770711438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HG8zlBASEXEUuIM8+5uDp+WbCH7TbkKZFp993DRRXSE=;
  b=ltiOUsZ47884NvgUF9xuJ+oQwJUlTHvYQOQ55lSQ2xJOKWWl7Wb+UcQN
   N4mq6JTuGod5BysqyebVvylu9I+hxyDZxRm9LzkGWLLR13eS1jIV5M9Jc
   kpxyKqhKn1clJLZozvkQFlwb+Wq75DthzLfzFXVvRgi9cYaqFiTdJ3lCh
   GZZsJUk0sfvLlQy/CVsb4ueggbWu7OBTBZggmHqIpbHO0jGOMW80JBm+r
   gYpuTnPjB2pSg8TrHpLMT5yXjJV9svklDlc88QctXgP6OBQ7w86Gxdj01
   v+BJ8N3Xh/6t5EWJWF2rse/FulbQ3g8nD3OG4a7fg2biZg3bonQLR5wg7
   w==;
X-CSE-ConnectionGUID: dhonwDeQTWex6eUgd3fhrw==
X-CSE-MsgGUID: dFmOq1IjS92qafvfUZ//9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39629935"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39629935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:17:13 -0800
X-CSE-ConnectionGUID: JCpqIykDTcySFN4yJ8vhyQ==
X-CSE-MsgGUID: lTtmBNoXTv6CuJa3wHcysQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112638789"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:17:03 -0800
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
Subject: [PATCH v2 4/4] ALSA: hda: hda-intel: add Panther Lake-H support
Date: Mon, 10 Feb 2025 10:17:30 +0200
Message-ID: <20250210081730.22916-5-peter.ujfalusi@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add Intel PTL-H audio Device ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7d7f9aac50a9..67540e037309 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2496,6 +2496,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Panther Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	/* Panther Lake-H */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.48.1


