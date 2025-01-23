Return-Path: <linux-pci+bounces-20295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B6A1A98F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79883A8B60
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31659186E20;
	Thu, 23 Jan 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELCcb0pm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07D4A1D;
	Thu, 23 Jan 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656585; cv=none; b=omI5JLrgtKu6OnpUegqKHxVfVV8MGA84MZwcnQmE+VcSeY9ueu7QpdgJYc+c7R+Rdauem/Zgc4mdeS09Vm/QtvUAZHcyxfpV5KDmTfTTjLZ5y7KUH1XBBvD4HWFPKJ+I7FMT5ruTDYem8OU7EqZ9qdNtK81VG0vt05SxX//CxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656585; c=relaxed/simple;
	bh=to0ZeiQxfpnAdykX/BD3biuLk5m1jC1vJ3CulYg8LzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTW6Uthu1sYDAjMx6z3zF9kOfIJtLVBPq0/oCuYjW+PFZD7q+lSD/Fb5sOqVNSM4uVhVX3JoA2DRzR2g7qhrZzaCgCYABTXeOvv491urNe93QXBBYAZSrs4Hwoo2a6pdvuk0Gq46AiOJZI+lN0EHa39sgiTv/bsgG73nQtw5aGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELCcb0pm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656584; x=1769192584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=to0ZeiQxfpnAdykX/BD3biuLk5m1jC1vJ3CulYg8LzU=;
  b=ELCcb0pm4rV+k644AeGrZ7b+YlCaWoM3kv++d+nJ9lRIKho6DoK1PeOu
   WsR5RThCjaOWkvXdUeAaYAg69Sh7DLDZJHOUx6JOfEIWFJ+QR+7Gvixfh
   7X4tYB0tW1aHICnPLF7eHmKWio6ceNSA018jdIvzM72IuKiPjAHy70ocn
   sa4Yqs1Ves1dvP4UQqgFJmSGAdcnKVGBj6nxtMZC9votbkZCYgUwapE6J
   /YAjlCfyr5Bza6ScOxWixt/Vci3oAC6FuudQGVcYizgQxRJlIRL/v2CzJ
   ln7yuTm12whgNrt9m5XPktnxa6rTMb5ZLKTOtlSCLGFsw380kkCGyZGG1
   Q==;
X-CSE-ConnectionGUID: Z9tsVXcjSH60BH3E58UB3w==
X-CSE-MsgGUID: hAE4ETXtQRWhVPUl6iX6mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49573239"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="49573239"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:02 -0800
X-CSE-ConnectionGUID: 4Eg5nenITTqSxH9hP8jFFQ==
X-CSE-MsgGUID: PFKHd94LTS+eZpOkY8TA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111574806"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:23:01 -0800
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
Subject: [PATCH v4 1/5] dt-bindings: PCI: altera: Add binding for Agilex
Date: Thu, 23 Jan 2025 12:19:28 -0600
Message-Id: <20250123181932.935870-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
References: <20250123181932.935870-1-matthew.gerlach@linux.intel.com>
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


