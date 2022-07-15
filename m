Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4373576752
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiGOTXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGOTXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 15:23:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FF79ECA;
        Fri, 15 Jul 2022 12:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVdRrDTR/MnmqEKRSDwUMXbDO4fCQrejRo1oAfNIlvJlOxq67NASM7i4wgdkSll+gBVX81rIhKem1psFjhlTLUD5OLhXtaco94/JE+OKp7/OxIJgM+mmxvo0lK2zC8aPcSDzVJHhCSy55qOyAsImq3jVb+HmvbG+eImRT8yO0AoH9+lCfmlX1Or3wsVUoph3Xo6YCQ5HsduuTIXlJxyiqjNI9LdH/3efiiCbeBVrfwFqfCzm9i2xVJhnM6dPbKT6tT9qe+YfqXYnbhVdO+4bBZV3pFlHZhYO/HddkJmG/02dC5rqSVlTE9SPUgjui1zZSnvllDVJrRNOj/ALak1tRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P0p0iFRI8WwaBrD60IFdem51ePNTmOiDYDu0Jf/RlQ=;
 b=GIUySnr8UW6uxwuDl+T9j+DU2cM1XE2o4CnhA1xgHgfpFrqqnhSray+ewDP0ljZazW5JZuephipS+UgQ+0MYTr1OuZWBCfB0sV6C8TqkvmyuNGQz3nBS2fYuqx61FCdVGGyeZeXP//nwYP1NtFSjMjNV64dtH9ukyRrz8DHFXpZCLAdC3CEKya19aaQuBaMmRdOdTZOBnX/4XD8fGMEXJlVwR8xieMoTbYX8TNUjxGNj2xiLG5ADBvmnKSkim/ay/sl19QHgBOX3y8CeJ68iXlQ0b2RhS+UdfnkmwW+GR6f2L3IbyFKd/Dgt9UwEaob08bOXW+THmFiqA+Q+96EIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P0p0iFRI8WwaBrD60IFdem51ePNTmOiDYDu0Jf/RlQ=;
 b=QcFvL7cXPK7o4pYOoBl2BQdMgz+nowBQKrKZ676ihMeN9zzAjcnwujtZTgoMX1+VzTXBuNiTX21TXJcNqxcm37vf456Ot8jn2d4tf96aQU6jmb9oaLQ7I8q7JeKYZh632VhKMpps5jdnqtrxdAsYrMuwqF0urXjmRnyhf/9chpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by HE1PR0401MB2490.eurprd04.prod.outlook.com (2603:10a6:3:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 19:22:59 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%7]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 19:22:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: [PATCH v2 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Fri, 15 Jul 2022 14:22:18 -0500
Message-Id: <20220715192219.1489403-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220715192219.1489403-1-Frank.Li@nxp.com>
References: <20220715192219.1489403-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c645b626-7fbb-4bec-291d-08da66976d9d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2490:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qBjUT5253lOqAnSRNqS78r0dhlAAzAS2ZXydn9vH8IZdo3YNy7/bWvGMXKcm3Bh3DRbMwlME0C/k3SfndbMsInh0OXV6jMl9eJR7b2J8PQ9Lo2M0HIP+XGGD76BETw93FhI3RpcfKMQ/ziOApVGxKI7hMwNCbpvT7j0THgvmc1Vlc6k8iejJQd2q0kU0kgrvvGjEGvbeg4+ZL95zjj5KOBoHWfb4d3HCdNKuQfl2Acd0xJ0/2fomzPVGbl54Nu1LtjHdBFeSy6o/BpNg7BfllCHuEH3CMIxljhG1P9q9Nau1ToQ+z2hfHxopp652uqvaXoktChpSsY4FQ5HPF4svd2UhnydB1Wd1KCHWhmnyMob7XvRV/g5QINWleJ0X6oOLwXGFat83n8LGFZ/bUdERUL8LWt/bx4/zCUZ6dHqtM8F1ZEP3yrutLl4pxw0U0+FfzMchnFZBzAlax3qMg4Qz+01cFOotG+kQNjcdPaZRqeF4lvpnX5A/zT34jOA7jeBMHi+5PVihDLhjiAC+QVGZrKERd/B/A+y3UrvcbnOlau7/uji3wmN95Wfi7VFpxq493C7Xn5Bj6joKVfhi2wIQ9+3jiuASjYQoNBo6XYPHOERfHbc+IcXMbqHfUM6HB4AC+Ip2jjoX9Ay4ZD/zJUROrIPMmWX6BzMh0M7QBVtL3TbfeveYkUYNqzAGuP5lvCrdC0RCDwh7pcxc1dLmqUAVSt3mdcW+0AnPPtJTtiXO7ypO1pb6xH5J5sJWqFpRt4QDIaqOojpZAaFZgV1Ir0qicqPKLpcvALfD6kT2qtdzAiSHkwzLb7TllL6341KldmTshg/gbWe31DxPfT6DPWx31apWvnNDq1bZ3yEzgBGMUq+vk0n5fH1jm/mLpVPJTil
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(316002)(186003)(966005)(5660300002)(86362001)(8936002)(66476007)(66946007)(1076003)(66556008)(6486002)(4326008)(8676002)(6512007)(2616005)(41300700001)(38100700002)(38350700002)(478600001)(26005)(6666004)(6506007)(52116002)(2906002)(36756003)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjZWsSnmcXA/gxqWul7qNlTFBJGZQPvogs07RXG8fnm5KJwQcpRHjT6Mkvmv?=
 =?us-ascii?Q?Gxg/lKOOuq2kgIHOdYnqZMeiIE6jPSb5YD/1zu7cyBlpGEnkWDf2AHVHqebJ?=
 =?us-ascii?Q?OqsOohpkeSvqMsAi/T6npQNIup53m9SrRMzHr3Ei2LOsRnSmvmU5ZL8kTuyr?=
 =?us-ascii?Q?K6qtgd++BhlECx2YNLSxwKNQFycj3fQohjFooRNdpPhuiLkC5JVghzUKa5v8?=
 =?us-ascii?Q?pgHftWdNGKhoW9DAURwBlkGXXS7ts/f1xEgQt09dbTRjtT9RuzNMVk5MoOXy?=
 =?us-ascii?Q?UGyoqNTOER+BnuH6burXzkXK3H/NN4RivdAEdYW7G2IdhxO2UhbapaBpNe0M?=
 =?us-ascii?Q?PRKldmGc/7rF5YKjLncfWKG50/ciu9PXHHx70vmF6spyxUiBmvtC4n+tYsva?=
 =?us-ascii?Q?MdG1vGDj3PnnTaS/r+RuuE/mnL+zqmpFoNHMe3WBKtrTA2dLNynaYAEK2Cyj?=
 =?us-ascii?Q?lZhyaFij4aos0lpHhlhm1DjXs30fRshYKhJ1w4o1QYqRxBAckmH15oW5HvWT?=
 =?us-ascii?Q?i8popTMIbnpH/Idot4naHuNY0fv9HIxbxQpQveBOXwuMUXMLT7bNAjtDfemf?=
 =?us-ascii?Q?MtKC1pyhnzmEf3PN/WCpRxh8XQ/M9hk9OJeckzeQ6aRLR89UgjQjJfR2dxEx?=
 =?us-ascii?Q?MsI5n7PTb6+ljnq99PpuJUS6zHQPKfFGqeU6a6nPpWSwtFSCT3dbCy6MI+pI?=
 =?us-ascii?Q?lmvEWdMTCUVj3UG4ryeD4iAkMZk4rfu3igAkZ1S0nEyz9AfHls26xQEtYEUi?=
 =?us-ascii?Q?oIsz61g7elbMewETJ6gSOJQ2BIGyowcXBe06S640QRsslMmZpF4JzNL50J6z?=
 =?us-ascii?Q?bONXsER/vLtwuE7S+RBjXvyo9AXtA89NKuR4vFMBp+/iGlA5H6YXeXn61bpG?=
 =?us-ascii?Q?+ESzVwxGi3BcembmOuf3Ko/jDKmTx7DvNUprUTtPZu1AUTwnRRMZM4o9Vgh+?=
 =?us-ascii?Q?Ml5IcwpVqnm6vh0UBEFms0tpNGsbxj4bO2jSFRhp7He3I2h6vR+euLckjHfr?=
 =?us-ascii?Q?Yh8zsl3HgR3fJ4Wek3FF4dCAMmYpjjSaJEmcPvsXuVEb9YNe5cdM4EV70vks?=
 =?us-ascii?Q?ipIuq1TTUlY3pL2jmTF3bKp2AHbXYGBuTY398adi6fvh3waToc/Y+cO6eysh?=
 =?us-ascii?Q?PS04ziUrVaCE8hQy4X/LWpdqpIE/MXh50TW/dULZwE+IrbUoyDj0K5BDYi3p?=
 =?us-ascii?Q?HAhjECtM+d2103RfhecHl4cwmcjDmhWDbHmOtkFm5CN9/HhqfZjxQmcf90It?=
 =?us-ascii?Q?h5vOfKAvMCjcfb9DNEvY0H/H7bPytkbuJArKHXTazsvqP6UGYzLKW2ZzvY5h?=
 =?us-ascii?Q?H3MUFdVugcKhnoAQGECFrw4QT11RVcVidYWnRLkuLR7/445SjXJR+d2tMcLq?=
 =?us-ascii?Q?u/OCr1y00TsJSU+U41M/FZj99uqfKdKfDu1i7Ke8DUcEpOOjxeYexVTL2OIZ?=
 =?us-ascii?Q?9hIzuZV5GviEvcOHlzJkB5schVMpW7pmFLyjb0l84RltntjxvJN1ynpSdyTV?=
 =?us-ascii?Q?D1aWnOkQTVY6Cl5PpYreS4gbKlSoR3lTn4Y9ht1Vj9DdlxneXoGKLGRbZLs+?=
 =?us-ascii?Q?5QzQO2bndN3TWaNNFlo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c645b626-7fbb-4bec-291d-08da66976d9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 19:22:59.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGASoGaDsu9IrPMPHRGxXfwNkTdeKeC47IEPQMyiZ4sDF76UyUbDNQCcx1vK29jB6HRZiChM11gCH+EUCMs6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2490
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
index 0000000000000..732ce770ac3bd
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
+  - $ref: /schemas/interrupt-controller.yaml#
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
+    lsio_mu12: interrupt-controller@5d270000 {
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

