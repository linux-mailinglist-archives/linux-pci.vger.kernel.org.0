Return-Path: <linux-pci+bounces-1112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180AD815D90
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1819283E70
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F42571;
	Sun, 17 Dec 2023 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kpejR8QC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AEE568;
	Sun, 17 Dec 2023 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu+8fTbWxFMtRCQGCUr0AP4+eoqgiPDnmJemWGRl40XFXwfB5OPxuYaVjU6/3jVMO4FOHkAeBxvI4TGTZHVMDHV3EA+AhDuzHycTu5BEETxoH0IoqPR85QMPrcA8wa3j2oCmNsy8lFvh1piRpoPzNEi914ELi650oNVk0Ih1AR36oSZtXYCBK6hN0OskS9moDt06XIl5vowk5Y0JtKiqpH3zNi0CKlkslRSymvmTiPrU7e40EkltP4JEzODIFVbv1Qjd/BgvnqZSt/t1ThCV5cP8mR20VEfwXhqQglhzdNF27xVxqA+XxKE7jkwYu3C6pCft0sGEJ0mrptMUMpD6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAw8RuZhlOT5aM2Yp0dohN6qVaLHq76nw4HwyEKP1Zk=;
 b=VF2AFOffBsLMqroa5QtYxvtEtyBIK0jcIgwIXqnKgN4j3nJEcwxu64LhsBNYRYWKp/Kq3UgPOMPnUK0PVBXAwB8MvkuOKSw+RSNKFWGmBRI5JnmGpn2Mz0cw8kO1wSKOVCX7rBOmPDPNVvUZJBQyg24Rc02Nwi3z8HeRlKfSJAosnWGRtgsIhuUDNQjjYJFuHsHOnoAWLJgfpXOymNvMQa1OctdtDEtJ25Ua9++5tbAth+abhQolF0I7IoVEzm5jgcqAARHP4ynUZ71v1WK5dno49ToDh39K9b3SiYZ0VNvVZ5kKhulkCQgGNhWqCzg5u7BWAAYj1EPwOUaMTEL1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAw8RuZhlOT5aM2Yp0dohN6qVaLHq76nw4HwyEKP1Zk=;
 b=kpejR8QCT1PAuePfun0m4Y0m70ShEkwuXDUpGh/S/mjziaK7w0myp19RwQ/dovfpb5WQ5Ud1bpfGrKSYpa0mOGUhTnqNsfFwIh/vlNZDtpZn7jRJuSDvvdNRfAeBLj9TQYk6QWp1VvSiKVgytW94G9MBCjQUEC6iuK2FYnw23ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v4 10/15] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Sun, 17 Dec 2023 00:12:05 -0500
