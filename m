Return-Path: <linux-pci+bounces-19024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6589FC232
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 21:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC21D16356E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366161922C6;
	Tue, 24 Dec 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IUiC5ESt"
X-Original-To: linux-pci@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020118.outbound.protection.outlook.com [52.101.196.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4D142E76;
	Tue, 24 Dec 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735071691; cv=fail; b=YOn86+OSeBH+2YtAjEIY+9YNo4WgfGnr0AFDHUG3nwyKHAW3e6ef+RjxouJV3UyxNLoDZzia0Q9VmvCt200WEVxGRpJcn5Zn3FpsIVi31IKFDe/A7ao3ih7dsU3pXrgqTA3dlNkf01z6oIHVTanLzK9K6ZmZ/CxiYNr6AQes0hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735071691; c=relaxed/simple;
	bh=uFyWc4QlgcyuGSCbEn+yRy3+8v/xLESQ7c2IeQOI56Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iTbpapU3ba3AgAai2n3HJdIpqANzNRqUMgkk92NqEqAUdsp6SFLPvTBsTd7d5YFjOVbJLhrKsQD5i+N3s753lNtpJvQ7OcL2+TLaxoH9GUY+48zOmkpQ3N7+Re1QDzbsj5xVFPbD34xKKbbQyA/Lu2aSWwKH/t8E/7H99bb+CZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IUiC5ESt; arc=fail smtp.client-ip=52.101.196.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAmXtTXojwLyyLMsdeqrz+TrFxcK5NpSH2JDcUCFL4ZwDOvxiQ1p64o7YkbjXb2wWnZFBWQ1DyaiaFzClsK5z2fywYUenEjhJH/eCpV+E5X06RaUAf84gYelFm/LHJO2vMtRno7zVyqiRCeFMNhe5dZCqXRuFraOaTs6UeTsQf2/69x8GysAVag97Cce/sto2vjTct0OMWoB6bF7t4YWlk/rOLofvtKuZ0rWET+h2MsKfR67v7dALCixHolpMu8DQsIx4SDrb7RYoiunqcORj+IQiF6Ta/ZhPW3vQM92cvqjhW0kpT5siC6HS50/NAmcu0Liz/TdJ573BNoC3NP9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDRd850OC8czIEmHprOIgVDMmbJNKxa0GuVVXx6v5rU=;
 b=So3vqBTGSxCGvKbMfjyk50LAsNsPtGuUHG2ldWTdq9j3ENMUayyHD2qLsgBy3mxjo9ssmOshsYuS/hr4xYmHyDqOdeJcATHUQNRp9+y8O7XpMYgDDjPao0TbKVCjxN41loXfLGk8IB8Cn9dUXmtbfziYtQRAEtnfU4hijJCGKUJgdEIQsaEGe+AmZF/JeUMPJNxJx6p+eCy7Uwq09NOku5DB0Eb8Zo5/RWG0m6ehl3IHq/sgckXmXOzDi0s7hmcusSx3IgodPR5uRqZRM76pd4C9PNFXW4JTRCyPHLXZxRNds4BDwTzDmGsw7RmT/RNw4h4NKiSVwBazHc7oQBBwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDRd850OC8czIEmHprOIgVDMmbJNKxa0GuVVXx6v5rU=;
 b=IUiC5ESt+sfuNhzo3PPD89qXPN9s/sAkw7tF/MFn9S6WpxfzEaQvCW/T+NeBFJQV3sX8K2HHGw0LV6JmCViuiRnlLebu4MiX+orpS9jmprznKouppd52pqvDQTQg98ssRUY3MNxbvV1mFWumKxHEr6ddd9ODrnb7SrrmPfDxXk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO0P265MB6357.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 20:21:25 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 20:21:25 +0000
Date: Tue, 24 Dec 2024 20:21:20 +0000
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
Subject: Re: [PATCH v7 05/16] rust: types: add `Opaque::pin_init`
Message-ID: <20241224202120.581b7088.gary@garyguo.net>
In-Reply-To: <20241219170425.12036-6-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
	<20241219170425.12036-6-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0213.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::19) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO0P265MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 80768fd0-e870-4429-740f-08dd24588a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x2aRV/+U+r5ZFnRKiN4/W1za7Seur7lQEE5ufl6iI99/t5Tl0duboGBQRvdp?=
 =?us-ascii?Q?s7jDkUsaXE8oLgYqcmyqqffDs5wg9T4GAwJkUqxqX6716adhTbcYFsX1DFPI?=
 =?us-ascii?Q?VSKv1IYxM+pXemybpWN21RQptcUWuIjXnZZi/ycQuYfz0kXQMjQ736nAPsWg?=
 =?us-ascii?Q?r5OZD4OgB2MQxcABiNjoWvZBUZnOVCZlIFsUvy9ayi5oSynYMlkjEWUMvm9K?=
 =?us-ascii?Q?ocN0f8pSr9pYC5RjwH96cAGWRFXafM5STnDYys8K2iflCp9Q1SE+kW5LdY7p?=
 =?us-ascii?Q?9gyeGh49+ym0wayIG1WpjVDjNpMDLpUIkAL59+O+tCY9C52kYoYqCg3W7xBU?=
 =?us-ascii?Q?sVFTciW5gxyNZ1AkMK0xnYcaIQ0d4Ch2E2M89gXaomtU4ATcGVOT0uTmDLEO?=
 =?us-ascii?Q?B0uO83hxc5GzoSpEejam8IpZSSMNheTGxqTjuqyDGvjncWakmQv5uvMT8ZRD?=
 =?us-ascii?Q?rlozFm1Ht3Y0rEt+wWtUGswXdF3AkhyzfuNjUwK8eepW6GFsjucwKn7NcBw5?=
 =?us-ascii?Q?gP16CQsVaFuu58CGdRMMyyQDu5edHUvQzh4fyXBJzCu7Rs1yanThSW0AQtjz?=
 =?us-ascii?Q?MT1zXE7zc6CxmDYPuiPUQhimkxfcY41hIcysEvEq1PM3DvjQ0dnSDe9MQzh1?=
 =?us-ascii?Q?JrNZus1e8MBnqqHM/1Is6j9CGEZCGh7wT1FxVqmt080LPLGC1ypq6C9Y1P1B?=
 =?us-ascii?Q?+w7xMvXIa2cEE6z1NG0u528j8aT5RBcecrHjQtcpHW1l4EE/ATsi1kM7zwab?=
 =?us-ascii?Q?D6E2J/GJpNtju7YCksVTKDG32C1gycKQwEKp7IpJnxxhYpVI09MPcPJpqhFN?=
 =?us-ascii?Q?EmkGl3CPh5Xi6VgKq1nBx/YUS5F3JqMD8q7rsrE1XfOl1XxrRhaLlWW30QIR?=
 =?us-ascii?Q?JjNltjq3bdPsKbUkjzF6E5A/Pha1S97amWgXeoIbaXEt8x023vZoIsXJPHlk?=
 =?us-ascii?Q?fv/yJqQ2StYmLsWK8en7ix0GtR0OHlgE3wsYJ0AeQWTWpWRmwlchH14jWwYC?=
 =?us-ascii?Q?e6McS5IYZqo6kC8oGLwWPY5SHQtEBP4nRy+XiHxZHfXZocSizsF3krf17k/Z?=
 =?us-ascii?Q?MmR+bV8kHvRS3Qb/Hb4kLLtsJBdVe2dcZETdnbvTcHhXwz0LBuR8uauyoEx0?=
 =?us-ascii?Q?GSCua1tTYLHNnrVY7bABTkwN785RlmMfEVHcT4yiAmCvOMWBkBRFkvSxlLS/?=
 =?us-ascii?Q?b7fYGaWxPjK3o5allfAQSqvRFoa/Bns/dVesCSGKwszPtggKZzIuk+qO6bzv?=
 =?us-ascii?Q?Q7gKteNGWFV58/6A1odYHlIkkgPwtSgLcZwpq9SBd6sH4GERSN7NuS6JopyY?=
 =?us-ascii?Q?wpogjOEw/ecU78KgjkBceXQ63V/mgrEC/M+RZ363E9WeCeqHJtl7Hwlsx06k?=
 =?us-ascii?Q?jxGKqcfZ1SgFC+JfYwsqKjyE72oe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSgZ36Wjuy3vsgXxOwan8D7itLWivrCyWffMBthov9egghwQ74xMFVVyUESU?=
 =?us-ascii?Q?S4gegD0uTYsJEBrK/qILhyVJFodyR5ffe2+HZ52nLcpi4ivPbWYDUlhfsMwW?=
 =?us-ascii?Q?2lEgYalD+bsSyBaXKw+hc7Gq34sspMOG81jDg+CAjGNVaJ53J6NlKy9Rx5qN?=
 =?us-ascii?Q?15gjEpsZFsifv+XnAYT24+9vC5xICyV7bodXHQscpci30GIXrrqYcGbIpmYO?=
 =?us-ascii?Q?3FBO2ncIg2DA8xCDnOAXbsk70TNZBAo2opo2CZ7C+5AVo8ap148swjxs9tkm?=
 =?us-ascii?Q?V4EcqLq/WLmcEkMHZGk2dL9qfeisJLE1IakL+h4EqvxmpptD9stPMz3cb7D6?=
 =?us-ascii?Q?bTmVSDIabHLer8HboJoeQwMqHDlaAXz0QKUF16NTx8LmbLv79DgQUNXV/Zl8?=
 =?us-ascii?Q?xxtTP5+QFvC9C9AmVHSiIec3HKPKj7dpGrvQpCMcTRoQM6ouljQp/KUlOBpz?=
 =?us-ascii?Q?pCz/yiBOGufYdyt9RLklcQWy9bvrhHqdL/K8Utfevp/VTgSfRSzR8XVGUQpK?=
 =?us-ascii?Q?Pezs4gKM2WjMjGp6P5UxSGGyOOH3vSahtCAbVzsLhNgFRdTKTXxYGwPhCNZf?=
 =?us-ascii?Q?ab6UtUiUZ4j84rr8yuUDvHXonNBQGcan3xAb2uVR17doJ/jwF1+UD2Zw2mzq?=
 =?us-ascii?Q?Yi4Bjfi/iXSvU7jdH2eIBosRSY4tz2yn5i/QtxsfcJ9rTFgFEhxcZswcn/yq?=
 =?us-ascii?Q?LxPZX/CvXCZHmB/rHRI9IwoSYy0GOiLOs3I/Q1eqTICPdaQ0TFdqMNt5qgtE?=
 =?us-ascii?Q?Pm57AK2hII06tB9ue3ECNCYAIDR9RTFvZUc5QZzd7/7jqlqoHHyuiqHsVTBH?=
 =?us-ascii?Q?ykG5vHbyP3gHzWbQgp8orOndY94JpJOkdYnmrJUjEyLWM5x5AZ1o21pTpEA9?=
 =?us-ascii?Q?ecX+CACssEYPIXWZFbfA9IR0FwR34p51qNixkWAincLk22mcooH838nUpKjg?=
 =?us-ascii?Q?11II7cw1eMnR26VlX+ImhNYIKbZTgUahnWdjRrs4F6G9iLp/qbWpeZjYmwq2?=
 =?us-ascii?Q?os8/K+iQV5J4M5EidpKnciR/2Ntd4vI3I0ff9ubboNEWxnM/U1xT5URD5BtG?=
 =?us-ascii?Q?JskjlP7/23Y+1hd8uUwL5R4VDz+btx7krabyH2LSGWAndO3pB62tQJnrl58d?=
 =?us-ascii?Q?E/LgIbPg3dktKtgei+QLHcnC4uGSsQPu5f12A1Y/TQAq/be2tp+s0gC90jLC?=
 =?us-ascii?Q?5KJG4pG6+rtPIkv830wf6Z8CsahPHw+86bfdiV6SsWgFhLtsDruucTZ6mxmH?=
 =?us-ascii?Q?IeJzpqBqFzrISWiohMW6ygBh2RXdm4qd9bWXyrJBQRaWAktAPSGFhniERz6J?=
 =?us-ascii?Q?+BdvmmyXhteNr6Fj2orV1+Pzfan0Jydew75AGzyrSCRNf5H7pN2qoW6rVdmD?=
 =?us-ascii?Q?eOiXE10p1QRpcdNskuaLpJq/+dM8gRvdIjVCMROSUvkDZIbLBkTyNR+wOWVE?=
 =?us-ascii?Q?woJ7WvicCsCyZcDUbcXQSBjgTQukfelNt34WHsVCZKmstHGxNsfA85c/KJMP?=
 =?us-ascii?Q?+kjtMYkx9xf02w4G9aOvqtb1eDuKsfrdz/TfDxqJ+7PUG0Nh0Couru18ANT3?=
 =?us-ascii?Q?hmFd4Y4gMpjiiKd+vB87VBTFa6f8RjypAdyR6Cz8dL473K4FF+9qgQxlS/xZ?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 80768fd0-e870-4429-740f-08dd24588a90
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 20:21:25.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUDvs39c6HxKABFPEU9775OLS6IdghQ/04Z3D3bd5DeYYqgI0L8of/i0MJVOQNjMDYRUUY8EpRDAFCIHwiMX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6357

On Thu, 19 Dec 2024 18:04:07 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> Analogous to `Opaque::new` add `Opaque::pin_init`, which instead of a
> value `T` takes a `PinInit<T>` and returns a `PinInit<Opaque<T>>`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/types.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index ec6457bb3084..3aea6af9a0bc 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -281,6 +281,17 @@ pub const fn uninit() -> Self {
>          }
>      }
>  
> +    /// Create an opaque pin-initializer from the given pin-initializer.
> +    pub fn pin_init(slot: impl PinInit<T>) -> impl PinInit<Self> {
> +        Self::ffi_init(|ptr: *mut T| {
> +            // SAFETY:
> +            //   - `ptr` is a valid pointer to uninitialized memory,
> +            //   - `slot` is not accessed on error; the call is infallible,
> +            //   - `slot` is pinned in memory.
> +            let _ = unsafe { init::PinInit::<T>::__pinned_init(slot, ptr) };
> +        })
> +    }
> +
>      /// Creates a pin-initializer from the given initializer closure.
>      ///
>      /// The returned initializer calls the given closure with the pointer to the inner `T` of this


