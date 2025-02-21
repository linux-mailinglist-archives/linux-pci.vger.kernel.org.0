Return-Path: <linux-pci+bounces-22011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE3A3FCFF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B844420794
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8724CEF5;
	Fri, 21 Feb 2025 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kssSt14P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2C24CEC0;
	Fri, 21 Feb 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157722; cv=none; b=WDJ142O91hAcPQhKtJt6xgRXoPe+Y7NmZMO71dwR9ETPsGYTmcWrWX9TfCgazX2e/HTDrA2OcFwXArbBEmk2+OzB0SjMM9zjyBITWktqy/5kyO3/bnE0pQk44TzX/ac4p4XuVrCC4UN2Avvd2HZD4oo7BTHRaMoB3cV3BHPKwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157722; c=relaxed/simple;
	bh=AVbALQzTP+0Oxj9pTou/5O/1xq7Qa3KcQgd3EWLJcbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMYC8c+ql246ypxp+1xYCk0z70LQSDNdjiiR4kesSbGNyedHJgK7dupMwX0QOLpgVX93mfrGI3TWhXREuxYikQbuV8k1nEaS9x+Qkf24+mxjorHvyEz5Js9G4zaTMM/KKk9K0hAhWS1J0p43Y2tv7krd2O2XEbOBmXP9sKswAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kssSt14P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740157721; x=1771693721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVbALQzTP+0Oxj9pTou/5O/1xq7Qa3KcQgd3EWLJcbo=;
  b=kssSt14Pv4BizYPyqV17fdzYN1J7xWb95T2WinCpO59vYazTwr4Y+Pqb
   0Uf4VaCC8jMvNm1bIln47znk5qA8EPISDEwFfFhAHFgvbBdyoqrUzS5Mp
   5WLFc/8HQ8lzeJKMUHtaRhK9TFBiP5jKRudae0F0vr2uLYhfm0jtFc15t
   r+HnQiTpQufY5fy0VIRVAMaSskywoLZY/HNO6YHQqtm2lGpOthqZHd0Bc
   +jInjJxfKvw6b6zMRjBYwbRw0QtPjFvUr0wcWoY5ZlyEz7SNvG60qiGM1
   NVUOZdY8ekjgqblFCp04TTLfudSDX4M7RSHUOMJAcyid9U5tSAAd/vD+G
   A==;
X-CSE-ConnectionGUID: BdqNRdx+QtqU/ezZYNTbLg==
X-CSE-MsgGUID: Qu15bsQKQ7anggzo2jaDEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="66348140"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="66348140"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:08:39 -0800
X-CSE-ConnectionGUID: rXV0XRfZRMW7n2WETOrdgw==
X-CSE-MsgGUID: KwZbgwwLS2Cq5mgn6Lhq9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120046090"
Received: from test2-linux-lab.an.altera.com ([10.244.157.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:08:38 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	peter.colberg@altera.com,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v8 1/2] dt-bindings: PCI: altera: Add binding for Agilex
Date: Fri, 21 Feb 2025 11:04:51 -0600
Message-Id: <20250221170452.875419-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221170452.875419-1-matthew.gerlach@linux.intel.com>
References: <20250221170452.875419-1-matthew.gerlach@linux.intel.com>
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
v8:
 - Removed patches unrelated to Agilex PCIe root port support from set.
 - Removed patches related to a specific FPGA configuration from set.
---
 .../devicetree/bindings/pci/altr,pcie-root-port.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
index 52533fccc134..1f93120d8eef 100644
--- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -12,9 +12,19 @@ maintainers:
 
 properties:
   compatible:
+    description: Each family of socfpga has its own implementation
+      of the pci controller. altr,pcie-root-port-1.0 is used for the Cyclone5
+      family of chips. The Stratix10 family of chips is supported
+      by altr,pcie-root-port-2.0. The Agilex family of chips has
+      three, non-register compatible, variants of PCIe Hard IP referred to as
+      the f-tile, p-tile, and r-tile, depending on the specific chip instance.
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


