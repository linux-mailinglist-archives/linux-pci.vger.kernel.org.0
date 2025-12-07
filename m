Return-Path: <linux-pci+bounces-42741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D076CCAB6F9
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 16:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BA723003F8B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411C2459F3;
	Sun,  7 Dec 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQnmC8C7"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B420C038;
	Sun,  7 Dec 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765122930; cv=fail; b=OnYIiK7jnlfvB48HYzFXrXFvcvYv6vFhzLhEGeQ0k45vtQxgdem2+h2uazjvzOo0NeAC86se+ntMMFybrZ7qyNI7rSxDrxXsC0B6H0fWbOKC4ThgzkrJctjsyVIWyC7vpqK+0PVmZzM5aZ6LmwRnkIXz3umnOXLRaVqJNsUc1lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765122930; c=relaxed/simple;
	bh=SFg1dtjn/K/8nGcSXwVSNaj3iMwNTmJdWnyS/i8bDWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hp3wvXc2Tda9D3eElRharpm9MV8BBbyApnwMr7dOP6gFBanD33coiQ0XZigw5Lzbt5R7NvLlkMphLusrc8YBpsPBv8lAmbdiRqgxDIhEaNasY3KVe59DRtgKlYqC7obzfFV4Zavs6eC2YxxI2xVnmb7S52HLWpwPg4wYT6vlUq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQnmC8C7; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jmy7+5P7OZ/FLjRpAnQcSHHc0aOTvDlNnSJUL0RYKYa0cMvuIQ0kzGgNIu6pUrrh0iwtepyRMb+2TUfDI8Fbtozm7BTLrENrSlQJuF9X9v0fFxv5y3wf5SyAXriI/+lRkiQ1fzQF4k3Pzkcca0NPN4HZuFPbTh5oxIAm9s4A5o0FtTM8qAlksxrEwfk/SumF/R7tGAZOI65Wp/RisQ0UqJpxDzhwguLyxkFdS/oliug3SHnVeibYvc0c3IVkaSa116UJoehwzemUTrOpAg+ZNsTrKDayanfUenikFM08bGwvTauh0n583r7KfYhyJWVeMWOo8FeEUS3ZZ4ByCX2FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFg1dtjn/K/8nGcSXwVSNaj3iMwNTmJdWnyS/i8bDWg=;
 b=wNGDrETZzVXlt65IztmkEcIs/+HT5b0QN/G4VibvfCbLLPvYwzO2iWnqkWO3a8bkibOvxlNXOK6S13lgnbjzI5dU+v9vZ5UTRGOMwrMr6Rv9om030nVYvAL0j07JayuPdxIAdndjlMIZzMMzd1P5SWHJBQKl2FNYW2ZyRAa7ps6YB3PHIjIuSJVRQvqVZkruXwyngec1H/leB+ZSts/od6mCwN8Qc5rQ2MVitfBZ1XFJQ1CKSUjE9TCjZ928Jwzf09MioV32zNPuDkvt9BWQYGQQqcWBW6ldJjAOtiY+YiN062cm4L4pMLfROtssv9verFtpMxazRgDrfRgKoteXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFg1dtjn/K/8nGcSXwVSNaj3iMwNTmJdWnyS/i8bDWg=;
 b=CQnmC8C7/CT6SmI+bbu+C15QCOklSSyd3P12s0khED1ncJv0Ip/lk3L5vqs8mkwpFtRDRM+mlk3CU0mdu0mSyOS3RBy10ACvVhfs+UReF/e5nGVGgeyl7wS0UntQwVThERD9igvotG6gq/789jBxPj7/Wfne/2LKBMHCVwVni+NU6syaBG5+pkLHKYRMBdZ6ip61AtjkAHnJnFMFNLk8MdFjIt848kdKEDrDRvaJv9PZb8K6ddUVDrt6G9uh1isEuWdoFutxOdCiJGOgnXowHu8Y2jMkGJpdS7K4VzTMpGzQJocqaZDfq+Hf519UqPAkREcD0jrFIQ2KE9J2CU9pxw==
Received: from PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Sun, 7 Dec
 2025 15:55:24 +0000
