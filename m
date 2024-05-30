Return-Path: <linux-pci+bounces-8067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA08D452F
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 07:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DF51F21E4E
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 05:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97FE142E96;
	Thu, 30 May 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="e9kQC59G"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1B142E8C;
	Thu, 30 May 2024 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048740; cv=fail; b=H8FybejQM4QUabRl+svbZZI1OvS3LMJ11HF54sQpsW6VaRrceZ6iOCQyw2olLQOnL9QQeNPmk7sWk2HH5YtZioX08zPOiOCDPYLOpHdOeAuwUg6+4MipoQKrIbqECd5pYH2WjnFdaC0SNjZWCPfbl9aSKzrLT9svEB4p8oXf4ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048740; c=relaxed/simple;
	bh=3IjoqU1iZjUHDmFN0iuoaRpJ97lmCCdJuDVihgTVCpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RiL2bL3nRw4gPm8Diguk1ztOR4t4u8JxYGyor8L4aSn8kuELNh4AcwFxOd5UBSisqCNkz6L3DMLQU/nF78yVP2LmOUvsEKR6LXP1LAaBsuuOqakedHd+xkjK//ZmC49031nrwdt8rrrYtrfd0ui3mwQH/lsALy7C6CDRzg8ziPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=e9kQC59G; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X59SxuOyqWRJj/jpOhlOjX4yiseBWzLjmXJzZ3QpItKdyf5XpIf95yh8x6TW0T6mFLC6Zd4rEZjoZ+Wyn2e51HwRtU7le9SQiG0aVQVpxXzcA7cG/T+7I/Z15EN4IyKkXRiaamPocQ0OocRJxDPlZOCy/OdSo8ek5a4nBIl7GDn0sS+3CGhLt7mD2c5+nfnOjGcksKuwpDxKBO4iK3Ey/Zj42Ckrrbr51uDJ012SRS/ZrC+ke+mqc+3Awf87pd7gkgC0zA1CxuxsIVSfchCNAtFBwkVphWjvi09h7AR+/wvMJxHLU6Qg8DzjCZFv/Pv9BAR54kXzjEXEOZJxCGIavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Six0rx9M6uBQ4xVN+dsG5EpITI6rCgK6jw6kvfgajTM=;
 b=HbUVX+DX0sCnvvedar+KBr7Jc+FBBxRuJ+dpiqkLXpmEmQVg/eM23lKcRffxJrYCr/iy/PnjxBOtdj7dfaxE0yvLeFk2skVJo0VIdGhJbj6PotEFCfOL90RBujsNn0jyeguT4aG4QwTZEjgk5hbV/gz15qIM4cmvqMcUPlqeBXOxnUCRUv7homy7lRXsWvuM4XkPYn6e2SrXs63zjgXE+khnRn/j3qQtSMnrjJECjyxGo/OjWZDj8NvypcXMlWLpKjWgfJBEBG70DgYnCP2CvVZXNxL2kkzJrdSysbvuOduYw060VPWEbWUuZ87nTp0e8By9j708Az2f79xRut+wUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Six0rx9M6uBQ4xVN+dsG5EpITI6rCgK6jw6kvfgajTM=;
 b=e9kQC59GCwY02ltsYqMkNCMgXxE/UvVIBckexRjIBv0ENH5X5s7Gz0ZgbvvIF32SBe2FsLrDXXHyh1AwRKnWOJEEJS1PrzDepCyhM9DQfyY0N4w78FHY3XxeFwRE7XHND0WHHf1Qwsx/AE0CvZtRaV4dC/fNpGQy3SVjtBVJx1MqRTYjO78j4qla91PYJLm++5IyytzDHzVFiPNJLx8IEbovLBWObReTwYi73PaCbo8OnsF3WnT48Ayv+dC0LoYZJoJ4g2eS/DyM5dqZG8HeoCkASAwpCnpbrNQThQL/+PP//jjXtzpVvXg3clgpG8xvY4HLCuUiozlze1Mw0gjbZQ==
