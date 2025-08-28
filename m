Return-Path: <linux-pci+bounces-34978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10CB396C4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84CB163BE9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15C2C21CF;
	Thu, 28 Aug 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y4yGrFmI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5991F4162;
	Thu, 28 Aug 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369172; cv=fail; b=buzytVwjnyNRFVe+3y4FSHEfREg9zkc7PZHfNsqoExRwMTpiIy7YOYobJr9jwvK2f9Ptkw0ej89xeFk9uT/RRxSYf4b3Yju/3npa7AI8jLzldrKIJjJXinQyofZp+N6pXtoW0k0KF9gbIPFq5JpghDmM5TI4WzsJlr2KHdHtvII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369172; c=relaxed/simple;
	bh=Rn+h5/Sk4OvZMKloUxwe2A+XDJ9IjyT9pDjzxEY5lxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3Y57DIZ1cD5dJ/Hm5Gom5XMWIvkFVQ0IrcsOhXC1Zb8RQ3YK70lLYPdG4juTS2NCiyKYY92o4lYs8iDUBjjnntw4uVuZnp09w08Op0AmIs1rdjIGDH5swTl1p6cIcl267XS4ju+BOVbVq/B+NQtxsW/1qkCaGUDWCdwfOqiInA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y4yGrFmI; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0DHayqpyUp1aWtuThrED1Q+RsM+jF9XO7nEy6FiIDnJCmtzjFPAgbEBFnES/+94m983aMUUlG/LRCjWDsg0X+QACDWGzuwBH8NpJ2rq9Q39GOkBORfxfJhBcsU6eiS62GEwqzbbidxzg1UziK53pG1ArEenRzRgd61WaAIK5KahhzmlK+K7PvWSJLCcWNz+UFYSfCZUBBQiNsXc/1i2Z9qwfIDmHxszTpeQWrCYwCltJwX4pLCFwF9r1xAW9U+4XcNBR3ck5P6hUa4XK14WEyCFRc70gMOXpt3sbPIq3DSb5yisT4oj9JP/7k13+dPiptVjCjzDtN73zLN3Pccthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULEgByW1yKDPClKzn0QHEXIcawlOjQfir28oazc+8No=;
 b=sVrOL1uK4DGHh2z08USY7ZUo19NQ+MLFPsVkW9zQNGRFR6RjBRy3Uhq/+0HxfEZCY8AIT9JI3ZlGUcLODrYgkLBhvmr3MljwPWhgcU9oxcziNH9u7OftnOYV/eehh0BFN8WWBH2xCYszyyQ7DJcmQ9rFPO2wR3hVXbQQKbKdVl5EFyFkLDxLnrX/8AN9amsZcNyeB6bGpMYsZtJ2I8aTHbi9fTRra6Eh9eWmH2BdvLMjzGdmSKvffXgBoloTTKwzKMh1UfF8m1Op+gAyMTPZ+VrlMN1bY3UtGmWw0iSeom8oSfvd4F1BM0Lz9NQsHadigrIMINCr7AXUhG1MkLTpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULEgByW1yKDPClKzn0QHEXIcawlOjQfir28oazc+8No=;
 b=Y4yGrFmIWuqTAKs8oXXx7hWmXsqIow92RrvNhopGxgPWcaNyjE36oSle4BFMNyEExml5vrLg3TWz6s3apC7TzO2E+zGpfU04OKvu0XqMOLhqKRm4bFn8HtR9XxcTMittnrvH9uBufihr29D3UqFAR9/2+5Wpxi87DWW/Yh8O9dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Thu, 28 Aug
 2025 08:19:27 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:19:27 +0000
