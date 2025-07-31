Return-Path: <linux-pci+bounces-33231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC509B17075
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04894565CA0
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4982BE059;
	Thu, 31 Jul 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWj8Z+bd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC82C9A;
	Thu, 31 Jul 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961961; cv=fail; b=mTwPlmGyvEJ5nkLlYVrg6mE1qcc16Bb2irNE/WqkLKqQAxwhQF4PBnfbtWONUNdN1lSuQHiLWfTYTWcsKOOGAwC3vUIWG4hvo9D5tOGGsQKLz1w+i+74uTtVR4R3zT+bhuex9zilGoyQDcNi2kCBt/GDcnbZBnBumeOyZnyw4hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961961; c=relaxed/simple;
	bh=4dQCT0IOfSvhhKvN+n0UTkUo/TZ90Muam1ODuYAm12Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WzLn/NbVplKJlcSgza6zGQrXu74wc5N0a2sv41gFhsPLpTHVRdvk+tgsjn1l8HKG0Qd2rRSSOdcw/nQIqVCd86A/lxWgCvZx6RvyMB8rikGq5spQaZPhllwlIX2z4bMShx2BPC8FmSgO4FNDCdNq8Vq1D69JAcIJmzl9tcY0/bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWj8Z+bd; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFuhoE1aZ53HqEnEPcCWjKWRsPlri6Twy4+E3AQbEJu2QAYFKcrVj6JTeuBjL0BxszqTYr/uQaUtdPgpVrv9psK2Dpo0ThyrTM1j0LqOut57xNG0au8FYZf8sXR+qF6GIEpx4XowGGcrcQxRAcVNmr1om7KpbRD/SUUERRc4tYFs/2gn0nRkYBm5NFw+rBGY02L2K7tOLkT0JCLA7SUElh2u0Uk8n1Ny+jJu4belcDpQ/W0j455kdRsonmmvOhwc1yD06/jVa3BkGfwWGToWgTXRoelAUNTEUKolp+aFujc8oMwAiekQ9gZHSxP5AW/WR5FjqZzMmNsUR3ARNv8aFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vePVj78v5woyhO3VDd45kppx9WRtxYTk+642hxzs0g=;
 b=SyAhCinrQ3/aH3e60NkJXrQyoKZ6RymGhPDeC/fink2tHmS9eyzEjWdbqtiXTYqeV6u2HAcv/UClkxCKTEiB/9sz8J7Vs+b8ZhWGS1ZWhyqQvt35Arkkz7pD5bUBDHBKvdcYi4cWhj/egCqaa/JcPL3aHBPWF19kTAOnr4smwU+gv+5nuqdqR0ha+6lfkRK2bglQXXt+gj6VDb497vCtlt0Evis6yBqGJ6K4pC13Yaygl3boi7FIfE2P9YuEEHnBlLsddvphdY/bYAG2MCDo1QNosUzjuFinJnaHe7hMNVJUbksN9XWrfEt8jL76mvNXLH7btry7cH/ZmBDkgEpYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vePVj78v5woyhO3VDd45kppx9WRtxYTk+642hxzs0g=;
 b=bWj8Z+bdv1w08sq/9gsIK6cfdSbYYX8Au3FF2/c5FhnCF36ff+Lm/8WfFsruvJ/CVxAm/kU9krn4zBmXnqp1F4WPqa4BDl/3YiZ7BlXlEfgHPcLAEvsdF8kjCw/Uitj68uXbgqxQs2BNTToJYngKz6c78DX+JCOY1dJC1Tx/ldfnD/cWHru0eIzIIXROVwBz0gvsKXZfMDHz2EVtLeVYuGj1sI7O1MSL5LZqzVhIuHEgAFoc1+/GuPtIot4bQBy0jXFNOQ/3F/zJJFWMSkRaq08oNln1OXmvkUZaC9nN0UwQZQ1626DFCFtklKUkKWMJbNNDjnCRm8AZnrjIFqUp2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Thu, 31 Jul
 2025 11:39:16 +0000
