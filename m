Return-Path: <linux-pci+bounces-40201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A94C30F78
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309C73B2DE0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A742F12D3;
	Tue,  4 Nov 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwSEt2e9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2D2F0C6D;
	Tue,  4 Nov 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258626; cv=none; b=Unbk8+mLEjRh+cHvHoPET/EXMzUhO4P9BLElKIkiAMNs8Qmv6bv8++U1WjEjzI2bNqBytuJaxXYDZxQvIBr/E0eK81c22LeqaOxaglcpVauKmaQxYMtdv0F1ePoKmhXK05kE0nPO4uerb+stwcQz2/vAFB3YwW8hRUW4TJlcMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258626; c=relaxed/simple;
	bh=PWmiytRG6/u34JO/B5n6uFR7MGxCAh9E5TvHc6UMBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsqEDgrLEG/xnkdoinM9siDaecuM/3saPbZaJ7UBVXyMwL99GoV1V3ahQxsE5L/gKlo8ZOEF2RkF4WVm1/y3wUs5z2vx22bUgRzD4aqnF26a+ryS++uEEmlQCsvltrtd1XEfifyb4jX2SKJxz+EP+hU6WRBn5u6fht77rT67qU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwSEt2e9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258625; x=1793794625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWmiytRG6/u34JO/B5n6uFR7MGxCAh9E5TvHc6UMBk8=;
  b=BwSEt2e9Cvfe+X5iYTtkgb9vmgl4CY5a+s0MAxQuynQxRy+soZsZb3OY
   034QhJEhBcbJgmNcxTtuEXosdE3BYd2+/Jh775V1+aySEQDdlk0hl4532
   e1M8kIawbTlzrBJ52nSPLe7vXiRZ/dUkfaGGsWrylwxeZnUJtalsIaDYn
   qqsnnnIOKtCcSVzgF4c5f5+fsJ28nPHJiZAUixoKVNkLKO0CmCG2/Zq7Y
   RO7hG/FH8HSWbXDigWdvt1gE07I9HlipolOUjz1IK0/qBSOuTrHJGmCLT
   iN6sN3EKVAER79hgpB+v68a2P2oEHN3nBddR8+lZ+9eEs3ZWKmr8D8bug
   A==;
X-CSE-ConnectionGUID: qOi27om9Q1OYoeDIp2aOEQ==
X-CSE-MsgGUID: q/C4IXPFSqiWO4OL3luFVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187520"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187520"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:17:05 -0800
X-CSE-ConnectionGUID: /l3CDK14QCCdnXQfnzq7Ew==
X-CSE-MsgGUID: uIOPnCc1Rm+0lTyV1z/ytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832453"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:17:01 -0800
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
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 7/7] ALSA: hda: controllers: intel: add support for Nova Lake S
Date: Tue,  4 Nov 2025 14:16:50 +0200
Message-ID: <20251104121650.21872-8-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
References: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NVL-S to the PCI-ID list.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/controllers/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index a19258c95886..1e8e3d61291a 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2550,6 +2550,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Wildcat Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	/* Nova Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.51.2


