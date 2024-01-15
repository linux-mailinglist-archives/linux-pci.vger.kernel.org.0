Return-Path: <linux-pci+bounces-2153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DC82DB52
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B260B214D3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E915A5;
	Mon, 15 Jan 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AoFDiZHW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC91759E;
	Mon, 15 Jan 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuQjpgex3YJ7KuGSYIzTJ4yqtZdKaXbECUUrN9MTdIcNbZAO/LMIYRfHL4SZ3WQyWJFhXom57pI3kyyZpIolZ9nd7ZutJ3pKeO9GnIDiryv6z5t+WMGnDJhjzGZfrJTm6ETDIcNPONSN5cDh9daqVnFWSQFPhhD9F0GKa8MtEqoNTQqCI21j/zpLYEHGFRUb3BCungM70vLIvRaUaPUI/YdjgLgONfbFJpDfpPQ/J360y/OmOq3rqDgEuULWQopV5GlRzGsuOpwgmsT95m65VCzp8Mjhljpl1zyS2uOC2wtS/H59yTp9J0wnrgG6YYvoDspDzEflIX8NlBgtWbkAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMI6jzx/sVGVrU/71xt5ejmVPUROg2dZO/aZt55pMjY=;
 b=On2EyUFvAWll+3cGcvaaAgOtd0HK8VwAwH/WPfGse/CWs1yiAqTkHmSdboi+lKX5kEopraKOruy8B2v/ewvVOdD08BWtaF2pGenvhXMlmorz+TH2zXjajBBRlTrkkWovw6Fvbyfvg7EJszwrZsWK5y1Aub32A3MiEyO57LwxYUB1Von52l4i/ugTPH+iuE/UpWCNbHFTiitQHsN65kkFp07HNGeX5jHA/Jnn5YnOIKoxUHfSsMZuvBuErnISiAdcnU4rCL4ZoeiUdo7o4/NtUbDvA6OmjzMytk11Tm+kx/t9Y7MbdeszWsC478vRLuRKyo2KZrL5EUF+sUmKzOtmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMI6jzx/sVGVrU/71xt5ejmVPUROg2dZO/aZt55pMjY=;
 b=AoFDiZHWSq47l/O/o45pyEESN2lGOt1yGJn0YcVwtU4Hfdv5UvSSnBlBR9GVSsD1mutENqM6CwEBALgu4/B7a+MY4qHr2ZxwAawiZEIQoMgEmUcvoOCkeTr7UGbu2Sjwu2P7RtUNAetg1vHLA4m2LwcQWJU8/G2RaubtPcBLMOeoTW3vLum/Bhya7/eJvAG5B9qW1s2KyEADCqKAdXoIAIlwjZ5EUdYFmZNbq9SeSsP0Tj0EckFXLH5B0lmSsDVPzoHI4LkegUaM7hx3PWqv6486d8ScIIMtrZyfMT0aRT72XPU9Yyk1PzL60v5I89ivz2ZpOGCb+InRP6Iwe790+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 14:33:11 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 14:33:10 +0000
Message-ID: <5e8f6c52-6149-42c0-affb-d8b072a77956@nvidia.com>
Date: Mon, 15 Jan 2024 20:02:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] PCI: Add support for "preserve-boot-config"
 property
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, robh@kernel.org
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 frowand.list@gmail.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, treding@nvidia.com,
 jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
 sagar.tv@gmail.com, kernel test robot <lkp@intel.com>
