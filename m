Return-Path: <linux-pci+bounces-37318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35627BAEF3D
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 03:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8C23A3906
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 01:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92E1EEA5F;
	Wed,  1 Oct 2025 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWEHAiYG"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974A6BFCE;
	Wed,  1 Oct 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759282025; cv=fail; b=BK/fqT1jJ2NDrDnWzCE9fRU0+IaYdqTHfOBNvUrT1uPAwoClFnGbZUbMg9PcQL6eWu8hDypZq1Gbfcsnxpj5XpWn9yM1z8Emmy8B5z+M1V++aREWCglY693blsADhkwG68qbNr6nQyzhTtCRS0xQBMojYbqVAyXUEUkDrytVuLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759282025; c=relaxed/simple;
	bh=AzC0J172NI7x+beyJfhrfg3H9ixwppZKHFv+P4j/cR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2G5UpII9hEep5JSvf4+XBQL1HdAmQuHtRo/wuaGGHPAKlF90QJUBnY1Akpv1SBxtfkzw25dtImSo1aEJ+02bzKtexPFyF3D90kqNxDnR1g0RtX0HvR+GJZX2pbdIwSJHTwLrEXBDWYwnZdf0S9SAHkdN3xi8AYJrifUpyVi4/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VWEHAiYG; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6yEjks6T+lXRHCVmq2aj11bkX1dOepdMtV1IvotpRiW+w1K8V/9uEnhx5wG6GUSqrCa/IhWpMO9Swt5CM7McmuNIG9MC8s70+SstWCL76tHVflEy2NYh7rxcsUlyY0C3Di95V8iuiDVfyNoNN9S/pw5XF6mkyWbJYHVZfP8iurMi5xA9b/1wuQJgqmWDJthT2zk/7CPQ/cZI1nrGFFvf+dWJBbTPmVyeFPHJJb42tUWRBSxwv9U4nkh9buKkGdK4wYjqZULlBDZiWID1DWbFdU+xXNrdUQGmuGYowxmc9VHux8+n2PPtChGxSi6s76HUCTVB3Ruyz73pv8n96cHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMZW4A9FdAOcztm9oVDNOFcMXN2l8ppgWEBO1oOMAOk=;
 b=qlOeAvtE1ENZ9Fx0E7akGr+darf52Cyr08B408vccZ/Yq0y4H9kj3MDJRDdQjrsuf0Couw7iVq5hqOUUwSsXK4/tRj9JgpbOyyr3mufT1Vv50ddweFAdO/QlG8Li1yGiSHLQ/eZPR7U9cMm08Z+VqA2qr00iLgjN6s+jQRk7dN8GQnMWnEXDN27rPFZTTnO8UF1KimKZaZe4ATqMMt1jnkda+t8AfhsVjILb3p1nv04njOoIvVULFKrMCX1coFprwPkDIlIv/QSBw1jWih8PoRViJjtLvNOjgt9JUjOdGpR3ui5IjTRXdPyU2M4sOW6RqURfO55k7+Ubdtb3XNmh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMZW4A9FdAOcztm9oVDNOFcMXN2l8ppgWEBO1oOMAOk=;
 b=VWEHAiYG3aPwFza8o69QPVZk8rqOao68r3yzxIrHOPtEP7UNQQAsojMq0fZzt7ca9lOnmPK3SXOhhMgjMdt0wmK5Hiln/BXxYxrFtOukoLN1LtczNtvT/1pQvszEuM6w/I7MwcHKNShnP5D+3rqCpXLkPQ92gHF/azXyUtMII7G179uPkm1W4Up5128Cnnq5uar/JshO6Mw9I15TYL+ni/qlHZzPQMrQCo9Av7NOsOJh+UhHDivhKwZtApylA4/nfpoZPUhe8f8f31rKKalnIrPCdqRIDJj7PieH+INdAZIf3P9l88jIugR1PqIRJt6voS3lgomHBzjUpw1b6CaXzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Wed, 1 Oct
 2025 01:27:00 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 01:27:00 +0000
Message-ID: <6cbc2df0-00e6-4d56-adbb-6695575d1563@nvidia.com>
Date: Tue, 30 Sep 2025 18:26:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gpu: nova-core: reject binding to SR-IOV Virtual
 Functions
