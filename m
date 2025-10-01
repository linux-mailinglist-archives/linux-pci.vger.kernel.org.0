Return-Path: <linux-pci+bounces-37372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C24BB1C98
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7D2A0648
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934172EA493;
	Wed,  1 Oct 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDRyFNsU"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D001F582B;
	Wed,  1 Oct 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353219; cv=fail; b=gvP/E4h7RjlVLxh9/+O9sdkrqlwbiL4CCdeEwWg9oIK5AZJLwDiW43Z4J9aUk3Btrv07tiNx0ReMysEGH7AlQ9lIFSHsUapff7TSFTKsKn21IFErURrLZOAtqPDo9UNEOxn9M0QH3oO8RLnnPtMZ3Bxb+IltDBk9SdcCuejX9PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353219; c=relaxed/simple;
	bh=OZ3DSOLIBToPCQrlBK5uSEtBUWnJSaSLbOfyIuy5j+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbF5obAoP/nn4XofE1RODsTf7Y+ONVLAo0lsPuXOkVzsGRFk05wjGVJEHaJILIJZstyiPiufHBHs143V55Vf7shRzJBj2Nrlfd6parlJQpqxfbdbYDMCg8XzX8mXtCMf3i1ZmT78qenS6U1Rbywpn/XGevcGxt//cSpi1Jh5rlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDRyFNsU; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfIF+oh0afj/QG/WhdxNtZRZ1r6Cm4GkzGE3vcff18tXlkmQc5QzsI7bBbiKgGIM6ad06tfzjufJMBMibL6gIonwdWmRuRkf0GGeO5E7XX4KL/09HLYrymCCDRPLUXvTa5CmxkWZwgAtB2NF2EVec2gYpomVJPR+PktfTtucNJv7LQlfxnr7WDbhIyLOPxuNLYhqTC5mi1YgaRIXwjiGv38ZGsF3ZhBPBAo8JOhDrmWIZ5vOHtrPC5dlYrad4Cb584Bi1HRpn4tI8C71DYE3Q3J67Ma2HzSku0XElWe9t7ifMQghkrFYC04bGUANiUYJgtUIaG9MzTj4Mn/DSibPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ3DSOLIBToPCQrlBK5uSEtBUWnJSaSLbOfyIuy5j+4=;
 b=ZJANDRfDwl+5wvW8PX/6Zn1R9rOx04aefRI1VwyGJgOguUObHRFjyYf/4XNxljDfPV4+3w9FJvAH+mZKIZmdnhyE+wEgpwQ5tdCOklXFVVDSDQKFwKY40pYM956UJZqsqfam6M33/FhwZ9lP/pF65sbCXHKYtO5aBurrYezdLdY4dfO2DRImEWZ+UaVD5twe+mFfnI/JEAsftoFM0EWgmqt59cAhSA7wxgp8ukmuFvcg/ZA4ADSyrOCJDGdc9ryS0n4atNLIHmkAJMYwaqZWVt/BkcfSvhb55R3jzwvGH4MN4vD952TMlJQ0Wq/30fziJpWMuMixvxkIOxYuZFmzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ3DSOLIBToPCQrlBK5uSEtBUWnJSaSLbOfyIuy5j+4=;
 b=gDRyFNsUAj5/l992pBPBPrRbALYJEE4YupRGr3J7Wh5dswRNxeyHPoskN1yrp4G7gAAABBnEetdkFYonChMSr//PqK2Wc86CR9ePshbM1VDl7NX/JUwP1TbMkrLGHsO4Cw0cCLx+EKqI4KYRBGt9NrivJirMAXnZlGqHArIzdNmF/ZJaKMXSvoixzqrSuo0x+jOlG7CiJ/8wv161hiq/YTAdBa10/DtT3d4VKpAUeHkOoR396zwoGg8YfTSxZlFXLHWdnhYCFLaFECik07MsdK9+TfTe4spIo2AZ8TQPOJbpwbZhHlkAtHjemLEY8slmF4t5UthXkYroh7VQ4bXHfQ==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 21:13:33 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 21:13:33 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index:
 AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAAQmYCAAAOXAIAAAaCAgABrcoCAAG9gAIAAa6iA
