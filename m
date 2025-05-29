Return-Path: <linux-pci+bounces-28523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB23AC760D
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD461C032E6
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61D1DE2C9;
	Thu, 29 May 2025 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wu9YnxAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA978F3E
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487841; cv=fail; b=SOpReYDsJM+Vkz3zLwmIQuQZHELmv1uwTyEg1Rnothbe5QdsVOejDmSMIISaHF48kAYdyuW4HZgIFkq03kTkDDdxSzJOv42jbpNHLhwnRse5A1qU+jNJK0Km/+r4MBCm89j4Sf20J8fbKpB/Gy4WOD13qZzuxeghyKkiG2qH9fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487841; c=relaxed/simple;
	bh=JlryxYKuBpQ4ZtlvnvRLu9kysosKJrDI73fklKhWNCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6po/QMcz2oCbxLVVFludA7WVGW7b0XSL//fKuuA0ylGqtlCLehkgUGnV262XXowuAT3o7jQDG2CnQ3CEnhfX/0RheGFyF1nMVxbSz3EMpT4nqBJBokmcUNxukOsCXLruerNt1RWrzuAdb0V17ObIePr/OOjjwwppUv3JmJbTZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wu9YnxAx; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbM6z96QLFzqHD3ShbFh2hK7l4fu2UFKZp84L5b1CaVVexHfrABq4/yQy7VcR4h6HNTdYZ3I6X+shEpYQ1fTnWsvucp5MdS0rfioVpCKIHh76Tnf7KGDxHd/AA7MXJRDGXbVchcGEKDoHn/OAs5O+YkGhAbNuR8H84Pilh+epCz/UhO1BajCMmAXw+Yy2YO9ycVqTKoK06rP+8vonSIsqOjz2+0swS//eGAzuwSWVv9bi84Pdc+QQ0RC9o2bDNUuj/e1XYbrFDIQOBwmhMgy8cXssfUIxeo2CrpboPD9VRSN/71sI8w4uxZBsOPwt192859Xu2CmHHEM577zwzpzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBl1CLNqg2+rLZ6o0nvCyS4SA7ow2NnkjUOjLurEI0M=;
 b=Bx0QplHlxW24UGWap4CJZErR5XBFvG0lmueKRJzwrLIDabISNRAqwVYuD44+Gc7OXO3dR6uQC2X+A3vNtuimkH2g03RE5NC2e7G4hoZQJ52Sf600f+vUwT+bH+eBKUkperx8a/sGZoXMXpV1c4Z2oMCNhRnSw4eMAU+puaEuN0J/EWexzyw/5b3WLwXFQmNde6JgFSrS0abx+U0YOtCtRy6+OLj0S685S7WTg+drLUk+Qw+bJ+GzBTSk36wLT0imUWWsCNNgf6a5eKAgSvaOHUMCVFQ+xAiQQuFhK8GS+jsallLQNmnj/Fi4CM+93NNGi6Dpt29kwgvihMCtGIvUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBl1CLNqg2+rLZ6o0nvCyS4SA7ow2NnkjUOjLurEI0M=;
 b=wu9YnxAxspKxNN1nkNuQ+RViepcL7+2p+LJm8lDi/SYmK5SmQwdvyib56RLggnU+Zu1eLk69XJ11hGijgrwKqSQnitdQIXAAjnFnbre+HI92FuyxLEjmExHRNHsqdx0RUyZiujIB6E9TlCan4Aj3wAOq6oXceNDyJctqr2HhUKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 03:03:53 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 03:03:53 +0000
