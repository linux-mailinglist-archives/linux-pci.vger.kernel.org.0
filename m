Return-Path: <linux-pci+bounces-19677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B6EA0BCCE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5F51886E97
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D91CAA62;
	Mon, 13 Jan 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DQ4npudt"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02C240222;
	Mon, 13 Jan 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784189; cv=fail; b=jeYCkrCHI3HsRsnq4nQzD4MXZpOJPmaFfmzvl4oanK6lc1+ffQH+MEmWvNYPV0TTiNoqWJ5z6wt7fhGJNWJQWXqzeq46FnTq2Ikdj5AC3tliUzlbXFNFJ1bk3QJmybea2hUMN1A7puXJ3XsRUTU8Fz9fxoZYIphtXHSxC012Sfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784189; c=relaxed/simple;
	bh=2ueuGTJjvZQYehWC+Maz5Qiz9cZUU7bp5mozKkOwSiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WwFykOvnd5wIuBhr17R/jP93sWxkqu1l4YcJPdOUj75+B4EdZ12mAACgYzdGxN1mw6PJzLpXLgLsgD9ywkNDFhJyM4v0LHXj2nbPfESiwSMAdUWrEZSEkNfUvTHkb3HGmE8mEu8+jqA+SB5SRqC+C2NdVAN3kK2V28fgF+OTmJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DQ4npudt; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYF3ooZ3JSqtUg0pQgAAhawo2KhQ9V6UeCo/oQhjxo3RSw74yHGorQ/RtD7LJXZnd/MKxhgYhNW294xqFPTx9INzff1IV7dJTbU6JQ6zkzkOkHt4Cy5qjqKQ7iI/UCFlBMaa9wouCv1cqYyAJIyJ/4etdT8GkSSiYdEuH4qYqN4txkgoWuw3yxRE+wJL+iz1paVJaq72k/X9W9n7IOdQVfWbD/Rffh5DrQAHQJQG+h009HhbHYkMWWwW+G3YSer+JtR91585Y0VSBaue9vhY9qcg4mZvt2FQVd7/eJ2y+LHuO6c4VME4Tl+d4taD12JOv+8E/pVRI9e26JfnZZmMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FQLHSDVrgdEFEHJ6gzkncGrVOML7jPhWb6lKJ6otSY=;
 b=p8ebTPc7KbPnqiQ1/IWk/H57y/56n9rb4fWvIi/uFmWA0nGSExbs01B7oRYLem9hLVqKeuE4VIdN4xcGZOt4YE3dAsiUhGYZkdILQSoOe6qd6l+0A3vz0A3HzIftrc3TX5ARi5AEKsfQpJpva82bI2NIxCmQmNRqjwegKfIGI3ed7C3FFS6bLG4BMob5IiULbm57oQM+jFI5d3Ff84HeBMCU4L3uzO5mxcScSOQIGbMRfLWRO2P21A3MVm1ztF5FRKjaXtQxz435W1M1AGZoOOwY+plml6tyo8jIG2sRAAFTeo8fcH7sdWwWTjLQoKFhNaRl4VqqMZNwOBzxc9gmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FQLHSDVrgdEFEHJ6gzkncGrVOML7jPhWb6lKJ6otSY=;
 b=DQ4npudtC2jAlTB3I9uOv7T7Ti2UYtcbYDNEA1DZkHBuhSYzVRPXzyGCJEE9Kqez7xFEvet5DfQZSXf/M3K2H2+CKLJyfV/HJ6b4OOozrZA9U9BSplDFUZ2pr7i//zAVQZ+pv8IK9/wk7e02n4OeernlH+d5ymMWIllHOzQmjbm8nDfpPCGC6NmKjayDuiC1d1480dTynZUZTktW7Ffva8XUs7Kg8apq5w64ldHR4CPc619RzRe3AE88hE6xFmMTcJTtxU2+rGvqIbU6o1pkB03C5fi659xmK6k0Evinc9vEqJczlgRVrjZJM8SeQ/97s20XcHCLBneQkwd7lZQo9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA3PR04MB11154.eurprd04.prod.outlook.com (2603:10a6:102:4b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 16:03:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 16:03:04 +0000
Date: Mon, 13 Jan 2025 11:02:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: dwc: layerscape: Use
 syscon_regmap_lookup_by_phandle_args
Message-ID: <Z4U5Ljw+ro3BRHSd@lizhi-Precision-Tower-5810>
References: <20250112-syscon-phandle-args-pci-v1-0-fcb6ebcc0afc@linaro.org>
 <20250112-syscon-phandle-args-pci-v1-2-fcb6ebcc0afc@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112-syscon-phandle-args-pci-v1-2-fcb6ebcc0afc@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA3PR04MB11154:EE_
