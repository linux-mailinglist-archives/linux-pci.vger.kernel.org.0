Return-Path: <linux-pci+bounces-34429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51766B2ED24
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635455A34F6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 04:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B012BE650;
	Thu, 21 Aug 2025 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqYqaSkL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F882E7F06;
	Thu, 21 Aug 2025 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751345; cv=fail; b=OdLulTn5+/GzL64p33zyS3sDatVSa9/h9TNI0u8dS5lWc7GlQwEui+arpQT7I4SrDaPf9xpOFHulP+SjIiIfePk/GnP0jXDpBa0zP/zL+ejps1TX6ezL992i4ZgzOJ88eashJHmxin4Xgkh10ae3wC4SdGmj75N9o/xuPwfaQ9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751345; c=relaxed/simple;
	bh=5AJeXBRDTlAoDMPi6jWxbZaK57UqYzS/zbVFqJ3zQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RybjAy+zDq1nvt8Yjrz7iizICcO4HkH/5PWApd0fe91C7l64HV27zWinaiW7HhQPoEi6Veb0uldbKSV56ng6bL6c+QviUc2pRtfrh2Mh6Qy+3V7VWHhVD+EXNuCuHvtOh5STsy7e8EB3DewdZyOMZ2/7djYJ14Zjj0vQIbX/Ra0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqYqaSkL; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq0LtrmGSqTtsihyBtOv3ewkMkkCfyhxhXvh3/C8cqIF8r/yvMpZuodXdYOTQzBp6N9dNcHYeDT0L86T3lz3kCEP/9dnUxIo6toMn4jfAbKQ4ILhTBHDCWGv7/mUfI7Sx/YiN+UehzaPtT6KmK8ipi/R4ftu6N61dvZdZIAKCCAHLWdQwAygC+TsFFCo4yFjkTT4pa1fawBkEjSdpin9/aE1/V1ehdc7OngCx2QcGEnt519l2Y7tmtjwbSwkJdO1kpk1aQFBao1rDZRajp26kXgi0znIf6ug7nlAq5KvQLRezqHh/inpbNnYwKOsMXFjsTBilAI3L1grCMRlDFiJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwprLk1/bgQy2DkCRo6s7iZqGCW0Vu6JYpizHHK5xFk=;
 b=SLBH7L8T2EXBOUGS/LOonYLYWuBF1oZ3vB6Y0nAkxB4l2yjtm2Tsy4Lpzm/TW4VE9g80rqWaHJ+BmJG6IVYcrKotmuyYR5HoM6wKt+UxaNbUeMC7pL8BnS4e4+wsx9s7IsYH0IRJ0UyVVqMsBDtxSibKj7o99hXZL0CCBkLq7K5MQUgS6Ts2SROnrvdj6OvN+L64OSxCFUlRR6dJ0Cx5RnWfzVglHB3ge03KDaKmUl5zKXanv/+3N+cfavf7igt1XxHMfoc3F6V6LHsZQyO0Q2mJQSzQc6OwVlnhZmKLzhWW4QdnsbZYW7nNW2Bu4QoEFwEdklHhAOiIQSormhh02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwprLk1/bgQy2DkCRo6s7iZqGCW0Vu6JYpizHHK5xFk=;
 b=mqYqaSkLWBq4fz7yx2iBBlZhfQfL40SVWsd8zDhl6zXNvDIV43Y8hyhJ4MXEf56ec3QXFoxJm8XxCsYnhHguAqcUzlNxkgdmhxpJOqJw/lx6LA0aTDw+c76ERf/lNJjTY0X+dQgBmWduuDCjgr/AvBkBA1EZuQsgfUn3wT/THCb6SDRtYwrPNXi+kZF5xlBFN/V503xqcYenUzXlAojXUJ04oftHlJDyw6QXerPUlpJn5BlNt/wpXVD4v/WiVH/hUSWulOjP3A72nagrPS8m8DO2DpgZJ8XZbBxX8uoFCKIp0S64yCGror2xvMbiK9/Jgr9wV1WBFkQm0yReWHyVSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 04:42:17 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 04:42:17 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [PATCH v5 4/4] rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
