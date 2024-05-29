Return-Path: <linux-pci+bounces-8016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440A8D352F
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04DE1F2646C
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5E16937A;
	Wed, 29 May 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TzP8QQu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01C17B50F;
	Wed, 29 May 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981068; cv=fail; b=Sc+Xwrnh+vhBmQGsISvcs644euemEVvFN5T75fDzwaV2JG6Kl7abdRy/LzeXc5KwXZ0c8E+JFiR2AEGqwnbhEkI9cUH3b2ZmsBPv7ydo8ASQHgtQx+m61L6uiKQjjG+qOaUv/oVPHCoLMPdDJpvPJ02QADolXfjq+LIiJs+cVKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981068; c=relaxed/simple;
	bh=hEIDRc2zaEYXFEK+zWn06OYxPqqG+2TBmSxYWQRAETw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=INhfYxgVS+Du7D0jJyg0Ul5toyB+AUDgwfHsMJMo04Rasd4Xbbg/dOkFC1beHoevMrP6N1FqIADjBrYFfswifmTh3CxYArxskbT1Itvv+1N/Ik79pQVhwVnz4XUs2bVwFfH59ZfDEBcsI41Ijpk9HKTWDIzebTMb9MelhCIKYg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TzP8QQu6; arc=fail smtp.client-ip=40.107.15.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmuHpJ5HI2G48eD2L06QQcJuOpiJzhdPQqWARxdYyADYST6/c0bq2FdeQ+F0LBZupnWv7IeMVeibDeI7l853JgeNM+N8IXq32mmVLAUz8503b7MTi0AH345u+LfhJn0+pc2xycA66iLwjRZcGrShSL1ooeLvyBBndfbS1ZHJKr8WAHIxx62CKXgt/h3KNg74vzs4aaaox5dh4Gi0yXrerC6zVIUGK6ucHFzGwEtjyKZsgD82gFMH3qHrnUvazuhwqYVwK0AKc6rU0y19qRMIh+/Ts0zKcVGLdrWWBVR4kmYuP+T5nG+YorV8iyQE70FDcvmj9OpG9EA0d1P+2+XD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xAPXtHYC1yMhS3SpRUDyNtqgGF/jX1ztYHZQt69tNI=;
 b=TALUTjccpJQ9y1Wi1bBalMOXokd9QoaemVqrPHUmJDntkpLvjGnnb3oDx8bAZ8/maVjmVHypOhIuGC1nkHYet6Ps/HPzDNKDYewOxjBhP5EFp5/Bcsoiz95ufRW64hGO4/jr5jDU0uBluHdaWmzzGfHc34tTRNApQAIPZGa3P6k97bi1JejmqY+Bo0ecY7mIZKYSXQa12rmT3jLX8YxxWRSp0YjPnqC7G+/e5mu6lyNacU+dHJ8PLug0IIxhRjuel9kS5OnA4WQoNmzugG0Y5mJI/dyipVKt4y3Zam6/nWi1+exHSwC3oCPUrbs8dZZFLiV0OqGIQi8rghWsfgXIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xAPXtHYC1yMhS3SpRUDyNtqgGF/jX1ztYHZQt69tNI=;
 b=TzP8QQu6wGsE33KJ/kRcvnQXUigWcjZREhHkklDEcqdeW9HM7KdNdzBMr1T4LFY6okdRIB3FDebU05FL2mKcKlZhDwp0VyokjDI5AABzuPHTI0bq2Tx2L4teo+tYGPQuBvmBm9QtLLMG/7YUJHLWITi0p/halq6duNqC0z1MFCHGHcy0tcKDg1wpSpjVcYtJSKvwAL6BCE/ZNeuwyb5wT5vS4OaMyI2f/+gWh7WLHCD5ymSgIAIXFNTw2tOSUWnqSfbx2JMetfRvgFkTSWC/rG3uszlvowSQIfMYSUyMJnln4WBb4159ULMsO4VluFAERjXM4YkbX2NionwaFljilw==
