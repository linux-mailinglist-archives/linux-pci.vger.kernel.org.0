Return-Path: <linux-pci+bounces-33232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30577B1708E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446DB56238F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080F2AF07;
	Thu, 31 Jul 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qgV8xKWs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D41DA5F;
	Thu, 31 Jul 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962475; cv=fail; b=hkfAV0R000FqxRwSeRoOHWbf+BNL8G4ImSYYFi4+frolQflsYPON0v92XjEPvBIYhLqg2OdkJFfMNy+sF1ZFMGt2gDJF+ubxBf32pNIsg8dbdkG6ug0TKA4F3XOB7ugJryulfjkIQ/AbggBpWV5ODlUrvjbz+c972mQC+guSBGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962475; c=relaxed/simple;
	bh=CfL/gKX25MNLdwc8+O5gih5Q1ARBEtdQkSdCxloSm7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X28xqUf+r0gmNv+KNIVa3BxCoqxUhkpjswg8KmQqbCmaneG6Vuta3TmIA7ehkVC37nR3JV3RbPMoP2/k7g8G53LGhGqkzCvOU8HFz0dOzRELia3BWZlgj0EcJZMq6682zuBX/a+YNLPACdTJRP4m9HFNaDKfBuDCwJLThEUTGCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qgV8xKWs; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we6XJL+iYA1XB+/SasYXVX4x0A4prNv0SCxhktiIipEKKTNcGw3CepLGZeloRkjW3gHfum9HqpO9shZW/WJTy/sowMYvtKDzp9ILJnoOwzRhf3F1kkB8pq76n3RhHtELUhZrujXxnwJSBM3VOhXHDrQvejitRklqJgIuzyNhttAqet/Eb71Tzq8KLW6wijay7+DEeWcCD0tdZh6sQcyGNMKBbAks6O5SG4q4F8SJ9Ua1GQxiv7ej5n+NmqBRi1i+ly4D6718Tqy8NTBNy/srffA2+7uUtvjgy12m3xiqdUl1CwP4zotFE2qSuzQtrFBvpBp/s4zFhwZ7dpFsmR43kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IxhGESs+BeKIW1y0uxA1RtvhXMGVyNTfPIMC3dcSnw=;
 b=zAeYfA37iw4SBnwvE/u++GgUeYzDP8bROW3YEHIrvkXDFivDuKpYGnp9tdy98vmVqxdPTdgYYgz5fjs2vVEbXKb+rbDg9qG0R+mgFUSN61yw0LE1kV8TpB5r5d5tlj0LFvrCrW5FVHcF3GVewgp4Y0dBGxnbeF7INyLJJtZ6ESTO5Ergghb9b+RF7AgvCYg0lvKxZ6orO7VShi3+XV2htC8eHMozEDVP50cBDlOQzx9GspVB7/nZ9JlH4Pclbwrr3io5MwulQ83oicgI5wFVHvlvJIxkJpxthn4kLTNo+6UKAQG1j9vmnnxxkISiCaGO+qGP8mJGysEnyIdsNvVF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IxhGESs+BeKIW1y0uxA1RtvhXMGVyNTfPIMC3dcSnw=;
 b=qgV8xKWsztpQ6vk0wPX70qFXInAeOiN9cvHl1RY5dtt7mBFBc0xIvogfbT7gVw2k12C7cTvS+y5inDaBzxxyYMvZwFEnp4IudeSkGcafWZYfAtqVv4DDpDp2bMyIF9EbDQEkmrFtyDvLysHam6OQQYpa0KeyQWCX4zfa0NUOVv776LATO4mGqz16f/t3AFQHZjBTWvyZw3IecA2pUrTuI6MLGEXqZ+JU8iPn5fcdTORCPkZhAyEgyyUyWx3crx8A529iyOkaVvA9xQMQoqdFgACkHju39LnY9+tZojEF7AhYoj4OFaDsG0RCIgQ2f0zC9WMidDTF8lYF5r0z3F/Pag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 31 Jul
 2025 11:47:51 +0000
