Return-Path: <linux-pci+bounces-37320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20219BAEF76
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 03:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69241C84CC
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6A72459C9;
	Wed,  1 Oct 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzRw0zJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBEE15A848;
	Wed,  1 Oct 2025 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759283116; cv=fail; b=mO9b7HRWmezuGAVcKcJjoA3m5cfW/HnbvddQolIUHElQToLbdMRtcj6WesBvJRKsm8FZuqtKr+UqTuRSO07HB0T1V7f4Pi8fBujb1WMP/foItTIYrZka+6E5qYIVHCfkDtyDklOmO1VTlGs0bMwkB7AJUvFC6+ZeJW6nx44jo3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759283116; c=relaxed/simple;
	bh=PU/2ymFlON5MfkpxLciGR93dq6ecdgyYNylvpvXuuL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+6rYF4ie34G4jMRNpwtJR6O2PGBtwyoSJiTtv4xlb88nf/Qcqf38GUSi35QBIyGX42uQ9MB5AcdiF6EjOPUjONC9WAEmahiNEXGDUldKn86scOcDMDm/2+PV3p8UcI9FRV1KKd6ykbB5ZQ5jfQFgZOBwc7WwiZ7dVFO3mn6fqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzRw0zJ9; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy537h4oadTyDn42sIxBOjktHnr5Mo61byoDyFon6StLmofDZIQh/hjT1JyuopbHLzFK3ifaehSNxExBmSMM6TmJfXtLQ22pdICbGqpv0BUDWnOcQ0MN0vnd3pmpM+170KEel6moepj1VQYdIQ8w2AAHM22Ud8uCZEqUe0I7+7qMv59Pf7rPUAVyJuqIF+LILLnkUuWwdT3x+7JDdW6GXFvHaJYjfTrWWKL+9sx8LvZyun+QKdQQIPDWZ2jpzp3y/o52SY2t/KUeBtHhtg9sk3DCdcCpMl5aJxk32hzChPzjqlukxe1yXHctqUyGKTG3doqLSGGF3kxd5utb910zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNkftdtVmrtu8v8Z9M7eZqra+5N5FFEf7FbzCdPprp8=;
 b=Bn4rcwt6r3MLJVzLPXtOO8kpz/hICNmuVDrU919jvIORiEf4/gidA7aNFpNWm7Al2ttaIijBEgVEmp9WSVlJkLajSAxLvGW4SCAPQHzbLaHEoAmBbgniglDa7tblNVRYrEV7lXh7xPFOmzf1gJPXgDcD+pygf4yNYbdW6vBmWXiY085Sh08wSl38yerko2FLLYIvPWVmo9yJQVOqfO36wxb8Se5ZqHLqN8zkn062Qqzt/63bNu2yab/nMPndbeusBIb3jD6gWixsEfnodg/70j4+doMx2slVaQ6f+YFJjSWwf/iA4nD0c8sxH5Xk8j/Dt5UOdSvuanBYF42pveg14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNkftdtVmrtu8v8Z9M7eZqra+5N5FFEf7FbzCdPprp8=;
 b=mzRw0zJ9H+B9aG8yDJAmB1Zpfxux9qa2l20GihiHshkkgX3mwNDZRAZIjbgqd5tr43YytOxXjBFnlZ8kAHauoTo9xNOvTfxOjuuLra6+I0LRUkEdzjFTkfQBhfVd2wF6ESJ4d8UsTes7zf9Z0ItEZuTT1QJZdL3tUxiZHZAh1tp70UFz9nOdSMWs9hdd9ZYSIM8g/uD6STpAH14hdDePb+r6B9nlOotPTXRqGHzvKXe8PlvrSUW1dH726d2C5YJ2e2pFwUiRLiaUYPdXTsDLXnhCMExVOpn74INRb24ynE0ZMrudlxg64IhptxKYovLm6Z+J/OI7XRpqbDjvgsrbpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 01:45:11 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 01:45:10 +0000
