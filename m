Return-Path: <linux-pci+bounces-25773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4BA87617
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A616F735
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114F19258E;
	Mon, 14 Apr 2025 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+MlUCqX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBD18A95A;
	Mon, 14 Apr 2025 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600154; cv=fail; b=LWYtZbcmvz0+Ex1s9mBBxkvXLJDMW4ArAqn97+SqSaKIVe0PVq3ul+6Ff4Z+2VQ+I7tRwvxZGUwiPWS3iWoldG0z+uu5B6Hs/8Ik6wJ6Y4Y7S6AbqW/XVy+RRsTyfm+tuVvZOWQ7n4CmlnvjN9bBbF19Tid4aGXdVpTcftlKDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600154; c=relaxed/simple;
	bh=3sd9Y0IkpNTXKcCsU0Kdett/NgzWQMwhUNldUaaLtWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr6ajyanABzNpgj8Ov3GRzOPqRda0R43pcS/QR2UYRIbomr/Rcbw5Qle506qkEXAiKOqLc3BXRaMz3IBWEIBMVZ365NmWM8YcS8yjKcFOAwL13srbqguTTHxtYNPwm5IwWC70RHAMl2NOpj/ZVdD2AlioTGPfUvaxyXjJelzkvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+MlUCqX; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLaBfW6yXEVNwBosNOTcL0/kRnhcb2uNAwt5QbjB0HjTlmImFcv8Bh8JdWAzAou4mB/FmzhtJUkJPYTdXyn1v0zaxNHx0Aaqr/Uj7Kd/SGtcqu3EXLzPQFoqQC9go60FHg3I4s87vpFlx9DisZ30jSpNnQNreE19Wm+g0WR48quzM8lZadbPu6wO0VYzQD+UcViT5A8Ft+XBEdDzHbepWLOltgb5ShcCylY6HPXjML62FJ14kK49aAa4uTyBjRUk/lVrOCClt3H3PbRTefa+Fq/UKbf6aFTA6T1FS28Xo3hHNJbCCANK0NPjccd48q+wGeeVrmKnYTXtw/MTLxP+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFIWCBMqrGGe6umXgnnoFD4ID336LJ1/LBaticIa1+s=;
 b=H5/Whq9YVk6f6DtXTGwEb05mQz7PErxaJbdph7tdzRjN9o+sWjQFHQxBl9qJf7y4tDU0HyCn4IL6YppbllREiYJbFUKkGdJkfFN7FVACVtMjvI2HJxmCcUNYW8UGfMZ5QnKv5uW0x0ZDEexUcJHFMEdPq1m5f7yOH2CGLiIm+TceDlA7jaAqizOYe8gtQL18Op542O6NCtNuJBRWfjZOVke/gxQysqJ2Me6bHi5eDOfsCd6ZaV2BLdnImD5BklZBrKPBWfnM7i56sYzmdyOZO6vEaKm686Trme9rwJRwo4FqUyhpYukDttLvg0cAO8DMStNa9VkNX/Ti4YLz68S6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFIWCBMqrGGe6umXgnnoFD4ID336LJ1/LBaticIa1+s=;
 b=T+MlUCqXgkMpyXPah8yhYZWXyDiN1ruUS/CIpW4r6+lGqNoOgbBjnSf6Iv3ZKLePTBZa+aIdclCwOSmGHUiFB8VlqjQuUTtIZonHd36w3uacILgDm9jHz+zLbr1LPjknrVgcUs1xYFefMXGHud66SeEmGc5Hgxm7OCEEwQoqUFI=
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 03:09:01 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ab) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 03:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 03:09:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:08:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 22:08:59 -0500
Received: from xhdlc201369.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Apr 2025 22:08:55 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [LINUX PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx` and `cpm5nc_fw_attr` properties
Date: Mon, 14 Apr 2025 08:38:41 +0530
Message-ID: <20250414030842.857176-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250414030842.857176-1-sai.krishna.musham@amd.com>
References: <20250414030842.857176-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5797cc83-89d7-455b-8bba-08dd7b01b438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+hodLFcZ0K4k3IUhQRPC9Q4FyqLjC/Co+QqBLvgXR8AU2x7tWQWKrWPKVXS?=
 =?us-ascii?Q?GZlSK72AhZu41ecro4J/FVk1p1ozCaUhmiMe+QComBF6LBdqJs22QWGj6IbT?=
 =?us-ascii?Q?ha9hG4Kdrq6fUlLZ01WpW5FCdeQhJgQw2GtlTvT19/MG8RMezTAa0T6nmVR1?=
 =?us-ascii?Q?HAcSARjF+eHnGa3vB3lsoNOYN6KS3PvliiWxy1HuYsm9CbcezQrtSNppx3hX?=
 =?us-ascii?Q?Q/RUyZptqT+8GCcAHagIPl8ql2CMPQ1hdavrEZo9aGZ+yNyLWV1caw/DhEVs?=
 =?us-ascii?Q?V8VOIQvGiNoO7/OuEhyyYfc4aotR5H8bqSGWpUFJ4MRgskrmWcEVcRswix5i?=
 =?us-ascii?Q?WjHp5oDO0rFq2l5n8SV/l14chjuTC8yH6pd2e6of96Ox9+3vB0JJy7vrm5GF?=
 =?us-ascii?Q?20XX0wxi8ypmH8W/k0bTZf4P3GmBSz0wrQzn75pS88DmWDN+YSN3kYIgsNDp?=
 =?us-ascii?Q?hpWM4WzBLDcboqmSPVVZnW3D9n6B+fC/zE0UMD0OIv7y5W1/xierNgD0ykbe?=
 =?us-ascii?Q?lQmp7iC1iH4qHGbgfZD6FUkY72WfUhaR0LojscGrl37YbOiIy0Rpc+Zi+88Q?=
 =?us-ascii?Q?mOnyJfLcPoboo9l2T0x79McSG/4L78lSOFPQGcGDrlbsYZInROi7J+QFAXFG?=
 =?us-ascii?Q?taG+2pd7OVRv505eCYLjsZg88dCrPL+c7nPqycDitoooSNvXyOyNKZ4IjSI+?=
 =?us-ascii?Q?9a+U22Qc8zYIC6nfSUN+DbLqoH2RkOvtvogDQofdNlkIWAMiv4UjnPAbTJuA?=
 =?us-ascii?Q?8/sNwbMxFO05KNV7aVaEAcoulJmGmM2kfso51NrHf6WqlT9S+t6E4IlhrMgo?=
 =?us-ascii?Q?LxdjoAuCe7rkzcr1DpcJzxPUk4cp0hUlHMry6FWSL6kOZiJQ6s50IrEKMYPd?=
 =?us-ascii?Q?YF7JBcbbJ9E/WOeSqGbGjBX8KmXCouF9W53LTs+Rczt4MH+jJ3o/6uXCA7ib?=
 =?us-ascii?Q?KyRsAn0t0CvtXzTEM+qg07jGqfcPBtBaL+GzS+OlDa5g0fNhuWXIucW1/vrA?=
 =?us-ascii?Q?O0Qo4vvqPvpaonH7gbWqtO41OFw4l+wtvjLHXxIvu9qpkxVxPD3cb8TO3Gl1?=
 =?us-ascii?Q?NRxFEgraRgMfnLZ72o/eTM4VoPfr2R7zyRfYLgLVLJWz509FTdqu5OugUE5q?=
 =?us-ascii?Q?IJcTHugeKyjXOjqGGIwdHN/N4RMVDyfnto/Y9+sa8DK495LXLW8OZvqCrqb3?=
 =?us-ascii?Q?V3dwi98PMZEKZJ2rlK33dZlwGjtW5OrYjkMvR1TBHwmj4SKYtJFKypeaRpTX?=
 =?us-ascii?Q?/QZlMdD6XkdZ3PA9d78ip5USNyBGfkZ8UXIuGeXP7Wx35TRw75xxuexj8zS2?=
 =?us-ascii?Q?6nfW7tQ05A+PDQJxaPVUlceeJtDZr79jajipw79oc4rjaYvVSSHIxESnQnTx?=
 =?us-ascii?Q?7FX3RlhmDLYj3Ek0L3kRYXGqBaCUd2+f2fiFSzeLSUvavpC7GtFB6kzo6saR?=
 =?us-ascii?Q?eX8PH4wtUQTorlsjXP+4hvMy8ro0Kf+Ce64rXm73FKB84+Du+/6f/eTq+4NI?=
 =?us-ascii?Q?nwhProSGJN6UwFIoRpPE4EWuZuBhdnGJbBDP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 03:09:00.3391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5797cc83-89d7-455b-8bba-08dd7b01b438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

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


