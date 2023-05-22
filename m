Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D314170CDCB
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 00:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjEVWXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjEVWXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 18:23:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34C11A;
        Mon, 22 May 2023 15:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzx9f0PfBViXFp0O2v33ScS1IEN0cAvuFs4BYX00boO4x4/6uJU0IFENY0v5j3oATf1s5enfv4PNy85u8pH47EITGMF+nUQMkU88viU4FZwTemq+zrPGu/1ZugdnfLbc3/DYJGYrHoOMHs+8nOu4CeUnXo40pxyzLYTzs9B9TitZX7xVC7+TzIgC8uaRC2S5gQxhwn0kcy0PEsT0oKxESIeHkZnZUE1lqQHkcjk6F1UEF6wsE12aIO/BwmRmGwkQk2VKxPUxhguvpDOdHJGcIMOruTL9Oa+HslKZc7ygu2RKCb2Mzl3Qsfx63xmF7WVZUUw6wMc4SVkFIjnOF3BovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H64Rr4nF88UNFCQv7sMOFerqbBG64xmnYCH5Z4nbdSM=;
 b=bbmXQ43nzQVBO5NVS0dkU1tTHjZUd6Bzkj9uB382Na8i2VtuN4eti5ldQKMC+5anTn9tM2YH3IJS1t77CCVMWGRY4XxNlD+95/g1hBhkRSWofMGjMqeGgdSfCDZCAV1KtbImvbaYhgI4uW1mmhU2nfdrwKr5ZBq7RRArurMbHRG+h//z2rV8pY0uNEEw79VBi+JIuA2Fcj3U0YazB3okqxSf3yLwB+3/0O3s92WQ585JkeM1RswB6dI86umMqUar3K5RbTS//UlKiAC07Pb/hvmyTmu9pa0dtTKSPL9q1Sjk8GlmbJt9K7Zd7GsJCzoPMk8O728mw67slmTJdrkCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H64Rr4nF88UNFCQv7sMOFerqbBG64xmnYCH5Z4nbdSM=;
 b=Q+dnAkezgpRCNJCEekVcpUI05PZ8eFL9OVRxs+tOoqBB0RulVUnVq52pVKG976RXXjpYIW+nINAegnAK+3RS8axQQgNb5AuTRf6BOczv/YHhxg24futcqwC3gPp0vmhjML6HLjxZa/Qyn8HG2lqlJENMgC3OdXpqY4Xo9YcMFNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:23:35 +0000
