Return-Path: <linux-pci+bounces-35249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F2B3DE3E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113E2188E637
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8A30EF98;
	Mon,  1 Sep 2025 09:21:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023127.outbound.protection.outlook.com [52.101.127.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD830E83E;
	Mon,  1 Sep 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718475; cv=fail; b=Y6LR/ePZBIMb+EHzKuN9ABlWGQ9Eba+mPQ6Cn47sua/BOhtSSiwSOM8GhjAlTuKyF4itnBPSXDjD49tqS6BHgY5sAhXg5TuewdX9ZIvXT3sJFuJYk3g0RJlGjUIboRXIurdmyPBvF/xxluxja2BkvdX/Dg0ixaau7UKXHvRLzm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718475; c=relaxed/simple;
	bh=kkkSztwjkWzHvNvHa8cZjDFHKf38e6sJJt9sJWcCEFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXiBXvRMx6xzw2RMnjEd4NM2nQwuMnQ3G+OFXx2AISroT9B1CzsSl5+KVZaKcr0Ui4ZsAju5hFBhFw6WpmeUzRz/tGlDCn1fSd1F/Hvzkv+VlE0F6pesUElRKvQYVccWyQxUFNTjPwoc6fdZavzgvlNCeO3GepIdYuvjtyAGkCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/XH7B7l5mymZWTQQUmYyDMLbfJt1qc+t8PE1FqDlKCDgVqZoI0MoKLnmzlDnUyaxwb+OtedoLof+/7dXpm/d9mFzYVhhE/vRb3EJzAlyIN81vSDx0Pxo/8r9Z/cpevRL0EGAxFyPczL4y9dooBvbFF6y7vTe/P/NTb6OMKKAj4mXZ/Werz+eLzg2SRSoF7JXdxt234bMCqQ0gL8jA8wOCiD3BX5K93a0Eg6k1orMzMNI0E0Y/GnVeN38RjQsz5c8YOCnHMIZmBXdRhmpGXjLBQ/qxLRHMFTp/3WKJUUfS2UU5XC/rf6YQqdvb00VsFdEg9egCxHv4Jw3DxCqZ5XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB39FNr7E8ZDx2fRTsrnz/r0DpHC8LZ/b7gDjjDvJZY=;
 b=C70phN8vQAomcrl3P9GQd3QfAusSIBpcSEgEmUz5vYuOMSVSQyu49UYxf9mQ5DDVo2BVnlX/CjzcIHHbuqIeSuK1ipWPTkv39kjcaHf2YHtwEaJdmMbfVqT/y1XX+/PhZR3+NyeKXCRk3n7FM2p0NnD1Ej2/Omk67mMqKlLFv8mCYKiPJTnIrnSqcW11Ao2hrwGPyU30ymqPJ0tjMF/Jv+MYhGiHrzHeBJCQhR2/GrcUmF1hB80cOoLO+kkgAF8rnFMRz7WoQsLFiGALqay5Fpw0Pt+APk5ycXRWjYuIOCYPnlH1ojWlpsVUa5GarPOjciKL5b3g98Zus6ICYD8OTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SEWP216CA0013.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2b4::14)
 by TYZPR06MB5783.apcprd06.prod.outlook.com (2603:1096:400:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Mon, 1 Sep
 2025 09:21:10 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:101:2b4:cafe::b7) by SEWP216CA0013.outlook.office365.com
 (2603:1096:101:2b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 52D9741604E6;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 09/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Mon,  1 Sep 2025 17:20:47 +0800
Message-ID: <20250901092052.4051018-10-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|TYZPR06MB5783:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 07cd1626-098d-4ecd-7937-08dde938e31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2N06kSuQJ/x7Jva6SEWzj4/A0zRZr2/1EQnCJDW0RhJT4fqWNgSHYh0u6b6W?=
 =?us-ascii?Q?NAOYcwvNFyxmRFUarlBdAoN0CB43Z9ApLW9g+VXDei9F3iUK/7fOswl1OtgC?=
 =?us-ascii?Q?I0veSV2c9V/qnz6bxISUFOIPQWq32pMiVp5GZp2gD2LHZsW8Otuwj3C02TOb?=
 =?us-ascii?Q?9vIsQwRaB03FkTgBjjSa9BJsQSgS5azfkgghuJL1KOlhCdTS2xN/fzyY/ouu?=
 =?us-ascii?Q?8yhLGCPCIyXebNgCgBV5B4DKjXeGVtrJwmcdjkhIYf3b/j0iXbjRt+gXTT/K?=
 =?us-ascii?Q?+TZ36/pKhil1m2pFkI7sllzCC4M6erpjE5dcs1xC/js+a7VQG4uhA2qnKzrX?=
 =?us-ascii?Q?57VgP+kszrLXi/pimY4jNf0QZdhusKo6djW3RgLSdMPpbzfgiOI4A/8zyHrG?=
 =?us-ascii?Q?XmNB0NK5i41qYj3+zA5fkPL28UJ712j4SlS2os5EXQLFfnA7rwlR94J03q0E?=
 =?us-ascii?Q?cyll0lqGWgjK0L81fqjOwNe/O8A4fcy50HVQj6PHhXMbUl0yUB67mTFQgM6H?=
 =?us-ascii?Q?qIBOgOLql82PJxs3TC+tcEw25Uvmwl6/VqDVxFD32bUyG41YRGi3XmxWDSnx?=
 =?us-ascii?Q?7SaI0tt5zdx/1+C0Rzl/3nE+a1xGcyWr35GtQns0LuLyTPq1f6SJkEFINeyD?=
 =?us-ascii?Q?KuDj5OE3nY5wj/+vo1SqQlxxZS/OIDKNAB1tofEOW+F40DgUL+MrGgFor7Fv?=
 =?us-ascii?Q?+A/vRJ2m1PTsE6ukQ767CnN/cHXIwdntUcJkdxlujrKK1oDMzoIa/ihjUwQq?=
 =?us-ascii?Q?vBkA1tvndxn7KBiz2sU/kc9N6Z5smI4seot+IYfB1vqTFhYidZcSohd95L/R?=
 =?us-ascii?Q?8hN+mPJSfVqDNw4dVyznLXBEjwTcd3gQ04cPTuiUiReCKXXzxw0XU/3J9GKt?=
 =?us-ascii?Q?wJJFC5rIbBwN0p0U3/uwpRuzyWXHD9px62ISvEl47FBH6lfWJF6t3fcW6DAi?=
 =?us-ascii?Q?VWXgxp59Q5UWtp6Em8oqn+4+UqV0cPV0J7+kkuttpGCj9T7yZo5tMfuskz33?=
 =?us-ascii?Q?hHg2yMeL0MfoiiShS1zEsMrBwlk1zbi8/a2TcMDlHkFjjE6g6NBTMkmuMLbp?=
 =?us-ascii?Q?0T3G+1Qz8oPz38gMSxDxTcZkZBMCgbDloo4BwoyPcaME2XpePncnzLISwlEz?=
 =?us-ascii?Q?vG1HMM15QLx1yqA3emMmQDBfh1iqK3VTCaZXM8R7fsy+AetoXp/mWlqE3SQ8?=
 =?us-ascii?Q?fKGMATqnI5xqj6jnL+D8bnpaESuoR4WA9Wn4VrDfQ/YmqAumTfxewMbtlMbK?=
 =?us-ascii?Q?snn/SY0H9P9Fb+iq6XV5wRWD2YTtmEh+S5sMGz/N8nkJb0JxfZ12N7zxTphV?=
 =?us-ascii?Q?ykTEQ7Z2DXBi1es+qk548yZ/JoUfznc88O9wZTrXyGBbbgxLFeLX3CnIYVZf?=
 =?us-ascii?Q?a8GnHFFadYAk1AuG2yQtiych22sMIKLnnHFeIa6XLHVPpJOmcWRNXDzLXp/u?=
 =?us-ascii?Q?3FxtdU/NKjl6jLBrHDHmHgzawMtKdQWYEEdlVhrnP928w7Q0v4iasg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:09.1674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cd1626-098d-4ecd-7937-08dde938e31b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5783

From: Hans Zhang <hans.zhang@cixtech.com>

Document the bindings for CIX Sky1 PCIe Controller configured in
root complex mode with five root port.

Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/cix,sky1-pcie-host.yaml      | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
new file mode 100644
index 000000000000..b910a42e0843
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX Sky1 PCIe Root Complex
+
+maintainers:
+  - Hans Zhang <hans.zhang@cixtech.com>
+
+description:
+  PCIe root complex controller based on the Cadence PCIe core.
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    const: cix,sky1-pcie-host
+
+  reg:
+    items:
+      - description: PCIe controller registers.
+      - description: ECAM registers.
+      - description: Remote CIX System Unit strap registers.
+      - description: Remote CIX System Unit status registers.
+      - description: Region for sending messages registers.
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+      - const: rcsu_strap
+      - const: rcsu_status
+      - const: msg
+
+  ranges:
+    maxItems: 3
+
+required:
+  - compatible
+  - ranges
+  - bus-range
+  - device_type
+  - interrupt-map
+  - interrupt-map-mask
+  - msi-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@a010000 {
+            compatible = "cix,sky1-pcie-host";
+            reg = <0x00 0x0a010000 0x00 0x10000>,
+                  <0x00 0x2c000000 0x00 0x4000000>,
+                  <0x00 0x0a000300 0x00 0x100>,
+                  <0x00 0x0a000400 0x00 0x100>,
+                  <0x00 0x60000000 0x00 0x00100000>;
+            reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
+            ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
+                     <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
+                     <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0xc0 0xff>;
+            device_type = "pci";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+                            <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+                            <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+                            <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+            msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+        };
+    };
-- 
2.49.0


