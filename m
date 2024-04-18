Return-Path: <linux-pci+bounces-6413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9D8A97E4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9CB28129B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2E15E1FC;
	Thu, 18 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0IC4Rjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74715B96D;
	Thu, 18 Apr 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437578; cv=fail; b=hNtrqiWevLOn5/+jnn4xrVnUAzkwvgBS9tpO4f5CXYDzilpWjVUJGzALkoreNpuZmp1biedaajTlO77YGzJNQtiypKpzDzflxwOY5lUYll0fZ2ezjhIZNbLAWLCW8oR3F9M1X9XvgGTqEWtn5HrRPn33TZIt2SAzL1oLXM1AA9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437578; c=relaxed/simple;
	bh=ZRvujl/Cy326XtpHiD8ybAESeoFmvx5PaA2ZEUf2pyk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ca1RhMQo65y4+y6dvv07Gc5c098BJW3osLkD+ulXJLRv7ut2kDsYGcgigBRqZKNm4IZohlfd3iPAmJGQnkzLg3VduuskXPqgPV/Dsid1Komf3Aw7irtSl2Eczqjo57Ezr2HPnA+bGnh6sOPJVDp8J830gsitymvtEI5t/oMdzQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0IC4Rjc; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQFJpPAtF6S36nxCj/3WuSP4PeCwWvgLL2bE0ErmAhGn/gkHzVgSs3vpbwSellxR5WGPvzDD/a/MmugxSjhjoWWm1oPyKGXX4hz1vd0PKnFI1RVQp7OS2Uj9Xb7pfQ8I3kzfhoKpfBYup2IlLoY60CyYXBgqf+fG+cPy/zdahiDLHy3oQyeFs+pSEcNJtYvcdJb5W49Xw7J/piTBe5pGOxuLzbPJn8obu0XCb6fJKy732cR2iNQkI1JQHt7oWoaEQCaVcv5M6QS5fu1qXvkqc9XdvC86ePqT6ceedWISzUHTv+ML6FbqluIotC2FAD61igKWpXtJ07fcssVclWFYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7qT5TGqE5E9TTrsZEV38RAXRgt4rJ4kJosYuVGvvLk=;
 b=bJI0ngQbIqkY71th5uKgwJy0zvm9X1ZHkoP15RdVqhsZMymr6s+4+BGoIWfjIXcSwoChEZVB1iBIZZzubGjfYTKlJoCUhqmWr9KRTJbmh0Lux3fEbAjQR4KEN15LxBWaBG4hxkAzA6bGxrIF2PVE3/u5xDsKiRLwsVPqv+mcCb5Irn19JtvYjP/g2YwfbQvbtZIhRr0muHPUqqS0g1PX66CXE+MFOXqligftrP3E9ROyIOOPYnS3MvtbvvzdyQcaSa8rweDDVPeSWYirSUic0oZDXKmROopcfbGD6w+WisoeHLyVymd6xRl7IesuNC6AUxz4fZXtZtKyUkfM/JuZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7qT5TGqE5E9TTrsZEV38RAXRgt4rJ4kJosYuVGvvLk=;
 b=c0IC4RjczhpRfGjpaZ6y5bQq1NLGYTHOOZoYVJ7R6zCNEMsPqqaGYsNyQPq/Yl2s7GcdNpudVB1//3aog1ef6s05WE2Sv5k+3GQPEN340zKcMXke7eipvb196dpxfZzUUoWItoFow/erT9sWcPWrAuBdgDBKGBwUTQQwaEmEwxDgG7AqMGIi2IAKEXSU7WRoqrWiOt6ZWbfUvvM9M1qevmxqsDypgnM9DvpnjEtAMFfvhOXc5GbuBU1ItwO6MzdSwBmQ5688HoYl2iOopiwur8OrPAibiT0dRimqXS6KX9Y8s/96w8e+AAbxeL5J2k+J6biCBOyEx+VT+EjgXyJ7lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:52:52 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 10:52:52 +0000
