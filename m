Return-Path: <linux-pci+bounces-29992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332EADE136
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308733BAB1C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24E1B6D06;
	Wed, 18 Jun 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UrBxhEnt"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85F1A9B3D;
	Wed, 18 Jun 2025 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214605; cv=fail; b=ed/B/clO7WRumLPDlMRfnKFdUK8nrOqURI35yz4ybbKsiCyEvsuq2r1mo2T7jvsd/Ts3k+o+nUFwvOCpsz2+r1O0u38fogR8Cuf0kyvzLaDgJE0gysDAcGDv8V6MS9qC9A8desA7eTIB3qk3rsRV6W3YKGA/ljAsxlOqM8H/H1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214605; c=relaxed/simple;
	bh=zfu54HCXl/1OT21VFfC0fzTFwxkWioWa0xTe1UwVLrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uoUVDrLuehh2h/5sqKFB61kowxg9DuKTbDWY1MPXhbMIvo3FB4HSHwaOJKqUC90FfjsMperUtRwYQioolrB9XaMr9VcrZFEst8ZnwX8kEC1iQqEf3FtQ947PP7LVa6v67NeEOal1iuPuXG0b8eUlk8aRXfdcP6MFEkjK7GbRLIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UrBxhEnt; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyKTnIj5EEVD3/GyLepQZoEsmLG/VIei0sztC9P6Von0DH7Y92sEuwtjI5d2gr2netnGuPOI6A44xqBYWNQtQB2x1bj0uxyeifpqa3cZsaDyXqpLwcStHZbLmtey45o7uiQCIOP08PpQlRZJXr49TNAQeQoDEa/bsgyL5WmLrhfHpUahbPXypqjotbyMIiu55NlAU4yXZwvGzjYx9CNHMWJUuy9ChSzWpgCA6GN4O++bj3LQRFVf7o78FvQxz4OHFeqle1Y9XxIXDJ19AP/NV9ZQDK5xCknO2bUMtWrgf6R04EbTY0roiB4YaJ3hH7Dx2kBaja9pmKk0p6wW6JLNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTMvzB/EsyVGyMym+l4MxGNuLFj8Q5x+lfAjXjfIsmo=;
 b=t5pH6Ro5O/pzRHvVJj7HqnvVsZPWFAthLI+dMAAzCEn2eoL7/9uaR/mY2JXpfZoFb8WOMgb17Q16uD2k+xqMy16kXxFfv6Asr7qqFILON04N/2OoOZ+kINhnfKT2Pa6llLuWsLlPUl25DcNHeYAXQFNUu9f+1vAhro3bs8qKfKl43S9bm1VZ0HBFDKLxTvSSM16Uw3y2C61sPC4R7s28Y4GrAoXO1faVTzJTpbdt38fwYdByh08cnJwOJqvxWoax3gpU6OT5pZZo5OaLnhQzH43Wz8wlxXaZfVPd3AkQBdinMNCt6ghFC1Pgd731hTI1Z5WJDLlKaGfB/jPhHYn3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTMvzB/EsyVGyMym+l4MxGNuLFj8Q5x+lfAjXjfIsmo=;
 b=UrBxhEntBGbCIBABEdN5nk9ip+2KNdyBPOdRbr+KggAVo+4uSwdQmO553OY9uCitXZu2Cl+bMCqvJzGUtp+v/Vim+XcKq/CUlRg5qD7z6YCjWGERsQHXzakMyZu07ooaEYV6JA7f5R48LxFlCve/ulG2ozxYMk1nJWS5feYHPfKN4ssR2QA/vP459jsBIWHIVVJGSZ9/zVOMyNj0gMOG+rNo3c1ce96ZaAXC4NqYWP7rDV502zTwgWrTmoPcCKqWkuw7O9uTBw7IiPXhYosdvfLYLtPkgq8G1tsBsRLZmEHnDZeZzNoL0VVmKHMH6iIdeS826Udi9OEOQgeWZxJWhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 02:43:20 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 02:43:20 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 1/5] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in PM operations
