Return-Path: <linux-pci+bounces-13480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4C9851EA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776561C20929
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 04:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5414BF97;
	Wed, 25 Sep 2024 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pWRaRgOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1D14D299;
	Wed, 25 Sep 2024 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237346; cv=fail; b=moG4v3Na+xdCq7zC2LVBYei4nPCBIHEn67ChsITfKPiiiqkZTahrDSHObqxnuH9c6GJYBZVQ/cr1hH5lRmgxLIaFdBdtrb42XJzsDMyWjYfmxKAlw5gSN4q5FqHBnwzTzb6+fL1SYldZ8daXbNMRJTLb/dNU78m+gcrk40iqc04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237346; c=relaxed/simple;
	bh=2LY/xKGRJ402kI55DmkrZFAkLVQ9WMl+wouPJk3Shv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kil+92B7Tfpw92algEZex6uMgd7brWFhivFsYNSQDNH/DNTBchtSnX00ATKmLEKrpwZ2f2XLOVz1KJro7G8Go2S9elo802itH9ken+BJ9l8aXTOPDCOWvN3j47t75PuJsEITV5EaDHtGjJkeaS4P8ahyVGMdKiOb1Rp2mXvUBfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pWRaRgOV; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4lBB8OUCbilDaki7XNA2EhauRPOMdW+Cx+LSvCctXgiL+1D1ioOpnZakH8OpWxaLfjoEn0sdbJk/thcELZlL42vZbgOBJwVmSBuaIDtoCnhkr4Mto4lh7oClr6cwUrtU6DEs/8kHF2X4Vq808OuHM42Zo97FSphsGQKEU+gmyMUp9SMS46ePkBQA7QVyxqztaiuSQnj7D1dRFyed2hUDPcUcKUjwNDpRMJ7auoNH/C9zbt9j6zdwCXOiHQQKBKs57LHZpx9AnIlGjLZNdsgMoYiXu2dAMvwCUDCvOHLJAZnWGyrMKgoKVnEpOLNMCm7/YWXSjJUy0nZR6wLoHNVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNEesgiI5Vs4ijvmEwXGbRAJwucqHrIw9QXjWF+J62Y=;
 b=NtRmqOizrWeFBSZYEJhdg2szs/hDY2GRHdaEtG5+eAMUZNXttmEj4vQodSvf+iR4rB3kT7biM8kFgQuIQeRh1dUbtEYdWCXhM0kXTQlCNHU7tdvR13VpAmwqTtr77ttcLy5IDmTPxQ5AwbKjvGpPhh393sZOUZAgRCGUqc3EVJ5kgIs7Znmo2iVpsKjLhcEuBEPSUqGydS2+c7g0O+PAaj7GiH7qGuVKD2AtZrtV0xGOqQOqiGrTfEQ4XIk62pMm4tX6CdFGzcAG+SJwxg7s2ooWIGeNltcXpyUWUH1mHkh2k8x3q8jeiQtItbHJGsKR+rJ9XMEliFq+mBNG01yQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNEesgiI5Vs4ijvmEwXGbRAJwucqHrIw9QXjWF+J62Y=;
 b=pWRaRgOVg0T7NL1AyWAlC3OpH9Vwf/KkMjdD05CmpZYfwUMtGLTikAMuCCH8ES1XmzpWPxliPFiKbk695m/4rTOEequ0KdUsdiHEAodJHfCQQTsj9ocScCAFNE6AyKmMminBd4eX8kUhImGS7dKROeFicVuz4bopX3PV8Vt5mwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 04:09:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 04:09:01 +0000
