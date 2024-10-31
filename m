Return-Path: <linux-pci+bounces-15727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E419B7FE5
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA461F222D7
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE121BC07B;
	Thu, 31 Oct 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HI7OVqUq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0001B6541;
	Thu, 31 Oct 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391711; cv=fail; b=LsvD+EDyaizYQK1M+J1ozrIFZc19ZSmVRRa9d80RLcsMxR6pYoxLthGVq20NpalpcYtLtHxwkhAIci334zDv19b94meNwNOkdqlYBhtAtpvFZ+cnTQWe6Z3o9P5Bf7k4JSeJTijWju4M2F7DO5tMYzL7xVYm+2uvPPDMRA87Pfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391711; c=relaxed/simple;
	bh=oHfydt51swGJbIoDKjprSbMlz9lZ5h3R4MeimwFMkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0pt6Dmmvrup42GIaQUC+kepSQ5gU/IEk5S99QOc8WS0O04oFxJgMDelsYIURttNdEDZQ1H7e0DsatwnjCYBbiNSt1yZ9sRWLKU0AMbJ0yBNI6mrS+FnAFbE9b8Wpj31I5MD3AfIbz++fHkw8yz4b4Vif1y3j9U3oiTH3Xz5UI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HI7OVqUq; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=If4RTAvExUzLE1rF7BNAiAfK/1eFgtvb7nAUUrOx91HpfWy+wfQTOH9/FZ+AAkn9O8a7+5FEQREulAHrNG93oQmFXs0uoaONbUDuiFDqEwm/Y46y7da9jcp+jbZwl9YOC0+T6T+2YASYrfC9hjwTUkMbArin5DPKSadaGkkLlXl2Up/N1/a0Q+7VwmtfIqrXtOCrA0OPJ7E1R8rfz2zo6Kjyoj+DYPmdu6ZOl3/u74ZkLDo2Na2Z/YjFXoBujdHxcImzolqJgCRbszeOTyWkx8FMBbR90fgmCg7EIFSpMEHYo15Vs6lkCGHAEFNPnM+wLqA2pMD48YWhx/gJqSmxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeKBCN/45BxnysnhokossFSswfD/fEosSM0dVwovrYQ=;
 b=QcGYAkaMyGNPliyi9u5Rh1w2lB3OWBqMvPDgfkxC9rwC3bspbcFkE5wTsO2CJS4dhor6OOUGbQdW8ZMBAeoFn25Rq9WBE6aA9itnNLNKIsXFWk7NehmuPt/dkoQaCmRFyZaQUo1LVDTXHazwZISEr2amrEdLHOKUojCdVv6cT15pbBnhjvzXbn/qGUuHa6Dieaz+7UkpGz8bHhHgmBdIaAlAr4vgEPpP3yJCwPyrZ273qi7hYCI9XHaRShfxh34/ukkFLQCdgfSCOaZtkyhGCt+DUan6hp1YTkn88S+J/nxcngH27TplY3JvhUpnw/C7kMhVz9M00DGXnz/RpDfAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeKBCN/45BxnysnhokossFSswfD/fEosSM0dVwovrYQ=;
 b=HI7OVqUqDoLywAO4Tq7k9wtz1x15bwmx7a+swOysZdc0HP3Cwb3k0KcLbsx00OBez4iDwMa9lfKBpXtYxbe9dhRBKHSEsrTugxout77w3kvcnECkP6P86DX7xct3ohpHu/bgh0HjpMCYh6itQU/GkXbgFICirksycgWCR6UwzCIpWT3ikxGGZUHAjR9Ut0V0ErZTZnxti/ROlPEwH1XrHjTtRThrrOEudJj3WOr/X0ea1bINId++kgAcaB3wd+zvyjkSNpZs14NvJNe1TrfYM43i/AG+uGQsfn58SFTYED5K0zG/AzPpFe5tFR+betXPdm8jbD/ymVwZL84gLMigng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:21:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:21:43 +0000
