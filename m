Return-Path: <linux-pci+bounces-2389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07654832DE7
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726A11F2165B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68555E59;
	Fri, 19 Jan 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NS+WuN6i"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147715A10A;
	Fri, 19 Jan 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684382; cv=fail; b=hZsGFtp7PLcy6Z6qxwqSXwWQggWgbL7XjJZBMoc9GU4nzHHlxRlc1NZ9bsEWnd/7kASm7KyfI4nQP+idOA2/t5TMuw10OoBtxMdtzstmKqGrWRboFM7HqvWe1fQS98OSGPrScj1Eh+0Py+nqDvB0nrbQ+Zz7VEqAWWurUDpM10k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684382; c=relaxed/simple;
	bh=V4CkPmE5sJm/QKoZDeZ2XTghlJMzEDmmIDCJ574ZXAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJrWryCHLG6GAsm7Gw6ZbPM95NeZnZ5LpJRUAcbpkv+3ucAJMyDgSkAFAWj6sm71KQsZf3nKRc0Ep10yiI5+I7UmB0Hf8qwFP2VHZzALlFpkXq0gWrNsMMmvjr/1dRIyuMTCvIKYRkz/dNSXc5grynATYt7cIR8G9KFTFGX35AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NS+WuN6i; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF3jV7f8Lt1xNjTmPIqeidGKZr+IOdAMNm7+uAuK87ymkCSoYzCNO2q17ETJH3rPUhTNOzk8pQCnFX42obCn85mhEFXZz5b2w6rL+5Lbl9o9QgZ2hkR0Xr7Im5oHP7Rje2GdQzMb8SoMpHD9C8XjQBT0QCamepPKhZoU8kqvbeDfSbwIknxsNb5wYf91iy98O3ZKCkd8bGuGZnQ6WyL0q3Qzx9UhR4IE4BOenHQQiqpkG9PUtiWzg5fpfaTVBzClQ85PEepAdWy/Xpghybar7Vz4YqTjJjr8UF88HjOaDh3yGhq3uozhkpCS/ZfRY7FiJAw+4aiMswEmrgAlRi0krQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HX8b2YytgPKGFXPo6S0m3CGINW2GHZdmojsFID8CjI=;
 b=ZM+UuwSuFN+UUPQY7YtdsqyHVBgdkg4px5HdCKgnxgNqjBs43cY9JSpxiSoDTQ0uXlor8+s8VUZUvCn9XHFUzri8AXO+BGZS0Bny8E1SVZLSohxLG2Gbp5M72XtamuZKw34wsASeQ8F4R5RPdnkXc1S7rCIbwfb/Q/3tFmQgpao5wzy493GneZK27Lz14gXdVq5l1lmvAi/VSg4FaM3DGxR/d8IvT+em1czNaC01TGATGFemZLXLVH7CLQWRIUwcSz2bA5TklimgU1ECjO1TEIfag2r5hUyuowHlmGKQDofF3FanqXbbLKdghCfyOhPGXGZg/w+NvHQC2AQIidFGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HX8b2YytgPKGFXPo6S0m3CGINW2GHZdmojsFID8CjI=;
 b=NS+WuN6ir9GHfQxhYvP6tRx2652D0JT93JM4jyQKkv/yXEo12N2zTK08hbwZtyOEyPlT7iN1iuNaOJFxgOPjTFDSz0aTLLCxDujLI6yv0JlwpVNdJLt8IKvHpbRJ3WSDG6MIKFG68XrdVQrlf9rqQakUNGOoqp5CBEJL9fjFQIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v9 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Fri, 19 Jan 2024 12:11:21 -0500