Message-ID: <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
Date: Tue, 30 Sep 2025 18:45:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d36178f-3590-4b41-d129-08de008c286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZ2eGpCekw2ODlodkNiNFRnR1BIeGkzMmQ3OTFOd2xoSHNUbXVUNmFpaUNL?=
 =?utf-8?B?cnQ0b2IzRi9ha0FEc2k5RjF5V1BPNE1NaUtaZEREcC91T05uWTd3MEg5TTNm?=
 =?utf-8?B?TU5aUHlRSHFBcDRmRkZuMzdwdUJ5TitrSDZqYURmV2plcUFPcnBmTDh2dDJm?=
 =?utf-8?B?VkQ0WHhOWXlQQlMyN05NS2U4OFhYUFp4L1pmdnRoZ1VNOVBwRW1VM2d4QnQy?=
 =?utf-8?B?WlVnNnRIYmJ5RjRNMklzUUMyaHoxbDl0aXE5SlZ5UXZpSmMwMUZDekdCQ0NU?=
 =?utf-8?B?ZDZkS2tQZC9WcndUT2dYd0IxYStCUFJGOVM4Sk56a0FxbVlpdXBuTTRIeXVw?=
 =?utf-8?B?K0JNV1cxQkpmS1hCU1NGTEh0YjQ5OWEyb095YTBXUGFhRDUrU01mNEJObzRX?=
 =?utf-8?B?Vy9ncy9hMER6M1h0eUkxR3Q2WHZ0K2wrNU0yL2lOUVNDbGhXbFkyVWtTZC9D?=
 =?utf-8?B?TkxIWnF1S25NeTBWYmlyT1pnVEUwWmJvSytqSitDUW9Cb21XWUVOaXlGNFQy?=
 =?utf-8?B?Rmt5RGZpdmFUcHlvdDlzWUFmNEg3VlpZd3krZXhvcG1XQk91ZGJzbXEya1U5?=
 =?utf-8?B?YTJxSFZMd2FERnFFRE5tM2RmZ1hEZ2VmVm55Vlk5V1pOdVlFclV2UkF5TnFw?=
 =?utf-8?B?ODFmNjJTYTBDNi83R2ZnQnhOWkk1VEQ3RmFBOStuUDQ5UDNuU1V0SVpjYVM0?=
 =?utf-8?B?UGlFWkttUVo5T0xLbmZ4Zm9uUkJHSWtEM2NBKzJ3Y3N3SmNJUWYxZXViSDZU?=
 =?utf-8?B?dWM1RjFSa1JaOTFLcHl5MzNzL2tPZ3dheEFmOGhiMThod0RNWG5XWG53ME94?=
 =?utf-8?B?UEVsaWR2RDNycWxYWEozRk8vbys0ME5RSGVuS3FId1lHNEFuUUtlS0t3bVUx?=
 =?utf-8?B?T1Zlb3h5US9tRXliWmdBM294eGNUa3A4ckpaTmE0L1cyVWgxczlsbTNIa3VM?=
 =?utf-8?B?UkV2ZzdYa0hmbkZ0K2hzQnI0V2FveXZGNEFtM3BNdXQ4dHc4MC94d1NYVzJa?=
 =?utf-8?B?eWQ0UDR3amdUdTQzbGFRd1V5d3dOaGhmdFd2QldnUTVDcUxzZ3d0NjYvSnpG?=
 =?utf-8?B?VmhOK3JIZ2NmMkI5b2hiK3ZOTmdUM2lnamNNVU9OSGZiMkdZSlhkcHBPbzNM?=
 =?utf-8?B?c3JiMDh5R0xGQ2F6VjhkOUZLdFBXN09OVkVXTXh3VWtzeEFkUXhMbWFJeXVn?=
 =?utf-8?B?Q3FVajgzbDBERXAxNldydEIvb0MxYVVJQXhJaDQ2L0o1MTBJTHkyZDJiYXBl?=
 =?utf-8?B?K25XcSt2M0pWVHBnQXJxNUlLdHhIQmhHSmhjOHNGeWhKVGxjMDhvY2NQN1JF?=
 =?utf-8?B?MXI4UFZNbmdXUzNkaWtVNDc1TGdoRm15WlNBaWo0YlZTbHh3NHNyUGlBdU9a?=
 =?utf-8?B?QytXY3ZxeUtsVURUSkkxL29oZlY1Zlh0SEJRYzA4dXJwVmd4bC8ySWZjL3A4?=
 =?utf-8?B?WmdRaUVRRXZjdkFSaHhFd3duanR3OFR2R3NsTkRDbzhJTEk5MmVnR0NaY2JW?=
 =?utf-8?B?TzVjNHlyQkdIWFVmc09PSE1BZzg1akRkRENHR2c0YnVvdFdlL1B1ak1XMUhx?=
 =?utf-8?B?MldpV1Q2TnhEZ1V5WFZwc2duK1VCRHkyRmtGVmlIZXFzNmxteHJyRkp2R1NG?=
 =?utf-8?B?VXFlQS9JQmk2bFhNa2tSZXFDUmlNNzdZeGZRVS9TalpHbng4STFpaUREVWxG?=
 =?utf-8?B?bm02L3Ywd04zbWY1Vk04RHpSekVwczhLYXdEaDJqTGxOSFliSHRLUnZFZzhl?=
 =?utf-8?B?WDFVSHhtQUxtcDJkem9Hek5DSkxVdXJlczVlSTVickp3dlVNLzQ4bndRdmJj?=
 =?utf-8?B?Wnh5dDdabk5IMHV0SCtBM2dMWUtmVXc3VHZKZFFYeWw1SjllbFFxZFR0UGxq?=
 =?utf-8?B?Z1JLcGcrQXhvKzJDUjJFUHNtMG9sZVIwUjB4cDlwSnc0T3JZQXE0bGJSSWI3?=
 =?utf-8?Q?XTJyvD0/w6U8wB+0lK1TuNbWWZ/GPUYE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVSemhaVGlNZTRSUmhZNVhaV3M0SnYydUV1Ry92cmJTRjFORG9mdURhT2lT?=
 =?utf-8?B?TVllNUlOcjZkamdhZEp5SGl4Sk81cTJ4WTFpUGR6L21xNzhVSmQzMWMxQTJo?=
 =?utf-8?B?aldOdmpLSnlxTmhULzF4bnhzK1RrTnZ5eUlJNG53U2p1eEFkeU5FdmVrUkVn?=
 =?utf-8?B?NVNLeEFxRXIvbEdHQWJOaSs3ZWw4WEFUVjNSUW9DT281bytpa3lBcjFvd0hn?=
 =?utf-8?B?YXBRRDVxYjVSMDJoS24xMTczWWlVV0hBTW9yTzFhb0hxNmFZWXE3azREbkF6?=
 =?utf-8?B?Wm9Ia2V1VXQzeFJnTDg4d1cvMmY0ZTVDeE1maW9Nd3BlU0xCcWJRSFZLa1lQ?=
 =?utf-8?B?OExid2lFbmZFZVNZL3ZGSzBIckFiWURTVjhHOUZYZ1FnTHIyVk02Vlk4NTZK?=
 =?utf-8?B?ZW9QcWVqZG9mc1Vrb3FJU1VZT3YyS1YvZ0xCVTB4RFJvMW9ZZk5NZUhMYzdV?=
 =?utf-8?B?cW1BOEJ2aTY0akszODQ1d2ZBM3k1SE5CcGt6ZXAvRVRCSGg1Q1RsUXZCeEFi?=
 =?utf-8?B?NUkzd0gwOGFRSUN2bVVtRU13OG5ndG5CdTR3djRLait5NFpsQ1VLTkJpTEI0?=
 =?utf-8?B?TmJDRjVUM2xWMlNRUmY3THlUWXBwUUtqYkZrTVpTS3BTREdkRU9KWUFDU1FH?=
 =?utf-8?B?RnkxZjN4djN1c2xNUVo1YVNHcWRlSi9haHR2Q1laTDRJVDRqUTZKV002S1ht?=
 =?utf-8?B?N2ttQmVPdkk5YllZNHJ1OFFCem5TdmRSdXNNL0thTXJxOEtiRm5JQmhzZFA3?=
 =?utf-8?B?cEUrODdGR0VqdEJJZWNtcHBjdWFjdmFXZ0VjUUpTNUFERGE2alRxQ3duR3lk?=
 =?utf-8?B?Z05yV0xJWGdkUmZhSU44WEhiZkN3VFZSUmRlQUEyOE5xb0NPNTJhQVJFNXda?=
 =?utf-8?B?eENUWmFyVHpJNW5OL3JCV2FVZW9ONlU3YlZHZlRtekx4ajFPWGJKKy9tdkpT?=
 =?utf-8?B?dGw3VWVSS2Uycm9DNVYrWVRJTm83OWxVb3FaYkIzbGc5ZTQxMGJ5Ui9xd2hN?=
 =?utf-8?B?azdpNkVmeW5LYW9QNXh6M2pEWGp4azd4WENYQWFHaWFUMlFKWnhFYUk2dnRV?=
 =?utf-8?B?ay9uZ0QxZTJDMVN3cm1waWJUSFhBWFVDSTRMUFJ0VEdJSXd0V1J6YTBIeFgz?=
 =?utf-8?B?cmwrdnJyWUFYS2hYdENncURjVGVVOElabmxycHB2Z0NXTEgvNDk0OE1wbTZE?=
 =?utf-8?B?Tlo1RTU3dXlVU0JreEZhM1YzVm5uRHBGbUp3ZCtaRkJFbXRzbE9FYnN2eDlo?=
 =?utf-8?B?M3NhWHltWWJvSVNGbllOTytKZEdRN0ZnV3NXalVSQnJ0THZubFU5M1A3eEUy?=
 =?utf-8?B?V1B5cEc5dEJOVi9iYlJkM2lCMS9IRDh1SzRDdHJ2YU9rUitGazI5OTQ4dG85?=
 =?utf-8?B?LzBKVituejdUU1hiWUw5dXZaaWhLMDdJdmg0dmo2K004RXZhZVlsS2NvRnNu?=
 =?utf-8?B?NDdIK0tyZUE0R1R4M1VGV2JGU25FczVSM2VBNkoxdXVWam5MSzhwT1QxNnJs?=
 =?utf-8?B?Vm5vWnRaeGZtNHZkZXZSMVc5aDV5NmRyK1dpK0tSVG9XeFkvQTFDc0YwUEIw?=
 =?utf-8?B?ajUyc0RnZlFwWlJKc0lsRkU5QzBUV0FYZ0ZsWjRJeGkxNFZURVdsdzNRTTFz?=
 =?utf-8?B?TXdMZ2RWTTJySytEZWhGMFg2ZnpPbWpYa3RnTFM4ZCt0d3FxbndicHk2alFr?=
 =?utf-8?B?M2JGRENNcSszZDNPczB6b2VKU2VkYWJjay9qSHluZTF5M29iOWtkNDhzNWhN?=
 =?utf-8?B?UzRhWmJuS25TZkdZcTRaekp5OHRZdEkxL0xkbUtqTUJ0N1EwcXZhbTV2M1B5?=
 =?utf-8?B?OG16VGJTVVIyd1dmWnQ4RDdHdXJ1M0svY1oyc0RLekRpai8xK1l5dWlNbzQ3?=
 =?utf-8?B?QkpaSWthZFRzVTVHQUZNUWdMeVM1b29uTXhPMDU4RzN6WHhTWWNZS0Z2YlQv?=
 =?utf-8?B?czhBRmpjVWlDbjNxS3RZYUxLNnF6QnB3NzFWdy90eDZ2NnlHNkY4alpmQUdH?=
 =?utf-8?B?NXA3bjFha2NWdy9zanhOZjNVY0wvOU4zY0VBKzg4RmtrQjFYZU5qalljYnB1?=
 =?utf-8?B?Wm5sM1ZVSS90RjUzMVcyR0FvcFlKMnBQd2ZDSkRmRXNOb1hXMWhseTJBV0ND?=
 =?utf-8?Q?6lhR9b+dTZuefW3WxwzuohGs+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d36178f-3590-4b41-d129-08de008c286a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:45:10.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyUtphciQxKPvcNOAy+qJ6vUHR0KSnOqGS6uEp4Dqw49fm/ibe/BD1I7fpMJr9w2cY/DexlSILGbjbP6ZDOguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

