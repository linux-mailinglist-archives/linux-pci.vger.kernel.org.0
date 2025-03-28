Return-Path: <linux-pci+bounces-24901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE5A742B2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D27617A8F4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306F20E03F;
	Fri, 28 Mar 2025 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kGBiF+uD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0A20F09B;
	Fri, 28 Mar 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131028; cv=fail; b=QvIotrVkX921kv1EhWjseYQBa5x2bZHUz7Gbwd3cFnBURHzhzEM0RHlJdVjTSOh0mYxjewvCJdw4KEJyeybKnh+WnyZuoYMSt7OHHq1xzJ1EXTeev80uzSCJzI94eFWVvs3+jYK8e+2oloo0ejI2zLZo9aXQ38EPqXlZvX1Krf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131028; c=relaxed/simple;
	bh=pmRzFVe65NStBXXpPAuOmj/aYPn6LODgEdy4AuLFxqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/XU8I5rr89o2+2DnszWsyXM5dqXvfQl6nYZHXR110hzp48pztbMJ+lUH5D21XJrnW9vt5/L4+7ooT32hlvTrMoSZwtQ//tqA5K5Ej0V7+SofNhXrMyXc9KW/kDoIyJ25ASUFVInQYtcisUdqM1WRdKiyUTpMpPabz9J8mfgzX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kGBiF+uD; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCvJRywedK5zpJ3oKFZDN2U2jIVdUudqYjkudSmXXWCj885+1ON+AnMQApKxPpY0la1ohW4iZ18HN7F8OjIBlV8dyiZqyBLRE0asLPnd+i9eY9pbVOKrmFPpL6rovBMuUZ9PW2DtJhnpt6sLIUgr0EP6P/Mku9c1LqgJbFdjSDYgKpLq7r+Vh1kFP+wpFMf3H3FJQ1uVUUo4pCauxeDnR58lluJ1zn8Ed9dy8bfDYKV9zb8/+Fz5VWIqoT5uLL636HQt8Q0+IZbEx2vSsN4NRdQNX0436Teogm8pft5hNuoGm+ZDkw7RwST3P7B1UnwVmEi8/y7uRO+YZjjm6TGhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE9P6dSZQzoDP4tohliHI+TBQ5/Orah/M6t/TysaJx4=;
 b=mcFEhrwo/jLESEuIDjO7wHOcTf+NVW8ytHzpM5VEHcDwB2yRL/3w3NbjYnmKCd1NN0vNEwfPCoU3TFCt0njf0fk2cVPdckBcBaQGBlrQT6Or8SCUpqhegNFgattavd2dcu9ZqMocCHLg3CyMC/cx6X4HIqKwZEQDOaEh7690nOyHd2fcaf+0CfRyAgaCxyir94Lc1iq6GNuC2KWWCQLJqficpnD4sxjNd5cAnwPxTbrj5HW3u+vMJnmxMVAZChQ34xz9z5x8O8QdCAXEOu2GfqGn3Rq51CeRAPMtzEEWtt07E+xJBf3f+J/ieAqcQ3J6yTphnp2nUaIZ+G7plwvtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE9P6dSZQzoDP4tohliHI+TBQ5/Orah/M6t/TysaJx4=;
 b=kGBiF+uDaw91qp39HdVG/Du+9mJeehNDyVQdKtbtDBZeFbbZoq2VpNeI+Eu4cHLReo6UWX4bOjk9IovGRz51iaaepv8aaTAsK4huIkMHmLrmZsLTBW6ch33j04lp8tA0H5cjMg8Euz6zEKUfb8iwQI4LUfzVSu7e1j4CGcc+dli2X3850abtYtGbSR+GZu60HBqOTfH/6b9pygiI7i5gF4lDY4gunmRG5gL/J5mEhe/N+dMGJnSN0mG7NYlCB/dx7zj08GRETCf63ntUQ7hwmla44CAFbvOCfoUBGC5BETL7mHZK4kxrspXBS0Do92rC8gWJPo4rARZarDBO9de2QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:43 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:43 +0000
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
Subject: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Fri, 28 Mar 2025 11:02:10 +0800
Message-Id: <20250328030213.1650990-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 35de3c3d-a994-49aa-7332-08dd6da5262a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lpRGhnVSfRL2ITIo/rZFruOyIh9sTSkKn4BJpImRfFVFMPs6fzL5OHNBylVH?=
 =?us-ascii?Q?erTjcM/Xd4MtTu7IfA5RN3llfbvIZQisca4ydtQmVNgk6JagKw4f8+3uOBTb?=
 =?us-ascii?Q?BCYHOdyRcLgi7+S6Zwh5oH1oLMWpBL/tYwvchlWzzH6tM0jBTbZf16XyfoXf?=
 =?us-ascii?Q?bnZJ3a+7eUHC1LmDiZCKaXrQ/whTa+PNX0C3qbJbyq8dJEdHu4ME3uqN3w+1?=
 =?us-ascii?Q?gX8VVRJ8jkNzMyirnNghxeqWc+dSHcWTAWTTM8RxpcBgJMYwyTnZq9M8Tf4V?=
 =?us-ascii?Q?BFTa08h5NY4YMdpGTh9JlTt16qhF7jb51AQAkBFFwnmFnc+eiD+ytXcgCErI?=
 =?us-ascii?Q?4++sUMM4ssQsiEA+KZk+v5drOoy6+lgZg/otE04nGkIGjpJXbxgBKGjk95++?=
 =?us-ascii?Q?D63XunfUGAjLjQHZkk51aOB0gcwyLK+Iu4ZvjKLQ3HAmYdkt5UTYXp/liWIb?=
 =?us-ascii?Q?vhxWdX/j4gUYhxDt7Hs/i6e331UUgeTxRAp7BifJVAK9wg/a0BVaeQp7YDR/?=
 =?us-ascii?Q?EeTIJylEql+TjEVBMs5mX+6EF7XNESdfFGAKmBE7EXWuGdz06W/j+F2ZKyBP?=
 =?us-ascii?Q?U2AETvzhWOG1+wj+XeCyTnxpoh+Vq8KIVI6JfbO7ZX3VwM8U7/aRPKY0xqpp?=
 =?us-ascii?Q?0YYl1piJEjos1qhftD75H3uikgHO5sv4utJNt4ot3vPb/3BCskVXdsw7ui4c?=
 =?us-ascii?Q?IYst3fKiaURfSltKwlcbF/681wYuc6ccmlycmc4MaIrruOQkV1MNWnOBvY6o?=
 =?us-ascii?Q?UeDKAaWiQ2VNoz4vuuq8TGtj3pTpHC0H55ZaS2a2XG5hrCOoffoJW9vhLAnc?=
 =?us-ascii?Q?jgy3qXSu1Tf/Gl/Iu5i4YJQYFRuk2UPJx2kQfW3T3tMUezHlgI5AkYk3/fFa?=
 =?us-ascii?Q?DP8OVg8knMJ0gOgclUCOVzvgHKNZrRaPuP6xga3+V8KSy2OMdRhCvYKj0y0Q?=
 =?us-ascii?Q?kdVEbYO/ieRJAicl6sUwLJfzz+eMpFfeWTKkKvdkfRUL7msroeQqMGPVvNRg?=
 =?us-ascii?Q?z8gJQwfEgbv1XEWNny8ysFhAc4zqQr5toD4KrxHjSigG0misjXGyMTSGagMN?=
 =?us-ascii?Q?x3kVob2G4qUTjB9xy9nsFLQytYfUcFUQFscBV93i6DEBKKZTx1uVN6M/i1Ye?=
 =?us-ascii?Q?jSREy8/joDKAwRKo1c70QupCL284/M3LVEmXMa5Fm/voGcXuMlS0jHFvKuyG?=
 =?us-ascii?Q?xU6ykB1lINV7FOy1+tYjFQAg6iE7IXr2CkGu1NWltdkOFQXSlkVEko3XgABb?=
 =?us-ascii?Q?b6gtZ9xWkQq7v8O3h4aEtCfXpxhVhNpFBfOwI1T45C/ZIWRRlvj88hTzF/oT?=
 =?us-ascii?Q?nuDTQ6tNIe1gwKfhBEdfdAco3xmFCNEahsngi9WGTC5t0HjLMYFOqw6Qfy2c?=
 =?us-ascii?Q?XIEYMmyjf+fY9YYowl0EUxW7DAPWaIafgJXaHTvTpqMIGXIefggTamdZrASF?=
 =?us-ascii?Q?fWrCklgy9lS01SGjhZsUpynEvMnyJ9fmkYA8OdC/sIxrCsE6aTvDjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9oTxvdGrBAc/wt+9jq314awuNiTbMweFKttxIjlFARPayzzuCjnIdfQHb+6Z?=
 =?us-ascii?Q?KWfaCXOc6niS9p1/ajwG6d+O1lIHNTfwwG2gl9mevyWh7RjNqciEkVnGMZiI?=
 =?us-ascii?Q?6Nd/28QVMWxFM0avSGMoC589EMJcOGcrXyKWopZBTJp1nTp24Z1pg5bSFpPB?=
 =?us-ascii?Q?udDGD0QxWtmRQlf2gXX1VgzaOxjlVLuyqs59y1sOWvK3iiiPjzlmtMIYKcMn?=
 =?us-ascii?Q?TqFQXrLECFfHh+B1PoxgIcuUjkVsOTBQQH4M64Cn4HnJD9zPoxgopA5uTBHb?=
 =?us-ascii?Q?iP7QIeC10AZ4u21LwtBcDqIMg5yO64YyQGmdJ3Z9VR6JreFyni1p1zC4Es2L?=
 =?us-ascii?Q?48U7/pm/qxQZjl8q4e/dhTj2PA6+9BfMGtV0JWgUqAt1ccdodDpdKr41SD5V?=
 =?us-ascii?Q?+QGQ7A3t9F4hG8EmsjotVjT5rdLj+G+Ov0IW+8zyYzPOyKXytOgIPnsFafz+?=
 =?us-ascii?Q?ARMnOaUG6/EbvOosE8Xsc/zEduqjLUzMR6e9e6HiCkrAH25T6n5X9zDiSESn?=
 =?us-ascii?Q?eeJXqNQmcof2BrIF2g/qDGlv8d1DxqlqY4cYQdbq0+aRXJK0f0x5q/8zB4ic?=
 =?us-ascii?Q?djjWLVLLvmhsys/j5fTNcv5d1Eu6udzpJJNtETkAjkrBoS1Bkx1nGlv61cRC?=
 =?us-ascii?Q?MQRmzVLmD1znOIq7R+y9KB6PQQgheTaCIFwqdPQBz2zWLv2Oi9q5L2mHxv44?=
 =?us-ascii?Q?SaT0YflncPa1MksqmPEX9ZZ2iQdOcwSEMcMnWPdQU6IsHh2YS9wqJEUHgksU?=
 =?us-ascii?Q?ScyJNxZLc0x9ZDbTYUZvN7oP0DPSaWoJd93Bu8skowdMvldnLbVBr1rEvheq?=
 =?us-ascii?Q?zkBKsCWETuS6wFtH2ZukljiwcCDL3+0xLPCbjJfOmXgrmCP3D5WqTzA4n9js?=
 =?us-ascii?Q?tyqT8a86vMDnT6wZmcujK7tfEU3LDP2r3jSTG/sFyUP5R8v2e9GmM8Z6vqPQ?=
 =?us-ascii?Q?EL2AS0U3qVVBaK9J140sCk36Q744HrneFp9ykqCGmwsxzMkUNGxuP4YJqCBB?=
 =?us-ascii?Q?39LBERpHJm6wcJXGonou7/AxdI28G6y/D0TJR+XDAozpGppryLK46OHTFGwj?=
 =?us-ascii?Q?6qolTGN/D8xLI8hLOxXXdDBIoex5kyXXLCIRNnWquldz6yTOJliBTt1LSZct?=
 =?us-ascii?Q?9CpmXwAUyDhyUKJqN1jBzo9KLjmP4QgN0XLob2imNmzKZB1s2TlVvwIgf879?=
 =?us-ascii?Q?lHs97CgESKKBx9sdUtBOeNgwP6AVhWJDQ815ZGdWBN2bhOB6vC7FfbFItb+T?=
 =?us-ascii?Q?1/EDfxZkNYKu+eSDEmRsv9rrva28mn/W5Jv4+AQUm7Z8yj7Zg7Hrq2qVXLqH?=
 =?us-ascii?Q?BG6MK50Y+B/r0PSVYve49ykSdpF/0mhcZ9yX4yw7c3V1h8lCZWkU+oiqIyHO?=
 =?us-ascii?Q?Gvgz2gTN/5tVtsQACJIsYwyXHBPq+PRQJGts2SoU/jg09QTmgUVpQbYYw/nv?=
 =?us-ascii?Q?wDKWy4tHv0mmTtbxrBmE3AnqTP6FGf5TACJudkhUFTQ7jLNwXOvkp3ur8pP6?=
 =?us-ascii?Q?Q4JZ7Rff7M/vGB2Go3blUjwHZVW7KfhXiGbccOfZyf1fA8IbHX1+t5ycY/Zs?=
 =?us-ascii?Q?c/AWqPcF+TLkuk0FwfbweGBtHW0hRBtjjL+73el8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de3c3d-a994-49aa-7332-08dd6da5262a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:43.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byOp2zo0MDWr7Gkjf6SzhTMyi1C6Atzc3gvocf9VwPebt1XKhJADhZRJeFwX5Yo/iixLohkgtv3/Y+ISFCerwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6051b3b5928f..82402e52eff2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.37.1


