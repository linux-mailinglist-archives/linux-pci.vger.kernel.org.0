Return-Path: <linux-pci+bounces-19027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D469FC297
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 22:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CBE1883EF8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC714901B;
	Tue, 24 Dec 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dl5/t7GH"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021097.outbound.protection.outlook.com [52.101.100.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07A18AE2;
	Tue, 24 Dec 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735077220; cv=fail; b=nSsZfP4HqdMqFo0OJ6P+xZWCTMARbieuapLKX0h0gOAO2Swq0kgY669M2ioe5Q/BiYmDGtEP/+UeEffN63fWNDv1qbr283Xq1vM4h2v7sT7A7vOijJut6o9xo6gC9DNPbzvPnFBsuDJK5C7JJpLtpfN0qKru/khnmT+UKRKafwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735077220; c=relaxed/simple;
	bh=Uvo5D9vCD/VIaBqRWjG89sIXVktAyNPStPOkyfYZjKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZ8ULp1cDyg8JPu29WINsWUWoEpcec2cF1Rvf53IKVvrLX4fietbnlVGC39J41GbxqoAwmcgs9MFN3rTFMOvZX+ZnSnZJl8AJZo8X7PO6+/Hj7WdPcWRKmuBMaXcXhau+YBzMknptHbrmVYkKZDXQ3+yPEWOt537Lb7j7Ii3BB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dl5/t7GH; arc=fail smtp.client-ip=52.101.100.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4tesBHfzlg9QmNjzqSUWWaNEx/dHx+sBQQ+7e7aRWWsaJH8kgxDdfhP5eBjdtsDs30KjEjHaP3ef5USojNlAlb6G88gwaL+0E9fPO7mdC3IhfdwhAQOYzzNtQFsTh9dKV4c8S5K4GkKJnbJ1QzBLpu6TNFx73yUMkVIq67Rx5OqTT/WBlpJK36W/ptLHO+5XLUe/f6RJ2SdT19zU4ENbyn7IXpto5/Yzc50Ew/hY1aMHbpAfBtZ0ORID4Sk/yKHvbCvrpkT1ZB/y6DQOvM8RD4CcXmYanT3CxJKhWY3T46xqoAkZ19bi5o5V8QAb0cCGW7NOlxVp/i41iwPdCYCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMJ5DVIPmR0GGyKuj9yCCK91LLnvLn8at/DfeavIHlA=;
 b=Werp8uz1MkTm7i4TsqzbfYABLxC77P1PHlWHZ7wCVvlUKOJcfRTnBvMU+mig5OayJQ/zThtnQAHIDOiKasI7CcP0ii2cJ1yN10U6cqOB6tgoC5DF4YcMy1FJqv3Z6PL5YSRajuOWaxyL4HjsOgQikSuL1KJf7xNXyIKcFadrJPgjIwadZtp7l2DEBdRvz6huP5JwgmCRmxHPzTGUCcziLd0pktKwbKcJmG5lDB2SyglqKC3X47rEcX+LUGDLmbx3ABmcHpiHNq93iQ/PbN+AWPoVrsGyDi/i3kWF+ZNXajBos1YAh1GBIVyKhZ/mYo+n5dba4N49n/vcz+6Cf/RuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMJ5DVIPmR0GGyKuj9yCCK91LLnvLn8at/DfeavIHlA=;
 b=dl5/t7GHTOrQpQsOc90oxMofPV8F9OXqPenVrLIccJxdCPFe7yeJRMDzW1xdE1CR/bdBPq2Y9n4eT97/ExHZzmNGPB9KiPoJvd7/HETGLg0MayEyotf0eoNkaSvWq+iireIRJjQ5OjM5kr5dd14KvF+285hUzCuwRxXvZWTismI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB7215.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:347::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 21:53:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 21:53:29 +0000
Date: Tue, 24 Dec 2024 21:53:23 +0000
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com,
 dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
 chrisi.schrefl@gmail.com, paulmck@kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v7 08/16] rust: add devres abstraction
