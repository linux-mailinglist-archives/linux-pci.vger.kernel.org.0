Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC4735FC2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 00:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFSWKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 18:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFSWKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 18:10:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C321E65;
        Mon, 19 Jun 2023 15:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7PcT/mU9bQc1o4hKedcnYaysgOhqD8y8BiHGw1M1pD9tVJZbirTEXYnLpGnUKTuiQpad8OWO1UQ8nAJwy2SRxqlnGpflLD4TrbLrIxFcpUg/s6biQIwjmvSfL8+z6dWatejijAD8d87ltxiaGLIJ3bR+HNk3fhJkxCd4zNGWAUp7CSs1NUuy0ADfDwNZuobeN9frWbKQt14PQP0ZyDdrywRb5ADtezLTMeVCG0Vm/RdNanaZp+Vz0xRv5dXils5fS18y+GJv8lCB0k8rUApMkafoAsvO7ia4GjNTTPYxQ52v9dwLDmabhQF8KTeMCdxfn/haEUeYHaZtzGyIWnF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oScFTpSuV4UWRcMy4JJtgoPuQIx33BnUlJm1uSbDQQo=;
 b=Jc4RmVncGRmxMxyQioekQBzmcX7l91sZkZU2oFYMeWMrMVkJ5mfXMp+8yIFI+3klqjy2VSXiyc2Xbb7bHTxFXpMc1MkloaXL4UNtFyWe8I/gj0+lSZDMATA9bpRe6pG9MAQw4GNqXCCf0H9yBeXZKshh089AwRaf06SlMCjL2hHlL8JtUmcMw6maaIsqxXRg1BnH6ILfQ7mbziQaUcVsVfqde2L7BAuYSzrxm7YoSctfyWbGK7l/T/Yr4+NOkhgt+PFTUV5AIGJIiIKeNlmM1mCmtBoSpvPg4M98XrDVL4wD8EGrjtgm5o+BqWAj0jjfx4i7T8z5s7mSEREXxzYsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oScFTpSuV4UWRcMy4JJtgoPuQIx33BnUlJm1uSbDQQo=;
 b=tBMqsDBmf00xBpdaD0XsnRPADnzZcKTU5yvLWvtAMQ37/QhO1/5fwwmhucdyL2zDhvsgqNVyOYBTc3hh5He46wJuKhZLb/Qapc1MMtSy/tIFBl8a9xYp4uzL8z78aXCtwIW7DaAY0Oo8tFiffapgS+k/6Uo+q8QFltYB5jVuYGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 22:10:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 22:10:00 +0000