Received: from DU7PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::27) by AS2PR10MB6998.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:59a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 11:11:03 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::f4) by DU7PR01CA0037.outlook.office365.com
 (2603:10a6:10:50e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 11:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:11:02 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 May
 2024 13:10:57 +0200
Received: from [10.34.222.178] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 29 May
 2024 13:10:56 +0200
Message-ID: <6dd51d6a-7ad7-40ed-8afa-85a97a808476@de.bosch.com>
Date: Wed, 29 May 2024 13:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/11] rust: add driver abstraction
To: Danilo Krummrich <dakr@redhat.com>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <bhelgaas@google.com>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <wedsonaf@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<a.hindborg@samsung.com>, <aliceryhl@google.com>, <airlied@gmail.com>,
	<fujita.tomonori@gmail.com>, <lina@asahilina.net>, <pstanner@redhat.com>,
	<ajanulgu@redhat.com>, <lyude@redhat.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-3-dakr@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240520172554.182094-3-dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|AS2PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 16325231-5b7e-4048-49aa-08dc7fd00720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|36860700004|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXAxVUpRalh2VVZOZnlleVRFbk9vZ3A5Z2tnNlV0SUZ5QkhSbldSdVh2SFN0?=
 =?utf-8?B?eWNMWTBXSDZGbTNabmhJT2NlRE9LTDArdDFRcFV5MWVvZ09lY0x0cVpTeEFa?=
 =?utf-8?B?dU5PNTg0d29wZzFhaGlrOUhHSVgwNTV4Uzl1bG5vTjJwVkhNK05YbXIvNHg5?=
 =?utf-8?B?cWxLS3NZeDdOUU02MEdxbm02V3U1Rkd4TElwVkxOUC9SRGwyT05IMlRzM2ow?=
 =?utf-8?B?bHBBRmZlV3owUy84eFFwZWplOWhmRTRUbXh2ZXNIbjNRamlMSkRXejN2SWhC?=
 =?utf-8?B?Zm5yMTFqTFhxWXovcktJTFh0TTJOWC9hN2VnZzRKdUszaEtGbW5HTy8wOWhN?=
 =?utf-8?B?dEZoY09HN3RuSTE2UjRMMnNFTTFNOFJrc2FMNys2UnhUZjczSGN6eDJaTEwr?=
 =?utf-8?B?ZU9YVW8vSW16SlRKZUwvWjFDbUtlaFlrWS9QRDVJUkI1WCtxcVlvOGZlUmVa?=
 =?utf-8?B?UjdjMjdhUnF2RFVmb24xWnBVbU1ZcGpJTUZWTlRBOXFKTmc3UUJmRlRYbXZ3?=
 =?utf-8?B?NUhjMTREN2MydDNtVkdTMFFpM2ZHalErS21MWUdhRW1rZUNMblpzUnB1UmVJ?=
 =?utf-8?B?NnNpaWF3bFMweE9sRFZNWnl1MnlGMDdSclRoWjhMU2ladVFFVHRKaktQeEVi?=
 =?utf-8?B?ejZucWNzOTJ1SUhBYzVNRzRiZ1Jib3dXM0k2V3BFODcyejFDMEs2b0VSQzFL?=
 =?utf-8?B?UU1mNG9PZm50Q05FSktFSktjZjFuR0Zic3FsejFsaW1PZUhaNUVkQm9ZdjdN?=
 =?utf-8?B?Q1hOUnZCbWp5Rk5zSmxBK05rR1FwOU5yQy9Zd1AvWlpOeHVISER3eVlFOTlr?=
 =?utf-8?B?RlRVd0h3S1REc3pibkh5Y01tc3FDTk9LclRIa2xHRWFhVGtCWXpnUThVYVRO?=
 =?utf-8?B?WTNCMlNmeFh4aEdxa09BdWx6Yy9lK09hOGVWeU8wU0FQMGVqbmUzY3Rla3c5?=
 =?utf-8?B?ZVFvUEFMWHowckpBQTRXWTY5YjliYytEN2ZxNWt2bDFhL2VKeXc5K2NRR3Q1?=
 =?utf-8?B?eGUvYmtScmhlcmlDUlBPQ1R1SmpLRUZZOHVHSjNGTkQvdE5EZ0dhbXhzV3N0?=
 =?utf-8?B?MG9yVkVZWTRtang5a2MvdGVFYnF3OXVKd0U0eWJFTlQ2bmtaU2pFajEySUxY?=
 =?utf-8?B?VG9QMFY4TFA0VU5OZWJlQVNzeGtPS3poVCtrT2NGQWtVZ3ZuZzlNYVVQR01W?=
 =?utf-8?B?NGVjWWRWK01sa3I0TzdVVXVyVGd3Qko2eTNEQkRiQjZqdDZ0cFkrMVMvUUl4?=
 =?utf-8?B?UGR1ellJb2UySy9heDRoTDlMeHo2bkQvYmxaTG1pYjNsc2M1M1R5eCtoamdY?=
 =?utf-8?B?ZlAvdTZGUitic1FWV0FUVlg5Mno3TWFZLzVZelppRHRPVWRMU2VocTFBVTNu?=
 =?utf-8?B?VmRqdTlFZVF5Vis2ZGFPc014djZLQ21QUHk0WDVzdld0RUtwMHdEOUpacFBu?=
 =?utf-8?B?ODlMNVVGb1NCZVIzQmdJMmJYQjBCdkw3K3d5d3d4R09YMDArVUZRamN1NnlT?=
 =?utf-8?B?R2J3cmNzVS81S0dYS2kxSGVxczhFSldmSmRFb2h1Mm82NWVodG5oZ2QvRGl5?=
 =?utf-8?B?NWU0M2REdmRBdGVzQVVhNzN1SGUwMkc1TlNzQ2s2dHRLcFJKdDlZOVlYcDlz?=
 =?utf-8?B?d0J1U0xkZ294Q3l1K05JWE8rU0RxNlVyYUNwZW1uNk43UVd0bXo2by9QVTE4?=
 =?utf-8?B?aEJUaTQwK1c0d1M1Tnk5VUdmNUtXcWZaODlrZGhjZE1XcGxHenJVVnBtNFlC?=
 =?utf-8?B?V2pmK1pqQ00wY0F6N1pGcU1pcFNHZ2RWZHgzTngzcjFKWTYyQkpacmYrbnBK?=
 =?utf-8?B?Q0VxZnBmUktVQWh2c1VXdz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(36860700004)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:11:02.8155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16325231-5b7e-4048-49aa-08dc7fd00720
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6998

