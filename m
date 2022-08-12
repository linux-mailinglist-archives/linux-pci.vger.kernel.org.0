Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27045916E1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 23:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiHLVxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiHLVxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 17:53:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D8B4438;
        Fri, 12 Aug 2022 14:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU8Fc9jCpm8ZT3k5j66WrQxnyqXdD/VsG65jruJyUqiJUjxy6kuBizvsMVacw7nSwwkuLJEyAx2NK/9upidHzHqJ04gI2sIS1OVx8zEWoB+OudrFLTUyrPFUym1aX8Nb5cD4VCXKy7PV+XiZhftqgD2Z+JP3HQWFnv6iwGFwJ1jy4VeiEfyoxXQz893t4nGMjHFKYZqnE3zoALALfa/OtInjLZaM10Bw9zq0SUVzX023me674dWpe6xZBjKApteVSRR8783oWX97ypK7CfEiMiz6tAGkGZKTI+BcP8+uJORmfM9P4KqyTdUtC+ymoIaWsMI/QOtgIkTMeYVvEZSj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO0Ukq5z/FFzjOPzQO5TFDzJmzH1zovnfAtQ1pbPsbU=;
 b=XRETAkWR2zKfGHxVT3/R4y2QY1JQgNn2aA8o0VWJrY4mBDhlRIIeZAeC3eY6J2ElCFIzPJPmH8iAjRkZ/r11s+2nTTH1rX5QkRD2CiVY4QOk3G6O4j+FiD1TT5tXMhrQDm7RcUEcg87ROng1VyxPlY+BtkGkNV9UlMhwhhDFw891u2y7jxwJnuHi95xEcxSl6mqx25D6SCFs0EF7PNETc2Q9KulvD70AABS9FSdHatflrIQA5Ufe543Q4GVDpA2dctOyIcSq97IwlFm3UlLYpopudqcASfmLozcdQQUScjqwRJLvENQJCmtWXle2010SQzcoG+4p7/7Kr6cqOY2iOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO0Ukq5z/FFzjOPzQO5TFDzJmzH1zovnfAtQ1pbPsbU=;
 b=iCTJLvxxKdKgmAhb1H2zKlx5wqwOMWCYABu9cYJnATTAP1271qP+rim95rEBXmvrV3Z9fjPDofjG5VyW7KQT/LBqeOHlsr/FYz/ZGPS3T19A2Pa7nNOVLDjLJjHy+SLoHU+Qco13MqNfVYMTzPCSfJiIlERFjGrqIYoIF47O3Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 21:53:18 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%6]) with mapi id 15.20.5504.023; Fri, 12 Aug 2022
 21:53:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v4 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Fri, 12 Aug 2022 16:52:41 -0500