Message-ID: <1427a905-1d01-4b90-8af5-acd1a7f5b1d7@nvidia.com>
Date: Thu, 18 Apr 2024 16:22:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI: Clear errors logged in Secondary Status Register
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240122230026.GA290856@bhelgaas>
 <d93a3f29-b260-4910-aaf5-d734e6242223@nvidia.com>
 <0c948351-9715-4c5c-ad0c-3727cd2ba8a8@nvidia.com>
Content-Language: en-US
In-Reply-To: <0c948351-9715-4c5c-ad0c-3727cd2ba8a8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::19) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cd9b77-eb02-4737-abc8-08dc5f95b1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yg5VPMwqZsZlwfBA1UZt/whu4u1QfUKmqCnZ8BBLCr8OHPVlptXTHc98eQF0HhVhL5radQ0QWaytn/D7l122fC/HJUjM6Z0S5MU3HHnq6QfIw2KR+7bO21jfBga9OSWVYNJxiD5WUf7dmkWtX0yhZ+CgZbEFQS6PUn2vHLvUoLBk3JKGDbNjUZcvinxwI7VYTiCvBe2eggHco8EZB7MY/IamXkIOY6YDmAxvZHjhe4dWKIa2slAQD5epZlh9a916j5tttt/rcrLEhMdrvfSW4rFxUbZjjbhKDEbCccnQSXWtaV+gk2xZdodAHcmHs7x7GskKioCJa0p50cgwJGVeMCE8ZFlZp9pRcQFmh/o6q8RnCAdxS1ASG1vHPmc6gcCP2+unhvs9yd3Xt5/dFrE5Qaoc+4Ayo5Gi3CyHPDtVqvQmjQB/wkxwRKnr6uqMBUdcFG9wGPkyzdw2cgb5HpEFGyJasdbNsb34/fLSMPUufjujp+Aa7n+dy3a0rBQnSVhpv2Pp5jmKyo13aKX89JHqKoWYwRnXznSQZEkFoiMN4joziORddXbyIR/9xX9GiGbXOVnCU1IyUChHpf7/LP0gBTcUpdREpdGJnQ7IMYBIEqSjOlff7HCirwopQ4Bsg9p4zJtTqvqJavR8iwFyafyGwG6M6QqInVpaaT6aPMizI8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUx2eE53cjJoVU9QL0toUzRKck5ydTFtNUhGcUhLNlhhR2tGeWFpT1hOUmpj?=
 =?utf-8?B?MTZnVnpiZG9XY0xOY21PcVk0TUJRSnJ3R0tYd0xrMEptK1cxWDkxU2pqZ1Bu?=
 =?utf-8?B?SU42dXB5WDdkWmNtckF5QXVmVFV5VUQ3OXp1Mk1obGU4KytRYkNZSU1LSHYr?=
 =?utf-8?B?VnF3a3NLTWxtTC9GazVpYy9QclpOVE5pR2ZtUHRLNzhoSXBVZVV5Ti9NUkNU?=
 =?utf-8?B?NWE0cGNFOXdsS3lrR3pWakY0LzVjYVNnZzRzV1dEM2RjV3VCNnJDMDYxdnhn?=
 =?utf-8?B?Wnc0ZkVBbVBTWGM0UlVETitmM2VveklLT2VLOGpiZWVxY1lNQmhGTU1xdlRs?=
 =?utf-8?B?YkxwcURvTUVvRm9mTWhmS3lIL3ZZNzdCS0U2VTJxS0Nwc3h3Vy9LeGhhZDR2?=
 =?utf-8?B?M1VpY0srREk2NlFxekNqM3ZFVjZVUDhmbVJ2QVBOdldUS1dMRDdGbkRzMHEw?=
 =?utf-8?B?dkl5cVY2NlBpQ1FDN0RkRmJCYzcwa2dpVG1hYXNYeHRianMrc0FqQ2N1ZTQ0?=
 =?utf-8?B?VWVMb1NnOXB4SmkwUFhrSUhvN2Vmc2dBc2ZPZENEc0JQc1JVQVZSSTJ2MTdJ?=
 =?utf-8?B?T1dWVkx4NmJYeUc0YnUxMUhDY20vYWtuNmNOd0xNa1hQaVRiRTYreFZqUU9I?=
 =?utf-8?B?dFB2QWpoMEdKWFBIa0h2ODVVL0U2M2pXM2s1dkZ4OFJpSTBOWEhYbGhhdnV3?=
 =?utf-8?B?Vk1RRVJ3NlhRUnlPZzdldFY2aWs4MHc4QmlFUFNzdUxMS0FOSWIxUFNVbEdQ?=
 =?utf-8?B?bE9qdzNOM3Jnek1aYXV6RFdVM1d0VG5obHlzS05FeVZsVGFpUTErV24vY0Ny?=
 =?utf-8?B?OFBsYmFCc1BvN0lJdHZwVHd0dHFlK20yS2VsRlM1ekpMT2VweXdJeHFPNmxv?=
 =?utf-8?B?dlNUK2svb1crSjE5NjFiRWM0bVljUmZOcnFvZDJGMnBLeitBMzhMMFdkek0r?=
 =?utf-8?B?eHFkZExvaEJSSWZNOHZuczZZcTFjMjYrV2M1ejR2WDgzNnZzYkNuem9yMzY4?=
 =?utf-8?B?b0NUYldwS0pWT25vamVWZUtBbmc4dGhPRGtEZ0VBZldrUHBpT2NwTGNVQy85?=
 =?utf-8?B?UzgwVWY5NkxXRHVUNlB4SytNSjg1Rk9pKy9Qb1ZoamlQT3dQWFB1a24zUmNT?=
 =?utf-8?B?VXZLZjh3b3Z0cTYzV0d0L1JLblBtZE5qMk83bzhLNHBvblhFUG1MU0xkNDZ4?=
 =?utf-8?B?b3Q2NGY0anBYcFZDNUZ3Qy9aN3UyZkY3cjhUYmRwNUJaZjY1NnoyZzNWMnpw?=
 =?utf-8?B?QVc0aFNqLzJaT2JqOUNwd2FQS2l2ZFNtWExCVEE0RmIzbHpWSVNaZmJHd3BC?=
 =?utf-8?B?Z3UxRlYrRTM5dDd5YVZ5dEhPTEVIbDZOUGp0aDdoYVY0dDNEc1JoaUUzOUlQ?=
 =?utf-8?B?ZlBCU3VkWDJzMXc1QlRTeG40SDIvTlAxT21kV05uRWxsbzRZdk5vclJwUFhD?=
 =?utf-8?B?RkhjQ2hweVdodzh6VFpPQUpwOUZ6YUVWOHNDaEhrQWpCTEIxQmhxNFc0b2s3?=
 =?utf-8?B?MGJ2d05iQlllNFY5KzQrSm40S3c1OStaL3JMRU8xYktJNk1tbnl2cXBzYkJr?=
 =?utf-8?B?YzRWOGs0TTVOUG81WUV4OHUwNXg0NDBKcU84WkhCYjd5MnBtSlZSU1RxVUNz?=
 =?utf-8?B?aExXTGgxWHpmeGNuN25LbkF4eTNLZDcyZDJ2ZXJDazZmaENwMHhaRnIvNzh0?=
 =?utf-8?B?Qlo1VzhoTG5kd2NqOTd2SG1mcEhwTmVKLzRpT2JsM1VoTUppcm4rVGNYbEtE?=
 =?utf-8?B?QzZXTE1Ya1NKNUFXKzZPRndHMk1SUDJpVkxSbFR3Q2pvaUxsNm9BM2h5MWtl?=
 =?utf-8?B?bnNkN2hWSzZESmdpSlZEWEhoeFZHckhjTitwRTYrMGNUYjA5U3BZa2tmdHJI?=
 =?utf-8?B?NUdrUzJSNHhJSjA3VzdTSm01NWdOb1F0dGd1M2J0SVEzZ2M1RVkyeDFMakN4?=
 =?utf-8?B?U3dESWpOVldSM1phMDM3dDdxNjJvTkllSmdTNXhTVkNMVEhkenBrOE0rRjJs?=
 =?utf-8?B?VU9vWGV1ckpmK1Y5YklwSEVEVjRMS1RnSi9oUDd4eW0veVFzRjBMckJiWHhR?=
 =?utf-8?B?bnhEL2hIcktGWGJXQVl6MnRySVV4QVRSZ1pEam9ZODNlR3pwU3g0RjJ4clNj?=
 =?utf-8?Q?qu2+25vPddTmIeqSf8g3vD2vj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cd9b77-eb02-4737-abc8-08dc5f95b1e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:52:52.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vmvzy1yR+ADUmOqb7ccaQ04JZxADCoyPzncnoa8+ReGrFe3uJcOP92xW+2lT+IoP/XPr+j8+Qp3lAHnmUL5BkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

