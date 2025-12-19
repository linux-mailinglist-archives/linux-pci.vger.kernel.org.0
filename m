Return-Path: <linux-pci+bounces-43425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33394CD1418
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B02AC3127280
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A533FE0E;
	Fri, 19 Dec 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpqXve16"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BC33ADB1;
	Fri, 19 Dec 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166134; cv=none; b=L7FK2yKm5VwtGij9aWNN4HAVGQUY9m5mvrNaE/ij/mswmNKbJeCsig1PRFdvHURBNDfasyugMgGIPYXoZmnwIc7dxBokXwZIUg8lkzoHFcTLatHWWaa8mOHgAFyxqkCgC179s1iEYfES0M2wFBW9SJqYbUwqybB7i5RZwdpfVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166134; c=relaxed/simple;
	bh=jbV7bMaiMlBpNb80xOxh5qKE5av1K1eirvSgZubtPoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGqDqy9a9FEujtmTv1tmkhFaET6L/AEwCE16ChAxOsYlv+vNqEos3ef564M2HOOrBKx1wUTHN40NzI6iTujG5yyW/dUqSUCiC2q2fMS2qHSo5Yo/g0iC1mld1trB9c3Tjt96/AF1vj9TefuhR7abFGrCOOePBDrR+8kR0bF4te0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpqXve16; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166133; x=1797702133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbV7bMaiMlBpNb80xOxh5qKE5av1K1eirvSgZubtPoI=;
  b=YpqXve16+KAT8VEs/kjSjwWHF3RKT7ZtVty5K/PQvNYuerZo9v6biZng
   Uj8B4x1FiGFihKBJRtchoh9BOEjvVoNKTixMiDAY8eABYuoN1AC4jtEWX
   YYEwdQQW1bgzUgzC2xBtcTASntxxrcU2zwOs41O5JIFu6NcrRcRIpSFPd
   cl00V7sHam6n8ES4wMYvYymIysLLu66kT0ZEIEoa+N2/CbKf6YkbF6NSY
   +zu0fO3Dcqmrf6YbUkOJmXpy9trimFV9ckxgQnZuJAtxB5VXQ8lQI03/I
   tVOjsuCZ9Csw/Eebg/T59KROHlWvaax+V3VqYYymwHbg3AGU7ygEA3MjU
   A==;
X-CSE-ConnectionGUID: IhyP7UUDSJKJPqFGPuTiCQ==
X-CSE-MsgGUID: doPBobEWSPOrfzcJIPivCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173903"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173903"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:12 -0800
X-CSE-ConnectionGUID: CGGMlx9IQVC1/De4Q6CcyQ==
X-CSE-MsgGUID: R0NwvNluTtuu0bEiS/0r8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="229597867"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/23] PCI: Add pci_resource_is_bridge_win()
Date: Fri, 19 Dec 2025 19:40:23 +0200
Message-Id: <20251219174036.16738-11-ilpo.jarvinen@linux.intel.com>
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

Add pci_resource_is_bridge_win() helper to simplify checking if the
resource is a bridge window.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 drivers/pci/pci.h       | 5 +++++
 drivers/pci/setup-bus.c | 7 +++----
 drivers/pci/setup-res.c | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2df915ad2d2..363187ba4f56 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -181,7 +181,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 		struct resource zerores = {};
 
 		/* For backwards compatibility */
-		if (i >= PCI_BRIDGE_RESOURCES && i <= PCI_BRIDGE_RESOURCE_END &&
+		if (pci_resource_is_bridge_win(i) &&
 		    res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
 			res = &zerores;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa001..c27144af550f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,6 +452,11 @@ void pci_walk_bus_locked(struct pci_bus *top,
 
 const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
 bool pci_resource_is_optional(const struct pci_dev *dev, int resno);
+static inline bool pci_resource_is_bridge_win(int resno)
+{
+	return resno >= PCI_BRIDGE_RESOURCES &&
+	       resno <= PCI_BRIDGE_RESOURCE_END;
+}
 
 /**
  * pci_resource_num - Reverse lookup resource number from device resources
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 41417084ddf8..403139d8c86a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -303,8 +303,7 @@ static bool pdev_resource_assignable(struct pci_dev *dev, struct resource *res)
 	if (!res->flags)
 		return false;
 
-	if (idx >= PCI_BRIDGE_RESOURCES && idx <= PCI_BRIDGE_RESOURCE_END &&
-	    res->flags & IORESOURCE_DISABLED)
+	if (pci_resource_is_bridge_win(idx) && res->flags & IORESOURCE_DISABLED)
 		return false;
 
 	return true;
@@ -389,7 +388,7 @@ static inline void reset_resource(struct pci_dev *dev, struct resource *res)
 {
 	int idx = pci_resource_num(dev, res);
 
-	if (idx >= PCI_BRIDGE_RESOURCES && idx <= PCI_BRIDGE_RESOURCE_END) {
+	if (pci_resource_is_bridge_win(idx)) {
 		res->flags |= IORESOURCE_UNSET;
 		return;
 	}
@@ -985,7 +984,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 {
 	int ret = -EINVAL;
 
-	if (i < PCI_BRIDGE_RESOURCES || i > PCI_BRIDGE_RESOURCE_END)
+	if (!pci_resource_is_bridge_win(i))
 		return 0;
 
 	if (pci_claim_resource(bridge, i) == 0)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e5fcadfc58b0..bb2aef373d6f 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -359,7 +359,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	if (resno >= PCI_BRIDGE_RESOURCES && resno <= PCI_BRIDGE_RESOURCE_END)
+	if (pci_resource_is_bridge_win(resno))
 		res->flags &= ~IORESOURCE_DISABLED;
 
 	pci_info(dev, "%s %pR: assigned\n", res_name, res);
-- 
2.39.5


