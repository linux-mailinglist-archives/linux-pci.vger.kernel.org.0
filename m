Return-Path: <linux-pci+bounces-5499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24EF89459D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D22281B08
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69551C49;
	Mon,  1 Apr 2024 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gMnOqFf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C820304;
	Mon,  1 Apr 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000487; cv=fail; b=DxpZ4FufLhjmuaFnrHSX/M0oSf8s4aGwsZ634jngpnr6jppr1bRmH1Jmnf/HCvJWazX2kO4gEWOm7qxtxnSyxOwhxs1UoWNUvt1vXnh0dX6MRmYRSqKFaFQvRhRWuZ104CMB2mvZ4/wGjgS2yIPdj64Xir8Tb89UvvSlrwLoPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000487; c=relaxed/simple;
	bh=hX6MFkJcAaaioZzJShBeJlxfntSqkDRUvvp5Dv+QXBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dYw+uRsaaE98cfXXeqQ9txBdcX1WN5ZlU+nc5gRJXRkhwndMuWzZJNVTo3jy15zmRjQ67MeXNIHPpCWkyfXsnaPapPQJNs5dNUSrJrnN14J03iLn7c5aA1W+wLI8Da32kVQqhw4AML9UetusbVN0L/MCH/3o/ziKtVGdwF10O/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gMnOqFf/; arc=fail smtp.client-ip=40.107.237.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0ujcVSxzDEZC8VJzzH2FVWTw6pBhuRxspn6siCIB+6W7xeA/mIg14o5jgL8ZV58TSnXEYIr1lvxJ+5Td4YYxSyDATbAZ86EVrDdkUGeslzR1VI9e4pVN4PwfNjizBGOwX7nQQZVZsmIviKumJi/gS5mX9+SP+d+6bbUfYEDNHyXI0ZVUtwP/WDEc4Yo91CuSElKXSgeWofcDeAKa/7jBLHDIPJ5H4Fp5VK/VxnqzdvCMk4P9NdSXIebMvkGD7jRn3uyF0Kye77RIpVA3g3WvIeXraaW9jxlD6bY+IvX/ZKvrFLoLprzdz2mYd+xO1eOy9T3MvOkluzwACeeiFrLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sinD9Hm0wu/4vWhjxBoKRgeoyqRhJzybNXFxb8MyU80=;
 b=Jz8Y4fOTSV9xYJnN6p9p9eKxoiaBSk78hXjy4Uw3HMro6qzTIfQllIGd+0GZ52EwHW0RqxfEqSJXyhR+7KG07J0i5gPC0N2V9idrhxIx9/1ua0aYlK6Tx09Xb/vjKcyeIy5HbKq7aKsd9CkhI/8hIkDJXT6iQqkfIR+p51hotT4mE57QMEW0/OB5jVm07BRZPxuvIupySAxqLF1fc2nSpTbM5Tl5uGj5NjufM4aPjTxBxDYFmYg3skQ4KNlqF3hBuzMpkdL22fwUcjt+Tmxp5NUDRhLzpBSC0Emqj9E4K2pxlxyXcWArMxdzYDDgodD4a6WR+pHW3ECbA3qhnP7rVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sinD9Hm0wu/4vWhjxBoKRgeoyqRhJzybNXFxb8MyU80=;
 b=gMnOqFf/H8lhPoqz4mOg3LitZLgj2KTBI3SqJsUKod+fy5aHT9I/ZXO5klwgBMWo7f3aWo8UvSJGHrwFf11CsHQayVxmvAE+kt5HhzW6E01bpSmlWnHmdoM2r0TDvNp1VXIq0Y7BignpwHsSznJYQo18Ka7RLRlCisck3cUq5ag=
