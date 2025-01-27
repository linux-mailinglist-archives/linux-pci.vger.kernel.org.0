Return-Path: <linux-pci+bounces-20413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD2A1DB70
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8315318879FC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E218DF73;
	Mon, 27 Jan 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Onr2/c+L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA71291E;
	Mon, 27 Jan 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999564; cv=none; b=ZXgzpUtN6SSGVHoaUVGjBpH+R6ULpI7Xh1kaPZZLICmkFEBbwHY6es+Y6cYivdffB/jMfBoYkCwVH4uVP14Kjp3WvxpKTjDtCLlApDTtx5FHqWR+Qx6B92tYc03ILH4yp9qJO7HQ2+NJ65didaUQdy6iU5ODyVlyyO9zslcl50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999564; c=relaxed/simple;
	bh=to0ZeiQxfpnAdykX/BD3biuLk5m1jC1vJ3CulYg8LzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFQx37GOO157jlMhWz+sZX2BF9GT3D8s4IkKpwvhYWixz4kFxPc01E+vOiwWEaFxPawmkWRu1hHulM4EThefQ4AWVE2Hdi0Qg31GtSVe5E/x8dX7qadRvYAi/YESGjNdgkfPYmnnyfmsM31sXolu+sMygd/XH9N5SI7qB1ePUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Onr2/c+L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737999563; x=1769535563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=to0ZeiQxfpnAdykX/BD3biuLk5m1jC1vJ3CulYg8LzU=;
  b=Onr2/c+L7mXfnIDMGb54GjgIQ6dvXDzU89vNhaBoWGVoJbPfO7tGyKJ8
   0tvUO0J2nWc7ZqLIzjd9yTlBGgPg7JEHceqQ3Ii82Jox0vVfPwN7ge0eC
   iKLMzKqAjntj1WJlI43IzgulRhkl6RQtymDH731Qv4qWPxs6f1ObOBEwM
   0AgOqqy4R9ABaGvJ80jn1a12MCJ87K3rL04cnQHOdo2HuODyj1fSTDGbw
   T3YBGWFksf4D0JCPWjmbchODshdhf3TFQDHhB4wSgeu5GzNuLtGbMzBiy
   YYpi4erZA4fm3KIP8Lgx2sOEnCgYEmCWX2G3k6xmIg2BQOLfTp4OxqKuI
   Q==;
X-CSE-ConnectionGUID: hwzQNW3gRYqSI2h8SzCJng==
X-CSE-MsgGUID: j+4dWEvqRyKKdBBqA1OhfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="26069470"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="26069470"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:21 -0800
X-CSE-ConnectionGUID: mpntEkj3Ss+g0s4/cgJcww==
X-CSE-MsgGUID: QRAOZRcpQi2unbwXHPilfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113124901"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:39:20 -0800
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
	peter.colberg@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v5 1/5] dt-bindings: PCI: altera: Add binding for Agilex
Date: Mon, 27 Jan 2025 11:35:46 -0600
Message-Id: <20250127173550.1222427-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
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


