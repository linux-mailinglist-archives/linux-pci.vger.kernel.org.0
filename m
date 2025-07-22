Return-Path: <linux-pci+bounces-32720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FDB0D877
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F0B161532
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBD623A98E;
	Tue, 22 Jul 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="iHGIY227"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771FB1E520D;
	Tue, 22 Jul 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184538; cv=fail; b=ADvitfF+EHV86JOD+kOkXz9ZKrKP0Q9wqpgBhM7D3/QghtUZf3yrtisQMdbV/nDiOqpxLCXG8K7wkuR9C8iyIIm0e6L0SFB6Xurz6kH5uQYv2BeN1+T4vH3Rm5m+bOne3Cu+76waz7XyR/rI1EOn6f0IccpmsRz6sirvG+dGWzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184538; c=relaxed/simple;
	bh=+sKaZ5Rf7vlDUZpdy5FU0JUp9IZNhvRiBx11wMf0u9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pAGeXjhLws/P9L/KYVaIa8MIEOTGBWI1O1WRlnJXkbEexkFuoo71blQfV/a4KrcmQKdAN6yNd9g/eKto23F6Sg6obYRiHnzflYhIq6wD+I57/JsEKvEYgY2yN1jULbh8BIxikIw+AsfNaaRbcimeOBSGAnrtcC4vIF8cgsbTaUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=iHGIY227; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq7RzVxoh0Ow9vgNPkwskwToqBzFKFBjhIrqbmoPbSFcD/xc+JtdRjlix/X4D3GWJ3hAPZ3r03Fi7z3M4+ljiMt5N3QZtYddJA9wg1oNk2zYdh5349Vk8zonBiwe02LwFDlergjtSWUofueQLy6aEvj05BiezVC+Ruhu/Qy3rEmLwNVvJwFjLLIC4CQs/L0gSB7TnmBTR3du7y46LNRUU2b1VV5l+JP0/uM5uuNy47zHSsmZ4M9Tqh9eHsahbu68TceUu9HFh7A2+HC/NCOlNapCJyreCS0WVPsqYwPWhHJGq1wBtnUDWpG1bHPUmFcLbaNQ8YwM/78eHfnDsL/tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24lSkkITWojsww2CRziY/gv0wogqKKBghPXBa/T+qTE=;
 b=ol9VFIA/ppTbvli+oecWRpeOwEEboRBsMwLEYc01ChB3itt/rZFQx2MFugg92WTusF5K67gBu1/YmjwUEuj7dGa/G0IDgLZVVYHjjX2soGMTDVxakH+0UNAZX+2KsvuAyobIkL9PJzNUV2dRvhqiEV3851IZ9gOBdmHaCpzs7Z1WmWu0JeGwP6uzFixt0KBdIsgtSIe6Bp8jgsVCSpP+MPosqU2dy1o29KgjkPFa/QpLQazWnrK3X7MGcNG8GhRjqHc6YyUfnQjMZta1VrWcMZYMRiQqCQP5Xghh+MoOQ/NONhwixDc7/pe3bZ3oBWByool54TU7xCrzhKJZPfp8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=collabora.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24lSkkITWojsww2CRziY/gv0wogqKKBghPXBa/T+qTE=;
 b=iHGIY227X7269Z0wWHU+RjcBN63ZxnIHQ1q2t7ol+R4+7gwYl6X1bEHb3f7+D7komg32V5NiF9lpNS18sUUl20dtoP+nPlH1UjlAOHICUTeSMsyLFS5lB6FHiBJF3kCC0rD46z1YnlzzyyIWmhFdtNaUmcK4gHvjK9OAQ6/mDAUDVx2ecKGihG8SBpZ5zIzFNk7tlHaVTqyFUrp3jLfbF+xP1VHue+Pyn4EeJEBC7dyM5PzHPWSjatU5tRjNQlSALPKkkPFiBx/bbfqzgw//MjxilH8X5+v+BoVhyYOSOhMYNbL6RudV4hRvLdaiYL3FjRs+Uev9jRHDjbTvpKWbXA==
Received: from DB9PR02CA0021.eurprd02.prod.outlook.com (2603:10a6:10:1d9::26)
 by AM0PR10MB3522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:153::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 11:42:10 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::a5) by DB9PR02CA0021.outlook.office365.com
 (2603:10a6:10:1d9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 11:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:42:10 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 22 Jul
 2025 13:41:56 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 22 Jul 2025 13:41:54 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 22 Jul
 2025 13:41:53 +0200
Message-ID: <dd34e5f4-5027-4096-9f32-129c8a067d0a@de.bosch.com>
Date: Tue, 22 Jul 2025 13:41:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 0/6] rust: add support for request_irq
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg
	<a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Benno Lossin
	<lossin@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|AM0PR10MB3522:EE_