Message-ID: <b96cb784-6097-49af-ae3c-bf469cd609de@amd.com>
Date: Thu, 29 May 2025 13:03:46 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050> <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050> <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com> <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com> <yq5abjres2a6.fsf@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5abjres2a6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::12) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: dd56376e-23a5-4e8a-9eda-08dd9e5d714c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVVyZ2UwTWJxKytZU2ViT1NrSEZBNVBvZHV3amRlYm9zenhLekpPdzZ3bkVH?=
 =?utf-8?B?SExXdjNxSEppWVptUTFhL1p5MWx3RE1LQUlhTUNNTjZBNEVvWkVUSldFZCsw?=
 =?utf-8?B?bDBFeFJZZnVYV1hqS01vTGZ4SXVZY2l0Z0Vwd1gxekpMWTdBRXYxOHNFUDJX?=
 =?utf-8?B?b2tEaURGVXBvb3hYZzdhUkJqSjNhUzI3K2V3eWI0eTFMRHVmZ1RYYVJxOWRS?=
 =?utf-8?B?UkJiYkRFTC9YWUpyVW0rNVZHOVRsMTY4cUZqRVByd1dtUGZhYlhtSVFOWG1k?=
 =?utf-8?B?bWpiWDRjS0dhZm9IaUN0VUMrOFBOelczSEVVU0IvSnY5K3hHSnMyWWFLZEpy?=
 =?utf-8?B?d0plWmpQbDV6MzBlQjFyY1N1S2JxNmpMQXdMM1pTT2pLMjk5WXYweHBleUFa?=
 =?utf-8?B?OXh3YnNETHd2WFpOTXU4VCtIT0Vka0poS1R1RFdEZUFNSmYvbStMenBjVC9H?=
 =?utf-8?B?MmdyMUJYSWRjZDdEOCtxZHNRUGNkQkJ2YTBOcGY5SnIwSkJiUXc4ZDFYRlpp?=
 =?utf-8?B?K0pVR3ZRNjZNL3NyVFF2OHhmLy96dkZmTlllMEhXbWdEK1A2SWJxQ3NQb1Vw?=
 =?utf-8?B?QjdtanJEcHVPQkZSdGg4UjJoQkl2dWx0L2Y0ZE5US29zOGpwSTloUldxWEYw?=
 =?utf-8?B?L1JWVXkwdWZ0ZmtSZFM1bmc0UUhFbHZRektSVUo0QWpGS1h1UU9yTkpGcUs2?=
 =?utf-8?B?OGx6cS9WbkJTWFpybXE2RGJHUDJtNnpyeGNUT1hqdmNUNW9jZjFIU3lGc2Rl?=
 =?utf-8?B?WlpkSFdxTldoS0hyR1ZPNGduR0VHWjA5anpES3FCVVhrdG10MTdOTnZncEd1?=
 =?utf-8?B?dVNFMm8zQWx2SURHckJIZy9NWFZCUjBjSU5mdzY0WHhWODhlWkJUbGxtcURW?=
 =?utf-8?B?WmV6WDY0MkNmVUlVSTcwVEZXRlI3amR0Q1VPU3FFOGY2UnFKMHgxcDdFZkdK?=
 =?utf-8?B?Q1ZkbE9ERmtoeTJPSG5ZZ0tOZGVaVkdBVTIrV2RqN0R2MW5wUm8yWkMrWnA5?=
 =?utf-8?B?RGNtR1p4RnhBM2g3N0pxaFFaa3l6V0VhaEoxWUN5NHdCL2NNT0dFcHZWc2VG?=
 =?utf-8?B?VW5WSC9BaTBmOVZXWXRWYW5qYVpyWEg1VjRBMFhVUkFKWTFZLzExd1h5eWE1?=
 =?utf-8?B?Rm9Wc0ZwTVA4RXJXQXMxVzdFU1FiMFhLZnBEa0xvNmFJWHBsUFVicG9VWDU2?=
 =?utf-8?B?REpNVVM1ZTlwbi95dDhlNi9JRkw4eU5RSThtUDg4U2VHNGk0ZWRJTEV1THp2?=
 =?utf-8?B?Z1lRYWUzQnQxYmxaa0Z5OU1EazhBTTAwZ3JXZTQ0VXM4Q3FuV0RlSHZSbnFu?=
 =?utf-8?B?aWcrNG0rcWJ6QjFtcVJRSHh6OEp3WkFNdmd0S212WGNVL0dBWEtjWEN3ZVBQ?=
 =?utf-8?B?KzRBTXFHL3JCR0tYOEJnUzUvRGFrcU1iM3V3RnI4SkhhbnBNcU9heno4MDhG?=
 =?utf-8?B?dE0yTXlCYVh2RXJqSEdZRTZoeVI5Q1ZLVGp5T25mRDdwZzhCSXFxdW5VWUph?=
 =?utf-8?B?aWdwSmZMbG1tMmMzV1dBUkZUY0J1NzUwdE43UlZIWWtzQkw4U3gyeVd2NFJh?=
 =?utf-8?B?VVBVcFdYMEs2T3dqSFg2Y3lrbmNxeFB0b011aklaQWNTUmNoVGt4dENEelBt?=
 =?utf-8?B?YkRpL2RjMnc3MVpNZHJMVkthYS9nVUZFbEsvWi9iT3YvSW9oTTJDZDZNUnVC?=
 =?utf-8?B?bGdGcXF0ZkRwVDM0bDkzWHExUU9tWkFMRTdVcUMrM2R0THh6LzZWdlRjMEtQ?=
 =?utf-8?B?WXBEajl1a0dlUHFkQXNrY0dwNEZ2cGRqVm5SamcxNXh1NVJ4SHU4bkZXaVFP?=
 =?utf-8?B?WGNLSDRmV0tKY1hMSzJNY0dHY2I4eWJ1S2gxZE5yZVBScUtzTE56MW04cWhu?=
 =?utf-8?B?cXlzZi9yb1NPQU5JSU5ldzM4MnVpYnR4c3pKRXJTNlJRZmN3eXROaWdNOTJx?=
 =?utf-8?Q?tSrVxC5fb0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THdGZG81RUZGV1E5YVBUVmJXdXZBRlpMQXpQem5hZFJEaXlici81V1ZUOGlS?=
 =?utf-8?B?OWJOd1V0SWI3VXF5bU5BM0JwaWp3N01TVmJyemNIaytRNmo5TmRPaXdUM2dy?=
 =?utf-8?B?cVBWTHh1U3hVNU5qdUtrMk9XT1o1Q3YrTUF0UWRtZmZHWmZHQUIxRnZiRWND?=
 =?utf-8?B?REpYWnBZV25rekJ5MFJtZTR4bGt5cGlsRVBFU0s4dzZrUDBLVFVnUCtwMXJD?=
 =?utf-8?B?OXhlU1ZzaG1wc2hxajF6NUpleGFWMjRNUEJjeU5KSjFzR1YwYitMcFpoblRY?=
 =?utf-8?B?T1cwTFlaaU9PdGcyeFROeUc3bE1BNUJYV1JPYTFEbWRzMTcyLzcvRlJsSlRo?=
 =?utf-8?B?TnptU2lmY2xORXR0VytBS3hxNE5TN1V1YkRNUkhMdmNqdytYaWlnNnhuVmph?=
 =?utf-8?B?ZnVYS0p5cjQvdmR2WXZOWEQ1NnM4MXNRM1k5VWw4YWNvZ0hFM3F2N0o3anVG?=
 =?utf-8?B?d2RtK1RaMnY2Snk2a1FOMERzZWcvSDV6R1k0cEFkanJkQTNyWTJLSjBLUDRv?=
 =?utf-8?B?SGJvazFPeVVsVFFoS0VNcmttRElpRTlyelo1WnFlcDUzb3hHOGFSVDBNUlZ6?=
 =?utf-8?B?V3dsUW5MQXhBZ3A1bXhSRU9GV1pyOTR3eWxvMk9ENU4zUEFmWjNRdkxvNUNq?=
 =?utf-8?B?RlN1dURvdFZLRG9vUXVvS3NhL013MmlsS0M1eTZ3N3p2eE5WaWZRblMzV3dZ?=
 =?utf-8?B?WTc5WE9zNUtkYUlxYTRQV2t0cVpyOU9vNzhsdnJhN0swb3ZYOG9PbkJkWWlH?=
 =?utf-8?B?VlNJaXJFRVk4ZWlXM0FpRlVzaElVRjZNUnJtSlJqV3RPZ05DL3JLM2JEVHds?=
 =?utf-8?B?QUhSUXpOWWNNUEpWMklETkE4L0pnWElMdzVRZU9Rc0c3a1dLQjUzdThEV1JM?=
 =?utf-8?B?dEVaS2dWKzVRWE1wZnl4bUxrYUZWb2dmSzgyZjRCSXExZjlJaE1zY2xCblB2?=
 =?utf-8?B?ZEZXUkxhMHlSeXpaNFlTWkZlQ3U0aTRWUmVlNW1tMEx5cG1IWG5pQ3JrMjBG?=
 =?utf-8?B?eE9OSENZdkJRR3hpeFVxdkxKeTluTDZoWjhUNFg1R24xMjRhSVZYTjFGU05K?=
 =?utf-8?B?SnIwTkVlc1V4djlFNW5hZkpwMmowMytBSnJDVlhYYnJrMWRKY2Nub3JJMDFu?=
 =?utf-8?B?Y3NVUGVZTk9sMUdBMHc3SlJWenpDK1pubXBCQlc1Q2VJTDAwZTcwVHJXcThT?=
 =?utf-8?B?YlNOMDMyakc0ZHlLV2VKV2UvTnl2OXRDd2o0aDlyeXJheC8xTnVNdHdxZWVK?=
 =?utf-8?B?L2V2NzFZaThRNXpGT3NwTGY5K2o4YlBpbE56ckNJVDIxR2pNdng0L1JyY1FW?=
 =?utf-8?B?TjFVQ0N1bzVjcU1CZ2NxZDZJY2d4a0h0cjV3N1h2VjU1WXpFeXhqUGFjSDNx?=
 =?utf-8?B?eW13VkJGTGJndzhPaDA4eU1sQ2JReDI3Q2h2TTR5cURDQVdxUlk5MkdYRGdE?=
 =?utf-8?B?eFJxV1g1Y1U0S1BFY09IbFJCWUNoa1VHVTArYTdWMk91OGJqTUduYzdwQ3Y2?=
 =?utf-8?B?emFYaXFXT0F6dE5ZbVVPK2tuekVSRUhieEVDYktVbERxRjVmMU5GRXp6MjZ0?=
 =?utf-8?B?K1kzRnJGUSthYzJnWkRHaTRxckVqQVBuYU1ZMXl3dEZrUGQ5ZXZiTkk0S1BB?=
 =?utf-8?B?bzE4ejlGUktnWk13Ykg3MGVRQ0FEaHRWakRmcjc0NC9MWVZsRWx2dWQxMnhp?=
 =?utf-8?B?RHhORWRJMGczZ0psaERMTlE3dGFkSVlQT0gxSmRoY081eHE1dkJtY1kyZmx0?=
 =?utf-8?B?eTdBbXVwaXhGVW5LSjdBdUUzQ3Vpd3lBQVdkZ0x2MmxoMHBtM1p2TTI0d0NZ?=
 =?utf-8?B?MDhmaGh1RkRreDVDRThBN05TUWdMVDF2bTdJOEhQN3FKdVRib2kvWnptMnpC?=
 =?utf-8?B?cW5ycUU3SUpZK2FhRnJKSC9ZeHRSSWtXeElSM1A2Wkp0cnhEQUlIZVorMjhN?=
 =?utf-8?B?TGhudEtoaWZuaDhhRkZSWjhDT3hsMHdRbzl1cCtZSG9JVFJkc1IvVHh0UDRm?=
 =?utf-8?B?TWhYbmtxTG5KdkZlUjJrZDRDbm1XK0tqYVEyd3dvMDQ4ZWdWMXoyOFZjL1h2?=
 =?utf-8?B?MEVDdTU4d053Y2hiVjRqUWFMcWtBemFwSG45Nm94WmNXNy9GZEJWM3EyWVNU?=
 =?utf-8?Q?Xxz16HlcZwyYMT1C6YxhCp4Pg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56376e-23a5-4e8a-9eda-08dd9e5d714c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 03:03:52.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP0MnDCQs/ZjFkm2ES8fXVED7c5mqbMnqJ8QXXgdiSUtXFpFLPTZaiIWmYj6yW5OdrS8wLTSPJ/mwjb2vf4i9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018