On 9/30/25 6:39 PM, Alexandre Courbot wrote:
> On Wed Oct 1, 2025 at 10:26 AM JST, John Hubbard wrote:
>> On 9/30/25 5:26 PM, Alexandre Courbot wrote:
>>> On Wed Oct 1, 2025 at 7:07 AM JST, John Hubbard wrote:
>>>> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
>>>> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
>>>> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
>>>> let NovaCore bind to the VFs, and then have NovaCore call into the upper
>>>> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
>>>> longer in favor.) So, in order to support that:
>>>>
>>>> Nova-core must only bind to Physical Functions (PFs) and regular PCI
>>>> devices, not to Virtual Functions (VFs) created through SR-IOV.
>>>
>>> Naive question: will guests also see the passed-through VF as a VF? If
>>> so, wouldn't this change also prevents guests from using Nova?
>>
>> I'm also new to this area. I would expect that guests *must* see
>> these as PFs, otherwise...nothing makes any sense.
> 
> But if the guest sees the passed-through VF as a PF, won't it try to
> do things it is not supposed to do like loading the GSP firmware (which
> is managed by the host)?

Yes. A non-paravirtualized guest will attempt to behave just like a
bare metal driver would behave. It's the job of the various layers
of virtualization to intercept and modify such things appropriately.

Looking ahead: if the VFIO experts come back and tell us that guests
see these as VFs, then there is still a way forward, because we
talked about loading nova-core with a "vfio_mode" kernel module
parameter. So then it becomes "if vfio_mode, then skip VFs".


thanks,
-- 
John Hubbard


