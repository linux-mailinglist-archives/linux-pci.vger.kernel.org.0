Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE85E6826
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiIVQN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiIVQNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:13:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46371BC6;
        Thu, 22 Sep 2022 09:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYkQOFSDGjHjRK6QHmgaQkVMq0OZrdpS/gNNoTrgLfeE3jUUByO3S0RNN6+Q31MQN8WvjXZFs74pqgFpUfh4eniyhuIdf8Ppo44trUkxZ+Q/L4dbmFQ1Zdsc9cHM6JbVLsEjlipdo6hsV+NznJQbsNwziPBfGjkyH4XhPvQh7+HJ0eycQPPI4QePo/8qd3QoyDxN4/EkJjzr3p7SB/YcyE3quGRhJWq8fxkPgPZDjr5Lec0m5S6KmykcaTeH1xyBg3/QdA7HKOkPB14AXIADE7S4qkX6P6tz6IllTRMNz+cQOJf3zDlbEEvwst3CbDK2y9OrJFL4QSkwPLDI1sC3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ankBqv4m+mipQUAqC6qml7eN2IMIGbUtiVkPxPMXbW0=;
 b=gtRbGtp7RfHJhir9674NQUtdtxoqbMLw8rwoEsvZLmaGx7cjkMvP3HYWd6hNqnL09Q+YFvwxhuXsmS/Pfmw8dBhmJuF53+J2SJ881jC2I4YnSLVCZUqK+fJoMdc4l5iUJdsHadsn4H/zpvA4lX7coIUlhRSh++10AEdR+XK2vif1IJ6rD9acKH4Y1aDhZxiKqJva9OSKcUG4Qo3uSz12LGxMm6f4tZYSaCtjSKAkVDiUF9iiN59Hzq8BNcSotZ2NRnLUTs9mtdn6bfM5tVBl16n2XDIGj2aa2OVyxlcsqSDO/UhtVZlFwMYumyIgAdpb+y8A9JzdcJPSqCYlAm8fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ankBqv4m+mipQUAqC6qml7eN2IMIGbUtiVkPxPMXbW0=;
 b=S6qwR5wZxVoiuqOW+mygiKB7bucAZioLX3suoC9Bc45+NPOyT+KTczaiuZqLpN+uUhdfRRT0iNTYD13aInQP5rdOmipCWzTKEDPZooh7arkUr1UBUR3DUKpPW9IRc6ykHjjcCcMn/hk5iaivMYrMkqiLocxzTSZmvMjcORveiKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com (2603:10a6:10:2e0::11)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 16:13:48 +0000