Received: from PH7PR12MB7937.namprd12.prod.outlook.com
 ([fe80::805e:c531:4f9b:57f6]) by PH7PR12MB7937.namprd12.prod.outlook.com
 ([fe80::805e:c531:4f9b:57f6%4]) with mapi id 15.20.9388.003; Sun, 7 Dec 2025
 15:55:24 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
CC: Kirti Wankhede <kwankhede@nvidia.com>, "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>, "markus.probst@posteo.de" <markus.probst@posteo.de>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, Neo Jia <cjia@nvidia.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>, Aniket Agashe <aniketa@nvidia.com>,
	"tmgross@umich.edu" <tmgross@umich.edu>, "alex.gaynor@gmail.com"
	<alex.gaynor@gmail.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"lossin@kernel.org" <lossin@kernel.org>, "alex@shazbot.org"
	<alex@shazbot.org>, Surath Mitra <smitra@nvidia.com>, John Hubbard
	<jhubbard@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org"
	<zhiwang@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"aliceryhl@google.com" <aliceryhl@google.com>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"gary@garyguo.net" <gary@garyguo.net>, "dakr@kernel.org" <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [RFC 5/7] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is
 enabled
Thread-Topic: [RFC 5/7] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is
 enabled
Thread-Index: AQHcZq3PY4ktkO3RY0ialCjICPwl7LUWVm+A
Date: Sun, 7 Dec 2025 15:55:24 +0000
Message-ID: <6c2e13d934c11170edba603fb88e8f2d67a2a049.camel@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
	 <20251206124208.305963-6-zhiw@nvidia.com>