Message-Id: <20231217051210.754832-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 24da473f-d3cb-44dc-f956-08dbfebee61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nXmDFehi15U+5D1/5uRWLgRKhenzknbTjbASeLir3wj9A/oqkS7ZArKfmqQVnjN1ohY6UThVPFSLgSm/nqoSGs3xVCpFmcUD8y9m0WErH/ZHhcp2E09ihekfvhMDQ0Gk7OXDUDXItCbMHIOOTPIXAfk98CSuOxr99lTJaL4duVH3+rKBOF7dYxyMUybwH6Qvpt1NAuAc9Aqo7fTHU3JxPUVI/sTaUzoWeVghHA4cfMR447kJxQ05X+Afn7AFmtE60+bF/oz2lug/csfLaEgPbIl7p2HS1+uwv6/TbwR5rEOZZfO0bk/0QNSGSh6Ha6On9LEmEQwonS/T0lSiMvFQeDj6IzO8Pd4ocVjtb1JMlhjyNY9U180Cr4MhOJsOoKHD/s0l5zwvWk7rfkgS5DUedNLKJlIo4oVriYAPFEkg6PV8p+BfrRja42+p6BviZl/HsJUpsSFVzms4FcDV5fESoXoXqqR8Qjpc/HURoOAvUAPMqVR+xfTuYZZHZpsWUyitm0EdgDKnvvbOgEQ5184K+Fx2NsY/Wyyjun7pCXgGJWrDZJDZrs8Tbtqb6cQ/jM/lyS/C1EWYIoowK0pAfTaTbX0EKlmr0p9ulF55juTQ7ED3eU6jyf+bT6RnMiasGAFt2poeOW8f9ip6ZeZmPhAUxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMblpH04cnhG5hGNvi2ptnt5wjT0HNm3A20RMhV3DkLbUbssL3Vknw1cYz+s?=
 =?us-ascii?Q?YESX7uPX1GZgMHr2CNXfAzi0SYLcCMoIR+Uo32E7qjxq2iN/tVYf9rKakisi?=
 =?us-ascii?Q?JUT4fAHH/hMCg659DrrrLQ5RzmL3aEYpZEijSMisfxaejjVT7w71cCO3Hdw7?=
 =?us-ascii?Q?KoBR1s/df8W8w+hQk+niieTMJEuTJJYVE2UOeLmOkl8yWMq4P/CNIaeCjier?=
 =?us-ascii?Q?csBLIyZ7iaE/q30SzfmE3WrIexnLRNdaPhKFE7aVh7hjx6iYe4Nwjfsubbhu?=
 =?us-ascii?Q?SgyVGlcvBgbTWFlRnMF/lnzQfy+LGk4XZpxk8Lp4Z2Ojt6Q3EdrzOpmFssHA?=
 =?us-ascii?Q?K/NreREKNdJL6rKatXijSE9alidLDibOh3qE8U0j0kepSzROy9AYJVx1svdk?=
 =?us-ascii?Q?FzxltxtG8AUQjRZqynjQPpSZuKzrSGMa6YoAWj/AmbALCR71tDvEvYnZq7bu?=
 =?us-ascii?Q?glGTX8baFq5deiSm/kn2M3QayShTLbHaD+hlhk6kdDWVCXtM4Y/Cr/4zXtKL?=
 =?us-ascii?Q?E/l8aU+yo6BGl7uZcp1wL3Z3qCckL9eGeC2oaPGrz9epBdy5dCPEoqoPMFhp?=
 =?us-ascii?Q?umRHskTQ+19tSrQB5Zy3YNKkZwVug5WS2hgA4eZUAAozYyUG4kkd7KK3mnKS?=
 =?us-ascii?Q?ibniPGVABB0Ivj4vR1eu51Amytehncrxnou8Y+a37zZvP2HS2eKwx/TBhaGZ?=
 =?us-ascii?Q?JApNnQCKQjL5t0hDXmrIUbP9+uoqROsYZjS7KEbQ622z/jiQTb1LIXSrW8YC?=
 =?us-ascii?Q?VjWupTa2D56pPEy+jja/s7u+/XsHGTHLh0/J6nlWck6mQx8ZutJWeA2+QHrp?=
 =?us-ascii?Q?o1wQhxcSxRPh1PPMzucOxy/yqNPnmV+hYFlp0XcDS0LX4HCuGl+J59NFgK2D?=
 =?us-ascii?Q?CLVQ4CVJGO6t5nTxkrEdCq19Zu9tTcUIjFote0D9UOX+kgCHFFOhuX1p8lzx?=
 =?us-ascii?Q?/0r8B0aiZDRP7AM1erlc9zQYAHo3wckhvKtg+JPE0ItM/HrbeugcB01hZYIt?=
 =?us-ascii?Q?WbjkWWgI6Fj8a7tVVs1x74ctDGMSVZQQG94MBzMm4EqlyEb1mCF03RP/B6N8?=
 =?us-ascii?Q?OGjcZBYcvLLbJRiDN2YcwfV3dZCwdRaQg4ez96ODzilnE9N3lSBEuEZjwi4I?=
 =?us-ascii?Q?0FX73hdnOit/iKO1Gx2Y/qy/+gqy9YiXm3PhQPDYSZlVryPaJal0QTzOHvzi?=
 =?us-ascii?Q?YkOsMJju7VuqQWk22CNNM8i7noWwvi0XCfCAqXWHZGfpP5mwqyymbhEYums/?=
 =?us-ascii?Q?9tLQFFxEOP8h9K2JKuBStOU+IG61Pj3eSctWjNpGfjvcezJG7mKtJqClxHJW?=
 =?us-ascii?Q?RtHGc1W3gcawD5g8qoMj1f81ABjWVYtuqHZjRBPKlarfshRzGPUOa+q/JxVl?=
 =?us-ascii?Q?5BI4m+QW3LAhzMSWloVaZDUIjk6r9yvp2TUzTObU2t7vVwWDoFS6TWNhAdcN?=
 =?us-ascii?Q?d07R2g0OE2krZPO+LCaguqN26HTzBtXygpLxBQWAOulC5O2FpaCtTV7MIb1v?=
 =?us-ascii?Q?uo0C9YuoEypjzKC3CnVj8ptZu3hzX2UNWX3k/PCvDEzU0JitqZ2GlZNri4e0?=
 =?us-ascii?Q?ZjN0YEv2OPxJnilrIDk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24da473f-d3cb-44dc-f956-08dbfebee61d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:26.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx5c//P9RZ3KBkbGQWEROuIE5H1SD48Wcf9mAadFJtIPCTYUc8UF++SDS1bQDxcaiSXCRrhe9ej9dOsoMXAhIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---

Notes:
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie-common.yaml    |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index 0c50487a3866d..a8b34f58f8f49 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -207,6 +207,7 @@ allOf:
                 - fsl,imx6sx-pcie
                 - fsl,imx6q-pcie
                 - fsl,imx6qp-pcie
+                - fsl,imx95-pcie
                 - fsl,imx6sx-pcie-ep
                 - fsl,imx6q-pcie-ep
                 - fsl,imx6qp-pcie-ep
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index f20d4f0e3cb6c..8633c622bd178 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   clocks:
     minItems: 3
@@ -80,6 +81,22 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: atu
+            - const: app
+            - const: config
+
   - if:
       properties:
         compatible:
@@ -101,6 +118,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


