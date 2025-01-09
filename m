Return-Path: <linux-pci+bounces-19609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B68A08073
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7117A2898
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F119C556;
	Thu,  9 Jan 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4AZE0/4j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B42AF07;
	Thu,  9 Jan 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449800; cv=fail; b=EAo8JqQ7m+ubi8FaxhgPqB6w4bmVxCgF4Ah3jwN/y1AiRXS1hKJC7ZyJf/loKR8FwvL2XXZMjlaLKkMVtOsrq5suc7RugKo0MKUfj7GMN8z1eknlmsH5sQvFC1hSG8X9/u+0lGGamZyJwj/pzaoOtWFZMCrM0IsL4Dmcrj4qtyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449800; c=relaxed/simple;
	bh=10LB8VRVGYmF0F1hCUq1Q084Fdw4kYhmMwx4S46Nv1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=he5maivd5XCfBzqRczzaNw3IIzdwypjjDSqYud8YBkUTaBK0R+DACVSyprIC0sV0/1FqXfFB5ZeeDM1TtAqtldVnfLR0zhKFBBinb/umLLa4o9rz1vS2FSmu3beH7soziBXXWNbO/erAPYrCUT9cm3uGjgtlPvBbOMGmK31wMQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4AZE0/4j; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPPGhS2gfXdtYtO4pwrTNjQ2z/rJDz4d7xKrS8s0kkOJkiUf03Uzna9Sq4w3+KJX84qbwalr97cCpig4JEPuj2e7oEUBt5gr7pYL73rm4dGVifHbwqtN7jV+gmUEoEtF1N841cOBAiPR1X2n019f5zgRjruzyn+61jgzzP+5PDcg4lZIcVGJv8C1rROPUrpwRYazqBRDsiLQECjgZ14L4Mj+B6QZbvqCd2ANaC8Q5kgXBt1DPPM3V7cfGRUA6Nsw9ce1U8SEkGkuPbENLWMFOQEWWqK1q+Qa1fXqss9kUxelIfRkjzWZI79PwEYD6V+PXgU0G9Qn5lRf/l1ES0u7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2ib+5Kv2WuA7TjYOTmT4cjFNUrRVdrwoFZHFfRuyVU=;
 b=am/D5Rn803Uaq+efrehX8X0Bp/urWdURefGWKGSn52HPhP/sfu/dM1ffqsveabxYFgc0umxiUZP/0GTwqGGKZeM60O/bx4ZmIzZjcuMFDR81IcKDxMPRoPQpk/J+7bwgklfW5HszAjllDgHUXNzfRN9OK0iO6K5+akO/bT6gyMMiKAOLgoQ4Ye+qebcevfBd6e+UGVzmGYqnaFm9ylkA6S5n4eKJFFHS3WvRQ0YpPix3RBG8k0EdzFSDEsuDRtIchIzkAbLWn1ZCHBlNvb0AUkJxjfkJTJZmHEYG3I3Ukw0x2hhTY10sLhewi1DN5Zb5f+K7er0klBPyzMGisQXOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ib+5Kv2WuA7TjYOTmT4cjFNUrRVdrwoFZHFfRuyVU=;
 b=4AZE0/4jClAHDtmjh7ouQK9zRjbtCFRrPPrRQrWHWucUKkWqqo/3QFCJA8VSaqN8kdfvp/MavkQeTMCHLlRXBmOjcHYOeuKxJWOz8pPHKa4pcOyHhfMdXcJFDChNfyBZcQfEyrzOSxaU4VUHaNcEiMjKGH5U/1EatkI9YNKbxqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 19:09:54 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%6]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 19:09:54 +0000
Message-ID: <f1f6af31-7667-4416-95d0-2f59c91a1b62@amd.com>
Date: Thu, 9 Jan 2025 13:09:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/2] bnxt_en: Add TPH support in BNXT driver
To: Jiri Slaby <jirislaby@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, helgaas@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, asml.silence@gmail.com,
 almasrymina@google.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com
