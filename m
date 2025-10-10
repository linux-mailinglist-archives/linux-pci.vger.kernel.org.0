Return-Path: <linux-pci+bounces-37812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F73BCD955
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B16D540657
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B02F658E;
	Fri, 10 Oct 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4vZ5bvy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586472F1FE9;
	Fri, 10 Oct 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107383; cv=none; b=qyigwk94fWi3bJ7TaW64uiO0b0Pp1s1Cg1GsSaQN8GPhrYmKl8Ry6M5rYEQvaJiwrb0Mlrhn60Blo09eXSwRkqB8318DV/rHy56OlxSNvE66L+6nCM4dW+HXYhTE1zNAbOqFTq6+7clz9p57CmLwzF+9yCTF55yKXmQp+5znYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107383; c=relaxed/simple;
	bh=CoNAQv21FfT9IE9DUrO8U1Q2zCeNLD9qeUhzpmJH2Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq0PCCAl6LnbgKfh0x4pGThe1oTU/sbliLboetgn4MXz6JJHPJk5ahuoMnByj7aWY5YhmTnBUgY6QY7j9h3EiEIQK43lBrWzpx8FiWlqzdR/OkYg6KzPe8iXAerB9Kh/fFgb0zcgSj8cowhUYuXP2TyV7m5/cqfEAbVG8kaW2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4vZ5bvy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760107382; x=1791643382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CoNAQv21FfT9IE9DUrO8U1Q2zCeNLD9qeUhzpmJH2Xs=;
  b=c4vZ5bvyPGl3geZ5o1HBY36VlmuNxmzSacO6adUGDJKRgY02EhEDeOc3
   huQurmS9eLjkyZLANN/HjWebYPti1O1zFaN1QOq/ane/iqVoH65iXseVb
   fRuIBLhsUWWOQQdYaOZksf3ODLmQ6W3yvXHj9EpGRNC5yLtp7IIzqPDsJ
   3AmrU2PVZ6m5a3DWiEt+OUklFh6huQlM5knkQLkKdiFrLkbRCjT0K6Ah1
   /4+PzXFmeK2zF1fcMtBbHXO3wTPn9LR0wAYkFKgYubVNR0tiA1yb7sq7i
   m4h8vl4sna0ZlEGiz4rXVZ3ARreWYIyTFaG3+I7GCrzSl84EzWm6bERrS
   Q==;
X-CSE-ConnectionGUID: Ou1AyywFQf2k3R1tB+z8Jg==
X-CSE-MsgGUID: 3BQxd5z1Q1CHuBlrB5wB9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62370393"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62370393"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:42:56 -0700
X-CSE-ConnectionGUID: xid9jkCqStKfNqhz/r/DTA==
X-CSE-MsgGUID: xj8Bvk5SSvWKZLIwHTVzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180573825"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:42:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI: Refactor host bridge window coalescing loop to use prev
Date: Fri, 10 Oct 2025 17:42:29 +0300
Message-Id: <20251010144231.15773-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_register_host_bridge() has loop for coalescing host bridge windows
that are contiguous. It loops through all but the last entry and if
necessary, coalesces the current entry with the next.

The resource coalescing modifies the resources in place which can cause
issues if other parts of the kernel hold a pointer to the same
resource. This problem was demonstrated to happen when trying to
address an issue with the host bridge window setup on R-Car M2-W (see
the link below).

An upcoming change will perform a safe merge of the resources within a
new function in resource.c. That results in removing both old resource
entries from the resources list and despite using
resource_list_for_each_entry_safe(), the loop will no longer hold valid
pointer to any resources list as the next entry is removed from the
list.

Alter the loop to look back instead of ahead. That is, change next to
prev. When merging previous with the current resource, the next
resource remains valid so resource_list_for_each_entry_safe() is able
to continue iterating the list.

Link: https://lore.kernel.org/linux-pci/CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca7..04523dea7d96 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -952,11 +952,11 @@ static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
-	struct resource_entry *window, *next, *n;
+	struct resource_entry *window, *prev, *n;
 	struct pci_bus *bus, *b;
-	resource_size_t offset, next_offset;
+	resource_size_t offset, prev_offset;
 	LIST_HEAD(resources);
-	struct resource *res, *next_res;
+	struct resource *res, *prev_res;
 	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
@@ -1049,21 +1049,21 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	/* Coalesce contiguous windows */
 	resource_list_for_each_entry_safe(window, n, &resources) {
-		if (list_is_last(&window->node, &resources))
-			break;
+		if (list_is_first(&window->node, &resources))
+			continue;
 
-		next = list_next_entry(window, node);
+		prev = list_prev_entry(window, node);
 		offset = window->offset;
 		res = window->res;
-		next_offset = next->offset;
-		next_res = next->res;
+		prev_offset = prev->offset;
+		prev_res = prev->res;
 
-		if (res->flags != next_res->flags || offset != next_offset)
+		if (prev_res->flags != res->flags || prev_offset != offset)
 			continue;
 
-		if (res->end + 1 == next_res->start) {
-			next_res->start = res->start;
-			res->flags = res->start = res->end = 0;
+		if (prev_res->end + 1 == res->start) {
+			res->start = prev_res->start;
+			prev_res->flags = prev_res->start = prev_res->end = 0;
 		}
 	}
 
-- 
2.39.5


