Return-Path: <linux-pci+bounces-34992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E2B39BDF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C499468459
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841CE30E83A;
	Thu, 28 Aug 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qdLKR6dX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639D19ADBA
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381437; cv=fail; b=U0m4Xf0HA97PPlkWY3ljq2F4Q2DTzc2nJM2DUAm1MgApkcxSs+pJ8MRI8n5cHAAFrjJitjzPK/JilCmHW/DEUtZssfD7ag0y/rq71OOLBDJHGMA9+FkBrggL8jyMUKjJjnh5lkMyxjBxT5s6d1DmWpfH/8a7khca8DzZpUR06Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381437; c=relaxed/simple;
	bh=EFvIg2yI18ionsks+ioDjw+UjfPkP2n/VqqkwMeIOsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KLFdgxRNu63kYGH2l3NEAem+5uws3KXFm52ayhwRY+tpnl0jBmzgCErqcDOEBq3abmfbj6MDHrhkFjrWEr6A+rrQqTSZ98TAicX+7U3DnNdMCo1gGm9j4CnDmltXzeIcSFRFHGGw3E794Mg6ebFsaQqoxD/YZp8m4/T4TTXct1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qdLKR6dX; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBkFHzGY1hinVhqF+GT+IKN6qy/Ps1jmgR1HXgc3CRLTrQbnBETPFKviS6usi+0yITrC5NnUEpuw3o3KMuteFwpVqstRaw62yajjmSK9lC3XS+1r1BMrPwMvX7z75ifPo5QbTDzaC61DtkgEzuxym0Ft2PB84uDDmejEvoynGaqubaSdodegwYEg7VCkrJn4Ij81hv5uMdqmhcqBNE3Gyl1LhZImepIQ+7VU1eGDYoR0dJbt31hhBiVmEMSL4ZUiamjOFVohVBRPOgRUS0g8jMVqnDDa7TyDqfWCGpnHiVp5aqUpb16AEqyq4kUiF3dhCPhOBIi1HcTb5sHqlYF3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLyVfGDQUoy8HlGyWGFNChkK56UJ+nslzpe8RENR0uY=;
 b=eM67REM6v2kw0SSJTJkDDYFA/Xe6S8BSEuYxsObvu/PRBNeVucHw2hN/V68c2jJOeExGKS3Gh4DMvcr//kpUGHxZxZpANzpYG0I2KjsLdI/6k6mBJ7V7qHJ0c6YCWK2ZGcJ6PigP+6FZ68yYrZwrouogZr3oblKtXb9zPxvAoZjOgKGlLy9SscJb8nKwNzKnbz+mrYqIH5agPi4oPz7uXZ+qlRrFlHIrT6FDVWp3QSJ+y0AOskbP9MC68JtpDxYPXWzEwRxZfWvbjuQ5yloUuaUgEWDdeK41G5Nzwu/2yL5bOIHrxfoCG0MVmIPVbuA6U1iKKd6WZwWcZHwkAsNKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLyVfGDQUoy8HlGyWGFNChkK56UJ+nslzpe8RENR0uY=;
 b=qdLKR6dXeCrXC/WrQJHfE7l/vDQxU8Cd2B5gpAGRGJmvZsGEzoH6o9KN18za+Cyuqo7VN/WTazfdr+Psv1beXpV05xzx4HeJ4IEApzeOpbb8h89NWdI9kNOeOJNhLTqJb0WIDI2jIzTWKJ+YtE9OQui5LRCWGi7OBc6Hwl9ii2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 11:43:49 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 11:43:49 +0000
