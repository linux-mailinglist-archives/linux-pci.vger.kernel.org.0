Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3E7BA97C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJESwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJESwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:52:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35593
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 11:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJdzP0ykwotq5dQX/LifzdWeoyxC9Zld4uZ0IAw2DLr9mvhwq9z/QYyxi6uUQo2koVhoH7PZ2IhEpqNBEGny7qsLath3W9JG6AFyKDkwYzq9D3tzPCwgWxoXeaQvg7Go9jl7+cKn7QwiGzvTlWiiqqHAXoZKhfwfOVRlKaxxtmAklKa96A8HZZSZi8mpIfY3tSlPsUNFP3eV7H6rMUDX5iowQoAU5XoUYJfYtzqDeTBgW++ca37mD5S1uI/CtoCDxerXy0gEiaqJFpSOYbbBQQPRBR5aiBIt/yDvKE2ZcystuMV8PxXx+nR/hIYzgHouZ54Or9EUBrguQK06oDZ4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaUvZ1WlqMRhHWiB3AZUWXfCsiKUo8mGaMhqCXzxQKw=;
 b=i65pDmFXIF1jWx3uYBo04R2OGnt4rhmp8cdXtnI7lzsEHhMzh3knjC5PI0dOfAldclWgpqwDewrmG5jLat4Rk0pnbAJ9UvBFVSIUXeO/xQAm+PYrCHKMPI3ocChr57fi4+Cb7HUgpbqbdT3X8EsCFQ7q0TOn+k8uGlvzUfRrSqBaj93b1FCk0rLM/PKANfWRBwyjGKIz46DpO663FWz9Lx6qNVaMHNnBMljEVb+30ES40Myh7TvWUjMdL/8V7nPp9CjgBuVqSk2eR0TTlEoC15liUlkbdvxd/QOwZ46LgEj52qtFI3zCMWN3O1sVwezOWQ3EC3IyL2N6R2A5IhrXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaUvZ1WlqMRhHWiB3AZUWXfCsiKUo8mGaMhqCXzxQKw=;
 b=uGvvC2mZ2S2/aYi4SIHJAXDNBf1nhXwhM2xVZV/K3CEk7jtsUkMHYxs2rtwwc4figHLu0UJyTEwSjdKrJpfv6wNNit3Du+BENNLczzrcTM9ADSLMydoLALCAp8Nt8MLNvECa29xb8xhfH80Dd/5+5116fHvpabnrADZ+cxnOrEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 18:52:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:52:37 +0000
