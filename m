Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521085951D9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiHPFSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 01:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiHPFSP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 01:18:15 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10089.outbound.protection.outlook.com [40.107.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABB12ED66;
        Mon, 15 Aug 2022 14:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkMuWDU2nYuG20sOI+LWNZ9nM9HVbBW1ApZ3sbe3Cz/AthUo2QY02bMRv8o4rVmlQIHJLSUkyA2kbtvGn+CTIxi90U4+6cbynBANBLtmugfFGg+3dgtweOPsisPqBHYubAyaI1JyLSnGZIqc3cV+uLMnzHBp6vh1hbhfLMtia+tDbdqqXigv/anrvFnNRL13g5pB2rZNGuFSaQlPPKm21tOkldRZwr5oNRMVW8pI3SZcHUpFwUShnwsVcIN4+AG57k9FeFD4G+SwOHW59zyB9yYbBmpAwJhqKkLl66ln+XJGNd7aBFV0uLDZST/jxFiEht4Vo4VLZovzMAafsilQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVFJJkHBYbxdRZKhWWlDd3nZUmM3IMXu087up/Kc5H4=;
 b=dNMQT/hW+SpUO22zUoef3U1N+BJ30UAKnvj5dC/oDzcuYAQ9w9jHlKajqA2sgbJw5UdysrQkqN/h8cI+5G0MQsXOdl3CgXFl+FJSPdQkoD9ScJIHPSO6HmwwFlQrbJiRSDoCCxu2Mu5C1Zk9YK/z+VCGbIR6xxe83aUa7yT1N/pfNfULbmD3sHyanTT9tcsF1fTfiwlG5jZZrTHxPYvgl9/6063/KhV2RaYKJRF8CeViUIgCMG71CMHQWYta3ln+94kNMhLaJ51cpuK/EhQJcouig3hHnLPYnATA63YU5Tk4RwIZ8p0/fS0x7Ozp8ud5ijwTPvz9xn39gtNnT7Lc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVFJJkHBYbxdRZKhWWlDd3nZUmM3IMXu087up/Kc5H4=;
 b=VtUTPuWZ9IGmWF7J8a1NPp54hW+L5nB7soCRWchH40tYO7lsT+sK1sP+/1JHdhRx31BvdiV0vhS9lHUKn+2riALBJcm4muPZ6VFgIY9BFNBKZVgXVugfQUsx/LhcoTqYBCMCTtaMJ9P0SqIivb/UCJICmFvnrT68zAjPRBkOjYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2580.eurprd04.prod.outlook.com (2603:10a6:203:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 21:40:12 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 21:40:12 +0000
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
Subject: [PATCH v5 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date:   Mon, 15 Aug 2022 16:39:35 -0500
Message-Id: <20220815213936.2380439-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815213936.2380439-1-Frank.Li@nxp.com>
References: <20220815213936.2380439-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:930:14::9) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b74b96-7dd1-4f00-3c74-08da7f06bba7
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2580:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 823vaPcdn8QytzBsZzkRhhaOtJ+qtk80wjeG6B2mw45Nj0YjVwYI+oIaxPtvR4djkdBZN7Eo3n+OnenbpIUr8FeGf47MuAVQYYboyZb2/wwBHk1xWMt+LVnZlz9KkZjKmUZQmaHJN4BQwMkQmaSpTQdbz1rnWZOQO+XiblA7hnD0c5zZXQ/FFcZlsTbQ1hKSI3OKpihFY5y7Wj0t9/TgpidKUirlJC3ycJRShB5s9+tql+/NGBWwU8pOrjxQhnj24NfHBrtzE+lWPLOzU7Tx87JBaGXu9ccL+NTVQOlgzHTdOFdVsJcuUbuNkeh6+v21EE85z8X/NQxfsMk2DLrIKr5O8VfzOW48rdnlRrJyWcwN1ENs0fkJm3mweaBuAhVUod+IdyPV6vIZ/+PBxpVLplFYbVMwMXGqEGiQ4P7ML/ODge8IwugIrHT/vFhKUAnzslg4WLXz1Kdx94V+CO6rFRQ4RgOcQtkJhNd3WbNMbU2iQEwThpOQralIPtGYPnnlSdEElknbgLu3tlu+HUAXZF10ztY0D4rllYTtQ1MRDivQedHUlYRROGydZ+cuS/3+DQE12efK6rdM9mX5eCL0xdq7uVl1S+14h8Zqtb2zE5YgpZKF8b4HcJRY3zcWBm/hxkzhnDUhw2LJJHTHobE+L8WZUM4pnAc/xlqUp2B5mgvaHNJ5lNyzzLdVno4h53m4xly0GZXvMTYBndRzwUJwl7ew8QtAtuGPrgnShFw1xuLzgXNKLEipfEiydq2YR9bQIVdvgxNSroJdB6Z9lSM2I8HyGcagFQmz+y4dt+r5cjsrQh3B0SKKxjLU3yJpmX5nTNGgIDkQGeRbPyKYwfx/8/fXrprvcfycM7ZAK/g32Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(83380400001)(478600001)(5660300002)(1076003)(36756003)(186003)(6486002)(2616005)(38350700002)(8936002)(86362001)(966005)(41300700001)(316002)(7416002)(6666004)(4326008)(8676002)(66476007)(38100700002)(66556008)(6506007)(6512007)(52116002)(2906002)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxi1yxYHRuJwR6NSy6Nq+UXjY6daQYDSuCistELxJ/7YyA/+75t/WgRnEyKE?=
 =?us-ascii?Q?FiDuJzZbTeS8I0haMGlEPzZHKAjoUGEKvf6pheZs5ojC7Bsn8aIIbWQK5HoT?=
 =?us-ascii?Q?Xgjewxbx7LAW6hQzXY2QCwXpMpBaKUk0M6cNxDv5OjNCcbYh9cmG2m2kkv1i?=
 =?us-ascii?Q?bbiYbedom88KQFIK3Y67X36cIAjrent75hfjK8P9I1a8lrYw6TZHf3Yk8B3B?=
 =?us-ascii?Q?vlbV+A5oP6e/UEJ965hug2AVz6oV3uAIev9SHcTCWGKldGMCtJ/BRcs87n6r?=
 =?us-ascii?Q?+T3h141pi41FlkS2neiOAD3ngBn8WRYaBOzYz4AEbK4AmaLXI04/WPfsYTZJ?=
 =?us-ascii?Q?N5F8zgrrWYUI70ZzlArODGbwP7WhUJA3D6ULzHz8pDadNhmqJl8jZ4RKZEqg?=
 =?us-ascii?Q?x3Kdw1o7pJwLxCr1UHDv9eX3It7/X+o58uIs/wbhZP+uosrKn73fsjiSxj3Z?=
 =?us-ascii?Q?1PMS9yjJOlsju3hTpPAPB3NesOGyJ4u37pqtUYKfnTOAKqBb/4ddnYyHLgkZ?=
 =?us-ascii?Q?57eHRN/tUF5ZHPh8v/JrVJAc7HBxof17MUCvtyuatuSaqc1O4a8Aqcd7wuyN?=
 =?us-ascii?Q?T3sDvSl4o6tMAhIDB+0UP/5GZ/HLqI1ug92F7zv9HioBAzqB2XQn0D+YpYs/?=
 =?us-ascii?Q?pW39c7AFLSR73MO78M7+ZDQGbgfH4HagidGb3aqJMnBwZR78TIpi0Xf+NRzy?=
 =?us-ascii?Q?tNGwo4b17dicYz7cjdFf4sio7u8GMU0K3S+ewqidRnQYZyGby59wcIYcoHXl?=
 =?us-ascii?Q?O/sAjvqtOT24wHijfsfPSYD5DusR8JCdZIc+Q/d75wkaAnoPxCt0ncO+ioc1?=
 =?us-ascii?Q?2eL78s41MZL7r8AiB3MVIEHKQZzjwQWypM0EjtAy2p+AZpdDskuHo9T/olrN?=
 =?us-ascii?Q?UvFroSf5eu9qOvigvzfrOKS0/u5T7drx+iwRGOuX9m9nLxC3x3D2LA2TVoNx?=
 =?us-ascii?Q?p+Yxy/i5VDVXrqippHFoSYxh8XzAYWggmohx1W5l+B/Geohd5G+fNImhEi87?=
 =?us-ascii?Q?TezEPQR0C6CGRf2s/NcrzhuuND3n7bfAJz7Z7ZiTwL+ozCX1SgkxUSPA8flj?=
 =?us-ascii?Q?kQ9KwRhecP9oH/oZeWM4yuqKu/vl3jhdYyGoj6b0lHQdVRN6q+HdTrvXv5A8?=
 =?us-ascii?Q?YoEnrFDgZBP8C662S8PB+LIodPO7wC9gd/PaJo6BjxWIqZd6q2ION5w3qYTQ?=
 =?us-ascii?Q?utUktj+kSkRDhSUZzZnbP+FBMdlQD3ZNPUuWZZGJIJlDfUJkV9eiXht1ehsR?=
 =?us-ascii?Q?T4i8qScKxNX/AYtYFb2+Cy0wFANZjJ08/z4LB/Z4U9o7owd3RF9MBra6EAUB?=
 =?us-ascii?Q?oYv8mZOqhryBFZIFhZXmpKd2tRLrbfXFGA0Tz124qFQbDKBVkZulfcjFd4e2?=
 =?us-ascii?Q?AesxJNloddGbvvSafLsNb+E+bcv7Vl4dVq66UaAV/pTMSc89caeXYReY4ZjU?=
 =?us-ascii?Q?/Kq9299QTNJGTHNfSJqsNk95NB0PmdsN4BdlKvlfahSaVNncoxCPsYy4unlB?=
 =?us-ascii?Q?xzjIPRPfqzI343OeC6NhufalkhFK5R2mNtOhssqX+8BLCRdQycN59CtUh/WS?=
 =?us-ascii?Q?vakkuED9ydLBqDFgTsKWD+pN5kfsY+w6qFUv685e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b74b96-7dd1-4f00-3c74-08da7f06bba7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 21:40:12.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjQxUPU7tI4J+UvR4+4OLgGEjzAZs+4ZFM5XYJwD9xbvoYpQJcjY4j36FW5HqCxCvcQ1XniuXkL/yDlIhT8RxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2580
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

