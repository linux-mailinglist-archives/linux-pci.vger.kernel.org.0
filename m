Return-Path: <linux-pci+bounces-43427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0496CD13E8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D20A30D3E11
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41A433FE01;
	Fri, 19 Dec 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSC5D+aC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8634251B;
	Fri, 19 Dec 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166150; cv=none; b=NTX3sB9MBHZL31cffTksqejM2Eu2HGrupTC2viI/MyCTULieaBLepgD/Gu0ubiLahwBfT83rBPisr7Il5+y/nS6zXSuSSwdNAiGoCWjnH3PUCxLdxX1+N9KPKhmzYXeHis5ioef0+Yq8445cfxD4rFcqB0YHR/lwMaLEhKBdNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166150; c=relaxed/simple;
	bh=+xSIN+5di/giUMM7A2fTxdXHCi72NeGkwGBidy9vG44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv5dds02q74rBGqC58vS/Wj6l9K3qENrXEHQEfATyezi1lYYroUEfr3sZ+5p5zGNEw2IWwax7vn8EJPVTqNnZWoZbrAgpi4sqQiniEgzfnTLeqe/+FGXDeYAcgZnu5IBlyOmi+o3qiNHTT7ephySwf86y8ICoSngUZmWdZ+AeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSC5D+aC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166149; x=1797702149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+xSIN+5di/giUMM7A2fTxdXHCi72NeGkwGBidy9vG44=;
  b=YSC5D+aC8DP0VnXv8ab6heUeRZU93yd1hJDslDIoIJ0zb8dFmLwSlppn
   6///12jHwVOSGW/1u5iToVQcO2iofHVhRBJoSIQIvhFPSMwWHJNspkbda
   2C7faYOXBDxl76hAGtA8p5NjOLHqskwjhwV70o7xbrt2Dt7fXzAb6rwz8
   EVkr8ztm7rjlxMA6bd594JcnRD8m67uXExEgUsrSqn/IRRyVU0Dk4TCt7
   hfLeESKrfbOV++wk6ohOhmapLaEupMne3Wm2AaHfDxj67ScOFvOf2NFWa
   YiGB6pvYaFp/MgF/LE6koyvfZm+HIiHu29BtNTcvpoS5Va8Bx8aDpFQlu
   Q==;
X-CSE-ConnectionGUID: MLHCGWzMSheGLEDijVyUDw==
X-CSE-MsgGUID: EbiuI64rReaHZjZuHsPV6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173938"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173938"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:28 -0800
X-CSE-ConnectionGUID: LUGAIcJHSh6irXm0B98ctg==
X-CSE-MsgGUID: 27EnsvdxTWuoBA4ZeSFHig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="229597888"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/23] PCI: Check invalid align earlier in pbus_size_mem()
Date: Fri, 19 Dec 2025 19:40:25 +0200
Message-Id: <20251219174036.16738-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check for invalid align before any bridge window sizing actions in
pbus_size_mem() to avoid need to roll back any sizing calculations.

Placing the check earlier will make it easier to add more optional size
related calculations at where the SRIOV logic currently is in
pbus_size_mem().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a5b6c555a45b..3d1d3cefcdba 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -19,6 +19,7 @@
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/errno.h>
@@ -1311,31 +1312,29 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 				continue;
 
 			r_size = resource_size(r);
-
-			/* Put SRIOV requested res to the optional list */
-			if (realloc_head && pci_resource_is_optional(dev, i)) {
-				add_align = max(pci_resource_alignment(dev, r), add_align);
-				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
-				children_add_size += r_size;
-				continue;
-			}
-
+			align = pci_resource_alignment(dev, r);
 			/*
 			 * aligns[0] is for 1MB (since bridge memory
 			 * windows are always at least 1MB aligned), so
 			 * keep "order" from being negative for smaller
 			 * resources.
 			 */
-			align = pci_resource_alignment(dev, r);
-			order = __ffs(align) - __ffs(SZ_1M);
-			if (order < 0)
-				order = 0;
+			order = max_t(int, __ffs(align) - __ffs(SZ_1M), 0);
 			if (order >= ARRAY_SIZE(aligns)) {
 				pci_warn(dev, "%s %pR: disabling; bad alignment %#llx\n",
 					 r_name, r, (unsigned long long) align);
 				r->flags = 0;
 				continue;
 			}
+
+			/* Put SRIOV requested res to the optional list */
+			if (realloc_head && pci_resource_is_optional(dev, i)) {
+				add_align = max(align, add_align);
+				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
+				children_add_size += r_size;
+				continue;
+			}
+
 			size += max(r_size, align);
 
 			aligns[order] += align;
-- 
2.39.5


