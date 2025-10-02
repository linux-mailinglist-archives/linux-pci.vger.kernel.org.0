Return-Path: <linux-pci+bounces-37396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B5BB3431
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6686C7A9256
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00852FE049;
	Thu,  2 Oct 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHQ8nlEI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B72FDC36;
	Thu,  2 Oct 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394524; cv=none; b=cRG8sg5q4Atur3sU7X9M73jeLLlLHcMUUJv5+dgjlEQrFsIvUkyRbmF9+9nwq792pEHxIfTaZt2KW+SPGFdYRFRKFsWt/2nGEhrV/Yl6Q3Resrr91IifmOrx/Y/Jae2HbILFXgs/PYMNgONagrKg2nGhU1Glc2wLcBVJ4PI0zjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394524; c=relaxed/simple;
	bh=oqpA+9LPiQckylpIzG8RPM8jbrJsPd5zAWg9J1WRnOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTuhOqJjiyzpHs9vQwt6dkGKzLjXV/cM8+l5O2URF5eo088AV4/+Fp9D1de+b/3ilYrptPc3sJBOc/Egd3X1aOovToz2vHtNKr+TfU83wzDycAqHW4aMIJrmE91taUAfei/muSuQ2slDMge8y6MRAubZzbDPHqrKNU9nTi5i/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHQ8nlEI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394523; x=1790930523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqpA+9LPiQckylpIzG8RPM8jbrJsPd5zAWg9J1WRnOA=;
  b=ZHQ8nlEIsmzLHmRbj9jc03W2mkO49fp9dqoc/d8cCSqx3m1UdfHUVmfr
   zdEwujjwev4SzyS6KNmBOMrpg2VUPvYTW7KfAEXm3T8LIMnHNTCSl5UZG
   DV/z5CuLPf60S3H/iZGoNh25k9GsEmXR6ajs/jzU4wu3hzVmWnFXVRRvH
   2F/fxYLF+3LTP01n3ylJkLTw0l7gwH5vAFyqdT9di/jvNyLtBO6fch/es
   V8Q5+T3YfpfEFADB5n1mNTN3vxYxLW7H6cH+dHsHPz0+3+YLIJs4rXjlD
   QNcjdcKj6sbhyp4V4QTEjq/qpYiiHDit7zcbZLafwS0chAciHdhZUkSYh
   Q==;
X-CSE-ConnectionGUID: sxkL05dPRI2Y0YlHhfM1tg==
X-CSE-MsgGUID: DstYNqLETqyWL5iPQNKPQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099028"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:03 -0700
X-CSE-ConnectionGUID: YyrarER+SaaHTz9g+K5L/Q==
X-CSE-MsgGUID: 6JidR6UQTkKsh1PYlHb07g==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:00 -0700
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
Subject: [PATCH 1/7] PCI: Add Intel Nova Lake S audio Device ID
Date: Thu,  2 Oct 2025 11:42:46 +0300
Message-ID: <20251002084252.7305-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
References: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nova Lake S (NVL-S) audio Device ID

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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
2.51.0


