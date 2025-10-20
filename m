Return-Path: <linux-pci+bounces-38703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0526BEF484
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D8E4EBF41
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 04:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A62C11FE;
	Mon, 20 Oct 2025 04:29:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023133.outbound.protection.outlook.com [52.101.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FB2BE636;
	Mon, 20 Oct 2025 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934548; cv=fail; b=GZACWS1lyX5Op8XvaGVbcJo/I5U5GNsOVxae2r6Dyle5PYxY7+5dIZcDC9Ivg2JrJKfOOs8QZfLyBPtIGSiXaAz+YQXfv+iz/Gj+fOSNbGwELrNIUJ5EaudCL1L05Ql1EJqqPgXOowMZoPf8LhJesdaXGIAHBDr2Uq/48wTWUkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934548; c=relaxed/simple;
	bh=kkkSztwjkWzHvNvHa8cZjDFHKf38e6sJJt9sJWcCEFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqmiclAaBkG94peBDZh9OQSKhyH7fLhhjzYNJvghpSIzcbam+wQDuET47bMrlks9qcmcoLvX8B7qY9gOh5oS0k+y4jJFz+L9dAt7g3eQbG8t1Obf4BEeM8ENAESXrHaZIVzG0BcSoVX8OSG2UfSka0w6buc9RHwiiNPZ5Diyglo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXOcgSvnZYBauho+bQZGlcZAl3xz+O1Sak1RqKPZrA/osYW7nfiCGbYh1HE99r3hdhzj6+IEiptPelZXsoSJCbLlEeQJgM6RzPZcUYlWIOP67VwcwOUYq2oYLk/6XJlqpsiZN9dwUQiFgTG4xVTcGsBx97hiZAMnuz67ByGDUhYsu3qag/X9DEn7RlCLngCtQDffb7JLJpoMX0JNj8iNFt18rR6sjjfldicZj4csTAsa0qblK6M+FlBmxh9k0bv5y5C0M8V60rmr44oX1pTx6dUS1IcyXwPpJXO3YJDcFFr2sUD2umpCtrcjTHXQgLUDpprk3+x3wkqdtCLSHClqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB39FNr7E8ZDx2fRTsrnz/r0DpHC8LZ/b7gDjjDvJZY=;
 b=lLgS4kx4Fai9uBC7DsNWJyVt4z1qeR/UBkAqGUbyBFdbl0K9zHMbxzZsuAyTsZpZ9P2JeV5qbhP5pOClT+Ljl09u4m7CPhWatDqSKhXCPSQvYv45Mv5k6MIea9+0WBW+DgD0Qg3Racurz/q4tw6KZPqtliyjHkww7w49DN1MXoDgjgpSiwlfaDxKszle1NkeR7P/s33TeUh8UBU2n8/qYEdCnCyLlTTcDbsr6rFoQmcr8z5urfcqRxQPXFVvFq76mIRYIEgPZoEn7EwP/LKIxxEYlgwXR31pu8/65pAOkTaOvpn7P9zrOamWhhebB2fdI3e4IjXKuhKipAtFGhXhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0161.jpnprd01.prod.outlook.com (2603:1096:400:2b1::11)
 by TYZPR06MB6281.apcprd06.prod.outlook.com (2603:1096:400:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 04:29:03 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:400:2b1:cafe::57) by TYCPR01CA0161.outlook.office365.com
 (2603:1096:400:2b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 04:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 04:29:01 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 045EE40A5BFE;
	Mon, 20 Oct 2025 12:28:58 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
Subject: [PATCH v10 05/10] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
Date: Mon, 20 Oct 2025 12:28:52 +0800
Message-ID: <20251020042857.706786-6-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020042857.706786-1-hans.zhang@cixtech.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TYZPR06MB6281:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 084ed7a8-e087-4605-6082-08de0f9131f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9jxUnANRV5mu40iCzQk33oIEpRfltVM6IWx5xK+n9znAwr0Ga280M+x/iPt?=
 =?us-ascii?Q?qeNUVrWJO9YABzmJpDBxLTlDWzdGATH+qVYCqytd26bPX1bTeFugMp85jg9a?=
 =?us-ascii?Q?raPsKjpcnxZquvFpWJSvWJok4bhhMc8gGi/Q+XMWVUFGj44yw+VsPdikfMEL?=
 =?us-ascii?Q?1jQEzhdHOiBQiJDqD4Yocwc4kx9Psoa8k62rbhJRZ4n/kD/IbW7P/E6kYy0b?=
 =?us-ascii?Q?8rpaHCjTvjMC4RoRW5V6XFGMur60hOhXl10ZOmZ2O9wc51ddu9H12rN+9AXE?=
 =?us-ascii?Q?tg5QqGPbQyArVJDYGg2e9+IBJVJX8KkjvCxC+23r/K1fXBo1i44ZLOphBP1w?=
 =?us-ascii?Q?TvbM83EzeHF8nO7VydTX1joJ49p4Dqybr2nO4YA9iANwB6ZOlEo1V46pOI0h?=
 =?us-ascii?Q?fSEa3cYx8Htm3YZZWuT4rT3bNdFY6Laa8aXbPI9eawhe2v6kQLSdUf2uOvRT?=
 =?us-ascii?Q?D7cOd//oWsYM9DQrtmh3bZAtuYbUGl0KRNrl0xKkyY6f7V2s8hh9Fk76TMuj?=
 =?us-ascii?Q?oUadRfXp/BAlu2VD1LI0a7W6/sojWBON1RJTmcwZahkRaJdLCYgC5z85IS09?=
 =?us-ascii?Q?TTpdvmxRLp8lvslxD3boZNZ+2Ot1VY29NbUGYZw1FujAC/7602qTf3QhkTsI?=
 =?us-ascii?Q?9rqTRnRoL85XuzdH+vuju5n9b8ve/aQi++7KIeR+a3bA0cOF/jMHO7lY/xrb?=
 =?us-ascii?Q?uW1bT+iKvTxSS/VhN7qZc7NT4jx4ietYSyxpOAjPpSBsm35WNqWb4PpZwzLH?=
 =?us-ascii?Q?p6XCkxsiktEb/RlL8ROO58MzMXi0ngJKfKOlzBJqbgJJmaM2J6DJ2YIG6/1c?=
 =?us-ascii?Q?W2XNo5H8VH/ojfsVekRzh5I270ruM1ezCslZcs9REFUeFl566c45VBnAsf2C?=
 =?us-ascii?Q?oKIw8BHoPoTbTcb8DWdCWpyQ6MnKHOxpzExQzMGlCQuLWseLnWPkPnY0PR/d?=
 =?us-ascii?Q?uqkTmhpiMRYXbtByxK+fInQ5Zh35q7zTBoBUHAQAKAe4K7ok9DlUBZJIYSeX?=
 =?us-ascii?Q?c/yxIZ07kmB3qRw8SUlAA8pjaIJsXBTuSnaNli45fsfSYNr+FWjw5/AFv/xS?=
 =?us-ascii?Q?6Z7jtPkwK3aFExdVKwcosQERC0gpT7WR8eL2OfBOWu6OhGuwbIBg89D+gqE5?=
 =?us-ascii?Q?eS4Vrq4TT+w2zEctHZ4verNTZwl8vMjxYg2pSD3td1MjxUaQSLdIzXENc83j?=
 =?us-ascii?Q?UgCj8H0y/v6wyW0e1Vollj2kc9r5cfioDaJLc3XOvrxh1u98HzZ6h+IVcb8M?=
 =?us-ascii?Q?Vr7cZNwsIqgwvYEKp4Ag71QJW+QridkThnbu2KuNxSSQBOTfB5fYTx0WSCLD?=
 =?us-ascii?Q?J0QttyPw6qA7q8Q+b2OlkzQoOQZMUg74uwhPNAvVoej2hXPrna2KuNTDw1Ih?=
 =?us-ascii?Q?w5CJRu0+GlXtdZi1hPvCFRNuq0eq7NHN/HkvlKkRPx64WfzgFWsvyL8NaCTs?=
 =?us-ascii?Q?l0+9MDsQM6EEOsJeW15YAyzoAYnr8qkfyMUAcjRGdr5sfDRao89eHCebmQdS?=
 =?us-ascii?Q?du0hwUAgmTjUmeqTp5/CwGQXwqwZhDFM52ZE?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 04:29:01.3367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084ed7a8-e087-4605-6082-08de0f9131f4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6281

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


