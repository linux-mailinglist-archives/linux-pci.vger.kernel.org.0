Return-Path: <linux-pci+bounces-6676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1898B29AA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 22:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CAE1F23125
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B5153504;
	Thu, 25 Apr 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YtJLjfk/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96923153583;
	Thu, 25 Apr 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076647; cv=fail; b=LK1/kg9am8ha+6AztiRlQCyOBFevamgBBroO4+BPTmYrD1K1qk2t5yfImhGSK1xAmu9xLvRNSOP/BT4DOC2eb5kNM2uSHRd8UbxBdLWLwqbeYoCB5mLmF5Kx+jKX1Zl2Qr4/93aUvuMe5diM+Y8gh1CSINoj/QtRQ8jAJglVS0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076647; c=relaxed/simple;
	bh=B9eg2XPC+Z724uprcUBI8KLGNJ0omzdGNsZCkRQgLrU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=d1o/euTRvWEZgXy7Pk/eh/MApl1aB4KtQjKhCwhcIdlcmN5rX5+xkbmy30EoZAOl1GAYPF+yQJTw0fKqgtvU5mU6rAtjEM5KXO5gjf/8Xo5o3bzt4b6UOvrA2ZlosZZPzcN07VkqRkdA/UiNdsHQGyavIbj9zEuV4DiRaiK5CPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YtJLjfk/; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/2kvp3KIyifNpQXrZCs5b3Eo14mhDDwWVpXKdPEzUzR3kCqbVFBSdz3XnrgZomjxEqOWD+UNe/46j4p8n1fx+Wc6HdjesTXQIMncJSBztxQPJR3Hq+uWKLOohmSt2ivOY8DCnscU1thZ59SGwj5NRe8b5T4WeoqJNYox9qV9i/1dE6EUCywYF7tmlhcRuBL6GPErrvJR7+p6UFTPStruRyXDehqqJt3vCNZP+z0x2CeEk8J3pfTxc+fWTtiDJWGtjnBEG8PHgQ+ayyGh5WMWKAxn2HXxtEMJzwjbJFWZT9qE49vG5vwI+MvYO9zcP2mkVqkG2AxVJnAsS74Vr++kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEWaWx/RNZc2vd2wopSq2PuHllBjDs0WpWygIlfBepc=;
 b=WE4YCQGO1bZkD9qDx3F1xN+jSAzLEu4FDgd+2kfZjny/MSLl0+wbpPYRuEhMLDtxOjGbPi0ZpTIBysVegU1QtM2+ge+PCGEJTieRAYfkGYRr5vWeV6zHcKXXyKEiGsca6A8Q2d7U84H+YHtxPdWh/Rfn3zxd/EPgDeyySAKvullXxnVYNFlLQNcgqtm3dkHO36fn87JehxpbhP8Wy7W4zFjJkG5KVkX8mp9EXObSB+Uwi4CJGWZArw43BloOSYVlX09ppN18oUIfyXQKXsWlNzcDfwqYaAVCBz/I/md5oT33Y9GvGSnMOg2FEtVx1hDQa7yRHZj6Pa6Z/qDad71FJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEWaWx/RNZc2vd2wopSq2PuHllBjDs0WpWygIlfBepc=;
 b=YtJLjfk/AKUczcu88pSHnAU3FRc4KTSUWSrYlxzONp/4gsS+x/DELcRWZWpXr3CPRAvvORdCfe1QwYJWeQm1sVOkMJ8PWduohTdVlPtInpJoruhwJmbfSRnsaU7F4DaIdW+LQr3bU/nAQpAd947isDzf5yKtoSHfwr1G/a74sU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 20:24:01 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 20:24:00 +0000
Subject: Re: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>,
 Hagan Billy <billy.hagan@amd.com>, Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 jon.grimm@amd.com, pradeepvineshreddy.kodamati@amd.com
References: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
 <52290bb0-97bc-aa52-6606-cc734a492cc1@linux.intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <4852519a-c941-aa0c-2912-f6383c708ade@amd.com>
