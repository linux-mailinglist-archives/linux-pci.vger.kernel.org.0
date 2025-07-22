Return-Path: <linux-pci+bounces-32721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABB6B0D887
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF676C5150
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA412E0919;
	Tue, 22 Jul 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="OigT1CgD"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CCD2D660B;
	Tue, 22 Jul 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184881; cv=fail; b=jSnmSIGm8e6ZKs7K5Xv/tSgWdvJvV6rfftLqrWKkhU/kDTZ1JUxqjZOThpjTG9Aa5JnhclIXe43dARtEothXflgNFiZR1M7VKH0Y86WlIVtk0p9Qr3anTYB7mmOyOV0zOSszNy4CkxJp06ZmPCSHxsRAeipMcboXv5VlV1WPJtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184881; c=relaxed/simple;
	bh=N4wrZYiqnGXpxkP1Ix6idAQ5uSnv50T+FuPB+PvtHKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r3IY0oLsb+/TsZ7upoyRUma6Q9Z0dywPg0lePRWDP3B/q0UXsnZ9muN+TtgrVageZSFgrr+SLdWWelXe+tSNskczJ0AwBS39FzIof6coE2WLSLOHgqhvu5iGuSqrlL4fTtQ/7N6SijRcEvnEClTB6PXjjwnFvz3B/fxg+9uLGOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=OigT1CgD; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj6n38kkRZnUpKia1Au90a5ezjD+sbNrRkpBmv8fA+uypvXWESN0Ubs/DXc+TZzl/QQlGd+18HdtNSGhpGGbpDN9SR7N4O9mkgxLRtIZlp5aKEoXvY25Q0HLfgHlXTDi8yNDP+J7ag4oMs2Hml4BQfLzS3lxi5PYhDZNKxFeZVF6yk2x0bgsoF8Kiw5zkVBHJbgm1/hkXothz6/+YUKD0MtOqqcbOZ7qnmyiGs5vuxTCPzPeAMvhY1dZ6HQK/tKovyVs2iavearO9aT17hTbnNtmTnWFk4hz9hLDi3AQRnEUD7kAjrSRS2uXyadvQ9yZiAoCZyHN+jgOw0BBs8JSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoeTQ87PVRFO9wvoCFp2Qec6I25aQ2cOeLBZCVJy9XE=;
 b=xzGHGI0YzjPUVAPIVRoEc9fsdH+wsYkuXwakqoDzhgOV+BQLvHcajByEJl97dIWLr8VZPjp8q6yUNb020hSZ6nVm6gxLkNEFYxeH0mrZR0yZj9XaPA5U265P+vcE4BFRZvtqrRYrITBUqnrqmCaygYHlLIEr2TQBhU/QmX0RYJccYgMrxzsUdwlcsGgOto0blV4L9orXrl4DwDLs53WsUXeMF8tg99Nk0kcx9Jm/hbWrPbkwYFuhzmgYNgfzjodbBtjAOVRWiafxgL3gb+MNQ73Uy2ua3Nz6zHbtERqGeYNPW4NyxklrAYITCisaXTn451rHHMyZjwvwzaI+Wv0Fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoeTQ87PVRFO9wvoCFp2Qec6I25aQ2cOeLBZCVJy9XE=;
 b=OigT1CgDUCZcYxGfHmqETVwOdiP53PHfjQrz4nl2dj6nvjapIZT4MruKbQg6Dx0IHpRdKrtEZ5vJYRe8MhFA3pDMdA/jrB5SgAiRf71nk4v7IpDGf+dlO3LIJfJF+98wKaPYRhNXjqOrL+2L030ZKBGr+hKpapoVNX9PWoiTm9AvKviNPabZpAvtSqcdcHMQH4HmKC+h1yfbNeedpn9LRIOKXg598gzrbq8USwZQ6u3CXulwhTUAZSnWLcXtWmj13A8HZ7MuXPQTghMCieDZOxXvGL0O8lKh5LJeEMXPGlbUqlnHYEpNSA+HhGCOAiG8kg0y0isusNii4yGMoOsSjw==
