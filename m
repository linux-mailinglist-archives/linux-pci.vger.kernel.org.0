Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644037077C1
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 04:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjERCBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 22:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERCA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 22:00:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA4BA;
        Wed, 17 May 2023 19:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOGcjKSWkonBD8VEkDaCGYLsILqLZgpnk1xjrVpHIPp3/aiOw70W1g3NiMN9uMM2RV1ZqPEuFhC1cHjx8gmkgI5kTTR2xsifjYxBlb1U9trs1/0xN+m6zRSpElUHPWCWW/aysJ+FajK4thbXQVWzQ/dnXJZb2nij/WNHyjjTXmjhFOzpNJAvTD5rbmhcuka915XgJcuGW5cgR/SUvI5gnUxwy1f+z0Tza8MVV+i1yV4KJznLUOtoefiKkDbCM/CYw5xdkXHK4ZI6EVyBtljp+LEVkHzUgLZOAnYLMokkqwCDwCpKklxGCBl3k8zPkGo5Nd4xlvaM6N8LE5CvwiHufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SWmavxlikMzoHP9Rz+p4tww/RYCAjOQji4/Mw9khQM=;
 b=hUn1eUYC7rJrLXObtboHcHZ7603MsQVc480GnILDU/upwi5o9DSksvPfeZcKRk8A2xPZF+gB9qSWc/XBKmtq0Mc4pZsn1AMc7Dw/rTO7UErB5PKY+fLx0RuEuv4iNmiQFOKNCponKrK/1ygrnjJpUNXljONDAibMMJ1k5/R7BUjRt2ScknYkxVCHrBB7YZfyLXrQ0V8ewZvsKSCUKUAM2scAMEHSOTxMj6IQ55yqXb5CCPOEWdfXq3Tj0F+Gvb1nW0rGSK0jqQp/oFXqRIABQASIEHYTangyrpf0aiK5kbbhP79MLNoguVxN6Q5DB5UMNRzhLT5QUqw9kZQL5gkq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SWmavxlikMzoHP9Rz+p4tww/RYCAjOQji4/Mw9khQM=;
 b=qbIFHJUfCj+ekkptkYhp+qeP5RsXizNePaKrQ8+LfcJqkClngyhcLr4tTMWDFZs9dxoOHFWQUtjx3QgBVa051iTH3/3Oj2hRRwHZJ3m08C9WlhlEEWu+nru02eDg/vhaPaFeoK/4H9Sy7NR/jJ9ZAaooHKn00JpX31QniAV1ec0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 02:00:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 02:00:54 +0000
Message-ID: <5b1a8e39-1e59-211b-47eb-20ef21cff84c@amd.com>
Date:   Wed, 17 May 2023 21:00:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
 <20230516055918.GS66750@black.fi.intel.com>
 <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
 <20230517071527.GU66750@black.fi.intel.com>
 <8e7e23dc-f01b-6f78-f383-7706795e386e@amd.com>
 <20230517125811.GG45886@black.fi.intel.com>
 <a71a662d-27a6-5c74-a44a-9538ed503a05@amd.com>
