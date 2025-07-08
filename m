Return-Path: <linux-pci+bounces-31683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D00AFCA26
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415841AA8572
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E9221D87;
	Tue,  8 Jul 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="vqSELylt"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBF206F23;
	Tue,  8 Jul 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976950; cv=fail; b=po6bmwkoCgVxIzBXmsXIXbP/SBAFPOqarmVxiCrcvNHpohpFbsa6KfDysIUEfqjfUML5invPg+VoHCnAqn9egWk/BaLqVDTEBvgH8KoekTNZIv4/RsqWVSH05zbnbTbAKX39jh5UaJIYdx4tf5kZGxyP5Ctd1oJT3/zUixG/7BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976950; c=relaxed/simple;
	bh=sGugLmDTvMwSNQoH95dHUVVEMnSVrsQxmRn2/Jw2Hsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c1tsViHCMICx2Az+fL1qSmwSmxK1ZbkuEtIH6nJMX9HjhJ/hNWASdmyUNKNz4sKChNqYCEYdR3/o7T2vOHzaLiVgKag8ldGX2Cn3urt93BYKE51nhHtPZJ6agzyC6DHfz3T/qt84jm3gzJOOHoBlvXOzKDF4ekghc7WSb02qSPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=vqSELylt; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2yrrk2IvdxD6zvjdwUUX4R2qmvb3a/tiCgmKNzgmf/d6HU1CU9qulltWU/DXEFjUiU3oL8WBmx/OamWOZNurxE4XeU3xgfUIhKjm1laNJYbAMfE3IZSmgXinO/G+FG3/UW4b58tltQtyYheRXunL7v3Io5//dfwcFrQc82Q8j+bxQGKSf1HKxG+rG8FAG76fNwb9khC8WqkgSf3fIS6zHiOpmzaaSA6CN/nQ378vV+Gg/w95McDEPpWkxUkWvO4mllWqPojvhJbuuoIkFi4XJfUhJ0yyuQqHuvxff/YynQVkDe+8pJ5eiUN3yJUyVMff87IHBuwm1ba4A7RuVRLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTLabRGCg9S8JvfF9/ZRrHd6FR3OemQsEsMQcL+dSDE=;
 b=T1b0vjtcIt2lYevk1HVPM0E90qgb4e1rEdunj3BGlzopvOCrHNmMXpHBqMU1p1Ptw5G1MpFxZvUapmyYluLxAOs4aVB0I6NpNFq2thVQ1UxLIRdqvM5JGvjcHnNR/9wQYaeC2xbiSUzmch25/ol7lNZwASbWfxeIwmpLKOYh5oFOA1nzX6ounjJOVzoS/RZQayubN6p6nTp/w/1jTPzPaRv9vy4pOM+iDuO3Zjnj58gW5CxyKaixJTDGdW3fc6DyLsXEM4bPtCESwaNv5/5vHunjrFcY7+Q8YtBb1F+J1YSzBoCcCFfovMev+07Ac1vTv89OBpmYPuzTgMvxlTl8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=collabora.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTLabRGCg9S8JvfF9/ZRrHd6FR3OemQsEsMQcL+dSDE=;
 b=vqSELyltIK6xwwzBqZHCnsKNQQfN+mv1Y8qJJyuc/nMCz6ludo45QxLMnWrw+EKYfrAYVECBRylhklJNt0iIzvR9EbdRbNAzLJJ0Zgvigy7srk/PoXtgRkZAGygKu6qTsOGtQ5FH47cGH/brKU6COVMAObYIsFs96OQI2XZB36BkUhSg8Df69x1mFSYXGb5tt+O787khkDaXEzOBzpbzQHleKYF8fp2jGXoMdDI0FMbEHWapoPdLp0e1A8WAF43nSKSt8wmc/SU/PSILpTO3KiaqxHIKuN2jzqu/q7eGbrRHJ81sQBqymdpqGTgolKgPFqGv0mYqMhqS8Bt3Ylir7Q==
