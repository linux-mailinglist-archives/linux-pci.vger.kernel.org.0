Return-Path: <linux-pci+bounces-24563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A399A6E322
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061367A374A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBEB2620FC;
	Mon, 24 Mar 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAwi8Qa0"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B026389D;
	Mon, 24 Mar 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843659; cv=fail; b=FZ320vMepotOsGI98A+s8RTtl1ktTxgEvJSM0KDKAJ5pvwE+0n6QLpo2D6LhLwXx5u+f2C8IiG9ohmIavmaIqZfqiOGI6he1hnXIvkARGDdZF0Xw7QyVmflgccE32qAZjEmb5w/clJKksxJj2PyNidDAvLERUdIsFudczG9e9Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843659; c=relaxed/simple;
	bh=Cl+WqOMhTQ4IaNlA++TTU0/ofqgjyOgEQ8/llAe8htY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qMCjTqfrP2NgCZfDnRAspsA4YPpgJUH6nkdOVoO+H3I1DJJgCYTrS/IWXxMJYkAqdY3h643PZRaHlMgpS2mRQpDFQV1VrCqszdUphc3tzDvW83zDhcfuLsyLxNYLmQgrcoiOH9GT48D4Gu+qSP77YW596XyMRoFrwG7oZZ4hCXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WAwi8Qa0; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKJT2hwxOtLYcwy2rpAp9LVcQwZifPThss4OYTFEphOYmrHcSppWLt8s6DJL7AiFNECa3+hKtScrMFQE6Ql4SyDE8ui1k2SkGFm4XcUXpD0Rw36Pyts1Gjay3IdeVjThu6KwlE1wvzNgpJyJ7Uh8VLG7/DGbV8nhzz2ODOYJ1AflQZE5LnfMAaot/heKvr8s7ST19ZXCuPLm5z52frL20B2jT79gTMVljl4JcCgHviVePlwYSjNWFPcdmpnoiWG+buHXRCeEJIXU+SGBi8JOlFVLWt6E+A0/HB2fVOAtNOuLGD4sP4uMTDjKNy6SU0f/EZ3Z8yQUoSDdUbBUZBmdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BbVHMCiAUNyTjY+95gdqwMruxqrP8xyjC2fFREOqjw=;
 b=fCA59NfL+PYqrIrWjN0+Jp3Gj0DQ2LiKzyBCunX7HCS7/cSUMmjNjcdbIqMjtZjfadqK+zBBNlpeYIGByFsOh33MGL3SR/VugJXp5vPO0h6PbViMOBSyb6O1XGwKXr3IYzTs0M+ZdtTFiz7a2Vplshgj6cMiCDB9xSO1CwsMBOm/spKyyHjjBQzJKQiLCbmAqIt5euUfeVbiX2zErfaqppDTK97PNo7+U5A7nELuG2fpIQDN28EUmPgrVq5Ol+AnIWxDedvK6/aCO9iw6damE0yuwqvqUvFR2ZJjypxhuSPCmsZeizM+IQ6zqEBDne6iQZPbHCATOKAbAcPnaa9BIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BbVHMCiAUNyTjY+95gdqwMruxqrP8xyjC2fFREOqjw=;
 b=WAwi8Qa0OzI8MwuK9vSvo02fwnlcuS7B65zWr4aRmhR3YHeVAR4YcDbEI0L16TtqDZbueKSAG/aRgJOCWYu1gTrVvXzTCcdkduIaT3dizax50szsqbb788Y99SY1kj9fI9PBmJdBB07RKJSkS7IXNfeG6XER/EURnF7E9IlkYN/78wd4+YdUG3BjcNED1+ByR3apfQJzvAinc4/1zs6cfJAHnvdlmuSQCrMpYUDO345VKNjwhO1X3p73UF+WdFlsPabcUML2Q6CIzbGkSwYUvwY7hcmXbR8CGdZTdwZLjJ+0OgV9aPKDhZE6U2ysZKk5G6TOigMe2IGQ5tpRjRi35Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10439.eurprd04.prod.outlook.com (2603:10a6:800:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:14:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:14:13 +0000
Date: Mon, 24 Mar 2025 15:14:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Message-ID: <Z+Gu/gmioiVJfDV0@lizhi-Precision-Tower-5810>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
 <20250324062647.1891896-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324062647.1891896-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:510:33d::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10439:EE_
X-MS-Office365-Filtering-Correlation-Id: dce68205-bf56-43f1-5193-08dd6b081032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b0WO77GOvzSM6FzP+xPmlsMhNrKjrEyPEcn3NGlajATbOy2KpsanJqnEWOJv?=
 =?us-ascii?Q?5/wOuAaJmdAClsi3tjFS8mZTV4g/d+LM+asrtVX6ZfjhlfeS9MB90XgW1k2L?=
 =?us-ascii?Q?T1eBDF1tiIzQhptScAWqvGlgSBtTvwNSrfqprtC/yFA9hm+2X5wif7f7arI7?=
 =?us-ascii?Q?sQMn3QaRjrIqyw2AMOnZHu81CSNBMg9mrw9UNbYPdePjSlpmpVN9J8vQbwu/?=
 =?us-ascii?Q?NgvIYBttqtDCjioBwy7IyCv5qL/+AfdgXW2xlHYchieBL2Z5omB841nyX9um?=
 =?us-ascii?Q?blGbgG/VN01F5pFk0qi/lLH7F5J2hwg+iXkOBXCoZk0TUOgYiVH/OSJtjiq/?=
 =?us-ascii?Q?Uw+e0IatasYYzKin2FntugZvDFxQu9KaE7sekSLcGBPmrwfX0TYKTGU5z3ZU?=
 =?us-ascii?Q?+C9hYx94RPMTAVSe1Hu+0xy4Ux4mleUJRWQa+kj5L+hDl3ferP5232UL0cQD?=
 =?us-ascii?Q?KPP9v4J8kp3azAajrLaMXwciyK8+Wdxbm0/02jD7zrw5YjsuuPeUym75VVjC?=
 =?us-ascii?Q?F+hrPs4uLg77q3FjDPnhPvpZH5XT8Xpzd3Wo7SNRzwao98CYzQr6wPQTFiOf?=
 =?us-ascii?Q?3f64erBFNbxf6HxAe5AEIrRwfI7SqOZDeD2OgoVqTKiFMpaTF783MiK/c7Ts?=
 =?us-ascii?Q?n3PthdVhGTA70lAllFypIgIyJaG58+ZH+2cKu81zVhhMW36PMF2Iz+/Q7xGM?=
 =?us-ascii?Q?aUdAVpFXXv2Wv905jNhFPa+xPWQicNHaMzjC9kOo8jzbVa4YtBxSyJ9vvwGn?=
 =?us-ascii?Q?oD5aehLI4szK8A9uWBkvadZK+T4j+h8gPY37JZdvX4ykCHUr9uW1nomwde2Z?=
 =?us-ascii?Q?47WY2PylNsDUO9F3W4PCH+MBhoDBl28rcO904tL3GE8gdgg70f3BQMnn8YOF?=
 =?us-ascii?Q?SE6vXDSe/CGB8x0s03imcyYNst243iQ2eTiPpIwDyRj1Mp5lfWQK6YPqMlck?=
 =?us-ascii?Q?lAyriNi1V4NJVPShcy79WcnRirMjs9jNAiuN4q4MetGsVMcXhzNxjgz8xxNi?=
 =?us-ascii?Q?ptugHHVb+s92O4NoiSwdjHkv4mfm9DbW4vRQbv3VQjyvSCSwtxmvFkouJVbz?=
 =?us-ascii?Q?98J675q9lu8vqSMQ6YGw/hK9RWq0me3VZCpNigB1EOa0h7wZyq0Dt8SDAlOP?=
 =?us-ascii?Q?XoC2MipMWH7FvL6kxyF76ip9kgi0fa4NTbKaBw/6HJ5QR11Cny0wLQpdaVrZ?=
 =?us-ascii?Q?KLDoNw5C7TP1Cjox+QAdX7o1nKFjnDMLLpRxbILQH53lwexxfe85eVaUaQqx?=
 =?us-ascii?Q?RVUaC3wypDKUNW+rVcE+RyC23ng4KqkAuei8+E19Nl9aDDWerFHNdU2EZ5eT?=
 =?us-ascii?Q?20d8FCYIOg/00YmN14hsT5YEyFbOPKRFT53rCHst4n1IzXaz3KJreczVHbEv?=
 =?us-ascii?Q?+vGHx2d2rAe7I55tTWVecbI0y8i8/A36bewewZn3qvtxJF1Q5jmaZH3L4RbE?=
 =?us-ascii?Q?a6oezMsRkJG0hOkm6eCgO0jvVm7LXMYe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/ge2Abo50ugDzezCaV99xEOXSrLj6j5yhbYoV/G9U9Zgv0cfch+Q/ZhJdOI?=
 =?us-ascii?Q?kVmPxKQHFd2bn/sMaN7umLjR/gcs4uWtQfjPIFlb3ARbJgoPB8xbu67dKUVt?=
 =?us-ascii?Q?YvKXnsKvU8piqWLOaHIuskSYr/l5RVu+zhckvOKOxpnNs9SOVo2zRZTGBoSU?=
 =?us-ascii?Q?tc+0dEbqay7c6ICitu1hHqIyn7Acnuf1/5QdtOaedkv1LYdZsGcmPb5Kz1GG?=
 =?us-ascii?Q?eqB0wc3DztRc9vBHEXAwjN19fiuHb9VnIE9U5cQN/uLfLRst9QenSbQy5q76?=
 =?us-ascii?Q?Sul6yoEvWn2upNLZdUMqEdkOQhDDEbik9INuenpxDfX7DfWndyFLZKYfLCfQ?=
 =?us-ascii?Q?mGjZ7v7CahuyYQQXpV/MuDhaFcW/ln4OTB2qzla1kK5KVdv2EG/6nULNlScr?=
 =?us-ascii?Q?59Y+/Ug4JZpuFE1Lf38zqttuavljjlY8xxowX/NcIOi0aRmjBRlzFBqty+Ww?=
 =?us-ascii?Q?OVhyTE6A5LfWPyY94PqIqhql7CSZH4/WMNvPFj17EB+zx5iUNga2iku8YkWk?=
 =?us-ascii?Q?SVLpyu6+0sEnojfV9kg/YGFO4QTkx+S2AY9394aKAlO9AgK2mJk59BwoJyfG?=
 =?us-ascii?Q?ha29x644xmITy7f+3z8TbJT50/7eMi5MmhN67aTp9yCBWFgDWs8pXddxBWht?=
 =?us-ascii?Q?Ewhv6oWFzU0JPAn2y+NKJDfeslmXamG0RnLYhhbDTJc/cHK6ub3bCvTP2lGL?=
 =?us-ascii?Q?7Mqsr1q+d6gnlXN3eYe89TwwBBRS9PXLKSrkfEEtsZNzHHj+JsfRLzMEyEgk?=
 =?us-ascii?Q?z2cI4hPwq/31MFhyRZ5f313ttHvVN2a7d1loQqSu3r/mnjm29f2EjGu3SiKd?=
 =?us-ascii?Q?Xp988o43qAILQ3UiO8qKBbviqZWAvMA2V+qQAu7THYhXMa/cp5uermzoFLnC?=
 =?us-ascii?Q?p2CyfWs9ZVQZ7KvOhT72+9h4bnpdj0ABvi06twMmr2nJIGRWHiuLrWxpNy9j?=
 =?us-ascii?Q?GSb0VzTF8TlQm/DVP/ZvLD3nCyNM6HV0/STzCFu49tzQBAgeQsioQEiidSXu?=
 =?us-ascii?Q?SOHLtZn0Cf52mrNe+GEddEL6zOZGSB0FrvNH4vx+0UwVnVZ4BpooIULzl87a?=
 =?us-ascii?Q?T2NMidIAKNJOxqaK07+tmA4PIMSppA1kUSjtBZIirc6lm2x1Ge2aXH+eStbk?=
 =?us-ascii?Q?UN4kYmFeOzofMx/1/GYU0UINmXXsKXAZ/EYS6bkNZ6lL/xwvSzrO4edYkRAu?=
 =?us-ascii?Q?W/KtwuhvCo6OPdQXF6DvU+QEfDiZgRH4iAbvEf4nhosQAUPDfaMbPVkkxssD?=
 =?us-ascii?Q?XiF9zpbwq1owLi+UaLu8vLrxgvJEXM/PypSVgBy67z3k0yZJQ9kdQoMNkWuO?=
 =?us-ascii?Q?QYM2gJ0ICuHAyOHMD056Ka+KnOX5Y8qTqUIC75aEgy810CQFBDLePmMXYKQw?=
 =?us-ascii?Q?4+IhTTAtS4YAEfGcjGe2K835+Ic1zEGVi5H7Ugysz4n9i/KQ8u20vygxzYRq?=
 =?us-ascii?Q?3f4HurGG+wiSborGmTIAV+1bTQWyu+Ddn23fO3s4dqiuaHTIsvrwRAXowHbr?=
 =?us-ascii?Q?iSy3qtcO4I0amEvGVIUHZwpAWCXSF+DQkYTE6Pr96L/Jb6twG/7WvWMPgXG7?=
 =?us-ascii?Q?W8co05h4yTkH/lUbpoJdCs20KDG1XPUdIsLPC8Hk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce68205-bf56-43f1-5193-08dd6b081032
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:14:13.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmAELHpIsfzU+yuYU7H72f4gUkJmM9AjNcX4pVcr7SuO2HfcBMoIbiGqlw4q+nP5KT5BoDSJSnQMEl7ziwc08Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10439

On Mon, Mar 24, 2025 at 02:26:45PM +0800, Richard Zhu wrote:
> Workaround for ERR051624: The Controller Without Vaux Cannot Exit L23

provide a errata link here.

ERR051624: ...

The words after ERR051624 is descript errata itself, not workaround.

> Ready Through Beacon or PERST# De-assertion
>
> When the auxiliary power is not available, the controller cannot exit
> from L23 Ready with beacon or PERST# de-assertion when main power is not
> removed.
>
> Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0f42ab63f5ad..52aa8bd66cde 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -48,6 +48,8 @@
>  #define IMX95_PCIE_SS_RW_REG_0			0xf0
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> +#define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
>  #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> @@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> +	/*
> +	 * Workaround for ERR051624: The Controller Without Vaux Cannot
> +	 * Exit L23 Ready Through Beacon or PERST# De-assertion
> +	 *
> +	 * When the auxiliary power is not available, the controller
> +	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
> +	 * when main power is not removed.
> +	 *
> +	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
> +	 */
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			IMX95_PCIE_SYS_AUX_PWR_DET, IMX95_PCIE_SYS_AUX_PWR_DET);

regmap_set_bits()

Frank
> +
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			IMX95_PCIE_SS_RW_REG_0,
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
> --
> 2.37.1
>

