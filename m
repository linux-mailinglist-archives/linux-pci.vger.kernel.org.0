Return-Path: <linux-pci+bounces-28980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A3ACE05A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5344518836D2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6B28DB78;
	Wed,  4 Jun 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vMmmm8Wc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479C28ECC6;
	Wed,  4 Jun 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047577; cv=fail; b=WJoX1fBS0gnlfh981L+w1RGflHsl2rcQk1gGWN+e5Ipx0kELQIadZvogATrIFIuH3c20E7FxUwWks1nuDSTWTx0uvOvPLv33tfIGWVXcOgxAPtKnSW1upx6mXh9qVhwLLlqJP4Vzhi4x2mT2rnK2awEnj01JsC20yil6VxLtZpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047577; c=relaxed/simple;
	bh=6Y4zNSxPCAIweP174OU7Q2KMfMV54hKzX+Nkc9ryvjI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ag/W1QQPXbwEFJZI5sSk5ILEEBV+a3TDmIoaBf9nmcmBvgvO7WNkfAqvuqJWEREvFWt854ZQi5DKFKdNpn1VFrrwwtt/9dpEWiGAFM41O4Y/Vdeef8op7HCztcxXa7Gun9I9jrVtW1sbwJ0RG7le4V5BpU8ZifyHmXfIYFzcHqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vMmmm8Wc; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjbq9/Wa09XmigcyI0Qb953Wmqd3ia/HUZVZhCZlBRxoy3IzS5j3qNXJyMNnOiVx7Cd2+ly6svmUbNSZEXm7QxfvThimlmyNFlilcJ1sUrGPmJPaCoEdya96IdPCU/ZyiBWdxghbcELewhyY0lsdB7u96ylixI3xkhkGll68QlHsQ8G8FkwkhHPEVO/SydE8hBT3XS9N3ix2ZhMJcZ0cen5ljPw2+j9HLXAB2cOTBhlq93Zh97qX7PXOMp/4b30HY/tEA2t+tfkG1ZLCaM2S5Kj1+/LU7OHcJVV/djr1gxeFKuuhH61wOiKC+1zU4wecoeQucxrpYMDivxV49vPP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BQ0l1phOzMBniDql2JX7FFy+Ahp0lK/FFbSYEUpGg=;
 b=PwXnPQNKZD4Rt0W8/bP0vtsw+nSlwaZd72cgP8+BVfHEOvQzKP3S/ecOVeVKpFqNrSzai6J2XbypCMe8BKh8qmZJC4llCZ5djduLLorK+ljZmPEpryaT4TX14QIQ2kAULs628N3G2rntb9p8nZvTppHIWuYSsJQTrh/LBJY/n/k61tV0JATnL8dkiun/9nyR4KMLs5EVgqpC0xp1VpPtkuN4myCLsVFLQ5f5q4ds6CgLkNjZvEGOHDSouTXtEcVw12Js/trSviPh1YBewd3Z6JbuwWPQcTAoJRTonVZloWDJ3l2B2LIDmh6Q7+tEI1l1z9S3w6uPqDEe+yfXtHpRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BQ0l1phOzMBniDql2JX7FFy+Ahp0lK/FFbSYEUpGg=;
 b=vMmmm8WcUQGBMUuc2hDUqHV4JBXtGNLeEroC9sco8c/wxT1ZQv/D0rB9YO/jHCKWKqgtvdHIEXZnpNjepBGrUPtBFqYRkAXPAR3DUP5mGr2iZnJ/vj87z8GiO675dvU2vNQg7VZj82Ca3xNjNYdf0RWAKd85okBGJDRBZ7X2SK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Wed, 4 Jun 2025 14:32:52 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:32:52 +0000