In-Reply-To: <20251206124208.305963-6-zhiw@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7937:EE_|PH8PR12MB6963:EE_
x-ms-office365-filtering-correlation-id: 19055cf1-8e4e-44dd-9ad7-08de35a908ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjF3NTV1ZmMxZXZ0ejNIbWwwaXlNdVVXSlBuKzdET0RRNHBFQmd6dTA4cFhZ?=
 =?utf-8?B?RktaRVNoVmZ4U3ZUVm14YjVaQXdnMTlaa1ZMYURCWEw5aHZZa095ZTljN0di?=
 =?utf-8?B?VUgvRHJtNzZJajZEWlorNG5mUFpkQzZQazJnREl2UktRajZOOGQ5K0dWdkxh?=
 =?utf-8?B?WFRkS05TWlhiaHZuc3Bxb21CK1lvOTRJY291clhLUGFKTDF4WVRoZEowVDhS?=
 =?utf-8?B?TG1DZXgyZVk3aXV3dzB5Ykd5RmlIZ0Zqa3kxY0p1VTRqcUFGS3JnWS9Vclhp?=
 =?utf-8?B?aUZXNkVtRGpybmZoeUdTZkhUUVFoMDZQNFFsSEphelBOcGRmZ1hUaUowUnE3?=
 =?utf-8?B?WTNyS0VyeldMREptRi9KRmJXUEJEQ2ZYZ1dveFJLcm9EbmM1bjRTZlBFTmd3?=
 =?utf-8?B?M1VJL0V6Z2IzZmFOWWRRQXM2ZzVwek9BOWdSN2xGbE5KMlJ6UjN4VjM1WEZQ?=
 =?utf-8?B?VUpjTDRFUVUvL0RNc05ORjlFNjVGYTJuS3p6K0MvVHJVaUUyak1PbWRZNGEz?=
 =?utf-8?B?UXpIRDBYcytnWGRRWC9JUXcxQUNtT3hnT3RUMWZNYmQ1MlJlam0vcC9kQ2h5?=
 =?utf-8?B?K1hrbFJMdG1vbzNpeWlTbG1vRnp1bU9JUE5nckVxanJKUlFzT0NiQVpQODVt?=
 =?utf-8?B?WVJSblcrMUE2bnhMSG05QjNscE5rTnlBa1A5alVMTXd5QnRNSk1RUVVaeE1R?=
 =?utf-8?B?RkNiVEU5a0x0aG9QSFBxcTJLdis5MXN1TzhLMFpZbkt1S1Q2eGxENDRaeVV1?=
 =?utf-8?B?SzVDYk9DSERuQzdNcXNubWF5SWVjMCtZeHpwZGZCQmxFajRhTkl1VHU5dnhw?=
 =?utf-8?B?SzJRc2tENlZnMkp0M3Bsb0w0dkdrVnY3Ykp5RkxGSTZPS3VDdGtyWTdTRG5v?=
 =?utf-8?B?aXdrR0xYQ3pyRkVFZWprRGV1VC9sa1BBMUM0eDVRR085VG84QWpYK1R4M0Ja?=
 =?utf-8?B?cXZ0TVdja1VBanp2ODhNMi9WM3NDTDh4Ny9mQVhiWWxNRW00OHY1RDB5b2Fu?=
 =?utf-8?B?Z0ZzS2RoMExGME9ENVNGQTJqVHQ0TUVIdlNBeEdQQlQ1d0VoRkE2eDB5UDAy?=
 =?utf-8?B?SStxSnUyZVl2V0pIVVMydUJMdkhQYjlSVFB3N0NMU0xESTFjZXNkaWZ1ZUFy?=
 =?utf-8?B?MnVMUFFXZitGck05UUJzMnRPYzQvcUJSWFQzWDFPOEloZVJFL09JWTU1VVdV?=
 =?utf-8?B?MEJjbTEvQVIzcFl1dENzRmpSTzFPVGxZNDlieUFJTkx0eXQ3Z2RYZ1lXWm1N?=
 =?utf-8?B?QmZKc0Jhb01LNTkxaG1qTjFCUnpmQWRvclczbm9wTS9LNDZlSmZSY0hpSndF?=
 =?utf-8?B?R0NFVVFjWXp5eWFsZFFNdXpEZmUzMng3OGhlbkpYNHdsdVBrM1preFQ1K2VV?=
 =?utf-8?B?bHpZejduQ2tidXozYWhBdTY3ZC9MZ0dvdk4wTjRzVWRzRGcxbzdDaVlNWVhw?=
 =?utf-8?B?QkpSYWQ4RkRXVUtqK05objFQT013VXpFM2hIOWJ5QWs4MDdvVGk3QkhLdWxR?=
 =?utf-8?B?Z0ZoelNYNjBuVDFJYyt2TUhxTklzOWw2RXdrM2EvSHM4bUpWdXdHQ0tKZk1L?=
 =?utf-8?B?d3AvMUdYYzNGblBrWE9WU2FIcHJ4MUpSWnI3bGIyQUtaRG8zcmxEd2Z0dWpa?=
 =?utf-8?B?QTRLSzBHZjZoem1XaUlvdE4vNlpOUTRJY0s5SGJpa2kyTE5Zcm1heEJtVzBn?=
 =?utf-8?B?NjFDVlZubk9WSzBUWXVabk41a0lYSXFwODBZL255TmNlK0tlS2F0QVozYW90?=
 =?utf-8?B?TmlWSStrSTd0V2U2UmNqNmlyK3VxWnRSMktFbDJWUmNLbFlvY3BsRjJHTEI0?=
 =?utf-8?B?b3RlbW5rUmU3VTZEWEZIK2E4dXJGL0tOZ0ZyN3g0QXpKRFJqcVVIL0QzL0FY?=
 =?utf-8?B?Y1ByMmo1WXErd0FHV2NhR094bU40NW9tcVN0dXlpcU96QWFrT2pJUjdBNGEy?=
 =?utf-8?B?eUZzeUJMSDJaTTB0UVRUMFNXMXBXeWlaUHdCeFBEa1dtbjVvRTVrcWVnZXRu?=
 =?utf-8?B?K0RJZzFEMEZ1NjV6N2EzZEhxazFpbDJsd2cyazlzZVpBanZzRFZvUi9BZlpJ?=
 =?utf-8?Q?mHJTlr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7937.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmVHZ09uYVYyQTB5SURXUFFJVTBOU0Q1cXYreVdXZzZHOExVNkxMeS9OU0Jk?=
 =?utf-8?B?ejgyL0gzTW5RZUdXc0xUR01NQjViTDI1ZVF0ZGZnNnJBTXVTQ1dOb1ZSakpy?=
 =?utf-8?B?SER3VFp6c0FPdDZubnUreFJPU093Um1KeTVkdFBtOGlDaE1LVVI0dHVSZlhT?=
 =?utf-8?B?cW4zRUN5L1lzUHFTM1JVMDNWNGkrdHozU09tT0dZeE9ReVU5Y1FFNjk2aCt0?=
 =?utf-8?B?MFFJd20xSkVvU3lxQkdhajBscUQvYTRKaSt4NnVVK3dhQ2dpSCtBdjVzQ0Jl?=
 =?utf-8?B?VXZGV1RMYWFLekh5bnpDWXNTOEJSSUtiTm1zcDZxeHQrYmp4VUU5UjAwSXll?=
 =?utf-8?B?M2ZtV1R0VHVkTWozeG1iMmVnYjZuY0t4YUxJa290dDlkbEQ5RWo1cnNnSEhj?=
 =?utf-8?B?SDVyYlJSSzExZE9MVXM2a2YwUlRRcGM2Z1BlWTdQaEwxKzlOWlVpWTJJODZO?=
 =?utf-8?B?L04remI4bFIwN0xja2VVRklicndPcDZyYzJJNEdJWEZvV2pTRHpvMzVtK3NL?=
 =?utf-8?B?YkFsem50VWVVbUIyN2NOSmhGUTk5WkVvaUl6NlNzd1JBOHB1WlRCZnFTTTc2?=
 =?utf-8?B?UkE3dXdUN0JGeTBLTDRCTmZBNzFaUk1jUUkwUUs3U3hqVzg1UlFZcmE2OUJB?=
 =?utf-8?B?akFkbXYwU3lmUUQ3ditEN1ZDdnpCWVJlaHN2WVNFbDczaHhLaFNkTnZhRnJx?=
 =?utf-8?B?VVlaTWFDMHQ3czlMVzMvY3pPMUtabE5lalZQS3hsM0U1Z0hCWGtmR25yZlN2?=
 =?utf-8?B?ODJhRDAxNXVCQUtFK0M4MVJXNmpjRmI3Zm15dUxjMmpGVVpTaWl5QUptVXdW?=
 =?utf-8?B?NFh6TjFWeGIrN3NOSFFjcFZpaUVUbWpTUWpuUXFJL2NwUk83RFNNMExEWkZP?=
 =?utf-8?B?NWczT1V5U0lCcFozY3FUWWZ1SExsWjNaL3c3NXNXRHY1TXpWbWFuT3o4dk1T?=
 =?utf-8?B?TVdNY0FpajZSc05OdGpaZlJtR1dIdXY3Y3Z6a0lPTm4veUdIeUdkMS9qdXM1?=
 =?utf-8?B?MUNxZStoSjkxRUJCRGZpZVpvdFdqbFFaQWd3N3haYjE4dVUyYUhIMFhSdU94?=
 =?utf-8?B?OTQ3ZkVLK0xkbjNqSDNoNVBsT1JTdG1lTmZRa1p0TjhobmRvcFE0WC8rR0JF?=
 =?utf-8?B?OFExZjlBVksweU14bFZSL2NjeEo5M1J4YzM0TmlYZlFwdldPdkRTeUFYNGY0?=
 =?utf-8?B?NG9SamJBM3Z1QktQTkx6UzdxdjYyNEpZMzFNeXo1Ujl1UER0V21HeGtEbG54?=
 =?utf-8?B?R1FhM2JWbHpKYkI2Ny9GdEdOTmJQSDZ4cjIyMEFmOEtLV01NQTFxTEhnNGR5?=
 =?utf-8?B?bjlOV0I5T2dsbFpIY2ZRY2gwQUJrek9vZ3NCN1RPMjVWQ3BXUnM5Sy9NQlVh?=
 =?utf-8?B?YTRTUDZRL3hpRktrZ2h1aDdxZFBuZVpXLzdVZnRjcWUzaEU0TnMyZlFyQllk?=
 =?utf-8?B?MFlCZHZ6Z3ZsamI5empZd2FHeWtMZWlVMDdLbDdhem10MDF6MVZYRVFwamcy?=
 =?utf-8?B?TFhLdHUxVmw5V0ZXZXU0Z00rMGcrQzZ5QTdKZXFjUEhxc0ZxUStLRTdMSUVl?=
 =?utf-8?B?ejl0S2gyTjJTWS91L1FSMmlnT1JGT3JjdHdEc3NUVGNZaVVUbkR5d3kwQWt3?=
 =?utf-8?B?bHhsaUVFUGxKUkR0NzcvNENVMWFLNWt6MEw5cTdZUTM3SUJjeU0wWHBMdkZi?=
 =?utf-8?B?eFN1RHFzNnFZRDkyNFE5ZkQrbEduWlBuajdUWlNUT3p2YXRPRDQ4MUF1NlJC?=
 =?utf-8?B?dUdyRmIxMjdvenBhSCsxdVdsYXZqT1hzTXd1Q1NXV2tTejYvTFptMitiUFVI?=
 =?utf-8?B?RkFuQ3B2Y0RQOXFyUnRhU3JwRTZzV1psc1JmKzZEZTRORkp1czl1MTVqT0VM?=
 =?utf-8?B?UDhwQWVhQVhxTEdqQnJHWDNwZFVNMHJxZEs5aWRKZ0lKUFZSSVlJR2xpWVJy?=
 =?utf-8?B?Z052Yk4wYzR1LzM2ZVA4MDhBNmxVcjg4bm9UMHF1T3BuU01nOTdXUjcyckZ6?=
 =?utf-8?B?UXprR0ordGU3MFJjYm1URktYNW1xNk53dFh2anRpVjR3RnhDbzlMUHA4RmFp?=
 =?utf-8?B?UzV3cHpKY2ZvNXFpL0JzY1Fud0VMdmQzVnNkTEk2WUJudTNVZkF4dFVjenNO?=
 =?utf-8?Q?bZeS1bVLGYXOiPmV3ZucC81OW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F52934DCA2DB0A4796C66C909ACBAAE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19055cf1-8e4e-44dd-9ad7-08de35a908ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2025 15:55:24.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyD9n7Gb1qjvNHkgXx0kZs9HCL7yIy7Hz+znBN61ZQnbHb/c7wlb6fL9983ofNlMnd7T/SKq/de3Us0QB7hH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