Received: from DU6P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::10)
 by PAWPR10MB7149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 12:15:43 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::a2) by DU6P191CA0016.outlook.office365.com
 (2603:10a6:10:540::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 12:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 12:15:42 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 8 Jul
 2025 14:15:31 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 8 Jul 2025 14:15:30 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 8 Jul
 2025 14:15:23 +0200
Message-ID: <abf29ebe-996e-47f6-8548-afc61ad29a89@de.bosch.com>
Date: Tue, 8 Jul 2025 14:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg
	<a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|PAWPR10MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: a570a0e2-fe97-4424-0363-08ddbe19291b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkhGNHZsMG1TZWUyanJmWVlVTTh2OElTV1R3ZHBWd2dnZjFLOVgzQmU4djJ6?=
 =?utf-8?B?bGs1RElyV3VDcXJ1UGs0SnlsNVRwM1lSWXdxWlJteEZpajd1U1g4OG1hMHRw?=
 =?utf-8?B?bmIxanM4SXVmaGVQQ3JtaGtjSlBCYVBnM2VudG8vMmR6K0o5TDVsWStiaGdJ?=
 =?utf-8?B?Zm95NVBVU2RkNVlNR28rZzVXcTIyUU1UemZhT3BXWE5xeWFteGdUU0VCcGha?=
 =?utf-8?B?QS92TWkzMTdBZzNoZnl4WjlFaXo3T1doNGZjcWIwQ2d0L2dKbWM3VXBBb0xq?=
 =?utf-8?B?MWY3SUYxYTdDblNaUEdTZFhFRk12WCt3em8rbkpBWGhlRS83Y09IV3J6am51?=
 =?utf-8?B?UkZYMjNrQ055eUZ5RmR2NzJoajVLUmQ5bUdsaG5EVWpodmtiSjN5Tk85YVlp?=
 =?utf-8?B?NTVsamR1RzhDOGJEQ285Q2c5R0tLbmF2aFBoSGZWeDVIODNHWHFxOC9OQ1pt?=
 =?utf-8?B?dTEyanN6WEVYTTMvZjEyZDRTWVNFMDljL3Rqa29pekdyOVJEcDF6Wm9kOTBR?=
 =?utf-8?B?OGt4U2k3YlRSVUZtKzBNb0gyWjJCMTJnQkxJRWF6NnpLclJBWVFtZnVZT2tF?=
 =?utf-8?B?U0dyOVIxRVVGdEVhSEprOVk3OGEzcVk3L3Z5Sm1ZYkQ5M2xKWFJvTkhPOGRX?=
 =?utf-8?B?Vlg4ZUduRU81aGdhSng1L0lpVUNPZk8rNWF4S0pQMnVRckxubjdCYVJIcG1p?=
 =?utf-8?B?WFpHQkh3cjNvd0lpcWxNV0tKREs1NkVyKzJxWHdMQ3hQdlk5VzF3bHJlTnNN?=
 =?utf-8?B?bVFHaW9rais4OFhvRFBvOVpnK3JiQnN3UlNVRi8xTytsRFlad0ZqTFhLd21G?=
 =?utf-8?B?ZEMycDRjaFdSbjNXNWFLUHl2S2I4QWttcXJwekJ1TEVBazU0aEplQ0tEaDNH?=
 =?utf-8?B?bmJWaHhJWW8yTkxJdmlXYWZnSmpiRlN1elVRbmZjNUkwSXpXYjh0TmhRdHRV?=
 =?utf-8?B?Y0htSHJPZWpjcGR3d1dWaW9pNVI1dEpEdjR1WWZIQjFiOFVxRk9kcGdEVzdp?=
 =?utf-8?B?ckRCbys2dEJySERITmtrT2RNYUFWRi9EcHlSYjgyZWxwY1RsT21qODlzRlRR?=
 =?utf-8?B?ZXZIekRrNFR3MmV6Qmd0LzFEdUsvalIwc0MvZUh4N1FEKzJLSk9UVjdmclNT?=
 =?utf-8?B?a3g0eHo3VmlCWFU3ekFwVFB0VlE1OFovSG9mNGN2cGw1M2J3Rkh5VHhoelFm?=
 =?utf-8?B?NlFjcEpoeHVBRHZscFJTU3AzMkpEMmdZQkFxY2wyaDE4QlF3Zk1rdTgra0hw?=
 =?utf-8?B?NTdYYVl0aXYzM3ZzckF2RkI2MEFQa3l1UTZ0WWR4MjN0d09nNVZOSmlMMVN0?=
 =?utf-8?B?NE14Qy8zZTlybEgvbUFIZTNpbENIeU14NHhUZGdJajBkZHAxcUxsdmRwWkJM?=
 =?utf-8?B?d0NoOVBPTnVkNC9vQ3VxNkNDbU1kM1UzQjhodlFpWEp5MERnajhScVlYalJx?=
 =?utf-8?B?bjA0THJVd2t4ZHkwYi9XK0pNTHBOeEpQaDQvZTRZTGsrUlk1QlliMkRHQXRp?=
 =?utf-8?B?aG5yZklRMjFoYUIwcWdXcmZSVmVsUkFUZkNLL2gyM0xtUjBvTmRtaUpNeDZ2?=
 =?utf-8?B?VmpUSTRwTkc4Ky82eTZFTEdGcWxOOVZCM2RRTTI0V1VnbFJnTGJnK21QSndP?=
 =?utf-8?B?YWlYUXlJTC9vM1Z0UHpsdENZRDFLYlhNcFZkeDNQZWQyZHRwZDhLb3Q4dEI5?=
 =?utf-8?B?d3MzMDJPOUZyRjJrMXZLcGpUb0xOUVgvcmRMYW9tWkJZRXYvSitOQUhUUTRM?=
 =?utf-8?B?TUtBSXZjcXQrZ25jbE03WkRzYmxlKzd6dVJSWjhXaXhlaVZLVG5YWkRGZmw0?=
 =?utf-8?B?YkxWb3Z2RDdlNXRIN3ExUG9rOVFNY1ZWamlnUDlEMmpiejhScUZ3eDNWZ24z?=
 =?utf-8?B?d3VaVzNGcDdiTlIyUHhUYktHQnN4L2ZKaDUxbitJM1lmeEtNRjBnY29jNUhs?=
 =?utf-8?B?dHhWLzA2Qlh6SnJxQklSZ0k5WE52aldXYlF5WVVSaGxiTCtiUEhXeTltK1hu?=
 =?utf-8?B?eTBYWWdoOTNsWllPTE5PTEhvWnA4TVgvSldFUHorOUdET3o4ZHF1T0MzNUpO?=
 =?utf-8?B?NEU5QVVqOEFnNG81ZTdOcitTc1ltTEhOZjZvUT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:15:42.8474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a570a0e2-fe97-4424-0363-08ddbe19291b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7149

Hi Daniel,

On 03/07/2025 21:30, Daniel Almeida wrote:
> This patch adds support for non-threaded IRQs and handlers through
> irq::Registration and the irq::Handler trait.
> 
> Registering an irq is dependent upon having a IrqRequest that was
> previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
...
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..4f4beaa3c7887660440b9ddc52414020a0d165ac
> --- /dev/null
> +++ b/rust/kernel/irq/request.rs
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
> +
> +//! This module provides types like [`Registration`] which allow users to
> +//! register handlers for a given IRQ line.
> +
> +use core::marker::PhantomPinned;
> +
> +use crate::alloc::Allocator;
> +use crate::device::Bound;
> +use crate::device::Device;
> +use crate::devres::Devres;
> +use crate::error::to_result;
> +use crate::irq::flags::Flags;
> +use crate::prelude::*;
> +use crate::str::CStr;
> +use crate::sync::Arc;
> +
> +/// The value that can be returned from an IrqHandler or a ThreadedIrqHandler.
> +pub enum IrqReturn {
> +    /// The interrupt was not from this device or was not handled.
> +    None,
> +
> +    /// The interrupt was handled by this device.
> +    Handled,
> +}
> +
> +impl IrqReturn {
> +    fn into_inner(self) -> u32 {
> +        match self {
> +            IrqReturn::None => bindings::irqreturn_IRQ_NONE,
> +            IrqReturn::Handled => bindings::irqreturn_IRQ_HANDLED,
> +        }
> +    }
> +}
> +
> +/// Callbacks for an IRQ handler.
> +pub trait Handler: Sync {
> +    /// The hard IRQ handler.
> +    ///
> +    /// This is executed in interrupt context, hence all corresponding
> +    /// limitations do apply.
> +    ///
> +    /// All work that does not necessarily need to be executed from
> +    /// interrupt context, should be deferred to a threaded handler.
> +    /// See also [`ThreadedRegistration`].
> +    fn handle(&self) -> IrqReturn;
> +}
> +
> +impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
> +    fn handle(&self) -> IrqReturn {
> +        T::handle(self)
> +    }
> +}
> +
> +impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
> +    fn handle(&self) -> IrqReturn {
> +        T::handle(self)
> +    }
> +}
> +
> +/// # Invariants
> +///
> +/// - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
> +/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It
> +/// is guaranteed to be unique by the type system, since each call to
> +/// `new` will return a different instance of `Registration`.
> +#[pin_data(PinnedDrop)]
> +struct RegistrationInner {
> +    irq: u32,
> +    cookie: *mut kernel::ffi::c_void,
> +}
> +
> +impl RegistrationInner {
> +    fn synchronize(&self) {
> +        // SAFETY: safe as per the invariants of `RegistrationInner`
> +        unsafe { bindings::synchronize_irq(self.irq) };
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for RegistrationInner {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY:
> +        //
> +        // Safe as per the invariants of `RegistrationInner` and:
> +        //
> +        // - The containing struct is `!Unpin` and was initialized using
> +        // pin-init, so it occupied the same memory location for the entirety of
> +        // its lifetime.
> +        //
> +        // Notice that this will block until all handlers finish executing,
> +        // i.e.: at no point will &self be invalid while the handler is running.
> +        unsafe { bindings::free_irq(self.irq, self.cookie) };
> +    }
> +}
> +
> +// SAFETY: We only use `inner` on drop, which called at most once with no
> +// concurrent access.
> +unsafe impl Sync for RegistrationInner {}
> +
> +// SAFETY: It is safe to send `RegistrationInner` across threads.
> +unsafe impl Send for RegistrationInner {}
> +
> +/// A request for an IRQ line for a given device.
> +///
> +/// # Invariants
> +///
> +/// - `ìrq` is the number of an interrupt source of `dev`.
> +/// - `irq` has not been registered yet.
> +pub struct IrqRequest<'a> {
> +    dev: &'a Device<Bound>,
> +    irq: u32,
> +}
> +
> +impl<'a> IrqRequest<'a> {
> +    /// Creates a new IRQ request for the given device and IRQ number.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `irq` should be a valid IRQ number for `dev`.
> +    pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
> +        IrqRequest { dev, irq }
> +    }
> +}


For example for Resource the elements size, start, name and flags are
accessible. Inspired by that, what do you think about exposing the irq
number here, as well?

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index bd489b8d2386..767d66e3e6c7 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -123,6 +123,11 @@ impl<'a> IrqRequest<'a> {
     pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
         IrqRequest { dev, irq }
     }
+
+    /// Returns the IRQ number of an [`IrqRequest`].
+    pub fn irq(&self) -> u32 {
+        self.irq
+    }
 }


I'm using that for some dev_info!().

Best regards

Dirk

