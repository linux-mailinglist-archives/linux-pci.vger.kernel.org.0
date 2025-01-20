Return-Path: <linux-pci+bounces-20131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3A1A166B5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 07:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A51163EB9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855241865EE;
	Mon, 20 Jan 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s3nNMRZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4337537E9;
	Mon, 20 Jan 2025 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355160; cv=fail; b=u/4DusaB1N8lBNNQbfhgMUe+63v3ob3PEBdyvkQIaEEuNS6990i1VIyXEAJUQY5+S3gVp04Ou3OBmmo0Jb0PNYJwq9Yc3m5ZsTV3d0/1d/t3kvI6XAaX/aDAYZMUkVT0MF1DaXSFBrER62/icNsskgpmL7F4dZ3yxZhandVp3cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355160; c=relaxed/simple;
	bh=PCX8peJrCy7JnC/N3+smjvHJsONueIZasH40oZosMkY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m8mtn8lN8SnSk3DP7WWYekpucMxv/N3XeG60NvqAO5N/ttaRZJqPbEB5CqJbzRfeAkCxpbbQWSOz9MlXSGieTRhsumDJj4GpjOWw6fs3kDm8hqrxExi2jKP1vsmGhvGBK0/DIt2cN1ZyL6YcaPI5AlQ+X8iHdTtcvLu6G35ssXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s3nNMRZd; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY/QrOCXNP0QNSjnstDV3OHY/NTEwY54wC67QfRiKhlbnwAqvKy9OU8vyzpMDzNZK19NhHBVqFvGSD5OUq/CoCTiD9gMeaLRjy60eLT69yWDZqkc/nQ3niG6GuS5uvSjmUh9rfEJRP+8/k23lvscQ8CQoLpWnnbMI7P3tYTTdnExRsBxAt3awyvia7QjdkbkTfB09N+pp0lKEy3VuSJAlHx6S/2Oxs0LIY5NUii3tKtrlMDgag1l78AsBphScbJ1IiPeLAjKvl0Iv7y7I17Tsjde3B/dsPHtPATshiwVHuXRFwEFs2VJra7ytRREFzb0bNJkELGpUCu2Xefl5RvuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIp4O2PDRygn1bSrllCQ3R//dX9qMK2LmQJv5/8HJdw=;
 b=IjrJpBby1L9F060chJEY9VXXIw30ambsR2aRfcdhYdOSVkbjEpPlV8daGbgngwxdcZt5BAtNLHyxYc9wXp6i8OurpYdpuv8BEzkHDmiPreKHRrNyecCZ/V8FFd8Z19FADoV5vEGkO8J2Hw5K+g1hxHaabVOxx8geYxC/iEUalVKmlft8AAtlRlvjzu+vUSZer0cbZerXn2KK8Mz9M/pBUIyMhW7U8QqHJ8aJx2vGgmN7PNntmztc2jO34jy+hv8XYq9mPuFnfEtnf8AAy7uCLfBnIaBKxQKH0IBSpjrCAnJUxsykdd0RuBLGL1Gi2J6WcRc4QP7lyammKKQTsvGSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIp4O2PDRygn1bSrllCQ3R//dX9qMK2LmQJv5/8HJdw=;
 b=s3nNMRZdMZKE4vqHMbGNtLdaahK8GEmppe0F/dPzE0JWOP7ape8UkEnHtxwkFF/UlwPz0wD94GRdPKrQOP57zwulLOOwZqRq7BOjiGcL261Uo0O+UEqgrn/ZopDkZIdsM+hM1Dd+sjeL8qZomLU0GlDOgG3DFUeXJwCkjUMIBJCdmAP7Zmb4S6QOIdKspSgwNoAF+oPBHPfR+2VeRFjh0Xx5eRTvP8Ou9iemfXHG9vNKogs4matPud6ZajsKYEgq4QUfKQoGmWglMtZX988/3XjfyS4LawwilucyTUKbXxuFQQ/w0G8J/sjVbJVSx6kJVLMBIkysLQqSCAtGeUnZfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.18; Mon, 20 Jan
 2025 06:39:12 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:39:12 +0000
