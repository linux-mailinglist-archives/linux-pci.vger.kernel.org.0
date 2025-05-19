Return-Path: <linux-pci+bounces-27920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC7ABB6BF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C1B7A6435
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B915F269AF9;
	Mon, 19 May 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxB5lAYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38926980B;
	Mon, 19 May 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642073; cv=none; b=FM6OG3kGgsK4E1+kFFjelyrBeIX0Z8Z/vkj/uftbTEk9TyosQwI9ri8pwiMazN4p5D4Bn6xMKXrCB5eEWQDA9593uurYSSiArLti/U+XNB+d6rw9hZammWseqZupbuEbxnGpAdHNrLySQxoWuRnyKnveV5BaDdoVWWFGeiaBPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642073; c=relaxed/simple;
	bh=fRseYVawSb8624uASA65g1wB9OLlqp3Ot9LTVJ4lWk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJlv7grkOnIhmUoqIa40cZed7esKk/GEbC7BMj343rLHvbUQ+g4CXSv1gt2p/s7IFttVgSRsFxAySTHAYSgqU4fh9XS+qfPc9k7NOxWwoGufpNpzlLSyTZm2HfnWj84+8xJf2xxLpISzaoJU8KfRDhmgkLYGz/5G4ghlWSogau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxB5lAYB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642072; x=1779178072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRseYVawSb8624uASA65g1wB9OLlqp3Ot9LTVJ4lWk0=;
  b=DxB5lAYBNj3Q+so/S6DT6JhDJZ/0sILqTzTxv02hNkspAO0BvExqqwe/
   4YS2r40HNTd3IMnlkeaheZmsw/kePpQtbHLynQ4mdkMfl8Xabk8Uf8x2n
   BYpSAAqIXI7E/dSbDau6ulbqwRy8eOKIYobdVLoAZAFr0xcrfc6rzEw+z
   38FP5NaTAxdcDIReLf+b3EPjG28hEVt3yoUTSuz4BXoVyIe8Lkdn/c9VR
   7wJ432oo4IqzqC96EoYxVW5gtXpgJDwBGfb0e0twjTLVNRJZtrzkYqTKx
   jaKy9fGdsf2NOOVST/bUbA+crE7K3WtSg1JYs64G7gqQMJbcmg47JHUEp
   A==;
X-CSE-ConnectionGUID: tupxg+LkQiS0dlMizfm4oQ==
X-CSE-MsgGUID: eEmaoOZMRU+hjh03QlVI5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="52163510"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52163510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:51 -0700
X-CSE-ConnectionGUID: DVgqmBNaQBi/qg5TVDpM3g==
X-CSE-MsgGUID: 4cd/Q+LSTDGR/PKcZpRrEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139205810"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:48 -0700
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
Subject: [PATCH v2 1/5] PCI: Add Intel Wildcat Lake audio Device ID
Date: Mon, 19 May 2025 11:08:51 +0300
Message-ID: <20250519080855.16977-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
References: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Wildcat Lake (WCL) audio Device ID.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 981ed45cc45e..e2d71b6fdd84 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3049,6 +3049,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_DG1	0x490d
 #define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
 #define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58
+#define PCI_DEVICE_ID_INTEL_HDA_WCL	0x4d28
 #define PCI_DEVICE_ID_INTEL_HDA_JSL_N	0x4dc8
 #define PCI_DEVICE_ID_INTEL_HDA_DG2_0	0x4f90
 #define PCI_DEVICE_ID_INTEL_HDA_DG2_1	0x4f91
-- 
2.49.0