Received: from DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::b5cb:8d62:c2c7:c4ad]) by DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::b5cb:8d62:c2c7:c4ad%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:23:35 +0000
Message-ID: <cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com>
Date:   Mon, 22 May 2023 15:23:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230511111902.GA10720@wunner.de>
Content-Language: en-US
In-Reply-To: <20230511111902.GA10720@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25)
 To DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2876:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 384b3c2c-bf64-45f9-9959-08db5b132e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ozCIwrj1gx2L0e9VJp3AEpvZTnNs+BvyLbPk7gVxE2+yKT4cP+lJwX0Trymznfjvc98ty4sUxSFsEuUT8YNqCG7OTPpgDZuqfE52h7+YmmWcyNR5FwBlccnl/Bt5DMG2cbyooa8H5n5SkpfgHp4xhEREH+WReQqXAbDcL1u7SGfOWyz+Q9f2kLsW/upYmbtTx2PZEWhXy+SDk9/GKcXn7ONKnfXbvm3IhbP6asZCsnLu5RkzGAOr8J4IJE6TluVQZBGJzsFkl1Sc82/1hSFRFP1Ycm7yqhd6wsGj0PEiyP92rk8ob9/ojiI/0/LP4rr+YRleuLTVU5NoO0hnkYbQYFbLMGjuZplaDWErwboafNFU/ofYYWrWE96MPCj1dA9M1ITIyZK2awXYoX7Gtfaz4wT6c8vWE+oI6YgTadmXOP02YtVG4KiRyrkTZfDpUe6lZ+nxKJfspCjEMR5brSpyjmcKeOwSM7/25/DT5W5uJqy3iywkMUpQ7AlYg5nobjgtNo7PZTz66bjGA3HW2fIchN6wN62RXiIWxZli9Sk18qsyyxRWeUBGksO9dVz/bC/43foXGKoRcBR1cAhrNtnL0bspmblojCSNkvWNV7pHPc2W/wEbo27OYvO3RtpHAkHla9EM9WBL0RWJE1HRG2ALA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(8936002)(8676002)(5660300002)(83380400001)(186003)(6506007)(6512007)(53546011)(31696002)(86362001)(2616005)(26005)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZaN3pmYjQrMDg0cGJianFiSExCdlRJV3IwekI0SGZTcmRvQUJRbXlRcmsy?=
 =?utf-8?B?NDFiQndjTm1YL1BvbFVLK3Ezc3phZHR1REtrQzFIUjBqOTZ6eXFtd0krcG82?=
 =?utf-8?B?THJiTkNSRUFLdzVNZmkzRERGeWRydGpFaDhMc2NXT284ZTRrWDEvTlhmZTVN?=
 =?utf-8?B?d1lKd3FES1pXa1BlcDU4K0FDcXFkamlBZE4wYmE3alAxaHlFYW9IU3VlNmNS?=
 =?utf-8?B?Z3czdHZ0aG9nSjI5STN0NEVBekRzNkIxTHNFdHViV2k0dWFoUnU1RGMzalZq?=
 =?utf-8?B?cUFhZmhGMnpJNHJmR1BZNVE2TmVuWFc4akk1Y1pXclpjL0xBaW5tSDNkQVBX?=
 =?utf-8?B?ell6bS9XUE14NkRGT3diZmVlSXJ5OTh5VkFmbTZkb2lPRms2czlFVDhFUmsw?=
 =?utf-8?B?UWJaYUJoYkpZck1CODV4QzBzVTVxN29INmN4TG53YkZETGxoelhYZm9DTG9D?=
 =?utf-8?B?SzRDbUgzRTdlVlA1M2ZOOTRNUGNwdDlYd1M5eUl5dzJDN0ZqTXRFeENIVzRu?=
 =?utf-8?B?aEVpbmpJMEV2TU5CQmZqYUIvMmxWT3BFM05PaUZpYU9YTnZqNXRqcTNkaUZ1?=
 =?utf-8?B?VHJGeWRoc3VodlkwMTNIbzNrd0dJSnpnbVVWWExranh0d2NXajlCMHI2UTRx?=
 =?utf-8?B?SWdZbjlLZHB2QlAzZnM0c1ZRQlh6bERYdU5HVW5LMzlCQUNBSElWc3BmUnlV?=
 =?utf-8?B?dGUzL2VLclAyVDg5NHdXeFhhM09XK0VLbEtaY01Yc3FOVTVTNXpIVWFCQUZN?=
 =?utf-8?B?SGlLVWJoZzBYRFlER2Y0UFhCTWpBMXdXMEV3L0M4OEEyWFlsY1hKV0xNWmVM?=
 =?utf-8?B?aytKbi9Zc3Z0RVBwTE11WmMvdVkwNk4velE1WE1IajBZY1EzRmFZSGRheWUv?=
 =?utf-8?B?dVFWeGp6WjZUb1RSdjRKY1BaRWZRQlZvTXpCQWlOV09BS1lRdXBJY0lORXVL?=
 =?utf-8?B?ZW16eUhWODQzcDRMTVhPOWpSeSt0S2I3bTd1NGh4aklJQ1c1TFU3OUVQZXV3?=
 =?utf-8?B?MDREYndvSFNZYlptQ050VXA0SUdzZThDczNHbGl2VGdsZW5oY00raGtlZ1Qx?=
 =?utf-8?B?NkVueHJPYjJQVldnY2xjZ0xUSWxjcUZCbEdtK2EwTVJ0MkZJWm5YVmgxSGNQ?=
 =?utf-8?B?QzdrN0VWY09GZkJxTnFBOHRoWGFFdkpic0VxOU1EQ2c0ZWp2b1pVY09kSjdv?=
 =?utf-8?B?eWNsd0JDUjVucG5tUHRrSGdHclVyQ1UvVHhBTHJVUXJBY2FwR0tiZi9NczlC?=
 =?utf-8?B?QzFpTlZjdk1JeTFtQzdGQjhqa1JMYzVvNDVnRWlZRmU1RzAzQ08zVjZaNXBi?=
 =?utf-8?B?MXlQMkc4WUltTHR2SlBmZnhFTFh4U0JtbnFzbE9BUHlYQkQyWVhlSGl0WUdV?=
 =?utf-8?B?OWFPYTFOS3N1QWdlSGpjRExJRElSbVpBTnY0QVVacG9vSTM3WnNXZDhvVlZT?=
 =?utf-8?B?L0JWMm8vcUNIWjUzaVpydlV6N01EdVpCWEdjaU5kYkZ2YjdBdWoyUGVBVnov?=
 =?utf-8?B?S3BZWk9uaGZUaGlFMFBWWGV1aHgwYjFPVzdVdFVjMTF1TlRtUzdXSE14cDJP?=
 =?utf-8?B?dDNVTXphRmQ4d3M5SWNoVHRTZndHV1hHZHlSVU5yQU9HK2JKaWtXM3dFOVgr?=
 =?utf-8?B?dXpYSzhMeWRYRlVSY2lydXRWSlFNekZab2I2VkYveVpzdWdFRDloa05oR1pZ?=
 =?utf-8?B?bGtXMGFuaUp4dUhRRFpKZXJTRERFM0J6dm1kN0pFV1krYXR2SzR0aU12QlAw?=
 =?utf-8?B?TTkydzRuT2ZIaFo2d3B3N25DTGV6S0U5b3lHbXJUTHN6eXEyN0M5MTl3Y0Uw?=
 =?utf-8?B?cCtjV3hTSlFZZS81LzZLd2ZEMi9YM1pSY0tLTDcrOVNMc3BuQ01FYW56STBu?=
 =?utf-8?B?U0xrMmhQM0ZOemtST3NGbGZ5eFo1dmxlWkdMbGo5eXkzUWgzd25tZmF6OVcw?=
 =?utf-8?B?b25zOXFQQW1aZXZnQnJnb05PTzVBMDk5QnRML2c0dFVud25WWGNTWGtRNmkw?=
 =?utf-8?B?T1BYdTNZanpNNFBjM3M4TGFIdjJxK09vVGh1dGJXM0dCSEVZcmNiSEhWMVBY?=
 =?utf-8?B?cVhlbkg3Qk9zbjF1VWp6UHBPanRrbnNBY05Qd0IvVSt6aFZhaGtjdkFrZUZh?=
 =?utf-8?Q?p+jLxnSiI++CTUpfa/VxRIS5y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384b3c2c-bf64-45f9-9959-08db5b132e8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:23:35.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2X36a5cZml6BCmUBZAUOinLBOEDcj/I11b9PenfmPfTR2/4/Bn16ieGSvmbXHhmDcmljHU5w06qkjntgxS3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Sorry for the delay in replying to this patch. We had some internal 