References: <20241115200412.1340286-1-wei.huang2@amd.com>
 <20241115200412.1340286-2-wei.huang2@amd.com>
 <20241115140434.50457691@kernel.org>
 <68e23536-5295-4ae0-94c9-691a74339de0@kernel.org>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <68e23536-5295-4ae0-94c9-691a74339de0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 313e7727-2ffb-4a73-fc8b-08dd30e1333d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OSs3SlBJU1VOamtrcHZVNTBLQTdKSXk5SFViZTZqOThUaEJHMkRQWjZWVkEr?=
 =?utf-8?B?NFZiaFo3eXJHL2ljWFlYa2N3Uy9VL2crNDhnTC9hRHk1VWpTTHpXT08vbTVU?=
 =?utf-8?B?RFJpV0w2UlN3TE4zbzRBb2hjZW1YUTJDYXJrQVlQK0orYnI4bnZBZjRlVmth?=
 =?utf-8?B?THdBTUtsbVI2dEJjOW1BZDNnZnpsaXkrVTlmY3RWZFpZWUFVRXN6M1NSMDNL?=
 =?utf-8?B?ZVB0ejAzWFhrMFBySktKS0xDRDFlM1lUd1RGQnhNUEM2L1N2SkcvbE1aNWx1?=
 =?utf-8?B?N0hELzJ5YXVtdnljeEsxcWxGTjAzeDRoeFBSQTBWL2RFa25CNW5jeU5TVW1M?=
 =?utf-8?B?YnN6VmlPTHVYY1dXZUc1L291NHY1T3h6WGFLcGUxMVJROTNWM1EzUE9VQW9R?=
 =?utf-8?B?UTNOd2RGbDIxYzdTZ2cyL2VPTndFcndrbkpFdnZ0OTJlbDB6aUFTdDRQTW5N?=
 =?utf-8?B?emZTUWE1SHQ5S0Z5SHRwS1dkWTUvOFNGVjh6TjVBYUEyZDJDK1ZTTW8wWlhY?=
 =?utf-8?B?S1JrOGJDMlg4QVRIOGJ2NWRjcXBvOTF6d1VRRTRraHVwQ1d1cFBPdWhuWTg3?=
 =?utf-8?B?TEpndFBmeG10UUNUWFFCUS90Tjg3K2w2eGpuUklpRjhPY3VKY0RJbXE1dWFS?=
 =?utf-8?B?eG5jejJrc2h1QTNoZVlVSVhmdS9FandoZTdUZ1lld2RXbVpsVW82Q3FodnY3?=
 =?utf-8?B?aG1LVUdZeGptbWp5UTlDako4dEgweGtDR2wrUTN3UFRWSm9oY1lKR2Izc3J6?=
 =?utf-8?B?Y2xGWi9kb0o5dTJTeldVNEFRTUQzR2FVSXIxOFpzSkNGaEhCaUtIemJZZzFu?=
 =?utf-8?B?Qk5od2dlZkRUR04rdWdJV1BpTmF4WU1zdmFRRXFEWVhiMVV5V0tTMEVZTnVl?=
 =?utf-8?B?V1lqYktyUStWZ0VxaTNaWkVIdkpuNkRDcSsvZFB5b1E1aTQvdUp6MlJGZ0Fp?=
 =?utf-8?B?Tm5MRmlXbktraTVZUDJ5K2s1VmZheUdBMmJRYnl4Z0ROSm51bE9tcWxySUFi?=
 =?utf-8?B?UTBQVFFzcGIrMnJ6dXg1WGNGZGNnb1BNcmFEMU9ybVJYR1hYdEJlWFJrNVFZ?=
 =?utf-8?B?QU8za2c1OUROZUxwQ3ZFTlpIc3B3NFdUWGlLQk1sS09YcW0xWlJXajZUWWtt?=
 =?utf-8?B?QW9heEJ4dkFHdnFJNUlpWVlKbElsb2R1WEFWbUhqdG4wQ3BJNDJwaFFubXI3?=
 =?utf-8?B?dWNrbTFqK1NGWVlTcndVOFpjL0crUnhpWUFKWHpCMHF5bmhKMWt1Y0NRYkhM?=
 =?utf-8?B?K042ZHA4enA2ZjFrYVBXSTgwQmFWOENhOGw0V1RNY1ZDd1l2UGM0MTVveDNG?=
 =?utf-8?B?aWloUkxwSlVXODRpQ0VZVXZjNVRrbDBhcFpUNXUyMXowWEFZbjVFRnhNemtk?=
 =?utf-8?B?R1FDTm4yaEQyZWNpeTl4Qk9UVC9UUEhtTGtMYmVzcDVTd1ZnREdkbVJjZW1n?=
 =?utf-8?B?RXpyZlRhMmRuQTgyQjBaWEk2aU9XNktSYmdUbGxsVktqcmgrbGw2QmhWeVds?=
 =?utf-8?B?eEVmZ081YnIwSmhQclNvbFJ1L1dGcUV1UVJ6RCtKUFcvTThud015aWNMQXdi?=
 =?utf-8?B?cHR2amFmaXRNdjZ0QTdKL05KM2Yzamg5cHpRUTYxVWxGQi9MVmRWWFdza0NM?=
 =?utf-8?B?S2RieFg5czEvYitDaFRtY1lWK0hDbG5Pa1BnWnRBQjV3R3l4d2J2MFh1Y3Ex?=
 =?utf-8?B?UzNhc3ZxaTZJYTBEbU9kd2xPODZ2MTgvSTYxb1c1dklSOVdObHRmb3grZ3l4?=
 =?utf-8?B?dDFLT1hLcGpsTGZ1U3gxTHFiOGRjYjFMQlZPOTNOejhIZmYxdy84OTZkZUVk?=
 =?utf-8?B?M1NVa0wyWXBENENOdDhxamJqMHRCY280QmV3cnk1OUNLNmtCVllWUFlHSUpB?=
 =?utf-8?Q?DiJkp6kOgOEOB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlLMWdyUGVHVHY1OXFCMExPeENicGhhOWxsRDlFcnZLZ1NRNS9rWHBrV2dw?=
 =?utf-8?B?dkU1TjE1WmJPYkwyTjlwbE9SOTZ4blFML0FyaGJLVEZTY0ZkTGNheWFGMU96?=
 =?utf-8?B?dlhZL01TRjJQL3dQb3U5SCtLcFluUUZVNlZKR0NjWWkxV2t0Skh0TklhVHBD?=
 =?utf-8?B?c1Bac2ZqL255bGVrVVNEajFRSXEway9ZUStxZTAzd0tVaEhMMVlGTUdZL3R1?=
 =?utf-8?B?QmtlRWMyTW94aDN0TkNFQkdzYTJtT2dKb2ZyUHZKTmpFYTR0NTVJdnFnMEJS?=
 =?utf-8?B?TW1KM2J3UFhybFJ5dWp6V2s3Mk41UzNGbTBQQXdFaFN1ZkIvbHVZSHY1cmo4?=
 =?utf-8?B?OC9hend3MEdvQ2x5WHFLQTJSd2RMblMvSWZBcUp6MlJDVStUNzBBbWRTMm52?=
 =?utf-8?B?MGhTc054TzFrWlI1YVJmSTNVekNyUmlBSXdyUTFGenhValBJL3VONjBuRTZF?=
 =?utf-8?B?eUF4Lzhtd1NHeVBROVhiallTMVBOdjRKMVZBa2Nzd2oydTBRazJNdjRmbjFr?=
 =?utf-8?B?cFJ5K1ZxNmtjdngwTXFtUG05a0l3OTVxT2hqOThHdStQNlUySkREOVozMjZ1?=
 =?utf-8?B?VUlwWWJ6TnNFNVdTcFBXalpreDVnc3R2dHNFSUJDS3M3ZGE3bm5WbkZzT2FF?=
 =?utf-8?B?MHpnSng1eXowT2NMWkxvSUkxbm1OQnpmK3hTUEFoaGtmMklLM213SUlJM2xm?=
 =?utf-8?B?OXdGOGE3WWZxN2FKRGxkMm1tbGYybEZJc3Y3d015dmlkb28xUzFhaEY3cmVX?=
 =?utf-8?B?bUUxbHpEV3BCYlJ5QjN1eHJ3MngvWEFINmN5WGNuUXJNUU5xY1BON2V1Nyt1?=
 =?utf-8?B?cEROWWJGUDZqNzB0eHRKR1diR0ZGRU5yWUZFbFZQeEovOE9KNGtPamxLVDZT?=
 =?utf-8?B?dVdBSW4wYzRXMnlheVVUajhia2ZVUUYyUTM3dVdkOEFVYWFEekJNYXR4R04r?=
 =?utf-8?B?VlhBMkNTYkZPZm0wdzgydVNlTDc2U253SVMxY1RON0p3THdvZUxUNldobWdZ?=
 =?utf-8?B?Z2RMSkhUNnJJVWxkQ3pYS0ZTL1JaRE9hbWg2cSt4WWVNRG14ZzNPY001UG1H?=
 =?utf-8?B?a3ErenF4Y0tGcHdGbHp0YXhDZm5kakVlTjZ3bG1PZnlQSExLS2J2OGNPeHAv?=
 =?utf-8?B?QlN6UFljS0p4eHl3bmdBN2dqZ0VhTXAxWEd1V0RiSVN6QTc4VE1ibUhkc3l2?=
 =?utf-8?B?NHFVSTlQSlNaT2tzYkJBdkZPQWozd1J4NEJ2VjF6VUtUNCtlc2x0ZUhqSlY0?=
 =?utf-8?B?UXM2RzJMSXFBaXpleVQrbTZYOEZmS1dtVkxBc0xpWXUzeVRwZmViclRhblRo?=
 =?utf-8?B?SHdjZ1FURTBUZG5GVnZFemM1b1oxT0RJQTFTbThLdkdzSk50YTFFWEF6azV0?=
 =?utf-8?B?OVREMTRDcFV6YmgrWmZGYnErbTNzVHN3U1FrRHBGZUJXTnJHenE5ZmtzN0Qy?=
 =?utf-8?B?bzJScUFoOGh1d2VhS21EM2hyY1pYZTBoRWJMV285YTI2blVBUTMwZ3FEMDJx?=
 =?utf-8?B?S0ZSMTVkYWg1RW83WmdEWW1GdE1EUUs3YytVTXMwa0ZLT2R2K0FLd1p3OTNi?=
 =?utf-8?B?bmNCSms5UVFDeWFFMjlsRWpuWXM0d1gyM2pOZkRRTmZCNktPMjlMUXdkRkV1?=
 =?utf-8?B?MzMzak16QUVvMll4UjRnaDFqS0R4U3B6R0JQaVNIWW9rSVBXblRuS2ZUZFJh?=
 =?utf-8?B?aU9UckZ5WStWUzNlR1h3aG80TXJQOGs4Vk40NzRPU1dMSXlVZWh4VEhGWG9o?=
 =?utf-8?B?NFp3VkxUU05aODJOQ3kwbHlRSTlGWlp6Vktlb2lwYlkybHZrTXVZd3MweGZp?=
 =?utf-8?B?VGtTUjREb3FyL3kzNkwyeHB1V3pEc0JjSjBocVF0ajVoQVhGbHNtU0dLWGI1?=
 =?utf-8?B?cTUwRXBjSkpNWDdsV3VtdWJkeGdEamg5SWtIZHQvQ2pIRW1DSU5nVXFaaXE3?=
 =?utf-8?B?WEovcjR6U2NhazZzRit3dmdlOVZobmJnc250bkd1OUJwcGFweW1WMHZtVVdY?=
 =?utf-8?B?a2ZJRnRGTk9nWlVTN1VzUlJvenJXbklJK1ppTmJIbXc2WEJ0WFNOdzZhWXFj?=
 =?utf-8?B?N1RSdTkvWDlTZVVVWW96SFNPbWFBck4vSTRNVTdvSFhxSE92S3JXdENrenJR?=
 =?utf-8?Q?HoMmMiK4G5+n2ENDUlV/IXVl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313e7727-2ffb-4a73-fc8b-08dd30e1333d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 19:09:54.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYeheZHUFP/g0k58w29dVSTMmgOf1SJa5oyH8HptTzuPAHoloI8JrGb7rNIjTP9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521



On 1/8/25 05:33, Jiri Slaby wrote:
> On 15. 11. 24, 23:04, Jakub Kicinski wrote:
>> On Fri, 15 Nov 2024 14:04:11 -0600 Wei Huang wrote:
>>> +static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
>>
>> unused? you're using it now
>>
>>> +{
>>> +    struct irq_affinity_notify *notify =
>>> +        (struct irq_affinity_notify *)
>>> +        container_of(ref, struct irq_affinity_notify, kref);
>>
>> this is ugly, and cast is unnecessary.
>>
>>> +    struct bnxt_irq *irq;
>>> +
>>> +    irq = container_of(notify, struct bnxt_irq, affinity_notify);
>>
>> since you init irq out of line you can as well init notify here
>>
>>> +    if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, 0)) {
>>
>> You checked this function can sleep, right? Because rtnl_lock()
>> will sleep.
> 
> Based on the above, I assume a new version was expected, but I cannot
> find any. So, Wei Huang, what's the status of this?

Currently the Broadcom team is driving the changes for upstream bnxt. I
will leave this question to them (Andy, Somnath, Michael).

> 
> thanks,