Message-ID: <43c373b4-6ff3-418c-93a0-f679375f117e@amd.com>
Date: Thu, 28 Aug 2025 09:18:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/23] PCI/CXL: Introduce pcie_is_cxl()
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
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-9-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250827013539.903682-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f18a29-6d0f-4660-f2d1-08dde60b8e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0EvVGlPNUxkcDFOM1dZUjN2QjNoZWF0TmlTZTJ3NWVQTC9ISENsWStjTHRy?=
 =?utf-8?B?VlNtNU8wb2dnYlVraFdpRWZzYzR2OHhMZ1Z2akkzKzRWNzdrc3JsaXZRZzBx?=
 =?utf-8?B?bzhNK1NJb1ZuTnRqbmFSNWhaMkVxQlJ6QStFWlBheml2MXFZYVVRbVVlMU1s?=
 =?utf-8?B?OFdON2M1Z1BjZ1g0NWtOdHlVMTdWYzFIOVVQQVlFRFp4OGF0ODdkZEhtckxL?=
 =?utf-8?B?R3hRYXplRTNzNzF6MXc4Wi8xU1ZMNFE3NGYxYUdib2x4R1dremp5a3Urai9U?=
 =?utf-8?B?SEsxTmZXeEdCZ25ZWnlzN04yNW5WNGE0UFJKeXI1ZHZneEtobHVhZFhha0VM?=
 =?utf-8?B?RjlrNGluOUpzNXoxMG04OGFVMTM4dWNFeS9RclRpck5mbTFCL0U2QmdGU3BS?=
 =?utf-8?B?OUJLZm1UQW1jOGlubElLTWRIbHBHMEVqMlVKbTlHN3B6Y1o0NHIzVlBsNm1a?=
 =?utf-8?B?clVlSEVTUlRYcFlGV3J4TFN1VmNsUjBzWDF6QTZRdnZGdHdlQTAzSXhYdk9q?=
 =?utf-8?B?ckNkMUxBTXFaMXVDZkJtb2ZpN3FPaTZMaHBSSk9VR3hxZndsL0Z2cmFKRFFu?=
 =?utf-8?B?ZHIxNktzbm9qcXprNk5UcFRFeWcvajBNT2VPTG9xekpvNmk0eHBzbmJ0YkpL?=
 =?utf-8?B?OXdwUkJCOEJRSDlzU3crSzRWaTFUMlZLbWlRbzNIbXJZYWIrcmdNOTBPWnNj?=
 =?utf-8?B?Sm4zME9jbmR1S2owSk1TdEMzVEh4WUVlakNlQzJoY2Nlc0syZ3gycmdzK0tB?=
 =?utf-8?B?d2lNbnJ1bWl1LzdoZncrR2NDT29ZZlhOa1hBVFArWmFuNVdmNUNHQjNraGVH?=
 =?utf-8?B?bnoyOW9tTHBtbEI3VGwrYm9ZcEZGem1zbWxadnV2T3hBZTBhOUgwU09QNlFB?=
 =?utf-8?B?dkhmNk1XQ01iRThTZ3hreDRKZjJjRFBuVUhKcHB5SWhhemxDeVh6ays3UjlP?=
 =?utf-8?B?cU1JcjkwU28rYlJna3RoejJXUmlHYk1ZY3NBbUdYYmlWcDhyMkxKblNXZ1dO?=
 =?utf-8?B?QjNmR1dDS05nTE9Yc0tLdWpEOVBwemhBeEJOU3lmaURKZHdWN0hKdUZrbXI0?=
 =?utf-8?B?S1FqTTAwL1JoOU1XS0NRU2ZlTkY1ZjFsTFRjQmxsamdGSFA3MWJpcTlKdUF0?=
 =?utf-8?B?R1MyWXA1VWpocVBERXo3ekZHTmdWVXdlbERsV0JXQys3K09RdlJpaXdxdU5R?=
 =?utf-8?B?YjBVcExsREtsMUVMVkwzZGZsTHdVVTgzVklPdjZDcnp6dVhnOWgybUcwaEdJ?=
 =?utf-8?B?TnppNlNOdUpwR1gvWmhyMnZYVmJSekRwd2pVdkJ0VUJKcmx6ZUc4UlhvNFN4?=
 =?utf-8?B?Z2hRUUdoVHdoMHJYdm4wZGtvNHVST0FXRHo3czltcGRhQmtsbUNkTHNyMFZw?=
 =?utf-8?B?WW83enZiRTdVSzNhUWF4SUhzWUhoTzQ5QnVOOVBaZ0s2UUV3cGt1UlNVSTVN?=
 =?utf-8?B?bDluaENaZHU4dlJjWEpnM0dXbzhIcHVGQWNXTVVBVVJReDJBZnkrK2d5OUk4?=
 =?utf-8?B?NmxNWFZGeWo3VkFTK1hmM1ZMa1B2SnpWK2hvcXVTODA2alViRG53UEZ2MkRW?=
 =?utf-8?B?NnB2WFlXb3oveGtuMUdEdXNMVnVSdFA4ZFJZV001U0w5bWhaSUJWT1RiME43?=
 =?utf-8?B?SnNFNkorUVdqbkZodHR2OVRqbkJNVFpVYzZLblAvZkFUNm9jaitHa0ZrTDBM?=
 =?utf-8?B?K3dYSnFFNEhsUnk0bWRaU1dsV3N1TkZ3bXVRVmRnSFdRQmprSzhzZXhDOUhm?=
 =?utf-8?B?dkN0S2l5MkhJTDJWWWpZelcweG84V1RKQUFNOGRCVkpIRTRoMnk5OUJBaUZm?=
 =?utf-8?B?TkROWHZHd0gvalo1MEVnTnpHNWluU2FkNmhRUG90bUsxVTJYRERxZlgwcjV4?=
 =?utf-8?B?ZGpIR0gzREpqbVZaRmJvM2NFNzhybGVjZjcwUVErQUU4Y0syMENVZEpkUEVT?=
 =?utf-8?Q?CvIgKGGSCIDhYnEhAzhhTl6zNjNMWUer?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU16UlNwR3Z5Mi8wRGdldGZPaiszQ2F3M1FnSHpaZlJkMVJ0Z2ROeVg2VjAy?=
 =?utf-8?B?dFRjaWlVcVVESzQvdDdyYUNyNTIvUW9FdThwYVpQZ0FaTDRzY1c3UFhONHZN?=
 =?utf-8?B?cFZxb1diZkZLaUwrSkxsdVpiejFvc0JXYjR5UkMvVGREUDA3OE9rRGJMVWJ0?=
 =?utf-8?B?OVZmZDZUL2dKSWdxenZINWpNTmNiSWozOGlhMDhuTlp2UkhUQXFpVWNPUUZG?=
 =?utf-8?B?RFVlTW5JNVdMSU1VRWk1YkVNZXNOU2x1dU51OEMxR20xeEVuTUdaeXRtOFkv?=
 =?utf-8?B?VTB3eDVFRVJoMnh3ZGxPMDIzbGNvN29xSHgxczlFbzhlYVR3am1NUHd5S3JV?=
 =?utf-8?B?NzRoLzJ4T21vMkF1Mll4RGg0cCs0YjY2b1ZSN2dtMnRCNmZBd2tnU0w1dWR4?=
 =?utf-8?B?YUN2ODJkU09wVnpURnZOc1Z3NE9xYkxKdXB0RHZiUDRRUDBRbUh5SnM5d1Nh?=
 =?utf-8?B?TUsrME5tc0VYTjdZWXBPMTFReGxyUWhUSlZWTkR1U1hycGo2ZDF6NmJvZHBE?=
 =?utf-8?B?U3kxN0FudjU5a1ZYUnhZYlRBSDl4S0VEQW8yeTRSMlhtRFhJemtvczhabGRv?=
 =?utf-8?B?RGNiUjd4NUZkVFJNQ0VIOWNTMDNCZ3BiMTFBYmg3bVBYa2JLVWxqM0NCcytO?=
 =?utf-8?B?ek41dkZ3alNVSm1Wait2TUg2N29VRThGWVhFMm96Y3hWNVZsQVYxVWxiRFR3?=
 =?utf-8?B?U3ArSkRwbys0Y0xienhISjRpbUJWRG9GM2lYdTdxVjNRUU9BcThNSmxnc0ZR?=
 =?utf-8?B?RkMxRlprQjVDTnBORStPdm83Z0tPb0ZjNXFzN0M3TExNMDlkTFJERWdHY0F2?=
 =?utf-8?B?Y293ZTRhUXJqSUtkSUNMbmM0QnpXdDB2ZFMrYkYxbGtEWHFuREwwUFVHU1Ro?=
 =?utf-8?B?Q0EwUWVuRFd2dEN1SFdlTjNkK2JVQ2tHNk5WeHROT3d1MnVJMXRTbkozOSsv?=
 =?utf-8?B?cFFLN3NIQy9ydVBkS2xyMnRjMXVUZmFXUlkzaFRwdzhIL0YzMVp4YWlja3RL?=
 =?utf-8?B?N0VTc2ZjejJDR2NpRE1oUitMYjE4UkpIZ3hVaWZEY3pGVXlnY0FzMTJ1YzdQ?=
 =?utf-8?B?aTByY1ZUQ281MU1TWjJXYjcyQVluOEJYbnJrUllvdVMzVDZlUC9TU0ZhNzg5?=
 =?utf-8?B?a3czQlB0UXloQlJEeHU4cnI5K0Q3TkhQNVp0b0V4RG95TjhCZTBPeThOT3h6?=
 =?utf-8?B?bDNrNkFzd1JLSk01ckUySlFmV3p2ZTF0bFhzOEVxQTcyaUZCM2hKUXRwNXBi?=
 =?utf-8?B?dHQwajFGajFGakZaNTZzR2syTTl0Tlk1S0pLVkw4cyttZGJIWS9ZVmFqaDA5?=
 =?utf-8?B?dWtJaTkzdzErUjR0SmNrM1lKQnBhcmxPOTVZc1dBdFlUYUJRQ3Mzb1ZRS1FU?=
 =?utf-8?B?dlNEaCtxWVp2MmhVekxHa3pHa1hha3NlTnlnamozRmRsTWhiWVdCWGd3OHNK?=
 =?utf-8?B?bGYrb1dHS1BGVFo3c2tvaU9hcWhlTmZwOEhjeU9qdnBwcitIditSSlN2cERi?=
 =?utf-8?B?OVhRSXRCNnNLakNFMUdKdW1JL3pMTk9IYXlTNUV5Y3VBSklmTUxBVEFtVi8r?=
 =?utf-8?B?b05FcVJqMnV4c3FTd003Y1B2KzRZeUVzc0syUXp2cTI1cVVHbGdsZnhrcnU0?=
 =?utf-8?B?aGljVUVCQjRnd2lCeno1dnkyUytRZXp2dVRFdThOY3AwWmszR3ptbE10bU83?=
 =?utf-8?B?aVYwRWd4Q1BIS3RWVzN2NkkwdXBCUWlCVkcrVEhCNFdEVWprc0dzNWpVbVgr?=
 =?utf-8?B?dE1iMzNzNlBPTUdiM3J0MkRjQVl1S2ptb3ZrRllNM3ZSVEJaQjNnNk15dGtp?=
 =?utf-8?B?blFCd29ZbVh3QmFxaHYwamNWY0VMMDZWVlA3LzR0YUhUSG9xeXQzNmtlZTJI?=
 =?utf-8?B?cUNmSWhRQ0pzRmI2aDdSVWdZZXFBeDFEd1B3OSszVy8rS3hxRHhmOFd0emxv?=
 =?utf-8?B?L1hXVjBIemFZN25EOFZ5cHNFY0tRRW9aZ2NUcWp4VFkrWmlsQi9KOUYrK1pX?=
 =?utf-8?B?RFdDZUJFU2lRNEVVa3dDODEzT1JxaERGOXErL1J4VG4rOVBUU1MreVRIODdH?=
 =?utf-8?B?VTRaeTdKNmNyMnpHVGRNYU5IeEJKaldkWjZoNXEzNU1YNklBekQ4Q3BiV1Nw?=
 =?utf-8?Q?hsy66X6iM2w8jh/M7npbQOT9I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f18a29-6d0f-4660-f2d1-08dde60b8e49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:19:26.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdpuLA1767nb6NjC0Gg6r4yISwe3mEGX42lZRfnUkXqbKBwA1Q67uL0q7ZyfbuqaBEVwnVJ8gFZbd8VQN9hd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB

