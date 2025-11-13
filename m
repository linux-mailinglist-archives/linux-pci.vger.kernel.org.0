Return-Path: <linux-pci+bounces-41124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B1C58C9E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208073B85DB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D535CB6C;
	Thu, 13 Nov 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BupXEZi+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E035C1B5;
	Thu, 13 Nov 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051241; cv=none; b=tYZtTxGcs/QiDM+K80PpnTIDjv4iFxg+5UBpffYkzHNjSzp2yMfzvyUFrK6mkXLkCRu32AbYgE4OTmlDEfJ7hYkBu4r7KpFVf/Y1giUIfwtsdJPVivfv2Mx6N89dvQ1ps5/OQGZFx3aV3b+3JWTYmttCMMjnr3/xPj2ZOHr8IVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051241; c=relaxed/simple;
	bh=+9U8bLoG5vhDi4CT1cCak0qMkenNIeswIbFL4jpF094=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p12vDG8gNyT2DFF09UR+xIyH1yjw1XeopsB7cKgkvZAKTD5DtC3Ezt4iOSi4esCBAxxstFStGcDYcSwn7WrjhzNN+6mBbQl+NSg8WxtqL60SVfsxIG8VKm8j7xOvEpMsqTKVGY1hIoAm1Kt1bgyhIjp6Cyy3W/ZPe3Bh3+S5zI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BupXEZi+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051239; x=1794587239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9U8bLoG5vhDi4CT1cCak0qMkenNIeswIbFL4jpF094=;
  b=BupXEZi+dTOf99g4zj41AekIcXNFPzSTSNduEFpQPDao4kIB7o1fj59N
   2DyFywNkKI1b8oPDo82CgTYaSBCI8dYTsCcSUaY6YKHUl7nUDFrVbeqIl
   Wspv3JREjbouN2O6qY/LdZAIcCoTuINqljgr+RipZWzpEIsVESWLFoSCh
   yarCjEmfaKKu/v49Qqeja5r5O02kWDJK1p3ibcGe+Iof7KBUTc3yieLby
   FoyXGdtMUJ0fisKcLBNL5+Iyx380w5LsrYr5AKHa9D3UirjmfdAd39+5S
   kLzW1eBoDSkWT+AvHY5xfZqrGCfKy5wO5ha9Wj+ozXwZkA5/GpiaU8pNP
   w==;
X-CSE-ConnectionGUID: czPvTD0XS7WdZs6gA5I9Yg==
X-CSE-MsgGUID: oh/pBLTvRGW9QA5MDE/WWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68766643"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="68766643"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:19 -0800
X-CSE-ConnectionGUID: 5KkuisasTgW4lHbn5DQh+A==
X-CSE-MsgGUID: ZS4+oLvyTb+mDc3Q1TU3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189553864"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 03/11] PCI: Change pci_dev variable from 'bridge' to 'dev'
Date: Thu, 13 Nov 2025 18:26:20 +0200
Message-Id: <20251113162628.5946-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Upcoming fix to BAR resize will store also device BAR resource in the
saved list. Change the pci_dev variable in the loop from 'bridge' to
'dev' as the former would be misleading with non-bridges in the list.

This is in a separate change to reduce churn in the upcoming BAR resize
fix.

While it appears that the logic in the loop doing pci_setup_bridge() is
altered as 'bridge' variable is no longer updated, a bridge should
never appear more than once in the saved list so the if check can only
match to the first entry. As such, the code with two distinct pci_dev
variables better represents the intention of the check compared with the
old code where bridge variable was reused for a different purpose.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e6984bb530ae..d58f025aeaff 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2479,12 +2479,13 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 	}
 
 	list_for_each_entry(dev_res, &saved, list) {
+		struct pci_dev *dev = dev_res->dev;
+
 		/* Skip the bridge we just assigned resources for */
-		if (bridge == dev_res->dev)
+		if (bridge == dev)
 			continue;
 
-		bridge = dev_res->dev;
-		pci_setup_bridge(bridge->subordinate);
+		pci_setup_bridge(dev->subordinate);
 	}
 
 	free_list(&saved);
@@ -2500,19 +2501,19 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 	/* Revert to the old configuration */
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
+		struct pci_dev *dev = dev_res->dev;
 
-		bridge = dev_res->dev;
-		i = pci_resource_num(bridge, res);
+		i = pci_resource_num(dev, res);
 
 		if (res->parent) {
 			release_child_resources(res);
-			pci_release_resource(bridge, i);
+			pci_release_resource(dev, i);
 		}
 
 		restore_dev_resource(dev_res);
 
-		pci_claim_resource(bridge, i);
-		pci_setup_bridge(bridge->subordinate);
+		pci_claim_resource(dev, i);
+		pci_setup_bridge(dev->subordinate);
 	}
 	free_list(&saved);
 	up_read(&pci_bus_sem);
-- 
2.39.5