Received: from DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428]) by DU2PR04MB8789.eurprd04.prod.outlook.com
 ([fe80::5c5d:d0e4:cd13:6428%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 16:13:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v12 4/6] dt-bindings: irqchip: imx mu work as msi controller
Date:   Thu, 22 Sep 2022 11:12:44 -0500
Message-Id: <20220922161246.20586-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922161246.20586-1-Frank.Li@nxp.com>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8789:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: a48cd936-2f43-464e-c955-08da9cb56e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqqT1wUNLO9Z0QHJsFxDqYjIUTnEGuKoNwG7pLlqTS6gwPQUGTG48IMd4qWyEmMDqi0eRuHoOKfB+umfuxeuzmS2HyAsOap978ergdn2lh5y04i1IPWokHb3qxDUwZEUr2tZPX7SPQorNFA0oQUtwfCTQEyW+nplTD6BEbwW/hFTonUv5KoPuGBRJVtwm9y5D6mDA+9ZOEcb6BO+mxv72b8r5z8PlhCCyd4BDb8cJTeFTgbi+uhKl4HiXxJeADEJlmg0mKORthuBgUCYrMQgiB3VkKVoa+m0PfdMn4cm/I/Q2Np+1FaNadWYeKzqUMjIDTY1SbU5MRj6oaAl6rtPp9GZfi64FVzJZrPjuwI+jsJ6nlTO7tscTmO7QWxxUta8g18tlDNU1SnXx5rkMh6N1rWaaw+PTqN9UqiHB8ZcgS/8oTllBGGgcB6rhh/tK5Nn8DZJfM/G9msg8V23Fld0i7CiZdATio3m61em3PjSfmxmbRYYqb5E1Gsfn7eOM69WzyyYQe/5VgUYzeUy+aWjNZNnL8F7Gq0n5ta9plFQIuZMpfMP0zo/ix91PgBweKsl5X2JUR+hIk8G8xLhofYPfFBOB5oGHqev9Yu4oXdsDNoEYejk1qy/pV5UPEQYwh/RO/TBu7Xak966MeBQC2PuvDTudk7pzaaQp20PGcGtgO+GT/xh1HwMPTMlq7nY6c+zWWA5zWJKE+E9BwuGjjqq4ecoe/2VKeOACUPdcovaVzlb+w8CkHVyIZeeaqqUCsFA1ix3gpQUWSOiCZuXhjGiQjYqKr8XxBBRN01XiPYEMN14oRBxglNd75kiH0+4O2CQoLEcJphUmUdXeUyXM/+w1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8789.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(1076003)(2616005)(6512007)(186003)(38100700002)(52116002)(66556008)(38350700002)(66476007)(8936002)(5660300002)(41300700001)(478600001)(2906002)(6506007)(966005)(6486002)(26005)(7416002)(6666004)(66946007)(4326008)(8676002)(36756003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SipQilz8ezxIxfbGB+Jm5lAN9055kUbKP7M5R4DcxWLHe2mtRbkdFUgiYsFB?=
 =?us-ascii?Q?b8Cjd1MifRYacmj8UwNMTiHBYH2755mG1E49pANWYOKfLrXM1U2T4aXa6wte?=
 =?us-ascii?Q?3d5NQ2HUOoVrWuQl7VTky7CLSe8mDkBDoR5okMMLuVXdcUXg+rQeuWnm6vWm?=
 =?us-ascii?Q?tGXd9whEWAMx/I9zwg4ZqaYyVyFDuawP+IjzwRGDv07T6mCXBtKIz8wYY8aQ?=
 =?us-ascii?Q?fHOfeNJrtYw2c/up1VK3OTt25Mh1e2wCa3MSBcnrcBrRS0jE2WznB4RclAI+?=
 =?us-ascii?Q?E51ziRDA0zS5FNqYMreKJQNQQWVPj8rFTNKLXrN6+ZrtClM1zXgWCNRis7cl?=
 =?us-ascii?Q?ywLx1sIGSsm1ULdWSm3IAnUeUYV8ksN5xQq43VMg42YhOeXAXXyt7T7NFSKp?=
 =?us-ascii?Q?FlgjhqfBalJj4XVO8LCNs8pqpVLfMI2tqt0HOALA+PK1WDk/333279A2j+A3?=
 =?us-ascii?Q?cNhcpjKz6DkN/iinXxNQMEVepl90PyvxjCNjYOMEztY7OKeDpycDvFxq3pm5?=
 =?us-ascii?Q?pts2D/VJOXGDLcxstVOopP2sbAW4sSCghyydnNDKG1Gsu4BeA3w5ZqZpeGDb?=
 =?us-ascii?Q?EjUS30/thrxrWr+4vGudYsPaIHxAD08bUIE4/11wQmEXnXnjpUuNBVLAcnSW?=
 =?us-ascii?Q?g2CL2YgOXL0g46SEtz7nlbqLBpA67KYGkIveg0nEnrGcet4zKQvX99VMarrU?=
 =?us-ascii?Q?otOKpUr9Cs81aPjEfmLvwcxzxLx6O/SJ+xisrAJ2rSWwhhWiLUN4vqIE4sv1?=
 =?us-ascii?Q?1SIrCZg/1c5t+eH/9ELVy17os3tBByDunjpQSET6R9z6tZruLz+3dE/I6PTb?=
 =?us-ascii?Q?1d/uU568r2wyvPlKPatbq5NlQyHomYHuBBPz9xoZiOVk3aNI8TakQ+PJShCx?=
 =?us-ascii?Q?phepJYhlkdGgUhZVssPSNV1GPe5MSUZlFFDHt4cklxldomrGvm2Oh9iHYceU?=
 =?us-ascii?Q?nScw4eohgx3LubJNmlqKm+g98JjWhmJOV58a+SrKTXV/hexEAPEMn5S44EwW?=
 =?us-ascii?Q?F/O8Phzck7g2eF9Cf3Wyw/5WOKD4UjoRWM6dTA4vUjVs3oJSVZhVoGc3CCSH?=
 =?us-ascii?Q?Z+mhJsPt0z5IKK9xAFXe6Mgrwnv3LX25oVDPdPhA/7X4m58aZb3f+Ce1mHaP?=
 =?us-ascii?Q?4TsuRRIqBEjTmzTLs/icKv/7CFF+fYBpQuptVNNWM567ubQA2bVfK6A2Qwi4?=
 =?us-ascii?Q?ooZ10pqt/k15LAz4ToqooUSNSd0jMp10DHl6nS3OBDRIkV42R3RGr2ycPkwH?=
 =?us-ascii?Q?MR6Juu9YJQsoEdaFJW9IxDricZscjgw1TdBSprDfgYUWvHaKMgA7ZD2Iu4Zu?=
 =?us-ascii?Q?IxoYfH4a1v3M+o9yMt3vbcoNLm6uK79s//c1K0bsGp7MAKQrUejXBF9dMTfi?=
 =?us-ascii?Q?8Mvp73tvFPixakX/vV7TXjyGQNYbR8BK+4DTAJQ1AFC4iTdq5YBocXXhyY2H?=
 =?us-ascii?Q?tZ7x7dzDHAIzILdwKGXB5C1rp6YjbMXRC+uyncHk5lV1K8UsGHIjnQSHRTkg?=
 =?us-ascii?Q?cnAVrfxgS2E8Ykc9hnKUTh7yErqB+RQQgZBkIUQsOZMBdQ+cptrf+ZQNKUvJ?=
 =?us-ascii?Q?R5MnLj9SzDF8tNk1FQTujBSXu+vTWKrf5No9xuxe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48cd936-2f43-464e-c955-08da9cb56e37
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8789.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:13:48.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCXc2zWnksyA0lXzg6qH9lQOB1i65Ry2oL6jvQGAKNRFXhNEhs3gLwI3/DhfhEUviFenaVY3tbhmMI2JNNX09Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I.MX mu support generate irq by write a register. Provide msi controller
support so other driver such as PCI EP can use it by standard msi
interface as doorbell.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../interrupt-controller/fsl,mu-msi.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
new file mode 100644
index 0000000000000..799ae5c3e32ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -0,0 +1,99 @@
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
+  registers (Processor A-side, Processor B-side).
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
+      - const: processor-a-side
+      - const: processor-b-side
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
+      - const: processor-a-side
+      - const: processor-b-side
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
+  - "#msi-cells"
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
+        reg-names = "processor-a-side", "processor-b-side";
+        interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd IMX_SC_R_MU_12A>,
+                        <&pd IMX_SC_R_MU_12B>;
+        power-domain-names = "processor-a-side", "processor-b-side";
+    };
-- 
2.35.1

