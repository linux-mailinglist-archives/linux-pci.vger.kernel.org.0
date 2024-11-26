Return-Path: <linux-pci+bounces-17323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED39D92ED
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43480B21BF2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7919D8B2;
	Tue, 26 Nov 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z122owBx"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989441B2192;
	Tue, 26 Nov 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607905; cv=fail; b=d/XM5LldEB/Oj3SLgQVpaCng2yLhFhtjNIHNffuWzPnj3C9ij4mPkXfXsW6HBJ5xAf2s0LZb2mF4v4QwJlWcU5iSkIirERdSBN0S9YZGSFJCujCiIhMrOJUVDX9rAwpkHeSExpWRYT+3infZ/FlWl618I2Bay/iUf/SH/aIMyAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607905; c=relaxed/simple;
	bh=kaokeuoUAOSunrNU8j/+kg1e+Y4FChqDRmAQZ/17nzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JbRpLZ1zOoRyYZGIFkxksENE6ze8Jss/H0U2QJORtvLS+MuXQMPPrtRHWpYRjiDoEWyxWwc6D6qXN2k9Px8Tf9mKVRTAw/7qOkmX0nXPZfaSgU3npAsBJO7louKkUEuf0csmccxH3vkq3OyUpjsG1/EnvluwUpD2DMe9Su0gBRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z122owBx; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P12dig6tgFJkrXDO51C+qHkErt90BUGaePKGXNRlqOMM0wK2HddRUVpE3jQH507he2ksWH2RcZZtv44GoCpzWLuaf6yw4b0DHWQkYj6Z1gsznKI43hSg2h5tHHjKcEnj5YcSQBavRAhrhfH4QnD89wTA1C1J7HDZ+WRbmR9AR5xQ1ZOj9wX4vYGFy+YEOw+W44RUw0uFkGvY2Y1SccdjEVxn1cYnlb5VdcFSvK4nJRQJGdjoqP4R7bc5urT4uC1t8pN2WhVaBaUcFCe33xfo7TZLagSHfe6T5KjG8sAoG1ziNuT3qAasoYXY3ZW3M0Fx/3QZuG1qRk6EyqhkDWcalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw2GdgKgzxq5HSKx9n+vRdiBQcPlh5JwuYYecwcvkAw=;
 b=tLl1WaRFzfru8l7vELIY7Q/XbWIu139osFoMzSpNY4p0gg5sHNzbvCwrY4IaQJ4Le0f4dWBKPWPfmVehJF1Blmso/ZHtJBEjOLOgkKeOdrq2a0POVQZfjzkZkWcwoPW94UNnZyXuXsXt5Cecs0K+1HNTr+5jT0iVi3GUS7lXargG12UWAH0KR6xMjF7ZdVgyqAaUf75jZ9AugT0HKhcs4az1Shdxid09seRCXNVsIW+57Od/4SPgq2QVC5TtwVQ/0IbYu1EuzFQ0frc++6i3u+MMq1CVF6lK1G5Qdg1O0H93GWmPKMKg74ZDLMsWIWi49S4rZsNO2w1bo5IKlR5zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw2GdgKgzxq5HSKx9n+vRdiBQcPlh5JwuYYecwcvkAw=;
 b=Z122owBxm3Q/xOnGyoVAoRA9E9by67yLopa/YhtSl1CqkcbFqDzE+1UtKUFbYWtdYpk1cVV31L+sGUsNtG5HWgU1lURiuLd++j8io+NHwjVtbJ4lmop2dtHtOHXcS2/OzD1+1fq01vpOni/EOj0qv4V3rRVfcOzXiYbL81G73kwf6jPh7DJRqJHrrrZ9bA4mumi7ExhQUftOVuBI3nDooG2MjZlr1mWCse2sZKvqElBjUTy0caoXq1GsFk10juuVbcXd/gHz9KIWcrp1vzdBWvHi9GbuFMzWNQQUaHgmEV6h+uR64OEFzwPcAVekg8ZxFpkDASM8gUpYdSJ+smBzMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:58:20 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:58:20 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 06/10] PCI: imx6: Fix the missing reference clock disable logic
