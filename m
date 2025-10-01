Return-Path: <linux-pci+bounces-37327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD9BAF8CB
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBEF188708E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD8275113;
	Wed,  1 Oct 2025 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nk8pT3ZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE126F2A6;
	Wed,  1 Oct 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306182; cv=fail; b=QOi3IvL/HpuyGUPvRVWEWj/pm7pIPDe880tafYaFc0EKV+IDb15V7WnryUHbTZrfbK8oj/Sx0QEI7qB2omcDIBe9wf8taOJlebLigEMrWA9KACURRngGhcGfxkcVPema+/EbXxjiUDRx4aIXr2all+bdBpn7An1nfyp8kTksLmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306182; c=relaxed/simple;
	bh=VYJChdqKqdq5pQGx1P4UQE44ZP6e1DmqyL5IewNd62k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gI8lhIWymoG5l41Lx5PB2upxNh6f/resmqftG9VRST+gQrDvqiLCp5FwfhS1zB1w9pEyERI2N4F3PKu2BxTJnhKnEe+6KVRWBSPX7TUbNUU7i8lkuiqTDTX3UWnVIEArbCmnm3WFaBYdM5ymaPUYVs+byBknjbokF3g1WauIius=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nk8pT3ZM; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwfwd0xrZR8ImkPvS2OQMxfVkShdXRnL3p5PRw9Rv6+JA/SMN4JWpDFjHIjhddDzSBWS34qrCVyn2RAuiK70j5A2kUIMts+enMhQNoCAvvUTbmrcQayR5bkBHFCLXi0xJcq2P2mFYMHCh6/LRRppADpZILmk+g807E5nqDfxUORu5kDJa3KuI4Fgfa1DOV2UPls4c3LgzayxuZPq7trrOYv+w/0oBgf7LC62EzVOk7AhzMTik0OHJwh/nBVk06iHu59MPydzJOdhMUp6MAMpoZrm32bj/uZhTpVtijnS6qRkWpqHoMYuYzm5gvrpgMR3ZcNuOgX8C4ZhApB6W5CPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYJChdqKqdq5pQGx1P4UQE44ZP6e1DmqyL5IewNd62k=;
 b=jDilhbYcqFCSEqefFlqa+00w406qHIH0NwJHC1eO1SWclDtS3SO7YmeBqv+d03RTp9QUsSQm1FfHBngwg/XB6Mfcv8uUl6AYWGI5yAiXxFM1h8jSFk+QuH6an7iIpNwrjig2n8cSlJHi5GA9qOZ+osAPUrLZDae4e/GUMcO2jtLVuQj+qEop4ZhkRw396g2jMdCSa0y07YZ2ajV3grwC9TMBKuSoFztEXzP6AE3lEzx+g22h2aauRIF/N0onlna7hRxdZHMb/xD54uT6UBatwg5eIQOT+WuPqMjNLXhzIw4u+7HJKKQBF1GeZGli0yUGhFsdPHbcH34xWmJV9Q9IIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYJChdqKqdq5pQGx1P4UQE44ZP6e1DmqyL5IewNd62k=;
 b=Nk8pT3ZMA0k9QeWld3fu9agpvm9KN77CULlZ4CTT/dAFnlAQ59uqAhQBIG2xM6t8zSNVdVbKe3ooJgrNRzEaKboVR5ntJvaan6AzBsW/EQr7jTGuWecAtv4zhv0xjSSAd6e8/OK3epkSlfu7xgG1c5Er73Ksa3iBbGfJ6WVktuzSa8B7Zsd+qJHjqHrU/YMKvLCfb7G0PfxBPEaeev92XfiVYRgA5DECx0y2TO6uNcJtZrRqlZZP2QawW4f8eh59YJuqtW1wHwAZEev3+SBB0KDMCfmdhflXuU4LHGRLoc5Be1hxAuIQuMKLOA71N353/7QKql60p1Zu+Tt4kBAqdg==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 08:09:37 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 08:09:37 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index: AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAAQmYCAAAOXAIAAAaCAgABrcoA=
