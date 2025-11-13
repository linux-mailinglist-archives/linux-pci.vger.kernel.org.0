Return-Path: <linux-pci+bounces-41039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D21C5565F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5D28348A11
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089F2E11BC;
	Thu, 13 Nov 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ob3GCPJQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2252DF14B
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000048; cv=none; b=s0mr7F4A4VsRLPZbrdfYlkFvxm05Qsh+qXcr/uhQ8iObdCrsE9Xtv8wGZRO+AnapoOw/pv51KV92dtVG6SHQX+4L4EUia5meaLUhM2h52q0IAoa8oOJKNsAjurOzUO3TyiMbMqDRMjM+cRpB0JTEOP0hck7qNQDTpnhX4315bX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000048; c=relaxed/simple;
	bh=zktKfxnwHupTkrYTYObZqvpcEjofeu5PnpGY5JLmcz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gL27r035v1hRpIPGZO6T3qOqwamJjr0B4DRIT964LVFCSLNFdoqbAlHF0qUOOfHP1KdkKuxE4ZUpCS6fd/xgInXHuvWxPDD4Blsm2S3sXNOJYdKK27tVuTmk4EXpkMyaXqJVa7N//D+wtNcf5zhaK8l+5wyyHrqt8Vst5x78UNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ob3GCPJQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000048; x=1794536048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zktKfxnwHupTkrYTYObZqvpcEjofeu5PnpGY5JLmcz8=;
  b=Ob3GCPJQX4Qy2m0nbGu6w6LaNyueCVTdhoYv0FUdpLWcJaNxI4GrVcwk
   zA8hvUIcFEeJ3E7KlECVfHF+Q88kZ+IXnS/g4d2tGpIEDqBnX/DM59rNJ
   Mnbu0lE2rlt2I0UpFvqHjPn7xoRTWQ45KMjhun4VUUrmL/rRNeA9W2+2l
   tGHnxcnpA49hcXwqPb/WIz6YSNLDetzRuWOHbs7E/tQv8uwEyiHIEG2Jv
   Erb0xHSGNpRp0IPXrCjs0VfidQPpdwofiMEWumalmGfAXuDqwJK9qmdaD
   vLdVmuylsc0jaKJAx8+m8EBCwP9BgAra4hWVN57rCHfJ1u133hZovwk8a
   A==;
X-CSE-ConnectionGUID: RJ+FTIPQQCyVo8MMW8R/EQ==
X-CSE-MsgGUID: BwHpH7DFT4G9VORJnCOmWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471763"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471763"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:05 -0800
X-CSE-ConnectionGUID: pw2c2rezSP228ESM7BCQDg==
X-CSE-MsgGUID: I82hlWRPTQeP+ecIoLpmhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802491"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/8] resource: Introduce resource_assigned() for discerning active resources
Date: Wed, 12 Nov 2025 18:14:41 -0800
Message-ID: <20251113021446.436830-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113021446.436830-1-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A PCI bridge resource lifecycle involves both a "request" and "assign"
phase. At any point in time that resource may not yet be assigned, or may
have failed to assign (because it does not fit).

There are multiple conventions to determine when assignment has not
completed: IORESOURCE_UNSET, IORESOURCE_DISABLED, and checking whether the
resource is parented.

In code paths that are known to not be racing assignment, e.g. post
subsys_initcall(), the most reliable method to judge that a bridge resource
is assigned is to check the resource is parented [1].

Introduce a resource_assigned() helper for this purpose.

Link: http://lore.kernel.org/2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux.intel.com [1]
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/ioport.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..9afa30f9346f 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -334,6 +334,15 @@ static inline bool resource_union(const struct resource *r1, const struct resour
 	return true;
 }
 
+/*
+ * Check if this resource is added to a resource tree or detached. Caller is
+ * responsible for not racing assignment.
+ */
+static inline bool resource_assigned(struct resource *res)
+{
+	return res->parent;
+}
+
 int find_resource_space(struct resource *root, struct resource *new,
 			resource_size_t size, struct resource_constraint *constraint);
 
-- 
2.51.1


