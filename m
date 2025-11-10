Return-Path: <linux-pci+bounces-40721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9DC4823A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B034F6D1B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA333161AD;
	Mon, 10 Nov 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hPyVNLsn"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFF316190;
	Mon, 10 Nov 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792773; cv=fail; b=njrD6elNW2dWz6gkYgEo/Hz7qCfFnjJpYXcNvq9N2CxQ+Xw9M3WnaBvDg5VEN81/WaYv8gk9uKMsaMah6Gr358c7Yvrs1c9JZSWTa4H7sh7yzdwVDS8jXhpP1Z5AzefgyahtKBQoDCFPw2nftSbrH7G6L0FbeXtNBTmdKcsKnNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792773; c=relaxed/simple;
	bh=ffhpNR4d8wygrB0ja4sRyyWySWDZ0MsVPywhXVCBcFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWfsCpZpq+kUY2uVAsZWjOQ49X6Vjw7Vphg/GeICawk2RHnbEoGsHI99qMCiBkkR0JBN8gOLgk//h3SOUF/JfT1oLPW5XwO0IQRz0yRyxVypvkg0NarQpvNweMeDf6zfgpdX7bR/mKkJpUxMhr7eX1p54yFuQufLCdN8MATLnOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hPyVNLsn; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRVZI6hKqolWdBSRo8lIxtnnXqpi+q+t/W0vV+9V5AUO9N3foxXHTHgonwjjxXrWbo/vba0objtkbWl/eE7F+GIY5bxkwN8axlT4NkYqYLZIVOFeKkIiwsh2ELMZAUvOm0W2QO0IkdcC++hQtfURje8w76Afr3XatuYzB44G1dyD1Gvsp9h3WSiq/l282iWzZEw6kuqAMr5wOQiRJBt1xPOPfvWZtVXCpAFKocjNo7Ac9VRSafe/C2l+dkif0BMY8vMz2bkHgvSxq02x026MdMxt2FXnJ/YQ+xKkbdFtM8JAc9Bo6c5tW6tlAWU1NWlhWcDej+SY3oe4zinMZ9XSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCGb/G9xqzex1WG5YnzRMiZsBatcvtJSQtepQ0xjPbo=;
 b=Q8UNXGUARoXHsyhIRC7YZWv00R3Qb+iNSVEpbKhF69YBZrtSK51RwG6xIjwzV5S+DAsFfrqoD0ioeIEYKOzFOc3cPIUFntkKDB0dTLTIVr252xbMS0Mq9kLqtDBGGWDsyzRLIV3FQD/vLdHogLNZTv6cHD5g+YIdkGkukGwy0ZYepwXoJTwWpOyVRHBOT6c6+sySpHIoFLes3cLNmL8MfEC44SWK3dReX8eiTKU8G2ReOTNOD5X4MJij9T0D9fOikhOoYidp8QMkKgnR2xDnvn2+FGeG9QMkCWw1nMhDVlgZNdd+a2L/L7FgCnJesziXrwo6NmilEolv4ggHDQ+6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCGb/G9xqzex1WG5YnzRMiZsBatcvtJSQtepQ0xjPbo=;
 b=hPyVNLsn1jhu5u45sWcVSy/u1cWSUiA19VffodFLNPJ+o6JgczcRguIQouTJ7nbsL0es1u1PwXjS6fEdBGH3mdmRKC9x3QzlXOPaFl1D0ukeb39M0VamlzlgsYStVR9eYPR1BXXfBmDcjN1w6qH/ycCMZm9KY0YRCb+kFbRzS9c7l9GIWEBa+Ya9eR0/nJG4C/6jXojx9UGd0ukDh6U/8NtMxcrQhzkCiBD+iEq9lU3GVTob/2OOjn0erE/C+ObjFCZ8M6Pqqf0MzhHUbix42vTp8ztfs8zML+0MVQFnGPh5AusxVYtFhxNseDK7PCHZLD7Vsz5RHAZda2V9PvS1Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:36:43 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:36:41 +0000
