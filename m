Return-Path: <linux-pci+bounces-4335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA686E591
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34241C21D6B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E17317F;
	Fri,  1 Mar 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ec///jgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092827316E;
	Fri,  1 Mar 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310492; cv=fail; b=HBO/QKZjTRJK7TxbxJNqDRZhsVlcKtnK645dPiX4s4Wkhn5mODUpqCQBsszP45iQ1dib54TaCZf1cSY9mRtNyJT3xRiOniNUGkC69Z4YSKxuVAaD3sV0TO1R62uhbq+TApfg/5GDHmO0dpo9c6eFu6j5dOeMXN9T0dN+hre6C0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310492; c=relaxed/simple;
	bh=1maBE3U3xoct5PhsFKMmJ/XaWb8wojZsmOnSEkiyFuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TqYZ07LAJeDNHXnaP/qFtBQE/wO4ezqiKNAmWWzkildke5LmASB9jv4N1LsC9cKNRIyr3+aQNjJauPnOUqDAns1sIIU4DbjKywTnOJ0mHa7wQFdXu+YLtw8lNRbNVmSwJfC6zaBG3UWzFZZgjIh/GPdxmczmBGktY1AmONXXbjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ec///jgn; arc=fail smtp.client-ip=40.107.241.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpRLBiQgWwr1aqm+Bg/eXn9Vyq2ah7KKF07c1tgWHGc+gacv1o/63FfhNo2A/2Bs670HAuoZo3RNLhpT94ZYvcAjeQ1oQciNAk43gcnSnwZrjeDh2+xSTAVilmPunpqTMz7dLErdsSMhLnuGDAhC6eZ9gA0vXy8/GSP9/xFoGkb30eB0wldddp//uzkIaQg9pPqFaSbGTm1TlMZ/QaS0MBbWQE+nelCLB8uYrjOTHnKdDLFdPWcdcb1R5UEeW2ORV5tm+rd6w/ySFc9X0wP4OuXwkYIW0f2e1lJOajsmW9BuS6+p07SoV+Hsw2iVERFs+zv1SAW5USP/PYARPlhs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7TrQARhBTnNN1DpIq0Esgu46coukWarnga6V/Y6/AA=;
 b=fb0iGvGCaI2fPojUyCXHNJcZYGwULpcIUMFq6E6xQsZU5ppXob5empyEK7dV/RzMqyGUjzNto+33GDkzgsmhD2pzswl+ZTF6nw00PUsntS5tQwERr+bfKTrfQxEYbh0gpo0d/obmhjusgQXYH5AlQYO8Un4P7nrTmvBB2EyI6yzJOtQc7K8Nl37rgGJpNG5YtnjXk6kQqBmZ2ZCWrKOwA2J7eNmAfX0hGdonQMTgojhEQtXdQ/V3NMZYtzm/p+QuFmWYnUXXkhK0wxriS7mqRJIzEG+XNDQ//riSwJEHsYx1pwFtc0TVhQNUSkXzevDN6Cb8byIvSOhl/691pPPcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7TrQARhBTnNN1DpIq0Esgu46coukWarnga6V/Y6/AA=;
 b=ec///jgnRkMWyNYY3CB45JVgHTEZm3RzK5T77qyrV+0BR/eDTqLBpGmuACzUlgYJCGsF5SWiS+BWp9R9IS0ftE55v3M5xEY+IK1cVOBuXtYAOiMozEwdGL06N+ZJNnPcWPCdxfG9ojnHUwbmgGBLIElSimQrB62pHLPfWCwnwmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7865.eurprd04.prod.outlook.com (2603:10a6:10:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:28:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 16:28:08 +0000