Message-ID: <7d9030bf-8d27-4c9e-b995-89ce1a63dd6c@amd.com>
Date: Wed, 4 Jun 2025 09:32:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/16] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-3-terry.bowman@amd.com>
 <0619c83f-84d9-4dcd-866d-d6df1da4d1c9@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <0619c83f-84d9-4dcd-866d-d6df1da4d1c9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0439.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 363e552e-f4af-439f-cae7-08dda374afb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXJHNmVadTQ3WURmME1hWXpJbDRYdU9CbEZEVWdaQWErMm5iQXRjMGYvSkxN?=
 =?utf-8?B?TUZGM0Q5ck1UcDgwdllRR1hHVVZXQVVHWkpkdmVqZEhYZUd2ekJqR3Yra0lZ?=
 =?utf-8?B?cDE1QWtOcG1kQUpmcStmUDR6NGw5Vk41QkpvR3ZzdXEwdXAxR1R1Y0VnZVQw?=
 =?utf-8?B?WktyWDdGQnpDY2V1bUtUaUxjRjBQbE9BdG80MTEvRVVKSEQ4RTdNWTJvaDNG?=
 =?utf-8?B?NVJja2dET2JZV2dNWTEreklKQmY3RzlITmF3a2FzcXRBZ0IvOGJIeHNyVkRV?=
 =?utf-8?B?VDZWd2RjQXFSNUpObTUxU3p1UDN0QmxsVXhYZE5oV1dpREk2MXRUTWNWcWZC?=
 =?utf-8?B?UUZ2TjZKQXNMdnBMN252RHp0SHdPWGQ2aEpGQWRpRHJTVDJSd3VtVGhZQzU4?=
 =?utf-8?B?M0dLK3ZhNHdONkZDQnZzWVNHQmh4QkllNEpLZm5seHRNdjJJaG8vd2tyL0s1?=
 =?utf-8?B?WElvSXQzRTJ2NTdTbGt5TWVFOTVGYmhDdFBnalpHNnlUcklBZUU3aXZWUy83?=
 =?utf-8?B?d1JLdjZ6YytlaktrOVRJcFpSRUZuY0xPTDloWlVPU1hJdm0zV1c1a3ZTL0c5?=
 =?utf-8?B?cXMzZHlqbDRWWXJEbDZzYm5GSUxWaWVDRWxzUllVa3RYV2ZNNEJPK1VQWjdI?=
 =?utf-8?B?MjJ2RVRhZHRmSDU0bkExanNTUUU0Ym9Fd2RoMWs3VzRIek5WdnB3WGFCdnA4?=
 =?utf-8?B?WTNETmNhbWRnYzRUcFRkSUlyTzR6UDlmN1VveElsQzdXVnNJR3JHdHdXcmZF?=
 =?utf-8?B?c0g0alAxaE0xVzNyQ3VFV2ZDM2FNM2lhUysxM3hGRmJZaGRLdmdBZXpMYW1D?=
 =?utf-8?B?M0huOFlIWGxKRTVrWXlMK1RuU1M2YXdMcUg1ZDFVSEhFQXRSYXZYTzg5bUVL?=
 =?utf-8?B?YlZpT05Pdko0SlNRUDRyWWZnbllWODVXeTdabEhENU9EcnBhcmxwZ05oS29a?=
 =?utf-8?B?TVRmc3lFTlNDMVJkbXVGR2tkLzFLWEZWTWtBUjVLSmVkdC9ZR0R3cnNFd3VT?=
 =?utf-8?B?ajJKWlRkZ3Nxc05SdVdobC9LOFoyY2NGKzZ4UFEvVGJrQmhveHVoNVRCQk9r?=
 =?utf-8?B?dEY0SE9NT3pqazlXeFhaUEFTak4ycEJNT0hVMVBRa2p3U2dIcGFDOERWM285?=
 =?utf-8?B?QkE5OTZRNC9iUVlDTVhnRFFKeFUvemxYQkZ0MkxqVVArUTM4NEloVGp2Yyth?=
 =?utf-8?B?UnoyTVpxdk1CUnJTSnFoSWVwaEZvWHArejQ2UUhLak5Ma1M0REZYamlDcnEw?=
 =?utf-8?B?S1RNSE1UVGVuc0M1c0poNU95Q3hjdExxMkc2bVRlREV1K0RVdkVuWXV3enMy?=
 =?utf-8?B?N1RPMjIwTjdzOEhyaGc0OEdNYTZlbnJwTkxaUWVnLzJ0T1I2b1M3QTdET0Mx?=
 =?utf-8?B?UzBiYm5WNzE1TGNxVXRSVTRxdDFUODVPMmlycTV2d3NsdC85VEtvcnozQ2NJ?=
 =?utf-8?B?Q2o1eWFZck4yNlJZZnpzb3piaUFxdkpjQW5aS0ZYRkFQYjZXdnRZczJmYytv?=
 =?utf-8?B?cVRmMEtGUzVaYTQ0cU9YWWRDZm9MMlg5enFxYlhOV3ZHZkNQZG5SMHdWL1k0?=
 =?utf-8?B?bXo2akRkcUtlc3pxNm5jMC95YktnbmRSZjFNVHRZdzBCYWwyV0FEcWFtL1Rt?=
 =?utf-8?B?YXg3SDF2UkkwVVM0Q3VybEdsM0tUdG5adVlFdFJYbFQxOUZSeWxrSVlpK2Jn?=
 =?utf-8?B?NStjS3BCTEoyMmxTdy9rQU1jWmZ1V3ppY2U0Sk1JdkFXT1VRSEpRdmlDU2d6?=
 =?utf-8?B?ajhFY2xmclp5QXhUQ04xYlk5bjNHZ3Fya1VGOHZDM1lFSnFVM3JiRUZuL05j?=
 =?utf-8?B?akIvY3FMR2ZaOXBjRU4zcVppNS9Sb002dTQyUFlkTFpKU1Nad2RHdWM1Mm04?=
 =?utf-8?B?ZGVySW8yNWJ3Rk5uOTFIQm1zWDNsNi9EMkxjMmtTdmVZMnFvUTJISUJOeGdp?=
 =?utf-8?B?aVhOQXZoLzY1Q0JLWGx6Vlh4R3h2NXdxckthVjRJUzQramhrbzZLeWx4Z3Vl?=
 =?utf-8?B?UHpXQ1RHZkFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJ1aHorUC9ybDMvTVVaTElCbEVQaEVXQ1BmR0FTUzUxekZyNE95dUEycW81?=
 =?utf-8?B?WG82MkFsOE8rcGhIRWlwdkhoelowalZpb3hCMkVDMnlFQW9nUmxSbGVLN1RL?=
 =?utf-8?B?Ujk5T2dqQVZhN2syR1hxUEhEbFZ3VU1RMEZoaFRGV2N0MUZ5dVQxcWpxc29K?=
 =?utf-8?B?WXl0TTJWMTJqWWZLc1hXNC9DTGVpOUs4c1BKZnIyNEhjMEcrNzAwSktNYkxT?=
 =?utf-8?B?NmM5dzJZdCtleldqcTFlZlFTcEo1S1FDb21aQUd1a2t3TUgzUmRTa0xJTVJJ?=
 =?utf-8?B?eUVVbi9qT1pPKytpTEd3UTB6bVY0Uml0b0pWQmhROStwMzdaTDdVRDMwVFYw?=
 =?utf-8?B?aTZaVldMcnVQcDl2SVVDWnJiaGowa0QwTWIvdUo3NmRFNE5DZldpQUNBSDJU?=
 =?utf-8?B?VnY3R0RZd1NxWHhkMnJEWFpLajBPVlZoSGFTK1pnd0dCSytER3pkU2NQODdU?=
 =?utf-8?B?MkFmbGlrQWs2QTVtWUxZUklFWk1vTDhqZFhOdnNtRzZrYlFLZGJHR0Y5SVp5?=
 =?utf-8?B?dXBobHhlZ0xYR0ZOTFg4WGsvSnRhRG05NWlQcE5jVnNlRVRrWmxIRERnVVVw?=
 =?utf-8?B?VmhNcFloeFFqM2hSdzJ1enFBYmVRL1Q4NlE1K2RvNUdYdVNmUTdtSDJaWFA1?=
 =?utf-8?B?dkZLRVVCMkROcVZzQ1lIUm5zbjhKVnpZLzN0cktZUHBpbGRNRlpIS0Zwcmoy?=
 =?utf-8?B?ekNLV3JJZXp0bTBqeGcyRlBoU21ybHZVbGRDL1U3OUo2emhYaGlFc3RkMlRs?=
 =?utf-8?B?UmlTdGJldUd3L2ZTTlhZbFNSbTlwK29rRWpHbHJHWGI4cTh2eGdXREZzcUxV?=
 =?utf-8?B?bmxSaHlZbVpLRzZaWDduYWtWdEJ1emhoNVVNYkhTRDZiTVM2YWFLVXJHTEJY?=
 =?utf-8?B?dzRwa1BPOStlZ3VBdzJpdFhuanhqK0J1UXd2UXZlUzVNYTVsQzJSQnRLdC8z?=
 =?utf-8?B?RDhnQmxaUHE5MlQvZ1VpVmVjbnFrdlNEWmpuUmZ6OXF6U2xxS3hFdGh0cjlz?=
 =?utf-8?B?SVQycjhMY0dBclo1K3hhOGNaKzBnMVdpbFF1NmtJK0hyS0ZIS0VrYmJCYlZv?=
 =?utf-8?B?Q2hmRENSTFJKdkhhdTY3djY1ZC9XSGpLUEx2bldOdFZ4VVBFLy80R1hCY2R2?=
 =?utf-8?B?dk5JYm5tT0JvSHhraldPa3hiaTc2c2Y0MTg1MUZNMnE3aUZDTVNEL1lQRjRu?=
 =?utf-8?B?OUw2Um1oTHd1L1JVcUEyUUJrSjNWcVExUTBTUHJ4dFArcThtNnI3NXd4Wlcw?=
 =?utf-8?B?NTlnNGNhRjdhcDZxWHBGY01iQ2VxZ1lZQVNjdm1UNzFsN044MVdDdHhldjFZ?=
 =?utf-8?B?L29FdXVKNGl6ckx1K0JYRFNNY1V6bzRwSEZkdjE0T0MvcHVHczlKTmZKMDRZ?=
 =?utf-8?B?THZ5Z3lQUm9HVGZydnk5NXVXdGtGZVdlYTI3d1M0ZE00a2RNczBBQ0pKeXky?=
 =?utf-8?B?dStsSy9xV2ZTdVhDNXl6YlhBbjlZVFBnSlYxYmNQamh4blZpSWo0YTBWejhs?=
 =?utf-8?B?dXB5Ui9MRGQ0dGROem1rdlJXTEd4a3E1dm1QejU4cG5UVkdxNUZwVXRhc25G?=
 =?utf-8?B?Q1dqQXJ3Y0ZacGFkNm9aRjVNUEFiZVIrd1FmdGZTSWVlODRCNU9wRzI3aHJ0?=
 =?utf-8?B?a0dSZEZBWkRqL3U0S1h4bUlnVWtaMVk4UUdpU2RETjFITytiMVpodXg2b1hI?=
 =?utf-8?B?WHdaN216Ny9pclNQcWhyallmWENRL1VqclhRQ09aUVNsMUpUUTM2YkVCYVVu?=
 =?utf-8?B?QUw2Zk1MaDcvc0dBY3A1c0VhN09MUWZWS1JpUk1hWWcxL3piRXpMSlNkTStB?=
 =?utf-8?B?dG0yd091bFRIMXJWcEw3R1BycXlTQ0VmcWZRM0xEbTdBSE4wYWhhNVFUNUwx?=
 =?utf-8?B?S0ZObjRjU295aXpKNGIvMGNLZXlYSjVsYUo0ZEJXaHNoa3hKZXBOYUF6b21y?=
 =?utf-8?B?WDlYb2hkZllSVkZMc2xEN0NXb1VORERmMUswTERicThmc25CSHRPUjExMm1r?=
 =?utf-8?B?SnJ3R0NKUCt5bnpESC9QK0lZR0xqdWtpcHNFTlR0ckV0dFdPQldYbUdrQjN5?=
 =?utf-8?B?b004K1JuaUZxMDhydFY2ZUc3bmxkMTQ0MTZTR2MxRzdYZlFTM24rRFVRN3VO?=
 =?utf-8?Q?OerIg8EogfU8QMkhcps5Qym67?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363e552e-f4af-439f-cae7-08dda374afb9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:32:51.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+y88s84Qd3RBooE/Twolr8DWXy/ovnt0MqhRWuECLACFUV/RF23obg/E0Mu9WN0mZlNYEIeIMnJxv0aPP/Cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348



