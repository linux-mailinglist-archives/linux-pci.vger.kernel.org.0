Return-Path: <linux-pci+bounces-37311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1286BAEDF8
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 02:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4736F19207C1
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 00:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1F199E89;
	Wed,  1 Oct 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCe+vrWH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126771991D2;
	Wed,  1 Oct 2025 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278436; cv=fail; b=oEXBEOOnnIYR57RlCdfSFTZxvbrGpTjj1gLCz7RL11TgxyrB2O0/pxPmFcJeBFoKShN35kKtlqp6lxUWwObMwxC7Eb8u5mpBpQyqFSsUKXyJiMNN0gwxGNof1zuhrsWRoV7u93wi+7FyIfxow4PpxnpIG2fVhMipUaGvHsjGLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278436; c=relaxed/simple;
	bh=Hco9JHuADUgQBsZV3nzXHvtbQlVzH+gq76fvGkYTQ1I=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FNnhYBcFZor3dgSzoqpWaMAzdjsuFbRLTHtr1ewbvkZp1BRHC18CTwAK77tYF+NZQLvynqCB68Nn8fW8Fv0uOkEmAmfXEIVfaZnPAnKfK0l3/ZOq6RB3412e9XWqIQFqlUxmLCmVD690vQHcK9ovsICJzOvICdWiDTxMetTsR/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCe+vrWH; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp2nSeaHYj7K0DUtWzfNl/9oWahx/Yx8RnXiHgJVpbHWYmXPs5zAev5582xpLPVCCIiTtluFkkOmxMpooKkMmc0Q2fSkRWRRe7QSxWK7C6aZk9SUs17UEW7oh4/Q8/5QrE8F8k5UVX95W3XpDx09SrJFY2P5uvGTjbR9TweY2Ww+be0WdaKUM9j0Xr59Sby9CHYSj2BMX18zUFtwu3nm2eX4/3tPr1WbIB5YFkeZkjCW1mdcGxGXYDYDanLfs8rwNQjjpFI9YENtq/+8ItjTEtqxjHTq/t2YxjHHH8Lgy4YqHQe0039XIcPXbcbSSLwzmVT33wzRcNDiUOkfftkgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hco9JHuADUgQBsZV3nzXHvtbQlVzH+gq76fvGkYTQ1I=;
 b=EZaIdB2ecmMgm1m9hhSXCnr60MT/ognc33JbHJllGXwSJ/uEAA+kTSkXKI4U/0mOdtTxFsKFU8h84K/F6D9Hk0cpSEd6VN6l5EUaaNC8UnP9G1dyujalZWThOSdBtv748Oj8KWxO7w8nQ0Tz8VCvfzejk2oXk4SwE1pLrJmtTaB8mYrffxYs7s3JRwCZilpkKm5vekk3yvx4rz4Tp0mXj0eic3tZ0HwuCrQZh2hieAMIvL3w9FubbkWBoJ5PtIQVuBgUHNsh0HObO7PUnFReiorEZKdkirZFK1rnOTz7tFt00yUQEVqmMi3XCYUw2WmBessIHBWdyDg/co2BBJgEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hco9JHuADUgQBsZV3nzXHvtbQlVzH+gq76fvGkYTQ1I=;
 b=HCe+vrWH+gRFyQrVJZG5v4WO6sXlNKrivqCk3Ws/e5Wup73hHUv05URf2tqf9hZwPlf5NyW7z8fM7YwPmmyVZswvoYSP61Y+w5bzieqmfeWlov+BcVQ98BHKnevLAUSJ36oFTdzrd4pxMrECbWHm5ajAqNX7I6/P87aeXg7KFFKpadxUDnJNJE3hQxTJrLnDG39zEE/44iF6UGNkoTB2YxI2VNaNBHcbWN7u15K9uTUZDL2gj7JfVqFQym9G7FDoTNdMOs/p7GSFjwbLig1sd6iNXd6ba1Fxt/MDGj68sJPiwdEtv2/b6GW3DsU8czVCn9R19kkEEEFf5B6HpniPnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 00:27:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 00:27:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 09:26:59 +0900
Message-Id: <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Surath Mitra"
 <smitra@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250930220759.288528-1-jhubbard@nvidia.com>