Date: Tue, 26 Nov 2024 15:56:58 +0800
Message-Id: <20241126075702.4099164-7-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa0831c-1c1b-4226-ac01-08dd0df0181e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w4UpRNiE6U8rUkbpBSSOchl215Y4xU/gtwaXgqMRT3RSzU9meYpf7YJ1RPr0?=
 =?us-ascii?Q?Us6N4x2Af41czVdGg5aAW27OfIpYIWXy+G+KnatyoWNiRMo4qHu5lsXOTZK0?=
 =?us-ascii?Q?E9CLDwD9U9x+rv4GGV1pUwpbxbQhUgsRUwpC/VTclnjV1HTfuuZ5vPJIjKyc?=
 =?us-ascii?Q?k5vWk2DFayuSp0agNzIybDm1gzf/QVFRyYwiAiDHkS8jE/sJDYV4eoqvG+sQ?=
 =?us-ascii?Q?L+Ry+kDh/PdkSV4q40BLPOhB40KCxPxDFPe3+xdJ+cgBbocJj0Z9DSnBS60K?=
 =?us-ascii?Q?nnIoCUsXsdFSIDLaktCwYjYZIKH55CJz+EikfHXgeat+0vJBQ1/lqscqa1lb?=
 =?us-ascii?Q?YjTamIa+cz5wzcdOjAlqQQQw2OM7s8xPuan83KrL6LsW/e5WFcHy401ABOYp?=
 =?us-ascii?Q?TF45e1ajX4ALwCfZsgIFfH1AJsk8OpIdND5aLiSVN20lrXc6/RaKrW+OzeyV?=
 =?us-ascii?Q?ukMWQYxxMen3THiZEMwDjTdJBCw3hoIar7dstHoOr1YhUg5jT0RUgsearf0B?=
 =?us-ascii?Q?WlBHqt49rU1FDGRHTTKN6NZG+L6fLyGiw3NDtRWR9S9QLt8S4VYYgkJtHrNC?=
 =?us-ascii?Q?Yq1pwEzeDVAan7mTyoiiuoK2iTnzvycvHgeNpy90AnyUJ9YFOVzlhma8K1my?=
 =?us-ascii?Q?B4rK4YaoY6aY6vKIPX65iLwjFuIu0UgKXdh8LKoydb6TpVD8v6cKvhpjiz7z?=
 =?us-ascii?Q?fii7LWSXPo+T94So3lrC+wZgfniqFevGG9DuCuXcg/n9tGTO8zx5PNF0llCc?=
 =?us-ascii?Q?MAoUyPUmRw5F6EsROIJ+Sqv3x8eN98/Knu2tQfZp4L9MeFkE86MJXwCZ8SuO?=
 =?us-ascii?Q?f00EjZbRT/S4qWE8pkBjsxQTj6lgC9QrkFHCJ9uHrBrcqbFBB4z/m379YNIq?=
 =?us-ascii?Q?CXzRBvJ+MiroIpiXtiptEEZXuQbE9fxxVMrIZ1GMKFWsL/wnNtIIVoJCxb/j?=
 =?us-ascii?Q?uU5BwqVE5piRNM/sOHIkkKEWgSBH20idd8nhnRpG+skZaxPIIxeI5pKsKUzj?=
 =?us-ascii?Q?2O7JVnOjpoiC2F4UtP/imuwtQ3fBgo0JkFYUtdTs/j4achEx6RfCz7aQMDv4?=
 =?us-ascii?Q?7CHJnuoG4+UMnoDM0wCMw7cz0fyDkxkds/tutJPvX9iVSIsj9OeMab+RTt8s?=
 =?us-ascii?Q?sI+QPExAQZv5ReCGwKXxKfC3ojpqjJJL4JONgB9aCZkFrfBGe06e9nvriawY?=
 =?us-ascii?Q?8zS3tRQM1jjw/mXqQmhOXArdRZcSPzd54OBIFIdA0mn0eqXJ7V+1Zl+RX+UH?=
 =?us-ascii?Q?C0O+H/J5lUpXBfsWnSjMWwkh+I4TvRrlmm24bNCdiHHRu+AhZtDXRYFFc/WB?=
 =?us-ascii?Q?JuE+aWa8uILg0VSFBIkVTgsF3K6DR2NTqPujyByQeXFBhO5frEPghC8yHkrM?=
 =?us-ascii?Q?bU0shSXlyxQ7/RNuI6ez4V06Sk3O3ubnc72g7o5dfGdbB5PLtb46X2IFzn7P?=
 =?us-ascii?Q?1948yRbzakA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ok3N50o/l2ekSoPqSnoGH/328NRxW+HzA4WvGd6hOhnvX/mmxhhc2mp8hL/g?=
 =?us-ascii?Q?qMfwY1nIvtJ2txY91wYjX2WCOVAeBKWV50JOxbdmTVfcC9zHcGFBj2gRNUWV?=
 =?us-ascii?Q?QpjW2mQ+cnSnb8iGFQZ52UoHH3Xc89HKHfbzM6m9IH/aLGhDzwChSAg37qf0?=
 =?us-ascii?Q?A9bjTomsN+0gfVMZ5xt4aXKoj8FsdsUkAz4tuDmcVU0R4vUKKfaVFveXADZD?=
 =?us-ascii?Q?Ktr68G9275USI/wfgVCEyAoFyP89340CAJ7fdFLMA9TwFXZdhSOSbREe0cNp?=
 =?us-ascii?Q?FIQ5/tbvYLtkzM1yPKBwp90gTmS4PSlspm092sXE8h09S+2YT/VIaePyQN6V?=
 =?us-ascii?Q?NTZze+HOM/HIuvg3aVM/J67bOpVmHkmekryJLKLDjNGtDIoSCet0ScRhL0p/?=
 =?us-ascii?Q?GyKQFe7POjM6dRoHyyDkaxw8KULxIMJdfumr1VHWEIzvD8TDueAnURaX+Ufh?=
 =?us-ascii?Q?HhV5xwh9iaiqG/5T1jLn8LtuVH+HTgG5XsxdUDmBo6o9pPrlNa+qGf5UJWIQ?=
 =?us-ascii?Q?+XMjSc7SQlOmzX4pkXH9V16t/Wl3aeBz16Ll5sL9RzrIGts/vAXJUUVmf9I+?=
 =?us-ascii?Q?yVY31LQSLExQABZXcvaYJUOg2CuIIsLxgRwVhaGxBAWcFvRf/QkY6ztAHkzQ?=
 =?us-ascii?Q?5MsjxuKXE61BCz8vKOlUNlfm3HuTbGCRQrCDytOvnLMbRP41RKP46LPRM5Qz?=
 =?us-ascii?Q?DDdS0YqwQzQa6cvJxOoycALLy8rbMjOpCe5qg9s7Z1QlL8D8es6hhInvo34x?=
 =?us-ascii?Q?9ydLWoRHBzATMgSl0F/l4rzZ8BYxUczGIItt7iEuuD1s5w8ZfcctQdMddXpo?=
 =?us-ascii?Q?XgC+0Nur7qALfagT/PTfqsbx+Evpu8gexCTy47M+HCKGnTiPh6Iu0QIC8Du7?=
 =?us-ascii?Q?SLOSugNPCU2g2vYNRAjoBmz1p7wmN498I8qXiW0xcpFeMew6yr09HGyU5WyU?=
 =?us-ascii?Q?By7RPlTxWzwuudposlDJKpnjhUlBleYmBwcQB4CnmvHgo4HWKl4MUN85Ufi/?=
 =?us-ascii?Q?yFf9S9MX53oRlmkpPZJZcNqJNnrDiDN9zHfGIh2BSiBmK1gwJr9ZPkSxXcq4?=
 =?us-ascii?Q?8u7bH9X/2O/e4rMTyznmOWWxUOKcPdmBb2b5JVYuy0mHz2oc/zNu3ebzXJzX?=
 =?us-ascii?Q?UobAJGzcQqsFITR2162huQXwNbdcFKi0Aqt0qzDJzXRBmbqvuyzhC7kJsPAR?=
 =?us-ascii?Q?MmDg4tmr+ZSHRY+Uw2FU0R5G2pme/djq0DRRT6BTKJWp5kJfm/AxSdnVxZAq?=
 =?us-ascii?Q?cD+wBvDryFXecfuIdc67hK8XRAD+Dep3P/gXoTvF8x6NxcmjGyO1+UMt1Y6z?=
 =?us-ascii?Q?YpCsXiKcbwUZNjnbB3a5q98hH/9QpIBUcyTKngrqf2dUAC7XDBaGQ2p09ptW?=
 =?us-ascii?Q?XmpdlhgwEbK4kb/fsixq85kYnZoBzflgp3n5mQSLsC2qPOMBZMrkUS5rBkkV?=
 =?us-ascii?Q?dP6IRID+17a4Y9uaUCFvMHAjYyFHFr9jQlf+go0BQbX1I15evDHRnV/hCYsQ?=
 =?us-ascii?Q?dqvxO6GhKXDZtMM090rTN6BYt9FB4LPShZW5jhtLSrLnjLSPtHGE485mNeoZ?=
 =?us-ascii?Q?T0IKICNKpBPsPLu76ObLmodMh3yqhIBKZqu5zE4a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa0831c-1c1b-4226-ac01-08dd0df0181e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:58:20.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTYJovi5cncek4WfgNMnw3OwMdFh2HdXAfjY0mV9aDeVESHIvAjZVv2QgkkxjikKJKL38q3ImaSoqpn10gbQQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

Ensure the *_enable_ref_clk() function is symmetric by addressing missing
disable parts on some platforms.

Fixes: d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match enable")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 413db182ce9f..ab2c97a8c327 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -599,10 +599,9 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable)
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 	return 0;
 }
 
@@ -631,19 +630,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
-	if (enable) {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-	}
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
 	return 0;
 }
 
 static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (!enable)
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 	return 0;
 }
 
-- 
2.37.1