Received: from DB8P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::16)
 by PAVPR10MB6961.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 05:58:53 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::33) by DB8P191CA0006.outlook.office365.com
 (2603:10a6:10:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 05:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 05:58:53 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 May
 2024 07:58:48 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 May
 2024 07:58:47 +0200
Message-ID: <393a0a3f-9142-47c1-8422-40abd688363b@de.bosch.com>
Date: Thu, 30 May 2024 07:58:36 +0200
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
	<ajanulgu@redhat.com>, <lyude@redhat.com>, Fabien Parent
	<fabien.parent@linaro.org>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|PAVPR10MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: bbced7f9-2dba-4be4-330c-08dc806d95e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkpzRkVnV0tEcU9GOVNub3oxY1IzR0IxR29mK1pZOHNXQ2ZEYmVJK1pXR0l2?=
 =?utf-8?B?SmVSZ3VRSEJ3UFRmYUtWQWQzVGJMbDdUMDVaS24zT3BJL1ozSnlYMjZJc1kx?=
 =?utf-8?B?YW4wZElON1ptbWtjMWZuZ1ltUjRBNVNXY0JCTzlEVkJmWDBjSzRlWW8xUVdo?=
 =?utf-8?B?UFdUOXB5UmRuLzdvRytkNEpJTnM5ZWpHbGVhZStrOWhJd1Y3eW5WRXlucHVY?=
 =?utf-8?B?RTUwVGZzakxIelkvNnpGYUE1dGtSQ05pYXVSR1VOY3BoNGFWb3ZuaTBiRDJQ?=
 =?utf-8?B?dWxpdENCWW4vNlRERDNaVTdwUDJRNVJmb0Jmdm5rbEdYazJGSDRndmM3djQ2?=
 =?utf-8?B?bmR0SHJQNCt5M1VNc2JwbTB6SHlaS2t3d29Fd1BjKzNTb1VuZGRwQ0lyT2hL?=
 =?utf-8?B?RVZsWWxiak1Jc3Q2SXhacGJueVg5S1RnaFlXaEJ5ZWh4SkcxY05JSTBmV2xX?=
 =?utf-8?B?K2dwQXA2blZJZ1cyanhobXQvMFU1ZVdXTWN6VWZBaWd0TUR0eXY1S0ZwWWZO?=
 =?utf-8?B?bnRZbXFsWEhoQ0dvZk5RSGhoZ3dHM0dBbEdyYXladlpNWTRFdi9SRUVYNE1E?=
 =?utf-8?B?K01QaXA4WDYydUlOZVpDdzUrVEZ4VkpoMEFINzBnZm1nSTROanNWUkcwTXow?=
 =?utf-8?B?Ujc2K2k0N21vc2Ywb2phSm56eEVBS25rSTA3L2lsek5QRUFNaE1GdC9IY1Ny?=
 =?utf-8?B?cGlvQ3doQjk1TCtxNnBSZndFUE8xMmQ0T0FmT0ZiRllNdjZEUHFISUZ4NjZt?=
 =?utf-8?B?em1iRzlBUTdGbEJ6cERxQVNRY3hCVDkxN0JOR0pXVzI0bWV1R0RTNE8vTjM2?=
 =?utf-8?B?SzhRdmxmUDVXY0RibXc4ZW8ySzVaazBmemR5SVBvVE8rcU15TXVRckZ2aE43?=
 =?utf-8?B?QlFTUytnWGJUQWVtYlFpRmwvbjNHcnROVi9vZ2NIdS9NUXByaFdQNkRTYklv?=
 =?utf-8?B?U3FrVVJpOGtMdGJHL1BuVW9JeE15eXQrbEdFMngvN1M3OVJVT2c5RDdTYlcy?=
 =?utf-8?B?NTVsUjJSN2M1a0ZzcjFkK25hNzgvbmI5bHNrTEVITllMVE9Wa3NHOHg3SlNU?=
 =?utf-8?B?ZmJGU00yWlRmbkRTYVNjbDdabmJsUlRCaDJBMDhmaU9DZHZURHJvdmZWTGdj?=
 =?utf-8?B?bU4ycU5LYVZiV2lhc1o3bTNjTllEZTJyZXNnU3ExOWplblBpR0k5eEhMalZS?=
 =?utf-8?B?RzVqN3FTNXpHZmlLQnd2ZmIxVjJ5Rmp4NlB2VGdET2ovV3dBRnZVeHRZZEhH?=
 =?utf-8?B?MGF0RDdPZGdMV1l1aWc2ZkRWWG1OZGQ0VzJyWFlQQkhaUXRMbmE0bi94djVM?=
 =?utf-8?B?WFVHMGpCaDZ4V0dHNVpXM0NXTzhmc0RRWUUrMVBWaEF3K01WenBXQmkycnd4?=
 =?utf-8?B?bmVoYmZHRXQvMEFnWnAxZ2xRQURKL2EyZlVya3BiUWVZdUQyNXVIdTZSaFlO?=
 =?utf-8?B?a1lEZGRBbVpJMG9rRWFzSEV6bVpWQmVLekNVUFJWck5sc3Z5RWNEeVZaQjJX?=
 =?utf-8?B?TUZvS3JWbU5iakFIMEtqVHZRcExsMnNaOGhpZmRDcUI4Z2Z2Nys2QkZrb1VR?=
 =?utf-8?B?SkgzYnhpWGpQYU0yVzZVdGhOY1F4L3hkR09hK0ZnMWhRODBTaWt1SEtyRGJj?=
 =?utf-8?B?UEkrMk9rbTNWZEdEOXZwdjZHZHEvRjA0YkFHaXU4K2xDU1RmcFRYN0xZMk1u?=
 =?utf-8?B?Zkx5bHQyekg0WFUraVR0NUVSWjVxR2Z5U1hnNjRPY0FzQ3J5VkxFZ29EeThB?=
 =?utf-8?B?RFR0eGNEcXpNbWxNTGovaUUwN2JQRVIrTWYzT1RDa0ZVNDd5TU1SSi9OSi84?=
 =?utf-8?B?VEVBN2RmQ09vYUFqWG9Hdz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 05:58:53.3446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbced7f9-2dba-4be4-330c-08dc806d95e5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6961

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
> +
> +impl<T: DriverOps> Registration<T> {
> +    /// Creates a new instance of the registration object.
> +    pub fn new() -> Self {
> +        Self {
> +            is_registered: false,
> +            concrete_reg: UnsafeCell::new(T::RegType::default()),
> +        }
> +    }
> +
> +    /// Allocates a pinned registration object and registers it.
> +    ///
> +    /// Returns a pinned heap-allocated representation of the registration.
> +    pub fn new_pinned(name: &'static CStr, module: &'static ThisModule) -> Result<Pin<Box<Self>>> {
> +        let mut reg = Pin::from(Box::new(Self::new(), GFP_KERNEL)?);
> +        reg.as_mut().register(name, module)?;
> +        Ok(reg)
> +    }
> +
> +    /// Registers a driver with its subsystem.
> +    ///
> +    /// It must be pinned because the memory block that represents the registration is potentially
> +    /// self-referential.
> +    pub fn register(
> +        self: Pin<&mut Self>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        // SAFETY: We never move out of `this`.
> +        let this = unsafe { self.get_unchecked_mut() };
> +        if this.is_registered {
> +            // Already registered.
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: `concrete_reg` was initialised via its default constructor. It is only freed
> +        // after `Self::drop` is called, which first calls `T::unregister`.
> +        unsafe { T::register(this.concrete_reg.get(), name, module) }?;
> +
> +        this.is_registered = true;
> +        Ok(())
> +    }
> +}
> +
> +impl<T: DriverOps> Default for Registration<T> {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}
> +
> +impl<T: DriverOps> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        if self.is_registered {
> +            // SAFETY: This path only runs if a previous call to `T::register` completed
> +            // successfully.
> +            unsafe { T::unregister(self.concrete_reg.get()) };
> +        }
> +    }
> +}
> +
> +/// Conversion from a device id to a raw device id.
> +///
> +/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
> +/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
> +///
> +/// Originally, RawDeviceId was implemented as a const trait. However, this unstable feature is
> +/// broken/gone in 1.73. To work around this, turn IdArray::new() into a macro such that it can use
> +/// concrete types (which can still have const associated functions) instead of a trait.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
> +///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
> +///     that buses can recover the pointer to the data.

