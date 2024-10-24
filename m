Return-Path: <linux-pci+bounces-15189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC139AE031
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D681F22085
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90FC1A76CE;
	Thu, 24 Oct 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="KGJ40yJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34857A932;
	Thu, 24 Oct 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761137; cv=fail; b=YyrXjeXeDTUP4bQl4nni3cXFNABOsDE179rbkbZ8BvNCzDndoyGm2y/g7yXmbSTEnCMol0oVTbGy0jB9Bh3iJ+zni6S1H/RrAgN4fjRUZPNLzHLS50EqyA+P+AoYG739pS8Jd+DLVah3fcgg8YUf9hLVKPV0IO8tD/xtl6htap0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761137; c=relaxed/simple;
	bh=8WPKuqfc4ELCsFUlNX5dm4vJPiCQB0YO2H/EHaUaggs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eGjBjT9LZnCcGHwhlT0J9Eb0gRXvlORgL0xwN+wbyO6cm1EMlrswAHbV/upnd5Owk26Stc6dt7RiHY4cxOLltd9RSDsBb7MPEKo9OG/qadq0Q7xv/z9ch0mtbqwIXHFJ8ge4lmIQoK9zAOy8pnkfc8NfqsTcQsfv6pbUocba3ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=KGJ40yJU; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Byy8aOVHDFk1mFdPB3j/4XN6hHgSo6n2pudtKOAjqoD3melcJB6gObhFDRzP8R5PQ2SjBdhgtaQ/xaZtZnIQPstqg+IUBXkN5R9dJOFdTyhOqz8PvsBrYiM+H0uUt5lldJT4lAYlntpGbuptppJMPQQWm4vETmgfEwtgXD35/J+6sTvhqLXl2GljVTH0obFLKAueqr3wq37EqGcV8dln7bSlIExGdsctnpADhnqQ/9vcDouB6RtHMHsHJnHbrKvVmF+PxiUmeNxLCqJwMff4/rJFwItasrjQNl5At0/bR8pE1s3vkzJH/7BHHkQH+aUec97ZpJdqauyr6EIAmJBUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZh3e+Ira8Apm6k/o0B87bcX7wVevkCEfJeY3OA5KFU=;
 b=jZgClk09s60McsTJEhn9XMTxD16IWhDYUY1jZOKEKkeaM7BNK+1YUWQHqLkSrHmiOtc2q8LsLK/3mb4x5SEdDfudoiEL8+6YN8HVvib+gpZBQCHpESkKDwp3B+wcT9VuvPxbHzI5jUAcLUbVrVXG8dVE+FnZjOP4jmq2Fd6UnDJTPsKQVYfYl6Ee0mLvP/lHYYB3vLEiZY9KyIJRch47h4WInXczotNGokisZLKmxwhUwSd0C4wjxjneQEFkW39rpig7UbdIeO42hYCL7OnptQZnP7KJkdosT1njZIu+L6IZelPadMwF3A5mqUaTPsVgIV0MdhWTK5aGTrMV8Fllcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZh3e+Ira8Apm6k/o0B87bcX7wVevkCEfJeY3OA5KFU=;
 b=KGJ40yJUIDpp7VGKbwXK2nLAuw2gxqbHlnqp9AJ8ZGS0pMIbSGcK2DOiSi8bn1E6p1ChwB0f/VLQVHa+6PGAeDea3QiaW69B7q2D3osIMIiKA3UanGK8wAW7jUX08o+M8D9g5Cc6xan/7CfFD5Y+023vWRVjFYWPFnJE3NE6xVXa/sglOHscqwF8MjbX/dAvj9hGoCj2TrDSz2JFNuCUlbKOeNCchc3CscjdkZ3soxh6OZw+tNrXCGVrRvJjU7IiRZnBBCgJ9MZlPOI0d0edPpp6bquoJNtdu+FevRf6qi37BlokxNFsE6ZFWXnZUnppRWg/lSmRTvyIlEhVJ54Fow==
