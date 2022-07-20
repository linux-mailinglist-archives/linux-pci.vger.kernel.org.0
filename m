Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76057BF9D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiGTVbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiGTVbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:31:21 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038761B3B;
        Wed, 20 Jul 2022 14:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIILyRtfj5I+MUq58laD7y8LxAKf/EeNdPHD6oF9HQnDVml9lgheq253Vq5MQNFyB4EwOKhVTyIkWd1jEkhjOAGl/JoXfG052MDYdrCh42Gf9EUS1gk7H6EmwH7LMyrmkxqPajHcVVg/RyhRPeyF4Em6UGQ6PZk3Qf5ofryJFem5/UtZNDqB0LVMw0UUsJtX6fFlOwLlhs47h5mlJqg/mXGxcTdMPC5+9fra+hkjap3LJEB7wJdhCkS45q+xNNL8X1SovlymJgd9xOGw76b3EncOp7d2uq+whjYAI7rph7AW6WHC872CUlVCeWCTSEUYuEoXFrBvlA5NAUWsVArR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkwQ47gYhSAEPm++wPMu0IyfyIHL4r7W3jd+aeYHTnk=;
 b=A57rQvMAaYyaPrhkUQ07FLyWcR8y3HNxI/lMTdGHaDGcB0rxftpWkXvwHrfCnxrkXWArTv99X0Or5n0fx3rOh2dMzj3WxogcZMsyIafQwpKHjIIqvNAI3RlutJzyPghsNF84qyeQq/mmM4salqqYWsU9hgZ6Qj7wIS+jVbw06ojn0Ukea1Z0jpQwKVMz3X7dJMkYaoGgJ35d4vxiZ/AwcUNx5QmMxL6mA0cJppMwbpIDKwK8fhwVrhUmM+lzZaU9hurBkN6ERmStIJJog7SOW2JSfyZLDkfFg3nWW0F8u0wUqX1kV4XNMQ9BAbqLGi6McYzqoWXltkHJzEwMAVXJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkwQ47gYhSAEPm++wPMu0IyfyIHL4r7W3jd+aeYHTnk=;
 b=fP3RE8db0GgY0JDrd0rwa3ktDuqvCiPmbu/VCYjIahKlruiQGodHJS8F2JKiBbaZSWjeV+Yot9mpT4cvL03P+p72/RUY6D4odTuDCXq4iX+KGjneZ7L3o8Epdkh9A0+GWNayXR/VREsqvM9MNqT+20CTmNePJ+NnvKzuAD6FRnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24; Wed, 20 Jul
 2022 21:31:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 21:31:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     jdmason@kudzu.us, maz@kernel.org, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
        bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Wed, 20 Jul 2022 16:30:35 -0500
