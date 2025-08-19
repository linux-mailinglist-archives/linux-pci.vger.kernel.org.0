Return-Path: <linux-pci+bounces-34283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CEB2C24D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C741966DF3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79077334727;
	Tue, 19 Aug 2025 11:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023084.outbound.protection.outlook.com [52.101.127.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602113451C8;
	Tue, 19 Aug 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604518; cv=fail; b=dpD/SarKX6fZEfJgi55n9MF37WoXJ5pN3QVYCHxAnYgYPZ07PQ76VcYzaEMqnAsAMHx35a2OxkZXPU4aqj9hdBNxGZpTMTDW+tflEZk6ikPVk0C9Z6OmIvSA7Vfe9qJRCw4ZlAL6WlY19XY9OnBl6xsJTiqzDbJ8tZr8LcDTTmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604518; c=relaxed/simple;
	bh=r4tUCOH3hAD0cI01zaClLN8o0B6ogXErrjJKZNV67GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuhyEcL9Aobh22LKy2iLeNraU5i7Kh4BgR5kVueiCCwgqcU/O9seieXI7vU6d4hWjtyOD7qxalOUBQvw7ou5sml+7E/eCn/RF6qkC87GzVHdWnBpiI10yF2L6gNCqWq011EU4KnKSAn4j2WuAJ7Cwljawtkg8bdx1tV2+Gd3ofM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD/M1HD0EngHGqHyY7dtCRB4pqKvRqCsnQVmS8usLwpDAd371M64vwc6M+f8hvX1nVEx69q0HXbtZsRNidvAFO+Cfi2SSu/ct0LZdiOZ3UzFSLLrrJqgSQfqDFq62FwKAqBbbrOfGbKvQAebGLgf3X6kUXjd+DCMftEiZo2e+9VPxJhNKMNKHoF3bavLqLj78gM8+9Y2pWfQLwubDme7wD8Y+AEyV495VuvjfTr6UWukI9MupO2k6oayB9tQeAEyGGQXzQM+FPpi7z3+sR/v0te8nche0RgXowr4wXYNMLgd5YioYg8xOtfmqi4e0nmuBpHYX7vEyEbxCSlR0KGBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWvXuryKSADQqShKfPnpjrHHlbIY+cpXWE0YVCtJr4k=;
 b=Vn7WScrHg9um+CH9ZhYsw7OyseczLJm1UWJbJGLY5om+Ckob6zs5R7+hLuegenSf+1NWUOwQO6Pg45eaOX6dwSxhaXTworl6WRLhNuP6fIg+FpSzFvKjJGTkNOWcCh0BWE0ESN2lQKWQZ6y99BBgELCnUFJt8YXUTnQAxWtoFIJdcmxaYgj0216NiIRnfR49sq+c2K/Qqe8EGOS76t4pJDyGgFUJEAF1kx8y3Kkt05R35evKkM8A3cU2+TMnWPseFgQx+CEEZkMHpKMoAe4pN2qHQWE6o7tUglbk/uhlQN5o6Zat3IC/sUY4w0ncNZ25IXfruWutI8pCQ1Z+K0ZX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8) by
 TYZPR06MB5843.apcprd06.prod.outlook.com (2603:1096:400:285::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 11:55:12 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::40) by SG2P153CA0021.outlook.office365.com
 (2603:1096:4:c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.2 via Frontend Transport; Tue,
 19 Aug 2025 11:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CD9D941604F2;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
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
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v8 10/15] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Tue, 19 Aug 2025 19:52:34 +0800
Message-ID: <20250819115239.4170604-11-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYZPR06MB5843:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1e0304d-308b-4f97-96ce-08dddf173fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPnsBIEz5yXHM5wBj5hFsxzqHif32rRa9r1JWsEcrnaW93EFQylC8BvHX4YL?=
 =?us-ascii?Q?q0CFBwugd6akSFJEcitCoeOhjHf+4DNYk2NsQSGpoPnaVtH3uulb49C1ANJb?=
 =?us-ascii?Q?xJPaejnMpWhmvJGmtcs3h5U33HVACK1o76jSe+AaR6lQpF3sbWOSmDhD2CkL?=
 =?us-ascii?Q?xFOHFXv1WaKfryiv5JnxWqUWF2hLGr942M376T/T0gsI1ec18wI4oGCgbrsf?=
 =?us-ascii?Q?/1gOueqCLK2s5I4h0FcKUTIwr4odL7LFyO1BxxdVKUMqQ3aQTeL27WzKZEOm?=
 =?us-ascii?Q?W1SXsCQ08qxLN399bIJaRydZhsGqsOdHF2R9wE/rorjOSim3lMPaFYcsHEGy?=
 =?us-ascii?Q?1GKZcNTWjEWbCrV+BInRSMYhwXuEct6gWlSnAfDLNuQ9KCaUmCIoCkaanj8X?=
 =?us-ascii?Q?RG/FS0C6zPNlPmWxFJ+1K6gpo1iclYn9Bq+U2lzsnmIkKWExgRE6k96mtXlg?=
 =?us-ascii?Q?8xn0MXwYMxyMi7batGaQbUoAXkU6YMnWI2qeGEAl+ACirInMlf0ceeoqBWP9?=
 =?us-ascii?Q?OydAZmBg0Sg5AHellx4bjVTjTH4ilR0RCbGKphxIq49k8MpBA0giHowtOgwQ?=
 =?us-ascii?Q?/xaLeOzCgq7G0esZVKgVJl+zxKFavQBFDiUJigtqdupGTAOYXtAAo5OXtsnW?=
 =?us-ascii?Q?LwLCgoUTB58dYKORbqlBYIRs+BFF+pd3T6QR9tnS8dmT+SdIJ36EhdKUiTT4?=
 =?us-ascii?Q?BgI8i+BTVNcfKgZRBI927D/6NaxIu9WmFOMuNp32TQCRcOhj+AjSRgnZfhP2?=
 =?us-ascii?Q?DFAm941x6giqDBCD0ELXmoVnJ9INISDDVHd6TBkE551kO1cDH/L4zsdtUxvw?=
 =?us-ascii?Q?uxUnpcZEtmtP4y5LsxGwCe+2izciWBvCf+c3SrHCKAWpjgF/3XhZRLVB5aNG?=
 =?us-ascii?Q?5edE0O34ea1fQrRIThdcHfCZxbDvHVZkUqYmWvgC/lD6cOxovnAx9Os/5GHH?=
 =?us-ascii?Q?FF0o77GjABrE9wzmrZfiiSDZcj81vw3nS4R4C0ZtoK4y2Z968fOjQspID8EP?=
 =?us-ascii?Q?GcYixnk0gNCaUzhAL7+EgBex4oY0HAzxyAlJ9LRDtZ42lzzvaAH0rxOTQrsU?=
 =?us-ascii?Q?RgQRall0xtsfffrHDoyGetDaxX5+p0kojhPB/wdBx+MVac/NSkcVWGNW5/z7?=
 =?us-ascii?Q?MmPm9QIRDvbGVW8jtfejYILQS5RzOegvi84vxQB1nf6fOE8HKGnd093FBzWA?=
 =?us-ascii?Q?SJunq22K7ZhLrCxZ7lunPT/bxZVTetP0ZNVwK+0dXrHNJjHVnRnyCfaT1ePO?=
 =?us-ascii?Q?89N6cABoTL2L1fsx8weTArvo6VJPqasjc4E8eZ6jIVyzOJhnFfO7gPW7Upo/?=
 =?us-ascii?Q?T7MmNxaUM9/Kc6DuCgsvCsa50MPToda+Dcxqv49or0+eAlnB/6vQ+2HRvhZL?=
 =?us-ascii?Q?I98IF+IH1PPxyRSuKZiZdh1/OIAVo5+yij4IEwCShgKeFnT2nD3kwkSVoGTO?=
 =?us-ascii?Q?Ptv030ica9bPFD1zPOYGHuHshbxpcgZAmTzpZLdR/3kvhwVXOxhBqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:10.4163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e0304d-308b-4f97-96ce-08dddf173fe7
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5843

From: Hans Zhang <hans.zhang@cixtech.com>

Document the bindings for CIX Sky1 PCIe Controller configured in
root complex mode with five root port.

Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Changes for v8:
- Fixed the error issue of DT binding. (Rob and Krzysztof)
- The rcsu register is split into two parts: rcsu_strap and rcsu_status.
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


