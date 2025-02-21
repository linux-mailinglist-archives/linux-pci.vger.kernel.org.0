Return-Path: <linux-pci+bounces-21946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B987A3E9CD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5421899731
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444070803;
	Fri, 21 Feb 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o72APzf3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755373597E;
	Fri, 21 Feb 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100820; cv=fail; b=UGKy3VbLq4eQvHbbx+Q4QpIsL17qJcXJtGh0jf1voge/XrnPhx9k7ivi/hcHxSB7dywdjdjocSMBWO2Jl2h/6jTeyY4jUHI0UzEImlb23kGxUih6uwDWVijD44vkgXt2AChS8sTNe1OyPw8RB4ot2uWkie6Q6UT/N89CadEKSBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100820; c=relaxed/simple;
	bh=dnwwW9H8Gmus2Vbwuz0L9G2qMLdpxge06H1CEEUnETQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Osccz9u235MArWPhFnxM1QEQNOg4zUaGpkUCnSdfPxHgZmxpuweZyAy9D45+r6hZiJ7FxIX42op7BInXQQ0NJx06Yld0ERoOkgZdJIhn1/k/afS7N6XR05q/p7kt+ILeuPFkgApTxqJ+SCFKlr5LohthETXzUY6UEGNROKFynP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o72APzf3; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjeM/dQjpkxgs4uo1t4O5hWfMOWOePyq1pbo1AoJMiaaCaiqPGy3TGNt7rVRbkODr9kQqB57AePSpWVAwmeX6NdTeFogrfnkRBk84ngaCm7bbsRp05jJFlJK9V+HbG99+St8+8dShyIFAm0Hds7qBdtCFaqXgtZd/gKeuexY7LxczyVLQUTNqb/8tEJLQfqxg2mEteI5AVbie5mv35kNARzn8gmPwThDPNowAMlJ/oa3slOJKOhPh9n71s9VaMW1pjYaL1YMNGaWuOgaEi3AnG8C50oKyBGU8eYF+a+ahuT/Cw25YIZgQXijxiVm9e/g888ETAuYNoUtVqkqtvWhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlbqsRo13sKY7Ma7zr/KHB9UyoKT5dVx2JXmckzwviA=;
 b=UUHrAyFfBtwVA8dIOoqvfRvDLACY83cSN6lvMqBjAlOimhcLbScfe/JfCnmGN7QBFv3r0QNxWfEBlKNOTkhioSgzFa6xfsZvNmI8Gq5LwBFZ5h3BcjQA2r0IZTg0xKr3fJxMWhFMxDDwh4NPry1X3bmC8uEO/oo7YOBOb6eeHcEZGQZ7aK8k8+CoTxi8wCoC+1+WvAD5wP6f0m6BAO1IVXyYBQ9u6ai7Pped6dAhr8BRCO/gztQFlNtB1BBToW8xGVh8Juutiy2EnhgWFru3EfqUA13LW1Sb5hW1jxqUKD5XCbrzcbHYtidBepoegfqkij4Y8lau2QTci4Hki9ZAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlbqsRo13sKY7Ma7zr/KHB9UyoKT5dVx2JXmckzwviA=;
 b=o72APzf3GSXGJwuB7b3moNyxJLO92lUvd0ok1wOWQELPkvDy5Nc5r1CyRnpXK7pk/7CpMwZ4PjIGaINBz5xhBa5tT1rlRNJgyhy+E9hblaSCS0HDGAf72gFDK/Fpqs3imYt84ar7yutROYNEH89ZBcm6upmQQTGeLaw6QecfSMaAZOUJQiZ1UO9O21Is2G4dEBIo01fCSciLzVVELRFl1Gzi5OFnxrDG7REZgMe+DnJwppELWt7+7A//yY/47Ord9WLImL/j8FDfi4FVLhD44VqDEQ51FkTjm3Zeaxq+IFEop2KtkxbG4E9QIMjova7fHy+jicd4OoEPoeWUZxbkPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 01:20:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 01:20:13 +0000
