Return-Path: <linux-pci+bounces-34577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992FB31D6A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7168604226
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE3313523;
	Fri, 22 Aug 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwCDtz23"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D582ED16D;
	Fri, 22 Aug 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874653; cv=none; b=F0662uHGdph9rNegv/PXBZx6KEvUQtPQQ20TKrKQ6Q4jb9Jv8vuBQCi7TtPgjjiMGL75O6w/20wUu/alQnPBbZwCSq5iiE15JOVTtByJgDH8f5zIlmtQMh7w2F2AAnjHlAvrbLTjzjetOWvZqoMdBdg9Ps6IW7O1LP3r/4x4bRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874653; c=relaxed/simple;
	bh=h9rOaKJ78cwvTMGhAeaZehjm2lm9CqbJUu56YHFbep4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIPNrCoKAVh/TClcIMlJQhskmqOA0ZrUhVoj+3VViTSiBlyQ4EQV7AHDu5FSbYH98InGXcT+igqRMlHE7jEVWj07fzs+RG/7FGOseMnHqy9gGGNaOLlUEHVbiPCbsFtTkd7GirknuhywUiJc+NehB0EaGZMBk3l66GmSEunK7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwCDtz23; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874651; x=1787410651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9rOaKJ78cwvTMGhAeaZehjm2lm9CqbJUu56YHFbep4=;
  b=cwCDtz23B2HsGWC0bZSi5BP4sm9veq7h1ZmYvkeiPlE4Vxqxp6jRtmtc
   flKYv7XIfiY95eIefy6KmaLg+sA8ltGRSHCDOSiPtVfNnKNecIaLCf22B
   N4gCYe9JqGvFQs1qtuqgJL9fkWjD9heEAaZG0hx78b4g/e+R3EHsbU+jS
   aIiMDDfDJR9I45T873ttaOw+1HDrYoqjBZYpGMr9ZtV9oSWIg6sBAMb5e
   wrV3BpJaNFaRjaiCb+ojIKnC1K/aS0P8DLJedf5JuGjyQ2Oapp2ECFz8t
   1VG/pjmFaDszMkizIFSwqzQn+Ntz1Gfnh5+JlZ/MVtpLsU4U9owvjOEaa
   A==;
X-CSE-ConnectionGUID: aR5OBHtlRdyV/cqjr8rjQw==
X-CSE-MsgGUID: I7pMgB7cTC6ix7xKIEoOeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201334"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201334"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:30 -0700
X-CSE-ConnectionGUID: DvVLJoVkQxS29oGAHEDBlA==
X-CSE-MsgGUID: Ujk0XRTPSUO4HfTmYVIn9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168920472"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:25 -0700
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
Subject: [PATCH 08/24] PCI: Use pci_release_resource() instead of release_resource()
Date: Fri, 22 Aug 2025 17:55:49 +0300
Message-Id: <20250822145605.18172-9-ilpo.jarvinen@linux.intel.com>
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

A few places in setup-bus.c call release_resource() directly and
end up duplicating functionality from pci_release_resource() such
as parent check, logging, and clearing the resource. Worse yet,
the way the resource is cleared is inconsistent between different
sites.

Convert release_resource() calls into pci_release_resource() to remove
code duplication. The will also make the resource start, end, and flags
behavior consistent, ie., start address is cleared, and only
IORESOURCE_UNSET is asserted for the resource.

While at it, eliminate the unnecessary initialization of idx variable in
pci_bridge_release_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 46 +++++++++++++----------------------------
 drivers/pci/setup-res.c | 11 +++++++---
 include/linux/pci.h     |  2 +-
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6bdc1af887da..b62465665abc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -473,8 +473,6 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	struct resource *res;
 	struct pci_dev *dev;
-	const char *res_name;
-	int idx;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
 
@@ -582,14 +580,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		res = dev_res->res;
 		dev = dev_res->dev;
 
-		if (!res->parent)
-			continue;
-
-		idx = pci_resource_num(dev, res);
-		res_name = pci_resource_name(dev, idx);
-		pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
-
-		release_resource(res);
+		pci_release_resource(dev, pci_resource_num(dev, res));
 		restore_dev_resource(dev_res);
 	}
 	/* Restore start/end/flags from saved list */
@@ -1732,7 +1723,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	struct resource *r;
 	unsigned int old_flags;
 	struct resource *b_res;
-	int idx = 1;
+	int idx, ret;
 
 	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
 
@@ -1766,21 +1757,18 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 
 	/* If there are children, release them all */
 	release_child_resources(r);
-	if (!release_resource(r)) {
-		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
-		pci_info(dev, "resource %d %pR released\n",
-			 PCI_BRIDGE_RESOURCES + idx, r);
-		/* Keep the old size */
-		resource_set_range(r, 0, resource_size(r));
-		r->flags = 0;
 
-		/* Avoiding touch the one without PREF */
-		if (type & IORESOURCE_PREFETCH)
-			type = IORESOURCE_PREFETCH;
-		__pci_setup_bridge(bus, type);
-		/* For next child res under same bridge */
-		r->flags = old_flags;
-	}
+	type = old_flags = r->flags & PCI_RES_TYPE_MASK;
+	ret = pci_release_resource(dev, PCI_BRIDGE_RESOURCES + idx);
+	if (ret)
+		return;
+
+	/* Avoiding touch the one without PREF */
+	if (type & IORESOURCE_PREFETCH)
+		type = IORESOURCE_PREFETCH;
+	__pci_setup_bridge(bus, type);
+	/* For next child res under same bridge */
+	r->flags = old_flags;
 }
 
 enum release_type {
@@ -2425,7 +2413,6 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
 		     i++) {
 			struct resource *res = &bridge->resource[i];
-			const char *res_name = pci_resource_name(bridge, i);
 
 			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
 				continue;
@@ -2438,12 +2425,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 			if (ret)
 				goto cleanup;
 
-			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
-
-			if (res->parent)
-				release_resource(res);
-			res->start = 0;
-			res->end = 0;
+			pci_release_resource(bridge, i);
 			break;
 		}
 		if (i == PCI_BRIDGE_RESOURCE_END)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d2b3ed51e880..0468c058b598 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -406,20 +406,25 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
 	return 0;
 }
 
-void pci_release_resource(struct pci_dev *dev, int resno)
+int pci_release_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = pci_resource_n(dev, resno);
 	const char *res_name = pci_resource_name(dev, resno);
+	int ret;
 
 	if (!res->parent)
-		return;
+		return 0;
 
 	pci_info(dev, "%s %pR: releasing\n", res_name, res);
 
-	release_resource(res);
+	ret = release_resource(res);
+	if (ret)
+		return ret;
 	res->end = resource_size(res) - 1;
 	res->start = 0;
 	res->flags |= IORESOURCE_UNSET;
+
+	return 0;
 }
 EXPORT_SYMBOL(pci_release_resource);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..275df4058767 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1417,7 +1417,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
-void pci_release_resource(struct pci_dev *dev, int resno);
+int pci_release_resource(struct pci_dev *dev, int resno);
 static inline int pci_rebar_bytes_to_size(u64 bytes)
 {
 	bytes = roundup_pow_of_two(bytes);
-- 
2.39.5


