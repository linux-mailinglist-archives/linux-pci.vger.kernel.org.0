Return-Path: <linux-pci+bounces-34697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33064B35210
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 05:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDB494E157C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 03:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59024265CB2;
	Tue, 26 Aug 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSun57iQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D262C326C
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177704; cv=fail; b=q0PBqccGG/4IX+CyEx9gdLbWMEAC4x5qLVxGymQvtGI+NLwUuPFO8IJCJQlepId9Cd1HTklVXtOT1M0FkLF6K+yqbKzr1GUz5F65a8GwbiEThJpnufUsgfgWouMtcyFQ99uT5H+/QpAGgTeOaHdRPT5s/FfxcjE7v6p2oDLmSUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177704; c=relaxed/simple;
	bh=wckPai1YzTWveDC0RbahhhbTQkMBM/r8fq58q/KgN5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFCYEeqH6ykUZA3r7mdFN12VsDbxsYqeCrYHKerLlSmbewriramfZbnTHXoPFKMfGvh0/x2QZluH5fU27NZvob9evfP6JDEtbfN+H3H/h4DdKZBeMklWYU9pDOgLUvINBK0T/T4F1fo8AWXABWLYF6/xDyMDnO6XmjSgp9NRoNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSun57iQ; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm1d+AdSlb1iMzX4N3MR378f5gRcfwlZw9RxFcggFWce9fdlgti6v2WuRS3NpPgvAQZmS02vmSXg8qlBHG4ue9kdLmSwgPhq5Pn4rw/zF5zWWmWWdJiRAeXXDoNdDCYY4z03e4D4ZzazRW49p2pFiFxzfEM0uLtXdtExwsJqqM1ARH9ZwXp6XyFb8c/S0wF1E2J4w3Lc6G6UItIYJehzuG+y6M9+zc2ns9XYVssOBcjmcn1f59P9zjGY8fgrcFN5rttFZq0feiDKyLEUsF2mp0UdulJlMSB/UPPKTv7nHkPEM4P+sFCS3/YveMCXR3qnQ2bmHhbU4fupjihmQB+HYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAyxYDXDn+Tp5ggx9GE+GwtwgUv/nJiXKyCep5MVL4c=;
 b=gWkPRuM+hJX5p0LMxPUqu/EYTBu4x2elMnDa393VlP6SJgIgb7icvw/yE3VHQIsd29upWbOFD7wGJLLgMBW91MMGrboFi8XyyFJxuXRytOUvbNpuvadcKDNHGFSN42aEyDHS2b3L5pR3KoIbHSdqj7NBCELRsLac2DblrKGYZlozKb2rXaUyITSvTEZFo61GKClHOmCUEBB4ZIQpYg690lhwp3VS1nQcQ4FSYEZAU8g/CzlYIE1GODeQ6RwbmpFnY5GU8GErsf1mW77GWiV1sawcqnHbcqmvsNZPTCbdmiPFiEkpJcKElZDbwwNQwmDgW2ivs0KPPyHqZmOzMye2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAyxYDXDn+Tp5ggx9GE+GwtwgUv/nJiXKyCep5MVL4c=;
 b=mSun57iQyfx3Hr9OP+25aj/z4LmWWUPcjwMvYGvvkV8tGJtGvwBBXlxxB1v0pvYfAZvobvy4iKhNcIhUYoMIU79zJNqcTJMW/p6hR7JTK/eu/AynC1FMnEVq7we1Io69pxgU7epQ03GNDLXd9qb/1DDTiK7DlOOIY/hb2rs8m6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 03:08:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 03:08:19 +0000
