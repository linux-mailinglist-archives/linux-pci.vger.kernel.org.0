Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC4733CF2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 01:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjFPXem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 19:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFPXeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 19:34:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5093AA4;
        Fri, 16 Jun 2023 16:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG5e04RGViv786NvQgkv3flaMzwMsS6ArscIkg8mbZdqkgLVtBXewFGOQsu2LlmzW+9dpjtQ6B2cgriVxt7ewFExS3Dv8YVCeD81huH22P2uBKyiVBeuJyoe7oD36pliPA06RuagGoUNZACwMpJ2ZF4K49lOJukcxEHW+HiGTO92FK06A6MTEPdyAW+LuGnRLiNqwKVhsuCj/7/hy+xi8rzmduXNK/v33vNUlU2d1mYbqNv/VNZ2Ds1Do/CYjaVYvRXdQNf03a/2+gca1HswWkX62aQ2nK0r2F3oCHd+0/t7IXOFk3oBLaC94Ick/ksaUVgER6dIUk5z9Q8wQMRa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwsehjKgBn8EwaVslg7LCYMbkXi7VBekSL9rG/F2FMQ=;
 b=f/3JUrdDcfnoPUd+7kp/Qhxig+Jya6lvtp7aRbqu9td9+8EyBxUMLunNnUlrCFdXQxgZP4FIvxfCTqYvRNF0xLPN2vpHlB3pzPLgkhTe/gUtcFM0591bm93lM5wSWl29uDnCUpUSrZjzZf0niF7Li7LHbLVc3S6XCymwzOG4ZAUblzJ/rCPTkt5+GN6DQlFH7rl2s0K6Ioxlxgr0ohNExD8vo8xDK+SJvDX4aV7dhOksFMUQVFt7RPfstH5gxv6goEMOaeiSNoS+rxveQlx1bb66vQK7DNpPL4iHC0BWvjipELSOuScQYcgwa+Y1Nmtf9ttNv4M/9qTqoRL/M9e7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwsehjKgBn8EwaVslg7LCYMbkXi7VBekSL9rG/F2FMQ=;
 b=C/JDpBGbV0gEYNSZQUUR2Pz1+V5H03r2midkeconHkw9IDYJAOsBpROkHoq3i8vZC/GYBTleOwu17vr+7hLJbPRG2bu+IIvjJkPGxjWk2KpF9wLnf97sSgereGOBSlnZMFTv8mcKGMqKXglvg6FZzjlekOQWxEwxhcX1m1gFOAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 23:34:29 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 23:34:29 +0000
