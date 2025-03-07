Return-Path: <linux-pci+bounces-23122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83633A56A07
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE26E188A432
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529AA21ABDB;
	Fri,  7 Mar 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDngAq3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB213A86C;
	Fri,  7 Mar 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356574; cv=none; b=Mlwhidyb1WG7HJ5ufDHchD2yQiEdd4MWLFSHgsf2roS7ZK5DRZra83cCFgghCb1I3WRlCz74qcEjuMMT7Y2Gi7nthcWO/Mvkm1DCVPxlQVaLDTepnVtLbBsOSZSCEs5HWQ4qTt+Th8YCw5I57rJO6lYNYsCOtjdFqUO8HSI845o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356574; c=relaxed/simple;
	bh=QlEoGVXKZTShMRvQ4USDMb2GPYj+O4LdSSE2LnXQHmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xfm6WOBUeZyxI64wf1BBMccSBrYtbOJjaWMPCb8dkG3jpNMnj5JJbTjqYBek8CWhhrxE5XWTgD2D9FtrHI+nIPkOrtkDIkLd7fmu3VD5l5viYJahd8NC+ZNk5nBhIGCVR/5y4wW3jThKuVYcgN+NMC+KUAPaVqBrFGFDrion1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDngAq3R; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741356573; x=1772892573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QlEoGVXKZTShMRvQ4USDMb2GPYj+O4LdSSE2LnXQHmE=;
  b=lDngAq3R7AJ/DoJ3Q/gFNmraMm+BgS98aoiRcEJmbiQ28VDcGmgQX7FB
   rgY0JxRsxKBdKJbfnPZ7GyV0KPh2hUZajcNiwpymbj+bVGumunqscbtjJ
   Lhk7M0nD17tnnt7G+qTOrkTLJBuNhlnLQF3dgu9JpNwirt0mvmRBqLXoT
   hHv4itlbHCy9iMf+vT6yFzJ2gHDna105Q/9mk6ZOW/J/JT776UJ+AM6eL
   egMrqP7c2g5lOY9JegU5fMz6HFPIiD5UJt48JBOohGOFiUQA99Zg6NhDa
   TVXg0s7hhSH1NPyU38JN4lQqXrmrHx8fk0pmdtpUKbsPDVVdfWqsMFplB
   w==;
X-CSE-ConnectionGUID: rPNSJUyxTh+MuI0gPvGq+g==
X-CSE-MsgGUID: C2xWfSIcQ4id7d418QBsEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53045205"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53045205"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:09:32 -0800
X-CSE-ConnectionGUID: dM81vwytTJi5CM1y/u8hZA==
X-CSE-MsgGUID: 5rykSzCmQvmCB+sxu5O+rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119258813"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:09:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Do not claim to release resource falsely
Date: Fri,  7 Mar 2025 16:09:22 +0200
Message-Id: <20250307140922.5776-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_release_resource() will print "... releasing" regardless of the
resource being assigned or not. Move the print after the res->parent
check to avoid claiming the kernel would be releasing an unassigned
resource.

Likely, none of the current callers pass a resource that is unassigned so
this change is mostly to correct the non-sensical order than to remove
errorneous printouts.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ca14576bf2bf..21719ae29a34 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -414,11 +414,11 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 	struct resource *res = dev->resource + resno;
 	const char *res_name = pci_resource_name(dev, resno);
 
-	pci_info(dev, "%s %pR: releasing\n", res_name, res);
-
 	if (!res->parent)
 		return;
 
+	pci_info(dev, "%s %pR: releasing\n", res_name, res);
+
 	release_resource(res);
 	res->end = resource_size(res) - 1;
 	res->start = 0;

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
prerequisite-patch-id: e4a2c15d0cd3241e2fdb1af98510211e63ec3d06
-- 
2.39.5


