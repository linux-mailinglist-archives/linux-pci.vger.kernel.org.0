Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7A56AD22
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiGGVDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiGGVDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 17:03:17 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051F205E7;
        Thu,  7 Jul 2022 14:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSfHtV2zoXF55EEGUGf4eVUNYEHJ8/6ywufzVZ4anmMUZE/MH9uVf9soxVPGWGWbhVS08WlK9Lka1GQJNuoa+bUAq2f6YKPkoDAbf/KxOQcCdWWd5lBFInSXy1NZqPccDj06KjFKWCsEhyqaGSH9WbZYrwEtlWYr/zfZsUu00hEO4lH9m+9xaNExlmrpK8jzNCQCKL2hEMcbvMukce6hiDuPN78SNhNHIabrdV8iQsVdk+B7R7weYQqTZRfGMygez/HXuecIrfn6KVECDmIZNMqEqTpejqSbMNJDp5EuSQPOyX+88/dCgOxClE9Dd9ieJ5h0xIHv6mIqG1Y0C5ZrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA+n7rUp/El5drWCneXxuuoPmuM92glV8PTouRgokqk=;
 b=cYUILDvpmqDf8JTYUHO47Nvl7LuHQ2B35zxKKo/2HBBEg7gI8UtJB1NlDiuZkKwxefT8jpqfnO30YD2PBR7koJjsOs8/sY8A8KQow5WKaflk2fDUrUHMu9G9FJmMBaPO79qMC+Wmn3QboHBqcA8qg7WQFHHILbUcqEy2EedACI8hCU9KsiLHSSgCbBVEDoapdQth7Rw0/XBfwrSwRoR6CpeMZyhkPynnk8/v+5mLQz4LgJckTTFHlkDeeS1VPpgBX4LU4sQlDUyG6nOQ/cJSrKyzmbKF7ifGHHMxwEFaXlZuMm+gvCgJngyr+18NsKyOLmOSJVraW2+2VWZS6XogKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA+n7rUp/El5drWCneXxuuoPmuM92glV8PTouRgokqk=;
 b=iMWhwP2Bb+sF+gq/Q+imtMD//1epNzsPBlCn/rhJXBP6VlYBSsCF70Vno5c7jkPLO9+65RtamcTHRLpa4pUpfWVj9gPIkGHX+Zp9ZV230WbHuM3eXgODXlqqP4SYxWp2M0h3VwjjrCo8CMKMb5wVjoxvsgPn/dglB2zDwiIAU44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 21:03:15 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e%6]) with mapi id 15.20.5395.020; Thu, 7 Jul 2022
 21:03:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi controller
