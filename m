Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37588698BEB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 06:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBPF1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 00:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBPF1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 00:27:14 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3A3305C1;
        Wed, 15 Feb 2023 21:26:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN0hXGGKszY5OKUCyQTqRis84T+QGFkpozdY6AvTYi/1iol730S7JP/iu0C7q8mDGJDB6chsx8OT0q/F/QZ/Y9y6EUQ7db0ujE6xnT2pOz7HKot3qdzWqNdKuVF9eZWZU+ASefZSw4MkYU5gjwSMFdn4Lcng/fXxu9CuVvXRw5m1M6IRUpd2vU5JmOX81/vyXjT1bQU6BtCbbgnHk+yYibGvejGVQ9O1d5A4j4UHpGl314+lEibWNDZRcJxlFM3EdGn59x/CbLzntOIi9PlQb1dnlNZuNpBa+6uRqKtimbdfWCGlcRZSsFfIppD4CBnlh6YoQyZdKpndRRmUrEWtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHruO6wtBqMvfqMcRqY4gg41ZRetMZwkp7kQPpTYFDY=;
 b=OsxYX/fLDHGK0emt0ikbNaJRWARhKRw86QUhvFNX7om6t3kbdoadXYrbaBMxrIVaOaQDBon/kY7RSWojMHs00Wl4WoAXt9wcg0D8VAzw8JFvOWXvwHjSWp/8xO4KIabFFYuR0EqhCLY8rqyiuJA0E8jDTixmt/lzUWFJysYy780Ejo78A9RtBPhyd/PRCkroxuHEv1s6kVwnLrbXAWrQvOVl1njeaOmqqUDetlGdUrPiLcTjFl1oVyWrT6ViFjV/qvdEQNR2wNTq+ANL2T8UR2w1sB2KRWmrkAh0xwvlcTlNVYYTVYK0knNTI8gFSyTkUaA+GC//nS6LNip1q25j6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHruO6wtBqMvfqMcRqY4gg41ZRetMZwkp7kQPpTYFDY=;
 b=XFel0syknNoa/d6p0YE0Wqt6Hxrc+eqtHTQeL64TbpfaM+QcKKpAbCjIzC1L3QZ8hZBfOU0CpcfKkoCuT17/SdFBPUPpPdoKNIIqSphSgu1eRRZFvfDrHTuckBiZhUcyA4YjyQcY14RkHnRNK6+8zcKApz7Ta/B/SMlAXSS1G+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 05:25:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 05:25:49 +0000