Date: Thu, 25 Apr 2024 13:23:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <52290bb0-97bc-aa52-6606-cc734a492cc1@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0c1088-97e3-44b3-389f-08dc6565a422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1owemJydzhmOFk2Q0MzMVBjQ2FqQlJSWlgvNlQwYzk4R3BERTBWQ0V0MmR4?=
 =?utf-8?B?TTcxUTFwWWd2MWpsbEtRckU1bHlaeHVvbTBHeXJ5K0JDZHhkd3hWVEkyYkhs?=
 =?utf-8?B?TnRFcmFhNDliOWJUeVB5Q01OQ3UzNmZpREZlQTVhMFpROG9Rb3NqSUQ0VG43?=
 =?utf-8?B?WTNpTVdkaXFXZll0THlIbnh6aDc4OUswdzR5WVMwb0x1QVhZeW9kdTVwRkFn?=
 =?utf-8?B?Nm40b2ZvWlZtNEFUS0ZpQ1dDSURVWmxzb21xeTVWOHlMN3ZIWHo3QWJqeWNv?=
 =?utf-8?B?b05La1Zvem84UzhXeEFUSVE0akhBMWs5Y0ZrVTc0WXdISzZIK1UzcmtLM1pu?=
 =?utf-8?B?Zkd1WHlDcGZpazhzYlB1bnY2U3JqN011TWdxTndaM2ZDNDRka2I5dGZWSHdB?=
 =?utf-8?B?MFc3eEoxWUdqRjU1RjV5bFBSU0ZKSVAwYloxR05qRmZDUlRQMGM1NERBd1N6?=
 =?utf-8?B?OUtjaG9TK2tGWGI1NzFpY3RyVkluZmczUDROMms3WDY4em5tdGMrbU1va3U0?=
 =?utf-8?B?VG1CcVhjaFgxSEFHbnpUbGdNcjlhTnZGUXExMDV2WHJMcTFraXJDb29Wd0Nk?=
 =?utf-8?B?ZnJGUVZVL1BBS0NKdml4OWVET2pVZWdkVkhGeHNuYTZJTXdVRCttOXFMTEtY?=
 =?utf-8?B?QWFoYXBMTHoxeDBMUkE3OXpOSHlQSkxTMHNabHRVNlB3bkFGaXNvVTBNRkMr?=
 =?utf-8?B?MHllcE5tUkZKeWxJb3FaRHNxc0JHZnBHTGpDdVdEdW41L1NHMnRXYzZBRFQr?=
 =?utf-8?B?akwwYnUxdk56eDkwWjk0SjZvVU40T3Vrbm9oZUhJMnpLVFF1M0hqRGFHdWVW?=
 =?utf-8?B?dFAvY1d2YjB5S21JeDdMaGdGNlkrRFptVC9zNWx5MXZINnhIaCtlcHBLSUw4?=
 =?utf-8?B?THNNSGwvVG9SVytSV29kT1VBUVlJN0ZZbnBHUDJJV24vVHlTdFZ1VmxDTlc3?=
 =?utf-8?B?S1JRaFUwY2ErenVveGlIREkxbkRlOXNsclUxbEg2enZvd003ZzdpNVU1OCtU?=
 =?utf-8?B?aHZHZ1BhRFh4NHd0QU9CN0FUZjFZeVBsdTNpUk1pVkd3SkhIL2p6eTZCNTd1?=
 =?utf-8?B?SFZZKzgyUjRzRTM2ZFFSY3IwRmQ4RU9mU0pPOGdJYmZ1SVdWNmF4b0lrc0ZU?=
 =?utf-8?B?RGV5YXJqVzNBVjI0MlNqb3pvV0FaOE5md0tnUU9lU2hrYU8yQlo1VFdwTkk4?=
 =?utf-8?B?RFN0ZTZWL043bmh0RitqeVpzV2NPellRWEFZdnBRbDlLM2VhSFhPcWVUYWxq?=
 =?utf-8?B?WUsrdG0zWk4yVDRzNE56MHdYMG9sK3lYaWJkSTllQ2xXRE04TGRvenZTSEFl?=
 =?utf-8?B?MW9YbTliWUtQa0cwQjZTRjFpWEdGaFk1TXJiYkN0STl1SnJqeXZrOWYwQ1Vu?=
 =?utf-8?B?TFRyY2VrZlBIc281MzdXVHcvZlcxQW5HVndnZGdGTTlWbnFCaHBhbHZqMDVR?=
 =?utf-8?B?MmcrQURWaURIRENNTnlhTTVTQ2N2NUxBZm5IYUphQmRmV2xQZWoweTNRK1Ir?=
 =?utf-8?B?SUlRTVQ3aEZ6RWsyT3U0TlUwS2xyMHZVamh1V1U3Ui96cHdoRm5FZTRlZ0ZO?=
 =?utf-8?B?dytkMGEyZmZ6czBobDVtZ1Mvckd3R3NpeUo4MytBOWZ4NE5HK2JYODZwanVy?=
 =?utf-8?Q?7Vf+3hgGI3Qeif1HTQtX4h4Z7nZSb9YET7Q/aGfyu3FQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0UweWxSQSt4dFR2Y3hTMUV4STlacm4yeUVRWjhJN2YxR2tUVnJ6a1haR05i?=
 =?utf-8?B?blVlMVBGejNzUytBeHczOVpoNExnN1BlRnp3OGxhd3pWSHo3YUdRWWREci83?=
 =?utf-8?B?MVJKMlNicnBpeTJWbkpabTlRcFJkUGlwZzhjcGNwSjJiZ0czKzZINTBGZWNL?=
 =?utf-8?B?NTRaRkFsdVhKNUF6Wk9JSlVub1Y2bTU3alV2Ujh4cUlhV1VINmJOL3Z3SUgx?=
 =?utf-8?B?T2NDcDBQMlZVVzU0RWVKOThrZHVLeGd2eE9lb0NvSFFZYmEyM3dmamw2a0NB?=
 =?utf-8?B?NmVxNlVPSkU3eTlRT2FvY3BUL0hXZ3FXeGRRL3BubzNqRWlyUUlhWEtnT1ZY?=
 =?utf-8?B?VG54UzNLZDlJVFNEZlBObEN6dC9VQVRTUlA0dDFLSDRNRmhwNG5wSTg3dndF?=
 =?utf-8?B?NEdCSG1hblRlWFc2UkxCWEpBUXpPRWM4K1VNZ0xEYzJvdDc0R2NoOFB0cnph?=
 =?utf-8?B?S2wvdktoa1pDQVFZYTZwTjQ5YXAyeGNmWDlHOHc0RmRPd3NKaWRobDU3R1hH?=
 =?utf-8?B?amtzUmV6c1E1STV6aldvdng2SUx1VDNFMFpmZUQ5RmtxQ2RVSnNiVlpKOFR4?=
 =?utf-8?B?WkI1S2tlUWFQVWV5ajlnRitkYzdkdzFma012VjVaU3hoK1FGVFpNb2ZvL2pW?=
 =?utf-8?B?RGdMWHVELzJCQ0EvRGFOaS9WWXQ5ek1xNFlDa1AwbytLVUkwcUxFTlQ5WWZt?=
 =?utf-8?B?ZVlvWVZRc09RTnRNYTM4UHJWNjRjbjdQTm9sTnJsUWowbHFRUDU1cjROLzMr?=
 =?utf-8?B?V1llazk3OUFQRFpweXdrNW1NcDdMYjdpWWpOcTcwZzNlMzJtVEFieXFXTTFo?=
 =?utf-8?B?QmxTUjlkMll5OVNtSTBudW5JZ1FROC9pUkdSbDNLZWFTT29KM3U4VlNPeVJB?=
 =?utf-8?B?MGJTb3RFTGlWam1ZVVNPMnhnWnYzVFFwVDdDV2hQQmdQQ2ZmUGhNeHBSQkRS?=
 =?utf-8?B?MEVLVG1hZWZ3aU1Rc0tTZVAvZzRqRWZUOVU1YUQ2OGQwOXFVSk9qbmlGK3I3?=
 =?utf-8?B?a011NFlUV29DUUtNVXhFbnRRcVAvdlFpZXNSRzBIR3gzYVdOSStBcU1MR09J?=
 =?utf-8?B?dndtSlZtK0o2M0lxK0MrQ2MrNjU0b2VJL0RQcUlKUXRqMmYrbUdkcldkZDBq?=
 =?utf-8?B?YkozdkhmV2psd1BoZTFFQW1RRGE1OVpDU1VSZEZKaDBiQktYNW1FaGNab1FN?=
 =?utf-8?B?emJpbTBNTDVNeUJlRS95YVJjNE1ZVGgxWTFWdDNFbGVzN2ZIZ0tQZDlSTTN4?=
 =?utf-8?B?UTRZZnV5cUhaQWFBR1QzTWZxRWg0dG5WZUFBZEhmN25SbTJ1TGpUK2dBdDQv?=
 =?utf-8?B?Z0JxUk8rempiVzVxem5ZYWhWQ3hQbHpqNGVpbTk0bmNqNnVnRTBPcEVaMnRV?=
 =?utf-8?B?Yy9nM1Z5UUUyM0ZJMHp6U1EvdHhwNG1yNGlqQ0wyU2w0dXFJK2I4aHdaa2g3?=
 =?utf-8?B?Y0N2MGgzcnNTVmI4dlRJOFBSMWZ0UDRqNU56VVhHZDB4Wlpic0w1S3JoYlZI?=
 =?utf-8?B?NnVUelB5RkplRHlQWHY1ejlaUytsTnIzMzJCMmJ5aUxydU1TN1JLK21kaHh3?=
 =?utf-8?B?Vkw1QUtEZ0thM3RYVHJxbkxwWktFYWF2S3UzUjJtcCtad3BnYWVEY2pHcGIv?=
 =?utf-8?B?VGZtRjJPM3RoMkVyUjRLM04wd25zN3pXM1BHWTNUV3k3Q0V6Y1cwNm1ydXhw?=
 =?utf-8?B?c3VISXB3aEpDcjlWbENPM0FPQ20wSnlJSFdTMERQZUJGMjE5a2hUd3dGMnZW?=
 =?utf-8?B?dTVnWW52OVdJTmVPV1RrYmlqcWZ6cXBqeFhJT0wxR2RDczVOaW11Mm50SnZO?=
 =?utf-8?B?d1VuZHFMNENSdHZZT21EUEl2YWNscHZlbTRTZGtxTzhsWHdXQWxkNDRNU2xU?=
 =?utf-8?B?NzlXeURtSmdZa1dmNnAzZG5UN3A3VG1qZDBla0Q0bHZ1OHRiYkxCYWowMjhs?=
 =?utf-8?B?WHVMS2NiMStvV2JNSTVNRGZwOTZGZDVhQ1lGaCsxRVEvNVdYQUJZRU1MRFNR?=
 =?utf-8?B?WUVTejNhQkpCMVEyTEVTSTBFWkNMOGxnUjFFa29QcmNkNjlhblMzQlZGYUFp?=
 =?utf-8?B?SGlsNk9ubS9FcnVxOWRXbWQrcFJ3ZFYvVTBJUkxjOTZZMnZpaFhBaXlUbnNH?=
 =?utf-8?Q?B1PKj3uAU7bPNG5XcG1ks0EcC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0c1088-97e3-44b3-389f-08dc6565a422
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:24:00.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yxXDxjfiEEAHYAh98N6bOzRO7p3lQucm6FeMCD+cmTrFS6X0AyV2ggOAJHRY0cgN5RtFECYuFNMlEa1Pbv55g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

