Return-Path: <linux-pci+bounces-20555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E8A22535
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0210164DEB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587719CC3C;
	Wed, 29 Jan 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YgW6kVL8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076129A2;
	Wed, 29 Jan 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183399; cv=fail; b=WpffyfZmSNaS8iuFlzpeWK1SuJw8KxZXVo5w/RLyv+zLE94GJ3D8cHCifQlzRsEXnCsko8r3RF0d/iitSKOJCIQkLGVvC+71s5d95VmyiEjZHKywARXXPb6Mrs3SrdXJGQcy0mVJHvkW2YlbRQPPnbw5QW1JJoFLgB94pViiPIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183399; c=relaxed/simple;
	bh=kV0lIZTfl2kySBoybfWKkXO8aSLdZ7/F0Pg/1n3rCO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l/+atlbn+vMbkeeFoYoCyIsu8XhkOJfKyRhyvoN1e7VeMKzBOaQ0BCb89sumaS1jSWqKDIduqc/2fQl+yjEGfgCX14XEt1elQKzY1vW557Hb8gW5wtmFZQ4YAgACa10uKq6EMYBws2BvwyAWq40tl1i1ZCVJM8O+wuhTUCYFSK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YgW6kVL8; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDVNvCbvFuoDSmvi2osKyEmBMEmRyXm43Jj7029qkIbhqsuWneU+BJDimgweKK1+l15/wyy0Ifg0MbbnTpuckn+FlIG+DRJeBLt0R6YwznwP7PGPB4Am5lB6nYAPbhrTpB+cyY94ow2aaLNhVtCf69ASmYCFqKMlbwQcnwxaeLpShe7zyFz5RKUzU9Vr+aKXLKRonr2hQV2WFSKyPYu9ThYsUrDFTzC1o92XJxiM1fXu3pCEpYj1WU8H9l8zHwoi6Xl/HORdo79xNOYZwCyr+oGuqS4UPh6mjTCtQo3jxIZR7XezJwbFngkBZT9Emm5dWTyMT16rgY4dJTPuYhisyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP42Xi8gjMco36VAmiQoNklkbYGR/s0cu/3jUd2xCDE=;
 b=QeqeQnrPCthLzViBTjg0lpCKuiZtWYq3+T6IRAq4hP7ed3PSDqWQth+I3I5AVsmj3Cg2qJlO9mgAPShcSQ+EDnrApstHWiD8KjUXpoOBrccDwnnAIsOxklIaHlSZVwZxXx3ilRVJAxwVTJhJyF7lzsyCnOuQG/rkC1OYl7ak/F3qmCnNMngYfZd6wiJFr4oqPtT57Xlrt5I+LDcllL34oYmdEL1VpH69rYwDk8AS4P0ax8pgXrgJTI/0dDxVDNL5ZIrUm+5/aFNOf3dxbCCshbicXWXofJhS2k/4YVeEKDlcrN3G6P9qUmEWs07Nj9BZxtEE0ubQHWvMf4mmg5cYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP42Xi8gjMco36VAmiQoNklkbYGR/s0cu/3jUd2xCDE=;
 b=YgW6kVL8GyjrkEZPHBzGMFJjP+LPZCzkc8CzBiVSf4atRRNqt4dKqGlUqqNrul6jDVI7MIyJXi0RCb2y66OLWEHlUWMxqGgS3Wg0c7leVk9f0ylJlrLFi4N58mBXGp96FInWYTmGgTU5f5wQECnh787yKpbmsI74H8vkq3+j4KZd3GDTzL/2K1JWxF/cLjztapGVKv1FwyB2+7XfAeXnvAMxkPJDabSwYNBZ8tpRDG7qvgCR06Tt3HfBxw+6Q2zUEl4dsSKPSeaVnZDrw6VZsefWZ0E2WlDyGO4pf0s2Lb2exEGMh26MsldHeTZMTEsK4nblj5RuraFNAWsrQ4RhPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10954.eurprd04.prod.outlook.com (2603:10a6:800:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 20:43:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 20:43:06 +0000
Date: Wed, 29 Jan 2025 15:43:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, matthew.gerlach@altera.com,
	peter.colberg@altera.com
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
Message-ID: <Z5qS1NKSRn8pSqg1@lizhi-Precision-Tower-5810>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
 <20250127173550.1222427-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127173550.1222427-4-matthew.gerlach@linux.intel.com>
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10954:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a306ce-01ef-4585-d769-08dd40a588df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AhdBsZiC9BRZY46xcFysWKsL/rzeQhw/Lw5sfepNAlejD52KAzqvdwjIEZl?=
 =?us-ascii?Q?d8i88Wf/nRqgrEBrC+JpIUlYWLLtyi8tieCBHQvh6hz8XZYHac9bXOjIk0Mr?=
 =?us-ascii?Q?ZdCUhiGjkwfC+oY1ZchJZOhr5X39ALPNCwODP94jU6i8o3h/b7AL9gHisG5M?=
 =?us-ascii?Q?cU3GiFohp3RP6kVEolrCJdJNN1+yL4bQHTH2Z/RAbq7fVUoFq4H83ZhxjVxG?=
 =?us-ascii?Q?TybD0HAycFNgBUyZm30J0FCKPYgej1N5WEWkHe0ksB4//fOLDH1QUicR+p5E?=
 =?us-ascii?Q?0WszL4FZbnGkFjEJ3MkY7kevghjYNv8CBs27zfiLJchUROGGX4yqX2RxrIJ0?=
 =?us-ascii?Q?+wh8+/oRwJhId/Ms/PbX+WM870ZUU3ITv3Zp44rL4+RJFe+0HQrOy39gyL4h?=
 =?us-ascii?Q?aqpJvokiHTctcYqPPVSwgjbYj9nVXJbXtPgu3hy0avTvRSiXO9xKWnw+ESuR?=
 =?us-ascii?Q?kMR0gUhCLKGiEDfF/QSY4USZ55L8w7Fp1YWpit6nqMvNDYRkTyP65SmQB1C+?=
 =?us-ascii?Q?qwbBIXGUOBEovB8gBS/8LGhO/ZjmED3XkVR7Qu5WTa/VFBDDOB+XgK6Pm55e?=
 =?us-ascii?Q?oPEmLwruw4HerzFdNutZvaVModuoRuc5FVL8w33TL6d108Wxn4uHmoDiJG61?=
 =?us-ascii?Q?8wUTXymOGNbViQY4uAltE3Hf16r9JtHNDAKKZ/mFiwJRVcAR/638nqiAlHlg?=
 =?us-ascii?Q?7db1mm/AGNbL/x8KjQO7JxlBcshnAXVNt4r24CSHtu1r2Wbq62SuAWB8v/aW?=
 =?us-ascii?Q?2aGZUjh9e4fg9zaxgF3Q8nl6xW1+BFB0NG1KEempa8fq/760xBC9af0WDDm6?=
 =?us-ascii?Q?lfjETkeoW4HBSXiQCdr8M9kBSR56VyrtpyzuKIEmjngO5Bd5TtWTPC+xYEEl?=
 =?us-ascii?Q?GQVaaqAmA42uwW9/PgzF0zpOzKqPsJFcj7ayWUENf4p82BHpNRPprU0yw/JW?=
 =?us-ascii?Q?ApwZNSZANHMm42KSwqB7AkoBXCnrzdchCczK7b6yTYeXYggFeAuEsGvHzHxH?=
 =?us-ascii?Q?T8L2YKS12ZNjAA9Nkp0tLyg5fwJhLLFlwrL/ONg/najzVGB4401AWZMmylLf?=
 =?us-ascii?Q?9MbuES91tYlmZkl1UWnNvQBFgxRUUOwfKXukWK73ZQ9jRvrfeWckZBuJNPJp?=
 =?us-ascii?Q?xsg0bZ1C8TmLyvb2UXVCe2a9+NUb+PY8zh6NmtUx2mhK/0+KtYfxrUoZ5wfL?=
 =?us-ascii?Q?ry5b+dYzHPIepl69jgOXC2ZkkYXAkbRF569nYFWmv/EvRF4RfN4ZubRX2WyO?=
 =?us-ascii?Q?KiP8QsKQJ1184GCoxelEMI+llbemlLDlPBOX5kCkS74Fe0hd0gX+REjvvWey?=
 =?us-ascii?Q?f2z2avS5P34UvOTnrw4qj2N3SmjFKlt4xIEf4Cl1PrSOtHrkX42mv6tcXkbF?=
 =?us-ascii?Q?wocNcN6ocdGqo6abl59FUktOvCf4qC69rTQ1fXcGEIZiaOQ+rNJ6Fx06Oth6?=
 =?us-ascii?Q?ockjdFbunvPkPe/fMVpa1RIBg7i8jKDL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lpc9fxoITW6gspZcfcPuOlp9vbyb5P8Q3aJ5F0ZK6NFMCEHJMgC6/Q07mI6u?=
 =?us-ascii?Q?Lyy5VJXbmrnVzJ071HaUNNSseW2QXCmxAZ+EvVyIBq8c4DVHfP+pYVwpWzIJ?=
 =?us-ascii?Q?ODEEvlnTTR7/ogMdoSEEPR+8FyvGM8Q/W7EkLQyTAmZqABiTm6gJS6ZzF7mr?=
 =?us-ascii?Q?eUglq2BgQCXu6+KI2N3ByhiMdKpnaB5O9udHtXLUOkdCqdZ/PAii0znK+Oru?=
 =?us-ascii?Q?OqV0KRDdBtMAoO/Uko7lCwPPGogt4olvD70wdDO1C3c6UC+jcgAXuHPdmpUQ?=
 =?us-ascii?Q?dsTf/Trg0SwvK2cFmrVzJL4pIGW9tkpZcDL2ciSj6Gbr7/d5iGKPnpAgKGUf?=
 =?us-ascii?Q?qH4xOlnmDnneTwaxODnrP8LYif5UL0LLpN/vlMu4EgIflHtD3UIGugLZu7ri?=
 =?us-ascii?Q?o//An1YLHNMdPGizoCt6SLsZrZaH3J08l/Y4m7ip7F2eyL76ICzIWi4iVozo?=
 =?us-ascii?Q?1Tj7ZWll2ohd2yFzzh/sKhA1+rpIGs1Z4r6YMClRSNS01MH5XOJK35wNvIbP?=
 =?us-ascii?Q?ynM4d6XKh9f0bLc6M+Zu3mEccowUe7cfHtNn0F2VLahmPF4kM/Utg6yN8xbs?=
 =?us-ascii?Q?KayBQbG/NZQvwml5rTvrN6n3yCMpAg0Q8+tk1F8mse5jSENG6HDOwA0SWDeW?=
 =?us-ascii?Q?TC3oPKxyulLMnxPb/3iPjx+ABzrOZt88wZm8TQN+p5EX3jwMqyVVuLIFusiV?=
 =?us-ascii?Q?LgIlAc3NGu5cr3LkizjuFGh05RRthvI9/fXeq0XtVHyue3k2xasKjnLxLRmp?=
 =?us-ascii?Q?SNoYjJ21dOjJGmFdFbvmPDddG5Wqvh80RwV0D01/OhD1YavvK17Lead7ivCh?=
 =?us-ascii?Q?kXA7oTtbSItt63cpWX9TyDR17UsdkDwtiimdVs+tnIJ0TCxEYhcu3LMacKXW?=
 =?us-ascii?Q?wf6yBHS/VqVxMEJRPNjEj6XvgABXIKYfGNgZ16ty8h1xb2cuGwIg7IgmaAzu?=
 =?us-ascii?Q?jtoYUWk5jwef82UO2zCnjm4JNDu7N+wh1uIgZOfYWTavGN7HyiOctRGRN/hJ?=
 =?us-ascii?Q?pF/LI8rbUSAhnc6QXKyG+sEVNWkMqm7qNYdQSk5iy0wsPB7/4MHVLPGmd0pY?=
 =?us-ascii?Q?9ZmsQti3ijIxjAsSVcZJiWmT5X0IR1UJEtw3V0tqwBeQ9EU+p9Q/QQnhlaJL?=
 =?us-ascii?Q?0MKyn+H7EKb4spTflAajh1cwLAlfWMFog3ymayidFHLBiOHeYHCEv68cyIRj?=
 =?us-ascii?Q?IR8OMobXbAlZ76ITnLq/UEEGrMVo3TCaYnf7/xrk66bl2zyhB4/5C9JgQVUT?=
 =?us-ascii?Q?c1j2eCSlj27IBPnv/EZI58n43yT7wvYVCuWleP2nyYVhce2YTbsxui59eFQz?=
 =?us-ascii?Q?PtitUsg0F00yhLRGJyEq5V04kFd9fAnomXHufOJnaJPfvzDRvr6mYrPFxIFz?=
 =?us-ascii?Q?844sRl9HzrOJ+MgZ/a2Oy0GWDq6MS8nwNY62N8gteerubBXKPeG1iAlX3jiy?=
 =?us-ascii?Q?qnKEjDvOMTIf1gfKHiZeiA79YhTUrjjOUadRdYSfvMZNMAkZ6H91VGH77iVv?=
 =?us-ascii?Q?1bL9avfL/WMeEnX+lYChko4fKjMUa3QZlxbkaVakU02epUx2tWNii86m7bzP?=
 =?us-ascii?Q?SLkntqR9tcs5YNx+XsRJlNYlkGeRA8N/rSECkJyD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a306ce-01ef-4585-d769-08dd40a588df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 20:43:06.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhzF4PD/UFhOI5UJTAlBYm3+hCHB8L6I8w6Ja+DBrAcKaa6Mqs3TqX1FdO9RB3pTVOzlXx/9MVvACcg95vBgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10954

On Mon, Jan 27, 2025 at 11:35:48AM -0600, Matthew Gerlach wrote:
> Add the base device tree for support of the PCIe Root Port
> for the Agilex family of chips.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3:
>  - Remove accepted patches from patch set.
>
> v2:
>  - Rename node to fix schema check error.
> ---
>  .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> new file mode 100644
> index 000000000000..50f131f5791b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024, Intel Corporation
> + */
> +&soc0 {
> +	aglx_hps_bridges: fpga-bus@80000000 {
> +		compatible = "simple-bus";
> +		reg = <0x80000000 0x20200000>,
> +		      <0xf9000000 0x00100000>;
> +		reg-names = "axi_h2f", "axi_h2f_lw";
> +		#address-cells = <0x2>;
> +		#size-cells = <0x1>;
> +		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
> +			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
> +			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
> +			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
> +			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
> +			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
> +
> +		pcie_0_pcie_aglx: pcie@200000000 {
> +			reg = <0x00000000 0x10000000 0x10000000>,
> +			      <0x00000001 0x00010000 0x00008000>,
> +			      <0x00000000 0x20000000 0x00200000>;
> +			reg-names = "Txs", "Cra", "Hip";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <0x1>;
> +			device_type = "pci";
> +			bus-range = <0x0000000 0x000000ff>;
> +			ranges = <0x82000000 0x00000000 0x00100000 0x00000000 0x10000000 0x00000000 0x0ff00000>;

This convert to pci address 0x0010_0000..0x1000_0000 from parent bus address
0x1000_0000..0x1ff0_0000

aglx_hps_bridges bridge convert 0x90100000..0xa000_0000 (cpu address) to
0x1000_0000..0x1ff0_0000 according to ranges[1](second entry).

Just want to confirm that "0x1000_0000..0x1ff0_0000" is actually reflect
hardware behavior.

On going a thread
https://lore.kernel.org/linux-pci/Z5pfiJyXB3NtGSfe@lizhi-Precision-Tower-5810/T/#t

Try to clean up all cpu_addr_fixup() or similar fixup() in pci root complex
drivers, but which require dtsi reflect the real hardware behavior.

In most current pci driver, even "0x1000_0000..0x1ff0_0000" is wrong, it
still work by drivers' fixup. If dts correct descript hardware, these
fixup can be removed.

best regards
Frank

> +			msi-parent = <&pcie_0_msi_irq>;
> +			#address-cells = <0x3>;
> +			#size-cells = <0x2>;
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_0_pcie_aglx 0 0 0 0x1>,
> +					<0x0 0x0 0x0 0x2 &pcie_0_pcie_aglx 0 0 0 0x2>,
> +					<0x0 0x0 0x0 0x3 &pcie_0_pcie_aglx 0 0 0 0x3>,
> +					<0x0 0x0 0x0 0x4 &pcie_0_pcie_aglx 0 0 0 0x4>;
> +			status = "disabled";
> +		};
> +
> +		pcie_0_msi_irq: msi@10008080 {
> +			compatible = "altr,msi-1.0";
> +			reg = <0x00000001 0x00018080 0x00000010>,
> +			      <0x00000001 0x00018000 0x00000080>;
> +			reg-names = "csr", "vector_slave";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 0x13 IRQ_TYPE_LEVEL_HIGH>;
> +			msi-controller;
> +			num-vectors = <0x20>;
> +			status = "disabled";
> +		};
> +	};
> +};
> --
> 2.34.1
>