Message-Id: <20240119171122.3057511-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: ede17224-77ab-4219-794e-08dc1911e2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FuK1+G4DMkmqjqvV5ZZWiGMFTAqKjv90mkVjRa+IOxya367GpcfuxqfbDaThVFb1DQ8n0geHFs/VCGDT0azpcDPMbbZIpwna11Epth9vR7bYY3Y+d6+eJnLzCrYRGHj0BtmE+fIDLHvX3faDCdE+jCKH+BFspJbAsIBZINaCRr2wWOrktv8SkYv51NYmsUT6Ks9B0q5A7ydkPxknc0qPlEzwVdBs1xBsUkWOlZGWdPdX3Oq2SYy1vwUZghtjSJPNuGWKNoQKIKaNAcNBP5ln6VQok2ERnLUx55h8UvP2+iwJ1Gv++7qIseqW5G/HSKEaEmT3HqzfFWtJiVl6VcSIsOhK0Dl4XvgqD5d/YSXpH1FSXGwwXr1qluraEZ892PQbZHZF5JovYBXsAy3kpBVgDJZhqEC1AhRSDZS+bP3s9enfExVLlvprLGwYQoRmmuIk8z1vDoVuN8gZ2kkwkJzkk9ydv+8Fxv05KbCya3f2sN9Dvp+dPe9nLnZuUHEFhs5lZXXHAkbaQus1IulUXsyNzcd2M3CYnboGvOf6Me2bhmFFFANi4uUKvNAwUctnl2qDG2pMagLK5kd+4JcxmWyOHn69GCKyP4PxEwHfdzTOS3ZWtrENTX4ZVMMvRrf12cv40SkakIqu//HqoECPIh/gMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGsbkh372Fur3nRijgfWjNjlWHYXkqrsaDzwnY2iIS6K1BdmdO7Kpr5ENC9W?=
 =?us-ascii?Q?19yQJK9nqTxAIJEhUQYTvuwtZJRD75zxb+SMIQzcykgQWCWJN7stFMypc+hb?=
 =?us-ascii?Q?O8Gr9KA0Ql4qWjqMVb5ACatz7/w2hD3xz3b156VBd5sMF1UcdBZwlKVis+IY?=
 =?us-ascii?Q?1YemqI7cIIezD+7s4Y7c+VUjvgINHuhaREkoNtbaq+f9XfK1DxNZNslVAR4J?=
 =?us-ascii?Q?DpX7V0VdapQmiCAxcQQBvLzYrw3xwxWpuVQ42500jSj7Gu633zzE7aieS2qo?=
 =?us-ascii?Q?xc71N/0zi4aHR6fBimLnvnD+Ov+wpGpjHd0m7tpyAi44o4Efb5A1TIVv+jfT?=
 =?us-ascii?Q?pC4U2Q9hOwe0WAsI+o/RFYQSEL+gyT0NZEhFiL34/whqim+MvAU1T7tH4LbW?=
 =?us-ascii?Q?g+sUf+ptbVq8oJyB7bwZAgOiK4htDw92+BGVhnOsvyblXx/qElsURV+bVfOc?=
 =?us-ascii?Q?+R8rwYbN0wM3jTDtn2Efno1jKNjK4wimukRRaqwnl0qpElh04sXVU9RRnZG/?=
 =?us-ascii?Q?DPHhSplDqYzIktjic4IsoCkI0mTkpysCeKEu5Hoawn8jOp+v5Z7cc3TcVQAj?=
 =?us-ascii?Q?N3GR8ZDePMRm/19LX7d5YFo/RDyD7Kfk840vEfhT90AGL4e5LFR2C3uBuA8J?=
 =?us-ascii?Q?d+gbrzkCTW35E7qf1P3mVtvhiareDMxHp1KRj7ksIChlcXYhzIN0h5C/48sX?=
 =?us-ascii?Q?s2oLLYgwyGdWfd+h+cukW3Ue4SqQnTOG25yeJmTFKmE2g1cUp3A8REzDiqT7?=
 =?us-ascii?Q?eTt56eQx4FWQkrOlFK+hQml7PHlVIpKZCWTtfhSqSKKDkizr3ik4mThrCp21?=
 =?us-ascii?Q?BQJHfSBibybh6HT3L8NItKJpk+Zgfemr0prd5N8KDSEkAkyw/vZOYIO567tK?=
 =?us-ascii?Q?TIB+Gh7gaWo9alkERAt/vtt1uO/vhJKyo2KilApxtsFRO506GQWI9MPBzddl?=
 =?us-ascii?Q?dMK65UenNQfDqZtilUYhelqYjqC+IvNCTYBFACwypfJNJ7Lx0MibuOsQ2UVJ?=
 =?us-ascii?Q?tS86pf+JUqcae5GD2Ca4pMpqkrdGh7iFKL8mLlNn4WTdYp7BLZ4ze9hU9JwT?=
 =?us-ascii?Q?oYHphnJgeT9gskX0BEOVSvQ4uKHiV2nFP0Gfh/RNczp9/FvDrsTC+1pNQ6Ix?=
 =?us-ascii?Q?lhwCHVqIj6h3eGiyp5Vv6fWflVyW/tXfia6gFh8f6tmWVVYvUEOB1z6opIy6?=
 =?us-ascii?Q?5MXSaAtCKdA5PjEpoKcQpwtm4cWkBx8Ti7LiTKzw1J8lTXnbRjkydJEwnx6u?=
 =?us-ascii?Q?dsN6PNcT6VtAPCvqAWlj3dlt0vr7CFB+54RWoLcbOd4iwPpmUSj0PwVdwVvR?=
 =?us-ascii?Q?4FqQt75Sr+A+evS/avWApxD260PAaE1lDDMp6QwLSK4xVom12TaKJLKQuidc?=
 =?us-ascii?Q?PPAZ1yZ98ADQVmRxmbTuWSrhYJYiqxE+t58NHRghkX42OJ+7Mb2xTbxP07FK?=
 =?us-ascii?Q?w2OdKMyuYqfnR0B+bawJ1+ZJL+ArF3xDSciLP/xb6jRO2v7QYY7GpQdmpmsb?=
 =?us-ascii?Q?WPzwM1szE1HTtrJ+/WY9JyGaoRbaXR6u/kFC+vlhczelgi9EoMGMX4x8qAQM?=
 =?us-ascii?Q?wHPMfe5ZceKvzKOtWnQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede17224-77ab-4219-794e-08dc1911e2eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:59.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GOfU1gz7a6/r3G7uRw+n9wMFZDKwfVcvvbXBjqjZ/dgzDoyzlli6eXKohw9ACGbM3PGLL8b7YUC4M0fvDCwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "app".
Reuse PCI linux,pci-domain as controller id at endpoint.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - add rob's review tag
    Change from v3 to v8
    - none
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 57 ++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..f4d6ae5dab785 100644
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
@@ -62,11 +55,48 @@ required:
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
+          maxItems: 2
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
+          maxItems: 6
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
@@ -87,6 +117,17 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+# reuse PCI linux,pci-domain as controller id at Endpoint
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        linux,pci-domain: true
+      required:
+        - linux,pci-domain
 
 unevaluatedProperties: false
 
-- 
2.34.1


