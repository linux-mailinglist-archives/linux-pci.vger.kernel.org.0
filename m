Return-Path: <linux-pci+bounces-30202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE1AE0A46
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2B51C24FAC
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41FD21FF4C;
	Thu, 19 Jun 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVCRSva2"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C601E7C1C;
	Thu, 19 Jun 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346220; cv=fail; b=KP9LQlnjY4LxE4rnMdjWzAW1qVMWWeGBJ5MUkcu1BdvgKPAdnYe4JVIOst9ex2Nkq47kD+UQJWfhML4GtpaDjYeo0b9Cf3iIcG5pLSrKZiBEp0gKs0ua3Jqe5fvnRA1GB/Q2vCCqNRQqgikSYyEQQms5vLhvlLF6PJBge+BcrAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346220; c=relaxed/simple;
	bh=g0OolTRrunC2RBFP5DrjUdgtuTWmRvc6QU0bfpnPbSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gB4voWtmTOyQOcQ6159lqGiCeJUNVEtTRHDIT9z2GUOw2kZOtJD/1R5dQ38uDbd/vFtP0b+NHZUxluo7VDqA0vTSmrt2SVpjuzog+X72gn/OqDmdYpq/wOSyjxqE4AIv13pd7BlX6mj9Or+ZV74uHA0tjfC6ipF9So0n9/2F7zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OVCRSva2; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OT0N4qEySPXyZe9t6hNjKXy7jmXWRwHjR8WoHIdKVQYpaN6mwYGLrIOpudkCy/7ihPVs5+YBRMbp+6iC4yGbZer2+bgrecPNMpJ4sMcEvv84ylaZlI0TsDEAvJovnLuifoWra5zbLUtg7g9wR9LfeWka18WwdSsgRIS6p7jRukbRSOyaZQWyV30wlsMIAgb9YZs739HlpXwMK7CUIsd2vIExcfvVnIkCAe6xqBu1TjJ2mclHmbJkBMjH7nVkF83apPKfMOdnnTiaPAdQqjUQB0vQbcTplGh92np9mbsPZ4ZuTqmmm2F2XJ+2zaEA5yEAadhPOajBBtD6aHO+bZaNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R811h/bVLP6brcd+phVAjGJYPSXUUtMs52NYQ9htsac=;
 b=KjRN3QfDtf6yWgybT07Xd2mSg1YhxLokl5ylyTwxhocyUtHFweXv18e/GSuu1WpM426DSuXt+0CGxrEgAqJdM7hhizuiWZ8glIMYhI84ZBDbvuYf4Q/dAPs2JFwvopnxX3iNd+xZF+gdI0gcu1OMh7b6uJ6W4JAi+krRwLT63lx1r+tX6ZkQ364jB0Kv4Xv97H+XmfGBphPQVAyVD/j+YYo23tfg3fSPouW/IiNpy4r6dkBev3oUlLZgQV9Rf8aW18//eTifT1EITD5PM3S4BXUERKywecgq5LsrBp2+4dyD9iZ4vjVWdMdiRHR7EochF1j7TjbeW3qVG2luCYV0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R811h/bVLP6brcd+phVAjGJYPSXUUtMs52NYQ9htsac=;
 b=OVCRSva2uvIJ7T4XKMiakwZPW5IcBrgOiG4qjT9GdXBPQ9YDCwXxAE8HfMK6edgHPALxcgJIliVG6exxZxB97nM3Wyh38Sth2IyV7SS2E+zRzYRB9TvUqAF7LnhxyGDR8MhGD0YdixFB00XcuTEU6d2ZyMhuj7SCrGI8qxYRUqD6yI5U3MU8jSH+yHOmpGz83okq1B2cMxPWyHhsVjRIxyZ8Q5lXBiyWUuJAOjH98RCNzVBEU496oU6r46azaBzyIpYyY2RtCSvFJ7ZmmGiSsLU7wXOqpWYVxgWJG5c9cVTAuXEIQsCQ7LbtenKi/SNu0zw4Ih3t/klUpo+bcLvajg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 19 Jun
 2025 15:16:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 15:16:55 +0000
