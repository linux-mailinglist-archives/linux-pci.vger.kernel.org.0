Return-Path: <linux-pci+bounces-32773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103AB0E941
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 05:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70915414F1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 03:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B46F1917F4;
	Wed, 23 Jul 2025 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="VAJH4e4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136C21421D
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242358; cv=none; b=UneTnCGjAnusFQAfedmdhstm4nZ6CdTnPEoKOH8XzCxeBGZhClENNC6j6pP9q7wzfgN6hdw9qBk/qJy2g/HI1p0/YUS0OANNexL5mcYiM08HsoKJWeDkGQtkfYdMFB/e0U8j3UT39WaA0dcBYOwoJ09IbgBuCElFBi4Cxthg8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242358; c=relaxed/simple;
	bh=dS3Vq/AtXU+TxZP7QmUzQG/h1E9LjY5aHSbcuNRJ2HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QS/vSxzlYZ1A2sn40kiyEotgeBbwlJPn+DQDUCwF0ObMAy7ziYYmuWtRPC7s4tqPGjLdSoAe9xS+0UgoEjDD1yAOg4CP22bs6OeM+3Q+yqyvhgW2Zi0fOga8WVxVa9FUVNPwoKoyqbHVrSvMxyKwwyM2QsnMjdeymKhuRj2TZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=VAJH4e4/; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202507230345493b6f1dc294deb28b0d
        for <linux-pci@vger.kernel.org>;
        Wed, 23 Jul 2025 05:45:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SCQPF5NJaTXFf43IS370UO0r+J/hStgHdQgUeUn8d7s=;
 b=VAJH4e4/OWJu/yGdG+tGrOoUQJiSLcY902RiADs20BPEowIIceBRECvzxZLxoEjWINo6YU
 G9EgCHb5xw8W9heALwLp997pSuOvoykf7emcPSOnLe9xqMIY3ykI80Mc2M500bTa2ADH5a/X
 4mSnPgixD0ERxAFBe0aM0MYH6uzKG9lQ+Ubp6ruu7lzcLPUEtr1CSVSJgHtv3qAng965fv2m
 EhFuwl3y1+Ov+5T0JqBV+ReXVK/pJnnBbTLBMNCRJT0yX8toEkrQ8bXYcMJHKE9sHQv+v7kM
 nGq/y6R1VscamHrDg4E5qilvrhc4jbfj0u4vOTzBXl1YzHm4QA+1F6ew==;
From: huaqian.li@siemens.com
To: christophe.jaillet@wanadoo.fr
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	ssantosh@kernel.org,
	vigneshr@ti.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Date: Wed, 23 Jul 2025 11:45:16 +0800
Message-Id: <20250723034521.138695-3-huaqian.li@siemens.com>
In-Reply-To: <20250723034521.138695-1-huaqian.li@siemens.com>
References: <20250723034521.138695-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 .../bindings/pci/ti,am65-pci-host.yaml        | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 0a9d10532cc8..98f6c7f1b1a6 100644
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
@@ -69,6 +73,15 @@ properties:
     items:
       pattern: '^pcie-phy[0-1]$'
 
+  memory-region:
+    maxItems: 1
+    description: |
+      phandle to a restricted DMA pool to be used for all devices behind
+      this controller. The regions should be defined according to
+      reserved-memory/shared-dma-pool.yaml.
+      Note that enforcement via the PVU will only be available to
+      ti,am654-pcie-rc devices.
+
 required:
   - compatible
   - reg
@@ -89,6 +102,13 @@ then:
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
 
 unevaluatedProperties: false
 
@@ -104,8 +124,10 @@ examples:
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
2.34.1