Date: Mon, 10 Nov 2025 11:36:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH v2 1/3] PCI: host-common: Add an API to check for any
 device under the Root Ports
Message-ID: <aRIUktA5ZZhqj1GA@lizhi-Precision-Tower-5810>
References: <20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251107044319.8356-2-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107044319.8356-2-manivannan.sadhasivam@oss.qualcomm.com>
X-ClientProxiedBy: PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: eabae6bc-002b-4e70-00d5-08de207753d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jvJr8fGILU096wJ3TtuNOCvg/vuEtQB4vxT0aFr7qW0jzxpbANJNMvM6kO+X?=
 =?us-ascii?Q?S06TemRTXeFsUQCZJf3FP27W7Mwj1cS8OGe/WEijrkrIRojY8/P8BHHkrZAS?=
 =?us-ascii?Q?1hytxHrqazTX0Q4TtIa+vbNP2rsu3Sx4XUjMGbYeS0m41CdlbkUIju6+m80c?=
 =?us-ascii?Q?8L9lvWNnZJmzPEZaQHPOfKSNEHMrjYUSRUosRpi6Pn0Io+xJvkLxt89yAJmp?=
 =?us-ascii?Q?P/ohAKv5HzHgOS53vxTfgGKtvAIwv5WwykctQ9yYZvX7FcZC9rab8zXWx6EB?=
 =?us-ascii?Q?mxAWtUXH5QJS1qlPbQ0hyuUXZLY1FpnGS0URsEs6Ywkw6zKKbpVjVUZkiJ3b?=
 =?us-ascii?Q?blfoOvLX+8W29dBJudQUthX3mPh4GEUsXuMoYMmKzpvJ1nZE4eIebVv/6hlk?=
 =?us-ascii?Q?t80/t/XAUaGqZJjI8SG+PKBrFnL4HlOBL16p1+aud0yZamEry8VGUNQrt16v?=
 =?us-ascii?Q?euBhs8UM2BNg+nYUccJvFObxZq5e1iZY3WxwF5wULW5vGYEO5j6qwFAyjSfW?=
 =?us-ascii?Q?aU7dmOKqsnhZr0Op6SrbrLvlA5cKRgWFUURHWo4qWopfoiO+y2ApCjEbnpDP?=
 =?us-ascii?Q?dLrwBTmh65IunlL3QsZE9DCcaHqGDic4nA8I4I8i6uCoqva06902q5D7Qz2h?=
 =?us-ascii?Q?HajserFL0qkAdPSX3sfXSU5uoXFC8KwkOQxc6IiLw6ZXTRv/+b3tmu0YkcoQ?=
 =?us-ascii?Q?rCSnoLrDZ3uj1LHWapuIPdI0Fp3WVnPSsjjAf09IgrisjJMwMARYHSXD9UJC?=
 =?us-ascii?Q?FmYYeboJhjAZwCeB8rQRFsi64IkMLnSAHqWYUTej6KlKQvNlcGYrcLo5aJ5y?=
 =?us-ascii?Q?QT7Ihe1F2hrJ2itcNpZ/6Vqsn23RqW9zYKXk/V8jAOabAgkzVJPs6RufXlzl?=
 =?us-ascii?Q?5/qMTwDI+OCTfg8v+M7tl6g+DcV9xcDG3HKAnJeAbw9jO2RQGNzQFJ6sqtxN?=
 =?us-ascii?Q?96SA9oL2ke/ojAsEsfukZwESLEhGuS8DlUIVcpcyiV2fXWwasjjS/ENrSj2I?=
 =?us-ascii?Q?RxUumQVb/IKdmbOq/x03qHS2cWGgsnak/GG/dyFuyEsaSxIvdRcL7gabEgNT?=
 =?us-ascii?Q?Wopom4bA1HsOiaqtzX1A8+YYJIPCA/1GSTtt3rGZhBJAsRRkn5zdU53RvnWh?=
 =?us-ascii?Q?uxtEUORbP4coFU50K0MNTGZlIwkxL3MN21kbXaUSkyoEpGlnH6kQxWVHn+pz?=
 =?us-ascii?Q?RIoA34vs9npNpKkyqYHV1eMFDl+8CdSSSv+5XUD3MtMay6SO/DFn+B+6JWjq?=
 =?us-ascii?Q?1Eh4X9Dy032i6MrRi38Hm0Cwz/0Nfd/kkldkO6Zi2CzXUf+tG9/SM89yTsAk?=
 =?us-ascii?Q?oP2ZmAw2p/vfmlkL78zUqhUza+Gyl7GNvdlySlOUFg+CZgBVol125BeVWZ5O?=
 =?us-ascii?Q?6wqfp0ql40mcKCoKB01Ryu0SAR0JOGAGY/RPkkDxwxdpdP+MueUaL9cAYQjr?=
 =?us-ascii?Q?7VRaV313BhirmeXKLgR32DbCQE8ENFBQl9nVFnQLju6Qj2CVE+Zg0z6DVQlf?=
 =?us-ascii?Q?P/qBCodNlMwusTPvt5lO7F9yDenXaQYV00zZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1oDC0B7XWu9O98aRAv2KuTe1V1VZwM8Lyl/fdM4Wf55BBRPN0CbtIwspNmPZ?=
 =?us-ascii?Q?jyyj16373oNAnnn0Bq0UzKTm3TLjZgYnCQHmzkPi3doa+jgnlbefzY9wW7eV?=
 =?us-ascii?Q?T0ehJuBcQOAWfSMbw8n8boAdIfnZ7GL1NRkOhBacbGEwcDBh4I4mobsok4nR?=
 =?us-ascii?Q?JhRk8oySFRWw2LFqwyo2Tdf/WAEoSoCSkTMz3qNrI3TRS0fSzaVh0tv0cPnl?=
 =?us-ascii?Q?LPB6eLLvTqHv88KUFo4dq7MLadeeROpPZ8S4lISDCYntzJyhRfYKHs4wDN4J?=
 =?us-ascii?Q?BCfLE6RAPNl26K4sWUkLH/ythsbTlb2iwUpApXRylSpyWzEDVV38CThz7dhn?=
 =?us-ascii?Q?eTwsFsz3Tg40mWQSLWl36dWoIvQKt+c5gG24zora9bv+3g9RQxARpXOIs56M?=
 =?us-ascii?Q?VmGaBQpvuw+79DJ9N95uBlPAGUKjYDnXN/SQEXk84BGE76ShMwALEQidWJCG?=
 =?us-ascii?Q?D7djoRjybQIv5gvTs4g9OAnCsdX3O3Q9z3MC8VQs9V2jZbd3TKhGKtMx3qXD?=
 =?us-ascii?Q?VdoTfY1N+pJmRRsxozitFhab8vejy1WN73cil3FNbetnYiDdYnT8Up9VvP1J?=
 =?us-ascii?Q?3MKj+uuLLd3g32zwt3wJBr8KfgVKb+/kSNabPReX+IHFse31IBx4HIy2I+kc?=
 =?us-ascii?Q?Et44mIaIbZMvZZINkABEEofnoY3M1PNnGqT9lnxFVxd9t6T/CiyXAnMehtd+?=
 =?us-ascii?Q?Qts0eO9d1g3GTkzJGGF/Zze8iblSs1hFpfLVHC+S8ufLSkN688dQTrQ52iFk?=
 =?us-ascii?Q?Y+sE+KvxowH3S5ZtgBI6HH2AbI0snEuHP1htiS1gihWyFA8E1uS1OEBv6pck?=
 =?us-ascii?Q?+lf7FeazChndNrr1WVuQndnMnOYoSbnaq+1duHYhioShhQa2J6y9DQpqtfNb?=
 =?us-ascii?Q?HIoxMP5+j3pFCFyJOqUbVkXvkNqNGjnBQaN8bLq1nZxC+sBgpWYaG89poVXW?=
 =?us-ascii?Q?YSPWMckf/GIpei/n1J2B5jjEYiuG51aGkuo7GHgwcVivw8PlHiRHhXTsi3My?=
 =?us-ascii?Q?IbZVaqHpeT5n7zB74DCi94jG0E4Q8lhDO3ki95KD4LLC0nW3z2tEUtno2VGZ?=
 =?us-ascii?Q?yevKqHBJpE8hhQgdawWAfKmwXmROWqyCA2XRuM9/IkeDLdZBgEdi5UtfYd0U?=
 =?us-ascii?Q?GNMOG/OKff3qfzaKMfzVzy+zpN81UhTeGdW7iB2nXNNgnzPIVpJjAFOXju5/?=
 =?us-ascii?Q?D4IZGOAe+WwB34VmAb4rKtJ5csyiAjm6DRNdVdqKClUUMHNZkJqq7UdWyrgU?=
 =?us-ascii?Q?uF8Fy6DTF+0QVhS2PRynExgoIlhDaLJmQsYKlwGLOYK14CmE+bR29186QbOq?=
 =?us-ascii?Q?LUYEKpxKRJfLqdKoguTX9RZ+fPP2+CvZ98mlMxgUdaqH0XgO42UUX4GTYTau?=
 =?us-ascii?Q?5diqbmhRQdhwihmzwhlwtvn75dP/BVehrZf4ZwZFOazsPPAswKIZxPYk/Scc?=
 =?us-ascii?Q?oHjP6kB004pFtguywel+s+kfQjf+FPIBk7LLodIRgXSkopy2ShxSqsnbM4+6?=
 =?us-ascii?Q?6HMrS/DuthIFIEgi/8BHVKumNtMKzxUFq3Az36lmoItLPLG1rcHV959W7nAy?=
 =?us-ascii?Q?lI7p8MdYQOLgLO0qEuF1S89Ect0ecG7ZmWfHwveo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabae6bc-002b-4e70-00d5-08de207753d8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:36:41.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyU0waQEQgvjXiaNV6YuIgNWIcVGlYuLyHrOgNhgcoCr3Dl54KTrz3lJTVAsEsqyJBKy9d78I71Wd/0P+CFvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423

