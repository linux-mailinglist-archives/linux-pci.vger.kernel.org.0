Return-Path: <linux-pci+bounces-40195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5597C30F54
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390EB3A6E5B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A22F12C8;
	Tue,  4 Nov 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lX0PduqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3F2EFDBB;
	Tue,  4 Nov 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258605; cv=none; b=cPYjfhlMfR45KmseyUJtwB0zjsRRGmi/iE2dMi+TDfdPb/B78sNb4pyVYfAuLpAx/Y5XSoaKoagMjAelcJozuFZzS7ashReUiSF/8vjAlECB36W898Lsa5ph318T9EIdiU3JN/AazZhiVr0F/9vx72uahDXLZclahn+obvAZBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258605; c=relaxed/simple;
	bh=viDCEWHaWpRJ97I7so/N5d5wIRHT6MWBLfxm+PJ7FnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbBmPt3IfwQfONAZbmLsYeqhtBTR7Xk3d1+o2H/+qNQGkMFfg0jACE+MC3D+/zNYeHG9NZgyFKZUqsP85pevQ+tbI36It0sSCBZwVub67Bk28H5L/fMBhHH/ye+n4rXx3+E+qE+cXr4MuHSqDNBqXvojFYuQrmENRRAw4qecm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lX0PduqU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258604; x=1793794604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=viDCEWHaWpRJ97I7so/N5d5wIRHT6MWBLfxm+PJ7FnU=;
  b=lX0PduqUxNKvs7vfoE0y9tcwLV5T8LzdXpf4XfPvCS62CrtbQG53iFhQ
   Dxy7+fucVW0EWH3mwB09xFvh+HjbzEqaa7e6zFMM3asP8fJVRVR/LsgPZ
   SsBE6WZS/+0OYQy4aU4wHBdtIU4GpoCNRYEfLVckjZuaipM6d8uoGxill
   XufFPqZDsdMWP1KGJwqEmqQBfrfvm3Q1EivpRBY1chsHKjN+KjrgpNylV
   s3kdRh9GliLakLfWKNaoghz9n5vwdPG5rSonmw1wpE9cnx5N14AMr8COA
   cR40HoD6u+jxuFaeoqZUE4FMiN/L/ZxTJMm6a6+GEHdgEB1UF2TGFcToc
   A==;
X-CSE-ConnectionGUID: jj0BuqcdRfGcnTVbYTzlIg==
X-CSE-MsgGUID: rdTO1kgnRwmqSbAzetUOvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187503"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187503"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:44 -0800
X-CSE-ConnectionGUID: onG4ZIoPR22A01aBA7GSHg==
X-CSE-MsgGUID: Mt5cYR3JSii+UkHfOk5Vzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832418"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:40 -0800
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
Subject: [PATCH v2 1/7] PCI: Add Intel Nova Lake S audio Device ID
Date: Tue,  4 Nov 2025 14:16:44 +0200
Message-ID: <20251104121650.21872-2-peter.ujfalusi@linux.intel.com>
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

Add Nova Lake S (NVL-S) audio Device ID

The ID will be used by  HDA legacy, SOF audio stack and the driver
to determine which audio stack should be used (intel-dsp-config).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..a9a089566b7c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3075,6 +3075,7 @@
 #define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
 #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
 #define PCI_DEVICE_ID_INTEL_HDA_FCL	0x67a8
+#define PCI_DEVICE_ID_INTEL_HDA_NVL_S	0x6e50
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
 #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-- 
2.51.2


