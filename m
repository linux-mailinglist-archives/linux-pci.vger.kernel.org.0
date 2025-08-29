Return-Path: <linux-pci+bounces-35118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B5B3BC41
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9A1CC1C44
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E532255C;
	Fri, 29 Aug 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+5YMdsw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BB322550;
	Fri, 29 Aug 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473239; cv=none; b=gqMpTMxXcCOsPJR/RM8sC4qc1uuxv6wr9vJSdzB666fr8SMeMkNNg8FJCGdheh44I1IbzWBhUM/DswAW6kOHHr7hbHgtc5z313hVQ42Nh8X2BGswhf3uSkyTKZ+thJNR9wGncrKe2+mSQAzTXh/VjjlDpIQ2l0OYCRmDucy3xLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473239; c=relaxed/simple;
	bh=BUC1nCoGsjDMg2klfPfm0wRaTetXrxSrVFecjFSnr9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7asowptlf0ni+UPLFV3DjhZNYi6RorFYIUMtxxWGvjXcPhncPdsEQxbM1nKxdMuWzjJzSXcGpHgt6zEeOq6GFV1FUEJu/pY9odTG7FZN2t8yv4QaznxRMAQdn4bIXAmRJNR/ACILqAsv/jP1jqsZcwZ5lx4fs2Jj2oocgvhHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+5YMdsw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473238; x=1788009238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BUC1nCoGsjDMg2klfPfm0wRaTetXrxSrVFecjFSnr9g=;
  b=m+5YMdswHpMdcweMW5s4W7LHi+9RKrqzIH9I1V97Q0sQ2PE/L1ONCfoO
   jh6l1HLl+tqtwKhg5/2I7hCFhmACFJWX9q8pBadT8m4DhIGK3hDP0gyo0
   5EeiMqgghbn+0jv8XKXG1TBzgfUB3MkYNoxtS0dl9SDcsbVHjCCf6DWWS
   KzmhQU+7SKbLMkABL8A+houLaPXAtcliCgzIFo8mD9zNfcOvawIB27IK1
   H/gmyVvc+e599pZsI6V5tHwgRMVw747BQ+q4BZjc7RStOw1PvpxeT08nD
   vRmWVNoVPloP5p94DjPhPYf/RFFZ1Pz9J3lrxDn4ANe6UnohTpENOCHvC
   g==;
X-CSE-ConnectionGUID: Ztn0XuMURnSrvf/Es4yCIQ==
X-CSE-MsgGUID: IGmZECsiSMez6oNL0HqcFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58905336"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58905336"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:58 -0700
X-CSE-ConnectionGUID: Zs4z4KjbQqmTMth+GZfuBQ==
X-CSE-MsgGUID: FciSGE6sThykX+VdDqbX7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169680053"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 21/24] PCI: Refactor remove_dev_resources() to use pbus_select_window()
Date: Fri, 29 Aug 2025 16:11:10 +0300
Message-Id: <20250829131113.36754-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert remove_dev_resources() to use pbus_select_window(). As 'available'
is not the real resources, the index has to be adjusted as only bridge
resource counterparts are present in the 'available' array.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3bc329b1b923..cb91c6cb4d32 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2062,34 +2062,18 @@ static void remove_dev_resource(struct resource *avail, struct pci_dev *dev,
 static void remove_dev_resources(struct pci_dev *dev,
 				 struct resource available[PCI_P2P_BRIDGE_RESOURCE_NUM])
 {
-	struct resource *mmio_pref = &available[PCI_BUS_BRIDGE_PREF_MEM_WINDOW];
-	struct resource *res;
+	struct resource *res, *b_win;
+	int idx;
 
 	pci_dev_for_each_resource(dev, res) {
-		if (resource_type(res) == IORESOURCE_IO) {
-			remove_dev_resource(&available[PCI_BUS_BRIDGE_IO_WINDOW],
-					    dev, res);
-		} else if (resource_type(res) == IORESOURCE_MEM) {
+		b_win = pbus_select_window(dev->bus, res);
+		if (!b_win)
+			continue;
 
-			/*
-			 * Make sure prefetchable memory is reduced from
-			 * the correct resource. Specifically we put 32-bit
-			 * prefetchable memory in non-prefetchable window
-			 * if there is a 64-bit prefetchable window.
-			 *
-			 * See comments in __pci_bus_size_bridges() for
-			 * more information.
-			 */
-			if ((res->flags & IORESOURCE_PREFETCH) &&
-			    ((res->flags & IORESOURCE_MEM_64) ==
-			     (mmio_pref->flags & IORESOURCE_MEM_64))) {
-				remove_dev_resource(&available[PCI_BUS_BRIDGE_PREF_MEM_WINDOW],
-						    dev, res);
-			} else {
-				remove_dev_resource(&available[PCI_BUS_BRIDGE_MEM_WINDOW],
-						    dev, res);
-			}
-		}
+		idx = pci_resource_num(dev->bus->self, b_win);
+		idx -= PCI_BRIDGE_RESOURCES;
+
+		remove_dev_resource(&available[idx], dev, res);
 	}
 }
 
-- 
2.39.5