X-MS-Office365-Filtering-Correlation-Id: 26baf35a-3e28-473b-c6c7-08dd33ebc2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JfptpOIRkA+uBCvSVmPzoCK8ZrRGqleC+BLLUs+gX9jF1ns0DGcuaUocUVz?=
 =?us-ascii?Q?2eDv+PZC/OVpl5Q2U81P5930Vqj3YDaAY8tOfanphbsBY2VEJlmpzBv8cHmP?=
 =?us-ascii?Q?melS1VvO0Ke7w10lnCZOreQi5bxU5NHHdWnWwYg9R8zXT6npKzC9hNr0Bbg9?=
 =?us-ascii?Q?pMx5Q8OOrHBAt6ZkykrdlhzVS6sHEmj9xpFRs3cUtsIO8NZiJJH/6LeAMq1/?=
 =?us-ascii?Q?D0I8jK6EVjrni3Meof5Y/tj9ZY/ukMuyzDhyxnGQmDV3zMDK7GOAw2nSI8Or?=
 =?us-ascii?Q?H2QZ9H/9/1iblvp+fuZeJ96b8ugx+o/C/sfaBEJ1C6kHBBWqR8KBjKyjbiLq?=
 =?us-ascii?Q?cTlsBER31XxF17iAVGc3OHx0baJk2YrynqVnJL7hVcuGZgZ1N2CRVsjSAj1c?=
 =?us-ascii?Q?5ja8eMbgQ2FpzPO2Sce5vW/Cpo9XkZD70cYnhk/rWRBRdO5exwyTYyA8FPtz?=
 =?us-ascii?Q?Zp0pzynCLH/mC93pQQ07y+0LGoR/Vqe9CiwQ7pD3+Tz8JzaR/ipJ5mB6J9Fv?=
 =?us-ascii?Q?+3b3u6K/0UiG+poDg6SLGrOQa+2a0Adyme8QDWYH60EkzZ5QlayRSbzqzKEZ?=
 =?us-ascii?Q?4cchXFXTXjkxzX4o8g3+hxbVHhbKMqgWa/JPOgCq/FgACSJYfXrKwFyuoe/L?=
 =?us-ascii?Q?4g7mUp3+0x1pmWPqVCfxFZTjd8/InU5eq+vE9C7cvJCayAUuwrg7+J9QvARV?=
 =?us-ascii?Q?wtYR017sE8RAXEcseTpYNHrtuLZW5o7xp+l+i/Z9nqUht5p4iWPVESh7CVnz?=
 =?us-ascii?Q?gMpACL6yO2GXSdGWqdK1VDa1/ZwMShudBwLzGK2PI7oWav/29ojYpZrOLz58?=
 =?us-ascii?Q?fniWcR1Oq7MpkLrE+StH1AUVigV1ZhMW+IQPQlkCLEW0GlXiCbvraXJYmWIy?=
 =?us-ascii?Q?RHhxYsJgcZdXiQ3UYrwCjOHDdos7ITiuIBl0L1wtWFAHMrH6ukXESDDMuKMF?=
 =?us-ascii?Q?7mlPl7r/cMfsem71KYrsI3u4RK42+4a0ltnIPumRW/cJDrhsteFcLMwB3lam?=
 =?us-ascii?Q?ZAvwmInzdeglneHtx9vcZQfa8MTQXFVL614i1W7/J4P8ytxYuGjnEOo3EfNa?=
 =?us-ascii?Q?qKSR2PDvkyOiRniko6UMQqjf4+qqApLLSfGW0DoQsjr7XZVkkJf8/+Ky/jj4?=
 =?us-ascii?Q?tr1qh8sHMbugIZoLAgX/ldNlIRl7ojUGriXgdgYrMmEBYVpg86N7XGp7ARJl?=
 =?us-ascii?Q?zXVca87prZ7YUK0IYkF0EzjFycWl6QGmjtig9vxWxezYPUoditAe3BhuM2j1?=
 =?us-ascii?Q?hr/gpMgVmafxAKDOPJWpX4u6lm7vIwwGtZYhpVAYVR2/lgqiJFfubNqdueTC?=
 =?us-ascii?Q?svP7BKys9WKCWn3VRqZrK+88fu0USWRP3obS8lwA4/DvwWdxJmP9pV0t8Vg4?=
 =?us-ascii?Q?dPSelo93wP3qimvJiAMzRqWw+atMxL75KyTLd9yu1dABRETpbBssprMCZLMu?=
 =?us-ascii?Q?ckKILuMlWJByvuapmUFweq30L9la4JXa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlTlACrCmntqRLRLTxnZHzFa8kycloEETAgBIHZAO59TWI5uLQ5Z1KhD27gJ?=
 =?us-ascii?Q?Ocxyn8wBqq9rccck4I/6RirxUfI5wwe+N1DLFuhHuHiepq3lbgk3iQZnkZVe?=
 =?us-ascii?Q?opiTWMXWjhsm1lO5Ps19W113Qt+QJn+wWjGqygv3Y5pAVbtlY/moHz5WnBFu?=
 =?us-ascii?Q?YZOKhhsfA4Y89EXbtjkQ78ISjF+OilK3pbh88H0GHzgm50A/LlHimSIkvh8S?=
 =?us-ascii?Q?5emJK5Reyz7b2gbDLO4ISduIzXfVFLqPCoFRuDi3+IrDaEWPuopUZLmStvXA?=
 =?us-ascii?Q?ZzIfi3yjFUyItowQLeUHUr8zUw6dssF1RLfHTsLZtkOQG+k6+UhcJgWzSjxW?=
 =?us-ascii?Q?BYfHveO1Gp8DoeDjvv4/anMPc9scI7bi55wGamXuVQ1ewLxIqkXSk+LSzfzm?=
 =?us-ascii?Q?bWRAyk8nOB2+gG4tYdqnfR5pA8HwNI9Z+Ptby5eCCBdpR2jNqUZQoUbkQ95w?=
 =?us-ascii?Q?GbRK5mCHt/dHBnMVpjxz9NcVHRyEGgDu/rSI94GqXe+WaGp21SsbgzC2TS3d?=
 =?us-ascii?Q?05yFYw7+7bPn8lSCVDPwLidsgmACS4H77CtqikR08C6vdTRJMDknzwts0dht?=
 =?us-ascii?Q?ln+rZKdJBORXcyOmWQ9hetnG62G3gYfSkbDUneRoMdQmlOahjsBxeBlc2twY?=
 =?us-ascii?Q?xjXSMELRznPiJQYhM+vjn7012688w+Rdvc3yJoTI9SObMdgxrYadHxXirWqx?=
 =?us-ascii?Q?SmUNs4UMwMuejay6pJJUpKDHU7Ih4jcu8+05it2bl0eIiaTkRmBKUECKevrv?=
 =?us-ascii?Q?BUjAnshoYgpHV7XeTTk1LDoOfmw/eqOeq/FMNsGEfYSFx57zP5qOZw1nx+PC?=
 =?us-ascii?Q?WtkcjYKlNtpohvZwHrzK2RlFEJqCQCHe6/QGvvcanIsEb2uQzzc3tMDsG43B?=
 =?us-ascii?Q?IFry/aaofzrt8ID73TWToAZuU48gckz5DfFJVkHZifz8E/xW7+KoWJagrYxE?=
 =?us-ascii?Q?11gQkyll8LBWFtob9D7839GOxEGZ0bRy1igTTD2l8Jxgi9WQeRTAC0K1ukts?=
 =?us-ascii?Q?xTpUmAlXMNMu+l5a0OArW+Ae4cu3aR7AfAMPnBpIJNdCa9zjS39YmzesUQZN?=
 =?us-ascii?Q?rQPCuM1jTsMPPqCuQstRb0lueg0uL6WAdrLDKk/c8lEBrQgoOGob1ZyYm91H?=
 =?us-ascii?Q?m0eQOwG3vzfWxXBIrcg7/KFl8gT2i4NhdeVOg1eT66aQmZjh3XCX/YkMYvov?=
 =?us-ascii?Q?3i4lmviNy3HhfOc1/30hyMYdLRTMPIKc4Y1Rox8VIHgOpjL4FIuLBNeEAMs2?=
 =?us-ascii?Q?bGDgaPKy+AJ4Fhusxdvlbxo5bvj1EHL/3ndRcS30H0PtDNGH3gUJLNV3XV9+?=
 =?us-ascii?Q?hFzrURMfHzQKU7VMWMG3qX7mmyqIgWkfKJVdcZiQokMAytbhKYmYPR+C4BEL?=
 =?us-ascii?Q?WGWZmH0eWwO1ruDkb/drf3ZI5TpAz4sn836VQq7O6fP0lAxIjiNyBd35MDHk?=
 =?us-ascii?Q?Y/1r/xoEnbTn8+fUr77Ra0auNGdL3C/b6V+nuvMCqp2yzSC+2f5/ias67cBn?=
 =?us-ascii?Q?HiSQU/NTUL8uxkO9cPg8YPkS6vJIcou6z1Qe8c39Dow2h9+K1pVijjzMcRvQ?=
 =?us-ascii?Q?rwBSa72uyo7qsqu3wTw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26baf35a-3e28-473b-c6c7-08dd33ebc2ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 16:03:04.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSMtULLRSsxU0kyR0b6ZOlMhbBKFlgONyueiH/yW4brxNNv6zLGPHgE4+xKEnO5qwCNGkrov0U/CqELQzN9nqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11154

On Sun, Jan 12, 2025 at 02:39:03PM +0100, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index ee6f5256813374bdf656bef4f9b96e1b8760d1b5..239a05b36e8e6291b195f1253289af79f4a86d36 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -329,7 +329,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	struct ls_pcie *pcie;
>  	struct resource *dbi_base;
>  	u32 index[2];
> -	int ret;
>
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -355,16 +354,15 @@ static int ls_pcie_probe(struct platform_device *pdev)
>  	pcie->pf_lut_base = pci->dbi_base + pcie->drvdata->pf_lut_off;
>
>  	if (pcie->drvdata->scfg_support) {
> -		pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> +		pcie->scfg =
> +			syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +							     "fsl,pcie-scfg", 2,
> +							     index);
>  		if (IS_ERR(pcie->scfg)) {
>  			dev_err(dev, "No syscfg phandle specified\n");
>  			return PTR_ERR(pcie->scfg);
>  		}
>
> -		ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg", index, 2);
> -		if (ret)
> -			return ret;
> -
>  		pcie->index = index[1];
>  	}
>
>
> --
> 2.43.0
>

