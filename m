Return-Path: <linux-pci+bounces-30190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D9AE0905
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591F016EF70
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02871DDAD;
	Thu, 19 Jun 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fyrX91n6"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D92111;
	Thu, 19 Jun 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344341; cv=fail; b=mGURqpGGa+fuKEoGGPEdXEGTiygzVGTOFlmir/Uiq4IahrMsOCh3++xwOcSfGdUdneTIYAp3Abn5s5xRryop2rWm4PYADDGjcx5XWBR/qy0M1jygPb1exXTESX2EkyCA7ANX6qIZRZvnyK/SdCN6UQ01N4TXJ432Nx14Cv6wBw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344341; c=relaxed/simple;
	bh=rxEKN1OnjaMTNZUYMkCFNj+pTOhgDsKTJa/94SKGr50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RzQPwM0xSeW/GtKQNtr60K2LeFd9snGmSlc0gJGf3VzOfOgRtqA82GpuMeyc41ChRVQ8eamwxLLkaYmXL+j0/fHTe9f5OF5MDf5Y07KDkH5+n+2rRh4aIL5Os/9LnrRHLZXl63T4yc0DuPuko4hSQ+7q7HqdN1qsMMdjfqRzv/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fyrX91n6; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/94swYtlBZGnIBWPdt1hGNBSxzTPhE+nNvtwTBBVxZgCChcQwGVGGyJZmT2G/lu4MHiCnM6ZeYBtfJap1FGKToQSi4INgEk8ND3y76ZEWvAauUTYlVQUc4E1kDiFSBziKCf5Zmc9FXuz6eUUVgaxWEhbXOXo1oYeD8rCs/4Pzgxq4gKWnZgja4Z3sa6NP+3PSwA8FOg26d8kBWSs8SJvU+z6+Y/3JASoOkYm26GPn/3cNKeSUSZFmMsTiO+AZGQDV10ezJrPLfpY0iU1kukkWkvDENy7hqqXg3ftD/ZRctek7mzEOhwRCYyw3WFY08FJ77FU95OGDgQfoUZ/3wEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gLD9Asam9PxZ6wrp2Z1f/6Dnp0WKHIT+hEs/H+Rq+Y=;
 b=onsVpYkTSWEeSXfOmoLOIdlXImLPBJjgJ/RO4Sj/awrEyJ90LfeWMJycHSETWaGyQjK9ysABNG5pOCeeKH5JVPmr2lNceiKuRnVcX4WdWGAwqEcp4QEOoQfuwtr71xyzepdC66HPDH644fvoc4DFi/q4hB+TOqbC+df0d644pYFaTNZeOpqWWUpfU/IgKhmQ94+LGT4yDdhXepNumQVELNjSWDqIKAQfF0vGPTbHwdumhD8uoUeoFP0+TjxOEgdloS0YnL3+aOcGP10/jp/2dzFwTGShnwl8gz0camUW6Fwkgm0xorGgaWZMT6vmKBe5+Lm3F4DC/uegdeKrV9mhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gLD9Asam9PxZ6wrp2Z1f/6Dnp0WKHIT+hEs/H+Rq+Y=;
 b=fyrX91n6gsHLvcK/aI/CDtYJ3MsQlWnOuwMOiNLxVFFVVo2eOcnlkmqIq5uOoPHIeAsCr2fFCOc+XyqDprZkKVWlJcsivIVmwpmAkph4IjSVFT7avcul9hqwTClx7OmCYaUesij8BjH5j8v46LxB8lKE2zTtWtphUTJYffByVwzc2lQ6CEgSDVQ0R5z85j2o6eV/Jl04dwf07JZBYh+gTuaPSZmfxSAj3BF0N/m/OMddhTApJ6luty/d8Dqb1jflXpYNwyFFneoV6jauUXyVMSryfEPl8qsoJYWKAjnEi6Wi2hki9ImodnH3nvl2asVw5BetukmQ60saabqclX0onw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 14:45:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:45:36 +0000
Date: Thu, 19 Jun 2025 10:45:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe
 in PM operations