To: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <20250930220759.288528-3-jhubbard@nvidia.com>
 <d2yft352u4p5goqqekbpngqyv4k5bopaof5xm75zg3npbobny2@73ojw73msjl4>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d2yft352u4p5goqqekbpngqyv4k5bopaof5xm75zg3npbobny2@73ojw73msjl4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::38) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: e41293eb-8528-476c-6e9a-08de00899e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tzk0NWprRy9HM216OU9ZM0s5MnZvVDB4L3VDS0J6d2R0RUdtWkdNTWtKMENG?=
 =?utf-8?B?WUJtRXlrcmwyTFVaOGJTRVJxTmwrWnAxWmMrY0thRDZCNjZNT1crVy85TWtq?=
 =?utf-8?B?NENTeEpOeGZjaWlKZXZOMG4xY3RjLzBKb0l1WGhmbmN6bzJvZXNmYzBqNXVO?=
 =?utf-8?B?OFFiQ2ViTlg4RSttblIxQWcwVnNBMlkvSkJxTlZEaitEcHR2Tk15NmdIMUR1?=
 =?utf-8?B?aUR2M1FUa1NSTWgrWkdNbkNYS0U3Z3B3MkNjcStOTDVRd294ZEtaaEFHTERu?=
 =?utf-8?B?NWdWd1VoWk9mL3hZNXc1VmIvK3BOUjgxOHltVG5SV2dFbm42OEJiQ0s1b3NE?=
 =?utf-8?B?NjFsSnJONkU2MXhFaEYzNkJ1NFQ5TUdxMmVKSjlIcjV6blptS3pxbHZneHdo?=
 =?utf-8?B?OW9sLzZiSDczSjZzMXlxZmZycm9NR3VCaTZZTkV0czlPR0tLSmhVMUF0VWhF?=
 =?utf-8?B?LytlVzhadXk4bVRrWDVaeFBDcFplT0pQYmdZZ3A1V2NIUmk1Unk3UWJRS05m?=
 =?utf-8?B?MkFJU3hkSEZkZ25hbkYrVnlVTXZvTGZyVXkwM3A3cERIOWlMVGNURVlJQkhk?=
 =?utf-8?B?cnJlSm13OEVYMVB0VUx4T1R1YzQ2OGxQNHE3NnVhSmMxMkszWkJBVUt1K0JG?=
 =?utf-8?B?VjRMaEF0K3BoU3o2amFYYkxwMFBPdUg2azZvcHZTejhla2dHbStqYXdwcFdm?=
 =?utf-8?B?ZllseGdEaFVJYTdUakh2cW9pM1dFQmM2SG83eUU5c21hVThWUlB1Wk1Fbk1D?=
 =?utf-8?B?RXRJa3dYeEFQVTM5c2VqWVpWc1NtWnc1S2RaMG9LUFRpQS9oVXpMeXFSVk9n?=
 =?utf-8?B?SjdLT3haenJEcXp6bSs0aWpJcVlucHlkWDFRRTdtRU5YcW9mZDJIR3IzZ0pG?=
 =?utf-8?B?Ti9IRlh3eHdPSHdxaTYvYVFvWVVFNkc0QWRGUjRPYlJ5ZFBKL05UMVBZVXI0?=
 =?utf-8?B?SklFOTU2elREY3EwM3V3bWJjM1lvMVRoRTBPRTM0dzc1NHl1T085dTQySEhu?=
 =?utf-8?B?enNOcDhpQnJyak1veHNDTDFSVjBkRDcxY1FldERyNXBsVE1RU1lpTFkveSty?=
 =?utf-8?B?dUxtdXhOcm1yRzliT0J1MCtsTzBHWnE1TjVwRGtTdmU1L1VXR1cvY2dIejhv?=
 =?utf-8?B?MnlOZ0FkbHdqRkIrSGJNbE9YR0pYNGVtY05oMU5YWGtZbE1ENVhRcWQzaldI?=
 =?utf-8?B?aDhaTVdCRGQxcWNWZHZSUmV2ckhMNzA3bUNyUTQyMHpCWXFHQkUraVg0bWE3?=
 =?utf-8?B?bCtlOUtQWEt6NlM5RWZ5VWZnWDNVaUNtc2c5bHRacm1aZUJwMmsreGltbFBD?=
 =?utf-8?B?aW9mVlpSQWQ4UVRkWElLNVF3WUkvS0FMcjgxVDZkZXk2aWxMTHVoQy9LcDg3?=
 =?utf-8?B?VWh1TGlqci81aHNndVkxN1FvMkNUTEdQemVWUkhHeUtwWUgzRGJEQjJBaGk4?=
 =?utf-8?B?SWsrVGhTOE1ObGt4bG5SK1IvakNuNDBNSzh6b2ZaS3BIWHlkL09iVTVZQU9G?=
 =?utf-8?B?NDNNdFgwL2lvNVMxVWFwd0oyZkVTWThzem1ZVG1LTnpLOGxXNnZuR3ZxT3Q4?=
 =?utf-8?B?TUVWQjhKbUJXVmFMeStFSmlsMWsrYi93YmZLZUFlYjRmV3RHK0ZIMFNEdWtj?=
 =?utf-8?B?ZHF3QXppWklYSzlsMDFwampoOWtTeG93UGlVQTVtSW1zZmE0dHJkRGh3Rm80?=
 =?utf-8?B?ai9HMWpDOE5oNnZLV28wOW03aUhzemtEM1Yxaml6OTFjVzZtWS80OG1tY0NJ?=
 =?utf-8?B?QTZHWjFlcXVMYmVla0RtUlRPNmVvZ2JhNUQ4Z0V6RkFIc2RZTWFCN2tVdDh5?=
 =?utf-8?B?SVV0ckxUeVZ2ZURvQ2wxTUQzWWIycmg4OXRoVzZKWnI3QTc3L3lOWnhlZWR4?=
 =?utf-8?B?ajhyTWlTL2t5bEZLY01Da3kwNFNWUWF5K0JlaEU0VFYrUnA2M3MzMkxnbUVX?=
 =?utf-8?Q?6JFGG2YtV7btHCjQd6/wCaIszySw2+xD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVJSlpFM0UzWlFqbmVhYUM2cjVlZFFPNlZ6WWNhSmJiejlpKzA0cytaNFVJ?=
 =?utf-8?B?NDl3NmgxeWtqVWtNQ3FhTVpsSFRsb2RKZHRpc2xma01jbjhGc3AwbjNGcG1P?=
 =?utf-8?B?MUc5T0U1L09NaHJveFlmYTBESjlNMm1JR1ArTDVySEdtS2VDYWdLcHd1Ly9x?=
 =?utf-8?B?Vm95Y0VnYU5Xc2lVODdIN1RuSkJlQnRCSWgrZ0w1bjU1REVpem80YkU5ZTY5?=
 =?utf-8?B?czUzaGEyS3g3a3lzUkVoYW1WMjlNT1RTNmR3empZR1llaVdIT042cnllTWJa?=
 =?utf-8?B?VXZHckUzWi92aDZpbnNOdFRWWlFKMlkweVJPUmVLOE9nYnU5b1BrVGgra3hO?=
 =?utf-8?B?V0RlcWFYOVJTRWJPb0dxNW5aK3l5VVhLNEQrbzV5N2V3aW1manQ1dmJqYXQ2?=
 =?utf-8?B?b29PTW1wbEgzRnJSSjJ4em9BWTFJeFhiL2NEWUNMTy9PVHcwV3J2WldEZ0hF?=
 =?utf-8?B?QndiRUlTSDFxWVAxa0ZXTVJ1WjIyS0R1MmZRN1g4M3RNU1FTYUdRZHNjaXBr?=
 =?utf-8?B?OTdpbkNFYjBtLy9VdkRjaExIRVZodlF0VjM0ZlFxcmlKVThMVkJvUWpLdlVY?=
 =?utf-8?B?YmJDMnlGajNVNmNDc1RVYmtOUVd0ZEZRbGhwMjR2cmFuTHRUV0JCZmRRdHFI?=
 =?utf-8?B?K24wQkttVzN5ZmhFRlBPNnpwUXh0VXEzdFd3QXFybUVKZ0NIbGk5UTJVWm1Z?=
 =?utf-8?B?alZtZ1hNb01vbEdCWmpNb1dieTV2OVdyaTFoQjA2THY1djZ3dXFoZkVOTEgy?=
 =?utf-8?B?VVg4R2VObHJhV01zaFhySG5Ob0dOZEE1U2hEZDNYU2NQOTFJRXRkS3dRa1E3?=
 =?utf-8?B?NlFYNGVNVXlzZ2xINGhRUGQzS1pHOXBKcUZ6eVVSa2ZSTmhxVERKWjVWRGh1?=
 =?utf-8?B?Sml6eUhKQi9zc3kvUjBHV0pPTTZDWm1ZV2dIcVYwc3lvcGlVUDRNRTNRd0pz?=
 =?utf-8?B?d0VudVRDYTZDaWVQeUREcG1TL1hpWkJKRi9BWUs0czlJbU14UUp3L2J1S05i?=
 =?utf-8?B?NW5PUjNMZFJzbUVOeWVINjVrbzRXeS9VNkwwQkVYQmJueExMTm53Vi84aUYw?=
 =?utf-8?B?VS8vb0RORTVycWtQMzhPYTMybnZrTE1HN29PSk5MeXRCNUJvRjJXR0VlVU1D?=
 =?utf-8?B?bWpyUmtxOXBlZXFCUUs0ZEdRcjlMei9IZGJxSjRycE01aExkTC9ka3EyalNT?=
 =?utf-8?B?STZoZ0JIcmVRVWppWTVzdzNxeXJ5NnNWSVg2NnJITGtvb2JRMmg3WXN6bUdB?=
 =?utf-8?B?bmMrbitGdGptdHVZZy9aSWZyaDN5cDR3RG1zMHN6N3Rabk4zaThDODRTK25w?=
 =?utf-8?B?YktPS0VHZTJWTDMrcnF1UlBUZUZIZFJmbHVFQnZnODNZcUxPZ2w5eThpTVd3?=
 =?utf-8?B?WXRZNVJlTytMV3NwRFFicU5LbGhydEdDRHhTWjZGV2J1c2s4MlVxTTZsejg1?=
 =?utf-8?B?dy9ETzVQdnYwRXE1eUxNZGphaE5mbG1jYWVtUFlKME9odEd4Y3FuM2lVOGtP?=
 =?utf-8?B?NmpUdEppZXNhcEhFdVR4a2twcmdWYWRRRU9OY2o4TlpqdUc2eXk0ZytWZXJt?=
 =?utf-8?B?QXVnYkZwYk1yT3YraEcyZU91ajFwWGFEeGF6ZjcxamhHclZWME1vSVg3RDhl?=
 =?utf-8?B?K1FSNGlPS2puOW9YTjBsT2FmRUIwMnd0ZHdKZytPSXF5RGZOc1owdVNZb3lD?=
 =?utf-8?B?VmtHZ3BQVFRmeDQyNDlLdWZmN1BaZXdWeThEZ0M4RnBJaGRjaUdTVFBseDNP?=
 =?utf-8?B?ZDY0d3g2UnNMN2doSzRUTVc5dmJsV3ArejdIRFlyTWhMYVJmaEJpck1mNU9a?=
 =?utf-8?B?OWovTXRhdnFlR2JBUGIyZlZTdEdzNnBKaURieVhmSkp0Q0ZPcGk2ckJTaUgw?=
 =?utf-8?B?TzNjZHBZWTM3bWhmc3BpRHo5NjZ0bXlpYXNlK2o3N3NUZmhpb3dTdkRnZVcv?=
 =?utf-8?B?QWZiTVBpS0hKZGlaQjNYTFdmM2QyeVAzTVlhazAzc2ZPR2hSMjVKVTkrdGt4?=
 =?utf-8?B?R25nMmkwVHZHR3RBcEp6bTRRWjZGUDlTR0hFYU9vQmFMcDFVN05rYVR2NkpV?=
 =?utf-8?B?bWlFYlErWm0rSVFtRFBPUU9SRlJtUUtYSzJJRld3c21oZVB6MW1SdDNleXFz?=
 =?utf-8?Q?FEiEPIadHsljNVFLMPHvXZ/1R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41293eb-8528-476c-6e9a-08de00899e86
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:27:00.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sMYCvf2tQlK9Q/hZbhos7aRlDu4OkO3qNyGcOWyr7c0cndxH7P1Z55n9+AR5i9wFxyTaD9OZXHWQL/jKoyhSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15