X-MS-Office365-Filtering-Correlation-Id: ce673b62-e06a-4a4d-04a9-08ddc914cb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU56VzFzdzhBTVZtTS93bCt5YTdWVEQwenFOMkJXVlJHRzVESDhIbjhGckpm?=
 =?utf-8?B?ZE9IT2UzSjlRMTBzZ2dpRmNoV1NtWkVYNit3eHR3VEN0WVJWOVNySGdKMEJv?=
 =?utf-8?B?OWp0K2w2SUNtenpOTmdtZXFSZEYrV2c2OVd0UmRkNGo2aEkxZGZmVkdET1BL?=
 =?utf-8?B?L1Z0T3dIYUloanJNNXRBeFZqWlZyaEZzSzdOS3M2eUw5L3ZaZ0NHcWxaS1g5?=
 =?utf-8?B?YVJhK0dLckJqdk9EeW9TbmlvbW1raDJBaEVFSXVobnF6bmFQV2FqTkd3c2Vi?=
 =?utf-8?B?aktLL0VLS3I4aGxBVXphYTZZU1NPa01qdDlLbkVLNUJ6aVRLeFBHU1oyZHEz?=
 =?utf-8?B?ZFUwWGJNQTZLUTNwaUZPUjZiWk8xcGdWUkh1THFPblZTZHArY2kzOU5NcmxH?=
 =?utf-8?B?VDNQaTZGcmRkV1pQMzUxclpiaEtMdVA3MjBaVGlxZFpyRGVVSVE2bTdiQmJJ?=
 =?utf-8?B?OXhJSDRUZm1uTjJPQlF2V1hpWGJHTUNkWnZJRy9aNlN4N2hKY21VWXd3M0xZ?=
 =?utf-8?B?Q1htWG9ocUp0a2h5Tmd5OC9LeUZJVXNaYVBXUGJXS3l0ZjZNQkVkTUtOeXJG?=
 =?utf-8?B?bTBSQWo4NzhvUmhBckU0aU50NUt0SjlaQTkyc2VoTGtjU2J6NjN5elIzTk82?=
 =?utf-8?B?eHZHWlM3djZDQmRUT3pDQm13MkZaMFdYa3Y2OGNYaWV1enYvb2RVS1RxTklt?=
 =?utf-8?B?UkY4bjN0S3VtV3JGOVR0NHIwZ3N5ZEExZUZUQzJTdjBKYkoxb0w5K3lTY2dm?=
 =?utf-8?B?T090Y3dsNktCMUtkUG05TlRiaEIzajlwS3NCUHd4RWJwM01weERDUkNZOXpJ?=
 =?utf-8?B?eGE2SDlBYkFSbFhac2FsREplRVJDMzVub3NaKzlPRHp6NFlLVXVlVTF2UDlQ?=
 =?utf-8?B?d0xtNlpGYUFmZ013WksxVDJUUkp4Q2pTODA5SEF2UkRDQXlMWVBEaHZ6ejJB?=
 =?utf-8?B?bC96MU14Mm45dE12R09YQWU3ZUtPdUlld2xkNVJXMGx0RTJPNVBBK2JydlVD?=
 =?utf-8?B?QTlEQ0k3UnRESGJqeElRaktJS1pnMXdEekZJUU42anBEOVgvWGY2OHUzRlMr?=
 =?utf-8?B?K2hvUG5XYW1CSG9TMGZkMW9CVFpyWjd3NWlCbSs1TWRHL3gwYi85QTBsbldo?=
 =?utf-8?B?TGFoWkVLNUdPQTlQajhRUEpqb1M5UElKd3lQQ2lMNS8waGlIOWlTcU1TWlNn?=
 =?utf-8?B?QVgrN3A3bmNEK1pLMkgxbVBaRW1FazIwdHdPOTllTUxRQXBucHhrRlRzMzRu?=
 =?utf-8?B?bzIwc3pxZUtNbEJ4cS9iWVVtMlIvVVVBOHdsYjloZFVLL3F1NHkrNlZ6MW9s?=
 =?utf-8?B?aFI2eDdvNUFSZkZ0QTkyeS9hUWFyZ0RzdThJeFBETWMvOFpHQ0lGVDlmdHlH?=
 =?utf-8?B?NUxUS2pLQnhva0lid3g4VUU4VUdmQTd5M3J2aTV2Y0FWSDEvLzBiTzhMMVd2?=
 =?utf-8?B?eTI2bDJPYmp2d3hBSkpIbjIxVVkyYklLeFp3WWJ2ZXlXcGNJSWNWNXNVMjZ3?=
 =?utf-8?B?YTh0dHdwOUpWTWx2Y0pGeWU2L1ljdldaampMeDNJVUcydkJMTWJ2Qmwwb0Js?=
 =?utf-8?B?V0ltdTFqY0ZIeUJ5TGQwRk44TG1OMzZsOU93MzJ0MEl0LzVTTlNIYWN5ZnFJ?=
 =?utf-8?B?cXZmSU8weUlrZDRXYUl6eERyOGEwMHlYeEFNemxVMkhNTXdScEFVTWxVcUFl?=
 =?utf-8?B?aDZXaW9mSDduWENZbk1FYWxjMm5oM1RsM3hhUjcxZmdEMi9NVzA3RDFVcWFQ?=
 =?utf-8?B?Ym9hdnlya3JRUit6UW9xSm1ndGNvL2dPN05LV2hkeTdnZS9RcnRwdUJKMENV?=
 =?utf-8?B?RDFjd2J3aDB6QjE4d2pIbmlURmdSWjNrZlFPd1JKN2EraDUveDBMM2h5ZGVD?=
 =?utf-8?B?UUtkbExVOFpDRXVKOEt2THZNdTA4VUltK0pKdnl4WHJUU21odCtUQ0NWd3lo?=
 =?utf-8?B?R3dJdjI2NFhkSWd1ZlNMYmhHL0JsU0F1QnE1TjVZdXlnYkJ0Q3g1b2dvZHpH?=
 =?utf-8?B?aUxmQWZXSDExOTlyWmkvc253TTNERERjVkxQQi94NitNTjRuTkoyb0NKbi9G?=
 =?utf-8?B?UG8vM2tDem9QdVNtbUwxdGxJTmpCWEJzdDNnUT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:10.2553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce673b62-e06a-4a4d-04a9-08ddc914cb49
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3522