Message-ID: <51861ff2-380f-640d-d5e8-7efe979a97ea@amd.com>
Date:   Thu, 16 Feb 2023 10:55:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 830a98db-aa6d-4333-6372-08db0fde4322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5fnxEH/9fIHsxgUb5nLM4rK+y2pLGmv1Ovw/PEK6Mgp4QYMQoROgceGnksysr27iQSwVQZyDE2QLAK0lsLXnQRk2445N743yDuFX+5bmHTnMva6S9EzGaMaziekGlDiA5iorbRXgfGGv7MFtLSnuLgwwlyGAdEUC/AqQl87ULdmdFLzX0q9EbPvP8yxKvJ9ncNDKzk0t5dEQeURxm8wp9KB6Hc82xkgDBJ1vbCKHHoMjMlFKi/zHZNDpgmuLzrkA6B4JYO+PB+bbu+8uQiH3rmpupTjWl6yG+0qMF3i238KIRJvmJkft4xJSvqdWUDZHGEAxFwjZwlAonvU6avCjriqu6vsDcsMVBxdXZK/QjEwYOU4cJ8Nkv+QQWykL6kKggRp2wkvyBVtNspUjAljfadyd9cG4VYFh+y1cMMJwwWrhY9pV4a2QezMHxDdteQEsUP/v98wbDhd7cMnu2XcYTJuElp9XC96hMj0iE6a/Gjt8bv5USeiK5ZDHkco7WY5ZFcdB4Q1RH6ZF+wRM1wH22KslfvxP9rE0T6+incdHZxXWPVMfa/OrAOJJbl+ZOzvhZSTHRBVgjvd39T74g4PyMR23+UozmcKxZ0rRlS3sXO9DhIh2uHuGkto1GkDZTjBRf15ulhmXR9ntpBFGfZoj7BvbNmd5Ot6/aOxfPaW3adD7y4RQAWD5eXrgjub4iiK6k9oZRoq0cchxBiioqOOk5RNk7bCQFXEvPbAXys22FDiTYMC66GpW3rA8u4QQsoWmgidj0rRHuGJMRO0v4B9Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(316002)(54906003)(2616005)(478600001)(6666004)(86362001)(110136005)(31696002)(31686004)(44832011)(6512007)(4326008)(41300700001)(66556008)(8936002)(5660300002)(6486002)(26005)(53546011)(6506007)(186003)(36756003)(966005)(66476007)(66946007)(38100700002)(7416002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VERVR3R5ZDl0TGVPYVJKZ1NscjZSdDBFNUloV29SRkxGLzFXdzZxMUxtbENY?=
 =?utf-8?B?S2plczJHeUc5ZEJyaWxNSTBFRzQ5bG1sc0RSL015ZGQ0SHIyRUwzVDM1RER6?=
 =?utf-8?B?aFpJMmpiakxmN25oM0UzVVQvaFRyY2V5ckwrTlhlWUlyakdEVUpwZEtqSzdD?=
 =?utf-8?B?c1lDZnpXY0JqT05VbVJXMGtKL0RSZDNFVWV2NVRxcjFzU3hMdDA4YThnaW1Z?=
 =?utf-8?B?MUQxaS9zNWJWZlYxS0xQM1JBM1dtelhNemR0ZnZvMVFSZy9OV2s2ZDVlRExR?=
 =?utf-8?B?QW8rL0cvTTdPeDZyWEVpOThYeXdYZjNSenNEd1RDemVrSW11Z1FzUzFVQW5L?=
 =?utf-8?B?S0J3bE1ld01wUkJsZUFUa29NeG41Qk15WGJDQUF1bE1RSVV0TE1WZnM0bGEw?=
 =?utf-8?B?cjRSaFRpUzk0R1MycUlSRG53QjdqeTlvQXZzWXR4WE4rdlYzMENKNU5TdUN6?=
 =?utf-8?B?UWZDM3hhWHpFVDdScFVlTGRoSnh2bFJpcWNWUUVJRUJLMjFVOUVOVGpTcUpQ?=
 =?utf-8?B?OVVUSjhyVXFEWUt1Y1F4dEJQYkVaWkdmb1JpZVphOFpNc09tNDlLYkRmQk5j?=
 =?utf-8?B?TXhwdzZSSEF0Q09LalNOY0s0TGFvZktSdDZ0dHJUbk10b2VlQnZaT0g5aWF6?=
 =?utf-8?B?N2V0bDJNSTJJcDZZMTdZRmgvL1BjYS9CdFFKQVladTFHRXRCZXB1MTlDdkJB?=
 =?utf-8?B?VVFzMnJFYnowbXFFanFqQjJDY1UyZHAySTRPTVNKWXhXemh6YU5PTXZiZSs2?=
 =?utf-8?B?NXhRTEFsamRYellpeTY4QXVwVXh5b1plQ0VLNUlKd1F6RTFCVFUxWnlaeWFQ?=
 =?utf-8?B?KzNLNjBZczRkZDNVNU9WTzF4aEI5aDhxelBLNGtuSzNmOUpOcnNXSkN6QVVC?=
 =?utf-8?B?S1gxU0lWcDFSNUx4QXRHV1hpVGQ5UWI1c1RRSklXazYwYnM2NlBLeTREVXR6?=
 =?utf-8?B?NDltTHRBdTVJUGFmTzl4dzd0eHUvNVF1YUdZNGwvQ0U0VVF3MHd4WXVuU2JD?=
 =?utf-8?B?RXg1d3RBNnVMbTJ2cXMwS205RndKZ2dnT3AvNkRaNkpOOVVDY1p6WXcvejll?=
 =?utf-8?B?bFZIMXVZVVhGY085KzcrU2RMcWoxNWxCU0xSNzJDNXhaQ1VZSVI5ZlUwVmdB?=
 =?utf-8?B?MVBRbkE3Vm91Uzcvck4yYjZMSVRKaHlOQ1BqVXhPMHc5QTk2YU5RUktsWHEx?=
 =?utf-8?B?L2lHdzNCQ1E5YnNVRjhZSVhsSkZJT0o4am51VzFUdnNidjZpM2JVblBOY2wy?=
 =?utf-8?B?M0lzb25qbzRhQnRNMnJOSjZMUEhBbVA2R3JPNmY5SmE0eHE2WVVIRkVNT3ZJ?=
 =?utf-8?B?K3dNR2tabzJiblpzTzBoWUdKUTV2TTlpZnA4dXlRSVhPZzEyR1lrTnRHMzF0?=
 =?utf-8?B?TTNpS3RNU1pRdXFOaFNOd1QyMXc4SVY4U1VxZ3V0dXlrZHc5dFRnWXhEUDU3?=
 =?utf-8?B?Y3lSMnlqU0JLVWtEWTFuK1ZzU0tISS9KbCszN2MxWlJ6d3BUL2ZITXhXZU9t?=
 =?utf-8?B?eGp5SW84dERvdUdjMzd3UjR3NTU1cWcxTXhEaTV3MWxMZXRXY056L25VaDNa?=
 =?utf-8?B?dFJIZkMwci9DZW1WTllQcmswZ2pSZEN4WHFIOGJqQTZpNzlibWRHVUJjTGRx?=
 =?utf-8?B?TWdFUnJJODdxVmZzbTRqUFd0VUIxeGF1OWdieHVDek5OV2FoYlJkcVhPQ1lj?=
 =?utf-8?B?RlhlN0hXV1hUa0JLTVhvZ2ZHTWlCQUNTTFd2bzZidGhMcm9oVGFqZjZIUnlw?=
 =?utf-8?B?TkdDNC9TaXdURjdWNFlsUnp4MGRNSjlnMU5lZmx4dHNEWEJhcm1FQ2tnK1Vs?=
 =?utf-8?B?bHJ6RUo4Mm9DSHFDbHNyeHhFeG9OQkhzVHRCOGZxT3AzV1htNU5oREh5NjdL?=
 =?utf-8?B?am1oVVMzbVhZWGd1a1RlaW1sUHdIREt4ZGxYbHB0YzZLOTZPMkVNdUpZWGRE?=
 =?utf-8?B?Zzk0WVAzbnFscnE0emZjWUw1UnB2K0RWU1ZYSmw1L3RmbEhwVkV1Y2J0QXVP?=
 =?utf-8?B?VTBhQm5Gd09KandSVjNkOWxqYk5jUGIvelBrNy8weWV1YTdWOE9JemUyMytp?=
 =?utf-8?B?WXk3WVVuQmVXejEwZk02Z1lBa0dWaWZON0NBVy9idVkzNXNEcGRnSStIOC9M?=
 =?utf-8?Q?xHVTL09sH1an/Rqpso/uwVgM1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830a98db-aa6d-4333-6372-08db0fde4322
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 05:25:49.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QJol1oTOrCIRjOdkxbbkE5jhKzPimfTzUxuLwnjH0TrqaN7cOleHhz8zAohGpu62iwJ4PoZVYdYAwy45RuGsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Felix, Jason, Matt,


On 2/16/2023 6:05 AM, Felix Kuehling wrote:
> [+Shimmer, Aaron]
> 
> Am 2023-02-15 um 10:39 schrieb Bjorn Helgaas:
>> [+cc Christian, Xinhui, amd-gfx]
>>
>> On Fri, Jan 06, 2023 at 01:48:11PM +0800, Baolu Lu wrote:
>>> On 1/5/23 11:27 PM, Felix Kuehling wrote:
>>>> Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
>>>>>> -----Original Message-----
>>>>>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>>>>>> On 1/5/2023 4:07 PM, Baolu Lu wrote:
>>>>>>> On 2023/1/5 18:27, Vasant Hegde wrote:
>>>>>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>>>>>> I built 6.2-rc2 with the patch applied. The same black
>>>>>>>>> screen problem happened with 6.2-rc2 with the patch. I
>>>>>>>>> tried to use early kdump with 6.2-rc2 with the patch
>>>>>>>>> twice by panicking the kernel with sysrq+alt+c after the
>>>>>>>>> black screen happened. The system rebooted after about
>>>>>>>>> 10-20 seconds both times, but no kdump and dmesg files
>>>>>>>>> were saved in /var/crash. I'm attaching the lspci -vvv
>>>>>>>>> output as requested. ...
>>>>>>>> Looking into lspci output, it doesn't list ACS feature
>>>>>>>> for Graphics card. So with your fix it didn't enable PASID
>>>>>>>> and hence it failed to boot. ...
>>>>>>> So do you mind telling why does the PASID need to be enabled
>>>>>>> for the graphic device? Or in another word, what does the
>>>>>>> graphic driver use the PASID for? ...
>>>>> The GPU driver uses the pasid for shared virtual memory between
>>>>> the CPU and GPU.  I.e., so that the user apps can use the same
>>>>> virtual address space on the GPU and the CPU.  It also uses
>>>>> pasid to take advantage of recoverable device page faults using
>>>>> PRS. ...
>>>> Agreed. This applies to GPU computing on some older AMD APUs that
>>>> take advantage of memory coherence and IOMMUv2 address translation
>>>> to create a shared virtual address space between the CPU and GPU.
>>>> In this case it seems to be a Carrizo APU. It is also true for
>>>> Raven APUs. ...
>>> Thanks for the explanation.
>>>
>>> This is actually the problem that commit 201007ef707a was trying to
>>> fix.  The PCIe fabric routes Memory Requests based on the TLP
>>> address, ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with
>>> PASID that should go upstream to the IOMMU may instead be routed as
>>> a P2P Request if its address falls in a bridge window.
>>>
>>> In SVA case, the IOMMU shares the address space of a user
>>> application.  The user application side has no knowledge about the
>>> PCI bridge window.  It is entirely possible that the device is
>>> programed with a P2P address and results in a disaster.
>> Is this stalled?  We explored the idea of changing the PCI core so
>> that for devices that use ATS/PRI, we could enable PASID without
>> checking for ACS [1], but IIUC we ultimately concluded that it was
>> based on a misunderstanding of how ATS Translation Requests are routed
>> and that an AMD driver change would be required [2].
>>
>> So it seems like we still have this regression, and we're running out
>> of time before v6.2.
>>
>> [1] https://lore.kernel.org/all/20230114073420.759989-1-baolu.lu@linux.intel.com/
>> [2] https://lore.kernel.org/all/Y91X9MeCOsa67CC6@nvidia.com/
> 
> If I understand this correctly, the HW or the BIOS is doing something wrong
> about reporting ACS. I don't know what the GPU driver can do other than add some
> quirk to stop using AMD IOMMUv2 on this HW/BIOS.
> 
> It looks like the problem is triggered when the driver calls
> amd_iommu_init_device. That's when the first WARNs happen, soon followed by a
> kernel oops in report_iommu_fault. The driver doesn't know anything is wrong
> because amd_iommu_init_device seems to return "success". And the oops is not in
> the GPU driver either.

WARN is fixed and its in Joerg's tree.
https://lore.kernel.org/all/20230111121503.5931-1-vasant.hegde@amd.com/

report_iommu_fault() happened because in amd_iommu_init_device() path it failed
to attach devices to new domain and returned error. But it didn't put devices
back to old domain properly. It left in incosistent state and resulted in IO
page fault. I have proposed series to handle device to domain attachment failure
and better handling of subsequent report_iommu_fault().
https://lore.kernel.org/linux-iommu/20230215052642.6016-1-vasant.hegde@amd.com/


@Matt,
  Can you please help to verify above patches on your system where you hit the
issue originally?
  (Grab above two series, apply it on top of latest kernel and test it)

-Vasant

