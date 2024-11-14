Return-Path: <linux-pci+bounces-16788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80E9C9070
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8DC1F213EC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32593176AAF;
	Thu, 14 Nov 2024 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ABELFeq6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28351126C03
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603859; cv=fail; b=pC8ZmwwAn/DDHpZDAz+5Egm5uM98qr48pQ6NkDLtMTyVoC1RIT0efRTOhJV2LObqTXID/uCphnE15PPbMiDFaupHI0XFbBPMw3HFk748RfLTUNU9hhJE0kedctOule7cGJawN3s9JzKRw1V2f5ztWbyqjhSWU50spbo0wNia1EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603859; c=relaxed/simple;
	bh=Z2edYtujP2/h5PCE9X1eXDKXmbYUDTe9FHqhMYdueG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rn/XykxgxT1L//ZsxA8KiIFWlNTPf7AH2R1jEuGa5qFT/qTzna5Fa0sKyqIYjgcSIrNLu53o3uUej9Fv7vipyLTA2Lk4Vf3w3tJRTpSgLefVNPEMkJVfVcnxFZUEBEFvcYA9OszJpcIUgH2QI1kUr/QivkJ7GIgKEJoUcKDeNr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ABELFeq6; arc=fail smtp.client-ip=40.107.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzimcXVeqi2q7VdPIWDo9U2k2MXKlJ4m92iW6uWdxvXp3aIA/AXzAhWOsC5u1I0yYA2lB4ztwVpMTAlSP19aA9st70nzJuol+L0QNdiZZSMuwn3bOhkD3JZHvb/kFBHnpy1HVkMOvUXgAZs7PlbAi4o59WEleLbA78LtAxKkY+D+H1H0dJibt7Tribu/B0fr8rctr4ZCux56GWgBKb5Hr12eQ0SUMj2fU7HhI3yvZYpo4VEnLsCTchRB4WLnuXT+YbjcxnoR07115DhYkkz7KqVyfZCoCAWRsK5CEeYP+JLpOiXg4H+p60xn1j2/sEYxBog9batsjWPHT3zLbQ+fMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKz9sygIBBTYwd53+1kloMk5RxrOsdwWXPwVhPSdEOI=;
 b=PWjxq0eYYi72HJPpq4snYssdU4GECw+imitV7FmkMo0AjLc0vkIprUh5bfbSWoRZlPS9s1IaYrn7uc8WY3+bchReeNXtfqhuIWTUDTxh9wnk4b0PHTJKDmfRtSuxWf7t1yivpiKYtYtvLBYtCKtXY1WAhMfEaX/0Ss7pYJ0d0mps0356VGXmXdcOpGXLxRWHfP73L5jIiuD4QuhpWWLyDZxYbWz0bbcYOv1smbtyVhpA2/IG6BvziCcwgAk0Vkbo7YOfM8VirvREZdFtIbDgOPBZnOV8t8xRDHhmKFbcTiKVUrFVLkdqIhKgNEenI31sJtxpHrpnYeqkQTOPOPGo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKz9sygIBBTYwd53+1kloMk5RxrOsdwWXPwVhPSdEOI=;
 b=ABELFeq654lrTBR+cAttsftNDdfOSRfsQUQfX85ZtWz47miCpPOpWDETx2K+ZPj6E9tS2mOFNHQS1fRZlVSmptX67VejnRnpZinCXNewrWCFeBaEYCNcJSRyKu3NGbAJjwlg2ResO8370rMcxULPAKtR4EPu2q5KU0trrZ8tlALCW0BCtGXiKcfqJ3SyTbgahnKsUHgoQeGevhVWHaWaY69IVwjIH0qDo7JPkGnLIm/jSLmhb6j+t3qKiO852FOZPXB0UtStLsZ6/eo5N8ttp6vZdBe9Gr4FrcfWXAQHszzyJHsTgguGtvJ7i3RQiKqE8vBGQHpIEg9ERBx+ies24w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7723.eurprd04.prod.outlook.com (2603:10a6:10:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 17:04:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:04:13 +0000
Date: Thu, 14 Nov 2024 12:04:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: artpec6: Implement dw_pcie_ep operation
 get_features
Message-ID: <ZzYthZzl77nE8OwQ@lizhi-Precision-Tower-5810>
References: <20241114110326.1891331-5-cassel@kernel.org>
 <20241114110326.1891331-6-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114110326.1891331-6-cassel@kernel.org>
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2808b8-62eb-4b79-7119-08dd04ce5d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6J4STQNatnsHnOCCOFvU3zIPrU6vARo4uEL+A59bJ3WmRLYX+ld9nVgjBmMC?=
 =?us-ascii?Q?YqsyZVjX3MULkIC1c+8BIiJkXLK8A84wSd2VmMUigsnHMHovzK+bdqajZ+Xq?=
 =?us-ascii?Q?SkDC8tKsIz1TslymqsGRO6HKsa3VK3O1tt+ED0epK1UFllX+1SW/axNWwZoR?=
 =?us-ascii?Q?UZAHVmWeptL4BSIrxOu4vEmO2hmAHNPlJ6CEybwPf6kFpPJh8JMVECIS05wO?=
 =?us-ascii?Q?FK3z9Xc1PUHQDXozfVlvls8k/xGM85lLRyrt5l72JHdCo30FixIfh9hRoiSq?=
 =?us-ascii?Q?JOYKOowmV1dV2RldElYexWMGTnOqUPVx4Y+qMf+pLIAvtEYFAxZqeYzxCjkp?=
 =?us-ascii?Q?BKNJXIRqnW3dmVP/1qI0snsgjSddblfo3aeGyp1MSluZWKPWV6u4lQ8F+K+G?=
 =?us-ascii?Q?M6wIhhZlbVCDyWp7m9N3SLPjgmNjYmLWe3VDbJuKGyYs71M1NjxKZXZerViK?=
 =?us-ascii?Q?8QnJ6Pt8X1zBMOXeeucsdd8ay5sL23ZAeK5Gbk/MtYT4UPaXJvUvRDjckmCg?=
 =?us-ascii?Q?LaMmxll/cyn8Y07y1oGSrxHEzTfGaPlr7cwJwjSTcs4cT2Fqnz432+Vb0Dtp?=
 =?us-ascii?Q?QO5MBWvQGINTAPN2DL2N1ecwPrrOsUUzSmFwDBr1/wGQ0oP1p6TPbWwm+FQK?=
 =?us-ascii?Q?YD2snP36O6Jqxw9yb/9hITGnaHv6aSJEzjelfyuc+5AB1ZN2K1ZtknN64lsA?=
 =?us-ascii?Q?9EPV2RivmdNQdmPpPb2aA8bTklK40IKngZMWhuVHSAhoTpMyfIzQ2Wb+bSRJ?=
 =?us-ascii?Q?UlkEeTy+Tbp007eCVoiC8KRyAQBYR7gySLBUIwy3KEDfygfyhngMTRoA9wNX?=
 =?us-ascii?Q?ex05Ci2lzMa4ev/77JYWG7F4Qlu8wIIuXToX6VT/HqsaMfYoj9XU3jLXLUr6?=
 =?us-ascii?Q?utfuSP/ossymDDjSYahWjD48v1A/Z/zG1GfazFSZvn3rK2lzkdGvYIAW69kY?=
 =?us-ascii?Q?9BzB545QtwhkJApLRX7yH9jQU1eh7EkmqoakSWpp3KK+Tb2weKish2u+g1Rm?=
 =?us-ascii?Q?Ph77cDScU/6kKuSRbyMVTBHQEV9mz5J71J9S7vIjy4z3GbBJXoySAGJnf446?=
 =?us-ascii?Q?niIw1ILpRUyy9S7Zbz6pL3LvAu9CfLNC1J4EvJbCvr/HN757E7uA0SSPTY4a?=
 =?us-ascii?Q?l14yqiAHEBHu4SmuvnTDiSnWUNn0k3SNGuzqNpPs7ViCxlNz9eA/7yOoyW3o?=
 =?us-ascii?Q?UN0DFfMg7zHYyhjjw0WM0BeUJzq+ShQSiczMea2yDCS6mhVm6rp4h7ND9vx5?=
 =?us-ascii?Q?X0lYJBksiYVlAqmh9hBp+GShmlWEvSABtJK5AaoAjnDehQ5Yc2KUc0bxmOft?=
 =?us-ascii?Q?dM9xr1IaYKu9Dt6rv6Z6YVuvCVieljkCKoezSNAPuiJQbjRmLbfgLGCBufCL?=
 =?us-ascii?Q?jZPqfDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8xEG7z23+iRkBH91949P+FsF3s8hTkpagLipdxmatACKyk/JglYLmKHWhN8?=
 =?us-ascii?Q?E7UFipE/EzMlEijr/woOrIblxyMzjQV91VEx/Fyy+MIPl7+ljZLNFBMOy8R+?=
 =?us-ascii?Q?S4mHjas3OCE+TuMBZUdybhTmdsGZ9u9kmDZFlsnKyzk42xIvEKrdv+Igl6o/?=
 =?us-ascii?Q?70M20XOYLMbXxylj/yqoRB18esPf7aWpTNX58yuXZEF2mRpgBwvc242Hf0AD?=
 =?us-ascii?Q?yrZ+uPF1Il/LMknq/S5O7fN074x37yYBIyCKPT84GWP2sxY+F0P4VF6m5isn?=
 =?us-ascii?Q?A/fPWZ2YKa6Iy0zawZHEU2K4xjqVmOkO4HiUDaarVv3K1bmfZWFrCRFa4VGb?=
 =?us-ascii?Q?hVc6xrxVMyLmUVVPfE4YGfabAVa2dsYOStHRpr3+0Vlq9R4ete0fFN3aSdbI?=
 =?us-ascii?Q?IntKiAo/3Cf8ugsyxMbeSWHDyPqaaHu9bEI+Fq6G0B/eSbPKWoeiDuRfqRlE?=
 =?us-ascii?Q?fYLNNxZyju+VAcStHAFbaHzd3ZMP6nOmKCnORaRFK9jD3ACXZjioRsHRIQCg?=
 =?us-ascii?Q?CXnITCkaHS2S1gVxvpHFEm64adyu81VoLrea2jw9eFtUsICgE0zXUmJXhJBW?=
 =?us-ascii?Q?Hcg9ys2hVj5wW8PEmpm6PSCnAOGndJNunMVGH7DtdLEi39EzHCTjS/6FOZ4L?=
 =?us-ascii?Q?GsxWpEU8IRf33e8W3miMk70UpWkatTWvksJLBbUjcnfitWxOpZv5ZhnlDOp7?=
 =?us-ascii?Q?at81k9du5MJuGYSed11fUGblB9KXKherho0hJ2+cyDPKFh9Lox2XScnZnibH?=
 =?us-ascii?Q?OzIdpacDfdgBIuG6ZGjpbihETq5b+qAcxKYpschDeoU5yW2oe77b35HwXpT7?=
 =?us-ascii?Q?qNHDVaFIrMh9hj+ZU9Z4OzmI0WK2p22D+DfoCNFiKjp1EdX7dWniTMPfQcI5?=
 =?us-ascii?Q?eWr4OVu+kmsf774wj6WInRB5K2a1HD2oLakwSwWSKVFDpxirTWOMv2GUYl+t?=
 =?us-ascii?Q?mpJ9rhvR/YyKs4zPxeTkkwi5RS3WCyEM+qoJ8zt25C9EoiG1zv0GGTJLQ54c?=
 =?us-ascii?Q?yoMLo/wsSXnWIO04DPvgHGZT4ek/wRqWHaZmxUJkiTEfEGl5ZA3uBj5fwWtH?=
 =?us-ascii?Q?WLQECUI4hTL/XoJcYklp6DTmDc1MLmQGoXQV8uSYYIpbeCFdXpPmlF84YrqL?=
 =?us-ascii?Q?VBMD2/uUrbdNop5vSdXJ9o3d0qtdtL9/E+Hi6enQRZJS2aKzSKUhoC7PzkqN?=
 =?us-ascii?Q?1sd0IfeIx4yn2OTe2hn+/rN+FJK9aGQbqOsoHCSZaQr3MB9i6xOjhe7OM2XM?=
 =?us-ascii?Q?voUERpT/EbfxyDrLY7hkZJ4wYntM7/pqxUZmZ+/aj1P/6hcM2HBFnhThQhmX?=
 =?us-ascii?Q?oHsUT7WVowXFTbxHf4b3VcLiBRj0ZD7iQyt2ra7v5gtc6KTOs7wL8u5rSnfM?=
 =?us-ascii?Q?nWKFV++8err4xHmIVZH+H4ynPLkDM4DMKhsWr3U4z/YDTnx/ssrKGQqt2GQq?=
 =?us-ascii?Q?fGIsm3L1xxwF350zzrlym5qJ/RdYSNhkzRFrqKm712f0l2Gc3rmsLMUYJGkD?=
 =?us-ascii?Q?RtpwfKJKHPq74/hHTj0NoHLT5Yl7iHaQAqmwtuoZ7fr0YrsJdcuYsjF+Ee5N?=
 =?us-ascii?Q?F3KhRWPNaW7uI0qlr34p1CMIcVbW/2+yzqGYv+Z9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2808b8-62eb-4b79-7119-08dd04ce5d3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:04:13.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWfw+nhqxKWHLUa0oKYmhNdcL/Aj/m+ZAFSX3uF1VenzO4PU1zASPSSQ9Qq45wMFJu+yvHpWfcKe2ExBwXKoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7723

On Thu, Nov 14, 2024 at 12:03:27PM +0100, Niklas Cassel wrote:
> All non-DWC EPC drivers implement (struct pci_epc *)->ops->get_features().
> All DWC EPC drivers implement (struct dw_pcie_ep *)->ops->get_features(),
> except for pcie-artpec6.c.
>
> epc_features has been required in pci-epf-test.c since commit 6613bc2301ba
> ("PCI: endpoint: Fix NULL pointer dereference for ->get_features()").
>
> A follow-up commit will make further use of epc_features in EPC core code.
>
> Implement epc_features in the only EPC driver where it is currently not
> implemented.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-artpec6.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index f8e7283dacd47..234c8cbcae3af 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -369,9 +369,22 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>
> +static const struct pci_epc_features artpec6_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +};
> +
> +static const struct pci_epc_features *
> +artpec6_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &artpec6_pcie_epc_features;
> +}
> +
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
>  	.init = artpec6_pcie_ep_init,
>  	.raise_irq = artpec6_pcie_raise_irq,
> +	.get_features = artpec6_pcie_get_features,
>  };
>
>  static int artpec6_pcie_probe(struct platform_device *pdev)
> --
> 2.47.0
>

