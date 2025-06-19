Return-Path: <linux-pci+bounces-30194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAAAE09D7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 17:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F305A7EFE
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033E21ABB0;
	Thu, 19 Jun 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZwOTKSu"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BF54769;
	Thu, 19 Jun 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345447; cv=fail; b=Gjk/wow5w2J9rf7KIpYvQDm4w5eSTcEy4fIbUD/i/03I0Jqb5WFZtpyt6mou0DMV6yxItCR81KogAuaCB8qwaFKtZp/vAr6wyVlSJoZupuYSmAoZ5pn95zNRSKrjtSBSbOqxyL08FB4zC/hGKpG8Q+AaSMI91Xw3nqPjXPSoxkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345447; c=relaxed/simple;
	bh=0gUdCmRObIlAqqFf4bkYx38pCafy/M2luMNtOzSRQOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YFwiQeeFDPaIfdjJShdJDh2ihwW/uZxGx1WLffcqTZJHQ6LKSL1/7kIlmk4NYDG32GBu52h+JYJEojZ2JucN5Etbd33HEzRqEeYS2kPtgi6lJaJ9xrh4NxYF3FdbcA3jDWQTxmLSYvnaDKf6LPUmuwi2UC/UUmsC/ChTw8FfeNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WZwOTKSu; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpSG+ja3w5Alnyh4j2yv+2yIp8AmSqvZIybZM/I7Pa1BzK13ApOxcDqkvzzPa8OVHRIQpBrK8MzfB39z2B6Xhe399I0BuAphiEf3Boc/ZS+fjEPzHrqPK5oxFS6O9z6Jlq4jICqiBM0oJv6Bpo/vybdH4rh7YNfRw9WGts7+y2w4jnfX+RJm1EzL+ixgrQNdn1Upl/NSujeBZj6psN/NkjqggYHDlqUpbFIsC8MidAvG+FZd7YRRK7ATyEzMAPeUaOj0vi1VF3xj4FxFW1FOfPyIcSEMq7b08Gk4i8wKCeUHikzkIs90LkCxADkw9nh71OE0pr8xROu5R3EflP1sHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+x5byQUOY7qgtf9l8argamkgAzp4ZQgepYY2YIOFQw=;
 b=jdnDhc97YCjIwCLIwZhrWgIVgE62ieaT2hrKlG+BHSEYm4I+Wi0FdOHTAykxbK6nozkOjCeUUccpjigG+LAi1GS9bA0xBjFASx8OoS0wxJPYBmhcXZmbg1190FzrJan1fzRkfbKEh2PUf483/g//bzDtMldMbbvv+III9MPvXmnlDnIlUvlNEUqGzmUXQG9ZfgAIpsXP14sFjySSwQGS0q/fHpPdexNxDO560VlZLfOEI+7ZGfHIaGsV9ik/00xfDGM/YiQ2soOi7EL8XF3TFd817jNdniJFQpf/BSzvNkii1Bgfhq8WnPOaN6NqAG6+lECrmJ/AhdHv9T23uzY6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+x5byQUOY7qgtf9l8argamkgAzp4ZQgepYY2YIOFQw=;
 b=WZwOTKSuZ1aDL+yAAEysWUY5zR0EywsL4uOyYRdrLhAGeZ1g/xgI9M35DbyZ8af8j14yvkVhbfyjYrgM2gsL+Q1tZNkkKBsT+6zaUErCSb7YFeZwrLItprVKaKwCRjmTVIof6t9pJCevPu1UarliJAYMDqFWtu+MrdmnR9maBKjTOUDXBD8nJkXff2E3WJA+SYBn71v8+ge94V8nRr5OknZ7IzoWUrHd7DHKogMz3hVppRcexihNDS1x8oP+OTADidg4gNP3NamajuPJY+gNWPq0DgAyUgsdh+BiPl81ZPuy3Xt7hXxjagE5MHG8saN8+xoXi6/WmyLXrtu0dLyHHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU7PR04MB11138.eurprd04.prod.outlook.com (2603:10a6:10:5b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 15:04:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 15:04:02 +0000
Date: Thu, 19 Jun 2025 11:03:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Enable the vpcie regulator when fetch it
Message-ID: <aFQm3KmyAaCUWtFa@lizhi-Precision-Tower-5810>
References: <20250619072438.125921-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619072438.125921-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: AS4PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU7PR04MB11138:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d32bf0-97c9-4d97-0537-08ddaf4286ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ffWbPJyWJJzMTvGMhPrfBh/TisTfVWkbkeVMdJ/IatZodCH3S8JUqXOeqdXC?=
 =?us-ascii?Q?DzSrdpXEJ+ya4fZw2bflR/i3ilvXlUmYEBM0sfeelhAEyBsQaXKjW85uLJ1c?=
 =?us-ascii?Q?hqdOt+RferZVf59a0pEVoBOrsnzxaqJdB5AT52z7tsvPQCHqZKTVk0bMHUO+?=
 =?us-ascii?Q?83L6zjSjI9EBpahWHydkuHu0OdGzaHpm1cwA/O9ZK5c+C0FaSxoyzoaJMCc0?=
 =?us-ascii?Q?Tuo+BgKemmVbpqa6otFxTnug3PMocS89+XQFvy9pzgD1xwP4ULv5aqzIpYpn?=
 =?us-ascii?Q?utmDmlJctKWNo0EJbgNSw8mOqNdPtXxXLWbqntU2GGWcyhbfyJcVh0Imo7LC?=
 =?us-ascii?Q?pznVy4XBPBlN2O3RB9yT150tGpm/mi6zcCnrkr56BrgtwiYEWgmEs7z96Vb8?=
 =?us-ascii?Q?stDa0f2CWWWz+hZY2/N8dZPS3p+CCUgslfF7uIbGkG4mO5uZR29AYtU/ZYha?=
 =?us-ascii?Q?u6caFBmc9dMSadU6BxTDDtIJqafPblB6YX0/d43T5t/ub3nHGgLozTvAUA9p?=
 =?us-ascii?Q?n8ctCgneWuDWFVZyfK6bmJNDLAEG83dsF+E+6HbzQbyBxLoBBcgLO1Tyus2+?=
 =?us-ascii?Q?h1BMT78cYQNe/AHkyOV8s3BoremBTNE4LKoeIjtlY9DIjSAJ0uTsLFmsLrlL?=
 =?us-ascii?Q?FLD/OMzHZDaROUyOOimsLBM7aKDNEglLpHPjFdzpsAYMtO40I4b7o9McGwJT?=
 =?us-ascii?Q?8ev0Mgbkh3dV95MfPtyfWTqf0V0dQZyOXaAYvEJYEqdYUjOJ2GTp18hL/IF+?=
 =?us-ascii?Q?VQjHTplOsjTxStD3yvdP8JjXyHiL93qTsrYKHNSccsV4Z/E1MJt036B3cEcX?=
 =?us-ascii?Q?XGaM/hNXPWko5LRI5K3ZAYLq9W6oJ/Luhe+DDRtLeifeeKrHTWo0sr1Dnuxr?=
 =?us-ascii?Q?eolpBYsKn5RlB1WaO2e5unF1/H2FC0icqQLGXZ2oOBuxfWPEISR1v11DUcN1?=
 =?us-ascii?Q?Q9ntkg1hUi1hVXIQZHYXcUU6r3xLAuOrlnf1ZsEeYN2C4PlFKlqxKngY3Mgo?=
 =?us-ascii?Q?77hhCaUFfOQ4z1kafkBliUdjNQImYP1thDrT/WCWnuA0xHzO+ochRM/2487r?=
 =?us-ascii?Q?acvYuBdoc6l4ABd+EWqprTx7VE6sduXCjvt3DJrtYEZT6oOK7+6K9QeVgzBe?=
 =?us-ascii?Q?i3E4ebPznqyNp/p4sRe4ossVYPHO19Fy9bfP/qzyHVv7+dKkE8GNq+a3k1Iy?=
 =?us-ascii?Q?ObPtl85avLn7rW0DVBmQT5uIIeVVID8HuddWZj0gZ/eQTcEjbaFXMzysjHwt?=
 =?us-ascii?Q?NgpaIbEtFUW7VSVppo77CAMN5KPAaYdu6I5LLQSwH9luN1+52nOU3MPVDWN8?=
 =?us-ascii?Q?ZQqk0z6tp7bi7UENX5pAYBI1j6siZl+CY5hVPMvppWbmc7w39DpcGTbPmPLI?=
 =?us-ascii?Q?+S8PgNeRQkLeUY60V3hIWWSCOKH0V4r6Dma5naHwJHBtQBJB6E3KSH/3XhI6?=
 =?us-ascii?Q?92nZh/ysiUgX/MOALCmNmOfScCwBOlPWrhO1kTF9psNO0xV7KwDoqEmBW61H?=
 =?us-ascii?Q?jdCqGQSuflrLW5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ivj4kulcbD14lzSgVLjCTddUPTIxBdx7Sr8a22oer9u3JRb91vu4aQC0tw4H?=
 =?us-ascii?Q?5dNzNYZka0KX/7jzwn2R35r4Zx5DhEyBt9hViWNiFPavxYsPH6mzGRLCxNrv?=
 =?us-ascii?Q?jFIwCdq09Swl4Wnu2NHwUKVdblpLYYT3soAVmh1kAPGxot3EhIkMtgpd3xPs?=
 =?us-ascii?Q?xw1Wjmp6JSu/IXVVIgW+jRiEZcWGOAbTajQ5W1w+7gdtCLUIh9DQvU2JysVI?=
 =?us-ascii?Q?k2/yS08xdacKj6MM5Z9nnBjgku+wFY2/fNlItwHydn2wg5l0Xz5RKzqk0fy6?=
 =?us-ascii?Q?wcovKpDoWUIXGOvGrYCPYW7SqH1YfrsSQ87LomyXL3FMjY5fXsIS9sbZlDMT?=
 =?us-ascii?Q?DXeF9AQAji1l832YSn7r3sfM9Q60ef6Tej76daBzO990sONXOiibPyQi34tU?=
 =?us-ascii?Q?tba5lz/9lsQUGo1E0BOhYlDk8AVRAtJ6Ae5Ffgk+SNIa7kMuSUUSM7S2/UtP?=
 =?us-ascii?Q?PVyaq2BuJswLuCsl1pPftbNBpST4gMhRG1ccfrRIsultkfnuroSqbnj8ZB6Q?=
 =?us-ascii?Q?uucZiI6ZIk3xZUdehzbvP4OxH40h2eelWQJe7lqjkpmUHyx2+/vL+fsgDaU8?=
 =?us-ascii?Q?/zNZzJ8x+aPeiZ5rjssh9y3O3qlKevztxv6gtPytZVUKU7aVmz+Q4US/vrJ3?=
 =?us-ascii?Q?nJ70+UMs+V/ISyLLEwyliI1pypHQ540PM2oQ0/A4SKjyUjRyTXuc8dLYKLVw?=
 =?us-ascii?Q?wFZ/WMhq0SfCMWf7W9hLnlqalhdywKSptPnF5kwEDTMnV9U+EAUiZer60CId?=
 =?us-ascii?Q?dK50WVGkuGPw0k4diuetNObh8Fn1mu31yQtSmIH0r7e+xoab54XU7NnhFhKw?=
 =?us-ascii?Q?kcQF/y2ti7kGkENluwMux24TaS+k5wvp8l+0WmuVXyKGAn2eO9e0YNHfPwTn?=
 =?us-ascii?Q?T+vL3d4QSy/+v3FPVUJvPWSMUWsBI0fRnfEs5kg5osSMJxwXEmLOD/NKW2H7?=
 =?us-ascii?Q?zuCdOiB1BAa1K33BjZ0Kwx50OLHLgtqYiXzKwQbQ1XBrBt9VxL2w89+0xfLd?=
 =?us-ascii?Q?f+DSo6Wk1u2KFogpXWCnBUlaKKuo/HubyIXMh+eM1i2T/+xiOdqcarIxkzhp?=
 =?us-ascii?Q?l3HeQoipb60f2m+lBDbnlkwxevq7U2sKTkejMarchZzJd/1MUoqeeGNDSkQz?=
 =?us-ascii?Q?sVY0yAvlGW0RWYK/s0IDGcl0bOyEsb3VysVSJPzFNahTa+DYtbl4jPkCrSL3?=
 =?us-ascii?Q?6OkPi/d/o5hIGGG1c9GhfgA2sNnJq3gjJqRHNQWqrtlWD9I7X++792zoKX0/?=
 =?us-ascii?Q?QxyNfKkiZjbueVqd2mRf14SeGXRH7KVFa0JQKVnINmSphNrtr6VGHv8xbnbb?=
 =?us-ascii?Q?Cf/y6LX4jA7mJ3dZT1Q+awFqirYeAMx798015JvtGLGytDCccTAo7qxeOtAj?=
 =?us-ascii?Q?pr84uTwTzNmlMXzTJRnB+mwycNvpQ0xCoq6Seb2pDPxb/oPeSK1A8r/W1l94?=
 =?us-ascii?Q?xLY8Fbbp4kFUjA6FCNonUWXM+VlZPdhtkEkSf53oHicdUUeXrHY8y+TkSxF8?=
 =?us-ascii?Q?ynwFNGC6+qItksId87+j1tPDc5o+SZXBz3zMlt5Or7Wfb24bf9g17w7lNJqy?=
 =?us-ascii?Q?0fCaFY2ehpWAQl9L/bskGLDxtwHazpce8vAU0vFN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d32bf0-97c9-4d97-0537-08ddaf4286ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:04:02.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE0RNdW4QgI9DlT6TapYhf5KK0diq10MMlIiAJkW52L323m0tkGFdZ9CFkAlHpZNbumGqadWXI1z6RUYMgC+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11138

On Thu, Jun 19, 2025 at 03:24:38PM +0800, Richard Zhu wrote:
> Enable the vpcie regulator at probe time and keep it enabled for the
> entire PCIe controller lifecycle. This ensures support for outbound
> wake-up mechanism such as WAKE# signaling.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..7cab4bcfae56 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -159,7 +159,6 @@ struct imx_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> -	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>
> @@ -1198,15 +1197,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	int ret;
>
> -	if (imx_pcie->vpcie) {
> -		ret = regulator_enable(imx_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
>  	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
>  		pp->bridge->enable_device = imx_pcie_enable_device;
>  		pp->bridge->disable_device = imx_pcie_disable_device;
> @@ -1222,7 +1212,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	ret = imx_pcie_clk_enable(imx_pcie);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_reg_disable;
> +		return ret;
>  	}
>
>  	if (imx_pcie->phy) {
> @@ -1269,9 +1259,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	phy_exit(imx_pcie->phy);
>  err_clk_disable:
>  	imx_pcie_clk_disable(imx_pcie);
> -err_reg_disable:
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  	return ret;
>  }
>
> @@ -1286,9 +1273,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		phy_exit(imx_pcie->phy);
>  	}
>  	imx_pcie_clk_disable(imx_pcie);
> -
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  }
>
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> @@ -1739,12 +1723,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>
> -	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> -	if (IS_ERR(imx_pcie->vpcie)) {
> -		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> -			return PTR_ERR(imx_pcie->vpcie);
> -		imx_pcie->vpcie = NULL;
> -	}
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vpcie");
>
>  	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
>  	if (IS_ERR(imx_pcie->vph)) {
> --
> 2.37.1
>