Message-ID: <aFQih1GVoWwC9WEb@lizhi-Precision-Tower-5810>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
 <20250619091214.400222-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619091214.400222-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: 486501e6-3205-4d86-0464-08ddaf3ff3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lMOSkk2JLYTZJLhZCPLJPkmEM1hcLm8GjfPHiZEnkKHT2TgximNVit7mqf4?=
 =?us-ascii?Q?XHTs2I5ZQsQMPy9qoqa5ItLiGyxb1QLV4ShP5m3+wlrpw1Fymzeq8RmKylG8?=
 =?us-ascii?Q?LYzsJ1RcbweyoALG50pZNsxqK7aOmf8Z4dIC6L6WJEQCa25gSwA1AZ1USFZi?=
 =?us-ascii?Q?a0ImQ6UZx0Nk/fxuSE8RmCseEZ+T2rQMH7OaNHazvfeG8Oqs9Ekx05mCc3uR?=
 =?us-ascii?Q?gwqI3VksXHyp42eM3U8Te1hOG6NMiBwM8hDCSGO8vhiRSve8fDkFkKHm4Gzc?=
 =?us-ascii?Q?UUfDTpxDDYI91gmytkmKpmbXq+VVrIP7fQvLptGTI3vF8FpJlRDEhhPUD4ke?=
 =?us-ascii?Q?lxgkcsxvKQE2c5RdX8fdtVi/6Aj6gWeZrY7Ku6Y5qTWll0u201DWi5QO6kd2?=
 =?us-ascii?Q?9lE+Y+AtPj+Zmgw8ZbaC1zrvcX0lMy+vMoy6t7hGQywrErTF2BTqrZLOceIM?=
 =?us-ascii?Q?zD+6G4eyH/AMo1Bvu4VH6Y7DLfd+voaePJe4c+hljO6Gj8tyWqEY+ESwuPEt?=
 =?us-ascii?Q?JRHpbs/ju9lDwWXc3MNQXvAh2J19/63vSkg6IqUhKIquxnfATNUJGCxRvOLl?=
 =?us-ascii?Q?TqPNzU6bF7SIbC9TH+t2EIFAYeNP6EzPXq/ait+wmHeKuFDhTxTf3Ir4F99W?=
 =?us-ascii?Q?6tpLW9i1ahLIgL+995bJ1UFB1dfBQWShKkTMJ3/fyhM9kOBDEvZ5/Ln/pKqF?=
 =?us-ascii?Q?NZ88PHXHI15qh9H1fdOetsEiSObimDsJfu14jVTM2vye2ur6w7rgZNXMkfAb?=
 =?us-ascii?Q?P7lDWeiK7pS96Hf3Tb+K0z/oGr4Ikwe/UoInRd8lO2UD1yNvdDhJL0NsoRB5?=
 =?us-ascii?Q?hRZSZFDzPgkrouK5QzTwyV8pW+xiZjvuNnUgYXq323uzcwx73sPBzSj3P7b4?=
 =?us-ascii?Q?fcBbwSU/K8F6XFkrbbfkI4EloVIchR+ME1X5YLya+3szycWKsgPAw9zuryeh?=
 =?us-ascii?Q?Q2HPgAO3opjHry09Cu7rJLKr5hWkRutKziEj21JnXTR7phccmfxzMmoBnRJy?=
 =?us-ascii?Q?2lJFKo1ulFusv5nhwQqLbXmoGE+XaKgM1YOo4cpano2UsTpVJUA66nX/SvJi?=
 =?us-ascii?Q?xen+/LsnHLR4PADDFR0cryGu8ddFMiN1SmmG5rTLcxpaoRDB8FGNQO0BOOBQ?=
 =?us-ascii?Q?MjzcVXvEPCK8zFARzphrFgnsCznJwGhJu7xTxBDkurPabRpcbBtUWVxHmZE8?=
 =?us-ascii?Q?xZI4pMJjnw9b88sYPOZUGneszn1dFB0TzTJWrPDiILUG8M+CwxEAr3lBw7K9?=
 =?us-ascii?Q?Mo9oKClJfnBKNoLX344b7jEPoxKlxBskxQawK9TxS96wvAvYVjjlDqY41mGE?=
 =?us-ascii?Q?jun8z87YNJ/sKcAMvPohoNLEgHAtCnVBL9vuROPIZRCznuBXIrZVEKznwscg?=
 =?us-ascii?Q?TMJMa9SOmJba9mq1GbSNMpCtUPrdXRwQ11/5QMegn3o+DKRCSRnVxLzCdFov?=
 =?us-ascii?Q?bJS1adKHorKgQ66l+ISV1xzI8yfQKTms0gBjM+Myv/SrmeLSA75UKnoO9xkE?=
 =?us-ascii?Q?vlabrieafILnwQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILS/FEd/P8UEXA0KxYRoet7OY2HJy1YnPUfNkRwi1b+rq5NzuzKCCYMLp/se?=
 =?us-ascii?Q?mkCp0QnRDsAe9wSlkVoNwQP8gjQW8wCmPlqmQXsLg0zwz0oXV1Xz4bBXnz7+?=
 =?us-ascii?Q?sO9o+SIXB2CKOrun8W7Lr+8h0o5DC1oNlY6RHoxgp4BEsfi7dkah3B/bly2v?=
 =?us-ascii?Q?bP0NhxhqxeT2CiANOu3en5CqYc4JUbFMJ9Qd6/P3xr3+ntQGjvMxNUlcWIIl?=
 =?us-ascii?Q?cnwf2Aszu8WefN/5XgLXlweSYXjz4xSG0OAzlqG8QmSz/qdS0hv9P0S0YBY0?=
 =?us-ascii?Q?s/XlAmuu5ZtyZGVJjALe0WkhMq9tElf9V+ekbMm1prRMGeAW4FcOTY1JCJzB?=
 =?us-ascii?Q?3ZmXTjNQX8/vMunuwQ5uueLu18tzPzuiiGohnmcvslyoqZO4643kZV7kHD53?=
 =?us-ascii?Q?E1R5RcAXgAVS90sg2J1rA8wAcWEPQ8Lo5JQL9aOsXkiaYEBjmGTObLEs/cA3?=
 =?us-ascii?Q?rYPx5sXXAfE8/uhmBUtHJEqYiHfyArTmBXUG/sgh32NG3/AsNjVUUoUMRHo1?=
 =?us-ascii?Q?wgV/vj3LeSchRc8+0TFW1WkwAXVUuA/vj5D3DLqFIaq+kDCUyn5GMD1CpCvW?=
 =?us-ascii?Q?jRZvFZ+Ly8KYbWzoAQG7PpC6XrRfk2IV6QVsFb5jBxQy8EGuJPjdyFAHsDnb?=
 =?us-ascii?Q?mbmMHhNGN/8lMcsm/pEENhbS5Uf17u4S6z0aL1JP1oyynzIpef65Ov+hZ2tB?=
 =?us-ascii?Q?QI2RhKLjfx9K9ki9OOc/I16iMY+I3ZWvs1Pl67Eg04/QUT43hxtkBP2XR6i1?=
 =?us-ascii?Q?FTmnlCS+aYrWGmmEFvjNYnTBWJ8CjcnjbaU6kK6KhHZP4Fj+eXb/A7REu6oh?=
 =?us-ascii?Q?dL02RwREDvDzIMN8xvXp0cpmLWt64YYR34BXWn5y6KlEnRcuXl8ARAOngy6I?=
 =?us-ascii?Q?ds1oDcicSyMGLCJrLc+ag079n6qdpWSTHhqe3DKamWl6TDv65pCUWgkKqtVJ?=
 =?us-ascii?Q?8TYmrmAMloNeP6Lz20Ki4IoD0oud76XtEZdhmX7UT4KAIgbk8hLk4ScDStDK?=
 =?us-ascii?Q?G6NrX4LQF1UGaYVk0jHdO+Y1LNLimLqfXCoL/OY7sL/j6+wJHw5BV/6OioOg?=
 =?us-ascii?Q?sKRcIfXSDsytrWhXflYL2dHCpxqGA/j+wYhHkka3Fs4rAayFfcU62zqLtPLw?=
 =?us-ascii?Q?x3shVO8VgSpVn4xxCoR1LqDIqS2m4i/ILbh1ozPBzmiy4uXOa3Om1GuD5EwB?=
 =?us-ascii?Q?TLyZodnbOdrjUr4LAwWCA22ZAhjWBjR6bBLncefFS3JdUdVtQiB4taFOHE9v?=
 =?us-ascii?Q?UEFzFamMEgvJ4nc/PLkduThv1vJHNcmoPsGofUftl1m6fldtv55zCerlNBU6?=
 =?us-ascii?Q?mhJFpxDuZ2gzVF3gesKW1hZq9dMn6MPsNGDW0GH6FRWe8Xi1X/5qfiYAmJcb?=
 =?us-ascii?Q?gJqNLglC8IFjCHQZDqPlm9usNGi5XM9sJ3aTFSqxZOIYT4svz7RvJEprvot+?=
 =?us-ascii?Q?Q+bllfVsCPKISZ16LijACo+ohlSMdysrQm3M9M5o8eRycw0VSQC7aOBsqHcz?=
 =?us-ascii?Q?WIWf6HYY5g2+9wMfq6LEKW6/oSc7SmGLZVHKhH1LA04q8wskoGNksmVLbXwY?=
 =?us-ascii?Q?GZNM5uPBsl4qlD5nozaYOBBZ9X8MtN/I9t/rGpO5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486501e6-3205-4d86-0464-08ddaf3ff3c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:45:36.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54VvB2O7in/2peOTvXPGA7QPxYLWj1zPziij3b2sPvNrYDG31RhXOvTn5b/qzpTliMfxQ75LtnZaBScduQSakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

On Thu, Jun 19, 2025 at 05:12:11PM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
>
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
>
> The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
> is kicked off. To handle this case, don't poll L2 state and add one max
> 10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..8b7daaf36fef 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
>  	enum imx_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
>  	u32 flags;
> +	u32 quirk;
>  	int dbi_length;
>  	const char *gpr;
>  	const u32 ltssm_off;
> @@ -1759,6 +1760,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	pci->quirk_flag = imx_pcie->drvdata->quirk;
>  	pci->use_parent_dt_ranges = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
> @@ -1837,6 +1839,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  		.core_reset = imx6qp_pcie_core_reset,
>  		.ops = &imx_pcie_host_ops,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> --
> 2.37.1
>