In-Reply-To: <a71a662d-27a6-5c74-a44a-9538ed503a05@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0141.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4a49af-9d21-450d-7c5e-08db5743b6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IsRnYv6uNDtQ9Abyv4GJZHnE2xJbMoFhZMabIgfIBOrF6HM6SyPn5VDE6IvefcAcBpxEtVIiJHQ9WJ/J34wy+KxWlVZu7PKOtYfb6tr4yCwoHa+T6lsH63eMud7hfkief6nEBJHOworqdEnBYq+iosDVhycRSP5UpnYDB3xEtBt5MkZQchTwXgXOEWS/EKt4iKIagCgc8s72SJ/hD4nj3SJqnBnuLJJid+cUsfswUrKE4qgpnptFBg8b9BGbJ2DLof34c25JRx43pD3Rdda2ARb9eH/pRgv1AfMKEWqtzfN9b0Aol8tALX8lG5VkI1WjocXPGI5SpvxTLnOsrbroybYXDv61DXjk6fl3HoOpUaCWlAvO1Wslc1uDH0EARp22pi0T12LBNL1hNIG920xDsPVaRdAPZUe75vPgy8kthbSo7DcRbxPnhOiljil6iBfU5SFxiuC6j3jpwjq5fy7qclDLOU/Beuq7/954K2b6tyrIYaKGlRMlUAMF/oc/GHeKWF7w0glwEoLmaQwqzLMdpGNN0/6vcCWvA+cIdQVu68xjSdB8ko015uTjGid8PT3Jes0iOrJzX5YxlIBoLqsI0ka0vMKjSCiLqlN7LF1uwO2HQPGHv2IBCB7SOANVS4HmkYyo4Sh+Tv2d7HHYbODlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(31686004)(316002)(66556008)(4326008)(66476007)(6916009)(66946007)(478600001)(54906003)(36756003)(86362001)(31696002)(83380400001)(6506007)(6512007)(186003)(2616005)(53546011)(26005)(5660300002)(8936002)(2906002)(8676002)(6666004)(6486002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdkVGVIeWtLeDA0R0JkMmJzZ1dqc05ndEZib0RhOGozRWFyOTJlM3kzZCt4?=
 =?utf-8?B?ajdhYnRFWXFGS0hyYmdEanBwOUVYRlNJcUZFaG9XQ3hDbjMydERmWlBVSlBX?=
 =?utf-8?B?MlFBUUE0VE04eDR3YUsySmxPNnA5d29SZGRxa2dBR2N5MGlKMlFSVlBuVEhL?=
 =?utf-8?B?Nnp3dDNMZTc0WnV6emp2RkxhTTVNcTNPU1d2bGlvY1pubmNDdXh4ZWVUa1Av?=
 =?utf-8?B?S3lvQkVKV3UvaHRrQnFnM2JLN3RTRS96YURha1ZDSXRuRXRmTUQvRHdEbk5k?=
 =?utf-8?B?T1h5SXFWUkN0RG1yNm40NlorNFExeWZSb2tLS3hpUVZTcjN2UkU1RVFKemtp?=
 =?utf-8?B?UDlFRTJmWm9sUisraUtpQ1BKbSt6TmhnaERialM4a1JjWE1oV1ZMUVVBTEdp?=
 =?utf-8?B?YnlXQkNxdFNEWlh6YTFXaUM1T0xUU291c0dYSzdRMld6M3VvNGxTZmI3RCtp?=
 =?utf-8?B?bXJ1UXdnSExMMThnVmc4elNnazFtTzBqd3FnOUtaeFpTUFhuOE9vQWtkZi8r?=
 =?utf-8?B?Z09RWFljL2pQMHlCMVB6dGp3K3k4SkV2MG5UZ21rNld0dVVSdWlvNzhmMEd1?=
 =?utf-8?B?L1czeUxsSWlBQzdlYWV4b2xhQnk1M3JDQ0Y1WUhLVm9XRFV0Tm9hbE8vNUpT?=
 =?utf-8?B?RDU0SjlQTDNqdTA1WHhOTWltMldod0dPWC9NYkpMT21kNHp5VU5oTXRCY2Jp?=
 =?utf-8?B?aytMQjNyWG1rcUVTZUZsSGVTbDJpUjJqb09mY2dFV01NaHl4TmJCaWlGT09U?=
 =?utf-8?B?VldjdElNTDNBc1ZGR2tRQ3VTdnd4aFhkcE5LVDFtaGxobXRrQ212ZnNlR2ta?=
 =?utf-8?B?NWZrVU9oZnQ1SFpLSnRDcGlQSzNXS0VHb1NHQ0RyL0hHMENBS01XTStlcDRU?=
 =?utf-8?B?K3ZXVGVIRWYyU2lrUStaZmZHdm5xS1FGeWVYbjl0d0p3Y3B4OFh6eFNMN0c2?=
 =?utf-8?B?L0xwLzdKN2VBOVVramRGRXZla0dBV0NpdTNlN1RBY2ZyMjdpaGU2bHcyNG9S?=
 =?utf-8?B?RGx0eGhzamszZHB3aVlZS2IwQWVlY2pYeGlwekNXb0xXdnVEMk1laVBqeHly?=
 =?utf-8?B?dDJtei9mZ0xnNGFLcHNJTmtvTXZsUWxPeUovOHY3dzl2Tm03REhQdHF5anU5?=
 =?utf-8?B?TWx0cTBqc0h6VlNMZFFWUmtaS2xRemtGNDR5TG5Xa0F3SE5QVERNSjNEaTBY?=
 =?utf-8?B?SU14aXdMYVZlMFNacS93Y05hODVFQVRSN2p3RnpXNTFyeXV2Z09FUmFpa2pQ?=
 =?utf-8?B?ZEVtTzlFNUFDT0o5cjdlVi8wN213dnlYK0ttNmFuRHEvcG5nWHVPcTgyWGpm?=
 =?utf-8?B?ZGpaSWhCbG9pZ1hxaXhWeVF6d3dKbHp3OEh5UExLTzRZd0hOYXhCemwvQWlX?=
 =?utf-8?B?bUZMTGgrT2MzZHBzUnlnWnNDcG9aV1hXS1ZVQ0g5VE5ZdzZOdTJsUDVEc0Zx?=
 =?utf-8?B?ZEszcHVzVGhvMGJlRHFYSTVzRFRBSktENUlFdnVkTUFhL3hJQjM5U3haZVMv?=
 =?utf-8?B?aC9EeGFJR042aEdvWEd0VWlPZWU2UTBDc2VUZnA4M0JJQTROU0FsQ1AwZnVh?=
 =?utf-8?B?ME55d0kzdSs5Vy96T1c1Z1pHZnkwQ0VGU3pEMlZsUHYxamhhK3l6ZUJGT1hl?=
 =?utf-8?B?cFlGSnBCOTdNMWIzT1E2ckcrMjhvRVpEaytFcStlVWZOR3NHR0VUYkpWTWpw?=
 =?utf-8?B?RE9qWVJOZ21QWkdJQ1kwUDlJcFExMDFuaHVOdWVZSmp0K3lBWVhOKzNDbFVp?=
 =?utf-8?B?YXFsVk1XcjF3WTV5aS81VkhaQ2lDUzUvZGNENDN5cGYrdzhxbU5YZzlPd3oz?=
 =?utf-8?B?a0x1UGJEYytnVHlaSlk3S1NYQXhMNTFIQzhucjEvaFozVlhFaUV1aHlRYktk?=
 =?utf-8?B?QW14dndRSU1wd3FJdUgxR3MzUG9TUXVteWltWVJ1UXJTK0x3ZUtxUHEzZFha?=
 =?utf-8?B?dFpDVG9WSldxWUJUYTJqSitaZGFULzFGMWhyQmdTY08wMTFINlAwUjFwNmZ4?=
 =?utf-8?B?ZE1laGlSemR6UnVMUW12c2lyYThuYUJ1czFyYmJvUFkrNFZUSHNSMkROWVNQ?=
 =?utf-8?B?ekx2Z0hKRHcxQWlIOWJOSk10VUF6UVRtMjVuRXIzUlpBZkN5VXdBdTVhdXIy?=
 =?utf-8?Q?LhdA7WspjFX/7dh4YM6lR1ro+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4a49af-9d21-450d-7c5e-08db5743b6ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:00:54.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEbfp2XOYExwWILNVZcPUlp/rqPz/EB5Nin5ucNAzOnRj1B3Klp3vRafLhTaemTEokTwSOewzYG+Bk9dsNebOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/17/2023 8:48 PM, Limonciello, Mario wrote:
>
> On 5/17/2023 7:58 AM, Mika Westerberg wrote:
>> On Wed, May 17, 2023 at 07:33:17AM -0500, Limonciello, Mario wrote:
>>>>> AFAICT the actual issue is entirely a wakeup platform firmware 
>>>>> sequencing
>>>>> issue
>>>>> while in a hardware sleep state and not PMEs.
>>>>>
>>>>> It's only exposed by putting the root ports into D3 over s2idle.
>>>> But there are two ways to enter s2idle (well or the S0ix whatever 
>>>> is the
>>>> AMD term for that). Either through system sleep or simply waiting that
>>>> all the needed devices runtime suspend. There should be no difference
>>>> from device perspective AFAICT.
>> I should correct that the wakes may be configured differently, though.
>>
>>> On AMD all devices in runtime suspend and SoC entering system
>>> suspend aren't the same state.
>> Okay.
>>
>>>>> As an experiment on an unpatched kernel if I avoid letting amd-pmc 
>>>>> bind then
>>>>> the
>>>>> hardware will never enter a hardware sleep state over Linux s2idle 
>>>>> and this
>>>>> issue
>>>>> doesn't occur.
>>>>>
>>>>> That shows that PMEs *do* work from D3cold.
>>>>>
>>>>> With all of this I have to wonder if the Windows behavior of what 
>>>>> to do with
>>>>> the root
>>>>> ports is tied to the uPEP requirements specified in the firmware.
>>>>>
>>>>> Linux doesn't do any enforcement or adjustments from what uPEP 
>>>>> indicates.
>>>>>
>>>>> The uPEP constraints for the root port in question in an affected 
>>>>> AMD system
>>>>> has:
>>>>>
>>>>>                       Package (0x04)
>>>>>                       {
>>>>>                           Zero,
>>>>>                           "\\_SB.PCI0.GP19",
>>>>>                           Zero,
>>>>>                           Zero
>>>>>                       },
>>>>>
>>>>> AMD's parsing is through 'lpi_device_get_constraints_amd' so that 
>>>>> structure
>>>>> shows
>>>>> as not enabled and doesn't specify any D-state requirements.
>>>> AFAIK this object does not exist in ChromeOS so Linux cannot use it
>>>> there.
>>> OK that means that if we came up with a solution that utilized
>>> uPEP that it would have to remain optional.
>> Right.
>>
>>>>> What do they specify for Intel on a matching root port?
>>>> I think the corresponding entry in ADL-P system for TBT PCIe root 
>>>> port 0
>>>> looks like this:
>>>>
>>>>     Package (0x03)
>>>>     {
>>>>         "\\_SB.PC00.TRP0",
>>>>         Zero,
>>>>         Package (0x02)
>>>>         {
>>>>         Zero,
>>>>         Package (0x02)
>>>>         {
>>>>             0xFF,
>>>>             0x03
>>>>         }
>>>>         }
>>>>     },
>>>>
>>>> I'm not entirely sure what does it tell? ;-)
>>> It's parsed using `lpi_device_get_constraints`.
>>>
>>> So should I follow it right this means for ACPI device
>>> \\_SB.PC00.TRP0 the constraint is disabled.
>>>
>>> It's described as
>>> Version 0, UID 0xFF has a minimum D-state of 3.
>> I see, so it needs to be in D3 for this "constraint" to be valid.
>>
>>> That means my idea to try to only change D-states at
>>> suspend for enabled constraints won't help.
>> :(
>
> At least on an Alder Lake P system can you check
> whether your root ports actually respond
> affirmatively to acpi_pci_bridge_d3() or they need
> to fall back to that logic?
>
> In my case the problematic ones don't have _PRW or
> _S0W, which might explain why Windows doesn't try
> to use D3 (hot or cold) for them either.
>
> If the root ports on your current systems do respond
> through acpi_pci_bridge_d3() a possible solution here
> might be an allow list for systems from 2015-2018 rather
> than everything > 2015.
>
Actually this is exactly it.  The function is missing a call

for platform_pci_power_manageable().

I'll send out a v2.