Message-ID: <b11535a1-0b20-41ec-be3b-05d7de3a6db9@amd.com>
Date: Tue, 26 Aug 2025 13:08:11 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250516054732.2055093-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0001.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::21) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 128fd81e-8904-470a-fb4a-08dde44dceb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGdaK0diamZ0SFhrbUREbjVFWVVtdlhCbTFSUkJ4VERLNWdyamZoV0Z1WmhC?=
 =?utf-8?B?QmI0R3FIR1lsUEdjSFlVdHQxTU5wVGZVWjFXKzJSV252SzY2RUVSZVdmL3F6?=
 =?utf-8?B?S3Z3SDJKRGp6VStDR3NtbnAvVTFRRHlHR1AydEtKN0ZIUnhRZHl6MUVXdDMv?=
 =?utf-8?B?bWladXR5UHRVdmJJNDhmN2svYklnQlROWURwc0tTcDhPWDRWMkU3UER0NUc5?=
 =?utf-8?B?ZFhEYjNKeEVSRXptWEdodlRDWGRVMUhiNzJXZExlT1hyNlcwdXBvOUdWRllR?=
 =?utf-8?B?WnN4blo2SU9YYW9uMWxjczB0b1NobmFKTGo2dnpwcXVMNEdDa0E5RFNwbFRN?=
 =?utf-8?B?UWlBNDl4L0ZRVDRZdjAzUWt0blMydTBOK1lYNTcxWEhoKzlwV1FPbHZHUWNv?=
 =?utf-8?B?dkpTV0k4NG5rSGRJbEwzYUNrYW5IbkRzcWlGQXoyMWp4RWUxeStGT3o1eHg1?=
 =?utf-8?B?YjJ1MXFvYkprNmpNRUlwL240cTgwUGxxclB6aTRyQ2lFYVNFVU81bDhkMUFB?=
 =?utf-8?B?bVZ4ejhzUjEweXFJbEFqUlIzODZaR0I3RHE3ckpIanA3OUJsVFBsOXJ0QUky?=
 =?utf-8?B?UlB2azBuYk05b2FUN0FkY3A4QUtJL0NyUTZmUWxWdm01OEU0clJSUGhPTDA1?=
 =?utf-8?B?bXUxNjFOOWRlTVAvYUNGT0xEemVmNmFUZTVzczVYV2xCYjh3ZWtGTG9YZVJL?=
 =?utf-8?B?TnB6eGFaT1BaKzNTb0NGMjJ5L1BzeUVkNmJrY1RLelBKazdvVmtWeE5yNkts?=
 =?utf-8?B?QmZaTXozZXg4d1FxZXBHOUdpb2RoVnJrVXp0OU96RytMNWFlQXY3eHBvVnlX?=
 =?utf-8?B?L0hpUnJjVkM2NS95TWU0ME9tTmpNa1RMNUhTcFg5bkRReFFjRXZzYk9lNkJp?=
 =?utf-8?B?Tmc5V3ZkN2MvSG1QOTYzNTluY3JVSW1iTGgrLzdaUFp4UFRuM2NHSDZ1L2M5?=
 =?utf-8?B?UzI2WUNqZ2t2SHdURVV6SlNEcEs3MnZCVWFSczdPOFRWdWpFVG5rQ0VmaGY2?=
 =?utf-8?B?cDBwQi83UTNkY1ZnR04zYVVBTnJDaTZvYlJTU2FtcVRFUUM0dWVjWmJEbm9v?=
 =?utf-8?B?Z2dldmFRWkZpWnYvWGkyZUU1OVRPbHM4bnA5KzVrTjFDenpjdjZwalFvaTIz?=
 =?utf-8?B?Vmg1ZGFnSC9ORDF1UWQrZWtzNTN2UDQ3MU4wTzZYaFVwZ2FHR2pCdjZ6SmVl?=
 =?utf-8?B?U1huT1JDMzRDQTlJUnJFZHM0L1ZoKzBoUjZDZjZ6clpxK2lYTncxSFphVGRv?=
 =?utf-8?B?THM0bnlsbXRMaUoyaEN1Mnk5TW1reVFocGlRdkxCUTJJQ0hpcTAxTk85emY0?=
 =?utf-8?B?U1dxSEw3dHpjSEk5QnFlN0FPRk9Fb1M3N2V3RkllVE5WUnZxR1lMRXd0MFdI?=
 =?utf-8?B?MDlSdjZpNjNvWEp1T0VOUm1RSFVrWi9hTzhVcGFlMCtSWjlmbElmcGJqRU1n?=
 =?utf-8?B?L1ZmNFFiZDdsR2JDeGprK2NZaENCaFZZcERXRm5rZnVEU1BGUnFEVU9CT1Mw?=
 =?utf-8?B?MkdiN0pDUzF4a2t1Z1g1a2ZFUld4d01jdjcwVTIraGlFdm1PeXFmN25zSXMx?=
 =?utf-8?B?R0pJemVLRFgveXNGQXNGd2FQWXJhaE5CMExLSTNCUlNGVGZPVG1BWG5XY1hw?=
 =?utf-8?B?YWtDKzZJejFBZlpDNkFOVWI5Ym0vQ1Z0QWRidlgrQlZHeUpObnA4bTcvUXpk?=
 =?utf-8?B?a2wweXJRWkhzVDY1MWwvUDFwRVVORTRFS1FyWTFWSC92RzBNWExhSnA4WkY5?=
 =?utf-8?B?VFJZMVZVRSt4TTJPb0p3RkpicXBBanl5QThHYmNYOHRlSDV5K0hFTHoyTFAy?=
 =?utf-8?B?anNNbUM2azNNM1JhSTk5M0JKNFBKUndDWlVZWnIzazlMMlRlMVpFK2JBK1NZ?=
 =?utf-8?B?UFo4akZuMGVXeDVlajQ3dUlkU294UG9ack1lcXpULzUxSzM5ZnlGdytKS2VF?=
 =?utf-8?Q?LY6HUAo1kA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJCRmhnV2xaMENNdXhoNlNvc1RnVmQraXlmZnNLdHI1WklERWlRTXA0SXQ3?=
 =?utf-8?B?ZHNhcFF5UVIrWS9oV2RIS01uT05NbjdzQlRyUkJ5MFdWS2c3Y0s0anJVYlNl?=
 =?utf-8?B?YjlNeUxpeDhpQS9qai9qb3I1T1h6Tmx2WHY0SXpLUUJ1czNCQWdCTVIzNjkv?=
 =?utf-8?B?NEYzMEhXR25zYUJxVC9kbjgxM2ZUNlhxaUhKN05XVWxzL1Y1QlcvWnYwcnRp?=
 =?utf-8?B?TVZ2dHdQWUxrNXI2S3lKd09PK1pjS3VPeEx2SDVWRjcrZFVQQ3UyTC9XbFBp?=
 =?utf-8?B?OVErRklMSUVBcElOQUtJUHBVU2dTelBTSWJrcWJ0M1NORlkxclJScFFMQ21u?=
 =?utf-8?B?SmlocEVaWnJMbVpoeU9ISkFDVThEUjRRU25Udm1kTzlHczg5dkRZYXhEM0xo?=
 =?utf-8?B?cDJKZ21XeUtJV3NkRnMzMkhVYi9YVlUwanVhYU9DeWxFd1ZzakdtZ01HMlYy?=
 =?utf-8?B?OUFqejZPUjBtT25MMFZYR2JNVzZURlJmdEVJQzlla21HWXFCOHhjV2R1eUxy?=
 =?utf-8?B?aHZ0M0lheC9RV0t1eXRwOXJ6NUFOYkJnR3I3THltc2taWStWdzU1ekMzemg0?=
 =?utf-8?B?R1JtUXRSblRVTlFvNnREN3BsT3A5bmhneUovbzRTRHV6czdmU0hrZDBocUZa?=
 =?utf-8?B?dU5KYWgzakRIVTZKU2tVMVMzQWRTbzhnbjVQS3U1WTBhWnd1Y2xhR3QrNmdG?=
 =?utf-8?B?aVFVTFYyck5LUG04VDdlWGJudlhEQWhLUFBMVmN4b2RYUzRiQnlGeHlnaXJx?=
 =?utf-8?B?N2xCTldqbFRlMDdqd29zNWZpNzdYUDlMZlYxT0FYTjlCMkNSNllHc0R4R0FX?=
 =?utf-8?B?UjQ0MENJbGxaWStPODMrZXZndW1wOEpIMkhrK1NmZXFKMWpYdlk0TXBZaFU2?=
 =?utf-8?B?V0RWL1hXUkZBWjl3bkpPRWZiVW1UVm9WWjBYZTVFczcwTGxHc3R6YUlGeVB5?=
 =?utf-8?B?NHZMV2JVV09WNXZKNEN0SmkvdTM1SjlYcDJlVDdnVDdhQm01eWlyRWdKWTlu?=
 =?utf-8?B?Mi9lV2w4OEhtQlRidnB2WTY2YzJoM0Q1UGpMSGRNTG4xNUZPQXJWQWdnUmc0?=
 =?utf-8?B?M1VkOWNxRkl1SHB4d01EblhsRXB4bFVXMnVFRDJTQ1NESUMzaDQwbmR1bHVy?=
 =?utf-8?B?a3BuMk9vUnNJdTM2UWNIK0dZd0p5SEhSZWRkc1F1VkpYb3lNRXlCRktncmtJ?=
 =?utf-8?B?N1B3cis1UFdXZUR1Y1FrckRHK1RHYzUvblhTaUVBU253ZWJHcmc0Z09EZTAr?=
 =?utf-8?B?UGl5ZjZoZXlCVjFlWGw5OXJJWVJJZWFlN1lPM0YvSjhkQXNFbDNrVWI4VXN4?=
 =?utf-8?B?T2J5RSt0MDExYzcxR3J6NXI2UVZEZ3NJaDM0WXBid2ZVNS8veGwrSVhkUmFL?=
 =?utf-8?B?Q3ROcHQvMlM1b0ZDVGtpdXNsVUZaZTVpVUxJS0pIZ0FFaWF2M0dpbHkxeEx4?=
 =?utf-8?B?ZmI4SEJXMjZBTWNzUVhsWTdubkVYd1l4T0YydDNPbVh6S0E3emFrU1FLeVRJ?=
 =?utf-8?B?OW1UbExpaFhYa0JiSS85MkZUdkZveWFBbjE0d09TYlBOcmNISGpzaFM4QmJK?=
 =?utf-8?B?RHJvbTdaREtwTGg4TXF2OEJTLzB4VlJGektrSnFEY0Z0bzQ5QTdUTmd3QWtR?=
 =?utf-8?B?SEVrdHlXenMrcDZwSisvVFZzL1hrU2VCMVd5K0o1M2JhaWpyanJUbFpVWFVk?=
 =?utf-8?B?MVBTM0oreHFZZjVIZGtVTEljVUV0czhDR0ZCQUJqY0g4bUtkMnh4S2dUaUJS?=
 =?utf-8?B?eWd1ME1PR1VwdGEvK2FaQ3E3ZWw2dGRWQ0dXbHdSSHRWTVBKaEtQa0w2SHBV?=
 =?utf-8?B?bG9OTmpTcTNTT1M3L0lXM1FaQlBRaENtRG40ZlZlamU5NkYyTklab0FzM1p4?=
 =?utf-8?B?Sno3Rjc4VkhrcnVaMkIwMWVCN3hMQVVjSUFVR3J5QkJaOXg3OWFMN2MvOXBy?=
 =?utf-8?B?V01hZ2ZYbmhjUEZ3Z1lzRWdwcVBTaFN0czdvNVZZbHVKbURML0p5YzBsWGxW?=
 =?utf-8?B?S2hEdHNvcmhoZWVCem95TVNwOHdCYjFqVnhxeWZYckJpZ3V2THlyTHpDaEp6?=
 =?utf-8?B?elBlRE1uWmdtVmw2cUVpQngrVWx1ZnJBSktjK25LcDNZTEtJc2RqcG4rVzRa?=
 =?utf-8?Q?GiFZJmgJvOmpa/+3P1H0jO9LQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128fd81e-8904-470a-fb4a-08dde44dceb5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:08:19.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuwhxiJounU4VcvbEA0fkoz53X4iJpVWIogt1gpubVVRXemd7DM1ZtDHA1XSfNcW54YHXz+V9+FQofAsJWlkKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648



