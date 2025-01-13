Return-Path: <linux-pci+bounces-19687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF9A0C262
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 21:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E19169D10
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE71CBE94;
	Mon, 13 Jan 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/JlRYiy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255991C549F;
	Mon, 13 Jan 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798874; cv=fail; b=iUa705uDx5IF+QumABA3YRcElfUKsBlqzmNRg0L46KplquQT8LFlwbzbDM0KfT++RFkg3mLkA9SRq6Vh0y0aQdP5qO6gL+8/+uvXtQeXqW3jvG33ykGQg86a12/ajGw+iwPbYvkOH5IcleUrbGxycgPihblc+9NQYj8Oa+sU8HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798874; c=relaxed/simple;
	bh=yOw0PMvcb0NZrR+cqJeLSpFph9oeADdC7fx3IfoLxBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rW1mNioU/lEcbf3f+S9O5L4KPLPF+swCO2vMMa7RlkjO259dmaoOS8b8C7Eu2B0gdfa7aEbKXg+AaIL51s8h8TB5N4ekBFjxDYnBj/szjHat5Z9Ha7FfAIsAZmo2++uxrIaR0PsysCIs5vg2vV8iUaZEygttg2tIdisw8k4Gy9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/JlRYiy; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFkxtWwx6jrvA7/KzhH6EckcwBI/BPNQp5FDcDsbtztU/wohWWSDHlWPFKz6cOqdps1uqmtJ3eTQ+WgGbYzAOCndS+zgQE6Bs5RA0jq264XFT/TbwZ2ftqw0sj0dHHe4jfcaWXDMLKdU40WOdTGx57xWf1fwX3QcKDOQlXomSAEgPAsIMzCZP+GJ90JukebucidgW9IbDNyns3iWTjBYJwesx9ylsv+o0cBKIdnyg3GfGDQHH07/Gc3aliAAORRsqvkKdxNypQGf201TcBTs7AiE4jMm3Tbwww+Q6MyTOz7X4pIcwhA9YxARdsxswVom3kCTlgf52QzzI7j6XEr77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3qnAQEvHjDSjLydwApgU1/9NHV4GS6bks1NhsNtEhk=;
 b=i3cglf1a6pdAzIkVmZq5fhfucPK84raYAcGgLkrgb5SiyqwcUKkFDsWB/f9c2y9BYowMjNx0c1fbH1xpkYjoQyvm8NKy69qsFsa1j2T0Xw/tVHxC2bpmIY7a+d7t5Aav0YL6NuzYYOy/M1a3bOlgbMakMHj76fqX26XIgsES2JK032rXmzsVDx70MIdLK9X1H3qDJffm42HCla12NkVNjoD4I6Irovhvd3bO1xgausW5VwQyOxzjmInFRX5FTJjE+KGOO+G8TzM+wUD9K1MsRkM3yRYL58h7ruegEfp1Lvc+t6eNrbScZCmv6yJ7IeoddPUunuLwASXEpMHpVQp44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3qnAQEvHjDSjLydwApgU1/9NHV4GS6bks1NhsNtEhk=;
 b=q/JlRYiyGCHgu9W7n2piIv+/DYvF/fk2MQK96g7LKCC7vR8gYZSiOIyyR/vm0Yxa1eGsi0fkwioAFfxJjUYkbZtHl5C948UMfnSaO9iBfN5yaylCt6O4S3RUs+A7TZP6dtkJaguVK69fd7C1xOXOFK/jwh684XXUdGZA3wLi0qVT/zZSfvk0s1jocpJO23xEfFLvuteK5QQ6vcI8KY2AzL9e29uPDbkilfp6hZU5bzAxWGU7/Kkeyc27aXucdMtJxdsw3pgmRiftyd2zmkNCz4UKz+k6J6HdGzFu6DgJjrCu/08aO1wmFivcBTPT1mOvF4l6HNSnvXvJ5beeT6rr/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:07:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 20:07:50 +0000
Date: Mon, 13 Jan 2025 16:07:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250113200749.GW5556@nvidia.com>
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
 <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