On 27/5/25 21:48, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 27/5/25 01:44, Aneesh Kumar K.V wrote:
>>> Alexey Kardashevskiy <aik@amd.com> writes:
>>>
>>>> On 26/5/25 15:05, Aneesh Kumar K.V wrote:
>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>
>>>>>> On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
>>>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>>>
>>>>>>>> On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
>>>>>>>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>>>>>>>
>>>>>>>>> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
>>>>>>>>>
>>>>>>>>> pci_tsm_bind/unbind() are supposed to be called by kernel components
>>>>>>>>> which manages the virtual device. The verb 'bind' means VMM does extra
>>>>>>>>> configurations to make the assigned device ready to be validated by
>>>>>>>>> CoCo VM as TDI (TEE Device Interface). Usually these configurations
>>>>>>>>> include assigning device ownership and MMIO ownership to CoCo VM, and
>>>>>>>>> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
>>>>>>>>> TDISP message. The detailed operations are specific to platform TSM
>>>>>>>>> firmware so need to be supported by vendor TSM drivers.
>>>>>>>>>
>>>>>>>>> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
>>>>>>>>> to TSM firmware about further TDI operations after TDI is bound, e.g.
>>>>>>>>> get device interface report, certifications & measurements. So this kAPI
>>>>>>>>> is supposed to be called from KVM vmexit handler.
>>>>>>>>
>>>>>>>> To clarify, this commit message is staled. We are proposing existing to
>>>>>>>> QEMU, then pass to TSM through IOMMUFD VDEVICE.
>>>>>>>>
>>>>>>>
>>>>>>> Can you share the POC code/git repo implementing that? I am looking for
>>>>>>> pci_tsm_bind()/pci_tsm_unbind() example usage.
>>>>>>
>>>>>> The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
>>>>>> Stage 2 patchset. I need to rebase this series, adopt suggestions from
>>>>>> Jason, and make TDX Connect work to verify, so need more time...
>>>>>>
>>>>>
>>>>> Since the bind/unbind operations are PCI-specific callbacks, and iommufd
>>>>
>>>> Not really, it is PCI-specific in TSM (for DOE) but since IOMMUFD is not doing any of that, it can work with struct device (not pci_dev). Thanks,
>>>>
>>>
>>> Ok, something like this? and iommufd will call tsm_bind()?
>>
>> yeah, I guess, there is a couple of places like this
>>
>> git grep pci_dev drivers/iommu/iommufd/
>>
>> drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
>> drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
>>
>> Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
> 
> Getting the kvm reference is tricky here. Also the locking while
> updating vdevice->tsm_bound needs some solution. Here is what I am
> improving. Are you also planning something similar?