On 20.05.2024 19:25, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This defines general functionality related to registering drivers with
> their respective subsystems, and registering modules that implement
> drivers.
> 
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>   rust/kernel/driver.rs        | 492 +++++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs           |   4 +-
>   rust/macros/module.rs        |   2 +-
>   samples/rust/rust_minimal.rs |   2 +-
>   samples/rust/rust_print.rs   |   2 +-
>   5 files changed, 498 insertions(+), 4 deletions(-)
>   create mode 100644 rust/kernel/driver.rs
> 
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> new file mode 100644
> index 000000000000..e0cfc36d47ff
> --- /dev/null
> +++ b/rust/kernel/driver.rs
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> +//!
> +//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
> +//! using the [`Registration`] class.
> +
> +use crate::{
> +    alloc::{box_ext::BoxExt, flags::*},
> +    error::code::*,
> +    error::Result,
> +    str::CStr,
> +    sync::Arc,
> +    ThisModule,
> +};
> +use alloc::boxed::Box;
> +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, pin::Pin};
> +
> +/// A subsystem (e.g., PCI, Platform, Amba, etc.) that allows drivers to be written for it.
> +pub trait DriverOps {
> +    /// The type that holds information about the registration. This is typically a struct defined
> +    /// by the C portion of the kernel.
> +    type RegType: Default;
> +
> +    /// Registers a driver.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
> +    /// function to hold registration state.
> +    ///
> +    /// On success, `reg` must remain pinned and valid until the matching call to
> +    /// [`DriverOps::unregister`].
> +    unsafe fn register(
> +        reg: *mut Self::RegType,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result;
> +
> +    /// Unregisters a driver previously registered with [`DriverOps::register`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// `reg` must point to valid writable memory, initialised by a previous successful call to
> +    /// [`DriverOps::register`].
> +    unsafe fn unregister(reg: *mut Self::RegType);
> +}
> +
> +/// The registration of a driver.
> +pub struct Registration<T: DriverOps> {
> +    is_registered: bool,
> +    concrete_reg: UnsafeCell<T::RegType>,
> +}
> +
> +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> +// share references to it with multiple threads as nothing can be done.
> +unsafe impl<T: DriverOps> Sync for Registration<T> {}


You might want to check if we additionally need 'Send' due to

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=323617f649c0966ad5e741e47e27e06d3a680d8f

here?

+ unsafe impl<T: DriverOps> Send for Registration<T> {}

This was found re-basing

https://github.com/Rust-for-Linux/linux/commits/staging/rust-device/

to v6.10-rc1.

Sorry if I missed anything ;)

Best regards

Dirk