Date: Wed, 20 Aug 2025 21:42:07 -0700
Message-ID: <20250821044207.3732-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821044207.3732-1-jhubbard@nvidia.com>
References: <20250821044207.3732-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0bc0bc-6667-407e-e752-08dde06d1b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jkBqNWDhZjCikkJEdTnWdS0MvxqyO707BHS3dVpYzQPuFLGcWZzj83sQbAVe?=
 =?us-ascii?Q?BB6TY/LTNEzYcH08sKqBpC55xijW1lhmLSycDcQYd2fM9DQAlHKI9VVnKLTU?=
 =?us-ascii?Q?kpx1ZZqTSyjkQDjO2mAzSo1U3HmwfG75kViP7IdCVgvC9knRxLxNjt2iEht8?=
 =?us-ascii?Q?pUyCYadRpqR4nflNl6+b/vvHptvgswLXkgED9BM4acSgEOKo70sSLwTV9avX?=
 =?us-ascii?Q?DhWS8owtAYmp8Gcr9Zmg3hFi7HUtZNN021H808ZQfoBCOBUdHFJLkPAZ8NV0?=
 =?us-ascii?Q?WQFup0OWZObqGsB+qwZZMDHmzyoEl3wyw/YMSHWCpnHbDsoEemki8LaTydEc?=
 =?us-ascii?Q?Qo/2ppeP4liMQY4Rf0L0r97pWzNn+y34h04BZecRII0pdndrGExgHIr4RGAg?=
 =?us-ascii?Q?L1DNqDbgkNkifcKl6ivrODGrcYVzqXlv6SstXnqly8uUEpHGpTJ3/hFwP6UR?=
 =?us-ascii?Q?A3NsaELuBWXy0mvTX/HLx1KKsdKVU7VMX95d9uo78VavHIkdNzOcTKvpOUK8?=
 =?us-ascii?Q?nEOv2WQpKOIDjCZUXIt+WvFABuIHxrnxBRc31BMjk3xO+WVsxpjfc61tm3Ed?=
 =?us-ascii?Q?sTFtnSrXaXOkWX5ruezts/6pW2skuO41FAFULwMPi6f7b8zB3kjKmg7tf3Oz?=
 =?us-ascii?Q?rSSriqSSTo47h2gZA/vxMxbYnbjsfCC73m1EoxykNMsmhgi6b/n7r+JALmpd?=
 =?us-ascii?Q?P8r7pZIvQJ/uyg8Nzpvzihep9aJCsPEwdTIpCNO9VH3V1CgJ6nCk3cANKesc?=
 =?us-ascii?Q?uoguVVXEKh4cSlu9ms1cMvHue4wHW5YrWgaFCMUtcV5PIzJusch/6ShfoWSw?=
 =?us-ascii?Q?UWO6xxKFMlzxL4ArxY67xfgBDIqwcwfQUQ3HXaYquEbDshpCuMG9n+6kofRk?=
 =?us-ascii?Q?Lb0wl0Rquy4py25CSFQ9BeGiOEr4i7Sn/C0UXaZvr/wyU88L+7JUa01ZkgqI?=
 =?us-ascii?Q?oRyKE6jmfV126MtkqUvBWEX3llxE493Q0cE/ERxrI6fle0dO1oV8YeCwZte3?=
 =?us-ascii?Q?gGNCDlJRujMKhY5SoHiaYMkbDTbDOciJj2Rr6Mm2k0ukVyyJ8HtIn/QI6vX0?=
 =?us-ascii?Q?QnmZ7htuIoFRlMJ8zstxHrkx40VPOZpfcIUc+Gy0zvhjOxCRtf6pixQo+hE6?=
 =?us-ascii?Q?PgwnFbzsi2O1bbmXf0+LkJ4a9l3kzsHyO+lM33BDU4PP0h4DQ9795zFQ6tgY?=
 =?us-ascii?Q?5anB5C5gFCaRUgxLWq5W9qpbNPUP57nyYx328xXkfzD4UwWvdLPqRooIG/UG?=
 =?us-ascii?Q?wH9PJEo1yz1G26tvFs2KdWtvBVds7GExEuwfnzoNEY6Nslekr+u+eI8lm1y+?=
 =?us-ascii?Q?aYsiTqDeZw4bz1Od+nuxTElKiDSNPJl9y8K2Nu4NNKPWzgSMGrczBV1ADwYG?=
 =?us-ascii?Q?olhUa4hsdI3/FxHlw1UZojabRmZEtqk6Y5C70pgqmrYp6p1VWmfzUWhi/+PI?=
 =?us-ascii?Q?IEYHbVUPa90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87jfCv69tE0xDO+ITE91WVej+mT6kRaLHjTZEQZbqWq00In5C5/dNIAWgHaG?=
 =?us-ascii?Q?xXVjBn3kEYcNBhzqznrqfzk1Quznm5rzeGpyVV0vVModOaREdSgGk91YtQuy?=
 =?us-ascii?Q?zH//bWDqDFRfWww4T/M1k+xodtPHwUJWhDRw/Icm6gDapUVqgac3YrJm+Qa+?=
 =?us-ascii?Q?JdWitfuDbkyXDd1+ckyPfCPD3NQLhOEcnsrGmJpMNbkDS88v9Nt41M1571OL?=
 =?us-ascii?Q?/Hmh+QUNd/BrrAJTk3hGnpT5kLcKiH3bMGegKhqotGf9H+IBln9N8YUhJy/n?=
 =?us-ascii?Q?EVF+2PBXlOtdyay+cO+fOIhTKQ8H/6Xo+exGBH4PX09YfOjapf0aNulX6PxU?=
 =?us-ascii?Q?9qkmBisSBQLDtMgzH6rtXUEgJqY6lLyvnZxa9ui4iMk31s64RyFtnvX6FcUX?=
 =?us-ascii?Q?sWWH7w4ad2dk4TIxdCKxd9I6H359XtF4tTjXV1AEpsKLlduwtE4aU0tz0QIu?=
 =?us-ascii?Q?acn8+0PCAO+unukHPxm7FXt4ChXxasxljajB5p4wcNF1YVeCkWFkf286jRWt?=
 =?us-ascii?Q?UXx5nktITUacrOXsgyHLL/psJCeKl3WZEstivg8sTS2PbCpJQULdjBc6dHTI?=
 =?us-ascii?Q?ztQg1aoYKQIe9OtcznTLBRydHMKPDhoRCQMTzJKSBzKpKEeS1usNOMzsBsmg?=
 =?us-ascii?Q?LX8+Vq7MYihkhDxoA0JZwAmsRcL7BwtuAiOrc3q84QYJhi8LfoyMSbpbfyre?=
 =?us-ascii?Q?fFhuOfKAcXieGuQF3+I4Dg8rTkSKa97orgMp0FHI+q9bkGK13MgKd3GBsb1m?=
 =?us-ascii?Q?yRFP+HGRXPm2Ogk6KbM/nd/EYkadcq2D49IV/SQMfxaaCulVO1BG4eDD0sJj?=
 =?us-ascii?Q?Yn4Sf+2X+o7PHewnNmtQeozqImWmBai7n0wTsl3c7k0MXJ5yi1PqqKSX0ukR?=
 =?us-ascii?Q?lBeFAeM7LlsSAuevOCyhLKQAf/zDxsJhX0ieuwU6MU95DdvMYL4S7ogPlzJw?=
 =?us-ascii?Q?cBa3ckaviOHFMUrpeR0Mm4M1pWy/IjZhIcwCyUweknAxzHtkDxkcQ6dyd0jy?=
 =?us-ascii?Q?XaCHINhjmpHX20SD9ujI3mMfYn3aaBFf7gJJMyHGPUJPOxdtG7BNYubzo55j?=
 =?us-ascii?Q?msoqYiZsMLQn4YEDiQ47WQ0b+bA0mRSZK8iqIJ4V8le35xafabo/JIebdZnv?=
 =?us-ascii?Q?ZKaRKtcbnouCMRialgoomjtLf81n+wFMo3cGqOys+PLg2gS23zF4bkunyyU8?=
 =?us-ascii?Q?gth1djf5b1CEj4TNIKTwTvfPPemQnUJ1e99g9SZgTd874doEXu1QQhGM8cj1?=
 =?us-ascii?Q?5XysFuSgQdZfAawaX75P+qKEMjw0pbvliHFhbz178oREJsawqJFiIqUZQYtA?=
 =?us-ascii?Q?tGCYXR03bGq/42WrUrQcH5D6T600xSxujvRRRMFmglZb58SBqqVF1q1GJ5fF?=
 =?us-ascii?Q?6E6oIsVa3XaNRYq6f4wxj3DBeKQuz5wwUwbbmPBC8MP5J2O89E+A9b8nzY7D?=
 =?us-ascii?Q?AM/nFGTnXOJk8ucdie/1e4LO22/eouxM5xaz2tby2FF5Jr6UPfujS+aY/rHw?=
 =?us-ascii?Q?tCuh+oGF4fej7dLtLmaV23PM04y9ZgAf1iDMoylltv7Yv5SeWnEh5sJvaoDi?=
 =?us-ascii?Q?Aw5YkVciBBdPGo8Umdb0GPMu5ot46IVhGWLnrdZj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0bc0bc-6667-407e-e752-08dde06d1b4e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:42:17.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pXHAtf+VYFtfgNaBE86EtoFc5moDhTgl84kT/wwhv4C3fbMLLrAD9ObTsTCP4AXBGAazNW9tzsI8f75411xKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

