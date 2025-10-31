Return-Path: <linux-pci+bounces-39955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C40C26C86
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1B7534876B
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796C2FF17F;
	Fri, 31 Oct 2025 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lSYfiRpp"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB182EC562;
	Fri, 31 Oct 2025 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939434; cv=fail; b=UpoNK79ksE2+bhDa1V06Xxo7Rq2ctXI1SWtDpEwMc1mhSKI8bRVQJ9kGPtm2laLoQxwIN42wAdmrz3QSRHiRXl7bm4qUJjefCpMfcpdsAdsrwnaA/9v4N+NpV9av7k6kvtSmxMJfA8Rmra7zcpy7FCqC7zUgTEWoEHcoCgbU054=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939434; c=relaxed/simple;
	bh=qBcJHa09GwSd6fn3beKwfHRKb1sCAPRLvh8U2kmElf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j2b3ZkFFMOXJrzhb/qp7c8jodldC4l3YZkLkxTFcuA2YwS+INLt0094cePaR/TBdfSe6bIeurwBghWk30avWIyBdoV2ceME8bU7q436A1eqeTg6tpaL83+8zAKZX/rJmWlo77Y/NM8x0jfUWE3pSBhKX5H/xRvhFpKSG3T/DjkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lSYfiRpp; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEYVcVvKr8ttDE3QGooA1ZxYnbLBEb2OtU2xbJ+xq8MvdzEgIYYr31qvpl2ZbBIoJJcAnQEkcaWFBP4lMZnoldELYUGdJcQ4Dbhh5/dYUbeoheLbR0txTB1p92pc52xdeJJEcH+C/fgsc/lR4yxyUDdFpnQySsv3HW5Rrq8ot275i2yI1kv2MMEBPdrN6D/Rcl0IqIrp7fj23YfuCSkGGUwTpcbxmLfIKAGeSQyaaNcbyYzv/3ega18EeXXTp42WaU5tUZ4dMhNdoPtZvcxYSWbmKRSNI3K77z435ZE5OznNzMA/kiTWv60xP2vK45w3ZVmaitaSGddBKoAxoa14RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KH9p+ps3uRZhnrqEycMAR9thv5rIrYSkKhdezrqQaYM=;
 b=b0EsdiDkPI+ayIk27VLZ+hnOyytv/Y+DPI+GxxCuU0kRN66svWVp7NF/VUokljvB6fABrIKFFvgwZ5NIF3b8jkQZF2FVZ3NH3pNVd4q7SasTm4jVnl1BlVvoHG+NMClfgYTp6oehFkZ9eLkRFV9P9FWHc/KsWsxQvjSXji8gjPnMVK5NLggKWRM6WVArOCwRtt6MmVNfiac+pf5DH1vizbHqRyNLR8K6XBA0dODev8pGBVKvvT/SvmwD3tAMCOIzbKzbUPedGc0oyiWusp9Bl5KNEToK90pHTFt4jCQgLkDqTtkir7xoU2aFZpU5JXgGYQwk0KT6L7i3pLRbWNklQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH9p+ps3uRZhnrqEycMAR9thv5rIrYSkKhdezrqQaYM=;
 b=lSYfiRppRXtggFPdnaxhfAjsg+kd5VIob0gAMoiB7W50ty2P57utRp7GzIuWGvef3CdravVjxWaNemPQz8v7re0WsYLqBN6dE1/1g1AgpWxFZX39BCehrp+AE4NMTtRcWz7ZCVbGCNeRnbvuuobTXC63kwbohCoI0CKHOi9Owvkg5+sUU5b92ZK82B+GGw42XYYkdgqWC2gaGB+NVvhwTVPhMGwVOTIC0HeBK/CEyyLrcgowAB/5PrZDXZnBQMLAzWZUgxi3PAJSVs/wfS7vdk4jOKOq7/NzsDnzWpNtfxbPSyHym1LkQiqtYo9tKqdGI16lMjDDriHdH50IG6wfNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7596.eurprd04.prod.outlook.com (2603:10a6:10:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Fri, 31 Oct
 2025 19:37:10 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:37:10 +0000
Date: Fri, 31 Oct 2025 15:37:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
 supports-clkreq property to PCIe M.2 port
Message-ID: <aQUP3LCHnMVhAUKR@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dae1086-0d15-4162-cd60-08de18b4e1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iB7kAIBFXUZPpS6OSC3zY1Fk/fuZmbCvJiewv9QQphOfak4oESoOjAdv21Jr?=
 =?us-ascii?Q?E5B3afMlYBjQGSG28iPNoDcgKmB9QwUk77CSNxZmMmbLcyFkUE4y6oPKe2X5?=
 =?us-ascii?Q?w2WlkRF8dFsKGo8mt6loGvPKBStP4Msv1DvnwjyB6Wv7OLrJ7T6+Z1XP0ZyT?=
 =?us-ascii?Q?ViflCRaniAYH/bbf88Hz3t0BqSOUIu06okWsXc51Pls6JKdsLJnsKATKzxxQ?=
 =?us-ascii?Q?fSYTbl1/qkw42xOu+nDFoptEegoC6a3Pd+GIPhRRcb79FJ12BpGspOkq1doP?=
 =?us-ascii?Q?LoGwjdPQML6L6zoPS2aXm/zAVXFO3dT37Tm0lj2zMbX1NiLLBg4JmQXR8OJd?=
 =?us-ascii?Q?Wy11wSZHjEgerPmtOeI7oP+2GeS4aCSxRa5ezRYGDId9JuVXRm+hdnclEhIY?=
 =?us-ascii?Q?NyeVB8Q/vxWKLQhI670QEAMep5l5DeZIhG3WC4ZnOJjTaE0+nGN+N4SDYk5N?=
 =?us-ascii?Q?Bkru5GOuqw3+nCWhb4AYoEts39X7Ma1cRW80vsZbXDRS2fcX40Bf3U5Zhw6t?=
 =?us-ascii?Q?T+ISzfwceAAwZu33utE9jIgqtvKtNEoh+Spvbpt1R0x4uld83RpNK/FCPjvp?=
 =?us-ascii?Q?+Qr0hkbfeP6tBPh5mUwdKq9iJXxndZD0Wp+A8NIHGik+Gt75B5uUGfdAJ6Os?=
 =?us-ascii?Q?aLfwhTxYPlQNE+mMia58pd0sZxC7EZZs7Nu31SS7nsbjgUwUI0sLgZbBOl04?=
 =?us-ascii?Q?dekh78Hp0mRpp0G6OX+RnL4nlax+jjMRFSxoi/CzcG/o7vUAvB53LDMWqeVc?=
 =?us-ascii?Q?ttT3jQs0XhB/+AsKQYAwTmnFCn9tCCFH0uLpCBqjOtMRWfsG/ma21iPNH7Zi?=
 =?us-ascii?Q?06xk8OaZc5SzusY7QfQEI070AVUPJVdjZ7BfcK1GpCg3x8FMDyK0y3kVrT4J?=
 =?us-ascii?Q?aBzlB6F/CZ8zao1Ng1MMWObNZOJUaVRwqe2SZ+7s4bUfHIXcmRfQNEOLSX3c?=
 =?us-ascii?Q?bCt7VoNpRu/v5vYgqiKih/zYZZI+jFtXFL6PEsmhidmZ1RpwJYvvCKgpIH9j?=
 =?us-ascii?Q?c+6wiytAs3hFKkzk3fwqAs2z7lRDjI6xddph0hfG9gkIgp57wF1KKLu/6Tdd?=
 =?us-ascii?Q?GtV4S8+A9448+tQn3+RcmJSuWYx+0N7kwzQRgv20q+tTyiaGAiLsxw8bEchk?=
 =?us-ascii?Q?mMp5rTAYdchjfFqPTuGA1oT7IlFFzZzJ9nDn9NFiIGoSEO3fRTAeKFiopvrm?=
 =?us-ascii?Q?FmxNed4S/be+ubsZhun9GlIBh69KqEkeHwIkbImOU2/bPaW7IUo14OE2pk6S?=
 =?us-ascii?Q?YzAGQbfrzMQJM+oWxQSY1rRfMtU3hPA+5o/aNMrJ+lFf8t1Ekdq9VxWZ8iBW?=
 =?us-ascii?Q?nnccpr1aO+loY3lcfEFcZ3DdQMNfhTi8Vxu41diENb34H4CSobhlmGw3ZG5v?=
 =?us-ascii?Q?VMeScHIi1MghtpZH9ycBnuUOciaSx5EnQPMt3yAa9OJShL6+kfemV1E7lO/h?=
 =?us-ascii?Q?X0tCRLPOAe+gEB5W7THTTLo/W+JRxaTFzc7MUHhXjoHeJiPFzymXX9/OtEYG?=
 =?us-ascii?Q?H5m8ew3NqnmWpkzXW5usDkL5ozXLRsYeyGEs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6MZaj3hEZMHTVTO2xxhpnv7til/4xI1jM5Ihk60qy5O1C2fmBZWv9pbOzmO?=
 =?us-ascii?Q?SO4D/f3TLRzPB+uBbxBZDVLWa2IaJ7xokby4g+irgMALpDX9b/vZ3C/FNGjx?=
 =?us-ascii?Q?gzQne4gkhTmkTkzvrfVi4I6z50WYBsTAgkrSambhZZTeG5zYKoc7CZjMFbTN?=
 =?us-ascii?Q?TEb3qv2Hto95yacIqAYarqJphg+0+r/OtBPFC8th045fkhagHaMVIsY/iu5C?=
 =?us-ascii?Q?Ux3JfnvrBL8FQjkcr6upU633PtjisfZpbwd/ADFDiKVA2aHHQc8LZcosMx4/?=
 =?us-ascii?Q?5Vpf/OQ2ryPb+4Cn/JMhQCz/Lb3RePpcGU9QfHNa/jowLWovxQVYUn7gbeIc?=
 =?us-ascii?Q?kv7nxl0iO/q12Eapdki/FvNbhTXUSLjkgkjlpp7AC0iJuOLHUwZomSJFPIMa?=
 =?us-ascii?Q?F61HyDpWSpem17OPE9RpdkHN1dtwzG3JK1fI7coAXpOyW31t/0gXZ5YevqMO?=
 =?us-ascii?Q?g1YCzcYmxvVqBaiEl+xEKafltXaOXMmUdkmnKW1fQ5QnaFBd/7tz5IUTR5L3?=
 =?us-ascii?Q?xixvMAaYgILqnQpIXMIr0s0rpd4PVJKugBXWFBcyxiOKRolnB6b0mUbvjMaq?=
 =?us-ascii?Q?G5lPdOB8fa4QLj7vJrXkPqucqk0OMmy9BaOBe1aRwIjTcAcn4nglDxHK43KS?=
 =?us-ascii?Q?qhDSOiADMiQKpnCeM4x/L5NniQHk0iS9CN7Y+HzTo2onr15KZu7dxBt7q+ov?=
 =?us-ascii?Q?wts3E6gAvjxoma8858w0Z7djVCTKyRNcPGZ2tSZlhr5q1E33cUcmOcghBlCi?=
 =?us-ascii?Q?vNCdxp/+17G424iRFsMZBrfXr/1L/4liVzqxpHD1enE/vQdpYDMgxvNcx8aY?=
 =?us-ascii?Q?dfXnS1VLD6FX+u5JARJYeHuK9vBmL8/0D4njRU0UL8j0IL+yoHrt7WuusLkM?=
 =?us-ascii?Q?EBDxZ0Y45CC8u7dTk5DK6pIJEGCBa+uavvrsWIgAtbsIJlvdSQpXNC6hufue?=
 =?us-ascii?Q?KJ2z4luenSwU2gF/joTnhYAZsYxRuH5HnU6PqLhcdJVexCGJ/fOpn8TFZ/d+?=
 =?us-ascii?Q?u4ywIiTe9Vwp4uPgkTHcl3QE37cvtcoV2NoO+BSo0BrzhXBAJ/tlIPsgKOMM?=
 =?us-ascii?Q?lXo7I8ySZ0oq9q8Pk7a0HkHr2pNoEFeDmRgKvG3Bcfg9K/KnX7WTSzxSKASZ?=
 =?us-ascii?Q?jFS/5/+wZb0QCrWRkNVnB9V3rcOVT95Gd8faVacHfg+W9aIyxiVRc+tzidzp?=
 =?us-ascii?Q?oz7cEl6Q0BCw4lrGZFMsTqgPowmQxNsfzCnDANkQGw8Obm2plZol+gnhLYqB?=
 =?us-ascii?Q?Bc7bKcmaF4Rvg1HGPiZSI1BLEoEnIotu1YBSmujVUvM6lN8kLMgHMDMftLFR?=
 =?us-ascii?Q?io2IO3PiVTMR3prR4BP9v7GFqnD0ttjPPsU9EdO9/0HDI0oSqlYUM8u/IhQG?=
 =?us-ascii?Q?hQeSK1ijB41eA+ecYUxbt3CVe7cl4sYPrloZ8S62wWYVhalrQXRJTlMWsoET?=
 =?us-ascii?Q?76A0oApWNEyKGSFeT/+g4MHM6340VM3kcv6qEB1fyGpjpfhT+aEvVEQJVrGM?=
 =?us-ascii?Q?MJr0gU9BTh57d8tJAmY2eeivVV5VcTfACSMqdmy/yvpjmbPPd4rZKrZ+vJxJ?=
 =?us-ascii?Q?WRo4dhMbCoSBCBc7R6CkPomh/3jkX5g6XzSFJYii?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dae1086-0d15-4162-cd60-08de18b4e1da
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:37:10.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+EWUtnqceTq0XbSrV9yz4S1Aa/iNfruzPdTFKAQ1EoEGJR31jqw357W/CBjL9VSjbnAuRCxJB42YAFSnhaGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7596

On Wed, Oct 15, 2025 at 11:04:18AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
>
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
>
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
>
> imx95-15x15-evk matches this requirement, so add supports-clkreq to
> allow PCIe device enter ASPM L1 Sub-State.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> index 148243470dd4a..3ee032c154fa3 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -556,6 +556,7 @@ &pcie0 {
>  	pinctrl-names = "default";
>  	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_m2_pwr>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> --
> 2.37.1
>