Received: from DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 19:41:23 +0000
Received: from DS0PR12MB8528.namprd12.prod.outlook.com
 ([fe80::e24e:1e8e:1c0d:6e29]) by DS0PR12MB8528.namprd12.prod.outlook.com
 ([fe80::e24e:1e8e:1c0d:6e29%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 19:41:23 +0000
Message-ID: <e7d4a31a-bd5e-41d9-9b51-fbbd5e8fc9b2@amd.com>
Date: Mon, 1 Apr 2024 14:41:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Implement initial CXL Timeout & Isolation support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 bhelgaas@google.com, linux-mm@kvack.org
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
 <65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <1287adbe-364f-431c-b33f-9d73e7829b6c@amd.com>
 <66019e1ec2153_2690d29440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <66019e1ec2153_2690d29440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:806:6f::16) To DS0PR12MB8528.namprd12.prod.outlook.com
 (2603:10b6:8:160::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8528:EE_|SN7PR12MB8147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z+6Gk7iRu/aNbcJNT78LvbLhExDTd9jnzM+IzXVin+59kaIF4Y/Q68c7zf+l3qU9bttIl36SgD1v2oqCfmNC1ZT8Ajt540rbn+kkbvL41MBxozT5sel3igCSaWWP0Z4ksvOmkovCz6KeGZV56Dlfxs3PiCPCN/yG7oJ9sm2onl5PU1LZbMfivcGXZlCFgGrRmB3Sqm8ISREqZbankrjwPcmsAEU795hbCKjbzxatRGKmeQq4vYl2oqlVy6yzBgq3AO0LyFN1YSyhX72h3HoRGhyXaz8RWBnP6ivcvK7Hz27zuVy63GV1Rgj8jA2+JxLEiWv2Q1NIeQvAlC1mZx6TAQpp139PSIK1Ca0sfEELM7V7vYAFi5Z7xUO1oLo3/TkAVBRvKTePF2kk8OeAXgKwVz3Fu0c2cQCjB3OoO7FQLBCht9s2qsTSNqVkvV9SS+BVVHBghiJ7xsZSEdBcmX6Sj2rP9vK1KAXFlXOWG1+W0gIWAQwS0DwrFigIbmmsAAbGqeILxMSuHaJsEx2ThE4Ne40Zme7wnaVIPvKvHRsfcYYWTQw/5VwfXJH5dpUL62sS3EfA17c52EOqiw8gwoSONaawulKMRP+YUHsFMapwq6vWgH6/SNUid16l5Hu2bqp3JRy1HIOs6Xd3w9eZS8ZzIVaLVnUxPzZKSJ7DVyHAiY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8528.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFZ1andUa0FXc3F0N2htUnVyNjArOUZsbE84RlpjM0lkKzVOeENCeHIzVHBa?=
 =?utf-8?B?TVYvcmtadldhM3RkM0FyazJwTzF5ZG9DdUl3clJjUnhwZkFCWm9SNDdqblVn?=
 =?utf-8?B?VHIwYTdzM3BiamZLTGs0OTRtc2pFSTNEd3R1NTJXVm81bHVFTEJnQmJTS1Nz?=
 =?utf-8?B?UkVOdmYyMEUxbVk0emZYTTJOUW4xRkhDY21qUGxLQUZzWW0xZjZtczdFeUpW?=
 =?utf-8?B?ckVhSmxqaHl0eEZmSkxGeHhubGdwWmlNcjFNaE9uZ1hpSkVMdkZaMnFuQUJF?=
 =?utf-8?B?c3lYeGQreW9wV3JpU09Fa0xCMjlLcVQ0NUtFNGhmSU1FR040OWJ5U3RDM2hn?=
 =?utf-8?B?bWhOMW9BMEVKa1NtTHlpMkViWGJVT090eFVickoyUGZ0c2dsM0JJRkQyTE1J?=
 =?utf-8?B?NVRoTU1TUEdvb0ZLTjJGUkdZV2JjNnU4TVlITVdockNwVGRyMTJOeXpLNktR?=
 =?utf-8?B?MVovZWZ6endkNUl5SGprNDZJcWlSVW1aNkxuVTVWMEdmY2p5bFZ0cWZlS29O?=
 =?utf-8?B?NUNSR2F1QjhRS0lacGtPS05tallyT2dPRm9kbnRiNFVpSER5NXBKYzRJTUdQ?=
 =?utf-8?B?RXRoeC8zZFd4WE9KRTBYcy9KUjZQK1lOVmRKSHM3Sk5wdDI5MExBS1RRdk00?=
 =?utf-8?B?YjkyRTAyZCtxOXBXUTN1ZkYvKzlDWUNjZjR4QTk3anhFSU43eStsNUxnamVk?=
 =?utf-8?B?cS9iVlhRQ0pXT1VxUU5zTzVxU2R6Y1Yxd0NmVjlLN0Rtajd3bHFyVDhmS3Fv?=
 =?utf-8?B?QXpic1J4NjIwUVlKNTdITDE5OHpaUngvMG03S205QVN1WTBUTHBKWnYvUmxw?=
 =?utf-8?B?eUkrTDU5MU5DNjVjZlFkTzhrZUhDbEZNbFpEMXBlRnpvMnNSRnRvSTZvck13?=
 =?utf-8?B?U0w4c0JwNUxBdDJ5NHhDVWQ4dU8rV0pveEtFWWxtT2orQ2ZaUmtxbVhqUSs5?=
 =?utf-8?B?Wi90ZVNQaGRBK2lid3NXYnluU0ErVFl1VGZpSmx0TXVOckR3Z0ZEdEhFU1M2?=
 =?utf-8?B?ZVZpbDRiS0lMc2VydUk3T1Fkd1dOYjJsTTd3Q2p5dkc4ZFpIRHkrajR0Mjdw?=
 =?utf-8?B?R3BseTdmejlmUGxlVkRrdnRFcEVZWjc5QzFML1U0NVdBemhKSmhSckIzTzhS?=
 =?utf-8?B?WGpzc09tRzNVNXdGbWhBMXliazZWaDdMbDkwQnB1Z1NUR1ZiVVc4NzRZK0hF?=
 =?utf-8?B?T1Z0WThGMUQvOVMwcjVyczQ0eXdTbmpqR0EvNUJTU3hYdzcxNTl5dWpIelBp?=
 =?utf-8?B?M0NBTk1GSFNPL1NKTysvMC9IVGRHb255Z1c4VDNJSkxHOHYycEhXNFdHdFpF?=
 =?utf-8?B?amFWOU1WMjdRazZ2bHZJU1BZZmZOMGxzV2VDQnBsTXl5cHlDQ0VsZnBzeWJ0?=
 =?utf-8?B?aU1zTGd0UzBwUmtHTGZmWi9rbTJZdTE2allXVDl3bFFhNzFTQmtLMzh1Q0NH?=
 =?utf-8?B?aHYxZDViYUhyNEJKT3lWbzZWTkVSUk12UlZmaml3SEYyMm93UGlzeXBuVklC?=
 =?utf-8?B?WGo1cWRlZ24wSHdNZC9VMmZ0cSt6d0s5dUdtNytsTEtYRmVxcnFQM3NOcFIz?=
 =?utf-8?B?V3dCWE9wZjVNeVNmbEduREZncENYQXN1dGNIaWdJRXRMVk5VcTFjZWhMRG1F?=
 =?utf-8?B?Mm1uSWticHNibWcxeWdJcHBMVHNFY0dqT1BncVhQbit5dTdLeFZLZnNYbXRi?=
 =?utf-8?B?SkgrNllCa2xHbUJKWklHTXdFc2crdVVPbm9tTjZDT3BFb3hhREpKQURURjBN?=
 =?utf-8?B?ZW9hS2lmdml1ZGh0L3ZIZmVEM09EZ1NlRlZHcVpaVWtDK3JQdlpxN0FrWjZC?=
 =?utf-8?B?YU1Oa2pmSW1kd3Qza0ZGdlA2dk81T3dKMnhwQ0FZZHVPdTVQYlFTUGlwWUtC?=
 =?utf-8?B?clFjdDJoaDJQLzdFdEV6T2xiNldkNVErU1RkRDlhUWh6TGhKZlJPdXB1d2tE?=
 =?utf-8?B?MC9pNXF2eFJHUXJKV2lOeHZFRU52Mkljay8yTG5zV0tYclEzc0tsck82eWtG?=
 =?utf-8?B?R1M1OXF0WCswZFRRMlVpdi9JR2VVa0tVTHZYVGVKdkRKTTNnU3p1RWlXZXdI?=
 =?utf-8?B?cFJwaW1welhOY0FRcWxxSko4RmZSYXNGNERPdnZSaGxEQ1gzeXovbWFzSHRi?=
 =?utf-8?Q?gAyehldkGnl+QxFcrPAgj+LDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d4d387-75ed-44ea-d86e-08dc5283b654
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 19:41:23.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OaLPK2v9t73qOPFzOrWaiaT82pI+AMwP3aIV6SgOCdOjs3g84HwkH/bcE60UleGOLd5x6ZKJn/+6WqWaMVZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

Sorry for the delay, I got a bit busy for a while there. Responses inline.

On 3/25/24 10:54 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Hey Dan,
>>
>> Sorry that I went radio silent on this, I've been thinking about the approach to take
>> from here on out. More below!
>>
>> On 2/15/24 5:43 PM, Dan Williams wrote:
>>
>> [snip]
>>
>>>> The series also introduces a PCIe port bus driver dependency on the CXL
>>>> core. I expect to be able to remove that when when my team submits
>>>> patches for a future rework of the PCIe port bus driver.
>>>
>>> We have time to wait for that work to settle. Do not make the job harder
>>> in the near term by adding one more dependency to unwind.
>>>
>>
>> For sure, I'll withhold any work I do that touches the port bus driver
>> until that's sent upstream. I'll send anything that doesn't touch
>> the port driver, i.e. CXL region changes, as RFC as well.
>>
>> [snip]
>>
>>> So if someone says, "yes I can tolerate losing a root port at a time and
>>> I can tolerate deploying my workloads with userspace memory management,
>>> and this is preferable to a reboot", then maybe Linux should entertain
>>> CXL Error Isolation. Until such an end use case gains clear uptake it
>>> seems too early to worry about plumbing the notification mechanism.
>>
>> So in my mind the primary use case for this feature is in a
>> server/data center environment.  Losing a root port and the attached
>> memory is definitely preferable to a reboot in this environment, so I
>> think that isolation would still be useful even if it isn't
>> plug-and-play.
> 
> That is not sufficient. This feature needs an implementation partner to
> work through the caveats.
> 

Got it, I'll come back to this if/when I have a customer willing to commit
to this.

>> I agree with your assessment of what has to happen before we can make
>> this feature work. From what I understand these are the main
>> requirements for making isolation work:
> 
> Requirement 1 is "Find customer".
> 
>> 	1. The memory region can't be onlined as System RAM
>> 	2. The region needs to be mapped as device-dax
>> 	3. There need to be safeguards such that someone can't remap the
>> 	region to System RAM with error isolation enabled (added by me)
> 
> No, this policy does not belong in the kernel.
> 

Understood.

>> Considering these all have to do with mm, I think that's a good place
>> to start. What I'm thinking of starting with is adding a module
>> parameter (or config option) to enable isolation for CXL dax regions
>> by default, as well as a sysfs option for toggling error isolation for
>> the CXL region. When the module parameter is specified, the CXL region
>> driver would create the region as a device-dax region by default
>> instead of onlining the region as system RAM.  The sysfs would allow
>> toggling error isolation for CXL regions that are already device-dax.
> 
> No, definitely not going to invent module paramter policy for this. The
> policy to not online dax regions is already available.
> 
>> That would cover requirements 1 & 2, but would still allow someone to
>> reconfigure the region as a system RAM region with error isolation
>> still enabled using sysfs/daxctl. To make sure the this doesn't
>> happen, my plan is to have the CXL region driver automatically disable
>> error isolation when the underlying memory region is going offline,
>> then check to make sure the memory isn't onlined as System RAM before
>> re-enabling isolation.
> 
> Why would you ever need to disable isolation? If it is present it at
> least nominally allows software to keep running vs hang awaiting a
> watchdog-timer reboot.
> 

That's a good point. I think I was just looking at this too long and
got a bit lost in the sauce, I'll keep this in mind for if/when I
come back to this.

>> So, with that in mind, isolation would most likely go from something
>> that is enabled by default when compiled in to a feature for
>> correctly-configured CXL regions that has to be enabled by the end
>> user. If that is sounds good, here's what my roadmap would be going
>> forward:
> 
> Again, this needs a customer to weigh the mitigations that the kernel
> needs to carry.
> 
>> 	1. Enable creating device-dax mapped CXL regions by default
> 
> Already exists.
> 
>> 	2. Add support for checking a CXL region meets the requirements
>> 	for enabling isolation (i.e. all devices in
>> 	dax region(s) are device-dax)
> 
> Regions should not know or care if isolation is enabled, the
> implications are identical to force unbinding the region driver.
> 

Got it.

Thanks,
Ben

>> 	3. Add back in the error isolation enablement and notification
>> 	mechanisms in this patch series
> 
> Not until it is clear that this feature has deployment value.