T24gU2F0LCAyMDI1LTEyLTA2IGF0IDEyOjQyICswMDAwLCBaaGkgV2FuZyB3cm90ZToNCj4gLcKg
wqDCoCBwdWIoY3JhdGUpIGZuIG5ldygpIC0+IFNlbGYgew0KPiArwqDCoMKgIHB1YihjcmF0ZSkg
Zm4gbmV3KHZncHVfc3VwcG9ydDogYm9vbCkgLT4gU2VsZiB7DQo+ICvCoMKgwqDCoMKgwqDCoCBs
ZXQgbnVtX2VudHJpZXMgPSBpZiB2Z3B1X3N1cHBvcnQgeyA0IH0gZWxzZSB7IDMgfTsNCg0KSW5z
dGVhZCBvZiBwYXNzaW5nIGEgYm9vbCwgYW5kIHRoZW4gaGFyZC1jb2RpbmcgdGhlIGxlbmd0aCBi
YXNlZCBvbiB0aGF0IGJvb2wgKHdoaWNoIHdvdWxkDQpyZXF1aXJlIHRoYXQgUk1TZXRTcmlvdk1v
ZGUgYWx3YXlzIGJlIHRoZSBsYXN0IGVudHJ5IGluIHRoZSBhcnJheSksIHlvdSBuZWVkIHRvIGRv
IHdoYXQgTm91dmVhdQ0KZG9lczogaWYgVkdQVSBpcyBlbmFibGVkLCB0aGVuIGR5bmFtaWNhbGx5
IGFwcGVuZCB0aGUgZW50cnkgdG8gdGhlIGFycmF5Lg0K