Message-ID: <6c02ad76-b205-40a3-9405-dd03e252414b@amd.com>
Date:   Thu, 5 Oct 2023 13:52:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231004144959.158840-1-mario.limonciello@amd.com>
 <20231005181440.GA783423@bhelgaas> <20231005184730.GA11020@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231005184730.GA11020@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:806:24::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9be8fe-1d72-41a0-4775-08dbc5d43e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c76Ammpemf/frN8FuMk1bMNyQ1xQPAq+sWte3Lp35OjbflRWdZVwRzR3PPqR4djZMVo0yRY/8aae7qy25UmaA0wCCwrcp0oEtj71LR2lGVpgqwxd1u3tCqU1UYn/qrjVO9vMiPV6+Xby302LFm5+jG0h0x1/qHpfEXIXJfeScjgfvx0dvpSrayclFJ5vM63I5pQ/hPzSUevK46jt+DdwzKUJcBCuD8ESnMou/DtOAUQCCoPTjZEhgn6ht1cfBzVbMjIP/OhNrKrxELT8+VuM0+lS6oTIuFNTYJ2FDyRoZBjTe11/0nHSxftaP9Y86ntiHuGiTX2d1+LLFOvHzc73+XB9LO5+HSvOFTzWW3S0ZrB6uCpaepestXxoeHhi5anYvh0qJY5tx7khtqCsybbekBwD1PT+jk3A9NAUN8gyJ97H9HS8F+ihowoClRBu4X+8iCiRtR/t+BnnnzrMNfwNJhPt4YSTLGybG7FB1oai56F+Z4OmneC03wKYHlimTWr5NJ1nAbUZa/+gDUR1bo1jjjOAhvTR+YwbuD6lRFvx0j3oqZuMngT1Colr5f0y5xJYfbjxst8qrOyR1pOBYMtp2qOGMOaO/ohSZz/2IKsol1kVOTQSgz9p7UC5mHVjuAmuud7ZMau2yzuGHtYUn7dx0j7sl4fIjCQLKw2YQvXv63P980Nm9/5OHk5jS5+XvKibRWChpaLoPJtbCcC8TRdA2L7QK5429waRSkYM6DIWmLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(15650500001)(2906002)(31686004)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(66946007)(316002)(66556008)(2616005)(66476007)(54906003)(110136005)(66574015)(26005)(36756003)(6506007)(6666004)(53546011)(6512007)(83380400001)(86362001)(31696002)(6486002)(478600001)(966005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpDcXF0MzJVUktEWDRxVWR4dVliNGNjWEMrcnRYbXZTYk5RaHpoanBicnRs?=
 =?utf-8?B?UWsvUHRSS3lGYU5QZkN6Ujl1TE44Z1V1NWI2WEEyYk1ScVVCbEM1OVMxeSt1?=
 =?utf-8?B?TTgrNTM2L29GNDJqKzBFSmNxelZxUmtna1Y0WTRZRlNUcTBqZCtPdWNZTWIx?=
 =?utf-8?B?b1JYUzF2cDB6SW5tWmp2cmQ5SkNqYnhqc3ZmcnNicmdPQ0xwaVlxL2ZGZ25y?=
 =?utf-8?B?WXRnUFc2aWV5dGlJbEtvNytGUFpqNEdIN0M4dGM4bTNzRkNlbXVLdnZ0RnBl?=
 =?utf-8?B?bnRhRVlzV0U2WDRacWw2UFpYVHYvNTZKUjNqQ3VCOGlOY2V0K2xzSEx0QU0y?=
 =?utf-8?B?dmhNVVRYSStLWTU2SzFJcWVxMmpCcmN1SXl1SitvM1c2T2JQNytmbGRMdlFa?=
 =?utf-8?B?QmYvUDVJZ1hBbHlHeUxiSUQydGlKVVZoQ1N0eEhHbmc5bE9XeXlqcjBPbHg2?=
 =?utf-8?B?RHFNQXFIYVZGK0RSZ0paYUZlOUFLQVc3RG5BZ00yY2dGeXRjVkFMbWl4SHU4?=
 =?utf-8?B?bkcrQUpqWDB5dWZieEgxRStuVHBCUU1hMmxRd3BvYUpDajYvRHZzdHZ1NndC?=
 =?utf-8?B?aVllcXkvcnNIdTVTRVZPUEpaS2M0aWZJZm9EbExlek9mQUVONzVwU0tuVE9S?=
 =?utf-8?B?emVFN2wyN3J6S0RWOHk4M3VKSld2ZElOUENCTEJxK1F3dTBHdTF2bkpDZGp2?=
 =?utf-8?B?R1lVeGRhb2FiRGhmSTY5cm1RaU16cDkxaVpNa3NCd2ZES3ZVeUZ2ck52U2gw?=
 =?utf-8?B?c2cyRUFSMVkwWUY0NzJZTWVZdmdndmk4UEZVcnlTcGpobFB1Zzg0azE3UjQy?=
 =?utf-8?B?eGxCb3FFV1pMMEE1UElnSDNuaDRiZlFmeTZBWE0wMHBDNXRFRjN4bW5SNkhE?=
 =?utf-8?B?Tlk0SUJPaytmNTNpSTIvdTFISzc1WExuZnJUUGlJWkZWNGxkb1RkSDRSelJR?=
 =?utf-8?B?KzJFK0lNd2xSYnFUOTU3OHNRZThkRDY0RS9BWjRaLzlzNXNOMDFVVHlEeFFK?=
 =?utf-8?B?RUxqc1BzUm9JdlRvbFAxemtkNGdvZVVzc0tLOHBFZGR3dEtCaE5iZTJ3MXBt?=
 =?utf-8?B?Zk50NmkvUzdnUjNUM0oydjI3L1dEMFI4ODdYeFRLRDBmVmhTNEVTZDA4ZkZn?=
 =?utf-8?B?ZERLTS9tRW4rNnhqeG9Xa21EcDdoY2pkWFh1aWwwSWQ0NjNyRjU2bklUZ1hE?=
 =?utf-8?B?V0twN0ZLOWZ4eGNhaTJHakQybnJ2R2V6QnN3aTdabHlEUVo5RU5oYlF0OXZa?=
 =?utf-8?B?RlU0eGdIeTZLTFVJWGo5NlJtK1prMHgxZzY3VHNEUWJqOG45a2U2M09yS1Rv?=
 =?utf-8?B?VWs5UXlsamo5WUNIN3FjSUhpKzcxN2NpeFE0ajNvN2cwc1Y5TzE3OXlTalFX?=
 =?utf-8?B?blYrVytHaU5XNVptZnUxaTV2cld2dkdkcmg2VjRIVDd6YWFzVFR2L1B0S1lz?=
 =?utf-8?B?Y3E4Q3Y0TTV1TDdWRWtPY3dIRzFjU093UmZZY1JBTWVlVUNXeHphQ2hLak53?=
 =?utf-8?B?MWF0bm96cmRqb0tLTCtuTGRzZnVhMVVzWHcvaktRUGJhdlZTUlJCeURINzk4?=
 =?utf-8?B?by9BT0JZYnJNcVlXa1Q4cm9IY3gzNkZXaVZNSDZEL3F2TVovNlcxK1ZIaWFp?=
 =?utf-8?B?b1M5SVBwaXB4Z0dyeW1CKzd4Tk1vZ1dhNXBxR1ZBTC9YdmVXSlBEL3M5YjBF?=
 =?utf-8?B?MkhKUjMwTFJHZzh0d2lSeVpyMVpDSStDcW5mdFU1ZnFaVGVFcXQ5dHdyaE1J?=
 =?utf-8?B?SHF1WXV4aWIyMDk2QnN6UEljdTc1RnZlSFlVK2x1Nis3UTc1dU5tWlc3R0tD?=
 =?utf-8?B?TWFnZUtUemp1R1V3QnZBdUlUSjFCYVFhb2xEeDlkeXN0OFZrejY0aW5EaWpT?=
 =?utf-8?B?OVJBeHBSRXhjZGkvbmRxbmF0TU1YMGNkWjZ4Q0NSWXhqMU5CaFMyUnc3NnZ6?=
 =?utf-8?B?T2VNSUwvRmNHb24xKy92M3lML0RzUE9hZHNMVmdFZVZRTkZoc1F3L2hrWm1h?=
 =?utf-8?B?S0hkYUVDK2liRFBkdjZSdXdmOUZ1NWdHaTY4UEN2K2ZOUVhTMDc4a2o3MUNk?=
 =?utf-8?B?UEh0c0NncVpvVlRpUU1KYlZ1SWF1NHZkOWJUVkRSM2VFakpnMGxJTnhjaVdX?=
 =?utf-8?Q?oDivhg4UMSBqtRS+NB8Q5T/82?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9be8fe-1d72-41a0-4775-08dbc5d43e3f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:52:37.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+e8GfMHTIx2QIMJ3Ly7/O450yjs4Zn4Ja8CvTrEqZfjcakyix6USWjJNhT7+gAOkUrdljujDgfV8LVFk6WO6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/5/2023 13:47, Lukas Wunner wrote:
> On Thu, Oct 05, 2023 at 01:14:40PM -0500, Bjorn Helgaas wrote:
>> On Wed, Oct 04, 2023 at 09:49:59AM -0500, Mario Limonciello wrote:
>>> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>>> suspend.  This occurs because on some AMD platforms, even though the Root
>>> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
>>> messages and generate wakeup interrupts from those states when amd-pmc has
>>> put the platform in a hardware sleep state.
>>>
>>> Iain reported this on an AMD Rembrandt platform, but it also affects
>>> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
>>> generates the PME. To avoid this issue, disable D3 for the root port
>>> associated with USB4 controllers at suspend time.
>>>
>>> Restore D3 support at resume so that it can be used by runtime suspend.
>>> The amd-pmc driver doesn't put the platform in a hardware sleep state for
>>> runtime suspend, so PMEs work as advertised.
>>>
>>> Cc: stable@vger.kernel.org
>>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Applied to pci/pm for v6.7, thanks for all your patience!
> 
> One belated thought I have on this is that it might be a better fit in
> arch/x86/pci/fixups.c rather than drivers/pci/quirks.c.
> 
> The latter contains quirks for cards which could appear in any machine,
> regardless of the arch.  But this seems to be specific to x86 machines.
> I understand these xhci controllers are built into the SoC.
> 
> We've had complaints in the past from developers working with
> space-constrained Mips routers that the generic quirks in
> drivers/pci/quirks.c occupy too much memory:
> 
> https://lore.kernel.org/all/1482306784-29224-1-git-send-email-john@phrozen.org/
> 
> To cater to their needs, we need to keep in mind that arch-specific
> quirks are kept outside of drivers/pci/quirks.c.
> 
> I apologize that this didn't occur to me earlier.

This seems like a bigger problem than this quirk.
On a 6.5.y checkout I have on hand:

$ cat drivers/pci/quirks.c  | grep "VENDOR_ID_INTEL\|VENDOR_ID_AMD" | wc -l
412

Maybe we should move it all as a later follow up?

> 
> Thanks,
> 
> Lukas

