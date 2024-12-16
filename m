Return-Path: <linux-pci+bounces-18557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E144B9F3874
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A00188B65F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065EE209F26;
	Mon, 16 Dec 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVM40QHW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EE208997;
	Mon, 16 Dec 2024 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371985; cv=none; b=I9kkgg//i2WVdRSlu+60oOIGkni9f8SdtDqeTYi2JYWDTk0Iuiz8Z63Vi4dC+Sam1Lv1TA1sk1U/HJslg70BhChNZANG1IPmeS122kizB9/VnO6MBkhlwhkTQPiB9GlESwespwRlDnmmPE9arhSD15ofGFuMNk8gDeAsTdNBRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371985; c=relaxed/simple;
	bh=iFwbglq+z8fPZu4ryFSOsJBi7ZGsVc+9fw6id0a/pwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/aaF6pB3iJI/KuNemhqgikKLTwawpJwZuhEjaOn5Nfk8omNolNLp/Hyw3QhAuJTlUwkXBsWRhX7QfLgP8gStg49YblZY7Xnk4zsXyh2HLXWJTqygiVRq2vVSzEzc3v/tYpJ2AXmtBFbVAV8Sp4oc5rNDsCZoAzR4PJbid/3Kig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVM40QHW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371984; x=1765907984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFwbglq+z8fPZu4ryFSOsJBi7ZGsVc+9fw6id0a/pwU=;
  b=QVM40QHWIizOvkWNXD7CA3Rwnj3c2Y5W1cEmwSEx5zVwjlsknXPNatkk
   Bf7oBQSO/YCGWmMJ5vIP6Hbi32WZzGyTqwJ8xrLg90P+PIZHbBwlargdp
   gva4kKhZ/2N0Lj9h1k/B2nYu9ONAl5dLkkcDoTlbvvoY3jcdRzDAzbfMk
   cZFnfWxq0uSnFcDvSxfWXr0/rpGDP1zAYMin8hhArWwd6lA/qN1o+nejv
   tpFBR083Dqk0QeDbtqLuyUuk2qeUtb/Q+eKuJ7oAFT+/dXXVcxnbhZfhs
   pVmrXmU33wJ+0y+nsC8VIP8WibaACTbPiRgc8fJrgCjRA10hUInaTileB
   w==;
X-CSE-ConnectionGUID: b2ulcFOLRtygngo6jiZ7Tw==
X-CSE-MsgGUID: JRc00NieReaC6K7fixmX8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52293356"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52293356"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:44 -0800
X-CSE-ConnectionGUID: FHXSRqJLQXOhENCYVB/bWA==
X-CSE-MsgGUID: L6BU1bmURNOUYT2hYHzehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120532085"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 22/25] PCI: Add debug print when releasing resources before retry
Date: Mon, 16 Dec 2024 19:56:29 +0200
Message-Id: <20241216175632.4175-23-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI resource fitting is somewhat hard to track because it performs many
actions without logging them. In the case inside
__assign_resources_sorted(), the resources are released before resource
assignment is going to be retried in a different order. That is just
one level of retries the resource fitting performs overall so tracking
it through repeated assignments or failures of a resource gets messy
rather quickly.

Simply make the release announced explicitly using pci_dbg() so it is
clear what is going on with each resource.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 500652eef17b..5a3b320f1511 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -408,6 +408,9 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *save_res;
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	struct resource *res;
+	struct pci_dev *dev;
+	const char *res_name;
+	int idx;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
 
@@ -497,9 +500,16 @@ static void __assign_resources_sorted(struct list_head *head,
 	/* Release assigned resource */
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
+		dev = dev_res->dev;
+
+		if (!res->parent)
+			continue;
+
+		idx = pci_resource_num(dev, res);
+		res_name = pci_resource_name(dev, idx);
+		pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
 
-		if (res->parent)
-			release_resource(res);
+		release_resource(res);
 	}
 	/* Restore start/end/flags from saved list */
 	list_for_each_entry(save_res, &save_head, list)
-- 
2.39.5


