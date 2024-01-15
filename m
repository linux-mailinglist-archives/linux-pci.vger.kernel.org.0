Return-Path: <linux-pci+bounces-2148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338782DA88
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395041C21981
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CEA17547;
	Mon, 15 Jan 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NiBquW26"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FE17546;
	Mon, 15 Jan 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzh/zDJLoU4jzShe+34T46Pe3Hku23sQT/xJhiLxo9MyqpChEAHcNaUA8iHyAyJyiX/Ym4qwFSswxD+l+u8lab7onOGWOo8x/oG9uIpPmL5TPWXKzs7LhdcJUjew/WX40wZCj3ToO/0Kh+XhLdVBxCiv9ZwssjLELUmTwtclhgPm0RXdVmtJPQBS1Tq22f8qtLr3fY3WFWJxGcVfDHltm7nzpYKDvahlMrCpLkMEUgI53ZkdFZoUIBkt77qk9Fj1LUptQKJ9Qx2dI0GYFbFGWh1RJJM99bH+tTnZBF/wHI/6fe+OwzcPo68WS7UYmsF9mTScL07WpdI63uLYUkij/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTfA6ekjB5ygLboA5pvvxDMiRPi0Dsxhps5tblILnWU=;
 b=DGHvuO77hZGIyB7owqWMre4bPLinjSpMHwxKnYyFTnG2yHj7SY9wiqhrH/m6qYYUbFPJiwMKWtgEML2gT8edSSJtQ8OkRlsfen/0qdRiiNu1dicvF1vmthmHpH4OCGLCEoPPO5veokksqmkr5op+fowDtSpTFuDgYfP6iMLlGZeVrDjyP5FGLxGwcsMqqy+T0sfmqgW7wbQk5J0O7sDBpUlNZgWnQgMJZdyZ/KCdnFENvEQD7QHyfmu3Cy9aNEqxPVxlvCs5rdVeGXO5K5PNH32HDIA6Xne1h3Uq1NZt+rD8yXHVT754YpX+TY5WcKE6XQ0M3p+3sSBgVbafXg/Iaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTfA6ekjB5ygLboA5pvvxDMiRPi0Dsxhps5tblILnWU=;
 b=NiBquW26i0PO8H/LPhja83UOw1/rugi+L8/DDUhixnakeUduER5VWuQTsiMROVcmVSC0xcWOFhkn5Z6XCD3sj+LOJ1KTaNan7XfjUeQJTHfFbWAQledVUAkUT9PYqyUyEXKdaWlAVHzqounIZ3AeCby4xpHwe6s3hdDLX0BelYC4k8B8NZDO6WokEtSQPiVZ7Qy76W7JaqiaSBcuzqpsb55EhqROI1KvIp8ITUNjjsj8+weTKERrL/3jGb+Jf3Uvjz1fh8PIVR20nQkrCLfFG127GkGAUd/HiN2VLGaYVuFuycXerJSarO3EKRFrN5xJx1t32oEF/wZBYBOKbEvuZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 13:50:48 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 13:50:48 +0000
