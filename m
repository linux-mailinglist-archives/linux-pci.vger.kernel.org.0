Return-Path: <linux-pci+bounces-8108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CB8D5CD5
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 10:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9363C1F22241
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC01514E3;
	Fri, 31 May 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="sKIM6G6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083814F9F9;
	Fri, 31 May 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144563; cv=fail; b=dANZHARqG8kMa1nHH7p4hZ3imf2ejr3GTUvgTsdLvAI+iHMDxBTth65mOvkG1YswZxMa1foBGekM0/R+pTqPgsgZucbOgvrm5H+/SIKOvXw2j3xYEOG70gwfbWXIqheZbF6jm8dGEra0jtbaS+QlVCgezmSqHQNZ+mqN3vYaxYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144563; c=relaxed/simple;
	bh=KklarpOiiIqqDhsmxtmSJPZNqcSKrY2BgIpQpqgWZig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LsXdvNq+yrhDXi0qr83BaFJxFyv8ciF8Bw6/g+0JnpicMcwKdGwVGOGJMLSEbUL1I+aY8Mz9o6jsokHx4JW0Qwtb307uvWe7pMLNqEfvPFmCHx4702XLIZtabil63Yz/EyzyjpsU4mMbZuSCy4/ouPsZWc41mwkOqoU1M9ot1FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=sKIM6G6W; arc=fail smtp.client-ip=40.107.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7gJnVz0XrRgFQEsB3RKCjKHAF/2nvDwpqLVt81sBo0RRYXnzNfBb2g6kS2NxdO0Io4NR3Wo1zsqMcKimWONYZGE4J2ZNfS15lu1FIW3bAM1TKKQXtj1hmFRW1QJg6Wa44ZRC/Tjz3JzrU3EgqW0RKDz0FdTXKWNQbGph/Hg4VAhU17wx6Mk7wLARqtWCUODKZf5UvzCxwb0L5kSEOcjCQnvB9yAC13xm2vqIDsjkuiDvWT839hn5JM9IxKP2VgIXeRVF6oNmfW1oB0vPbzed7fSW8SmwiYh5rouVHAXZSt5GNuxBHjtSRwjSqtne2+Tjwos4uVox4i94RctaisYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmS+E6WGFfUm0ZLVmaJK08+yN75qeoY93Jm0IrhoaWc=;
 b=Sm08FMqGcbCzB3ldIRHguOFo8VxbypjTgUS0DpSWh5RLxzbqtrI9A0YqaWCn0i42VS669FlUuCbQd2ZBc8dDlNuiLrlgSJKkupdUog0B0AHZRKg+9mBjruLKI0MidczPf8ctV2ygdB0Wv7rfE+/rStLitZfAlcAFCn3Zg04MBjHXITybrJP06m8dbwEXQCEt+/yQw1M//GVoPxYV2V3DoeHkbjHBOHQnjDUrJ11aiEbSu3ooF0Jzoo4qoaObq69VssjKUOVaBi3KiDep32GsSsUDrmVVBqb3+ELoj5vWnNghT0znESlskCSCdikYUYzWc5GBwJv5TabABf7TINeCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmS+E6WGFfUm0ZLVmaJK08+yN75qeoY93Jm0IrhoaWc=;
 b=sKIM6G6WO9dsg/ZMVYQQ9SCbOx5ZVWXiXBzfGR4XN+GGx80OHDuoBAoIXCsaCbUj/UNS+hbbaTx1qxpIL5soGB9/KLStyp3BP7YU32WzbmzEh4/odRAv903emXIfDHadihpL0UbnIbiV7FzgfiTL61bddbIqL0/QNbBuZghhzEBuKDoPFRdqspONrJkOXngr/JqAT8TeFW0KMFCGCPTBJTRfA1ev/NZYZLex+67INlOk46ZoEX1fv8AYRlL8VVOsjDKLwUyOB9nSVLSaEyOgJ9fluBTtjrMNRfmTP+SRVIJT6jljnlorks7m96sPbTuJBQjSPFJg2GX6qvx//aKmqg==