Date: Fri, 21 Feb 2025 12:20:08 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu, 
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com, 
	saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org, 
	chrisi.schrefl@gmail.com, paulmck@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	rcu@vger.kernel.org
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219170425.12036-8-dakr@kernel.org>
X-ClientProxiedBy: SY5P282CA0044.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee224cd-1d74-4821-a0f4-08dd5215e3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J75J3jX3ldbcSH5t3/4fpNfmEcz5AxcX48l2jLuKaHTi5QfegBVtAQ7HYwuH?=
 =?us-ascii?Q?RLNnVYEiJZ2yPlGPqu+q7kK2NcrtFUYHWTi7eYaHqdq+/NScjSxSAyJQjQsc?=
 =?us-ascii?Q?la5NVqUo29Bf5ZlYaFiQmpZmWEI0FmynYRvuHYx1xXPV2pP1QFBJf290CGuM?=
 =?us-ascii?Q?HFeXoLv7unAGNcKlpo5XMuFuzX0kG5kwsNyPT9D8+aggfliddQxw1l2KC5kK?=
 =?us-ascii?Q?HfEwKrC4VrVhbflsyir07uuZ1OvDp7VhZkAM4BYMpzP+G2bytMFf6LKSkqTq?=
 =?us-ascii?Q?ZXUgDwDNFZRs3E17TEDtzj3YNB3Pe4Rty+GlkIwEFlUJujzaZERYAMTmjHff?=
 =?us-ascii?Q?21BWCek4HmKjfKXJdMKXuy8y8n7C2idYvXt+rvFuQUA4x6vNCKx8y+e/gPMT?=
 =?us-ascii?Q?yfb2mk7NfkYoM3ycVaOfRLW1R+w/Pi61AzuzIg+ipUWxmIk7cswZ9jNC1E1Q?=
 =?us-ascii?Q?4aURMVhzEeIGemDO2ulTcw/rVcOxcVT35xIyZ5ASR90UdGXpLUDdvvY4PMJC?=
 =?us-ascii?Q?b9p3R+7cv/pJvaIy6u3ivDchqHP5CYZJ1Dfsgn9Lg0JVfXczYatv5Uba6AA3?=
 =?us-ascii?Q?/gRk/04X/8ktkAUtLxQS64BkGUDoWA5WLzrrB0Uc7cB+eHkaj5ub9FU0BUJK?=
 =?us-ascii?Q?HeKjqTR+Blp64WZLhsGSfzYCd+AHcWIB/nfWvByeBG2m+cie7i/2k009yVCr?=
 =?us-ascii?Q?wuZzMk1WlQ8yCGk8u72nqoB9ukezGdp+wD+tAVjgZyoy5xEAbVLgfO1r3NZ9?=
 =?us-ascii?Q?Tobm7B9on0X+bt3VOI9H8CYzGT7fQVeW6fSjAImktvCtptWVxzXX+tvPFZiV?=
 =?us-ascii?Q?ie18ibdUKRQId802w65u8K3YVQTM+Na6LKPdI30RjJ9PHWrzIzq6gxLG7bfl?=
 =?us-ascii?Q?7fWtkdEqDhFkKeqa+RqJsNRA6ir79rTkfdZ3NzNhYZiCNZWsHjWVxLq4dT2G?=
 =?us-ascii?Q?3EFP5OP1Q5dCG6pykx4JlrTNUzRGY8PWyHSuwSVwOTrVn2pE+HSCfH0MYkEe?=
 =?us-ascii?Q?RKh1TK+zKjIbpf/Jf8q5vz4AhiqfdLQBPAj53echZZcWeBjLf42ycBhWkHvz?=
 =?us-ascii?Q?U3oShdABdd24iOlqA5E2iKKD3/E2ct6PWhfbYswhasIYiaDaDQML7f/E/Vjn?=
 =?us-ascii?Q?EMXe4PhjsLXx5FxHRp/YYIqtYGLoIp/VHLpLz29rk0ZI6UjDOWst67KFBpyB?=
 =?us-ascii?Q?W4YWnMJNTe5NBpc0mJ/jDfiobEnWSvKIdbCdwg9CV7B3B7MQwLqoFDWLM91m?=
 =?us-ascii?Q?sSWSkQ8Bc5jm1eMICzDFdOPXb7zYeLH0mkiixzK6vBQI11fSWZ8qiJcxcmLL?=
 =?us-ascii?Q?dBzht8RXiI7L3PzA+dwCVyghuyirketjJRhnnK63AyQ0SaQIhwdYDHKxKIWK?=
 =?us-ascii?Q?WdT19fjvcBgLSE4qciqg98IssFgr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ngEZfuB/bYlG/pipCmq2yJgtaKLaJsuxD/G+7GZpAl8ecsbpKYwonWOcVos?=
 =?us-ascii?Q?r1MV89n5HzSJx6OSqUyrvM1WLvGbLlvCGW1/iszutjA7Z0SvTrTq/RDm1SDg?=
 =?us-ascii?Q?tAU+tLyRU1THlcNzbW6nRahn5px0G5HF25ND/TcjsZ50dt0ttW8UOrVhrVYl?=
 =?us-ascii?Q?zXkoqy2KmrKYrsx19OMyk9i2HTyPvAR/Z0gtPfnV9Lj2+jcnuT8NGV/Yf4M/?=
 =?us-ascii?Q?E1CKLZt92H8En1Dam3nuN4t3QP4WjLUuIrYMbRmaUUgWmzggX8Z05f9NUKMR?=
 =?us-ascii?Q?imRBN1s2UEF/E+qko+X/ktQORi8JrQllmBMQCde56Y1teQs6we+a9fdjOFdr?=
 =?us-ascii?Q?J4rbyT5Fr1Gv/HacpCb642OF+2siPfl/pEIAN8YwzeIkMDgK1lob3+mKCwpV?=
 =?us-ascii?Q?TeIFysHi6kJwCnwgEmIPtmG+66WbmUNUDQ1jJTuJt+nD4qLSkE71l0jAHnhA?=
 =?us-ascii?Q?0/rgRX5JeaICL4ciGXKJFwRSHrEYYLj9N7xcc2Oe/93iXIwW2ZKjKdMyrVGk?=
 =?us-ascii?Q?+t+s2uAY65nSNAqO0SyW7LUhzxM2KVqvtuqopb625omU9RYNr61wmUGDvRH/?=
 =?us-ascii?Q?o0e+4O0qIhelbuEykTo/j2kEHKS+ga5yj+f/GR+6Cf5+drF/qwLvSPJ9vOhI?=
 =?us-ascii?Q?NWQiGO5KaKh0JktSFsUgimMgn3r2xw4Q3XQrfz5+wuwIV2gioCrY+SkZb/3Y?=
 =?us-ascii?Q?you7DamkApN8TBunXA5z30JD+3TEvddWwouBS0gftEkS56uecAYFDYqoVcsT?=
 =?us-ascii?Q?G/4Xk0rxoD1ZG6CvdqRU/+gbsGH51TTzwwoyk6Ehr/GAsUNOc4/Hx47N540/?=
 =?us-ascii?Q?N51YXHMCsZ8sU/dHG0/WRLeOna+fkiigOLbttsh6yIY3fo9Jx5r+K9Ckth2C?=
 =?us-ascii?Q?0FiDcV+mm8VTbM6BSe23tTxh79hDPbZAzhMiVbcRcJ3p9GWvkQCa8BYA/ise?=
 =?us-ascii?Q?QctJpjjxgjZOhCrL2JWmjqvR5q1CCIwWhqB8BZQrsAHR9mt0KYAiKG1FEzfn?=
 =?us-ascii?Q?roSmFzDlyWJYBEAOEd5APIwbkGk9r/9FiWxWmNgQZxQeCfPtIZqRdT5oz5WU?=
 =?us-ascii?Q?McDqYrt/Rtd5SPbmGtp2XkIt22pfDpVzO3R/DMFfK2T5gJ0H2Sfd55WnXZ0F?=
 =?us-ascii?Q?HdjAz+mEbuDvWjbVcZtXql5i3dwBdsWKuF0GLOFTiLf2qgtvrdfAq9ohLxO9?=
 =?us-ascii?Q?9JhetEtKVLebXeI6o65XNVF/+lwhCAOcBI2yo090vCb0ghChsk7dYe5TEsmZ?=
 =?us-ascii?Q?Az+7zJnQKIhhdCwZOCklZBJFyx6+UDB+Kuq//HrCFpOYd/z85GSPNIPHTrbh?=
 =?us-ascii?Q?rEzHkhSIwIOd+GUre1AfQFpAlvuq8yYUc/jsjxjzoQwtTu/PgUyEiXVspopC?=
 =?us-ascii?Q?M1R9HX1CIKIBDWYNaLkHA2Y0AZE4vXsiF9dpcybC0TfV23LlCkbqRd/TVfRB?=
 =?us-ascii?Q?S2DVgSTm60QjwLfBVo7yCpMkJTa5nVJa1HsK+h06nyMXBbeBI5k7mdnuGTg6?=
 =?us-ascii?Q?SMTIOcS7PObLr9BZT5il0bfNDiouidSdLH23fOrkvsRj4mghvHlWoJP0GNIX?=
 =?us-ascii?Q?CJJTp12O5gShTfGiK0k3zBlAaQbkOvWW30fmfixf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee224cd-1d74-4821-a0f4-08dd5215e3e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 01:20:13.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TjGuIvFHbEqy7Eqxgvj4SQZ0iaLuDydPkJvtfB91877qahpIY5l6qokOxUiKhY/uAYhx6WGBccwJhY1ZlN3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548