Message-ID: <5f68453b-206b-49a5-aae5-72a14ce65cab@nvidia.com>
Date: Mon, 15 Jan 2024 19:20:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI/MSI: Fix MSI hwirq truncation
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 jiang.liu@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240108120522.1368240-1-vidyas@nvidia.com>
 <20240111052814.713016-1-vidyas@nvidia.com> <87bk9qim4p.ffs@tglx>
 <b9a7b855-af2b-4858-b9d8-3340a0421cfe@nvidia.com> <877ckahq50.ffs@tglx>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <877ckahq50.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::32) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f87b1f-687a-4503-1ee6-08dc15d0fa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Oj2GgDNUc9Aae3t+TUPWKoTDd84p3WtNPa6wrqsShPC/3up/V6cBuKk0JLUThD4jF/YW+8q5qpNq3k+hvMGVPMeeGYj658nTjBNflji7+eT1RcfItgwhyBuJ7At6l0SWYXusM+Eu/pjZxBaZmUXGbrvH/mHGh9EpuQcP/O5tqHbZkAVlh4MY4RF59dylzsTx75fhDdprY3Edvlm9oXZ12Cc5FPS6jox+atNciDZM4qjCcHgnzGnAg0S9+vKbz/kasHKAiuTk9pxoibvp9PpAoei+PjFDkQ489C0m4xp3sKL5Tpqq0EvTQO/rDHaws/+QG0Q69QIMW6lkiDuhfs0ppMD4CNwg/hBn0LtXuLWNRyir82jmmqz3UG2LJXCENG/1N0HmzxeqjgLCj3wGt6gMEJxCt+kYVbToNl84es0hxDSwH4+RyLmAC/BpLNGdZD/yzT8Lgr4ipgYDIDfwPMCKHPF+LyxYLEWNQJ+qidZuxl1uGwwy4txC8RxY1X7gRyvd6gktEVuRMF/CNR3TepczIytATNPJ2gfq0Qnais21aENdHHUv2NQadiSagxY8puqhuav60cbsQYWQGlvyfkYx7+uRWg9h8iO4sRldVimsdw0wDjFZhlNnPljy4eSwp/JcESZ3I8G+rSlSdJZJPKWywIuKpsCbO5Im/xiOnrXDLWfBJBerHMFQs7rRxQreRda
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(31686004)(36756003)(53546011)(6512007)(86362001)(31696002)(6486002)(5660300002)(83380400001)(6666004)(38100700002)(26005)(2906002)(41300700001)(316002)(478600001)(6506007)(66946007)(66476007)(8676002)(2616005)(66556008)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFJtRlBTZUNjSkNReFd5OXhzVkhnNy9RcVY2NkVvMkVpQ24wVGhhZUJnYjlE?=
 =?utf-8?B?MktPY3dIOVRwSDZ1WjdGYUVxbEw4SklqRWs2NkZKWUVtdlBrMlh6UVljQW8r?=
 =?utf-8?B?L3ZuendsSlB6WUcvemNaNU8vQW4xNDRkNFQxNitmNytGdXV6NkxacHNKS0c2?=
 =?utf-8?B?RVprajNOMG5IWEE2aUYrbEpNVjZ0bDd1TFlUZDdrbW5JNGpWUFpZQnVGSkJq?=
 =?utf-8?B?bXFvWVlpd2p2NzhnWVQzYUJ6ZEdoQ25CRWpuamxXcDgySGowY3J0TnFtd0ZF?=
 =?utf-8?B?ajhhN09YRmpRS2luTkFiZ1VGZFBMU3dkU0drdkZQV3JsWHc1dk1xemIvU2tL?=
 =?utf-8?B?NTliazNaM2xxNFF6WXV1VGVEUjM0clB4SUd4QUFBZ2tVbTA3K2paZjF1aFlP?=
 =?utf-8?B?czgrTEcvR0FwZXAwWFVXeVRNQXpUdEdxNXV1ODhQTm5GNVNnZ2NkbjVBRVpq?=
 =?utf-8?B?TFRlNDhkUk4xeS8zU2VuekFWNWUrZWhnMXJYSU1id1BWbjZpS2xWdHVuamRF?=
 =?utf-8?B?dWh6L3J3Z0RhUURWVURrR0VST3lBK3ZBem12UFpaeXVjV1pOQUQrSkhjbXh3?=
 =?utf-8?B?elh2UGhwMTZNRG45VlZxRHdOUmcwT0V3bktwWlJyS2VWSHA4QW5vV0pWaVBR?=
 =?utf-8?B?b2JYN0E1azJmdjl0UWFwTTIrVWhZTUR5YVAzN3FyTzNodExQM3JvcnQ1RGlx?=
 =?utf-8?B?bUtYZDBtQTRyMnVvQlF3ejhwQW5SNTZPNDl0QnlKbGVoc1djZ0p6RWI2ZTFT?=
 =?utf-8?B?ZmRVTGNZaFMxM1U0Y1NmenVFZlhBWjlkV04ySEJHakhyUGFpNzE3UjBBaUJK?=
 =?utf-8?B?dkpwZE9MVFNEOU53c2lEc1pNeitQZlhxUS8rQ0hjek5wcFNxZXlKbXFlWDdY?=
 =?utf-8?B?UVVWdVdVSStpWFJwTXR6dEJwN3FSSit6WktvYmU3R2dFYmRkVTBiNzRtOHdn?=
 =?utf-8?B?QmZtNTJ0RHhXWEZYRFpNRFlMU21USkVLUFMyZWtuUENjOElhZWRQNE8xQ0VU?=
 =?utf-8?B?eFJWMXIvaGFzZGI0ekZwU0dDQzVRYmtRTGYxa3d5eXRsS3V1Ky8rS2owbGFh?=
 =?utf-8?B?UFdOWFVMQXVrSytJM3BKOGY3c1NLR0ZqVFozUEdxYjN6QmNMdHA1ZkJuTzZi?=
 =?utf-8?B?alFHY2oyQnYvc1pOR0FEbGwyYnp5SnRmeS9xKzZ2aDNDS2tMQmg0R0xUMGNI?=
 =?utf-8?B?WkhLZDdlalFOSjF4MXk5Q3QyM01rc1pHbnZ2TTVkTUp5RkpiV3l2ZWhjQTJp?=
 =?utf-8?B?TnlzcXF4dW95QmFNQTVPbUhGenBOL0dyc2pkNGNDUFpJWXh0cWEzTEI3QVJu?=
 =?utf-8?B?TE5MbEZmRGxPVGdVVTZtaStmMUFiYWt1UFNYbERjSHNmSnVKNVgva2wrSkVV?=
 =?utf-8?B?SFdjTnFOYTNleTJmSGFJcklXSlpJWkJPVWFocVdRZmE0bVFjUXhuSmN5bXBJ?=
 =?utf-8?B?KzJrTzVFcmxoOWJLODVhSjRjWUxCMFJkelN5dFV6bHpzbVphSGEvcW12emFh?=
 =?utf-8?B?K2FtODRvQjFYS3g5QVFUTHF0OWZZcGZpUkFYZDNYQ09MOHdHVmM5VmVXMXVW?=
 =?utf-8?B?SC9kMDh0elRnc25jR2ZFYjdLZzhMRGZHbStlOVVvWUZlcFkvbGVzVXFKMk15?=
 =?utf-8?B?MW5VdUs5cmJ1ek82Mm4zRGVpMWZORzl6cDNyVU9RaW14dmwxc2tNSUtYTHA3?=
 =?utf-8?B?ZnVwSDI0a21oYktIZUlzRGNQVFFjSWxQSHZPeUVwdmFnMG52K0RpRTZpN2xE?=
 =?utf-8?B?d1d3bk9VcmZCeS9QdThjcFBxdVZoQzViYUNCd1dTZ1cyM1lSeWo0SytROElH?=
 =?utf-8?B?SlNqcDlBZmhvaER3UC9IYkFmMHdrK1ZzdVNtemo5andkRUZqZDRjN1NyVlhN?=
 =?utf-8?B?R2xJenRiSjZIV2R4VStaa0pnUkQ2eURnWFhTZ3IzbFM3bHBjSk1say9OaEVw?=
 =?utf-8?B?emhaNUV5cDBEU3RRVS85Vm40Z01BdVBwSXhHdndBSGtCQW1VREhVMHcwYmJ6?=
 =?utf-8?B?bzM1NVM5UlM2VEc3ZlFPSmRKaHFMdHd3REI1WFBwQUNlZ00vU2t6WDdUTmVy?=
 =?utf-8?B?NDkyd1dZWFNjdnY2WkxmVDhPeHpJMm5vU2Q2MHVjeTZuM3hHV2JWS3FnR1cz?=
 =?utf-8?Q?4UKR+YwOKABPaY3VElvOH8PXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f87b1f-687a-4503-1ee6-08dc15d0fa44
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 13:50:47.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCqhEO1HLzwmFSpN7UV93RQ9OXwuzcfXXoUmmBl1cTS/Z1qFlVFtH8LqKbZoNsn43gem5pNFGu073lpg/Y9sNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663



