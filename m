Return-Path: <linux-pci+bounces-2262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAAD830383
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9E51F26E22
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC014A83;
	Wed, 17 Jan 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x50NvCKP"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7414A8E;
	Wed, 17 Jan 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487166; cv=none; b=N8HseUzeFG00YS2CSLZ9cifEfeeojBbKufsW8viSpx4MTGd1A9yxtmaYK01bg/Cd7saGGVF8jvzh391USNaGy11xnw5eZTRS+R7YQi/KTqkV9L2lW8ztfM9VuYU1fB5NDhuTDQ770R9jpD8fpXX+a6ph1yORXGO2ijQ88u53a1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487166; c=relaxed/simple;
	bh=nahy3SS6sJexvp/Fe+FnCJVPr3TOlktOrrshUHTXvMg=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=qF0IY2SEVh7JAVQNCOxsvE1sBH8FS+sLb0lgamg+1SDTKUrIani2WVo0uo70hXKsAIpxxzw/nuU3QVdIdoBHAU9XA7BsNlfdX9WT5KAqbKw3VtHQPlxIzL1vtLJgwib1nwuY37znVPyx+kq0mEJhs4n6c/hLyd0snqC3fq5Our8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x50NvCKP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPiIv090260;
	Wed, 17 Jan 2024 04:25:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705487144;
	bh=0OJmNLdqlDpealeON2rR+yAWVUQlNSGGnDJNQz+hl1Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=x50NvCKPz5fIcWDVTwbJJEOJNFku7WdsPiuuak7BFLnCaioxIy4U27cah1A9YjkdX
	 2I9Cd0H2ZmWFtDzX6zrAX8EkeRw3U4s6ZUAWZTOS7fS1hi36pVa7llRGfm9bPlWeR1
	 BCDN26gNHlYhR1hVh/hsHaWQPpP4zJZCtPmMroTI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HAPi39035540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 04:25:44 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 04:25:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 04:25:44 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPQIi042834;
	Wed, 17 Jan 2024 04:25:40 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/3] dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC
Date: Wed, 17 Jan 2024 15:55:26 +0530
Message-ID: <20240117102526.557006-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117102526.557006-1-s-vadapalli@ti.com>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J722S SoC has one instance of a Gen3 Single Lane PCIe controller.
The controller on J722S SoC is similar to the one present on TI's AM64
SoC, with the difference being that the controller on AM64 SoC supports
up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.

Update the bindings with a new compatible for J722S SoC and enforce checks
for "num-lanes" and "max-link-speed".

Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 005546dc8bd4..b7648f7e73c9 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-pcie-host
+      - const: ti,j722s-pcie-host
       - const: ti,j784s4-pcie-host
       - description: PCIe controller in AM64
         items:
@@ -134,6 +135,18 @@ allOf:
           minimum: 1
           maximum: 4
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: ti,j722s-pcie-host
+    then:
+      properties:
+        max-link-speed:
+          const: 3
+        num-lanes:
+          const: 1
+
   - if:
       properties:
         compatible:
-- 
2.34.1


