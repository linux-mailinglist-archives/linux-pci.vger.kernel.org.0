Return-Path: <linux-pci+bounces-10933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF2F93F11F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FB41C21ADA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E5140395;
	Mon, 29 Jul 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IFDj7z0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6913E41F;
	Mon, 29 Jul 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245363; cv=none; b=eBqctPl97bAhBEglMOn2ywXTRwe26x5CdPHjrf91s2qz70MZvL7qhaAxBIeKU8RymZf2nkCMB2P7mjM6kBaad6PShadhMuocO9PittD11baBVrLPoF8Cd5fHmFvDLOkLhrx2hehMGB8GU5oQ5AmIiZohk9NhySoi1mK5wKKPMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245363; c=relaxed/simple;
	bh=tU98mYyp6OGsVIxm+A5skwUiGi4u11EGnhGWUT7dXTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL7HOPxYYOj0OTN/yGwBj1hYCiQl1mWi5imhDaX94cO4wkmSxHNtdWqz4NeZ1zigu5Mehaj7pag6PXk20Zbi/ERFlAJYeHyeK8Uyzofis2Vccvta1UUBgpVB4Ey9JHTpUREAAQmHYpAGIt9R8vXgCHKxflfytlAJCUFzEhYuk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IFDj7z0c; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T9T69Z031881;
	Mon, 29 Jul 2024 04:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722245346;
	bh=n5l37iqbSU4qBow91hqMSNtaJx7p1e5/sHaJofLQc3M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IFDj7z0c+4jjLV8N4A7li9Iq2k58WnWa4d917bLMFD1CI8rHDLcK01WBV2csaVtuB
	 mFsc8L3631+lXRtoIEFkIIL6CTQfakj7mvoi3iCtlCU/ZCdxgMo6gYMujmiWafGo5/
	 wzDPSIPr91EeU9WWH+lZsnLE+7IKC83V3M1P5/PQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T9T6eO025830
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 04:29:06 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 04:29:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 04:29:05 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T9Stc6087068;
	Mon, 29 Jul 2024 04:29:01 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vigneshr@ti.com>, <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control property
Date: Mon, 29 Jul 2024 14:58:54 +0530
Message-ID: <20240729092855.1945700-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240729092855.1945700-1-s-vadapalli@ti.com>
References: <20240729092855.1945700-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the "ti,syscon-acspcie-proxy-ctrl" device-tree property which is
used to obtain a reference to the ACSPCIE Proxy Control register along
with the details of the PAD IO Buffer output enable bits.

The ACSPCIE Proxy Control register is used to drive the reference clock
for the PCIe Endpoint device via the PAD IO Buffers of the ACSPCIE module.
The ACSPCIE module can be used as an alternative to either an on-board
clock generator or an external clock generator for providing the reference
clock to the PCIe Endpoint device.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v1:
https://lore.kernel.org/r/20240715120936.1150314-3-s-vadapalli@ti.com/
Changes since v1:
- Collected Acked-by tag from:
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  https://lore.kernel.org/r/1caa0c9a-1de7-41db-be2b-557b49f4a248@kernel.org/

 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 15a2658ceeef..69b499c96c71 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -38,6 +38,16 @@ properties:
       - const: reg
       - const: cfg
 
+  ti,syscon-acspcie-proxy-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the ACSPCIE Proxy Control Register
+          - description: Bitmask corresponding to the PAD IO Buffer
+                         output enable fields (Active Low).
+    description: Specifier for enabling the ACSPCIE PAD outputs to drive
+                 the reference clock to the Endpoint device.
+
   ti,syscon-pcie-ctrl:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.40.1


