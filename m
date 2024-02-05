Return-Path: <linux-pci+bounces-3100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB684A0E9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7941F21305
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F11545BF8;
	Mon,  5 Feb 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMJJCVse"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799894A99C;
	Mon,  5 Feb 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154477; cv=fail; b=TkSt7fJPMgrw25+pQBM257V0P5g3a5KQySg+pl8I0bRt2WHaOCh+c8t8Sg0M9mmEqSjG22VixVCRWoilVNjDiAlfV+1w75QXf6LXChC7YiH1GUj9Q/LhryvWwhPsn0gI2ZU2WlZ0dsw0MHVkxQ224rOF5vUOOHqvEqAcO07NIts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154477; c=relaxed/simple;
	bh=T1x+5xu29RBCLNUbh74bHFYM8p4OyU/ZtMVQlC1iY30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6XCz0Szz15ZWI6Qi90vsOXIh3KM0xoYEJm5Bm7uj506pvPq1sup2C1ZRLQe1nQ2exoWK1J6P6LzHMFKxcucdDzvlNv+qSPbNnZXuVM9YAdn+4G8m5Cppxj/PAl6I4tIITpzVZYsVVSG5KosKtq5ptpPvSOqxUNy8CcTKv1qnXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AMJJCVse; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpHMkD7EPj4Xl06T+AvHdP760hIV3IGLTQyeHsizhRI7fUditbQkm6aCbvLCOgIRtewZ01IoWUCn0Kd6juVCzbSiKVsLrZI2Yuam+LnKmx91JzZgDO+ImIgpkOkpWrboZCMhJ88upS0vLNDWXHWvhkoA6rUAhM1+yBgD8PhY1DuU4UnX/vvo90P5hlyKcD6MC+9l5TIMmVeUnOtqMoMJlovr5x1fUcctSsVJ7J4gef6rbeg95Wzb1Y6G69+hbKC9RrDGDWrsyaPnw8isC+WhUFCyDcjbMaP3ujQv791G+aPdhuHaLPjlfYbJD1LEUcuY8ZPG8sZLkRuQQbNK0DR17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZNTROLn9E87k4rdmI3GuoHZlLbg49vzGd/L9dvhobk=;
 b=Fhu7ftliVjgs1pVkcl18KiMBtpLa3FAEDI0cW+y5UGERz4rl2cFGp5DtGqbJlLIlm+tQE3uxcKAE3aUISofmnyMS6yWV6bHS8KBL6ZgGpda5X6dR309CRRf6a4KmeuSjoRKC6JRha4AojXlrSx+MqZ3OaLBDTvDgIG1EVGz/xpURbsOXRO9CSBZyJD3s8ERsPxyjfaMda37LjUioiEe/QvtESAmEbcLn0f8dnVS5vx2MH7vL8OFX/v9pggdoGVNaE2DEGf7kuTlBLrTO9JXq/crCTRtH6grIg27+1juKVw5crHmt1UQo4bK2T+KPhu15JEnWXJ8FHzDpaEMsf2DllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZNTROLn9E87k4rdmI3GuoHZlLbg49vzGd/L9dvhobk=;
 b=AMJJCVse9jBZ4rYnfLT52R+JPuMWNVhDt3rFxz83N8HngaZLePFXGz3QT/iIhrxN5nBXMep2o02HKo4ugmqeaXDVlKvjWJn+ZN7FUj7LcKIU1PTNIKYYaKSAsEg0OtqwJtd06bBqK/AkBSJtX60vGk4ykndVe9oAXmi84jyWQVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 07/14] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Mon,  5 Feb 2024 12:33:28 -0500
