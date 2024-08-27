Return-Path: <linux-pci+bounces-12243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820EB96013E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 07:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B451C21619
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208751487D6;
	Tue, 27 Aug 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VzCWsZzD"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7646EB64;
	Tue, 27 Aug 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738177; cv=none; b=SppwU39P3zUpt2qPZ2ww9svuMZd/eIASadhVvqiiO+VS1F2r5D/mxw07xb4iramwQHfnqIKJw90ZTWBOR0LskQ7ECV+P712ZiiNT2g5kLqRNSt8xcCDX+fDnaj8na3HXvw4BXG/Qo0n4KV4yokUlLDwUZagJC1JiGmnfN7HwH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738177; c=relaxed/simple;
	bh=voxKAhttDJwVFYFPKi8/k0ScjZhitqmMJimn89K7fL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOMRR1OHc8QEvpkz0YOOm+1L3yO4wLEejQ3Iv7uEOCGKYpi2VklT7CZFEtiAZZ+BB+s8y8O8+q1/rRg6F8htWFaIwOmmSJ5IPD4hzoUpREnGiZYbKbUgVOgk9JMVHLopgPD444MYA1uletSYvw/RN+8mg/TprI0GNfH7ZRjLUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VzCWsZzD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R5txuH086225;
	Tue, 27 Aug 2024 00:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724738159;
	bh=QPaO3QsNv5NaAoPgz9ubqhBCpY5Raa+kHO4t56mOjpY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VzCWsZzDi+m+xIcvXoVZOhTdK2VfVQSNL7nRwMstghofeXlRItvqGrhRN90hpkDBq
	 ZE29evwNoUL0nAubgPL9+PkPOxKe4yM200Uo8mZibwYdM+ommesrbLfsjIh+4LpcAl
	 X1sHoE/vslgF9bPrsYQy9QyqLTAId1ENJol57t5M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R5txm2086475
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 00:55:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 00:55:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 00:55:59 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R5tn7e103422;
	Tue, 27 Aug 2024 00:55:54 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control property
Date: Tue, 27 Aug 2024 11:25:47 +0530
Message-ID: <20240827055548.901285-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240827055548.901285-1-s-vadapalli@ti.com>
References: <20240827055548.901285-1-s-vadapalli@ti.com>
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

v2:
https://lore.kernel.org/r/20240729092855.1945700-2-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20240826.

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