Change Device::vendor_id() to return a Vendor type, and change
DeviceId::from_id() to accept a Vendor type.

Use the new pci::Vendor in the various Rust for Linux callers who were
previously using bindings::PCI_VENDOR_ID_*.

Doing so also allows removing "use kernel::bindings" entirely from most
of the affected files here.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs                    | 15 ++++++++-------
 rust/kernel/pci/id.rs                 |  5 ++---
 samples/rust/rust_dma.rs              |  6 +-----
 samples/rust/rust_driver_auxiliary.rs | 12 +++++-------
 samples/rust/rust_driver_pci.rs       |  9 +++++----
 5 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 504593c882c9..0ef8754f83e5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -132,10 +132,10 @@ impl DeviceId {
 
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
-    /// Create a new `pci::DeviceId` from a vendor and device ID number.
-    pub const fn from_id(vendor: u32, device: u32) -> Self {
+    /// Create a new `pci::DeviceId` from a vendor and device ID.
+    pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_raw(),
             device,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -231,7 +231,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
@@ -412,10 +412,11 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
-    /// Returns the PCI vendor ID.
-    pub fn vendor_id(&self) -> u16 {
+    /// Returns the PCI vendor ID as a validated Vendor.
+    pub fn vendor_id(&self) -> Vendor {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-        unsafe { (*self.as_raw()).vendor }
+        let vendor_id = unsafe { (*self.as_raw()).vendor };
+        Vendor::new(u32::from(vendor_id))
     }
 
     /// Returns the PCI device ID.
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dd91e25a6890..2e4c7edc48a4 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -124,9 +124,8 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 /// ```
 /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
 /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
-///     // Get the raw PCI vendor ID and convert to Vendor
-///     let vendor_id = pdev.vendor_id();
-///     let vendor = Vendor::new(vendor_id.into());
+///     // Get the validated PCI vendor ID
+///     let vendor = pdev.vendor_id();
 ///     dev_info!(
 ///         pdev.as_ref(),
 ///         "Device: Vendor={}, Device=0x{:x}\n",
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..f3385c4a7e5b 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -5,7 +5,6 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    bindings,
     device::Core,
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
@@ -45,10 +44,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for DmaSampleDriver {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..55ece336ee45 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -50,10 +50,7 @@ struct ParentDriver {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for ParentDriver {
@@ -81,11 +78,12 @@ fn connect(adev: &auxiliary::Device) -> Result<()> {
         let parent = adev.parent().ok_or(EINVAL)?;
         let pdev: &pci::Device = parent.try_into()?;
 
+        let vendor = pdev.vendor_id();
         dev_info!(
             adev.as_ref(),
-            "Connect auxiliary {} with parent: VendorID={:#x}, DeviceID={:#x}\n",
+            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
-            pdev.vendor_id(),
+            vendor,
             pdev.device_id()
         );
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..f3819ac4bad6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -38,7 +38,7 @@ struct SampleDriver {
     MODULE_PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
@@ -66,10 +66,11 @@ impl pci::Driver for SampleDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        let vendor = pdev.vendor_id();
         dev_dbg!(
             pdev.as_ref(),
-            "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
-            pdev.vendor_id(),
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
             pdev.device_id()
         );
 
-- 
2.50.1