Message-Id: <20220720213036.1738628-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720213036.1738628-1-Frank.Li@nxp.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b54f57e2-39fc-4645-48fb-08da6a972bb8
X-MS-TrafficTypeDiagnostic: AS1PR04MB9479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqe4MlNXG2K90gu0RHvdBhi2f8E7nxvuV3SXUQUB0fKQEVejx6cGIyVODeqeLBS2jBLm45ogIS7JTANHoFeP/MHCm347kg/wt6ZAMgnPj5QvNMWO4wqZOrZMrhW0IARai3WwWZoG3eaymmEMlXnMIaR9bcMOwlGVwrESp2XtR/5fePBJRD75ClSuoDB5GIxU+WHd4CPMI/HwNUIpNAKcGRafhavqAbdC9W3b4v2hL9PZCvdI0Ui83VNFI0etPGuiJxJKAIEollwpOTXM901yBjjPvh0mGvvKQQL8LJ05aj0FUK1VVYyP+YuJRN7qCIRd3RDe6pSNnQKNuQpOaXSIE1DaDry6V+079zNvyvnze2wm+kl7nFUZcV1D7aV7I41d6vyytserBg7PQt1TV7axFdEMyhgcC43ANDnfhHxPWg3aqW2bVaGSQkyOJUJ1331w3nEMsbVfYxSAB5EKcotrjAUTbkQafhkwHujN+g6A90velrYFdpYWQ33WRvM1p1WLkD5bcGXDlXbUVqNutdzN6mXKuRtBnAICRlHNvTO+NGjsPOrvXHxIFaTlj2iOoBoiEy/8+rrTHkJ4n/dpBkSW3FlI0mTj58bLx0sHsWURKQuCu7f9z8RJ06Bj9+hueJsctwxZTCecH4FoTK5ZwOnmPqKgcCxCdDH8z4iiIqjfcv4Kc/W2I1HDhkldmSpTfU0Avo+59HzjUbj81ZY5dlIE0C/kJQoEphqwrXHE2Q3APKlEOvNmIBDl2PtIRSMSgFCerfXmxLzwV5iZ7h+lq8uh9G2gSvgxxmP+oy0lf9vI2pw1NE0FSNGVfIUrVUbdkK6DLcQgiv9SfyUg06oXwu5ouP5x14Z1yKLCcBr8aYX4P64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(4326008)(66556008)(66476007)(36756003)(966005)(83380400001)(6486002)(86362001)(8936002)(478600001)(5660300002)(316002)(7416002)(66946007)(1076003)(6666004)(6506007)(8676002)(186003)(38350700002)(41300700001)(38100700002)(52116002)(2616005)(2906002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sICVCEl2gI88gd51hQf9zw3vggrF5b5yMej4H14ogNq2qbs42FsYT7v6Xqrn?=
 =?us-ascii?Q?LKZ5QvXGEAWxZYgzs4OPrzKVOP2YHwfB4E2RRYZgAWx5AedXFc9GPJ48hAR8?=
 =?us-ascii?Q?08yVAmafzsWFrz8Tf3cVfS156n376wPZGvk0Cw0NKtcb/8RRtZFDHZ1rqqDx?=
 =?us-ascii?Q?+hocu8o95P6yLBsff82vqXLxoS+3hLNvY0cNlzkqhqxwRI7J6R84TqvWgDFW?=
 =?us-ascii?Q?Pk+k0E/fj5QD8wLl7G0n/o2QymkMy/A+6AQvRNf1iwFTGvuCe/nJ048IEwmX?=
 =?us-ascii?Q?gFWoNLTBgFiOY/+2v2ztstK+Yqt1Qms84q4EQpdv327nZtORwILVzzsCXoIC?=
 =?us-ascii?Q?kpA1WX5ySch1SZnHJjkO1QchimPHVfTf2fSc18BTYC8a6ayQI0DPjhPsoxEc?=
 =?us-ascii?Q?99Q9a+Bg9QS2yt9gpxeNOLiJHPQQZ2AHkGmK9etLyzvj/wcGOtPbkcdRlgrR?=
 =?us-ascii?Q?39Zsf2HNeVqFb2YeIlIQBJvy3YXQoY3LbMK1C3cprmNf2nw6bVLzAE7wC7mq?=
 =?us-ascii?Q?xJOvU7/4xMQDf2QJ6CZhhLEYBLUgBFPDTS2/3sug6DCjxdepiaSZ8NMnJa/p?=
 =?us-ascii?Q?6wyN4wwKX6S0+nU19RdmdcRazWPmcdzcYedeIZf+N+MDdP9fDYTOPpzF78PT?=
 =?us-ascii?Q?3ziWcHs8VHQtZ7J4BShqK5jJXUUwpFApxu1IEKTSKZi++leT65Y4Tuckq71i?=
 =?us-ascii?Q?yqz8G4bpzMfYZyCcmlKYeAZHmcerYQmtf+uyNJoZGK9lrZoMIQp82ZI4hGGa?=
 =?us-ascii?Q?kCH/feTSjIlp5q82PI4qDkhR7KAQ+1B8W7CRj7qwEJz79uc6oij7JYuExCFi?=
 =?us-ascii?Q?jaz+CIRSeenz/QBIpigMO1dY/kH1ygCXFOkfssmH2ZwVVpokwjNut9Aozdsp?=
 =?us-ascii?Q?GL4jajOKjsxiLokXVcgqgoXu9COEc3Lz84k31sMldZ7Y2l60vOiAojQu8H62?=
 =?us-ascii?Q?M3GoIRtmAYCMBbgUfTQXgVpjhtV/uFfjBjq+vyusjRitCiA97DZJDNiJO57R?=
 =?us-ascii?Q?5CzERNAcWRPap5IiTryXtJZySw3Oin8+ARL7xpme4TAvlW6vfHllAvRtFgEc?=
 =?us-ascii?Q?JOuqW6siw+rXOD6+4SblVa7UJed02N4Me8wzBLdx2NFPnL2GJTuXrgv3ImM0?=
 =?us-ascii?Q?bSxGktBzgwrxsyp7/HYGJSfDiMURABuRpXz4nAFXBRH73vx1FLXjnm7ZB0mP?=
 =?us-ascii?Q?TQ2uRCj4XpBdNk7pPQ9Sbxx/drV6zk0X8jm9astZoVlggklpQIXjDc6S7wSq?=
 =?us-ascii?Q?z9Sa+Cimrpuj2qLrxgafzFwAV6IZzhvJthG0KYBRMC5VeSX4qVbnk6cJSq6T?=
 =?us-ascii?Q?zjq5BYlS4yihOLc88EudMMomZlKsSxTte1RIa05S/zRehuB0sRit8US4LBPE?=
 =?us-ascii?Q?RJVxXUrq2mvVg3mxcVJauGJNHvr1oHCMlSzAXDQEYX8wrTNbh6hqV0BDcQ3i?=
 =?us-ascii?Q?ZBoXoU4h2Qxn5Pwov47ZyWZpqvWgqOXQ+AWeFieVnUZ0+/s3lUTcG0cUk1ig?=
 =?us-ascii?Q?hla2LhG8bXlkaBd7EPr6WE7hx3LCFkAV2fuyIFyFzGs8UmfkbcnvHAMb7c6A?=
 =?us-ascii?Q?wCLX1jB+inPGz5kFqNU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f57e2-39fc-4645-48fb-08da6a972bb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 21:31:13.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO/XoPUQTTB2uV80xgypaculIhP3AUuAouvYQPhWE5RMMzTNH9lXVL949yoxKCYJ/BWdkXKA3su6Q4loM77x5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

imx mu support generate irq by write a register.
provide msi controller support so other driver
can use it by standard msi interface.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
new file mode 100644
index 0000000000000..e125294243af3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Messaging Unit (MU) work as msi controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The Messaging Unit module enables two processors within the SoC to
+  communicate and coordinate by passing messages (e.g. data, status
+  and control) through the MU interface. The MU also provides the ability
+  for one processor to signal the other processor using interrupts.
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
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: a
+      - const: b
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: a
+      - const: b
+
+  interrupt-controller: true
+
+  msi-controller: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - msi-controller
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    lsio_mu12: msi-controller@5d270000 {
+        compatible = "fsl,imx6sx-mu-msi";
+        msi-controller;
+        interrupt-controller;
+        reg = <0x5d270000 0x10000>,     /* A side */
+              <0x5d300000 0x10000>;     /* B side */
+        reg-names = "a", "b";
+        interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd IMX_SC_R_MU_12A>,
+                        <&pd IMX_SC_R_MU_12B>;
+        power-domain-names = "a", "b";
+    };
-- 
2.35.1