X-ClientProxiedBy: MN0P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6b9f5c-ab71-4b6f-aeb0-08dd340df482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/K4Kz7OLvLu3+g3chb6REDW6BJSq1mZ6BDkEeXOkdSXx9uzRdYEgRCAqf/36?=
 =?us-ascii?Q?mMyeR3dsIhdaVqDzgmItC1REP+y+IE2ABSbc6+Ail5drgSjsYYQk4zhfLbcZ?=
 =?us-ascii?Q?G1KtQRmrKWxd6i5uadY3LNwQHiYt6PzuIg+ZN89pP3gzox8CTYubvLsF/9uM?=
 =?us-ascii?Q?9HCvD6naysqdBzZTTl/weVItn5jISycwLnyNLGp1yBw6lrdcdzQmhvSjvivT?=
 =?us-ascii?Q?4fJbESacLiX4z7Ob4nTRS1owmlFVzZl2LLvdZxFh94ueAe91BzeR3P/Otqhp?=
 =?us-ascii?Q?fImogdcteKDvj5zsp1ADroPd4FuEBaYpnMwc79O1DI/yf42StUMDCvyRzA23?=
 =?us-ascii?Q?OItiNzprNisrSNxYAsxc5aJBkjNWqX48T0q9SZ3kRO5z8IYtw6EcwUwGqnUW?=
 =?us-ascii?Q?0X36WYGqSvG7t1hIIjO3vf5nAJFVOJZXAR80+LMBxM5UuGcJnccy0z1S0tTM?=
 =?us-ascii?Q?b9Wfe70UNH3sgQ2AzhYyNk5pEGuUQ8rqAW4+XdFHYon7nr/rz7usc3gAzlXh?=
 =?us-ascii?Q?8utyCBgyP+oJRqNwU09WnrhIMnwCEnMigGFYetLkTGDRtjQmVHip9EVngTCY?=
 =?us-ascii?Q?WAsEhZYCNgI5L1stwrJyM2pA3j64BRoMe0ixLgMRYimR6pHyBxpI1ujqaFXu?=
 =?us-ascii?Q?EsQm9FuzTTi7DPrZgMJFleo8I4pCbVHJ6SbMe/FlVP9kRNuRgFa/evDMgoMG?=
 =?us-ascii?Q?9DqrcOVm18BAFi3l7i6nQFj/43kTnKWSxeQtjhlSOgzd80hY9tw0C0pvRt4S?=
 =?us-ascii?Q?HrcW3yM3sZ2Hlin2kQE4vzLGhNzPfekRv35gDqOnbQqtp9NdXEHJewr/Rle5?=
 =?us-ascii?Q?WDBsztI7V0MM+f372x6BUjB1tC6xioBdFzrFQmNM6o2avzsJwA7W73WWEecx?=
 =?us-ascii?Q?rj48SPJuiBLiMG8Nuuj29BamowpkTDGW90XJPxdchmc+jdyBusMOi4oYdf/T?=
 =?us-ascii?Q?pCv1Het4x5fVa0Jker3hHIorP2i8e0mZZriGfGA4uwgzdQGQvD7asdBy587E?=
 =?us-ascii?Q?UH4Pm73E/LLH+QwFjUaK7OJJc+Ny4S7ET3xkxE4g7I+G8tfkhxx/rsOWpPLC?=
 =?us-ascii?Q?xFleG2pcYkWz0mtM8F+rggHRngssipsNWy1WNmUk9DrTvddBU4vSfhpJSQfu?=
 =?us-ascii?Q?aYW6IDmRx9QKhAp1hE9L3YXzuC/8bEtFMbchfso3T44wYYigBeyQkKp5A1ka?=
 =?us-ascii?Q?tVXLcolLlAqIeOdHx5dIm2WaFSp+n/0ciDnwlh90bF6ysuXHaut3u4XnJH+Y?=
 =?us-ascii?Q?oW4FMMpdgnenV6O//wcgL/UR/Gxu3/21QyUICDajTiJi1TYp0PkB/5IkJg0t?=
 =?us-ascii?Q?cgK9TzHb1isP9IdVOdlclqMMe9CEZibi6QH7unHsvpuV1NWdf7l9GILKnToL?=
 =?us-ascii?Q?bU+KSmfCPGVoR0zfb55B+hCVhzd1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q13Jc5gzu0wqYUVV2IBifFP/Vc/x1KYUxY1VrGJ90zW8JpQLoBB4eNxSZFYz?=
 =?us-ascii?Q?KWdl86T4Bjx7lBohENdIVHWUENQbGLPIQZBbMvzKkQZKpyGlS0+eopbKwY/E?=
 =?us-ascii?Q?lzaYjeiynZTy6C1S/UbgDZEURushbjSJ6JZDs1c6x/BrHK6wY5TeAM0/03fZ?=
 =?us-ascii?Q?l/Z9cC3SYkChWnPwJNwiNKKimVvrpM4NOz/Ay3rqVooVOSewd1HfM7wwtfaK?=
 =?us-ascii?Q?unHF+7b4RvTDjD8CnjGkW0rOlW9TCdeJd2jhQ/UP6F+IsYH9ozAa4zoFnQ9d?=
 =?us-ascii?Q?DRdJm2lnREupWGHS13Nqe0HB8Y/Mu5BgvKyzMYnMgLuE9neWuf5KKv1/9nzu?=
 =?us-ascii?Q?HN5HWRswfWnbZpaGI0ZS/YtlaVlFA02n9y2cqqEEsF+Q0NJ7StkHtQsOZ99b?=
 =?us-ascii?Q?agCszNi0LVOqn8K+icoBvlaoUeKV8ocdRB2yLyaELlqafcIzJcerCwmsbH+M?=
 =?us-ascii?Q?FDCC28lLirXyNdfzxvdBsDVL+Uhn5NaYWv7jlRl0cXjgD5uxK7E/lBK2w9s7?=
 =?us-ascii?Q?teP3otwUt011UIYbA8TyK+IEogUQdUrKtH3c9E+CCxV4v1cQMogCinNXHhMx?=
 =?us-ascii?Q?tdGBMORDBwtKkT5+6NU6NTJuvwlVK72m54di0BlxIPnOUFaZRBUqX48b8WD0?=
 =?us-ascii?Q?PGM5IUhnBxkojD+hJX/4lOVSlXFNQDFnT/ZZ9tTJ1W2DcboLHMrch3XAaW48?=
 =?us-ascii?Q?uN6P63rzYtcCRDFB9rizHmWyFDDrs1KWYX/IbOjQtl+QlCDw3043RB+/KWiu?=
 =?us-ascii?Q?FP5Nb9F1iO51EVMNwe5rIIm02MLAQAl6sJwjIsivrZSgp1PLisQp3WNe0I2g?=
 =?us-ascii?Q?gMZgbQLAz+Aa2pihZEUrY9vnXRYh9Sqb5WeXjqkSfXY2sHX1TvePBFrvP63Y?=
 =?us-ascii?Q?MIUys19eHL0r+QDFsEEHWJTbUwj7zpusjfZC+QwXY3gK2q8REUthqXjOUMpz?=
 =?us-ascii?Q?MJKecBn8HOX4ZbuNpOmgSI2Y+zS6AIXaxE1WuOx7wpPAvon0/HuwCH2PbW60?=
 =?us-ascii?Q?xRXu8iOcKbpNYGNAQprtfESMQ+h8QypqnHXTCyayHIMXcAxs5DtIzKjt/tl+?=
 =?us-ascii?Q?6GhB1J7Vgp8foY3V9UgibYMs8RCN1CN7UhaMcj33Gq7CeeTnef1HkvfwyyYU?=
 =?us-ascii?Q?nDAR7nIZi+hg3M0nAFf5H+panq3sg74X9/KjpJ5oj5fnwJK1aLdAlyDiTY8S?=
 =?us-ascii?Q?sbq12rAf+/YAJsPeRA3oQEivE2TahX1NmceyuC+UTugaGya7Yuam6dbcRAKM?=
 =?us-ascii?Q?3kpe4f9MPok3giO+Deic+SAih65hlun+SP27/zP10aVbvyvljTUQpYTgaMN8?=
 =?us-ascii?Q?G7yn1OGGHYJWNvVkJyfnSFDQZZX8cXTyv7bU1vNigRFPQyM+gTTGjte/NvUN?=
 =?us-ascii?Q?0p63guCX2wJcrcCAnlbFms3AXqPKPOHe29Lel3iRIOu1dVciyWBjwx2A+oNH?=
 =?us-ascii?Q?QM6M72aY6XU+4DJXXu0PpatfiAi60m6lVk3dq/PaLxV1Ztp/PckBDDN+SRS5?=
 =?us-ascii?Q?/9ri2FlP1rREnzaPdeRlo/txYB3SA6QbLkFrhEZiQI4BUC59cwD5XwaWJpyP?=
 =?us-ascii?Q?GZu5ZnrMYaJ8l9NwNfu4BlY5zCNm2Cdr2jrzz/fR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6b9f5c-ab71-4b6f-aeb0-08dd340df482
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:07:49.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwOA/2gEeJaTRUot/n8T3baMMAYV8bzzRrHW/6odZs+oBVr9MhoA7XglsTz3+RsL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

On Wed, Jan 08, 2025 at 07:13:34PM -0800, Tushar Dave wrote:
> > Yes, but X in config_acs should copy the FW value not the value
> > modified by disable_acs_redir_param
> 
> I see your point. In that case (for the last hunk in my patch) something
> like this should work IMO.
> 
> -       /* If mask is 0 then we copy the bit from the firmware setting. */
> -       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> -       caps->ctrl |= flags;
> +       /* For unchanged ACS bits 'x' or 'X', copy the bits from the
> firmware setting. */
> +        if (!acs_mask)
> +                caps->ctrl = caps->fw_ctrl;
> +
> +       caps->ctrl &= ~mask;
> +       caps->ctrl |= (flags & mask);
> 
> Wish I can have better condition check instead of 'if (!acs_mask)' but let
> me know your thoughts.

It should be per-bit surely? I think the original logic was the right
idea, just the bit logic had the wrong operators..

Jason

