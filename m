Return-Path: <linux-pci+bounces-18538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C629F3821
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D26716C4CF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3B206F13;
	Mon, 16 Dec 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1CEVvI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5492066E0;
	Mon, 16 Dec 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371831; cv=none; b=SJRUZJvylEW3CpCSmQyyMkEgV7xfFYypExNbpq2sP4sHHsmIwsJo4F2QOrJ7a07CQD0wYWBL+WX24yr6Y+TXuMRKPQPkrQagYVG62OmYozZLtGrsCbY/c7gsS73x31aHUYwSe7Z9LWePyPBrWsI6pn6r48HZGa1iEBbHv2AVgh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371831; c=relaxed/simple;
	bh=7QpAk4U4dEoeFYRN5VbFA6twq16iBTBhGQ2Jo7UTpjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hdn5JAcbwV/BJ/YSlcwVaLM0PC8uvZKOuQ1EVL834J9FrmqgjTpQUoynea4+iuxqyZcK+2DsZKMQKiZUEYOJNN3M2kWA5mmE4gZ106eig0wfKBlVGBDXNh2oNT4Tx3ilmaRUQdWlh+vpxz10ES9DVV/VZ5oMFd/GSCTq7D+5aC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1CEVvI/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371829; x=1765907829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7QpAk4U4dEoeFYRN5VbFA6twq16iBTBhGQ2Jo7UTpjU=;
  b=j1CEVvI/9Xar15r/ufsP+YPxatHvSRffahDmdylUHuHoxQAjiAEyB+Tn
   He8ed7ubkogeb3nwmpWS1jecMMAVodYHwZWVjOiWERfla2nCsY7tn4hPX
   f8ONySgHtR1DxCctZImnUwTUWUpBKi8hguMmXu16oilroYnIDZ/qpxfah
   SXi/FN0GW3mj7pOp9u0mCflisQJv1oRE4NyxB8qiPePueQmWuCDDvydvQ
   sO/0fqViC65z380EuoR6RRIM5uenK1Uk6dDHNaVZV3gQajL0ks+ea0Uxu
   OGUcNKlE6xm5aEsVlYBv8cPGIaeu7iIQ9RpAWK82HEqb9WXiOOLYLW4aq
   A==;
X-CSE-ConnectionGUID: H6BwEfqXRX2YJXHFlHIruw==
X-CSE-MsgGUID: VNwkBbMNQ6mGoe9AHGburg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45465722"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="45465722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:09 -0800
X-CSE-ConnectionGUID: 9JJd7Z5xSXS31r/tyzD5Yw==
X-CSE-MsgGUID: QQ0f7n+ORyuXAV1rVgBkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97309411"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/25] PCI: Simplify size1 assignment logic
Date: Mon, 16 Dec 2024 19:56:10 +0200
Message-Id: <20241216175632.4175-4-ilpo.jarvinen@linux.intel.com>
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

In pbus_size_io() and pbus_size_mem(), a complex ?: operation is
performed to set size1 which becomes easier to read when decomposed.

In the case of pbus_size_mem(), simply initializing size1 to zero
ensures the size1 checks work as expected.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 09c275f8d088..7f4680a23c13 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -927,9 +927,14 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	size0 = calculate_iosize(size, min_size, size1, 0, 0,
 			resource_size(b_res), min_align);
-	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
-		calculate_iosize(size, min_size, size1, add_size, children_add_size,
-			resource_size(b_res), min_align);
+
+	size1 = size0;
+	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
+		size1 = calculate_iosize(size, min_size, size1, add_size,
+					 children_add_size, resource_size(b_res),
+					 min_align);
+	}
+
 	if (!size0 && !size1) {
 		if (bus->self && (b_res->start || b_res->end))
 			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
@@ -1058,7 +1063,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	resource_size_t min_align, win_align, align, size, size0, size1;
+	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
 	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
 	int order, max_order;
 	struct resource *b_res = find_bus_resource_of_type(bus,
@@ -1153,9 +1158,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 b_res, &bus->busn_res);
 	}
 
-	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
-		calculate_memsize(size, min_size, add_size, children_add_size,
-				resource_size(b_res), add_align);
+	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
+		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
+					  resource_size(b_res), add_align);
+	}
+
 	if (!size0 && !size1) {
 		if (bus->self && (b_res->start || b_res->end))
 			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
-- 
2.39.5


