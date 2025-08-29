Return-Path: <linux-pci+bounces-35109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88588B3BC28
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486AB5A0284
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99431AF24;
	Fri, 29 Aug 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKZs9Rw2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5902E7BDA;
	Fri, 29 Aug 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473173; cv=none; b=sZkuglEtZINu3Jq9CM6XXxx30I4MkMRsn9yO5cYZ99MuGgaVFgW4l/fw1zG2/2pc2/j6VkBsPvuyZvcooeiSFDVbJIp49NbPyS42eFNHG4Vaj+F3t8Jbhv29Al9nb++CKipVZMH+5wbylQ6KroqNaEZrWjHWPboMlk5KkDMl6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473173; c=relaxed/simple;
	bh=L/pcPeupwPTtNRI85oPP3u9i0AlajJ1NlR21PKXET14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ngy3GIZceC16cSHc9YxLTHcnkMNH7yk5JE6sFmcke3SVk4AOaglKGqAx6P0otK74qGwgMBUtYXEmCuoCUoPmV8qDDPyFIpzuVBnDdUr0UayB6AzwfwILXhGex6n4Rxe0USXoGOyWkzWCBLuiH4lfQu8wm7/28TM8C5R/YC1VrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKZs9Rw2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473172; x=1788009172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/pcPeupwPTtNRI85oPP3u9i0AlajJ1NlR21PKXET14=;
  b=JKZs9Rw220H0WBytFeYE4EODJvUYwRy9630lfaDh/u+7c1GXPU7WdDwR
   pHFQRHpIe9ObaA97HREk41kmN5esL+VIKg4keLbhUcXHU6kUFHYNszwNA
   MVLD9V/2bMhjfzO2Sz2B44hS89txOhfXV5VQEAK4Cpz1U7nzmLVct8KZZ
   +YvWYTPc1atOVm1DInTP3bZGhlLBlU0oxK4K44OgYvU9iqI4I2gG6pwsf
   8gZQoQWZJ9W3uHr4r2nPvv8u1Xfq5DWTNwfz3guaA8wBsfYeW4jeeRcxH
   eN4xlUWexOYtDZDVvMJsaPueuba6zB/zcqk//0tRO52eHYCVGPXLbdDbF
   w==;
X-CSE-ConnectionGUID: Sbv7+pczRN+eLmLdiSmiYQ==
X-CSE-MsgGUID: 7DCaKJEaS++uxT9S2q6f5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62576112"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62576112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:52 -0700
X-CSE-ConnectionGUID: geAJOsONT3iHv8ea+MZEkQ==
X-CSE-MsgGUID: qs1FTHQwRN21s6+cTAHj6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174733745"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 12/24] PCI: Add bridge window selection functions
Date: Fri, 29 Aug 2025 16:11:01 +0300
Message-Id: <20250829131113.36754-13-ilpo.jarvinen@linux.intel.com>
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

Various places in the PCI core code independently decide into which bridge
window a child resource should be placed. It is hard to see whether these
decisions always end up in agreement, especially in the corner cases, and
in some places it requires complex logic to pass multiple resource types
and/or bridge windows around.

Add pbus_select_window() and pbus_select_window_for_type() for cases where
the former cannot be used so that eventually the same helper can be used to
select the bridge window everywhere. Using the same function ensures the
selected bridge window remains always the same and it can be easily
recalculated in-situ allowing simplifying the interfaces between internal
functions in upcoming changes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       |   2 +
 drivers/pci/setup-bus.c | 101 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1dc8a8066761..cbd40f05c39c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -385,6 +385,8 @@ static inline int pci_resource_num(const struct pci_dev *dev,
 	return resno;
 }
 
+struct resource *pbus_select_window(struct pci_bus *bus,
+				    const struct resource *res);
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 70b210ed200d..913fd41e1d0d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -172,6 +172,107 @@ static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 	return r_assigned;
 }
 
+/**
+ * pbus_select_window_for_type - Select bridge window for a resource type
+ * @bus: PCI bus
+ * @type: Resource type (resource flags can be passed as is)
+ *
+ * Select the bridge window based on a resource @type.
+ *
+ * For memory resources, the selection is done as follows:
+ *
+ * Any non-prefetchable resource is put into the non-prefetchable window.
+ *
+ * If there is no prefetchable MMIO window, put all memory resources into the
+ * non-prefetchable window.
+ *
+ * If there's a 64-bit prefetchable MMIO window, put all 64-bit prefetchable
+ * resources into it and place 32-bit prefetchable memory into the
+ * non-prefetchable window.
+ *
+ * Otherwise, put all prefetchable resources into the prefetchable window.
+ *
+ * Return: the bridge window resource or NULL if no bridge window is found.
+ */
+static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
+						    unsigned long type)
+{
+	int iores_type = type & IORESOURCE_TYPE_BITS;	/* w/o 64bit & pref */
+	struct resource *mmio, *mmio_pref, *win;
+
+	type &= PCI_RES_TYPE_MASK;			/* with 64bit & pref */
+
+	if ((iores_type != IORESOURCE_IO) && (iores_type != IORESOURCE_MEM))
+		return NULL;
+
+	if (pci_is_root_bus(bus)) {
+		win = find_bus_resource_of_type(bus, type, type);
+		if (win)
+			return win;
+
+		type &= ~IORESOURCE_MEM_64;
+		win = find_bus_resource_of_type(bus, type, type);
+		if (win)
+			return win;
+
+		type &= ~IORESOURCE_PREFETCH;
+		return find_bus_resource_of_type(bus, type, type);
+	}
+
+	switch (iores_type) {
+	case IORESOURCE_IO:
+		return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
+
+	case IORESOURCE_MEM:
+		mmio = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
+		mmio_pref = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WINDOW);
+
+		if (!(type & IORESOURCE_PREFETCH) ||
+		    !(mmio_pref->flags & IORESOURCE_MEM))
+			return mmio;
+
+		if ((type & IORESOURCE_MEM_64) ||
+		    !(mmio_pref->flags & IORESOURCE_MEM_64))
+			return mmio_pref;
+
+		return mmio;
+	default:
+		return NULL;
+	}
+}
+
+/**
+ * pbus_select_window - Select bridge window for a resource
+ * @bus: PCI bus
+ * @res: Resource
+ *
+ * Select the bridge window for @res. If the resource is already assigned,
+ * return the current bridge window.
+ *
+ * For memory resources, the selection is done as follows:
+ *
+ * Any non-prefetchable resource is put into the non-prefetchable window.
+ *
+ * If there is no prefetchable MMIO window, put all memory resources into the
+ * non-prefetchable window.
+ *
+ * If there's a 64-bit prefetchable MMIO window, put all 64-bit prefetchable
+ * resources into it and place 32-bit prefetchable memory into the
+ * non-prefetchable window.
+ *
+ * Otherwise, put all prefetchable resources into the prefetchable window.
+ *
+ * Return: the bridge window resource or NULL if no bridge window is found.
+ */
+struct resource *pbus_select_window(struct pci_bus *bus,
+				    const struct resource *res)
+{
+	if (res->parent)
+		return res->parent;
+
+	return pbus_select_window_for_type(bus, res->flags);
+}
+
 static bool pdev_resources_assignable(struct pci_dev *dev)
 {
 	u16 class = dev->class >> 8, command;
-- 
2.39.5