On 16/5/25 15:47, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential
> VM such that the assigned device is enabled to access guest private
> memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of the "TSM" core device,
> /sys/class/tsm/tsm0/uevent, to know when the PCI core has initialized
> TSM services.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> defined for secure session and IDE establishment. The 'probe' and
> 'remove' operations setup per-device context objects starting with
> 'struct pci_tsm_pf0', the device Physical Function 0 that mediates
> communication to the device's Security Manager (DSM).
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  45 +++
>   MAINTAINERS                             |   2 +
>   drivers/pci/Kconfig                     |  14 +
>   drivers/pci/Makefile                    |   1 +
>   drivers/pci/pci-sysfs.c                 |   4 +
>   drivers/pci/pci.h                       |  10 +
>   drivers/pci/probe.c                     |   1 +
>   drivers/pci/remove.c                    |   3 +
>   drivers/pci/tsm.c                       | 437 ++++++++++++++++++++++++
>   drivers/virt/coco/host/tsm-core.c       |  19 +-
>   include/linux/pci-tsm.h                 | 138 ++++++++
>   include/linux/pci.h                     |   3 +
>   include/linux/tsm.h                     |   4 +-
>   include/uapi/linux/pci_regs.h           |   1 +
>   14 files changed, 679 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..1d38e0d3a6be 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,48 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one,
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the platform TSM (TEE
> +		Security Manager) to establish a connection with the device.
> +		This typically includes an SPDM (DMTF Security Protocols and
> +		Data Models) session over PCIe DOE (Data Object Exchange) and
> +		may also include PCIe IDE (Integrity and Data Encryption)
> +		establishment.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Date:		July 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09bf7b45708b..2f92623b4de5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24560,8 +24560,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
>   F:	drivers/virt/coco/host/
> +F:	include/linux/pci-tsm.h
>   F:	include/linux/tsm.h
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c662f9813eb..5c3f896ac9f4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -135,6 +135,20 @@ config PCI_IDE_STREAM_MAX
>   	  track the maximum possibility of 256 streams per host bridge
>   	  in the typical case.
>   
> +config PCI_TSM
> +	bool "PCI TSM: Device security protocol support"
> +	select PCI_IDE
> +	select PCI_DOE
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c6cda56ca52c..6bd16a110916 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1811,6 +1811,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	&pci_doe_sysfs_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_pf0_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 10be2ce5e5d5..7f763441f658 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -517,6 +517,16 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_pf0_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1b597b6e946c..c090289b70be 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2620,6 +2620,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_tph_init(dev);		/* TLP Processing Hints */
>   	pci_rebar_init(dev);		/* Resizable BAR */
>   	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_tsm_init(dev);		/* TEE Security Manager connection */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498..21851c13becd 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> +	/* before device_del() to keep config cycle access */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..d00a8e471340
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/xarray.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static const struct pci_tsm_ops *tsm_ops;
> +
> +/* supplemental attributes to surface when pci_tsm_attr_group is active */
> +static const struct attribute_group *pci_tsm_owner_attr_group;
> +
> +static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
> +{
> +	struct pci_dev *pdev = pci_tsm->pdev;
> +
> +	if (!is_pci_tsm_pf0(pdev) || pci_tsm->type != PCI_TSM_PF0) {
> +		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(pci_tsm, struct pci_tsm_pf0, tsm);
> +}
> +
> +/* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
> +static struct mutex *tsm_ops_lock(struct pci_tsm_pf0 *tsm)
> +{
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +
> +	if (mutex_lock_interruptible(&tsm->lock) != 0)
> +		return NULL;
> +	return &tsm->lock;
> +}
> +DEFINE_FREE(tsm_ops_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +
> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +	if (tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +
> +	tsm_ops->disconnect(pdev);
> +	tsm->state = PCI_TSM_INIT;
> +
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +	int rc;
> +
> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +	if (tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +
> +	rc = tsm_ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +	tsm->state = PCI_TSM_CONNECT;
> +	return 0;
> +}
> +
> +/* TODO: switch to ACQUIRE() and ACQUIRE_ERR() */
> +static struct rw_semaphore *tsm_read_lock(void)
> +{
> +	if (down_read_interruptible(&pci_tsm_rwsem))
> +		return NULL;
> +	return &pci_tsm_rwsem;
> +}
> +DEFINE_FREE(tsm_read_unlock, struct rw_semaphore *, if (_T) up_read(_T))
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	int rc;
> +	bool connect;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	rc = kstrtobool(buf, &connect);
> +	if (rc)
> +		return rc;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (connect)
> +		rc = pci_tsm_connect(pdev);
> +	else
> +		rc = pci_tsm_disconnect(pdev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_tsm_pf0 *tsm;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_CONNECT);
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->tsm && is_pci_tsm_pf0(pdev))
> +		return true;
> +	return false;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
> +
> +static struct attribute *pci_tsm_pf0_attrs[] = {
> +	&dev_attr_connect.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_pf0_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_pf0_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When device authentication is TSM owned, 'authenticated' is
> +	 * identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};
> +
> +/*
> + * Retrieve physical function0 device whether it has TEE capability or not
> + */
> +static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pf_dev = pci_physfn(pdev);
> +
> +	if (PCI_FUNC(pf_dev->devfn) == 0)
> +		return pci_dev_get(pf_dev);
> +
> +	return pci_get_slot(pf_dev->bus,
> +			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
> +}
> +
> +static bool is_pci_tsm_downstream(struct pci_dev *pdev)
> +{
> +	struct pci_dev *uport;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	/* "grandparent" of an endpoint is an Upstream Port (or Root Port) */
> +	if (!pdev->dev.parent)
> +		return false;
> +	if (!pdev->dev.parent->parent)
> +		return false;
> +
> +	uport = to_pci_dev(pdev->dev.parent->parent);
> +	if (pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
> +		return false;
> +
> +	if (!uport->tsm)
> +		return false;
> +
> +	/* Upstream Port has a 'tsm' context, probe downstream devices. */
> +	return true;
> +}
> +
> +static enum pci_tsm_type pci_tsm_type(struct pci_dev *pdev)
> +{
> +	if (is_pci_tsm_pf0(pdev))
> +		return PCI_TSM_PF0;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return PCI_TSM_INVALID;
> +
> +	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0) {
> +		if (pdev->is_virtfn)
> +			return PCI_TSM_VIRTFN;
> +		else
> +			return PCI_TSM_MFD;
> +	}
> +
> +	/*
> +	 * Allow for Device Security Managers (DSMs) at a Switch level
> +	 * to host TDISP services for downstream devices
> +	 */
> +	if (is_pci_tsm_downstream(pdev))
> +		return PCI_TSM_DOWNSTREAM;
> +	return PCI_TSM_INVALID;
> +}
> +
> +/**
> + * pci_tsm_initialize() - base 'struct pci_tsm' initialization
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + */
> +void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
> +{
> +	tsm->type = pci_tsm_type(pdev);
> +	tsm->pdev = pdev;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_initialize);
> +
> +/**
> + * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initialization
> + * @pdev: Physical Function 0 PCI device
> + * @tsm: context to initialize
> + */
> +int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
> +{
> +	mutex_init(&tsm->lock);
> +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					   PCI_DOE_PROTO_CMA);
> +	if (!tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return -ENODEV;
> +	}
> +
> +	tsm->state = PCI_TSM_INIT;
> +	pci_tsm_initialize(pdev, &tsm->tsm);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_initialize);
> +
> +static void __pci_tsm_pf0_destroy(struct pci_tsm_pf0 *tsm)
> +{
> +	mutex_destroy(&tsm->lock);
> +}
> +
> +static void tsm_remove(struct pci_tsm *tsm)
> +{
> +	if (!tsm)
> +		return;
> +	tsm_ops->remove(tsm);
> +}
> +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> +
> +static void pci_tsm_pf0_init(struct pci_dev *pdev)
> +{
> +	bool tee_cap;
> +
> +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +
> +	if (!(pdev->ide_cap || tee_cap))
> +		return;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	if (!tsm_ops)
> +		return;
> +
> +	/*
> +	 * If a physical device has any security capabilities it may be
> +	 * a candidate to connect with the platform TSM
> +	 */
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = tsm_ops->probe(pdev);
> +
> +	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
> +		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
> +		pci_tsm ? "attach" : "skip");
> +
> +	if (!pci_tsm)
> +		return;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +}
> +
> +static void __pci_tsm_init(struct pci_dev *pdev)
> +{
> +	enum pci_tsm_type type = pci_tsm_type(pdev);
> +
> +	switch (type) {
> +	case PCI_TSM_PF0:
> +		pci_tsm_pf0_init(pdev);
> +		break;
> +	case PCI_TSM_VIRTFN:
> +	case PCI_TSM_MFD:
> +	case PCI_TSM_DOWNSTREAM:
> +		pdev->tsm = tsm_ops->probe(pdev);
> +		break;
> +	case PCI_TSM_INVALID:
> +	default:
> +		break;
> +	}
> +}
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_init(pdev);
> +}
> +
> +int pci_tsm_core_register(const struct pci_tsm_ops *ops, const struct attribute_group *grp)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!ops)
> +		return 0;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (tsm_ops)
> +		return -EBUSY;
> +	tsm_ops = ops;
> +	pci_tsm_owner_attr_group = grp;
> +	for_each_pci_dev(pdev)
> +		__pci_tsm_init(pdev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_core_register);
> +
> +static void pci_tsm_pf0_destroy(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +
> +	if (tsm->state > PCI_TSM_INIT)
> +		pci_tsm_disconnect(pdev);
> +	pdev->tsm = NULL;
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_unmerge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	__pci_tsm_pf0_destroy(tsm);
> +}
> +
> +static void __pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	if (!pci_tsm)
> +		return;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		pci_tsm_pf0_destroy(pdev);
> +	tsm_ops->remove(pci_tsm);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev);
> +}
> +
> +void pci_tsm_core_unregister(const struct pci_tsm_ops *ops)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!ops)
> +		return;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (ops != tsm_ops)
> +		return;
> +	for_each_pci_dev(pdev)
> +		__pci_tsm_destroy(pdev);
> +	tsm_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_core_unregister);
> +
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz)


This does not belong here yet - no user.

But if you still want it - "enum pci_doe_proto" should go to pci-doe.h like this https://github.com/AMDESE/linux-kvm/commit/af12dec97ed98a9f365bbbb6925e76c556937d01

> +{
> +	struct pci_tsm_pf0 *tsm;
> +
> +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	if (!tsm->doe_mb)
> +		return -ENXIO;
> +
> +	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
> +		       resp, resp_sz);

The wrapper does not seem to be very helpful - the platform driver (==TSM ==CCP) which is going to call it already knows it is a DSM and mailboxes are initialized (otherwise the DSM's pci_tsm_ops::probe() would've failed) so it can just call pci_doe() directly. Thanks,


-- 
Alexey


