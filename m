Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F311598705
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiHRPMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiHRPML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:12:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888DFBD77F;
        Thu, 18 Aug 2022 08:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpLSUfyEY2okFKNvyDJzPlhqGcjx1og0EkYo+5WVTIoUP9YGOznv6rzqfsRNzl3XjsrouSvTTXUxY/w+zmY1BOzy/L87BUQ9JWSZPR1NHg3e7JTAXJevvf08uL72Cn/35mSDgLPUzhel90Iq0phiS4DPubyXtctigYy7qYAMzfPvRDIudWCv0ifWbDz+nXsG3la7ucvUNo9k2v8q4B2HyGn6Toet79tOVv2qIs0Z/qb67AGa73qf/wkMbXRlVRI6fC5i0KOPRzvZN/NbfiJQFIiLkTmN8CQa1IbW53YmoylAobkgF5iwLPE/4aULM+Ls3Mg3w8KFW0DHAdbCWX3KJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVFJJkHBYbxdRZKhWWlDd3nZUmM3IMXu087up/Kc5H4=;
 b=O5s6Pvtj2B9C4YCwtwG9rXb69LP6RtjKzb5sFlOo1bEnlfqZBoiRLU15gkCCf0UMb5aGI09wNZpLINf10lIsA/p8hys75vCYTwsuG9eIUzXl/3cSWxOlmFYD4IndssBUqv7gu3a2g+20PjcVIN78iX/cBPq7MlGJseJwedpMQ5fWNdnj9urfzlsPKrQOvvDlilMGbGIPEexez29jGBFtp5a1/ny4bWUBc3JKltbr7rXCUecoLoTle+MqU9LH/UhEX3QoReDbebO6F/ZswoRVuOiKRUG6AG6nSsvWcmVEliuhkwBIOZU846GAxbHhXZOKX8zKO2wNjEt8esDzJ0+s0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVFJJkHBYbxdRZKhWWlDd3nZUmM3IMXu087up/Kc5H4=;
 b=E/ZPgUp/zqQkHgvNj0UJ65OD0sFOaeRGmOzk5qKNao5IHjAlfki+bvFRXniWsYNy3UnJlgw4tGMQvSnBTmCe6tg5/i6hDO9jY/L+WqPCOhBoRw+jvK0uR5PfAekSUDQbGyHMY5D1QGoEC0Q03L297ZRRqb/cdJN0YbWyWym0IT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5713.eurprd04.prod.outlook.com (2603:10a6:208:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:12:05 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c%3]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:12:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v6 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Thu, 18 Aug 2022 10:11:26 -0500