Received: from DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003]) by DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 11:39:16 +0000
Message-ID: <d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com>
Date: Thu, 31 Jul 2025 14:39:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
 lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev, linux-coco@lists.linux.dev
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-35-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Arto Merilainen <amerilainen@nvidia.com>
In-Reply-To: <20250728135216.48084-35-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To DM4PR12MB5391.namprd12.prod.outlook.com
 (2603:10b6:5:39a::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 12232d1b-1bad-485d-29af-08ddd026e0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjNVaHorK2VOSzlFWGljTitpUjdZeUFRU3hJTk05UmdmaVpXSC8xbk5qSkNh?=
 =?utf-8?B?R0U3WjhXS1dZRDFockhtWXZsWE1rUWZnQXN5M3BVTzNpNjFudkxTNkRDNjFV?=
 =?utf-8?B?RFRBL0tSbGRnaWNidWxQOW9pdUVEOHhNUUtlV2ROU2JoY2dhYjl2a2ZFT2U1?=
 =?utf-8?B?b2YyS0V2VzVmaVV4Um9vbWVJVGl0eG1CWG5PclRvTVJVZURlY3UwU2gvS3gy?=
 =?utf-8?B?MzU2ZzhNS2RUVVdaQVNmYnovbXZmbXRDRW1uZmZodnkvemdXcllZSGNNMnlW?=
 =?utf-8?B?cmRuRmgzQndTTDJGdUZmTUdZRU1YbGZia2FUeWg0d1JJZzhRWGkzOXJXdDlS?=
 =?utf-8?B?VUdqYjVCSG81N2MyZlRXcTZHQTFGTXg5Qm5lUktZK0dKWnF5TnUzN3BCWXB6?=
 =?utf-8?B?eHcxK3hPUzNSdjVzS3RmMkdPTWNiU0JHcFZLaEU1OFgyeVNEYk0xQ2RqY3or?=
 =?utf-8?B?KzJFMkw1cG1MV0NDWE8rSHJ4UW9CSnRtbkVRdGhudDlSNmxISzNRdVJnS2R5?=
 =?utf-8?B?SG14Q0lmaTdwOWVYR3JOS2YweXpJSTZ4aU4yTlE4TDZCa01iK1liMFdUWVhF?=
 =?utf-8?B?RURoOFNMQnJ6c3JJcWR6cW5SUGdkV3NkcCtiQnN6M1BMdWRraDY3VkZBa0Rs?=
 =?utf-8?B?amF3NzJFVi9sdHc4elp5bkxlZWVCVXZpdkNEQzZqbXc2RHdpVmUvTjYrSjRB?=
 =?utf-8?B?YTBhVlIyckFKbTdraCtqMHlEa0JJaVZ1TjJLc0FaQk9IZkcvNFdvaVRNODJy?=
 =?utf-8?B?dmFMVkJzeFZIdTlDOFNjWlZRaTU3Nll3aHJLbW0wSHFqU2wrUGdzcEVIWmFx?=
 =?utf-8?B?ZE1MMlp5cTdDaWN1Q0FuajBWd1FONDludkUxdFM1QWtrOHBCSzREZXpwTjhX?=
 =?utf-8?B?YUp5ek5UVHR3Y1EvUHg1QjJRRU4xTEJRNEtXVEdyK3hnSVVpNDAzTWFhc0lS?=
 =?utf-8?B?TXZXTWlDUmdoU3dndm5ZMkwxM0hsVFlhZnFaUm1sWEQzY3NEVE9CZzR3MHZq?=
 =?utf-8?B?QXVCU05HNFdaVEQ2TU04L2hMZ28zbXFKdGtYcXFZb0dtRWpHejFBMzR5K0Vk?=
 =?utf-8?B?ditDcy9UdzBERFA2TEFuVGRMaGg5NVFyVXRFVVBrZjZOWHo0UlRqUWpMeUhr?=
 =?utf-8?B?Q2FSYzB3WVJHRUR5c2NyOUxSUEROb2dnUWZsN1F6K2Q5elljN1RFYmdiWSs0?=
 =?utf-8?B?ZkwxOG9LN3NSN25LbTRhVWFLQnZUM3J4ZWd2MWNQa1BqYjFZOUwxQWQySS9o?=
 =?utf-8?B?MzRwRnNJSnlDcEJQdTd1MEMxUWgvVm9kUi96VTJmRXpLSzZ5SHdHZkI5bUN1?=
 =?utf-8?B?eVRHaHJva2ZIa1NEamlRZ1llbWUyVll1REY3cG1nZUcycnk3djUzVkJGa0hU?=
 =?utf-8?B?anNIaVV2ZVJNdTl1K0diOHh2NERHMFpSS0srRWVaZ3p1M3NTN3dVR05zWjJr?=
 =?utf-8?B?VlJacS93b3lzWW9XWE5EN1NjeHBqMWtPSGpCQXMyQnpJU1RVczJ0SHFBY3Zu?=
 =?utf-8?B?MU5MSkt3NW9zM0hqS1VPRktvZS80aGVEck0xN3ZmSGE3ek80M3hLVzlGL0pa?=
 =?utf-8?B?bUoyVGh1WnRIM296akIxNk01V2w2T3pJWWpLWFhCNVJrNXAyRjlPN0FkZGRa?=
 =?utf-8?B?T1JkQjhkNnZyRUlLNnFXbDBYYmkwdnZFT09EY2xJbWNFYlhvdzRreDhXOHVD?=
 =?utf-8?B?Mjl5bm5MQ2RTNzVYVTdPbmZGK21RWHlJcnFIenZqQll4d29HckJxc3kzbGwv?=
 =?utf-8?B?S0lpWGNpVlNhdGpER2NtMnB4ZDlpWklVQUhnMEh0dml6K0daSHUxUWZWcnY2?=
 =?utf-8?B?eEJSa3p3TFpLS2RXVnAyeSs5MUVSVHFudUxLVkNTNGF0MEZ4Z05za0tuK3No?=
 =?utf-8?B?TFlPZHVqVnR3cUZ3UnJYRWhoeUxXc3ZiM2xPVGpneXNlQzBKRDh0bUNhSElP?=
 =?utf-8?Q?zBx18Z8A1zc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXMybk15ckFUbXJxcVF6VzZ3YllVU2MrTzhubGs1TVV0N0xPZmN6Z3pLVkhJ?=
 =?utf-8?B?dER2NzhmK0o0TTVCd2wwZ2g3TVZkc1l2elBaSi8rZHJLM2tDM2hxWE5aYnZG?=
 =?utf-8?B?UTJOV0NJcitnT1FiamoyQ0YyMzlVQ0RkZHJnRWFYcnlWRHg0Yks1QUVYVnpT?=
 =?utf-8?B?emVtczNmZDFZN1JaTURSVzQ4dnA1TzF2VFU3T0JhSEdJeXhSYnp0bmVLUENB?=
 =?utf-8?B?Q3Q3ZVowUXJ3RUZwaFhUMFk4ZTdHUzg2M3V4Tk9sWEorUzFabzBPeCtVdktz?=
 =?utf-8?B?T2N0RjRNS2tibTZJcUVmUHVVZ25Ud1hudzFXYkRDK2krQ2ZaSGE5Z3FmOHVK?=
 =?utf-8?B?SGd1dVRicXVXYlQvVWhwVmRkOXRhdjR1WnU5K1FtTmw0VW1YanVTaThiajNs?=
 =?utf-8?B?ektwd2lCeVFJTzg3aU5JRzlqN1dRangvb1dwZi80SUp4R3pUanlhdUs1eW9i?=
 =?utf-8?B?Q3FadlE2c2hRcmphNXZSakFLRFhZczJlRkZIbDdpNU5EOC91azVTY2tONFJV?=
 =?utf-8?B?c2ZmR1ZjQkloelVYZGovcVg1eWwxZ1ViblNCcUFRU2JkZWxNeDhRNGdnMUpU?=
 =?utf-8?B?VjF3N29nVHEwd0daM0ZSM2pUZ1VGK1dUTGU2K1BZZEllN2kxSGdnTFptVkpU?=
 =?utf-8?B?TlNWdnRrc3NFM1V5bTdzbXlkVkxHQ3YzTC9oWDZlTUlMU3BCTXVVYXM2YVdW?=
 =?utf-8?B?eU5udUNyL21HRGZDMXRpQUZLYi9Qakc2VnV0TWxTd2wwaXowL0dxSGpibkhR?=
 =?utf-8?B?bDhJYVRnd2lHa3dIZGdpeDdxMlJUM1loZzBSWjhnZXNpWlFRSi9nZmhGSzdt?=
 =?utf-8?B?VU45VXYveW9ybzBzWmhqV3dyZmJCclhCQzBlTldYc2RmTnR0WTZKSjRhRlRw?=
 =?utf-8?B?TFllb2IzUlRwREw0UlNOajZ0Q0oxSjEyRmE5bWpsWEpmSHJucE42UGJYaEl3?=
 =?utf-8?B?c0JmYkE2djdUaHhjK0RLTG56U0lBUldxclhxL01sWk0ybkhFUElGV00zUHN5?=
 =?utf-8?B?RGRkTFNteG5aS0lqZWh0S3pwWUxQMUs4U1kvWXZlWVBuL0ZhbU91VnVsc04y?=
 =?utf-8?B?V2hrLzlIUVY2VnU1T21CdkRDVnlhNHBNZklhdE8zeXFCcm9GZHozc1QzbmZ6?=
 =?utf-8?B?VnBrcVJtZjRzcktRTXF0dVZMb2FrZUFYTnBmM3VLcERQczFCSWdQeXV6Q2Y3?=
 =?utf-8?B?SUg2Q3lZdFJXWHgyam95dzEreGxTcjNLbUNDbUdiM2ZkWENCdGlSQktYUkx4?=
 =?utf-8?B?LzRVZW1jdjY2OUt4NDg5bk5SMytIb3JXUDh5MGtBUm5YTStzR282bHM0eG91?=
 =?utf-8?B?bVJMTWt3SGZETFRKWTN3VjIrMFo1TzNzVzF1NTgwaGtac3J2WEV3M2RFZm1K?=
 =?utf-8?B?V1BBWEFGS2dva2tsSzU4NW9UeVdpQkZ4RnpKS2w4Zy9LZlFUaU45N3ErYWxF?=
 =?utf-8?B?QnZuTGRRcDJydTYxU1FEM0ZkZHBLK2FKdndCZFQyNlpsY2s2ZSs5d1dWRlRs?=
 =?utf-8?B?R09RelhXcmF2QndXTEJiRVF0T0hqbFhPMXJnNkxkcUIwMHAyYytpUXJzTlJ6?=
 =?utf-8?B?N3BHYTBzTWxBKzcwMzBSZDAwTmxaUkx0ZW93akY0aUVIcWRQb2htOXkvZnRU?=
 =?utf-8?B?N0QzUE1ka21WUHBoZjZQQlBwSUZDUXg1bjBHK2V4MGFhT2VCZXBxdUh4aUR1?=
 =?utf-8?B?WDNvUFlaZjlrK2ZkdWtZQ0xzSnJ1L0l5Y3FCdkMrRnBianRJUW5SVmdrU3Rl?=
 =?utf-8?B?VCtKeUtKK3VBaTJZVmZyMGlSY1c4b25LZXRsOSs0b1NUL2VYeWhoWk1zZytK?=
 =?utf-8?B?bVo3OE1HV3pKUXI2N1hvcjRaTnduRWZmdHoyUVNpYi9HYlVMa0dCOTZwOEZH?=
 =?utf-8?B?QlA0dVd6dGJwLzVTUjZ6ZFVQaFBmYnhURzd2djBNLzVSZWVQWTVnc0RBb2hB?=
 =?utf-8?B?T0FocFB2VS9BL0pESlVIWUJPNThKMG5WaDBqN3o4UG1LVlJnVzlZOXZTZDRi?=
 =?utf-8?B?aDFscjRFaS9hbHJ2ZkUyTEVnN1RKbitENXN1eCtscEVMSU1LSEJiU3lhSWNy?=
 =?utf-8?B?UFo2cWd4NC9nSHcwbEkvdWxoUWk4QW52dklCeHhrUi9WUVg0RWlZMmFhNzVQ?=
 =?utf-8?Q?MYfA364iVd5pkRh8hgg1HdcSW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12232d1b-1bad-485d-29af-08ddd026e0b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 11:39:15.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNgmmDdxbGcTwkKhjfMHLx5V0qBbUJ6rHNxuhK2pBYquq1UkUNf6+DmwZbcoNZaNGlauj7ethu05pHErhI0kjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

On 28.7.2025 16.52, Aneesh Kumar K.V (Arm) wrote:

> +	for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
> +
> +		/*FIXME!! units in 4K size*/
> +		range_id = FIELD_GET(TSM_INTF_REPORT_MMIO_RANGE_ID, mmio_range->range_attributes);
> +
> +		/* no secure interrupts */
> +		if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
> +			pr_info("Skipping misx table\n");
> +			continue;
> +		}
> +
> +		if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
> +			pr_info("Skipping misx pba\n");
> +			continue;
> +		}
> +


MSI-X and PBA can be placed to a BAR that has other registers as well. 
While the PCIe specification recommends BAR-level isolation for MSI-X 
structures, it is not mandated. It is enough to have sufficient 
isolation within the BAR. Therefore, skipping the MSI-X and PBA BARs 
altogether may leave registers unintentionally mapped via unprotected 
IPA when they should have been mapped via protected IPA.

Instead of skipping the whole BAR, would it make sense to determine
where the MSI-X related regions reside, and skip validation only from 
these regions?

- R2

