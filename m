Return-Path: <linux-pci+bounces-10256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D379313A1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B1C1C20DD9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A218A948;
	Mon, 15 Jul 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pxxqlX1s"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A52B9A3;
	Mon, 15 Jul 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045415; cv=none; b=n9RE+o4M/LViYW5GBmoXB1dy7nngi//rIrH/WOSq8ZdsU83tlxQIwqXQ9OW3Ak3jzBF2o9YFDKvqO80NVlwCKh9vWcrX/DTGjZ1SKTiJbmOJY+bMUwnM1wCsOu2WQja8v4Cm6534KKhEb952mZo8lv8hVZg4M5/pDS4hMmWnrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045415; c=relaxed/simple;
	bh=Np7FjnMeZr9L2hYzr0T3jrWbzJznqSgUpJHIgVSxNYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcFowdCoV4OczaUmHUraDqq8GZoVNcYQRWoL+nU5INTOZNB0TwAxUdHSKdgx24yDrVvMi2Xf/AIMm/f6ewyEUxcDgK6JHt6dflXxPVi6VB1H0bG5LEvNEvcBQLYdhPclfwU3AzL5xFa53wdwg68j6d9nVc1QP2+J5KPCd1ZXG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pxxqlX1s; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9pHT024084;
	Mon, 15 Jul 2024 07:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721045391;
	bh=oWdZfGEhKAneWVQdWVjdFiCIeJCzvhKBZKftmlYHpQI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pxxqlX1sg+1QpB6O8zFKbxwuSC6dl6NQIFtYC8UP1JY/SxRNAOt4+hblZ6KiEhzy6
	 zbbsYxBowRyaOH8kJ7N2x6ZU1gIddWcAFsANr0SbxUcBm+bG2j7a3O5QO2iuNP6IzO
	 jU4P0GIq5Ccbj+XKYSTONqceDya09mge1zxymNrA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FC9pKk012700
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 07:09:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 07:09:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 07:09:51 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FC9anX060344;
	Mon, 15 Jul 2024 07:09:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/3] dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control property
Date: Mon, 15 Jul 2024 17:39:35 +0530
Message-ID: <20240715120936.1150314-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240715120936.1150314-1-s-vadapalli@ti.com>
References: <20240715120936.1150314-1-s-vadapalli@ti.com>
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
---
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


