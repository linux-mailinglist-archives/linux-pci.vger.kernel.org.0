Return-Path: <linux-pci+bounces-15446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E879B3209
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1257D1C21CBC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6951DBB36;
	Mon, 28 Oct 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Xx5spDXy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C01D5CDB;
	Mon, 28 Oct 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123082; cv=fail; b=oICzdOIIY4pWTeAi7q4uZMJZgxS/VbsiyyF5DAnrMxSVKT+6zeUquAJ57CgOAAzMtDZ/ytkQ+/sL4MeVcMLm5ngTMSduUY+PYjrgddSrfSmn+92/FU1tQF7Ay4MA4AqixKnyiz6zcJGNoyLajTEZQYgygYi6wpqSYxAcmcy9HRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123082; c=relaxed/simple;
	bh=pV2buAt8uT/anPPqcVpXVGOKiJ/SVmEZ9AaO7uGhBdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aq0p2H/mRFKNSQJk0E6SneuzFSid76Y8vvDVU+Jt3Wq8xrfQASOKy5q5LMRQ71qJsMDCK9BXz/2a1VuWReztRUhMSMiBViNcxYdmxUCv2HwMFf/VA3+Grg4Tci0CP9wWAqZfDOlJZZNLNjR2NBEgCVZlk1wW6v6vgUbpr2SLGkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Xx5spDXy; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbVj9iL2VVWtpbhLepBJlh//zBtydLbId6tlSf5/PJxTBDRHcNqtk2la3wjCpZrjeY5oUzSuHQfmiutNp35Ea6LIKRVKpz4KsgRxr72aYV/NSfN68M2LpNPdjicf3b6NTvzaNG/jLQnWCLm3X8KBHcHv+AMnDPiUyA3cMMJNe4vBA8BcecOfTFYxbx8eCC/2y884Pw060QYS9Rq+QWPR5DNre/EOjj4pm3S4xbXj2YPM0qk2h3QW7N2+VjBsTxevtB+/MdI6DvpUOa1CPCv2STXAxbHZJWjk2QtcrY5Zp2OuuWiyTWERcZtf/BgIyBC40SOWQ+o6/8awTE0kFjuRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJA86ey4kGizoNgHPqHvz7KSYHmIX+Z5gkOFQxwN9MA=;
 b=h0jbrj+BGwFANKFHk2S8poTIoawxHUC/4pR9F+fHe54NtMD28Js5t06o98qZW4ZuIesSbw5eqreAZvNIvAzxTFXHDlodJeIO9/fJ7SWxw8ayjexfb5ExnACYFXry48IanSZLrPBDFtTw2o1fm+b2tZ6jNUVCCX2mE5ShzpYa+BRqCbNRcsWMpA7Quj+sxXraKNRDqXtjv3g5JOvRLo1Y33zzqlGbmo8a2fuKa/CjT/KHECxS9GcgYwEfQlLplQnh4AugANfZgNTahtjwIEVUCkhcd52QSI1KCmaMDxRcNWR0/XDEg9kCzp/Hj6xYdua/pNbMsvC22t4pNGgk/ZEWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJA86ey4kGizoNgHPqHvz7KSYHmIX+Z5gkOFQxwN9MA=;
 b=Xx5spDXyYVS6XExnx4RFQaHnS/BgMb15GYIfgPjmF/fgRePULTgQwmmtgbzvLX20+LjCBdDpIg2FYrHU2rR28xS281zQsO74Q0LIEmhAumpKjD/fUoivO8V0nvAD5zJGrBcgXM9akqr/82MGxNfsj7A1hYtjLnUAPkxwiZjCflTUvTXXx1CLQ3i8DYvoHG3X8iWf94YtwVXJZDNRFDnp6uiUs0EwTRaKCqClOdOqyczUedJSLw7fSyq061dpJhS2Ib+7wC7svj1Ur/GzEienz/kHpCZmnlP+Eg+AQz+jA5LGofbGjzsj5HutkAhN0BntBAeKEARh6bcDEsJ8O4gkgg==
