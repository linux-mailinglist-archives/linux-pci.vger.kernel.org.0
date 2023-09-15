Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7067A129B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 02:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjIOAz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 20:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIOAz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 20:55:56 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528F1FE8;
        Thu, 14 Sep 2023 17:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx+yLvCXEJE0K2JOjTShGwJ/RNuulR5wMVDRbj1MCFERV+9czUOXoaug3B6GY6x8aGmb2XsIi26ilz/QXE9Qsy8xlC1JKiYeivM+akMylz1RTFoe6TJUd5+NIhqKU+JnhO3O8Dprmv8PY1dQNGxJlXxhUB3cSAiR+WFMi/xYDxUsnI5WoRTjQfJdmvMXElpPiAje57aOhDo9Abe/Rv/Fn12OhzV2Q/fnSqmjg4g+Z1UbEc4X6y5Vv1lyNpNl7YwOs3t0zWKkKZmJmMATsC+9sg1nVtwgzrJIJK/m43rhONU6DRkX9QBDU9wETu0N0WiGHcSKYnEj5aAjeivqXto/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5NuakR+bJMglYxMin+C2fzMN7pMR6VcJKxxMByRGMM=;
 b=fxMeQ5o6ngIS4a98zbv3s6cA2b7cwCSE8CH3061HQCaTxs+BVWffNM5xzzFr38e7X4kyZveK85CJ7ip1QMnI+EjTpf6wtFbb6e8KA3wUybPP+zeCGMwjY5lCAAEhgKsECnU5ngjJAK+Fx1mYEQ+oOiY/9sftcw16NufeHQ9ez61OkdYeriWIoqjaaLB5j+61zEC6duHKMeG0qnGZEFoaCEgdwn8hjTSLjs0NU2lp8Hkff/bzLpCiSr7ZyNbB7qMIEb+YksNEYrMVINkTC7X1+775cRR/R+hMuA9KpRD3IVzOah8LbSdsOG55/cdqVIr+q1MtnN6MYIAjWTszUcs8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5NuakR+bJMglYxMin+C2fzMN7pMR6VcJKxxMByRGMM=;
 b=FYNi3ajNSZuR47f4cOplK/otFpTjmS8Qk5uHNEc4RfP2gfMgbjdfiCa0zFroTeaHPz+I7pB1XRk8Pb+3oP2IA/Y9EguDMDJPJ5PR5T+/RAQBc3+qWPP8NmxmMXvnoMK7zai1LqiRsWqbaFv5gzwJvGLTky1q+zy3LteQjp3AIcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 00:55:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 00:55:49 +0000
Message-ID: <67fe444c-e3e4-4063-a7ad-e0c3c835bc68@amd.com>
Date:   Thu, 14 Sep 2023 19:55:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
References: <20230913210543.GA440503@bhelgaas>
 <001d9c72-49df-4a8d-a9bd-10311887c60d@amd.com>
 <75e5175e-406e-41dd-90c7-3dc30741897e@amd.com>