Date: Thu, 31 Oct 2024 12:21:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <ZyOujhheoeMxKxSv@lizhi-Precision-Tower-5810>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
 <20241031080655.3879139-9-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031080655.3879139-9-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 86947187-a4e5-4d37-cfc6-08dcf9c81bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l0rg79vI1T2jNq5h7Gb64JH71cF0g4mr8K5RxzsaxaVvKxXir6eu/q7TCpTw?=
 =?us-ascii?Q?jtdxTg7ThnEZ0uINLZyVw8/9OPNJDe0OkkyymorcelgUJMny6tsx0rjlnv9g?=
 =?us-ascii?Q?rE8ZfxKd/xegjq3nrRC7+I90ukjyTspvOg+MlB54xhequGAvoaRDX6wyzzzA?=
 =?us-ascii?Q?ATRFjUdguov0G7sSUgkjqcAcMVkfA6qdIjgXxAgSSc1a/+HyHtePur/zNadp?=
 =?us-ascii?Q?QzwMXWfdj/rW83S+5r9ZsTBmauvSQsLeBJMINzBcCT4RKnD3uNRfmeSqhETA?=
 =?us-ascii?Q?Y+REzlqDOmmbTffWqb0iNvDSf33p9T5lzrueckCzr6wOQddhL2QlQkfMSOkU?=
 =?us-ascii?Q?dwAIm5QsGtjiE/I1iNbf6LkuXP23+4RVkhi54YW74Ktul4nD8nm7gG0a8qE2?=
 =?us-ascii?Q?2GiEhDx/X7Dm+dyAI9DbAMMrn7HFGCD1USteaIQQ/2UaJbp48zdhf2gNVklF?=
 =?us-ascii?Q?5H9cTy2+foWnxRO07x9tePLtLpiVZBU0CNO3PY5hMMd+xmhTLOOeUIuB4NO4?=
 =?us-ascii?Q?tti0kjXo8gsNJBAXRPCYlfyxdx/f6tWY3YuwCt0tJ2CxO/W4PrpPVLwOobdh?=
 =?us-ascii?Q?3AEeBuQ7k0EUUEjY0ThZfbyKwW7ES9qYNzcBT+0DJtjC+vqP6ZM/+nTvHArZ?=
 =?us-ascii?Q?xJbYrh+K3IIrGleAYdqJvMAgr+rJnQ3TgZFlNCC4kgCXfnhxGfANBJ8UZ7De?=
 =?us-ascii?Q?aKnTgPXi2RV8s/SCvLDm3kPa26FD/MgbhUmja8FGumqhE/muZ9hIBDYFh8YI?=
 =?us-ascii?Q?0/DrbVXjPpfspZw7D/44I8yE7PMsqiOnb0rpAKL3cCy0MRbw0vSQoqIm89w6?=
 =?us-ascii?Q?zOj4mdTN2/TbqUAnpVjlKuKmCoKtgi1YU44m7KYyjY2m4sECmcAxGT4eaz1f?=
 =?us-ascii?Q?ZYP3tyiqRaLdFr24nmaI+hKXQzQdLyFsHqhjGbcxFMmpybIExYUpdYLm06QC?=
 =?us-ascii?Q?i0cHZwy4/fwghQvFQ8ZPg4EeWqYfeTcYTLTBcuhCURwZjRJXcwf8nknaKkiy?=
 =?us-ascii?Q?cUjT+RuePltK2vFAK53MZVNGFfIDUTsdpObAc06Oy17sbuBj+i6UcY4AryIc?=
 =?us-ascii?Q?cvqJkEtjI5WIaWv0lVJYWw1gqEkSBHlJ9Kp3J2WS6WlDiE6UsfIbtpshrOIt?=
 =?us-ascii?Q?n55KFQyOgYn0a560ATarW+604Bzy+RYJH7rJqXdNez4ZTMU828/cnLgYeRA6?=
 =?us-ascii?Q?XorzoxlvN/hngPv3DNH0bEsAWsNMao1T7b2BIu7jP1cCz6hVqURVBJ+1gb6u?=
 =?us-ascii?Q?Z4rttr9cpZlDD/XCi5XPUEtZ6aoB9q1BWg3iTOivEdbck2MMW0lo5tyg4OVH?=
 =?us-ascii?Q?bjE5+wAXWz/rXDXOHl5eIF/B8Aub2ORZgt21X7iGNI6HlJeJLmcRMFCncNep?=
 =?us-ascii?Q?S1eevxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sy8AY2vem2voC5fuzUxuzftUvSzJ2bJSFdauTHGY3e/l5QATa4rcBfhjnLKS?=
 =?us-ascii?Q?ykH23xtskOKTyTjzZV/vtDwghOoldycJb6PjgfrrS6TNT/0cUTK2QuRZmKW0?=
 =?us-ascii?Q?Qjoz60YItvs13l+YHwGWz7FYfBX00yddXoPe/JOnogUyQBGgxmjkgi89VQ6m?=
 =?us-ascii?Q?x9c5RNYsFNsGz++jic+d2FpLJNa3njJWvn0A3+cswBZz29vqUQmyCAYNuLd3?=
 =?us-ascii?Q?BGEXK80ib7yfTqOyCUxxj6qwQHBSpWCUUL6no2FzhRGBBoyxhu392GMAnz4s?=
 =?us-ascii?Q?ku6A5xn/d1Ttf7dOdKahoFg1UK/29Xo/bT/WXZ7YsQKBGq27KNoTSewQrMD5?=
 =?us-ascii?Q?1TPdUfNX9mm8BZ543aAU+OF4XaxHLzjBy5z3WKiC5lZSXhHApZ0xhXBlk2CZ?=
 =?us-ascii?Q?P0hPCJoiabswC5nKvN7hMZ2mIaI866o08LjAlCXYj8BsXE5Eh1XSx+7QaSLt?=
 =?us-ascii?Q?Er+DFCUdnLpwU9L4EExo7Xvsx2HH0ZzOBGkJX71OTgSys11pG7R8gN9stWin?=
 =?us-ascii?Q?BOA2VDO1Sq6HrkR96lA0XmYumwttVPXidXq8LqxNOIJLs/ABeWKu3La1fCUw?=
 =?us-ascii?Q?hI5EmLHaO0FzNfwMdxvD+8v97o22QMCg3xPDIyU6fmAn9rhNLROOPmhv4UeJ?=
 =?us-ascii?Q?xEjazz+AOKmVc4KY7hnw94xxkwKPRgHsBH8YgXBnY4teiGVCIsforvWUVxR9?=
 =?us-ascii?Q?/CQrqQXv0kMDp2OeTBeAb2SvnpDRWkGjS9SSyFjMnvkhFbR1wJNrapAqOymh?=
 =?us-ascii?Q?sbcpvgVvOd4CQsPDc2k0gasumSVInV1KtHWMEHruMk3/ts8CGmjWRpAMZ3nX?=
 =?us-ascii?Q?2eXyl0wTCLdJirJ92uI4DiHR4BcNI65ZAkd1qB2wwreJJrlt+C0Ia2zDgSKe?=
 =?us-ascii?Q?F2oueV1MJKlSDWu1lYo123i0c2KcP8xRCnHQDhGJQY9nFoAwQxeMkDpdZacK?=
 =?us-ascii?Q?kgc8cTduTV1GxucBWeDpy0QO37nVy7jlIBP1CgzznkM76TluCaLw5qcJvU3v?=
 =?us-ascii?Q?COX4FMuZRwUzwo3u14nZvboit+vw6e4oHwuBZe8gK0D30utIy1OTVMWfCx7n?=
 =?us-ascii?Q?3fBuj6Kn3jW95DYxllazbP+N0tvZoxYqJk3h+c06Fh0BOFaHX4ZXLA/NUrjJ?=
 =?us-ascii?Q?RdNKsWdikO+UOPfmV0AeSt08IlXGVYZpGaDsL6YuNhD6pcy5akVmAgM9NyR9?=
 =?us-ascii?Q?O3bec0FcPSu3XPsRqBYTSgFk5tGRxQDZ/jRbVzLGawuRH8ugQGM64V5VxjXq?=
 =?us-ascii?Q?nDu6c//hTosOM96uxgTxUU+PaXBdDEeyUS94bVKDlbbw/+1A6Pg7I1iOcrWB?=
 =?us-ascii?Q?gfC3nubfS0u363hZDyUcYTkTv6fzWQiXB5vTt+lnF3733gd7X1lC+otoJOvv?=
 =?us-ascii?Q?z+Q3fhMeHxGm8euuZCIMlspFcomPp893rEveLnORdW2MWYeUcWsS3Ufz+NKZ?=
 =?us-ascii?Q?8GWN8rnK6lLA0Rq1XJ/PyZbuXaXcvwN1t9tamiqTWlg6G1aI5tUWx7iU3CNP?=
 =?us-ascii?Q?eWZqjPLr3v34/3xe0Iw0O1RitOvOYo03GyOwbo83E8HLRDw0KEjO3oASdw9K?=
 =?us-ascii?Q?ycoaNwS1o6GGSs5nZFz3qWI2QhAnqUHzN6OZkua/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86947187-a4e5-4d37-cfc6-08dcf9c81bcc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:21:43.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qWnO68KzysLRRg5eUp7XgsplOEcMvIz29j/1xLiItLiJGNBW+IafGA8J9a5rIAclnYLawi4N/VO9cC+OO9YhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