Hi Bjorn,
Sorry to bug you.
Is this change good to be accepted?

Thanks,
Vidya Sagar

On 01-04-2024 13:29, Vidya Sagar wrote:
> Hi Bjorn,
> Just checking on this thread.
> Is there anything else you want me to clarify on?
>
> Thanks,
> Vidya Sagar
>
> On 14-03-2024 06:09, Vidya Sagar wrote:
>>
>>
>> On 23-01-2024 04:30, Bjorn Helgaas wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Jan 16, 2024 at 08:02:58PM +0530, Vidya Sagar wrote:
>>>> The enumeration process leaves the 'Received Master Abort' bit set in
>>>> the Secondary Status Register of the downstream port in the following
>>>> scenarios.
>>>>
>>>> (1) The device connected to the downstream port has ARI capability
>>>>      and that makes the kernel set the 'ARI Forwarding Enable' bit in
>>>>      the Device Control 2 Register of the downstream port. This
>>>>      effectively makes the downstream port forward the configuration
>>>>      requests targeting the devices downstream of it, even though they
>>>>      don't exist in reality. It causes the downstream devices return
>>>>      completions with UR set in the status in turn causing 'Received
>>>>      Master Abort' bit set.
>>>>
>>>>      In contrast, if the downstream device doesn't have ARI capability,
>>>>      the 'ARI Forwarding Enable' bit in the downstream port is not set
>>>>      and any configuration requests targeting the downstream devices
>>>>      that don't exist are terminated (section 6.13 of PCI Express Base
>>>>      6.0 spec) in the downstream port itself resulting in no change of
>>>>      the 'Received Master Abort' bit.
>>>>
>>>> (2) A PCIe switch is connected to the downstream port and when the
>>>>      enumeration flow tries to explore the presence of devices that
>>>>      don't really exist downstream of the switch, the downstream
>>>>      port receives the completions with UR set causing the 'Received
>>>>      Master Abort' bit set.
>>> Are these the only possible ways this error is logged?  I expected
>>> them to be logged when we enumerate below a Root Port that has nothing
>>> attached, for example.
>> In this case, there won't be any TLP sent downstream. I talked about this 
>> scenario in the
>> second paragraph of point (1) above.
>>> Does clearing them in pci_scan_bridge_extend() cover all ways this
>>> error might be logged during enumeration?  I can't remember whether
>>> all enumeration goes through this path.
>> So far in my testing, clearing it in pci_scan_bridge_extend() covers all the 
>> cases.
>>
>>>> Clear 'Received Master Abort' bit to keep the bridge device in a clean
>>>> state post enumeration.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> V2:
>>>> * Changed commit message based on Bjorn's feedback
>>>>
>>>>   drivers/pci/probe.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 795534589b98..640d2871b061 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct pci_bus 
>>>> *bus, struct pci_dev *dev,
>>>>        }
>>>>
>>>>   out:
>>>> +     /* Clear errors in the Secondary Status Register */
>>>> +     pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
>>>> +
>>>>        pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>>>>
>>>>        pm_runtime_put(&dev->dev);
>>>> -- 
>>>> 2.25.1
>>>>
>>
>