In-Reply-To: <20250930220759.288528-1-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: df4423ca-635c-4648-43d3-08de00814018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXZCWHNQeitEUWVDUTRqUU9PMUFDUnhSYmVHZUtwalJISHQxNG9EdzVvVFJq?=
 =?utf-8?B?NU1qTEFsSDVxUU1zK3NrZHVjcWR0RFViNG1GYmxyWjBQbm5LRDNOVTQ2RTJE?=
 =?utf-8?B?WElCQkZCZE5BMDAzblhaaGJacDRrZzJpVDhUVEJ6WngvaG1QZzNDZEFmeDYw?=
 =?utf-8?B?T1hpVFNHUlBUbi9Td3FkL1Z6Q0xlM1ZWOTJoMVJwWWh4dFp6TXJyWDVxTkl4?=
 =?utf-8?B?NWtBRXVCdGRRVXRsbVlLUHB5RXVJcnpFWW5ML0YxRmRPb1ViT1RKdFhSdEgr?=
 =?utf-8?B?emIvdkRoVURUYmgwSG9pLzhBR2RPaGJkbjF5SFQrRXJzNUdTQlRKZGdOWTJl?=
 =?utf-8?B?cFVwU1ExSjBmTGp2S05HQnozdTJLemZGU1lvZ0RFTmpqelpGdkhCc09VVDds?=
 =?utf-8?B?V0VOdmltYUFXTjk4RVBraktrKzYwZEZvbThTSzZ0V0ZBemJMUnI2M0JWSFpr?=
 =?utf-8?B?bkU3TVVpVkR6aTRTYlR4K3FEbmYzM25oa1BraHMwQU5iYmlaa3pNd3hQdTMw?=
 =?utf-8?B?TFdtQkZtZGVaNStjS1o1Yy9LWTM2NHQ0aStPNFNYbmlUWHI1b3hhWERYbURK?=
 =?utf-8?B?RE1GY3JOek9mQ0Fod21OTytQK3NraWk0M2xESDlqYkp6Z0d0T1JEQjhMMGc0?=
 =?utf-8?B?bndrUTlyK09rUFBkYkJVTHY0YWVhc0luTWplbUFKWmQ5Ym41Q0pYMTRKUnlU?=
 =?utf-8?B?dG05aThaWUpMTDQrbW5wVkEzcGIyWTJWdWRMVEdNVnVkcmcxUks3a2FMVUk4?=
 =?utf-8?B?dnRlT3lPa1V4SzNmTGxTWHBSd1kzN040b3RTRVYvc3RXR1EzMHF0c2Vid0Rw?=
 =?utf-8?B?d1BKRHZ2NGFNT0Flak0rM0tCbGhENkFyWis0NGgvR3N3N1E3TndRUGUvL1cr?=
 =?utf-8?B?Z2tkeFQwOERmNXR1RXpQZE9YV2ppdVNEM3ViaytVb1NPSFNScHFPaUszd2xC?=
 =?utf-8?B?b1kxcDhuaEQrczhPSlJyTHIvY1ZicnBWcm9UYVh4L01KSWZDcStCS0pwdHpr?=
 =?utf-8?B?WjBqNndVazJNcytlSlRzTGxIblRPczhlcExsTVArRElUaG9SNzlwRm10UTlr?=
 =?utf-8?B?QjlQMGZsRGFHazhHaVprcFR2QmdEQnowVjhWMWM1TTdIUlBYMGtEaHdGL2lV?=
 =?utf-8?B?MUdsRWN5UWhiWDR4ZzhMeForbzdJMmh2NzB4NDIwTEZaaXBNaHpnb1U4Nlhl?=
 =?utf-8?B?VlZ0V3Ewa0J1M3pjZmZqZGZWbVVHdUpUVXRsRE1aSjlyTFppMnF5MzJVUEli?=
 =?utf-8?B?Y1lpZm1Jb1FrRnQ5dU1FOGVaNGVzc2dDUWk1WFVkQXhRVG5oNGJTRFNLaGRq?=
 =?utf-8?B?UVZtRngwa2FUZFZtc2UxVldnR1EzS2oreWNGWlZRMjRkeEdtKzZqMUF6UGoz?=
 =?utf-8?B?eUZ5ejJtNU9BdUhwVWZ4SFgxVnVxRkpCK25XSERKbjZOZnRpM051Vk5kdjlm?=
 =?utf-8?B?dVpSRU94WXB0dG9ySDVBenJkWDhvU2NFQnZYZ0UxN25Kb0VwQXl4TFUzdW1S?=
 =?utf-8?B?MmNCNUtQcy9vMmtZSmZPcWdLVUpKS01qRXlocFdKRWhMeG4yQVBmQThmQVlr?=
 =?utf-8?B?L3hhcXRlL3MxbjZFY3hpdjU5bWNZWmhZRjh5QTFNdzlnMUg4VTRoa0FMbTc0?=
 =?utf-8?B?VWN5N0lkUk5QcU1oTmpyY0ptdU9oc1hac0NVS3V3STNiL3l5eVJPVkVNNmJE?=
 =?utf-8?B?RnJwYzdETlFldGhtRFhBY0J5eWtBTFl1QisvZ0pPd09DWHFYRkVaWjZYTS9w?=
 =?utf-8?B?UkNySlEwVHV5VFRrK2NjT1pOejR4NGxqRlA4QjZVTVNkQ21JcHpadVI0S1Zl?=
 =?utf-8?B?dzFQU2N2amUyUUZxamtORXV3aW1EUUo2cTRSTXMzenRja28yNU1WdlVkczlI?=
 =?utf-8?B?eXEwUnM2Uks5V3BSUy9DdWRLYmVuTzU0Zk1JN3pPS0pDM1BvejNnUis0Q0lo?=
 =?utf-8?Q?BYYsdXCG5ZWXQWM0twTMjfon7JJ/mUMx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWFvNmlPM25oeWUvMWRHd01pS2RGSG80d3l1bzJHazBIalkyQldFZ0M4WjBr?=
 =?utf-8?B?MnlLV3RHUjZCbGpDMjhwQldKWXM2SHFmbWx4bHErRkxJTms3aGtNaVZEdXR3?=
 =?utf-8?B?Q1lBS3AyejN2aDhucXo3YzRKUlM0SzA0cHVFVDY5emJCRFFUUE93d0pOZXBz?=
 =?utf-8?B?dURUaEtOeGh1MGl6TUh4SGRHY3B6NVU3OWUyMWNuSTU2U2JnbnNJTXFCQUpu?=
 =?utf-8?B?ZGZvc2paeGgwc2hybzJLeGM1RTloU2JuUks4RHdQS1lSY1BLQ1hmdEc0MTVW?=
 =?utf-8?B?cllWSllBSnJOd3Z1a09aVm1MY1hXM1Y0Mk80Si94MCtrTFhudFFXejAwTnBP?=
 =?utf-8?B?aUJTbkRjUjdiZFRLaWJFeGNXSngxdUhXdmxrQVowSlJrVFBmN0dSZXJOOWhE?=
 =?utf-8?B?NXl2L3BmeFZqeWg1aWtzc25uWGlRWWtUZE5zRThLMTdyM1Zvb2VwY0g0VGZ1?=
 =?utf-8?B?eW9KMmMzTnhyeG1RaktDU21CUkNVVTJ2d2oxNWFGbWZHVU03QUVJbWVpQ1VJ?=
 =?utf-8?B?cDBlREV4emNLWGRRTTE2R3ZXQ29xdWExZ2VqT0tCRU8wOHRpWG1GRHpKRWwx?=
 =?utf-8?B?MXB4cUE2aEN1RTJGcTVTb041eml0UXVVenpBOEQrZzc0K0hlUys2M1JiSDFo?=
 =?utf-8?B?bG95ekpKMGhCVExvVmlMRXZCVXIwelIrWlVPTWdpbzMzNzEwMXkwU0U1YXJz?=
 =?utf-8?B?OGF1NWYwVHRLd0Fwa1VEMDdBT1ZMbDJmcWdWcEZaNlpIcFA4dGppY2dYRUhl?=
 =?utf-8?B?UWlsZFg3dDY2SHhBNjExeTZHd0tHNW80RWZTVTVUN3h0dDdkSk9GeDQvdmNN?=
 =?utf-8?B?NHVBM2luMkYrYVREb3F5aHo0bG1na2IzRXdMaU8zczJYWEUrQ3dhQmxiY1lp?=
 =?utf-8?B?WU90RVo3YzR4aTZyV2FJZFRiYUk0RjBLYWRkbzYvUU5pL28yOGtNWFFsZGJu?=
 =?utf-8?B?cThzRUFjbmVzZXVGbFI2eFM3ZnNJdS9qbEhTa3VIdU5MVHVOenhzVWI1SHVT?=
 =?utf-8?B?Zk8xK0NzM0RTRmR3YlFjV1B1U3dNeEgvdVdaV1ZnMXB2Y0RNWkJUM1JmVzFW?=
 =?utf-8?B?aWtlcHVEekRUY3hvS1ZVZnNobmxSa2VBeklhVDJsSFRCNDkzNk1oRHhuTjdD?=
 =?utf-8?B?MlEybU12aXRjdGc0UVloKzlyYnU0bHFRNEdHV1N6QWdmZk5kL3diN1VMYWxu?=
 =?utf-8?B?aVM5Sk12OFpLRm5kbEtyd3Z4ZStsekplTVlJQ2xUZUZXM1l0b0JhN2VZNTJS?=
 =?utf-8?B?OENTYzJ1NGZ0MlJoM0VGdHQ2QjNYODIySlZIY2g5RnZnNkVZa2REeUxSRTUx?=
 =?utf-8?B?ZUpjMEQxYVFvYUhudE5DVHFMbWdIMHkrQ0tCdTY4eHduSFpoelZCNzBPby9r?=
 =?utf-8?B?N3BCSDRQd21uWEpkOEV1Rlk1VGFRNlFGbEYzbnBVaEFZKzlCNlVjVTZDWmdJ?=
 =?utf-8?B?Q2l0cVZ6M3E5ZkFXKzh6RFVPM1Z5aU9qSnAwRU5rdFlCT1ByWnRqdUgxVzJV?=
 =?utf-8?B?TldGT0ZLMFVBTG56QlJIc0pBNVUxVmJJRlZDOWN3bDZLcXJYNXpqcXlqbnoy?=
 =?utf-8?B?cHF0OVhvSHNSRjBYTk9sbWZxTytBTUtiQjk0QmdYbEE5STR1QkJZM2pmMzBz?=
 =?utf-8?B?Tkw0eSs5WjNweVcvb081V2lYUDFXVVhCOVM4NWliTXdsK3VTOEtOd25uWmVO?=
 =?utf-8?B?bVVQeXZyemtIRTNPOVZjNkdiSUZvamNBUUpDWDd5SkJXYUJlUTZjTm0wUFNP?=
 =?utf-8?B?QVlpeTYzcHFqd0xhc3gyd3ZxU1Npb0htZHZMUXY3ejhwdTZ5SHM0cFhzRE91?=
 =?utf-8?B?WFk3d2ZKOUljRlRZQWZJY1hyMnhUYmdCWkY0QWFiekNpVDRMK3ByOVd3RGZK?=
 =?utf-8?B?Vk40YWsvdWpFSmZwR2xpSnBGZGRjc3g1anVlTHdTQXlVR2RQNS8rZWJzK1Z2?=
 =?utf-8?B?NGdtdVVJUHNkZytIMFMrb1hEZGdTYnNRUDhCRHNEb2N0cTFxZ3FScmE3T0la?=
 =?utf-8?B?NEV4dGp2dEZyeGk4UlBCNUl5MVppNk1rS3ZpOVZlOFZ5YlNMNkd4ZkFsNWdr?=
 =?utf-8?B?UWJpZTBrR2RCZnpsMW1uS1hHZ1p5WDBFekNnMThObnhwNWxyK1JVVW0xTTFS?=
 =?utf-8?B?MCs4ZER3aVFxQitoeTdrOEROOUQxWkZHV1QzVkk0dXkxWXMyQk52NFJLMFRH?=
 =?utf-8?Q?cvpe2Lgogm5E+/cIlsEcDt+vzIOrxhbvUep6p2RyfPqW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4423ca-635c-4648-43d3-08de00814018
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 00:27:06.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WEHgbpR6dGlXyZxvtlcgKCTVKY4nMe+6B8zsSN3igs5BUJC883hcPbU1cmEAYHcjbfTxrZ6nebpRSNq7vr2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623

On Wed Oct 1, 2025 at 7:07 AM JST, John Hubbard wrote:
> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
> let NovaCore bind to the VFs, and then have NovaCore call into the upper
> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
> longer in favor.) So, in order to support that:
>
> Nova-core must only bind to Physical Functions (PFs) and regular PCI
> devices, not to Virtual Functions (VFs) created through SR-IOV.

Naive question: will guests also see the passed-through VF as a VF? If
so, wouldn't this change also prevents guests from using Nova?

