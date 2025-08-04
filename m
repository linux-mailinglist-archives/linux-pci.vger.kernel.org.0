Return-Path: <linux-pci+bounces-33339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0EEB19A3A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5ED18945FC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAA2153FB;
	Mon,  4 Aug 2025 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SVcmb0tK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263119F11E;
	Mon,  4 Aug 2025 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754274758; cv=fail; b=fEiGdae04QffN3YOE6MOJxgYsWohlnp2nLMukbFQTglBEZOcoI8tAKLdPlc17UsqPskvTsXwu93O2M/3AhbqGTA9FsGHoUOZuzoDqbVBRD1tTHXCe4DnbojyYKsQQ5jIPcStXM2zLl/k1vUQ8HH62Y4BiA5JtMGXJovVq88vLBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754274758; c=relaxed/simple;
	bh=jvOvq0OxsgyE+mYobpg4J7knqLKoDXOuVKgEHdCxbb0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBSLJnsMnYNfCrBxEOlKtzp/Nn+kXUws0BBh9L5oo4bTq6Ep5PeurtjUjs4x330i7BS7MNER2S27QpVRz2ONBLhASt+1wvbfHl+6uKlFpDqVImi5cnEPpdF245dxnoEZGNpnRp/bnMcH+gtxzAtXBJBSI/GxaQVq1d1MYAZfD6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SVcmb0tK; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF3o68NqUjYsl/cdxG7bXBqwR8mJqc3XS/iCCDJeAcUwI02qlTNvB6VMDaA1GJLSFHoLcY8QOrtYNTDk03d9GNegfXQjMDFCqVuExxAP2+zd5zDvTKMmof6C8/IShFeNsjdLIl26klDJ6Q5p290iv925rbBw6j2rGwAqtHyEuJrh3J6ZjBj9rv6iAtYjrJtmnCZ+xVUj0/i74mTfPEzVexuF6d7M+WgwOJLfgm1v34WQh654gYDs/pyQ2baHpAkIvlAok8ZqyRXdACjTgp122gUFvJet1VJW2XQ37fGl1SCYv48aD3DtPsRY7Iso9Teecd2kia0qtCRHmjufJkx3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XknGT+PGWyeYz4zatbeTRugN2H7c+KyPS1eeJA8UWE=;
 b=r39GKmgRTcP/tTzcN60zt9hM0N1JmTUmIobX96FtPY+ZI6j3kbaFq0I7xxDWgsccdfTE3GwAkiRNrjXYpRBpZvm8Qt2sQcojyqVFx3OtghD0whVjpdU3UHawiSDvjYc1z8Pm/AnpWH5CTW3riNDb5sbSq6Au+cDLYqtWtKJC3Wgzf2uEazTBhGPqu74yl6g3jZsrY51W5S589QtsaRVIBi6AFeE7g7NCMVEsHTsX3vunw4v6mWna+U3u5iaYXwvgvaZU+WxXUFWlZuNZQcC8VEX0E9Det2MDamRYcduGOcnEJzGzAY+p7WHSbbi2tB5REStRzp9+Vw1Bu7upVDTEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XknGT+PGWyeYz4zatbeTRugN2H7c+KyPS1eeJA8UWE=;
 b=SVcmb0tKv2VGm3OPWpJTAUFj71brEqD9IB1HOR0uf4AshKXjCc1RND5V83HDr7TAYUxMD2qkyS2AczLU6gZzLGS0DVZ8Q7Ii+AjYslnGtL7MX59q4hCQ9SONNF9KoFop+7vwzYLolXrvN/QvqusP6Qp4oKHdGGnsclDgd1THwu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 4 Aug
 2025 02:32:31 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 02:32:30 +0000