Message-ID: <d9cf3451-c0c1-ab86-0528-2c05982e7872@amd.com>
Date:   Fri, 16 Jun 2023 16:34:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Content-Language: en-US
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
 <cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com>
 <20230616182409.GA8894@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230616182409.GA8894@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 97148ce2-933e-46e8-363d-08db6ec23aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yw/QHJdlUzzjlU8JgUc3A3qAG4juWzRV66soQE4RFsqyjjEkp/kjR+gAEg4UYEJbncE4TT1Y6/Ve8G1nZ9vkmdDe4/l9CFkc+6liM4XhRpwehZqBoEAqU0Akc2d80R4AvmCqh8xTxMm1chn0ctXfTw0PepUJTcbix3fHj/O31vyTycx2aqiObnPXrF9ui2vibK93Mqj8zyEKEVJ1XRER9P7AK63BmxwG9wkn7lD8GFyrN9UBuSWwjsESTxhmrKLNSYj/CCFi/0Nbew52/bVdNE9XWQ2UWlTw9/1PIcM7IM3xCcl7F+WkltKhcJDRQ0+El71MorLlGA0LpvvCWkB6+pvyPH8AAE1PbIK9feVjtNFce3KxTCKZ8RiqRBI8WRcHhSgj/+LPcQalHI0/EAI9WTqgnS03jnpsu1/jTVFyorg51Lr1txtSu80klIfxEtNaE1BHifiGl1qi0peRcHAeZUYAXLyhEWnWjvyLKfirVgm4lJRZjh+RYqnvlOZftnTDGrg9G3Md0lYLzNgAcqfVZV2ryUMJcv/9TPJQysj08G+tIiQJKCIX9kAvoAKOcGWkqKdQh4MH0Ie2XbAioC9f8ZvvO6o8QkNlzgRqB+J5+zhS0NA0zq5q4a8JCHIyWoIzGArlzu6ZTUJ7RGPnXPsvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(5660300002)(31686004)(54906003)(2906002)(41300700001)(8936002)(8676002)(66899021)(66556008)(4326008)(6916009)(66946007)(66476007)(316002)(36756003)(478600001)(6486002)(38100700002)(53546011)(2616005)(86362001)(31696002)(6506007)(186003)(26005)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnBDdlhZR1IwMXdTUkY4cjdrblBDeXNaRjF5d1ZiZnRmT2duYjFWWlcrM25S?=
 =?utf-8?B?SSs0OU1aMEJMOGU4UjNUSEZCSEZBbTU4R1RBUkU2SjJ2K09mUjFGbURSUUt3?=
 =?utf-8?B?NWJDTWRNSE9hOE9CVWFKT3YwTTBObDdlUy9sR1R0UXE4WXlMU2tXaHZVV1lu?=
 =?utf-8?B?SmhMaVpGTytlVDhHNXpMVnAxbVVlZ3lnbjlPZGxIOUxvdWVQOHQrZkFaV1Mw?=
 =?utf-8?B?WDFCdVZEMmlsU2V5QXY5Q09qTTlMMDR2MTNReUtNWERSVFZ2bEpidXFiZzZz?=
 =?utf-8?B?b3djbTJVNGZtZlptS09qVzU0WEx3SlJMVjdKK1E5TWZtSmdQS09BRWFIRVVq?=
 =?utf-8?B?NUVIU05seitXcVN4NUZLTFIrVHpobHVrREsyc2U4M3pVS01oaGFSZjh6amxD?=
 =?utf-8?B?NzRmTWFwdWRabU92Z1lTUHFVM1orZUNsNSt1VWRrckFBVW44UE1vSWNOeFFk?=
 =?utf-8?B?b2hIQ0l1OW9vZXltTm5ORjVFR28xTmhMejdoRmZUOVljSVh1d1pmYkxIZkpU?=
 =?utf-8?B?TldQK2VYK0hVZGNYQmtqYnNNUnBibGR0YStianBNTVFnUWduNXB5MlpoTzlh?=
 =?utf-8?B?K0V0RTd5NElVNVp5SUF2Q3NqR0k2N2EvNnZmV1FMVTAvZzZCN09xZERXb1I1?=
 =?utf-8?B?Vmc0RXlTN0FYa1VpN0NzVC93L1BOZVFlOGZGL3RhZ2xtaFd5VjMyenJiSXNs?=
 =?utf-8?B?SGFwZndYc3JxM3pCcmlGSlY5anJQcDl3a1ZIUjNKeUlVY1haZ1REY09sb2R4?=
 =?utf-8?B?L1J0L3BzMHBiSG95VzNyZm9KeENGVGM1ZjhkLys5a1Z5RDFnOVdGT1RhNm5N?=
 =?utf-8?B?TzMwR1d0UTdNeEZldmhNUjFDSE9nVGRvOEpLZ1JNOHZ4NCs1RVdLeVFYYlhj?=
 =?utf-8?B?MHhLdFVpWk9VUTM2U1IraGp2ZVBxQytyZ0NLSXlJRDIwUzlFdzZYaVhhUGFl?=
 =?utf-8?B?NjNZQW9nWHk2TERXdDlpZjF0eUNnSW5ZUVFwWmtwSXF5b29EaUM4V1k3cWMz?=
 =?utf-8?B?U2R5Z3QzSzFlZ09uWWNsT2dZblNaUFNRYkc2OFAvTzJ0ZHR2ai8zakZ4cHVP?=
 =?utf-8?B?b0Zkbzl4ZGNOa3QxNi9wZ0VNYXI5ampZMnVJVThoL0VDVmRLRkdvNU9jakpX?=
 =?utf-8?B?YzN0K2RzSk0zbTRvQ0RZMEhxWmlQODFiejByT0VMTnE2dy9ybzRpcE15eHg4?=
 =?utf-8?B?WFhORWtpY3FJdGtCT29zYVdJbW9PazN6Wmg2Wk9YN041cGVZV0tmNnEyb1Jt?=
 =?utf-8?B?OWNtUi91MkppUlR1TTJ6RTRISGVqdkNFOVFuZlFDTlBNUld0cHJCaHlZUEFo?=
 =?utf-8?B?azNlZXA4VFVsTFZZNHo3bExySlh6SHR4eXdVdHZ1VEdxaE5YQlJ1T2tMaTNQ?=
 =?utf-8?B?TmFFODM0b29rUFhORGZndnRhMTA1bEpnY3oralNFN3RtM29xSHYrMHB2dlMr?=
 =?utf-8?B?M2tVVElzNEVqSDhZcHlPVDY2SUIxbjBFTlJlSVBCSDBxZTEvNUQzWEJYcnpK?=
 =?utf-8?B?SitVaFJWcVJYNFJmZjBreWlEWW9DamtTeURTK081M3NyY01OU2dHOHpEK2xu?=
 =?utf-8?B?TTNrM2JvRWovSjIvS2xvQTBYQllNOHdMODlzSnFDZmZlZjFLNUtET251dTVz?=
 =?utf-8?B?ZXBTZm1Wai9jZkVPcGdBcU8vM2ZlZk9ScHRUWVBRUjl1QWhiWllFSmdISUZ3?=
 =?utf-8?B?ZXI2c25oL2dtSFVFN1FOcWkwRkl1NDBPbFhENTZjSmV4TXA4azluT1V3UWp3?=
 =?utf-8?B?UjNVcmVYODBPSURrMURsdlBWVks1N0NPci8wYmFZamkxcXZuaHRZWUJMYXBy?=
 =?utf-8?B?SnBCeTR5RnQ0ZVp2V1RDUmtENDN2TVM1WFRidTJIVHdBMStscVdYNHhqV0hW?=
 =?utf-8?B?R0Q0NWcwT3lBdFM3Y21nZE9RUEtNMXBHcnJSUUtHOTN4VXAvVVFOeVUwUmtk?=
 =?utf-8?B?NnRlS1VSejdwSkE5bjZqYjFPR2t2bXBLTEVsVThRWWNNZjdQTVRuVDRPRVFr?=
 =?utf-8?B?c3hyc1RvU1B2V294a1g0RElDRnI3OGpGNFMzMkMzUldoQmxCOXhqQ1hISG9h?=
 =?utf-8?B?eXhUQ2tDSFZvWVBBelZtUFU4NjBtM0NIMXlBZWRXY08xSXZDOUgzNlpKVTgr?=
 =?utf-8?Q?JwE57hd3g7Mg1oM439eQ+XX5+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97148ce2-933e-46e8-363d-08db6ec23aa4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 23:34:29.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2Q08c0mzQQvL61o3rcsV5NYbGzka1/bvv4ac2YX4Fq48iNEFxAZy9/595auJYY3/h5ZCB4psoF8mYiUbbsT9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thanks for reviewing my patch