References: <20240112165830.GA2271982@bhelgaas>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240112165830.GA2271982@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: eb58cc61-e126-4645-4f33-08dc15d6e5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HruN5eKpbxKPDvykE79JfLBLeZvT8AU9Y5piOiwu3UMZe9/2MShOO7a41Tlv85A9dgyRZHrz4IflsR2nf9T4MOKjUbYB02imtS7G9YHf35xHvqX0A47fHQsHPkGZ38w0cKGYT3vtpfbVMbIxcjfHtk9qPsAfHh7e3OckRjqtmuo2+Mkz8R0b8nfkA0TMXFK24f4DgZ3UI2B5Ueli+in6OQXfihDjcGXuSrBqpPNK4dJoqdrW6v9MctqcdUQeHzcepkr648FN4uSFpyLD31S2PpXKxnVMmDl8/4kwtg153QK5QmIdwQBLw/pqkEz++GhXM4yuP3kOmZZUQvI2rth0uqLwnIBafBX6Flpr++eNuqKNs5P+9WFJrlEyKg4ClLnyXqsByhka2wA01clWBMZw7uOy0E3C+pfaUoj9KRaYnlz6kJLj9TDaZBbONi3O1mPdCYRUT7Xew9CZ6TtJnIgepvvqpbAsGRzKZPY4Be9G+wAyHGRstyXHpyllccn0dLsY/l2ECmdH5l//TukZg5qGEiqbP6Wa7R0A7jxQlxysljeemWjDMQycl23VsGJprZEb6sv7HIpF7+cICvhUd8qkghoE9d2KAlVFiACV763yWE3oOccBBxKDBeuMo72uBne/8knsWBZ7jEN1tKV9WS10RU2m2zVPAEjN6lSN5K/0pF/H5lwFAdI8GpZpsAZBjAnk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(86362001)(41300700001)(36756003)(31696002)(83380400001)(2906002)(38100700002)(6486002)(478600001)(26005)(2616005)(66476007)(8676002)(6506007)(66556008)(316002)(6666004)(66946007)(5660300002)(8936002)(53546011)(6512007)(7416002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzhHMnNTSWdPSHlLUjh6K1ROOEZpcFhZcGNNcnpoMGdJOGhuYWxuTmZzbFZv?=
 =?utf-8?B?VzFCWldWNVFVdHhwUlV6SXkxYXRZMUFVM0NveFVMNWoyczdod0dyaGRCaXB0?=
 =?utf-8?B?dlRXcHFWbGZXY1BhbDRNaVNDWXpUYXVDOVR1emQxdC9mWE5hQVdHT0tkNXNj?=
 =?utf-8?B?V0JvNU5oaFNBY0QyZU1pUnNOaUtybmc4V21oaEVhUmIwVGFHUGVpSHNHdkpO?=
 =?utf-8?B?Z08rTG1CMmVpaldvWXMrOHlUa1o5TzUyM28rTUE3Y2owV2VyOFJyVUpEU3NM?=
 =?utf-8?B?OXlpS01qazF3Rk0wcEJyTjlFbEZtbVF0VnQyaVZsUGJ6bHZ6SG8xZk5mSjAr?=
 =?utf-8?B?Z0ZEVlN1cXJFSytJV1VyNTdobkNOMDFrblY4Z0dQZVRHZm0weFBJaURjYm1r?=
 =?utf-8?B?ZWxlRmI2Z3NJN2hVRWVhdFZHWEtVTlFoemd0blYycGxVeTRQN0JaQXB5Wm1T?=
 =?utf-8?B?d1luMkVmcG1vUzJFWVVQazU3RWdmSUFyOGJjVFNNWDVaanNHdDFROU5QT3Vu?=
 =?utf-8?B?aXJubmNVVk5OeXVwQ0lmdXpRa2pkanpDbW5iU0lZdEdoZGZCYTZmS3Y1OXFs?=
 =?utf-8?B?U2VLR05hODNkaTkyVU5Gdm1Fa2RycmNOWHk0V1JJdm4vcklkaW1IZDZ6WlA2?=
 =?utf-8?B?MEJGbVY5MEoxN04xMWdRVGhBMmpvRnVLanFMb29tK1ZQb25McmRMRjBGRFcy?=
 =?utf-8?B?czRzTnpxaSt6Z0t0MTMrUWJTYkZwekxWVWVaZzEyeHRVUmgxYWNjaU11L1R3?=
 =?utf-8?B?WGh1MEovOFRDaXhQdFVjendSbko5aENJWkV0V2dyR2xGclhQcDdaOTVGUFFU?=
 =?utf-8?B?QUhGcW5BSHJCL0hCVkJwb0hTK1Z3NVVZR3NqYzQreUJEUEpBMzRCRTVnZTRh?=
 =?utf-8?B?WHJ4S204SEVVcERnZUNvY3lJMm1tQStYTUNWaTVFWXNjdWtFQ3FDUWRwVVNx?=
 =?utf-8?B?ZE5Md2xwNEJDOURBSkxWSWNUMU5YOXp6UDE2T0hiUkUyNU1XS2Q4NXFXaWlJ?=
 =?utf-8?B?am1QOFlhVWxpckxhWnZqeUdRaFJsNEJ2aDJjMFRISm44T2Y0Y1V0WnI0OE1T?=
 =?utf-8?B?ZmJRNHZGRGFNTFlXSkFkR1JZRVdWOU90UEdxMU1hck9JZVlleFNQdEl3VHFL?=
 =?utf-8?B?T3pvOVRYLytteFFuL0xTaENUNGMySUZJRWpwbU5jazBCR1hNdkFUVXI4QWRl?=
 =?utf-8?B?aWt6S3B3Q0t3ZWdZc1lhKzFSUTlBVDlYZUpjbVpqVGNiOGZUNUpQR1FZMlk3?=
 =?utf-8?B?dHBjeFdGdVlsZ2czeXliNUkvdzFucmFRZDZGb1luQ01yMUp0SHBGOTFlczV1?=
 =?utf-8?B?TCtLeGFFMmUvWE16YVcxVkoxMTY0N09YbzArb0VFYUFxTnJsdGx4VXZ2TnhX?=
 =?utf-8?B?cXZmUkU4ajVicCtRNW5hdGxhS2RXbEExeSswZ25ja094Qi9WNVZrNXlGYTdN?=
 =?utf-8?B?Y0owNDJaUUJtdUxFRjk5M1htNWFxSTdwU09KLytWbUZON3VMTWw3dDViSHo5?=
 =?utf-8?B?cnE0aDZEQmM3dmtFbDAvcnZRN0VKQkYzRDhtZWZjTWtxY1FwQVg5ZzNFVXpU?=
 =?utf-8?B?TUdrZVdqQVdVZnNDMVF2UVVwNVVsWStzNXo3TzltekRmYVRkM1pSMW5Wa1FL?=
 =?utf-8?B?WHRCZDZMN3JBMHc0U1ozMnkzUEZWMkV1NFhBbHlJSUdwMFBUL2FYbWxVYjQ0?=
 =?utf-8?B?RHdJYk1OZDIrWHNOWENmNUpxcVJ4akFpeEh4RC85OTMvSXR6MUY2NkxDS2x3?=
 =?utf-8?B?MEp5bC93UHl3Y0I5K3pYMDc4OXhGQTBROFdiejlUTkhNR0JLQXBjYXdxQnN1?=
 =?utf-8?B?NFVpdlVkb1RwV0hiU04vbk52Z1M4YW9UUDZ1bUhCK29tbFdhSW54dGl5MVgx?=
 =?utf-8?B?MExkUC8wVytQZFc1czJwUDFDa3lhTGNOaC93R0xMRG1Kb1pOem95aFZhc2ND?=
 =?utf-8?B?ZkpkZXpReUcyMmxwUnVRdTRhYi9rZEExcXZSWmtyYnl6aU95Y2ZnamNndXZC?=
 =?utf-8?B?R1BXendFVmp5Y3JBUUtiUVAwNEc0K3BKWEVkSUE5dDBvZ3kyUzJkQ1BUejEy?=
 =?utf-8?B?SElMcUFlU1NyYjBJYVVuOW1aWHBka1NWK2NBMHZiK0dvQUlDZ2dxdC9Vc3o0?=
 =?utf-8?Q?yoz4sLJcb4vDAtkNitqYYKCYL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb58cc61-e126-4645-4f33-08dc15d6e5c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 14:33:10.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TunJXrDxBqb3xVpGY6wgmjM6hzGoMic8kuUrCGGd5kmpHQnNfTNaUIqGO428e1E7lTVHtbttT8KIRvtEZhdofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973