Date: Wed, 18 Jun 2025 10:41:12 +0800
Message-Id: <20250618024116.3704579-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: 2144e1b0-d947-4e03-52e4-08ddae11e320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SQ5XdYM+a1oprDL/tM3GFS9sY9iU4PalJeV7RZlth5HXBPuJvqdCMbTnM9QO?=
 =?us-ascii?Q?82raK2QxvR0G/4mm7sWhaMNOmdS7uPJv6Ak+vFZ8GcfKUNuXQ4fPIjrmGmS0?=
 =?us-ascii?Q?icBwIrP+aNOYq4jj9J+8o2bsoYldLhHrmw5hBCxA09Wq9A8VVutEcMnJZqFe?=
 =?us-ascii?Q?jsf/iExumNxUdr+RhIdOCXUB/X9rB3pMeMiMEmCpJbfiv2yN4hCEPW3csdiU?=
 =?us-ascii?Q?H38GhfspJ5oJJa7q8yOH7imM1lNRvyTvFhSQcoOA4WKDxx6SuFazu9xssNni?=
 =?us-ascii?Q?1nQmb0DoUDjmuETF1EBYTgp1kqudu6WZW7sSGA8EAvtTHYyhRD04bdxvcdgd?=
 =?us-ascii?Q?intzVZT7TzTD0KIU0aqCf3Fk/zojo5sLomwDfX9ptfPu1WGldC2MaihRC8Mw?=
 =?us-ascii?Q?Mn0bLqlQe6Tk4EKcGwoTmEYh/LB2v0PelXFgmUkG+561j1l9hKgQr2ncxNkc?=
 =?us-ascii?Q?P7I9WeyXU7QOQySGZN4DTXN70mpRJMQ1ebJdKDS8PnKnCapjwbxWgilFytyv?=
 =?us-ascii?Q?m0Rss5h6Vn6Fg2oPhOmNwc+kLCm70ZyQ3qG4m4DqbhYbg5dfgeNCfHFX9SJW?=
 =?us-ascii?Q?3/m830wU9olKSs45yn5clR7x/j3NRWQ6tquvRCtEfj6Rmo08/r4SGedSfMSc?=
 =?us-ascii?Q?1KveTuSVA0JCslBFsiqQvOjlEY0yeaJZRvC7rPNtxm0Wf/Ye+8rLCKR6gr2f?=
 =?us-ascii?Q?FkaiOZtLnD476HErETPVhihGRpRPYfKfdWcuK/Z16qeZWeG2M3ORDSgK5SXY?=
 =?us-ascii?Q?aojqrNX3+JPDb2ADpidm6jc+BpQ1vlM1LQNlMCAJRNKssAmMkL4oPPSTbmIS?=
 =?us-ascii?Q?TD5C7D0/Qn2LjLSUI6FMmsXRie+kmKTz3vdSpM8l73fB/z+bGYilHXHittmE?=
 =?us-ascii?Q?AGVFlZ+iP6RS7dLToAcWLNjNfZgRLyLD5ng2PBSBEB/ab7thNWO0wrYeq6k4?=
 =?us-ascii?Q?rOJWQ6fFY1mlYYFwIQwWByRJHflmDjICgB36WWYSqNmNwPqD1jHNUqifgG4o?=
 =?us-ascii?Q?MA7xQ1hXJN8JiJ50IZy0EzQu7sw8Bipt5qPt9mziNXuHDeS5ija3QBxgNHv8?=
 =?us-ascii?Q?IXs4zJkpmwP9AxhERr3BlRaq5d5j6Cpj+J8OwktzDweofJ9H8K89Cv//Gujg?=
 =?us-ascii?Q?lRodMyO1D7Ilrep/+DgXn7dtQFwsolWOKHzc4lhd+nON2ygISLZY8/BLt/xW?=
 =?us-ascii?Q?OxDn02zZqwytAeYrwxCnPybLF8+aIUvJdgZJydz9fmj863TaL9FPzxTWY0B8?=
 =?us-ascii?Q?WDnCj3s/1B8+xPDlqA3tA7X+Z0HOsBM2qR2Vp1qOkl5bbaD+8zGMDh0O8n9w?=
 =?us-ascii?Q?nrMEoDRUjY7D7M0q0wenYE7fPMoAkjd81OUb8dV8N/Siv4lmM9Ioc4ibN9+o?=
 =?us-ascii?Q?DHdvA4pwL7ITtyIgrDkxcfIVxtit2C+hlSol23Piw17i9v5mQwEKBZxy8I1u?=
 =?us-ascii?Q?PuE40eQ/lBmLhSpyFc5ckLNCfEgIzrp6O+YUt3M6a7WNhBKgW0m5GiTE2USb?=
 =?us-ascii?Q?nljuWnSVxJPtG2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ix4CDU9nsh0XbQVuNBeLXAq+7UDqGvaxSvIEK9tmAdrepMuvK4QrNyr4r/x?=
 =?us-ascii?Q?HN6eJZeDGWw8nPEQNCb76NeBz1wh7jZ3zA1SZNtubpXsMe4Kz1zfL6Fna0o3?=
 =?us-ascii?Q?/y3yqCx9Ot/DmQngIU1PuO0Nm8kkL9X/ciDgk7UzAQhIsj4bl7y67jS4CGHZ?=
 =?us-ascii?Q?2NAS+quLTqo+gEw/uHZQ2528nhhJFwe4KDsJNPUapVNSlzlpR4+9qvcZaX3v?=
 =?us-ascii?Q?dEXKw11rCjXTJCeQG0oV/xs7/nYYFLgM9DdAkgyV1t3OKqsnZKqaQPoX4JLN?=
 =?us-ascii?Q?+vMvN48CfJbY11EtfPn5z/qRzFz9E1rX46vxDHLCBIwoyZGAAutB/5kmXBOq?=
 =?us-ascii?Q?h2srSsXsLoQuY8rVbN/ieOrTt6wyhK4EpaXqO/+l/sLGQOx0BFb3iS4YLUj9?=
 =?us-ascii?Q?sLHRVSDfofxU4J4RWk9tO6Aodh6ppV7P5MJRVmuupiH4wBUlw/E+ny+RacyV?=
 =?us-ascii?Q?JpLATssl94sJ9FNOMorN1G2fbVyOeQufTaMh8JGmcZUy1oJrt0f81AxlBDUW?=
 =?us-ascii?Q?JPYjLolDzEzPU6Q3g646C0t5du/5QJumBNuvsWGIOCfHdNqEuLmc0R3YrMK9?=
 =?us-ascii?Q?rzD4vyXH5IEHsMOBMbVYvaqYDIjED6RITfF2GNUoPAktGQkDION1qw38zZzx?=
 =?us-ascii?Q?YlNdhw/Wy/V/DQ7WX+TTyFvC9aTxi0y8pizK/9FOWpIo8LF9+tPM5EuNs84X?=
 =?us-ascii?Q?eveZz5aegrqh90dsrEPzY0sXzHVvbaSKULuese1uWILy8x/7zqMaX8Wc7yH+?=
 =?us-ascii?Q?8d0ZIWbOF5R9jRupLfcFXWLT3QgDoMkDKGOURJ8hFQn7Ns0SbwteAIMxgpuL?=
 =?us-ascii?Q?OlqL54P3RkruadXWusS0SbJsCJorGYTK1vv2WDGWCn+pBiWU5hEciGegXzP1?=
 =?us-ascii?Q?KqNMsLG4NtxS7irPMJsYFrC2b3B4d8gjbA91xi83T62RWcZ8dh4PPGAZ6Im5?=
 =?us-ascii?Q?i5t6x50pVPdq6Ztk0UJJDHeb1DrOEago4QckxPxuduc2tiEdLpLCmQ0umLUm?=
 =?us-ascii?Q?4HPz1IA0GqyhK1czwryns8KJkJfn7nvyKNdk4iKUScNFBbwYijBw2rISveBy?=
 =?us-ascii?Q?03im6blj5vsalOmm7PdLmHHL0yzHIS+mbgh4g+MqG02j36wUQHMqNT51ZBfi?=
 =?us-ascii?Q?eFENwhRowNY3JmB3IO6OW8+InV7SQ6CBp1JaLHFACzc4Hr/bEq6VcL/C81rA?=
 =?us-ascii?Q?zLi45luXG/AKjVJw87wiqyYysc6pAYY2musZK+WKKNQT+1feRbnjgG1TMKjc?=
 =?us-ascii?Q?hm9K3hZdq/S34NFzulmcwwsL7APyL9+vC5tzkjzQJTkylZTS5avOoLIPqLl4?=
 =?us-ascii?Q?ZYG/4Vrq/cVpfpz1gElkqYQF7Xu0ba0Vzk5JuxQ5A0pAMLSyJpkfJE7h/omz?=
 =?us-ascii?Q?+PGPJl2Pvu5GAz37kH0MlzoalyaAKCmsrwQCt/rJU9VTrMIa3TPUNoVR2k8K?=
 =?us-ascii?Q?97A+GSbj2v43UQVH9o18+mRDSW4DJoQZphJBL6+t74mxvdVnAdRDz83IF4AD?=
 =?us-ascii?Q?hNrmGBLZnvfLU5HFYSKqfyi9Rmqscq/O6Q5jcoPxCyj3Pjrt2V2OrjqAf3Mf?=
 =?us-ascii?Q?BjnfDnpVmKFw9iez4jsABbL2YCflVW9Z/OUE6Cd2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2144e1b0-d947-4e03-52e4-08ddae11e320
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 02:43:20.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozaSChl1Oe2DIMU2egID/aIb5l0YeNPxonU5eOvMxhIQ3VD7OdaJ1WwGIwaEQRLb4LMt8dgzlcfFWFAby5OJdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..8b7daaf36fef 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1759,6 +1760,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1837,6 +1839,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