Content-Language: en-US
In-Reply-To: <75e5175e-406e-41dd-90c7-3dc30741897e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f48f8c1-58b4-4a53-e155-08dbb58680b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwNQidGeborrjfMlQylde3JufEG0BDrdjgaTLAnWxyxRjgQGyfedQQGcG1RnPB3X6YGW+U3UKQaxTbaVN5H/UbW6vvBtYW9crwI3+r/RbGpTiwcIcgnEHjB6iFpFeFKa23euxFQ15/Xgvj5Epr5QTVt6DR+m7z2UxHlhjgZmF7/nUyA8x79IAFaWCiySoMGT9oi8axUaUGStsYoTgjR5RPkvSsIQA8GG3Gh2j7at8VOlEplKP6exUBaD7ryLFGEksZpniIZ7gSkHg4iqhKuJN+P+3rX2CDyTHb/DIIxsBwrpvLTwa8jIcuR8TxnKQetoH+Z76vRmEbJw2lyRkk8j1/9Z4l2lnJAnXlq5YjqGCXflxgDcW/psnYlNjkiqeoqH6GerKVP5mvxMQdkiN0JqwqnlfPIaaZf8Le9zJsTq/LQvNK5KpHA+YBMlHP1XV1atTCBZKN63xAkLUKTVe4jJI3L4Jcc8YXbGiRPIETmjeSC2JBdVJ7wDJc4x8SD05i4Qb+48016itLR6D4jVnFsUee6UNmS4p0uiSzpLZ8zTVZmmuqD47IlmQD7QpNfIx1C+qN82D7ns+v3Zo7DXeouw5fkm7xq25Hbv8fcN4ckysAgRC2xIlJe6N7yqQF1K+qSK94q68v9I8CMhgM+mdHGecA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(186009)(1800799009)(451199024)(5660300002)(31686004)(6506007)(6512007)(6666004)(53546011)(83380400001)(2906002)(6486002)(86362001)(36756003)(2616005)(38100700002)(66556008)(4326008)(26005)(8676002)(478600001)(66476007)(44832011)(31696002)(110136005)(8936002)(66946007)(7416002)(41300700001)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzE1QzkvTmNyS0JEMGhhTkhPVTM3RmZ1UHVFQ3dkMmdoeDNTaXhVSnl1eE1B?=
 =?utf-8?B?NVNWVVVjVlNBRHlKQkpxZlk0SStTU1N2RjE4OEFaOEZrSytLK3g5WkRoOGRl?=
 =?utf-8?B?ak9tTHhkYUYzTkFZcVFzUGlDN2l1c056Nk1jN1RhSUVYb1lmQUV6MmNScG9D?=
 =?utf-8?B?ODBrQzg3WGZEeVprRURPR1VJWW0yT2JhdzAzck5wTEhsdTV6bEtWK2dMYUJ1?=
 =?utf-8?B?SkdGSHBpQTRsTmpTU3VMYTczcGhnakFadHZTbnIyeVh6VzBuZmFvc2N3WWdo?=
 =?utf-8?B?ZjU1eW02LzRYelZwYUQ3K29wK293YytGeHVJOG85NC9WSE5KcG5PcVFxN3pa?=
 =?utf-8?B?czhGTFNiUG1nWUJnMTRBMkQ2dk1nSjJJRUFwWngyYkp1VkhzNGZ2WkoyVVdu?=
 =?utf-8?B?SFJsQlZneXJDd3o4Tmc3Rk1yS0JWa2o1d3BaN0Y3QXJDSS80U1VVMTlyeUJ6?=
 =?utf-8?B?RVQ1RFBMRUliOFVnMSs0QmYrM3V0NnNMdHBXRWNpOCtiZFBzUnZ1QnJYeVJn?=
 =?utf-8?B?VVBWSmRTY044ZmNFby9OZEZaTHJXY1ZRTmlFcVRxU1RNUStGU2xIaXNwRC9O?=
 =?utf-8?B?QXBnMWgrSFdDZUdlcFVhdVJxckVyY3JrZ251bzlGUGtEK21WRHpxVXo4UkVn?=
 =?utf-8?B?c1VHcTFlRVZkcXF4SDZub0d4OW1Udk9GLzdBVGJyNUJ4MmZ6YWVneTBSR2VT?=
 =?utf-8?B?YVord3gyWGFLNk9qYzhObGFKSkRqeEkxOGkrTE1ndGF0SXlNRE1Sb1FnVUlZ?=
 =?utf-8?B?T2JaVTlHS1k5c0hzYlRoSXBLRk9XWmgwVno1WjRZNTNoNFJaNHI2TFhNYjIz?=
 =?utf-8?B?M3U2YXdmbU12WDBVTU5NellpamJ2b0dBN3l2Zk9KYWJQQkVMTm04K2VONTFU?=
 =?utf-8?B?T1NXc0J0YVNnNS8yUkJMQ2tXZW1MNDd5dlVMQlpYZWhEdkZhUm1FMVhFYnJt?=
 =?utf-8?B?SHRTZWJySGxjdlhMYmlwajV1RGFrSXZZV2wyeE9QLzRhaUFDbGE2ZXkvdHJp?=
 =?utf-8?B?R1U3N2lZMWwyU0liQkYvNzkvc3BDek5oVkJHcHNteWNzUFdOUXJvbWZYVlg2?=
 =?utf-8?B?b1RieDNpcDBXR09oM1E0MXAwS1kvQ3RmWGFNemJJdnFEZWJiUnVFU2JYbk5v?=
 =?utf-8?B?WTNxS0c5NkxJNnBva1J6Y21Rc0VkUHJhcjc1NFFTZnp1aE5aWUo3T01DbXRw?=
 =?utf-8?B?bGZRTkRxaXV5TG1BZldzVVZQdDczRDQ5WUs0OUx4NWpIa0F6VFdXd2NPYjMx?=
 =?utf-8?B?ZlJPUTIwOVI5NC9uNHUydW9sbEd5ZC9IWUwzUkFTUWFnQVQ3ZmJSSFRPNlU4?=
 =?utf-8?B?a1NmSjV4NmUyQTdRRGl4eU5OZFJaZlkxWmdSaGdUc0QrQlNsbGU0ekNBb1cr?=
 =?utf-8?B?bXY1Z1lELzJQYjZ4NlVOUEtISWVDU0ZhZDgwN1ZsZzNNQzFvOGpIeDJ4bXFY?=
 =?utf-8?B?cm05M2p4S1N4ZGFkcU5vWEcydkNVd2tMMlVuWVU2SkFqNjBQc3ZxUXY3UkRC?=
 =?utf-8?B?TGJYYXRyOGRHd3RaMVlxMTdFbVJqYTIrMzZyVzNFTGt1eC9NQmZtbWh6RTh5?=
 =?utf-8?B?ZEVrVENpODNXUm16RUZYRnJSV0VvZG9NTU1VSUZsWUhLaDB1WVpUSmhGcW1i?=
 =?utf-8?B?TEVlSkRwa1JUR0lUNzVjT0cwb3FPY2RScTI4Y1doQ2Foc3hXYWx6cHhKazRC?=
 =?utf-8?B?NXFUZHFnNWloc0RwYTJFRythTUFOM25rTXVXTXdVQnM1cG5IdXFwM0FOR0Jl?=
 =?utf-8?B?K0NRb09ZaERQd3cyZ1JHekh6UDRtM3p3NWY0azVNeEorMVBialN2KzEyOXZK?=
 =?utf-8?B?R3J3Z0JMZ2k3TElKY2JrYW9jQmtydWNIQUxQY3liZldUcituNzcvM2Y3WUVX?=
 =?utf-8?B?NkowSzRacSszSkpLTHl2TTFhN2VNd1pReFByRGpuVSsxTk5zMHcvckFlM2FM?=
 =?utf-8?B?R1JmU1ZkQXdDSGNzNE84Nm5JSDdJNnBZY2hJOUw3T2lUMTlzZWI4TWY3QXNT?=
 =?utf-8?B?VVNSVStPeHBwY3pBMUVtUDFndjhIZjZXditLM25ubFk4Q2tvR0RGR1g3WkZh?=
 =?utf-8?B?Qk1QVlE5QVpnM0o1ZGljS0JZSjhHdTZHTktjZkxzcnhmeUJuZVh2VlBkVE9t?=
 =?utf-8?Q?OmE3jjcnBjaA+FPLcLJa4ruON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f48f8c1-58b4-4a53-e155-08dbb58680b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:55:49.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHoAIW2aUNlB7U0RKhgs/bAWLO6lAsF+S+fHz3vGroOKXjHh0+xGHKiFEoxREH639XPM9Vq+YEpkO+JpMO8asA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/2023 23:59, Mario Limonciello wrote:
