Return-Path: <linux-pci+bounces-17320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA39D92E2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96195B251F8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462F1B415C;
	Tue, 26 Nov 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QwhFZdHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F7199EA2;
	Tue, 26 Nov 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607880; cv=fail; b=J4DKBuzLqki0w0PGwYeclj0VqjCXzGeK8Voox2qWuk+X4+heQG6MA3RN8LlvJKvezY06J22xjL3Dp3M8v2F0HHhJfsHMD2QX2R1wax7+7Fwj/T/i1LARMzZodwlZG562KrwLy61iQCx2Qz0E4A/6pU+TyUFAQTRGheAWfzntqpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607880; c=relaxed/simple;
	bh=yNRgOLn1KtqgTT8BbfwpEgHDaCKkoEaSE5AjeGAkITM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOR0AYoTyg4HxVgzpnsKohEh6X4azulm3Ehjq+91zYOKyVA23K3fAp5GsZMYeMUHqjupqlX4Or1jw2XFuLxKt8XS4JiZkGUcSJVoVVtwk2SSaqu5/UqINYI15ssuxLNOuDEDvmolX1bN9KvnJ6+yTvcWfK3+vQY43t6vkTmE02Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QwhFZdHI; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxf6O90BNQZs9pjOBM1q5z3Asu3NbiwZFe4FQOqQcwHBrtq8wGGXeIi6yJ5dCJhS8i3pFyOEP94lcl1QL3O6GPrOlbslLDZbjVxe324QuM/VebbIdkm2GGpa1Qf/NSZDCOwmi8zYdgO6Ih+alwBBo5gw7FBUfnVVCoSRynVmWFiy3CfembxSIUDH6iNghPjL1FAsu1P49EraYlBflTwWiSq0LbrHYeyflUc602hxyckDZc7C4MYN2Z9gdVI6E49WJ/q4d+Bsc2+PONvZnTQ321EXiNeQxEAp9RYVr9aD7zJipjJI6rYk63VWL2NuSrEhUZyeF5JJBclMeDE2+smDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK83ClGL/0mzmv1DjwZHG0YlibQLXa5eUiYfMl6Hk74=;
 b=nGaB+rNfjpQg8hX4oa1lXTJLO9hzXbSHXq46b9DlaLWBKCrKO9u+IRULNgHYR4Eq5WfS7KXe3BQWZS5L3lFBHVxhsnYoTRyJzcQNZ3r815kdWkX06wL902DUR9EYnV4Xkx2aQpCYSc6GVig6Mu3XuN/QSLzOkA3OzH1nKF6FRdpbvyySiyRlIYM2PCEHzrsSIk7mdEqDApYkBHL24IuDL1J8dht7Bou9pCALxJLPagnbzxKhiuC+6PcWBcY7xQHslU4/jBju2vhmTF2mq6eHt2zRPhCN6TE+fDOywwHXZ2hvcvqHtzkM+5j2Hl6vHjb8T8JiBclg9DhRcv8VlhJPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK83ClGL/0mzmv1DjwZHG0YlibQLXa5eUiYfMl6Hk74=;
 b=QwhFZdHIMq+HoelgxoAQhiLRvu7le/N9lO2Am9UytavuHLn3o5KYrdren//8puCkPAOSD0yBYkostafrPIHDDmv6dWXFziDD5Qzd+L5q47oVBIEocKLRpx7SYwr2ZcNqY812vJKciM56suJJ/tLq87/G10X6pYmKLuoJH2NwHwsexqDOB42kYzzua3cgLXFZlm1NeG5FzdnfbOtMLPJ1TKTSQiAsGvZYHCkyjiQq8aC9GFd0MFAsuE+umq9aaxkqV9sakxI11gIayMRNI3UC73hWvxEY1YN34XA2MBCTCZ8/Y9yh5tE2c7bReXn2OC8BuinN6JkPU7VeNjmJYJ1nZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 07:57:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:57:55 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v7 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
