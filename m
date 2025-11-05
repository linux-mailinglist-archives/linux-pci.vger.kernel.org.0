Return-Path: <linux-pci+bounces-40305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F2C33E54
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 05:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC8EF4E2AD8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 04:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BE419AD5C;
	Wed,  5 Nov 2025 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPwndJj5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956314EC73
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315254; cv=none; b=SgRFWIRqTCmY4wD540pP2ZrmfzbJ7ZRmI5WSVoOYqdG+r/pmMvcC/ABVc1UecbUy9o/H7hfLHndFvEUVM8gAQiMH1TTB5MjMVzGi/PN1EcyWQhA8eLiEk3GtQBEgh0DiltDmuBXLafll5heCh7hO9Ig6QueiDA985rIAM6Owps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315254; c=relaxed/simple;
	bh=7NWCkN82+h+zqnPMIKreBsI7nAGKT+v/iRNc+SUJu2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcnQ3nFBDocdf0l1vrWw7xL48M0IJuRb63yVxgqDgfgrWdkRE1LoVARVVR1vFwXrwBGldacsUaXzmPBPiiuIybsuHOZHt4GwRCdP5Wy8WdeiExkU8zumeniyHcJWE2xvAzQFYEIZVtJolyf6PMT7Dg2YhXastY6GG3qKVJZMsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPwndJj5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762315253; x=1793851253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NWCkN82+h+zqnPMIKreBsI7nAGKT+v/iRNc+SUJu2A=;
  b=bPwndJj55NBHBSghz9VrjRTXxghInCPuQPRYI33zVCB/ZTaj/ai+aDvD
   V5D0q2FJlEqQRZ5vLnn1FC2taGiLuClP892RAdsGNJwsliciduaXWoyqs
   f7+80bI4BNa7zFCSlojQ0O8C3MpR6E/AWjxOzIWSixtRa1CRIqnakk9sY
   gztAEDt5E/Mf8ZyvRCrBjUoSe6AlWzdo5OHWr7JOlhTMEAGqi939lgxXd
   Gp94+lAuXbQ/NUfXeY9hj8Ac3Ovf4t08TWT8LN9VsGhjg9pBMv+5KhYc1
   vqfJX9uo5zRzUPt89zd5/rvUzD71QBRzsnkUlDWmxsMC10pzM4Ft/BlAs
   w==;
X-CSE-ConnectionGUID: UujSSkhbQWKQvf0wgHUynQ==
X-CSE-MsgGUID: b/qmnhA8ReybklFj9IarPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64328830"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64328830"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 20:00:52 -0800
X-CSE-ConnectionGUID: ntcbriBQTB+Lm8ParSwq8g==
X-CSE-MsgGUID: LAklPVQ2QNygH406HEfhqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="224588517"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2025 20:00:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	aik@amd.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/6] resource: Introduce resource_assigned() for discerning active resources
Date: Tue,  4 Nov 2025 20:00:50 -0800
Message-ID: <20251105040055.2832866-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105040055.2832866-1-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A PCI bridge resource lifecycle involves both a "request" and "assign"
phase. At any point in time that resource may not yet be assigned, or may
have failed to assign (because it does not fit).

There are multiple conventions to determine when assignment has not
completed: IORESOURCE_UNSET, IORESOURCE_DISABLED, and checking whether the
resource is parented.

In code paths that are known to not be racing assignment, e.g. post
subsys_initcall(), the most reliable method to judge that a bridge resource
is assigned is to check the resource is parented [1].

Introduce a resource_assigned() helper for this purpose.

Link: http://lore.kernel.org/2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux.intel.com [1]
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/ioport.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..9afa30f9346f 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -334,6 +334,15 @@ static inline bool resource_union(const struct resource *r1, const struct resour
 	return true;
 }
 
+/*
+ * Check if this resource is added to a resource tree or detached. Caller is
+ * responsible for not racing assignment.
+ */
+static inline bool resource_assigned(struct resource *res)
+{
+	return res->parent;
+}
+
 int find_resource_space(struct resource *root, struct resource *new,
 			resource_size_t size, struct resource_constraint *constraint);
 
-- 
2.51.0