Message-ID: <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>
Date: Mon, 4 Aug 2025 08:02:23 +0530
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
To: Jason Gunthorpe <jgg@ziepe.ca>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250728141701.GC26511@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0302ce10-f0cb-4d66-3e7e-08ddd2ff28b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTQ0WG45c1k3RGkxTERQeitBMWxacC8rYXZTSjBrajdRQzc4VnlBZkt6Qzh5?=
 =?utf-8?B?YUJUNVVjK0RSbTRySXh1NWdtaTFIMTBSK2NIejlyeXpZaUlGc3BPQUYwL2tm?=
 =?utf-8?B?ckc4di9QQTlwUGp2QjZGb3NlU1U2TmxTaEpqZjVjcVpGOHhJYUQrOFppL1dK?=
 =?utf-8?B?MmhPOTVtMWtkeWozV0pQKy9EWUhPbFRCZ2Q5THJmQmplOGtGTGE4OWhmalBS?=
 =?utf-8?B?OHhrTFViNUZ1YkJFMVZYQXBPcXd0dkN2VzlPYndKUUc5RVA5MHdJbnp3M2hS?=
 =?utf-8?B?Ry84eVovTTJKSW04YXEzd0xEQms3ZXRpZktqN2NnVGJEM2NFdjVDTkozMEhk?=
 =?utf-8?B?bWQxZUw1Yk05SWVnaUtGd2FYUGpYNnBtNkgxQ0hXTE1peVg4YVRjY0ZwZnNK?=
 =?utf-8?B?YXl5aGoxOFFNKzU5ZXg0T3V3S3NSTWNLRG9uZG5JZFEyTUdrVWRUbXltZFRz?=
 =?utf-8?B?blFGaERIMWU4RWxNajUwQXNQUkVwRlR0cU1UUHJsSmpySDlpK015b1pkVlV1?=
 =?utf-8?B?UHozSUxLN1hhV2dxWXJBV1FiRnJkY2QwdjlFa05RSnZnbU0wb2RUcG5maFk5?=
 =?utf-8?B?cXl4UTRTNHlQR0V3L3dGWXFqZit4eTUyM25kNHM1TFZPeXkvYkhraU9LajdG?=
 =?utf-8?B?VmNFS0ovcDFhalV2T25jYU84bzY1VHpWYjZrdzFXQUMvWHV0blZ0WVJiejE0?=
 =?utf-8?B?L2oxVy9PSGs0TzVOSVE2RFBhRjNRMzg4Rmc0Q2pCWFE1a1RHbkhZT0FGYTNn?=
 =?utf-8?B?Vk9VVTJDeVlsdVpsenpjc0x2dEFSOTM1Ylc0OUFGMTNKcEp2WGR0VCtOWXA3?=
 =?utf-8?B?b3JuaGVNNDdJaGlmb0kvUXJHV0dTQkxQZ2YzWGxOemkzVFJkb3FXWTcyb1M5?=
 =?utf-8?B?OVBVd2haMm96bzRlK0IwNmRuKy9VRkVyYVpTSWVPd2JsYW9QcjJHaEc3Zm50?=
 =?utf-8?B?WG8zdTZ4bW4zNkt4YXZ0Yk4zK2pDWE5xMkVVVHlOMHY1UXhnRVFmN2s1MFBh?=
 =?utf-8?B?aFFSY2Jwazc5VW0zdEs1SmU0TkIwS3FRazZDSDJsWEtSbHBWQ3dFOE5Md3Bl?=
 =?utf-8?B?M3lockF5UktjY3FBaDRBYU0xOUgxSjhPNVhsWDY2M01WN3dkazg3Y1dKcGU2?=
 =?utf-8?B?bDB2MlkwcnJXN1ovN0R5MWQ4a1Z1M2QvZnJNWGw5Z0dLMWYzMWFlQ1pvY3NY?=
 =?utf-8?B?cmxlaldGdEpSejhKM0kzZXhuZk9FUEMySXBKa1N2L21NdWs0N0kxZkdobVc3?=
 =?utf-8?B?UVFvUnBwSmxkZU9PMGxMVWlyNUl0NTJWR3RBTS9nZVJmUWV1blNVeUphUDNG?=
 =?utf-8?B?djNNcFdMS0Izc2s2TStHcG1aMkVPdXhXKytic1VUc3BaV29aYlVVazE1a2xL?=
 =?utf-8?B?aVFQNUtoNWZycUlEc2doRTJmRjFCd1liQ1RaTUpmZ1Uxakd3djlSN2VhYXJK?=
 =?utf-8?B?TFRmR0o5OFpGSzROS3lqU290OE1xNEFxRzh3Z2hrQXVlSm16TUZCRkJmNHEx?=
 =?utf-8?B?WmZVTDZuZlM5cjU5cUplQWt6cWRMYWh0cEpicnF4YXN6dDl4dUlwRUxhTDNn?=
 =?utf-8?B?amZFMUhZd3J6RC93Tzgxa3NzVkU2RmRZUjhrMW5JM3NpZ042TWhtcXNGd1c3?=
 =?utf-8?B?WjlBdGVkUVloU1BYdlhRL1UwdFNBMW16Y2doOU0rQ2NFdG4vRk0va3E5RWc2?=
 =?utf-8?B?M25HSlhhK1F6R2ROTGVGQVR6a25DckRHKzFQWG83Rld0Mkx5NEhFWjI5Sklr?=
 =?utf-8?B?Y1cvMnBMVlZBRUVKd3IvTzAwUkhTZy9MVTI1aEo3cDlmbXd3YU1mL3lMaEJz?=
 =?utf-8?B?OUsyQWV6Z2R3Z2RFWnhzTStQU2JEaW5mUEphVUp3dTREYlpFZFVySnlFZ01z?=
 =?utf-8?B?NDNaOHorMDFlVjNGRWsvY1dpRFk5Nk9ybXFLWVRRQkpndVZZU28zeUtFK3M4?=
 =?utf-8?Q?Xr8f8c4NZwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFI4Y0xlbm9paTZIVUs0WkxMRFkybGJuM3Q3MWxjNkJiYUwrcFNuWlBac1B4?=
 =?utf-8?B?MTdyOGhCTnRZWFhwUjhmQzk1bTFHU0tTSlhtRUQ4dTIvOTczMmZXVkdaTGVv?=
 =?utf-8?B?ZGlWa3ZqTzZFSGNMbjlMR1ErSVFSeFV0akgyUDE3ZHZmNkpDMzl3elMyR2ZG?=
 =?utf-8?B?U01neStXNVJ0RGtVUnAzcktjelB5aWE5N2Q1czNRemUybzlFNkhHbG5xTkx5?=
 =?utf-8?B?b2tFV0tuV1puVWkrSHg4YjFBT0p6cmN2cHhMdkMrTGNuN053RkNENXBjSENQ?=
 =?utf-8?B?YUt4U05aeGduSUdiMHYzNFE5ZHI5RHowRWx3OVJyQk1wbW0vRko1enBOUU5S?=
 =?utf-8?B?MGJ0QXBlZmNva3A2Y2hkSmI2RVhtc1lUV0JMNE5nMDd3L0lQZWpaWDh2YWMz?=
 =?utf-8?B?eGRuejRVRHNPck1GWUtlNm9ienl5NmZMbENHS003RUdHRlRYUjlPUFBRMmxo?=
 =?utf-8?B?VUtsUWIyRVlNUmVuNlB0bSsyb0x4R0dlMUw3ZHZkQjRibDV1WXd1T0Y1czhO?=
 =?utf-8?B?Q2dBZXd2SjVBRlZaLzZIbkFkL1J2QklXQ25YTzBOU05PL2VSeXUycjdFdEFV?=
 =?utf-8?B?SExycVNhQUZUN2tVeEY0dmltays4UFVXb2lpTCtIQ2FxcHJlLzMvSE9kODJI?=
 =?utf-8?B?dXRUb2lYaWYySFJBTmgyUkI5elJQRzIra3RBQmVHWmhhcU1ZamxScEFCUkh2?=
 =?utf-8?B?YU90NmcvUjhwMUtnZTV3ZVQ1K2hvZVVhaWRvT0RoM3dxeDFOUURxckxKT29j?=
 =?utf-8?B?VXJJNDQyWFlPOUtKdU1OZnhGN2RVK2JOKzViMnBUbmplQVMyTXdFN0RGUnU2?=
 =?utf-8?B?TzZyUWw5eFJKVXlkTEhCa051MUdMMUN6VlJRMzhaMHZCWXU1Y0VaUHFmTXFP?=
 =?utf-8?B?YjlXNzhveTVkMXljY2dCaWU5dkEwN1NnVVJ3SlRrMDl3TjM2OUpoN214ME9Z?=
 =?utf-8?B?MGpjWnNFSGRsVkFuQUk1NUQ1V0VHVFZhOVhhR25ZcUxMSnNxZ0xiR0hVZGU2?=
 =?utf-8?B?UFRrMVJDVGxwTldRZVIwUkpncEt2NTI2bVlySHRIcHAyQ0R2ZGZCY3hSbUhS?=
 =?utf-8?B?UG5HQTBFeGJRcjI4dXhFWFRZSnRyKzVXdXZCM3pHWlZnc3JtaUVKYU9wUnBL?=
 =?utf-8?B?MDc5L2k0NWp5V2lYOTY5aTFVYzR3M2RuTXpsbHRYY0M3QWlNOXovdG53TUY0?=
 =?utf-8?B?dWdQT2FuRGE5eUo4bExzWlFFZXlXQXpldWRBcWZ6bDBaSnRseEdGQzNVV1d2?=
 =?utf-8?B?cFE5QUVlWVBsNk5EbU1ZVEI0bStLZ3lTOEZHWmd2TURWNmgvdDd0Q00vOVhp?=
 =?utf-8?B?SXZjbXZnQWNpZzlVdU03VEZmNnVLdHZjQThtRENocUFBY0V6WnI1cWs5c0cy?=
 =?utf-8?B?TWpsQUlmTU9rLzB4cVhKbXVqa3ZpQ3dpbi8xMDNWTkVMUCtSMGVpTUdNQ2Vu?=
 =?utf-8?B?aklNYmtUTnJWTSthUEVSOWFDNmF2NWZsVFlzTVRqVWxnRjVMRzV5d293V0Zt?=
 =?utf-8?B?OVk5Uld3dFlpazlkMHBCaitBVHk3Wmt1R1NTUDd5NE1GSllqWUpTSkVVNWVP?=
 =?utf-8?B?bExlYzBLeWZIT1NRVEdabUQ3WnFacFRCMzJWdzE2MmR4eDcrWXBDdmRJVDhi?=
 =?utf-8?B?QTQzRVp4VGRWMnlVYVJPTlhtalZMT053L1FpRE1jSEFCNksxR0g4VlUyS2dH?=
 =?utf-8?B?a3o4ZDB5OXM1MU5OWnhUcjZleURwKy91Z2tPS0NUSThQWHJYMGZBMjhpeG9u?=
 =?utf-8?B?a2F3U1VEUTIzamV6TnlTdHdvTjJFNHo3Qm5MMUE5T1NmcHVOSFRmRFJocU5o?=
 =?utf-8?B?TlErOE5iZE1PTmlWUG55QW1Xa1htN295T1VKQWdxL1RzSlFVS3p0aHl6QW9P?=
 =?utf-8?B?cEJxN0dlNDRWQ3hDWXhTNm55dGMyMzg5VHRDcU92TXNmejJIV0kveUpZODBZ?=
 =?utf-8?B?dUlsVU53RFFmcnhqVzBTZVJZVkxoczdJdVdRWExWOVY2UlovNFRoOW1CTHVK?=
 =?utf-8?B?ZkFSVDVxVk9TTVY1bEdoUURSbVpna1M4SWxJeWxSY3IrR1dRMHlNVFM5ay9i?=
 =?utf-8?B?MHV5UUZwYmRNNjh4M1B0T2xQUFNSc2c5dTE1Y1JuOVFQaVlQQ1JSOXJ3T1g3?=
 =?utf-8?Q?CukA7R1HNnVoQzmYJuc14kBNj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0302ce10-f0cb-4d66-3e7e-08ddd2ff28b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 02:32:30.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWkN++SJtollA4wE4Pj2C3LQw2NYn6tgI3iOXP1fmH0mTD2QpUTgEVgNbZ7i7g7Ev014W52v5CIYw3iDTLK//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382