Message-ID: <20241224215323.560f17a9.gary@garyguo.net>
In-Reply-To: <20241219170425.12036-9-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
	<20241219170425.12036-9-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0287.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ba5e7-caae-4a4a-8dd5-08dd246566d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c3TKK9hF1OjZAtE08/TuN6/3ylMqxlw0yZhBLM/Q7x10Aquag2IBaMznVH4k?=
 =?us-ascii?Q?h3dwZgn9rxfKLrXo27sQio5cXBH4bt5i8Q4o0MKGYc2cqPfEfkzvYUyy4MrU?=
 =?us-ascii?Q?ZV6gNSFSlojMMhS54WxcrnrTrMdI0HuNXm1oRNuJHD9WDiXypoTiPAuQNIZd?=
 =?us-ascii?Q?0xYCmaAK36zPUVC7n6zsBXw07i6Z+7wwRa4RhHv2omLa3KDbQohtQX8M7/16?=
 =?us-ascii?Q?fouW6hzyIccoIu4ExE2A5XMtrSRG8O7LiG0lTkhWxt6Tyna2S20NJpOop8fy?=
 =?us-ascii?Q?6qHWXiqdLLO/lJm6+dAWCD1nzjqlDq6YRIGZVFFTroZCF5v6tgDSJtRZoRns?=
 =?us-ascii?Q?LNPCob52kK3ln8CWhyKgVTZbrmlH+kFR8rvetBD9YFnL+VNNsVVS2GUD0rEV?=
 =?us-ascii?Q?8MwngEgi+hoUPqcAMCxxNEf6t7D4SZpoWoYej3ov8katBlC4H+5rYrSz0XJS?=
 =?us-ascii?Q?f+TgsH+86k+Jmdg/KKLJQbprhUbsvbaIDgALO0h58gY+TUeCVNY55QjMqe3J?=
 =?us-ascii?Q?hXhX67LumPwmj2R3+gwJEZsKlVZtKDkIGmO9Ak/LUkVXneJz60QHSo8NUxII?=
 =?us-ascii?Q?4VeWzwyuUqEzjW5vyh/N17O/8y2YSQab6QXzYWSfYXLY05/GpZqUrWHy8kCQ?=
 =?us-ascii?Q?aFdGkj2I1gKbqQVcgouo7ZZ9sBJDjAhSk1Qh0W3W7kbLSG3gCY1Zha3pRq/s?=
 =?us-ascii?Q?QdTORDJOQE9G2lN2fjrBnswu3B42Ifj74jg7WMY1mlQ6/szfhpaYIJMGxsSW?=
 =?us-ascii?Q?eELViNAeEibbxHV+NirQWsmFjpugjrNAd9x8m45WSoB3+Qze1wQGF1HSKD+x?=
 =?us-ascii?Q?4+8BCcGh5f4vRXbsKct+NgyL/ZDioPSy7ealW/ZoIZss1p7JB4RYOQxsLr53?=
 =?us-ascii?Q?pW+bsk2unx04mybTounSuHdDIqwR+kt1ocGmdyeZLDDMoiwsjWs9ZqTzPscc?=
 =?us-ascii?Q?UzFm3+Pqwc6oY9D+bk0zcqNtnHvPrYhsnD+Ldz5fOL2LfYiMypIqMT7/5A8e?=
 =?us-ascii?Q?Fu8+sfJxBSJEDhJ1ABLEioBj2wk6hRG6bX6imd4GygdyJaYgztkAwbi9Ow5r?=
 =?us-ascii?Q?EP8bnZTRaniyKV5aCKruYq0LI1v7/mVbjoUt7arNNRmRRkgaJAqeSQWjsc7A?=
 =?us-ascii?Q?keAI+BT0WHMFuYTsAdtd9K20o4zuj8bozL2ql0KrtWZHdbohNX/HRt+s/RxV?=
 =?us-ascii?Q?DiR4a3SCmFz7FgTHC9XdD8ns/CyROzN6ddpJhheGcJP+jAPrrcNmqOnhk6Cv?=
 =?us-ascii?Q?dBriZiOjGNYlnvRSUUAdP6DtsOdc88YDl9GpJghHbdvo/wCTqCIMUX86YU+h?=
 =?us-ascii?Q?J4eCooB3djW1sfz+J0KSTBZt7Ukk7Yub2V6YLh2jbWcTy5gki7LH1GJKgKtN?=
 =?us-ascii?Q?ToZ/892Cv3UwM9kHn26g0CmY3tsy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sq7ImJ48s3i0mFk/nKDf6QSQLmLsZoOBlEa6+4v8FK6/HUvimTL4rZuYMlcV?=
 =?us-ascii?Q?cMeuY1opBQND/6AKMmhIYfe+rQlMhWqwD1PaY6quu++NjHnEf4CPtIFKnruN?=
 =?us-ascii?Q?zAs61jO2CJCJLUTSGJd3Amioae9O35a63V8vyju/zTh+PI4NkjGVqUGMW+2d?=
 =?us-ascii?Q?NFsNEHtlsmFu1WdVvXEdOufmWZWS5DaDzfxc1FlT/scR9JCflL4sPYb0k8BF?=
 =?us-ascii?Q?NLUUf6ZUrWyPZC3ZT4s378gEKJz5qWMe+qwEdlG6ydiPprC2KbdHXpWtSc4W?=
 =?us-ascii?Q?i+9YpXh1MNindlqWbeK1jX0qYK1VgZ0zFDfuli6msHcWdkRYaicVxclz+CnE?=
 =?us-ascii?Q?2OlE75tSj/fLfe6idD3cUOA4Vtlog+UA80EqADgfaroC/ACdy+wjHNGcb3aV?=
 =?us-ascii?Q?FB7m4rxfa1TexznF+jAyi6yzaHj1zxZczJAsRO9PQVeJ0Gt7cTPWDUEJCMNr?=
 =?us-ascii?Q?rf0JovVD21DAZzuM6YUY9tQXlRESXn3GCZLxWFOdcF6CGUtzchNhUq5dp8Rm?=
 =?us-ascii?Q?ZgN43e+tzS5TMceiO8Nd9ta2F9RIhIkCqZBRDjidvPrbWy29sDkgL7tNpooO?=
 =?us-ascii?Q?NntEEl18iqLc8VUq1p5QGdFTarRjOReTMJs20Ni5sbU3uEM2NETTgz19QFgo?=
 =?us-ascii?Q?K1x45F6LbUzYxA40QDjGefKyKOhfG0iHGndain5zPJqfGZlJrVttNQmgwodN?=
 =?us-ascii?Q?014YWbsboCz7Id/PCW114ISu2xeQV4fpkt6QsWISA+9RnwvaJJ+n9VSznway?=
 =?us-ascii?Q?J5tYxZT2LbxlIYASxuHHVxFFxZpOm+hHlegoDJ+50bDGzxq6SU+oFeQu0hR+?=
 =?us-ascii?Q?Qfc94p8tiTFyPkFZcf2b6ZrbSPSZiUcfvKZMdbPrFt+8g/FNA3NEbBkVs+MQ?=
 =?us-ascii?Q?iwKSWJkvfl1Wj2R6LZ6ZbrUWgUMbfq0QZi2Ni0/1ty+4BU8mAYXCtHy5coWp?=
 =?us-ascii?Q?brEkBtrwj8usOAp1LB8rLuOYNRURMbvpP8dJ5nNU+atXRWtg8LKXkn5zB5hE?=
 =?us-ascii?Q?tnegFBbk0N6rMqJ5H9Uch9HkRf/96kfRU+D6LsUO5sXCvF1Z+J6Ji99o78Lp?=
 =?us-ascii?Q?iMwW1rqOCqFMilOoLGWfytr0Ff5IDTdhjTBvoeMsh6Rl65ETzua9MtwpKz2Y?=
 =?us-ascii?Q?0sxNqF/HsfFxgu/CCCmc+fJi6wjZLLRBwZhdTQI0F/zduNHCPkpLS/DNPIfV?=
 =?us-ascii?Q?wn8LWZ46WnICjH5ZcgjRsdWq7v/HtJP+J5Io3zZRb5KzrAa9fcjoXxIXFl4O?=
 =?us-ascii?Q?P775tTScqfyaQFK+0SzqGW74wxpEcQifTI+Y6YuecW/NsLC5qD2DJ2iWOR0j?=
 =?us-ascii?Q?Fcg8M9XqyFiykG8xoBPL8ZVYdh75Ax8d+334WicBqT4lNKgNBzWqMTrxZmul?=
 =?us-ascii?Q?aERbgt/g7r+rLkoeyu4UFjJJv7y8l/Hk5lyaWTCPzNN5L6hSEpAOTBh8OCWB?=
 =?us-ascii?Q?K0xZqIMBUTnXCPd/E+PU49XRzrSeiDhQTrV4vPEuati7bgptyS7OdSobZzot?=
 =?us-ascii?Q?M672Pd7Rxh2OG4YARZibFU1BcF2SnPoGGAq+OsXnb4JAnutYh1T3tWHREPIa?=
 =?us-ascii?Q?Nwm34EQeDlIk1hFez0A26vTzc/JCPwuhXEKibEfHWginvR+l99kIhFQx17tV?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ba5e7-caae-4a4a-8dd5-08dd246566d2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 21:53:29.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXpl+b5Oiffj90o+ru8dmETY8dK0ygoGGkgmtj6gre7ItFYT6j6z9dynEtVj0ggfZgTxJ3lnMcDNdjZLmg6vtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7215