Message-ID: <aa6aea6a-c082-489f-84df-a1fe5686dee7@nvidia.com>
Date: Mon, 20 Jan 2025 14:39:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Use downstream bridges for distributing resources
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carol Soto <csoto@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Chris Chiu <chris.chiu@canonical.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>
References: <20241204022457.51322-1-kaihengf@nvidia.com>
 <20241204054809.GD4955@black.fi.intel.com>
 <99a4ee84-e41d-472d-8935-8f2a2de837ec@nvidia.com>
Content-Language: en-US
In-Reply-To: <99a4ee84-e41d-472d-8935-8f2a2de837ec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c69987c-e07b-4fa1-5622-08dd391d26e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3Z4LzZFSEE2aXo5bHd2L2VOSGIvM01GSWR5ZnNQOTZsTW5xSFBGYTJQeXpp?=
 =?utf-8?B?ZkdLa3NRRzRJTDVPeHpyZkszMGE5TDBscFdzOGsrR3NGb1JoSG4yOWc1WUtY?=
 =?utf-8?B?ZlhqbkRDTS9WUU52N2xYTmJZbittTUExZVFCdGV2UGEzZy9sUkt6OUVoNTdi?=
 =?utf-8?B?MG9VbmY5bVdrOFZvT1ZYMWlYRmhwMkV1MytmTzVBRlRYNllZY251ZnJxR1A2?=
 =?utf-8?B?bG9BMGRLNm1vT2pvNmU1RVVBalJuYUV5YTF5V1ZCeU55T2pINVhtR2tYNWVP?=
 =?utf-8?B?M3lUV1cxUGthNElHdGZIQXVFRzdmSnRZNUloSVVEN2o2dW9wRU12S3dxakFz?=
 =?utf-8?B?bTlyQ3ZKQi92OTNVQ0t2blZJNWxFNDZQYVcxRloyNTVYMC9PMXliYVRZVFVi?=
 =?utf-8?B?OUxrQ1R1SENHc2EzL3FNNFdKbU53QnFWbkRBb0R6dytOMlhIdkc3UW5rL3lK?=
 =?utf-8?B?SnN3Umtkb3JCdWpGNjNqVEVuN201Y1VnVDRrMXpOUkpic3NiNFVMUXUyUUE3?=
 =?utf-8?B?eXdLaW9HZkRXVlVUVSsrZ3MrSmNwVys3UVB6Kzg0RWhmZHpFT3ZMV2VOUWxy?=
 =?utf-8?B?Z2RFdnBDSnJiWmFQZXdKZlpzV2lPM3lMYUVGSXVFankxOU1yRytMdjFvSjNZ?=
 =?utf-8?B?L2NXQk1IUWNKUWRnek9oaXZ1emhEWkM4YW5Zcjhaa0NDWGRxc1lBQklTVmZB?=
 =?utf-8?B?Nkp0VnFrL2NudWtlY3loU2FNeXQzWTNwM3JhYlY1THZ2SUVTUFcyam1haDZ4?=
 =?utf-8?B?WHRqQ3FnMmVYdUk3OWZDVWRtWWVRcENuY0JaVmVlazdEanE4YnVZZ3FQUFlr?=
 =?utf-8?B?YnByYm5LYi9RS1NMQTJId0VXN1pzSDdjbHliNm9Uc0xzV2pnL2x0cTBpOEcz?=
 =?utf-8?B?YzhGSzFkTHJNamszWVRmUG5aaU52bG56dFA2UDNxL0VCbUJ5Z2U3b05PcUJK?=
 =?utf-8?B?ZGhlZEJmdXZYTWZQOW5US3UxOU9HY2tYbjBpVHBieWdXdExjYXM4WXUvZ01M?=
 =?utf-8?B?Qm9VUjJ3bisvSXliOUVrWFVFdC9LU29rc1lVZC9qVVd0bnNBUmd2RWcxVkRv?=
 =?utf-8?B?bktXZXlJbmsxTUVMUUNsMHJxdkp5MWtNVEFQcUVNZkFWNHp4UVpuSkFUUXha?=
 =?utf-8?B?alBtUmRGR2JyaDViZG0rTlo5emUvUy9SNnNxc3lkWUI0ZGE5NEI1dno4VHNN?=
 =?utf-8?B?OXRuNWQ2WjdERmpkdk5vOEYrL0NGRFBWR1RscENXVFBDT3FFaWlRdnJjbjR6?=
 =?utf-8?B?RnFudjBTdTBscTh4T1IvMTg0L2dVVTZxWTRGS3hUUjhRMW50ZlprOVVibWFD?=
 =?utf-8?B?MGR2SWd0SlpJU3doUStSZENHZHhNcWdnRStTbjY1VTk0dGZ6Wi9CU2hha3l5?=
 =?utf-8?B?S3Q3V2dISjk5a0FnR2pyZDR1TXV0MjkvcDh3N3h0bUNnS3pOTFg3UjFHb1lk?=
 =?utf-8?B?Z09WenpFbGdwaXdQVktWZkM0UGpOcTFHc3R2OTM1VUw2OThjcm13aWV0WERo?=
 =?utf-8?B?NE13TS8rellrZ0lIb1RGM3hBbk1HajhQTnZuSE5YZGlyRWdIbmRWKzVScS9S?=
 =?utf-8?B?UDNDRmx0ekg1c3FiR0ZDM3BTOGVUWXk5K2grVkk4cTI0YnUzbEVMbldqNWk2?=
 =?utf-8?B?QloxOWJpTjRuM3hXQWpjaVVleGExWHRHT2hsSENPZDRoYTZyMVlROGdPZW8v?=
 =?utf-8?B?dE95WkZvUVNJeHpBVWNyamh0WCsyemJKYUE5TDd1RlVnYzFROVZrU3BWRFBG?=
 =?utf-8?B?aVc5N3VKaS9uNDk4TzRIdzR6ZG9QVXVBOWZpbjRpY2FBcGJrMnlScGlaMHNL?=
 =?utf-8?B?eU1uK0tyZ1VyTTNldGhCM2RLYkRidHZWZEtwYS9QUHQrRVc4ajUxc0ZLeFAr?=
 =?utf-8?Q?iMGgg8uMz/NKw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2hyNTc2NkcrYmxRM3Bzb3JWdGtZSlFOd0l1eVhlNEF4MmZWM05PUitKV3Nx?=
 =?utf-8?B?NFlySDlGUFdoakFnMzlrV2pzYWZMQXNTT3FkdDZ6NVAxdnljZ3hzVXJYVUJq?=
 =?utf-8?B?WEZiZW9paTBscjZQeGNUajdqWHBXNFlNV2lRN2w5RXhYcktuUCt0TktGRUFZ?=
 =?utf-8?B?WE94Ti9nQTNuQkNkdllUblpkTng4MUt2SHpDYU82blhlMmwxT2hSUzV0WTlU?=
 =?utf-8?B?bXFENzhHbE9XOEhiNk9XQkVONmJWNWxwa3lsbjNOakVDTEdDL2xGcEZlcnBi?=
 =?utf-8?B?ZU9veWhiRnR1blg4VTErYmhBVmR6bURiSFZJS0IweGUwUE56RkhFSWFuS0Iv?=
 =?utf-8?B?OXc0VmRmSFBNUExCbTR1SWhGazRLS0dXVGg3bjM0dVhONDFPMUhBVWJZelli?=
 =?utf-8?B?VVo5M0JaNk1qbTFNQ3ExSlRBeHJ1RVNPU2Y4cTBEQzBvQUM4VVEyTGh6VWVk?=
 =?utf-8?B?enNoSGZSd3BHSXFrR293WXk5eFNmazlNcHhyLzFSY2Jid3N3RGxFOEdQZGFL?=
 =?utf-8?B?N1laakJiK04rZVpGZGtka3lXQ0ZGc2hoSk8weXdjL3JSYWhXcFc5Q0pMVnZj?=
 =?utf-8?B?eWtlS1EwWjdaUUl1SjZPUGY4S3FjckZWQW5HNjQzeE5CaVR1NUExanBOTUdq?=
 =?utf-8?B?UEhma3FLSUZ1YjBrc2RvWW1tU2ZzeGtkWXdQM0NhTzdXRzVMZUlSQzNnazBl?=
 =?utf-8?B?aEw2aHlCOVREbDVvZTBndjN6R3V1dzNiR0wrVlJ4aXREU2JkY2s2UkdhOGw0?=
 =?utf-8?B?SytSNTdJYU00TkRrQ2dvaHdhZTBtQzJXWUVYTTlUa1FURytuV1NmVm5yc0Iw?=
 =?utf-8?B?a1lZQmdjL2VsNHBOVG84N0pncUtzZmxHaGVycmFvN0tOUDNRcndxNEhONkhG?=
 =?utf-8?B?NGpJbWl1bDJJZ2ZNNmdOcUZLbU4xMXpTY2owbVMvUjJadDg0S1dQMkdYWmNE?=
 =?utf-8?B?dVlnN2JYRWtvTFlFT3F4K2V5dGo4M1MyS2dDT0VKNzFJamdSa1ZpQjFIeGpC?=
 =?utf-8?B?WHMvOGdBQi95VVZXZThoRDJFYlNSSzdzYi9iU3RwRXM2L0JWNCtZaFFIV0Uz?=
 =?utf-8?B?cmRHRWdaUWFBajM5Q1cvOWJJOWZtckRBRytKQnlSZXVhN0xROStyeVIvZXpS?=
 =?utf-8?B?UGUrbGtNTUVYRVdQSEV5V2NibVVnbnpSU295V3doRDd6V2FwMGlWQ05oaW1T?=
 =?utf-8?B?QWZoaCtDOC9QbUJFd0JvMVd1U2NXV3M4Y1ZDTEVEeWJNQitndDRnRTExQTU3?=
 =?utf-8?B?UWh3V3VtQmhka1lCS3JNY2JpaHZjVW8yTlFVZWhYNEdXbUc1VEhxekZnVWRI?=
 =?utf-8?B?R3lQeTBhTGVlY3J5MXpBcXFPTnpDdVRKZFVxOElqcTVTUnNpdVQxMXpFRnhU?=
 =?utf-8?B?TS9nZHNmTmZveWhLbThOMlUyUTg0Nk9PbE5DNWc1Y3U5UTMxWTNOM3pxaXpJ?=
 =?utf-8?B?RTQ2Y1BuamVla1FqYnNacFpSVkRTVnlLWU5kSU5tM3lrREdIcXRNNEwxVmFk?=
 =?utf-8?B?bUc2MVhNZXVGdkM2eWtDcVdBUXROZzlOKzcwV1ZoZUU5SXBiOEhLRkkweThR?=
 =?utf-8?B?dms4Q3pHZ01LTUhrbS9TZnVMMWhEUlRaT3VEZUhUeVEzdmlBSnlQYTV0OUlj?=
 =?utf-8?B?ZXJ3M0ZwMUpZelcwcG5oc2dWS1ZJQXNZMEx6K0I0b1Z4NzJNbTRyT1JFd2M3?=
 =?utf-8?B?Zk1PcFlUL1d2Ny9Ua3VVMEpyZmo3d1RDM2R0N0s5L1ZjNkRjYTF1amlhZmVD?=
 =?utf-8?B?TURiL3VCMlV0T2lxa2pFb3lkU1c2dExyU1lvdjhzei93dmZkSU9CS2cwRExa?=
 =?utf-8?B?NFZzRzhsK2ZmWllIZ21YUjljaldxU2FhTGZVcHA1T0FzU05VV0pCZHdKWDhL?=
 =?utf-8?B?SEh4TDgxQWNTdWRDRHYrZWcvTWZEOXU5S2FNUVZzWlp3MXhKWHduRDE4VHA4?=
 =?utf-8?B?MlIvS214U09lbk9qMzdWVmJUcGdvRzZrUFUxbURZK3FsOEd4SlppUEp6UmZ4?=
 =?utf-8?B?d3NjVWNqcm8vc3p6UkZ1bkFLd0ZwSjduc1RWQlg5R1l4azhWTWZjelBoYWJ5?=
 =?utf-8?B?UWkySXhXTFNKeGo4QTFqYzJTSlBnVUI0WWd4d0lJR3NRTHIrL1o3TVExTFRK?=
 =?utf-8?B?azgrRDBKcm12a1hTMmx3QjdRbWppVVp6TmsvUGFkbmxsNTI1Y0paZXRHMEhB?=
 =?utf-8?Q?OuoWu7iZTJu2m5XivbPZZQwlR+B1Z5L6Hla0rY7jU2J0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c69987c-e07b-4fa1-5622-08dd391d26e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 06:39:12.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkRv6e3ODcGyW9tD3mmt8Iptc28elLHFpXVprfy4AYAcZbi7s6593piubM5pa58t5lFyvsxsFE1dmKgDm9Ck3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598



