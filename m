Return-Path: <linux-pci+bounces-34586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A17B31D26
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635B87BFFFB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4732F32276E;
	Fri, 22 Aug 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljkyL/av"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD12322A0C;
	Fri, 22 Aug 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874737; cv=none; b=mE7GAPccMUt87mkBv0r9UeARzTRorUEZ/tvAfPP3D3ROpiXkNvj9K7FvGGPMFR9snbda1/lqmWigtlBRMOxXIJ912accw7yWykym2rQnFqWYCLth8B+TPIh+YP6Rig/SNZMENKig8BYfw2BFOsKwmLo3NTIL9lEuKpvnajy6cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874737; c=relaxed/simple;
	bh=X8NhfOVVPeUuaZ7xzX5xjJ3Kbd+6Ye2qksEkgXo7VC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnGH6QkrvjpCooR58a4bY2DMRZDKx6ukCu72a+LH9r1p4+Iy05cBWTVtT/VK6X2Xu4PeqvvaqhebZK3X6ot14rQO4iOYBbM3KWr0Le9lFrsJny2mVnTFpB/EBURhQXxa2bjB125NWLSrn2ZW2pL8InVwNxTLq9XJm3EHZy8bvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljkyL/av; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874735; x=1787410735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8NhfOVVPeUuaZ7xzX5xjJ3Kbd+6Ye2qksEkgXo7VC8=;
  b=ljkyL/avL3bBDEWsQSQkqYlBk+MznR03gTl1/KttzBonuMXdqhRbT/k1
   eyOrv4bQRtHiPJ+Qb5+IGmNFOzItX6EnDw5rbUbkKo2ZA+LyiNojRGjZt
   rDVp3xaQuqOqsMfX28qwutZu/e1K2sd+lVrSwYeKqSFio3wDaRAMGvSOb
   FpvkpPTdZW8q+opDQ11gWyaGuJ7e1o5OPLaa/TSXG6RMmCyo1R04bJvWk
   XtfwLAm+MQyOnC6Eu10B5blf3UPybOaJQUL+NjJyhBRKaTwWlPcE/en/Y
   Qrw1kctucEpLeSw0WKpFQLUsjwbhh32gx4s0QcAFoJWHWowSa1rfjThKQ
   Q==;
X-CSE-ConnectionGUID: ayN0EGOqQwSyjkFQsSc+2g==
X-CSE-MsgGUID: +Sahd3PtTbiL7EIqPcdzXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201519"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201519"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:55 -0700
X-CSE-ConnectionGUID: czktQPQuQrqYykt9N0PyQQ==
X-CSE-MsgGUID: P1NLfDMUSq2nPtJmAVVs0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199695258"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:50 -0700
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
Subject: [PATCH 17/24] PCI: Rename resource variable from r to res
Date: Fri, 22 Aug 2025 17:55:58 +0300
Message-Id: <20250822145605.18172-18-ilpo.jarvinen@linux.intel.com>
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

Resource is going to be passed in as argument aften an upcoming change.
Rename the struct resource variable from "r" to "res" to avoid using
one letter variable name in a function argument.

This rename is made separately to reduce churn in the upcoming change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3f2776f7a1b2..dac0f0f0360b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1241,24 +1241,24 @@ static bool pbus_upstream_space_available(struct pci_bus *bus, unsigned long mas
 		.align = align,
 	};
 	struct pci_bus *downstream = bus;
-	struct resource *r;
+	struct resource *res;
 
 	while ((bus = bus->parent)) {
 		if (pci_is_root_bus(bus))
 			break;
 
-		pci_bus_for_each_resource(bus, r) {
-			if (!r || !r->parent || (r->flags & mask) != type)
+		pci_bus_for_each_resource(bus, res) {
+			if (!res || !res->parent || (res->flags & mask) != type)
 				continue;
 
-			if (resource_size(r) >= size) {
+			if (resource_size(res) >= size) {
 				struct resource gap = {};
 
-				if (find_resource_space(r, &gap, size, &constraint) == 0) {
+				if (find_resource_space(res, &gap, size, &constraint) == 0) {
 					gap.flags = type;
 					pci_dbg(bus->self,
 						"Assigned bridge window %pR to %pR free space at %pR\n",
-						r, &bus->busn_res, &gap);
+						res, &bus->busn_res, &gap);
 					return true;
 				}
 			}
@@ -1266,7 +1266,7 @@ static bool pbus_upstream_space_available(struct pci_bus *bus, unsigned long mas
 			if (bus->self) {
 				pci_info(bus->self,
 					 "Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
-					 r, &bus->busn_res,
+					 res, &bus->busn_res,
 					 (unsigned long long)size,
 					 pci_name(downstream->self),
 					 &downstream->busn_res);
-- 
2.39.5