Message-Id: <20240205173335.1120469-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5b7ccb-8f77-4538-158e-08dc2670b51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mQlUgLTcKxnWZ2vgYwokOD+n7XLJQWOMQ9ro9x0F7TX8HEskZbL99y4L3ATONcE8ETXPdRY6VHgZg1qFYMaIf09drFmod+N6GgPZmhevHJiKhqaPtVgguO1LSU8hiNSkvz68ojCXP1BIcqSIo5rdxPMZj31hUAjhFOjqVEPeMvD+NDCW9IsL9dZP/vDZISdilqpjl26CC09QlnG8is7MZrRUAs0na/PaJdDGS3OngbVYAvZNiEdVzWMiZwLLYBXhRFeJRap/4MpmAKvFOnC+vOXVKC54eq2yoeGhfFGCNsT1ROTWVjTGgM2CZyHtCxPsP/ZMc6AdSxKQWX+YJF9r1Xeo5XYvNKoqPNi1RG9df7WDrinKHpGZfNfbdJmcJBPYd+Q7iN7wIPEmTjWBqdBiLoRRpOcDXYS7p3B2vxhRSek8jcQfXAc4g4UgzQtz+us7NafDUXWlPmW1jAn0Mn8VC/7jHw4fxhl8XakgU971ZXDi5Ya1jb9pGB7W3lrAAggjKtYjFKF9wh5wEir1LQPTiQhm9Yop13Xa0J6dirGxyUMKe1D4VqBV6O2YpqPTkFSGbctVlt76XImRqDRVKaN1gc3gC0RWpGIktnb2r0H2EI/kQ/ECWqErt7ivzSVgT9TP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uOYJynNAc2tveKviDfu+BeM3OZPdu1oC6GVp+AmqJvKyxwfCLe1ZYf1bDAaV?=
 =?us-ascii?Q?9dXn7u1svUvVkTZ/AbdyzQmwwf5Y9BtLxTkpLhEJaFxw3iQv7nEx8Grw6PIp?=
 =?us-ascii?Q?Yo+uNH48nKOCsegPrhtn9ZWMDc+3ykNRfJiZhxz5xc1T05xBguD92wCzdJYB?=
 =?us-ascii?Q?KYEwR2JI9w61m/Gt0ul70jKEthtkk1GSLiGYTrh87AwN+R/XmGL4f8xMbwbw?=
 =?us-ascii?Q?sc3VrI9UnteBnE0iBTLTNsR+Myna0yLd5kh13kTDS4fMsPImcTekY4jTw4pX?=
 =?us-ascii?Q?pa+gKLzgtnvEwV9PUYbtW5z6p3OpeJdBERl9EQnfOeErdOwh7U98vRARXzGY?=
 =?us-ascii?Q?H+CFHs+AREXt/3K95munYDcY7Mh0zYYv2An97HUiR+ealLA8wrcZAf9XcXwB?=
 =?us-ascii?Q?+eRtWQ+XFMrsgnXcYxF7IKWnGa/0AzTaeRlPvpQvTq6qw8zT8UbhflpqjwhF?=
 =?us-ascii?Q?Z6hleqy37zPPsoNAOpt7NAJxVIVl3U5zjqCc5PzXmIqasAo2ReaCzmxOTBGY?=
 =?us-ascii?Q?0JLwgV0bYeS7B/wMqJIIx7yrmi0NuQKSv4+MYavn96HPOkYf+Wg6QwLcYNON?=
 =?us-ascii?Q?a8bOQFdHm0onS9HZ1vTCJoHZ5P0djysDtrWx+3FQXSOqRsaUgljhEB0vy3ZD?=
 =?us-ascii?Q?2GZRYEpn7YvYIMthssUs4GSW4F8IM0cbTXdu/bW54i4JuW1rpotqbD00ALPM?=
 =?us-ascii?Q?adU4XMrt1Ib4d80qWZcJQStFcz8fj2tseEKz5+xNjZfxyMLXbrYXUbbYWBd4?=
 =?us-ascii?Q?dMKa5W0cnQaOYahpW1WqXM6iZetzkB1aaLRkeqKz94USXWL2QftCaS68JP9o?=
 =?us-ascii?Q?fcMPvHk3uzz9YIvY0cEFqPJNuEagKhc0jXAi0VTQyOWvBrLntCKzBYO0mv1z?=
 =?us-ascii?Q?TbJQ9kstVvu0CNacUorucmY1cBBxsvU39oEO21iOgZ++szzoTS9oCI3PF9BH?=
 =?us-ascii?Q?HFTQ9xK8FyiST5gLp0mJGwYBv/h4iBLh44WRxZrvA7QfyKCQZwICQ965kBfB?=
 =?us-ascii?Q?cU3OnHzW1AxJnpsehI2d7D9QorhPwUIJP5UOrcChBzRqfP8BDS0NYvoyTwBw?=
 =?us-ascii?Q?JpVBSXG/RHvllv4tE2Bn7saJxeUnfSUHFI4jnnevUZ9vFHVfT1zdqzodB+Dk?=
 =?us-ascii?Q?0qw6rYK0+3XGLeYIGVE76OTo2NrS/EkHyh82aQuaT8cc5ZIG2qPzHLA2hjGC?=
 =?us-ascii?Q?BBlYvD7cxd5wvf6Q1jBKvTsGmqRtINz94DDSpVPobq9bxlwRUqFcWU4ehcjP?=
 =?us-ascii?Q?Fze22oUQpiYahdmgV7VyltPAsO925OJFLsKgbq6m7sdQ8XMYkXUxEM00fAAz?=
 =?us-ascii?Q?4VU3qDK0vtjfY3DW2bZF0bxCyHdFMyZOw9DKZb9MVU37Dqc3bOB2yD8PJqGL?=
 =?us-ascii?Q?tOhaTxVprMp3XYTNtpAoUsHlh6Rsdxtgxsj4cvUIPWBNcM/lWvIEtQcJr+UF?=
 =?us-ascii?Q?nLTpkm5cLiJg8Nb6oGxh460bJFIP0UJiJyfsXXjkTIUqqojUbfrIK1JiZNSs?=
 =?us-ascii?Q?GwdZ3F/lQyI4JNfCl1Xq7+CW0n7LicjFgC3iMAo1EqQVGcZUjLP4d0gwcNYc?=
 =?us-ascii?Q?hN3tSFaD0JBzbW+QYSZf2q+Hww5kjT2kwu4v2b0v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5b7ccb-8f77-4538-158e-08dc2670b51b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:29.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epTAbzyG+z1mzh3khicLvSe2QRAPoectTY++ce5zlqMKZVJ1Il0/2H3WYnkvnPBjcHYGawINlx2QoXG4HW8m0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

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
index d91b639ae7ae7..0c50487a3866d 100644
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


