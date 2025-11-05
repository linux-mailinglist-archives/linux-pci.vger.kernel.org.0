Return-Path: <linux-pci+bounces-40320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA1C347A8
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 09:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942163BD42C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63CB239E9A;
	Wed,  5 Nov 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQ/onGAs"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAC23B605;
	Wed,  5 Nov 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331461; cv=fail; b=iJyQHlMcgSLGN8G7DBaD9MhHI7PFvxFWlgzBig/8Fsb7NcQKUp/TycOVjzPCvsYQrvhG908Ya3cS6Ql5I5IpNx1YjRJFq4Ss/4pOIn14abARr87FyxUSlumJJfhm+LcyxAWqIfJebpmc8ZW3WGuD7S/SRA1eglwFdxf6/pgueyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331461; c=relaxed/simple;
	bh=F2j2bN5tOORsk+UtnPU0D0N+QOhhV3r2CLmwBbmn5VM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WGRyeq/wtjlw3vh9zsq22dwHqlxIpVG4Esf55ppNBUs4IZCiJlrFjGQPSuAt4N0zCUpEHrgy5lrGtWJSKk3CYOsFRj6Bm58sMX+OQvthTG3TE65OwlpLJgeuYSG+nnnIPC7M/vKtUKHDXp/QgJ8EKIGhQOyItiqeObzPlLEU+S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQ/onGAs; arc=fail smtp.client-ip=52.101.61.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bums83ud3S0Uqw3B4W/NW0joCTUI+OAk530A+8HHR2RAG0dNemD5yY4z8OZ0t4T4aKFx1CS13XXC3YdMBKgzUbljVBujFwoNhV2p9TvUSFeyjHZwGZG8/xI68IWK1OM4vB9XsvNIc5AzzZASjoMCJM3kJ2LlQzPxY9TivYeEDttztcQfwk0+Ro0m14KBpGu6ZTxY+CM65hUTwhP/pGYLMZo9GH0QJsSteladcjLk+4RsOmIZSDgtCLEyd9Vmo86ioe1PqJ3pt+Z3PR5SfcCznxc5BSCdgIwEPIWeyDuKkwf+G69SpOF604TnZWx/1N7mgQ5gQe9EOxnHC3N8PM5Z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4q0txgax2kuYLnBJh+SL+9ZfuwpvhxQAzBGsODDCN4=;
 b=sfgneD1PONw0xl/lMhy0HgigUrVdtYHNWvA3G8Pz9WhEJvJF7fsvELANNCVkfie8yKO+R2AhxD80E5c9hXCqY2hHBhhYnFoWCk/ykKTkVYdl3szRI7kt5BAHwAw3LX50Qn99s3EGg1kLE0oedg7Tv9rKmJYdIPxipftzzqCZBCeXiSFRPGprA2MIl5rAc/sdyz+L+4i1TmlZWrc+uCEQENl05lCR1pWSn5i3lmEFYHEHYIpKhqXNFRhNGD3xWJxu/V5oOB8FyUVMm0cfuhGXQ2BIjbE4h7IKPCTZtcGcWK8ECditYH9Me/q3H6TSGpzHN3o/57RBOKhj5DGfVCkctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4q0txgax2kuYLnBJh+SL+9ZfuwpvhxQAzBGsODDCN4=;
 b=SQ/onGAsrl0mD2XaCW2mCn8E1wCRKk5uJGK1MWHVMsm/D+nPbzKQgxEx1UtL7r0CxhVFN35lL0qqbnfoIAzhOconJTspwIdjz1J2nUfvNqfCQc8J0N7VvJJectySzLA56ojKyjy9mviKBL4BQJzvIYWMuwkq6Ne7NbOyPlQDbEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:30:56 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 08:30:56 +0000
Message-ID: <142695fc-324a-4916-a569-e11d8342805b@amd.com>
Date: Wed, 5 Nov 2025 08:30:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 13/25] cxl/pci: Update cxl_handle_cor_ras() to return
 early if no RAS errors
