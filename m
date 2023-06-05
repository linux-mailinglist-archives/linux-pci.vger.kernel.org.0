Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9813722EC1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjFESdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjFESdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 14:33:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDECD;
        Mon,  5 Jun 2023 11:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVBJb2QaLZlSEwTH59PqClzrGtz4yn6IQAZs/WxZD5Qso9nzJLi2lchWitTOPr8hfrctxcmQhRmOl/xZWmLvv93bkJw9YcLhiUqlro3E9U6BWAKaIGtDB/R9WagT7q751D/gdxAV5q4x41s/w+rnjtenjdmsQCk4frfnYY+sCfGC9JJ4eX2drBSc2U4vt6yHKUFq+hNslYr6Z2u0z8kNmoVhIcQWNSYZGQQLqtlPNwDBvWzUWW8KWuPZmGWfLkFr44z6IdcQYktdFQ5NtqnL+1Jvlwv8K8inDi8zQJkeCGrigVxOmIUdx1JdCnltnTvsRtsLweGlwpiRCSB2yVmuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kAw3vyZ0CfQLMHch9mrrsjLMFuPGrD/2EBpvs3eEjQ=;
 b=jj24k0VAsBjbtXYKuN59xVq0cV7Yz/kqbjeXnTjjq5qt4X1jtMMiwr6FgkKeJSV1TJRsmtBdduGGfrtn0Al3+6uMS5tjD1bMwo+UMwC8tphgid9y23UHsSm3dCHuHNGaHGCtOX8d2prdUtbrcRsFREt4zY+klYUYJdaAlSSMjxOGXwdCqgDtaUwZNhBLlNR2+znGkcNMPUlMS+KAHEj4cnq9hY/C/QiCGqpuPBB2f4dbSdnTc3nMKvStQw9hjEA4u8IEFAEf5Zy9FWZd2eVzZqNnXxBdRTmd2kYr1n3vGmyHZNve54ZK07Xg5DVSGh79dV3aZqDoB8fWt/IDMEEh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kAw3vyZ0CfQLMHch9mrrsjLMFuPGrD/2EBpvs3eEjQ=;
 b=Ezxj5LAcipiy/NJvVJ7I33lnaHNxb0DVkxTxXk6Q9Vt8l7B0YeRAMfs0mQ4EpMXfqLryQcnItsunx5kBTHxcL0or6Mlxo1TArcA2gryeEjb+d8qaNyDore2gMLnHgxEx9ZhjyzhT/1xPyHFqS6DWwtiFK0j+qgvx4GM7pqQI/h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 18:33:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 18:33:06 +0000