From: Frank Li <Frank.Li@nxp.com>
To: conor@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	helgaas@kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v6 3/3] dt-bindings: pci: layerscape-pci-ep: Add snps,dw-pcie-ep.yaml reference
Date: Fri,  1 Mar 2024 11:27:41 -0500
Message-Id: <20240301162741.765524-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301162741.765524-1-Frank.Li@nxp.com>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: ade6e94d-6b65-42ac-9ecc-08dc3a0c9439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8OQahmy6f0xZLNp0WwnZIgAQPxKaCae/57fvuK1KppG9OoWfaMx234mOskBMcWH1R/HtileZGiRYt+Qk6EcgyIDY3tE6IDF60SlQK42tsXKpBT4iOLklEYjvxm9SXkc6c5fpswukYzCPuWfII6SKG6wDIKuiFjBgMGZw/sMUBQPkeHxyfIBRAe5nqWuOCZTPmj0UxqTRKULNBGeWzdKPtkegsE7zXVIprUxwId0AcX+MWcYV27Uh75Al8ly30Wuyp8d9RrIbkB/q238Y8pEXbnywL0Jkl9Ku6mySBfUqQwb4hEGj6nR1PjUQSlVAhWdrFFPbzVA9XY4oSlsf1NehKqQVXMY6Afr+llSiU0ey/6qTMMbDt2OvJzs+tYjPOn+IQ4J/CLdhMKRtKPm0bVqYAXNyldg5qT7hdVBj6poxBKCKEOuhz3BiNUJ47FrVytMDX+mtxVsQVRDalxxCPIhej/tbeWcoV7oZkF2r+uacAZ5aF3F6MBr0BCd0vj4xtmrT0J7xiUb3o+NLUACOcRZ36KOf/DT1s/ydz+xE3rfl9JAcCE52eUmd6gqcV03/Ln3qJGfjOssh1aBo92y+bZByu6sFQ33AZRsQzhIhBFm8eSEZQ5po8UxDawIAiUuiS/IxFtWQopJ3ZJ9QmqAdUkSphESX65ZXSjhwyNDvj1XCKFlOknVjBYbrl4mf1MX8NWUmbN5BhEx8M4pfGAEMKCvFqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGZKufBq7aT4Sk8Mz0ZvdzM8rzjB0VKspnoocOGlr5B2Zec5YZES4WX5eVxX?=
 =?us-ascii?Q?8cN1jzZV68f1FFQc+BXrGHwhuiAxJvSNKsm3kg8cU0W8jCvxwI93ph3JjVUL?=
 =?us-ascii?Q?rsN9+0YWTO5D+ZRP5T9/ftgZSICuXDyRx/iid3eSTkJw5RRpM2CmZgdx2vz1?=
 =?us-ascii?Q?3kpdFGnsmwidEBhF5vuRBwl5dKvGv8LIwS8Iy54Sc2FFPpZmAbIjsO/MQXiU?=
 =?us-ascii?Q?3Z3OOYf57QTNOfHhZ3SzD4AK9MN4YovuhVwgB8goZi8R9Xzq+T2QqsP1/ec1?=
 =?us-ascii?Q?hjI3Vh3v58ni9d8dj60EhVYMJiTrduBIqE/9eqcP/2e+51FiKkW+CWdwxV9O?=
 =?us-ascii?Q?AbhMsHLL4eF8FmUyN5FFOk5YKkEJ9uH954hq0INeBUX0cgN5hFRbxLIjvw4F?=
 =?us-ascii?Q?5056un41bitbwmzjzzVtoGZQua3nIkm+GMUhFaMQeFHT50RtB2mrb7u2inmv?=
 =?us-ascii?Q?iKim4XnHMPOd6bL9LvKxwEC52aN+DsAVcQD21MxpkZM4S7f5Chj2ZZ/QI4Lk?=
 =?us-ascii?Q?e57kAyaRB90lub52VUzv5kN2V7qzaiPJ8ugiFt5ZrLTVR3Er1dLGIjF1TLJE?=
 =?us-ascii?Q?B0aC838NSf5a+LFKSRXMqwaMvTeOREAHywddwGD4TyD27tT+mPT9nRV4AMFA?=
 =?us-ascii?Q?hDlM3cuvmG5SI4xuBJijoWMJCJFI+PD88YGU46KHi/yvr0LuGJdRpO58h8pt?=
 =?us-ascii?Q?19DdMNBu4lfhv7gVIcMm5HL/FW1E5ZUQgWPDWg9BLD+NROz2lrqupmoGxJOm?=
 =?us-ascii?Q?UC9XjEenUPKR3MSj3WUndVifiRwqdorLP9WM68nN8mS9y7d1BHUWdkNe/1ZL?=
 =?us-ascii?Q?jxunNtuTYa8vMdftcMkcyVjnEw9+swKQXjPs5h4fa2bY1I4PVy8lX8Kwtd+w?=
 =?us-ascii?Q?XTW/qtU6jTGXBdPw+eRR8I9gk+95WrreOSiA6Yh6VtxHucFg7fo5aB4O6Q2P?=
 =?us-ascii?Q?8oc76Zap9sAkwBvppCDYTeY5q08NVzjvDJ8AIR1WA2pOl7ylhu5Q4IE6DKlS?=
 =?us-ascii?Q?5Vn4P14NXpEhM2DwqF8oK5hTzL6VaJn61B6k1gvxoME8iYmqH2i32hfzxJ/K?=
 =?us-ascii?Q?GXVda8ozLqTDuPiUNRvD8NSbe0g9U03WKmAW1xHHb+Uycwyp4xAw+C3hpwGE?=
 =?us-ascii?Q?swE2ryw2gqzxR18p+6dOzWQyvPEDDfRrnEGl6mg4vB8r34RF2G7rfRrVnffh?=
 =?us-ascii?Q?Qmq0YeqQPYDT3fh2WzQuN8MnJGPMgl4+nzuYaX4ygzLdKvca9N25rmhjfoha?=
 =?us-ascii?Q?9N3nCah8LXNH8lwSQZL9LldZTffrEBEARweJDDRAF7K/YO+Nn7N14FIuDr26?=
 =?us-ascii?Q?BDskRA15i5PBAgvBBCHp1BTIhqTrzMM+CpIaNQFosVjLYWZCkoskxnrRe6uN?=
 =?us-ascii?Q?iixt0cCR6ufMEZjuTnxsM1TB5/8xs40kh8qiyT6POvkz1d1ECOzsaNKUajKs?=
 =?us-ascii?Q?GhTJFBGE6MGgk5VNKmd8Yzg3cDQxPT3U6BjVhEsdeG+UxzEb+MYUtgEf7VMn?=
 =?us-ascii?Q?hb7eYy15EoJBcWZQd9gapAdiddrhMBe0PwwQAJB8SX4GfSuCR0g+XHBurafs?=
 =?us-ascii?Q?gcSepFfMt2usFJCuHt5/UvoRLtFh74PQxL6ohqn4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade6e94d-6b65-42ac-9ecc-08dc3a0c9439
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:28:08.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onN0ks2d8udeAbINWYhHBk6Gg7WUAdxmuANclNPxKoTRG+1xKx8Of583fIAyFUCqjhygd64pWaPxZYOiaZ0wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7865

