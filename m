Return-Path: <linux-pci+bounces-22402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72421A45349
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 03:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDB73ACE7A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B921D5A5;
	Wed, 26 Feb 2025 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TAUG6ehZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1F21D3C1;
	Wed, 26 Feb 2025 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537854; cv=fail; b=GYg6vOygfoXUA96oRMUKsYMsKuZyf6+L0HHNt5yUPk4q7saT9XFAiT48m9m8cfpj1JyNrCI/KSnxrXrWjiYW/cj50990yNbkkb1MdlQDesJoLh1Hsm3+sOttjLfiRkLl/PvdxcRQxy4AzqEFic876kNUf0w1BXzLfzi9Ff5RTKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537854; c=relaxed/simple;
	bh=fiNwketc1+iqmhjOp9UFVbAh8O7nemyVWPT5QDuGtK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjWQoUIUrPHr8ADtEBOnmEtz8l++5+tMOqBnYv0zp0/QO1mTUV6Q7qV2BpvXClDzUlZhEJEOFdZPQkrx19luBRf8xfhwdyrZU+aMay8QtwOZHnh3uxv1WQf+wDzS3fNbc3+IPDS8d+sYV62i5MDj3eZeGmuhJYRAoT2+a+qZrCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TAUG6ehZ; arc=fail smtp.client-ip=40.107.249.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzzFmfaJ659XgXA30zd2QfaqKZ8+PPRSEqrm1kE7TG8iG6svy2C0Xh1uyWk6CiF55Zr7yVMZ7KFQb8p9ReshtaAps8DfgU2shpZrC+f+ks64PEpHfUG7LuA174toM5V0WqR9OCMGUD3g9HTTjd+e5nKLB/+bLuX1M8XH3XuU0gHcFNRIQf744SbOUiW65V7UpaQ5bTrvE99uN+BIWM/ITh+4/MqrQUPRhK/6o2FLM0NSWNOIDYgcITzqjMJR0luz7mGIWQl0s6wb+UwfXraMV1IsPM+VhamqSGZDZ4ejOUbC9KutpywChLbMPE3/RYZPiwhgXt3WpSC1nk73wOsAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCnAHGJ7oBCSYN70Ba/pPsePyGFqSLPzp/ab+fiDDls=;
 b=uVKpMPpMaPX4B5XIZ+w9VBb2Jp3CQRrSi3fd7FLhAgIuUJ/+BNWdQN00uny8M70TWFojzK2OX2Q5dmuoPhJBxxaEV4etM357YzLSYZYYKT3MqKxJqMt3+vGFg3wfAh+Bb+X6D8dK2vxbTgfDIm5q6x+gu8naHhpgkvSVBcWXd20Op5WDyHc28KUw19XsRixlhptfu3e7+5RnAT80XzPQiSrxXEj84FJU2mpinAbZhbzcfBKTw3mkrNVk1OWQolmJhIjQD0GxFbn79ZabI+RFRGSSH8Yizx73oBygVWZmXn//xaaSOcQcwiinasTBDaxEvcan8wt27tnnZvnjWDivQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCnAHGJ7oBCSYN70Ba/pPsePyGFqSLPzp/ab+fiDDls=;
 b=TAUG6ehZdpwngyFYfQO29V9IwBxFRHj7r2uKaV+cydmK6syybO5shun4GiUZ5JhUlWlhFDfKgq9HY5q1kopU47qVnb7DOgyQKLQ4m8kxAmr0i6qBcnGxSG46lfFnnNbrKxktQpohIFFAmSfHKk4SL8zPD8B0os0yRarGT0OdVIYo+WeipUdVh+zvE4YQtQUgdCZG5aRj8LuqycLKmb597J3vlh0YkDkXKw5syx7wNsuA3HbB3dEM8CJ1V1rSDxz2vtdIYoTsofJaEOX1uuG7Qc6Llk98xMLkrRcqvvva2/ZagKYShjQf01qWIz8g0YmZpisYAJKJDpOFstxtLMWUUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 02:44:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:44:11 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Date: Wed, 26 Feb 2025 10:42:56 +0800