Date: Wed, 1 Oct 2025 08:09:37 +0000
Message-ID: <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
In-Reply-To: <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: 43ac09c4-b48d-421e-1374-08de00c1dd6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3lhY2pjUTVzVFVtOGtkZjFYRFlCbk5Za0NnUnZZdDl5NVNNOC9Uci9Ienha?=
 =?utf-8?B?S2N2WGRXaGV0RmwvWXZ0NEo5YzQ1R1ZKUHdOcnpXcjZmenZXOW9FUVFyalgv?=
 =?utf-8?B?NUcyajdpT2dSbFB2K1kzZ1BHK1IveDZPTXY1L1RLZGdNWDNNU29pZ1ZoZ09Q?=
 =?utf-8?B?RS9CV1VqaTBWTWZYNGRXNkxrLzNmamhRSWFrdGxKcHA1Tk5KYkpvQTgycHFr?=
 =?utf-8?B?a1ZsaXJ3VENmNFNqY0gzVDNTL0hCaC9tSDVVeFdzM2hwSzZabnhhck5Dd0o3?=
 =?utf-8?B?NEdZbjlUUHkvVzNEcWFlbEI3aXJZc3FNb1FIenhqTE1uT0pJWk1wTytFTUtC?=
 =?utf-8?B?WG5jVnRlSVk0b2ZGcE16Q3NZNTF2d1RsMTQyUkdLRVltYjJrazFaNnBZZ1BF?=
 =?utf-8?B?aVh2aUYweERoRXpTaGpwcGp4TGhuOUhQQ2FpRkVCT0pobktxNzN6SGNvc2ZK?=
 =?utf-8?B?UmJyMDR5VDdVNXQ0czBBdXNWaEdnWDlHcmJBSVdUTHNPaXRuNUcvTXovZHRQ?=
 =?utf-8?B?QlZsTDJ5SjNGSmxoWkRVT2ZCenptL1cxVzh4ZjZzMjRHd1Zxb1FxaU52cVZi?=
 =?utf-8?B?UWhPRlg2a29zQnMxSUprbE5RcVFlWkdMeTBSYUU0OEpxTW53NHc2RmNoSWdr?=
 =?utf-8?B?NVFINWh2Tkwva2tjblJoY0ZXMGlKQm9zZGpEcStHQ0R2SjNyaEJkaWY5am82?=
 =?utf-8?B?b25tUUo0bWN3OE5vamdsSHZBd2JSb3NhaXVuVmVNZG5LcFBKMno0bjh6Yk9v?=
 =?utf-8?B?cGs4WVlic1BpTzJCUEErVy9PTjhmZmhUQUlFOUZRT0NwZzNwUlVLbStNT3Y5?=
 =?utf-8?B?Mnh3MUo3YW1Cc216aHVjVDYyaWNLZHVPK0hrMnNsWktYZENoQ2lYS1U0bWtZ?=
 =?utf-8?B?MHVKck9ESXlTZWREYlY3eTlVcXNGUEFLK1ljWUw2b0tSU01FU3VBV0FpRWdt?=
 =?utf-8?B?NW1iMWRHTTlRYjA0dzc4UlRmZ3ljSUR1N0lxTHhDM1REYmhDME5oVzF4b3Bv?=
 =?utf-8?B?ZXhnOVZvbkY4dzc3bWs2YlZVeHFMYjVIQnlxQ0x6dENVMHErMDVjNkphWXZU?=
 =?utf-8?B?T1JwdHhRQjU1UU5hMnVLSUU3K2tUU2RzL1JWNVhZVmt2STRpY0o3OUZaQkgx?=
 =?utf-8?B?ejdSOXFGdVVIWXBjcUhnL3huT2NhcTZTZmh1UURaR2tIMmtPbmo5ZHVKWkQ4?=
 =?utf-8?B?WVgyWFAxaTFZdkd2eWplcGZVSkt6RXNTVXIySGZaL1pHTGNpdS9TcndjRFJt?=
 =?utf-8?B?OUVTMHhuS3dwWnljb1NMZWRtV3MzN01NSmlGZDBPMlZFdlJCZnVyMW9mY0ph?=
 =?utf-8?B?Tk5oYlo2Y1FneUUyREt0QWdSODdTSmxUU1RubkRmUkRvWXFPYjI1UEdSZmZ5?=
 =?utf-8?B?c0VPekZ1eVdjVzNCOGxmNEVoWEFBM1l3MjAvRmJCMTM4ZWg2enh4MjF5VzVB?=
 =?utf-8?B?eWZlNVVrcHBBangyWVBpV3pYcHIxSFZJTzFGcm9yaVVlSEJuRW1zY0hscXRs?=
 =?utf-8?B?THhqL3dwbC9WL0FEVFVkZ1FOc3kyMmZwRVduSnRRL0h0dXNUTS8xZ25WR0pl?=
 =?utf-8?B?emExYy9KNHNJd0ZlbkM5eHFnNFVtU1dDTm1DSVpuMTRyVUpPQXBrRGhXLzRT?=
 =?utf-8?B?eHE0ZXBqR1RIcjh2MllwZTA3Zzc1QzI5RjlwNEsyWHdpU3J1Vy9GYkxmUXBB?=
 =?utf-8?B?OHRuUE1jSkRDT3lyL1c5dURHQW9RR0MzYnA3N1hkRWN3VVdHVHEwMm1ubXVE?=
 =?utf-8?B?MnEybHNRdEhhK0kzZFo1bXVGbXdQWCtBUG1QV1lTamtQNnFybkx5cG4ydklZ?=
 =?utf-8?B?RmxqZDhHRFk5anFQeVF1M3JiQk5OdEk3VHhkeXNhM2tRU1RFb2lQSEZLZG5E?=
 =?utf-8?B?NUxvOGk5TXVrNHBpazVWOHF4OTJFNzVYTFkxRC9qUFozNGplMG1UTVdEVE5m?=
 =?utf-8?B?TkRsNm9xVU1KanB2dzNPbDZ3OS9XTXJoOXFJYjBJVHpJVEFJVXE3TFZhOWoy?=
 =?utf-8?B?eHQ2SXZ6ektpaWRrZXNua0w3MVhQRnBsTkFPVS9KZXNBZlkzczk2RjNYWm11?=
 =?utf-8?Q?c6or5S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUNic21scEc1RTdicFZUT0YydzJFNjlEdXBEWGV5RnR4cXBXelZxWnJYdUJz?=
 =?utf-8?B?SGlXdm5rejkwSTYxU1lUbXRhRkVBRFhndm1VSFdtUE5PYjBLT1dRekpodTVp?=
 =?utf-8?B?TWVHNXExZXk2OWlrY2lPT3ZCRFlwa2Q4aDJBc1dlVnppeDVsQVNubERBMXVx?=
 =?utf-8?B?TXg3OUxTdzBtRlczWVVuWXFIbk9JU2VmdmpSd0NSbXlsNStPSVNwTHUzUGR3?=
 =?utf-8?B?WDdWMW12ZjBxVDM4Y2kwUThPck9EK2kzK3Z5OUpIOUg2NHVJclZITTR4cGRz?=
 =?utf-8?B?d05rU3dIdEMyak1yd0ZYVGRvWndBOWpwZ09jS2p3UUZjRFpYOGVTUWkvamtR?=
 =?utf-8?B?SWdZbVBDZk1tNkd0dDRTTjh1Um1vQVl1K1hmejU0UE1SbXNlTGVNcG1UOWZ3?=
 =?utf-8?B?NjQzUXk5Z1FkcTVKVmx6cEpielJ4a3FlMGplUE5HQlV6azR6dUVLY1g0b0U2?=
 =?utf-8?B?MEdxNzBhZHpRZ1VlSHJUeHdlM1E5WVUzVkhiSWdDRTJsMVJjSzRHbDdoM25K?=
 =?utf-8?B?Tmk1Vy9yRDU0d3VZTjZPZHlZNGJ2YXhlbGJHaXFHeGJJemswZjdNZElPQWRp?=
 =?utf-8?B?RzBnYXgwZW13WEpoOHIzalBlRnFFcTBmcmJXczlNSURHS1lRSjlLWit3azJ3?=
 =?utf-8?B?S3p3STFsYmhPY0daS1d0a2x3VmhXcGFTNnhmS3hsN29BMGEwVFEwVWwrSnFj?=
 =?utf-8?B?SkFUT1hXSTBMZDBKQVREamRNWkZnTnlvOXpJUkZnRGl2cDFzcVdQTkRuK3lz?=
 =?utf-8?B?UjgxblBWVE9ocEg0T2VrcDM3cDJJcWZZRENUZzhnczAwYklxVTBPdldoUzlS?=
 =?utf-8?B?SElzdE9LTnkwUXczSW5lQ3VqbkFUemxWeWxZeUtWTkNOd091d2dJSkVYVVpj?=
 =?utf-8?B?aHV2bEFZZFVJMmp4T3RyT0czaktlR3BBQzU2UnJ3b2xXd1dxazM3QXNUaTJX?=
 =?utf-8?B?VUJwck02b2J3clBmZUphQjB1OWxvbEV6VnNWS0dJbjlBTjJUY2xERTkxQ2pR?=
 =?utf-8?B?U1BUNkg3amg2OThGRDdtam5Panc5VEJJRXpyNHFVcnJob0kyS1JLUWQ3NlNI?=
 =?utf-8?B?STB4VThETGxQOXdTbi81Vk8zVWJnYVdCNU1vSS9ySE5ncG9NY0k3Ujk0NG5P?=
 =?utf-8?B?U3pQZ285ZlpzWGsxSFluQU5iaG9QNGZyYkwxTUlMS245R1lFbW9YYTd1VzMr?=
 =?utf-8?B?aTFGWkc0NDRtYzJmMjNWSklzWThyOURJWlZTTmFaTExRUVlXZi9yVkQvckJr?=
 =?utf-8?B?ZnVjVXNXVnBMRDdKUzBOZXZKWCtLbHZDQnRIQUxPSjIwMDVBd24wMlo2Y3Y0?=
 =?utf-8?B?UjZ3NmtlRHh6bGZFSmg4QThoSlF1WDhUM3R5TjJuY3FIZVVKeE9xdzVpUjYy?=
 =?utf-8?B?c0lwSndPZ2dZL2tHY1F3RWxCY1E5ZkZQSWd5bTlNRk1UUXl1b1U2L3JXdjBv?=
 =?utf-8?B?OGJFcVFXMHoyRkJuUmFUbUJqdXB1OVZoY0tMaFBsN3MzeXIrT29sS3lrUXRQ?=
 =?utf-8?B?S21YNjBrZ0NGVHFFeHBDQ3hnK2REdUNaZGRCaW0vd2hsVytGQmpRdTJjVkNE?=
 =?utf-8?B?OExERyt2RVBZM3ZSazZJdkRWaFhzYzY3M08yTWNISXlIRU5TRTU1ZDd2VEQy?=
 =?utf-8?B?UnVRQ2I3dFFDdzVWdGxRMXRLNWxOZC9qbjRsRkZjajk5ajh0UTlYK3hQSnpn?=
 =?utf-8?B?TEh4MHNuQWNNQ2VTSEttaVF1TG5hcUpYQlhkc3dPZ04zSUNsWTBUTk5tNTJa?=
 =?utf-8?B?dkF6RU9zRkZ4dHdWdG5GdjRiQ0NRMEV0YnFYYmlVUmJKU2pGTTBYU2syOVBQ?=
 =?utf-8?B?V1hOcTVEWXoyMmVCWnV2ZTZFYkcydHVvNFo2VWF1d0Z0YkhKN1JUeDRNUXh0?=
 =?utf-8?B?SlR3WHBSMGNFcjRQZ0VmZVBZUXFieXhjRjVJTDdwTHM4TGhNdDFIQlJXNHR5?=
 =?utf-8?B?RU1SWDNFYU40TFpOUi8wVGUxM1c0bktiYlFYbXBJOXQ5VWVFU0h0cGxmdHBE?=
 =?utf-8?B?SzNIdWZJWnRxUEh2dmJVOERPYitDS3p4RXhBN1cyYUlRZVB3OXNpY0RmQldV?=
 =?utf-8?B?bXNLQXZxWHh1OTYzWHM3bzFMR0NhcHlwc3RILzZCbndXRDh2Q212TmJiNWxl?=
 =?utf-8?Q?YomQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <451492BBA047D84CA07FF65EC170623D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ac09c4-b48d-421e-1374-08de00c1dd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 08:09:37.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRMM+zi2BODAv1G45RbsYx6zDHnj7+jiyNuEFbd3a089N3Ry3Gy3Ka1aZzTlN2zd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