Received: from AS9P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::13)
 by GV1PR10MB8027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 08:35:55 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:50f:cafe::b2) by AS9P251CA0011.outlook.office365.com
 (2603:10a6:20b:50f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 08:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 08:35:54 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 May
 2024 10:35:46 +0200
Received: from [10.34.222.178] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 May
 2024 10:35:46 +0200
Message-ID: <f397640b-23ed-412a-a1ac-59b7c56e5110@de.bosch.com>
Date: Fri, 31 May 2024 10:35:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] rust: add revocable objects
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
 <20240520172554.182094-6-dakr@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240520172554.182094-6-dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|GV1PR10MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: cb294c52-74b4-42f7-d3d3-08dc814cafd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFArelh1K1daSlNMZlZPTW04UWNtOENTdTJYa21mTW9GN3gwWkE1UDFiakFT?=
 =?utf-8?B?QVJjTE90aDQwZjU4UUVvZWlPaDltVVBGZUFGTFJZRVQxMGlBQVI2NTVnSHNT?=
 =?utf-8?B?RHB2N2RNQ2dPa3I2L1hYSnc2ajR2OFZ5Qk5maXYzL1Z1ekJ0UTJOR0g5dWRn?=
 =?utf-8?B?VU1EYWR2bVVaZWJSSk1OcGsxTTRrRzFTRksrZDByTzMzMVJUazZ5SW1QWFo2?=
 =?utf-8?B?a2RUQUxGRmI5V1FjNW5seHhZa2F5YmJrSC9OVWJ6ZzZ0ajF4dzdrQnNiMFFP?=
 =?utf-8?B?R3U1bTBCYVhiYzdpc0hjYlVLRjVXYWxjVloxVU0wN1M3WTJyNlpub1MrYWlB?=
 =?utf-8?B?TU9SeElRZWhlMGZKZ2JucS95YWFBZUVmaEw0YVgyWW1PYjk2R3llUEgxd0ZR?=
 =?utf-8?B?ZUlIeEtOWitJckR4N3NmbGkzMFE5QlpGdEVRWnRDY21YTnc0TnZRSFMrWmU3?=
 =?utf-8?B?TmR2L2hKQ2RRSWFxNlBzWEpuNHJIODBveUZSbys4cENJbFd3VWNBUHRFZnlo?=
 =?utf-8?B?NVFHWXBPZ2tkQ3loL3R1ZElBWVlPckxzdFVjZFZMNzliakV2Q28zamQ0YTMr?=
 =?utf-8?B?OFNCckxmZ1pEUGdJRTA4MWRWZHJtVDRLcEdXdkRmSmhrVWdaY3YxUHFXSldZ?=
 =?utf-8?B?eGl5ZStuSzI3M1Y0MnVKWFlvdjBkeXRXQXlCMzB6ek8yR2hvb3F2ZEdRK1RG?=
 =?utf-8?B?RVovRkQrTDNnSjBWc01HQ25QQ3dPOXdSK29ZTFBPVVJKbUx1Z2dLRW5LY1Jv?=
 =?utf-8?B?OHNUREthL2ZUcCs1WDVDWFI1akdsc09VMnVyOUNWczhUMVptYmI1aG1uMlRX?=
 =?utf-8?B?R1VVQkFUaUJrRi9janZYM3Q0ajVHYmFpUG90cXY5R05zN1VCK2txSDg0d0JT?=
 =?utf-8?B?N0EvaExlL0hENzVyeFcxTEJXRWRMNENvaHdaTnZQbGt3WHdLRUgveDBhNUtC?=
 =?utf-8?B?ait4NFpsaHo3U1NCdnFzeWNZWmNKZGtnc0VkR1RaR2VLNmxOVXQzTk82ZnRO?=
 =?utf-8?B?UGJMcDFRSFhNSHczRExNUktiaHNpVDVBK1kyRTRDc29KT0RZTVpRUGcwbDNx?=
 =?utf-8?B?OE9ub0RvaU0xcSszUUprZEk3VTk0R2hqN2x1Uzh5endHeXN1TWM5WEUzN3Vh?=
 =?utf-8?B?OWd4K3p3Zng5UHlLTE4xRGlubTZlbjAvZXdOSFpWL3FUcEMza1RzVzI1UThF?=
 =?utf-8?B?dUFqUHhQNWJNMTRpK1dqd2JUUUVneC9qVm85dVB1dTNnT0EvR3JRM2ZEaDdP?=
 =?utf-8?B?TFVXRjgrN09xalNkbVhuKzNNY3hIOFFBenVMSjdHeFMrT3NwQXBDUkxHTFJ4?=
 =?utf-8?B?VFJiaXhUYjJNMGRrWUhiRHhZRlduYkZkRVlPYXBFNGMzTkVsamxZN2FtWlhj?=
 =?utf-8?B?eUhybm9QYVJsdk9GVXRhRGdvQWltRXhZSzRQa2VtMXgxY0taOENzaFFQVWFG?=
 =?utf-8?B?MG0zS2xXOXZQald6aG4rekt4VXNmMHQ4NVdPRk9sZ3V5ald1SFQvbUowaWVK?=
 =?utf-8?B?M015ak9rMVZmeFVzWGNGaCtJTDF3NFlWVytMQmZrWTVDVG1PNTdweXlnUXg5?=
 =?utf-8?B?VkUxUVFOY0dlUXZZUmhhbWlBRDlsdFZSQkRtOHA2QjNlUnpPdVlEQ3F4N0ZU?=
 =?utf-8?B?QkZmUXMzUnoyMlM5VGtmejdHRGF4dHRxMEJwQ2NDQlQ5eGlscGZBSllyUnIv?=
 =?utf-8?B?dWw1WTJQLzUrSmJvVGJkSFZmbDhnU1A1Y0VDWEpmcldyS3A0R0FFSGpKUm9S?=
 =?utf-8?B?dmtNcU1vV3BxNEMrdENweVZwOWZ0dER1VWMvbUdqcFBwcG1jWEc4S3kzaVRn?=
 =?utf-8?B?QUpTM3pPNmpLbHFibnhWeDlBWGovWkVqOG02UFhjY08vWnA5K2liVWFya3c5?=
 =?utf-8?Q?EK2jZf0QBX83S?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:35:54.6928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb294c52-74b4-42f7-d3d3-08dc814cafd9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8027

