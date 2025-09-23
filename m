Return-Path: <linux-pci+bounces-36785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADAB96D40
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7B61885AD9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A41B423C;
	Tue, 23 Sep 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lBpPD+AK"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF511EE7B7;
	Tue, 23 Sep 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644935; cv=fail; b=O9mrVfYFsu6GKRzZogKVO0D+VnP8P+z73lZnw4OlGoH8pSTr6I7vjs84xZQzT5kr29gaJAraG4Sd9IS+Liv4i5vfKJDCpk8ekoWwOWeGAXjUl8Lxy41cv3XjJC6KguWN9gSgZnbmBfJnifiObdiTAvIK9Hwts7Nym8bGBYci4qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644935; c=relaxed/simple;
	bh=cGCS7qeFKJ/cprG2nTRMkPEQ277qSZnqyfpf5IZD6/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tqNpvcUyhfrjYK2G2//44fBsam79GdR1QuCMyqn7GPVvbW/WSxZtAyZk6/TEpUtVBRgKA1/Wo0h+V3LESsLK/ehqUiwQyn9mFH5JgUPxBxcsMrnoAAAVPS/jym8FE5pGPOVZGuYc61GhMpy5VpBnVnYr/+zK5PUmChMYJvaY95c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lBpPD+AK; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yheWybgD8rT8p6TC1PBEAoCV6p4CogXT79gvlECxBrNdn8Pg9Xiw8oMzDuRmEky2xvneZ9uy4xKLFboO7iFSpUKEcdkmJVHORAZFdqO1ERrw6OjrUI/l644dgrg/ftPilbsEJplMiUHtm3snUTH3i9sEXtlAzWKa3O/9Bt6ozRsqnxxXByg7UIY58AmmXcvS4pHukH0rrL4JlyYhtk1pYnX/kuANWTuB7a5R+oSlBkRdP2X+pPk3OUbilqGA8zcnGJkF/i0o08VS9fgjtTnMutzMVKzHtuGTqeIfFlOFsADfmjQrQktHS5ofX+J5k2NxQulXAgR+5kErqwQZ8MLHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsYxvz2II/eweHhZiCA168g+ln5MQ4HSm6E59uyBFrI=;
 b=byL8jmesakQSn8fcSiIHFeIf08ZiuVb3gyOjo869upBrSWcBuwT7R8L9sCZbqDbIGUoHWWJo/AKVoGWyVL/HC7QtnFeBV7xALsxZ9OMasahKiuniyYyaP/NSQt9oGF+TzsLtVwiga0B0kxY+jmdJgFAM4ne0lnNLDLAAEMIq2QzFVfHFDU/FuYvrHypqCBwQx/W+/L6TCbhYPza483ve1YgvFNOI51wKqlYxXw5uW5Ej5GMXdpWRtxatlFpoSlN2HJ+ax+Y6VHWkM9YKfQODTIYJawx8W6uxvtfj+7272ddjx4wMSXaLnThOFQAoiWNehLh4SB1b6vEGr8HSr1K8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsYxvz2II/eweHhZiCA168g+ln5MQ4HSm6E59uyBFrI=;
 b=lBpPD+AKdkmKxMsdwtZGNoV4PxOag61InWV74LfIIc8aeiWEo/OpuRXoUTD6sNujAHUSzpWfWYpwzllEpu43oKahAvwbeHBVw1mzmD4dNDCpVCcYlp8c3rSktN1+ZHuVER+V6kjalXtQKTkSxdzoNEYleNwcH/iSwgL81WTXURmhILYb/UMkuo2tua/UBzOd+uW612U8lNWBNo/C8iRuXNNAzSXDrIFysqXN4bxA6bvzbGXprlJxaDsoOsUsvDLNf2WL1dxB3VizypLD4YSUwe4WJf8XIHHgBmzL0lHxefPzcz0xuWLyM5J9Pul0D/rLQdTdmNsjVwSun+YqJgzVvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 16:28:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 16:28:49 +0000
