Return-Path: <linux-pci+bounces-6228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9678A46DF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 04:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9229E1F21927
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01856179BF;
	Mon, 15 Apr 2024 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="unLKmMxu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292B1BF31
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147770; cv=fail; b=Juhq2zPjhYPMzP/hI+MdD0n2tktNan27XzJbIIznsSaRXZvReanMg3RwP+0KwiXW+ykU/19ykwpmhfiqy9TzynkH/+TgJrO3R+DReDKYpv/TrsVgbGC00aUQmAyNW6GRGzlzsBBa6xl2Q+cO6/ayf7T3pbIGcVgt5sfWfmLudhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147770; c=relaxed/simple;
	bh=zTMBMWSr1r1C2urPeXLr2ihMzawX1gVP7EH4p59TlgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jnLsPUqmrcilWnogVL4QEpORGoudReh5UQ7Nm466xo5Y4Nmtkb4LBUk3oMJRBfoQulJB1PCVCsiGynTGjpdn2xQM5MdYfBDpS2p2ZplT6oC67TbOS7wuLE++S4RJMTXHBmgxRZGBH4bHqBOdRFyKFYbfbquL6ajRs+7wDUdnFXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=unLKmMxu; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldxR4h520A7iYSu9jaiubYXl9aOrjHKZaLPGXFAqNh2ImswVNCSB9ITUMyatymhRzJk+9M0TEgha3EYSYUbD4x9Qtv0EP0KahZLBfE9qx8+JZJ2FnSHmOCwxytP0e0veHOUHFqjvagYbq5Hg2XYEFCDqSgfNh5zIMKir1mtKG6bfKidL1aJZFyr4FAtpEtI7oJweNNRtNY/4WICj8dsMerExMy6gbaGhPxjfLhIItlV/jQBJtkRsVEhEr2PS5ZQhoJt6CUDxDpeTOHO+ip8ig/I5rJlpkOy1Fj2lPHkB1zupbWL17EaukdG0qnUKwO5fwFiC2FTaaIw9AkgX648VMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbxHBx/iLcy/t/U7WUuwN9oY+c0kVWun3WxmUh68Zhw=;
 b=J1GjXGYrT9bIXi7ofbWYbkoLbo4ubuMZzl35fCgDfm8M6BCBU+HvKsadAFYya50O3aQgRYrlV3oh2pISrK6oA7+PZvm/qBSCmgdV+YSv5sFuHi3rwvPlitcWrr3iPmNNKgprsX0eH5HguWgfovVWHL8yvK1YHpWTdrZvuMUzJt5Imnu39l8hKEi5hbl59CFudmvgNoQrIPvB1HETCRLsCWH/ajiCm6l7T8t/2RuSUO+kbXOk7jm4rTJ1PnsV5tnJNyXK2RLXR2QtdZz/POLOdVQdj1T3+RDo9KrMSZMF8X7/lYmE7zbFjOS/gp4DN2tf3oaCBP7qqyquc1M+y91loA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbxHBx/iLcy/t/U7WUuwN9oY+c0kVWun3WxmUh68Zhw=;
 b=unLKmMxuhUIpTzolZgHJ7w2TJVI7tBMZQLM8b/MSsBBIYv7vMkrFwl9itdO0WKfG/cYCXYwDmAjtTm09rVUr1ms5BszhpLlvPH5umuthP9+fmrg85prWBUu24oxfutDLTnT6V3/dwhQEk/VyUywz+o/tCzJnjXThK0/Se4/kVAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 02:22:42 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.7409.055; Mon, 15 Apr 2024
 02:22:42 +0000