Hi Terry,


On 8/27/25 02:35, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
>
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
>
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
>
> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
> the parent downstream device. This will make certain the correct state
> is cached.
>
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>      Capability (DVSEC) ID Assignment, Table 8-2
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


With the changes for checking flexbus state:


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


Just a minor thing below, something I do not fully understand but I 
guess it was discussed/explained previously.


> ---
> Changes in v10->v11:
> - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
>    downstream port by calling set_pcie_cxl(). (Dan)
> - Retitle patch: 'Add' -> 'Introduce'
> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
> ---
>   drivers/pci/probe.c           | 25 +++++++++++++++++++++++++
>   include/linux/pci.h           |  6 ++++++
>   include/uapi/linux/pci_regs.h |  3 +++
>   3 files changed, 34 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..b08cd0346136 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1691,6 +1691,29 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>   		dev->is_thunderbolt = 1;
>   }
>   
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> +	if (dvsec) {
> +		u16 cap;
> +
> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> +
> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> +	}
> +
> +	if (!pci_is_pcie(dev) ||
> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
> +		return;
> +
> +	parent = pci_upstream_bridge(dev);
> +	set_pcie_cxl(parent);


This recursion is confusing to me.

Is it not the parent already having this set from its own pci setup? Or 
maybe do we expect that to change after a reset and this is a sanity check?


> +}
> +
>   static void set_pcie_untrusted(struct pci_dev *dev)
>   {
>   	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -2021,6 +2044,8 @@ int pci_setup_device(struct pci_dev *dev)
>   	/* Need to have dev->cfg_size ready */
>   	set_pcie_thunderbolt(dev);
>   
> +	set_pcie_cxl(dev);
> +
>   	set_pcie_untrusted(dev);
>   
>   	if (pci_is_pcie(dev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..79878243b681 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -453,6 +453,7 @@ struct pci_dev {
>   	unsigned int	is_hotplug_bridge:1;
>   	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>   	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>   	/*
>   	 * Devices marked being untrusted are the ones that can potentially
>   	 * execute DMA attacks and similar. They are typically connected
> @@ -744,6 +745,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>   	return false;
>   }
>   
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
>   #define for_each_pci_bridge(dev, bus)				\
>   	list_for_each_entry(dev, &bus->devices, bus_list)	\
>   		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index b03244d55aea..252c06402b13 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1274,6 +1274,9 @@
>   
>   /* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
>   #define PCI_DVSEC_CXL_FLEXBUS_PORT				7
> +#define	  PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET			0xE
> +#define	    PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK		BIT(0)
> +#define	    PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK		BIT(2)
>   
>   /* CXL 3.2 8.1.9: Register Locator DVSEC */
>   #define PCI_DVSEC_CXL_REG_LOCATOR				8