discussions after the review comments. Please find the responses inline..

On 5/11/2023 4:19 AM, Lukas Wunner wrote:
> On Tue, Apr 18, 2023 at 09:05:26PM +0000, Smita Koralahalli wrote:
>> Clear all capabilities in Device Control 2 register as they are optional
>> and it is not determined whether the next device inserted will support
>> these capabilities. Moreover, Section 6.13 of the PCIe Base
>> Specification [1], recommends clearing the ARI Forwarding Enable bit on
>> a hot-plug event as its not guaranteed that the newly added component
>> is in fact an ARI device.
> 
> Clearing ARI Forwarding Enable sounds reasonable, but I don't see
> why all the other bits in the Device Control 2 register need to be
> cleared.  If there isn't a reason to clear them, I'd be in favor of
> leaving them alone.

I understand. The SPEC doesn't "clearly" state to clear the other bits 
except ARI on a hot-plug event.

But, we came across issues when a device with 10-bit tags was removed 
and replaced with a device that didn't support 10-bit tags. The device 
became inaccessible and the port was not able to be recovered without a 
system reset. So, we thought it would be better to cherry pick all bits 
that were negotiated between endpoint and root port and decided that we 
should clear them all on removal. Hence, my first revision of this patch 
series had aimed to clear only ARI, AtomicOp Requestor and 10 bit tags 
as these were the negotiated settings between endpoint and root port. 
Ideally, these settings should be re-negotiated and set up for optimal 
operation on a hot add.

