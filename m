Return-Path: <linux-pci+bounces-41038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2BC55660
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E9644E14CB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D62DA756;
	Thu, 13 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqnOxudm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E62DC333
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000047; cv=none; b=A44aTy9+7Vc760ytzPBXkIyaNdJmPZ1MotuZKMkEqKlB46HhXDgYrTFMO6rSm9BLimpAIKiohtoOAxu8KOPCmv4jqU62nEkevzAErY2s8mpvnVd3pFTVl81AsYisQAFdrvpy7c7umfrCpwJScFfCU8e+IobbijipI8t1NbXyGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000047; c=relaxed/simple;
	bh=eC6qEbzsXevdG9GwC4fXz4RHY1UhX66VpCUuU/hYOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNSj8mbkPYFs0rjHDeu5HQVCZcZ4lMQEpmrSbWQY/GMGo8pgFTxsQyVej3GcSeevcCC2/7xNORtSL+EjRRfF9s2tgFgabLPB28Tn204HcVQZdE9iM2l0AdZQvAnOOeQofeo6uFUVHq6q+drHj3e6EpYcgSXECi67cDoEeWR0zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqnOxudm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000047; x=1794536047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eC6qEbzsXevdG9GwC4fXz4RHY1UhX66VpCUuU/hYOPY=;
  b=FqnOxudmvyHCVRtL9OOfxE8K0DC/XZ9wge54JYz33DyBgfF9qlVkV1rt
   bb/u9QnkKyNleEYxBW3LIY+jMxsLD6ywCPbMc6hgxHKL6R2fzta/PI2LF
   xYntO1JH1XIhZPPgyKALPiGkVB792gbumg2e93yhxKuAExcKumA3P7hwn
   6MScAz9TAD6Qgt9so4hrIfIPtQ/AsOrexvirQ/jgXu3+gOijxwpKf38Uu
   0LianFE8r13JmUOrrPLwiqfU8y8pRvvop4mDwArWs1GeFZhj0B/V7cYSx
   j1DGqp6vS9dQkU1pMo4vY1Gk6OxWrL/DrEiJtDgHe6pDp+kWmr4TCqm7c
   Q==;
X-CSE-ConnectionGUID: 2Ln8RGHhQvKdO4/aeJkXeA==
X-CSE-MsgGUID: F5WKvM6KQGal7uwEoi7fJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471760"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471760"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:05 -0800
X-CSE-ConnectionGUID: ZQpneiF3QUW2iQvOhVJhTw==
X-CSE-MsgGUID: bg6OzPHMQ+iwymjsr8irjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802488"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 2/8] PCI/TSM: Drop stub for pci_tsm_doe_transfer()
Date: Wed, 12 Nov 2025 18:14:40 -0800
Message-ID: <20251113021446.436830-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like pci_tsm_pf0_{con,de}structor(), in the CONFIG_PCI_TSM=n case there
should be no callers of pci_tsm_doe_transfer().

Reported-by: Xu Yilun <yilun.xu@linux.intel.com>
Closes: http://lore.kernel.org/aRFfk14DJWEVhC/R@yilunxu-OptiPlex-7050
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/pci-tsm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index e921d30f9b6c..d7b078d5e272 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -147,11 +147,5 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
 {
 }
-static inline int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type,
-				       const void *req, size_t req_sz,
-				       void *resp, size_t resp_sz)
-{
-	return -ENXIO;
-}
 #endif
 #endif /*__PCI_TSM_H */
-- 
2.51.1


