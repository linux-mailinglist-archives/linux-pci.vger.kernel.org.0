Return-Path: <linux-pci+bounces-2383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9223C832DD2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191BE1F212E0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F69E5823A;
	Fri, 19 Jan 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WWM4Vkvz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F658239;
	Fri, 19 Jan 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684354; cv=fail; b=mn4WERltXKqSDom89iQs94QHXsSROXpZcXX/06kIAOOueF/qYBiPXKPtu7wsteVjLpfsJBmiFSHSSLWTCO5+DU9BbHISj2QXI7y4/CZ/To2LtnMCKCALQDHTH8727oLT/fr+k9nuumQ7GmwqUcg62awx1kQTLYaSkO6bN7N5GwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684354; c=relaxed/simple;
	bh=4U0EXmDAhWt4Qi+hY0ZhmgS1j1Ag5H2B7cHjA0y4ur8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRyxec23nL/n4XLbAOlGUsHLu2OkhPpqHqA4sGBh934+Xjmh/2dxRA4m3WY1ypzwd0xDA7F++IM8N7sm3qhg6emWcbrRd9L5JrjJXkcj2m83uwpPldfK0uXQTW7TM1p0U7MV8iodMcY2OukIkirT58TB6mJzRPlkl72DP+QQVOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WWM4Vkvz; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR2YsnoRy3HhSWtfYrwAQXmRtqxy5UX/wUurqUnwuDZ87fMicWmJRt71LPexxvY1joLxUCJ6CUCZnFcwYRcrplnvHJ3N2mW8PgYq1SvjgUd3iZlCINMp9hoPSbGQ15Hn6cXUA2j1JE9UuaK63eQNuIPXMEhNFkR0KmaLJEbJ1Y3DI5XPC8SleS/Jom1+yNbD8KmE27p+ZXZICSVB+NfBigNZ9QKk2gVLYY3/DGnulYHB9UEU1dYlpjQZwxOf7nQfbKEwpAf1N5d1maOIkoZcz0IA1lzEY1iR6vEPICk3QDRJURb5lETXRp+4125g7GUF0fXM8sf657M4sDOeVtn6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV1LmGPihazQf9EcU7o32Xhyn4PgMLg/E0OO76MiU9w=;
 b=X79lsG7HdhqV0uM1g3iLFiOxhFRYvINgpr9qBacjCxX61TB/GzcS5G7Jyy4ZNEk0h3Qgf8oN/HqD016ShWZ0tDpv4foaJPLl0NMVeGV4KzxyogiKJKwP3ar3v6vWJYZf7lQCMz0bI4VAmG13odVwnroBvE/L+DjagNOv6bI69xHiVBNefqBLhxtWVyK3UvqyOdAS09yy/Ged4k6eN8ilVMKFYzbpRWFc/1vPXe/pEr7hJB2C/cbwq1PpqGHTyWwBt9ecxq852gFktJ4U7z7ZgRp0UxQjT4GH1cEX9/vNOQq9yeVJ3KACBXK8YqjmDkR7XWxZNjmrrxz9fnhPwSPrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV1LmGPihazQf9EcU7o32Xhyn4PgMLg/E0OO76MiU9w=;
 b=WWM4Vkvzb4jAoNpCdtx6UN/pB2J82TA26kg5GFGEcXk/6tIaLHIloV+ioHyLXZPo1J74N6iKs4zrtaLDc+B5ym2rTfvyqeVglbH2CtTQerDihUyiwi7yGkbwK1T2+86cNDHX+JPvC5Wi0deJ4yF+InMRQPQzBpAza9t0z0Bxoho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:29 +0000
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
Subject: [PATCH v9 09/16] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Fri, 19 Jan 2024 12:11:15 -0500
Message-Id: <20240119171122.3057511-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: aefd7b9a-dac0-4d6e-747c-08dc1911d0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rPPMIaSt6OuKzcinSaET55GwBHDrGkbGK4tAIcFUvqmDqzwodCTxZWciNQw0TzyH/s4dT/3WFGImygqWrWzkLmAHu3w+ymvMhbiAyjox/lG0av2meFqIs4EJrzc/T+ZqvXMLejng7Jf42Zkv3xzzZfjTPfn+zyueVQB5rrG2ueS7b/j3C9MxOwdWkRa3pfqBJKUFKZO6AbLyoS4VTYtOvgQPyHUNyz6p4R+FXyWVbJ2HmM570mBiLRXjir7QLrfZZxhhOOG87grvKO8NC4qqcM2iY8vyrMHBvlYI+vv2pIKZivXpCBg4ucnmiybCgMezFg17rgIabhSajP0FNgGwn11mPfn8HXzuC8JFlRnOD8OTQEewCnkcGyx95CkTEEls88z3g0RSvnow/3N9Tpix2oVf3gzl38T7RoExamZq0Sf5XPup/4jqZ/1GppPdyjdzH2+3bk+uYND0Q2eFgnKiJ7IMX8txeEGc2D2hHULU0kBM+IBixj1upzAXMJsL8YTV1syaviQfC+bY2KQnena38xNTBW6WfnGkas5FLkc6WM7s7abam57QnVHFgtAAWcZNPAJ17YXAhCADqHaietIWkNTnKoxfbnQI2mRJzGTShgd3fHwkLaC4rbU+Q20AE0jXKa8FQED33q7HEoXK3P55DA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64phxPig3b34AMoqLbZ2NUyJ51kVlqKBKCdKyz2+SSZ81KgsgQzyn2H14YmZ?=
 =?us-ascii?Q?ImAl9izqtVHXiXulkBTyCpbmd3pKvDIpYflU0tQRvVFfFgPrmpwNZNOH1IV9?=
 =?us-ascii?Q?dnMHQp3rA08zT6dPCOgm/KSaOocMJvlYyBrdWE8qee0H8oQ2YDKhdu/uUZY5?=
 =?us-ascii?Q?3vpzAtfw7xNAUPOQ/zWwywfQiLQfPoQkgnLk7k8dpP5NAeTRnRMQlKvPZDz7?=
 =?us-ascii?Q?2Eadc6DKoCVYPbE7TuMR2+5Rvsm3yoHwSTq5iJxCPChUv/NtoHcsZRyCspSL?=
 =?us-ascii?Q?dU4Zm4R2GY0D6Fa+WNFENBg2J/GYuiNT4Kamj0ye5CyDMD8vLekJixTlQWcA?=
 =?us-ascii?Q?oct3P3mvZvIbZTnG0utqjqq+iJrBZWtGVmVTtUJce8OJEdPUVNXMON7N7DuX?=
 =?us-ascii?Q?EdR6/n/+R6tERBLIZ2LFBnfAzfTCSLHZkJCp2+/G2DJp4yjc8yGahpInPndx?=
 =?us-ascii?Q?FFCrnwIImxQjDD9oVBuXc0AWLffKF2wEf81iXiLDv7HsFqqtyxhGLu2OLRo7?=
 =?us-ascii?Q?Tm48+tKDw/k6UQUrGqTT+qE7HBUpmhf7OOCna7SD1e0zaI7N1QrQtgUfRyby?=
 =?us-ascii?Q?FGqhOvATWHUYnaAV+ZRSpyBbbv92IGRi7Qq1CBFWg1HHDYj5+eoRigIiEfVX?=
 =?us-ascii?Q?yCkIezibJNAzmay+LBLQS8vnfMwDOJ2LU1vx82So236s8PFKH1UTZp2VbSP/?=
 =?us-ascii?Q?U/+R29Nj7jomcuzGUUclRsno7w3miE3pUAdAq9zGLr0CnGzuAu9gdltTyvrG?=
 =?us-ascii?Q?+yHOmI1S35uZshzBBrNQJlCWLaHfe+h4CKH13ckBzJzliD8LyypVK2foh+a2?=
 =?us-ascii?Q?tW7PiKiQ4ZDBbCJFifKrdX/3qiPqr2c87C7S8NYe8Pb4k93lveqtJjAMLDod?=
 =?us-ascii?Q?UsnmFD5MDAZXyJBKgHKwPvT/vvjSNW08DDy9pSvet9z7Rwgc8PKFm2OGisFp?=
 =?us-ascii?Q?vK077f9Zqlo7dF+OC1pH4uyHvZ+w9mbyQV7I+W85rvzB1kMHFAJUK3+I/zoy?=
 =?us-ascii?Q?eVlBxYcrkHN5D/CGo1zKI++bZ/yx4O5Vw8dH47UqxRLYoTOqybiznrJZDuz3?=
 =?us-ascii?Q?9/aS3tKuwKkauBncw1jymrf4ujWem6INHswpNYSWpI33TTDCzXEB/V6s6sub?=
 =?us-ascii?Q?F9aZD2rNzCbun3kVKX+7y+HgWyzlGspmfDuRZ0q3UVYpr7aVE4fs82J930s0?=
 =?us-ascii?Q?TltlL46uHnECF37SQyqMEGU1HzW0HHzR47pnETNHrk3+p/Tw6uvikaMTnrZV?=
 =?us-ascii?Q?iUBgUEMIqK6JIQIuz4xqG2l6235uesgL7qy6sjUrkIlBBpVpSj82lwFB0Nob?=
 =?us-ascii?Q?k3i5x0EWPShTK8IIUSHtUu7uNLLNloJVHTBUDB2PorsVu+2qVV8czWCmVGC6?=
 =?us-ascii?Q?svp2UvsABspppn83bzrq58dNWXA4PenNKpVmeN4PP1NQchXfHddZi3ndhkDk?=
 =?us-ascii?Q?PPZDxDhUzXKinQxkPv9pAn05rTChIUZTAdflqiFOmoDN8TPILLrTKybSLUga?=
 =?us-ascii?Q?hzoD5j/MgpQxbE6lAshoNl7DhMiYlTBeXhkJiNycz7MKT0Jn6hcL25M9j76c?=
 =?us-ascii?Q?zZt13x9XNzfAQ/dIFdE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefd7b9a-dac0-4d6e-747c-08dc1911d0dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:29.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOR2yOzcGBb4OSYAHCylSwd9UILCIrTmzooZBj5wnPsWlkN9TZHwgVKekTGKKe5jVwxUZqURRUE8iYIPoBS3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

The bindings referencing this file already define these constraints for
each of the variants, so the if not: then: is redundant.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - add Manivannan Sadhasiva's Ack tag
    Change from v6 to v7
    - rewrite git commit message by using simple words
    Change from v5 to v6
    - rewrite git commit message and explain why remove it safely.
    - Add Rob's Ack
    Change from v1 to v4
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie-common.yaml      | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index 8f39b4e6e8491..a284a27c5e873 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -150,22 +150,6 @@ allOf:
             - {}
             - const: pcie_phy
             - const: pcie_aux
-  - if:
-      properties:
-        compatible:
-          not:
-            contains:
-              enum:
-                - fsl,imx6sx-pcie
-                - fsl,imx8mq-pcie
-                - fsl,imx6sx-pcie-ep
-                - fsl,imx8mq-pcie-ep
-    then:
-      properties:
-        clocks:
-          maxItems: 3
-        clock-names:
-          maxItems: 3
 
   - if:
       properties:
-- 
2.34.1