On 6/3/2025 5:02 PM, Sathyanarayanan Kuppuswamy wrote:
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>> Type' for CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and
>> CXL errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>   drivers/pci/pci.h       |  6 ++++++
>>   drivers/pci/pcie/aer.c  | 18 ++++++++++++------
>>   include/ras/ras_event.h |  9 ++++++---
>>   3 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index b81e99cd4b62..d6296500b004 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>>   struct aer_err_info {
>>   	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>>   	int error_dev_num;
>> +	bool is_cxl;
> Do you really need this member ? Why not just use pcie_is_cxl() in aer_err_bus()?

This was added per Dan's request instead of using pcie_is_cxl().[1]

[1] https://lore.kernel.org/linux-cxl/67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch/

-Terry

>>   
>>   	unsigned int id:16;
>>   
>> @@ -604,6 +605,11 @@ struct aer_err_info {
>>   	struct pcie_tlp_log tlp;	/* TLP Header */
>>   };
>>   
>> +static inline const char *aer_err_bus(struct aer_err_info *info)
>> +{
>> +	return info->is_cxl ? "CXL" : "PCIe";
>> +}
>> +
>>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>>   
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a1cf8c7ef628..adb4b1123b9b 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -698,13 +698,14 @@ static void __aer_print_error(struct pci_dev *dev,
>>   
>>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>   {
>> +	const char *bus_type = aer_err_bus(info);
>>   	int layer, agent;
>>   	int id = pci_dev_id(dev);
>>   	const char *level;
>>   
>>   	if (!info->status) {
>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> -			aer_error_severity_string[info->severity]);
>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> +			bus_type, aer_error_severity_string[info->severity]);
>>   		goto out;
>>   	}
>>   
>> @@ -713,8 +714,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>   
>>   	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>>   
>> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>> -		   aer_error_severity_string[info->severity],
>> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>> +		   bus_type, aer_error_severity_string[info->severity],
>>   		   aer_error_layer[layer], aer_agent_string[agent]);
>>   
>>   	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>> @@ -729,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>   	if (info->id && info->error_dev_num > 1 && info->id == id)
>>   		pci_err(dev, "  Error of this Agent is reported first\n");
>>   
>> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>>   			info->severity, info->tlp_header_valid, &info->tlp);
>>   }
>>   
>> @@ -763,6 +764,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   		   struct aer_capability_regs *aer)
>>   {
>> +	const char *bus_type;
>>   	int layer, agent, tlp_header_valid = 0;
>>   	u32 status, mask;
>>   	struct aer_err_info info;
>> @@ -784,6 +786,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   	info.status = status;
>>   	info.mask = mask;
>>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>> +	info.is_cxl = pcie_is_cxl(dev);
>> +
>> +	bus_type = aer_err_bus(&info);
>>   
>>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>>   	__aer_print_error(dev, &info);
>> @@ -797,7 +802,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   	if (tlp_header_valid)
>>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>>   
>> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>>   			aer_severity, tlp_header_valid, &aer->header_log);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>> @@ -1215,6 +1220,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>   	/* Must reset in this function */
>>   	info->status = 0;
>>   	info->tlp_header_valid = 0;
>> +	info->is_cxl = pcie_is_cxl(dev);
>>   
>>   	/* The device might not support AER */
>>   	if (!aer)
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 14c9f943d53f..080829d59c36 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>   
>>   TRACE_EVENT(aer_event,
>>   	TP_PROTO(const char *dev_name,
>> +		 const char *bus_type,
>>   		 const u32 status,
>>   		 const u8 severity,
>>   		 const u8 tlp_header_valid,
>>   		 struct pcie_tlp_log *tlp),
>>   
>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>   
>>   	TP_STRUCT__entry(
>>   		__string(	dev_name,	dev_name	)
>> +		__string(	bus_type,	bus_type	)
>>   		__field(	u32,		status		)
>>   		__field(	u8,		severity	)
>>   		__field(	u8, 		tlp_header_valid)
>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>   
>>   	TP_fast_assign(
>>   		__assign_str(dev_name);
>> +		__assign_str(bus_type);
>>   		__entry->status		= status;
>>   		__entry->severity	= severity;
>>   		__entry->tlp_header_valid = tlp_header_valid;
>> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>>   		}
>>   	),
>>   
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>> -		__get_str(dev_name),
>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>> +		__get_str(dev_name), __get_str(bus_type),
>>   		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>   			__entry->severity == AER_FATAL ?
>>   			"Fatal" : "Uncorrected, non-fatal",