Content-Language: en-US
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-14-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251104170305.4163840-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dac533-b0ca-4993-5ecb-08de1c45a3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjkwZlY4TTdNNW82cE1mOUt3d3k0Z1dzZURFT2VwNTdrT1ZqRFBLbDBMQ29C?=
 =?utf-8?B?RUR4cE9vSUpIMGdkdHZPdWp0MWVRUVM0S0RtZHV4NVYxUElkYjVVRmY0VnRO?=
 =?utf-8?B?TFp4M1J2WVdsMDdPRGJPdUR6S09SK3VIUC9EZTlISm1RbmkzL2dLZkR5ckRF?=
 =?utf-8?B?SGI2RE9kMWdsdHM4aHpBL2prb3pDbzd3bVcyNFNGTlFDdTBwUkoyU2pOTWQ0?=
 =?utf-8?B?M2htU0owbGdRWmlRTGV2VXNDNDkraEl5blcyb1hIU0VpNFVYOHQyT1NvRnVo?=
 =?utf-8?B?ZW5KUFRDWEtnU1hNa1NqYmlJaVowUmFLU3MyN1VMSkxubFVmQ2NEeGdQd2JO?=
 =?utf-8?B?TVNCV0crK2VQdGtKd0FnVE9BVENkRVJYbmU2dzM3dDFYYjhkTGlENFFOMDlG?=
 =?utf-8?B?azdEdHc4U240bTdsQU9RajJvQS9qdnU4UkdkNzFrUzIxWkw2a1BnQ093aE9L?=
 =?utf-8?B?OE5DYnFmQnhiOFBCcEZxY2VqNnlaakpEV3ZWNjU5YUIwTWVzM0ZmcTkzSkE0?=
 =?utf-8?B?NS9sV2VYZ3l4K05OeGlpaWVGenFVK3JwTTBXTE9VQnI5b3VmLzQ1Y3N4S1hH?=
 =?utf-8?B?NzMyeGlrbTFtWmpibEhCU0o2UjlFVmtyWk15MVBwbTRWQVBPSUEwY1o2Y2lr?=
 =?utf-8?B?VThnV1VGVXYzQjlJNWx2aSs2WXo3ZGp5dTM3c1FWaEJGVkxFc0RheUtKU3Bs?=
 =?utf-8?B?QXQ3eDZBT1k0eGVnTmVkbEVCZytTRlcvYlhCZU1wZ0pXZk9hcVRGSGMyYlZY?=
 =?utf-8?B?bkt0a3RqZXI0REt5K1Nsc0hUalBMZzY1SndtSENHdzFBQjJHQnFhNUFjY01l?=
 =?utf-8?B?L0hUMVUwSFNzcG1rQlpBeEdHUzgrVEE3SW4vU0w5MXdOWDQzSkp4bUREcURL?=
 =?utf-8?B?eXNkNFRxeFJ3WERKa3NGQ0RiQmkyb1lIV2pKcTBrSS83bThZcnpadkVqN3hB?=
 =?utf-8?B?QUwrY1gxQ0l1eDF1QUpRakVQS0gwNWlITWxPVWkxeFF0ZExrRDNOT04wZ3R1?=
 =?utf-8?B?N1VoR0VYaTIwTUJ4WTFuSk5lZVdwVWtlSFphZm0rU2p6NVZaRlM1Z3p3WW8r?=
 =?utf-8?B?WmhkV3NDbmVnMHV3bFdaQ0MzK1lqMnk2WHp2djlabitmdzdGRVNEeTNWaG9i?=
 =?utf-8?B?RGFrQWw4ZGR5UC9uVG1MNStlNFJGTDM2dklPZ2ZWV2prQnE5S2lOMEZicHlr?=
 =?utf-8?B?cXFMbVFXTHZpbU1IN0NSMWozOWMxc0VhZEdKc2gwU0wzNWNyNnUzNHQ4V2pS?=
 =?utf-8?B?dVhWUlorZWxya2RMeC9XcWl0K1VrOEFyMmI5cHFMNzFHZnFoSWJpdDI2K25z?=
 =?utf-8?B?WmJRZFJHNDFTcExMN2VtRU5HQjg4Z2I2cFdIb3ZjYmVWNmozN0pwYWFSalFx?=
 =?utf-8?B?N0c4ZStBek43SFFUVkxRKzUvazNRM0RQMndQZTZBRG5LakNCTFdnaFFIMDY1?=
 =?utf-8?B?OGtzTFdscXhUamFVbXJQVlRLT3dDY0JxVUtwNFdXb2ZqSU9UeGExdjN3bnNo?=
 =?utf-8?B?WWVWZ2ZrVDhMa2U0cTV2NThDM005b2lsaVdMNkxHMENFd1J1Z1A3UlJyQWs0?=
 =?utf-8?B?RjhhaFhCWW43VzlqM3cyOVg4dXdHQjc3UldPYkUwLzBMcUFPOFpxaTJJVVU3?=
 =?utf-8?B?ekVKNGM5OG5ReGJMdjUxYXVPTFg4cjd2bnE0OEszLzZRN0wvc2Z0c3A0VmVO?=
 =?utf-8?B?UklSdVRYRG5JSjhXMXZVLy8wbW1xTlJrR0duUFpPNzBCbTU5WUZzYU8wZkI1?=
 =?utf-8?B?b3doTTNWeUQrakJmd2lWc3JNdmV6TExUVm1kN3puUlVVQkg5ZWIzQUg2SHBJ?=
 =?utf-8?B?MXo4VjFFMXBOMGlmUGdEWVg4T3JzM1RqTisxZ2J5Mld2WGZvaDUvYlF4ZmIz?=
 =?utf-8?B?dXpPcXhJQ28rVkRTYzBUNFd5Y05hYVgxV0xoVGZLMHBVRHBWQmxrQ29sTUta?=
 =?utf-8?B?TEtTUFp4L1NmM201cGxsUVpjZ2grbGFGUlBIenZOcUJrcTJkaGJ0S3NQWDZt?=
 =?utf-8?Q?GpqgiFpzAYxHGgwxwbImZK4tHkxEgo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2QwYWpJYndiRll6dU11RW1HeFYyRTA3dE5qTXQwbXBEMjhuNUhDemZiOXQ4?=
 =?utf-8?B?QXZzTWNkNHlSU2NOQjZicFZ5aWRYOUM4VFdCL1ZBMG9CSzZnMFh1RHpGRzNv?=
 =?utf-8?B?MUxZSmZ3MnhBUzZ2dWc3aW5ML0tBSEJjWFR1VjFaMFk1cFg3TlBSSmlZUWtr?=
 =?utf-8?B?UURPYVpvdndwSGMzN0pnY3NHNWhRdDA0eHNYbjdFcVMzUGhiNk9kQlY5Z2gr?=
 =?utf-8?B?NXdTY053a3I2OStRbll6YVFkWmxDUWxpRytzVVRZRkFnUXRxbmZpaCtBYkpD?=
 =?utf-8?B?R0Q0Z0Z3SndibnhxbmplNHhCUmZ0WWtJOEhwYzlLL3FNWk1IVlBrYUZKbDUz?=
 =?utf-8?B?bXl3U2Q3MDZVNkI2SDBqd215YUl5azZVeUlCZ1dRVDdldzZmcHlNMWI0bHFY?=
 =?utf-8?B?Ty9yUnRlaC82ZHlTZFAzSUduMDBicjJJR1l3cVVMT3FtTjVxSjRJT25Sdzhp?=
 =?utf-8?B?MFNtak9LS29Xajlra0dybXNRMFF4UWpmYlIxYzdYRHlSVHVJV0lMSWdORWsr?=
 =?utf-8?B?WjFVWUxXTXhkclg2Y1dZaWRIb2t0Q2xxd3oxT3d4d3NicE5IK2FBUmQ0a2ZI?=
 =?utf-8?B?WlZVdENBWnpFRDdnMzlvNnpDcWVGb3VDS3Z6U2pMM3EyU0FQM3VVMlRDS2sx?=
 =?utf-8?B?NWRBWnhXVFh0VHVOeHNSV1pleEh6bC8xLzRWMUczdVZqK0kyS0hXaDJLTHZ1?=
 =?utf-8?B?STR2dGRoNE1Gd2w2VW44SktOYlRMaFFTSlp4a0xYa1p1N1AvL3VmWDhQYSs4?=
 =?utf-8?B?OG0vNnYvVnNUbW1KeEp2RXdNZ1Q4SVcwNTQ2bGp2T3dlZlY4UzVoUjRKcWFT?=
 =?utf-8?B?bkxFanRFN2pGZTFnZXlFNld2d2xlc1owTmRqWXpQSm1xY05xbWxreW5JR3cr?=
 =?utf-8?B?TzRTdzdHL2hsTGlNMUJBY1d4dkV3VVFMV3VXY2N6NTZhY1Zqcm82Ty81aFR2?=
 =?utf-8?B?R2ZVYkxQR25jNElpajYxSGV4dzQxak1XK1FtbjVIWm84N2xZclZmdnM1bTNQ?=
 =?utf-8?B?aFBzOTBMclJUVnVmMzR1cUZlQXdGVHh3em1KZFp5NUQxKzU2dzFMNkVUT2di?=
 =?utf-8?B?ejBseEttemh6YTFHbVFtdTdVQjhobVdqNjA0VzRWcTdIbFowWXY4MjVhbDJr?=
 =?utf-8?B?YTQ5dWRHbG9jTmtmL2Q1YS9qQXg1R3pxa1F0NmpxSjJpdUxLOTJ4MDNsUnJW?=
 =?utf-8?B?dUMrbWZWa2hXNkVpNExSeGdNMjB1dzNqcjRERkIzK3FwYWVMZktsRmNNdTd0?=
 =?utf-8?B?UURBYjJLT2d3ZXphY1JKTXp1T0VVSHFNVnZRWHVDY21zdmZxT2pZYXZ0QTVY?=
 =?utf-8?B?K0dUM1RnNWJDaThWbW83NVorbFNoVkpWWjY0U0dtSU1ZSGwrV3FZZm40bS9T?=
 =?utf-8?B?amNPU0dQSm14d0ovMkcrcUlOaEVnVVgxYnlDcWREOWdlNVdLTkJvOVR3UnNp?=
 =?utf-8?B?SnZYQW9CdzBTNW15UzlJNUIyQkRnQXdsc3lkNEVZYXlpUy9XbmdhZ1c1a1ds?=
 =?utf-8?B?UFIrblEvbWVsV3RLU0ZoSGg3YjBmODdYK0VjbUpDWWZoSVFXOFJIZWZPMS9v?=
 =?utf-8?B?N29uaFF4bG1MMm5hMjNLYjFZRVBoQzArMUxERk1pWlJ4d0puYjNFTUdOYmtM?=
 =?utf-8?B?OVhNZ2dYbzFGMjVnV2NWblVIUDl6UlE5NElhMWxsQXVEQlFLZlBaNHJxS2Js?=
 =?utf-8?B?NDVzb0ZUUjBQaytZZ3dzK3RiM2JsWGV6MlZEdnZCTFY4dGU0dWM3N2RMbUNO?=
 =?utf-8?B?MnI5bi9Td0tFRVBydlJ1d0Y2dzZEczlVY0JsS0FHa0NGdU90eWtHZmRHLzVo?=
 =?utf-8?B?U3ZKVGE4ejlmWjhZNVJtNnVEWk1jV3RudmJEZnFiU1BhSzJsS0V2YjByNmcz?=
 =?utf-8?B?ZTZ1RklrQ1VGd09ZMi9RTnJuNk9JU3hGMm03NlBVQkMwVEdlcW9nQ3BEbWRI?=
 =?utf-8?B?OFhMRlNBelZ4T3ZYaVhVL0JtR1lGcTI5K1RYN2cybFNpQWNHRm1ISXc3UUFv?=
 =?utf-8?B?QW5jSzQvSGZnem1CRkhRdWI0UzBFQ3Q4SGkwcWs2MHljTTBLRmxQYjdybjhH?=
 =?utf-8?B?Ly9ZREUybTlsTEd1bkc5MUhjeWlkK250WVRWL3IySTN3aHlGNnhSZWNqMGdL?=
 =?utf-8?Q?xSzCWWKfnGBzUy+Ck2qCMnFmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dac533-b0ca-4993-5ecb-08de1c45a3f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:30:56.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP43LF0g8oLef8HTKr6Umdc8+fU26cix2FYBwUJMOTcyTQxOm2t0t+hrw1e1totQy74lRS3K6Bk/IWyemxgwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908


On 11/4/25 17:02, Terry Bowman wrote:
> Update cxl_handle_cor_ras() to exit early in the case there is no RAS
> errors detected after applying the status mask. This change will make
> the correctable handler's implementation consistent with the uncorrectable
> handler, cxl_handle_ras().
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> ---
>
> Changes v12->v13:
> - Added Ben's review-by
>
> Changes v11->v12:
> - None
>
> Changes v10->v11:
> - Added Dave Jiang and Jonathan Cameron's review-by
> - Changes moved to core/ras.c
> ---
>   drivers/cxl/core/ras.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 599c88f0b376..246dfe56617a 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -174,10 +174,11 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>   
>   	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev, status, serial);
> -	}
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	trace_cxl_aer_correctable_error(dev, status, serial);
>   }
>   
>   /* CXL spec rev3.0 8.2.4.16.1 */

