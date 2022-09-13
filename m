Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D35B7C8D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiIMVK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIMVKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:10:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471B75CD8;
        Tue, 13 Sep 2022 14:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2yuU8M+DogTg6c000HEHWQkdWmvqGFtZdflQp2qFljxJKf986WPNFa0V8FMvmTzMGQhCSqR3P6q8nEJW1/sqX0JF7Z40SumUH68KPOtCT+rararoASEzzIiA3FmyqFahhAcWf50oAul2sfBamgLLe8/umiaJF6a4c2QQNe/nHVNw5u4c4mGuY4jQ3D3YnLoRGcYj44CJ2siZLnopBCpC4TQ4mQcZZyL4xpot+60bfAV6k+gcZtIVv8pqQrNXU1wPSmTjQaQ0z1AemcYbsiDjl0mwsZqVYRAglT3GEfg1kjPB//qN+cC6QBjklC4XsrjEMRhrddld6bqP0217bKiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ankBqv4m+mipQUAqC6qml7eN2IMIGbUtiVkPxPMXbW0=;
 b=StieEtaLG8W24nMLhS3DoZoyo9Me8VA7RpzB3teODmsFRmrU4ek1TCxciG9PVTZcVt3SAFSmpPj8BYwJvr+t0u66Ls59yregvh/bNM74nTPvSPfJqFlzuB263rXZL9NMbwvAMUf2PoE8ivIKIXv1Fw6npKLVeat7fGIwPQ0TvsmiFEPQwoz+DUvZv4Ntq/ejlQUuvWNU71LLkoYZ+tBDcIibqjCE10irTlW22wgwEUTJ/fU8TtgmdOqk/+hYlWuxmayyQrL9QtqqyoTx31y5S3CjeXdL1ZVhRiNfwo3rufn02HSTcN4tkxhbgwQ0VvkPaCruZ0QsNurUOClR2uNjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ankBqv4m+mipQUAqC6qml7eN2IMIGbUtiVkPxPMXbW0=;
 b=kmaJaP6lSogrwnWfVEg9J7XWVLh9b/dv90ooingyryjMb+2zImgRp0njXDhNx1WYW19h1Q+psjI5euT5QQ7aKbYa24VC2uY8GKwsTNzRudE7f5jlk99QSXfyt9DyhbVbRDXuU9HAX7xV5ZIrwhovyhnC+yMGVi8xJPexsVnxa+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:10:39 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:10:39 +0000
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
Subject: [PATCH v10 4/6] dt-bindings: irqchip: imx mu work as msi controller
Date:   Tue, 13 Sep 2022 16:09:55 -0500
Message-Id: <20220913210957.3493826-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913210957.3493826-1-Frank.Li@nxp.com>
References: <20220913210957.3493826-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 26916e9b-f769-4438-7140-08da95cc68ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8oom0MPteWC4W0cFui33wJzhy8liPIARMMyL9Iq8SwGPbqOMs5p6zPzrQCZ03Qp7pfjr2fv243QeoSrR/QsZVLTY3qohcGYL0O1XCb5O1P0nggRvHcb9CmTzyh4+GhhSDTkk2uCur1VAVJ3/6mwEAoXqyaONjXw6sE3FUxbw6BLeqizNIT46tcUDPjVrvmmY8OjwJIYDWSLl/2rUTlmG6amtF8AnWiJn8y81CQocQKFyztkJVrz2AERRN5LsnvMWsyoL/5AcVQhZTZke+zbzrs7fkT2n6oOmzP+z2z1WCJaKRKgL9/KVngF6FhnLd2iNU/Gc0tqVHymzsxQ8UgIQnyHB91nZ3oM528JmwMnIb8UbjMSAR0O55S7Jn49mw3WOok8x1X7tpbiKTxC+KkM42siWecXcHLYQH3lyoiiIbnyT2LwcH5cxhHNVvOFOI8NMGCDFi2auXmBjsgtuW1Y4G2AcYsR/MDQDVgqDUNiFN7GyZzDF7VWxZq6+ygaAx6ie2Evz2UBJDWSuFYN2ZmIZIhGFINV7WuvIHpU8sZSksqBN6eAYLLPvZlHsrrpvLDOXPozGPJmYXQrC+XuTnL7G1eKZzsaqtTMmwbTAWg/qzyW2ubspAw4dBlsmU1jK/wGR4re7lcSuv/LUBjxDCnwxxstgaWdSm0fmyEf3ozfImylUOBod20CD3LnS54yffWwwV0ZS1oecyNvGZ5DWoSYxUgkVeZizoeT/eScJd8FR83mmFG4rb6zq4QSPdXt06h4QZyFCf+NbPrquoVtDmej8Qhu1MTwwKp1jOn/cdF1vlVi56cZv5P9Y+KAcPcX9uV+k3+YywTaGM1t4KkxRupLlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(38100700002)(478600001)(316002)(966005)(83380400001)(36756003)(8676002)(66556008)(2906002)(26005)(52116002)(2616005)(6486002)(66476007)(66946007)(6512007)(86362001)(6506007)(4326008)(41300700001)(7416002)(38350700002)(6666004)(8936002)(5660300002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkfxyyNVnygalxNdrMCM7IoiyRk/1xihwGkL/jBN8BL5+KR8hTlUU7iBH13B?=
 =?us-ascii?Q?ziz+FeQk2uouYwxg09BskubE6d6sU6Nkm9DJA3VViWbgh+z+XExxbiebF9kJ?=
 =?us-ascii?Q?98p1AcFIATmAgVNdDTtumWZhSS2AOATC9dQvXuLcEOBxwM5HR38f0+QYmcnV?=
 =?us-ascii?Q?q9LCGM+b8bohSiTtAPHqJ4gJY3zaBd/yFiJwDsFRyiewfl0OFsW3nyZKjDJ2?=
 =?us-ascii?Q?yHCFgjHc4UV9fLcg4PZt0+sRuue+Qm7jNtqh8gm3aiafDmVjH9XDBfCz1Qh/?=
 =?us-ascii?Q?CEQMc6CHfS1vu3MU+s0GxfN9ataHm0mZO7BsJIJWlnIOQo1gecCX9zT9XWe7?=
 =?us-ascii?Q?oo996+RwiVjb9WfAGmuCQGLcHdb3r6HV3RiVOkcja1OG1FRutZ4PmmkgzctW?=
 =?us-ascii?Q?DVf6G3Uw6gLz54z0WTYIHHztRM4/0KLHkpqP4XAfkRzj830S6SLzKgDVz0tT?=
 =?us-ascii?Q?4TDrOwVNtZ+Z1E+ir5lxCn4btp6qqtfSvfiwWpZKDjWm2vWSSVHPkUroUFET?=
 =?us-ascii?Q?TsZE7gxXep3ZvpF5tMLasFx7kqYJHejG5OdT4G2ujo1ETUU3q8L95jCNbcUV?=
 =?us-ascii?Q?+OL03XHh/DwbRww8GsJ8mn/AjRQAxNH+orRVDFZcHSL3/RMUviAD3Wou56UZ?=
 =?us-ascii?Q?meAaKrDmaBuBPlZoOEjYUFLrMwqTDEfbkIKT79aKS8E3EAfRGZfwYtN5owfb?=
 =?us-ascii?Q?gb8Q4OnxRzfYrP24IAgYzpTO/YUTtyYhr3h/bbD1zfsYG9nMcgEtr7erIGQH?=
 =?us-ascii?Q?LnNEklUvt0dbCvqNqhkTaYcZPn5qIIfKuIevh9L9J4Nvgdm4iJjiGNNJ9J5f?=
 =?us-ascii?Q?3ktyyTuU92QZgh3YLkGDJTKYFiOtpJQJV3MlUrOPCQ6/JzOy2h5Xu6mOguxP?=
 =?us-ascii?Q?P3b/SWViUE5aXdC0W8Tt4JdXeeRPlXY9AOXoZtDP3TSuQwOkumFA7hZynFjw?=
 =?us-ascii?Q?xT11uWLqXmVG529TcuG+/PSAwc/JvGUU57Bwj9K0hQYl8gmj6luqNDlpCZMJ?=
 =?us-ascii?Q?A1EbngAkyplYUwzYdDtxC1GLK+ZxFF7FQwzdVvI4BErtbhGs/34sTql3N0Nh?=
 =?us-ascii?Q?Ut6ipsEH7JNLetFiVj85T0m+L/jQGy4q+luIF429HpZxwH33oT9/Lo8yudh4?=
 =?us-ascii?Q?retGAXyvzzjGsSwqOLT/qsA/RyOkVv36LX5GgLsXBti4Cu0FXtba8x6dhm+x?=
 =?us-ascii?Q?SSLneVYN5omN56ld1z7RVhQFyLdUcR5ESqWC6XBzOUZ0MLvqF55MFAEY29Dk?=
 =?us-ascii?Q?A9Qsww13eBQphvn2eGn9Lit0szecIr0767TwqdWPJHKHfvCUSst1YnSk0Ebl?=
 =?us-ascii?Q?PF0HyxJouF5Y68mIGy69tEKLQYagQ7EPuIk9eY7/O684z+PPt5dKkEJC6Hj3?=
 =?us-ascii?Q?3KxMdNlFS70s7m21YasehYyZ2Dz5X+rod3iablAg0pzj5eFzJgJq55Cfhd8K?=
 =?us-ascii?Q?S66s7qTs0Rtt+wMvnJ2PJGLq1UZFu+ckaz/NuUb3EE3Po6XYtR8MxGiJ0+pe?=
 =?us-ascii?Q?BJ4KdschqZvyiaSREFiLDsVwfOtAyGGrwjY/EYOqlVSyjz1bNAazGEh9aREt?=
 =?us-ascii?Q?guBl30lROP6anK2kb0U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26916e9b-f769-4438-7140-08da95cc68ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 21:10:39.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzeXLJ6tV9n60SwIUMFnZ9sjbQ731trD4R3oRSJFN/IpsBNuFlSDvjn7/yCKR02o9l/X75tltS8gFgdHeM1kAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621
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

