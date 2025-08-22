Return-Path: <linux-pci+bounces-34581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F5B31D8D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73340AC216C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8D3128D3;
	Fri, 22 Aug 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBpMbgiF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F02E611B;
	Fri, 22 Aug 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874691; cv=none; b=iLOxOjbsDf+cp/C54WDR8bD/n2g9Gf5DwFB7do1VeayG4vCeAoTjU8d7/w3DKEAueld9vuSic+SeSwLL5LladAD4Y9hU4/9aLImnbCK1InVcGRo7xtn4Tut+lzXSm1IVuTz3JkZFl6VRCMgVI4BJvb1FJzFK3PmIFujeHZjGG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874691; c=relaxed/simple;
	bh=HvowNzzh/OD6cGrbG0ubHIxVA4Lk6Q820KCMwB+uzto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtgYrHgmNnB7JKbTykdrjC2ELb1fEFwSnlqmWyotSIrKO43FlNgqtuPZ/AiOgq8DbJ5jf4Jp/OTWP5Khpo0QGC0B89lomdnp6ev9lzer+SiXR6siagUZ407UivDyTI9A46tsgPAvln67rF2kntkpNCxDwRZPmGZG0q61i6TcMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBpMbgiF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874690; x=1787410690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvowNzzh/OD6cGrbG0ubHIxVA4Lk6Q820KCMwB+uzto=;
  b=hBpMbgiFltyZDFtoRu85exQHvYgheKm4OkCHJ7zbr81BrBbjsdADYDOb
   7liHLA8H6+MA52TLi6s8uV9vkD9JdKo+b2geK7eWz3WCcPbCqdoJduGBV
   kpM9iFw2/o9Zs9BtLzlDvgjpTWJDF5uizHnzu+9sYG3cFJTxvJgsUw5LR
   hpz2exdO2UFLWMmYYCDmuCINmiCE2fsMOUDff3i+q/gACkKZ7Z2E+WShR
   dOhb93Q+gvwoYjikFWgM0daZueJBR8PzjrjpWmuxODqAelgMZoRIHmSd4
   Wml9/fVGlz0GACk0XYTEjhdrcP80j6WHkdXDDWoP9P9Gr21QRQxoQ/kYM
   g==;
X-CSE-ConnectionGUID: OnTuXDQnQzCAaf/ZMHES/Q==
X-CSE-MsgGUID: tpd9cpTNROS7sbE1mGlP9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80780518"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80780518"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:09 -0700
X-CSE-ConnectionGUID: vlviQhsgTCG2Kd8H61AzWw==
X-CSE-MsgGUID: h4VZ9g4tQ6e8L99bQN0BOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168232306"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/24] PCI: Add bridge window selection functions
Date: Fri, 22 Aug 2025 17:55:53 +0300
Message-Id: <20250822145605.18172-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Various places in the PCI core code make independently a decision into
which bridge window a child resource should be placed to. It is hard to
see whether these decisions always end up into agreement, especially in
the corner cases, and in some places it requires complex logic to pass
multiple resource types and/or bridge windows around.

Add pbus_select_window() and pbus_select_window_for_type() for case
where the former cannot be used so that eventually the same helper can
be used to select the bridge window everywhere. Using the same function
ensures the selected bridge window remains always the same and it can
be easily recalculated in-situ allowing simplifying the interfaces
between internal functions in upcoming changes.

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
index 223f0e025407..0c0872b85762 100644
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
+ * Selects the bridge window based on a resource @type.
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
+ * Selects the bridge window for @res. If the resource is already assigned,
+ * the current bridge window is returned.
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