Received: from DU7P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::35)
 by VI0PR10MB8471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 11:47:51 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::55) by DU7P251CA0029.outlook.office365.com
 (2603:10a6:10:551::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 11:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:47:50 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 22 Jul
 2025 13:47:37 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 22 Jul 2025 13:47:36 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 22 Jul
 2025 13:47:37 +0200
Message-ID: <361ebaf2-efc6-46ec-a9d2-0722cfe382ea@de.bosch.com>
Date: Tue, 22 Jul 2025 13:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
To: Alice Ryhl <aliceryhl@google.com>, Daniel Almeida
	<daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg
	<a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, Dirk Behme
	<dirk.behme@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|VI0PR10MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: dd789edf-4cb7-4993-1ccb-08ddc915963b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymc4M2VNc0QzTEM1S0kwTFEwUHFJZU1mRkxDL0FXQWl1ejFyc05XNDQzTUNj?=
 =?utf-8?B?R1hCcU1GdjhIN1V5WDJHaFlsUUF4YmpjeHFyeTk3dVZId0hsYUFiRDRYQnVj?=
 =?utf-8?B?L2d0c3NJbllJa0UySjFKMllHYmZHd29YQzFuVlNRVHYxOUp4TjVNLzB2VWc2?=
 =?utf-8?B?em1VellBVjZtc290K1g2dXUveVNuMnlDVmlnam1RNmdBVWFKTUV4VVpPbmRC?=
 =?utf-8?B?MFlMM2YwVktNR0EwYVh1N3lNUjR4NzNjcWhVNWxOUXNuSUUxQzZNaithQmVy?=
 =?utf-8?B?a0dDRTlBTDdIeW84SlBaajRRb2JKQWV0dk1oZmJyUGRzUjhia3ZXTXplSFMx?=
 =?utf-8?B?Sm5BNmxiMEdhSSt5RklKTzJlczkyMW1yNE1uS2tFR0ozeEtyeHlPckN6cjRY?=
 =?utf-8?B?Z0p4azNiNUt0SWI4MkZJVmw4YXVJTWl4YTdaZVNmYy8wWjJoVno4WlkrS2J3?=
 =?utf-8?B?Nlp0ZmQ0aWVzaCtGMzVEQ0JZM2FYbkpwbjc3TFpjMFc5amdLM2FXZFNSeWhu?=
 =?utf-8?B?RzI3dUxtS1lGcmNqSmJRWEtDanVxR1hxRDR2TGswamtMSVc5VXFCU296UWtU?=
 =?utf-8?B?Zkc1VlNjdzRJSW1xbnJqYjZkalJkZW9TM3ltUDBSRGphb3FyUzh6aHZEckhF?=
 =?utf-8?B?c3VsNEQ5QUNZNjZpbFNRcStaTlpXR2wvUXhybTNOWXpvTit4NjBjR09Bd3hE?=
 =?utf-8?B?dVdYTWtaSmhvTjdoTDI4Sm9oS2V1UEJnWWp2Qkc2MWQ4bEcxNWczMFRZUDVr?=
 =?utf-8?B?aU0zYVF4SWF3STAzWExVbS9uOXVqR3dTNmo0bzVQNFRuUVZzekpuVm5RTlUz?=
 =?utf-8?B?STdJMWxBN2h4Qk1mejROS0ZEdTZQUGFuTlJWN3o4Z3NYcVZoVTRSdjFieFN0?=
 =?utf-8?B?ck1icVdYaVFqbXNRSkorbTFhMjFqOFVXMFdlVmNBc2ZyM1BnR1Y3MjNuUElz?=
 =?utf-8?B?OHVGUEtIV1FsRzZxU2JFd3lSam8yd2lwazdFV1NKWEhJRFpWUzVlYjZtby9h?=
 =?utf-8?B?Yk0yK3NPUjNQUlhlcE01VDMzbThreGVFNm1JYmw0U3VJS3EvYkFOZ0wvMlRk?=
 =?utf-8?B?OGNTWUtPeUpleFZyYnJWeThCMmw5OVk4dWN1U25vR3NidjNTeXRNcklNb0xN?=
 =?utf-8?B?akdSN1kvWEtrVjBNaGo5VDUxVFp5WUxoOHVKOWw0YU5ZMzFFa083RlNVUlZK?=
 =?utf-8?B?NXU1OGhWMUx1Ykd4SGFDVWorWE5hdDlWNjR5SGhmL0hWNEZZRlpnNWJ0Qno1?=
 =?utf-8?B?RlR1VEVpc0RFM2NkYlFkOWxSWFVHa1lOc0FYdXcveWd1RWRVN2ViZERKcnFw?=
 =?utf-8?B?SFpYZ01vYVZPQTBSOUl6T25FQTZHT28rSHNJdzFhVE9xbjMvMEc0TUdsK3NV?=
 =?utf-8?B?dFIrN2xQbG1vV3EvV2p6eDlTS2pyNVZLbXUxc3Q0SXp3d3B5SkFSS2wxbXdw?=
 =?utf-8?B?Z3d5YkRtcU50NTlCM3hQN3dKbjgxbzBoSGU5bGZJM0I2QStmTnRLRUx5L0ZL?=
 =?utf-8?B?c3U5eVFnS3prOEIvNUJ5T3lDcjFRclp1bUFuRFpMWnBleElKMzhrSVd4dXp1?=
 =?utf-8?B?L2RYSWJjbE82c1I4SzJ6Tkw3M2JPd2tRVDhweFJ1U2txbzFIbmxGWXdxWncy?=
 =?utf-8?B?UWxFMk16MGUyam5meTBhRUJVYWZkTGhLb09jenR6S0dRTmxJUnFNdWZNYlhN?=
 =?utf-8?B?ampxbm1OMVhXWFhqclAxOFNuTUQwU0FiclpnSVNiQlJkMHB2TnYzQm9Vbmho?=
 =?utf-8?B?TnNaR3E4ZVB4WmNOaVkrR3Z0Z1o5eXVHSzhMbVo1NlozdS9ZM2U5VEZGZHQv?=
 =?utf-8?B?bE56Z1Njc3dNSUkyTnN2eS9STHVzMGlHYW0remg4NFdwaExWd1B1K1RjRit5?=
 =?utf-8?B?eER4WHQrSm5VR2EraUZNOHMyb2ZEbU83OEZxWENFTjBtWkFKbG0yZDVmRkhI?=
 =?utf-8?B?YStmV2MycHdsT2drV21lV1BVd01JZDZGRllwM0NoaHVoK1h4Qk9NWjJyLzg1?=
 =?utf-8?B?Tkd4SE9IUTY5MUxCVEpkcEJEdjNPS2J1Ym1iNzZYMUNobEtTL2xSeS9JSGVP?=
 =?utf-8?B?ekx1NmRkcWhvR3loZXJoNUJXTzJmVE5hM0NHdz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:47:50.7317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd789edf-4cb7-4993-1ccb-08ddc915963b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8471

On 21/07/2025 16:38, Alice Ryhl wrote:
> When working with a bus device, many operations are only possible while
> the device is still bound. The &Device<Bound> type represents a proof in
> the type system that you are in a scope where the device is guaranteed
> to still be bound. Since we deregister irq callbacks when unbinding a
> device, if an irq callback is running, that implies that the device has
> not yet been unbound.
> 
> To allow drivers to take advantage of that, add an additional argument
> to irq callbacks.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


With

https://lore.kernel.org/rust-for-linux/dd34e5f4-5027-4096-9f32-129c8a067d0a@de.bosch.com/

let me add

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

here as well.

Thanks!

Dirk


> ---
> This patch is a follow-up to Daniel's irq series [1] that adds a
> &Device<Bound> argument to all irq callbacks. This allows you to use
> operations that are only safe on a bound device inside an irq callback.
> 
> The patch is otherwise based on top of driver-core-next.
> 
> [1]: https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com
> ---
>  rust/kernel/irq/request.rs | 88 ++++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> index d070ddabd37e7806f76edefd5d2ad46524be620e..f99aff2dd479f5223c90f0d2694f57e6c864bdb5 100644
> --- a/rust/kernel/irq/request.rs
> +++ b/rust/kernel/irq/request.rs
> @@ -37,18 +37,18 @@ pub trait Handler: Sync {
>      /// All work that does not necessarily need to be executed from
>      /// interrupt context, should be deferred to a threaded handler.
>      /// See also [`ThreadedRegistration`].
> -    fn handle(&self) -> IrqReturn;
> +    fn handle(&self, device: &Device<Bound>) -> IrqReturn;
>  }
>  
>  impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
> -    fn handle(&self) -> IrqReturn {
> -        T::handle(self)
> +    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
> +        T::handle(self, device)
>      }
>  }
>  
>  impl<T: ?Sized + Handler, A: Allocator> Handler for Box<T, A> {
> -    fn handle(&self) -> IrqReturn {
> -        T::handle(self)
> +    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
> +        T::handle(self, device)
>      }
>  }
>  
> @@ -134,7 +134,7 @@ pub fn irq(&self) -> u32 {
>  /// use core::sync::atomic::Ordering;
>  ///
>  /// use kernel::prelude::*;
> -/// use kernel::device::Bound;
> +/// use kernel::device::{Bound, Device};
>  /// use kernel::irq::flags::Flags;
>  /// use kernel::irq::Registration;
>  /// use kernel::irq::IrqRequest;
> @@ -156,7 +156,7 @@ pub fn irq(&self) -> u32 {
>  /// impl kernel::irq::request::Handler for Handler {
>  ///     // This is executing in IRQ context in some CPU. Other CPUs can still
>  ///     // try to access to data.
> -///     fn handle(&self) -> IrqReturn {
> +///     fn handle(&self, _dev: &Device<Bound>) -> IrqReturn {
>  ///         self.0.fetch_add(1, Ordering::Relaxed);
>  ///
>  ///         IrqReturn::Handled
> @@ -182,8 +182,7 @@ pub fn irq(&self) -> u32 {
>  ///
>  /// # Invariants
>  ///
> -/// * We own an irq handler using `&self.handler` as its private data.
> -///
> +/// * We own an irq handler whose cookie is a pointer to `Self`.
>  #[pin_data]
>  pub struct Registration<T: Handler + 'static> {
>      #[pin]
> @@ -211,8 +210,8 @@ pub fn new<'a>(
>              inner <- Devres::new(
>                  request.dev,
>                  try_pin_init!(RegistrationInner {
> -                    // SAFETY: `this` is a valid pointer to the `Registration` instance
> -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> +                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
> +                    cookie: this.as_ptr().cast::<c_void>(),
>                      irq: {
>                          // SAFETY:
>                          // - The callbacks are valid for use with request_irq.
> @@ -225,7 +224,7 @@ pub fn new<'a>(
>                                  Some(handle_irq_callback::<T>),
>                                  flags.into_inner(),
>                                  name.as_char_ptr(),
> -                                (&raw mut (*this.as_ptr()).handler).cast(),
> +                                this.as_ptr().cast::<c_void>(),
>                              )
>                          })?;
>                          request.irq
> @@ -262,9 +261,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
>  ///
>  /// This function should be only used as the callback in `request_irq`.
>  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
> -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> -    let handler = unsafe { &*(ptr as *const T) };
> -    T::handle(handler) as c_uint
> +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
> +    let registration = unsafe { &*(ptr as *const Registration<T>) };
> +    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
> +    // callback is running implies that the device has not yet been unbound.
> +    let device = unsafe { registration.inner.device().as_bound() };
> +
> +    T::handle(&registration.handler, device) as c_uint
>  }
>  
>  /// The value that can be returned from `ThreadedHandler::handle_irq`.
> @@ -288,32 +291,32 @@ pub trait ThreadedHandler: Sync {
>      /// limitations do apply. All work that does not necessarily need to be
>      /// executed from interrupt context, should be deferred to the threaded
>      /// handler, i.e. [`ThreadedHandler::handle_threaded`].
> -    fn handle(&self) -> ThreadedIrqReturn;
> +    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn;
>  
>      /// The threaded IRQ handler.
>      ///
>      /// This is executed in process context. The kernel creates a dedicated
>      /// kthread for this purpose.
> -    fn handle_threaded(&self) -> IrqReturn;
> +    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn;
>  }
>  
>  impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
> -    fn handle(&self) -> ThreadedIrqReturn {
> -        T::handle(self)
> +    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
> +        T::handle(self, device)
>      }
>  
> -    fn handle_threaded(&self) -> IrqReturn {
> -        T::handle_threaded(self)
> +    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
> +        T::handle_threaded(self, device)
>      }
>  }
>  
>  impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for Box<T, A> {
> -    fn handle(&self) -> ThreadedIrqReturn {
> -        T::handle(self)
> +    fn handle(&self, device: &Device<Bound>) -> ThreadedIrqReturn {
> +        T::handle(self, device)
>      }
>  
> -    fn handle_threaded(&self) -> IrqReturn {
> -        T::handle_threaded(self)
> +    fn handle_threaded(&self, device: &Device<Bound>) -> IrqReturn {
> +        T::handle_threaded(self, device)
>      }
>  }
>  
> @@ -334,7 +337,7 @@ fn handle_threaded(&self) -> IrqReturn {
>  /// use core::sync::atomic::Ordering;
>  ///
>  /// use kernel::prelude::*;
> -/// use kernel::device::Bound;
> +/// use kernel::device::{Bound, Device};
>  /// use kernel::irq::flags::Flags;
>  /// use kernel::irq::ThreadedIrqReturn;
>  /// use kernel::irq::ThreadedRegistration;
> @@ -356,7 +359,7 @@ fn handle_threaded(&self) -> IrqReturn {
>  /// impl kernel::irq::request::ThreadedHandler for Handler {
>  ///     // This is executing in IRQ context in some CPU. Other CPUs can still
>  ///     // try to access the data.
> -///     fn handle(&self) -> ThreadedIrqReturn {
> +///     fn handle(&self, _dev: &Device<Bound>) -> ThreadedIrqReturn {
>  ///         self.0.fetch_add(1, Ordering::Relaxed);
>  ///         // By returning `WakeThread`, we indicate to the system that the
>  ///         // thread function should be called. Otherwise, return
> @@ -366,7 +369,7 @@ fn handle_threaded(&self) -> IrqReturn {
>  ///
>  ///     // This will run (in a separate kthread) if and only if `handle`
>  ///     // returns `WakeThread`.
> -///     fn handle_threaded(&self) -> IrqReturn {
> +///     fn handle_threaded(&self, _dev: &Device<Bound>) -> IrqReturn {
>  ///         self.0.fetch_add(1, Ordering::Relaxed);
>  ///         IrqReturn::Handled
>  ///     }
> @@ -391,8 +394,7 @@ fn handle_threaded(&self) -> IrqReturn {
>  ///
>  /// # Invariants
>  ///
> -/// * We own an irq handler using `&T` as its private data.
> -///
> +/// * We own an irq handler whose cookie is a pointer to `Self`.
>  #[pin_data]
>  pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
>      #[pin]
> @@ -420,8 +422,8 @@ pub fn new<'a>(
>              inner <- Devres::new(
>                  request.dev,
>                  try_pin_init!(RegistrationInner {
> -                    // SAFETY: `this` is a valid pointer to the `ThreadedRegistration` instance.
> -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler }.cast(),
> +                    // INVARIANT: `this` is a valid pointer to the `ThreadedRegistration` instance.
> +                    cookie: this.as_ptr().cast::<c_void>(),
>                      irq: {
>                          // SAFETY:
>                          // - The callbacks are valid for use with request_threaded_irq.
> @@ -435,7 +437,7 @@ pub fn new<'a>(
>                                  Some(thread_fn_callback::<T>),
>                                  flags.into_inner() as usize,
>                                  name.as_char_ptr(),
> -                                (&raw mut (*this.as_ptr()).handler).cast(),
> +                                this.as_ptr().cast::<c_void>(),
>                              )
>                          })?;
>                          request.irq
> @@ -475,16 +477,24 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
>      _irq: i32,
>      ptr: *mut c_void,
>  ) -> c_uint {
> -    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
> -    let handler = unsafe { &*(ptr as *const T) };
> -    T::handle(handler) as c_uint
> +    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
> +    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
> +    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
> +    // callback is running implies that the device has not yet been unbound.
> +    let device = unsafe { registration.inner.device().as_bound() };
> +
> +    T::handle(&registration.handler, device) as c_uint
>  }
>  
>  /// # Safety
>  ///
>  /// This function should be only used as the callback in `request_threaded_irq`.
>  unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
> -    // SAFETY: `ptr` is a pointer to T set in `ThreadedRegistration::new`
> -    let handler = unsafe { &*(ptr as *const T) };
> -    T::handle_threaded(handler) as c_uint
> +    // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
> +    let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };
> +    // SAFETY: The irq callback is removed before the device is unbound, so the fact that the irq
> +    // callback is running implies that the device has not yet been unbound.
> +    let device = unsafe { registration.inner.device().as_bound() };
> +
> +    T::handle_threaded(&registration.handler, device) as c_uint
>  }
> 
> ---
> base-commit: d860d29e91be18de62b0f441edee7d00f6cb4972
> change-id: 20250721-irq-bound-device-c9fdbfdd8cd9
> 
> Best regards,