Message-Id: <20220812215242.2255824-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812215242.2255824-1-Frank.Li@nxp.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b69adbf-c88c-488b-ccdb-08da7cad102d
X-MS-TrafficTypeDiagnostic: GV1PR04MB9087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpByzxxatGTfVPN6puLCmJxZ1KrSzTtbLmECzxejEywbM8qbsDVoeAATPZN/b5vu9RAdht+EM6XEhBlC1ZV16c5r8LwvZEWCCDWTQ7k+ETEIhtBVEGZxl7OtD9OXaVJPb5z+Ai3na2X+lsidXnOPjp/WsuukHmMU5+/WufIwhh7lruoxhVyyhdCB4Kjt4IQnAmGLFEbrmBqsNoP5LZWqTq0jSS8solWIfjooQasUj4qObbU7R69bqRh/m7oRDThyXAwtBjtsSnMOA0O4E3x0OMCBTer17rZMEE4h8Xc/fhXwplgo9OJ+h7mzxwwPu97Vol1yU04/wkpKkmn57vn7p1qb00rjVqWEVujWwSmmwUpKuaAkwLN6lnJGpNn+0/q0BAZ6eCqEU46sI+WJ1bj1AC3cU/7T/SUnoE2qZ4lgC/JZwg2ici7UeL7IDMRfZW9azh6/X8Ufcarx5DeKt4NBf3bZ72huKy/uRI84wjFeyQ7aJMT+71hKkCK+2zfZ5/Fxo8IZcYAIljg8oy3tvgddZJxbPoOOgDH2M56bj03bnalQtAar/5c7BEcJg5AWtZn8Heo2AvQI30a48AFep07w47JhVtyemhuSTBZHLKReyKCy1WC+0NUONvyvgnKND/ffIU+OpTpDKVpPLu3AU8WX88fz5mIAHY9obUuEnzbTiuzZF9Z7dbvuy0r1PFLaJ7MyKDFdNcglU760lbH9tQ4Hr5ferkL9JAE+KPwqEciFloyWhhjIPGZgLjWZFw0dWJbNKibQTmtJ7DjbaQY2PI67AgCoYogkAuvHElSoA1yZCuIi9AU8Pnq+CQzAVr3CldXzhWlQlqWp+UFAqYb+zhJSMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(1076003)(2616005)(186003)(83380400001)(38100700002)(6486002)(478600001)(38350700002)(966005)(316002)(66556008)(41300700001)(6666004)(7416002)(5660300002)(52116002)(2906002)(8936002)(26005)(6512007)(66946007)(8676002)(6506007)(4326008)(66476007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvfBheJqSqFl/I9eqiobXHqN5/JfyK6Pnqa+6RJVkBoTMtw8T/K2zOsV9qp2?=
 =?us-ascii?Q?w8z8NE0R1Qmov2RUGkFOb8M+BrSjrvln/ndab7jmlSHbL+IDZOoHM5fDxr/s?=
 =?us-ascii?Q?SDmtE4qM8qSH1Cw3MylBBAqW0mhk9H6CRuTMx3zCbV8rNhnKxgmFOEIorhF9?=
 =?us-ascii?Q?88Ai1EcXXTspHBpuBt6REf7R1Qcp/Rqc0aTfq9f+7fjJJHNS9WNbm+fbnFfn?=
 =?us-ascii?Q?jlfBPdwpVUMxOFgeFmTr+6aqi46EVi/aEzWeX4iICNymsYQKiiPS2WPBmKK3?=
 =?us-ascii?Q?fZpLlN3oC5RCDgg1T9Qf8WYW7Hp55PbJK5f2Z4XDvUnO6cjAi/a6VGaA/1am?=
 =?us-ascii?Q?8wslC90AhctAawLFzDEOom2/2G9gyo1AV+cIMa+R3VJPZ+ywm4znO/ueYywU?=
 =?us-ascii?Q?7KfFl8p52RsNq9+O6cmtVBMvvdw5iCx8c3y1E6pbBgWr/Dbf8UFrNyxvIU0B?=
 =?us-ascii?Q?WrWB81Ef4WLottSe1sylbpHdt7Q+GJOfLQd/Zu9ivdEXPskwN31yabeg+xOG?=
 =?us-ascii?Q?c+8kyT8TdLLrW0L5mnwAyUgmC4G7ejKdLtfJmgq6O68L96u6VttO4T+XSo3o?=
 =?us-ascii?Q?WTAMo+jLJLS4hbeoLeqvYhU3IaAsg+9iYilEg4QYE33HusGb7f/bKTh3778/?=
 =?us-ascii?Q?UiGx7xuKDRdcW8TG5Ox+MgTcbiw4qUxSr8CwAJFjYSDZxC+xsOxnasnx9Bp2?=
 =?us-ascii?Q?MTPh4rxtVCJlx8uOsBDNSKWj6ytZJvNEKlVwnuwQgW0xg5n6bUYq3ShEyeiD?=
 =?us-ascii?Q?9EHFrot7N4RT5O7p4kFE4zRzl4GeRrwLiu5yKvdTecKlqrhNqzBPBbMrGzLP?=
 =?us-ascii?Q?TckRAqka63LWrw/Sujy27XpWSnkdU/Xac+lQwWLcLllzQkOsuuGvWraSQlxn?=
 =?us-ascii?Q?Lk4LJVBsMVO4LZsIHokoXTBSmZjWbeIxfFPcR74Ap9YXpd6YYbtBh2l7pUPZ?=
 =?us-ascii?Q?DRbOGz+s+1J1Z1MuFTwCk828BxeXXzGoNCaiVIRDPEHbJ2Iykb7xlA9tzfHx?=
 =?us-ascii?Q?dhBXkpOd2tU4N3h9blFTyvTOe5HaZCXOfFLmRH4cC0JoYptyAEni5X3biWkZ?=
 =?us-ascii?Q?vFF/POdwHbigGTpsATW1M5OoSqfEW9RaPdPq6OBsbdSLgLavGmMG5C3Nr1Uy?=
 =?us-ascii?Q?q/klPwZJ2Bc4D+yixzjGuQQAy16uEsCRnfZzVs1Imw7FltP0AxXh8rzgssAC?=
 =?us-ascii?Q?NU1r44I8nAKHaW6GW71M9fzy6OcuG7j5dELHRsr0S/+ICzjklzHkU/WWPJ5B?=
 =?us-ascii?Q?KfqySLvAsWaDc4WjGKq/F+2K6SlXGJ4LIL/46NogtNR28Y7ST/bZbIr9J2/u?=
 =?us-ascii?Q?YSLjpIdwwrMQODAhDkFGhcVT6YdX5j7ua2Fma95ZXogyxcWKaQ57Y0hsMeE9?=
 =?us-ascii?Q?imfjbaP+nOU3gelpomCRmtFRvfy5pE92YCC6JZo84MgYVwfunzNGQRb2nfVs?=
 =?us-ascii?Q?w7157rNbfT+wohn1/LdpD1VoH0k3NYr2YRJ9yRXBicTHJvlkGvEUM1iu9+ID?=
 =?us-ascii?Q?AmlB/yzr9dX2Fj/L8OHfaEP8IXGcyA+MWqdYifgkRhhkClW/sxY44vkfS+h8?=
 =?us-ascii?Q?xS099gWTXeNZEq2bfNs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b69adbf-c88c-488b-ccdb-08da7cad102d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:53:17.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4mbsob6BwDZWVfZ4AxiA7g/l3DZUG+mEvoDnqRBB/r7Na6EQP/GQB6PrZIRI5qyGIIfg7h6gC9zz+9ROabpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
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
 .../interrupt-controller/fsl,mu-msi.yaml      | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
new file mode 100644
index 0000000000000..f60fa8b686879
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
@@ -0,0 +1,93 @@
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
+      - const: a
+      - const: b
+
+  interrupts:
+    description: a side interrupt number.
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

