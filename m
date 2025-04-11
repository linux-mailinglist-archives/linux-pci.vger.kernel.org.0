Return-Path: <linux-pci+bounces-25672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DAA85C86
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEA7B66CF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B029AAF6;
	Fri, 11 Apr 2025 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bkkeLTPl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5508238C2F;
	Fri, 11 Apr 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373391; cv=fail; b=DcwEyI9xNSYbZBfz00ND1Pet2cFpc//dWyZj3pMwD9lLaNwIzHYNBJzVPrM/NXYQQKcuJK0OA/bueZuBdt50/02pGn46zYNBqkzsPHHp+f8holb/njswYW9ORs0A80DMLZ4o4yheBlVU24otBhCYev43SJgMM59Ljm36xUssq3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373391; c=relaxed/simple;
	bh=EqrgdsCcrgQMv/b5RJuyenmoqqzVVwh7S3EkmmoOjIM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=SS7w+MC3b9i7wcm1Cq+Vr38Nos0twOXrpP3Fi7bby0Lie4WXqtvmbTNMcujkPBAAdZ0QjnIRQ1mBJHA8TO9tVyUnT8WxwAPq0giWFAYeW2tePcv4fme5dKmyCUQQSBABILRLtXyzeFg36dZyui3HPIFK0Zh37aSZ6AfVD6SO86A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bkkeLTPl; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG677rgAz8PQN15F4Pefe21x3p6BPC+b3ENdFlQXWrvUOKtzJLhDUQp+iBOaivScH1wEvYbhho3P1HLGj5wBeARtewqc5ktarTFzrsNkipylqKlrkYDoPNz/R8IrDqz4K1mluWJpgmFFtS4PZHYat/rgFvZ6BHOscASQHwwOFha4zP+O4KzRcSpOlsTMG6JbED1tFpvt9Vn6JYBgRECdoFn6hGZ7olpuX1ujzYZ8iQ4AmK4I51OE93gdXsWRjmyFxOMtqjUIEIFLXqKLFAz5folKcRhkfGUC/vDESC/ZA18fo/8tLBslbSZDr4iyMGzP1w+KzjI3cgIrM68AYsfgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jvr+etEoFHOjULEGRM/TT3blEjxGjSxj7dafsYZ+qg=;
 b=GoYM6PqQOKFg0rZmE50buhXvbsinyHZ4+LMU/jtk/NB2VXheRmT8cJ6YF5VYeQ1OtZeBNLxPk3GRkTwy0OohK9FKjCVMZ9Gv5JOgK/DKw8jDufXT0qy0BF01qOaQVElglJmdcXD/816gHdVmOYdVHXtCumOV9VlwzM59Oaf5JSb8UCt/LJAhoIeiGSGOv4l0KQD/IDbsNPfio00G5dytsu5xfm+Xmq+wylvIIZIoC9FMHXnZ15fqpGZsWTlH2e9hwoWwumqe257ZQa2IX+HcJs7cDFw6nOa+9R2+0nakf1SGJRDKbgPWnJvdRZcLhf8IIOSWrOT2jfruuOQ/sw5Ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jvr+etEoFHOjULEGRM/TT3blEjxGjSxj7dafsYZ+qg=;
 b=bkkeLTPlga0ItRn3sbnSDtT7DAUOlrPGdAA8mtwcHnCDTzrqtfEpZrW4MsfOXyx9PqOJPi7/LqoPtQ5eBTUDx3RUKQYBSNk11oaf0n9GTk2sbzL9Ix1bZ+kx1hOCppWa5oExnJTue/0slLblUck5ViZy1jb1MCtSrqaeNAkDbUIWPiRIYfmitTo/7x5s9aZ7MWWES3qtoY9CHAXaMUQPomNK3yoSv1kKAIeprjRfHYaIoC5dV9GLnj3CbRQjhkaQlmvV9+iJgNroosv7YJ4yKPdpUICxki2ER2irJVEa6tZUuIS9U5mYPwQUWurewPZuUMVGK+sZ/XJWHbkqoPba+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 12:09:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 12:09:45 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 0/2] rust/revocable: add try_access_with() convenience
 method
Date: Fri, 11 Apr 2025 21:09:37 +0900
Message-Id: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEG+WcC/3XNTU7EMAwF4KtUWRPkJP1JWHEPhFDquNQLWpRUm
 RlVvfuk3UwRsHyWv/dWkSgyJfFSrSJS5sTzVEL9VAkc/fRJkkPJQoNuwCgjl3j7uPAySkQ3OBW
 C6VsQ5f070sDXo+rtveSR0zLH29Gc1X79oyQrqWTjBrAeLYAKr1PmwP4Z56+99B/hA3rqKDjr3
 Vnsu1mft9xJagnSak3YGoRm6H9J85A1tCdpikRwdWdrTV1rf8ht2+5BpS8VRwEAAA==
