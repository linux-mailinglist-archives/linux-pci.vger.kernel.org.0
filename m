Return-Path: <linux-pci+bounces-12930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C9A9708FE
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691801F21704
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EBB1779B8;
	Sun,  8 Sep 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ibJ98p/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76A17622F
	for <linux-pci@vger.kernel.org>; Sun,  8 Sep 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816767; cv=none; b=SAF4DNOT5j+RU1s8ELLvR5n9duodeD/30YZS+suvBkUOwFmhFcLUKXCw1BAG6vJvr/h/dbQLNLKkqa8XpcOdkPyamfpJqM9O9FRFg2f0E4aF7GqA0kVqcvVaisBXF2GYnDiFThnt5PD2lBKD0BEUDyLgiuut7WOXfLgMQpytq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816767; c=relaxed/simple;
	bh=nA7OrD55DWADTycCQzj+qgY8P/JDYY4XE91hoTgicEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrl6FK/sCTz86pmCLIU6nr4P8oKT8ErLxFvJ6IEPz5SzTQQCNFvDIqeCE6R+i3CumMF3bjNJ5d84VmDaqPce4Y+jnnrmjPBbAEitfAaKr4mJjFZZiKw8ZyjdxncnsvyCLISITmZLyukOOs4BmRwTsQFTpbck4GUzEc4wQMGhq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ibJ98p/x; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024090817323680eb14ff063c01dd1f
        for <linux-pci@vger.kernel.org>;
        Sun, 08 Sep 2024 19:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xh5qkc0c1+MDM8uSvx3tNtBQFpLWdYTXf/RSsVtEdy4=;
 b=ibJ98p/xG9+0uKRwbXrpftDDuC3NOwllC2IbqCSkizfOqjw3ImVvbkdLNsMVEIuTfH+Xkr
 EyddHfiXA5PkIqwfFYC363dKbq/hKMK8fc5HAHRPDJQsvjrASOlT9lecE9pDabwzLgMEgZKr
 Ip/jKF6OcqPnn/JfLboBTXF55s5ylKGAsfJbeotcnwPDf/e5Nw+vfq43I/+tgwgk/2pS8BFI
 AsvUXcZwv6+P4zVc5sW5pgQeRNRo5bqGgc2S+JhffeQVTGFH/np32q50iW/5Gp78SdmcNcQZ
 a+Gre+vZlf5IBW4/bA9b2uEwzmpVOpKlWn8RcsMxNd/chbqQ6zHNv+iw==;
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
Subject: [PATCH v5 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Date: Sun,  8 Sep 2024 19:32:28 +0200
Message-ID: <33d08f61fe9bd692da0eceab91209832bf16e804.1725816753.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725816753.git.jan.kiszka@siemens.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
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
registers which are optional unless the PVU shall be used for PCIe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 0a9d10532cc8..0c297d12173c 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -20,14 +20,18 @@ properties:
       - ti,keystone-pcie
 
   reg:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   reg-names:
+    minItems: 4
     items:
       - const: app
       - const: dbics
       - const: config
       - const: atu
+      - const: vmap_lp
+      - const: vmap_hp
 
   interrupts:
     maxItems: 1
@@ -83,13 +87,30 @@ if:
     compatible:
       enum:
         - ti,am654-pcie-rc
+
 then:
+  properties:
+    memory-region:
+      maxItems: 1
+      description: |
+        phandle to a restricted DMA pool to be used for all devices behind
+        this controller. The regions should be defined according to
+        reserved-memory/shared-dma-pool.yaml.
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
+      maxItems: 4
+
 unevaluatedProperties: false
 
 examples:
@@ -104,8 +125,10 @@ examples:
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


