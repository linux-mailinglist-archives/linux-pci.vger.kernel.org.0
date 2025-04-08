Return-Path: <linux-pci+bounces-25469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7EA7F2FB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A6C3B49B3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB5238D2D;
	Tue,  8 Apr 2025 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G8yhHi3/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013056.outbound.protection.outlook.com [52.101.67.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD725F96C;
	Tue,  8 Apr 2025 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081280; cv=fail; b=AXayrVScRdzKU/oPqbeZWrjJqNU+dQUHgtorSPgs4/uQ4CevcGNP/mWEjepRUjZ39jR3YDUoTWCxyhn7GngF8pZMfNwAshHRqH/Q0E/8Yz4DcYh+TFjzkHv5jdAH8kIe0qp8iOO5sqvqqU0dJq9guggpNGVMM41BQNs3CrDsgIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081280; c=relaxed/simple;
	bh=vl7IHnlsKCckjRcbUyhgVQFVgrJ2fCD0n8q4dgniaxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIXoeDl4dfmfz2gao3nAy7C4KlfgLmVP1vYGwi00uDCHsgyj4qqpSjInUo1E9ZU3KTfoNh6kdB3YK8YvfmmiYVLJqLh28RK51obdo2bAKxUzuYKzNdNsbYyqjjZPCEjCE19Ib7jfsUeyAlAi7/2jdVgscz+QWe72zo2ImvE38XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G8yhHi3/; arc=fail smtp.client-ip=52.101.67.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaSfKnjp3/0qZ3Fju8+W48HR79tIQDfqplZdkCvtsvCHMHSEdnqxnFh2S5vliNPxNN7pdYa8ZYMOIfVzXM80oDC+KudrqF5XFXs5Naqi8WZhIVwmEt5Bw+By+BpTfH4ccZBGSYdVJzqF8T1E2oxorBcKqSH2wKiBEWG9dCAUG/So1mUDEu8i/0PP2n4z1+hGLCme2HQQsJPAb2eZa11BOhuIIVWPwPyLoQXjcpdW7JVZbOL8VY9x1y2Ji+sikDeE2L+31xISxbQ/hQI+K4VKOfs5NglxMEfi8/ww1HWgMV2mia8T63OqP2nYWRGAlOG722BWPfPRc62BWopf6jvALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnwGdEG5qfpvTGMebNhGg1wtFGs1UvPt05cM09AHdDU=;
 b=XyM7Fbs3zFzG9ukHYorqS/hK++NkfbuTYZgSrnEHAs+Occ2A/lCoWYYG1MX3Q2CffaSPROp2E3l0gKftsyzRofpc+q+zhLyOeNsDLD0c4D5IK+I/j6AJlUITj9CvK7m3PFBOMmC/tKJPdQO+mZrminA9Atux4zPnqEALB+XgPXDqAmV+b+qkMyhdncknFchK72GWcx5ZH6BZe+sJBCC3Dm/DekVbAyffV320qYyQ5sfnSPM2zd/7mJMAsKijE4u4jA0dBAT533dHOwyHOQjnyWjyi3AgE+8p7u+tL0oyI4mlOZyk1kLB6MpMW9tucmts71aQ+w9g6H2Wn9uHDMN0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnwGdEG5qfpvTGMebNhGg1wtFGs1UvPt05cM09AHdDU=;
 b=G8yhHi3/B5kmiAJ7juCislPhNsOrGvASk0MGYLCU5UxymNEoCJz8kV/G45vNSoxYRMbmrZvt4J8i9PA9dKAxQtKPgrq7r/xNUu86lLMidlzYdtW7jwsqhKFdiMDFmxpnMugm/t01kxD7l5h8N2L8HD5/An8MeLOt00+IUOEjipEN0nolyspFdIYg2g3vQCUiY+/V5WXpZDhqm7mFizIyXguHkpUqWCZ+znllG+0J/f1/A2q2TAPDEqlCZRN2LMrNbmgmDI625F+SfpxKLEgb57+jbbeZni/Zd0dhT2G0ShyCQ7H17IUBho5Nuj3KCuAas/W6KHd0ZnfMw8cVSkHU+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:01:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:01:16 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
Date: Tue,  8 Apr 2025 10:59:28 +0800
Message-Id: <20250408025930.1863551-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9d383e-bd1f-4984-877d-08dd7649a0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJJMXsTm/Obu4OxfwuSQB5Q53ILAIjV3gP1qqcLHhW/kWc/3DKj2JSgvIcpS?=
 =?us-ascii?Q?YkKdnrCf20aw9pwYjlEY49wLnTMfB/ov94IzTBwNrE4fZS1G40noABQc07rJ?=
 =?us-ascii?Q?VAH/umhDyRRc5ICyFc09CHSdHtx4kVYbKBsFrLWNO+P4Nmm6zq23eYlkHod0?=
 =?us-ascii?Q?Lrv6lwh7gRot6XbmdI6hX51og0Yu0f3g716h1o52+oCeP1eKHlbpUru2Zye4?=
 =?us-ascii?Q?f6NdXd6YtVBHMFrpssQ8WwOY/SkyAPMtUufkVuphWR/j1j7iRSGIbq/5uby1?=
 =?us-ascii?Q?1TSgr48IInjrmapfVfvxTwNuMJCgKNqHUAggUAZ61h4tldiUZY/3O6uYYXJP?=
 =?us-ascii?Q?gdRlU+oeu1rr3BcOPhowbIMWjVxwMeDK5ThyXVO3KV4YrYA7mxKMJeJ0E/PE?=
 =?us-ascii?Q?fC9qn1tDo8h66sr7bwElbkktHpTVA1aVf4q2o3yK5XlRUxsQZLhTsH2bSgnF?=
 =?us-ascii?Q?4uscLKiAKwPsIx3kJmHtTHw0xjU06f8W+g/FWkTH3sfq0V0dFTeuFeKXgb/Q?=
 =?us-ascii?Q?g3bMTs9pe5BWZ94BEyCXlSf5UER0oerDp1uVyb9drpxpvvTzqcNNf8e2z6C0?=
 =?us-ascii?Q?KFUBbeo1eQq7xzVy+uOulcoUfog9eWa2IHNcBak22Diy5tvTSkYUVCOXC8/2?=
 =?us-ascii?Q?G3DZETSbNo5Kdkh9/Ki8BdNz2OXARj1a97KF0LQQYDNyFKF8kONnZumiNy6s?=
 =?us-ascii?Q?+su6uKLFkYks5jyxXCQ72Zab49DY5khkzYfiFDlQVnNG2MmfkUwFmPDV1jfG?=
 =?us-ascii?Q?XmqploCEBBgeqLatSt1UruDHixHceyiXcvKjw4GABu5ioVtSE7+Uj/qnskgJ?=
 =?us-ascii?Q?nfM2nOXMeHRnd6+9gxTWdnMhXLTxboW5LWkd3JaxGCUGm5j8AUIsEkMRDr5M?=
 =?us-ascii?Q?ucs5UywtdCHMyddmjbyPn3UVgs5R3tGjbWY2H+mIOAwuhnEkSvWhA2OWoElm?=
 =?us-ascii?Q?otRZXhXrv6L/XEojIodu9BQ9qjCbtC2MM7Umz5ohX6db6yWdwzC144Z91nYN?=
 =?us-ascii?Q?EqBf0wte8ZSs2jbDJ+IOCNGmR/e5PqsFk6mcVlU9LQRYjaPD+U31f1hfX9yB?=
 =?us-ascii?Q?xwyGFWK1Vc5Jpo6SnRBUNMJDouur3hN3XL9BiTECMCHmfnuLUSHs+EsOFD1y?=
 =?us-ascii?Q?jlr+OBuwMCCLYws+ECztnk8gnDGgS9jxo8WYERNk4mPWB2nhF2KWqaH1UK/C?=
 =?us-ascii?Q?RyhICl7uy2UsfZUjdns9ADOuGt88GmOfX/bU/86SNu7cGikFryUBsoVHMbXu?=
 =?us-ascii?Q?qS809dAlxRoXQquRrNI5OVdG4RxcWakVUsOxxfLJ3AHcsgfEpJCm0lwvtJkJ?=
 =?us-ascii?Q?HCxovQCD81Sq6ebm9xxGU4PEeiXTeKtnm54TPFAmBs+sIjhFD4jj+G89zrHQ?=
 =?us-ascii?Q?8XavDoNHyUVoGoVCmlkhw28VeW8kJpPRTaqaqS6OCF1IjkXx+aq62IITt1cY?=
 =?us-ascii?Q?n88yAT/C5IsC8mdGb9DOb4Qfbt5c+I3+XTwxf7w2lXJCF5MRcdWlUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7TVnWzNGrKiIy+FT/3WWfK0dWUrjNu7/+R88wGq0Iy6NedgnvpK1QZ8ZQqM?=
 =?us-ascii?Q?nvPuSFj0I8dNuDNza6gvAJfElDrrxMVRCePtGX6jNvJa8SRXwaj4PDf/zWb5?=
 =?us-ascii?Q?xfEVheaPtJUOqFz26TeflU3dQVzCBBT222ORHi8B5cMu3vbdj3001Mlui3n7?=
 =?us-ascii?Q?Dc/SBXk8NTtxPhXBiB+YHvtZpKat4ys9gaWmvgz/0944uLIrjEqJZsjHgtrA?=
 =?us-ascii?Q?O6VHd9gViPIGLVmlPWC5pjMkkwjdOtuZJ9o6RKhSH+iXUf0SXTqpcB3cOzBg?=
 =?us-ascii?Q?uRjFojMKTQqlVt/kqnYwB54+J1mCCJTONw6TTZGPOO5C6soGGFBzOW+MgQfK?=
 =?us-ascii?Q?UJ5E1QCeEd9RcZnRLxho4cfLsd/ZAT4LH8msWj1QWzxqXHaqPKQ0QAcnix1L?=
 =?us-ascii?Q?M81ySlzNijqSSb9D8HzD0qpYowFzb7hgvk4GcQY+hhK72UpiSjibUc+jMafV?=
 =?us-ascii?Q?fYzqV9YDEo23libeoStHt8YiFOD/SzPAiFswYEMNFikzXMY7t18n+kDq/Ued?=
 =?us-ascii?Q?3klC60TYRVs977WTGmgr+/SGzoE57c1pZMnXVdLJlmEAgWrjfTxULbMZfXJY?=
 =?us-ascii?Q?uKOFaXKkm/wUvPBuJclwpLRXlELvDbWHL0Cvr4BpXQK2X8rY+N5WfuTo3H77?=
 =?us-ascii?Q?LErCxh8rg0INx0EOPs5EBupggsdmRU5DyDzhX2nfgCj9biDKiW2n3Urkp9Rb?=
 =?us-ascii?Q?jUq/sbqMQN6d8LEhTQlTv5M/lM0yxKvfU/1yPy93cMra9YonPEwKHYR/V90C?=
 =?us-ascii?Q?G4lmIp9DMiPOYfkQ+NEdwODrJ139/13nwfqFSPqfD1T2r+2CnejHP03Bm7lN?=
 =?us-ascii?Q?w2a7WZJKDiy2OwmJ9WeYeqM9Sya4y4/L/QzGloLzZvAxNooJQLRof5rNHK8P?=
 =?us-ascii?Q?dkQunmt7g/fsdl/yQwq0rJtspa64hHbup6zxx3HJljWozOX+R4WLUZ10CpSJ?=
 =?us-ascii?Q?hxpXGOle156xUT9qDuZCd+p+ffV4ebEA2PGYeRUzkOsCWUmBqAW0Ug8/mMZI?=
 =?us-ascii?Q?2tK56eiSUkDeqAKrSFOtA8GCCZ75qrp3Jq/Za13zrdLQzS0nBUrzNGk5aOyg?=
 =?us-ascii?Q?7a6O50ljDDvdc/RRRQMvIUWeRy9ioyZBEdH8gPypTKvGLa8o+9giz9UGKydC?=
 =?us-ascii?Q?tbeP4cQ8ZV/4OoZzpIGqTbv4kULnw56kyyWLHq2hvAO4jK1zUTcpNKsPQzvb?=
 =?us-ascii?Q?xN/RB36WV2zwGOfnHGhXLKuX9OUi36FpwPdyIDbZQHtMTk1HZdy3+XvrCh+H?=
 =?us-ascii?Q?qK9OHbVDIPPKvzL73xKiuUBssFjp46PICdv+/KQCm2oTaQ+zMoe5vYwSGyI2?=
 =?us-ascii?Q?t7a/OdoV0NaT3176iRmONjaPNEsVF3BSA2AxHXJczH42kNdn482rYp2dGt/8?=
 =?us-ascii?Q?1g1B7AK4J9nM8baB4tb9wLzvs9Md/3qx9Hw1lpUOCCQyTrjEUBZ/5kBuIM1l?=
 =?us-ascii?Q?IGfDeNoyM4Ibj0MULcNNX6B5k3gXOoeWjJju4n52lOXPGYoJPoI0X/IyM8Xc?=
 =?us-ascii?Q?cBAgy9CmKPKhQ3V0jkn9765O+YFhh9Jx3gxnfRLYzrMT+wbTv5bDGmxXni9O?=
 =?us-ascii?Q?c39wmEoxyb2EgHiRJUemf1qTm1GqpvNUNU4PJ5U8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d383e-bd1f-4984-877d-08dd7649a0b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:01:16.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6xR5rUIpn9pYxRX8hFNWKP7vycLEGiMsAEEF4JTFxS6u5WSMMg2fJnhacxZH6x8UD3Xtc7eeuJahx7XHk8poQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

ERR051586: Compliance with 8GT/s Receiver Impedance ECN.

The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
operating at 8 GT/s or higher. It causes unnecessary timeout in L1.

Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 016b86add959..7dcc9d88740d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -110,6 +110,7 @@ enum imx_pcie_variants {
  */
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
+#define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1256,6 +1257,32 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+	u32 val;
+
+	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
+		/*
+		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
+		 *
+		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * is 1 which makes receiver non-compliant with the ZRX-DC
+		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
+		 * It causes unnecessary timeout in L1.
+		 *
+		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
+		 * to 0.
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
+		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 /*
  * In old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD in iATU Ctrl2
  * register is reserved, so the generic DWC implementation of sending the
@@ -1281,6 +1308,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.post_init = imx_pcie_host_post_init,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1392,6 +1420,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 		dev_err(dev, "failed to initialize endpoint\n");
 		return ret;
 	}
+	imx_pcie_host_post_init(pp);
 
 	ret = dw_pcie_ep_init_registers(ep);
 	if (ret) {
@@ -1789,6 +1818,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
@@ -1842,6 +1872,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
 			 IMX_PCIE_FLAG_SUPPORT_64BIT,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
-- 
2.37.1