Date: Thu, 19 Jun 2025 11:16:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] PCI: imx6: Refactor code by using
 dw_pcie_clear_and_set_dword()
Message-ID: <aFQp4MYpRaEUXNQy@lizhi-Precision-Tower-5810>
References: <20250618152112.1010147-1-18255117159@163.com>
 <20250618152112.1010147-5-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618152112.1010147-5-18255117159@163.com>
X-ClientProxiedBy: PH7PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:510:324::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: d7378159-28c8-4c56-b86c-08ddaf44538b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJQ3vjeywFppHjYzawgpeaZmXOaYRL/LCyEkHUzFJ/+Nh1C0hSmXfDNthCoR?=
 =?us-ascii?Q?4gElc3ZcPIwvVT4bZ8nGopAb0PHEH1jNDHOqhF3C0ETzoQCSXkvq/SAnSD5S?=
 =?us-ascii?Q?41fG+hUi6etb0+3/PBUNrtuLPS/dnTxobEqd/QRD5OiyRkyqLwnn3m2FkC1y?=
 =?us-ascii?Q?OkZxDntOXCYFjJY+JWA4ewkpGOLKSwb7lcaaIq0mDfIk2XOLKxbGeHeVhvQc?=
 =?us-ascii?Q?XodMZN2B5ricDt3FVV3ekH7I+VfyP++2h7h3ZLuSKIOYOkj7FEsYb/RxuIsB?=
 =?us-ascii?Q?55raHA6iai0uo5b1wXkBejFqBO9sEUNU/ha+gWDb7QgIGLQjVbY13xe3Uzmg?=
 =?us-ascii?Q?7cajo7NdupfxHMYHdla+idKGmCbawk0MIOw1JNrLYLoEgigTZ0JyTUb7m+zG?=
 =?us-ascii?Q?JePSvmwpyw3g2Xi1OUlf1+jOrmiRJFzSr5RnnMw7MGS+uME2qXQzts1AlVB+?=
 =?us-ascii?Q?0e0GLX4IUEr9bTeVJ19j5yAKJJSKxB6v7TwchR1tKIm8WN1G4wxbKPG2VFpn?=
 =?us-ascii?Q?Pyz2EuzIZqTbrcGLwGFUvTt5D35dKBSoPm6/GTPj0saZUPKpxD4iTxHLQ4T4?=
 =?us-ascii?Q?VRQVNTLEkJ9K0C5QF6NAM2syPoI5+/fOGJjia6yR/A1d29TbxQvpC2B9EPVo?=
 =?us-ascii?Q?Ytbo1sEH2GvdatXWDgKt9ZSwT0lWp6LN8B0xxREZ87rHr54pVxDEIRslkKdm?=
 =?us-ascii?Q?IM3ogrhSm4gosxcJC3cyWtKMID1tQoK0kKwV+01Y49MprYh3k6EzZi4yaIcl?=
 =?us-ascii?Q?VMAkQPHSMeeUL1ph2wSnkqpeYAzMCvXhfURhbAc8DBlO7X8Rs+HLBDT9OjlT?=
 =?us-ascii?Q?mLEGDIcx/7GvepCAHFUPcVlirljuIcScCUoTYOgtTn4EB5LF/WFxRud9yidw?=
 =?us-ascii?Q?STeaH29jupXcDEUeMGW3fzn67uDjLpzoUjNCrfeNoH1Feshrty7jhCI/y3N+?=
 =?us-ascii?Q?JNdSi34KxzcbGX6sglFAR7vBQTt8u43lbqPZjZrLDKR0Adg5C4JBGGNye55/?=
 =?us-ascii?Q?CEtN0N+usDytfH5PWzwoMNeW3q5eyDvHZm3JdCy0lHOgn3H7KL2Ci5vpktit?=
 =?us-ascii?Q?te6g54OgAdsJDnQKLREL7Gx4j8mzavQFTAOBDa6JqfEK2JGqh6juuIQw039l?=
 =?us-ascii?Q?SOGHbxGUXTVcU5pGP/e1m/4bXsiPOyYVrf1gQbHNsVOQl0msF/8eo3qaH07C?=
 =?us-ascii?Q?ZSq+vkHiApdJ+XlzLemoHQSQIKZuR1oM3r/r/MkkFqlX4/nQ6aU0DJcOFIFC?=
 =?us-ascii?Q?nOhGuWdb8jWGtZT9Ia4XTdA3fzpik95XPfka/iPgejFC1mXiGFEck21X+Dzi?=
 =?us-ascii?Q?7W5LNtnW/KVXhjN96JMz2MlNTzaQjE14d07Rtk0m2tcY1gy6ef038GIyaD3r?=
 =?us-ascii?Q?u/9+/vohDpRVKm87vvaEZPKGC5CSjHstP8NwYI+LrHduSejX6oHBRHmvNHlH?=
 =?us-ascii?Q?13NvJniYldVBnTFnoTXMZOK+VXynaU07kuAM6PaRgrfHoNha09xvbAI1BbIx?=
 =?us-ascii?Q?iPjMomz6fWZheoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDbsie3R2/HSUHT1JDtzROhY31hBZWqXab3nbaoSnBhGzcZf6E5hATRHKeRB?=
 =?us-ascii?Q?JucYSjXMXHayMVOUDjeL0yyVCpnrA4ZgInHeIBx0RFjOUA1Dvd9mmNndzU9B?=
 =?us-ascii?Q?h6UR3bpB7cflusDqO42MKkmwpPZXmhnJJA2Nrh3yDPAGpMY8H8PrXnoQTAPW?=
 =?us-ascii?Q?2a+ewrOMaW/B7rLVJ0IcFrIFajAjrsInQcq2IjUdByad2RFsucCKich0gwhA?=
 =?us-ascii?Q?y8kRoktwrcqaU7AMFSKVcfx8hntX9o4bcbnnKGf1o/XuxYeLFWJdoEgguBrT?=
 =?us-ascii?Q?iHwjBi2vNnUesbrKPM7QKvA6/CSerYj7Bw6kZBJU5ROcAJw8BsVLgOR0rAcZ?=
 =?us-ascii?Q?Zh9okbR87H3MPKBqCJUnFuJGoRGtdAv8O1/zr4d1jWBeTFiTTGPbZ3M1bk3t?=
 =?us-ascii?Q?c6fX9h6L3fpuiMs5Kx3+jEEEtWu0ulUlb2+jfswYxczm7vxtfzzfGpVgO6V/?=
 =?us-ascii?Q?SaqRg8Tvvw+iz+D5vmU05vydFdu2k7ZSr70ra5vZXyNrFrmyouBk+OY7MqlR?=
 =?us-ascii?Q?MylP8mVTggda/byY58VBUbvFNoV67YRVpl/tnXxO3yNn7hc4KElThjr17k2k?=
 =?us-ascii?Q?cUHFol+qUEHDsyTwQfwnd6IMfjlfFoyHHRWdFCGSSLlkybGLW0s/KohjvF8O?=
 =?us-ascii?Q?T287/dFgjvm53goQbplppyfExaTsns29jaFRUu5+/MAfTxREIrNvsq0+UWfS?=
 =?us-ascii?Q?wuElYXAGrP91OAf6wb9U3wfrOasXx5soBMcF3fCIxWEEwQq53NoHyIaIwo5F?=
 =?us-ascii?Q?24K9k54JHwPq5Q/PzX5l87QETpc2Iarp+TjLlNW2UYHthqEU+JiBG4p0oyxD?=
 =?us-ascii?Q?iWv+HhK6ORC+XqfHJiXjYUnUyCgbWZvasfRpFiz3vTJG76fHCxIMlN9Ux+Jo?=
 =?us-ascii?Q?rRSYNYU31uw7I7ODT3vNPu0RG6nES0mH+vCFtPVUrWBhPc1oXo60UNWkM8OE?=
 =?us-ascii?Q?6mOhyHw5X8M7lO7/arty4sdNQGhlMEYINRr8D0ysxBEsC/hVbHt33Wz3rqb6?=
 =?us-ascii?Q?L9EMT/C7rUVhrfKqbHXuMB+ZijhYmT2cOFbTICcdr9pr7pBeKcDzjamfggsc?=
 =?us-ascii?Q?4W+3aQ4XmZbYPhN9RYLyQd0sie7zr+6303y3IQwfFlrG9rTlyaRGRZ3XttFh?=
 =?us-ascii?Q?tDyWoCWmV9N/kTe91pmIfELAA2EEvajkHCWatUPFzmvvHrJghFYv6ulgCi8V?=
 =?us-ascii?Q?K5+uRE6A45rkF2oISytzrqIJ/s0Qhb13/vk+tsyaWKf1x4MMDt4QIXLq3nd8?=
 =?us-ascii?Q?vO2QljSj50ajFclwkfYX5mNZ/WDm244W8XUU2bJB7pv7kfijbkAcCm+V139F?=
 =?us-ascii?Q?U9DllXLkgqiKoLFqDh8VHT6uovmphpOkNPtkDe3e2W6gkw3e/EEQduoOpT0Z?=
 =?us-ascii?Q?ihtxGYmi2HvZwWLqG9irrgeVrGQKoxHEYxHGoJfT7n1jUJVsEL3BcmFdgKbY?=
 =?us-ascii?Q?SpQcS53vctX6ESGovq6Jci+a7A5BrwRiXffuaBBj2LvMG4xI4sVK/Dx502gD?=
 =?us-ascii?Q?GQiXpgHcuryE883E/y2Aj0OxJez8rwABujDBVa8L0gId5bHh+hEWtVFwXilb?=
 =?us-ascii?Q?+tbYnfZ3K4evQ3+m8/Qp/5bvMfzfO3FSoAV2AHqf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7378159-28c8-4c56-b86c-08ddaf44538b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:16:55.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuSzLsZRLY4eL4gibP6iz+C7IhH8SzE8YAM+pL+E3eGSEf1fCyW1aEehailNav53ypfIGWa4en9cxSHbJD/Ong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394