On 20.05.2024 19:25, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> This implements the Revocable and AsyncRevocable types.
> 
> Revocable allows access to objects to be safely revoked at run time.
> 
> This is useful, for example, for resources allocated during device probe;
> when the device is removed, the driver should stop accessing the device
> resources even if other state is kept in memory due to existing
> references (i.e., device context data is ref-counted and has a non-zero
> refcount after removal of the device).
> 
> AsyncRevocable allows access to objects to be revoked without having to
> wait for existing users to complete. This will be used to drop futures
> in tasks when executors are being torn down.
> 
> Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>   rust/kernel/lib.rs       |   1 +
>   rust/kernel/revocable.rs | 441 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 442 insertions(+)
>   create mode 100644 rust/kernel/revocable.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 698121c925f3..d7d415429517 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@
>   pub mod net;
>   pub mod prelude;
>   pub mod print;
> +pub mod revocable;
>   mod static_assert;
>   #[doc(hidden)]
>   pub mod std_vendor;
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> new file mode 100644
> index 000000000000..71408039a117
> --- /dev/null
> +++ b/rust/kernel/revocable.rs
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Revocable objects.
> +//!
> +//! The [`Revocable`] type wraps other types and allows access to them to be revoked. The existence
> +//! of a [`RevocableGuard`] ensures that objects remain valid.
> +
> +use crate::{
> +    bindings,
> +    init::{self},
> +    prelude::*,
> +    sync::rcu,
> +};
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ops::Deref,
> +    ptr::drop_in_place,
> +    sync::atomic::{fence, AtomicBool, AtomicU32, Ordering},
> +};
> +
> +/// An object that can become inaccessible at runtime.
> +///
> +/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
> +/// [`RevocableGuard`] are dropped), the wrapped object is also dropped.
> +///
> +/// # Examples

You might want to enable the doctest and check if the Examples are at 
least compiling ;) Here and in devres as well.

Best regards

Dirk




