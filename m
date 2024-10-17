Return-Path: <linux-pci+bounces-14800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C79A26AC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E25284B38
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF891DED64;
	Thu, 17 Oct 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="im4ICrPy"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0233086
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179240; cv=fail; b=ALDxKWeV1E6HzgrfYGVbRqMZmzSVjtTce3ofiNMnd+0Yi8xWMY312juDl1IAEB9nTc/hyZT3+nS6UhPNWWE38SulhqSJVzSsXamFyf1VRKuUDdfjTmip/vaN/9kxBnZzjZck8RDy+q+WVJMMPt80LsBk7T/jPMSpUmf/OvLVYsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179240; c=relaxed/simple;
	bh=s9Kg8eVy429LnK9hCUrC9luEa1438FLU1HnVmDcoEcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QUARIJ93Mnxqj+KiA4XsclThCJfasX6awIWSuOeXOAPWxsJp7qMh3J8mKDQPkmFTFGlkhInlnEegXQWo74Z8eWB3IfaNjPK++v6HK2C1C3lXW29c0rydoH9yTg0OdcRrM4mHMvdWjvQt07SvYu4DVpG9XsmGLYmu49BjSecYwM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=im4ICrPy; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUooDTNWLbbbAWoggbP8Ed79nkvJA0otVbnWpWmSPtK0RYhDa2lRBP/qDIfexH6O/cPBk3wOgbHwfez2fwZMqMH4VP7599iTSoYYJDOeWo+rlT9VARBOgHtqfEw1/VaDF2LKhRJEiRsXSWrwcc+EgmL34pKxR7gXqRUb6B+WpIJ60i8iw2y9pDWXL3o+1tLxXXTAiE3fZCmS8QvkrfXXr8dlBGH6j2/oNqbXfVq/RjleHyZMdHWdGFmsbiWTZmteTxjjD+qSzy7XbwtqUKS/oAvetltzLi38kn7AQ2VAoC0BCHwB+mpwsZgy6jgDQZ9ee6i9jWhLtKFYwyHw9wb/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPaExePUJsrdv/Ea0MTUL8a926NvZQ5tkm1uAW8Fxk8=;
 b=gkDVlwxDhDNYzJQvWGIx2yrze3SLSL7tmTJonAtDfI1xk4zfiS9cvakS99xBLs3yNlgZaEtM5xaLgIfaWm+Yis2pxkuop3zTt+4/TSnz0hIKYzcSuzg0w9zXTL6gom0TdkI9DAFvtVKAhOZ9q4jtc/pHzJ9V9tAC6k1LL+DeA+WB9YN5PziccfuyePfsFRMqnwKBo0bGdTtVXDBUIDJXqocZTRs39YgcsfLcnDt5101n8euTszkJvavXLz9SxiKtI7y4bkmf5x8aezITHYZDOm22qINxsYA2G6GNTJUnVGaD2tY16EDqR5q55aikqavkf/cVT4v+gNAooHLh9pWv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPaExePUJsrdv/Ea0MTUL8a926NvZQ5tkm1uAW8Fxk8=;
 b=im4ICrPyuAxkjNq6UJ5PnVFM+uHUJBcbaCB7yMm7Yk9KzSl59fRkppL3SoXlUmdV/n6S0lwPve1RhgO7Ftj0MeuGrmRJc4hgJtNioSJWRugClcY/CPAmwepcYfI5Hiedq6wj6xCOiA8Jyxhiq1ewu3+EJ+cfdraUwoZFLH10Yo26mC0iOObFZIiADlGHdfqIZMGOZdxV93ctrPes6Kdjaf08LpHNFl0FS4gxT/NMjSuQXS26BI5he3vYSYBJN9jJxnIORXmFcUeFCePHEXZxuRpGtH/V2u3iKOQNeyf+Sq99Sl707smmU3pMZhLEpDb5sGF3Z44g2/gL27XqX1MWLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10937.eurprd04.prod.outlook.com (2603:10a6:102:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:33:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:33:47 +0000
Date: Thu, 17 Oct 2024 11:33:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
Message-ID: <ZxEuVSlmfsfRY4CS@lizhi-Precision-Tower-5810>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-5-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017132052.4014605-5-cassel@kernel.org>
X-ClientProxiedBy: SA9P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10937:EE_
X-MS-Office365-Filtering-Correlation-Id: fcead02f-043d-49be-75ea-08dceec1179f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lOAgt81pMbdafPPaytwG7elRTLje1HXU9OCTp3LffknzB21Gj5IU3nGev2b+?=
 =?us-ascii?Q?hZSHdYvgTnhL68qCCVqvi+Yuprx7frC2f57kuqkfIbRocRuzw/ReZm4m9PdX?=
 =?us-ascii?Q?t5o+IyPtWjGOH2XGLYvoGAjefAA1G4IzbsO6sF/g+hXyg5Qq1LCl0LZV8Q6k?=
 =?us-ascii?Q?Dii8M/7aWK69NfhQymVTE7zolv3i5sy+3b3cgLCxSK+XLLobm7RAylGYMX7K?=
 =?us-ascii?Q?Vtu/2SUf5hzE5WuyLKw43trhPZBjUcjRyNwm5KSiTrtm/dMi0VPddxGc31n7?=
 =?us-ascii?Q?omC8D/dzDmjwDMBjqNR8BLVLUAs6VPrLwu8IQEJuO3s1ryH0VVlSR0c8WLEg?=
 =?us-ascii?Q?XL43CETXVbKlpnJFguRzQGQSYFC0TgayLm/w3bkie551eT8snEHlYh5iHaBV?=
 =?us-ascii?Q?5uY1Qbwpbt+Rrwy58Q1MJKXbZSZ9rDRUt/ZHIMNDVNu1tBNXP4PFj1IFFCYJ?=
 =?us-ascii?Q?Z7lXf2gOyXmTEfzXAaP51K4G+eo1ugQS3si9t55gFnBu5cmI3yLaaDOUKUUu?=
 =?us-ascii?Q?DxVCQThDTWwW6REAeWSb4LOB5jhMqCvqmh1BYHgr7C1mpl8j5Jf0J2H5NYhx?=
 =?us-ascii?Q?SZUreVP5vDa9oRsX15CQX5a3rCGLX400BcGL2mxXFOoykBJrSXKnc/2WM5Lm?=
 =?us-ascii?Q?/OXccNJP0CsWTqhnJNsSGIoDk2X5m+ypGtyoFpzKOIRXdZr71f1IMKaD1/+j?=
 =?us-ascii?Q?oShfgnzOe2e0IRFRt/bq2+eCKLtPJ5N901btO2kaQSpQiAUw6JiSx2ccg2Rs?=
 =?us-ascii?Q?l7PQqBMYNHRJsa0YMfb4uyLT0/09zr3QMyMJ6QGh7EJz1YQ6AZKnEARL35cO?=
 =?us-ascii?Q?QapB88yZpToIBNzLKEs/+JK7afPCIoAlDquYkFayBlZs3Q2q7gkTJC7oYcdU?=
 =?us-ascii?Q?FftTfMG7atZDiuvKUUEoXASG4WFgLRAat5Cw1IAB738DdiN8QpGIhw7eCLIw?=
 =?us-ascii?Q?I2Hl4PidaJ5OKBbZJna49KPNw6LfLaqumBf4q6u4fNVcfACVWBaUlrRSvWoQ?=
 =?us-ascii?Q?KgkZRHcVnglRMJYXj2k5oGTs+U7PrX/LZLMdXxF/mTu3zE5GgSP0VTS0H/pc?=
 =?us-ascii?Q?9JR6WtAgTdcTEeXPL+TE0awt56/ic7lwe39yjEzFhmU5ERcuP2mymFAEkTD7?=
 =?us-ascii?Q?qBDeq7NNn76bt9Y4v2CDz3b2DsO6bHq0WDisenis4aVCVRUqJRHgkvy7zysS?=
 =?us-ascii?Q?00UVwP4nWOtOOwZQGjb90IlUCnkRnpMfp4SWP9VGIJFJt0fhUqoW2E6NyGSS?=
 =?us-ascii?Q?k+5SV8cXjbHLlKZ4/Q3AHxdqfs5LdtwZqcf96sHWi+XLan1Vu4H7bNkg9N3H?=
 =?us-ascii?Q?C5SEvb9K1hIUiRu3KZzonJoXk+9+uCdTZRPyib89CZyaC64MOD2+UB0fwwD1?=
 =?us-ascii?Q?fhU1s0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+RNHtwG2Ql4ZDY7GbLDn3rMTyeKgAXX2SMCtR5mQNWbDzVhxtRGpF9cXnXl6?=
 =?us-ascii?Q?eO8EhrQEtwjOYO3DbjsgIv2JtpPHH6pmxSXNtCamg2U+x94U9PfCM0pJlWP1?=
 =?us-ascii?Q?+3u0XbUJE0lIoLLLAoB+Wy8H4NmIT3MzDN+BGpYraVAoftgGDM+ZaTiPkS/4?=
 =?us-ascii?Q?r7rPBJpRr+bATzxYEJdB6NRg0gMN3jYkjGPQECaPFYjgzfO2nYWHoPEx3mv4?=
 =?us-ascii?Q?+AnNtq+kSxKIEfWDUwDOKLkp3KxldSiBvEDPEj9/+sCt9uCaM2AwSrct4Mag?=
 =?us-ascii?Q?KkelpAIy4sxVen+oI+Cg518XQInOXBxp2J+M7FEpZjApMkyNpmKqJ2Vuwxjt?=
 =?us-ascii?Q?1BNIoCxKZll7R4M5a9KST7VFw7tC+kiacnaOWHN13Qwun0uIXWFEkbId/GL+?=
 =?us-ascii?Q?JHrgGFHk7p0z/6MRrpeox+rhZIzQIwj30xPOgFs3fGCyNYNaoC0/4emesJ1p?=
 =?us-ascii?Q?cNOq9ryntV4/JITsYU+UA3kmKeyUe0qNx/WhLaLN/bC5dmW0mo9i8ms1ADLl?=
 =?us-ascii?Q?2gXHEJl3YZPJtR6CTwXPFWTPIHqQYeJE/VklJJVekxhsXihpOcui1qcu6pko?=
 =?us-ascii?Q?pstlrgFM0utC+mPfloG85Sz3RXqxwHkdRswlS2xCD8Q+Z4Kfs2u06n8TUpM8?=
 =?us-ascii?Q?88bXai19D/A6ov4dlaFByTAGwjvMBwGQ23tvukP8BZmycRuV5vqWrKoV2B/d?=
 =?us-ascii?Q?pGaa/mwQu/1HZzJ/CchjB/osXK3yTl+B4cBeQKCYspI/noDOLe6l2nWUXsnQ?=
 =?us-ascii?Q?1pXZEkO/nGLSRcyi/feQW/i7Aw+CN4KOpHc+p6T4tWyvoze+Y8sVk0X/ZtHZ?=
 =?us-ascii?Q?8r8CM6ABQ/dT0vlhNbxcSooeCkSPygyGJSdYD2gmhqfc8XzuufcMUe51cYm8?=
 =?us-ascii?Q?2ylsDHvuIY76+G7/NbB4NcjfFpM7+ZrfsAbBX/NYiFUM7kmVGRhLOTRuH3bQ?=
 =?us-ascii?Q?/wLJnS+Yvmj9tXyo8bdG9SVnoFX0MSD1sn5GRoP4kR/04yhUQp5L7aObWekq?=
 =?us-ascii?Q?nPhXGWSTPicLSFvn//tvnvEy3A5WHDiYHhKxfwl+jN+uHjdyZ1/4k69bO/Sv?=
 =?us-ascii?Q?+vG7K46wJoChzEHQWJp6pIOQZil0bZ98iJ+oetTpU/ZuRSjDnekC21mf/io9?=
 =?us-ascii?Q?BtyP6F1RTVK4VjV6GI4KTSolcWWvndVj2PV8TnthoYPmOAEBJWj0OHsAWg6y?=
 =?us-ascii?Q?Q0vOKV2IF+6U0dwPZ2Xksdmlywz6o7w2+wGQR8sGC+0nM1HXDBrv3033wNNx?=
 =?us-ascii?Q?QcF8uFRY2mYzx6iTNJosvnfz5bojibCPl/Cl//y4XQjOH2y1YU27zP1d9DNV?=
 =?us-ascii?Q?NV5aL5o1vDNp7ZBK+hh2SFxz6VD9VD+zvaq3RQnFwTyFVofKxxV4dMSLO9KF?=
 =?us-ascii?Q?28vCp5RL8ugySpb3r+mV5qzF6V8U4EOWA5lXmMF4hBcMpYxSY3UxF6IQfG0N?=
 =?us-ascii?Q?EudK/L2UISTZwu7SwyE5mAPn+HuVkw/tzQkjRzbUaets1UjnBein85JNCPv3?=
 =?us-ascii?Q?KDiMrkDoczOCd1l0lJvYBH98KjNakw1qdZy2PailiRKcQLyO3hccNwIyV+JM?=
 =?us-ascii?Q?KrESI4hqirhozgMCJUug2dQrm+W9wLx1X+ENN+Bg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcead02f-043d-49be-75ea-08dceec1179f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:33:47.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZpsx/Vhh0Dl72CDrsaXSarxLtdLNOPc8vdJv+6q6Y4x9Qiggkh1e3iwMSSJETQFbypFeEyvYniMHgv0wptkFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10937

On Thu, Oct 17, 2024 at 03:20:54PM +0200, Niklas Cassel wrote:
> ep->page_size is defined by the EPC drivers.
> Some drivers e.g. pci-imx6.c defines this to 4K for imx95.
>
> dw_pcie_ep_init() will call pci_epc_mem_init() with ep->page_size.
> pci_epc_mem_init() will call pci_epc_multi_mem_init().
>
> pci_epc_multi_mem_init() will initialize mem->window.page_size.
> If the provided page_size (ep->page_size) is smaller than PAGE_SIZE,
> it will initialize mem->window.page_size to PAGE_SIZE rather than
> ep->page_size.
>
> Thus, mem->window.page_size can be larger than ep->page_size, e.g.
> for a platform built with PAGE_SIZE == 64K, while using a EPC driver
> that defines ep->page_size to 4k.
>
> Therefore, modify dw_pcie_ep_align_addr() to use
> epc->mem->window.page_size rather than ep->page_size.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2d0e7bf17919..20f67fd85e83 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -276,7 +276,7 @@ static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
>  	u64 mask = pci->region_align - 1;
>  	size_t ofst = pci_addr & mask;
>
> -	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
> +	*pci_size = ALIGN(ofst + *pci_size, epc->mem->window.page_size);
>  	*offset = ofst;
>
>  	return pci_addr & ~mask;
> --
> 2.47.0
>

