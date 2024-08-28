Return-Path: <linux-pci+bounces-12371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A8962F2B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91063283903
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2041AAE1D;
	Wed, 28 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="g7mnqD5b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248C1A76B9
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868088; cv=none; b=fIYCHeG2gWHH42uRc3Z9nCZ6P9POamFG9UGaxsupMnLQQt/ITJLgZkOIfOW+ws+Wxnbo18Pt8XkYHGa1rYHxaEpl42uR2rkUjhUrFyFGWLnD+l8ZG9x0///HrmckFF9Le+DVTuIqtO7dMlDUaJLBt/2QySMn/OF1iAk1xbt8K/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868088; c=relaxed/simple;
	bh=L7JPxl8R9FZ+yWGawfiXacqspkxD3trGrjXuYvfK+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdBGAkHzQ/o0tzWTQ9ikEPsuWOSQ1BbCReYXa2y9P2sU4xptyx4ANzPz3ExEWQJlgu88niUZUnUOBllPCdSPH+dSpHF8mLqo7EFra0oHeOTNVqNnYU6D+Mz599E2f/J0dXz8hv9+qZALD9+Xw/gNpkSEKVInBoolpWD3QYslOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=g7mnqD5b; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240828180123745db8d23b1465f9c7
        for <linux-pci@vger.kernel.org>;
        Wed, 28 Aug 2024 20:01:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DgtS7ahOE4MmAw5xSeUX02j6OJr0If6h53x4evkGsRY=;
 b=g7mnqD5bJ/GkC29L6iZcwO+1tjNpEnN3EHERw/V0R1L7LmyMv5UuqI+uKudZ6u1BgXUS2A
 bQhDPLsJ9QZZOFa50VX4Zf3RsenccdaHkliVVUsFuo30tBOApP8pU6fq96Mr0E2rytzFJP2a
 laCRhZjPabu9rC71xKcn4Bw3niZ5XJwadl2aH7AcBIhrJAUpvYSL7wD7pisMqnkfy5SbPXjs
 FFo+nXtS3YSNIF380hqhcs03qO3m5WpAu7LYXZCm1varvgMwNxYRH2bCNz0/lfxKFTW4SJjD
 L7ZDeiRantqvXZXtKwrCAS5Xq4DlOoS5ayzgztwngDwyaUYm0GU+ha/A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Date: Wed, 28 Aug 2024 20:01:15 +0200
Message-ID: <752fb193661bb5e60e5aae6f87704784cbad145d.1724868080.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724868080.git.jan.kiszka@siemens.com>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
to specific regions of host memory. Add the optional property
"memory-regions" to point to such regions of memory when PVU is used.

Since the PVU deals with system physical addresses, utilizing the PVU
with PCIe devices also requires setting up the VMAP registers to map the
Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
mapped to the system physical address. Hence, describe the VMAP
registers which are optionally unless the PVU shall used for PCIe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 0a9d10532cc8..d8182bad92de 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -19,16 +19,6 @@ properties:
       - ti,am654-pcie-rc
       - ti,keystone-pcie
 
-  reg:
-    maxItems: 4
-
-  reg-names:
-    items:
-      - const: app
-      - const: dbics
-      - const: config
-      - const: atu
-
   interrupts:
     maxItems: 1
 
@@ -84,12 +74,48 @@ if:
       enum:
         - ti,am654-pcie-rc
 then:
+  properties:
+    reg:
+      minItems: 4
+      maxItems: 6
+
+    reg-names:
+      minItems: 4
+      items:
+        - const: app
+        - const: dbics
+        - const: config
+        - const: atu
+        - const: vmap_lp
+        - const: vmap_hp
+
+    memory-region:
+      minItems: 1
+      description: |
+        phandle to one or more restricted DMA pools to be used for all devices
+        behind this controller. The regions should be defined according to
+        reserved-memory/shared-dma-pool.yaml.
+      items:
+        maxItems: 1
+
   required:
     - dma-coherent
     - power-domains
     - msi-map
     - num-viewport
 
+else:
+  properties:
+    reg:
+      maxItems: 4
+
+    reg-names:
+      items:
+        - const: app
+        - const: dbics
+        - const: config
+        - const: atu
+
 unevaluatedProperties: false
 
 examples:
@@ -104,8 +130,10 @@ examples:
         reg =  <0x5500000 0x1000>,
                <0x5501000 0x1000>,
                <0x10000000 0x2000>,
-               <0x5506000 0x1000>;
-        reg-names = "app", "dbics", "config", "atu";
+               <0x5506000 0x1000>,
+               <0x2900000 0x1000>,
+               <0x2908000 0x1000>;
+        reg-names = "app", "dbics", "config", "atu", "vmap_lp", "vmap_hp";
         power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
         #address-cells = <3>;
         #size-cells = <2>;
-- 
2.43.0


