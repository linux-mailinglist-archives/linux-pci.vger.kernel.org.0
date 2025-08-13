Return-Path: <linux-pci+bounces-33898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A810B23F80
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFE3BAFB8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB952BE042;
	Wed, 13 Aug 2025 04:27:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022112.outbound.protection.outlook.com [52.101.126.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E73FC2;
	Wed, 13 Aug 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059233; cv=fail; b=ti0bQBL+HUQ/mdCXLKP7A0oNRlc6sT+sFBlY77icy9rVYMhr4oUfviNdScrLmwuByNh1G3QVS12lq2HUhDGlqVETWcCcQcaauFIp8sVpHF2rIt1SjF66ia8fvh2Dzs+ZYBYBtOKT2KSDSWM+0frv62MVE/c+nvmrs2JKnbiDijw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059233; c=relaxed/simple;
	bh=4FsAw7RxadyqMjdLkeRAQC/flrSfO6l3LUNtuA7Tpo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7rtBvyinSySZXXa5dHvmCyamkj3yojUomdDzORkBQtU6qSBTMX2eiSIsPBPdVP0CoTS8ayM4L/BQuJnKOS3oLuD2zVN7egBqzpO7HnGkrEn6CvhlQp/7KD8+8EgLf9s1wWdzZaALI/5nCNDTcCoyaPfxqn+qwiOtE3BTLt0cWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLPSk10bdhtdJeuYesYTUjL2Qn91bbX16tBfgtLqms0zt4qwyC4ZiYqqPb9Teqs8bJXbcA3dzYuPgRPXv+13YtFc7bGJrtWAP8kdeK1mh08V1+wlN8nXuy89rmszg7Ub6wU30/6rYvCWHQYfa7W2gZRSjipnKFktFUcwo1JwF7l87M3DYChytIdQjrtFrPjdvWQgNfUhAcdT+5gpYlvQOVVgz+GhApoCz2+Y8vynK9J1EmlnS4ycJ/hkg7eNUQLbFL+51l6wH4dmQcqpUJaoPBJQjKxoltJthQxoyqr4d0yJTEVrMWgCteZlWSTh/+nqvifOoWLVcJr36axaKsP28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfckEM4NVD/gLWn7hJBQgSbbiJOrghG3F3EVz3aRryI=;
 b=BfERLl4hn44h4SDniQBdr5Ya2Ea0WDUZxX6kD1VX+8zdGZFRlXIEy2NELsl85GXVg4daL9+ynsy2SCkt8G5rZPm0/A7wh4AOwh5iVyrcwlL4sbvmguqYGcMdpHKkWh3W7ZCgbE+qu5jM0YYY8lvHmDrrdQgKODzi/fnh25gdGQCfvRtdSCd+EMiCXi0hSwR3hOxFWvDd8oyM9B9ObePaDb6FnI4anDTjJoekU8FO327Cj/ONqpazWSDuW7+0g1Ufxnug4tpFBo/mdaXBWvTOtyu6hQYuWGrbRH59VJdphd3qRNA0NGAKXVypbjcvJIbTWvgwYWB5RnkEHkUyDI+0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0018.apcprd02.prod.outlook.com (2603:1096:4:194::18)
 by JH0PR06MB6776.apcprd06.prod.outlook.com (2603:1096:990:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 04:27:08 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::4d) by SI2PR02CA0018.outlook.office365.com
 (2603:1096:4:194::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:08 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C242241604E5;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
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
Subject: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Wed, 13 Aug 2025 12:23:26 +0800
Message-ID: <20250813042331.1258272-9-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|JH0PR06MB6776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30643d32-2f17-4c61-5a1b-08ddda21aa68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfFKWGs1QOa/zzCAAIYhKpmGHRz6BuEkwCgH0FRu5qJMQ+KDtXrkuSNizhDw?=
 =?us-ascii?Q?F6GQKfxMf5kemB+TsO5Lf3rMTlXITfnmwspLT3PHXOkCT/OjkTNskCN/L/aD?=
 =?us-ascii?Q?toBRbF4mET+M5lLct24+zq4WTENL5Q8BvAgMjjzIY062bbyQBSTJ7gC43A+P?=
 =?us-ascii?Q?q3PkprfOfza73HG2HIUwpv4dmZslNy1DvqwRO5rX2OcAGta86hS6DYlhXzoM?=
 =?us-ascii?Q?snxgdRS6l/CAPioK/aB9ibblUhDd2yempKqnnHuvnL8acNLykL2+QP14CDoK?=
 =?us-ascii?Q?TwoqRtBKbzoJc0Pk9tQQad6iEgZ80IwqeelZPDtqUGCgWAnnOQ9z3+GzH5ZY?=
 =?us-ascii?Q?4nkerIa6lFW0eMPaV1lh93KNOj/xFlJxJfU2LLMwCcXesWnoVQqwmbbyamFI?=
 =?us-ascii?Q?23O6Ue3Ljq1b3t5MlvjbLOPO/E8qijAR676v4m6PCoNS4BdJc0gTdijBOO4B?=
 =?us-ascii?Q?YdCrhB7VOa3MMKSP3Ecpn6Cj/oShePYBri4Wmd499ZwpINcK8V22xMghRv0t?=
 =?us-ascii?Q?oORPh/YmqZOOkIjQqSNVOURZzxZJcAWk/AdZQBJM/TCqg170/i/IR2DPmhtM?=
 =?us-ascii?Q?O4jBj91BLzsaYT9UW0bllSJmjuMZd+IjvVlFiX/1BbV3N4LuBHPQguMifLlA?=
 =?us-ascii?Q?0neluPIN4cDvOs4i/Jf0ePCrZ76SOv+1lVSmo5sSoxLemHe4F/io+upV1Xs0?=
 =?us-ascii?Q?hWziCiXsH+fG1ByNqjBxJjbj5fP6hXI58o2webh75XTbqJ2NO4pmwZ5zT9Rw?=
 =?us-ascii?Q?zziP/Wk9+Ir8Xx2o/RL4aLy9DgHh1tKPA7dag2aXth9w9uzdaL77o0iYBt1R?=
 =?us-ascii?Q?To7gP/yG+uF0/Pixpudwh5ra1WAh99aC32PaoIqtu0Fs9UUftCsSJG1xXAeR?=
 =?us-ascii?Q?CU64KFzdhEtMtMIHjh9qgctkT2YcVxzV8rcYh3O+/OpcRhcVm7yxvUes/R6i?=
 =?us-ascii?Q?Guha3AeRqlBWoAXiNzJ/mVbQ678r0OWrVaZU/PEdja5Qcy0NAgyW9HElia/H?=
 =?us-ascii?Q?mRebMw+pQI/26TGLUG7QiC8cFvYEJlem0IqEhh2Wxjpg76z+mcISdUx01ML7?=
 =?us-ascii?Q?H/LA81nGHH97jKVbM9oC/I6lzLFeglQ26FTn5UE9Yy/RzKIjQcqkcI1G5K2s?=
 =?us-ascii?Q?zAXQDweXJyAz13ljcYUat2yzLDtPNdAX9rt3LD8vbrTKt2zEXcpXRM3J2E5I?=
 =?us-ascii?Q?ViD3jEPkw49oHqBe1kl26S3dpMT7u31tIQjNo5648iE3DTSg4Dbtr5IizANC?=
 =?us-ascii?Q?Xcq+HeJMvZFV2UD6q7ZJl9a88fBIpvCJmbEQqqAX9PnoUvQEMxj1Rv2fdevD?=
 =?us-ascii?Q?CfgeAxA4rHlDfenEeWrwVe8sXDJ0HXzH3AFLyMz6h7D57HE/GOVl49kI/xT3?=
 =?us-ascii?Q?4lW0nLlS6FTh7x66P1LsrhkC9JYRcuH9qKTNPCGarNYyqV92QQwT6NTj2mej?=
 =?us-ascii?Q?oojdOHRAX/JPaP+lDyXZLBvwHRNDA/hWrQILKBFX/blrLZ9h2cK1Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:08.2392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30643d32-2f17-4c61-5a1b-08ddda21aa68
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6776

From: Hans Zhang <hans.zhang@cixtech.com>

Document the bindings for CIX Sky1 PCIe Controller configured in
root complex mode with five root port.

Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 .../bindings/pci/cix,sky1-pcie-host.yaml      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
new file mode 100644
index 000000000000..2bd66603ac24
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
@@ -0,0 +1,79 @@
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
+      - description: Remote CIX System Unit registers.
+      - description: Region for sending messages registers.
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+      - const: rcsu
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
+    / {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie@a010000 {
+          compatible = "cix,sky1-pcie-host";
+          reg = <0x00 0x0a010000 0x00 0x10000>,
+                <0x00 0x2c000000 0x00 0x4000000>,
+                <0x00 0x0a000000 0x00 0x10000>,
+                <0x00 0x60000000 0x00 0x00100000>;
+          reg-names = "reg", "cfg", "rcsu", "msg";
+          ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
+                  <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
+                  <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          bus-range = <0xc0 0xff>;
+          device_type = "pci";
+          #interrupt-cells = <1>;
+          interrupt-map-mask = <0 0 0 0x7>;
+          interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+                          <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+                          <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+                          <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+          msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+      };
+    };
-- 
2.49.0