Message-ID: <b10c9456-488f-4c92-a855-f086f550d7d5@amd.com>
Date: Thu, 28 Aug 2025 21:43:41 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035126.1356683-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0061.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ce3fe9-b13b-4dd8-f8ed-08dde628278e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2N5aDk5NVIxYUNrMEdlVERrWU9DVzZ0V0k4ZUhZK0MwbEY2MXhFcWZtVVJY?=
 =?utf-8?B?a0M3YWFkMDF0NkxnVlJmWXFBaW5Vb3hDVHJYT1FFeXNWaXovRzEwMWZIcnIr?=
 =?utf-8?B?b1lTcmdaQmJYUWcyUm1PN04wdEluNTlLeVZvYitNSi9PMENDVXVWNlczb0tv?=
 =?utf-8?B?anRBQlRVVUhGdmcxUUlKUHptaHRCSmRXRFVaczZBQVpHTVRmV0kvR29BQU9U?=
 =?utf-8?B?ajB2N3kzNm4vZTBOcUUvSXFMb0NnenRFc3FPTzdmbWRjL2k0WFVmODI2ZnFh?=
 =?utf-8?B?NnQyd0piNDJoayt4MzB6WmlzMkcvTEllMXdzQ0lQMDNLd0l4WWxiNFpGdjdj?=
 =?utf-8?B?dG1NdEs0VDhrcU1RaDZRVk50ZHdxMWcvUmh5MFFRREpHY0htRkNLTnZ4OGJX?=
 =?utf-8?B?M2crR1dHRDcrRWh5WFN5UDJJcUdNdklaRklqSzVRd3h3WHYwNG5aajVMb3VE?=
 =?utf-8?B?TUpNUmpBYm9Dck9ZcnhrMk1adXljWkhTeHdIWmtqTjJpR0l2eGRadTFtaCtZ?=
 =?utf-8?B?cTNmaDhEcldPeERjRXBvNUViY3ROS1dpMng5RFdzNkJzbGtPQmJGL1pKY0w1?=
 =?utf-8?B?Y3IyNE9pQUxoelhmZmNYRmUrOVcyOWo4bFgyTXNpSzFDSE81SUhhMVF3eEJD?=
 =?utf-8?B?WXVIYU9uRUFaMVFQajV2eG5JUlpUZEpNWUZUNDROZjMxQ0RmMkRDWVdRWFRx?=
 =?utf-8?B?VlFteDlEWjc5dHRkQVpMOGFLTUpUYyt5MlcydzBhbmp2OXRTNWczSngrcHcz?=
 =?utf-8?B?L1d4NXh3YllWL0o2NWx5QjBTdHQ2Njg4NkN2aHFLWEJqanZhc01kWU5DcWFB?=
 =?utf-8?B?S0pDUllMYWNWd256OHZCeklaeDVLMGJnY2VqcUJOUjhDbDJIMHRUMjk1RVNi?=
 =?utf-8?B?TzJMalhUOWtrU2tIYnlGa3owbGVuWDhOSnJ0Z0k1TUgyWUNkS25Vb051LzZJ?=
 =?utf-8?B?UGtRdUYvN28xaFpGZlFuK0ZETmhObGV1Nkd6Zm14V3ozeDBmS21DMnZSYmVr?=
 =?utf-8?B?ODZmMTNlYk02dFlrZ1pRM211RWFPOXBRNnJDdi9tSVpZWmVIeXc1czgxa1pP?=
 =?utf-8?B?Zk9IaXkvdUtlcTdPTmVyc1lXMGE2dk81YlNNZlFrV1o2c3NCSGFycnI2RXZI?=
 =?utf-8?B?KzFRSGRJNXV5bndKTFZaQm0rMnZnS0UyS3RaOWdudGdCWS9oRE56N2h4TTFj?=
 =?utf-8?B?QXl3d2VMbjFCQnJNVm0wWnRzSlluQ1pnbVZxcktPajIwUS9Ia0VoZ29tRHRU?=
 =?utf-8?B?b1dOVVJ2ZWVmTnhQTlJBRlRmZFg3aWVNZjZXQzZFVS9IaHV5bUdwd1l4RU5r?=
 =?utf-8?B?VU8zU1NKbUNNcDNSM0xVTEg4TnFaQlNMZmNOZVdhL0xRTHJUUTlsZG96RXF1?=
 =?utf-8?B?TzN6Vlh4N25wQVQwNXJEZkttVnJ6UWJYNXJJS2IrdXpnVU1tNXhvK2pJdXcw?=
 =?utf-8?B?b3Z0VTJqRGZOdFFVR0xwSmdKR3FtU2VpWlVvOFdBTlVjNUdPQ2JJYkszSENT?=
 =?utf-8?B?UEZKU0xnZ1VNVDl3UUxoTFhCMi9DdjNPaUIrMjR4ME5kdC92VzdwZ2JOOE53?=
 =?utf-8?B?cUt2djUzNkdTZVNleXFZTnJJL2hKaEVTN09FRjhXNTFWNGtCK0pxY3JNTjN3?=
 =?utf-8?B?eGVWdnlwaE5pNXU4c0I1QnhpRWxkMG9CNW1jcGYwUUV5cit5NTFQUjRMZXdH?=
 =?utf-8?B?TUdHcW04cG4zcmhvTEpQckkyQjJzN21mWk9PQlZJM21zT3VpRi9YR3g2UzIw?=
 =?utf-8?B?ejl0QmdubkU5STlMVUc1cnVETzBuMDNhemJyQ0JNaTdPbWVVVVV6UURsUXFJ?=
 =?utf-8?B?SVZtc05MRmJPZEhyVjhPTWlMOVNjWGszeEFlUXRsMkIzZzZHOGwwRWlrT0NR?=
 =?utf-8?B?Qmd1Y0lZN1I1NEN0TmlCTXdKNXhUb3l5ZG0zaEpKcTNUQjJxODZNRkMwVktX?=
 =?utf-8?Q?mRql5JOhO68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0VhUWx4d0Q1cTBnMzBxTUV0enVHMFlTdjA2bklxVGlSZy9mMVN5U2QxZVYw?=
 =?utf-8?B?RTdXQ0NieTZHaVNFWkJmNklGejdYZ29XOTNqaUV6M3VKMXJlcFBNS2RYRlgx?=
 =?utf-8?B?MisyQ0phNFZZZ1F0VHNMK1paSlJLYUQzT0tGVXRBTkx5NnZzSmN4R212OWxu?=
 =?utf-8?B?emVyRks0UEQ2MDBmVG9oTisxMWhBcTZ1dUsrdDR3RHNzbUd3anhqa1BvOHRu?=
 =?utf-8?B?Z2ErSitEakVxVU5QM2J0b2IvSC9SdjNHN2xOMVZsS1lHbldwK1RWU29yZFB4?=
 =?utf-8?B?THAwME5uaHg3bHpwbGxJT3hnSEpyVVYraVJ3U2tseU53UGErZVArYmdVTXZ1?=
 =?utf-8?B?WnovSmF6WExrTXp4NTNPWlVST2JIWmhlWGROVld6bW1zdWtiN3BlYUN6MFJ4?=
 =?utf-8?B?RkRPN29renN0VlcrY2pIS2c0bjZmdDhIVjhOMzFMdGM0Ym92OVM0N2NEdWxS?=
 =?utf-8?B?RG82WXMxeit0L1JrMjh5QWpHV0Z0NS9UQmIzRDJzZTlXZ3BoUERyc3dKTW5L?=
 =?utf-8?B?NXRPMTFtNDFFbEE2YWxFVlF2dnl5aTFUTmpzQVFteDJVQjZ1OEJCMWZob3hC?=
 =?utf-8?B?R3BaUlM1MlpuOVBQYi9nZExIeUVsODVuSzVlS2wySldhRldMeFFoUWJSL0Rq?=
 =?utf-8?B?RzRjQTYzcFpBN2ZGRFMwZ2NqenNXWkVNSGI4N2NpeUVPZU5uRTQ1WFBDTUZo?=
 =?utf-8?B?UFBxRVdTQ05oVXpsVm9sMFYzdVVWa08zeWtaSkxYWjh0ZlZJR2wxclZwbDFh?=
 =?utf-8?B?QzJmV081V05UZC82aDNSZkQyazhEb3ZVd1hNWjJhWVd0V2VSNml5UUV0Q0Fx?=
 =?utf-8?B?MjhMWExZajFuKzlRV2ZvS0dLRDRjdDYyU0RSTUh5QmlrSlQwSTZKK1lOWjZi?=
 =?utf-8?B?ZTBhSE5TZlU4dDZTQ2dzaVpzMzU3ZUE1bDNFVG83Y1BlZWRGMDBZay9jMk1v?=
 =?utf-8?B?SGQ5T2YvMFdOU2xNUXFrZ214MUt2dFFrVW92WGVtQ0cvZGI4RUJBRllTamIz?=
 =?utf-8?B?cTRNY2R4SUpwaXg4Y3puT3dKYVFJR2hPeC9IdlNCZEo1R0t6K1pXekZTNHJW?=
 =?utf-8?B?ZE1jVUVZaHhuKzRLZkcyZklFWk1uVmw1VlA0Ny82dzAzQWNpaDRRTUtrTjBr?=
 =?utf-8?B?ZmNWdjh3R1hkSGphbmMrTC9zTlBNOTNoUVAvM1cwTUlhYlVETFBLQ0gyYUE0?=
 =?utf-8?B?RHk4YnRWcEsyNnRyVUcwNk0wR0N1Vi9pVllUWTZTdTVOc282WlR2MkRUZUZM?=
 =?utf-8?B?aHhtS01Cbi9mMzJ6V3VRb0dURElLR0tSS2JjazZ1MGZMbzA3VTNvRWFyZHgy?=
 =?utf-8?B?a0xLVnZIVUJwdFpCN2RHTFRhZWVNeTlrbnZYaENUMndPTnZoUThuaEQ1T2pQ?=
 =?utf-8?B?WTBpaXRONGE5OTlKc2lUK2xweVVCdTRCdHBodnFjeFowRUU1WWVkRzFrMm9j?=
 =?utf-8?B?Q0lsZ2J2alV4UHJRZXZTV0ZUR3d5U1BWZDZXNXZINlpOcXNJWUs5bktESXVF?=
 =?utf-8?B?T1VQbTE4VEQvci9Rc2xzMGdXT3lJRkdmZGhMVDJVQjVPMEpOS3Z4NHA0NXZL?=
 =?utf-8?B?MUhDOWdhUWpYU0Zpdkkwd1Z1WVJiWmpzT2hvbVJxZTU0QXZ2c08yNUVNcVBx?=
 =?utf-8?B?UEhLbFJTTjFlVlNXK1EwMDNXSVVJYWp0eHQ0Y3dFUldXTHh2bDJIcnJ0YVlr?=
 =?utf-8?B?bGZMZWplcmZ3MmhXTFlPcHdZVnpuL1pjRlV0bjZpZ0JscmdHZHNsTmVKZVZ6?=
 =?utf-8?B?eUR3eWF4ZFNaK3dlKytLdzU2Q0llOERnNGY2RGVVakM5cDU5alhXSFViOXJX?=
 =?utf-8?B?dWFRSXo3ZlJCa0dVMGVZbFJIZXBsYU1GU3ZtZWtYRVA1Lzk5ZWVsc1JpUXBy?=
 =?utf-8?B?OG5PUWZJWWh1My9OUzQwUXNVQ0RGcmczQzVwRDhsaHBJS2FaSVUyeUt6Q2Np?=
 =?utf-8?B?bFFDOTlmK1B4NmF0OEFaMkI1RkJHQ0VxOFhVZnQyR09MTzQ1SGROY1RrTytq?=
 =?utf-8?B?bXB2cFhuWFJOcDhGcmRYZnFJMFQreGZTZzZLeGJqMzNhYldnSEQzWVB3Q001?=
 =?utf-8?B?TkdMZjZyU0JqRTNlcW1hZUhuMHBpTGNqV0pKZHBtOFcwL1RWZHZEOGFlWWgw?=
 =?utf-8?Q?K2Czv4Qv+7D/MKGb8RywrplXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ce3fe9-b13b-4dd8-f8ed-08dde628278e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:43:49.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQRiLRTBBFXx7TtrCEpP5haCxqqoKLr5DlJTnvNysF0Pto/zXEyvJzj8wrVY13lAQfQEZpvr75R4pF51fC8xkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861



On 27/8/25 13:51, Dan Williams wrote:

[skipped]

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..e4f9ea4a54a9
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,143 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
> +
> +/*
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + *	      Provide a secure session transport for TDISP state management
> + *	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages physical link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
> +	 *	   operations
> +	 * @remove: destroy link operations context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * Context: @probe, @remove, @connect, and @disconnect run under
> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> +	 * mutual exclusion of @connect and @disconnect. @connect and
> +	 * @disconnect additionally run under the DSM lock (struct
> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);


struct pci_tsm *(*probe)(struct pci_dev *pdev, struct tsm_dev *tsm)

as otherwise there is no way to get from pci_dev to tsm_dev (which is sev_device - that thing with request/response buffers for guest requests, etc).

Or add a simple void* to tsm_register() and pci_tsm_ops::probe(). Or I can add (which way?) and maintain in my tree. Thanks,



-- 
Alexey


