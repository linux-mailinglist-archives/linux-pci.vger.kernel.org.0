Return-Path: <linux-pci+bounces-2405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B9835A97
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 06:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9730EB24E3E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 05:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565E4C9D;
	Mon, 22 Jan 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xlFFFeTC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE35681
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902751; cv=fail; b=mNfgfl8BwFS1Kg9ndph4377HCJcAFJxXKD3k7slRWI2rh53Dgwm7xulieSSwg+g0OlCqesaosOyhNSNq4+9ouwIpQsOzV7okXmqjrsPmQzu0+nCyixACvKWKUUJzolv1iTJQfGcAOO8+z3hAZ9L+zzjwgZj14tRqwYhL+7+K4FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902751; c=relaxed/simple;
	bh=o6BOqx259A5LB9Cmh3DfJMU9LbGqn+ydgdWIII9TX9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jYNtfXPyJZ823uUPj7kVPpbvWtI7Rpr4y4ROrvNWEYMOO1admrZTWZJJFuv5qUCAmmeA5ZVLjxYCP4HVfVtlq+sdsvj0RgOXLphuPVaaZPL5TnhMJscqqWqRQYAoLo8JcQJ4A7HFvCYfLSVqPf/rkBzBmmXuCbgcqxM3nvCNJPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xlFFFeTC; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuOSvGuAD/0TZWt/0LGnNo1Xs81DlKE2TKFBkGpu6obcZgZ3mkjUDgdDXTvcswvVTaEFmS6ks+zD5xR0Bqv3LIy/CmZf+YQdK1MxnMsE0yAEoR1pIQzXS7XJTmP/vZWvB/T/qbEEMPkOC1tuF8mOeIa20aDNYADyQW9PTJdnKKJ9mTOhjzs/ZJ8FweX46A77pQpvvdyEkFDmMn7kw789MHXVSXpEOOSa+EH5b1qhEeCZ6YVtvlQq5p2RbY2Bj+Vc8tmER/qOxJFN/OojY+l4F7hE29OJ2fqXmbgR3XSu/jMxxu7hF1yZNj2dQXJ5oHTCSy7PiBN+sijM6l7fKrOGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylp/jtXE2yAsTzHmJtQQfbNSNvLBD03MAn1Mh+5EMag=;
 b=fFhtP1GG2KTHUXTk/5asIAhvhck49o++Y4isMExrlg7cZpQDdFQxggMsq5h2pcncyYH4LcQ46G/q9FBCIxFjch0KKVtsiENyZas6DbYI8s6+XlPddhFkIGaNsDZs+aNvD5RNk3R1oKLnB16eSfUmoqzLTvEbAmJKGikuTZrJHW01TFPnmlt872hGrW+Ro4XrTCu02nTqaITb1uErfS33HZU8lgwIt47voYFP9PL1Xo7ehwpK4EnNB3In4Ae8CZYzw+Bv2Zb661nwsLUXJ7A/4oWyb6tUrxBgn8hdM+NvqdEz0VIb7XcnQSwMIJB7ApqHML5w+pNvTpKrm/2hc6tL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylp/jtXE2yAsTzHmJtQQfbNSNvLBD03MAn1Mh+5EMag=;
 b=xlFFFeTCqALzus6yGXrOEcJYR4rFeVvTotOsgDqVwNHOeUoBjvITrKjm27Cm06IsievNFeVduc9ENeq99xKZmGMk6h/kZcz71Hdzp1NoicMKBiCMl/7Yp/BgZw/VUbrIz5pmyvmWErGYkXWObJyjejdyGNSCj0U0mhsR2V+UgaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 05:52:28 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::4821:25c:ab91:94f3]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::4821:25c:ab91:94f3%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 05:52:28 +0000
Message-ID: <88e450b5-5be0-2203-3474-45778503699d@amd.com>
Date: Mon, 22 Jan 2024 11:22:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Keystone PCI driver probing and SerDes PLL timeout
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, Greg KH <gregkh@linuxfoundation.org>,
 s-vadapalli@ti.com
Cc: vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
 tjoseph@cadence.com, linux-pci@vger.kernel.org, ylal@codeaurora.org,
 regressions@lists.linux.dev, jan.kiszka@siemens.com
