Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5394C5BD14E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiISPlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiISPlc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 11:41:32 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00068.outbound.protection.outlook.com [40.107.0.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E1B39B96;
        Mon, 19 Sep 2022 08:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0rUo3a36WCdpNSeWClnlTYZzfL1nDCUo0iMno2oMd+/bQPTRHusrMQAa0QARZovNcD6uBnUPdKaC4YUOVVtrNPDEQwsh1Puc7N+W+QZvmDoHCAweCycpm9vChx4DOcg5w80Buc3xWQDh3Ejsq5zS3d5omeeshNNzf4+KvCnZ9yU6H2wrWM53Pylzgtg3VFYTGqPt6gIpC30C+XgTMi/rxVBfwh379MfE8h2PVQNoKsCCV23LAIjKmk6HPRnX7XVTP7LmDij9e1LgeS5APEAnLooHOwSTMfs6kp+Zi6ogE++828tcHwdi7nct8XcbSM+upincViD3j3q0wIq8GisHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ankBqv4m+mipQUAqC6qml7eN2IMIGbUtiVkPxPMXbW0=;
 b=lLmdYaIgJ7Ap+hp/3eyKLkumte2/bGVRsBjQ67SpkWuEvHjf7qglCr2Eh45fvaXM6H6mOqdLgbfWp9vmCGP1RIftOg7hv236SMRboRvAUMcbFeiPdEMpLySCxAh55BgKPkE5q6u+rmxmvQlIXRL7VKfY+TPyE48n7woEuq7l2fXHBIpuldW8x9HN31vdRthn4h6maRxINlkDacVaccoIUZhV/uzilqU0vJKF0XZQdB2NDWNfy7imIs5UdZGIba/0v+ML+5kEB2wR4I1Jg0tuXYBc5gQrzTz1aHWEmQgXvVtUwIV4bVpw6X9hPTdzBE+t7c95iiTbFOYypwKQ4t0ZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ankBqv4m+mipQUAqC6qml7eN2IMIGbUtiVkPxPMXbW0=;
 b=FIrGaAynjGN6RXC2ojvwSEQvQideA2uLKHP/mGBWdGNT14bFVf9fSZz5iFVan4+kBQeD71MRR0JLu6o+3vyKNJCXooeYgOrF5Pc4rkf5cEvyaRLRBPUkN4gsN6erJTLEvuzHCTKAqRuWiTkgiE+Pxz9L0jnMkCIuOs0PXPwucmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by PAXPR04MB9665.eurprd04.prod.outlook.com (2603:10a6:102:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 15:41:23 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::5a3:ff70:317d:a99e%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:41:23 +0000
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
Subject: [PATCH v11 4/6] dt-bindings: irqchip: imx mu work as msi controller
Date:   Mon, 19 Sep 2022 10:40:36 -0500
Message-Id: <20220919154038.187168-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919154038.187168-1-Frank.Li@nxp.com>
References: <20220919154038.187168-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To AM9PR04MB8793.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8793:EE_|PAXPR04MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 69268d2c-5ada-4433-d657-08da9a5567c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuDWnKw8F/uvAJ/YMCKVIqDHWZxN4QHojT1uSdJ3ja65BP4UDmqv/y037t5orqk7dS74b8bnhloYh+U77+N5VVTsQcMmcdRO1juHxc1Dbp93GSmA6vqA7rYBiveVeH73UL+1iYMJxvKFD4XHudJjtco5vUmfhAYGa3ElZWvVLyYhdetUchg46ji1coUGYOdWBXLisqLOmLYOWLU33GGfXvd/Ygvm2bOuX0D3YmvkSp+gogIJVHo9o4nxjw7wTCLfM/N22OB4vY1laLGkCCAFpUIX2en+ewn+jq5SUZA74YsBEW6g/wNf0mlEfez0iTYouEwV9Lq7JZvtKeSbOG9fia3PLinPF3/n2Cw9iiIe0sXYg8SK+by3xHXSHgGlAlbeLCLC07fxdl30dEdEWGPiLb/LkR84L+/PSUFwcY0pUNj8Cx5M7lcvbBYaHf1zrleyrsQJgltPfGvzUfIqVujIyDprglmzPFTFVbuqAkn21xYxHqr6Ajc9bSwgcDZ8j210uoc0c0H2ndvjQ97E6Lnl+qRY+6YOiHQMDUMX7H7aNxDGv/oZH+iGiHiXXK0UFWhbezV5958OJIXbShWY11F6Wl/bHj0j8P4uvT3vBVT1jD2FhDeoTF8XjAKrDLWJR67+B3+ZjVOzNBBfAu/6qRIaQLFTU+0YIIzWIiwDYTOlsQLY3T/gqqlEkP/G0sL03ck6jIcHhyMut85Pz12a60UAJrwrxBadHj1fbLDlCV5pz2pIxYFP4/hW8HzQtIuIDlygk+eQYSCaMCpqm8LiVEakpCCpTdifOh2Rkozmuu8nOcqIxXf8C5IsR4h8/fBlaudDx3yc7ADAJj3IY4CuFFBRUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(478600001)(6486002)(966005)(36756003)(316002)(83380400001)(186003)(1076003)(2616005)(86362001)(38100700002)(38350700002)(26005)(66556008)(6506007)(6512007)(52116002)(6666004)(66476007)(41300700001)(5660300002)(8936002)(7416002)(2906002)(66946007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k04+0IXa51M8YeOQtiIM5yXCQ3xSYHF0+4uqnUzFke6QDOKDULQCAFhrws8v?=
 =?us-ascii?Q?yQbpraefzlZnfIUqmuJalWiwbMSm4/rVs2NGj9AgDaGo1CZ+FEzuFK5WqWqi?=
 =?us-ascii?Q?TM/QTHIc/B5LNjIOck5CEl4nup/PX6TmsjRdPNvdviZahtVpeQ/Jbr4Z3Y6L?=
 =?us-ascii?Q?lndpPbu+DpllVsZSxNmbbBo3XX78q6aF0qoNJIjL8MHjYpup/Iide9Abww/F?=
 =?us-ascii?Q?LLn7b2c8MxL5ochcU+8pKUVmHk10iYpr/2klcbCaXNAWJgSoC1xo5u7s2OgF?=
 =?us-ascii?Q?krtdVWFL6nUscN9w307tcoXwcZgDU8wBjPHELm+Lg2bPwub4szxvWEeehqUh?=
 =?us-ascii?Q?KcSofH4z8yUwSwaAxdH5j7AyQ05TeCFcyT6o23GRQxwHa6cv9fsAEcz9rBAw?=
 =?us-ascii?Q?XDkSJ58lkXcm0lia8Kra5hxun1NLt3MlUk3DwyWH+Rlk+H3nDbHHKCGpFh0y?=
 =?us-ascii?Q?QWPuIckHENm3iqwHVTsevHouez4nU284qzzERCwUWiN3KeeCjrUYTIg5+l/U?=
 =?us-ascii?Q?tHf0wibMX+/Y0ttQpJXLD+2LsuWZ+L96txarsoNdpnMoGvmm38nWo2iDtoag?=
 =?us-ascii?Q?a0iCEWn2laxyB5/oLSvivtsEJINEFGe95Sz1KhVdZjJhQrScraIryuJ7iNJf?=
 =?us-ascii?Q?uS4JthULl68RD5smpCsCbV1oWNd0mL0dso2xNbksI9e/Om/0gAeYV2OidVez?=
 =?us-ascii?Q?Uhst8FMV+IyyMK08GytXNh+9Lf7MFeZxgHJ7m4QV2DzhwRQVdHnpBlTFniQr?=
 =?us-ascii?Q?eWltWsJkWK1fq2DSW2Z4fI4trA6tnc3N4I/4gDTTlLFcxVrqkk9FstA3NrY8?=
 =?us-ascii?Q?Vj8azSi//LWEKDYdfhtszQJirekugPw+OOdbT1/skl2qbrmRJZ5WsNXzxTVi?=
 =?us-ascii?Q?Z9acmDilN3RjrFWjLMKhTj1Bky2JLCUAs6VUvJdXMhzF68AMclzF53K9eES/?=
 =?us-ascii?Q?mpgChtWcMfSSPDJkzFlhLwtqKgMN8OUrLlbP/efGrihPYh8nfYP96wLdFGpJ?=
 =?us-ascii?Q?Fk+6Qv1oKq4r/B8oVVIFOSg7+e1jgz/DgbGjh2r5gM4kwA+TUe+hrhvDgpyW?=
 =?us-ascii?Q?BXAXOmiKtd3Wn4IIbcWh9XCOktIdHAssfk5lY8XYO2+GTJw2X+A6WQG5t18U?=
 =?us-ascii?Q?LfeRx7K9SWx3GoEDDmxO9ualwPTVMEjeUEp4JEqVzu6lnSb8KoqfUNIaV8aU?=
 =?us-ascii?Q?qGxm/fxBrHNH4K+Ipv0RWPpuobKd1Xik72uLF96rx8eYcHmx9thRe8MylU6p?=
 =?us-ascii?Q?Lk6XScm3tzJUv6099jg3vCp/wbHKNlfkv4x7syFC2hzSu/3hX9vbQob936S8?=
 =?us-ascii?Q?+UTkPpcJzwZWjqmbNHdyr1coTq7fYGwFjWKQYXExqcLAoKUPa8WB+axWDQiS?=
 =?us-ascii?Q?2slat5BACr8XI0Uj72NitLEhxG9T5T63bXdByUUSIRObXldyfrKCD5Qy12HV?=
 =?us-ascii?Q?XSXKrtZ+gfTzjH4yJv4u+TQuf2ipBi3YyDvCunbLOXEHczx90NyMfo8Czwgm?=
 =?us-ascii?Q?SxL90knbztit4Q6/DgYu9f4MlCMrqzWEW7TgjugWmmIQLEWpdFl+pAQ0FEIN?=
 =?us-ascii?Q?DJTt7wctULwjinjQusV+YW+6WAo2yYDlkNpWFSkn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69268d2c-5ada-4433-d657-08da9a5567c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:41:23.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE0HVQzK4NSFl7zgGu94KZhxB82VpcD1hXzVby5KY1COsc7q/yxbDWl2FyleWbrQWwuXpqZI/tkYdcvFQcucHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9665
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