Received: from DU2P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::33)
 by AM9PR10MB4086.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11; Mon, 28 Oct
 2024 13:44:36 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::ba) by DU2P251CA0027.outlook.office365.com
 (2603:10a6:10:230::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 13:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 13:44:33 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 14:44:11 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 14:44:10 +0100
Message-ID: <ab0252ff-b2a1-4e59-96f7-134e4e38be5c@de.bosch.com>
Date: Mon, 28 Oct 2024 14:44:01 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AM9PR10MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a33a15-0204-4a01-6e77-08dcf756a825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhtRTFxNUhLOGFIM3RYODJwbUYyZTJaSWNjbTFIZWpYQmRjTUJ6Y0tGTVJB?=
 =?utf-8?B?RkNGYk5zSDNsQjV1V3Z3VnZMMHdVam44NnRXZkxXbUIyWW1mS2tIWnBWTHVN?=
 =?utf-8?B?UTQrakNENGxydkJsaVdueVR6aklhTXk2eVB5eHBBeEpuU1AybjRvMlBia0Zl?=
 =?utf-8?B?WllwL1RNT3I3Y1o4WjlWdzVUN0NsMlBKRThqNHdkZk5tTG1pTGE5dmdzNzFs?=
 =?utf-8?B?Z1MvWExFNDhSZnlUZWd5MVJ5dmRZd2hveURwWnBqSjJYcUpjSExNQlc4OEVL?=
 =?utf-8?B?cUJ3eWhTZ0k1b0xHMDlnQkJ5a0s5NWF3MldkaE9GS3paWC9xV3NVQmhSL2V5?=
 =?utf-8?B?bEROQVROcnZ2c0FJRG5vQVdmV3hQQ0pVaThOa2h5N044OFp0QnppL2R1OG1G?=
 =?utf-8?B?TXFudTFrSEpocjZsbGFucVFwZlhyaDhLOFVadXN2aTFjbnIyc0N1ZkNEQ1dX?=
 =?utf-8?B?d0R4OFlvY203TENnVElHbURtZTlqU09GMTZ1ZzFISXUxdW45VkgyWTR3RzVw?=
 =?utf-8?B?STVCRml4aW9IOGo2MkkzUGRkL3Z6VVluNDIwOXUyZm5zemhDVjRyM0N1THY4?=
 =?utf-8?B?UHh3MmJCMXBPRUZYNjVLLzlCNzVkT0tic3plbGcyRm5YeVJsc0pvbkNGQUdw?=
 =?utf-8?B?Vmcva1VZNEV0b0hmeXRrT3VBNXNINFVaTFpZRmVTZzJyZERrYytvbHN0N1Jr?=
 =?utf-8?B?OXRPSmlwZ0tOeEk2dEIyK1ZQZ2JWcTB3MkxSdXVCUURpemF5SFhwK3liMTlL?=
 =?utf-8?B?MzRkeUNvYzZobWM3eEwvSk13MlVxdVBkZXRxYmU2QXNJOG5pT2N2cGdsRnpa?=
 =?utf-8?B?SEtaY25Kc0JEOTh0ckpSSkJXWERLb3lMUkUzY2NuVm1TTU1jMjNpTkI3SWVI?=
 =?utf-8?B?cFBnV0FPdDBBQmJiVlh3OFkwZ0tVRWkxOE96bi9YZ1dLNjUxY2tZY2FHSGc3?=
 =?utf-8?B?SzNqOGZxZC9sQnlhVnZ4Uk8vZUtqZTAyNC9oMkg0YlliUFNaWlpqdExnSUIw?=
 =?utf-8?B?MU1uSFdIb1ZnVHBHQVd5a1VrZ0tXRzRmMnFneG14KzIwdnp0aitlbUJ6OUIv?=
 =?utf-8?B?VW5URXRwM3ZYRFlZaXpST2cwUnMwZVNyemFybGdwV0tVOU5YWFFSQWdqWFBr?=
 =?utf-8?B?eEVQL2FKekFVRkRlZnpMU1BxdkdqdDJWTEtJbU1uY0pGWUxKRFVIQVN5TENW?=
 =?utf-8?B?T0dzWHRxak1ydGpuWEQ1bDZ3RUxmRUxFQm41MTVFOHhQNGxNbGxiRzdMOXVF?=
 =?utf-8?B?QnFHOU1tYURxVm00aE5CZ2E5TGp0cGVmdGhMNlBva2RIL3VaZUo5bytXNm1U?=
 =?utf-8?B?dVdpRzNXajZMU05GK21JODdLRzBzNTRGVmNxWVZpckw1a0J2SklSaFlTS0Rp?=
 =?utf-8?B?MGwzdmJNNFBXb3BHSkNjQUxCdWFPd3hCUFVhV1F0MGNNMlk5b25DUEFjNXRD?=
 =?utf-8?B?RW9nV0NUdTRldXo5M1BoNUpCb0pSblRsU1ZqaitqR3d6TTlSWVFYcUhwNjVY?=
 =?utf-8?B?UksvdWNyMlJ4bUxjeTlRWG0zNEZuYVNpb0VmMmhtVGM4cG9RN0lKUy95ejVi?=
 =?utf-8?B?a3FWSThUTXBFWFlPNFBDQ2kzelJYYjVSeFdUa0ZGT2pYMGlkVEV4aUs5Zkpy?=
 =?utf-8?B?MkcyZ3NJOC9qOUxUbUFIaStaTXFBWE1YNGtpRDh5STZlSXEvM1Bhdk8rUDhY?=
 =?utf-8?B?dmZrS3p5TG5QbXViUWVLRGFzZEJ0SXpmOW9seEErQVR5ZkU3VVNlL21WY0tU?=
 =?utf-8?B?SkkyRlIxdDhGQmczc0ZYVzZ0ZFlqbTVWeE9JOGdCK2h0K210VkFTT3pUZGhm?=
 =?utf-8?B?dE9FRVNpR0lORFFOTzE2N2xMajA4ZzRqZ2tqcTVwSDk4NjlSVGRUOGFKb1Y4?=
 =?utf-8?B?SmFTL2tLSkRoSUp6Szl2ZTlEeGRHekFrdFNMUmpNVDJockl3YjMwcjU5N0d1?=
 =?utf-8?Q?oldAn7PFp8o=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:44:33.9103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a33a15-0204-4a01-6e77-08dcf756a825
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4086

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
...
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> new file mode 100644
> index 000000000000..addf5356f44f
> --- /dev/null
> +++ b/rust/kernel/platform.rs
...
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
> +///     <MyDriver as platform::Driver>::IdInfo,
> +///     [
> +///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
> +///     ]
> +/// );
> +///
> +/// impl platform::Driver for MyDriver {
> +///     type IdInfo = ();
> +///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> +///
> +///     fn probe(
> +///         _pdev: &mut platform::Device,
> +///         _id_info: Option<&Self::IdInfo>,
> +///     ) -> Result<Pin<KBox<Self>>> {
> +///         Err(ENODEV)
> +///     }
> +/// }
> +///```


Just in case it helps, having CONFIG_OF_UNITTEST with Rob's device tree 
add ons enabled adding something like [1] makes this example not compile 
only, but being executed as well:

...
rust_example_platform_driver testcase-data:platform-tests:test-device@2: 
Rust example platform driver probe() called.
...
# rust_doctest_kernel_platform_rs_0.location: rust/kernel/platform.rs:114
ok 63 rust_doctest_kernel_platform_rs_0
...

Best regards

Dirk

[1]

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index addf5356f44f..a926233a789f 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -112,7 +112,8 @@ macro_rules! module_platform_driver {
  /// # Example
  ///
  ///```
-/// # use kernel::{bindings, c_str, of, platform};
+/// # mod module_example_platform_driver {
+/// # use kernel::{bindings, c_str, of, platform, prelude::*};
  ///
  /// struct MyDriver;
  ///
@@ -121,7 +122,7 @@ macro_rules! module_platform_driver {
  ///     MODULE_OF_TABLE,
  ///     <MyDriver as platform::Driver>::IdInfo,
  ///     [
-///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
+///         (of::DeviceId::new(c_str!("test,rust-device")), ())
  ///     ]
  /// );
  ///
@@ -130,12 +131,22 @@ macro_rules! module_platform_driver {
  ///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
  ///
  ///     fn probe(
-///         _pdev: &mut platform::Device,
+///         pdev: &mut platform::Device,
  ///         _id_info: Option<&Self::IdInfo>,
  ///     ) -> Result<Pin<KBox<Self>>> {
+///         dev_info!(pdev.as_ref(), "Rust example platform driver 
probe() called.\n");
  ///         Err(ENODEV)
  ///     }
  /// }
+///
+/// kernel::module_platform_driver! {
+///     type: MyDriver,
+///     name: "rust_example_platform_driver",
+///     author: "Danilo Krummrich",
+///     description: "Rust example platform driver",
+///     license: "GPL v2",
+/// }
+/// # }
  ///```
  /// Drivers must implement this trait in order to get a platform 
driver registered. Please refer to
  /// the `Adapter` documentation for an example.



