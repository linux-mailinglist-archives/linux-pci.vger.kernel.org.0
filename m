Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA75AFACE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 05:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIGDtn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 23:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIGDtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 23:49:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C49DFDB;
        Tue,  6 Sep 2022 20:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gq2gx/f5o4tSjC5iirGnflGsHSo8zKIC+3JHMu4kdT5KJQgC+BsCfiZogO2yJ5u9ze8wSDZ5yPhkcbCsFzh9KMCUiH6hz5d2foGxfLa+zGkMUt7VHKoAVPjmmt6eP6M12HKkjs8EDk3hjVxhCg+4BuwcOGQxnNrMdd+Il1XPumdwFl/BSgLltO9Rlws9EhZnTEUDQz99J6HHGu9aIO73phzg3Vsbr1tGkMGyAE8Ylm5gbKplViPL8w4C6yDs9nY9nt3eiVR3Fd95UuGQLQTpz4q3fOBJxwDRBpHDfdkkaVRBE0VJlyzwLRxv7LrQyYgWi2Xhzuph8w9pZvD1jBrFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hnO8mtkHx6It53X38fh7NPkLHDeKRrTi4AH+gFMxUY=;
 b=Kg08f+Xv+XXuj2gAKD7Yjo5qrMNwsGUnvZ9wKD+14L0pLtkZx4F8DrV7BlA3VnbO5NlQZFa05OHHmA69G+6MFNlidfrz8N6DLL5JHhsG4/hTVOVIP8m8iljLpoFjtnwbIQALEHJ27Lybnr0bJmCxqPFRBkjHg2JQIqA7obWmiqJw/GFhz/dDsV3B9ztNr3M4Nosyc2REs63QFh8mi1n/aha5cLOQO83jJj6gJShJuUESjSxLajS1Q1+vsISHi1M9b6MuNzUEGxJM0DFVVshJ8U4eSwmMbMgF2Kv1yl+YmzJrKPIRSgZSURbwID4rDyg1EbNljp4d9HwGSiY93mt8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hnO8mtkHx6It53X38fh7NPkLHDeKRrTi4AH+gFMxUY=;
 b=XhTX5P4T47HHo/Ghr+zt/hUqXBTkf+Wm4N23TlhndxiAWW+vS0UHEIfTVPWrLiPfkqPwxPq+V+Rbd9yQuEBq88sZjmsdwHC6KYMghj4aiHOuGzJvDLqY5XRprnD2jSInGAccFNcHYIZIiebd861oFAyrDnUVYTdFd+iBsYzxfos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 03:49:32 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 03:49:32 +0000
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
Subject: [PATCH v9 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Tue,  6 Sep 2022 22:48:55 -0500
Message-Id: <20220907034856.3101570-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907034856.3101570-1-Frank.Li@nxp.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0264d195-b134-4a70-465d-08da9083f948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfIerPDOgUiBmRDMvDPCROGjU/uxTdruVBLhKl/V/1Cz6hB+/mY+R5PnJOMhcebZYUSkUU0exNzelgrbkQ0C6lMLpt4K42H2gYmwqTsG5kOy3B5XZ6B/kKzfpJz4AjHlVGSf5w49hLkNTAHsAw8tyqaNbrOouOHSnIKSKPCpd3sm/uQ5pxBKab44rfk2FpzC7WftmP+BfgAxZ59XEh3FxM559KM3xQf2ohJLqLiO9YDjf2BT4i2HJgM+oEpANO1Fs+v+sM9qYCxWiCRkdokykikJ6wysrJE5UoI7Ni8P4vYVVUR09rbl4Sear/2nRQhEp0NJ3RlXtRTj2TzY2XlwicucnuUTcXeU9FLTMiddtEqg3znkjK8jnQkmRtmNAGmKR3rcLnAqXP2ej6CWiR/PXpfF5Ufi7e3SkoF7PpFkEuXZoZyo5MZ1GOE7ZLMvy/4OtCAPxVLdi5Jc6bKKSFbsIl7ZFP+dhf83TxCs/bwTRDCf3zNBZWInSO069n+MH0zO98UWUzDDffzO1mZremuOZnD+SpggMdcwdiDoZJWarCNDhoV50wLU0NQ24H35wZu8AupXXVEkqgBCNLLozJTPVD19JCMWNSvgazj2k4O/UPVVifx1IEfwmDgicEi6nyUJP4XlqBVWbeIdyoh3pCfJRknZGt6EKG+J4qR9Vw+CdDSwCgrMwQSThtEzBAct6ntGlPXzW0uW+FtzhcBMAoH8Sx56tFM5JPJXiCzqR6yWR/nOgtrETysbIZwP4ed/wDvEx8iipLST6vpAUUnlDqh/dttzHzaaCUsFN6+OyklIxwqJ+IoLu3CqdeDDu5N1ais6OLDtGHlxJuvTF/qPqMiodw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(86362001)(38100700002)(36756003)(52116002)(316002)(38350700002)(478600001)(4326008)(66946007)(66476007)(8676002)(66556008)(26005)(2906002)(6666004)(83380400001)(1076003)(6506007)(5660300002)(41300700001)(966005)(6486002)(186003)(7416002)(6512007)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGWkWoXChQd8iWBh7cXTecVXswlbSCxiv5NIklWJ4H66a2yP54U66fYR/jkI?=
 =?us-ascii?Q?frhpsutoZcVBIX/DILY4w6fr/obwtG+bKH7V4aqSRBamcVD9A/EskBzs3Ftv?=
 =?us-ascii?Q?Lt7A1o97GOfm5U8/AnONut0CHl7+fZLtE16n6KOoOju5bUIcSNPBv5Uu1yuI?=
 =?us-ascii?Q?uK2yIQCB3cad4OaX1eX9g3NoiUwESrxecABC7EUSzvnrvisJz/qJKpvsFgYI?=
 =?us-ascii?Q?mTykeH/1OGncHUnglespa+WuxN14STjZ1QswPwz8e+/22nOqxbAzY3E/5WxV?=
 =?us-ascii?Q?AaRF6PK8srNh5HsgDFptCiyJKAm249BGfsoF+SwITnUqQfEIVHxHQ+YWtnEn?=
 =?us-ascii?Q?rhvMZ/vmgyj5lrAP4PqsoWbwjmH+Rc8IffAhIpgu98l5gI4p5O4MqyfDINRM?=
 =?us-ascii?Q?fBi67LmKGbs6P5WAxqvx2lJk3EjBVDXBK+FxHryPffiL3jqvqFbXEg9W81hy?=
 =?us-ascii?Q?ginY9mbqO1wRXzKiA73HROL7/+76LeM4Ga/kFIpqPzdQOm5jb1IYWtZ26N+5?=
 =?us-ascii?Q?STJvJrzglvQ6JdqMCE88FB0fx7Te5IZBlH95DulWl9sG9SWJTtWIg2qD+ZiP?=
 =?us-ascii?Q?Y/RDBCFZ+Pq+5o8gmRM9zUH1W2BOfHgSLkR2Hj+nsiy4EQKlmuBsLqctlVE5?=
 =?us-ascii?Q?SAB/TyuL4tvY/YmwPXz/treMLa7ljLzrh/wP4M/tHOqYDe1rjFsQ2aE5/Aur?=
 =?us-ascii?Q?s1J5fQiEU31GvurKI340rTbj07Jowa7W9hov9rmUsqWWhDOM9i5TnoGesM2y?=
 =?us-ascii?Q?ZRx/6IMEKeRUD1BiayviISA/vRbQZjbwVhur9ZQsaxB2A9CiL/WAZZl3C+yI?=
 =?us-ascii?Q?oY3VXQW4usM34vZLkMuODIOhYExPAosCAT0sEIbfbakxpZbPBFycsYsFzNgk?=
 =?us-ascii?Q?Njh/kZFtHnaCywM6vgnyIXNXKbe1mje90PoV0vs1VgZk+tKFr28RwY9Ifj8O?=
 =?us-ascii?Q?CQ9Zx/WFSDgt748FCi8xOU0fPDPwS3lH7OcmU94RnudDhc31nt5ha6bf4UnP?=
 =?us-ascii?Q?B59N+rFnbJdurLaYupSinjkq94jGcfT7Kn+AQwA2uwMp3+DCDkzOyN5gPKGC?=
 =?us-ascii?Q?5uJL+gqpHGJeX2UDx+oZ+FGybv+Up3vJixNGym3pMA9DQlSgHO8M23AARLno?=
 =?us-ascii?Q?7ZKUdScaTne3uhE3Uqz44EOJNsZPTYawCKE1/JfS8YXiyurxUiU/IzhSofqK?=
 =?us-ascii?Q?9TBlGJ3/Q9Ytv0rAO6M8uxfxUN+8Wf3jQozaZfwX8Tg3C0JG2dLFX+3f+0jW?=
 =?us-ascii?Q?fRrHoPnIREKg0VvH8ujGzX4P94e6xjt5+7HFXHxS5Ckra+73cN2X5Dl1lt1Y?=
 =?us-ascii?Q?j3c2g7vWU1dV5nfVxHVETpHqDrZrorQI6nUeKCCG8eHo00gVBAEajv93RhqI?=
 =?us-ascii?Q?56+PjHrpltNBnJzJn6D7z4YRoFggVvGWbMpyuhFSxF+eMCcgcnY5x/zpzRYa?=
 =?us-ascii?Q?gws4yaOGtmylOhhkqUcncB2gB90yO5dRJMaEIp2KNzPBxhXCK8aowygQla3u?=
 =?us-ascii?Q?DBQfi6GsrYpmwFihy78ot6BEP1rbkzVSM6+tpzP4cWX46EQalXAs5vN8SRHX?=
 =?us-ascii?Q?AmAb5Z8v7KW3ebO+YUHFyTjUqeIHHiNF+FjYCiZT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0264d195-b134-4a70-465d-08da9083f948
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 03:49:32.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J50EXX7Xdq7Cftl5xmYTe1yTEWa9q1iA8CVaVu3ZVwqVEiR0kUXaC1XvvfADPjrp3wfKmqJQBcLzsD7L1VMH+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
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

