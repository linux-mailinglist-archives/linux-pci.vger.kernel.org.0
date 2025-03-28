Return-Path: <linux-pci+bounces-24951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF3EA74D2A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B987A60BC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5C1C4609;
	Fri, 28 Mar 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e04/jbhK"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEA17332C;
	Fri, 28 Mar 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173628; cv=fail; b=Iphx6BNlmH+EbRomeRk396ccbe+VOmzDtRxvyLWdjZ95zMbt2Lh8evMxb2iLAbmcZ20l/wPr7o/0y3mNe2rCCiUXRJLn02PNVd8OC0VfNtgNsRH1u68KHawN8YuvgWZ+zT6F4ZzNsPy7zuXvqJR6uSMIp3c6me5eCxTG1se9Mdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173628; c=relaxed/simple;
	bh=tfkPGjbAn9HZBB0rG3wyOBTdtvqatww3BxYVVVNZjjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kRyJkgVD4/Lbv20gMRjl41tTap6bLTg6EKYSQ9efReMRxtAqWN8Kt93zaTHn0/uj/Z68hGRiK/bYjDixYYO9hTcfp6YHgRNrQHO5iJmNiZIIcJWhddktpYCiC4ZMrqbbMMT0giUm9Bw9gS57V7u5XguE7cSHQHv+aU264VK1ZZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e04/jbhK; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySjAy7jA6DdowykwhDGLkcXDiIKwCQZGNGlfEaaB/q8IytBDd8eiFA4OCJOMQq+0brobBggiClUSi1R5gj+WWd8NNu1+OU82iUN/1lQt7eXRy//n2QZmBsqpWeSpBft8uKE03/JCDJF3u5UBo451mdI8/2t6DZYZ7JLN8r0M2sNhLhtbjgvR3EhrgKrhnJMHa0MJHubx8hwotSqXQHIObgLX1s82F+tILmf7FklpMkIHzAFtVNz2+a7c/kzglN3miR35bKNj0/ZwCJJHvRI5jLjqPh96W37M0pjeF5zaer/VRTRwCea/9+0NyGuddi2kVI6jH7oNQXlifiDcHp2EyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW4XRC8RRIvswrNqc1GytbUJSPMhqHsI1ePi5uwuvuU=;
 b=uW5oi6YqT6pe8+rGpeSVjO9W3S270g2RbTAYhiMduy/EHRdPlIvH2xXNevxz1YkE9j44y/9H5M00BMxzDyHIR/yaWwzLSh+r4+Odx88qFpfCQkG7guiryMmXLdfajUESOEZd2f53MPUn+s7GPvsY3TpRfOwYQwymulWhyUvxvaOhraVfy48ABcZ7DirNRhpHlw5KSl1PgeKJ+dU87p5hc2LiKPWwSm6Jw30ZilBhkOoAUkdU6sFjscfp+1AAkV1McD/AD7dtf45JOtT8b3n1QyPMIlw62tEOwRbVrPI0k/d5DGGl+H7R1Ao/0BSUy37ryXhkmYR0GISbwNUvpHHR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW4XRC8RRIvswrNqc1GytbUJSPMhqHsI1ePi5uwuvuU=;
 b=e04/jbhK05AsWwPg1ulqx8TDN1cHHXe5fzzqyKqc8ysZ2//w9kdzwITm2JoPLapvJkwg8Ah2oHzekq3BBwrtO0xp8OwZ6eZjUY1oHfjb25bIC5UqfQo5fRCSSm5B4RXqF4bpHNwJ7q4jvGw7C/2M1uKQ+24W1EBDnmZd9pytJ9FgkNYvFPyv9BZVQeCQhIDYpcQd2ORBKD+XdSf6JtpZcEOqF1ngK6vZb8cjoZXXYRU6dp5reWhS//S7hjBoAGxldlwCuJfwWafOuZCG6znY4ZJ6cfuVJbXQobcF/GEP98IulfRVTFhO6IK26LBrObV5uuAZHoZbUKCp3ezaFcMbPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 14:53:43 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:53:43 +0000