Message-Id: <20220818151127.2449064-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818151127.2449064-1-Frank.Li@nxp.com>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e43333-e1b3-4fd0-57b7-08da812c02af
X-MS-TrafficTypeDiagnostic: AM0PR04MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDXnbX+NmEhXbbCh0soY36n1+mp636e/o7t78uHbjgvGs0gck+JKr001AWzefEKq3aGEaca4TGlFDROVBO3tjNjC1R02Ph42fn/La25Iuv4BOFksID+RKCRtcCNpru0vWyxANV0+3XJerofMjxoco7kicvG7J+l7tLwhSJVCQveUL5Z8SIMJwAu3+NxxBUPCJ1DgybGrhNw9+RllV2zP2xMUGuo22ThromRn+Mb9Eoj7WKX+MouJPpaMcDItfDtwrRJ9AjpHXNq7xX8cUQ/jPxd4MoS5IDUrd8do9v5CUSewyMfR5SnQRK3LfR4PpiKPotY2oXWKrsao/VrXQPps9OLPkbFMxMeWvwnno/RUtK2cuLJ3fi44uJh2By/JDuXcnDYejuWTPuQWKtAP4HysqNwYYIXAzTvdt9mQgUgM09B0yLXcyGpRbhcm5VuTiZLQoca9haZ8jVMR27yv1YlLEI3a4hHDXeGJAbzyH4auJ7HymLrm5QC42G9HADpS1UXv1DCD861ngomDDFgTqSIfaoigFkEqAveNZLFm2PNs3epxIFvBsAdcidRYo/EvtVKSOcrOILM9d6pjv18cnr/rL101BVIf/MYLxRIwotcWSCoaai3458mxnxQ+ac99stBbcdYCUXxjKglfuueO5gI1I+pjfY06Rk34kg00sX+MKR8y23AIlAhHFaXFCQAphf7f/F0bJnyzxROCt+yPP/RuF29VZnzxL7Je0jLKex3XSRRAchjcyXxOZZeax4Hv89UGI4nIAqvsfd7FqAn/R6w2sTlmeOpv/Xh2ej67YgsHuJUGeEuM8Jme4v3ZpTx61RcArX2kDWKWRmkv7lYuPQ2kEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(2616005)(316002)(1076003)(186003)(83380400001)(36756003)(38350700002)(38100700002)(6506007)(52116002)(4326008)(66946007)(66476007)(66556008)(2906002)(966005)(8676002)(6486002)(86362001)(6512007)(41300700001)(478600001)(26005)(6666004)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdT9FKOLTxYQhwjOtn+FN5TxysrNpXrTAfLVFOKPX/FUee9KDVMRAWO1diFm?=
 =?us-ascii?Q?14UcllcgLffvezNG06UqAFSv4rQz2H4xw91n8VnI7iTaEnYWPtcyfgL4bXqr?=
 =?us-ascii?Q?FxfeiyVloo1TEiviC1sXadXSv9/PClTN2I7Fn2vBbn4guEDlHElM9kRrLKJA?=
 =?us-ascii?Q?LbkVlVzy4BYq+e5AQA2bEPGPrmWUPnM9tVGFx/kqLOMv3rKjPid3dQMm2EMf?=
 =?us-ascii?Q?rgs6wZuC8jUhjaelvqiL0UNya7lYhSbpyZP0EkRQ/shlWFCjh/g1Y4utNb6H?=
 =?us-ascii?Q?cV2quBHGXMs+C8Qqrl/z2sRTx224npKCVaDFqsysT55J/bEX3gMsqTj2B2sy?=
 =?us-ascii?Q?vVxlN2C1L7tBxjNO6DjSxWDXYnc8a9BvOIds/kdABv9I+J401cPmID4/t+Rw?=
 =?us-ascii?Q?CjT7Yu2NAiK1WHzT8GjkNg6FCl2NSEAXGHD968HIzAj+3/f+6hCsCear+aJe?=
 =?us-ascii?Q?di4mmwyOHMSYwQSw+tFUMEGNx6UahJcaSRKtdO0Wa9TvvCKHP8RIVrNnLvEt?=
 =?us-ascii?Q?LBowQxapd4Y+KEaNiqtqHEqp7rzwclxSzeQq6UjtuDnNGbcCGqoYBz1tNKPk?=
 =?us-ascii?Q?yBNfK1ZbM2aFVGWl7plgViZJABigw+L3isWqHO7ujvTpJc1lUMw9Wr4BCSBS?=
 =?us-ascii?Q?aa0pCYtQLxxdGx9C11u6y72wMOzvTFlLuH3YtiUXp+OTqNW6ONfxKgbsLCXW?=
 =?us-ascii?Q?wQ5ZwY0TtuuuVp3FugUfzsZ9QiF7tEUfJcn8j1TTarESYNMB1BTJFjnFfiv1?=
 =?us-ascii?Q?J53UBz/X5uRF+NFLuqocw0wvPQKt6n+oWFJR/pIl3bdXYYaPE2gQZfoH+TrS?=
 =?us-ascii?Q?oi/1O0o53jq/G/cRVGakMBa7GDv5advg5yleyqzZtwERwFHy7YWE6CnA0OQA?=
 =?us-ascii?Q?+9mrQsJtuiVvTTkipwDYIGfJFzmriIWS8M2P/kKBoQ/H6R8DLMIMH6XEIHYd?=
 =?us-ascii?Q?SIkVjmZ2Z3+fUg/LIakAW+mHVEe1WEYjwMVq5NHj8Hm3CJ6Y/hnXKxPpXFDN?=
 =?us-ascii?Q?tSqDOL/ntR5WeUGKdpMY4TynemOlEWEtZxghRqGvHVt5ZWm67gNmBO0zx31R?=
 =?us-ascii?Q?S6Gx4gIA3/XDWdl0Ablx+oejNwP631ehvdUf92QdkrmaeJ+eIMImABszJfpm?=
 =?us-ascii?Q?zcZxnJZQvVtKY5LNhzCegn++7aRlsvw0NTeanOdetAtkY+v2qyMvZrzQmjVe?=
 =?us-ascii?Q?KqvF3Cvx5OdoEIOHcg3T8gVwdwVjZ/zCL95ubspcwqU0g5j7203z0hugADms?=
 =?us-ascii?Q?IfGDWkGickiST/hA/Z3tsoLwNcbV72lG4AX4LrLyy+maZOfvzxUlhOT9oyEZ?=
 =?us-ascii?Q?Qr31rwszuNufsbSjhQGw18y0U5Jx1KZhxrICqmtuJr0Zuoo5OJwMfrUwMI86?=
 =?us-ascii?Q?fQRR0zS44/8fo26GEvF/iweFoNR+5F5lAeOZBRC5pI6uIB61slzneVwtIJ2f?=
 =?us-ascii?Q?1TMw2l8ZLoGoMyMx45oWwodnIco92GOjgSQ76ASejXdS7QrAlm8S5smMuGLU?=
 =?us-ascii?Q?x5xv52iDiie5NKdTMDgveq6EJLlIFcCCNVmLrzxoRFy+v35nbUe8kXAaLu60?=
 =?us-ascii?Q?rZVlZTks7M3AgV8yJzo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e43333-e1b3-4fd0-57b7-08da812c02af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 15:12:05.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxaGMpG9UAw9kgszJwa36ylzNyD8m3VKKShSH00EzFyTi55gySMariJ6b42OpqvU8peD7Ua5yjIej5c9Y0o9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I.MX mu support generate irq by write a register. Provide msi controller
