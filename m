Return-Path: <linux-pci+bounces-26338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA66A953CC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C837A8C0E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8131DE3A4;
	Mon, 21 Apr 2025 16:00:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021112.outbound.protection.outlook.com [52.101.129.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DEE17BB6;
	Mon, 21 Apr 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745251204; cv=fail; b=UTyn6fmKs+UZPCn4MGGz06LKBxYTmMJgTK5ntX0H8V3a7H6Q+oHWs5JnXA+ylil4bLqmicjCJoMJodXtv6R+Sfi8lb2oFi/qa3bKQVxzWRNhmT3e7iDqq9kp3znHbK3WVBzDSmu6tFkY6etSpv86orCgFeW62YlMM+tTYHYw58Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745251204; c=relaxed/simple;
	bh=DksRVp82TebDO4ctrDOKxHA9F+vU+NyxdNQzdtOvK/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNuC5n2mGrNnScRbPcl1mvy64ryeWfCOvYuztkVKIO0QqqKdamdnd87QpMkgNzkizzhTxKIzqwpPUEdLn0SQWRbatT8sXnatQpdWCJ3hJw4YdKG+WqHELo+Y6nrTnzUVKwVyOjaS8k1nB6VY1rpBTmat1LypuMfPmu4bYZmlIqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhJeSVCj5+5pax3Z3dHRhYbwV5UUs/2bcVB0Tw0zUO5IujlHlKtO7RARaFcd6lySQ+/gF6B9st1JLYr9+YHnS+GuA2fKzYxoBt+pxdDOKPq4NPQLnIcZ5Awcr+GjIX8jsnlpcVn7KoxamdoY+Ug3m4MDNHMMxgXIFcKYvZRM6VOettzcFkgRmfMvN66+CSBaYNV5q/GUZAInNwjYDOKMeL9owuFIOGGbvymrEemd7fZenOcDsZ1XdjC8v9zajrYL9pIpkmMBQXtHcb7zf4IhZfhMW+oZCA2qpSW9OjnXX6kqbDEuJYPlYpF+49a/NlzUdeqJMMzXs+2Y8x/JLOjvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfwVcqZIdLYa6ESa9VFX4UZ+RIhl2xtGcB894nYNcAQ=;
 b=oxECZRWZa+e8FbJ7AaoQiN/jzLgTq9U15+iRHEFmXyMkjmO90I3n/5Zl45og6oo2hTLdX72vAoW4pjaV/l9JyY0TlljjFPz714imVgnR4dlQOlc2VX/5sCvGqtmVKdMIuhttjd0f2N+p6vOzL8nf41PNVdunQD5zEnPPcfZeKea75l7noZ8iWVmhfnmp71Rh3ay7w5u4ks4OoFgv93+8J9Y1zHYJaSMqftK3pCKBVOwtmjiqF2wI3Pg5M+iv6DhWhmqQf2/U+yb0ZJ4DRPSLrpGhw9u7SiQqPrIwFHWo5JDhQ/HxC6gWETqrMEkJIr9aFgzhtzs2qlu4jPLPGiczFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0135.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::14) by
 TY0PR06MB5593.apcprd06.prod.outlook.com (2603:1096:400:31e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Mon, 21 Apr 2025 15:59:54 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:101:1:cafe::a) by SL2P216CA0135.outlook.office365.com
 (2603:1096:101:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Mon,
 21 Apr 2025 15:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 15:59:53 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 548CA41604FA;
	Mon, 21 Apr 2025 23:59:52 +0800 (CST)
Message-ID: <60a41564-43ed-41ea-af5c-eb8409b47ad1@cixtech.com>
Date: Mon, 21 Apr 2025 23:59:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Hans Zhang <18255117159@163.com>
Cc: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250417165219.GA115235@bhelgaas>
 <22720eef-f5a3-4e72-9c41-35335ec20f80@163.com>
 <225CC628-432C-4E88-AF2B-17C948B3790B@kernel.org>
 <8af8a418-b808-4a14-9969-1c6d549e1633@163.com>
 <vc6z6pzgk2sjgkghnwfzlmj3dblrvpkfnsmnlb2nnkj2leju7t@uxy3kthse7g6>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <vc6z6pzgk2sjgkghnwfzlmj3dblrvpkfnsmnlb2nnkj2leju7t@uxy3kthse7g6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TY0PR06MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 348ec270-357c-425f-77e9-08dd80ed8e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3pUSzFYT1ZIMERMTCtwN3JDclhPaG1nVFRCMHlQS3JpSWw5K0J4alBqMUFj?=
 =?utf-8?B?bkxHZHo3Y0YzZFlXUlRvT3RNdXFPZzBSazJZcDcyMkhuelErVHhqWkFSZGpa?=
 =?utf-8?B?VUNaYS8wb1Y4M2tPdnc3NGxGWWc5OWhnYUVZUkI5WmpOTUVnL3loOUZzNFBM?=
 =?utf-8?B?S3J4WmZXNzhKazM2VUJMeXUzcnllbG9IeVR4Q1g0OWVBSFZXSis0K0U3aUIz?=
 =?utf-8?B?Wk5lWE44b2l3SWtWUUhMU3l3T1NwekptUDRxSVhPejVpMzUvVDR0WFBOc0pX?=
 =?utf-8?B?WmJuT2M1ZFpPR0t2M0pYQk1rOUtkekJ4UXVTMUxoc2R0VVhCL2p5L244THNI?=
 =?utf-8?B?UlFZRmVZaXQwUHVJN3lqb3BPN0RzVzRXQ3BwTXNkaEtrcHVlN1dlMzRDUnEw?=
 =?utf-8?B?NThuZUFobXpaK0d5Wll6WDVoN0VFbzlvcUIrYlhjYVZWcEZLZXpjcnM1aGFp?=
 =?utf-8?B?SkZyZmkwZExGUDJuaUl0Q1ZIa3E1MjQ3TTBsYVBEaEtQWDV2SllNNTdGZDFF?=
 =?utf-8?B?c1FIUUhlaEtFazFTMldZaW9LRWNEVUlKamY2RVdxazVjQytkRll2OTF5ZVVG?=
 =?utf-8?B?alZ6bFhRSHUxVy9uRThsV1lUbjFnOVd3cU1HZEpwRVl2L0hzN3AwV3o0dmxX?=
 =?utf-8?B?Ykg2RGhVNW9yMTIzekZld2tBZEhISVBNbUNqS2s0amIvZzErQmJyZ0ZpT3Ft?=
 =?utf-8?B?cHNXMER2cWx2RVpEUzRpVFNxdnE0ZEp6WnkwZEt6SVpNVElqVWEzbHNtVHEr?=
 =?utf-8?B?azdqM25hTWZTSnNBN0tXV3pOdXdxbXErWnM4ODZnaVloeEZxWk1PWHRIWWYx?=
 =?utf-8?B?Tk9tclQ1MThMT09Fc0d6MEt2NmxBd2JKaldSa3haTjZ6bnVaQkYrMlFSMTNz?=
 =?utf-8?B?K29FRDdjRnV5QjZ6YzUzWUlVN1EwTFVPTmlPQ3pOQllaR0xEVkg1cFFJNFVw?=
 =?utf-8?B?aGpQVEV4RW1xNFFYK0Nobm9pdFkxR1ZxK3pGNkg5S2dPekdiUDdiQ0doMkhN?=
 =?utf-8?B?SCtVSWpGWW1SQnI1WEhJMHBpVktTZGVkNGNGZVo1cFhrVUtQcWwrVzFoNmRM?=
 =?utf-8?B?YUZ2VG1kR0g3dFRmRFFScUhSL1NUQnJtQlhIZW95RTd1OWZybVN5VU45bHcx?=
 =?utf-8?B?M3o4aXVyQ1VuMDV3TlNNbkJNWnQ5SEVmTk9sSVRra1FtMFVFL2tPT3JCZjBT?=
 =?utf-8?B?eW1JNnk2UURGenJ3RXdpRUZKVWtheUMrYU5iaXhtcXpFTk5KSm1IeEh0d2Rt?=
 =?utf-8?B?OFdRVEs1cFpweCtuUU5jbFVFaCtLMWlPUFNHa3JhNXhhb085RzQ4REY4OG1u?=
 =?utf-8?B?cWxqOXRMR2xkTVUwclNCSitpbW0vQ3NhK3pnaGxNS0ZucmFHVURDZUFaQjlj?=
 =?utf-8?B?T2VONjFobGJHWkpTWGFSZDI2b0VRekhkaW12RnNLaWpWOXU4QnZhL01IcElr?=
 =?utf-8?B?NXJRYWZjbEpvY0x3ZnVrbG5OemUwVE1ZRDUrVGFqWm13UWxCYUJXU0IyN1Fy?=
 =?utf-8?B?OVUvekJOOUowRDRLVUNYUnQwY2dQbXJJSTlpQmQrcDh2WlU3enhEZHMrZ052?=
 =?utf-8?B?Y2RzRGpLcXc4d2xxWW4wejlKOFlwM3NVd2tkM292UWRPRzgyc3QxaEZqWklv?=
 =?utf-8?B?RmRaVkxWN1RwYlZxc0w3aU1aSzYxN0x4QndZNlY4amdBcDN4OG9rMzZlN3ND?=
 =?utf-8?B?bENDa0hxZ25DY3NsUU5IaEx4WldqTUsrNWlaeDM5MFdqdk9wNC9qUHJpUS81?=
 =?utf-8?B?T29uc3NEbnJOOEhtaWloeUxEQ2JZMHU5V0JlRjNPZTdEY0RsbG9YQnBQQ3lk?=
 =?utf-8?B?d2wrd3FySnJGaEY3V1E0Q1lpeWdkTzh0amxBUktUd1ZlNXlKVFRXbm55VXpG?=
 =?utf-8?B?dExaSGNRd1J2b2NJd2FpaDJENENGa1cyRDFOOU9jZXRIUzY4eVowZG9oN1k5?=
 =?utf-8?B?YlJmZGxUaW92RWpjclVaU243N1ZHUHJOTzV2aW1kaElsV2VSTFZlS1BFc1RZ?=
 =?utf-8?B?cWs2cjRPeTh5aFVtNnN1UzE2SEdwZDJPMm9uZ1loZ0JIbk1vK0pNcFcwaG9w?=
 =?utf-8?Q?ts+v+2?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:59:53.4035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348ec270-357c-425f-77e9-08dd80ed8e1d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5593



On 2025/4/21 22:53, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Sat, Apr 19, 2025 at 01:21:54AM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/4/18 22:55, Niklas Cassel wrote:
>>>
>>>
>>> On 18 April 2025 14:33:08 CEST, Hans Zhang <18255117159@163.com> wrote:
>>>>
>>>> Dear Bjorn,
>>>>
>>>> Thanks your for reply. Niklas and I attempted to modify the relevant logic in drivers/pci/probe.c and found that there was a lot of code judging the global variable pcie_bus_config. At present, there is no good method. I will keep trying.
>>>>
>>>> I wonder if you have any good suggestions? It seems that the code logic regarding pcie_bus_config is a little complicated and cannot be modified for the time being?
>>>
>>>
>>> Hans,
>>>
>>> If:
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 364fa2a514f8..2e1c92fdd577 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -2983,6 +2983,13 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>>>            if (!pci_is_pcie(bus->self))
>>>                    return;
>>>     +       /*
>>> +        * Start off with DevCtl.MPS == DevCap.MPS, unless PCIE_BUS_TUNE_OFF.
>>> +        * This might get overriden by a MPS strategy below.
>>> +        */
>>> +       if (pcie_bus_config != PCIE_BUS_TUNE_OFF)
>>> +               smpss = pcie_get_mps(bus->self);
>>> +
>>
>> Dear Niklas,
>>
>> Thank you very much for your reply and thoughts.
>>
>> pcie_get_mps: Returns maximum payload size in bytes
>>
>> I guess you want to obtain the DevCap MPS. But the purpose of the smpss
>> variable is to save the DevCtl MPS.
>>
>>>            /*
>>>             * FIXME - Peer to peer DMA is possible, though the endpoint would need
>>>             * to be aware of the MPS of the destination.  To work around this,
>>>
>>>
>>>
>>> does not work, can't you modify the code slightly so that it works?
>>>
>>> I haven't tried myself, but considering that it works when walking the bus, it seems that it should be possible to get something working.
>>>
>>
>>
>> After making the following modifications, my test shows that it is normal.
>> If the consideration is not comprehensive. Could Bjorn and Niklas please
>> review my revisions?
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 364fa2a514f8..5b54f1b0a91d 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2951,8 +2951,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev,
>> void *data)
>>          if (!pci_is_pcie(dev))
>>                  return 0;
>>
>> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
>> -           pcie_bus_config == PCIE_BUS_DEFAULT)
>> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>>                  return 0;
>>
>>          mps = 128 << *(u8 *)data;
>> @@ -2991,7 +2990,8 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>>          if (pcie_bus_config == PCIE_BUS_PEER2PEER)
>>                  smpss = 0;
>>
>> -       if (pcie_bus_config == PCIE_BUS_SAFE) {
>> +       if ((pcie_bus_config == PCIE_BUS_SAFE) ||
>> +           (pcie_bus_config != PCIE_BUS_TUNE_OFF)) {
>>                  smpss = bus->self->pcie_mpss;
>>
>>                  pcie_find_smpss(bus->self, &smpss);
>>
>>
> 
> As I replied to Niklas, I'd like to limit the changes to platforms having
> controller drivers. So here is my proposal:
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..d32a0f90beb1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3228,6 +3228,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>           */
>          pci_assign_unassigned_root_bus_resources(bus);
> 
> +       if (pcie_bus_config != PCIE_BUS_TUNE_OFF) {
> +               /* Configure root ports MPS to be MPSS by default */
> +               for_each_pci_bridge(dev, bus) {
> +                       if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +                               continue;
> +
> +                       pcie_write_mps(dev, 128 << dev->pcie_mpss);
> +                       pcie_write_mrrs(dev);
> +               }
> +       }
> +

Sorry. Since the reply just now was made by logging into the email 
through the browser, there are some errors. I reply again as follows:
[My personal computer is not at hand. I reply using the company email.]

Hi Mani,

Thank you very much for your reply and suggestions. The following is the 
test on our platform and it works properly. I wonder if others have any 
other opinions? If not, I will send the next version and then see 
everyone's opinions.

root@cix-localhost:~# cat /proc/version
Linux version 6.15.0-rc2-00015-gced1536aaf04-dirty (hans@hans) ......
root@cix-localhost:~# lspci
0000:c0:00.0 PCI bridge: Device 1f6c:0001
0000:c1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
NVMe SSD Controller S4LV008[Pascal]
0001:90:00.0 PCI bridge: Device 1f6c:0001
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
NVMe SSD Controller PM9A1/PM9A3/980PRO
0003:30:00.0 PCI bridge: Device 1f6c:0001
0003:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8125 2.5GbE Controller (rev 05)root@cix-localhost:~# lspci -vvv
0000:c0:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
         ......
         Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 512 bytes, MaxReadReq 1024 bytes
		......
0000:c1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
NVMe SSD Controller S4LV008[Pascal] (prog-if 02 [NVM Express])
         ......
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ 
FLReset-
                         MaxPayload 512 bytes, MaxReadReq 512 bytes
		......
0001:90:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
         ......
         Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 512 bytes, MaxReadReq 1024 bytes
		......
0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
         ......
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ 
FLReset-
                         MaxPayload 256 bytes, MaxReadReq 512 bytes
		......
0003:30:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
         ......
         Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 512 bytes, MaxReadReq 1024 bytes
		......
0003:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8125 2.5GbE Controller (rev 05)
         ......
         Capabilities: [70] Express (v2) Endpoint, MSI 01
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 4096 bytes
         ......

Best regards,
Hans

>          list_for_each_entry(child, &bus->children, node)
>                  pcie_bus_configure_settings(child);
> 
> - Mani
> 
> --
> மணிவண்ணன் சதாசிவம்
> 

