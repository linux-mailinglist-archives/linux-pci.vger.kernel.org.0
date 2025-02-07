Return-Path: <linux-pci+bounces-20892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC59A2C3DD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FE93AC772
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200B21F8AC0;
	Fri,  7 Feb 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udg3avW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8D1F9421;
	Fri,  7 Feb 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935437; cv=none; b=TtuRhpuZXkdMIV/F4Xw1Z1mbrwE6PC9nnqna63hC4ICurFmA/X4phCt9uGMcRGqWgp5cjZQaGsCOdAwuUJK4KGV1f9E0bVZblLitFGO3Jf7DDC6fa0gJfkl7GrDgm4BLNPEqI/s1+n9njU7mLQosrQIMXD+qJhoThB9HBWFersE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935437; c=relaxed/simple;
	bh=1gPbmt2CETIzLFEDnbd4H1EjyjVkwI381ioMsJl4KW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRCG06haP8dqUrJAYLTZb61NuvWag8Ocuk90klKkiMoIdxyWVkx+U6RmFYz8HqZb80dZSHSX9K/CSuBAsQaBLzKdZo/wuRQ7C0H6wn+kjpXiRwJ4sXAzFlwqZzBGSIBKTqung2ANyoc+AKPpxRReGHU3TQ7XH0Bd8o/gtNS1vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udg3avW5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935435; x=1770471435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gPbmt2CETIzLFEDnbd4H1EjyjVkwI381ioMsJl4KW0=;
  b=Udg3avW5kNrUr5K2tY5Fk7ddUqbXuZ59GQFr33TUfcU6iJbOCCn1tA0C
   JicOpj+LgR8wWEWGXhmxriYvsFey2Zz5tZI3fBbCW8WY3vma+lU4ubvFX
   bkNzD3Veq8bz1t6sSsesWk/44+tb5qKWAKUswY/AoOyYgAbbzj0/FpRq6
   m2OJ4SWDf19yKvXznDHKdI8yq6SzC1bMEBaGKJmhvkJI+HotJqsrclxAT
   z6OF7JK2nZDWFDtsV2jJZ2WYo4iPAoy29YnIAq+InTEuScYGcarf+jLrt
   EjahjeRa0YBt9wSS7oiefrod3CeXNskWoKa46HyXUXN3X/S/0NBKMtMF+
   Q==;
X-CSE-ConnectionGUID: wHYVtijIT+mJF/3YG4nxeQ==
X-CSE-MsgGUID: eDGhiEA2TPuHHE0tJc77NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39268459"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39268459"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:15 -0800
X-CSE-ConnectionGUID: UU5DFwFzQVagWK+sgVoTUw==
X-CSE-MsgGUID: YawrmXTXR3SOkZKF45OZCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148739906"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:12 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ALSA: hda: hda-intel: add Panther Lake-H support
Date: Fri,  7 Feb 2025 15:37:36 +0200
Message-ID: <20250207133736.4591-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
References: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

One more PCI ID.

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


