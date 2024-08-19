Return-Path: <linux-pci+bounces-11812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FBB956DD1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AB71F23640
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C2171E5F;
	Mon, 19 Aug 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbKABEJ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92817170A20;
	Mon, 19 Aug 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078969; cv=fail; b=KKgl58WAuVn17Fn2DBmnJjZYloLlYFFu9KzOks/WjET+i8Y6Uah9IUrZ238NcH6Sy/hMZ1KawAbIO8PKOUITz+xdDRUky176jBjCoLeiMDYBIbS5iZulCS4qprast86u1bsK78KsQCzAxAjsrEt+Qg8xZ95bR2VinzYzAatSpHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078969; c=relaxed/simple;
	bh=QiqsFPlKJn0Ts9N59kgw0jN121jeJeMzzwGD3deLoDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqKyLr7xwy8btblvpTi+Xh0w2GA/CceHhiq0W5kBuOVa45sgxI0pgDtjrYD1CeraTm72HSVdZq07deJPQDie4hrwwMGYssglE+ZwegFZZOqC2sfE+ZElB5itlm3Hd6RjOMJSg8/GfAkHShv8st7j5cfS0SlCZ/IiGSRy9Ht0Vx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AbKABEJ7; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLvbI3g35Ws5l7XD0MG0q/wkSopQDttnLinnEdmnYnPkJaMtr9QFeq8Z4OKdPLQd9PdB+jpQDiXLkGK01fP1EYRk2A7LFElwaZD/EohFPytu9SzpPWT72rXHcYCq/ichPAfRwdN6Bm/10Tpv+HmgsQDJIpWtm1MBAkS6uTiT4Z/z97/2OIhtNdGOUqbRPqh+sQE2dNG4/hZ5OU3pQDCm6977dn3Bjaor+NtLdsF2PAbSSOIcnEyhHB99BrZMURcrU2+iOl+NUYimA9WOo3wIqS8PMHTYDbG5svI4gLkldUxsEddznY+bEdWiJ17ZmrWfVDQgERvDlnhzXDkDnvOjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bP8Slw5Ij+kXPQ8tnv+tBirIk4P8lVPar+Kpasavf8=;
 b=bX77lg6rfXame4NBKk7r3CdXxcJDIyMKSHbfVVNwelE9loehatSn+Nxuxv/rFTAn15PR2TzTptrma9Mq0ifNyRqoXrO4/tyYmW1OEgW322ZTPeGoNYLvWsUDr8IiLIjZw15WJnh9DH2k1YAQ2nAjggskn1h36QeYyKNKMMsyHWLiJQ7zWRcm/Cebj5rdi0tTyantEfK1OoA5WsgKU6fGSjPY2J9qJSgE3fcxUojGGEWfT6UbZshRCWPrzWdvdpywrXZLl1qpA8TH1q9oY/WUlTNew61KeGYKdhlr6U6oV7np3VZu/7wxV9GFyKCk8ypxf+tBpMbptuPDsLr6XGsx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bP8Slw5Ij+kXPQ8tnv+tBirIk4P8lVPar+Kpasavf8=;
 b=AbKABEJ71FjNeZjtLPEs3mqmjNZpVEKKmBsenk/AsOMWHPWkfBtWDJCRS0ja4KugdOnSTkSEJ32Fs2smbjR65WhZqmpiN2IxSAxsHmfj5UIBTcle/BBDzpa/lFBgCFg0jcYnPBIM8zlb7ARLpu5NwDEX931+fU9lOfJeWcN2BfgZed8V+xdLC73vzMCeBqR25aDLIKzVOX4XrR5MOMb+ZGmCuyP37uMupo1qNqnaGVg10Uudjosm77LOXgvriJDbeAFSchPhU6VGJVmtXksmrxiSmBnAh9Kb6Q4D9ABCXaEnFmomH+Lcdzfek1JKxIE4NkOtKZg1YwvoRJnIDfCIxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 14:49:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:49:23 +0000
Date: Mon, 19 Aug 2024 10:49:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/3] PCI: imx6: Add a function to deassert the reset
 gpio