Message-ID: <af689b1f-43bb-403e-9de1-e6c43f398662@amd.com>
Date: Mon, 15 Apr 2024 12:22:37 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH pciutils] ls-ecaps: Correct IDE link state reporting
Content-Language: en-US
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
References: <20240411042844.2241434-1-aik@amd.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240411042844.2241434-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc7e147-e6fc-4169-8d9a-08dc5cf2edd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f4JFwzqTi96tOO+R3gvV74lmUIjZ7VrhNtPZCp/LV2LhG1nj1kazGefgNxBS8d8BtRrNkDx//GOj/HKW2gs3W2tAfS9UxlaTUf7WbLSqgxzbydMNu5I1tlTAhlvzlnvGo+N+Zwm81L7yldPVrn5UK85xOhtPU1RfV5pRsuKgeDi5mLR61gxW+PdZw/9UCTEtQ9hq3R02cFwXy5LFWRi4SgWCPaP12h/yHjyjXs/NbAI0zGDt3MOaYn7aXCwD4J2U9cfx1KkDJxzimFYsYCbzQWjIdQF4XlhRAmyyMuQjYP488bCF84cE0oWKlQsWlNRZRoJwd4WizldWItEk/HQhl/DeWcTdM3I6Il60tR48+cRoedZ27u1IK5rgjvmp6FVLyUhuvUuGMliZ4iOcUz7zMv3BooIFZ6Sa8cmNnvDwdFOo7ib9GG9IubfBU15a3hFfQuc66x/IyxZHQmrb9SVqQpQNywaT2m5kzr8FQdkMRw6TnvOvFSJMW4wB08uLXe0tolITmLb+rCZDEDlFzoR6RHRa8xGIpLWayW4tuSshQhaLFcH1B2U2T3pa8jXzEggX/1egIGUdbnlLXC6RvsIIzf1bBHbfGW4KB80jdDU4yVSlFOBi0f0sQCor3xzc4362M+APpht0eKZy2SQxlLCnCy3jgxqVtPj/gO2OnZv3Xqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEw0ZXlEcCsyR2tocFNrWVByemEvR3VuZGJPYUxCSTZWOUpzRW4rd0xhTUlZ?=
 =?utf-8?B?bE5hcllub0JTbVM1SlhPa2dEQmRSM1NoWVQ1Q1ZsbWtTQm1rS2ExQ2NUZjlI?=
 =?utf-8?B?YjZFMG45UzRhRHg2dllGejd4TThpVzd5NjJIelNKN3VqSWpZdW5jTDNhbnNa?=
 =?utf-8?B?VG9YWCtVYmVBVEdJdFRoeEUxZmpBcXdKWlpYd3dWQzY0NHBHRXdkbGplVVkx?=
 =?utf-8?B?OUF0K3VCZVloY1V3eDlDR2l3K1JXSU4zQjEyQm5LZEZydy9MMEowRW5Uc2Nn?=
 =?utf-8?B?eG5VNk5LRGh3TlRzVlpyYmVjN2szUUJ0Y091dm96dWNyTkFiRmRQa1lETGtx?=
 =?utf-8?B?R2NNcERNS0ZFb2c3U0tFMjU5R2Mwd1NOTGhMTXRIckgra3ZFaHNnNlo0Qzd0?=
 =?utf-8?B?azhIMWdqd09OcS9aWjRyOWluY1VFOUtsNmI2SDBPUzVaKzhncFhOSWR4dDFY?=
 =?utf-8?B?UDZjQXcyU2dOa3dsaWVKSDdWZEIvYzNMSmRnRjR4VzRUeUZUTGxiMzhwVnVv?=
 =?utf-8?B?b1lYK3pFN1hoUGRqRjFPZno3SGpIYmF0WFNXak1ocmpLL0xRRHhlMnFBU01D?=
 =?utf-8?B?QXM4dERTTW9oZndpZGozTk1YaG95dzlwVHh1M2V1N0hLMTdyMFdKd3B3a04w?=
 =?utf-8?B?TmJNRGxQN3hpb0E0SExIRlhIUlRFSHZQMkF2d29HbHBKK0c5Y3l6SldydVNB?=
 =?utf-8?B?ditzM1RheGFNMGppRmV6ZWdNSUtNWkp6eE1rT3ZpdVFhYTN2aS9VcmN4RW55?=
 =?utf-8?B?Q3MrMHlkdjVTRHBmUk9ITHo3RFVBaDRkVyt3QUF2UEw0dFJCNm93ZFgyMmFn?=
 =?utf-8?B?MW5KU0VSUnJjZTkxSU1QRWk3MDQybFFkN3pMRmRZV2liV2ZLTXR2QW1OdXdm?=
 =?utf-8?B?Y1JTbHdRVHJCT2Rad1hEUitURVhWWkRZdGxQNTViNGM0eUlVemxsaCtVYUd0?=
 =?utf-8?B?Nmx0WjNZTy8zSmNWdzlpbVhzNksxcTNROGE3VDJObDcrSTBVdW5nWUFNYXQv?=
 =?utf-8?B?STgydmRObm1BUTNZR3AwWG03aytqdHRycFpYSXBxTTcvQ3ZuWXdyMlREN2hP?=
 =?utf-8?B?c3NxZVJvY1JYa2p6dG1sT01Va2ZTK01CSFVHN1g4TlFwR2ZIcmkrZG5za2p6?=
 =?utf-8?B?R3doWDVNb0xteU5OdWdKNTJKcktMeWlOMi9rTDNDTHVQSld4NHQyMXlZU0hL?=
 =?utf-8?B?MlVXN2hXK3FYM3BQTHVxcWRyNjhNMEpyTDNpYW1MRzExNjlCYmhoL28yQ2xT?=
 =?utf-8?B?RlV0LytiOXFUK3FGcURZVDYzREVrSnVVRjJoRm5oY0hxaE5YdTV0eVdjOG1a?=
 =?utf-8?B?UVZENUJzVVBZd3FXczBzRlhKUldnSVVnNldHbWVqVzNjcmtGZFptVCt6NVFM?=
 =?utf-8?B?YWN3ZkxZUW4rbEVJQ2MzWmljTzVUbFBveXE0TmxMNU4wS1FENWNXNkhsYVY2?=
 =?utf-8?B?Z0xvM1NOYlRDR3lzdnZVclJTazZ4dUt2R0UwWU9MRnhSaDlzTU5MWkVaVTlB?=
 =?utf-8?B?RnFoaGhKZkY0NFdoSm5KM3A4bUJ2dDZtUnhFYitUZk5VcWxza0JIUmpYeDlU?=
 =?utf-8?B?QnhQcXlSTk96SHlqYWhTaHJSUEdMcHplZWUwM05PYnA5SEpDWU5rZTAvOGtL?=
 =?utf-8?B?QW42NUJ1azZ5bzV5YjlQV2JrTHVMc0Zmdko1ck1SemIyQXVoamJOWjhMRXRt?=
 =?utf-8?B?VW5TVk9tZXQ2UWFFSlBwUEU2aTdXUlV3WjRKOXYwOXJQQXRKaXV6R014ZWds?=
 =?utf-8?B?QmE0VU9HRFhSWTZib09nZ0FGVVovNkI4K0tNRW5UQkE0QlNVNEQyQWZiV1hJ?=
 =?utf-8?B?Z2ZDUDV6amRQMjV6dGNGdlBFblZtd0RSMGxqV0hZRitjRFpuZ3NwZkhXRXpH?=
 =?utf-8?B?Uzc2R1dyL3JURHVHL1BaS2pHaDNoNEcyazg5cWRaN2dvbFlsZUtvY2Z6V3lC?=
 =?utf-8?B?d2RRcjJJWVpUWG9RZGF6NHlUMnMyVG9HYkQ0VG5UY3YrRzlJbkxNVkg4SU8y?=
 =?utf-8?B?dnlJbDdwd3lqTlB4Mm1ub281bVFESXQ3cWJpQURibENrSnFZVHZwSm1pcGlU?=
 =?utf-8?B?QW0zaE9MOGFMS0VUWjVxbzBQRU16QjZ1N3VpZG5iWldJUTI5QlZWMThMY1Np?=
 =?utf-8?Q?Bs+Ou3BN7nlFeS44B2IPn2f2j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc7e147-e6fc-4169-8d9a-08dc5cf2edd6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:22:42.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK3Mom7KhgldqlSQToFxPvdYjvB6uk8HCf4WtYbAa3IkOcT01iss3NuO3Zk9mL3ak9IUZTxf98YmNuL3BcTHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