Date:   Thu,  7 Jul 2022 16:02:37 -0500
Message-Id: <20220707210238.917477-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707210238.917477-1-Frank.Li@nxp.com>
References: <20220707210238.917477-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4907db8c-5e64-45d1-19bf-08da605c1c1a
X-MS-TrafficTypeDiagnostic: DBBPR04MB7817:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D60+Qxiy9EtV/Dc/PIz4nyKaHoUjufguYfWdpC9PERV7KnTZvC0bg4tJD31btyiws/jj2lDmiXcQWNR+0kkyTTIAeleE4X3ZBJbPRYU9yNLILI9zHpSyEe1SlkH0eaBqIA6QumKTnxESbOTO2wvP2Iq75T6nHFaqEfwRUFXgcNzQH3RGjFYuD/r1vD3EvFO/qphVHOOUFIVZcnxbA+HYq5c6edfLhVtmHifO9JuyolO/EXwnIud9qFY4glEV0EEYwy1AF8d78E+x+waiOZmc/pjhw/COfkjdJK1RF9EaUhXo5JMEFgx9O+MXGzXm2TbX6+iIMBTbARZnkZvdh8K/YY44cfnX2gDI65kpvuvUMrHWUMJZH2urpEV0UY+x9NqFMhoY+xFZ8YN95pLHOe46YJktMAJVxWpOcC365VS8jLx3Bu/LaewRkn/ncZMlcucFOdAiFBjClrCns7oPYjwmFbbg/K6IUkKa5KHk0UtiRYAt1lu0NgAyTaKcJYYb6vLn7w1zMKbNmcup5w8wbvjltOPGSLL2CjyOSUW1Upz9OWly67+uv4UZ3He4+MqfiAprNaslzuRFyz0nSzEVf+84cURiq5QugxZ7w2sqAr00tPgGJGKpHf1C05NAj7IHmto+UmVspp5FpHR/0UegE3z0bgFynwAPh9JIhsyFwApWnAcVdI5w+wobw0MQNquJiNAnSblei/TMD/Ji5AMY0w5wYPYW8+/W4Ndn8fKrVxUV3iJNHmUq5zgRmrDZ+Wj3Pus2vm11k/UtojQ83COCXZ75StqfVVo3v/nXb0S98cApXPSvu+L6USbmNpFfgZWiMrP5zvjCbkFm+xla+OEFSwTnJL4QW49Fcp+mBGRIGetg3ulXU7BUzBFHFwovZyjdeV1pvx+80t5myXeukq/rZCjusA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(38100700002)(6512007)(38350700002)(186003)(66946007)(66476007)(66556008)(4326008)(8676002)(5660300002)(316002)(921005)(83380400001)(36756003)(2906002)(2616005)(6486002)(8936002)(966005)(478600001)(41300700001)(6506007)(86362001)(6666004)(52116002)(26005)(1076003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATvPVpyZxyy0NtoAQUjFmNead7YXG0dySPN9+CtAkUnM56FIM2Pi7j1+sbdV?=
 =?us-ascii?Q?ed7IvC+CSgE5iKQjrGmkLUnVVVhZZa2VnWjUTZqNlM0VTRahB87Vs1op0ZP9?=
 =?us-ascii?Q?+yczF/h1hTRdb6UkmTgwkL6WdLENMgtGJ+LdTXIH8sfUsIv6wGND3JpA4aDH?=
 =?us-ascii?Q?ezrESdCfnbu/OZejCS/O+7AEVdZz6PlU4am+eh97GcAOeIvXsBzYhbXqVjBa?=
 =?us-ascii?Q?1pvZrUn4IVpHNlPimgzIoONsSzpIWJnh0O2JLRUC5PBv2IPowR+0SXHyk0N+?=
 =?us-ascii?Q?OMyO0SI2MVX8ye5z8BSgQeU9WmBErUMHD7O6ZDOpZfW70Q4y3phzDkz2ClVI?=
 =?us-ascii?Q?xm7UfNQjL/L5gPuern2WFysu5k8aLtkBIvQafBYeq/RDg/TgetbeffJ/xzlc?=
 =?us-ascii?Q?ziksFn58fECcs9T/t5VoOr1yUVdK9qNDC3EzjJ1RKkJSCLAmkBGTRhn5LvtV?=
 =?us-ascii?Q?9Y+MmappXYvx3aAOt/85Y4qucSiikcV+HDQgQ4hnHnJcTvO89tXY7FFgtg5F?=
 =?us-ascii?Q?2Mk7aRxjZ/XIUV+t09LUX5rcywe08KcaRgBCnrHtZhdHTui3BIGHRLh2JrF7?=
 =?us-ascii?Q?x/SzsXKItI3RTf+zSTX1lgTViDwbtnIvGeksmC1h4XIYiAVmmeP65lZszZZ4?=
 =?us-ascii?Q?jdixMY6l4V7IQQmnaeGI8XUet71FNL1dhsHNZ/EE5fOkA2LHrYo1C2XvkHyy?=
 =?us-ascii?Q?eyPrcpwn7FNfp03y8JE2CrSyB5jaxpoclv0dTwmWLU8iPjVx04SHjgJB4GJd?=
 =?us-ascii?Q?7On/nxutgiAJJ7+7hTdVGy651hmx/7oYlbCUqyycvGatS0XB23Q1MZFgtC3t?=
 =?us-ascii?Q?iZkhDqBwj8nwtBm85nFjI3Wcs1SKIH0xdipkkt4ze6cvG6A8OMBgDXs20Pl7?=
 =?us-ascii?Q?S4SqQZxJeyB9DzQGdJtkklz0wE2rMZs9NYrUYgSv6I7kNqSqRpxL9dhYMsQ9?=
 =?us-ascii?Q?DjCSM3qyFp/FFhFJo6fEvQF+JGe3aP1WJg8g6Lin5bxG84HAENxCkNJP7Ekz?=
 =?us-ascii?Q?ekx1DG1tPtHCF82xB+7pJ2Xpl9xjSM6eLmVQSXBWgApVI6qNeUwrimSR8Kk3?=
 =?us-ascii?Q?3l+x0KZYCx7CWWxm8Sl+XJ5gh8roc/5R2ZFab43FU+hcjGIHvqHnC/890slS?=
 =?us-ascii?Q?PgrzuWjGPhNZgbtS4q/SqtBz/CxKdSGpNau2XUnhB2MV18YIVL7ihODhCed0?=
 =?us-ascii?Q?ongatb3MuAmyyXt6sNyjgSoQr6m4CAVWqZnEwILpgCvdKkDWnHLOFcD+A69P?=
 =?us-ascii?Q?Gzv1b8YhTI6W+pZyYyomjDE8YpXXJOeBuRswgP1L4jyE7WLNcaP9Tq58ROtz?=
 =?us-ascii?Q?Fm/PySi5sA7mPzr4hQ3i44MSNHp1a9uf8CTsRIuBF6L5x8tHrna9R1eqYaNX?=
 =?us-ascii?Q?JVJ7u6Fe7pSH+CYInFGQnkXTyIBhXNRTjKHxLmf4CaDxhNbeiHC5yCSP0pRm?=
 =?us-ascii?Q?pQj+95gTzFt3DHyqNooBQp+7gzzDDa5Cpx1CUOeYeiXIa7+Xe7m6gkZOj8gn?=
 =?us-ascii?Q?Cb84gUzNRjYPc+sbCfDVflPzs10oX+XAPBiCoNReVmJDx4FdZHUywMmwL6y8?=
 =?us-ascii?Q?N8iASiEg/xNflRjfPq12CRxyzyWpaU7rEorDflnW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4907db8c-5e64-45d1-19bf-08da605c1c1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:03:15.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/91LlErXqWCTNXJKBAvWuFjPfbo76SzceLhucyNO7X5qRdQF307X9fiatldpNmhoDxTFJVgjBCbqijNKBGzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../interrupt-controller/fsl,mu-msi.yaml      | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
new file mode 100644
index 0000000000000..b4ac583f60227
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Messaging Unit (MU)
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
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx6sx-mu-msi
+      - const: fsl,imx7ulp-mu-msi
+      - const: fsl,imx8ulp-mu-msi
+      - const: fsl,imx8-mu-msi
+      - const: fsl,imx8ulp-mu-msi-s4
+      - items:
+          - const: fsl,imx8ulp-mu-msi
+      - items:
+          - enum:
+              - fsl,imx7s-mu-msi
+              - fsl,imx8mq-mu-msi
+              - fsl,imx8mm-mu-msi
+              - fsl,imx8mn-mu-msi
+              - fsl,imx8mp-mu-msi
+              - fsl,imx8qm-mu-msi
+              - fsl,imx8qxp-mu-msi
+          - const: fsl,imx6sx-mu-msi
+      - description: MU work as msi controller
+        items:
+          - enum:
+              - fsl,imx8qm-mu-msi
+              - fsl,imx8qxp-mu-msi
+          - const: fsl,imx6sx-mu-msi
+  reg:
+    maxItems: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: tx
+      - const: rx
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - msi-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lsio_mu12: msi@5d270000 {
+               compatible = "fsl,imx6sx-mu-msi-db";
+               msi-controller;
+               interrupt-controller;
+               reg = <0x5d270000 0x10000>,     /* A side */
+                     <0x5d300000 0x10000>;     /* B side */
+               reg-names = "a", "b";
+               interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+               power-domains = <&pd IMX_SC_R_MU_12A>,
+                               <&pd IMX_SC_R_MU_12B>;
+               power-domain-names = "a", "b";
+    };
-- 
2.35.1