On 15/07/2025 17:16, Daniel Almeida wrote:
> Changes in v7:
> - Rebased on top of driver-core-next
> - Added Flags::new(), which is a const fn. This lets us use build_assert!()
>   to verify the casts (hopefully this is what you meant, Alice?)
> - Changed the Flags inner type to take c_ulong directly, to minimize casts
>   (Thanks, Alice)
> - Moved the flag constants into Impl Flags, instead of using a separate
>   module (Alice)
> - Reverted to using #[repr(u32)] in Threaded/IrqReturn (Thanks Alice,
>   Benno)
> - Fixed all instances where the full path was specified for types in the
>   prelude (Alice)
> - Removed 'static from the CStr used to perform the lookup in the platform
>   accessor (Alice)
> - Renamed the PCI accessors, as asked by Danilo
> - Added more docs to Flags, going into more detail on what they do and how
>   to use them (Miguel)
> - Fixed the indentation in some of the docs (Alice)
> - Added Alice's r-b as appropriate
> - Link to v6: https://lore.kernel.org/rust-for-linux/20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com/


Looking for an easy way to test interrupts on an ARM64 Renesas RCar3 SoC
I found a quite simple timer unit (TMU) which has a configurable (start
value & frequency) count down. An interrupt is generated when the
counter reaches 0. And the counter restarts then. There is a C driver
for this already [1].

Using this patch series together with Alice's [2] I got a quite simple
periodic 1 min interrupt handling to run (just for testing, of course
not a full driver): [3] (output [4]).

With that:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks to Daniel for the support!

Dirk

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/sh_tmu.c

[2]
https://lore.kernel.org/rust-for-linux/20250721-irq-bound-device-v1-1-4fb2af418a63@google.com/

[3]

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517a1ac2..d009a0e3508c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -554,7 +554,16 @@ config RENESAS_OSTM
 	  Enables the support for the Renesas OSTM.

 config SH_TIMER_TMU
-	bool "Renesas TMU timer driver" if COMPILE_TEST
+	bool "Renesas TMU timer driver"
+	depends on HAS_IOMEM
+	default SYS_SUPPORTS_SH_TMU
+	help
+	  This enables build of a clocksource and clockevent driver for
+	  the 32-bit Timer Unit (TMU) hardware available on a wide range
+	  SoCs from Renesas.
+
+config SH_TIMER_TMU_RUST
+	bool "Renesas TMU Rust timer driver"
 	depends on HAS_IOMEM
 	default SYS_SUPPORTS_SH_TMU
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 205bf3b0a8f3..66567f871502 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
 obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
 obj-$(CONFIG_RENESAS_OSTM)	+= renesas-ostm.o
 obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
+obj-$(CONFIG_SH_TIMER_TMU_RUST)	+= sh_tmu_rust.o
 obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
