Return-Path: <linux-pci+bounces-5892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0589CB8E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B053A1F236CF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6AF1E532;
	Mon,  8 Apr 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZysvCVlW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B91448C6;
	Mon,  8 Apr 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600200; cv=fail; b=cjqLIJt26QmpGZJWAEzFAiLe1mGyPZG5Z6Qlg3hNd8xsDUCxNEcx8lnhFzZhr3yZPD49WmCvejekrG+HhZPrB/3c3CU0/piAVMPP2s1Xj8INeXoYTxy0J57+4xLPycQFSRb9GOhrXtLLYTVkrvn0nCL804hJhtvSdFOaoLmZJ6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600200; c=relaxed/simple;
	bh=sLO5EPVNn0/oR4yxExWZWMKmvSWp+8bCMJ8AUSW9ajw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C0AySqiRZYuvWd+dHqjINL+wClozOoYNMk6ig762TVm33gKfQgRTeieHaMduBxK3G9VFhalbXX6rhFKJXnWHegAsJDfa6YHTzzM7R5WVQ1+pHU3mt8Vnebf7CuRAymmH9f4IImNX1TQMmuNTlC+uCBTSrMVxPMvb32+zqsedVC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZysvCVlW; arc=fail smtp.client-ip=40.107.244.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpCeNV8g8LlDGwEYRra81rVHX3T8H05qSvp5xmmS5Gkexkzdq3vsnmEbqZLs5bivvZNjKtPn4jksa2CsGGzoDlN2soB+Y23cnceiqSdGCYbLzgVouH9ljtbUyVSLMJ1kLrkU4oB2JHLoTEZGckS1Oqb7elMoGZEldG07r2JIVi2Q/ekTsGiLeQH4qefodpXAQ2nj+w04Xl8iZBtCVRU0jrolEm+czhoL91j+luBQgOh8VvA+LchOZlXR/PhPHNFgqD/frLnJo3zgkBjuXjuvNSweXs/tIS6FwS5R+MuQbsuNhdj5Jeo36Ua2UyvlY41F85e/7oGyy6RIYD3bR06dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvV45FYbk4/O/xysfb2BRMtcVIu6YjRTFw0bY1nfEhE=;
 b=Hrd7B0dE8FEvJx6qci54V/G2OereyK72njvLYoTl2oEmZeaRqzTbiAZ5sReb6z5N0ZgEwS/WpEG+l+kbtn8YJ9xNIZ0s+WmaOdtej+3YF+DGT+ujuj/adGnL56EQnnUiIACeR4O19s7ax8C3wD23UtFttBDkDL8jnubQ3S3MXbqXbmIqz7kYfvzzP4V55yR3GXM4JCxnCr22e4BSGy9GJetqWGWSvxO5spvjBakfDHw+bVfw6ZyyosmEXQT7iC9liVcPdiJzAOOECWMB0u4lMF7nfp9PhGnITAxfbRKoTp12ot6davaPpO+/kDdEnP8Gy5rjKoogd4goOXzUHMDV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvV45FYbk4/O/xysfb2BRMtcVIu6YjRTFw0bY1nfEhE=;
 b=ZysvCVlW2shFYvEHAbcfimHD08xLMnpkQ4XqAJXa8vG/9wqBL9T9RctsulD49RKGweE3sW9MLd9POcUbPntCC6sAEp7EtuTA7bIumTtzmKwKNy3mEUq9Ll3I4dMoNDuc/9XcJLhaG9YWF728JhrEaEKN5dd/INDpAyiSQzSzk1WDmV42EaYmjV3cYuuoSw66NHGphx9IlaMLwsisZup3C3TxL+pYbRBo0bqYJij7ddT4MQe0WcFMJ9w0qn22RvPo9MNb+6NH4+0r/4SML4+acF8jWOFoTytPZLbn5/jT9VY5x2WZCweqehjk9Kxqf4sSS7oO2Ap9p5jbJPiRiCTZkg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Mon, 8 Apr
 2024 18:16:36 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 18:16:36 +0000
