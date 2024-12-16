Return-Path: <linux-pci+bounces-18545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD539F3832
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645F016D342
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897120A5C9;
	Mon, 16 Dec 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxYGcOOm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D460209F58;
	Mon, 16 Dec 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371891; cv=none; b=n9YQA1izi/v2ONhAMqaC8ztD2f6HpURPZX51QwuzHY7TPRD/A3au7c31eLfFUG+JnCk4gewe/TqJHNoy4VN1dJ4y/DlpzwK7P6DD3oDTmCj8GvP3FvvhTUm4hzVljnf7VYc36qVJQnMOmuzDEEGHjEEcbo8JztWiZS3evQXNnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371891; c=relaxed/simple;
	bh=CBkcy5rzYd/eqjdXBU1hkT0sjsV59h1TDhZErEvno4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3PmMRWs3/xDiJVb29Ap+IiqGjLvoclGYWW4ePBCz6xeZeaGabNUm9kX9k8UPP/kTDO1J5bswODDh2znAKlMaFJ6M9yi/0J2Vbp4h+kTR46W3tJaOov942KJkRPGbo3oCdRqWcUIODW8fK7Lbac7PeSlfXa1vIE8E82fifQS63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxYGcOOm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371890; x=1765907890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBkcy5rzYd/eqjdXBU1hkT0sjsV59h1TDhZErEvno4k=;
  b=WxYGcOOmyNeXTuetnzIcr0q+Zh68JZ+DpYNdNW1HTCbeWVERraqJ/icK
   0aTjF23d0ZGltRMZ1Z12N1n4FTcNpBn2CsGDVEQkzv+tNT3v2hV79RUaT
   cakmEO1P2sRrYAQFrIROOlF0V5phodgTIWRhIH6FmXXDDKKIUXunKaKyz
   xUopZGdT2+r/Kggk8tN2wYcb7/m9fFbjNbDE7VNYha/Cdx9PkLhm6+LQ2
   4/cKiQGUCG3W+nE1U8gFyJPyAiLPWke1UJevQiAlCvdN4k5pjkmRx1GBY
   oYlPWGc5yLboq5d+Ko6AQiMo5WzKz+P+qWFpNP5qXeVbB1DIXrVyhKpVF
   A==;
X-CSE-ConnectionGUID: 0Y5vUwNPRa+5FGvO61IXHw==
X-CSE-MsgGUID: YEC+tb7nQU6hNr+a3/8wPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38544015"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38544015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:09 -0800
X-CSE-ConnectionGUID: AmrWqJSmRdOIysjgUHgzGg==
X-CSE-MsgGUID: zVKvHnL+QNGNo2cyViiWiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97149730"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/25] PCI: Add pci_resource_num() helper
Date: Mon, 16 Dec 2024 19:56:17 +0200
Message-Id: <20241216175632.4175-11-ilpo.jarvinen@linux.intel.com>
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

A few places in PCI code, mainly in setup-bus.c, need to reverse lookup
the index of a resource in pci_dev's resource array. Create
pci_resource_num() helper to avoid repeating the pointer arithmetic
trick used to calculate the index.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       | 24 +++++++++++++++++++++++-
 drivers/pci/setup-bus.c | 10 +++++-----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 25bae4bfebea..0b722d158b6a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -330,6 +330,28 @@ void pci_walk_bus_locked(struct pci_bus *top,
 
 const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
 
+/**
+ * pci_resource_num - Reverse lookup resource number from device resources
+ * @dev: PCI device
+ * @res: Resource to lookup index for (MUST be a @dev's resource)
+ *
+ * Perform reverse lookup to determine the resource number for @res within
+ * @dev resource array. NOTE: The caller is responsible for ensuring @res is
+ * among @dev's resources!
+ *
+ * Returns: resource number.
+ */
+static inline int pci_resource_num(const struct pci_dev *dev,
+				   const struct resource *res)
+{
+	int resno = res - &dev->resource[0];
+
+	/* Passing a resource that is not among dev's resources? */
+	WARN_ON_ONCE(resno >= PCI_NUM_RESOURCES);
+
+	return resno;
+}
+
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
@@ -682,7 +704,7 @@ unsigned long pci_cardbus_resource_alignment(struct resource *);
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 						     struct resource *res)
 {
-	int resno = res - dev->resource;
+	int resno = pci_resource_num(dev, res);
 
 	if (pci_resource_is_iov(resno))
 		return pci_sriov_resource_alignment(dev, resno);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 63c134b087d5..8831365418d6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -242,7 +242,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		if (!found_match) /* Just skip */
 			continue;
 
-		idx = res - &add_res->dev->resource[0];
+		idx = pci_resource_num(add_res->dev, res);
 		res_name = pci_resource_name(add_res->dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;
@@ -284,7 +284,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
-		idx = res - &dev_res->dev->resource[0];
+		idx = pci_resource_num(dev_res->dev, res);
 
 		if (!resource_size(res))
 			continue;
@@ -2211,7 +2211,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 		res->flags = fail_res->flags;
 
 		if (pci_is_bridge(fail_res->dev)) {
-			idx = res - &fail_res->dev->resource[0];
+			idx = pci_resource_num(fail_res->dev, res);
 			if (idx >= PCI_BRIDGE_RESOURCES &&
 			    idx <= PCI_BRIDGE_RESOURCE_END)
 				res->flags = 0;
@@ -2295,7 +2295,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		res->flags = fail_res->flags;
 
 		if (pci_is_bridge(fail_res->dev)) {
-			idx = res - &fail_res->dev->resource[0];
+			idx = pci_resource_num(fail_res->dev, res);
 			if (idx >= PCI_BRIDGE_RESOURCES &&
 			    idx <= PCI_BRIDGE_RESOURCE_END)
 				res->flags = 0;
@@ -2402,7 +2402,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		struct resource *res = dev_res->res;
 
 		bridge = dev_res->dev;
-		i = res - bridge->resource;
+		i = pci_resource_num(bridge, res);
 
 		res->start = dev_res->start;
 		res->end = dev_res->end;
-- 
2.39.5