Date: Tue, 23 Sep 2025 12:28:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <aNLKtDXCp19M7ft6@lizhi-Precision-Tower-5810>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <aM2HMOvksD0kSd1u@lizhi-Precision-Tower-5810>
 <CAKfTPtDadioUFDn2F5gJ59tYJD2owVZMZs9TNUBHk-2uuz0GmQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDadioUFDn2F5gJ59tYJD2owVZMZs9TNUBHk-2uuz0GmQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 7406ce46-7d6c-4267-a06a-08ddfabe4634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jaP/cv4yZ11DMfbyoDYvro6UMw9DJhhVHDrX3S7MjeXBdv+ETyE1npkI1MHQ?=
 =?us-ascii?Q?qhglSkJJiMmKk02co/1A5T4vzlFkMxCP4OdANQvozxs9T0J7NZY8Yjrz21LT?=
 =?us-ascii?Q?Sk0loa6tTKm8SjIE5KmySJH6m/c/SfgzkS4t9pAtkyBVrfRM21XvQCE4kVma?=
 =?us-ascii?Q?tVdcn+qwEmWfMmvTsLbbaMUVWe8J8ovxoaVx4A/qk3ez8mOVXiLcMeT8Zq6M?=
 =?us-ascii?Q?A3cN0nuAUi+EpiaoDn0Kuk/IV4+6tJIKV90wLLZCFegHOqeFh2JtQxunxW2U?=
 =?us-ascii?Q?z8M8ITwjRoHfnrftvSX+IB6THdQpx2wqmqXsys8l5dZPcp7HyEEWGRmObZQa?=
 =?us-ascii?Q?lu4/K+06pNYQ90NKO0Y3kDb/n7cCbTc2nfS2//kypgEQ0u1YJhIFonVauG8I?=
 =?us-ascii?Q?K50ap9QG3ZsIfHYoKnvbJcTlyuX23An9XPQaqNBzGj5n9bR0unppEqzykTla?=
 =?us-ascii?Q?99fQfh0klCL+/OOIJNxDrrHUyZxz8ri8mPF9tEoMwr+QNGDvrUtBjHSeWbcI?=
 =?us-ascii?Q?r7RX0RvlAdfTYSUaHbv5aL+r6yV4zb6Jhvn5mN1o1BgNHFqlGIg4ewVzWMIQ?=
 =?us-ascii?Q?YibycH+Khy4C+mfRH2J0rFdKZ1I56Oy7lqaBGJCkg2s6m00RT8Jo6o8zujhF?=
 =?us-ascii?Q?8yzsMHhcCjAq7kgXsUbBLDhaZmf71p9PPQKc7wa6Q/8FVDFrzntgrRXYuXRT?=
 =?us-ascii?Q?71gIAhZn+fe5fo3TwscM2S8EvJo7YcILdi9qAwd4Ru1dN9gwp2Kt77r4UWhP?=
 =?us-ascii?Q?Z1DsvYCP0L+/8gl/b8oMnO2gn3heeVUVjCsW75WWr5lhEXBxH1IRa0U+xaDo?=
 =?us-ascii?Q?fVpqQTmgkZnUwMQ8qgoa1AukiM9tL7c0FSV9p1o6NgVYHzs7IzRQC/1tPr6G?=
 =?us-ascii?Q?UhmufZDjILxGZ97OnEIcLKs2ukMw7lrO8cyaWcwfXqDPAWlHz4OdORfsEjmg?=
 =?us-ascii?Q?wgfyAXJtRHBQ2cxK0+Ayx4hyMEy3SDfomaQzZc6BqPYkYQxERLufTa9Ljy0B?=
 =?us-ascii?Q?NUOLV7xjCO7ujnfSE6DcDhzOm8XUxigJIrR4LQafqiNiUjkyHZN1oy6iwBwT?=
 =?us-ascii?Q?joPEQHUSeugUtP6ehUYj0qHlkkOywp/FDUL4vG0Xg5kUPRIRa+rh07659Ord?=
 =?us-ascii?Q?ilLskIJGIyXij3+0mISnx5t8q1cVZXHDCkMaakBmSeUL8i7fOOAe3dIr/zrO?=
 =?us-ascii?Q?CQXVRsx1tNS6EEX4volZl6cBkXSNohFM5mvuxsqaOh1UnQ2wogz+gXi+vN5n?=
 =?us-ascii?Q?kk0CNGP7k86AT+3WLVMTvqkh9Ww5P0hNfqYN2GJQDmcldxBK/W2wNo1kOaHH?=
 =?us-ascii?Q?7eZRmvGeUHH3P1V028xSuSGGXMIaT/m6g0Rv7gj9zNCqTBiZGWbgtH2ET+vk?=
 =?us-ascii?Q?/V24E9OtGv4zHI8VF6BCZULw6lzZbUN0a8xKcaueu0joLsGF8qGNazP8pgtS?=
 =?us-ascii?Q?VTEdMeVAGyiE2cntMODLo9y8FdlXxRqWwSEyo0PFoeSmfXgikYIYMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Var62PIFzqQQX+aTkt8PQZSu++mOQqE5UlyDi9uRLf/UTEElvWe/oxArMJ+9?=
 =?us-ascii?Q?FLc3MRy5rGN81yXHU7Mj32iMaw+GaWTyre3cT+e4Cb3D5kQzFtF4WDe2LagJ?=
 =?us-ascii?Q?yF7+O2DM5d7RbooDs8KRcP78u0a5Z0tzHYvudGP6sNYAjZ9usipAga2D9uiQ?=
 =?us-ascii?Q?DaULVgGfgoHpPjLFYXVRx2CyVpKpSFkYtMbuTPo01LNqzrg8aUdE13pnK2Ko?=
 =?us-ascii?Q?kT0DbC5vlFD622NtKU65Drp2SF4TuLXC5MnP8hLD16viyHHhYhHZmdJnQZ/9?=
 =?us-ascii?Q?h7HYAYUfgnHVg6gQO7Gi3MqS77JiPlEc0qX0JnLfqyc8oenMCXPr4sBEZe4i?=
 =?us-ascii?Q?nrh6d8NkkSs6QtJOY3aUqJaN85K8YY3nxBtzNsnB2F60MN3dHLJUjOnyUQX+?=
 =?us-ascii?Q?5i+zNLsXDuYj7W+jIgpQBiqP7iTB8tHbGx5bUxsjOaI9/4vZkWB/hv4a29JJ?=
 =?us-ascii?Q?heM54j5I8dfOc03jEHmU/Yw/o38OuRitqrn8VF4+BEMggzv8XGmo4JEJqwwx?=
 =?us-ascii?Q?t+3a5GQrObKRgOyFS8be4RVbi91eoOG0hpn8h73rO252HSo9oxHPtTM0D8K6?=
 =?us-ascii?Q?yd5uuh/hMUx/wjkVvF2cuc2H3z5CWUA+pQ0ElCOSDjuWGKsriwtxHtOK2kyG?=
 =?us-ascii?Q?00GjBTTG5yA1o+SPSkO0N5Lt0LPo2re3PbfG6DwuH125vy70H3weI1jLOkaa?=
 =?us-ascii?Q?/yLt2veGFNjkaRcpjOdU11udqa7GyDzEEOB5Hn/Go73pj3ycLbMoH3BS1e75?=
 =?us-ascii?Q?c0TkWNrPaodUZHBwELLZ26yMtAmLaW/XRnYF9+9C2kH9iBb463Qh8Kt/lROG?=
 =?us-ascii?Q?fnB//P+CwszpLKX+aGpxjFVLdsuOjdcI0FkQRpisPqQhnh3cCKl+VgM4ExdR?=
 =?us-ascii?Q?o8WCtjlX2N69O1gL1Slb58acEDlIw+u4F5HuDGil3LMDAYDkTTLWI5QonV5e?=
 =?us-ascii?Q?Dm2RUY6D4ukqdz0QxUzZe+Kw4XpmjkT6qUlFx+B7Rl/I5rTi714UIgbMHPN/?=
 =?us-ascii?Q?TrqLC30XBXjZd3b/gZbq5s6gHvDmK8l80cfu8HjVu6Yubmj9nyGbEpMqi4A2?=
 =?us-ascii?Q?Z80lsGt8mfjKzNIaFzPvrfJ0NoRkfLamChCyKSVsB5J2emfUYCOB9W7tZfOo?=
 =?us-ascii?Q?kEg/35Sun4neFUZFh3D9M4Wt+EVFv6C6oEij20h4vfHQ+whqORrVJXcDEtHP?=
 =?us-ascii?Q?Tpj60J8VEOUbe+mb6dSlDKBBAiIuQC2IAsVxRcGjWmMcXiKaRON7/CckV/l3?=
 =?us-ascii?Q?9vUqFQW/kBQeXuC9vri4lzTrMkg/tYJICm6WZG4cspHYiEvZtyRevREOoMan?=
 =?us-ascii?Q?gpuK97vdpH8ZFwjsX/+80KvGCr7A0QyrJcbGTBvlemcRSogmrfXvd/dWDw3u?=
 =?us-ascii?Q?DviybrCaKOtuSJrWK5c0v9OITXEw9D/wlaFhUj05QN8gFcvY7Kuw+zslukEf?=
 =?us-ascii?Q?4YA7E+bsWqZJ+ORcIX8cQeW+XaP716Vl/iMXcI65/GyP2W2HQ3uELRcETw2U?=
 =?us-ascii?Q?ssAl4zN62mpy7UvyQQj9ic3UVFjmeH0UjB5K1K1k9UnVLu9E3Ib3qX0Kpuee?=
 =?us-ascii?Q?788S34P3pauZ9iCu7pksQ6LCX9K9WgDggf2uJ2Qz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7406ce46-7d6c-4267-a06a-08ddfabe4634
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 16:28:48.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pD0PYL2sM5kYjfGsTcZZJW425FTo5dV7qMLB4gEzRo5WMa8mHJuD3RKnDc3bbGt3vDtnrW68wHNTXnwULbQz+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