Date: Mon, 8 Apr 2024 15:16:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240408181634.GR5383@nvidia.com>
References: <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB7353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQ9V8gXDcSDGx8j/hlEh6kGzfZIcWWcYpx4CIvVLw79wA5kpwGWyHeKJEe+zhkCHC4ZHmQ+/IWsoceZflMsd6MMy4ee+sPax5nPlhsYuvoHA+XAG69tLrptHUtZXQgE133gN/+KultV2uGyWbdSFrt9uMQIJvBGhtFQjBGWBmdw6tqjF5LCodpuckzsUBlTeXn/m2+xqL7bjZMzQFQry4CGN3GnxOsu8sI0270jB331oVhyebGJcEf74azjRhk/ZczzgO/UYsZ6ZM7WLmWFX4D1cFpIlgal9xOgLCGo18OaBuAB/kgHAUBk28plpazhAy4Xz13OGPnF64yq2Mc3aexQdZsCb1+ZCTpmJCCxUYOKuac98iSPtq4RW6yZptwTmsqS+VizuOA2d/HQ3ysxJb5Njm1tguSgwoQdrD/NZZo0fKSPT3eq1eGK8fCPqSagZ7kZz25WiI5DMgK0SsUM4uy5GWGOHab0b+02E/bxFb5pnyWMWw4WJWeIUvtWoctDybeuPmWXhiloTQsH7izi3fo4S2iyB5AMHC9FekQo0xlwQC+ADFLiBQlKGORvEObjaCRqlo053vt3+CMd2DTAu8Plb9MQKeIOOd5PbJ7esAf10Edck2go0VV+QSuQKSv6puYjKgkkFxMxWOIq5MIcos3UHaTq5yr0Lb+WXMKSvKR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFOi+IpMMEh3GcnsxeZyFFFKL4odgnEjXHYIoz80Ok63+UICKu2KPQX1n3XI?=
 =?us-ascii?Q?3PZuKtAxDoTsgXLlmTOmMejUPzgPJ29GIyXYWcq6ydSpzswTA93UhsOxKQAR?=
 =?us-ascii?Q?/bMy40tPSkdBKIWIbPX+hEaeh9fnFXJNjW8I1pmo0YsubGOn/U78NyprQpH3?=
 =?us-ascii?Q?rQOYft+hGI0qs+J+Sr17JKHKsDaSU5/ZaBMdxSe4MRsZVDlHT2cO9F23ZiNo?=
 =?us-ascii?Q?9pSwFudV4uoEew7egdzxHK1w9pXGFNG7Und1vg8eKZrhxwrYLYkSFs/tmiuO?=
 =?us-ascii?Q?JpBUXRpwo8Ez84NiQFITAASlbW3uemH2cUxlrsXiu2m9l6eLcxI74dxEaL2A?=
 =?us-ascii?Q?R2A6e+kGuWhHk82hn/LeLnuRH9/Bdj5cq1ugo3sitOHZfuPz3o/v53EH1tbT?=
 =?us-ascii?Q?/FICbytJofpUXsO1b/bmn5h8qdhYPSQLmhN8uXz4RWYj2TEeMYiGN6sHz/i3?=
 =?us-ascii?Q?E+e1O46kQS7oDqyJ15V/N9N2ES3V8DAHGkO9iXsVPyV5/CuN6IzyyB72LfWN?=
 =?us-ascii?Q?WARgV4PU26jjnMI3tSSAZTq0NlPV0DlgF0QclYM/N6407xjZCn4+g49pj701?=
 =?us-ascii?Q?y+fkkU23EA+4KQ4KOvgIMEvePDYHWXNATx2DAIb9dkFwJbUuazptnqor0CAG?=
 =?us-ascii?Q?8r8heFNwuVgELBoyZTKLU1GdF9iQnzvEUdCKXUenWDKvRUPzekkGtsI+n408?=
 =?us-ascii?Q?x/yUXPsBAdM/OEs+hLBVE2dF3lfvjS3J2p1fQXY3gYOzo0e6s2nryT8HudAr?=
 =?us-ascii?Q?3c2E0DAovt94PIH8b/JioNhfUfki7bEY3h7jGHeAFvDHJE3fHWk9dqCgNVbP?=
 =?us-ascii?Q?bkhUA/yV0cq4PumN7y5YsqWIWfUVnfLMKMofwszgfQbdy61eIv5cPIXJYWdD?=
 =?us-ascii?Q?rC19Fyz+N2nMI0ngH5CZz0UKOJLrNCQ8CoQjrGBWfFyoIiCyPhqZ3ovE+NHx?=
 =?us-ascii?Q?IGegzFKyyIMDsVEZxUUHrF0KKFw0YDpP81BbtTiGiEaVu8xB+KJlgXaJDuVM?=
 =?us-ascii?Q?+OQPmKQCe4ZOGfDpMnrbZCtKYpTLVpClX2MxZH8YhiE673QidPePw0Hp41HJ?=
 =?us-ascii?Q?xYW7FmJ/ZaV9128Ja6loF3FeP9uhdsPE7uEC63KnPEgwkYaCPldUk+rP0YrJ?=
 =?us-ascii?Q?Fc3iG+C1GIzHxN92YXbvGSR/oiCIdMC4QAYAHCRGWYp5elcCLsUcNZkJ7ljI?=
 =?us-ascii?Q?ZXfVqfOpgXHYG/gxiA8Vhfe/UeJi4IepTKwuHikZUNdCpVblaR6+1ikTSoWM?=
 =?us-ascii?Q?f5Z/jQcUReoYMW1gUSODmLPad5EKgcNI43VWqSDpcbepl14XsyvasKrHqEOV?=
 =?us-ascii?Q?WRV4fOCpb+KmZGS8opRjtMLK1wk31a49ZHsXFUo5n1U+6qNJj5b2e+J3Nurz?=
 =?us-ascii?Q?zsXcGwjLCX2FyTgd/Ngu2zOjWsRiP5a27uOHpD/k3TdFl0knzIrfP6TKlbew?=
 =?us-ascii?Q?+Swd88+Ver8zV/BQc8MZOHLLVrbwhN02FHrgNxkBFbFhXaYIMnKKnKi3Sbyz?=
 =?us-ascii?Q?XBly31wb7tE4JQg72tzx9HE51Pieg9xVZ2UYQMW1u//ZZ0mqA5tNKgI/M1+Y?=
 =?us-ascii?Q?eJZQ3/axV+VqPOhCcw9N6ybwR4fJv3Ua86V8aXpQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979c2f8-8fcb-4953-b70e-08dc57f80703
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 18:16:36.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jFdoSYKamTJx+pZzV6fqTdzwUYmoJIVV69de6ssLZLhdLQu4WxJojG3ojdMJ4DD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

On Mon, Apr 08, 2024 at 08:46:35AM -0700, Alexander Duyck wrote:

> Really? So would you be making the same argument if it was
> Nvidia/Mellanox pushing the driver and they were exclusively making it
> just for Meta, Google, or some other big cloud provider? 

At least I would, yes.

> I suspect not. If nothing else they likely wouldn't disclose the
> plan for exclusive sales to get around this sort of thing. The fact
> is I know many of the vendors make proprietary spins of their
> firmware and hardware for specific customers. The way I see it this
> patchset is being rejected as I was too honest about the general
> plan and use case for it.

Regrettably this does happen quietly in the kernel. If you know the
right behind the scenes stuff you can start to be aware. That doesn't
mean it is aligned with community values or should be done/encouraged.

> This is what I am getting at. It just seems like we are playing games
> with semantics where if it is a vendor making the arrangement then it
> is okay for them to make hardware that is inaccessible to most, but if
> it is Meta then somehow it isn't.

With Meta it is obvious what is happening, and what is benefiting. If
a COTS vendor does it then we have to take a leap of faith a unique
feature will have wider applications - and many would require to see
an open source userspace to boot strap that. I don't think we always
get it right. Value judgements are often a bit murky like that.

Jason

