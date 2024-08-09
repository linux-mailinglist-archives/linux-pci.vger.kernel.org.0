Return-Path: <linux-pci+bounces-11546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EE894D31E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75F41C20A54
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53F1990D1;
	Fri,  9 Aug 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSySUqoi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2D198E6E;
	Fri,  9 Aug 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216442; cv=none; b=HkzkzhZ+TEHRTVInZPQR/692cgNG8N9m5EjMLd7GnD8Xc7Ug4lNcmkj5mOzS9KqWqaQHQV42B2W02yt1BnQcGOnuPgamWj6w3oXqB/6NKLEkymUkRQD8Q9Pz3HGHsQCRFx8kHDPLcW5vab0QWlCXalWfgYehITF5LWRNcVvZUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216442; c=relaxed/simple;
	bh=2pvY991hWTHWyH+PK3KunrZbyvzCTm1SW/DwSA8Bv68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPS5nc30tPc1vaQCmP4Dvdyr1ZR+J5EUYjaYbmDbMsKOa96HSaWxBrdM6/HWLHH2y8banb+vQS0e2at1gckp2su/+AkKbApsSaQTakimm5pCTUgHD6in2DL6Vsf8PagkRHV069oRYALl6FS22EXAQGuBKZQCrYxV7n5SGCjHo5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSySUqoi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723216442; x=1754752442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2pvY991hWTHWyH+PK3KunrZbyvzCTm1SW/DwSA8Bv68=;
  b=SSySUqoifW5Dl3S8v7cTwakSU02s1AvgbKWwnAf+X26zBzw+aAqS/e3D
   2QJrKfMABEmT/Ux0y0ZFuHxqgmuiKdPQUhCczKV75zxBEXylBpsHwIRwQ
   emhK0BMIsL0/Or8o+gRyP1qh+BtPVQqi/+G8JePSgk/TsCS0t0wVZT3eV
   VTRJfSCmxsrQE5buSwIUhAhPtmQnsu+1W3Ni9tKabZJWte8mS36pe9uXt
   gLEOFTE49MMG+CGOc3+LsnZmu/Y51j8oztqcfSANNbdTbKWCGak+C/olI
   3ZuhkIAWPbtcRmtRgIfRBnsUAqRnOi4tXXqAQOA5SGcgF86kDNC17CSQ6
   w==;
X-CSE-ConnectionGUID: 7ohd2d3wQh+akq2gQoa1+A==
X-CSE-MsgGUID: x1f0WjErREuduMXLuN/Ytw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21368874"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21368874"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:14:01 -0700
X-CSE-ConnectionGUID: 6OZXM5lSTpmiyNz+cWtoTQ==
X-CSE-MsgGUID: Mpen1hTqQvWlnqe0K4S2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57485960"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 08:14:00 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 3/7] dt-bindings: PCI: altera: Add binding for Agilex
Date: Fri,  9 Aug 2024 10:12:09 -0500
Message-Id: <20240809151213.94533-4-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the compatible bindings for the three variants of Agilex
PCIe Hard IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/altr,pcie-root-port.yaml     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
index 52533fccc134..ca9691ec87d2 100644
--- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -12,9 +12,18 @@ maintainers:
 
 properties:
   compatible:
+    description: altr,pcie-root-port-1.0 is used for the Cyclone5
+      family of chips. The Stratix10 family of chips is supported
+      by altr,pcie-root-port-2.0. The Agilex family of chips has
+      three variants of PCIe Hard IP referred to as the f-tile, p-tile,
+      and r-tile.
+
     enum:
       - altr,pcie-root-port-1.0
       - altr,pcie-root-port-2.0
+      - altr,pcie-root-port-3.0-f-tile
+      - altr,pcie-root-port-3.0-p-tile
+      - altr,pcie-root-port-3.0-r-tile
 
   reg:
     items:
-- 
2.34.1


