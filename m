Return-Path: <linux-pci+bounces-36859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1195B9A20E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC644C03FB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322C303CA0;
	Wed, 24 Sep 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huVT09G3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531212DF71D;
	Wed, 24 Sep 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722215; cv=none; b=bGVCe1rJviLpRLeSo7Mlo2bFU0jmdCMzdx5clZtSP5AGtDinmbBQiztmcOvTImkJSSJt31Mbj3Lu1YKL0nO6yQVr02PmziSrZRgB65PFs4BNuazE7Ye+fvtHd9PI4ShtPX7j3aizKB/m2twRV1aEtBINZDhlgAetVD9hSGlZDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722215; c=relaxed/simple;
	bh=pLC6wjH5w3LHcx7PnM6ppNHXQW+ibNKf9rH+70rz0Z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o1eL9CS5GqWwTE/6WgqvDnhUvXimnF0LkqqPlgYSDPHAaJjGmWzDg0pKbUWA3mV7mptqraLKSYi8751RBrZafZQfa3qp7vWzK3nEAxXOwlv8/J4RUcgriqM1InzchTH9tUXJEWezStBNyC42jCRpZoW1H3lAXu0bMm4V2m6jxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huVT09G3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758722213; x=1790258213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pLC6wjH5w3LHcx7PnM6ppNHXQW+ibNKf9rH+70rz0Z0=;
  b=huVT09G3weTOClI6MLSgxvYSbNcFgKXSE8guvlfLCBiMGcNyW6hRoyJb
   igN0q0S/UW6FxCxraWUd10YyxP1KwyIC1sVWW+Hp8V/hzGuZS+Lc6BSWu
   v2S78ul/8/ga4MqgQCyRCE6k+L3siy5u8cPmhBdssGeN4+ZtGp6ZW/0z+
   +lPSKgze8/DkkEXMpWvqLcgDZ6nPUeBVraI9I8H2CMgFbSm5seGVsmDbq
   LG/UK+bXbCqsRQOP3OSUbiOQNHeZDTbUtwCTXsSvAQbg8ShD8amP8Nr2F
   AE3UyQeWkMTPc5GZOCGrNQpiuX/hagfy1xcfAmwIdH0CCoQWWB/enhHNA
   w==;
X-CSE-ConnectionGUID: z0KlxBJ/S0aMeQFR64/ILw==
X-CSE-MsgGUID: yS6aN6/yTn6Ch4k9c56kTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60942436"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="60942436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:56:50 -0700
X-CSE-ConnectionGUID: k9yk4Ni6QsiDCUQQKWEsCw==
X-CSE-MsgGUID: 4eR9z9OFShKSFxRJ92fmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="182317678"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:56:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Don't print stale information about resource
Date: Wed, 24 Sep 2025 16:56:41 +0300
Message-Id: <20250924135641.3399-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem() logs the bridge window resource using pci_info() before
the start and end fields of the resource have been updated which then
prints stale information.

Set resource addresses earlier to make understanding logs easier.
Regrettably, this results in setting the addresses multiple times but
that seems unavoidable.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Based on top of pci/resource branch.

 drivers/pci/setup-bus.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d264f16772b9..362ad108794d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1317,6 +1317,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
 	resource_size_t relaxed_align;
+	resource_size_t old_size;
 
 	if (!b_res)
 		return;
@@ -1387,20 +1388,24 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 		}
 	}
 
+	old_size = resource_size(b_res);
 	win_align = window_alignment(bus, b_res->flags);
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, win_align);
-	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
+	size0 = calculate_memsize(size, min_size, 0, 0, old_size, min_align);
 
-	if (size0)
+	if (size0) {
+		resource_set_range(b_res, min_align, size0);
 		b_res->flags &= ~IORESOURCE_DISABLED;
+	}
 
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
 		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
 		relaxed_align = max(relaxed_align, win_align);
 		min_align = min(min_align, relaxed_align);
-		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
+		size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
+		resource_set_range(b_res, min_align, size0);
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
 			 b_res, &bus->busn_res);
 	}
@@ -1408,7 +1413,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
 		add_align = max(min_align, add_align);
 		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
-					  resource_size(b_res), add_align);
+					  old_size, add_align);
 
 		if (bus->self && size1 &&
 		    !pbus_upstream_space_available(bus, b_res, size1, add_align)) {
@@ -1416,7 +1421,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 			relaxed_align = max(relaxed_align, win_align);
 			min_align = min(min_align, relaxed_align);
 			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
-						  resource_size(b_res), win_align);
+						  old_size, win_align);
 			pci_info(bus->self,
 				 "bridge window %pR to %pR requires relaxed alignment rules\n",
 				 b_res, &bus->busn_res);

base-commit: 43b4f7cd064b2ae11742f33e2af195adae00c617
-- 
2.39.5


