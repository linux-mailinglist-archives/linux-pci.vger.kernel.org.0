Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E0735C09
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjFSQRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjFSQQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 12:16:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFBFA2;
        Mon, 19 Jun 2023 09:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHjnP4ptHXHBCmrjxwksRJOW36r1ACr/aG0oMcBlZYzUz/syL4CHJmHzjZhMlXtudtCnTbnQEjK2LH4BXETxh9UrxexBYXTh4w3DQp2+jHY3hzsCYolWs0NfHUOamCnS27yJikuNHFv5XTtLzHgvyW2ofLubneFpK9Cwf62DdQ2du3mec9LnxEPzUDs99xWg4/MNhQ9Qsv4g3oDjVLum/sxCUVCVSbXtFypjdUop2X528jGvKCPefJAlzrk2VLZH46gPrvcO6F6cU34BUrbFupKf7pPtmdWD6At+Xx9p8aUBOEPiY4+Y0Neow/ciM1y7y9sGQV1BPM9IXnQoW5JQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLHTfAP/oDtI5xs7sJQOFrL0JCvnTIMfwIakFdzW6HY=;
 b=m9Ghpr0r52tUJ3NACU0invxrhfrEXFGv5Qbngrhwg5qBx+618HjZ555tjfIpiDQ+mrE/myt+qta/t2u2Wqc0lMWxkpJ4QpAxa8MfSzzr6iV4qc4y54g5+FPxTIuyA6/K9bz9sZgIUCrgACUNxkqEByRuIDA1KocMukCtd753ZhFKu2rl0RIl0CXbrIt3s1bqDq7XHyFsQ4j68QnoXDi7wbeYMoNTiOW8rpBembuSjnqjW5wRf5whaZTUzoIUnF0XkWPZVc6w9IKj8ox/3AUssrnkxNTEoXRCtf2UMt5j0Qw0T98ROgYhxkCsugSjlTwj1Rb4lIBLir7ZDGZD9pcnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLHTfAP/oDtI5xs7sJQOFrL0JCvnTIMfwIakFdzW6HY=;
 b=YiBET4n4djixUcUtZLuYMrL/tCith4X0Z/dYEo58es2rTbbADpujFXRAu/EgoZpniHhGulvvi3VIdcmsKHDAiZ1AWPaJqHABWZTSNIZnHqZEOXDPBfL+Lnv3UUsCULmkZzmFIeiVT37Mj5hwPZJ/xG1AkeLaegmm727Onf6KMro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 16:16:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 16:16:38 +0000
