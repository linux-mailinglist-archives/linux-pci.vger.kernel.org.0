Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF545AF49B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 21:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIFTlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiIFTle (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 15:41:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE980F69;
        Tue,  6 Sep 2022 12:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsKVIkbBXLxIOv3Bx8qJGqCzYtCTmLqbqQluxCfzAntm5rTBVLkhYMViuARQThhJnZ7zFp6L+LEgsEutej9gyF35MjEcyl7EE7Qy8uyHj1nTtJwrKJPjNKZNTlxoYwRBM5JhibAytz2OMFQW79kJ0Uqav1/t1mJXjEea8WomfZI6+dvOlGSmarqzW2a9GoGVZaEBLHK+ERhZ7LTIBvN4hyWuR53FZPzeF36/cNv2vLh5p9aM9kc4lf7hNQlQKBmBO+N9LOe/P6iayTXpXefNgCwLzKlqJZ1yfS+x/86JcxK41Scnyo4JW55gXLtA67bconN1DEamoClgxJzQtNTTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlNYDELcqtaOO3+2tamAaCCPR1txHEHqQqFIr51Iutk=;
 b=oeVoeXpmXoq4FZ9y6bM028fcD9fcjhn0PgBMyGT9a9G7yhJbYm43j0QOlT8fm9eKq2Z0Mpx7w0/tdBQxcWd1Zqn5rVSRD+DXHHe93OsPWvNu105Ly7XafYnIej1PC30zaWvILArUI7qCwgJ7MLdDANRNAC7Sn8t9b/jMMYb3ZCQk5kwYHd6Xd7Crcn7MgCfyytPsIcV52NABORQzQfEH3qeB3ox3W1YPrwNdQlZdFx33xhYm5WFV/0ub0NfGUTR8VO+8rP0UBDuytKsyiQW89XOPNgAWnisV/md6gCcVG0UpoZa0OjSh8NWem0hEpH2DdAIfCoCG/9Bv6vAmPrZdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlNYDELcqtaOO3+2tamAaCCPR1txHEHqQqFIr51Iutk=;
 b=NflKiMKyVBhHuEgsHlixhFk8ZLPTd+S01/zkaqLaM957kOEr7UvEDEkecj9eSkGGfJoYuvBuY8AtUInxN/KoqgHVnGLJKR1S5lJszXq/kR+W+wBFK3UQbnkCxYSa47tcK8olPm8VUj14HDZiovP5Zutdq+jorLtFL8H3MDty1Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DB6PR0401MB2358.eurprd04.prod.outlook.com (2603:10a6:4:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 19:41:30 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Tue, 6 Sep 2022
 19:41:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev
Subject: [PATCH v8 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Tue,  6 Sep 2022 14:40:51 -0500
Message-Id: <20220906194052.3079599-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906194052.3079599-1-Frank.Li@nxp.com>
References: <20220906194052.3079599-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|DB6PR0401MB2358:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6de411-a621-4959-3b87-08da903fcbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C54gCqL9gLGZovVz1nAGfXhkgconW6WDyqYwIO0hJig+9hXYJJGuOLsaVZAFdZ8t4Hmh+FlRs3Cn22pXO1Zh1SEimtqZ2hwG2B7n0KZbL2otvphcVK2v5l+Ww4yW2p7M6I6Gy4hTk0ZWLTwdalKTHbq+arnECj3/6rY7FeHSfduZira/p0CD6vAfiXGQK12kgqjwSq3+GBWq+AfmG/AuX6eC52Y4wLTzRKxdznebAuhYwBslq/ekcgg5QXfqGT9gS4qtzGSFiVWAqc+bNrOjdyyZwVIhdFB2rxV7PnJ2DJTNx5bDOmfvsLas3hobN9oxfNDZ12evF2U4T4rAZzD4e63yYB2dh0rGipy6Z0dSCOo6NofYtZOQTSVefZ9SfpuVnOxvNEOnOq7nYdPwMv7BSWZQF60Nj+m0sqopJPCVRlp2Lv36f1P82fvqssp7ekUX3rp5wzcYCEVN78xkeIVhBXp7Pl70gX5mmbCrzbPZcSiso1oZy5Et1j4dLvbGhbUTnIcIQNUptELl23fKrGDBWd6wozPXRia1KBr1VKqsncfiZGUAVr5WA/Zb5quay1iYkaImaa8PNBeMoWI7xt+Vk6A3r3GwVRB3FkcLMMHF54c6X1OLQzjGgLzJrfR4dhy1Ygef5PQCy3MEB2UZzyH7YmfrmJSomVj9lsu1fEpthNLwGdfjc4Cb2QYKOQxTrVo4IiaKLplbVYMhFc7fTcAjrTSx8tf9U3OO1eThwWykyga3g4Ngn/Cuip1q3HWCo/rpBwxAd9pp+xibiZQkoGNaZ79HCABTVZVtz2rHZIWy1yXjfx3gjBv19sxnXaDI9wpGPtBgjTeWPgTAfu/v/mGOzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(41300700001)(52116002)(26005)(6512007)(6506007)(6666004)(966005)(6486002)(478600001)(83380400001)(2616005)(186003)(1076003)(2906002)(7416002)(8936002)(5660300002)(66476007)(66946007)(4326008)(8676002)(66556008)(38350700002)(316002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jWeRMoZcLw9fBv945VZbf6Z0ToCIcoWlAoBXYm8ofCYUPPD/swVbHHH62T22?=
 =?us-ascii?Q?19l1FJgNSI4N3TI7WrYOCpFjQv5Db/5aFDPn8g9Gj43+zOYh8zglcdSZj8YV?=
 =?us-ascii?Q?a5hnb0b6Zpqfl95qM4tLCHxxitLji9HyJWXn9wMRjBeLIT3l0FmxxDwBQu8Y?=
 =?us-ascii?Q?5bGHo7XHUDRYK6DtUivTv/5sYYIw+70gn6BIkmO4wPxggboRDX/pEnQPEJuT?=
 =?us-ascii?Q?xRZcn6NVgn1N8XUSxdoxZ3V9Xizi9p5x7Y3jOYyrXzG7WdvuuGF2ZTOWda7c?=
 =?us-ascii?Q?nVez4HYW7J60hhlTism/uEI2knP1vcnp7kAyT4hQ7K615w9RgBl5NLQkvb3z?=
 =?us-ascii?Q?on49dZuHmhFJaw0eBe6sa5o1JStCC6k2oZztTAY6SCdlGNrvtRq3IJhGuCOZ?=
 =?us-ascii?Q?A0uts3NArxPgK22t6BbFkzYu/xR4bMUZDeUjwi4dhGgc3mb0w7o/BR7VEt89?=
 =?us-ascii?Q?kwSJkYCRNDbPrZWIE4r2CBGaiMeEtq+z7/QnO/eu3tfZrkzLUhlqDupaNesA?=
 =?us-ascii?Q?oNyEuZtLfHmwQsZWKuofboF7ElxAZleyKzSCa97p3LpmDMa41YXINXMwG2gI?=
 =?us-ascii?Q?qDRA65sn/yZuTSP7ZctAlkBVSONU3445xW8BiJpItgyQe6dml6RxtXSCb4KD?=
 =?us-ascii?Q?2yAvM1a8vht6M9ZD2sfna105czZ08Dag87oZkOBuBTugNubwhKMhYakHC+b2?=
 =?us-ascii?Q?Q3Y9A25P7xrH6UITK6/xG5Vh5Jpo2xN1uxZ3Fal/UACdECN2j7WNRVAxcpvo?=
 =?us-ascii?Q?2+gfeW6VrMFl38tAmL/E6OGjQ1KNP8moeR4q7LVQF3qNEgXKDTmhRP4hQMBr?=
 =?us-ascii?Q?KH9DKE+uJESf4qfClSU4nBJBbifN7etFoIFE8DR7KWoPKymVKgtbeH1Z6RRc?=
 =?us-ascii?Q?mf/sIo2FvUQTydTIbnKHpHQBc05GtNHDhPGQU/S3PEZgL55GZQfHvfsnS44n?=
 =?us-ascii?Q?1VHHlkuuS/tVzyP7lEM70FuUa+f+8NWEjEMniQy2QX+HubKj2prZRut5kAjN?=
 =?us-ascii?Q?gmyOVH56hXHQqiQqAGHhh/bUGJCrq1qgl7vK+JT8fBk2jgDqFuh+rD5LsbZy?=
 =?us-ascii?Q?CWS/IAbApQo71jHiksMDpOHU5FSBU3k2+c2nyGbTi9iBExrZXxPhdeRqQtTX?=
 =?us-ascii?Q?1Dw+sHyCUDLzA3JNcLgbM3ZpFbaNU2n6CEKWwLsb9LpfCOTRLjDWsjNnRXbY?=
 =?us-ascii?Q?lDh6phFnABV+mvKHO4Vw8YpzGK5jkVXTHW+gBPCZKjSsiUVkDXcmwyEOAhVL?=
 =?us-ascii?Q?SA7j4pDkC2DPd4HPI4q8D5F/+1mbC8yEwZ8dmDRlICH1fmDG36AXHZOVAD5z?=
 =?us-ascii?Q?sODI9xUtUz9M4gjtAn3EXf603JEXxcncPWmuwYYf8jawpDb4GZtGs8Io/cLW?=
 =?us-ascii?Q?JoN7rfHMKDu2GWvthSJS/6MjM1awlfk/uutd2MxqNreDudZensONStIr0NXs?=
 =?us-ascii?Q?9KVjATM0ja9YS87MWeSdB3zmfkxsSR+g3pqBowXRAM8J3EFRvK6gEVFZy8Og?=
 =?us-ascii?Q?ZnMRb3HxPmSNuFazn/d5ITcJOvKWg02ylrVRNeb//J3q7CCfNByFAhq5jsXm?=
 =?us-ascii?Q?T+AV57hZRzau0OIBS6RLmVaVbnGJ8FSCnH1N1cFA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6de411-a621-4959-3b87-08da903fcbc1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:41:30.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Il9rQo/N0hn9eYIk6ZpVFFqH+WqFNlS9I0EY9WUtd4Yn2jWFlJXU3U4wODfKeoV3U/EdnB9bHY4MfbjDcGa0Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2358
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
 .../interrupt-controller/fsl,mu-msi.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
new file mode 100644
index 0000000000000..5466bd19b703c
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
+        reg-names = "processor a-facing", "processor b-facing";
+        interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd IMX_SC_R_MU_12A>,
+                        <&pd IMX_SC_R_MU_12B>;
+        power-domain-names = "processor a-facing", "processor b-facing";
+    };
-- 
2.35.1

