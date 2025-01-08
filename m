Return-Path: <linux-pci+bounces-19551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC9A062DB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4663C3A7347
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E21FF7B8;
	Wed,  8 Jan 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMSq0MzM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392C19F41C;
	Wed,  8 Jan 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355750; cv=none; b=Ejs8Po0UlG6vpH4rhGa8HD5mBNp+xFIHP4xcQkFgZ7DLWGsnmmQxVcr7POjDMt2G++4jC2NoWVLk+MFh5SZvz2tneZ5xwCUt69gLeB5b6Bl273XNuxyFRnmg15NWTZsYUcH8kr9deld4PgRpv330HUSyivoI8IriPq3WMvUMVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355750; c=relaxed/simple;
	bh=to0ZeiQxfpnAdykX/BD3biuLk5m1jC1vJ3CulYg8LzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur+5f58JhlNYo9YHOzXFeymqKN0gp09EVzrIjcK16Ci+uEsFV8BTZJhP1jW6Fpc8vY5nwYDSawBrOO1UU0x7d1uGzsLswvawQYR3JlvshMF5EQR12GU+g8EDkK1zlbMc/WlvBc4TdwgN2gcIHce7akOV+3vM354uhC1Cxoc8mT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMSq0MzM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736355749; x=1767891749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=to0ZeiQxfpnAdykX/BD3biuLk5m1jC1vJ3CulYg8LzU=;
  b=cMSq0MzMzaM9fsg+faMPpX+CBzKBkEPgivQl10BTWgIjJenuLwB6Svoh
   T2jrQWmEtFAGsfVmzbX26I9JJMO9gEzXiCSNOr9KrFxbB2LuV1LIixQLI
   JqwXZFAKaTISTYc2BPt/CyQHRiXGltz4/ac6EhvWRae8vTL0789H0xKnQ
   JvSmDaB8fwt5XV3rdWpzExSYiHwnjujRdxxU/Ml2QYRl7w1dQgI+aCfCq
   97eV/8Lavddbqp5l4omkF2Q2PyVlU9jgK1bV3w0iiEt0MKjCYgNc17ks6
   9Sloi7ApXDBNAMKDtEgOq/qxTOUsFrShfWKHlN69OzApC8kHPQtToxqxf
   w==;
X-CSE-ConnectionGUID: AK4YYiEpQ+qeeNaifr0lcA==
X-CSE-MsgGUID: w5D2JlkWSiW2hoJc22DYSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35882065"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="35882065"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:28 -0800
X-CSE-ConnectionGUID: V0Pz2g6SRNCgPsgXa71rIA==
X-CSE-MsgGUID: y1tmOcNXRd6HiyKpScQ6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108255825"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:26 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 1/5] dt-bindings: PCI: altera: Add binding for Agilex
Date: Wed,  8 Jan 2025 10:59:05 -0600
Message-Id: <20250108165909.3344354-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible bindings for the three variants of Agilex
PCIe Hard IP.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Remove accepted patches from patch set.
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