On 9/30/25 5:33 PM, Alistair Popple wrote:
> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
>> Nova-core must only bind to Physical Functions (PFs) and regular PCI
>> devices, not to Virtual Functions (VFs) created through SR-IOV.
>>
>> Detect VFs using the newly added is_virtfn() method, and leave them
>> unclaimed. This allows a VFIO kernel module to claim the VFs instead.
> 
> See my comments on the cover letter, but does the kernel driver core continue
> trying to probe other drivers if this one failed? Or does it just give up? If it
> just gives up I'm not sure this really helps much, although I suppose if
> NovaCore can't use the VFs for anything useful anyway then it probably should
> fail.

It keeps going. :)

thanks,
John Hubbard

> 
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/driver.rs | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
>> index 5d23a91f51dd..004c15763694 100644
>> --- a/drivers/gpu/nova-core/driver.rs
>> +++ b/drivers/gpu/nova-core/driver.rs
>> @@ -54,6 +54,11 @@ impl pci::Driver for NovaCore {
>>      fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>>          dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
>>  
>> +        // NovaCore must only bind to Physical Functions (PFs), not Virtual Functions (VFs)
>> +        if pdev.is_virtfn() {
>> +            return Err(ENODEV);
>> +        }
>> +
>>          pdev.enable_device_mem()?;
>>          pdev.set_master();
>>  
>> -- 
>> 2.51.0
>>