Date: Wed, 1 Oct 2025 21:13:33 +0000
Message-ID: <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
In-Reply-To: <20251001144814.GB3024065@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|IA1PR12MB6460:EE_
x-ms-office365-filtering-correlation-id: a8fe6618-25d3-4415-2a49-08de012f6104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmNqQkw5VmpDQWMyUTM3d3NyQjhEQVN1b1hHQzM3bnFPZnArSGw4YlRFWXFs?=
 =?utf-8?B?YlpwUmFJWGZFODlJNXhFWW5uanlPeDZ4TG5sYlhiUnpoeWF0cGFaLys1RENu?=
 =?utf-8?B?dDU2VkpHSEhRNWYyR2J3UDdnZkFvajY2cm56cXVtUlV2TmFDc2g0ZGo3R0l3?=
 =?utf-8?B?TXY4dWVEYk51RW5FemM5dTdCb3h5dkVuM21FRUovYmJaMk0zSHI1ZklqWlJx?=
 =?utf-8?B?eURkUTd3WXRqVy9zR2o3ekxpVXU3TkJOai9TckRMRndYUHJtTGxzdlY4T3Nt?=
 =?utf-8?B?UElGMkppbThKQ3VjSzFZOE1ZNE91VjFKSjFKUEtibFpFK1pCMGxvb0JwdFQy?=
 =?utf-8?B?TEltQ2xTOXR1dDg2Qm04aXE2QWYyRGpqTk1BcGFRVThZNHVBclBEYjZKajNj?=
 =?utf-8?B?VytWbG9wRXAwVzZrcTk1elNTejhlak41NXRHOEZOakdIN3hJTHEyVHZvSUF0?=
 =?utf-8?B?dFdZb1N6RDdaVWFPVlNRbG5JY1hQdDZmUFVRZGRqa1BQWDJKTnpvMytBMDV4?=
 =?utf-8?B?MHE2TVhya2IrUFppV0RtYjM1UHBodEZUUElvWkZTV1VtOTNieXlxanJ3SWtI?=
 =?utf-8?B?WDhkOGVuNXNKbWZaL1pRUisxNit1aWVyWC9oYy93ZjJlc3VtMktnMnh4OHc4?=
 =?utf-8?B?Qm9tcU1kZlRhaFBBMG52NzBtYUpDeDM2R2luaUF4ODJERzUwamEwT29wVmhz?=
 =?utf-8?B?bWJOWGR4UTRMVVR6cGZ1NVpySkxsQUJHNkJ2RElDS2FlMkZHWDJaY3YvQ0dJ?=
 =?utf-8?B?eG1mVWZvM01obU54aHdKQnRWUzJjMEtadXBydERYZDBTKzdOOUtYUVl2Uk9n?=
 =?utf-8?B?NCs3SkFmcTVwNEIvL1djZW5WRU1Tdi92aVBpL2thNk5RbGRjSVRGVFBRMFp1?=
 =?utf-8?B?NkY3VXZ2b01acGZZbGpIZ2tUSTFRaUp3c2dubXovZ2x4U2JSUGk0SnQ5Q3p2?=
 =?utf-8?B?cjNxbTcvdHdkazJXQ0FkWmllQTJ3MFRTSm1XK2hrUmdON2hQNmdmdHBJK2Jm?=
 =?utf-8?B?Ryt3YTlSVUV5TkRnd0xTU2ZIUHNVcU1OZ082b2w3L05DVlhVb1lPWVBCMGE0?=
 =?utf-8?B?ZS9WOVM5RUVsUnpjOEpLSjhwalN5cTlJbC9zWlREQ1JPMXdNcVFUbDFSOFlp?=
 =?utf-8?B?YnVPOUpjQ2F5cmpac0ROalVYVkFTZmU5Q1NZQ2ViQ0JuQ3FaNEZwaGEyVXIy?=
 =?utf-8?B?cnAwSXI2SWI1T2JOSWRPVlZmSXdsR0IwNHNYN0I5WXJwYk9CaUdkYU5IdW0w?=
 =?utf-8?B?MG1kSDN0bSt2SFloSmVyVXd6VUhiTTAvcWkzbUh6R3d5SEdwVXNMcWFqbmFE?=
 =?utf-8?B?WXZOVENlbXpjWTR5TWJ1Z3BIQXdtMkNjaXl6Qld4R3hUcG1rSEsvZ0lma2NZ?=
 =?utf-8?B?UFc3aEEyK3hHQ2FhNGN5OEdXOUFqRFZmcklkamlpc3VkUUhoeTBIVUJlNkla?=
 =?utf-8?B?TTd6dUFQK2JRNjk2SUhkMUFCMEVjTENjTWszeUtFNzB0ZHlvSzlWRWU1SDVM?=
 =?utf-8?B?NzZadHdldU4zalYwZXNVbUcvcXN5TzB5YmFOaWQvT3d2NnY0ZlJqQllYS0VB?=
 =?utf-8?B?R1BZV09TaEJwUTUwb0tKck9DU0c0UERGVDMxUVFoK3o1aHFTVGZqWkJOZ3J2?=
 =?utf-8?B?Uk8zeFJ0VXErVHhNQWtleXNlSjZLTy9PVjYxd3dCOWtWV2Q5VzZZYm53OEdV?=
 =?utf-8?B?Skl5cmpHaGxJbE0xR2RqVDlhYlZaWFVMaVhDaHMzWkkzNUVWdU1BblZoUFM3?=
 =?utf-8?B?ZkptMUZmbXcraXJIN04xdGdBdVFBZUFzOC94VG0vaVovNXBxa0RsaEZDUWxN?=
 =?utf-8?B?c1BqVCtqdzY3aGsyMFFBeVl4eW5pRGMyMUtuMm1YNnBGVE5RUUNmUVJTdys5?=
 =?utf-8?B?MjFxSWxxRnNpWm4wWmNsZUNVdWxTOHVVKzJDWnM4ZDlja3BHQk0rcTE4Ti84?=
 =?utf-8?B?a3ByMVQ5aExObzBiOHNocm41UmcxVWRFT2s3Ykg0aFY5dlJ5MHFOOURZRjNR?=
 =?utf-8?B?ODlPSVdMTGRjTVZBQ3B5ak5NQVcxUm1RU2RsMi83Y1Y4ODB3WHRaREJDVTYr?=
 =?utf-8?Q?Whhip0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlNHUGlVMmtibzJZWW9tUjNJcjFTQmdCaXNoSENrSThqZG9hN2pKeDBwbzdR?=
 =?utf-8?B?Y1FrQWNoempVL054Q2NNOEpYc3BvVDdHbmFsUWgxK2JPamNZbUZpOWk1WFly?=
 =?utf-8?B?MldaeE1KallsRkcrQnd0NHJpSEI1cnkrczBvQXJIVEVCNERhK1FmMk5zcWlq?=
 =?utf-8?B?ZS9Xc1pSMmZCQmtWTDJPc1JQWWNrdFlWbkZwOG9Xc09XdzZsdnByWjZ6bGFO?=
 =?utf-8?B?eFRvWEtxbkNaZVovUFU0WWFITDMyemV5SHM0RU5WbXkvUUdsT1I3MkpFRjB1?=
 =?utf-8?B?UkRVMTRDSFhZKzlWaE4yTUlreU9kRUUzNjBMWm41dVhRRFhMOER3WXQwdWlB?=
 =?utf-8?B?NXNseFY5T3orOWUrOTd2b1dxSzdYZDNnaFVTZTRpK3VzMkdNeGlibllyQ0Vr?=
 =?utf-8?B?RVRvVDBwT01QZ1pXbkNiZURzSVdmMTMwYWo0V0tkZFpPYmhhdlRGV1RzVjl1?=
 =?utf-8?B?bmo4Yzh5b0RTTWJVK0lxUU4vcm1CaEw4aHN0K1hNNkQ2TmwwMlVGQy9NQkI2?=
 =?utf-8?B?eHVwN2dSVkdKNW5hYlNtY2E0bnZqZHdrMkdhQ2xpV1ZYcTZVMGt1NG5CQS95?=
 =?utf-8?B?UUg0MnFYZEw5SWlFYmdrTjcwWE9kOXRqYUl4VFAzdy9Wc2E0dlpnTWZRUGx4?=
 =?utf-8?B?cFVEcmQwQzNhYW5RTWJxRnFVbGN1TVdld1lpd3ZxazFOTm04V3F1N3RzS0hE?=
 =?utf-8?B?SThIZWU1Nk8yU2I5M0l0cGl0Q1JsWWlYZEgyWXFIeU55NVpiOGsrZGY3dmgy?=
 =?utf-8?B?Z1Z4WnJEaURmMVFrbktlV0VYeWdkWTBvMXVEYUdwQzhONjFMb2VvMWQ5eFVs?=
 =?utf-8?B?M3RpMS9ES2MzYk14OFZrOHJvMEVqc3pjZ254S08wL2E1cmdrR0YyWjI4MFJ4?=
 =?utf-8?B?UUdWdFJnNWdJQ0pXRCs0dU1PbEQyWnlvcFFsT0hTN2N2NDZaVnVTOUpZRlI3?=
 =?utf-8?B?T1doOEFRNUdjbnJKRndENGN0aTB1bXJ2aTJEWW8xMVlTSE1KWjRYMFZtbi8y?=
 =?utf-8?B?bnJFN1hSc0doZUdsY3pPNFlNTFVqbWh1Z0FGVng1MU1nbjd5MFQ2Q0IwYTY1?=
 =?utf-8?B?RHIvM0hpejFTNDhEOWZET3BsRzAxaTd0bFlpbFZ3bWRKTFh1MFpHb0FRYXl2?=
 =?utf-8?B?WDlmTTlBUUxMNVJTWEhFUWNmSUJLWDZtWVgyQ3FtQjQxejA1K1FxNmhmTkxO?=
 =?utf-8?B?S2dIWFNqbWxvelJFWGdobENQTkJuNnRLNWRGclR0alQ5VTY2cHhDM29lU0Jt?=
 =?utf-8?B?NVpvL1UyTnV3VFg2aUpuUnN3WnJEU043emZIYmZobjdPRWhzcHB3RkE5RFR4?=
 =?utf-8?B?d1lHMGtiZ3ZleDNnZUsza2JHYm1ZK0lPMUR0czQzWlYvbXVDcWVQR281MURo?=
 =?utf-8?B?QnhzT3JjYjdLQkJxVGlBSUZESjdDODcxci9oZTZXNWhKNVJrTnE5bjRkS1VX?=
 =?utf-8?B?alNJS29jckVMS3hCWGVoYzAyUFE3WkRpc1V0VkZ3WkhiQmU2R2M4U01qM2JV?=
 =?utf-8?B?cG9RRFdZaXM5eDduMHUxMmJ0azBqVnFjdTYzS1ZLWjhUZUxSc1hjRU9PUmFX?=
 =?utf-8?B?aFlNZytHY1JhLyt4SW1IYUZSb085YitJVlp3WERMSllsbE82Q1RoRHJObGJk?=
 =?utf-8?B?eFBIYlMwMTZxVGZGODcvUDl1QnNFM3hOVVZ6Vm5wQjlzcWltVGVmREZtSWNu?=
 =?utf-8?B?OVhsN01nNnA1K2tobTBYdU44dTlKdzYvalpmcGREZ0o0dlFRSWszeGQwTmJ0?=
 =?utf-8?B?RzdlenM3dGJ5SWU5VitTb3FYYVdONkZPL3ZMK2IxbUYxdlVGSzVXbVdCc0tD?=
 =?utf-8?B?YjJEVVZibkdBenRxbDZvOWE3SjZZc3c4Zk52NGhYL2J0RVh5clZLK3lETjJ2?=
 =?utf-8?B?Y2NBLzZyN0p2STdmaTFIQTF1bjNMR1REcGFQeG9YdW5abmJ3V1ZpU0ZGLzBC?=
 =?utf-8?B?WUpaRFJwMUgvcmtpVGUrejlQc29QQ3NVY0RlME5SeGZYbEdOTVdyWHhwVHEr?=
 =?utf-8?B?NEhkZnR0clRiWldlYi9nbUxiZUd0YjAvVXh2aFJFc005RXdvcUhULzdZQk8w?=
 =?utf-8?B?WlNXdU10YVc1MTlMWkVtWDJBelZ4VTk5TXRzY2JrdDlXL2YrTHJ5SS9BcUF5?=
 =?utf-8?Q?+YV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C421AA9293E3747BF447C17923643B7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fe6618-25d3-4415-2a49-08de012f6104
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 21:13:33.5549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFSw5LgoB7uMqZse13VgQrZ2PKo8EY5am7i0lQAKpOqIVB8xI09kYeJ+flC2PXI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

