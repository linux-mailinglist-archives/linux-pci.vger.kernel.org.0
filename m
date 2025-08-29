Return-Path: <linux-pci+bounces-35102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13DB3BC15
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4198A1CC18EB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1231A06F;
	Fri, 29 Aug 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESWKBIeA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667D31A061;
	Fri, 29 Aug 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473122; cv=none; b=V1HISAEuurtYiRE6lezUl/wi2Ec4NqLjHo6jdSelvAx/S3hyczh5ug/yZ9wklFahTM6qnILNg8E0zAD58UPL2aeio6Eetu/jROHWIha9xnAhwbq1y/DvVdkMmVh++bykVfoESPRmmk6u5tEb9Po7xptEeM5YU0Wsy1Y8faOMgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473122; c=relaxed/simple;
	bh=rM82OhwHo/iGvjxvD6YHBNxc60cvUbkFuOCHsZoW6bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXQOAwse3EzId3LFqciRNwfWMxN3syrd4i6X0QHnz0LMCa27FKKehow/GCD6mbToWWk1TlKPLZCe2ypB18YxGtNQ6Pfb3IUK9JiKrxvPae3yTjj+Zqfz2Q1gYLAAnyTk/eKM8AAkD+vOZQyGa0C9asD6JeEoy18EP4DMVv2bzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESWKBIeA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473121; x=1788009121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rM82OhwHo/iGvjxvD6YHBNxc60cvUbkFuOCHsZoW6bo=;
  b=ESWKBIeAVc27ud5ysGmkEBzNfVSvxebk5yIcRp0VcP+JOD2mnApwIzIb
   90wlEtFqk27GLjz9i9GRCaAGNd/Us/vKC5M7iaXONrTFWkKr+3+hn0I0d
   FmEMhjTgToz+FE+2g9zflLL5jQvvyt94Nub+HWIQn+iLfLStB2AQt+zDd
   KjXr38C4itWyNG/RGpI2DFADIPa5U4OLnfZgUFxpHQb46AlvpGro7Yp56
   VsMtbFCszJrEvqxIUv6eokp4X7gKO8mdOoUv3p5jJ/rmELdgK9AVhPiFX
   RmWLc8U6THHvZvokwd6cL4HOcsHqCMJvnXh1+i4xZHNY6HaapDCCV2y74
   Q==;
X-CSE-ConnectionGUID: A8qww1a2QAexn7zP7KXv5A==
X-CSE-MsgGUID: iPVoOP3mT/CydS2G8EJq0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62402913"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62402913"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:01 -0700
X-CSE-ConnectionGUID: zVL1JTMPTiO/sF4Viilkow==
X-CSE-MsgGUID: 9k2+iqqbRDqRFeb0dmu83A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169946724"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/24] PCI: Refactor find_bus_resource_of_type() logic checks
Date: Fri, 29 Aug 2025 16:10:54 +0300
Message-Id: <20250829131113.36754-6-ilpo.jarvinen@linux.intel.com>
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

Reorder the logic checks in find_bus_resource_of_type() to simplify them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4097d8703b8f..c5fc4e2825be 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -158,11 +158,15 @@ static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
 	struct resource *r, *r_assigned = NULL;
 
 	pci_bus_for_each_resource(bus, r) {
-		if (r == &ioport_resource || r == &iomem_resource)
+		if (!r || r == &ioport_resource || r == &iomem_resource)
 			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
+
+		if ((r->flags & type_mask) != type)
+			continue;
+
+		if (!r->parent)
 			return r;
-		if (r && (r->flags & type_mask) == type && !r_assigned)
+		if (!r_assigned)
 			r_assigned = r;
 	}
 	return r_assigned;
-- 
2.39.5


