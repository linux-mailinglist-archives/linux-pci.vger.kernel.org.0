Return-Path: <linux-pci+bounces-25977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C543EA8B00D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD55617C5C0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46922DFB8;
	Wed, 16 Apr 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSVyak0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284922C32D;
	Wed, 16 Apr 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783774; cv=fail; b=B9IfOYAiUphLTOVBurSh4bdc928dILkc5jOpZmJ0x2NDECQfOkC1QYcWoFWdoJu3A7AE6zqpEzty3Bq47lAahORISp83uNg/HtVhvW+gDEiYqzzKXdosJOarSgOg/cXHAsj+DbEGpS+XDQdoN27QkYv0IkhihwCB9Hh8AKXBBhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783774; c=relaxed/simple;
	bh=baZK1Jqxs/Af5rJEmDWFrD/U0dl0KE7X7CVm6Mgumc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsH4Ll6X84DFaDCPkXJncq9DYW6KWraPXtJtPO+iRNG67VghZ0Ect50ysOqO7Qh9LANjQsBIXl+he22SA74Nlhq/XGjWIfPLKjQrNVNWuJCI+sjmQbX0qIDqxb+GWf9urUZcUXkpDeC4jroteQrWfETKCoNQC3g78X7tgbfHplc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OSVyak0c; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/ddV/ri1dFnCxp4DTnNsrvrBNQKEyBNxI/4mBjNdhlqFARAA4AEmGeEqYVyxA/la/sGy5k45OEDbvNlP3X5KjeqO9gnkrLEQwlqm7V0LfXrqQgfsC+9ifpwa6F64oqLkmoSXL2crsCfPsIruY8eVlvLvqt7aBVf87Px96nWxGFgDKNCn0ovS7/JgyUsDnwHfF0l0x5vfIsGQycUXt+7VV1SScB4HqOZ7mg/Q752sFe+Xo5lHtxDc7XTNEKeSUAtEyeDCNLS5Q7PtpauLg7SSnyeKPPO1WjR0WL+0hb9Em6hecPAzj7ST89YIodEsAuKd/Rev3ZSYGtDwkH13vsjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44ql7gMMxH0e/yMRoGv/knoUioHznUcfCCpcl2n7P+E=;
 b=de8FvW+hGC7QMC0y7TqKB52FiIIJwnSS93GYZkzLbBTakooP+ikgZo+OgL9Yi3ZiXm11sC87mD723SwvB3ER9bfREYInj1cyYdlhGUpRrDJgO7k9/zsS7UsknW6Kl5UOKbtmC5rFzzxGgO8PWSMq0JlWKrUMckRbLMz8E5AQAl65juZl9rkWajv17H+Thuq+SLszQ5MOsFw/7htD3u5uFgCujVpBsNLKSnUOXtsn0svzdDgOt1z1JrVlGHdIIjyBWF65rqw4W0lgXOJP/D89FNxa3czpY8a2hghwp4UorvKVqFiTl82SJfF1Ojgj+dBajpPUW/XHvppqzdtFE+wvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ql7gMMxH0e/yMRoGv/knoUioHznUcfCCpcl2n7P+E=;
 b=OSVyak0cUR4z0RjK0pGZZozucqxf3f1BqxwoBU44ZPaePs4k4g3feI6tvov0DjshAxVUgyt8MfJJltIbkfwGAKoIraqE9PHyHtRnmm6a3T+S+wb/3YAMNCR7eQ8ZuJqQ1bbnFiv0JuLpmj6sYaobJ+Gzm4e3mZjdK6MpyhlvCAu4z41HQIwhFYeN2j01dkzqM9IQBZTmV9gfsOatQGDnE3QGvV3lnHWp06Jz9jDRGqLlxumqpPyOX3UuRphzOJ0bOOrG/QbIyDicGpiZSMw8kBegyD+CWTCutaIbBW5F4dEv1Jh15gVwQycD7Zeo1bxSV3S46B121sqKs5tHOYf6CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:30 +0000
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
Subject: [PATCH v6 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Wed, 16 Apr 2025 14:06:45 +0800
Message-Id: <20250416060648.3628972-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
References: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: f165c5c4-3425-4cce-182e-08dd7cad3ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nf5DWiJMeEafChTiY6Pi26yCAyo5+4ocvqPZweYiBJd3hpBuBM0hn80iTfr7?=
 =?us-ascii?Q?BCIqUGs3gRTYMHsamAL6G2qqnhHnFFZomUXOSTHILmoh2AQo8lpsp6mmzsMc?=
 =?us-ascii?Q?w9vvc+LtUMO+064dATQYIBP6ha/UIZ5xMVsS1sQTJOaD3Jx//xK7nk3dXmbY?=
 =?us-ascii?Q?m0eSydLgvDIZA7IFRT5s8F0DZ7rAslRrxxqPI2uzAvUG6C8Ifl9LFLcbgigB?=
 =?us-ascii?Q?8ScxMybMsizC6yrzQsf1bBv5uRMYsflIn/O/Htm9u33Wf0Mf1C6+Zs0FQOTt?=
 =?us-ascii?Q?5N2KOBe31hysVaoNcxH43ZY+xG+aGWu1uLUUwH4br4SFgCPUiYxu1jGbn2/e?=
 =?us-ascii?Q?/LKaUfB/rUiaauoksITyvb/XMxHN1ZWFgtyZaTgAjxhEXg0gSTm30kzOmy/l?=
 =?us-ascii?Q?W1PRK3eAtg3OyrwDpzqOUCALkKpA6TbnZt0cxsIz6yDIdM/WJj+XYTNzgXpu?=
 =?us-ascii?Q?IsNDcCMhqpnWcQ417cAeqAyZwijve/1SHfwWkOdWt735ZnAOmdB8qn2TAILh?=
 =?us-ascii?Q?/kjG8Vrp90SPKnUr+ic07c3I2t98ilBjyls3IJgsbwjZJBKTgYePqEDlkN4L?=
 =?us-ascii?Q?OOnb5/JmPPb3X80FcbdSH5iYoB4VInS+oSKV4sw0A0pGr+v8g5XR/ZIL5BZX?=
 =?us-ascii?Q?Nv9Zlrj0C9AmDy3hVr/GYYyPcsqVy3g7pTgZqhKTqaYLE7YH/O4q05vQv+D/?=
 =?us-ascii?Q?D0isUytdM9TNDgQDx7d7/ux1Yxs92mAapOaDW0gw6eQU5w7Jm1SpNgDUw1Xc?=
 =?us-ascii?Q?ogjdQBbsxKeA8HZ3MZF1KR3Oe6RFsdi9b/vR2yVJFB6CVHiL0tQ5ZO7R/bnU?=
 =?us-ascii?Q?+fBF9/NoQHzzYZh/KTBPZV6xVse0qJVUhSL+M4pAIbxj0ssrQGBphlstTldR?=
 =?us-ascii?Q?9jST1XIvUwaKnxOf4152yN+wjSKCXauICSgb4ztS6+rk6W8MGsww1HYFhXby?=
 =?us-ascii?Q?YF1qPnnyfPQoO525snd9I3jQUsPcB8nSROBdAFyjIagUlzGWDIL1Xxe5hpt5?=
 =?us-ascii?Q?+oXyQf7o3APrmJJ3kSydG2lkilmZ+TfgyuVYzRkwcXltkVWS7wIEJ8++sD6w?=
 =?us-ascii?Q?gLElIjhggwJyal6hz9BHHW75JCwv8qN4cmnblru7A+dy9gYuPzJLiWXlXZFm?=
 =?us-ascii?Q?f5oI6YDq7Rav0JSgXONOdOp4x0MKPfyFGBOP5PFzAh0szp/bxkEZZt9lqoxW?=
 =?us-ascii?Q?HBeU2c6kLACD+UgZgQLmpsGqCHea3Emakg5EN0u4dZAZLedjX2eTeURuLmXF?=
 =?us-ascii?Q?zh6eicMzBsW4c1V7exBXKSTEycn4s1aunvDddy4dqPAoBO8f6Lvx6XUCbhw7?=
 =?us-ascii?Q?ewJQnHUxnEb30Z3hQoQBtzT8ihMbZTcMXK8eYbmwM511K+cZsiMHFQ0QFEuT?=
 =?us-ascii?Q?79TdMdzKs79tfmSZ3Ry92E9bRDZQKQQSzonjd5QXgrl5S9QcBLRpP6HoeVNi?=
 =?us-ascii?Q?GNVUgkcPZWjd98kp9BuA61sMJFwGxTx+kWTlMgWHHUT1j01MYvKQ8tIegQPz?=
 =?us-ascii?Q?HkH0hz52peTifHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKvpYLGO/cRIFlI3oZFpzQ67se2AS2b68qznCu9fF8fdzID+JMBOWVC2e0Vs?=
 =?us-ascii?Q?LqJK4erKQNamQOpjPFuGcvMsk5j/QR2yQPkhofFWT6rOIGvyjS/3HG66Djfo?=
 =?us-ascii?Q?X4mNvF2+t8B2EZBjZYhGZ2+u+VsPjp2xT1FfjF+NU4fpjBVrSmA+W+GmkTUW?=
 =?us-ascii?Q?hwIGBDtaTl7pxFpPyGqlKK6kJZ476H4ZBoMWe44aw0AtpQumGr/Tvmea5PS3?=
 =?us-ascii?Q?w6lI5bx8CYanBcDw7Imqcb8OO+0EO4+ljCKA8Op4eQhhRMmB3Cqy2fHzVFa4?=
 =?us-ascii?Q?x5TVk3Targ06oocV4f4Z/328oWKZg/XPKHIP+opMkCwNIXOh3411517aB4lg?=
 =?us-ascii?Q?jDfBLAcgG9c9hhnH/QJS29AgYfmXiidrFsA/w6DMcEIVrZh60mMxSv8AG4re?=
 =?us-ascii?Q?Fzw538jVYAeA+tV/M6oxaZzZ4jFMFKr2IVyJmeOwIePFlhL8eftPvEIyjWri?=
 =?us-ascii?Q?HyWy06lHX75Ow9XwL6ULlJpoP3cdRWQXeB6c7eThIY0QjpRwk+A8lZlbafSL?=
 =?us-ascii?Q?lphsFve9hiD9ska2b0iF8Cw6FOreJ1InYxc2LZhU111kdU6+7+ypHgfSBay/?=
 =?us-ascii?Q?hcbCeO+PXR24BiDg5S1GFS4a677nRYnsVLomzjIm/Ft921sBIC0xeD3F89xV?=
 =?us-ascii?Q?XnBlHUHZtXNuiWX38C7M61ttAWMWfmNFu4R5cYs+s8DcwCHrzkwussOO4/h2?=
 =?us-ascii?Q?Mr3h68fRx6fkMeOsGNbXLOuc1u4IsKh/0V79pXVlh4uZDRtVLcpfwrNclJn7?=
 =?us-ascii?Q?TL6zS6cIoRZ/vLBsl6Y4bLkFOsh7YoL2db4i3uAnLvEb9RSo6i/hGZTprX7r?=
 =?us-ascii?Q?mNKIJ5iihyEx3Hxo5O1u4fW9D3nPPkd/6YEeKCgWhELpfuEvhZAZBAZCzI1O?=
 =?us-ascii?Q?m7uPG6bK1kyiv2OBzTkoVlrtdmnWdDqjOgf1wQoFERlnFRD/mz2XoI5KdZyK?=
 =?us-ascii?Q?4/WuZFJpwFXDLKZZs1ZT+6hi5UeZAgA6zrVRcCybj6R8paBjFkimbbLE6opH?=
 =?us-ascii?Q?nJfSiQ0lq0ymXeg2n0PSzampQKiOCMfyYS20RVHJCiBxSOZjmQG+hLcRMc3/?=
 =?us-ascii?Q?iXR6ebVae6oODfMMUZklPjLgONE0uPElEBei3B5VjJZOFb9WZ/THyPVp/xgk?=
 =?us-ascii?Q?PuDE7oeomhzqHRJsTnmhE6tsAQN6GHzJpau2xDvgD6ihadnVNojUzzNxivGw?=
 =?us-ascii?Q?fHmvpObnjcenSXjtKJKuBePg9DZNJbSMuExYeJc9BUKnBM0ttQ0ISCWWO7tl?=
 =?us-ascii?Q?e+lw4ky2fSZJnpqAZhWjaw46kK+cn4CPMQOuLCBnB25RCNa2ZyUCJFNYCD0W?=
 =?us-ascii?Q?l85KpKndFxSSRGZgqiZWpmmjFRoiWQROim5F1QtMD4EPSMy3zcLqaKnFVjIR?=
 =?us-ascii?Q?P83jCfvvc3Qg1sYO8YTeMk+UCAN7xu4vUf1gahyeHNuQy3gLVdgWXEV4ytRR?=
 =?us-ascii?Q?NvuouU/BChB6RK208b/ZVFujW13QqwY6qkebuLWkZ/he5eiikk1xKcRW1GcN?=
 =?us-ascii?Q?f0wgl9U5KFC0gyhTJqLJN5DrRMjTghLvequp+rhTXICvJuyXtzofPIiAXQLD?=
 =?us-ascii?Q?SH7HmzcN1/tomYHGKt1EMd5/5EdYEnKw2uYS4xgJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f165c5c4-3425-4cce-182e-08dd7cad3ff3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:30.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOCFM1oh/fcPFJwvxQX+hkIRpeCNr8w5D3EER+w6EhU7//9Lv80T8PaNNJCG75goHHHAhFvxzm3ZZe7oBsWWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

The workaround is irrespective of Vaux presence in remote partner.
In the other words, this workaround should work whatever the remote
partner has the Vaux or not.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7c60b712480a..016b86add959 100644
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