On Tue, Sep 23, 2025 at 04:49:13PM +0200, Vincent Guittot wrote:
> On Fri, 19 Sept 2025 at 18:39, Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Fri, Sep 19, 2025 at 05:58:19PM +0200, Vincent Guittot wrote:
> > > Describe the PCIe controller available on the S32G platforms.
> > >
> > > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > > Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > > Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > ...
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - ranges
> > > +  - phys
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> >
> > why not snps,dw-pcie.yaml?
>
> dt binding check reports a number errors and warnings with snps,dw-pcie.yaml.
> In addition to the reg and irq names which I can't all map on the
> snps,dw-pcie.yaml, it reports unevaluated properties which I don't
> have with schemas/pci/pci-bus.yaml
>

Then you need update snps,dw-pcie.yaml, match as much as possible what
defined in snps,dw-pcie.yaml, which try to avoid every vendor define their
difference names.

Frank

>
>
> >
> > Frank
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/phy/phy.h>
> > > +
> > > +    bus {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        pcie@40400000 {
> > > +            compatible = "nxp,s32g3-pcie",
> > > +                         "nxp,s32g2-pcie";
> > > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > > +                  /*
> > > +                   * RC configuration space, 4KB each for cfg0 and cfg1
> > > +                   * at the end of the outbound memory map
> > > +                   */
> > > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > > +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > > +                        "config", "addr_space";
> > > +            dma-coherent;
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +            device_type = "pci";
> > > +            ranges =
> > > +                  /*
> > > +                   * downstream I/O, 64KB and aligned naturally just
> > > +                   * before the config space to minimize fragmentation
> > > +                   */
> > > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > > +                  /*
> > > +                   * non-prefetchable memory, with best case size and
> > > +                   * alignment
> > > +                   */
> > > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > > +
> > > +            bus-range = <0x0 0xff>;
> > > +            interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > > +                          <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "link-req-stat", "dma", "msi",
> > > +                              "phy-link-down", "phy-link-up", "misc",
> > > +                              "pcs", "tlp-req-no-comp";
> > > +            #interrupt-cells = <1>;
> > > +            interrupt-map-mask = <0 0 0 0x7>;
> > > +            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> > > +                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> > > +                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> > > +                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > +        };
> > > +    };
> > > --
> > > 2.43.0
> > >