Date: Tue, 26 Nov 2024 15:56:55 +0800
Message-Id: <20241126075702.4099164-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ead1a8c-9fb2-458c-8597-08dd0df00909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l48vTPymmDBk1eNUM5Ipcs/ReZBx57XbgI10t5YflDfDxcdYxIHbYIm4+CZb?=
 =?us-ascii?Q?jbguSHLK0lbAohl9bB+EtGW8eD8bb5NTbyXXjCmeBoGOLeZW2lmEA6c9RRKc?=
 =?us-ascii?Q?WBT9lmRcndBoF/v/dGBt9af9tc5a6703s8Bmu5znPeQsTyOW5tMwHo3XAtVq?=
 =?us-ascii?Q?ABqqS05lqzmgkB/aZSUbo/B0Xtaa4nzc4AmK/KDnDFOTsKWuqkhEKeTtnlW7?=
 =?us-ascii?Q?wnm2tOQMOgwEsfZdvszkaBc845eCefBQ5hjx536t2vk3DchSRqrFfuK5KEQ0?=
 =?us-ascii?Q?eMHLrQnPVfYIIMVItm9yl4DZfSU8s0xrE6DTt6nSQmXg3dNm3t+s5z0Jtr3l?=
 =?us-ascii?Q?X2P4f5Zd+BbHkylSg8rw48n3DfTuB0zRKtccdeaNsA3HP8OZMzrkAkfc+ZuF?=
 =?us-ascii?Q?Iug6DOz4KfZ671EP5zXlY23CLJQgjzMO/18k+P0XyYlZr5HTlmEp/kHW3mE/?=
 =?us-ascii?Q?Ka/a9yGbcP2Jc50EzQozKqlnqCtcZL2U6EyB3TxWGuRlpd+h/Pt9F5k71p6v?=
 =?us-ascii?Q?bwLYAlBvzq8Wv16wVvEeQ0QzR5qVkPVVLiCFPfLL6RcNW8yq+695oDSLQQMK?=
 =?us-ascii?Q?aQUzAT3B9tpoNRGC7JIz7fvt/px3825SugTTOtW1kXFa5NUqfgKIEgiIkWdx?=
 =?us-ascii?Q?7MDBUmi4fVINSr3DfxPdH4l4/0emHVBG0ellLWB6wizmo74CEfLvrXlbKjoI?=
 =?us-ascii?Q?fgR7vp/MRUHgIft4Negea5nUQHRsDuMInJV8SL1XUxUUOS9IT9/CljkV1fjo?=
 =?us-ascii?Q?DUhXnfK7jJlMgrHVkVj4Bl7nWttxaRY/caLEGr4ANGfTSp2q9Cu82cRSw55C?=
 =?us-ascii?Q?rYy6it+H1CusxF7CfpxVc/oG8I2DV+JsZ14Z/ucHvwERiAe1bqfOgwrcsZzY?=
 =?us-ascii?Q?0ghpyUMHo38gznwTEA8/4xloVjXujdpigYhjXotJl11GuOvFIaAXKFyfP42Z?=
 =?us-ascii?Q?Qz+FaD/Hh+9zz/gySzApT0A5NBwXvihCXrU3jn+DAnVZiTJraUD5oT7BlNN7?=
 =?us-ascii?Q?QG0KWPoc045Hlr0hxCFHDTx9MtdYqklTDYZkUsvkvASINGBKzClDNk6pIHpK?=
 =?us-ascii?Q?ngQ+ADQ0s1HNm8cHbhZZZgE2I5qSzau/NwOYtGjbVaCE0ziGXVj6+PpTttTV?=
 =?us-ascii?Q?Kcyj6pyashYfCEjEwuutjMQufyUgtZXcQxOi1YWeZmRXJvJ7uW0tFAOESk41?=
 =?us-ascii?Q?CuJlvmxUszDqV6as25fyniWeRNY9LENi35Ck41hUbhxtZUea1ExCPuBBVOIU?=
 =?us-ascii?Q?oy32H777oN99+PMvXr3A9g8cZnYyWk2MTqXVjZcPx6zgvaf+uqGGqItRU1rV?=
 =?us-ascii?Q?oC+ToPpxdO3MGqIPqlHWt5AoVNLLIhbvxDUqY90hrWEyuN9IqEJx2db33w5h?=
 =?us-ascii?Q?HGbr5wHMgWh7+d7lwc+T8bqGbe727F9W3TjSiE3BLBNpqXhTk1cqEwCw0PWX?=
 =?us-ascii?Q?24NKou9A1mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hX3njDR30R1z0iEkZ5Asy4knIcJN3mAfVUM8Z0j7Zu/dR8dTW1xv+JIeBZpe?=
 =?us-ascii?Q?RvsrKUxkmBvxmZWosePV2TtsVUzc2GniL+itVzoT1We/nB/p8FggFhRJd85K?=
 =?us-ascii?Q?/gmuMIvlsVzsTYrzcVAukjcLwcjXRBPEDECqEMQmjHOH9IqM+YmH6+diGvxf?=
 =?us-ascii?Q?ONNiEp7V/tdfwDfQGLYtIwXshBcmDxm4RApUqGHN5BXNBrjmeUVbENg2PUDW?=
 =?us-ascii?Q?YPeI5OMDYZSFHQXBTKNVYeBLEeRvh00x2tRcoMy50tGrK23BYROQKfb4ePon?=
 =?us-ascii?Q?UtOVTIRFS22aEzssYDnReWrzUEjWgj/iN5eTyP8GbfE/kn9Rxnn0ZDApve+e?=
 =?us-ascii?Q?DOpvU+fSq7y3dEvymNc2D7GIJfy7clcpg9KP31VVsGO8+ds+eiikhNx6qzbI?=
 =?us-ascii?Q?vVfBdnHOG6qFlWz3O3K2z5Dv/2SC3sS/HywiHzoqW2vzwE56MowzgMQDiseZ?=
 =?us-ascii?Q?RblFtaIR6hEeXMU2nS+JgVsgwCSE3fShcjy3oMfjKvvjEgI3qSG1DujdEpRd?=
 =?us-ascii?Q?aQeT7J0QFLyRmyfm4GEhRyJqZ2lDqSZ0TLwE+56zeoiu5hi3PVD/JsCx+yX7?=
 =?us-ascii?Q?BqXr6Vj9CeTorASju4nwZWuPIo+x8IiOF2mu8NlCdSmPxJrK8dxNFsTUtS6v?=
 =?us-ascii?Q?du5z8pLSZq8H2oiTc8xj9z6P8mOfz2BN1T0PcCMQL/ELHtHmcQbzEVHaqFp1?=
 =?us-ascii?Q?2PA3HfPDhTu3iwxG2gO8evMFtbCMCfQc8RYjQY7EcZ+gnTwFOVx2YQ1iMpA8?=
 =?us-ascii?Q?le2hI2tuHfzNL8qlrgXuVbgbfiwyoEcktPx2gvyJg9VP3KbQVL2Qbg/p4MM5?=
 =?us-ascii?Q?Uyn3pd1PEWdRTed0sI+s817HK+jHBx6Zp3H0tZt/3P+44PbxZCWYDq508nvE?=
 =?us-ascii?Q?dYZQK3HoRsbTymz4Hs5KEEhmkddNXL11LwkTRaFuBrNAew6Ndv0uoNiDnzye?=
 =?us-ascii?Q?PNe2drV4asAEmbpwWY/z0xffjSldgwKJ+LainEpn+Dev7LdQQHALcZiS80vv?=
 =?us-ascii?Q?5eihaC90Vaygi0zBr/mKNIlh7qGJsqwSDZMmzxSmIQbThITHypiXRVMuL3TT?=
 =?us-ascii?Q?z2Z/qxzwJF0PcoVr1fnCFXmoM8bNmpy7SeC87+BwQUxUZvAXfuMz+Y+I05w2?=
 =?us-ascii?Q?qdHEGNJBrl/sbH06g9367rauWEgQ/f6+kukUbydU9mrwovJ5UAgkO0a0292k?=
 =?us-ascii?Q?ewxFSJNFtoBEp21ejkcUfRPL20ReI1DTSNlc/I83MGoGKGNrIIsrlGNn1iW2?=
 =?us-ascii?Q?GoWfscCimK+wRjqcU7SCDJVyUUwI8IZi3VeK2TVUtvCQW8NXDzJpL9aCuDQ2?=
 =?us-ascii?Q?l8SlG7jf9q+cGWInl9UhJjf7lsr6ZdRsH/I/IhVJmUzNROT5uXDiaBQUWDWy?=
 =?us-ascii?Q?722tk3HP/eAYqh4aMyknEHpANp23EzkJTKwVUjs+3L4gDhTjEDB4Dr7tGu0x?=
 =?us-ascii?Q?81OVaPQ68yeVK7mpV2G5PzRO6wc8yyozKDfAiXP+SZRYp8QWrQfQH++fDAx0?=
 =?us-ascii?Q?jeRGhiffuKNuPQS8WJ86/UePZjy3/xYYQqPRgGjPTTf/mMS7jQLk4WndikO/?=
 =?us-ascii?Q?/SdJTstVKbMkoBiRhZnMLcW2CSiqtXma4/XfNviu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ead1a8c-9fb2-458c-8597-08dd0df00909
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:57:55.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mNbWY3SEZxY6MCA9hARZ7QPn96TSpgNCHiTROtC2NFS3TGivDzfP1DwBhvxCG/L+9JGgxJKM420XNQ5tUftXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401

Since dw_pcie_get_resources() gets the dbi2 and iATU base addresses from
DT, remove the code from imx6 driver that does the same.

Upsteam dts's have not enabled EP function. So no function broken for
old upsteam's dtb.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f7e928e0a018..81f1f68ccc14 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1114,7 +1114,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 			   struct platform_device *pdev)
 {
 	int ret;
-	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
 	struct dw_pcie *pci = imx_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
@@ -1124,28 +1123,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
-	switch (imx_pcie->drvdata->variant) {
-	case IMX8MQ_EP:
-	case IMX8MM_EP:
-	case IMX8MP_EP:
-		pcie_dbi2_offset = SZ_1M;
-		break;
-	default:
-		pcie_dbi2_offset = SZ_4K;
-		break;
-	}
-
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-
-	/*
-	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
-	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
-	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
-	 * above "dbi_base2" setting should be removed.
-	 */
-	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
-		pci->dbi_base2 = NULL;
-
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
-- 
2.37.1


