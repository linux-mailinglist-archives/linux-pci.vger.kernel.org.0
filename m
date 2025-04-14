Return-Path: <linux-pci+bounces-25780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB10AA87634
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351D83AD3E0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465B18E34A;
	Mon, 14 Apr 2025 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ab5LAq+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77894DF5C;
	Mon, 14 Apr 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601015; cv=fail; b=N3DV1T36ijJhnZjpgIK1dVsknt4c8WfyqAFco+r2qW9rpx+7scSvEtV1FkG6K5WgMDvxo02XULJr8lpf6rmaJfU+nAP1C9Qx9mSAYQTb0vduxjvqK+HysUy5I97bWmCfpQZWW91C32tvzSsKV5BVgID5XaT1InnZMdtmmoOwQno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601015; c=relaxed/simple;
	bh=3sd9Y0IkpNTXKcCsU0Kdett/NgzWQMwhUNldUaaLtWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgQSrNNi1119JVzRuiyOkpnzbYOimRw4oTmmWQN9NU+d3JUgXg2fHWY4CE36q+CHq6eJnbQy4MwhwcgxANyEbB+H3fIevSEyftn7BqcE9Fs6CUrLaoH3/mH5vgljSvjsKPsd6a5UXwQMjux9G3gUc5kWZiUkdTKm2u+bW2Nw6VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ab5LAq+z; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlmJnl/FCSX2QN93eMhbMvWWKhRYjxQ3Lk5PDcSDEbsx9IxhXCy6kGWVq5lA0eZqqDbLC4vqvOZPh4n/D6pLFR5Kuqd7rOVZvP0u7oEy/Q/Q0aldyI9nWxr/ozpSXBx/qbN6Yyu4gOoAjtjuMLRzOZdoGRfxuGQDOe7kA7tPg2PS1LnV8k2NtjsVPM3HNqqUJrbSp0DN0btiyPu/VtGRKnxX8n6fFJqW+0q5tdsINUQB3GBbR5XIHAw+CAGkrWz8KYiK6Rk3Eoz+iJ8q7SFqguhQDyA1beUEUyCJxAUSJ02xA8rso7pDfdrxQF7O9Mx13OeTtumRsj4O5SwzyrchLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFIWCBMqrGGe6umXgnnoFD4ID336LJ1/LBaticIa1+s=;
 b=o4Mu1Coeh2y+39pFe/fjTQonYdIvaIPigDTS2oD6Oqf4sw1qUlMsgn5GbZN8cmtUlbTBg1rDpDogDjh30AC45fhgKa611Oh2gpaiGzPK4PE66NJIw05JQTmvgXXDi5ViQ8PdwMOKH8kQ0wV0rsWlnIocFyPGykM747XZbTHztOl4uJW8JOTpBY66TWC9qTzDA5qcLOlzXQu83rAItxaNRxkeSMdrkgN16sGAzc4zwkknjBVU9sjggsH7NzTavSlYTFOaOMBfrtn05juK1lDjINFbC1lubsCD3HjwLMF7e8FuKPoPSvFbUHBDVCl1+NfhrBvr2WAbZ0OocojNHuD2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFIWCBMqrGGe6umXgnnoFD4ID336LJ1/LBaticIa1+s=;
 b=Ab5LAq+zm9D10Gw0zNaAh7Cbp1SYfPr83r6ZM32traQMOQoGkbsspV/BrPGopzq4i/KcLurcOWS4XqXXZ9w3REEqtXrhN4DZchXQelMuv/M22/Wqh0nFObRnVQOmvPmbGPRAGLpwy/32EKV0420DxM2CYKXom5HsojsslWH/TGw=
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 03:23:28 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::7f) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 03:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 03:23:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:23:26 -0500
Received: from xhdlc201369.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Apr 2025 22:23:14 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx` and `cpm5nc_fw_attr` properties
Date: Mon, 14 Apr 2025 08:53:03 +0530
Message-ID: <20250414032304.862779-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250414032304.862779-1-sai.krishna.musham@amd.com>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: bc404962-353b-4e12-9521-08dd7b03b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFyGgkxd0lerWDRJ/vYV/7aKIRQlCxQK9kvXsmLkN0rI89lbc1lWTlpOq7A3?=
 =?us-ascii?Q?aG2E9FFmr2spzHESiJ39RQWhiYYE5euTfDn97uYVN2U6vGd0wrd1n6G7/j6I?=
 =?us-ascii?Q?1jpysiMNH9kNIdPZ265dnljlqz8QALdvvzoyS2gNm1/V8YCCjY8OL9ZdtfAM?=
 =?us-ascii?Q?Wo2Mx9Nv5X+Rm8G6ead0aRzzSnzKnZcilM9UeKdeSXxvpXiRvq7oHusYnP29?=
 =?us-ascii?Q?UagXMnFFCiTuU1uOgiEnAPuYoSp59/9iwB9ejDOlgga/oogTq81mtKA9HB2R?=
 =?us-ascii?Q?DaYCyqlVWNjbUXMXiUjaDcNVsbh/P00W+jTAExbNgyi0v6rhOPaK7Vm6ls3s?=
 =?us-ascii?Q?xBJdF1CcByiWnWVzHIFGT5bT+7FwOKQAK7FpBEcQuUFC4wZNJirBQnqpPvAA?=
 =?us-ascii?Q?yyosnG9r9InGMaZcP+ReV87CRW/qysXfzinN2Ieobyc0qZYIklR2dTvk7Ljl?=
 =?us-ascii?Q?MwMNP38kIkB9D5yfTT5jT+VW9jacCFvYQZuFjDYBLwDehFK8+7q6tEWmr7Jd?=
 =?us-ascii?Q?Xn9+3OtFYwk1X04rsmfTtyKQcp45GJhFtO0RjBcyxbHTdsY/lnGp6KNVhK8q?=
 =?us-ascii?Q?ENdQhmrDqKWmJTBlQATe6AHP+tbEfI/d8fLzODA9pRH+Jx9qNTiXvVvJWxpN?=
 =?us-ascii?Q?uGJk4UJPrIt6wWlmPyhp24risP4Vpj4EfaNmYumUjyaQnhTjshbdBCn+TELC?=
 =?us-ascii?Q?1q29GaSSC+oAhC4mom41PtGoRsMmKr/1F1TQlDbEvmGim7lgFHh30YdMBZHm?=
 =?us-ascii?Q?jvWClbC5HEzpOaZZFXs2Inclg6CK0wa3nOi+ljxqYih3Hu7lXm7GAgT8ruW7?=
 =?us-ascii?Q?oa7tNghTbOk8CJyqrZaekRD0SSXzTz13EJySNYdxdmKcQHochtc2vzO7O3TG?=
 =?us-ascii?Q?DT63CVMUMWivK07Ijsqy1EMJHC1pIkNDXg17rcM5dR72CQ/UYlIxxrHbkYOv?=
 =?us-ascii?Q?T1GyRqEp0PymbzT1YmIwg1ttMNyeNnxfoI+Q+zmn+19SIuxmMiSfeF4NDL3w?=
 =?us-ascii?Q?cK9PLLjUEAjwn2Chr6ZllMwezerl9SMIPBcgSzX/hyGcSTNmMcna3K1W98h7?=
 =?us-ascii?Q?wPsNCiuZq+UtxGUhsm6HCbzvg1nUWq6VCLKyYeQd4QvCLf9Q0PKR6znid0dZ?=
 =?us-ascii?Q?Kk+jsZcc0lQgrIdqtbfMzVnQ+P5cHQ5LmPjyJB1eRvuhqhPUPUI05NNG2enU?=
 =?us-ascii?Q?N9gC1Na2QKWmpj9euyEbLsMqSbD9Epj3kItA2pObZEhgGEsHrO+BVv+Inem4?=
 =?us-ascii?Q?7DIRy58jCNxz/hliuyUchHTdTxbRz6Y9u14NTRL08kK9Sly2+lrrufOL3wAK?=
 =?us-ascii?Q?Sj4cw/Vuspsjzo0Zz5AuwvN0O7RG9d/3RC5FuJrCCEtlJYo8PBxW+VI0sjW8?=
 =?us-ascii?Q?HmO0IEgkNgv52Cg17pUEgnZhb6znZIBEVi3jf131VPsnCYr6E5NpSesw4d4H?=
 =?us-ascii?Q?NCKHXAsu6NRmGhxvp3O/z8wKVpcd/Zp4KQUH+bCMOuYweeGI0DCwdzD0Z8lm?=
 =?us-ascii?Q?nZ/wWTvIaDxModd9LdHqTin9cxpJE3yWFsXq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:23:28.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc404962-353b-4e12-9521-08dd7b03b965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

Add the `cpm_crx` property to manage the PCIe IP reset, and
`cpm5nc_fw_attr` property to clear firewall after link reset, while
maintaining backward compatibility with existing device trees.

Also, incorporate `reset-gpios` in example for GPIO-based handling of
the PCIe Root Port (RP) PERST# signal for enabling assert and deassert
control.

The `reset-gpios` and `cpm_crx` properties must be provided for CPM,
CPM5 and CPM5_HOST1. For CPM5NC, all three properties - `reset-gpios`,
`cpm_crx` and `cpm5nc_fw_attr` must be explicitly defined to ensure
proper functionality.

Include an example DTS node and complete the binding documentation for
CPM5NC. Also, fix the bridge register address size in the example for
CPM5.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v7:
- Update CPM5NC device tree binding.
- Add CPM5NC device tree example node.
- Update commit message.

Changes for v6:
- Resolve ABI break.
- Update commit message.

Changes for v5:
- Remove `reset-gpios` property from required as it is already present
  in pci-bus-common.yaml
- Update commit message

Changes for v4:
- Add CPM clock and reset control registers base to handle PCIe IP
  reset.
- Update commit message.

Changes for v3:
- None

Changes for v2:
- Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
- Update commit message
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 129 +++++++++++++++---
 1 file changed, 109 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index d674a24c8ccc..ed07896f763e 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -9,9 +9,6 @@ title: CPM Host Controller device tree for Xilinx Versal SoCs
 maintainers:
   - Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
 
-allOf:
-  - $ref: /schemas/pci/pci-host-bridge.yaml#
-
 properties:
   compatible:
     enum:
@@ -21,18 +18,12 @@ properties:
       - xlnx,versal-cpm5nc-host
 
   reg:
-    items:
-      - description: CPM system level control and status registers.
-      - description: Configuration space region and bridge registers.
-      - description: CPM5 control and status registers.
     minItems: 2
+    maxItems: 4
 
   reg-names:
-    items:
-      - const: cpm_slcr
-      - const: cfg
-      - const: cpm_csr
     minItems: 2
+    maxItems: 4
 
   interrupts:
     maxItems: 1
@@ -64,18 +55,94 @@ properties:
 required:
   - reg
   - reg-names
-  - "#interrupt-cells"
-  - interrupts
-  - interrupt-map
-  - interrupt-map-mask
   - bus-range
   - msi-map
-  - interrupt-controller
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-cpm-host-1.00
+    then:
+      properties:
+        reg:
+          items:
+            - description: CPM system level control and status registers.
+            - description: Configuration space region and bridge registers.
+            - description: CPM clock and reset control registers.
+          minItems: 2
+        reg-names:
+          items:
+            - const: cpm_slcr
+            - const: cfg
+            - const: cpm_crx
+          minItems: 2
+      required:
+        - "#interrupt-cells"
+        - interrupts
+        - interrupt-map
+        - interrupt-map-mask
+        - interrupt-controller
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-cpm5-host
+              - xlnx,versal-cpm5-host1
+    then:
+      properties:
+        reg:
+          items:
+            - description: CPM system level control and status registers.
+            - description: Configuration space region and bridge registers.
+            - description: CPM5 control and status registers.
+            - description: CPM clock and reset control registers.
+          minItems: 3
+        reg-names:
+          items:
+            - const: cpm_slcr
+            - const: cfg
+            - const: cpm_csr
+            - const: cpm_crx
+          minItems: 3
+      required:
+        - "#interrupt-cells"
+        - interrupts
+        - interrupt-map
+        - interrupt-map-mask
+        - interrupt-controller
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-cpm5nc-host
+    then:
+      properties:
+        reg:
+          items:
+            - description: CPM system level control and status registers.
+            - description: Configuration space region and bridge registers.
+            - description: CPM clock and reset control registers.
+            - description: CPM5NC Firewall attribute register.
+          minItems: 2
+        reg-names:
+          items:
+            - const: cpm_slcr
+            - const: cfg
+            - const: cpm_crx
+            - const: cpm5nc_fw_attr
+          minItems: 2
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
 
     versal {
                #address-cells = <2>;
@@ -98,8 +165,10 @@ examples:
                                 <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x0 0xfca10000 0x0 0x1000>,
-                             <0x6 0x00000000 0x0 0x10000000>;
-                       reg-names = "cpm_slcr", "cfg";
+                             <0x6 0x00000000 0x0 0x10000000>,
+                             <0x0 0xfca00000 0x0 10000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_crx";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
                        pcie_intc_0: interrupt-controller {
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
@@ -126,8 +195,10 @@ examples:
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x00 0xfcdd0000 0x00 0x1000>,
                              <0x06 0x00000000 0x00 0x1000000>,
-                             <0x00 0xfce20000 0x00 0x1000000>;
-                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
+                             <0x00 0xfce20000 0x00 0x10000>,
+                             <0x00 0xfcdc0000 0x00 0x10000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_csr", "cpm_crx";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
 
                        pcie_intc_1: interrupt-controller {
                                #address-cells = <0>;
@@ -136,4 +207,22 @@ examples:
                        };
                };
 
+               cpm5nc_pcie: pcie@e4a10000 {
+                       compatible = "xlnx,versal-cpm5nc-host";
+                       device_type = "pci";
+                       #address-cells = <3>;
+                       #size-cells = <2>;
+                       interrupt-parent = <&gic>;
+                       bus-range = <0x00 0xff>;
+                       ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x8000000>,
+                                <0x43000000 0x1010 0x00 0x1010 0x00 0x08 0x00>;
+                       msi-map = <0x0 &its_gic 0x40000 0x10000>;
+                       reg = <0x00 0xe4a10000 0x00 0x10000>,
+                             <0x00 0xa0000000 0x00 0x8000000>,
+                             <0x00 0xe4a00000 0x00 0x10000>,
+                             <0x00 0xe4301000 0x00 0x10000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_crx", "cpm5nc_fw_attr";
+                       reset-gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+               };
+
     };
-- 
2.44.1