T24gMS4xMC4yMDI1IDQuNDUsIEpvaG4gSHViYmFyZCB3cm90ZToNCj4gT24gOS8zMC8yNSA2OjM5
IFBNLCBBbGV4YW5kcmUgQ291cmJvdCB3cm90ZToNCj4+IE9uIFdlZCBPY3QgMSwgMjAyNSBhdCAx
MDoyNiBBTSBKU1QsIEpvaG4gSHViYmFyZCB3cm90ZToNCj4+PiBPbiA5LzMwLzI1IDU6MjYgUE0s
IEFsZXhhbmRyZSBDb3VyYm90IHdyb3RlOg0KPj4+PiBPbiBXZWQgT2N0IDEsIDIwMjUgYXQgNzow
NyBBTSBKU1QsIEpvaG4gSHViYmFyZCB3cm90ZToNCj4+Pj4+IFBvc3QtS2FuZ3Jlam9zLCB0aGUg
YXBwcm9hY2ggZm9yIE5vdmFDb3JlICsgVkZJTyBoYXMgY2hhbmdlZCBhIGJpdDogdGhlDQo+Pj4+
PiBpZGVhIG5vdyBpcyB0aGF0IFZGSU8gZHJpdmVycywgZm9yIE5WSURJQSBHUFVzIHRoYXQgYXJl
IHN1cHBvcnRlZCBieQ0KPj4+Pj4gTm92YUNvcmUsIHNob3VsZCBiaW5kIGRpcmVjdGx5IHRvIHRo
ZSBHUFUncyBWRnMuIChBbiBlYXJsaWVyIGlkZWEgd2FzIHRvDQo+Pj4+PiBsZXQgTm92YUNvcmUg
YmluZCB0byB0aGUgVkZzLCBhbmQgdGhlbiBoYXZlIE5vdmFDb3JlIGNhbGwgaW50byB0aGUgdXBw
ZXINCj4+Pj4+IChWRklPKSBtb2R1bGUgdmlhIEF1eCBCdXMsIGJ1dCB0aGlzIHR1cm5zIG91dCB0
byBiZSBhd2t3YXJkIGFuZCBpcyBubw0KPj4+Pj4gbG9uZ2VyIGluIGZhdm9yLikgU28sIGluIG9y
ZGVyIHRvIHN1cHBvcnQgdGhhdDoNCj4+Pj4+DQo+Pj4+PiBOb3ZhLWNvcmUgbXVzdCBvbmx5IGJp
bmQgdG8gUGh5c2ljYWwgRnVuY3Rpb25zIChQRnMpIGFuZCByZWd1bGFyIFBDSQ0KPj4+Pj4gZGV2
aWNlcywgbm90IHRvIFZpcnR1YWwgRnVuY3Rpb25zIChWRnMpIGNyZWF0ZWQgdGhyb3VnaCBTUi1J
T1YuDQo+Pj4+DQo+Pj4+IE5haXZlIHF1ZXN0aW9uOiB3aWxsIGd1ZXN0cyBhbHNvIHNlZSB0aGUg
cGFzc2VkLXRocm91Z2ggVkYgYXMgYSBWRj8gSWYNCj4+Pj4gc28sIHdvdWxkbid0IHRoaXMgY2hh
bmdlIGFsc28gcHJldmVudHMgZ3Vlc3RzIGZyb20gdXNpbmcgTm92YT8NCj4+Pg0KDQpwZGV2LT52
aXJ0Zm4gKFZGKSBpcyBzZXQgdG8gInRydWUiIHdoZW4gYWRtaW4gZW5hYmxpbmcgVkZzIHZpYSB0
aGUgc3lzZnMgDQphbmQgUEYgZHJpdmVyLiBQcmVzdW1hYmx5LCBwZGV2LT52aXJ0Zm4gd2lsbCBi
ZSAiZmFsc2UiIGFsbCB0aGUgdGltZSBpbiANCnRoZSBndWVzdC4NCg0KPj4+IEknbSBhbHNvIG5l
dyB0byB0aGlzIGFyZWEuIEkgd291bGQgZXhwZWN0IHRoYXQgZ3Vlc3RzICptdXN0KiBzZWUNCj4+
PiB0aGVzZSBhcyBQRnMsIG90aGVyd2lzZS4uLm5vdGhpbmcgbWFrZXMgYW55IHNlbnNlLg0KPj4N
Cj4+IEJ1dCBpZiB0aGUgZ3Vlc3Qgc2VlcyB0aGUgcGFzc2VkLXRocm91Z2ggVkYgYXMgYSBQRiwg
d29uJ3QgaXQgdHJ5IHRvDQo+PiBkbyB0aGluZ3MgaXQgaXMgbm90IHN1cHBvc2VkIHRvIGRvIGxp
a2UgbG9hZGluZyB0aGUgR1NQIGZpcm13YXJlICh3aGljaA0KPj4gaXMgbWFuYWdlZCBieSB0aGUg
aG9zdCk/DQo+DQoNClRoZSBndWVzdCBkcml2ZXIgd2lsbCByZWFkIFBNQ19CT09UXzEgYW5kIGNo
ZWNrIFBNQ19CT09UXzFfVkdQVV9WRiBmbGFnIA0KdG8gdGVsbCBpZiBpdCBpcyBydW5uaW5nIG9u
IGEgVkYgb3IgYSBQRi4NCg0KaHR0cHM6Ly9naXRodWIuY29tL05WSURJQS9vcGVuLWdwdS1rZXJu
ZWwtbW9kdWxlcy9ibG9iL21haW4vc3JjL252aWRpYS9hcmNoL252YWxsb2MvdW5peC9zcmMvb3Mt
aHlwZXJ2aXNvci5jI0w5NDUNCg0KPiBZZXMuIEEgbm9uLXBhcmF2aXJ0dWFsaXplZCBndWVzdCB3
aWxsIGF0dGVtcHQgdG8gYmVoYXZlIGp1c3QgbGlrZSBhDQo+IGJhcmUgbWV0YWwgZHJpdmVyIHdv
dWxkIGJlaGF2ZS4gSXQncyB0aGUgam9iIG9mIHRoZSB2YXJpb3VzIGxheWVycw0KPiBvZiB2aXJ0
dWFsaXphdGlvbiB0byBpbnRlcmNlcHQgYW5kIG1vZGlmeSBzdWNoIHRoaW5ncyBhcHByb3ByaWF0
ZWx5Lg0KPiANCj4gTG9va2luZyBhaGVhZDogaWYgdGhlIFZGSU8gZXhwZXJ0cyBjb21lIGJhY2sg
YW5kIHRlbGwgdXMgdGhhdCBndWVzdHMNCj4gc2VlIHRoZXNlIGFzIFZGcywgdGhlbiB0aGVyZSBp
cyBzdGlsbCBhIHdheSBmb3J3YXJkLCBiZWNhdXNlIHdlDQo+IHRhbGtlZCBhYm91dCBsb2FkaW5n
IG5vdmEtY29yZSB3aXRoIGEgInZmaW9fbW9kZSIga2VybmVsIG1vZHVsZQ0KPiBwYXJhbWV0ZXIu
IFNvIHRoZW4gaXQgYmVjb21lcyAiaWYgdmZpb19tb2RlLCB0aGVuIHNraXAgVkZzIi4NCj4gDQo+
IA0KPiB0aGFua3MsDQoNCg==