In his I2C branch Fabien has a patch [1] [2] to remove the 
RawDeviceId::to_rawid part above. Maybe it could be aligned that that 
patch isn't required any more?

Best regards

Dirk

[1] 
https://github.com/Fabo/linux/commit/4b65b8d7ffe07057672b8eb89d376759d67bf060

[2]

 From 4b65b8d7ffe07057672b8eb89d376759d67bf060 Mon Sep 17 00:00:00 2001
From: Fabien Parent <fabien.parent@linaro.org>
Date: Sun, 28 Apr 2024 11:12:46 -0700
Subject: [PATCH] fixup! rust: add driver abstraction

RawDeviceId::to_rawid is not part of the RawDeviceId trait. Nonetheless
this function must be defined by the type that will implement
RawDeviceId, but to keep `rustdoc` from throwing a warning, let's just
remove it from the docs.

	warning: unresolved link to `RawDeviceId::to_rawid`
	   --> rust/kernel/driver.rs:120:11
	    |
	120 | ///   - [`RawDeviceId::to_rawid`] stores `offset` in the 
context/data field of the raw device id so
	    |           ^^^^^^^^^^^^^^^^^^^^^ the trait `RawDeviceId` has no 
associated item named `to_rawid`
	    |
	    = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

	warning: 1 warning emitted
---
  rust/kernel/driver.rs | 2 --
  1 file changed, 2 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index c1258ce0d041af..d141e23224d3db 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -128,8 +128,6 @@ impl<T: DriverOps> Drop for Registration<T> {
  ///
  /// Implementers must ensure that:
  ///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the 
raw device id.
-///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data 
field of the raw device id so
-///     that buses can recover the pointer to the data.
  pub unsafe trait RawDeviceId {
      /// The raw type that holds the device id.
      ///