T24gMS4xMC4yMDI1IDE3LjQ4LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDAxLCAyMDI1IGF0IDA4OjA5OjM3QU0gKzAwMDAsIFpoaSBXYW5nIHdyb3RlOg0KPj4+PiBCdXQg
aWYgdGhlIGd1ZXN0IHNlZXMgdGhlIHBhc3NlZC10aHJvdWdoIFZGIGFzIGEgUEYsIHdvbid0IGl0
IHRyeSB0bw0KPj4+PiBkbyB0aGluZ3MgaXQgaXMgbm90IHN1cHBvc2VkIHRvIGRvIGxpa2UgbG9h
ZGluZyB0aGUgR1NQIGZpcm13YXJlICh3aGljaA0KPj4+PiBpcyBtYW5hZ2VkIGJ5IHRoZSBob3N0
KT8NCj4+Pg0KPj4NCj4+IFRoZSBndWVzdCBkcml2ZXIgd2lsbCByZWFkIFBNQ19CT09UXzEgYW5k
IGNoZWNrIFBNQ19CT09UXzFfVkdQVV9WRiBmbGFnDQo+PiB0byB0ZWxsIGlmIGl0IGlzIHJ1bm5p
bmcgb24gYSBWRiBvciBhIFBGLg0KPiANCj4gWWVzIGV4YWN0bHksIGFuZCB0aGVuIG5vdmFjb3Jl
IHNob3VsZCBtb2RpZnkgaXRzIGJlaGF2aW9yIGFuZCBvcGVyYXRlDQo+IHRoZSBkZXZpY2UgaW4g
dGhlIGRpZmZlcmVudCBtb2RlLg0KPiANCj4gSXQgZG9lc24ndCBtYXR0ZXIgaWYgYSBWTSBpcyBp
bnZvbHZlZCBvciBub3QsIGEgVkYgZHJpdmVyIHJ1bm5pbmcgc2lkZQ0KPiBieSBzaWRlIHdpdCB0
aGUgUEYgZHJpdmVyIHNob3VsZCBzdGlsbCB3b3JrLg0KPiANCj4gVGhlcmUgYXJlIHVzZSBjYXNl
cyB3aGVyZSBwZW9wbGUgZG8gdGhpcywgZWcgdGhleSBjYW4gc3RpY2sgdGhlIFZGDQo+IGludG8g
YSBsaW51eCBjb250YWluZXIgYW5kIHVzZSB0aGUgU1JJT1YgbWVjaGFuaXNtIGFzIGEgUU9TIGNv
bnRyb2wuDQo+ICdUaGlzIGNvbnRhaW5lciBvbmx5IGdldHMgMS80IG9mIGEgR1BVJw0KPiANCg0K
UmlnaHQsIEkgYWxzbyBtZW50aW9uZWQgdGhlIHNhbWUgdXNlIGNhc2VzIG9mIE5JQy9HUFUgaW4g
YW5vdGhlciByZXBseQ0KdG8gRGFuaWxvLiBCdXQgd2hhdCBJIGdldCBpcyBOVklESUEgZG9lc24n
dCB1c2UgYmFyZSBtZXRhbCBWRiB0byBzdXBwb3J0DQpsaW51eCBjb250YWluZXIsIGl0IHNlZW1z
IHRoZXJlIGhhdmUgYmVlbiBvdGhlciBzb2x1dGlvbnMuIElNSE8sIGl0IGlzDQpub3QgbWFuZGF0
b3J5IHRoYXQgd2UgaGF2ZSB0byBzdXBwb3J0IFZGIGRyaXZlciBvbiBiYXJlIG1ldGFsIHNvIGZh
cg0KeWV0Lg0KDQpaLg0KDQo+IEphc29uDQoNCg==