Message-ID: <8a218293-e2d7-4a1c-9a7d-f113a68f1449@amd.com>
Date: Tue, 24 Sep 2024 23:08:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: unexptect ACPI GPE wakeup on Lenovo platforms
To: Baochen Qiang <quic_bqiang@quicinc.com>, rafael@kernel.org,
 mika.westerberg@linux.intel.com, ulf.hansson@linaro.org,
 bhelgaas@google.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 mpearson@lenovo.com, markpearson@lenovo.com, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
 <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
 <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
 <91e179ca-ff2e-48b0-813d-7b819e300dca@amd.com>
 <115efc10-60fd-436f-99b6-0b141f9585e7@quicinc.com>
 <5012908a-9ece-4c16-9d01-2633df740fbb@amd.com>
 <f3e31284-09d0-4a30-be74-34d33efe8535@quicinc.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f3e31284-09d0-4a30-be74-34d33efe8535@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: fad4c9fe-21db-4e9b-8f6a-08dcdd17c94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QngrblZCb2xvYldVU3NxWjBpZFFmMWhabXZUTllRRlFRZjV6N0lqeDV4ZkE0?=
 =?utf-8?B?S1J6UWNKeEd1b2QyR0Z3NTdZTFFZODg0dGNKMXRxL2w4SjVlbEhld2s3NU11?=
 =?utf-8?B?TDhSQlZXM2JDZ3Q1Zk9JUnZ6VmVjUkllaXBmVVFwU3dqU2ZFYnhHbTh5MWVn?=
 =?utf-8?B?VEZWSHB4R0NrT1F1dlhYY2JtWnp6NEw5OFlCT3p0amNLQWV2c3ArL0xNUVUw?=
 =?utf-8?B?M3NpcVJOQUJ4NXZ1Zy9NYUVzaUJVWGI1ZmxsYXczVFo4Tm5kUThrdmE1c2Z2?=
 =?utf-8?B?OEh2TU1ocE5UZGJpVlhVcGRWcXlYa1hTVG1IMWFnZ1RwY1ZSaW5sNXJQd2Rm?=
 =?utf-8?B?dEVZK3hycGdXRklLZjg4OFJPZGRjUWhyNFp6Q3MrUzFRdGFMcWRpVEpXazVY?=
 =?utf-8?B?SHFYZC9sZFNhQWhDb0V6VlVZVTBuRzhtTWtpSVpvbVFJZklJM2dsK1pYRktE?=
 =?utf-8?B?YlZPWTB4VitjaXo2MWxqM0JVVHIrT2llTTBnL2lWd1Z3VHFidFJmK2NJbUVQ?=
 =?utf-8?B?U1ZHOWY1b1R0d0E0U3p6Uk5UbkdETmZOamY1MjFMcDloNXFmVTU4MzBJUGVp?=
 =?utf-8?B?YkV4ck83Zm5xZHFreU1EeFJDNjh5NlhGMCtLM0xrZUgyTm51aDFCbUgvSkhK?=
 =?utf-8?B?V2I3dnJYdjh2YmdsUll2S2pDc2ZMdEoxSVpCUTBYR3RIY1hhcG5SelVlUDY4?=
 =?utf-8?B?Vms4dk80Mk9veWxMSDFIV1ZxQmpybnoweVd5SkhxV3cyT2ZaejBvZXNxRHdL?=
 =?utf-8?B?bjlZQjdXYzIxM2Rxd25kMVdtditoZ09SdnNoeENsaTVKWURzemNMWFR3d1NL?=
 =?utf-8?B?QmhvelAyRHlhWnpVTTl3aTF4MHZkRDdGY3RDMjZBSDYvMzBNNnRnNldPN3Fr?=
 =?utf-8?B?OEFCVm1HeDdrVFd1ZnRSWUV1R09ZZFIwNXF0cjUreE10K1BOK3BxT1FCc1JD?=
 =?utf-8?B?QmZrRGVlZlZzb2JaSlpqQ1RiZGY1TzM0bW5zL2E5aXNrc1k4QjhUeEpUSER4?=
 =?utf-8?B?czhqOVdtMEFIN25EeThVT25tMU1PMGswd2ZQbStLQW9tbXdzdkJCTFZGV2Ev?=
 =?utf-8?B?K2YzeTRxYk1xOUtkZzZJUy91M3JVcndNOElSWlF1Nm5CQUg4cWQyMjY1dmJB?=
 =?utf-8?B?YVZRZEtYWkRrUUcxMUJBa1hXSUFNZTcrdERYdkpvZ1VWWnJyVWo5TjhhaFlV?=
 =?utf-8?B?ME1qeWtlUUw3eEdoRlZldmN1UGtaNUsyanBUeHhqdTFadjhycUE4M0YwVzhL?=
 =?utf-8?B?Smd3RWgrR1EzV0h0UWNyb0hQSGpWb2JRdGVKUGluaU80ZVdSZUw1VDJTaGQ1?=
 =?utf-8?B?MU5MM3N6TVcvVkloa1R6MCtOYjJxNWpBSmdVUGRxcTZhekVmTklJMFAzYnhY?=
 =?utf-8?B?YVh1VHl0bkRoYlZHd1hCN01vVVN6WDRXYVVqQVZ3QVhqOUtUa3g3MWo2ai9J?=
 =?utf-8?B?N3MvVVZ2WFJhWHIwa2YraCtqSmMxT2hXY2pRRWFSU2t5MWFmV3VpRmFRV2lB?=
 =?utf-8?B?RGE0WWRaNEpJT1dnRmlYSXlOUEVLWHk5dnYxTkY5WWZQakpzREJqRDV5WW5B?=
 =?utf-8?B?bzlZay95d3RsamV0UHBGNjB3WXZMTmYxOG1VSmprUFZpdzlxN3VYT2ZkZWNh?=
 =?utf-8?B?Y091Tk5icVFBL1pqOWNtU0xyWmphVllETXRGd2ZQdGh0UHJUY25DNEUwT1JW?=
 =?utf-8?B?azhEOExLRmtoZFl1UTdDQ3BlaUxQQmF4QkJKSndiNkE4bjJPaDg4aUYwaWl5?=
 =?utf-8?Q?rpS6G/i4QpkN8k8u03a6o+Trev2x3Ql9KuNkBmG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmxjY21PTTRjMkNqZTVlOEwyWXhUb1cvRVdHd2hwSExFWngvNThkNlZCUndC?=
 =?utf-8?B?RHdOUU5MQjJzb0hpNjdlN2RjYjNETk1FYk5YQmZTeWxmTVlNY0cxM0cvRUNV?=
 =?utf-8?B?S0MyQmtTQXBvY2lrZ0JEODREVEQ2Y1BsNlFRWFVBNTJpK3M4ZFVNWDFiQmJP?=
 =?utf-8?B?amViVmlHZjh2bzI4V2VCUHJRMVgwNGU4UjlBNzFnZTdKWklNU2lLS1U0YVJn?=
 =?utf-8?B?TVBFK3diUS9CWjhpZER2RSswV3R2MWwxV1cybEdObUxYRmFGMytnZ1NJcHRz?=
 =?utf-8?B?NDAvVmJBVDFjYkkyc3dObytHQUU1NWZ4QUhjNFRvc2pMMGV5SkRRM2gyK295?=
 =?utf-8?B?MzFnMUZYOGEzZVNBeEMxUklWMTk0aW9BNkNmMG5FNm9HWWoxQXpIYnloeHl6?=
 =?utf-8?B?VysvM3VBQnZQbDFseXU5MWx6RG1zTzRPTWVnZDZCWjNaN29LQmJQaDE5ckp0?=
 =?utf-8?B?WTA2T0NWdDk3YUROZkRyMGRuMEdGM3J4Z0NQQWI1UUhrQWozc05QOGxyNDdE?=
 =?utf-8?B?cHRuWXR5S2NwaUlmL2YwcTJ5aDVUSUJYelZHbVVOTFg1MWN5Nit4WUFsbi9R?=
 =?utf-8?B?UkJxYVNjV1E2dnBIT0ZUUmxaQXlBVFFhOW5sU1NwSmdqd1duYXhqL2ErRjlk?=
 =?utf-8?B?cE9jNGtrNHRzZjVUMW56RjZucEhBRndtNUtGK2w2UDJNN05WTzJ5MnBCT2Jj?=
 =?utf-8?B?Nmc2YkFPaGU0WjlkWFdzditYbkJ2V0JNOUVwaFdFOWxPby9vSjVabG04MC8v?=
 =?utf-8?B?ZHpRN2hrL0V0Ly8wUGpxTHJoUFZ1RFg5elpFRE9LU2REOEt0MjV5SGpYVTN1?=
 =?utf-8?B?NjROSVZXMFhYSkRrL0dvMkJPNCtiYzhpdDdtc292K2RScjJhV011QlRUdU1D?=
 =?utf-8?B?MVBwSjJMb3VaaHRuYlNEOS9LVFBQQ0ptWkU2NEx5T05wYUkvdmc5bFpCNE1t?=
 =?utf-8?B?dTZ1UEJsZklKakRPbDEwUlY0dVhITjRiTTVna1lZbWVLMGRxYXNvUUx0Q3Ri?=
 =?utf-8?B?aHRGN2FYN3JiaURKMzJYZk9NMElkY1ZNZHpTa0p4NnZEa2l5REhIWTdLc0xR?=
 =?utf-8?B?MEJGWFVjVWdaVkFJNlArZmdNQlRXNzBNMTNhT2l0aUZYbHhFMUlybzRRWldr?=
 =?utf-8?B?YkR5dHhDMFF4WU5UdHZqbVdiOTM2RlV5bUFQZStweCtBTllCeFRGRitkOGNB?=
 =?utf-8?B?VHRDSDRnM1htVG9jTWREa25mVmgxa2lWc2E3aGVLNWw1VVovaGYvQlhPNXFm?=
 =?utf-8?B?WEt1ZjRZMUg5anFSV1RtM3c5alhETnpzeW9Hb0NpdGw0NUtGdkxGU252Y3Jj?=
 =?utf-8?B?M0ZkYnd3cmZaSG81VWhYeUJxY0IwQlNPTUlSZnQxQ2JNaHVubmJxbWdDOFpj?=
 =?utf-8?B?blJobnlkS0pnckQ3T05oMGw2Y3pkWnFnU3RvMGxzKzN1MVBpR3dWL0p5cWQz?=
 =?utf-8?B?Q2t0VGpocGVaVlpUaHVvNEdXemF5aGpqVGRBTThTVVM1TVpRR0pWOGd5Z2wz?=
 =?utf-8?B?VXUrNGFDU2hqQjRaeGsybWpqVk96dHk0eVc4YkgzdVVVN1NYNytpNnJ6cGtz?=
 =?utf-8?B?akhSQTNMMFlKNVB1VFRrZkk5WUFJQ2JTQzFoaUcxMmZGNHlKZGZMVVI0cTl3?=
 =?utf-8?B?TU9JTjAxTEI4d2pqbjZJN3RUeUY3aGJCam1jYU5GbllMWVJjSUNpTS9YeHMy?=
 =?utf-8?B?dmN0US9EUVRNcS9oYmZpSFcvR0pQeU5CTkUzcHpHR3hjZ1NOVmpCT1VBZ3VI?=
 =?utf-8?B?UHRpUXBCR2lLcEFWNXQrN3pETTRhOFREWlVuSFB3T2M2bUJDYWNOTFNyS044?=
 =?utf-8?B?QS9IRjN0eFVIZ3JTN0NuMjdWbVliSUlHRHFuYVlhUVFoeFhRNGhhUUdIRkwx?=
 =?utf-8?B?R3Z2NXhMTTNIbjBXKzFEWnQzVmYvRVo5UStVZklKVUVqTDNYRnhqRGhyZUVD?=
 =?utf-8?B?dTd4aTZaY0xIa0FBeGl1WnBhbXpMVTlML29WTlpHVS94SWJwYXErZjVqbXR3?=
 =?utf-8?B?b0Zzc0VtUG80MVdPR1V1OU5UYnRjQjRqK1FsRUEzRCtYUTh6OWRlUThuVnh0?=
 =?utf-8?B?TVdBcWoxenE2OENQR043ZmQrRE1jbFFGMmxoZWVUb2ZrQThKM1RzUjNMKzI1?=
 =?utf-8?Q?ewnPJZcNzglIStsFMetglr40+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad4c9fe-21db-4e9b-8f6a-08dcdd17c94f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 04:09:01.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+SoeOjUt0j5MXLvbT8byhhlCxxwapOifeJtfaFh2uZz06yoehmmnl7PRFJ8y53QuHZb5uYHFV9nWWtQQqSszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

