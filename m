Return-Path: <linux-pci+bounces-34576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C7B31CFE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BA894E339C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7711320CDB;
	Fri, 22 Aug 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDV1WeRD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE2321F4A;
	Fri, 22 Aug 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874642; cv=none; b=P9EQBGAvwfhNhc+9+t98b1xTJwlTkFpp/qifX6cF85EKYiYvxSeoeQkapUnifEBgHy3FzpqcKwuRdGY8u5BGNy8j2dLwyOnCgD04D71Iip7ZX8VpsObfUSNpkfB7B1K8VEC1hbUawb434YDGae5Oa0hFK97nZBUU9i8jhICbYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874642; c=relaxed/simple;
	bh=gchIaEGGMd1rP3k9+ZAelZgSdhp5C6iJlv32uxG+nxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLuNyDdLY7654w7wv+uUsvXk34OFzPfuKp3uYf38BxgFhI0qc/p6CuvWI3drnfQi9q6uWRFV30L/wAVEbXXanfxTE7RELWy3cVP21tFuYwia3hJ0f+bR9D3s+WwoSPSI/5+QhvwllliWvg6yYUwQDNVEOoMUcZ4VY0xfmr2yiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDV1WeRD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874641; x=1787410641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gchIaEGGMd1rP3k9+ZAelZgSdhp5C6iJlv32uxG+nxU=;
  b=mDV1WeRDiJGu333qJ6WfQe1jipzw53tuRmMiLBM4WHTSOVk/W3V1QpZL
   5kmFKErxyEjgEVx9hec54svhAZ2mEgkkt9V8gCUDztUXpHHJMaq/faimZ
   AENbXrWfOqTgodi6sGRBM1dmn+YWVRHp1uhKvJcKBaYwWstx9mUeZ4RjP
   YfyYjYlwKXyZapFX8udV8/uu5gAYIBCIgtJGwjiPHMCbiiVIyn4pPXMtG
   F7Ja4Tcsf7rE516443/Xi2VPRzZeung16EVitiYK80y8PnBNddHBA2aAY
   YvoIvYO/i+ARkkQ2MQaqoS4BAS0xhfucHkVyDemwyImPjDofsUEO9zeJG
   w==;
X-CSE-ConnectionGUID: xyfnfbsdQYa5D76wjzJgaA==
X-CSE-MsgGUID: WuhRvz78QjW7Z0xKyq4iVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69283146"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69283146"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:21 -0700
X-CSE-ConnectionGUID: ypkw906bTXqIvRPHTHdqxg==
X-CSE-MsgGUID: VaLoVjPPS6WX/H2vbHvugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169547108"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:16 -0700
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
Subject: [PATCH 07/24] PCI: Disable non-claimed bridge window
Date: Fri, 22 Aug 2025 17:55:48 +0300
Message-Id: <20250822145605.18172-8-ilpo.jarvinen@linux.intel.com>
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

If clipping or claiming the bridge window fails, the bridge window is
left into a state that does not match with the kernel's view on what
the bridge window is.

Disable the bridge window by writing the magic disable value into the
Base and Limit Registers if clipping or claiming failed. To detect if
claiming the resource was successful, add res->parent checks into the
bridge setup functions.

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