On 1/12/2024 10:28 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jan 10, 2024 at 08:37:25AM +0530, Vidya Sagar wrote:
>> Add support for "preserve-boot-config" property that can be used to
>> selectively (i.e. per host bridge) instruct the kernel to preserve the
>> boot time configuration done by the platform firmware.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Addressed issues reported by kernel test robot <lkp@intel.com>
>>
>>   drivers/pci/controller/pci-host-common.c |  5 ++++-
>>   drivers/pci/of.c                         | 18 ++++++++++++++++++
>>   drivers/pci/probe.c                      |  2 +-
>>   include/linux/of_pci.h                   |  6 ++++++
>>   4 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>> index 6be3266cd7b5..d3475dc9ec44 100644
>> --- a/drivers/pci/controller/pci-host-common.c
>> +++ b/drivers/pci/controller/pci-host-common.c
>> @@ -68,13 +68,16 @@ int pci_host_common_probe(struct platform_device *pdev)
>>
>>        of_pci_check_probe_only();
>>
>> +     bridge->preserve_config =
>> +             of_pci_check_preserve_boot_config(dev->of_node);
> 
> Thanks for leveraging the existing "preserve_config" support for the
> ACPI _DSM.  Is pci_host_common_probe() the best place for this?  I
> think there are many DT platform drivers that do not use
> pci_host_common_probe(), so I wonder if there's a more generic place
> to put this.
My understanding is that pci_host_common_probe() is mainly used in
systems where the firmware would have taken care of all the platform
specific initialization and giving the ECAM and 'ranges' info through DT
for the Linux kernel to go ahead and perform the enumeration. This is
similar to ACPI way of handing over the system from firmware to the OS.

If PCIe controllers are getting initialized in the kernel itself, then
pci_host_probe() is called directly from the respective host controller
drivers which is the case with all the DesignWare based implementations
including Tegra194 and Tegra234. In those systems, since the controllers
themselves have come up and gotten initialized in the kernel, resource
assignment has to happen anyway.

> 
> I see Rob's concern about adding "preserve-boot-config" vs extending
> "linux,pci-probe-only" and I don't really have an opinion on that,
> although I do think the "pci-probe-only" name is not as descriptive as
> it could be.  I guess somebody will argue that "preserve_config" could
> be more descriptive, too :)
Honestly I would have liked to repurpose of_pci_check_probe_only() API
to look for "preserve-boot-config" in the respective PCIe controller's
DT node and not "linux,pci-probe-only" in the chosen entry, had it not
for the single usage of of_pci_check_probe_only() in arch/powerpc
/platforms/pseries/setup.c file.
Also FWIW, "linux,pci-probe-only" is not documented anywhere.

Since there is at least one user for of_pci_check_probe_only(), and
combining with the fact that the scope where "linux,pci-probe-only" and
"preserve-boot-config" are used (i.e. chosen entry Vs individual PCIe
controller node), I prefer to have it as a separate option.
Rob, please let me know if you have any strong objections to that?

> 
> Bjorn