Message-ID: <ZsNbau03d5J0sLy/@lizhi-Precision-Tower-5810>
References: <20240819090428.17349-1-eichest@gmail.com>
 <20240819090428.17349-2-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819090428.17349-2-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdf2849-0642-48f4-7cbd-08dcc05e1d9f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?lQB54gy16K6XrS7TL+A4ldWX6jWByuvEsfqhZXdVnG8fq+Z0P3fRtOCoedB4?=
 =?us-ascii?Q?T5IdFoz61r0xycb3JVGUUfe1Yb1Tdtb6Ap0cUiliEnDmB7d9fhDvC3bQX+gR?=
 =?us-ascii?Q?lMQmOgrBGrQ8Fv3LwM18AIAJUo8RIr50nV4arkIZVKN2e9Js9SmpkLT5/gDV?=
 =?us-ascii?Q?USUlrzIZI5qgyog+nGe97kH2GS9B5XTDRjaeFMxb6FTXCtLz0uKKEeDThZE+?=
 =?us-ascii?Q?Au4Cacrg0POhq+F+ZicILoHV2+P58JNSnzfViHWonDEX6dCFK1IqaMkRp4Eq?=
 =?us-ascii?Q?9wtfU302JEwIPx8c6Vvd1QlzIPyyypOcfYfoq0CIpTOJ4hcbYwezYFyB7lbL?=
 =?us-ascii?Q?C1OynR+oG+433XZNkGjKzr+KTZCkqDKoeTUL929YkAlTbopq2+RoxNaNhUrE?=
 =?us-ascii?Q?o0RiVoDxsmVz7OG30HWxlEXbeVBjp95pWNQ3hlc+cQr74ydjugr56iaIkI54?=
 =?us-ascii?Q?CvTEYLFCFPF6nQmPyc7kgoG0U60sTEmyy2AK2+hnHXmS7P7ie4WAD3Bdf9iT?=
 =?us-ascii?Q?8732iw4BgXukeT6wXflkGuUC150xo+UjDtx4OfA2w95gu2xwoxYIXAyBfpsz?=
 =?us-ascii?Q?/kqgrBJaGtb7RpkfN6z0Qx75XV0qfyrrORK7ZVVzptoHXemwwpGOJAyGRYAa?=
 =?us-ascii?Q?U5HTAAjXfZidz/m6Opmm53jbWJQRaNRq4u6gJJd1nfzbYi7UujanDpd0W2NV?=
 =?us-ascii?Q?1hY/hGontCtuE4dVSB2nAhnucYN5bAQVMHTdIjqgQCTiR96yuJKdCNVe6ivP?=
 =?us-ascii?Q?Exx4Gv3Hb2AEn3J7d/ED4d98jJncskmu39oNrOYdMQj3glh6Y8bLM3+kc8zo?=
 =?us-ascii?Q?uF1P02RGMUyPwAYVQoATtJm8+JiP/v7lz6H3b9RVeaDPZ2UCqKd3tIF8mbIW?=
 =?us-ascii?Q?hK84CZcBbkkkoEv68zYeHeWorfgihjjpPrDUaH7AkjxQBOYz5BIi9la7ewoK?=
 =?us-ascii?Q?Sgeqcn+wKMetFqc9iXY1x6rWimr5Jl7fsvKby0/kce5y4yS1wuP29XCbJVwD?=
 =?us-ascii?Q?4jZQZpqVBU3OiQklrb37T7AkLFMJTDbzUsFu0FX9LDgrVB3soSC769aAUDPW?=
 =?us-ascii?Q?csbFrw+hAXzu2OQnNJ6fqnfD9uGc61MrqGvIdbmCqGKnXJwhziABkbO4O2ND?=
 =?us-ascii?Q?e6TmXhU8wnM7Tb+kpF2+C0TeEqkQsOoBGKsXU5qm2uRFCy3o1/S8WIe8Ar5z?=
 =?us-ascii?Q?BM0H7jAxNhwqEvF8c6bLuVEaEPvXQimn7ouMrWxFLISIyab1G7EdpYtfhwGX?=
 =?us-ascii?Q?ojYGbFyit13OOkoNbvgJ8DoIk80pyfvkLRPc/G/dUy/E/o2XO3a0viD3uuMp?=
 =?us-ascii?Q?U6SCLy3EavWdOv8BJQvW0uoQsYuVGjNv/KySkb996Ad7F0uhsaypsfx0QGaG?=
 =?us-ascii?Q?SVWwxWIfHXzAoeXixm+ncXeKbnr39BbXYK9anxMRlScW6Y7zsw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?gco0suCtJqxH9v0bSp86d0PQe8xgs8d/JfBAKeyZQWqHWH3ze6RmEeXklK7D?=
 =?us-ascii?Q?ojEYcWXAHloCvodSjcNl+uUkHQXb/cc7ozBT/MKRxkZe0atm8c0W9lrzWF59?=
 =?us-ascii?Q?JdK9E0DNBcbYymK0VRcfijFeTlBJTBBp+IPyO79eP0yWR0ahPTTrXNx2hfhx?=
 =?us-ascii?Q?LfzohKZ/Zu9PtWQ9TiaY1UYQjQuL5H0xzSOw+mJz6Cud3pNU1TPFwV2+f8Q3?=
 =?us-ascii?Q?+r+69DOFuB48H8YK+9+OAFJ9OoZYRjKIh5MJapwGvJs83dO5qOdqOjtBOmhG?=
 =?us-ascii?Q?GR5g8ZEVNcEoL0qxNOCTEqaW8Sc9L26XR4HNCJSMW0keBrx8kfjfcwJI+hhR?=
 =?us-ascii?Q?utkyXBn3UXX3TqV8Dr9bijraAw8Rgw82LFk4//IVSrGx+netyd9tP+8v/DEB?=
 =?us-ascii?Q?G7xCKPcTWnoucyqzrI8PyX1rxbWuZ+fHmjKcU+4OwSp3/APwJ4UGRvm6lyua?=
 =?us-ascii?Q?cuMdlm3iaoPRf8M+7jMNDz97l0rFvj0UEKSgml8QZgeNekUgVPdDAqHPPCq/?=
 =?us-ascii?Q?SZEN1gvxiPbCm4+P/tmTjTwe+BEt+sJPI1PDhvtnH+eCXPmfWUtelRiRLDS/?=
 =?us-ascii?Q?Pc9JzyD0n+FFzZlGDH9OjNUx2R/dhOpZFF4tYWGOtS0eWUZxOV8VwfiUS0md?=
 =?us-ascii?Q?Jo13BpbUZADLbTheorx64qDiay3I7szHEbM7aW99dAsVY6tY+zDrg4AjgLYr?=
 =?us-ascii?Q?J/MX0IjHUU32WgdkJD3sub02XICV5WI6GDaq7yMesOflsXqIICUuHPV6J/ME?=
 =?us-ascii?Q?wamBwkMVSzsGGlk6hMFK00hxYycrS2arl2oxSqaDmOLFerfocBy5h30FufWF?=
 =?us-ascii?Q?4ZDdruUkcURm6SXMFCZvKpzOBmCEMPiLP5DXOOVJM/naaqZGztIXKQebsGZ3?=
 =?us-ascii?Q?ZtIdlqtrjhk7msgM//Pgqm3em0g++D5PBX6/XTu6ETsW9kBNHrsq1xgfNyjx?=
 =?us-ascii?Q?Sd65jfweHGOTkulH869dfEX/cGEeTi6ebCGXlaTnW5UDpopjWYglhZiasjGN?=
 =?us-ascii?Q?Wy64jrbAkUTMutXfddOznEpO4xMPPQYTH43gO7F1FXVeO7Y0cqtWqExixV3V?=
 =?us-ascii?Q?/y3r7VsDHzaRp+qcp5iPC6vvr1zjJr0ZoD7Yf8059y1NwYnrEMD6mAurgcGr?=
 =?us-ascii?Q?UZd6IuDkmXkqsqPrGIC+3JuKizD8gFFoWg+77IpDyMqZ1Ku6CCp1LJQRR4C2?=
 =?us-ascii?Q?Z5ttjqlEMYnAGNhjfwNl4Yfs+hf0vjIFTMMA/U4vP1Q7692YO9ff38oRw91Y?=
 =?us-ascii?Q?T3W7kQ26aO74DEp82sTrblVgX7Awk+BOgxNfQK27p2AyyrdTp/ZziE1u1cZK?=
 =?us-ascii?Q?ptxA0ECt5VTq9CQ/McaI0DW40bYYXjFLW4wBXQjUT4il5irLdfXakRr01RR7?=
 =?us-ascii?Q?Osgmxks3KaHYhFQ3FVcpT5SmjWft0rkXX0itzLEfsRoRVjwpMN5dOteMm1ay?=
 =?us-ascii?Q?W3q2mOeefBARMceDR7Ut1WOxFxAKeaH2uqkMZ4AJDH18d+Gi3qdGScWUSUXh?=
 =?us-ascii?Q?BHfOpVojBSpcq9YVfVpN6616QU/8CUITTCdOUSElODznaet/+qjR/wWqYIXd?=
 =?us-ascii?Q?FxX9pPuzqtPI9DA7kT0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdf2849-0642-48f4-7cbd-08dcc05e1d9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:49:23.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmbUC70y24Xx+cDTc0vaZwoHxNH6vjXxTvN1x2z/CCnLcH+K2tY4qZ/iq9nLR+PV5iQp8AuzQ2U41OA36QI4jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574

On Mon, Aug 19, 2024 at 11:03:17AM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> To avoid code duplication, move the code to disable the reset GPIO to a
> separate function.

Add help function imx6_pcie_deassert_reset_gpio() to handle reset GPIO.

>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 964d67756eb2b..fda704d82431f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -722,6 +722,17 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
>  }
>
> +static void imx6_pcie_deassert_reset_gpio(struct imx6_pcie *imx6_pcie)
> +{
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (imx6_pcie->reset_gpiod) {
> +		msleep(100);
> +		gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 0);
> +		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +		msleep(100);
> +	}
> +}
> +
>  static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -766,13 +777,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>
> -	/* Some boards don't have PCIe reset GPIO. */
> -	if (imx6_pcie->reset_gpiod) {
> -		msleep(100);
> -		gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 0);
> -		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> -		msleep(100);
> -	}
> +	imx6_pcie_deassert_reset_gpio(imx6_pcie);
>
>  	return 0;
>  }
> --
> 2.43.0
>