On Thu, Oct 31, 2024 at 04:06:53PM +0800, Richard Zhu wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Call common dwc suspend/resume function. Use dwc common iATU method to
> send out PME_TURN_OFF message. In Old DWC implementations,
> PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
> generic DWC implementation of sending the PME_Turn_Off message using a
> dummy MMIO write cannot be used. Use previouse method to kick off
> PME_TURN_OFF MSG for these platforms.
>
> Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
> dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().

because dw_pcie_suspend_noirq() already do these, see below call stack:
>
> dw_pcie_suspend_noirq()
>   dw_pcie_stop_link();
>   pci->pp.ops->deinit();
>     imx_pcie_host_exit();
>
> Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
> imx_pcie_start_link() by dw_pcie_resume_noirq() in
> imx_pcie_resume_noirq().

because it dw_pcie_resume_noirq() already do these, see below call stack:

>
> dw_pcie_resume_noirq()
>   pci->pp.ops->init();
>     imx_pcie_host_init();
>   dw_pcie_setup_rc();
>   dw_pcie_start_link();
>     imx_pcie_start_link();
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 96 ++++++++++-----------------
>  1 file changed, 35 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index dbcf22e440e2..410a31e5f82a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -33,6 +33,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -83,6 +84,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
>  #define IMX_PCIE_FLAG_CLOCKS_OPTIONAL		BIT(9)
> +#define IMX_PCIE_FLAG_CUSTOM_PME_TURNOFF	BIT(10)
>
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>
> @@ -107,19 +109,18 @@ struct imx_pcie_drvdata {
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> +	const struct dw_pcie_host_ops *ops;
>  };
>
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
>  	struct gpio_desc	*reset_gpiod;
> -	bool			link_is_up;
>  	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
>  	struct reset_control	*pciephy_reset;
>  	struct reset_control	*apps_reset;
> -	struct reset_control	*turnoff_reset;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2_3p5db;
>  	u32			tx_deemph_gen2_6db;
> @@ -898,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  		dev_info(dev, "Link: Only Gen1 is enabled\n");
>  	}
>
> -	imx_pcie->link_is_up = true;
>  	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
>  	return 0;
>
>  err_reset_phy:
> -	imx_pcie->link_is_up = false;
>  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> @@ -1023,9 +1022,32 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  	return cpu_addr - entry->offset;
>  }
>
> +/*
> + * In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2
> + * register is reserved. So the generic DWC implementation of sending the
> + * PME_Turn_Off message using a dummy MMIO write cannot be used.
> + */
> +static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> +
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +
> +	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
> +}
> +
> +
>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.pme_turn_off = imx_pcie_pme_turn_off,
> +};
> +
> +static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
> +	.init = imx_pcie_host_init,
> +	.deinit = imx_pcie_host_exit,
>  };
>
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1146,43 +1168,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	return 0;
>  }
>
> -static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
> -{
> -	struct device *dev = imx_pcie->pci->dev;
> -
> -	/* Some variants have a turnoff reset in DT */
> -	if (imx_pcie->turnoff_reset) {
> -		reset_control_assert(imx_pcie->turnoff_reset);
> -		reset_control_deassert(imx_pcie->turnoff_reset);
> -		goto pm_turnoff_sleep;
> -	}
> -
> -	/* Others poke directly at IOMUXC registers */
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6SX:
> -	case IMX6QP:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> -				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> -		break;
> -	default:
> -		dev_err(dev, "PME_Turn_Off not implemented\n");
> -		return;
> -	}
> -
> -	/*
> -	 * Components with an upstream port must respond to
> -	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> -	 *
> -	 * The standard recommends a 1-10ms timeout after which to
> -	 * proceed anyway as if acks were received.
> -	 */
> -pm_turnoff_sleep:
> -	usleep_range(1000, 10000);
> -}
> -
>  static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  {
>  	u8 offset;
> @@ -1206,36 +1191,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  static int imx_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> -	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
>
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> -	imx_pcie_pm_turnoff(imx_pcie);
> -	imx_pcie_stop_link(imx_pcie->pci);
> -	imx_pcie_host_exit(pp);
> -
> -	return 0;
> +	return dw_pcie_suspend_noirq(imx_pcie->pci);
>  }
>
>  static int imx_pcie_resume_noirq(struct device *dev)
>  {
>  	int ret;
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> -	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
>
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>
> -	ret = imx_pcie_host_init(pp);
> +	ret = dw_pcie_resume_noirq(imx_pcie->pci);
>  	if (ret)
>  		return ret;
>  	imx_pcie_msi_save_restore(imx_pcie, false);
> -	dw_pcie_setup_rc(pp);
> -
> -	if (imx_pcie->link_is_up)
> -		imx_pcie_start_link(imx_pcie->pci);
>
>  	return 0;
>  }
> @@ -1267,11 +1242,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
>
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
> -	pci->pp.ops = &imx_pcie_host_ops;
>
>  	imx_pcie->pci = pci;
>  	imx_pcie->drvdata = of_device_get_match_data(dev);
>
> +	pci->pp.ops = &imx_pcie_host_dw_pme_ops;
> +	if (imx_pcie->drvdata->ops)
> +		pci->pp.ops = imx_pcie->drvdata->ops;
> +
>  	/* Find the PHY if one is defined, only imx7d uses it */
>  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>  	if (np) {
> @@ -1345,13 +1323,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		break;
>  	}
>
> -	/* Grab turnoff reset */
> -	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> -	if (IS_ERR(imx_pcie->turnoff_reset)) {
> -		dev_err(dev, "Failed to get TURNOFF reset control\n");
> -		return PTR_ERR(imx_pcie->turnoff_reset);
> -	}
> -
>  	if (imx_pcie->drvdata->gpr) {
>  	/* Grab GPR config register range */
>  		imx_pcie->iomuxc_gpr =
> @@ -1430,6 +1401,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			return ret;
>  	} else {
> +		pci->pp.use_atu_msg = true;
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
>  			return ret;
> @@ -1494,6 +1466,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.init_phy = imx6sx_pcie_init_phy,
>  		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
>  		.core_reset = imx6sx_pcie_core_reset,
> +		.ops = &imx_pcie_host_ops,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1511,6 +1484,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.init_phy = imx_pcie_init_phy,
>  		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  		.core_reset = imx6qp_pcie_core_reset,
> +		.ops = &imx_pcie_host_ops,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> --
> 2.37.1
>