> On 9/13/2023 16:16, Mario Limonciello wrote:
>> On 9/13/2023 16:05, Bjorn Helgaas wrote:
>> [cut]
>>>>> I expect it to be an ongoing issue.  I also expect unless we use
>>>>> constraints or convince the firmware team to add a _S0W object with a
>>>>> value of "0" for the sake of Linux that we will be adding IDs every 
>>>>> year
>>>>> to wherever this lands as we reproduce it on newer SoCs.
>>>>
>>>> So maybe the way to go is to make the AMD PMC driver set a flag for
>>>> Root Ports on suspend or similar.
>>>
>>> I like the quirk approach.  When PMC is involved, the device behavior
>>> doesn't conform to what it advertised via PME_Support.
>>>
>>> The v18 quirk isn't connected to PMC at all, so IIUC it avoids
>>> D3hot/D3cold unnecessarily when amd/pmc is not loaded.
>>>
>>
>> Technically someone could; but realistically no one will be using 
>> these machines without amd-pmc.
>>
>> The battery life over suspend would be abhorrent.
>>
>>> I don't object to avoiding D3hot/D3cold unconditionally.  Presumably
>>> we *could* save a little power by using them when amd/pci isn't
>>> loaded, but amd/pci would have to iterate through all PCI devices when
>>> it loads, save previous state, do the quirk, and then restore the
>>> previous state on module unload.  And it would have to use notifiers
>>> or assume no Root Port hotplug.  All sounds kind of complicated.
>>>
>>
>> Yeah this does sound needlessly complicated.
>>
>>> Maybe it would even be enough to just clear dev->pme_support so we
>>> know wakeups don't work.  It would be a pretty big benefit if we
>>> didn't have to add another bit and complicate pci_prepare_to_sleep()
>>> or pci_target_state().
>>>
>>
>> I don't think clearing PME support entirely is going to help.  The 
>> reason is that pci_target_state() will fall back to PCI_D3hot when 
>> dev->pme_support is fully cleared.
>>
>> I think that clearing *just the bits* for D3hot and D3cold in PME 
>> support should work though.  I'll test this.
> 
> I did confirm this works properly.
> 
>>
>> Assuming it works how about if we put the quirk to clear the 
>> D3hot/D3cold PME support bit in 
>> drivers/platform/x86/amd/pmc/pmc-quirks.c?
>>
>> It's still a quirk file and it makes it very clear that this behavior 
>> is caused by what amd-pmc does.
> 
> I've got it coded up like this and working, so please let me know if 
> this approach is amenable and I'll drop an updated version.
> 
> If you would prefer it to be in pci/quirks.c I believe I can do either.

I've also got a variation with pci/quirks.c working too.

Here's the trade offs:

pci/quirks.c
------------
* Two lines for every platform affected by this.  IE:
DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x14b9, 
quirk_disable_pme_suspend);
DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14b9, quirk_reenable_pme);
* D3hot/D3cold works at runtime (since PME works at runtime)
* Only runs if s2idle is used
* Runs whether amd-pmc is bound or not.

drivers/platform/x86/amd/pmc/pmc-quirks.c
-----------------------------------------
* 1 line for adding new affected platforms
* Runs at probe; PME is disabled for D3hot/D3cold at runtime.
* Only runs if s2idle is used
* Only runs if amd-pmc is bound.

Having implemented both ways and given users will effectively always use 
amd-pmc, I have a preference towards pci/quirks.c which only patches 
dev->pme_support to drop D3hot/cold at suspend time and restores it at 
resume.

Please let me know which way you prefer.