Received: from AM0PR02CA0119.eurprd02.prod.outlook.com (2603:10a6:20b:28c::16)
 by DU0PR10MB6273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 09:12:05 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::d3) by AM0PR02CA0119.outlook.office365.com
 (2603:10a6:20b:28c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 09:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 09:12:04 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 11:11:59 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 11:11:58 +0200
Message-ID: <42a5af26-8b86-45ce-8432-d7980a185bde@de.bosch.com>
Date: Thu, 24 Oct 2024 11:11:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
To: Danilo Krummrich <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <bhelgaas@google.com>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>, <tmgross@umich.edu>,
	<a.hindborg@samsung.com>, <aliceryhl@google.com>, <airlied@gmail.com>,
	<fujita.tomonori@gmail.com>, <lina@asahilina.net>, <pstanner@redhat.com>,
	<ajanulgu@redhat.com>, <lyude@redhat.com>, <robh@kernel.org>,
	<daniel.almeida@collabora.com>, <saravanak@google.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-16-dakr@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241022213221.2383-16-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|DU0PR10MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: d25c49cf-ee82-499f-d627-08dcf40bed9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWd4TVhRbDhpc1FDVUJxNWJXMTZYaSt0cFEzZUdRdGpuSitXOGNZV0h4V21z?=
 =?utf-8?B?alNjNFJKNWZjaE8yQy9MbEtGYXRXOEx2cXU5SW04L0lBbWFSUkxuVm1Xdk0x?=
 =?utf-8?B?N3BSYW5lSTYvanRtV01tMFR4cE9nZE9QZWdNeS90NURYWXBySmJvbDNjRFlV?=
 =?utf-8?B?c3hZWHBBVzBMZ3FSdEFHVkNZMEhSYVkxRHlaM1BWUVovSTErRkVqb3VqVHhE?=
 =?utf-8?B?cG9uS29yc2R4bEFDanhLdGVGQkNrcXdXcTI3QU5kT3ZKYlRHajhiQy9YWkk1?=
 =?utf-8?B?R1huZTZibEpkamErK2NDM1FGY2o2MmZBTzBrN0tBMmkvczF6NG1iV2owZU5j?=
 =?utf-8?B?TjFvM2RxbHpZbENySyszVEFYMHhVbkdQSFNjYTlGQTBRMDlUQkhzZkhzblJr?=
 =?utf-8?B?TkdIRHFZendjdGlXQUxKbmlmNUhEWi8reGdIdWV5STN3YVhvd0xVbGc1UVpr?=
 =?utf-8?B?cUUwU3Z1bktVUVhmUktmTlNUQ1AveW9XeWxmODlkcWtJWElyTVk5aGZiZ3Jr?=
 =?utf-8?B?NzFDSjl2a1p6TjIwYndiSTBmRjJtcDhHZXZZUzdwNTljalM4RkVqTkVQVDBE?=
 =?utf-8?B?VC9yNVBrSEFKRTVmRTQyZG5HcCtaRnZTR1JWRFU5L1FzK1dSM1BnaVdwWnF0?=
 =?utf-8?B?bm90cmZsRzE3b3FLN2o5d3pqVythMzRLZ1h2TkRab3ZSamorZmtzb3JXYUNq?=
 =?utf-8?B?TU1NNHJ2bzdTeG5yNFpGOHN3K05EUmt5TGU4UHU3OUloMDJ3UGZhNmZLSjln?=
 =?utf-8?B?dzJUL0F0aXBBSVdyT1hGTksveXJEUXFBQUozREZTWC9LUG95SFNUemhUajhw?=
 =?utf-8?B?VVU3ZFgwbVhiSFRzWWpTSmRDVlJ3TCtHcERqM0xXMDVia2pNajN5QkVIbnky?=
 =?utf-8?B?Rko1elJIZlR0emhLNkZHRXVob2JVOFBIU283SU45cm95Q3BPZUUvRHVHQVVk?=
 =?utf-8?B?K2lsY1R3a0hpTnVLNlN0UnIrRVdPVG1oaFZZTjFXdEExQkFSdDVyN0R1UElU?=
 =?utf-8?B?TkVNYmZoak5WK0oxUUo2WEdqSFhXMUxFZWk3cjJIU3BETWlja292dDZ0bnRW?=
 =?utf-8?B?aE05TlRmTFRDQTBtYVpvVkE5TFllc2UzbHdFMTQrYkZHS3BROURDMFc3ZnR1?=
 =?utf-8?B?dWRSbWx2Zit6MG5GWEtKTGhaa2hLb2Q1UjdkOXJNQktpVDNUekhNR1lxMWhq?=
 =?utf-8?B?QzBvdjd1NXE3RUJrQUh0RWEvcFJzZGU5ZGh3TUZCVzBiMUtLZjA1cFlxcEJY?=
 =?utf-8?B?dFBrSmgranNpQlRWYVRCd1V5a1p5aVhORk9ITktCcXA4MSsyc1N6VWZlVmJG?=
 =?utf-8?B?bm5NeHN6dk5NNG8yZnBLWHZ3YkFYK1c0SmJJemIySU8rRnZnM3dNUDBHUUI2?=
 =?utf-8?B?SFRTRUQ2TWlWcGZaTEUzMkZWak5FMURMeW1BV2JBQXhuZkRlbEh4NzBNa05B?=
 =?utf-8?B?MEp3WFJ3WlR4UzltakNoRy9hWVBOWjVDdUE0bDhmUFh4Sm1LU0EzeFI4U1o3?=
 =?utf-8?B?ZU1adnZYOUhtTHlsbDV4Q1ZLRW94SzlEckhkTHIzYmQyS0YrRlc0ZHdLekpH?=
 =?utf-8?B?TUtZcDJ3eU9KQVNaRkpvenRvbXNLQ2Q5VHZRS2dkaEQ0cFR4a1EwZUYraEdE?=
 =?utf-8?B?djFCMjNWUkxXMGlwRG1KTFA0TW8vR3BGV3EzRytFUE5wUWRZVUV3L1VZRFda?=
 =?utf-8?B?ZmNQT0xVYm1BQUhaWXRVVlJaYi9UdmJXbGEwbW02anpXZ2ZqTmQ0Q0pOQzIz?=
 =?utf-8?B?NU9DMk80bjFmMVVxdXZidkJPbVdLQWlRVzRhZnNoSDJTQkkzZXU2cXh4Rysr?=
 =?utf-8?B?aFd4SG50VTVyN2EvWXluQ2xWTVZlSHoxZ1FuNEZ3RmFXbVZVWXJQbnNuK05z?=
 =?utf-8?B?bnB0a0lRZGxlVjc2L0x5YlBlUWhQdkFWYjdkS1FIM2Fra0VtRWtxK0srbXBR?=
 =?utf-8?Q?g6avhAbqCzY=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 09:12:04.7439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25c49cf-ee82-499f-d627-08dcf40bed9c
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6273

Hi Danilo,

On 22.10.2024 23:31, Danilo Krummrich wrote:
> Implement the basic platform bus abstractions required to write a basic
> platform driver. This includes the following data structures:
> 
> The `platform::Driver` trait represents the interface to the driver and
> provides `pci::Driver::probe` for the driver to implement.
> 
> The `platform::Device` abstraction represents a `struct platform_device`.
> 
> In order to provide the platform bus specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is implemented
> by `platform::Adapter`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>   MAINTAINERS                     |   1 +
>   rust/bindings/bindings_helper.h |   1 +
>   rust/helpers/helpers.c          |   1 +
>   rust/helpers/platform.c         |  13 ++
>   rust/kernel/lib.rs              |   1 +
>   rust/kernel/platform.rs         | 217 ++++++++++++++++++++++++++++++++
>   6 files changed, 234 insertions(+)
>   create mode 100644 rust/helpers/platform.c
>   create mode 100644 rust/kernel/platform.rs
...
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> new file mode 100644
> index 000000000000..addf5356f44f
> --- /dev/null
> +++ b/rust/kernel/platform.rs
....
> +/// Declares a kernel module that exposes a single platform driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// kernel::module_platform_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     author: "Author name",
> +///     description: "Description",
> +///     license: "GPL v2",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_platform_driver {
> +    ($($f:tt)*) => {
> +        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { $($f)* });
> +    };
> +}
> +
> +/// IdTable type for platform drivers.
> +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<of::DeviceId, T>;
> +
> +/// The platform driver trait.
> +///
> +/// # Example
> +///
> +///```
> +/// # use kernel::{bindings, c_str, of, platform};
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::of_device_table!(
> +///     OF_TABLE,
> +///     MODULE_OF_TABLE,

It looks to me that OF_TABLE and MODULE_OF_TABLE are quite generic names 
used here. Shouldn't they be somehow driver specific, e.g. 
OF_TABLE_MYDRIVER and MODULE_OF_TABLE_MYDRIVER or whatever? Same for the 
other examples/samples in this patch series. Found that while using the 
*same* somewhere else ;)

Best regards

Dirk



