Return-Path: <linux-pci+bounces-36528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A47B8AB09
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC757E7FFC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE931FEE7;
	Fri, 19 Sep 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRL/zeQ0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D5W8E02I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA430DEA7;
	Fri, 19 Sep 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301505; cv=fail; b=QgEDpYfO5vzG2U2/OSsWnEqTtXw3/rWPmZwCmzVGtSdC387KKy93+PzK1jJoY66FzQsYCj8lMiOpnytCw2iSMkEQ2WojvWsPhTwSjr9iLv8hZIRazZfmAIExiCDUByNn10PFj8sT+iBGjwNdir6l0vgnPitcM8mWAkW+7WpmX04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301505; c=relaxed/simple;
	bh=93MtWPi6uvzrPIB6ALIM7Uh71xMB48V+nxmTXa0j7JU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKFsMx1qAs62ifBrvVOx6XZdZ+M5qoL0C6LLbg/HCAOtOnDfCPUNY5/HHxxWyPtcXZsGrtiJbMqU0gUxCQfREioEYHkB9hFNSitT5rO+MtNggsPYlBNP+ojcn3wFBS08DENTHLADybCVzVhxFQOWTKWzNsTvZQ+un2n3QFlrOPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DRL/zeQ0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D5W8E02I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoqg023213;
	Fri, 19 Sep 2025 17:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ez385UX737Irw48/oeBFUPvlw6xnThLMcgh+FzhyPq0=; b=
	DRL/zeQ01neQyKLa3lyw2apcQ0yZOf0KeYCsMoeGR8zlQtrY4iMru9Ff8vfjwokk
	dpSVUnQsHkeFMoAfFfF997Ah6KOlihiLRWC6u7MUjIFq9JulyUlho79C7FPM9HWB
	cbr8f9TWUvKTm5jfWtcAUGzmZs6u7djq9fZDBFRW6Sk1y6I6kQq4cEuA5fkkznKb
	fFOfBKK3c++yegfkEOm0yRDUx2lmelz3TSjjChNeB5UmtgtjaYmJlAlTS7DgslNr
	0c0zItisho/YiHXE0LfAsxxeQD9lVYUuFCcuxpMfiFm+1bie0jRhIiXZ7S1K4OVL
	aKdY5zru3OwAysCXmvV26w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6p19j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:04:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGL2x7027194;
	Fri, 19 Sep 2025 17:04:42 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2q0np1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZGlEQkzXTQ703ez77O9dnz+DWMjcVAg8nF+JklnHVS2cFzerZbG/AreCdma6FJQlrFheCyjNojsuVsjo1fgGrLLB4goy/b5ozfmXB4cj/VXNuU9XepYRRrerL4E8X6z3CF90SpOiZmLuidhZBhNYmuBTeuKxO1bCV+YusMoGQlFD4dNIqn1gDhxfocH/+eZpYktwU7sOU1eb2WwS59FPn3q60frKN/l1t5Qa32kXT8odKIv2ko0Tg8ufXKUaNcaO3Kv5GW72GHOjNyc03exKksepC5ViBFUec1SBtA3pVnw5N8x21H1YKCrJEsvxTihOIqFTDGY7HiRmbnWqfL6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez385UX737Irw48/oeBFUPvlw6xnThLMcgh+FzhyPq0=;
 b=aI1CJ3XWu20EsyedZQ5JRfgu921Zqw6waLhQJFELOnaS/tMJQwOHpeoPjTKRhfbLmF29d/+UpFbK6b+vjVwwzmKcv9pFRAcseFlzdDnVHaTsyDDC+ZYRm6pMSkSuRk+HWIsNE/zEt5qMqlS1Aaf9vnH6PrNeyK992w6rbmZABFA3GycIoZxG4nywSQ4en4ftQoRndW8zBWHEjeYZTSaWTvMCKbPsX7o/TR3Pasmu6Z5/kDfJs7M/wx606tA23g2ELA4/OJZ17DYViaygDPGlTGFfuY+H3w9pUQY23RRwXyJssyejmBThFXxZvXjP49fPlzBy0cEKdku5IDn0eBPEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez385UX737Irw48/oeBFUPvlw6xnThLMcgh+FzhyPq0=;
 b=D5W8E02IoIfN7ocRj0/nVsgV/Hl+jAw/49FcQSKoXo+E9EnrJtf6QLe82hU5MLANoCbKRxkuOUD+FxcLeoap967VW7mvFyvqbfckpx7RURDCIRO4zFRypZlg0RV+/7HGb2sXUzL/HC8+WeuKw9cDAurfO0NGSKuhpqsK0QHVp3I=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Fri, 19 Sep
 2025 17:03:20 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 17:03:19 +0000