X-Change-ID: 20250313-try_with-cc9f91dd3b60
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: OS7PR01CA0234.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b98520-c723-467b-5073-08dd78f1bf96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXVSYXlzTFNkdWZLNnpyWEEzM01qZ0ZacnlidjdwUDJJUzBCeDRSN3FkMWRi?=
 =?utf-8?B?QXNGRVZXUzZnMkhLQlBaMXgzNUowS3h3N2JPYm9vWlFycmlCWThQQmtlUmo4?=
 =?utf-8?B?anZXbUlxeDdvTEZNNHYzMXU3cE5uclJwUUtwdjJ0NEMrZW5ka0hCMHk0allR?=
 =?utf-8?B?QkRqaXVndjgyNFVMeDc1MHNlclNGNVg1b085R08xZUNBVFdya2VYcDI3aGVh?=
 =?utf-8?B?VWM5WWdacU5aejVXSEtSdmNyQVdFV1MyaHAxSFdZaDFHcTRac0dOODBJS0x3?=
 =?utf-8?B?aTYxMThKRmJMMHJKS1Q2MTZFRTAzM3dLdEMySzlKS0x0S0wxV0tpbkdYRkhl?=
 =?utf-8?B?ZEs5VnhkcGU2bEIzUVgwZ1hHMGkxYUFSMW1sczdranBwUEpKVDZHK3J5RjNS?=
 =?utf-8?B?REVlOFZlc1RoL1JsMGU2WE9vb2xYYVQ2V1NjK25jVFB5RnFpYmR1d0ZkaDhp?=
 =?utf-8?B?N0JrK094ZjhpWVRpSHMxc3cwTVBpam11bjM5WGxQOWk4TlBzQzFVQ0pmaDFN?=
 =?utf-8?B?RHA4eDNJMG9jVlpleGRmam9mRGpMaytMNjg2WkZxYWxPRzdCWkpUWHV2MEFi?=
 =?utf-8?B?WHg0Z2YyNjZTVElYbWJla0l5UVhHaFBXbUN0c1JuaXc4V3pISVRhcGU3UHA5?=
 =?utf-8?B?bDhzQkIyRnZuMGRpdGFaR0xHT2JRMit0WlQ2RTZXTUpJMnRmODVhNksyZEgx?=
 =?utf-8?B?Vm8wQ2hjVmF0V0FGWEpiWjUzMWFodGsvdEhZZTFSdEF1TC8zNlVWMFlNcVJ0?=
 =?utf-8?B?ejdhU2N6Rk53NWR5ajAvMU1MRUxlYjZUTGJ4MERRVlVYU3dITm95NGdZMWtU?=
 =?utf-8?B?MWd3bTAzdGZxQlRjSlpQOFdmanJydG1RSVUrb2UyRU9kVVZHQmx0LzFFdi9D?=
 =?utf-8?B?a1hXczQxRjk0L2hEZ2MvZHFnbG9FTDJNWVEyV29Da1prbG83OHJ3VWg1VlJq?=
 =?utf-8?B?aEM0NzNVMTBOcE02QitxN05iN1FCTFdkNnBST2ppZVpNcDlLaytHYlFocTY2?=
 =?utf-8?B?ZjBINmo3Q0pCTUZNeHdRTmF2Ym82VkdCaSs2Yi96VUNGRVg5YytWVDEyalRH?=
 =?utf-8?B?bzB1WVQ1MHFTL1hGZ0NIYmNmZlliSGt2cFJTN0JNWkw5eFFJQVQxL0VhM0Jz?=
 =?utf-8?B?ajRxNmJFa252R0RmeUMydXIxYzIyM0lFcnp1MU9UNFI4VlBFZG1xS1hrWkxM?=
 =?utf-8?B?Q3V5VU1hallGeTZHVDhOZXBFMUZtMnhBOTAyRFVicU1ldWoyWWVhcy9IMWxl?=
 =?utf-8?B?c0gyOUdGYllRbll1YmJkcUk2RXNBUFJvbjZxOFZtc2luRmNNeS9BRjZ1Q3VH?=
 =?utf-8?B?eGJ6Z0RockMwbHZSWE1lTk43d0xZWkdVSHM2T20vS0NYM0t4ZHFSbkVmbng0?=
 =?utf-8?B?Sk1lZjZSTUZ5TVdiZlRyZkpLaDhONlVHMmQzSmVMQ1FMTVFHVTRMZVp6ZlJv?=
 =?utf-8?B?azhTUUVTRnVkZ3hCUkNPbkZBTnREdWdmWXRLOXp5aVpYTWhxTGJYWm5FQW9I?=
 =?utf-8?B?WnhCaVFvUmRITENOK2s5SmhnVlArVC9wMDRjMC9IcWRyNitmK2gvc1ZMM1Rw?=
 =?utf-8?B?dE1QdFJaQTcrek1pV1phczRFN1JvcXJFOGI5NyttZURjeWZ5S3VvMVB5WWRX?=
 =?utf-8?B?UEtobkp3MFJ3ZTFCMkRaL2NzaE04MC9MNGdqZHFxakpWUDdHL0ZQZXREWUhu?=
 =?utf-8?B?NUFaVS9YYUJuRS9UYUxqYm9hanplNSs1b1pzQWVrdkZTbzYvTVFObUVoamZl?=
 =?utf-8?B?ZFhKYWNiL2t2dGR5ZVF2Y0xOeXlwUmJNYTlZREVXcUh4M2c4dm81NmZKeVc1?=
 =?utf-8?B?RXcvK0NTVjRmK2t4NjRweExIdm80Q1FzVE5ET0ROT3Myb0VmemV4b1NUUVB1?=
 =?utf-8?B?QTh2UTU4blF6ZGJrRENGS1I4Wm9sOTZidXRxeVJjRU5zNFFMWWNxMGYzQ3JY?=
 =?utf-8?B?M2dXWHZ5VVZEclBJYkRPdEpDSXdCOVJtejhybzNJUXlxemgzSlltVDJEN0p3?=
 =?utf-8?B?SXpra2RiMFNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTduMU1iN1ZQRVp1UGFmc3VwZWpFY2l2ZGZtVC9CMFRub1VnMG5sdlVuMXcv?=
 =?utf-8?B?TnovMEJKR2MwR0ZMSW4vL1Q1Q0pNVjlySXN5K2pubEtzM1hvbHZzSG9oOFFj?=
 =?utf-8?B?OU1NV1JucXloS3BlaHZ1RnUzWVhpWjU1Wml1SmZvTkJRS1hpS3VvR3N4SG9z?=
 =?utf-8?B?bDZkc0hJYUtVcVovQlVFYUJHRlpCNkNDUVU1QlNiTG01T0VGYWUvMi80OE0w?=
 =?utf-8?B?cU9oSitHMVh1VnlsbDVSbDU3UXhDaXFmZ0YwZForMCtRNnBqUDZTcU41Mk5D?=
 =?utf-8?B?Ykk1eDJNTk8rUG5aK25ydmgzOXN6UEhYNEdNVnp6TWkwODZWZkp6ZU1Pb21J?=
 =?utf-8?B?TXBydXgwRVNSd29hTlczRlVkL2NQTFpKVU4yb2xyTkE4TTVSY1ExTUZQYm53?=
 =?utf-8?B?bWJKdit1SWdZUi9zanR2VEJBb3ZhQmlielJTQThTVmE2ZEJBZkt5T210a2kx?=
 =?utf-8?B?U2UrWHM4Vzd6bWFjUmNMNzBCa1Y0QTNtZXMybVRubE1yTTh0U2RGZGNSc2FH?=
 =?utf-8?B?Q3laRy9sYnN1cnkvbUZ6WHdrVkIwVVhpdXI5elhSZ2NNRS95RlNGM2l5Z0Z0?=
 =?utf-8?B?Wk5iK0lqVWpXd0JHZnc0S3YwWXpjSzh0THh2V0dNTG85Q3B5VHMrakNZSnFN?=
 =?utf-8?B?dzhITElqK0VFek9nRnFMdkVsZlgrVUgrUEI3MDVJekdEOXpFY3dFcG1NR1FL?=
 =?utf-8?B?MVhJL1B5QW40NWRuc0RTWnNpck9kQmJYTzh2VWZXaFc3dGVaQXNIaFpBczFo?=
 =?utf-8?B?NFZFUW1ra1A4MnZnNmJwYlVZYzg2YUx2TWNPZ1h2ZHI4VmpMcFlobm1CR25s?=
 =?utf-8?B?TTJFdWw4VkY3M1FsUHB2UjZ4TGZzYmd2L05nRjgzUnpRaUQyak1VS1JQcm5O?=
 =?utf-8?B?bThKczlrS2RoRVBaNmxyUnBpOFRKeVJhTVZMc0s4d1o2WWZaOUZMMmphRERF?=
 =?utf-8?B?Q0pnUHRvTUN3di9zUWsxOU1ZZTNDd1VOOGo1SlJ6b1NWQnRVdUVyUFNRNVhm?=
 =?utf-8?B?bm5UM1g4eHpTaktueXFvY3hrU1d0YktPdDcwK09Rb1JaOFg0M3NhNytEcjFh?=
 =?utf-8?B?T3FUMDV3QlJjcWJSNkZqOXdTZWl6TXoxay94RzhabUZSdE9HU2ZidzBHYkxC?=
 =?utf-8?B?dlljcVNrOUtDTmpta0lHZVRoaHQzWUdvc0xzZVVQL2ZGQ3BCYXdrK21leGty?=
 =?utf-8?B?ZzBlSUpndTZsenJ0TDRmNWd6TUo3blJZOGFJMUp5LzRUalZXa1BZZjZjcVNU?=
 =?utf-8?B?MjBxUDNidk8vTWZCWHQ3Ry9EUGIyaXBidVkrWWpWblIrd3V0QnU3QzBWaXM1?=
 =?utf-8?B?Ym1mSThxSmI2cExHYWZqbFU0VDh2OTA3NUFwdFBkN0VpbkxDY1g4NytycXJy?=
 =?utf-8?B?TXY2Sy9Hb1FNb1hYcDYzc2U3QUlXYkFoZXk3MnZONkx5WVpyRndFL0RaSjJI?=
 =?utf-8?B?YnRreXFwTXFYOS9WdnRsV0c3MTlQeVhtdzRsYmZJM3ZTQlgvd1R3M2p1MXhC?=
 =?utf-8?B?Z0ZEbnNOaDFOQzJ4Z0JoUkEza3d0azNheUlYdTY1U25qenhhUW96THl3WTNk?=
 =?utf-8?B?TlptRmt2WnZJaFA4aG5PQ2FzaG03My9hM2dmL2s2ZkdraVNDaVVhRThoQ3lJ?=
 =?utf-8?B?cURYR3J6WHQzUERGZjRQVlRtYXkvYmMrNXBGTTF1NUhpem1ZMG84TWdJZkxY?=
 =?utf-8?B?dFdiRFZVL051VVlhU25zUmlrdzVlM2JLanhzRVNTVUtxMEVIcXpNb0p4SkRQ?=
 =?utf-8?B?bkI2QUFNMGI2NWtSQ09LR0t6RE8vQTFnRkV4cnQ3cG4zazEyMHVOTnN4NHpy?=
 =?utf-8?B?Mjdpb2dtZ2UzWXBObFdXdHpjNGxIRG12RFI3S0dTelFUdEhrdG9KRFBzRFQ3?=
 =?utf-8?B?U2FWWER6YTd6My9UMHpoWmxLc0g0ZURhdTlxQ1Z2MGYxSUNlVXlrVzVubWFW?=
 =?utf-8?B?azIxZXN6S21Oc3hTQjViQWkzb1djUm1mS3lsUnd0TGcyQVk5cHB0NFlxREpQ?=
 =?utf-8?B?dnB0RGx2a1g5eWJtT0hFNzVKczIrdG55ZTllemE3M0N6Qk9LSG9EU1hjTDI4?=
 =?utf-8?B?bkNOTElvTFRjKzE5bnd5bG0rbWNQa0J4aWRiT3pRYStYaUJFcXlWMUZQS0RL?=
 =?utf-8?B?eEJsWWVMSVZma3E1VFB5WmdNbFd4aUNlamFVNnN6czNORGl1MEVyZFBFWnJB?=
 =?utf-8?Q?1AVVMMM0t7Pf92i4e8hFZxb7QkXC1SbrHtHJHRlZLIEQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b98520-c723-467b-5073-08dd78f1bf96
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:09:45.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCjzErBVlHTF6GAQJL6WlYu3K6yt4kj0r8WEJGQl00eeFZbiCrEcXwyVGhp95U0M9ntkFniwZu2BvrWCKZmkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

This is a feature I found useful to have while writing Nova driver code
that accessed registers alongside other operations. I would find myself
quite confused about whether the guard was held or dropped at a given
point of the code, and it felt like walking through a minefield; this
pattern makes things safer and easier to read according to my experience
writing nova-core code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Collected Reviewed-by tags.
- Link to v3: https://lore.kernel.org/r/20250406-try_with-v3-0-c0947842e768@nvidia.com

Changes in v3:
- Add Acked-by from v2.

Changes in v2:
- Use FnOnce for the callback type.
- Rename to try_access_with.
- Don't assume that users will want to map failure to ENXIO and return
  an option.
- Use a single method and let users adapt the behavior using their own
  wrappers/macros.

---
Alexandre Courbot (2):
      rust/revocable: add try_access_with() convenience method
      samples: rust: convert PCI rust sample driver to use try_access_with()

 rust/kernel/revocable.rs        | 16 ++++++++++++++++
 samples/rust/rust_driver_pci.rs | 11 +++++------
 2 files changed, 21 insertions(+), 6 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250313-try_with-cc9f91dd3b60

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