Date: Fri, 28 Mar 2025 10:53:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <Z+a37g228ERrR9qd@lizhi-Precision-Tower-5810>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328030213.1650990-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI1PR04MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 6252eba4-62f1-4cf8-79f4-08dd6e085541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z2wnugEkZsWpTgDYB7pRPLCBJx4UByJMPpzkpAOwiG+u0sVf/xTYrWoM2fDo?=
 =?us-ascii?Q?UZIK0oq+wwzvI8BcLcfWANUASsaIs6BjrqUWgtArsROtNgZrQOkOLB2OnVzA?=
 =?us-ascii?Q?GsX2i1Mtn+QON2vQ7nZcP2TcI7yoOvFN5+hlgwHmij2/Pd+XVa5mLGuVIdYf?=
 =?us-ascii?Q?PWHAlwlyVaqgrsPkqWprFuMSxQvVbdCzXM/NCa648qBN1xk6PbF8XgPwYOVA?=
 =?us-ascii?Q?nplB61+n95/FlhJWxuxlA9G11SR0sIC8K+07wD3pq7PW++Od7EiVQEZHiNpF?=
 =?us-ascii?Q?ZIjMpjW066q+Mzp8z9qO04qjYQfvDUs0254VZ2MVwrkSZ+7y1gphvIOu34co?=
 =?us-ascii?Q?BhoFN38KGu5xPaC7wAMxr3Cx3YA7tkO9m0blw3eEHz1aAJkACmHqvdmEGokZ?=
 =?us-ascii?Q?hn6jbt3aPaPIm9ZyNyY+rKGjg2U+xfRo3tlNfl64HeYUsX3DbDbLjE+7ggHd?=
 =?us-ascii?Q?d7qYeDwaT1zRRNq4iGiUycuBXYUy/Y7WnDolKKY/jLTbRvR7vT2JbE2b+8iL?=
 =?us-ascii?Q?T69PbpeRY4dZpl4cwjraGyytziCVJjmlMbTTY9xpjchVUvPuTNmHd5JHgHOk?=
 =?us-ascii?Q?3atOs5emqkQDZHfbISm9YCkagAnaBG0UW1bV0D0CRIRJ0KPMv3cHTgBkEbYe?=
 =?us-ascii?Q?SQ2w6+KwGtjB1VasGCVNltrzUr4bjc/xatiBbKUFnr9/nZDqsClrlfm0Zxol?=
 =?us-ascii?Q?+pfPcWes/tN5Ka5Zk9ZOrxOGGl298McFhYwZnSU/m7JZtsUE8epmAhPhF3aS?=
 =?us-ascii?Q?tJFuO0umqcUyz/cWFhMM75J1CyzkgjVwU3brcn9K1Hl59YZlwKNju02oYTwS?=
 =?us-ascii?Q?lt1rvHcKxNTxIDOm0Jnc3KgAQvlChtRZpn9BEIhGbT8w6Naqhh6M9oFZVzmq?=
 =?us-ascii?Q?4vy3ESLk5j33wuv7ZLyJwpcqmKCNWuAl7n3KYxUnavYLg4BqdpRwpg3TPL1m?=
 =?us-ascii?Q?A2mQ2uHpuxmiAUKaWhBcrOUgBvyCd+zcv11Eixw+rjqGWiGwNakaao22Y5i4?=
 =?us-ascii?Q?zbZ45yIkpVfKt2XHFiQifrwnIcICteqQhDqq090zRO1wz7V6F6ffN2YJtd9H?=
 =?us-ascii?Q?m12rED3jHmzmJXNu1zxe2TH55EfYp69erO5bXlK7JnXZd56QCoI9p13aHz1+?=
 =?us-ascii?Q?L+GbshutTARWldjPTdXe/hc8+jLaok1juWiUsgZrxns2BitQeYQIgBMh2ICe?=
 =?us-ascii?Q?bIDWRYTw/qe3z6ZwbIxDbdLg5E0vOvuCN65+12eDIetXB27pTj8qWYzkgSNh?=
 =?us-ascii?Q?7kOoPjAf0rBG0OLCDXPzr/xSMKHZdpczW2930oopkbWwPThbd8yrddXRt9yf?=
 =?us-ascii?Q?0K23mAKhdO7o2k83dqt394arE34Vsx/siAQ1uQAUDs9MkAF/KpC9e1pNPn/G?=
 =?us-ascii?Q?U5MdhDRndGh3OKodG9E5/TIA18Si4uD7UAjxvGt2Dq2bok11hRDGBZgOXAyO?=
 =?us-ascii?Q?u4YfRVWins2ao1mft+AzScRxIlebGUbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooGk45nmJdtQq29hjqjFAFxN6pAyZUC4wivkZ6Cm+JM1huf7iz+YjFfsIsHs?=
 =?us-ascii?Q?9nu9et0APGyNpc0KazNO+EtbkDHu5+9n+ndBgCXtKYeRfprlozOk/4xw5q+9?=
 =?us-ascii?Q?uD6DxZUflVmAk6VJIcUTJQCCltElh1lRQjJtjuao4A7mKc/2ZEzTufshzcEB?=
 =?us-ascii?Q?EYOAe4DO3bSXaKNYogpcvtBqR3+8rVSFu7qpeBxCrLCQpLP8R9/otJwZ9w/8?=
 =?us-ascii?Q?KqkUbelQTpMqjMpx/QU0nrBPWqi8Kb3a7a95LiqqIcDdOxOrDOTxxoEfZtVR?=
 =?us-ascii?Q?ORONEgCBFka4yzm279sbGviP+EfTI86nMNUTmaMSOWQ0rXwj0/V6NCX1Pw1s?=
 =?us-ascii?Q?LI5YemKBbP0NucfkaBmzuNXL2zgc4Q7RXMS4l0wxq4Ct39QEW4byk+GK66Kx?=
 =?us-ascii?Q?u1ZP4DfLwTZnGEhKJWz3/TGc93C6Dqs0Xzh8Tl85pt03sDrKFBAtLUic8FcO?=
 =?us-ascii?Q?pEMnpPG+iIGznXTkaFg+IS1J8IhZceOTZBY/7/pbrO2yfy6Pejf6T09KOcEK?=
 =?us-ascii?Q?ecSrbgswtfs7ih5OJbjhEi0Lwj6RcNKQxsPCEIxUGv4uiKsQbApDAcdb2jr0?=
 =?us-ascii?Q?LIgpSSgNE8nuSsUWvh3mF4RibkIMID8U4pRUZJ8AooSgL/0yjdnwoNj8lxoP?=
 =?us-ascii?Q?AmzD3oHw89ghoh7T0yl+nsGaueqN0uPSszNS9F/oW3Tfgyy9JyWQgsUhbHUl?=
 =?us-ascii?Q?asla4zEevWKCnAl5U749ryXcPoTANprMepM2ilgETkV/plN8alJEzhyt8Ztz?=
 =?us-ascii?Q?Q+b56Lwnj8KDG4uzn9UKEzv+zWGeeI/bzIbmlrztvXSCaPMnJ8Z7S/zkj2++?=
 =?us-ascii?Q?fauZbR7HLI9JsHLdAb9DRkM78qDTjEq9j9fyplkrXCfvMIdh45LAIz6cfKE5?=
 =?us-ascii?Q?LP5dEZcW/yBRhX4TPtynrYiXwiqN42dWlsGNr7h1EHOficc1/J85PhbUiNYp?=
 =?us-ascii?Q?UeU9kK81QzJ5MneI16a8LhKbldHTOBD/EoE3iD2VFUeP8+PHvwVmhQejGt+g?=
 =?us-ascii?Q?bxvbHv5XxG74NXrtkJzJ5KAskU76SkE/zLh47qtoMY7a/qw7plb0caXVC12Y?=
 =?us-ascii?Q?s/hs0ioMaUmPoVlSHpHx/TZss6kYuE7nAbF2yOLU/QsL99Se5QLvvadNVzHU?=
 =?us-ascii?Q?rR4ouJ16midr/lCGIr1uRZJ732FND9q8T30nKyfx55Y5xyAGyq+fg9k3sI+g?=
 =?us-ascii?Q?B7YVYTRfQPy0CHmQS2J3EI+/h3426Ut5NwI85yUmkIiVbUgJq0AU8IgnRZhR?=
 =?us-ascii?Q?0LbHi7dRWkjk2bN24BY7MD0q81SCZLMCge2ylViOFTXvmw23rZw6k/wOq6zW?=
 =?us-ascii?Q?QvMZxnLtMIrR/pW12Dk9EQsz+Wemt0iGC9F6ccbrKGnkzvKxBGd5gTUMccLk?=
 =?us-ascii?Q?H3pmgEKm+RVq2UyBWzbeyGcVLPsv+SxSJHagnOFMzP+SdDmlOPWD+IHvIyHq?=
 =?us-ascii?Q?UXmgDhc/GqMRTOI1lWaRU5G4uxl+sPaBCymaMbj4oCtiJ/ulRThv44JD+hbe?=
 =?us-ascii?Q?UrE4m2PC13UAUMaad54RiWSNfnLzSwclJLKVGRRIYQkPhmWAHDxNuUdyyZig?=
 =?us-ascii?Q?++zFTUe1LabsGY1araLYIIs/+x1QZWkCusZLTxD2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6252eba4-62f1-4cf8-79f4-08dd6e085541
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:53:43.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBDLVEmbmO6Oqhmf/Us9HxglFdgRNXKkm6+sCG3k+QckVSh1qV4wao79yBB3/2wjI8Pj17umavEYFdY4ReOj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864