support so other driver such as PCI EP can use it by standard msi
interface as doorbell.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../interrupt-controller/fsl,mu-msi.yaml      | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
new file mode 100644
index 0000000000000..ac07b138e24c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale/NXP i.MX Messaging Unit (MU) work as msi controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The Messaging Unit module enables two processors within the SoC to
+  communicate and coordinate by passing messages (e.g. data, status
+  and control) through the MU interface. The MU also provides the ability
+  for one processor (A side) to signal the other processor (B side) using
+  interrupts.
+
+  Because the MU manages the messaging between processors, the MU uses
+  different clocks (from each side of the different peripheral buses).
+  Therefore, the MU must synchronize the accesses from one side to the
+  other. The MU accomplishes synchronization using two sets of matching
+  registers (Processor A-facing, Processor B-facing).
+
+  MU can work as msi interrupt controller to do doorbell
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6sx-mu-msi
+      - fsl,imx7ulp-mu-msi
+      - fsl,imx8ulp-mu-msi
+      - fsl,imx8ulp-mu-msi-s4
+
+  reg:
+    items:
+      - description: a side register base address
+      - description: b side register base address
+
+  reg-names:
+    items:
+      - const: processor a-facing
+      - const: processor b-facing
+
+  interrupts:
+    description: a side interrupt number.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    items:
+      - description: a side power domain
+      - description: b side power domain
+
+  power-domain-names:
+    items:
+      - const: processor a-facing
+      - const: processor b-facing
+
+  interrupt-controller: true
+
+  msi-controller: true
+
+  "#msi-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - msi-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    msi-controller@5d270000 {
+        compatible = "fsl,imx6sx-mu-msi";
+        msi-controller;
+        #msi-cells = <0>;
+        interrupt-controller;
+        reg = <0x5d270000 0x10000>,     /* A side */
+              <0x5d300000 0x10000>;     /* B side */
+        reg-names = "processor a-facing", "processor b-facing";
+        interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd IMX_SC_R_MU_12A>,
+                        <&pd IMX_SC_R_MU_12B>;
+        power-domain-names = "processor a-facing", "processor b-facing";
+    };
-- 
2.35.1

