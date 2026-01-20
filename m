Return-Path: <linux-pci+bounces-45251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E9D3C27F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 09:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A556A5C02DC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D23BFE40;
	Tue, 20 Jan 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpkPTrMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4E3BF2FA;
	Tue, 20 Jan 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897875; cv=none; b=SvrPVv37Cva1tQjjCbPGAgxt/G1pbZXFbWe9xpA+D6Ju3gh7wzHxTauLYxp5zNSJB/1g01DHk1KWTdhzmLfVGhyAJaiVYV6olpdxvqKjW1d2OyXK5MuynFUYcyf5od1VCGJwuUyG73vMsWpxJNkREuh09SpNeXPIZH2ZEH9IujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897875; c=relaxed/simple;
	bh=+9tdOOwAmwzGzWY2n/TdQhvg+PowftvB3bUTTK8Zgj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPvgQvYylk0isV5/yqRbl7YkCTELzhpnT54d2jksElMJStd+POxktHIPnZGZrQKpz877jw+QbxRSNohWj0g4L9ZVpGnxSVt/ELjQ7Y/CnGiQzcKwplHzshLlC8w7ZW2Xu0eQRoQiOaE+PtM8E94tdIrJsSBDIUnhAYd8K/BvFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpkPTrMB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768897874; x=1800433874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9tdOOwAmwzGzWY2n/TdQhvg+PowftvB3bUTTK8Zgj0=;
  b=UpkPTrMBoHxUtAkoMB0D9l+sV/wYsWCsGeHo9cMQ9W+Piw/+ZOUmDAJ3
   N5+QYIV5ODnmVN/rynDlvxmHrkDVtNBOJsL2fvNzrPuOkBjcP2l1dAvuE
   1JcI7JZc2zkpinNT7eqi+/bHlqDt+hLQRBeTy7PZuwflEi6jdnH+c2Spc
   ybjcJj+x+GuSUMCHGUpujBzN4ZJiwrhliKqamtzrD4Vd6lATL8OROenQ3
   9EeQ896xUOt0XvmnVyOhlSKhypGT97aZOS4rnhLBJWeLp70slv34D6umV
   D0iE3TRz0INSOaOoKubQb2GTGd08psh2oPdEN1Qfr7bRCeI3aKVVd5SRd
   g==;
X-CSE-ConnectionGUID: dJ3P7CHtQ4eeYfXa/udzBQ==
X-CSE-MsgGUID: 1LC2GcTJRumKQ6qiBYAKhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70071923"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70071923"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:13 -0800
X-CSE-ConnectionGUID: 62Q/Xai1S0SxnswB2tAgQg==
X-CSE-MsgGUID: hhAAu9nrRKGChdttgV2O/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210530653"
Received: from krybak-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:09 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI: pci_ids: Add Intel Nova Lake audio Device ID
Date: Tue, 20 Jan 2026 10:31:45 +0200
Message-ID: <20260120083148.12063-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
References: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nova Lake (NVL) audio Device ID

The ID will be used by HDA legacy, SOF audio stack and the driver
to determine which audio stack should be used (intel-dsp-config).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 84b830036fb4..5ed7846639bf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3144,6 +3144,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_CML_S	0xa3f0
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
+#define PCI_DEVICE_ID_INTEL_HDA_NVL	0xd328
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
 #define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
 #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
-- 
2.52.0