On Fri, Mar 28, 2025 at 11:02:09AM +0800, Richard Zhu wrote:
> Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 57aa777231ae..6051b3b5928f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -71,6 +71,9 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
>
> +#define IMX95_PCIE_RST_CTRL			0x3010
> +#define IMX95_PCIE_COLD_RST			BIT(0)
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>
>  enum imx_pcie_variants {
> @@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	return 0;
>  }
>
> +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	u32 val;
> +
> +	if (assert) {
> +		/*
> +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> +		 * should be complete after power-up by the following sequence.
> +		 *                 > 10us(at power-up)
> +		 *                 > 10ns(warm reset)
> +		 *               |<------------>|
> +		 *                ______________
> +		 * phy_reset ____/              \________________
> +		 *                                   ____________
> +		 * ref_clk_en_______________________/
> +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> +		 */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				IMX95_PCIE_COLD_RST);
> +		/*
> +		 * To make sure delay enough time, do regmap_read_bypassed
> +		 * before udelay(). Since udelay() might not use MMIO, and cause
> +		 * delay time less than setting value.
> +		 */
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(15);
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				  IMX95_PCIE_COLD_RST);
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(10);
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
> @@ -1762,6 +1802,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  	},
>  	[IMX8MQ_EP] = {
> @@ -1815,6 +1856,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.init_phy = imx95_pcie_init_phy,
> +		.core_reset = imx95_pcie_core_reset,
>  		.epc_features = &imx95_pcie_epc_features,
>  		.mode = DW_PCIE_EP_TYPE,
>  	},
> --
> 2.37.1
>

