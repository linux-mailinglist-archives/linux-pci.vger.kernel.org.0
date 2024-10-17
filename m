Return-Path: <linux-pci+bounces-14789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C79A24A5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B13128A98D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB61DE88C;
	Thu, 17 Oct 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrNkNcyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213A1DE897;
	Thu, 17 Oct 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174297; cv=none; b=eAwOhGfN5sqMimq8oS5MPoSeS2Rb97KJ8I715t342Mm6JP1AWguq0nfqVdQ3Ge1dvoA09XjmB09RE3W/gXXCh7z0JI0Tw2sgtuGX27YyKmolTtVPIIAf9z5/4dp8nIhX9CrH+o0vTn+Mtz6m0m8wJxCsz5gv5NW2IdEzI3ZjQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174297; c=relaxed/simple;
	bh=Arrat7mw8ZzbkjzLvyqYNFGgxY8Pgq8SAVp/RviN3C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLZlH+NI4TfToIyNAeM0cqOiyFIwJur9SLfliNynBolccTNIQer31DcmDVZdD+0sOw+ZTljnFJrsPNr7xKZ00sG57PUp0CS844ylVIG4W11fnbUupkDeDNo+rPi6DvBsQaYx94xu2zN9LECUBKPTfRM26jWFFNy/PUE9ToHrZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrNkNcyw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729174292; x=1760710292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Arrat7mw8ZzbkjzLvyqYNFGgxY8Pgq8SAVp/RviN3C0=;
  b=TrNkNcyworjbt9PlZrwWTY4E04n4vJBrEBWjMAeAoQ6jbiwv39lEq/gf
   ldPY5a8gAZX2dLi8jViVvZDDY1tvBtmMmPRWkXb6Or0kVa4+v6Ij7ijI7
   HAAiPVmCwE01hbCHz59y7HlUX+jiHQnjDUpEIo7ZnFKVOXzv5cvNGMdiO
   DHjeruejW7oPZB+C+sIu8B67uK0qc1Z4BUnv2tNFnAZPbQnPOodIu7Gvl
   dVuPiuetlQgjkn8VHzLpDAqUI9doHJBfO/n0kV9K0AzKWY8maqZs9nqEF
   Fvh+NWD3dGj99nudWweivSceS1zSrmj9JnRcgTLS3CY9gk7ZR0Ek0LVac
   A==;
X-CSE-ConnectionGUID: 6U8AMqhdSqCEQY1Bo5Zc8g==
X-CSE-MsgGUID: /yBIg86CR0WTH7rn24qz2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54075348"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="54075348"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:11:32 -0700
X-CSE-ConnectionGUID: pMEREt9/Tx28oNObN5FQCA==
X-CSE-MsgGUID: b7sVqaPaTL6pEWw7tpBqYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78701368"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:11:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] PCI: Move struct pci_bus_resource into bus.c
Date: Thu, 17 Oct 2024 17:11:09 +0300
Message-Id: <20241017141111.44612-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
References: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The struct pci_bus_resource is only used in bus.c so move it there.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/bus.c   | 12 ++++++++++++
 include/linux/pci.h | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9cf6d0f3ab2b..e0a2441be6d3 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -18,6 +18,18 @@
 
 #include "pci.h"
 
+/*
+ * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
+ * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
+ * buses below host bridges or subtractive decode bridges) go in the list.
+ * Use pci_bus_for_each_resource() to iterate through all the resources.
+ */
+
+struct pci_bus_resource {
+	struct list_head	list;
+	struct resource		*res;
+};
+
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6a9cf80d0d4b..5a9d849b28ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -626,18 +626,6 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
-/*
- * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
- * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
- * buses below host bridges or subtractive decode bridges) go in the list.
- * Use pci_bus_for_each_resource() to iterate through all the resources.
- */
-
-struct pci_bus_resource {
-	struct list_head	list;
-	struct resource		*res;
-};
-
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
 
 struct pci_bus {
-- 
2.39.5