Add snps,dw-pcie-ep.yaml.

Remove context that exist in snps,dw-pcie-ep.yaml.

Add an example for pcie-ep.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index cf517e4e46a33..07965683beece 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -10,8 +10,7 @@ maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
 description:
-  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
-  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
+  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP.
 
   This controller derives its clocks from the Reset Configuration Word (RCW)
   which is used to describe the PLL settings at the time of chip-reset.
@@ -35,31 +34,18 @@ properties:
       - const: fsl,ls-pcie-ep
 
   reg:
-    description: base addresses and lengths of the PCIe controller register blocks.
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
 
   interrupts:
-    description: A list of interrupt outputs of the controller. Must contain an
-      entry for each entry in the interrupt-names property.
+    minItems: 1
+    maxItems: 3
 
   interrupt-names:
     minItems: 1
     maxItems: 3
-    description: It could include the following entries.
-    items:
-      oneOf:
-        - description:
-            Used for interrupt line which reports AER events when
-            non MSI/MSI-X/INTx mode is used.
-          const: aer
-        - description:
-            Used for interrupt line which reports PME events when
-            non MSI/MSI-X/INTx mode is used.
-          const: pme
-        - description:
-            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
-            which has a single interrupt line for miscellaneous controller
-            events(could include AER and PME events).
-          const: intr
 
   fsl,pcie-scfg:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -68,10 +54,7 @@ properties:
       The second entry is the physical PCIe controller index starting from '0'.
       This is used to get SCFG PEXN registers
 
-  dma-coherent:
-    description: Indicates that the hardware IP block can ensure the coherency
-      of the data transferred from/to the IP block. This can avoid the software
-      cache flush/invalid actions, and improve the performance significantly
+  dma-coherent: true
 
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -85,3 +68,24 @@ required:
   - reg
   - interrupt-names
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie-ep@3400000 {
+        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
+        reg = <0x00 0x03400000 0x0 0x00100000
+              0x80 0x00000000 0x8 0x00000000>;
+        reg-names = "dbi", "addr_space";
+        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+        interrupt-names = "app";
+      };
+    };
+...
-- 
2.34.1