Message-ID: <f8b5ed80-62b2-3a00-d036-08bf1ef6a7dd@amd.com>
Date:   Mon, 5 Jun 2023 13:33:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI: Call _REG when saving/restoring PCI state
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <ZHpPOzT0nm+vddPq@bhelgaas>
 <fda371a2-da84-c764-c809-2a361418b4ef@amd.com>
 <CAJZ5v0gzSitt2zm2fhwkg51ZRUd_1ZBVB8akiUK_cnr8wupFQA@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gzSitt2zm2fhwkg51ZRUd_1ZBVB8akiUK_cnr8wupFQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL0PR12MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7d704b-ee63-4c2b-62ff-08db65f34e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GDlM+VALX+nj8VPY/V7VWduEs+A+f7nZo9QtSgFjgDRdk2Hm1EjGesZxantIOjtS4WBWursLgHCytXV89KF4lgeSOudmCNfbJIFaX7E4s5Pg89eZgccdzQcgMmxvxbIcgVoJhsivQE2uQFGh4fFXH8TB6/j0MueEusgWoZoNKtUof25MK+Vzowpi7vr4h41a7XniYzlN8I5NtZ/Xw9krpePdajP0l3/DtrebFMMpLISyr8t3Nxk7Y0acE0jpPO9S27GgaHFjVFaOzXwlBgvUiBN+ceDzU2ge+A7YjtMlYXeoKU7ox5g18HGO6GRTMQJK8i8kg8PSiLoPBI73t46RUVgbicuz0/i+AYM1FAaCqAq0SES15qKhLTyXpqGfdaJXJGXfh5ui+OaVO5qw1hIVF9OIL6M8O6a9wTlO5pS6y08ufYVwTIpATHA/ZBakjL9Com2rrBi4P4bWKsl12cJ8CgbGEFtCh4oyC1Lm7vvlHn4huPbA2FSt9m8nUujwNowk1UhlO+ykSQ9xrLbpgdSY2mmtQI0Z7KU34kyFYwhrOy8VzqUpLDTieu8Wmbvki9x7Plht071U6rfwh1hP29Tt36PANXjjCRutqjmdOJ6DEs16JiXoDnwA4XpiM7vf1jJqrBgQ2I0mCmpq+YesptwQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(2616005)(26005)(53546011)(6512007)(6506007)(38100700002)(83380400001)(41300700001)(31686004)(6486002)(6666004)(186003)(966005)(478600001)(54906003)(4326008)(66476007)(66556008)(6916009)(66946007)(316002)(8676002)(5660300002)(8936002)(2906002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWlNWU0xRjBCcWNUNDkzOTZzTUlqazZyQlgvRlZuVWdLcWNqTDNxUEZGbmsr?=
 =?utf-8?B?aEFDUjhkbGVZaXY2TTFWU21CRUVvRnBxUkRUMjk5NzN2OFhzTUZYSW5GK0dq?=
 =?utf-8?B?ZTZtWmFWVkFDT0c4UnM0VWo2ZXBMa1haK1cyNVNEYTBrSjRlVk85ditqZ1hH?=
 =?utf-8?B?MGthK3pHN3ZSUUFVWGdsWXdFTjJnUXcvRVdqS092RWwrRTZKUUcxdStmc2gx?=
 =?utf-8?B?ZGNNcXgrZUlvQmtidzV0bWFKYjJxaVdsOExNckxKVWdqMmVXT21EUFZKcGdv?=
 =?utf-8?B?eW5oT0RkU05kdXVZVzlRS043bmZxNEF2R2JSeUszc29IZExGL3E4WFBCSldV?=
 =?utf-8?B?bFliNVh5VE94YlpVd1puekswRDhpWnRvS09GRlNzQU9iZFFRbisrUnB5bEMv?=
 =?utf-8?B?MjJVTk9BSEgzVnlMWE1nc24yWS91eWZmTkErbUZWZ3JWTE8vTG1lSWROSFVl?=
 =?utf-8?B?WG8yem5QYVJrMzcwMkkzT1BVUFZNdytQWXg4Q2JBYUNvOUVocE5jMm9NNTdz?=
 =?utf-8?B?L2M3bFFQZm9XTjdEZFZMYk9PSVZ5NnQxQnlLYXJEWjBTTWJTWlJvczFJYjds?=
 =?utf-8?B?UFp5cXN4T3N6WjZ5N2gyOG5HYUFiYW00NGNsWjVFSlQ2SEFQSnVPdGsycm9Z?=
 =?utf-8?B?MmI5Q3Rmeml3MWxUNkpvTkUxSXN5SFhHbTVqWm5OSjNSRGYzNHovcXBZaFoy?=
 =?utf-8?B?c0FkdWJVTGwzYnZYRERSOWZOU1FaMkxjZ1RhOFNLajdGTS9XRkhNdG9rS3hl?=
 =?utf-8?B?TU1CZ2ZZanRzdzNvdjF2TGwvczZ0UG15VW9sWmNxdUN1SytSeUxiOVUyWC9O?=
 =?utf-8?B?YmhHcDdXbllhOHhZR01tTHlqd09sYnR4QkUva1JrNTFRQUlYZ3ZkRlNoZHY5?=
 =?utf-8?B?cWpZL0dKVERvQVpTRFN2ejhVWWJxS2xxNVNZemRuWFFPM09HQytXU2N0QkFm?=
 =?utf-8?B?cHJpbDBiVGEyRVVLRWdtVkNibzMzZDdlaDYvS0tKNlZWaGtXU29LTFlJSzRz?=
 =?utf-8?B?NHYzbUdOTVlScTRoKy9KV2dvS1p2ZlQ2di94bW9xVENzVVM2Qy9XQmtDQmtP?=
 =?utf-8?B?ZU1sWGptSVhvejJxN3JwT0NJY01ZMnJrUDVGdFRDcHZYbXhOb2VlMEVOUm9r?=
 =?utf-8?B?ejJIY2JCVEFFR1FQSTJPZTR5RTczR1VTMmlBeTNTSnJvK3JJbXFONWVuWnIr?=
 =?utf-8?B?SHJyUE9pdlFJcTZLelVldzlCVExmR3NLLzVrV1RBMkhTbjYxY0lNU1NqMWNq?=
 =?utf-8?B?a1VkRkwwQ0l6WldjbEFlRWhhcnJCUjJNclpUeFYxVmplL2NLTVlDOXp3TlVm?=
 =?utf-8?B?bDEvbFEwY3lPSmxPMXR4aGN0VDVwQnMwNnQwK3BzcE5qa3NHRU1hZ2pIQVdO?=
 =?utf-8?B?czFwelBtUkNTd05Tdm4wOHFyWnkrYlZwS01hVUZycUVOeFdtdzNldlZiWGlO?=
 =?utf-8?B?YXlQN3dXS2Q3VXc0VjErWjUxV25TQkg2bzI4M0EyVm1TKy9wckQ3OFIrN2NH?=
 =?utf-8?B?VXhROHlKM1Q2N3ZPajE3Q3NhT2VVMXBWcS9aODhpMFNibVdXZWREUzl3bElu?=
 =?utf-8?B?RHphckpqT1krdVQ4K2oxbjVmUmdjWE9RYzFITEs1cFpUVGJSR0JGZTFrOEY3?=
 =?utf-8?B?WElDT29ITUM2Vjk1dm5PMGlXNTloRDBMZE9KTWJvcHZ0QjRRTkxONjlVNGF1?=
 =?utf-8?B?ZEQydGlVQnN4bitkZFpRVi9IQk9vN2hoMzlmZVBFWEZKanhBLzd0ZTZrNUdr?=
 =?utf-8?B?NGNTZFYzUjRlN1FZYmJBbjJuN1c4TzVhQ0lYUE1ENjNWTTJwT2VPMllVOGZ4?=
 =?utf-8?B?ZG9zdloyc3FJM0pTS2QraldoTllEL0hPdE5iWmRXLzVqK0JPLzV2d1d0NEd5?=
 =?utf-8?B?bEJEeHovajNQZWtsWVBHUHNhS1ZkYVhJMmh1czhvckhJbVV6TU9lTkRjL2dT?=
 =?utf-8?B?Q2dSUVJvek15K1pnRUxHRERkaG5BaDVabXNHdlh3d0Fhc0d6RVZWaGdydXZu?=
 =?utf-8?B?UUhRZXpiYmlIeHNHY29DaWJVQnF1MUk2SXhROUhaYzNOMEsyTXVFc1VUT2NV?=
 =?utf-8?B?U29pS0ZHU0tjcmxPRjVpUUdPTlZreUMrQ1RkNVZIYXlveGFNODh1WW9JMjRZ?=
 =?utf-8?Q?g9iSJpLbLn9Bo5ZRLnJUwfb29?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7d704b-ee63-4c2b-62ff-08db65f34e2c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 18:33:06.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMO+EWZvIf9JgTj6RJJ63XT+RHPtSaEE84FmVgZi2ZJJjlxLbuPnrt70P3I3CdIll7ZBBMizNix5zEeI859WRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/4/2023 6:30 AM, Rafael J. Wysocki wrote:
> On Fri, Jun 2, 2023 at 11:57 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 6/2/2023 3:21 PM, Bjorn Helgaas wrote:
>>> [+cc Rafael, Len, linux-acpi]
>>>
>>> Hi Mario,
>>>
>>> On Thu, Jun 01, 2023 at 10:11:22PM -0500, Mario Limonciello wrote:
>>>> ASMedia PCIe GPIO controllers connected to AMD SOC fail functional tests
>>>> after returning from s2idle. This is because the BIOS checks whether the
>>>> OSPM has called the _REG method to determine whether it can interact with
>>>> the OperationRegion assigned to the device.
>>> "s2idle" is a Linux term; I'd prefer something that we can relate to
>>> the ACPI spec.
>> It's important for the symptoms of this issue though, this
>> problem doesn't trigger "just" by moving D-states.
>>
>> It happens as a result of system suspend.
> As I said in my response to Bjorn, s2idle is D0 from the ACPI
> standpoint.  It is not a system sleep and it has no special meaning in
> ACPI.
>
> The problem seems to be related to the low-power S0 idle _DSM calls to me.

This particular hardware that triggered this patch can do S3
or s2idle.

Let me confirm with internal guys whether this can reproduce
with BIOS configured to S3 as well.
>>> Maybe a pointer to the specific function in the driver that has a
>>> problem?  Based on the patch, I assume the driver uses some control
>>> method that looks at PCI config space?
>> The issue isn't in anything Linux code "does"; it's in the "lack"
>> of Linux code doing what it needs to IE using _REG.
> So the argument seems to be that under certain conditions the PCI
> config space becomes unavailable and so _REG(dev, 0) needs to be
> called when this is about to happen and _REG(dev, 1) needs to be
> called when the config space becomes available again.  Fair enough,
> but I'm not sure why this is limited to system suspend and resume.
I didn't think it should be limited to suspend/resume
either.

That's why I had put it in save state/restore state.

> Moreover, "PCI_Config operation regions on a PCI root bus containing a
> _BBN object" are specifically mentioned as one of the cases when _REG
> need not be evaluated at all.  I guess the operation region in
> question doesn't fall into that category?

Yes; that's right.  _BBN is only present on \_SB_.PCI0
and the problematic device is on \_SB_.PCI0.GPP5.

>> At least for this issue _REG is treated like a lock mechanism.
>> In the spec it says specifically:
>>
>> "When an operation region handler is unavailable, AML cannot access
>> data fields in that region".
>>
>> That is it's to ensure that OSPM and AML don't both simultaneously
>> access the same region.
>>
>> What happens is that AML normally wants to access this region during
>> suspend, but without the sequence of calling _REG it can't.
> Is this about being unable to access the opregion or racing with
> concurrent accesses on the OS side?
Access.
>
>>>> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
>>>> state of PCI devices.
>>> Please include the spec citation: ACPI r6.5, sec 6.5.4.  The URL has
>>> changed in the past and may change in the future, but the name/section
>>> number will not.
>> Sure.
>>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/pci/pci.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index e38c2f6eebd4..071ecba548b0 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1068,6 +1068,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>>>       return acpi_pci_bridge_d3(dev);
>>>>    }
>>>>
>>>> +static inline int platform_toggle_reg(struct pci_dev *dev, int c)
>>>> +{
>>>> +    return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>>>> +                             ACPI_ADR_SPACE_PCI_CONFIG, c);
>>>> +}
>>> You never check the return value, so why return it?
>> _REG isn't mandatory for any of these uses, and I wanted to make
>> sure that if it does end up being mandatory in a future use that
>> the return code wasn't thrown away.  If you think it's better to
>> just throw it away now, I have no qualms making it a void instead.
> I don't think it can reasonably become mandatory without adding a
> specific _OSC bit for that.
OK.
>
>>> The function actually doesn't *toggle*; it connects or disconnects
>>> based on "c".
>> Can you suggest a better function name?
>>> This looks like it only builds when CONFIG_ACPI=y?
>> The prototype for acpi_evaluate_reg isn't guarded by CONFIG_ACPI
>> so I figured it worked both ways.
>>
>> But looking again I don't see a dummy implementation version for
>> the lack of CONFIG_ACPI, so I'll double check it.
>>
>>>>    /**
>>>>     * pci_update_current_state - Read power state of given device and cache it
>>>>     * @dev: PCI device to handle.
>>>> @@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>>>>    int pci_save_state(struct pci_dev *dev)
>>>>    {
>>>>       int i;
>>>> +
>>>> +    platform_toggle_reg(dev, ACPI_REG_DISCONNECT);
>>> I would expect these to be in the PM code near the power state
>>> transitions, not in the state save/restore code.  These functions
>>> *are* used during suspend/resume, but are used in other places as
>>> well, where we probably don't want _REG executed.
>>>
>>> Cc'd Rafael and PM folks, who can give much better feedback.
>> My knee jerk reaction when we found the root cause for this issue
>> was to put the code right around the D-state transitions, but I
>> decided against this.
>>
>> I put it in save/restore intentionally because
>> like I mentioned above it's treated like a locking mechanism between
>> OSPM and AML and it's not functionally tied to a D-state transition.
>>
>> When the state is saved it's like Linux says
>> "I'm done using this region, go ahead and touch it firmware".
>> When it's restored it's like Linux says
>> "Don't use that region, I'm claiming it for now".
> So it looks like you want to use _REG for protecting PCI config space
> against concurrent accesses from AML and the OS.
Yeah.  When I discussed it with BIOS guys they
explained to me that the BIOS will typically save/restore the
PCIe device BAR when _REG is called (depending on the argument
to _REG).

They'll only operate on the region when it's in the right
state, and they'll restore it as necessary when OSPM would use
it again.

This is also how Windows works.

>> Think about that other patch I wrote recently that controls D3
>> availability [1].  If it was only run in the D-state transitions and
>> the root port stays in D0 but has a _REG method it would never get
>> called.
> And why should it be evaluated in that case?
No matter what the actual D-state is the OSPM isn't
accessing it anymore, so AML should be able to.
