Return-Path: <linux-pci+bounces-12424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D3964255
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5837A1C24A73
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4618FDD8;
	Thu, 29 Aug 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XKFQYFP/"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008418E049;
	Thu, 29 Aug 2024 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928823; cv=none; b=s3DtLyYUOutRRM/4GWelHr6qzx1tvCbggnSDF38Wi9pf8WbbFYx2iKf5j9niz5GGfXrEor3/jOiN3tShqF+4gM3ak4ommJpcWnqheeStXcSse5TUye2CjqClpR0jIqfYtEkBo5je6yw4EK/3iMKRT7RhtBAdbwcDdHk/YGQdRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928823; c=relaxed/simple;
	bh=eOjWmCGYkQaExPYAYn5LNam43OtntIsPkUhHFa6JZ04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebrrswgJDXfT+BGufxIisyQRZkyLl3z53FMa3zqT7uCTERfr8z+7LX1ffNL9tZAye3JyaHaxZ0a1lVQsGipHmZtqvjPEFGUMwvVetxDxJXHbheGKQ6Y2h35Rxhg0qGlfUvHo46tDT1cDFFOZFbev55QegAzkY4I5AHVn8iBweQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XKFQYFP/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TArQma032249;
	Thu, 29 Aug 2024 05:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724928806;
	bh=X6RXbw20GMJ0FoF1xqS2/F+/UvIx5MHp6Kk6m8ysDCo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XKFQYFP/E8eq0P0FF45Ww9UGBbixsAHNuClSA+LVjFJUcWr83b6X2UYX9+CVqfDfL
	 l78Id94C7BXb4nxuj+JsasOFYYd3ekumbiMIlaWw7Hhxz2pT5uolFWA2zbRW9OmmV0
	 uWQ5iyqO2Yn5te/wNjjTgqcnJlq0l7qMDhSlpV+w=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TArQCp081111
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 05:53:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 05:53:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 05:53:26 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TArHpS070385;
	Thu, 29 Aug 2024 05:53:22 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <kishon@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control property
Date: Thu, 29 Aug 2024 16:23:15 +0530
Message-ID: <20240829105316.1483684-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829105316.1483684-1-s-vadapalli@ti.com>
References: <20240829105316.1483684-1-s-vadapalli@ti.com>
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

v3:
https://lore.kernel.org/r/20240827055548.901285-2-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20240829.

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