On Wed, Jun 18, 2025 at 11:21:03PM +0800, Hans Zhang wrote:
> i.MX6 PCIe driver contains multiple read-modify-write sequences for
> link training and speed configuration. These operations manually handle
> bit masking and shifting to update specific fields in control registers,
> particularly for link capabilities and speed change initiation.
>
> Refactor link capability configuration and speed change handling using
> dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
> by encapsulating bit clear/set operations and eliminates intermediate
> variables. For speed change control, replace explicit bit manipulation
> with direct register updates through the helper.
>
> Adopting the standard interface reduces code complexity in link training
> paths and ensures consistent handling of speed-related bits. The change
> also prepares the driver for future enhancements to Gen3 link training
> by centralizing bit manipulation logic.
>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..3004e432f013 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	struct device *dev = pci->dev;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 tmp;
>  	int ret;
>
>  	if (!(imx_pcie->drvdata->flags &
> @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	 * bus will not be detected at all.  This happens with PCIe switches.
>  	 */
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +				    PCI_EXP_LNKCAP_SLS,
> +				    PCI_EXP_LNKCAP_SLS_2_5GB);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>
>  	/* Start LTSSM. */
> @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>
>  		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> -		tmp &= ~PCI_EXP_LNKCAP_SLS;
> -		tmp |= pci->max_link_speed;
> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> +					    PCI_EXP_LNKCAP_SLS,
> +					    pci->max_link_speed);
>
>  		/*
>  		 * Start Directed Speed Change so the best possible
>  		 * speed both link partners support can be negotiated.
>  		 */
> -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -		tmp |= PORT_LOGIC_SPEED_CHANGE;
> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +					    0, PORT_LOGIC_SPEED_CHANGE);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>
>  		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> -	u32 val;
>
>  	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
>  		/*
> @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		 * to 0.
>  		 */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
> +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
>  }
> --
> 2.25.1
>