On Thu, Dec 19, 2024 at 06:04:09PM +0100, Danilo Krummrich wrote:
> I/O memory is typically either mapped through direct calls to ioremap()
> or subsystem / bus specific ones such as pci_iomap().
> 
> Even though subsystem / bus specific functions to map I/O memory are
> based on ioremap() / iounmap() it is not desirable to re-implement them
> in Rust.
> 
> Instead, implement a base type for I/O mapped memory, which generically
> provides the corresponding accessors, such as `Io::readb` or
> `Io:try_readb`.
> 
> `Io` supports an optional const generic, such that a driver can indicate
> the minimal expected and required size of the mapping at compile time.
> Correspondingly, calls to the 'non-try' accessors, support compile time
> checks of the I/O memory offset to read / write, while the 'try'
> accessors, provide boundary checks on runtime.
> 
> `IoRaw` is meant to be embedded into a structure (e.g. pci::Bar or
> io::IoMem) which creates the actual I/O memory mapping and initializes
> `IoRaw` accordingly.
> 
> To ensure that I/O mapped memory can't out-live the device it may be
> bound to, subsystems must embed the corresponding I/O memory type (e.g.
> pci::Bar) into a `Devres` container, such that it gets revoked once the
> device is unbound.

[...]

> +macro_rules! define_read {
> +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
> +        /// Read IO data from a given offset known at compile time.
> +        ///
> +        /// Bound checks are performed on compile time, hence if the offset is not known at compile
> +        /// time, the build will fail.
> +        $(#[$attr])*
> +        #[inline]
> +        pub fn $name(&self, offset: usize) -> $type_name {
> +            let addr = self.io_addr_assert::<$type_name>(offset);

I'm rather new to Rust in the kernel but I've been playing
around with the nova-core stub (https://lore.kernel.org/
dri-devel/20250209173048.17398-1-dakr@kernel.org/) a bit and the first thing I
tried to do was add a new register access. Of course when doing that I forgot to
update the BAR size definition:

const BAR0_SIZE: usize = 8;
pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;

That lead to this rather cryptic build error message:

  RUSTC [M] drivers/gpu/nova-core/nova_core.o
drivers/gpu/nova-core/nova_core.o: warning: objtool: _RNvXNtCs3LxSlPxFOnk_9nova_core6driverNtB2_8NovaCoreNtNtCsgupvMsqqUAi_6kernel3pci6Driver5probe() falls through to next function _RNvXs_NtCs3LxSlPxFOnk_9nova_core3gpuNtB4_7ChipsetNtNtCs2wKxHFORdeQ_4core3fmt7Display3fmt()
  MODPOST Module.symvers
ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!

Building it into the kernel instead of as a module provides some more hints:

vmlinux.o: warning: objtool: _RNvXNtCs3LxSlPxFOnk_9nova_core6driverNtB2_8NovaCoreNtNtCsgupvMsqqUAi_6kernel3pci6Driver5probe() falls through to next function _RNvXs_NtCs3LxSlPxFOnk_9nova_core3gpuNtB4_7ChipsetNtNtCs2wKxHFORdeQ_4core3fmt7Display3fmt()
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST Module.symvers
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
/usr/bin/ld: vmlinux.o: in function `<kernel::io::Io<4>>::io_addr_assert::<u32>':
/data/source/linux/rust/kernel/build_assert.rs:78: undefined reference to `rust_build_error'

That was just enough to let me figure out what I'd done wrong based on the small
change I'd made. However the lack of reference to the actual offending line of
code that triggered the assert still made it more difficult than needed.

Is this a known issue or limitation? Or is this a bug/rough edge that still
needs fixing? Or alternatively am I just doing something wrong? Would appreciate
any insights as figuring out what I'd done wrong here was a bit of a rough
introduction!

 - Alistair

> +
> +            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
> +            unsafe { bindings::$name(addr as _) }
> +        }
> +
> +        /// Read IO data from a given offset.
> +        ///
> +        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
> +        /// out of bounds.
> +        $(#[$attr])*
> +        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
> +            let addr = self.io_addr::<$type_name>(offset)?;
> +
> +            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
> +            Ok(unsafe { bindings::$name(addr as _) })
> +        }
> +    };
> +}
> +
> +macro_rules! define_write {
> +    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
> +        /// Write IO data from a given offset known at compile time.
> +        ///
> +        /// Bound checks are performed on compile time, hence if the offset is not known at compile
> +        /// time, the build will fail.
> +        $(#[$attr])*
> +        #[inline]
> +        pub fn $name(&self, value: $type_name, offset: usize) {
> +            let addr = self.io_addr_assert::<$type_name>(offset);
> +
> +            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
> +            unsafe { bindings::$name(value, addr as _, ) }
> +        }
> +
> +        /// Write IO data from a given offset.
> +        ///
> +        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
> +        /// out of bounds.
> +        $(#[$attr])*
> +        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
> +            let addr = self.io_addr::<$type_name>(offset)?;
> +
> +            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
> +            unsafe { bindings::$name(value, addr as _) }
> +            Ok(())
> +        }
> +    };
> +}
> +
> +impl<const SIZE: usize> Io<SIZE> {
> +    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
> +    /// `maxsize`.
> +    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
> +        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> +        unsafe { &*core::ptr::from_ref(raw).cast() }
> +    }
> +
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    pub fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    pub fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }
> +
> +    #[inline]
> +    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +        let type_size = core::mem::size_of::<U>();
> +        if let Some(end) = offset.checked_add(type_size) {
> +            end <= size && offset % type_size == 0
> +        } else {
> +            false
> +        }
> +    }
> +
> +    #[inline]
> +    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> +        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +            return Err(EINVAL);
> +        }
> +
> +        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
> +        // this can't overflow.
> +        self.addr().checked_add(offset).ok_or(EINVAL)
> +    }
> +
> +    #[inline]
> +    fn io_addr_assert<U>(&self, offset: usize) -> usize {
> +        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +
> +        self.addr() + offset
> +    }
> +
> +    define_read!(readb, try_readb, u8);
> +    define_read!(readw, try_readw, u16);
> +    define_read!(readl, try_readl, u32);
> +    define_read!(
> +        #[cfg(CONFIG_64BIT)]
> +        readq,
> +        try_readq,
> +        u64
> +    );
> +
> +    define_read!(readb_relaxed, try_readb_relaxed, u8);
> +    define_read!(readw_relaxed, try_readw_relaxed, u16);
> +    define_read!(readl_relaxed, try_readl_relaxed, u32);
> +    define_read!(
> +        #[cfg(CONFIG_64BIT)]
> +        readq_relaxed,
> +        try_readq_relaxed,
> +        u64
> +    );
> +
> +    define_write!(writeb, try_writeb, u8);
> +    define_write!(writew, try_writew, u16);
> +    define_write!(writel, try_writel, u32);
> +    define_write!(
> +        #[cfg(CONFIG_64BIT)]
> +        writeq,
> +        try_writeq,
> +        u64
> +    );
> +
> +    define_write!(writeb_relaxed, try_writeb_relaxed, u8);
> +    define_write!(writew_relaxed, try_writew_relaxed, u16);
> +    define_write!(writel_relaxed, try_writel_relaxed, u32);
> +    define_write!(
> +        #[cfg(CONFIG_64BIT)]
> +        writeq_relaxed,
> +        try_writeq_relaxed,
> +        u64
> +    );
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 5702ce32ec8e..6c836ab73771 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -79,6 +79,7 @@
>  
>  #[doc(hidden)]
>  pub use bindings;
> +pub mod io;
>  pub use macros;
>  pub use uapi;
>  
> -- 
> 2.47.1
> 
> 