I found more inconsistencies so v2 will come soon. Sorry for the noise. 
Thanks,


On 11/4/24 14:28, Alexey Kardashevskiy wrote:
> PCIe r6.0, sec 7.9.26.4.2 "Link IDE Stream Status Register defines"
> the link state as:
> 
> 0000b Insecure
> 0010b Secure
> 
> The same definition applies to selective streams as well.
> The existing code wrongly assumes "secure" is 0001b, fix that for both
> link and selective streams.
> 
> Fixes: 42fc4263ec0e ("ls-ecaps: Add decode support for IDE Extended Capability")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>   ls-ecaps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ls-ecaps.c b/ls-ecaps.c
> index b40ba72..5c2724e 100644
> --- a/ls-ecaps.c
> +++ b/ls-ecaps.c
> @@ -1512,7 +1512,7 @@ static void
>   cap_ide(struct device *d, int where)
>   {
>       const char *hdr_enc_mode[] = { "no", "17:2", "25:2", "33:2", "41:2" };
> -    const char *stream_state[] = { "insecure", "secure" };
> +    const char *stream_state[] = { "insecure", "reserved", "secure" };
>       const char *aggr[] = { "-", "=2", "=4", "=8" };
>       u32 l, l2, linknum = 0, selnum = 0, addrnum, off, i, j;
>       char buf1[16], buf2[16], offs[16];

-- 
Alexey


