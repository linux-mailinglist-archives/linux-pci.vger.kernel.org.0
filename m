Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60659C370
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiHVPwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiHVPwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 11:52:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510AE2AE3B;
        Mon, 22 Aug 2022 08:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmfr4+G85vc0xUPX9eUfhHZxKhYyei9Wlf+tRRdNQtiARpq9fTLKnH1q5nANLYWZxJJaBmTWl8JiBmbc3K3ZmyBvSa497ossLM6C9S1QN3GdkcN4NWhCTl3wYQHVYH3BZ78n9gITArRTzmAdk0yAbKWZQcvv6JxQE23pvJQ7nT9fbcBNNXs5PDLNgxn+nYZ7+MBujP09/rFA6pK+0qiCdDVhlL/6Pg16EVaFWofmcYXuJXzU0qnj6DTlGKlrQtZhbZWnfyj5iQpc9wwYmeCiSSfbIc3pMOQegSwOdRQVc4xhnN/Jm4w6+Um1OGlUnB0wO4oalVZZN0uAhx4Bdx+/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVFJJkHBYbxdRZKhWWlDd3nZUmM3IMXu087up/Kc5H4=;
 b=VLRGrUXZ7cty8qLpQ58Lz1gxziefCx4L6CH0EpYL5kZUdP0Nu2pXGcbHW3EmiKTWZoSiYqaBP223jeSVtSlFCUrgFI+hT9JJ8zNMRGWqdG/YNo99+anIdJq30qg/XwKo7i8swQ4+6MMTZXse9mh6JawmnlOL2z6zQY415xz2MobFcIzrlC2cNJLhwtJYkTCfRRiPynKkM3WHmV49WuKA5ovXOUCnQ8dDf31BZ7iutpI8Ymxlw5X1A5t4nP4Tp6MvNz35+yTvgdrmu+4k76MmLDmr6+caNUHLwYVtKMes88XaHcfE27vXRC2wl1T6ryAiiJ+a5idy9y9m7nQ+nRML8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVFJJkHBYbxdRZKhWWlDd3nZUmM3IMXu087up/Kc5H4=;
 b=eVa5JAjvOO0BB62BQgwN4NAyFcjf5BkYH8blGf5dWuCbsGkl1YK/9k1w9Tpd5Jv4w47+zP5Y9VgVwB334ohr7K7sGbDvAYpPexUwpZC86r+CUU+4dw5Lybi2D/a3CP4ITXHSWN8jEmLgUiJ+uXdgEg44vbEEt8EDcqtaYrVPq3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR04MB3169.eurprd04.prod.outlook.com (2603:10a6:206:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:52:07 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 15:52:07 +0000
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
Subject: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Mon, 22 Aug 2022 10:51:29 -0500
Message-Id: <20220822155130.2491006-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822155130.2491006-1-Frank.Li@nxp.com>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::13) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3314034f-95f6-49fe-1d74-08da8456437f
X-MS-TrafficTypeDiagnostic: AM5PR04MB3169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2fk2sK9Zsl4lqOhu/BssTXok6U7OeVWdaPH003TsyRRkED+SslZiK1rx10THfXIuGx+dZUJG896z0YS6U9LGb32Z2fdw2J1Z8SeOZiys2sMupaq16PLY+lfshHkYN1zK/ri4DUys2FMLkOxNwhgdte+MU9MGouqkxLHcYlWdBT3I1YFg+GQCu5dfpgsgQLClrAdR1R0Mhl6BfKF+OGuqg/CBsrpcShgODh/f7HAQjzK2f7I8TpaMYCnAZ98IXYZk7XcRsybCeYvWU0IUWCF+RuIkFDwBx01KKR0ACcn/cCZgdOVR5yDyRc+zQFYJiWkevA9YA9sX0K1GQtSn7r0L5xLFrh9qXRqzNuvIuh1IsAn77u6Lik2ZKQ4J795xa4jtXqqM/lnK7VIRPj94yO60Ux4KPJBwyXHLvlzWpWiCJm2fdtFTIj5hWk3WqaCo59JSHY7nF6+g9hB17iftdgdslbgSuXqrK1vsHSDZrC0+adBoTGQBZTwVp2nfPmS2z4i7R5uCfVjzSompo3wI/ez0qPQqlNtIX4J7lYsbjvGxnu0+ylS91iryGWpCcQBy6ysvMyg4nmVYF8JcG+Gr0acUX/X/9up8CGCFXRcTqRPR9zSPQ3eSVyI6BWSWQCH257yTGkYmjhJz3jgFDbB3wQTa//0dyCucSlpLRVCH/G0OBBgga0KHV706u7BiJhz1piDWFOo/1RoQ+TEUYYfDoAwlXBzDnLfNPEEJHDjE1aExCKHLTfZIZz9YL2Db5rvI5TKk/nk3VNiTkBx6foRyUaXS5DfpUnNN/J6xn51iJ4YE/2L7PL+TAaLZVOwqFOA4yFPFeBVCAOcyD8W1PD7W/os9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(86362001)(38100700002)(38350700002)(36756003)(41300700001)(83380400001)(26005)(6506007)(52116002)(6666004)(6486002)(966005)(6512007)(478600001)(2906002)(66946007)(66556008)(66476007)(1076003)(8936002)(5660300002)(8676002)(7416002)(2616005)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84H4grMEkJG+fpT2ntU3P4Sv0xC5tuDizY3MLdPnq2ZFOzl4ZcpKq/pJSHwn?=
 =?us-ascii?Q?bG6j24HefVizEnU82uPSCw2VoVqUojSldk4oYHvTcIfHjaT9GbK5DwCSvbSo?=
 =?us-ascii?Q?lnR8V3cMla0jXqzN8fHhS2ukUaxKHmYx8/Y6pNMy9wD+j+bIsvQTMtkiYKpg?=
 =?us-ascii?Q?XBRuXy0rLoQ+Ga0Y2A/cpN9oDh12lxQkJPApuXks0vAqWxZCbmzamx7bUW5g?=
 =?us-ascii?Q?tSVBL2Ga7ntCvUtaFLS1mo1kttvy6hLozmkeO8Wpm2oSOQ8JoGn/QKzMyNjr?=
 =?us-ascii?Q?rl0C1UfVTkbJ4LZcKRoqy6PKmtlLTFW/axAu1AfmQwUrxPDLY4+PXSvjnulI?=
 =?us-ascii?Q?Vm8T336P8YvEdhdYnI+VCfwa6lEDfNPBq0YNAsr8x0HE56FtQtGFedsnHqAy?=
 =?us-ascii?Q?+VJ/UnBBu7UmLgczxsrjpTo+OZcm5PP0ymXSIkSY4ejS4eW2dliwqrRKrQ3Y?=
 =?us-ascii?Q?irHENDvhUv1yFp6tAxd8Aqevs+hX4IRKKGZP6C0DRGnKhZfXjei4sKJeNBJg?=
 =?us-ascii?Q?jqPD//7JhQVoASG2Ts9ZRDvqN/NvOBS9TBtMdbgK++KD9e0/Ai+aO5mhg4Hx?=
 =?us-ascii?Q?b3M4LC1Dri1wDNMdfDvmrawr3PJbPs1Co8eh5kfH3J2lk1isfd4RUT9bbBLY?=
 =?us-ascii?Q?t26ylRZ2ctKzVLUCbMD9ZdteBhu+OoilqPrWPmDH3TQEos2MSe9sGcxreCCV?=
 =?us-ascii?Q?3XhmFjfTS9nm+c6+mJmsjjt3GA9nOwf8tFF/+ZmLUZXLNep42A5dpCggSidE?=
 =?us-ascii?Q?EterIqh0sSD+7oHOpc+HVNyBbkA+52FScDOBtE+MmrFUrgAmnvIOkZGazZW7?=
 =?us-ascii?Q?gVHHbM+n/OPu606WlskLoY5kQE9cxMArlvEN8+WiV4+WzGJEW8PsjkJTS0pX?=
 =?us-ascii?Q?csrCLA5oox/ZGbGbq/RXJpX+c+EmiHkLIQR6Ja0ElyZKZGlkUZMMHSy5bksK?=
 =?us-ascii?Q?e8rNtYBg1+sFFeRK/7g3u6tbi8FDwP+zIJpYLHYU4+Yyshtv5Z2y5+8DKG0O?=
 =?us-ascii?Q?hUclwA4vNKppsJTB/kt3yp2GAPHTY4MnhA+cIvxjLuJAesCS9ktxKe9mw0vY?=
 =?us-ascii?Q?Fta3J44vrzWTr5HQPvAl41dxhSNJ5NiA1NLgbLZK9L5hxGzcd82EskmrLnid?=
 =?us-ascii?Q?bUPB/Fr7Y3M9VtX751xqUHKizGx0ojLAPqBHcuYSRnN03HGjow3CkB193idv?=
 =?us-ascii?Q?krvTNb+upToa0nlDbpGPiBoZ5X8SPccWr820LMT3LBBJ9IdM+Mih0zM1MafY?=
 =?us-ascii?Q?7iNymRtpvPca2RzOgqFFDszRryEt9M3mO6pP1YddAIfHjHT2A4JalUNt+RoM?=
 =?us-ascii?Q?uwDINOXLW1tHRtrI0cqKcr/WwjzwS1pEJrr33q7pbPNOQh4WKmhQCb2njgjb?=
 =?us-ascii?Q?I66nmsMXUiVgX7HHqbPM/pqhcvAMYERC3d3jlddojKe4kW7qcwduhtoG5jhg?=
 =?us-ascii?Q?OM1irDoGxbLBGxl54N+KL2674P5XtcuQAnK1YqN0PEu3Ih3ybZKsdVy9q5q9?=
 =?us-ascii?Q?qE6CKFyxdvbmYegOFuDIvhxjGYLIuHlNKEDoYIgkl/EfzHCTcag0+kWOB6sF?=
 =?us-ascii?Q?5o+j9Cc79CV2V0QI7XTwErg7C1hnU1Ps7VpJt9FA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3314034f-95f6-49fe-1d74-08da8456437f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:52:06.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zw6U8OVZVGWXjfcxMwRM7IiwDNEGuoL6mrc3BvJfOp5Oo3vU+/Y8Tf7zSDImaVzeZ97ya/AIlA/WPOVv8EnGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