Message-ID: <45d5995a-a0f7-4b88-82ea-21169a2c94ef@oracle.com>
Date: Fri, 19 Sep 2025 22:33:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support
 (RC)
To: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
        mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
        bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
        larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
        ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Cc: cassel@kernel.org
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-3-vincent.guittot@linaro.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250919155821.95334-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9bca44-2bc7-4024-ebc8-08ddf79e6e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U211ZDRKYXRRTkFyOHZ2VGVkMWF4OVZab281VTM5NUl1MmNYM0lqSitleTdo?=
 =?utf-8?B?ZTl3ZWc0NDU5RVNHMkVYMldoOVY1bXlrUjN5SkFOQkxMaDZWTlRpcy9OanZE?=
 =?utf-8?B?REVJenNNRkd1SW5nUkU1TjZmVjJzYUhaUFR5eG5HWGltUmViMGsyRy9hT29l?=
 =?utf-8?B?YXBQa3NGTUZQUjZ3Y2piR2ptY1VTaXFzZnhkRFk5ajQvSG52ZnRKNko2RGVw?=
 =?utf-8?B?U3hseGJaUW8wK2pHMmhVMHhFTWc3T1hhN25MMFVJUHpZZ1hJUW9ZNEl6Vk9v?=
 =?utf-8?B?TUZ0cDhvNy9pM1hYWmJ4WnpQMTV5RVZucENuMzhkb0Z4ZnBhNXZQTDgxTmZx?=
 =?utf-8?B?YVJubzRvd1kwM0RyT25LWEJVc05jVjREcldzSG5VWkFlZUorbVhNcERnWGtP?=
 =?utf-8?B?bG13ZVZFOVhJdWQyNXNmY0w5QVJ0MEdYM01kelBES2VESG5jRFloOStVTCtH?=
 =?utf-8?B?SmpXdkZiZWpHY3VhbG9Yc2UvRkRPQ0xaL04wb0lhTE02dUxoS21BZVA3Q3dI?=
 =?utf-8?B?ZzFobjFDcnlLRStvSTlqMkFoaU45dFJ6UUUxTkFVaE1HUXBVQ252OEpkNlpM?=
 =?utf-8?B?OWRXK2pkeG8zS1R4UG50b3lLUXA1MCtyQngxb0czcDVEMUkyRE9kYy9Oeno4?=
 =?utf-8?B?Ulh2ZU1Ec1VMdE5wT3ZmN0MrMFkyNjVMQXRTdCtkVGpLWWtnV2FhbGQ2OEFQ?=
 =?utf-8?B?aVkraUx1ajJWQnptMjhMemtGc1hrR1lDOVFRd1puTjViNXQ3ditRRXNDcXpW?=
 =?utf-8?B?Y3owV0plU0YzU0RxQTFaTk43cHpScjBqNG9pZ2trQThod05DSVhkVHF5OHBS?=
 =?utf-8?B?MkpVWm1pcTV1ZmRadEkyaE44NUg5S0dpZHpoZ0tkWGMrSkdqeHNsK1g1TE5l?=
 =?utf-8?B?Q1JkZ1gwR1ZTOVBIT3B0akF6c0dqd0xlVGtwb0lCbTQ3RVIxZkdia0ZVS3JP?=
 =?utf-8?B?aEVGY210cjV4OFordEFsMXJhZGZ1cXVxWk5xUSttOGczajJSNFZzZG14WEph?=
 =?utf-8?B?N0lkM09xOGhIZFpZRUpKNXJkMDVyWHZoU3JBa05ZTmFDSldsUHl1bFFyb210?=
 =?utf-8?B?bXFBeC96VWVVZ1UzbGtwWGFXTEZ1SEM4TVhlTkovWmJ0dzhRaU9XME5hRlNY?=
 =?utf-8?B?WEI5dmh0dExSQUkyNUV0Z3BBc0lUZHkrVHpmelJlanZlQ25EdzkxWm9ISXZD?=
 =?utf-8?B?UWcwaXkwRVF1MGRwUHVyVFU3c2UvUi9YdFpIb0ZDSmttZ1Yva2xQMHJCaTZI?=
 =?utf-8?B?d1pEWmZmSHlKMHNpc3VpdVhLMkJpYXBaZ2Exa3dMOU1SdVU5eVpRVTFKNlA5?=
 =?utf-8?B?MFBzMTBwdmRMS05VUjdOOWk1NjFBS1VJRVM3b1ZjZTBtTWcrbzlIdVFwdlht?=
 =?utf-8?B?NkZJMXRJcVg3VnNFNDRTNWk1bmYwMFN1cmx1QWdSR0F4WS9TYnNNVTk0K0lJ?=
 =?utf-8?B?SUJReGdnSVBXeGNpN0xDcEtjNWpQbnprT0xYRTQ0N1Z1SG5ReUpoMDBrRE1s?=
 =?utf-8?B?dGloc0lYNkhVUlMvdlIzY3AwakdRbmRKMFRpL1hkbEI0T1RVeWk5Mlp3YnVN?=
 =?utf-8?B?N2Z4T1BsaWg0S3Y5VmEyQUg1Sm1pY21FM0MvVTV3cCtNdzl1Qzd1cFhSdlVH?=
 =?utf-8?B?NlZxYit2elZBdi9YWm0xeitWU0ptWE9wRnhvNGFVY2p1azlNTTBVMS93ZDB4?=
 =?utf-8?B?QlFaVGQ3NGVrNUlwTHRoZ3ZqdHBrSVZNWHhKaXkxK1VDVUp0a2dxVmxPd0xy?=
 =?utf-8?B?dDBGaFhxOHNtOFA4M1RFUlAyNVV6d3JKQ25nOUwxM2NoVC96OXdEMll4MEtr?=
 =?utf-8?B?RWRJSjlpMC82ejhVc05IQk1OM1ZFRk5VczByOXZPQnIzNGlXNlliMTJkZEhS?=
 =?utf-8?B?SmdaMGJwY21DdjRWNmZ4Ty9KT1NPYmtJdEtxbFNtQnk3RHdkYnZLeTVFRG1P?=
 =?utf-8?B?citnV1hoR3pnbmlLTnJoYTVOTUxaTlNHWnJlenVJR2phL2JOQnpmRVA0bi9x?=
 =?utf-8?B?am9zOTFBMzNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTNzOUluTWFZWWRRc1RDcjNxZlNzck9VNEltWGpmRVZyckxWZlNtOHd2L2Ew?=
 =?utf-8?B?N1VQUmxhVmlwbDdibjBmNkpid29HQXA3QUpleklERG0zMG02NGFsT1ZZaUkz?=
 =?utf-8?B?VjlXVVlXZUdyTWJrQXhwRVFtMDJHbzhnallzbFhjZENLU2N1VlJ0TVRsbzNP?=
 =?utf-8?B?b1Fsdzl0cWRIZ1IxQ3JQU3RxY2dTM2ZnTTdGYTRKQVlQZXJkRFJLOGtSQzI1?=
 =?utf-8?B?YnRwb2V5MkZ1WlRqVWNhWDBjMWtXZlFRaUorQjBKSnVlTE9haERJOGcvT0VZ?=
 =?utf-8?B?aE9ERVE0WU9EOUxJTUFYbTR2OStBTnB3Sk5NdlAxNC9HMUNxL0c2WG94K2lL?=
 =?utf-8?B?QSthQld0aG13RllCRGlNYjA4THUxbFVhSnBJUk5LVlhITGU4RUJWZ1RDWE05?=
 =?utf-8?B?cWpOUktvZEkwaU0yaU0rb09KY1MxTThmcVA0V09Ya3k4MXA2YVMwSHVvQllk?=
 =?utf-8?B?L1UyZjV0MldNY2doN21BQ2g5YWpmLzJpWUkwc0ZZNkhEVS9GbStWTUN4enYz?=
 =?utf-8?B?MUkxbS80Z0NxS0ZTa3Z0MFE5YjhFRy9sQkRSTVkwUHVEYmM2azZhQ3lhQWV6?=
 =?utf-8?B?ZE5qdVNwbHE5QjJnN2tFbXJwd1BVeHgyRmFaMjl0d09ZZXY5VVRQS2pIL0p4?=
 =?utf-8?B?ZXNSdkdHNHMyS0VQaDZjRzBnb0x1WHV2YVp4WnJZNjRGcTVaWGJJYStidks2?=
 =?utf-8?B?K25ONVZyclMrckxnT3NiSW9adG1Qbld3bms5WWhmbFlYTVB0eVk2SmU0YzJZ?=
 =?utf-8?B?cGMwMmNvbWljZ0JlWEoydGhBV2VqVmlFL0pHMzdFdVhwazludHdGR1Q2U3FP?=
 =?utf-8?B?Tit4S1BCSEJTU2l6UlppKzRudHRidHgyYVZjT095dUxpUDh6K1Z0NjFiSS92?=
 =?utf-8?B?V1g5KzlxMUJtMUVkd0Z5bWpuNzNEalkraU4rMGc4Q3Q4d1hQcUUremk5K2Ji?=
 =?utf-8?B?MVZId1JNWG94Y0hjcFNDZXVjcHBac1l0UUpZMlJuaEVlMUZwLzRFTnlNbGJV?=
 =?utf-8?B?bW0xV1lFSEJrbk05bXU1dlIzdzN3WkVRRmtQbnVQSVBDMDdTcEl2b3o1Z2I4?=
 =?utf-8?B?YllZWmJRVEtONTQ0dzB4VHl6VEs0OFl0NHhSNFFBTVJXYk1ZRyt5N1BTd3BJ?=
 =?utf-8?B?VE1VWjhqT014WHZ5WmlDcS9ZbDdBR3dnT2hpNDE0RWRtdVFQMlVnMUZRVUR5?=
 =?utf-8?B?V2V2ZXY4UDFnaHBRSXRhYzkrN1ZxaVJjZEY1MzRXYnRuVnFaTkhjT0NZeDE0?=
 =?utf-8?B?dzN5VExmVFFqbDNVeFJ5VjdNNGxuMy9QYUQ2cXkvZTE5VUVLOTJWTW5NQ2x5?=
 =?utf-8?B?RlN4NzBsTUZmbTZrTTJFc3dNdUF3ZzBVTWZJU0RURVlNSTdXTVlnc08vU0RU?=
 =?utf-8?B?a2xxdlh2dU90WDBQQ1ppYTBpWVI5eXd5L0h6MmFsQzc2NG1vYi9uMjRCZVBl?=
 =?utf-8?B?TG9NRG5GTlk3ZjV0d2laaWR1YkQ4ZWViQjVObUlPNUZnTHBSV2NKTzdXWFJC?=
 =?utf-8?B?dFVQOTBTTkM5VVgrZkphaHZlNVpML1lEWEUrWEtmMnhHSTNkQnpHR09FYWkw?=
 =?utf-8?B?VXozejFYQ3dZbHgwaW05N0NiZHNQbmNmS1BCcTJtcTZOblF3alZVMzNxRXZz?=
 =?utf-8?B?QThoZm93WWVHL3pRWVJidGZRUGRnSVBrbWRsMWZvazA0N0R4cFg4K0JoME1Y?=
 =?utf-8?B?ZzNYS2JwdUNGRzY3S3BwQ0FIUW51Z2FETnpSZHd0QzVvanIxZWR0SFZvZWlP?=
 =?utf-8?B?OVhyQ3ZaNmNhUENmQlZBK2tiTFhaL2QxQTlQbU1DNi9IM2NNc3g3VmFoRFZB?=
 =?utf-8?B?aEN2dEJoVFl5dVJTSXlpNVZ5WkRBVTBMdk45Mmt3QU5tdC9lam9sSDFlbUJC?=
 =?utf-8?B?cllXcTZXd3hpeVBaM2Q4Um5xdkJ5SU11YkF6bXBjTFl0S0JGb3krNklsdUhl?=
 =?utf-8?B?QkFVYVROaGU2VDczN2llUjBvQWUyUEplaXFISklZNU8zaHNpRHVTNWV0UXBS?=
 =?utf-8?B?MG5GSWY5b0ZCZWhIRjJZRVBqOU84OGUzYkhzNEJyWGV0RWxiYXVhblRkZGo0?=
 =?utf-8?B?QWRGdWMvdTJQSEtoTTNVYVBTbmtiL1V2VVNuNFBPWC9JNWo5WUdMdDBiVzFt?=
 =?utf-8?B?bytZKzEwRzYrSGRSeXFIQUZHTHl3TGxpV3FaSUJsMmpUM0ZmdFMvMkdWVzFB?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kP7v8MHbQ+X4qTUnKvDq/cMi/k18Naz/L3VebAwCDXUh1Zm/UCphg30qY6EQI2TBddhP1OpLPnTDWFz+eLKMH8ROURgPRzemKzKO/zuB06vBKAjtIzUokR7gf1X+rYFo4mFban+wXAPclLtX7g9e3aksg0683EjbabH9CgPWeZ9KWjr3AW7em5p9gvh7zrWK3Q7vwUXE6lA5l22VHkpjiOelPoDwshKmVa2I1YHUX08o80htz2IDn8qJEOYaOTKGNTuavxbYuG2toxuJ00coMQH7dxMcwwQ2NGGTH8t8hl2AOB7xz23lO3EfIPg84U1VyeYipkhqtj14Peo5NSHjKvK/BnlQh8jvuplXcQhFJoCwTrlxigMI4Y9jcX4ljdSmQ6EpOtZ5ucrti0NPScw4e85CmHXKz9r1i0+/hjShaOEXlvQn4bj95qvD4QgnSQRUfF9oPGvmwvXThfUf1xiQ8mf1BsSc4O3VKlhGt8M6jKHMdylV0NaAAI2GMVI04w8HqDmAqR9tbvosrwCs9gTR4sHwP1iXYfvVptHR/D4+eE6KXu96gqghbnrbaYS2pEo0vEv5RouSHxwj2PYzNauiRilB03L80TcDsY+VO9oz2pw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9bca44-2bc7-4024-ebc8-08ddf79e6e8b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 17:03:19.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g39pnT1872vLwbWY+RojWEIaLiKQXtf8ZYq359eGEgAYI0tY/+V2wbPEWEP5wfvu9AVO3eE0PxznaZc865ViyFPLaXoeOhdBxYseyU1Bl6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190160
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cd8d2b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=xQ44jagUv3E0MuIvdG8A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: gUK4NRyrB6SwBXXEChapXp9bAowUG5oe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1N5FF8sTzhoB
 +Q93kPlctsiYlPhbn3Fo7dXk6dVhjnDOHWoe3biXshAXaX7DO40UBfhu3Sl2cz0em/bpLFuaE9O
 Jh0Z9yiMOKDOD/Dk2Wbvy2o8rlX9oftrtUSgFi9/PE0B0wI1J4Hoa93B9skw6QuyKFo2D1AJhWr
 TzPn5WzSVaYv8vMnVI33NISJjyb0f10fOMTo/8dnaKpFHeR5PjQXErAMj1yH5dbKM+Ev2oosDXa
 djz7R8ckrHJCiSnGYA0vqLqMujFHDDyU5r0WcAaVuSW5i8RVoQ/zhP2P6oPDvX9nD7uW8S6G93N
 RJ9Rtqfa1SxkUNaChe6rVKn9qQoxzL0jI79o6MgJYV8iDDCsy9y861ipu5b8x6ZaPmPXjHX1lrF
 ClYTuo1GwspslcEIm1ORmTy4vQpjmA==
X-Proofpoint-ORIG-GUID: gUK4NRyrB6SwBXXEChapXp9bAowUG5oe



On 9/19/2025 9:28 PM, Vincent Guittot wrote:
> +#define CC_1_MEMTYPE_BOUNDARY_MASK		GENMASK(31, 2)
> +#define CC_1_MEMTYPE_BOUNDARY(x)		FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
> +#define CC_1_MEMTYPE_VALUE			BIT(0)
> +#define CC_1_MEMTYPE_LOWER_PERIPH		0x0
> +#define CC_1_MEMTYPE_LOWER_MEM			0x1
> +
> +#endif  /* PCI_S32G_REGS_H */

typo -> PCIE_S32G_REGS_H

> diff --git a/drivers/pci/controller/dwc/pcie-s32g.c b/drivers/pci/controller/dwc/pcie-s32g.c
> new file mode 100644
> index 000000000000..995e4593a13e
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-s32g.c

Thanks,
Alok