On 2024/12/18 7:12 PM, Kai-Heng Feng wrote:
> Hi Bjorn,
> 
> On 2024/12/4 1:48 PM, Mika Westerberg wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Dec 04, 2024 at 10:24:57AM +0800, Kai-Heng Feng wrote:
>>> Commit 7180c1d08639 ("PCI: Distribute available resources for root
>>> buses, too") breaks BAR assignment on some devcies:
>>> [   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 
>>> 64bit pref]: assigned
>>> [   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 
>>> 64bit pref]: assigned
>>> [   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: 
>>> can't assign; no space
>>> [   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: 
>>> failed to assign
>>> [   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>> can't assign; no space
>>> [   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>> failed to assign
>>> [   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>> can't assign; no space
>>> [   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: 
>>> failed to assign
>>>
>>> The apertures of domain 0006 before the commit:
>>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>>        6300c0000000-6300c8ffffff : PCI Bus 0006:03
>>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>>            6300c0000000-6300c1ffffff : mlx5_core
>>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>>            6300c2000000-6300c3ffffff : mlx5_core
>>>          6300c4000000-6300c47fffff : 0006:03:00.2
>>>          6300c4800000-6300c67fffff : 0006:03:00.0
>>>          6300c6800000-6300c87fffff : 0006:03:00.1
>>>        6300c9000000-6300c9bfffff : PCI Bus 0006:04
>>>          6300c9000000-6300c9bfffff : PCI Bus 0006:05
>>>            6300c9000000-6300c91fffff : PCI Bus 0006:06
>>>            6300c9200000-6300c93fffff : PCI Bus 0006:07
>>>            6300c9400000-6300c95fffff : PCI Bus 0006:08
>>>            6300c9600000-6300c97fffff : PCI Bus 0006:09
>>>
>>> After the commit:
>>> 6300c0000000-63ffffffffff : PCI Bus 0006:00
>>>    6300c0000000-6300c9ffffff : PCI Bus 0006:01
>>>      6300c0000000-6300c9ffffff : PCI Bus 0006:02
>>>        6300c0000000-6300c43fffff : PCI Bus 0006:03
>>>          6300c0000000-6300c1ffffff : 0006:03:00.0
>>>            6300c0000000-6300c1ffffff : mlx5_core
>>>          6300c2000000-6300c3ffffff : 0006:03:00.1
>>>            6300c2000000-6300c3ffffff : mlx5_core
>>>        6300c4400000-6300c4dfffff : PCI Bus 0006:04
>>>          6300c4400000-6300c4dfffff : PCI Bus 0006:05
>>>            6300c4400000-6300c45fffff : PCI Bus 0006:06
>>>            6300c4600000-6300c47fffff : PCI Bus 0006:07
>>>            6300c4800000-6300c49fffff : PCI Bus 0006:08
>>>            6300c4a00000-6300c4bfffff : PCI Bus 0006:09
>>>
>>> We can see that the window of 0006:03 gets shrunken too much and 0006:04
>>> eats away the window for 0006:03:00.2.
>>>
>>> The offending commit distributes the upstream bridge's resources
>>> multiple times to every downstream bridges, hence makes the aperture
>>> smaller than desired because calculation of io_per_b, mmio_per_b and
>>> mmio_pref_per_b becomes incorrect.
>>>
>>> Instead, distributing downstream bridges' own resources to resolve the
>>> issue.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
>>> Cc: Carol Soto <csoto@nvidia.com>
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Chris Chiu <chris.chiu@canonical.com>
>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Is it possible to pickup this up in 6.13 window?

Now 6.14 window is open, is it possible to include this fix?

Kai-Heng

> 
> Kai-Heng