Message-Id: <20250226024256.1678103-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
References: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a341803-d983-4c64-9e9d-08dd560f733b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kf+fQCpfV9cG5sPrEbnlbGeoNCoFNnAV6W2eW5mLTPf74AOsHK27G3JT0M8y?=
 =?us-ascii?Q?r4CmfR9LQn76uiURp1q9sRfav3T52xM6PIS5lvPmHTrPcvY7bv7QmLtCyqZi?=
 =?us-ascii?Q?V5ql6fQuLY35lqPhrnJAXB4H90bzKT7bnNWgXQj5WuC9cJ8vn5iD6Cyr27Ok?=
 =?us-ascii?Q?OjMWW4FVtvtXR3q0RUZKhF19DLZaG0xb0xkSPeNFKDwUmwdvYxC0jlFRvI2z?=
 =?us-ascii?Q?NQSj8i6IcOJtUPqcETLJYMbfmLqRLFQNip9ywE0aa8pGa2XeFcWP3VxC0v9W?=
 =?us-ascii?Q?Y/UzQsWMHm+OiQEzb+m6f8TRAzBGcEV8770LMcS/JlKLk9ehlJMRfkn6fPyn?=
 =?us-ascii?Q?hryFLRk/Bns1AdTr7F9Fz+CuhfgJR5X9bMrdMj+RQhCwajXjZRsdHEW3zRfF?=
 =?us-ascii?Q?rG8WlTnghx0Kj8UuhRnkxAHxrYz0MsbPKKARSIpemoWlhOcwVcElXmT6YX8m?=
 =?us-ascii?Q?aMTV2GS/urIFYf39V1e4v0Y0TUcKXhm+ZNkhUkdPOyR2FwdXc/Fs3GzIAWha?=
 =?us-ascii?Q?wuGN4BAfxdgDokhxxX8jkfaCdKde1FlhGafHC4JGHJTajYbCVhNU90A12ANr?=
 =?us-ascii?Q?o+dQ5EjLJ+yxIfkufi3vJwmAaO4QNcy0YIetLUSjUIk1oOD10fPiMmPPEZyi?=
 =?us-ascii?Q?Uq1TFJ8SCW5hLXxYsnfTHRnGWmGsUAdOycsHPIPPHLtxABZdvAI6GLntVFXa?=
 =?us-ascii?Q?othReGJQvV0gxFrm4xZ0XphXxi1sHRW1CjEwTnXjCidLVPFBwOOBQb82VFq1?=
 =?us-ascii?Q?Vlau5hiajnZ+JJj1MCicKYG22toan718VlDOObd1N+OnhZAQ/BwRgC0cVmIU?=
 =?us-ascii?Q?0wc2gUc3wElEYCYhWhs3eOvBNMCMU0CSTnkvkafRlXrOIl9W4eKo7V1oLEUL?=
 =?us-ascii?Q?G9QMXMpbw0wck8tkYT1uuEA/XtIFt4GKb1Gt9MuV5XhcMleoxbkfBzavTEwl?=
 =?us-ascii?Q?vkU7/Y3H7egVJvasHFO+N5dq7ezSUnjKXOl7jbewGTCSlWig3vp03N7EpKOQ?=
 =?us-ascii?Q?D/BwbbwNYtghmIdlWjqqJ0FuHjW/EP6wxLg6VVQ4K1HP2yG1KLorYKSx7xW7?=
 =?us-ascii?Q?8B9SHykodaHZLelmppgBwXz98LFp7W525AqepqJKtie/nsWrm3Ykjg4uzuYw?=
 =?us-ascii?Q?2I817Q439k7ra7FwZg5+XuKXnTP4X3a/tJHIvCD09MPo9tIMdayzqgpd2QUR?=
 =?us-ascii?Q?s7lzwRxJSnnGpkgNE77ZNAbkaiWiZVPzETDoQJP2ouRt9XfL750G3TZZ8YXy?=
 =?us-ascii?Q?L3v0sYGdHcv2bNoMaPQW18lMEJykb+ZoGllgT/HY+TJNSKTh3uZUBD2kegAp?=
 =?us-ascii?Q?BHQcS0QBHpmVN5Ttq4PlvxLN6jd4kvClsZVa/aq/QjY522IYz1er7XyOBsvU?=
 =?us-ascii?Q?OVLIkp2ev46G1KmB7ENuA34363Wbqayp/qRhHMxVZUuBakcrBhdYW61QFmHy?=
 =?us-ascii?Q?SlyB+A0JHiP0JmaNjamtsE6JtTU6bQt62jt+0kbLoaGxe0F3A3MltQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lt+qrMt1NwoPmN4erwWhJCSZTxwmxibN7cIzZCuFzf5PDgSJgleKiVal/gez?=
 =?us-ascii?Q?D7jBm/DBBiRe7r+1ZmQK1g2j8bUcvXMgxq+44aFbw5/iP6EeqpxltnnsHUW4?=
 =?us-ascii?Q?DuNIv3PfSdusXIn5QHpochvQL1wiLB2saC43Z1ectms9OkJJdIv3iWzFCXDw?=
 =?us-ascii?Q?0K+WO+p7PTLs4Ghp5FBXcLGLPwjGa+d/2veS2tWWYBETH0M4EDwFhP/W5Qle?=
 =?us-ascii?Q?VUCyDK5qnTetAAUjSzOT4Ux7DvG5kdw0q7ptYcAwH6KVai5dQPFGUY/pVAbz?=
 =?us-ascii?Q?4Z7CLBJ7ylnU5gQOCMpw+XabFDlB6IJGIlps4WmHRzv6d0m34y+i8vP9DB4P?=
 =?us-ascii?Q?vG6slgKIBqrWNwU4eAfmc4vycWNGolROXf7+JcXwH+1Y+qnSnQn/zkT+jktt?=
 =?us-ascii?Q?XrvFvJSORXjuOMiqVBI5dIT+BZ83be6hKYRn3C1PBynRq2r3xrrpK7lspwfu?=
 =?us-ascii?Q?1tMoxOVL+g0G2BbdCnHIQZfExny7w4tDZxQBtzv736oja7BjFATWD6WjM0bI?=
 =?us-ascii?Q?t9+GFEW/01OhXHP1coGXViDv8vCtTbLD8Qi+u5Zg7spr31SS7IKXMItlxo+e?=
 =?us-ascii?Q?nP0QBlbZI3QQeFYC4wUKCoONRaTH5Bl+ldLqk/sRjtm93GbVpftpP79komDr?=
 =?us-ascii?Q?GVf+e10iC99IGwrIWLiIiweHWlsdJ3hTJxyThP4Qp3dvB4gOyp7A5yc8vXCJ?=
 =?us-ascii?Q?sChezEDEMBV4RSjKWlqaVlzcGsNIHqmlSlTQn5Vq9N293F+3RxNNuRkdIkHo?=
 =?us-ascii?Q?iAknjkg1sUiYiUdaPxrmbeMyEzpwIAESdeDv06v4daK7NPqEHJ1oRb1IAwGP?=
 =?us-ascii?Q?ashx21WPQbdt8HEnTzbIaPE1MF/2PvC5mngdvh26pCA3PE1PMH0H2JpfT5MG?=
 =?us-ascii?Q?tuJPErwkZXIjuIh8uCIgzK9DUXr8YcqvIVJz842v0jNtTurPGn+NzuGl9xYE?=
 =?us-ascii?Q?sFKrh2ffQvxCD08vz+GM3IhtjWNoGvi4FtzJuhiX2Xzuqfhz4WUt1z85Bbpd?=
 =?us-ascii?Q?/NenHx3zO594ff/DBaiSTIFXNbfHkkjg4dDV4RH8U2ssLShVbrw6xYrnat61?=
 =?us-ascii?Q?TZegidgvxogPzgStqwu11xGKkj8rl2aOT4TzKNX6+0jFouE+HWeREYUj5v1U?=
 =?us-ascii?Q?TbVT29wdYjtU3gTHyotZhnET+UiUUBLBr0bccQqPFa6jofpO+Wzh5ThUZTIj?=
 =?us-ascii?Q?1UJC61iVrWqIoDqvSKE2ZyFvkmZu2LMm06QVrqEd6aqNORTH96S/FbBqDuTg?=
 =?us-ascii?Q?Kw7N0mkmwTmiWT9LtVYZNDxH0ApQO/Dj9QzFH6t1yQJfPrnj1zttUAAI5C0V?=
 =?us-ascii?Q?O6tUPUziPcmMY4e1JafwATaPhldyIlj0RxlcTeYIM/yGheuqtHAf/zmuvDaY?=
 =?us-ascii?Q?v+Jn0Nis+tt4vsn+azMk/IbMFX0wL/cV9aq+2JfmueUjh3P8BHEiVbSwokAh?=
 =?us-ascii?Q?54iWbuj4o7jN2fjB8JjpeW73AihLWdw+quQlzqt26q4Xz2ZwiCzRnFYEOIB8?=
 =?us-ascii?Q?7h8YJZaRJRhy4PwE57G/C8aEBMG3v/Jlp6Bk9SLOmpBb0hqNtpcyn+P9hzqL?=
 =?us-ascii?Q?ttOJhhLva5QlKUyVhTkGnNF3fFCoYryiRwnomifk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a341803-d983-4c64-9e9d-08dd560f733b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:44:11.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjZOrSd3L5uOyUsKXWPjmE7RCNB2uq2Lb61SVc91CofkgbQdc+fuTiZEgFnS0Hru+0snE86ERiyIjJcpdP3tfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

Use the domain number replace the hardcodes to uniquely identify
different controller on i.MX8MQ platforms. No function changes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f..ab9ebb783593 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,7 +41,6 @@
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
 #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
-#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
 #define IMX95_PCIE_PHY_GEN_CTRL			0x0
 #define IMX95_PCIE_REF_USE_PAD			BIT(17)
@@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
-	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int i, ret, req_cnt;
 	u16 val;
@@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx_pcie->phy_base);
 	}
 
-	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
 	/* Fetch GPIOs */
 	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(imx_pcie->reset_gpiod))
@@ -1565,8 +1559,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx_pcie->controller_id = 1;
+		ret = of_get_pci_domain_nr(node);
+		if (ret < 0 || ret > 1)
+			return dev_err_probe(dev, -ENODEV,
+					     "failed to get valid pcie domain\n");
+		else
+			imx_pcie->controller_id = ret;
 		break;
 	default:
 		break;
-- 
2.37.1