We had some internal discussions to understand if SPEC has it documented 
somewhere. And we could see in Section 2.2.6.2, it implies that:
[i] If a Requester sends a 10-Bit Tag Request to a Completer that lacks 
10-Bit Completer capability, the returned Completion(s) will have Tags 
with Tag[9:8] equal to 00b. Since the Requester is forbidden to generate 
these Tag values for 10-Bit Tags, such Completions will be handled as 
Unexpected Completions, which by default are Advisory Non-Fatal Errors. 
The Requester must follow standard PCI Express error handling requirements.
[ii] In configurations where a Requester with 10-Bit Tag Requester 
capability needs to target multiple Completers, one needs to ensure that 
the Requester sends 10-Bit Tag Requests only to Completers that have 
10-Bit Tag Completer capability.

Now, we might wonder, why clear them (especially 10-bit tags and 
AtomicOps) if Linux hasn't enabled them at all as the "10-Bit Tag 
Requester Enable" bit is not defined in Linux currently. But, these 
features might be enabled by Platform FW for "performance reasons" if 
the endpoint supports and now it is the responsibility of the operating 
system to disable it on a hot remove event.

According to implementation notes in 2.2.6.2: "For platforms where the 
RC supports 10-Bit Tag Completer capability, it is highly recommended 
for platform firmware or operating software that configures PCIe 
hierarchies to Set the 10-Bit Tag Requester Enable bit automatically in 
Endpoints with 10-Bit Tag Requester capability. This enables the 
important class of 10-Bit Tag capable adapters that send Memory Read 
Requests only to host memory." So if the endpoint and root port both 
support 10-bit tags BIOS is enabling it at boot time..

I ran a quick check to see how DEV_CTL2 registers for root port look on 
a 10-bit tag supported NVMe device.

pci 0000:80:05.1: DEVCTL2 0x1726 (Bit 12: 10-bit tag is enabled..)
pci 0000:80:05.1: DEVCAP2 0x7f19ff

So, it seems like BIOS has enabled 10-bit tags at boot time even though 
Linux hasn't enabled it.

Some couple of ways we think could be:
[1] Check if these bits are enabled by Platform at boot time, clear them 
only it is set during hotplug flow.
[2] Clear them unconditionally as I did..
[3] Enable 10-bits tags in Linux when a device is probed just like how 
we do for ARI..

Similarly call pci_enable_atomic_ops_to_root() during a hot add..

Let me know what you think..

> 
> As for clearing ARI Forwarding Enable, it seems commit b0cc6020e1cc
> ("PCI: Enable ARI if dev and upstream bridge support it; disable
> otherwise") already solved this problem.  Quoth its commit message:
> 
>     "Currently, we enable ARI in a device's upstream bridge if the bridge and
>      the device support it.  But we never disable ARI, even if the device is
>      removed and replaced with a device that doesn't support ARI.
>      
>      This means that if we hot-remove an ARI device and replace it with a
>      non-ARI multi-function device, we find only function 0 of the new device
>      because the upstream bridge still has ARI enabled, and next_ari_fn()
>      only returns function 0 for the new non-ARI device.
>      
>      This patch disables ARI in the upstream bridge if the device doesn't
>      support ARI.  See the PCIe spec, r3.0, sec 6.13."
> 
> My superficial understanding of that patch is that we do find function 0,
> while enumerating it we clear the ARI Forwarding Enable bit and thus the
> remaining functions become accessible and are subsequently enumerated.
> 
> Are you seeing issues when removing an ARI-capable endpoint from a
> hotplug slot and replacing it with a non-ARI-capable device?
> If you do, the question is why the above-quoted commit doesn't avoid them.

Yeah! Sorry I missed this. ARI is already checked and enabled during 
device initialization.

> 
> 
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -104,6 +104,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>>   					 bus_list) {
>>   		pci_dev_get(dev);
>> +		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, 0xffff);
>>   		pci_stop_and_remove_bus_device(dev);
>>   		/*
>>   		 * Ensure that no new Requests will be generated from
> 
> This clears the Device Control 2 register on the hotplugged device,
> but to clear ARI Forwarding Enable, you'd have to clear the register
> of the hotplug port, i.e. the *parent* of the hotplugged device.

I agree!

Thanks,
Smita
> 
> Also, this patch doesn't apply cleanly to v6.4-rc1 because of a context
> change by f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock between
> reset_lock and device_lock").
> 
> Thanks,
> 
> Lukas

