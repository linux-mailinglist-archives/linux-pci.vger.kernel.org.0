Return-Path: <linux-pci+bounces-37166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C0BA6940
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 08:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F5A17D8CB
	for <lists+linux-pci@lfdr.de>; Sun, 28 Sep 2025 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6912BD5B4;
	Sun, 28 Sep 2025 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPTD7scr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D229E115;
	Sun, 28 Sep 2025 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041626; cv=none; b=EvTIyhzIEpC84vpABVfFladpM9eDVBXVh8n4JvL86P+ztxKT+xSGGDSd/j2MKVKTuoIXX2tqsXSnNND5l6vjR1fULK9kW+D7Kam4RwGvOWy0iKerEH4Sq0LmPt90r+GZE08quHVJOLOePEOhwDEmioEfQnQUH0EmwU1/V6Xotn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041626; c=relaxed/simple;
	bh=cDTxcb4B+ODUAizKTHRF3o2YDVPO24Wtl1sX30pmf1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSe7K2lcqeY8yBv8cj9JRt0Lcv1CMij5zIAVwBaKCumbtQYgKYSgZ++nUgC6EcblcOzRiiTadS938QDkjH0npoe5VomBHgbSjILsEKFaNI6U2umvqPSpSCoLLDzzsx7c+qYtPPyK2dXwwVvuCVfjPD8V/+us1N7QxF0Pj6AN7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPTD7scr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759041625; x=1790577625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDTxcb4B+ODUAizKTHRF3o2YDVPO24Wtl1sX30pmf1Q=;
  b=TPTD7scr1CnpetPMDZOV29mFBXRku93aWeeoN42UVwBG14y9t20xtYec
   hgkVqDQvcxFo4O1qaptzTBONZFKsLKIh4wM7P6SvzLsyx5pWYSeDr9iW/
   tdd9sR7nF916MCcRl/WyTbj0XPBQ4SUAyY7pKeqsz+VPTQJf00awsj/7n
   vl468+R/ghY0MTxJSowtETu4snM5ksTONve1zqK15y3k6X6LAu23iDbd8
   iCFYSX9Hnd3F67V85IkP/Lvaed0wUMrjZ+RKJ0wyuUYrd1cbbEQYR+X3I
   SfMijTEtLyOyS8AFWLeAqVxQHKpgyQk6Ea+lcE1OWZhJvwA8hm5jeHs/z
   A==;
X-CSE-ConnectionGUID: 8SYQ1ekNR2SI325oCifSow==
X-CSE-MsgGUID: ee/IpVXTTh+aeSySfj4cAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61228546"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61228546"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 23:40:24 -0700
X-CSE-ConnectionGUID: VDyHmiQCR06ImWbm1f2Vhg==
X-CSE-MsgGUID: yfO1NG4ISXmJrNPikFM3iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="177088889"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 27 Sep 2025 23:40:22 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com
Cc: yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	aik@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] coco/tdx-host: Illustrate IDE Address Association Register setup
Date: Sun, 28 Sep 2025 14:27:56 +0800
Message-Id: <20250928062756.2188329-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not for devsec-staging. Just illustrate, can't compile. Please wait for:

  [RFC PATCH v2 00/27] PCI/TSM: TDX Connect: SPDM Session and IDE Establishment

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 33 ++++-----------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 5553c63b4083..58777225b51e 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -387,29 +387,6 @@ static void tdx_ide_stream_key_stop(struct tdx_link *tlink)
 
 DEFINE_FREE(tdx_ide_stream_key_stop, struct tdx_link *, if (!IS_ERR_OR_NULL(_T)) tdx_ide_stream_key_stop(_T))
 
-/* OPEN: Should we add general address range support in pci/ide.c ? */
-static void setup_addr_range(struct pci_dev *pdev,
-			     resource_size_t *start, resource_size_t *end)
-{
-	struct device *dev;
-	u32 devid;
-	int i;
-
-	add_pdev_to_addr_range(pdev, start, end);
-
-	for (i = 0; i < pci_num_vf(pdev); i++) {
-		devid = PCI_DEVID(pci_iov_virtfn_bus(pdev, i),
-				  pci_iov_virtfn_devfn(pdev, i));
-
-		dev = bus_find_device(&pci_bus_type, NULL, &devid,
-				      match_pci_dev_by_devid);
-		if (dev) {
-			add_pdev_to_addr_range(to_pci_dev(dev), start, end);
-			put_device(dev);
-		}
-	}
-}
-
 static void sel_stream_block_setup(struct pci_dev *pdev, struct pci_ide *ide,
 				   u64 *rid_assoc1, u64 *rid_assoc2,
 				   u64 *addr_assoc1, u64 *addr_assoc2,
@@ -422,12 +399,10 @@ static void sel_stream_block_setup(struct pci_dev *pdev, struct pci_ide *ide,
 	*rid_assoc1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, setting->rid_end);
 	*rid_assoc2 = PREP_PCI_IDE_SEL_RID_2(setting->rid_start, pci_ide_domain(pdev));
 
-	/* Only one address association register block */
-	setup_addr_range(pdev, &start, &end);
-
-	*addr_assoc1 = PREP_PCI_IDE_SEL_ADDR1(start, end);
-	*addr_assoc2 = FIELD_GET(SEL_ADDR_UPPER, end);
-	*addr_assoc3 = FIELD_GET(SEL_ADDR_UPPER, start);
+	/* TDX Module enforces only one address association register block */
+	*addr_assoc1 = PREP_PCI_IDE_SEL_ADDR1(setting->mem64.start, setting->mem64.end);
+	*addr_assoc2 = FIELD_GET(SEL_ADDR_UPPER, setting->mem64.end);
+	*addr_assoc3 = FIELD_GET(SEL_ADDR_UPPER, setting->mem64.start);
 }
 
 #define STREAM_INFO_RP_DEVFN		GENMASK_ULL(7, 0)
-- 
2.25.1


