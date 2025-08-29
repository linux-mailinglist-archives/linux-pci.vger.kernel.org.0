Return-Path: <linux-pci+bounces-35104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DFB3BC18
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7031CC1A89
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C2931B106;
	Fri, 29 Aug 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WF01qQwG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFD31A563;
	Fri, 29 Aug 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473137; cv=none; b=BzdzjpTCG9Z9F68eJzR3xR806qlrhDlHVfGMGU3DBq8KL5B1p5vzK7hVs/8LBXHiOnEwGTYmmAq5A2HKmjj/ptXQagrHWkwSUHaj8cPq4tGfT+ZyyL4pmwzTRc3vEQ8HSngPgg4ToNnJSpJdUsIS+bDhSO8jVHQ1pf0+7QnfRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473137; c=relaxed/simple;
	bh=o67wBBtDb3ifV2Ku79cWn/DFcDwLVFbBIY5IplZQPDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JN3uwhNVsmOfG6k03vdCOCWQhrBNiiJrkiExd28kCx232C7pd1YI08Twi08OtfS9hV7OhlGYb9jQRMp9754r7fJH2mCKwu+V8hoNZBfzVKzMaKN2Hqzk5H6PGLqAeo8OGCkcMVtLcNxu8WHoJIt4MwdrG2hiFBWcdxg7NY8Y2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WF01qQwG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473136; x=1788009136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o67wBBtDb3ifV2Ku79cWn/DFcDwLVFbBIY5IplZQPDU=;
  b=WF01qQwGR/+hBrlQP7Wra/5DC57jydi98bWTkSxxxTNSago6Rsc66My9
   BwdY9jsWCbsdl1tBuUnUN7A0mJMC5WANbeRvcIEUt5Ro2BBLdbdjzFR1X
   rnrri6HN8fAyqqB+YFzix3rYrJCraUyyanHq8q4z7Xuktj4zQDbeN1jJS
   CmaDmxKWznHsF2sJjSjAXfkAspqLySUvtLt3lptTctcFIP4nciFuj+Kur
   8/cSci5uVwfRyZF4E0lSdR4JM9av5AZOAVFzCZYV8tFWfCN0CDLfqaJyv
   SzOMztciuTBGQyFC4py557G16OHVTVYN9+eo0jWSSjNPXSsWOhjTwuEb2
   A==;
X-CSE-ConnectionGUID: BVnD9JH8Q6+pncC6ARpe+A==
X-CSE-MsgGUID: OpqDwbyNQf2WUugG99o25w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62402929"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62402929"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:15 -0700
X-CSE-ConnectionGUID: 9KO3Y+OyT+Gc6Zg9wJFMZQ==
X-CSE-MsgGUID: f6S0P4YKTD+3+vf5XljP4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169946732"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/24] PCI: Disable non-claimed bridge window
Date: Fri, 29 Aug 2025 16:10:56 +0300
Message-Id: <20250829131113.36754-8-ilpo.jarvinen@linux.intel.com>
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

If clipping or claiming the bridge window fails, the bridge window is left
in a state that does not match the kernel's view on what the bridge window
is.

Disable the bridge window by writing the magic disable value into the Base
and Limit Registers if clipping or claiming failed. To detect if claiming
the resource was successful, add res->parent checks into the bridge setup
functions.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b477f68b236c..6bdc1af887da 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -660,7 +660,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[0];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_IO) {
+	if (res->parent && res->flags & IORESOURCE_IO) {
 		/*
 		 * The IO resource is allocated a range twice as large as it
 		 * would normally need.  This allows us to set both IO regs.
@@ -674,7 +674,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[1];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_IO) {
+	if (res->parent && res->flags & IORESOURCE_IO) {
 		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
 					region.start);
@@ -684,7 +684,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[2];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_MEM) {
+	if (res->parent && res->flags & IORESOURCE_MEM) {
 		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
 					region.start);
@@ -694,7 +694,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 
 	res = bus->resource[3];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_MEM) {
+	if (res->parent && res->flags & IORESOURCE_MEM) {
 		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
 					region.start);
@@ -735,7 +735,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	res_name = pci_resource_name(bridge, PCI_BRIDGE_IO_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_IO) {
+	if (res->parent && res->flags & IORESOURCE_IO) {
 		pci_read_config_word(bridge, PCI_IO_BASE, &l);
 		io_base_lo = (region.start >> 8) & io_mask;
 		io_limit_lo = (region.end >> 8) & io_mask;
@@ -767,7 +767,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
 	res_name = pci_resource_name(bridge, PCI_BRIDGE_MEM_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_MEM) {
+	if (res->parent && res->flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		pci_info(bridge, "  %s %pR\n", res_name, res);
@@ -796,7 +796,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 	res_name = pci_resource_name(bridge, PCI_BRIDGE_PREF_MEM_WINDOW);
 	pcibios_resource_to_bus(bridge->bus, &region, res);
-	if (res->flags & IORESOURCE_PREFETCH) {
+	if (res->parent && res->flags & IORESOURCE_PREFETCH) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		if (res->flags & IORESOURCE_MEM_64) {
@@ -848,6 +848,8 @@ static void pci_setup_bridge(struct pci_bus *bus)
 
 int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 {
+	int ret = -EINVAL;
+
 	if (i < PCI_BRIDGE_RESOURCES || i > PCI_BRIDGE_RESOURCE_END)
 		return 0;
 
@@ -861,11 +863,8 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 		return -EINVAL;
 
 	/* Try to clip the resource and claim the smaller window */
-	if (!pci_bus_clip_resource(bridge, i))
-		return -EINVAL;	/* Clipping didn't change anything */
-
-	if (!pci_claim_resource(bridge, i))
-		return -EINVAL;
+	if (pci_bus_clip_resource(bridge, i))
+		ret = pci_claim_resource(bridge, i);
 
 	switch (i) {
 	case PCI_BRIDGE_IO_WINDOW:
@@ -881,7 +880,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.39.5