Message-ID: <eea91b5c-a61c-9a66-f084-df7495ae2c0c@amd.com>
Date:   Mon, 19 Jun 2023 17:09:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230619213716.GA23372@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230619213716.GA23372@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:610:119::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 088df0ac-3e13-411d-4f22-08db7111ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAEbZqFIJ0o6iVlH3YmGIF2xzNMNFh72YLRQJlhbSpo8zEfi5hiRH+iJAKkm4RkZLoSid9ak1fN95garD2N4oxNpi3OKiRlWcZNlzEB8VBcoh/MEJYC80tOGZzZvVi70tg8xaENkFbqpoWCVJUmFkcjA2gyBF/gHEwo4FQj5SbKkw2moJKEAd1Wq/PmnjcKDewyhLuuznkLKj843vDBz5A1OpYjnb7NuYmbSXs6nujlTFLHjpZDe/UxWxlfHKyPSTYBDEQN113qyuZ0OURu9QAdEB6yBWRZ58bf5PgW8XL3WSRQeVOHjoneVd/56ivxUH+tFeuZN5LqoZR6xRXzsfCShtdxWc6pzfCsg7id601RrSq9uZ49Oaq2MMFTA9nVC+dMPppN777Fg9efh40RHXlQ5AR5krKOaN/TPvhmmp2oZNf3tym2M9GbJVd4b4cemfxbQxX+fAb9EjOUY5/aayrMgRyKA0VcB+JsYVhzGpDzHa+JmCszPKwkkQwy2zHNmaL6K6eWm0WjEVzy2pw5BQxwN3Uy0bhA5hD+IoZmHVb3Ds5Mencu7WBKenApiToB0+D55rl9sqZO8mxbFdcrKPDlY3TkpJ+NQANSHJb1Xxwd4W55bcXd6q4PyEQzQDeb8lEV+4s4KGUhIYuErKvowOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(53546011)(186003)(6512007)(6506007)(2616005)(31686004)(966005)(36756003)(6486002)(6666004)(83380400001)(478600001)(54906003)(4326008)(66556008)(66946007)(66476007)(38100700002)(6916009)(316002)(41300700001)(7416002)(8676002)(8936002)(66899021)(5660300002)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFZUTTZqSmJmdkFEOGg1dytPc2ljV1NrSkxzMjhDQTVwL0JqLzlyN0tGU2Ew?=
 =?utf-8?B?eFYxdmg2YmhFbm9Dc3QydGJ3Sm9obStGT3NzTXludCtndFZSa2IxQ2kvMzVl?=
 =?utf-8?B?UmRacUZpZkl1cm5PcEo1M1p4T1FMcG84YmZmUU9XV2JneFNFeTJoa2Z5eXdD?=
 =?utf-8?B?dExZUzR6TzRXWFY2ZmZZWHlGQk9KU0RDR2Qzb1dIci8yN1Q5R1JiT1FDWWVp?=
 =?utf-8?B?MVlJMDJhOE54LzYwR1VzOS9tbTBPS0hUY1VTK2x2NjhSS25qdWh5SGY1b2xR?=
 =?utf-8?B?REo3Y08zaVp4dkZ3STIydFdNbS9Nbmc3QXVtMzVjaTdCcVRLeFdMajNRMlpJ?=
 =?utf-8?B?MllVQkw5OUQrMkk0U1dSQkFWeWRZZFpUVzF0SWhRMGJNQk1XUUxHQk5PNlZ0?=
 =?utf-8?B?d0hHOUx1aDFWbXAyazJnaHVsOUowZU9ZLzVjZkI2dTFDNzFEdVoybUhPa3Nh?=
 =?utf-8?B?K3hZMllYYmZGaUdjay9IM05ldGlXQkc4NWlLVTJodm1hVk9qUFVya1RpaUZP?=
 =?utf-8?B?NURPcXZ5dXVndVE4djJ0a3BwUHRoUmhGL0hFemNiWHNNRDZnRllIK2JJUE96?=
 =?utf-8?B?Tm96cEUvK0s3cjhJcmpFM3g2Zm5QU1U2Z0YxS0h3R1d1NmliREtlMTFZa29w?=
 =?utf-8?B?NE95V3Bhbm44UHZEQXhMczBRRnl0Y0tWekJuelZoVHo2clB3bldSdG5Kc2kw?=
 =?utf-8?B?MkhlRWpYeTNqQzczNFFUOVdaeDRVcVBycTVhd1EwRjBteUR1Wk8vQy95RGFs?=
 =?utf-8?B?a1kxVkJZUHc0QW1wQW1tYzdTOEZ6SWN5MU1IWFFHZktPS2NWUk5aUElCamVu?=
 =?utf-8?B?aEFncWNMRjZsY2JrTFF2QzhvRkRlSDR4eUVMWmJtMkhDVlFKT1Q0QWpYcUhj?=
 =?utf-8?B?dnlPR0pMb1U0UzJwb0FNeklycEIxcHZieWR4cFNkK1JqdEx1VkZiaFRWWVBh?=
 =?utf-8?B?aW1lb2gxNHJQQVFKeGlPOUswWjJmY1BiMFdrRHdiTkZRb0I5b2JYemhiYzND?=
 =?utf-8?B?VVNnZ1hac0JHMHZFelpjU2wycUpkY0xZa3hoSW0vZnRQeEN6R0F6MlArbksz?=
 =?utf-8?B?Q2FmNnl4a2ZGQXpvTVdZNlNXcTNmT2t0VG5wWVp6QTJKclpnaWZFSDZWMWNZ?=
 =?utf-8?B?UGhKcGNvUjNWSnFTeWlrWWJJMXdFa0ZKY29IaXdYQytwZHVta1hjcWhwTXpy?=
 =?utf-8?B?bk52MjQzd0JYTEF3VUNjWWFXRzBPQWZOekt1eFFUSUwySFZoV3JBS3A2NWcz?=
 =?utf-8?B?b29SS2tsMXp3QUdZNmo2NnNQRXIxeHBsVkEybUlMWTBpL3J6ZDUxb3dFb2lC?=
 =?utf-8?B?ejJkQnQ2SnQvT1hZWUM1K0V2bDFBYXEwN1BxeE00SXVqR01jRzdVZEtxWUdh?=
 =?utf-8?B?c3BwajVuWXBTSGhQZFM1S2RkTmlJUi9UWDNSei9yZXVVb2JLdzF6T0JaLzJw?=
 =?utf-8?B?Qmx5UkE2ZTJzL0x1cHo3M3dkaXMvSk9OZU1DTE5yaGpMVC90Q1Z6OStDbnBr?=
 =?utf-8?B?Nmtrd0xPelUxYzMrUTAzeHBWSWplZng0VUZDNTd1QjBNSkdHallnZm11eXNz?=
 =?utf-8?B?bEt1N01Qa3RDSDlLeXFKQk1SNTBuSWhRMjVuWDBMdktNeUtEMHVRSGFacFZp?=
 =?utf-8?B?UTBFMGFZL1FNeVE3Z1FXRXFReStoMmcrWE1FS0pIK2hiQmdONUwwOGg5YXor?=
 =?utf-8?B?Y2p2NUFKUVZ2d3pzRHhvelVMSEV5UmZmK2c2U0JZZnluV2ttUGpheWlDTmc0?=
 =?utf-8?B?WkR6d0ozY3NzdzF1ZVE0dE4rcjFONnZtZkpIbTVxaTdld283VytpcFV5ZWgz?=
 =?utf-8?B?OVlvc3F4b0xqMEc5SmFtNmd5cmV6Zit2ODlzY05Vc0I2SlQxL0w0aVBXWU9l?=
 =?utf-8?B?eVVDV1lHeGZBYjFVNE9qbzNDOFpmbm92aW5TNHhGT0dIVFpKdzduaytLUjVX?=
 =?utf-8?B?T3Yybjh1YTdza1JSaHRTM3EzcTFUdmlxSGw2WlAxMDJXM2Yrd2F0UlpnVmJO?=
 =?utf-8?B?ekFuQXZjU3ZQU0VBelRYMFFkQkdZbElCMWZzS1ZFMWMrSkZzK0lWaU05cCt2?=
 =?utf-8?B?NitzUjBWVlUyeFUzcjNaQklRTlJvSkhRMEkvQ3A2ZHhMeDBhaWdabUxHVnY5?=
 =?utf-8?B?dWlwVVRYUkVXcmlkSG45VnliT1hLTUNESC9BVFppZ0diMGIwTjVTekg2clFO?=
 =?utf-8?Q?abLqTKo6a9tu04ZoOzVY8Jqp7vPvkAI/jQJA2llQe8FJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088df0ac-3e13-411d-4f22-08db7111ec84
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 22:10:00.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uolc6G19nHQiMd7OBlpvX+OgozxE9l6s48XaUWw0E0wPqjMEWWWOBmh6r8Zrak4ISH2bIiRDwfojpT2cFKtMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/19/2023 4:37 PM, Bjorn Helgaas wrote:
> On Mon, Jun 19, 2023 at 11:16:35AM -0500, Limonciello, Mario wrote:
>> On 6/15/2023 10:01 PM, Kai-Heng Feng wrote:
>>> On Fri, Jun 16, 2023 at 1:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
>>>>> When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
>>>>> enabled for that device. However, when the device is plugged preboot,
>>>>> ASPM is enabled by default.
>>>>>
>>>>> The disparity happens because BIOS doesn't have the ability to program
>>>>> ASPM on hotplugged devices.
>>>>>
>>>>> So enable ASPM by default for external connected PCIe devices so ASPM
>>>>> settings are consitent between preboot and hotplugged.
>>>>>
>>>>> On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
>>>>> pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
>>>>> pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
>>>>> pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>>>>> pcieport 0000:07:04.0:    [ 7] BadDLLP
>>>>>
>>>>> The root cause is still unclear, but quite likely because the I225 on
>>>>> the dock supports PTM, where ASPM timing is precalculated for the PTM.
>>>>>
>>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>>    drivers/pci/pcie/aspm.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>> index 66d7514ca111..613b0754c9bb 100644
>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>> @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
>>>>>                 /* Enable Everything */
>>>>>                 return ASPM_STATE_ALL;
>>>>>         case POLICY_DEFAULT:
>>>>> -             return link->aspm_default;
>>>>> +             return dev_is_removable(&link->downstream->dev) ?
>>>>> +                     link->aspm_capable :
>>>>> +                     link->aspm_default;
>>>> I'm a little hesitant because dev_is_removable() is a convenient
>>>> test that covers the current issue, but it doesn't seem tightly
>>>> connected from a PCIe architecture perspective.
>>>>
>>>> I think the current model of compile-time ASPM policy selection:
>>>>
>>>>     CONFIG_PCIEASPM_DEFAULT          /* BIOS default setting */
>>>>     CONFIG_PCIEASPM_PERFORMANCE      /* disable L0s and L1 */
>>>>     CONFIG_PCIEASPM_POWERSAVE        /* enable L0s and L1 */
>>>>     CONFIG_PCIEASPM_POWER_SUPERSAVE  /* enable L1 substates */
>>>>
>>>> is flawed.  As far as I know, there's no technical reason we
>>>> have to select this at kernel build-time.  I suspect the
>>>> original reason was risk avoidance, i.e., we were worried that
>>>> we might expose hardware defects if we enabled ASPM states that
>>>> BIOS hadn't already enabled.
>>>>
>>>> How do we get out of that model?  We do have sysfs knobs that
>>>> should cover all the functionality (set overall policy as above
>>>> via /sys/module/pcie_aspm/parameters/policy; set device-level
>>>> exceptions via /sys/bus/pci/devices/.../link/*_aspm).
>>> Agree. Build-time policy can be obsoleted by boot-time argument.
>> I agree as well.
> This isn't strictly relevant to the current problem, so let's put this
> on the back burner for now.


I think it could fold into it if we end up treating the i225
PCIe device as a quirk as mentioned below.

>
>>>> In my opinion, the cleanest solution would be to enable all ASPM
>>>> functionality whenever possible and let users disable it if they
>>>> need to for performance.  If there are device defects when
>>>> something is enabled, deal with it via quirks, as we do for
>>>> other PCI features.
>>>>
>>>> That feels a little risky, but let's have a conversation about
>>>> where we want to go in the long term.  It's good to avoid risk,
>>>> but too much avoidance leads to its own complexity and an
>>>> inability to change things.
>>> I think we should separate the situation into two cases:
>>> - When BIOS/system firmware has the ability to program ASPM, honor
>>> it.  This applies to most "internal" PCI devices.
>>> - When BIOS/system can't program ASPM, enable ASPM for whatever
>>> it's capable of. Most notable case is Intel VMD controller, and
>>> this patch for devices connected through TBT.
>>>
>>> Enabling all ASPM functionality regardless of what's being
>>> pre-programmed by BIOS is way too risky.  Disabling ASPM to
>>> workaround issues and defects are still quite common among
>>> hardware manufacturers.
> It sounds like you have actual experience with this :)  Do you have
> any concrete examples that we can use as "known breakage"?
A variety of Intel chipsets don't support lane width switching
or speed switching.  When ASPM has been enabled on a dGPU,
these features are utilized and breakage ensues.

There are various methods to try to mitigate the impact both in
firmware and driver code.

>
> This feels like a real problem to me.  There are existing mechanisms
> (ACPI_FADT_NO_ASPM and _OSC PCIe cap ownership) the platform can use
> to prevent the OS from using ASPM.
>
> If vendors assume that *in addition*, the OS will pay attention to
> whatever ASPM configuration BIOS did, that's a major disconnect.  We
> don't do anything like that for other PCI features, and I'm not aware
> of any restriction like that being documented.
With both of those policies in place, how did we get into
the situation of having configuration options and knobs?
>> I think the pragmatic way to approach it is to (essentially) apply
>> the policy as BIOS defaults and allow overrides from that.
> Do you mean that when enumerating a device (at boot-time or hot-add
> time), we would read the current ASPM config but not change it?  And
> users could use the sysfs knobs to enable/disable ASPM as desired?
Yes.
> That wouldn't solve the problem Kai-Heng is trying to solve.
Alone it wouldn't; but if you treated the i225 PCIe device
connected to the system as a "quirk" to apply ASPM policy
from the parent device to this child device it could.
> Or that we leave ASPM alone during boot-time enumeration, but enable
> ASPM when we enumerate hot-added devices?  It doesn't sound right that
> a device would be configured differently if present at boot vs
> hot-added.
Same policy for both boot and hot add but specifically if the
device is in a quirk list to enable it or disable it.