References: <20240111141331.3715265-1-diogo.ivo@siemens.com>
 <2024011246-corned-disregard-7123@gregkh>
 <1cce86b1-b309-40e0-afff-45baeb013e1f@siemens.com>
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <1cce86b1-b309-40e0-afff-45baeb013e1f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::20) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 89467719-555a-4cb5-a0b2-08dc1b0e50b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I3GGM1Dy+MXH9kMsR+mqgFI1eiiBZ4+Qqp4tq0WvwG3NT4MR03r6WGvvgurjDdmEmmZHpUxBB9VSF/2FSlAxPUfexpvD/xr4R7jgcUdIV+KysBCT0hS3wiZDbHQA7LKmAQxnGqaao2YJD8HrwUMWvtU9abql8NkS7NaQlP1TWrk4HwnpQTm3c8WcukRi7BWcGKNu+9Sl8vO9WKnOoiQqBdVqKGW0uW7t9O8gamy4Op+p3xEO7Oqv5Qf2YwXeMMlvxFjg489KDzmTfGh2rtIdpieO+56zgfiQLIBCl4ng+qE4qZeVNjoy/ds3sXe1Ev1kFyJ4isnbz7BXo2/hZyzMyhP0Xb3jDzEPBnHRQmfxn3PnPPNv+Dx6ECMgzB8YX0fLm55hvNxSmHhL+hCQyGAfOPWJ8d/m2YzaLmGReQzAvAxSzGTnWQW1CK2PbRW0MaadlTDyEvTiGFNpmXkpI5b/ONX1HDkpQK+3mzAoLsjcJtbM1xtDpuHTR542hIdf+UkB+NKAd4XShxuzTr2IoNYWh0dvG/qparfX9eDG4X5SgEKLchd3e3V2eAcGUWAu4mQQYR0W6g+qPkNn8fpCZ5w8HqVYs8yRwJxH7K/RoERQO0YPXyl2ZeUtouxWcONJbe83UjA2RRJvyvyc80Wj4ShxiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6506007)(6666004)(6512007)(53546011)(2616005)(26005)(38100700002)(31696002)(36756003)(41300700001)(83380400001)(5660300002)(2906002)(7416002)(8676002)(66476007)(66556008)(8936002)(966005)(110136005)(6486002)(316002)(4326008)(478600001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZqSDJMandCWWVCMVIwMTVTVWowdjl6VkZRb29oRmZYRW51RURGMVFzaWQy?=
 =?utf-8?B?ZTFha0xXVUFYZ0hubU45RlFPK3cxc3lNUnZPTmVSYkNwaWkwaWIxOEdybkxD?=
 =?utf-8?B?M3ZvOSsxNS91OUlabXFCK2piWlE1bG0wOVAxc3V4Tlc2ZnAySHV6ZnJETjQw?=
 =?utf-8?B?WC9QOVJFVjhnNHVPb2pXOUZmVmxhTmdFWFRsUndaaDdJOXd6cWtObTd1YmRn?=
 =?utf-8?B?QlVWMkpnajhyVEhwaDRuZ3FYdFcrOThsOTNObkd5aE1QZ1B6MFozbjVqMjVV?=
 =?utf-8?B?T1RKRU9KbDZuM0ZvWlpkTGNtWmpUcEQ0NVRHNUQvZzJ0Uk9pWlVWMlR4N2d1?=
 =?utf-8?B?MnlxeVlyR3FsMFJuREt4T0g0WGpJY09NYnZoU1luWnR0bjVFWHk2Mmwxb0RL?=
 =?utf-8?B?SG5qU2FqNk5yN3hLdnlFNC9NZlM3VnVTeUFjSlh4emE0RVhVdVRPZ3hDR0lk?=
 =?utf-8?B?UWFjQjl6MTM5Y0NxY3Vyd09KRHQrSnc3Vktad0wyV0V5ekswcjc4QmtvWGpv?=
 =?utf-8?B?b2QwWFV2UFF2V1hWZDRsSWg4WW9pNzhnQWczem45Zk5CYUdPSDdwUTZ1TnRT?=
 =?utf-8?B?QTRYTmZJTDBrdDdPczh4RldydnRuQ1FvM2xleWNhcU11ZzUzNi9LOTJNeEh2?=
 =?utf-8?B?R01aWE5QV0ZEYUNQdUUzSUJKdCtYdjdnM1VOdENUSWJSbjhNKzFid0Q0QVEw?=
 =?utf-8?B?blRXOVNiK25zaDYvLzNvQjRuYnluR1Y5V2xjR0xhN2VMRGwyZHg1bUxTbXJT?=
 =?utf-8?B?YW1RZjB0eXpBNUF4L2lvOUxTaktxK1IvY0t1dUw2Z05rQitPcDVNTjE5MVRE?=
 =?utf-8?B?c0VaOVpUZit5UXZHa25YcFF4aTJzUG91cVlyS0kyUkZMSEw3aEh4TTE0dU9o?=
 =?utf-8?B?QmlNVUpPSXBpK0ZSbGRRWWtzQUswTnRqQk1raWtwVmRvcEE0MEYzUTA1UG53?=
 =?utf-8?B?ZEEvQ01JU0plaVRFZjhpdzh4VUlER0dHSW5hTHNtZVVhK2UwTDgxMFk4TSt2?=
 =?utf-8?B?TGw3YjcwRnoxYmJrdHVTRkgwNVlOckVkSFJ4WDFDUkdTUEJBK3lRalBDSitL?=
 =?utf-8?B?SFhxRGdwV1c0bDlyS2tFdGJaVjhoNnplY290V0IwTHpGRTk0aTFERGlTM01R?=
 =?utf-8?B?NUxmekduMnVDUCtsTGxQVHRSZzczSVJzNEtnM3ZmS1lrc1UxWkp1QmN3MzJI?=
 =?utf-8?B?NWlUaHpQUnFTd2E4ditWZEU3ZlhwOFkwOWEzdlBGamNwbE9oSDRpM1c5OTlz?=
 =?utf-8?B?YWxveTlHRkc5L0xEWnY2TU9XQ3RGL0dpVkpJMWl2SWQ0NThNQTZidERhU0tl?=
 =?utf-8?B?bzRUajJjaldhaTAvN3ZLUFBueFRwS2NDZ2NxcnIzVDZrV1Z3eGlKZU9CNUsy?=
 =?utf-8?B?Vi82UmlCdVJCNjZVemVvSUorR0ozZWF6Z2llQnROa1VSSk16eU14RURCRWVT?=
 =?utf-8?B?YnF1Mlc1S1hTN09RRnllYTZoZzFMWmlIZlNaTlJXYkpTbDJXR3dxNzBZZWVJ?=
 =?utf-8?B?MWV0bHAySytEVzBEdUtKR2hSbkZMZ3ZKWE8vT3hsT3BLakM2MHQrYTcrQzJ0?=
 =?utf-8?B?bys5SmVQNjBjNHp4LzdFNmxQZi94dHNSYWFjTit5ZVNkVFgvc21PVTlUMFd2?=
 =?utf-8?B?Vzd3YTdiM04xbERMdWRYME5QcG96RFZsUU96K1hIdVdZMDNMMVBScjRSZmI2?=
 =?utf-8?B?M2ZQMzkwMThQVzg0ZGlyRSt5WFdLTXVDQVdPclY1ejVvRmhlbWtDbXhWVGQ0?=
 =?utf-8?B?V1lQY05pNFZxYjFmN1hLQTlHUm0vVW9xQXJERmxmQzl3L3Z6OENSOWJuL3E5?=
 =?utf-8?B?b2FJRWNIdWdOU0MyVEtlaHJHWDFXWHFKaE5rUVU3cmtMaEgzaE50ZWV0UWE5?=
 =?utf-8?B?TU5JVzBjSjdNdlhhNTJ1L0dsL2NjZndUbHJ0cll6K3ZpbmVycjdhZGIrZThs?=
 =?utf-8?B?clV5MmlyckYwOTNOVzVtQjBDWFlIeDVNMzJqYVJWMUcxMDZhdVJqNWZ2cDBB?=
 =?utf-8?B?RmswODVZOGRoYmRXL053NkZIcS9oZFR1VzVYRjI3VVhHVjhFbE9zV0dyY2Fz?=
 =?utf-8?B?Sk50S0tXbDZvUjFhTnEycG9Oc3JmMUROclNoV3JWWEJ5Nm95L0hOejRnZFhW?=
 =?utf-8?Q?TTFxNmrE24GCQVmqqdDeo0ZDK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89467719-555a-4cb5-a0b2-08dc1b0e50b6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 05:52:28.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJQbaDhoUcpdQy51+bfimObglBqnxrYzeTsAvhfDbac0vQbM2xQfmVSwpPxh7nDtMsWSrOhSPw5/qJjyL40VIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

+Siddharth

Hi Diogo,

On 1/12/2024 5:16 PM, Diogo Ivo wrote:
> 
> On 1/12/24 07:57, Greg KH wrote:
>> On Thu, Jan 11, 2024 at 02:13:30PM +0000, Diogo Ivo wrote:
>>> Hello,
>>>
>>> When testing the IOT2050 Advanced M.2 platform with Linux CIP 6.1
>>> we came across a breakage in the probing of the Keystone PCI driver
>>> (drivers/phy/ti/pci-keystone.c). This probing was working correctly
>>> in the previous version we were using, v5.10.
>>>
>>> In order to debug this we changed over to mainline Linux and bissecting
>>> lead us to find that commit e611f8cd8717 is the culprit, and with it 
>>> applied
>>> we get the following messages:
>>>
>>> [   10.954597] phy-am654 910000.serdes: Failed to enable PLL
>>> [   10.960153] phy phy-910000.serdes.3: phy poweron failed --> -110
>>> [   10.967485] keystone-pcie 5500000.pcie: failed to enable phy
>>> [   10.973560] keystone-pcie: probe of 5500000.pcie failed with error 
>>> -110
>>>
>>> This timeout is occuring in serdes_am654_enable_pll(), called from the
>>> phy_ops .power_on() hook.
>>>
>>> Due to the nature of the error messages and the contents of the 
>>> commit we
>>> believe that this is due to an unidentified race condition in the 
>>> probing of
>>> the Keystone PCI driver when enabling the PHY PLLs, since changes in the
>>> workqueue the deferred probing runs on should not affect if probing 
>>> works
>>> or not. To further support the existence of a race condition, commit
>>> 86bfbb7ce4f6 (a scheduler commit) fixes probing, most likely 
>>> unintentionally
>>> meaning that the problem may arise in the future again.
>>>
>>> One possible explanation is that there are pre-requisites for 
>>> enabling the PLL
>>> that are not being met when e611f8cd8717 is applied; to see if this 
>>> is the case
>>> help from people more familiar with the hardware details would be 
>>> useful.
>>>
>>> As official support specifically for the IOT2050 Advanced M.2 
>>> platform was
>>> introduced in Linux v6.3 (so in the middle of the commits mentioned 
>>> above)
>>> all of our testing was done with the latest mainline DeviceTree with [1]
>>> applied on top.
>>>
>>> This is being reported as a regression even though technically things 
>>> are
>>> working with the current state of mainline since we believe the 
>>> current fix
>>> to be an unintended by-product of other work.
>>>
>>> #regzbot introduced: e611f8cd8717
>> A "regression" for a commit that was in 5.13, i.e. almost 2 years ago,
>> is a bit tough, and not something I would consider really a "regression"
>> as it is core code that everyone runs.  Given you point at scheduler
>> changes also fixing the issue, this seems like a hint as to what is
>> wrong with your driver/platform, but is not the root cause of it and
>> needs to be resolved.  Please look at fixing it in your drivers?  Are
>> they all in Linus's tree?
>>
>> thanks,
>>
>> greg k-h
> Hello,
> 
> I see the point that this code has been living in the kernel for a
> long time now and that it becomes more difficult to justify it as
> a regression; I reported it as such based on the supposition that
> the current fix is not the proper one and that technically this
> support was broken between the identified commits.
> 
> If this situation is incompatible with a regression report then it
> can be dropped as one and we keep it is as a bug report for which
> we are looking for input from the community.
> 
> I agree that this needs to be fixed in the driver since all other
> drivers are working fine with e611f8cd8717, and yes, all of the
> drivers in question are in mainline, where we performed the bissection.

Looks like Siddharth from TI fixed a similar issue reported by you here.
https://lore.kernel.org/r/20230927041845.1222080-1-s-vadapalli@ti.com

Thanks,
Kishon

