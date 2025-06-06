Return-Path: <linux-pci+bounces-29116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EAAD093C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 23:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411071643C4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18567201013;
	Fri,  6 Jun 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMH1Ks70"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808EAA31
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243799; cv=none; b=AbOyoUSKb//KnCotvwakIxR/fw5YK/YL5Y4aI6HuHqcIFLwGB+KmIF+j5+30ERVVhF9D+hlGR4LLJuwHenNtf4yCDo0Htcxz1PpPp9yI3angN6dMIqn0Dh9YfSN0U4zycnlQVkhOHFG7GF22954SZmoyR1ffybGdrySlt2bgFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243799; c=relaxed/simple;
	bh=+YwLhvfVfGEP8mNQFUZ5atF2/lQOBHl13HYw+eIxoIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrqwU+g1raQp1sSftEy+HS/OaVIofBl9nYv1Kl08ehUgxyc6UTXwJG2F7vau0T2+gEZNnTmpG2/qzOT0zblwjRmXb3gcSwjSo/iYKVtzh3Uctau6QdghgtNolbd89GWxqrJ/nVcVtiGdhGUinomwtnqfoLQRbadziu+WVekP4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMH1Ks70; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749243797; x=1780779797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YwLhvfVfGEP8mNQFUZ5atF2/lQOBHl13HYw+eIxoIs=;
  b=WMH1Ks70wDy42EnyxMRu7xLpu10iXsSBx+7E/FmYgwvLVOhEcEwo9tvj
   ie8VgSjgKycYqGAgYzgTBK6r7CGAL9vofcoRazjCJ7wdwyGQ1LR5BEel0
   8Ec+FaVsWuoppa5JhZDkHr1FNLCFDBcCBnZwVh4Q1MkWSdAy0IncflLhZ
   engTvGWDNGWPl8i8aW99WGKrpoE9wbvk2aONgmc5GGqGkuGzw1Y77XxTe
   uRgbxOFQIpqy+ijpdCNX5LtwIqwIMNZpJqgtmH/Y6yZRC8YTbNAFdjwrP
   MqlZdfcdqux9jQFItLp+fgwpUEM7/jexGoLYV6fPoQu3WZJq8SOQxXpzZ
   Q==;
X-CSE-ConnectionGUID: HoPDTXJOSA+B5mZQ8AiYlg==
X-CSE-MsgGUID: 9s5ghskgRruef0N3mE9ueg==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68961616"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="68961616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:03:17 -0700
X-CSE-ConnectionGUID: GDMShCJKRCCZ4sGAccTojA==
X-CSE-MsgGUID: b0L3gSoVS2K4vW6SpBGJSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="176872544"
Received: from otc-chromeosbuild-6.ostc.intel.com ([10.165.164.32])
  by orviesa002.jf.intel.com with ESMTP; 06 Jun 2025 14:03:16 -0700
From: george.d.sworo@intel.com
To: nirmal.patel@linux.ntel.com
Cc: linux-pci@vger.kernel.org,
	George D Sworo <george.d.sworo@intel.com>
Subject: [PATCH 1/1] PCI: vmd: Add VMD Device ID Support for PTL-H/P/U
Date: Fri,  6 Jun 2025 14:02:30 -0700
Message-Id: <20250606210230.340803-2-george.d.sworo@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606210230.340803-1-george.d.sworo@intel.com>
References: <20250606210230.340803-1-george.d.sworo@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George D Sworo <george.d.sworo@intel.com>

Add VMD Device ID Support for PTL-H/P/U

Signed-off-by: George D Sworo <george.d.sworo@intel.com>
---
 drivers/pci/controller/vmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2f..375ce9d6d9f6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1129,6 +1129,8 @@ static const struct pci_device_id vmd_ids[] = {
                 .driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb06f),
                 .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb07f),
+                .driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.34.1