On 28/7/25 19:47, Jason Gunthorpe wrote:
> On Mon, Jul 28, 2025 at 07:21:47PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> With passthrough devices, we need to make sure private memory is
>> allocated and assigned to the secure guest before we can issue the DMA.
>> For ARM RMM, we only need to map and the secure SMMU management is
>> internal to RMM. For shared IPA, vfio/iommufd DMA MAP/UNMAP interface
>> does the equivalent
> 
> I'm not really sure what this is about? It is about getting KVM to pin
> all the memory and commit it to the RMM so it can be used for DMA?
> 
> But it looks really strange to have an iommufd ioctl that just calls a
> KVM function. Feeling this should be a KVM function, or a guestmfd
> behavior??


I ended up exporting the guestmemfd's kvm_gmem_get_folio() for gfn->pfn and its fd a bit differently in iommufd - "no extra referencing":
https://github.com/AMDESE/linux-kvm/commit/f1ebd358327f026f413f8d3d64d46decfd6ab7f6

It is a new iommufd->kvm dependency though.

> I was kind of thinking it would be nice to have a guestmemfd mode that
> was "pinned", meaning the memory is allocated and remains almost
> always mapped into the TSM's page tables automatically. VFIO using
> guests would set things this way.

Yeah while doing the above, I was wondering if I want to pass the fd type when DMA-mapping from an fd or "detect" it as I do in the above commit or have some iommufd_fdmap_ops in this fd saying "(no) pinning needed" (or make this a flag of IOMMU_IOAS_MAP_FILE).

The "detection" is (mapping_inaccessible(mapping) && mapping_unevictable(mapping)), works for now.

btw in the AMD case, here it does not matter as much if it is private or shared, I map everything and let RMP and the VM deal with the permissions. Thanks,


> 
> Jason

-- 
Alexey