On 9/24/2024 23:02, Baochen Qiang wrote:
> 
> 
> On 9/25/2024 11:46 AM, Mario Limonciello wrote:
>> On 9/24/2024 21:18, Baochen Qiang wrote:
>>>>
>>>> Yeah that's what it looks like to me too.  The easiest way to confirm this (without a schematic that is) is to look at the _AEI / _EVT in the SSDT and see what is notified when this is active.
>>> seems GPP6 is notified, does this mean GPIO18 is NOT bound to WLAN wakeup pin? but instead it is bound to the PCIe root port?
>>
>> There is a concept in AMD machines called "GPIO mirroring" where the status of a GPIO pin is mirrored into a GPE.
>>
>> Particularly GPE 0xE is often mirroring AMD GPIO 18.  This can be changed by BIOS though, so Lenovo would have to confirm it is the case or not.
> this does not make sense to me because in the test where ath11k kernel module is removed, the GPE 0xE is active but GPIO 18 is not. if GPE 0xE mirrors GPIO 18, should I expect GPIO 18 and GPE 0xE to be in same status? I mean both active or both inactive?
> 

Hmm, good point.  🤷 for now.

>>
>> But it could explain why you see GPE active.
>>
>>
>>>>
>>>>> [  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
>>>>> [  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>>> [  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>>> ...
>>>>> [  899.826378] PM: suspend exit
>>>>>
>>>>>
>>>>> But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:
>>>>
>>>> I don't believe that just removing the kernel module is enough.  Can you physically remove the hardware?
>>> not possible, it is soldered, not a M.2 module
>>
>> Ah this makes it a lot harder for a debugging.  Is there option in BIOS to disable it?
> I will check that. But to make it clear, by 'disable' you are meaning disable wakeup function of WLAN?

I'm meaning disable WLAN all together from BIOS.  It will drop off PCI bus.

I don't know if Lenovo BIOS exposes this, I've seen it on some platforms.

> 
>>
>>>>
>>>>>
>>>>> [ 2640.849342] PM: suspend entry (s2idle)
>>>>> ...
>>>>> [ 2650.806234] PM: Triggering wakeup from IRQ 9
>>>>> ...
>>>>> [ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
>>>>> [ 2651.467880] ACPI: GPE event 0x07
>>>>> [ 2651.467961] ACPI: GPE event 0x0e
>>>>> ...
>>>>> [ 2651.848848] PM: suspend exit
>>>>>
>>>>>
>>>>>
>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219286
>>>>>
>>>>
>>>> Is it possible for you to put a scope on the GPIO and/or PCIe analzyer on the bus?
>>> it is hard to me -- for the GPIO I need the schematic which is not available, and for the PCIe analyzer we need hardware rework for that, but I will try.
>>
>> At least from WLAN perspective, it should be well known pin for GPIO even without board schematic, right?  So should be relatively easy to look at with a scope.
> Ah, you remind me. We can check it with WLAN wakeup pin.
> OK, so seems I have no option but to scope the GPIO.

Yeah; unless some other guys on this D/L have any ideas here.