Received: from DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003]) by DM4PR12MB5391.namprd12.prod.outlook.com
 ([fe80::6096:acf3:4a5c:f003%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 11:47:50 +0000
Message-ID: <69c1bd48-c55b-4af1-a48b-1669102af1be@nvidia.com>
Date: Thu, 31 Jul 2025 14:47:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 13/38] coco: host: arm64: Create a PDEV with rmm
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
 linux-coco@lists.linux.dev, lukas@wunner.de, kvmarm@lists.linux.dev,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-14-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Arto Merilainen <amerilainen@nvidia.com>
In-Reply-To: <20250728135216.48084-14-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0106.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::22) To DM4PR12MB5391.namprd12.prod.outlook.com
 (2603:10b6:5:39a::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bfcd63-f252-4afd-d196-08ddd0281366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bld6akhsT1pFdytNYjl4Y05IWFhtS1hhNmFKdFIyL3JjdnhOQndHVW50eUJ3?=
 =?utf-8?B?aWxFT2VWNW9lK1psdkNFYmFDY21KYml1VzdrdmFUOXFCVGk1OTRYQ2MrenJj?=
 =?utf-8?B?SWt3T0EvOUs0eFowOWEraVZ0MG9PSm5BdDg2REh2eUFjK2R1VXQ0S2ZlanE2?=
 =?utf-8?B?ZUhiQllXQUR6c2grZVlrVlMvS3l1ZFZrYS8rU0tKSkUzQ3J2emRmR1B1bDUy?=
 =?utf-8?B?SHVNaldFajR2UWd2WWloQjNKREtoYTRweE1UTE1qS0czeDVhemhBaUZ2Y2sy?=
 =?utf-8?B?YUk2MENXRGZVZzNiTDViNTJDaXNDeHo4TWdrOUJxQzY1cEhVSzN5NTE5ODd4?=
 =?utf-8?B?bWMvVU5kSFR2WGNkUEMySnZMb1NkMXdxTlByR2dOMHhzT1lnMEJld1FpRmxD?=
 =?utf-8?B?dzdta2N6ZzJwNFhNMG9YRU9BbWExVmc3Sm9EeGxHVmFFaXBJays0Z1FzblhZ?=
 =?utf-8?B?V1Y0WENiOWJPVkRVb2paRmFKWFpkV1M1d2k0UWlINWFwNHV1N2kzbHVrQ1Rk?=
 =?utf-8?B?cTBkZGFiK3d2ZTRPTS9nK3RvMzFuR2R6RGdVbGZIZDNtckJlTzI4Q0wrRWVs?=
 =?utf-8?B?VGhXd0x4ZUluYWMwcjBRQnNiMzY0R2RhVW4rQ0pXK21NYVNqRGdkemlhUlRW?=
 =?utf-8?B?dEg5OXhENzRxU01DcFQ3WFF2SC9vdCtJZk8yRHNFRmd1TzdYTEpmeFo5OHor?=
 =?utf-8?B?SXF1NmNIOW5UMTErb2daMktpK3pkVEsvc3ZnYWVXdnhCSW9QckdSdFBINklu?=
 =?utf-8?B?eGI5M3p4alp4SHIxbFJOekxtdjZmMFhCODFRWStXVWRmaDNIaXdTZ2lWYTNa?=
 =?utf-8?B?VWI3T1RLbEtQcTFpL2hNU1ZNRktreXV6dzRoWkRyZlE3R0Rhd0ZDUFp6K1Fu?=
 =?utf-8?B?STcvTzZXMEZKQ1VYMTRKOHkrMDltbHBYY25xWlRDVnVpaEJlN2JDVndwUWs4?=
 =?utf-8?B?Wlg0Q0Q5Wk1yRURJZXkvS0NKNjhZRlNMRjlBcHBPdnBBc09WSy9kV0d2TjRu?=
 =?utf-8?B?enlwYi9pUE8vV0MyWGFFL045NkdPb1IxL3ZLZWZHbHYyUHc5Wm1vOWpXZWVH?=
 =?utf-8?B?V3BNcFNBT0hyaUpFNUpkT1kza01hTmluSExNZ2ZHZ1N4M3hnT2JOM3RFeng0?=
 =?utf-8?B?c210UGcyK1VQNVFHeXZWa1Y2N3dRZ01mdU8xMnMzM1haYUlwMmpFYVhUVUhu?=
 =?utf-8?B?YjIwbXJtczd4QXVma2RMYzRhc0lmYk12SHNaTDdRcjNHMklrcHdjSHdxdVFW?=
 =?utf-8?B?UjArbHlPNHZYWTVaRlYvaVpScklyZTduSDdyZVo5RnljejdvaWNUeWFDNkhZ?=
 =?utf-8?B?UDFFYmNmR2tqcVdGSjNjTUtyM0JrdU1pbVVVNkRBb0dUZ25LMDhKZWxiR3B5?=
 =?utf-8?B?amkyMmt3UkRkT1hydHVVY0VPUjY1bG42YzZnL1pQNjREM21wWkRHZ05Id3Vl?=
 =?utf-8?B?ZHByc3FJMWlIVFluUkJwZTNxYWh1MkVvNCtNMG5ka3FqeDRKRjBxcEdaNE1T?=
 =?utf-8?B?Qm9yc05GSXovUlVFcG5vR1UxSnI5TGxXbjRZamhGOFFueDJ6RXorOFBGNVpl?=
 =?utf-8?B?OUdpNFhyUzRSWjNvY0JHdlAreHl1by9IVFkrZUhiTHdBZjc4b1BONGYrTVBS?=
 =?utf-8?B?K21LQU5hcWc3ZndpZHpBZ3hHb0RPK21YcHNVaEJmaXUwenp3VlVqRWxZOTNr?=
 =?utf-8?B?REI5RkRiU1ZVUmVuQTJjbkdXMWhBVkRTMEt0MFpPRm5veUpUVlVkZ1pyaURj?=
 =?utf-8?B?MktIODRsUzF1akxnTHp0MXZpVnU1SG5kQkluR1FMVTZuSTNwWDRDbW1Fa2Mr?=
 =?utf-8?B?NFRaUVIzdDVyTUp6eE5QY0FNNnlYL3loZmpnU0FkL3paWXhKWkFocVFieGxp?=
 =?utf-8?B?M0k1NU1DMVc0ZU0yYXdUYXkwT29uMTJYY1RLa1Iza1JlSFZBdnFGNWV4TVM2?=
 =?utf-8?Q?j3j0hGJ6Xp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitPKzQ0MjFSMS91RlRhRFUrWk1YSlpER1lJVG9leFBSUkVVcjY1SHYwRGF3?=
 =?utf-8?B?NHpuenBxMDE1K1VmU3FjMlErUW9IczJ3WUUrWFFCTWFPRHZrcGlGL0RrWGJT?=
 =?utf-8?B?UGFnNis2NWNySnpnSS84MTBIZlF2NnlFSXZDM0sxUkFSNXlaR3BpVnlQd2F5?=
 =?utf-8?B?Sk5UQmIxc1ZWcFA1Q1hTT3ZIMUN6b2ExTGwzcmpJZnVxZHArYkU4aFZ2UW92?=
 =?utf-8?B?SkYrUkRIN0VCR3FXSyt5aUlQQmJPaU9xamtmQ3ZCOXpFc0h0QjZPWVloVUpJ?=
 =?utf-8?B?MUx5T0VGaHhjK0JjNDZjVklvQkFMQVRlUFVyYW9BQzlXZktGVDBtNTRodVI5?=
 =?utf-8?B?bGdCYUYrZUd0aHBtUFBVZlRhakoraEwrK0pYaVdzOWZpMTBxcGY4RlFrS0lN?=
 =?utf-8?B?Qk16MnR3MWUyUFNlNEJqd1hZN3VBNVhwbHllQWVqZ3R6Q2xFOGlmUng3V1B4?=
 =?utf-8?B?dWd4bHg1SHhnR1J5NG5tOEEwWGsxQ2ZEOVMwaWp4encvTFZNRW9QeFh2bk9t?=
 =?utf-8?B?akViZkNVdTZkYnNvMk80RmE0NTdDSEgvSFNxNGY5YmM2MUFQMmpDaVBhbGd4?=
 =?utf-8?B?Y0ZEVzh1dzU3LzNaWWJkQk8yK2FBQUROQitNQ3IxU3BaRVRTTGJXcGYxSUhO?=
 =?utf-8?B?cHEzNWszT25jWW5jQnBqSE5ocXFsS2dpS21NKzdwUDhFa2ZYdWdOYUd2Tk81?=
 =?utf-8?B?UGJBRWQzSzhWN3Z6NncydmRWZ25IOG0yM09OYkxSc2JuU0dyL1lDNWUvckph?=
 =?utf-8?B?OGc0cS9ydXR4amtsQkJzMzRFVmxSekJKaWhBUmJZUyt4bjc3Y0ZqVGdFRE5q?=
 =?utf-8?B?VG43WVdmcXhpVlczUkYwN2lQYmVGMGZwdW01QTNDbUNQYVZWb0xZck1POXQv?=
 =?utf-8?B?VGR4VitKcE1iUDFlelZwd2dodHNlSTl2UWVGRkI0NnQyZEcyM2FYQmorVE9G?=
 =?utf-8?B?UlRxMEg1ci83cDNpcTJYOWNmNG9oeTFTOUxqeGI0Y05XekFmK2JpOHNnK1VK?=
 =?utf-8?B?dUtzRThSR2hPSVhxdUo4Q2xGU1ZuUzVvRHRsZDZFaVdpclRBSFQyMDJTT0Ra?=
 =?utf-8?B?OGZhQ1o5c1dSVUxQT0o4eXJJOTFYa2tiVFZWMGhzWFRnNVM1Z1Q2MDZTaEd5?=
 =?utf-8?B?S1hvN3R0VnBDVXJOVUJzU3dCeUdlSkhmajU4N0grQnhGU0JHdUpWZnFtcWlF?=
 =?utf-8?B?TGJtck1OZFNCbkx4bjI1QUpwaS9HVzJDUWpwU2dSUU53TUEwSmI2T1ZHa2F6?=
 =?utf-8?B?RFRTMllyUjlTTEZpcGZFaG5RR1loK0xpSGFZTEppZ0tCdzhMTCtTRU12UXlC?=
 =?utf-8?B?N01Kd2ErZmIxalNGbVZPUTRkTml3WHhPTGx4RTduZ3pLQktxVlM4UnN2bzFY?=
 =?utf-8?B?MXo2VERrUDB2WlNQaHVuZFJNS1NNa3BlbVR1bXNlN2Q5REo4Nkg1cnZhMW1F?=
 =?utf-8?B?d0Zlb21ZRUIrNXhjcU5Dc2pvS2s5N05JWjcwOVdmU0NmV3JZTHJYb2VEcmtv?=
 =?utf-8?B?VVZ6Z1ZsZFRFL3h2d2VjWGlORTZFako5enE0M2FlZGl3dEFGS0RiSnR5Zjlw?=
 =?utf-8?B?TDREdlUvMjZrYlAwWjNVODR4R0orb3B2TjlGY28wRkNRdmpUTkJCQVhkRTF5?=
 =?utf-8?B?VUFYZXpxTUREM0F0V1pDRUJ0Nlg1NEJuZzNUU055Y3FJSVdHMVZqS1RoNStv?=
 =?utf-8?B?NWVMQlNqSEM4UDZGTUhsOHN2Rm9ZTGM3VytWK29EOXhFazhXSm0xTXQxd05D?=
 =?utf-8?B?RC96Z08wVS91eG5PQmlsSG5kZVBSZXhvbXRWOTZ0OE1BY0lhQlVmdWl6czhF?=
 =?utf-8?B?NzM3TG4yNkdXOHA3UTFwMXFKTHdxOW02SzJ1MjN5L2tIZmZWRU03YXphampr?=
 =?utf-8?B?Wm5TL1R0d2UzbHkreGRRaFMyd1RKNmJZTzNwR0N4TDY0VVcyUER3TnFLVjl4?=
 =?utf-8?B?WGZQS2Mxb1NyUDdrbHZZdzBNb3l6L0tqcWw1Yk8vU2NURm4rbENrdklWMGF4?=
 =?utf-8?B?MXVQVWJ1Mk1aVnlOc1lLcDRZcnFyYW5weXlYMDF6V2M1Z1drbWZQYkZJU280?=
 =?utf-8?B?QzNEejNiRjQ5WDFqK2RMVTRpT01zQzg4Qnh6MEhNUzRhbDN4eTFkWVNPb3ZO?=
 =?utf-8?Q?V+NOD4fA3U9oHYm+YcUg6esNd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bfcd63-f252-4afd-d196-08ddd0281366
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 11:47:50.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVjRpS1aesIID2ys5KTlW/e+ec9CzLkecY8PW1d6dqxIE+i///2S4x6bhLy4WxbtnHQSoT8eEgLo4mo8ljADxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B


On 28.7.2025 16.51, Aneesh Kumar K.V (Arm) wrote:

> +static int pci_res_to_pdev_addr(struct rmi_pdev_addr_range *pdev_addr,
> +				unsigned int naddr, struct resource *res,
> +				unsigned int nres)
> +{
> +	int i, j;
> +
> +	for (i = 0, j = 0; i < naddr && j < nres; j++) {
> +		if (res[j].flags & IORESOURCE_MEM) {
> +			pdev_addr[i].base = res[j].start;
> +			pdev_addr[i].top  = res[j].end;

I think there is an off-by-one bug in res[j].end. As per the RMM 
specification the base address is inclusive and the top address is 
exclusive. Both res[j].start and res[j].end are inclusive, and hence
res[j].end seems wrong.

> +	/* use the rid and MMIO resources of the epdev */
> +	params->rid_top = params->rid_base = rid;

Similar issue here. As per the specification the rid_base is inclusive 
and the rid_top exclusive.

- R2


