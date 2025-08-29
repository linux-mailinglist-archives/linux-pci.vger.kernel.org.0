Return-Path: <linux-pci+bounces-35114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D4B3BC30
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEC7C3BDE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F03218A3;
	Fri, 29 Aug 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lT7gYvGD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753031DD8C;
	Fri, 29 Aug 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473210; cv=none; b=aEhUwnaUHerrE12p3IBL+QLFcLPqd6ESh3Uw7JHrk8KtVtdowqH5QOeut03WVEED/SkNwZ99cmqseFIk0xOKgXz2cuo0GsUjlhe9rwHJBgY+Bqfz3q9SNr9J6mFv6wh3J9twu15rh3A7DtYr0ILgR6wEqz2TfjEdcPv2u2l7NTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473210; c=relaxed/simple;
	bh=hKFs7q8kFAwGpFS94xbAyKK07PxLfWSk+RCo81+5mq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OehoB1Zb50yMx3F35l85VsNGJHbCl9PGFxgnQHH5iMvrcpiP9GsorT2qYNpERqjbMNgJ6QeyjHr9Y+sNkdJhK/29Yy+NdZjgUiMwNvJrUmNJVewg4vYa24BXqoAwy2mQknc4uiKr5tzwLBr+Y6DTY0WvFZSGDhfWOo6umrGNd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lT7gYvGD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473210; x=1788009210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKFs7q8kFAwGpFS94xbAyKK07PxLfWSk+RCo81+5mq4=;
  b=lT7gYvGD1ige8VbCgq5BAAMSDBs4AhRinS+fIgqJjIeve9JZ/ciA3ezo
   pA49f5w3xEUFyz7CIW3E8vf/XYR3zzrGhX0mZX6uFsHJ3fFlSmx3PoT3L
   FpKwRYncPV/VJblac6LB1RFZNebSkN+7xHax1zLb+w2hm6Fg4L0mNTdvh
   +3RMZbdFGPMj9Zwedx0gewtMjA7XBVuMF2mZm+TZU+DZdLsnePQCF6vEt
   IwNTDqsyIod0QKWEZR08wfMRow7H5mlAlt2JPntWhPszxoi/PaUbQ6lXJ
   mGhdhgp/5tV8DheVUu84nvwA/VUk0iib+N+wLVPQAEzmMfjcil5veFVZm
   Q==;
X-CSE-ConnectionGUID: D2kD9+zIR6Sbsysts8O5GA==
X-CSE-MsgGUID: RZxL9oHyQH+jWFXy46OrKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62587483"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62587483"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:29 -0700
X-CSE-ConnectionGUID: X86hfhkTSX66MU4WG8si0Q==
X-CSE-MsgGUID: YDjUKg3mQVKRjWB8pG3byA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175656784"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 17/24] PCI: Rename resource variable from r to res
Date: Fri, 29 Aug 2025 16:11:06 +0300
Message-Id: <20250829131113.36754-18-ilpo.jarvinen@linux.intel.com>
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

Resource is going to be passed in as argument aften an upcoming change.
Rename the struct resource variable from "r" to "res" to avoid using one
letter variable name in a function argument.

This rename is made separately to reduce churn in the upcoming change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a21d6367e525..5ec446c2b779 100644
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