On Fri, Nov 07, 2025 at 10:13:17AM +0530, Manivannan Sadhasivam wrote:
> Some controller drivers need to check if there is any device available
> under the Root Ports. So add an API that returns 'true' if a device is
> found under any of the Root Ports, 'false' otherwise.
>
> Controller drivers can use this API for usecases like turning off the
> controller resources only if there are no devices under the Root Ports,
> skipping PME_Turn_Off broadcast etc...
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h |  2 ++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 810d1c8de24e..772bac8b3bf2 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -17,6 +17,27 @@
>
>  #include "pci-host-common.h"
>
> +/**
> + * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
> + *				any device underneath
> + * @root_bus: Root bus to check for
> + *
> + * Return: true if a device is found, false otherwise
> + */
> +bool pci_root_ports_have_device(struct pci_bus *root_bus)
> +{
> +	struct pci_bus *child;
> +
> +	/* Iterate over the Root Port busses and look for any device */
> +	list_for_each_entry(child, &root_bus->children, node) {
> +		if (!list_empty(&child->devices))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_root_ports_have_device);
> +
>  static void gen_pci_unmap_cfg(void *ptr)
>  {
>  	pci_ecam_free((struct pci_config_window *)ptr);
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index 51c35ec0cf37..ff1c2ff98043 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -19,4 +19,6 @@ void pci_host_common_remove(struct platform_device *pdev);
>
>  struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>  	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> +
> +bool pci_root_ports_have_device(struct pci_bus *root_bus);
>  #endif
> --
> 2.48.1
>

