Return-Path: <linux-pci+bounces-1848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94872827B7D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C7282DE9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2157896;
	Mon,  8 Jan 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hmD77X1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03245811C;
	Mon,  8 Jan 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk+6uQ5d72MeFQz0cZROYjes1HqwSFs8l+0jkBdzjNeppj+j7I9osDS+689IMY6n393apbXBg79elWd/xtAhNv3O1JoEgvCdLFEPGHsGRVQ/4PRsBVWOESI9Id1NqOyUhvYgHeFfMByaQ/8EayixNwCOFVfu5mxZxpwjMJbSULWeMnKMxKFbb/fOaD/iogHdmbLYgyLk+kEH5BaxUzRzRMG8E7sE7dlTdy7xS3tSCLlSRf7QSpAb9bYJBZQagxZjnv7IO/84FJd9UGWCwbfRbbP+piQcBN2+lyZlZIebegQjYL0wQrzLi3nrR3LPl6oWC3OBd7+ZP9C3bbbwPEXBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNuEqwnvrUxPSqcjCvVLoRsw0bm7wK8OqtVGkt+aEeU=;
 b=lqpqnubsFBshAjutfJhzaXf4sjib1mIVarmuKPBHSC7AxhjMVsllc51fn1TLRb7MUJo8jYnqMPXMyOvHX6gseheENpLsl17KF2vnUOKwlYcf1egvCcp7sRiXeefl1zKecTBiWKRPvz8BD20Kr6euY0O2ibyR3E6jANmNdaC/iSup2gRgFDfwo01e9IiX6LS5FgPmsn36ZlQBa9eym5ospkfBd1WkVR0AsacVcSQftWpv4N0WUkFlM0dvqPvHlqU4gVdydp8Nu995qgsGzoY3IGdnPSM23HP4PJRHLcIKg1iRkmlZ4/aIrlTJjOAGaPGC2lyr6tpsZG/69hLJfU8EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNuEqwnvrUxPSqcjCvVLoRsw0bm7wK8OqtVGkt+aEeU=;
 b=hmD77X1KijJa11HJKZ3Rj5LVSJ1GmDoEyyDqahudBzncgCVJiNbKd2F1L6YnlQmXTOM83PmvB2s50Q7LJQiJxjcGbmllIQEbb5orpEzS56xw6W6kRxHndWKtm4lSOMKFo1dRcuRDZSEwCc39slsZWVZvLXZT05aXEjWu1YoZSFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:59 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.Li@nxp.com,
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
Subject: [PATCH v8 10/16] dt-bindings: imx6q-pcie: restruct reg and reg-name
Date: Mon,  8 Jan 2024 18:21:39 -0500
Message-Id: <20240108232145.2116455-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2238b683-6a34-4274-0db3-08dc10a0c0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a6yQvceb/7bYiRKHMg7oIJfOzdVHiK22SUcAUrZsDSLCTsLWkBMlUsZcsTzZNsRkyZJuAAcJDQ44U8OxsTHWb+ri2nzWdsh4Eewz/ZCKCmiOSVrx4meuEDVKXlFj959fO8HD0N6pHtlu3nJvOC1C/mF0j8Ail+NWaHHzGQ59OGymmRp6e5XJ6/v/pYFZNqcTID62cYLIIjx0Q4YybBKeaGDUuW6u0KLpYcL6eDsM6Ig/pUohnUYN5DTItqpecjvt3fZfsq0co+EJCz+KQH0uFXwrMdfW/aaCrc1081bcxjyu+0cD5whz31nuxiL4wiMP9Vwa2OmqWdB9XttqXUzWC30YlDi+d9MeJ9HFmLcVj1iTvzsaBiA+Y6VMUFaR5Q6pztBBQgVUoLcBGLM+51QONzSXO3p3pIma7PZMpGf+9TPDaC33kM4yAsPHsVlb6upJKCTfTT9M+FT6ONabDKnn8eFeiZ7IelqUAZ866BpHTzzVlEhyD92Sywf4s2oMP8r0TVDkMfQ5KlmXMmn/VAIKDzVajMxd/Vtf+3gu8BkUrwwzWeLkzzVXn/W/PZnsrGCiZ0HveUVT7ZVnUZlgQFB63YTHJ52NqFa/Nb3g4OT3ZPWWgE4JATmIONNjdCv1KlJ8KhzX+ppB/T6KJLnwelgE3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2hEgMfSVz5bxx3fGHNrUp2wbjqNwQJHrGrRHjoI4rw7ucfnF0AlfL0mmhNXy?=
 =?us-ascii?Q?cm39ckY+A7jkZXBRBosxOpYLYi23/4TZaYMMQAvDbRX2+LIfsdCK534H5NI7?=
 =?us-ascii?Q?NarPp/MWDxlxcgHAvr7rvRGpOCriEPJc2iX1mlA5X+n1cCD5Ik6KjP6akSf6?=
 =?us-ascii?Q?Uj8Cej/LRE5sjemSnvM++Bbg6IaqI4HPXbTpdajvN/mvOSdsptDsLXIBf7NX?=
 =?us-ascii?Q?YEUtCwQXOHnBF5OFuTMJpyz6EE4MVXqgD80Zt6VrXgknMoSnMN2iexDN13eB?=
 =?us-ascii?Q?cNJB+2U+h2ChBYXFLYGftgq+2s3r7d225cK54tObHogMrusIs904zqB4ZyfC?=
 =?us-ascii?Q?/WmDfTxqae3/jFLVlfV+TmyQ+JfWCAvPfIu+yWwYQFZ1mij4ZRj77L73LGNY?=
 =?us-ascii?Q?XjqbWLjAA1RtnajP1hFY3WJoqzw3qSV+TQ44fbbw8e5DE8TZYcZaFYQkvWYl?=
 =?us-ascii?Q?uMlnPQOZPwQcTSt7Lp44Obz1v1h3wg8AMOl940Q1A8/zNKgawAz/xv0v1lZj?=
 =?us-ascii?Q?UgHjFOtbiZ/F7es0sLwfAMxsJCcedah1KcM2MsclTyb7jnyNxCWXgB3qUBvK?=
 =?us-ascii?Q?4+6J6Xq5oFWljgXPQuG4C4M43Xzs7EiDbjiOFhI8H1hiSNGgXL18cp7JB8fB?=
 =?us-ascii?Q?SF7EB5GsEz8aIZJOclQ1/azQE9kO79/xJLEKNlhHHlyFNmYQiwHHY8u2Kl+U?=
 =?us-ascii?Q?tghHOtsPWYTU+7W9AJYdAZdTlkaFXu+OUwRr6Had/mhPLnkVWqpsKJQ1YCTh?=
 =?us-ascii?Q?9NNYgLLe2a5hotXOWEWhJX6Ax9BvxHBueIJ21naE/BnleBjM7deOxVVD1ne+?=
 =?us-ascii?Q?Da/zDfG7KVN4QgLduUjaXwmF7ww22KScDkJ0KbBrFk06PMcAEhkBtX05o0ac?=
 =?us-ascii?Q?skUgCbxU2bn5fbFh50ImwsYpLTr9CfisShLjJvI3bXU/HpNfrygf6b0aY3BY?=
 =?us-ascii?Q?0/xXJAb7b3sDygLrqiaDc8r5/MVPmB4dMv60IiegmLZ6UhiwEpKqnW+QjLnr?=
 =?us-ascii?Q?E9NiUkaWZ2WQF0kI6MGOnaFd55GfjD+elBZa8yzc8IYUuCAINsQfNPgBN4pP?=
 =?us-ascii?Q?gKO0C3e+eGUcD1z5BroCQ8Lkhr1OLzg3MCYvgG0gB3+WkLSdRVvOivkoplAu?=
 =?us-ascii?Q?fmEYKUpCRwUYyKAt4gGPPhIFMm+qjjWM1pBwh/KvuL1IPjHYIh/nrW3qJ0VL?=
 =?us-ascii?Q?vo91pIig6OK2Yjt/xtHk21GckhCT2sBnD7buFBHk9JVbjcE5yytoDW8pO0bC?=
 =?us-ascii?Q?yYu+zp3Wr95xQjqzvF3UQ9QDvwf8hDtoBE6lsOtMFQC3uUvZXeAJfPqEcuHO?=
 =?us-ascii?Q?EaKwJ5SLXZIKI9F28w6zow7Q+T4MrMaKczy6u7YJFBj/9lC67Ouavl3ZfzJZ?=
 =?us-ascii?Q?p8WrMbaiA5k4qVPW1L/JkD+2u+eY3guQKlbkDV1Mgy0suNgAallHC0ER0EdJ?=
 =?us-ascii?Q?Y8onA9fHipDCaE3OqdcIYqoPwwPQZXhHQqBQ4TcQZLwQSO0RXBpVOb6He8OI?=
 =?us-ascii?Q?uw1XeHPy34CuAYLgIK+DJF2zn30WeDME8eej/jIYzlxHJEjl9UwkAXE5QsrK?=
 =?us-ascii?Q?dmVkNsULRWEPbnDWK/2RnTPYT1AYB1N5LDZubsEZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2238b683-6a34-4274-0db3-08dc10a0c0c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:59.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swTA9rZtHSVJvN2GUODvypuxiV7HcpUx25jwH9LHA/+n04NC4qqwPQTPvBptelpd+ARueqTnY+G8x3OJchFMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Add 'if' check for existed compatible string to restrict reg and reg-names.
This prepare to add new compatible string with difference reg-names sets.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Add Manivannan Sadhasivam's ACK tag
    Change from v6 to v7
    - add Krzysztof's review tag
    Change from v5 to v6
    - Add if check for existed compatible string
    Change from v4 to v5
    - add Rob's Acked
    Change from v1 to v4:
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie.yaml          | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..eeca6b7b540f9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,16 +30,6 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
 
-  reg:
-    items:
-      - description: Data Bus Interface (DBI) registers.
-      - description: PCIe configuration space region.
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: config
-
   clocks:
     minItems: 3
     items:
@@ -90,6 +80,26 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx6q-pcie
+            - fsl,imx6sx-pcie
+            - fsl,imx6qp-pcie
+            - fsl,imx7d-pcie
+            - fsl,imx8mq-pcie
+            - fsl,imx8mm-pcie
+            - fsl,imx8mp-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+
   - if:
       properties:
         compatible:
-- 
2.34.1