At the moment I am planning getting/holding the KVM reference in the TSM:

https://lore.kernel.org/r/20250218111017.491719-15-aik@amd.com

but may push it even further to the AMD TSM (CCP, the firmware driver) as this where I actually need the kvm struct to get GCTX+ASID from kvm_svm; Intel folks have a similar intimate knowledge sharing between kvm_intel and TDX-connect. Thanks,


> 
>   drivers/iommu/iommufd/device.c          |  4 +-
>   drivers/iommu/iommufd/iommufd_private.h |  5 ++
>   drivers/iommu/iommufd/main.c            |  5 ++
>   drivers/iommu/iommufd/viommu.c          | 62 +++++++++++++++++++++++++
>   drivers/vfio/iommufd.c                  |  2 +-
>   include/linux/iommufd.h                 |  3 +-
>   include/uapi/linux/iommufd.h            | 16 +++++++
>   7 files changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 2111bad72c72..79d669064044 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -165,7 +165,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>    * The caller must undo this with iommufd_device_unbind()
>    */
>   struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev, struct kvm *kvm, u32 *id)
>   {
>   	struct iommufd_device *idev;
>   	struct iommufd_group *igroup;
> @@ -221,6 +221,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	refcount_inc(&idev->obj.users);
>   	/* igroup refcount moves into iommufd_device */
>   	idev->igroup = igroup;
> +	idev->kvm = kvm;
>   	mutex_init(&idev->iopf_lock);
>   
>   	/*
> @@ -1009,6 +1010,7 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid)
>   	if (!hwpt)
>   		return;
>   	iommufd_hw_pagetable_put(idev->ictx, hwpt);
> +	idev->kvm = NULL;
>   	refcount_dec(&idev->obj.users);
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, "IOMMUFD");
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 80e8c76d25f2..dd1c87500a74 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -424,6 +424,7 @@ struct iommufd_device {
>   	struct list_head group_item;
>   	/* always the physical device */
>   	struct device *dev;
> +	struct kvm *kvm;
>   	bool enforce_cache_coherency;
>   	/* protect iopf_enabled counter */
>   	struct mutex iopf_lock;
> @@ -606,13 +607,17 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_viommu_destroy(struct iommufd_object *obj);
>   int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_vdevice_destroy(struct iommufd_object *obj);
> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
> +int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd);
>   
>   struct iommufd_vdevice {
>   	struct iommufd_object obj;
>   	struct iommufd_ctx *ictx;
>   	struct iommufd_viommu *viommu;
>   	struct device *dev;
> +	struct kvm *kvm;
>   	u64 id; /* per-vIOMMU virtual ID */
> +	bool tsm_bound;
>   };
>   
>   #ifdef CONFIG_IOMMUFD_TEST
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 3df468f64e7d..9959436d0d42 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -320,6 +320,7 @@ union ucmd_buffer {
>   	struct iommu_veventq_alloc veventq;
>   	struct iommu_vfio_ioas vfio_ioas;
>   	struct iommu_viommu_alloc viommu;
> +	struct iommu_vdevice_id vdev_id;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -379,6 +380,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 __reserved),
>   	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>   		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VDEVICE_TSM_BIND, iommufd_vdevice_tsm_bind_ioctl,
> +		 struct iommu_vdevice_id, vdevice_id),
> +	IOCTL_OP(IOMMU_VDEVICE_TSM_UNBIND, iommufd_vdevice_tsm_unbind_ioctl,
> +		 struct iommu_vdevice_id, vdevice_id),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 01df2b985f02..9182353f7069 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -2,6 +2,7 @@
>   /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>    */
>   #include "iommufd_private.h"
> +#include "linux/tsm.h"
>   
>   void iommufd_viommu_destroy(struct iommufd_object *obj)
>   {
> @@ -90,6 +91,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
>   		container_of(obj, struct iommufd_vdevice, obj);
>   	struct iommufd_viommu *viommu = vdev->viommu;
>   
> +	if (vdev->tsm_bound)
> +		tsm_unbind(vdev->dev);
> +
>   	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
>   	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
>   	refcount_dec(&viommu->obj.users);
> @@ -134,6 +138,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	vdev->dev = idev->dev;
>   	get_device(idev->dev);
>   	vdev->viommu = viommu;
> +	vdev->kvm = idev->kvm;
> +	pr_info("Assigning kvm 0x%lx\n", vdev->kvm);
>   	refcount_inc(&viommu->obj.users);
>   
>   	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
> @@ -157,3 +163,59 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &viommu->obj);
>   	return rc;
>   }
> +
> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev;
> +	int rc = 0;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_bind(vdev->dev, vdev->kvm, vdev->id);
> +	if (rc) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	/* locking? */
> +	vdev->tsm_bound = true;
> +	refcount_inc(&vdev->obj.users);
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_put_vdev:
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return rc;
> +}
> +
> +int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev;
> +	int rc = 0;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_unbind(vdev->dev);
> +	if (rc) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}
> +
> +	refcount_dec(&vdev->obj.users);
> +	/* locking ? */
> +	vdev->tsm_bound = false;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_put_vdev:
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return rc;
> +}
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index c8c3a2d53f86..3441d24538a8 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -115,7 +115,7 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
>   {
>   	struct iommufd_device *idev;
>   
> -	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
> +	idev = iommufd_device_bind(ictx, vdev->dev, vdev->kvm, out_device_id);
>   	if (IS_ERR(idev))
>   		return PTR_ERR(idev);
>   	vdev->iommufd_device = idev;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 34b6e6ca4bfa..79a9bb0a7a00 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -51,8 +51,9 @@ struct iommufd_object {
>   	unsigned int id;
>   };
>   
> +struct kvm;
>   struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id);
> +					   struct device *dev, struct kvm *kvm, u32 *id);
>   void iommufd_device_unbind(struct iommufd_device *idev);
>   
>   int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index f29b6c44655e..abcdad90bfba 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -56,6 +56,8 @@ enum {
>   	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
>   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
> +	IOMMUFD_CMD_VDEVICE_TSM_BIND = 0x94,
> +	IOMMUFD_CMD_VDEVICE_TSM_UNBIND = 0x95,
>   };
>   
>   /**
> @@ -1038,6 +1040,20 @@ enum iommu_veventq_flag {
>   	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
>   };
>   
> +/**
> + * struct iommu_vdevice_tsm_unbind - ioctl(IOMMU_VDEVICE_TSM_UNBIND)
> + * @size: sizeof(struct iommu_vdevice_tsm_unbind)
> + * @vdevice_id:
> + *
> + */
> +struct iommu_vdevice_id {
> +	__u32 size;
> +	__u32 vdevice_id;
> +} __packed;
> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> +
> +
>   /**
>    * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
>    * @flags: Combination of enum iommu_veventq_flag

-- 
Alexey