On 1/15/2024 3:31 PM, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Jan 12 2024 at 23:03, Vidya Sagar wrote:
>> On 1/12/2024 9:23 PM, Thomas Gleixner wrote:
>>> On Thu, Jan 11 2024 at 10:58, Vidya Sagar wrote:
>>>> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
>>>> it to calculate hwirq number.
>>>
>>> This still does not explain that this fixes it only on 64-bit platforms
>>> and why we don't care for 32-bit systems.
>> Agree that this fixes the issue only on 64-bit platforms. It doesn't
>> change the behavior on 32-bit platforms. My understanding is that the
>> issue surfaces only if there are too many PCIe controllers in the system
>> which usually is the case in modern server systems and it is arguable if
>> the server systems really run 32-bit kernels.
> 
> Arguably people who do that can keep the pieces.
> 
>> One way to fix it for both 32-bit and 64-bit systems is by changing the
>> type of 'hwirq' to u64. This may cause two memory reads in 32-bit
>> systems whenever 'hwirq' is accessed and that may intern cause some perf
>> impact?? Is this the way you think I should be handling it?
> 
> No. Leave it as is. What I'm asking for is that it's properly documented
> in the changelog.
Sure. I'll add this extra information in the change log.

> 
> Thanks,
> 
>          tglx
> 

