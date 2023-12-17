Return-Path: <linux-pci+bounces-1116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32D815D9D
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020D8283E68
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091A3C2B;
	Sun, 17 Dec 2023 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lt/pn291"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227A1097E;
	Sun, 17 Dec 2023 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzWPt2c8OzduxJZW0hOBP06BN8FLiVWmMoEmBuuxHZ9t4BZpUv3eARXFuyypjIbpYRJZpT0uPjEh22Kb018yo38t3VIDDZMDUSJ4QzXfyc0xOGj9iY7QLwBxnYYFhXcqvNEi8eWn4hZ672JrkywB53mgqz7pnAmza2u3FAfM3gZlI8oYF4vRec+MgNpy+y2zWgGYQDQUpH8I4gC1VDNXIDUF2jz21AZXaseFH/8wzhgRpRh6Xl7US1CWCKhGpnVQr6nUFxyX6QQPP59PuML3MBEhw0MVMawAxLeT1a5kDYM/qA561jPlsLBn3ZHF78WfQUwnbexsm4M86AuZQ4Ya8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63F9NxfXq3HmQYGZBPKTxEqddJisXBl3IIB1cnlRj6M=;
 b=C52CAR2HGOcHZKCqVjkCSfSmuhkddBoZdU+4w3s0ua2CrHzjw7zBd1KFjfIZCkaZ5hwiiWw1ek5lxqS+MAMOquFIeP6v/v6eMzYqjfU8R/Qy0sVh0TlzeSS5+rO71jummOnWwSdOYryQnqSybozy128bz9NnTEeLp//DLHtpDV9iek408MRU5nSbUkOyWvTJVChw8emBGfLDN5vIMJcC7GeEbAc8TFE2mUdkjrnsIeeiVlDtZwUWFfcIBJhT7DL35ADCBxodMmtljBt4+gCvNYA2FMoH5uGlhAwt/8m1+v7v5G0rpDUiL9mWA6EJwJHHhd/4rRZKNe7/CLWa3CD3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63F9NxfXq3HmQYGZBPKTxEqddJisXBl3IIB1cnlRj6M=;
 b=lt/pn291ACq4zRotcITbAXiXxP1W4OzTOG2LFPuhd4593Jdu6DSoc6tesTFfmXFJreEZSPmHuwN8mFUqiqHUZq1scL5WGScL4gnrR6wgPZGLrJBhmod5RSFleWnbD5TKDOWKvA3GIhA9MH/W9nCsLQXqy5EywITNjJIpNxGLsZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:46 +0000
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
Subject: [PATCH v4 14/15] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Sun, 17 Dec 2023 00:12:09 -0500
Message-Id: <20231217051210.754832-15-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25ebefff-68dd-4507-538a-08dbfebef226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yKzATpVmUoZlDvZHiiQVHjpr3ReLc7d9fSrq6TJ2yxL/OB8LKcP5BubqJUkUTsmEh4EyQNLg9VNFUKA7kEHNi9XJ5ydnaAFCoyNZiJ36NB4xeK2S3QPAs+GSOOqMMRRB1uBO0P21/qjjhv4rm0SgNU++d3kf8OlcQasnucod2/+BtL/Ykrep7VB3HR2oyquJ7fOy6Aa6lFnTTIOgFlhhSu3IZb6gLcRx72UlULEllyMcPn1Z/Or/YEBNM3k28rGgdj5KbfQCyy5vCy1/W1WblPXXQkmYDkFGcczR+13pCdh2Gx98CMMir41z+6kcGKjogtpyDM/L1ojHHIjFYCTqFHyNapufUtQlp1o4I32hXAZiRaxNK6GCOgLCk0aIU39SwnXCRmWIA2jDgdOd2Wkf8myKbvVKTequrKxD8flFVwSvQFGN2J/l7a3zpnQ7ouXioEi7LKHccstWA4T273Ws+lxuVOzOLiVFgPemFJzHBu4TRs+GWYd7S3jO6jeJtQVOvZSo5NdLgQZXAesmikh0/rJOWS8kYsrQXBD0n/N9FnCq2jszKUBLACEeipwGxk+URR30ft8/z178vUX4itSGRKd2w3bF2LeSii1HO2Gf7mC3TjcejpX2wjHTiZxwgcdjZG/m1YwKuPxxjL9NabrYXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NO4mXsUw4A6lPUxrn/J0w46MWuEixTNhHPSAvWEf4dLFtXkfzHNde8iwBkbq?=
 =?us-ascii?Q?fyVI4KvziYgFdfefLZDiIOvAQECAuxR6B6KDpCGObEmVTczIR3heggTzhdyR?=
 =?us-ascii?Q?3G8+nUgjcuXlqRAhEFaZsy2CsDTgTVkMwAkpJjJHCn9Wj28bYhBnnMS9cBR9?=
 =?us-ascii?Q?BpkmwMfYxKZkSTNKeiGDB3JgRW9RYLTfeLo6vaFCSw/ntxFKP4nqrhyozIgm?=
 =?us-ascii?Q?SAf3cZN/Kki/2bSwaSl9BNZvJ38Hf+2hF7cVl3xN0Cmywwsp9gCUXX1EvKnK?=
 =?us-ascii?Q?sFCe6XjRGgf5XmLHjvyxrp0vl4bD3EGgRwL20ZOxFx8MU5TChn7m1pKt479a?=
 =?us-ascii?Q?RBFkBJQ0eD3NEI5PHyEJXxGTRIIKnXbaw6+oP+0aIPvG2BQZMoIkEwT1EJ6d?=
 =?us-ascii?Q?7a3MB3PFI9V54tyRLOw3ve3u/VMcYe96buP8drgWSLvuNPcVYre4oHzgfZUr?=
 =?us-ascii?Q?mYJ9bRO7N3MTG0QbeQ5OLUH1O1oq3WT0CrOiOUq8ZCPELfT+05+aIiCpmPol?=
 =?us-ascii?Q?u+iMeXNLXRH/qhJl5Cnz4Hob3LlZ/0uGprnVuH1NfykIOjKM7hIIwvuNUKA/?=
 =?us-ascii?Q?JNouRcHHb68q2/JYSwhuxd1js3YBCYm+tPWwd8Nxp5ISdngokSAgMai5SaxU?=
 =?us-ascii?Q?CtVYjegjBzl9FyF/GtC6DRDPmyoxuQlbyOezKt5i4z0immBOu49NRHS69xch?=
 =?us-ascii?Q?4/GnB7HGQLXu7eILeSNTbGF0i97wG2JN/pXNDcT0nNS3eaFqHDFgsxIoiO3V?=
 =?us-ascii?Q?VE3JbXn/tVh4L8uTnlOKtad8vMQYRnLoUVNlFDWNegV/hIb812Dk3EUDriP7?=
 =?us-ascii?Q?1x8o8KuvJfmme3tYTUNwnPCC/0lTJumsN4Ke4apQK+7Kg64hEyMlabmPYLih?=
 =?us-ascii?Q?HmmfZ2r/uld8NigELdTWtfaQuPA+1QMy93DebEkWurp7932G5jNoXpU/Ume/?=
 =?us-ascii?Q?D6R9u/FmPsSmykwMDx8bC5SBKG5CIl8gltiV2hqc6Z1b9zyatNlkPXjlV2Wq?=
 =?us-ascii?Q?lHaErgCXqo6euIIh1IRX+wrs/Ifav5gLtgd5xd9NxvrTmKaJAjd6zafsmR7w?=
 =?us-ascii?Q?r7tpfQX4y/R1QY98j2eqZhywjQx0vMXtLDdNJO22dv/6eseYSylMajYVL/Wm?=
 =?us-ascii?Q?Yc9Jpx4BUE3D5f3tBWTh9beV4nsKslapT7rPanXuDZUV+oyygFiB/Mq4N+2/?=
 =?us-ascii?Q?9dOmH5eX0TaUSaTuNFszKrd9mBuEMz1yRhCW1taEKNLWyJnZ9zAVITXc25CK?=
 =?us-ascii?Q?bKx/wBmRtAvYq/exqvN6olQoNmf3jUXhgrEgjr4x5NhOS+an0gmCjLJDsNWW?=
 =?us-ascii?Q?+M3yiKTmaXdhZWgAZiZNVusJnw/24cxMleU0lPshqsjDcqR4miEUeyz5Ymxe?=
 =?us-ascii?Q?swOu1n/R1pbmTz0G5e9pidrC1Qw1mS9h2HfaAgQraWyqhuwd5cu9EUFCgciC?=
 =?us-ascii?Q?3J4mr847/iB5E5XbWj2WgojCPmQx/OlPoJrY05c40ESnWR348i/6jB9MKQ++?=
 =?us-ascii?Q?XECKXbqFfJ9xhdgfL8nvyqojGlXUE6fBN5kWSyJYAaQW9xlcMF8EpdlHCKoc?=
 =?us-ascii?Q?S27e1wCazilojBwYEmk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ebefff-68dd-4507-538a-08dbfebef226
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:46.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Zi4DUB+PngffQo7/qI+EdaoFfGLvFYak4Vx85fhA9uoLSlWfCwIjHVTj7qPUNi5fJmxtiEU6v1WmwsR7epicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "serdes".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 52 ++++++++++++++++---
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..be9ea77ce8548 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,14 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
-
-  reg:
-    minItems: 2
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: addr_space
+      - fsl,imx95-pcie-ep
 
   clocks:
     minItems: 3
@@ -62,11 +55,46 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mq-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 6
+        reg-names:
+          items:
+            - const: dbi
+            - const: atu
+            - const: dbi2
+            - const: app
+            - const: dma
+            - const: addr_space
+
   - if:
       properties:
         compatible:
           enum:
             - fsl,imx8mq-pcie-ep
+            - fsl,imx95-pcie-ep
     then:
       properties:
         clocks:
@@ -87,6 +115,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        linux,pci-domain: true
 
 unevaluatedProperties: false
 
-- 
2.34.1