Message-ID: <20ac3359-cc0d-7725-fc75-d415bcd4c2fe@amd.com>
Date:   Mon, 19 Jun 2023 11:16:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230615070421.1704133-1-kai.heng.feng@canonical.com>
 <20230615171229.GA1478685@bhelgaas>
 <CAAd53p7o496+WRgYggMcCOAGmA=tV0-M7HnURXGysFjCHxSuKg@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p7o496+WRgYggMcCOAGmA=tV0-M7HnURXGysFjCHxSuKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0114.namprd07.prod.outlook.com
 (2603:10b6:5:330::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cf4d18-5172-4a2f-1daa-08db70e08f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yv5vHcdUMYDq96y1QgQVW5NbC62wP1lZ1DY1R6KZLtmudHMIts3L5ZTHAlZ5wdVQVxvpLU/e33RiVnX+Jijqn8WoDKf9CQ6wZaFDar9kvgX9CHRKBgff/H4TE1YnlZQqD+XJ+y4JooGfsch79MyFYiY5tZs6jGN65WLmLHxMwvnr+xwshctZfCB4VOjRwpDYi9M1prtLosoqq1C24kSBRzvv2seNrp2ByM2lokUM8AoSwZy5vzYWZd2fpjJiQfDXFZZLBWhtzX1Ivcnv3qM02IVuQclzN3wV62ivOfS601YVy9YGsk1blRX5mokPrAWEAFR/dOVCZa7Y0lIAzys5XMd4ElPEKAEnteWZ5PaXNvBIAfXevhII1nbJ07HNdIliDzN3wskbVahLEZZtoFx1/cM700iUl76+qTYQlHhWAKrR5uLeJLEnJW2mJHcJgs0S+ZpOi78Zo9vtYGySoz9GW6wh+mEyMO9Zysn48FcDpy4L17qvuruFuFCgCKn55KXNFoN/W7M2P2UnCcjnbEh0cyGm9w/vhqPuG+xakzEfsnXk10yWlUGGZRnWDOq9lCnetscMhO99hF/o8DG0d0pw+nUTp2C8RQu+rbkpsp5626UQh4M2ofOzRuE7KNSrMQzQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(186003)(8936002)(8676002)(66946007)(66556008)(66476007)(66899021)(5660300002)(110136005)(54906003)(4326008)(6666004)(6486002)(316002)(38100700002)(478600001)(36756003)(41300700001)(966005)(26005)(53546011)(6512007)(6506007)(7416002)(31686004)(86362001)(2906002)(31696002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjQ3VG9TRlQ0VDd6M3dydTdZNTVmb1dOQTdPY21LQnFQeVNXcHdsNXZJTml5?=
 =?utf-8?B?UklTblJVL2FJR3VYL1puNlZMRTlFMUZFVmg4aER1RDMwOS9nKzROOGI4c1JU?=
 =?utf-8?B?MkJKcW5GWkNQZmIrd2tMS3VaRFFXNyt0Vmg2VjlpTjJJQ1gyTTA1QmJVendI?=
 =?utf-8?B?cnpzdHJBc0ROaCtYc1Y3TGM2QWkybHdxQU1VSmg1blJEVWZHbHdlQW4xV0R6?=
 =?utf-8?B?SVBhcktRNjVmTzVuSmdEQVg4MXl3d3hsSkNUdWxIUzF4ZzRka1E4WFNhVUtM?=
 =?utf-8?B?TElFNG45U0t3anV4SC9XQXo3ZE5nb3dTUzVBTWsxZmxjU09odlVDQTRKOUNp?=
 =?utf-8?B?YVppTjhiNEhPMFp6czBKVWVVck5lVnMvbGswK0FFU2crdFJQNW5FKzBNQWRZ?=
 =?utf-8?B?N0lwRitZNzZwSlo0ZEpsaG9pdTB4SHMrWUxIMHV6cy9ncVZLK09yT0w0N092?=
 =?utf-8?B?R2IrT1diWlBXU0gxbEdwZFoxRlZzR3NsbjU1bks3M1lHczM2STRqMlArOXNx?=
 =?utf-8?B?VGNjbGV2Mk4zMm9XVGdqWndMYzZZbHBKZDdyNEp4N2dqcStOQnJCWS9ZL3ZV?=
 =?utf-8?B?Rjk2SUFiSEc1N2JkVTRQdWlLUWRNNVZ0U1JRc1JMMEJqNE52Q1JUOElQWTRU?=
 =?utf-8?B?MjkzOUxyM0pzTVl3WXd3dkJyUWh4dTJZWUpnRGF1WGQzTUtMMW1LR21EZ3dh?=
 =?utf-8?B?SW5XZUhiQ1RJbVMzd2dEUCtwL0djL0lsMFB3dFdjSC9NK3hpZEpRUlB2Sys3?=
 =?utf-8?B?NThINjJJalh2alRkWjZEQ0xZeEhDalk3ZzRTamFNRDR4VE1PVVZpUERwTHR1?=
 =?utf-8?B?UVdtY05YaVhsZzh0Tk5CQlVXU2tUc2d2dGFtZmJ0OEUyYnJsNnU0QVhpNzRm?=
 =?utf-8?B?SXVjYWlKYXJ6Q24wUUowS3QwY2JnUnUxZXEweWZ5K05pSUt4U0lOUDNvaCtD?=
 =?utf-8?B?aW8rUzhQZW1kVEYwMGoxOUp0SHdNSUhuVXR3Mi9rbEg5em5iUlQwREs5c091?=
 =?utf-8?B?RkVNeEM0VnVJNmhWZTh1UnBlejFEYVV6T1JHTHUwMS9xTkZnWUluaE1ySjR3?=
 =?utf-8?B?ajVlZ08xOVVqZ1pOYm9xMzgwWll5ZXRvbTFEeTJsc015OHExZDloaFlPSERW?=
 =?utf-8?B?cEJYbm9iTVJXc014TFJMSWUvZW1FMTB1ZkQzNGxZWHUzOW83TjdwNVVGb0dq?=
 =?utf-8?B?TDhNaVVUaVVyckdETjBxdWtNSUptTGR4MVA4V3hDNWdJdStOc0VoenF1cW9Y?=
 =?utf-8?B?WjNkcldhbEFOZW9wUDZVSGt3Yk13NDltT0hoS3lHYksyRVQ4UjBaM1p2Nzl2?=
 =?utf-8?B?VUQ3TURIWHBxaFZqNUhBMGZQVlNRK2wyRDZMczRiRzI3b3YwUEsrS1l1QnIz?=
 =?utf-8?B?eGpYUTZOTUhEYXdSMU1mTzlDRy96NUlvN1B5Tmtxd0RqUjFyRmtTNGdxZS93?=
 =?utf-8?B?cU5LdGFHR0ZEUGk1M0JxbGVDQXZncU83dkhhQ0VDQ3FhZjFHOGhpZjZLOFgv?=
 =?utf-8?B?T3hnRWpJV0lpSjVUSlFndGw4ZTNuMGhWa3ZFWHBaL2M1aXZTT0FhVURZOFls?=
 =?utf-8?B?T0kxeWdONGtjY2tBYjFrNm5NMWN1ZGd2QmlvZ2k5WmFtZXhYYnZwalJ3UUlu?=
 =?utf-8?B?VndiUGd6ZDlZQWRDQnhTeExBRU54ZGUvRnNwSnJMdmpJeHlsK0dFVUF5TUZO?=
 =?utf-8?B?VDF6MnloQ252aUpZMnVQcStLQjlSMGZuOEtJZ0dOdkJveC9OZXJTVFlQcXZj?=
 =?utf-8?B?TlBIcjR0MTg4RnJ3UDJXZ1k2UmhMOXVraHM5VHlkeUUyME1zZ08wdHIvdlZ1?=
 =?utf-8?B?UWQvRHFWRVoxK2NHV3lRTExQb2RFTHEzZEhzWTlkOEoxa1BuZzQ4T1FaNDV1?=
 =?utf-8?B?WmRGbmQxSWZ2bnZmY1R4TTFBOWhxSDM0U2VQNlFwZ3QweHVKME9CaU5Hdzli?=
 =?utf-8?B?Q3J5bTk5LzZRWEQrZWlpK25UUmlZVG5HUTByWU81b21Jbm5qaHhYNDR5Q2V1?=
 =?utf-8?B?U0RBT2NiM2VRWk5GbDBqcWVIQTFPdVFpWmRoK0RrS3BtVnBCYndkY055ZWln?=
 =?utf-8?B?Tzl2NzE4K0pnZHZ4UWtySE1oT0ZLR3FwWlFTWE93SVVQeWtGbzVuSEVYb0Rk?=
 =?utf-8?Q?93F3dVn3oaxlMtWBWz1YH5O0d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf4d18-5172-4a2f-1daa-08db70e08f4c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 16:16:38.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tOWcEG4jS5G53YmG5QbCVnPGx+WBuR7ziAxIvryryaiNAH5cEsO6LiPyY96nvh2yTL585lsyCPu54MODGX1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/15/2023 10:01 PM, Kai-Heng Feng wrote:
> On Fri, Jun 16, 2023 at 1:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Thu, Jun 15, 2023 at 03:04:20PM +0800, Kai-Heng Feng wrote:
>>> When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
>>> enabled for that device. However, when the device is plugged preboot,
>>> ASPM is enabled by default.
>>>
>>> The disparity happens because BIOS doesn't have the ability to program
>>> ASPM on hotplugged devices.
>>>
>>> So enable ASPM by default for external connected PCIe devices so ASPM
>>> settings are consitent between preboot and hotplugged.
>>>
>>> On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
>>> pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
>>> pcieport 0000:07:04.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
>>> pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>>> pcieport 0000:07:04.0:    [ 7] BadDLLP
>>>
>>> The root cause is still unclear, but quite likely because the I225 on
>>> the dock supports PTM, where ASPM timing is precalculated for the PTM.
>>>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217557
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>   drivers/pci/pcie/aspm.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 66d7514ca111..613b0754c9bb 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
>>>                /* Enable Everything */
>>>                return ASPM_STATE_ALL;
>>>        case POLICY_DEFAULT:
>>> -             return link->aspm_default;
>>> +             return dev_is_removable(&link->downstream->dev) ?
>>> +                     link->aspm_capable :
>>> +                     link->aspm_default;
>> I'm a little hesitant because dev_is_removable() is a convenient test
>> that covers the current issue, but it doesn't seem tightly connected
>> from a PCIe architecture perspective.
>>
>> I think the current model of compile-time ASPM policy selection:
>>
>>    CONFIG_PCIEASPM_DEFAULT          /* BIOS default setting */
>>    CONFIG_PCIEASPM_PERFORMANCE      /* disable L0s and L1 */
>>    CONFIG_PCIEASPM_POWERSAVE        /* enable L0s and L1 */
>>    CONFIG_PCIEASPM_POWER_SUPERSAVE  /* enable L1 substates */
>>
>> is flawed.  As far as I know, there's no technical reason we have to
>> select this at kernel build-time.  I suspect the original reason was
>> risk avoidance, i.e., we were worried that we might expose hardware
>> defects if we enabled ASPM states that BIOS hadn't already enabled.
>>
>> How do we get out of that model?  We do have sysfs knobs that should
>> cover all the functionality (set overall policy as above via
>> /sys/module/pcie_aspm/parameters/policy; set device-level exceptions
>> via /sys/bus/pci/devices/.../link/*_aspm).
> Agree. Build-time policy can be obsoleted by boot-time argument.
I agree as well.
>
>> In my opinion, the cleanest solution would be to enable all ASPM
>> functionality whenever possible and let users disable it if they need
>> to for performance.  If there are device defects when something is
>> enabled, deal with it via quirks, as we do for other PCI features.
>>
>> That feels a little risky, but let's have a conversation about where
>> we want to go in the long term.  It's good to avoid risk, but too much
>> avoidance leads to its own complexity and an inability to change
>> things.
> I think we should separate the situation into two cases:
> - When BIOS/system firmware has the ability to program ASPM, honor it.
> This applies to most "internal" PCI devices.
> - When BIOS/system can't program ASPM, enable ASPM for whatever it's
> capable of. Most notable case is Intel VMD controller, and this patch
> for devices connected through TBT.
>
> Enabling all ASPM functionality regardless of what's being
> pre-programmed by BIOS is way too risky.
> Disabling ASPM to workaround issues and defects are still quite common
> among hardware manufacturers.
I think the pragmatic way to approach it is to
(essentially) apply the policy as BIOS defaults and
allow overrides from that.

1) Leave a kernel command line option that will force it
off as a "big hammer" for problems.

Remove other ASPM related kernel command line options.

2) Direct users to use the sysfs knobs to override on a
case by case basis for devices to aide in development of
any quirks or new policies.

3) Add quirks and for things like VMD.

The external devices I don't think we should have a blanket
policy.  What happens when you put a faulty device into a
USB4 PCIe enclosure?  I think this will be a recipe for system
instability.

If the i225 PCIe device generally contained with USB4 docks
is known to behave well with ASPM, how about just quirking it like
VMD would be quirked?