On 6/16/2023 11:24 AM, Lukas Wunner wrote:
> Hi Smita,
> 
> My apologies for the delay!
> 
> On Mon, May 22, 2023 at 03:23:31PM -0700, Smita Koralahalli wrote:
>> On 5/11/2023 4:19 AM, Lukas Wunner wrote:
>>> On Tue, Apr 18, 2023 at 09:05:26PM +0000, Smita Koralahalli wrote:
>>>> Clear all capabilities in Device Control 2 register as they are optional
>>>> and it is not determined whether the next device inserted will support
>>>> these capabilities. Moreover, Section 6.13 of the PCIe Base
>>>> Specification [1], recommends clearing the ARI Forwarding Enable bit on
>>>> a hot-plug event as its not guaranteed that the newly added component
>>>> is in fact an ARI device.
>>>
>>> Clearing ARI Forwarding Enable sounds reasonable, but I don't see
>>> why all the other bits in the Device Control 2 register need to be
>>> cleared.  If there isn't a reason to clear them, I'd be in favor of
>>> leaving them alone.
>>
>> I understand. The SPEC doesn't "clearly" state to clear the other bits
>> except ARI on a hot-plug event.
>>
>> But, we came across issues when a device with 10-bit tags was removed and
>> replaced with a device that didn't support 10-bit tags. The device became
>> inaccessible and the port was not able to be recovered without a system
>> reset. So, we thought it would be better to cherry pick all bits that were
>> negotiated between endpoint and root port and decided that we should clear
>> them all on removal. Hence, my first revision of this patch series had aimed
>> to clear only ARI, AtomicOp Requestor and 10 bit tags as these were the
>> negotiated settings between endpoint and root port. Ideally, these settings
>> should be re-negotiated and set up for optimal operation on a hot add.
> 
> Makes total sense.  I like the approach of clearing only these three
> bits, as you did in v1 of the patch.  I also appreciate the detailed
> explanation that you've provided.  Much of your e-mail can be copy-pasted
> to the commit message, in my opinion it's valuable information to any
> reviewer and future reader of the commit.
> 
> 
>> We had some internal discussions to understand if SPEC has it documented
>> somewhere. And we could see in Section 2.2.6.2, it implies that:
>> [i] If a Requester sends a 10-Bit Tag Request to a Completer that lacks
>> 10-Bit Completer capability, the returned Completion(s) will have Tags with
>> Tag[9:8] equal to 00b. Since the Requester is forbidden to generate these
>> Tag values for 10-Bit Tags, such Completions will be handled as Unexpected
>> Completions, which by default are Advisory Non-Fatal Errors. The Requester
>> must follow standard PCI Express error handling requirements.
>> [ii] In configurations where a Requester with 10-Bit Tag Requester
>> capability needs to target multiple Completers, one needs to ensure that the
>> Requester sends 10-Bit Tag Requests only to Completers that have 10-Bit Tag
>> Completer capability.
>>
>> Now, we might wonder, why clear them (especially 10-bit tags and AtomicOps)
>> if Linux hasn't enabled them at all as the "10-Bit Tag Requester Enable" bit
>> is not defined in Linux currently. But, these features might be enabled by
>> Platform FW for "performance reasons" if the endpoint supports and now it is
>> the responsibility of the operating system to disable it on a hot remove
>> event.
> 
> Again, makes total sense.
> 
> 
>> According to implementation notes in 2.2.6.2: "For platforms where the RC
>> supports 10-Bit Tag Completer capability, it is highly recommended for
>> platform firmware or operating software that configures PCIe hierarchies to
>> Set the 10-Bit Tag Requester Enable bit automatically in Endpoints with
>> 10-Bit Tag Requester capability. This enables the important class of 10-Bit
>> Tag capable adapters that send Memory Read Requests only to host memory." So
>> if the endpoint and root port both support 10-bit tags BIOS is enabling it
>> at boot time..
>>
>> I ran a quick check to see how DEV_CTL2 registers for root port look on a
>> 10-bit tag supported NVMe device.
>>
>> pci 0000:80:05.1: DEVCTL2 0x1726 (Bit 12: 10-bit tag is enabled..)
>> pci 0000:80:05.1: DEVCAP2 0x7f19ff
>>
>> So, it seems like BIOS has enabled 10-bit tags at boot time even though
>> Linux hasn't enabled it.
>>
>> Some couple of ways we think could be:
>> [1] Check if these bits are enabled by Platform at boot time, clear them
>> only it is set during hotplug flow.
>> [2] Clear them unconditionally as I did..
>> [3] Enable 10-bits tags in Linux when a device is probed just like how we do
>> for ARI..
>>
>> Similarly call pci_enable_atomic_ops_to_root() during a hot add..
> 
> Personally I'm fine with option [2].  If you or Bjorn prefer option [3],
> I'm fine with that as well.

Looking forward for Bjorn comments!

Thanks,
Smita
> 
> 
>>> As for clearing ARI Forwarding Enable, it seems commit b0cc6020e1cc
>>> ("PCI: Enable ARI if dev and upstream bridge support it; disable
>>> otherwise") already solved this problem.  Quoth its commit message:
> [...]
>>> My superficial understanding of that patch is that we do find function 0,
>>> while enumerating it we clear the ARI Forwarding Enable bit and thus the
>>> remaining functions become accessible and are subsequently enumerated.
>>>
>>> Are you seeing issues when removing an ARI-capable endpoint from a
>>> hotplug slot and replacing it with a non-ARI-capable device?
>>> If you do, the question is why the above-quoted commit doesn't avoid them.
>>
>> Yeah! Sorry I missed this. ARI is already checked and enabled during device
>> initialization.
> 
> It doesn't hurt to additionally clear on hot-removal.
> 
> Thanks,
> 
> Lukas