On Thu, 19 Dec 2024 18:04:10 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> Add a Rust abstraction for the kernel's devres (device resource
> management) implementation.
> 
> The Devres type acts as a container to manage the lifetime and
> accessibility of device bound resources. Therefore it registers a
> devres callback and revokes access to the resource on invocation.
> 
> Users of the Devres abstraction can simply free the corresponding
> resources in their Drop implementation, which is invoked when either the
> Devres instance goes out of scope or the devres callback leads to the
> resource being revoked, which implies a call to drop_in_place().
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS            |   1 +
>  rust/helpers/device.c  |  10 +++
>  rust/helpers/helpers.c |   1 +
>  rust/kernel/devres.rs  | 178 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  5 files changed, 191 insertions(+)
>  create mode 100644 rust/helpers/device.c
>  create mode 100644 rust/kernel/devres.rs
> 
> <snip>
>
> +pub struct Devres<T>(Arc<DevresInner<T>>);
> +
> +impl<T> DevresInner<T> {
> +    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
> +        let inner = Arc::pin_init(
> +            pin_init!( DevresInner {
> +                data <- Revocable::new(data),
> +            }),
> +            flags,
> +        )?;
> +
> +        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
> +        // `Self::devres_callback` is called.
> +        let data = inner.clone().into_raw();
> +
> +        // SAFETY: `devm_add_action` guarantees to call `Self::devres_callback` once `dev` is
> +        // detached.
> +        let ret = unsafe {
> +            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
> +        };
> +
> +        if ret != 0 {
> +            // SAFETY: We just created another reference to `inner` in order to pass it to
> +            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
> +            // this reference accordingly.
> +            let _ = unsafe { Arc::from_raw(data) };
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(inner)
> +    }
> +
> +    #[allow(clippy::missing_safety_doc)]
> +    unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
> +        let ptr = ptr as *mut DevresInner<T>;
> +        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
> +        // reference.
> +        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
> +        //         `DevresInner::new`.
> +        let inner = unsafe { Arc::from_raw(ptr) };
> +
> +        inner.data.revoke();
> +    }
> +}
> +
> +impl<T> Devres<T> {
> +    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
> +    /// returned `Devres` instance' `data` will be revoked once the device is detached.
> +    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
> +        let inner = DevresInner::new(dev, data, flags)?;
> +
> +        Ok(Devres(inner))
> +    }
> +
> +    /// Same as [`Devres::new`], but does not return a `Devres` instance. Instead the given `data`
> +    /// is owned by devres and will be revoked / dropped, once the device is detached.
> +    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
> +        let _ = DevresInner::new(dev, data, flags)?;
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T> Deref for Devres<T> {
> +    type Target = Revocable<T>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0.data
> +    }
> +}
> +
> +impl<T> Drop for Devres<T> {
> +    fn drop(&mut self) {
> +        // Revoke the data, such that it gets dropped already and the actual resource is freed.
> +        //
> +        // `DevresInner` has to stay alive until the devres callback has been called. This is
> +        // necessary since we don't know when `Devres` is dropped and calling
> +        // `devm_remove_action()` instead could race with `devres_release_all()`.

IIUC, the outcome of that race is the `WARN` if
devres_release_all takes the spinlock first and has already remvoed the
action?

Could you do a custom devres_release here that mimick
`devm_remove_action` but omit the `WARN`? This way it allows the memory
behind DevresInner to be freed early without keeping it allocated until
the end of device lifetime.

> +        //
> +        // SAFETY: When `drop` runs, it's guaranteed that nobody is accessing the revocable data
> +        // anymore, hence it is safe not to wait for the grace period to finish.
> +        unsafe { self.revoke_nosync() };
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 6c836ab73771..2b61bf99d1ee 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -41,6 +41,7 @@
>  pub mod cred;
>  pub mod device;
>  pub mod device_id;
> +pub mod devres;
>  pub mod driver;
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]