Hi Ilpo,

On 4/24/2024 2:32 AM, Ilpo Järvinen wrote:
> On Wed, 24 Apr 2024, Smita Koralahalli wrote:
> 
>> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove event.
>>
>> The hot-remove event could result in target link speed reduction if LBMS
>> is set, due to a delay in Presence Detect State Change (PDSC) happening
>> after a Data Link Layer State Change event (DLLSC).
>>
>> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
>> PDSC can sometimes be too late and the slot could have already been
>> powered down just by a DLLSC event. And the delayed PDSC could falsely be
>> interpreted as an interrupt raised to turn the slot on. This false process
>> of powering the slot on, without a link forces the kernel to retrain the
>> link if LBMS is set, to a lower speed to restablish the link thereby
>> bringing down the link speeds [2].
>>
>> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
>> be set for an unconnected link and if set, it serves the purpose of
>> indicating that there is actually a device down an inactive link.
>> However, hardware could have already set LBMS when the device was
>> connected to the port i.e when the state was DL_Up or DL_Active. Some
>> hardwares would have even attempted retrain going into recovery mode,
>> just before transitioning to DL_Down.
>>
>> Thus the set LBMS is never cleared and might force software to cause link
>> speed drops when there is no link [2].
>>
>> Dmesg before:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>> 	pcieport 0000:20:01.1: retraining failed
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> Dmesg after:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
>>      https://members.pcisig.com/wg/PCI-SIG/document/20590
>> [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> 1. Should be based on top of fixes for link retrain status in
>> pcie_wait_for_link_delay()
>> https://patchwork.kernel.org/project/linux-pci/list/?series=824858
>> https://lore.kernel.org/linux-pci/53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com/
>>
>> Without the fixes patch output would be:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>> 	pcieport 0000:20:01.1: retraining failed
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No device found.
> 
> Did you hit the 60 sec delay issue without series 824858? If you've tested
> them and the fixes helped your case, could you perhaps give Tested-by for
> that series too (in the relevant thread)?

I'm assuming the 60s delay issue is from pci_dev_wait()?

Correct me if I'm wrong.
I think series 824858 potentially fixes the bug at two different places. 
What you are seeing is at suspend/resume operation called from the calls 
below.

pci_pm_runtime_resume()
     pci_pm_bridge_power_up_actions()
       pci_bridge_wait_for_secondary_bus()
         pcie_wait_for_link_delay()
           pcie_failed_link_retrain()
         pci_dev_wait()

But series 824858 helped me in properly returning an error code from 
pcie_wait_for_link_delay() and also avoiding the 100ms delay inside 
pcie_wait_for_link_delay() and probably the timeout in 
pcie_wait_for_presence()..

The sequence of operations which I'm looking at is after an PDSC event 
as below:
pciehp_handle_presence_or_link_change()
   pciehp_enable_slot()
     __pciehp_enable_slot()
       board_added()
         pciehp_check_link_status()
           pcie_wait_for_link()
             pcie_wait_for_link_delay()
               pcie_failed_link_retrain()

pcie_failed_link_retrain() would initially return false on a "failed 
link retrain" attempt which would make pcie_wait_for_link_delay() and 
pcie_wait_for_link() to erroneously succeed thereby unnecessarily 
proceeding with other checks in pciehp_check_link_status().

Series 824858 fixes the bug by properly returning an error code.

However, I had missed looking at your patchset when I initially wrote
this. From the patch below I see you have addressed clearing LBMS as 
well but at a different place. But I didn't understand why was it dropped.

https://lore.kernel.org/all/20240129112710.2852-2-ilpo.jarvinen@linux.intel.com/

 From what I understood while experimenting is, tracking the set/unset 
behavior of LBMS is hard, as HW has the right to attempt retrain at any 
point except when the status is DL_Down as per the statement from the 
the SPEC: "This bit is Set by hardware to indicate that either of the 
following has occurred without the Port transitioning through DL_Down 
status".

The set LBMS when the port was not in DL_Down, is never unset after the 
Port is transitioned to DL_Down. So, I think clearing it after the port 
status is DL_Down (which I assume happens after DLLSC interrupt fires to 
bring the slot down) makes it remain cleared only until the port remains 
at DL_Down state. As soon as the port transitions to other states (I 
don't know how SW could track the states) there is no guarantee that the 
bit is still clear as HW might have attempted retrain.

The only way would be to track the DL_Down and Active/Up states. I at 
the moment don't know how to do it or if it is possible to do it in SW 
in the first place. Hence, I'm more inclined pushing [2] below as a fix 
  for link speed drop. However, that has some complexities as well :(

After talking to HW folks one place where our HW sets LBMS is:

Device is removed.
   DL_Up doesn't immediately change.
     HW will just see errors on the receiver and doesn't automatically
     know that it was because of a hot remove, and tries to recover the
     link.
     LBMS gets set here as rate change is attempted.
     DL_Down occurs after this.

Once DL_Down occurs nobody is supposed to set the bit. But the set bit 
is never cleared and is creating all issues.

HW mostly considers other parameters and LTSSM behaviors in 
transitioning between Active/Up to Down states which I'm not sure at the 
moment how much of it is transparent to OS. :/

> 
>> 2. I initially attempted to wait for both events PDSC and DLLSC to happen
>> and then turn on the slot.
>> Similar to: https://lore.kernel.org/lkml/20190205210701.25387-1-mr.nuke.me@gmail.com/
>> but before turning on the slot.
>>
>> Something like:
>> -		ctrl->state = POWERON_STATE;
>> -		mutex_unlock(&ctrl->state_lock);
>> -		if (present)
>> +		if (present && link_active) {
>> +			ctrl->state = POWERON_STATE;
>> +			mutex_unlock(&ctrl->state_lock);
>> 			ctrl_info(ctrl, "Slot(%s): Card present\n",
>> 				  slot_name(ctrl));
>> -		if (link_active)
>> 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>> 				  slot_name(ctrl));
>> -		ctrl->request_result = pciehp_enable_slot(ctrl);
>> -		break;
>> +			ctrl->request_result = pciehp_enable_slot(ctrl);
>> +			break;
>> +		}
>> +		else {
>> +			mutex_unlock(&ctrl->state_lock);
>> +			break;
>> +		}
>>
>> This would also avoid printing the lines below on a remove event.
>> pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> I understand this would likely be not applicable in places where broken
>> devices hardwire PDS to zero and PDSC would never happen. But I'm open to
>> making changes if this is more applicable. Because, SW cannot directly
>> track the interference of HW in attempting link retrain and setting LBMS.
>>
>> 3. I tried introducing delay similar to pcie_wait_for_presence() but I
>> was not successful in picking the right numbers. Hence hit with the same
>> link speed drop.
>>
>> 4. For some reason I was unable to clear LBMS with:
>> 	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> 				   PCI_EXP_LNKSTA_LBMS);
> 
> LBMS is write-1-to-clear, pcie_capability_clear_word() tries to write 0
> there (the accessor doesn't do what you seem to expect, it clears normal
> bits, not write-1-to-clear bits).

Got it thanks!

> 
>> ---
>>   drivers/pci/hotplug/pciehp_pci.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>> index ad12515a4a12..9155fdfd1d37 100644
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -92,7 +92,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   {
>>   	struct pci_dev *dev, *temp;
>>   	struct pci_bus *parent = ctrl->pcie->port->subordinate;
>> -	u16 command;
>> +	u16 command, lnksta;
>>   
>>   	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>>   		 __func__, pci_domain_nr(parent), parent->number);
>> @@ -134,4 +134,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   	}
>>   
>>   	pci_unlock_rescan_remove();
>> +
>> +	/* Clear LBMS on removal */
>> +	pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA, &lnksta);
>> +	if (lnksta & PCI_EXP_LNKSTA_LBMS)
>> +		pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> +					   PCI_EXP_LNKSTA_LBMS);
> 
> It's enough to unconditionally write PCI_EXP_LNKSTA_LBMS, no need to
> check first. The comment is just spelling out what can already be read
> from the code so I'd drop the comment.

Sure, I will make changes once I send v2 and if we consider to address 
it this way.. :)

> 
> I agree it makes sense to clear the LBMS when device is removed.

Thank you!
> 

Thanks,
Smita