diff --git a/drivers/clocksource/sh_tmu_rust.rs
b/drivers/clocksource/sh_tmu_rust.rs
new file mode 100644
index 000000000000..328f9541d1bb
--- /dev/null
+++ b/drivers/clocksource/sh_tmu_rust.rs
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Renesas TMU driver.
+
+use kernel::{
+    c_str,
+    device::{Core, Device, Bound},
+    devres::Devres,
+    io::mem::IoMem,
+    irq::{flags::Flags, IrqReturn, Registration},
+    of, platform,
+    prelude::*,
+    sync::Arc,
+    types::ARef,
+};
+
+struct RenesasTMUDriver {
+    pdev: ARef<platform::Device>,
+    _registration: Arc<Registration<Handler>>,
+    _iomem: Arc<Devres<IoMem>>,
+}
+
+struct Info;
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <RenesasTMUDriver as platform::Driver>::IdInfo,
+    [(of::DeviceId::new(c_str!("renesas,tmu")), Info)]
+);
+
+const TSTR: usize =  0x4; //  8 Bit register
+const TCOR: usize =  0x8; // 32 Bit register
+const TCNT: usize =  0xC; // 32 Bit register
+const TCR:  usize = 0x10; // 16 Bit register
+
+struct Handler {
+    iomem: Arc<Devres<IoMem>>,
+}
+
+impl kernel::irq::request::Handler for Handler {
+    fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
+        pr_info!("Renesas TMU IRQ handler called.\n");
+
+        // Reset the underflow flag
+        let io = self.iomem.access(dev).unwrap();
+        let tcr = io.try_read16_relaxed(TCR).unwrap_or(0);
+        if tcr & (0x1 << 8) != 0 {
+            io.try_write16_relaxed(tcr & !(0x1 << 8), TCR).unwrap_or(());
+        }
+
+        IrqReturn::Handled
+    }
+}
+
+impl platform::Driver for RenesasTMUDriver {
+    type IdInfo = Info;
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<Core>,
+        _info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        let dev = pdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Renesas TMU driver.\n");
+
+        let request = pdev.request_io_by_index(0).ok_or(EINVAL)?;
+        let iomem = Arc::pin_init(request.iomap()?, GFP_KERNEL)?;
+        let io = Arc::pin_init(iomem.access(dev)?, GFP_KERNEL)?;
+
+        // Set count to 1 minute. Clock is 16.66MHz / 4 = 4.165MHz
+        let timeout = 4165000 * 60; // 1 minute in clock ticks
+        io.try_write32_relaxed(timeout, TCOR)?;
+        io.try_write32_relaxed(timeout, TCNT)?;
+        // Enable underflow interrupt (UNIE, Underflow Interrupt Control)
+        let tcr = io.try_read16_relaxed(TCR)?;
+        io.try_write16_relaxed(tcr | 0x1 << 5, TCR)?;
+
+        let request = pdev.irq_by_index(0)?;
+        dev_info!(dev, "IRQ:  {}\n", request.irq());
+        let registration = Registration::new(request, Flags::SHARED,
c_str!("tmu"), Handler{iomem: iomem.clone()});
+        let registration = Arc::pin_init(registration, GFP_KERNEL)?;
+
+        // Enable TMU
+        io.try_write8_relaxed(0x1, TSTR)?;
+        // Read back registers to verify
+        dev_info!(dev, "TSTR: 0x{:x}\n", io.try_read8_relaxed(TSTR)?);
+        dev_info!(dev, "TCOR: 0x{:x}\n", io.try_read32_relaxed(TCOR)?);
+        dev_info!(dev, "TCNT: 0x{:x}\n", io.try_read32_relaxed(TCNT)?);
+        dev_info!(dev, "TCR:  0x{:x}\n", io.try_read16_relaxed(TCR)?);
+
+        let drvdata = KBox::pin_init(Self { pdev: pdev.into(),
_registration: registration, _iomem: iomem.clone()}, GFP_KERNEL)?;
+
+        dev_info!(dev, "probe done\n");
+
+        Ok(drvdata)
+    }
+}
+
+impl Drop for RenesasTMUDriver {
+    fn drop(&mut self) {
+        dev_dbg!(self.pdev.as_ref(), "Remove Rust Renesas TMU driver.\n");
+    }
+}
+
+kernel::module_platform_driver! {
+    type: RenesasTMUDriver,
+    name: "rust_tmu",
+    authors: ["Dirk Behme"],
+    description: "Rust Renesas TMU driver",
+    license: "GPL v2",
+}

[4] Interrupt each 60s:

...
[  430.655055] rust_tmu: Renesas TMU IRQ handler called.
[  490.637054] rust_tmu: Renesas TMU IRQ handler called.
[  550.619052] rust_tmu: Renesas TMU IRQ handler called.
[  610.601050] rust_tmu: Renesas TMU IRQ handler called.
[  670.583049] rust_tmu: Renesas TMU IRQ handler called.
[  730.565047] rust_tmu: Renesas TMU IRQ handler called.
...




