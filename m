Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3677FEA3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 21:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbjHQTlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 15:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354718AbjHQTk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 15:40:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B6359D;
        Thu, 17 Aug 2023 12:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyrbkHGp4XE/+mNCOv49uJ+vfvnMSPjm08/sLKaJGxVHc8eTZdNR5mMhm6pacwhE4cWd7b9V7j+7rDCSOCjztu0UkdvwcQf2S0aLLXihFdY7hr/un4oAxrqi1KY+F90sN1PvaNK/XRkMHDCxgmZpCtIeCiZKD1zQPqqm6YE9arPEyU+xjP8hID8bCCeUdSseyJU2jiX9ugp+ZI7L7zK11JBWAt49q9M0hAylIjZf+3mmMBjs+lVbnSp3IeumGyenW8UbdiQgJ7c+yK5/NbgS5J6cgUvntahRkBcZgi9DryzgoBygPCDe2XWK8g4SK0HiCvGAlpZgd1osGQ5Epm01MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eMVqsOiVSC/4D3d24KVH4vhsbGTL0TmKWio+1xd2Tk=;
 b=MGhsnfFqI3q7z68pvawm7x28cGOTWNRZ5df2JBACnKc3yW0Y4IpXkI7qLTpvN4sGZhE1DlKWWs8a9wgLABPawRO0LCMmBmgFQQYcyfigKT1QxM6ksPNquc70ta9aom2Gev3u2wb5R1fQZslh9+vBs7aYyUTz6DYsAYE8h4COgBmL1Ep+sP4BWX+GFpJaAeedvczTKnhvlBr9cEFnBkRm2jdSodbpvEwjxrZMkPMje38RcQz24z1eHSyvLgAkB2UNCKkDEFQf1eb5aoXJHcGX59m5w/q/jbA2ipcFxl+PuC1I9rVOlznvQ7yRqqvbCK3kHzwcfOuPBDnj6QCggQ3Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eMVqsOiVSC/4D3d24KVH4vhsbGTL0TmKWio+1xd2Tk=;
 b=UugW22bo8NOAFxQ3PF9rD7LI7gNC7H8qeelO+b1U4015CrxGc6jv80UYk2eiodhbjR1IfcCk07xStNtBCbUB2iuzc0RqzSYH7v2BC/unw2eiw7Iv0tIlbBS6F/CoCICF2ktvvhGI4MuF0cX0PZebZaHmAQJOBBFsMkJFydLb604=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:40:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 19:40:52 +0000
Message-ID: <681613ab-a811-41c4-8abe-55780108ad26@amd.com>
Date:   Thu, 17 Aug 2023 14:40:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for
 PCI devices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230817192537.GA322922@bhelgaas>
 <beb88d67-9437-4d7a-b1b0-a763583df17e@amd.com>
 <CAJZ5v0hTJzBkTD64bHmREGymjn2oWPt8y=6bb6WVJm39Jr+ouw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hTJzBkTD64bHmREGymjn2oWPt8y=6bb6WVJm39Jr+ouw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c62f8b9-677c-4129-7ab8-08db9f59dd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lqF4fHklM3SNUtbjJSYPC1WHzleyUGYCUfT78FJobGYLwcL8Gees53L6HpPfFAcz1x9cx2IaPwiB46K1R54BtNd+1OWQbdrdr2JeLykYfi63ZLepZY2jsEoW/hRzENIkHAX9ygKKmO6TBnequ/QwOQvAobYTUk2R6hgymLgOApBpXnaRrDTaLsRxY6fL8IALFDgkjpXeUg5Dp8xpr0Ub/GTz3Qf+PD+TMWRVbkz/UDLN3Fdw5w1LmtSINk1GWRLB1PLX8MT9nokGAkM0oH5IVT8WFnWw2EqNibEyyzwpC+2yJ/3lcQrQbzGZ4KtVQnt/lr9E+HuUcRocPEgbXNaXXR8hjUlVHNj7lOa36KSHsoFNA/XWWmCYUNjozmgKeVQB1zEsV4hQSSlHHlj3c14qREZFzwoESZtk5jnOhEARmCX2u0HqAPz+Kdp4T6BIjXrPW4SWQNxApZekmq2mvv80eRLFVY12m4NtIVa+w0uaUeuMVS5ZVMBn1Yh6FkzZaxfH7xJlXCyjL+pjPw4774y394nLJx6uUpIjf+6bW7tgrEhhEhoqHZ7qtR602UtMdNJmVE02/pwzIRQK6XgrAaLyic5/LR3qOdktm43F7dbbK7+AcgvnCcd9tA2QvboYAoR7jc2q/TtThwcLkxBCQ/jV13pL5rt21DyKZyqhn7OmXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(2906002)(83380400001)(66946007)(66556008)(66476007)(478600001)(6916009)(54906003)(6666004)(316002)(6486002)(53546011)(6506007)(2616005)(5660300002)(6512007)(8676002)(8936002)(41300700001)(4326008)(26005)(31696002)(36756003)(86362001)(38100700002)(31686004)(3714002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmVnbU9xcUc5WUtpZ0VndXpETDBjeGl0YXpiSERNYXRJYTE0bWJmc21IcC9z?=
 =?utf-8?B?N0NrcWlJTkM3YU9qV2tHd0lYU211eGlMbVBjMnJFRjk1aklDY3dDMDZETmFw?=
 =?utf-8?B?dlhEUkl0QVRMTVBRVVFmeU9SK0haZ3R6eC9zZDlqRkhZQTA3bzZ2U1BiV2tz?=
 =?utf-8?B?amtIR2swVzBKL0NLZUdNaUVOY0EzS3BiYkR5Mm41enZsS3RqQS9rUkxtS3Y5?=
 =?utf-8?B?TmRyVEZaM1JVR1dLMnNmWjBkeXZzMzJIQkJ6c2kvNmhTSExxak15RGNDUXlt?=
 =?utf-8?B?THIxQjFSWVl6SWpjKzdOQk1oYXlONWNkZEV3eWF1MlJEeWFnTVRYd2VnQUIw?=
 =?utf-8?B?SnFSTVU1aUtPYTIvdmEyU0g1Qi9EN0xVd3lzY3hBS09CTjRRdHZTZi9pS0Ji?=
 =?utf-8?B?aTIwZTlTOU52NmRDNTIwcmlUZnpEMVFKL1dqaGRVeGpDVklzZlJKd0diR2xL?=
 =?utf-8?B?TE9UREpyOVJZQjVodnZGenRnZUd3aVJ3WjFYYmRENU5DWkhxRFdrbmZjZk1E?=
 =?utf-8?B?aXI2RitSOEVrT0ExbUpES2RQYXR2UXFWV2krbW80MGtwY1FjYXdWZzBxV1Jz?=
 =?utf-8?B?Y0I1N3RHbzFOMHNDYUdJb3ZuS0s0MWxNQjBKNzh0VzJWNUtyTlprbXNyb1Nm?=
 =?utf-8?B?ZFB4U2p5aFd3dHQzZXRhOWRQQ1VGN1B2Tk5WLzAzcFljZkxVMTc3d1VXNFE1?=
 =?utf-8?B?L1lOelpRRVJkOVZTd3Y1VGt0MjJJdkVvbENIbXRRVmJkYjhFZUlWZ09Vak14?=
 =?utf-8?B?aUg2djZQdFJGaGUyYVNXaFMrS0cyQjVHeGJSSEFhSmIwVGtQa1V4Qm1JL3NX?=
 =?utf-8?B?ekNWaStHY0xrTlZUay9yeWxFN1h2MHRjeUFPN2Yza1lQczR1RnZUYXFWc2dB?=
 =?utf-8?B?UFM3dzJNbVM0NnM4Mm5xdXZ4K3ZQd2lkU3g0Y3NKbFJ0NlRTNkd1bW1hWjA1?=
 =?utf-8?B?aGhnZmlidndUcUFSbjIrSXJDSUFZc2k2eTVJaDZ4dUZzN2thdG51NS9jUDZS?=
 =?utf-8?B?M01aejZpWmZWd0VEdUdQT3VXYytVT0xMQ3picE0xUyt1aG5aQmhvcWdhV3pF?=
 =?utf-8?B?WG5NN2FiQWtaaXdsSnlRdTBQYzcyWk8rV0Y2WmE0WnBZU2RFYmZ3VmQxTHJE?=
 =?utf-8?B?UmwyYS9oVnVuOHdNT0RLaU1nWUZYTVBwREdtd01CMytzaFA4c2U2elRPckdi?=
 =?utf-8?B?UlhpSkxIU1FCcVBudk4zQlFKUlJrUGFXYTJvSXBwZDlwMnpuRXNPc2pDb1Jn?=
 =?utf-8?B?OVNKK242ZFV1d1FWQjd1WFZDdjdQSW5SVWNTN09zWnZybFJmdzdnL3pRNlNV?=
 =?utf-8?B?M2ZmQUpENUpLQ1ZoYVJad09hTDNwRm1RZThiUnVvMldkeTh6VUwxZjdWdUZL?=
 =?utf-8?B?aFdvUGxtZTUzdnByZGJxVUFaNk40UVVRZTRHdjRFbzZnWnpBMGhHMVord2ps?=
 =?utf-8?B?Q2FqM3BvZHdYcUlCQUxqM0lRUnRMUDRyT2dmUUdFOVAxMlZjVk9QaFBrWm1X?=
 =?utf-8?B?OXVUT0FZTGtYcEZwNFNENUlzTklFdUY0cTBOZk5FcEVTMG1CVytRMDBKMUtX?=
 =?utf-8?B?WWtPOVZjcENVWllzc2Z6NWpiUnhla1N2VlMxNSs3WVIraTlFbDJkKzlVTCtK?=
 =?utf-8?B?Z1l2MmNmSzZ2TGgvc0s4eFdTb3BQTkpoc1E1TGovQzRRY1YvTlFhQnUydFJi?=
 =?utf-8?B?SzhRUVhPS3M0YmVzdE9GSUJhRm1TM3ZVM2djek9pKzV3enRHc2VRTDJ3Ulgv?=
 =?utf-8?B?RkhmRkF6ZnJHRWx0eVpjaURSeDQwUVRBbTV5Rlk3L1pYd3RTUWwxVlRycFk1?=
 =?utf-8?B?NTZZZm1yYUJObGRFczJkdTdlRE5DNS9MTCtjYk0rSXk4OHgzbkZlMjVsYmhF?=
 =?utf-8?B?SGd5NDVBR2c5dXVwY2xaR0R5V21DOGRMVVZvdEttU0U3SU42RTJTcHZvaUdp?=
 =?utf-8?B?MVlGTkkxck13QitCbkVURnhTV1hneHRUZ1lhV2hGVWc4MFVZMmtLUUJhT0hV?=
 =?utf-8?B?cHFvU2t5WEh2R1BMdkw2QmVEQ3FMSUswQ1dOL3JjeWNqWWl5U0lFYUs5MnBr?=
 =?utf-8?B?R2Z3UnJyNFBOYmJqbWpDZC9CdGxpVTJ3U3Fwd2F1SU9FQVpKNUVHSVVuamZr?=
 =?utf-8?Q?YrupmMENdQuiMrCuLPcThctB2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c62f8b9-677c-4129-7ab8-08db9f59dd9a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:40:52.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2wjGsQbxedlDTUz+Qa9Lp0TAPZ3o3SCMysK3nIdo16X4t8EG9ZwSTRks+wPeRJjp9mJ5ga1AyBcbE+ORQOk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/17/2023 2:37 PM, Rafael J. Wysocki wrote:
> On Thu, Aug 17, 2023 at 9:30 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 8/17/2023 2:25 PM, Bjorn Helgaas wrote:
>>> On Wed, Aug 16, 2023 at 03:41:43PM -0500, Mario Limonciello wrote:
>>>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
>>>> storing a value to the `bridge_d3` variable in the `struct pci_dev`
>>>> structure.
>>>> ...
>>>
>>>> +static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
>>>> +{
>>>> +    pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
>>>> +
>>>> +    if (pdev->current_state == target)
>>>> +            return;
>>>> +
>>>> +    /* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
>>>> +    if (target == ACPI_STATE_D3_HOT &&
>>>
>>> ACPI_STATE_D3_HOT is not a valid pci_power_t value.
>>
>> Based on this, kernel robot sparse complaints and your comments on v11's
>> last patch I am going to split off to another function that returns the
>> pci_power_t state based upon the situation and better comment the reason
>> for the D0 when not enabled.
>>
>>>
>>>> +        (pdev->current_state == PCI_D3hot ||
>>>> +         pdev->current_state == PCI_D3cold))
>>>> +            return;
>>>> +
>>>> +    if (pm_debug_messages_on)
>>>> +            acpi_handle_info(entry->handle,
>>>> +                             "LPI: PCI device in %s, not in %s\n",
>>>> +                             acpi_power_state_string(pdev->current_state),
>>>> +                             acpi_power_state_string(target));
>>>> +
>>>> +    /* don't try with things that PCI core hasn't touched */
>>>> +    if (pdev->current_state == PCI_UNKNOWN) {
>>>> +            entry->handle = NULL;
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    pci_set_power_state(pdev, target);
>>>
>>> It doesn't seem logical for a "check_constraints()" function that
>>> takes no parameters and returns nothing to actively set the PCI power
>>> state.
>>>
>>> lpi_check_constraints() returns nothing, and from the fact that it was
>>> previously only called when "pm_debug_messages_on", I infer that it
>>> should have no side effects.
>>>
>>> IMHO "lpi_check_constraints" is not a great name because "check"
>>> doesn't suggest anything specific about what it does.
>>> "dump_constraints()" -- fine.  "log_unmet_constraints()" -- fine
>>> (seems like the original intention of 726fb6b4f2a8 ("ACPI / PM: Check
>>> low power idle constraints for debug only"), which added it.
>>>
>>
>> Great feedback, thanks.  I'm thinking to instead change it to:
>>
>> lpi_enforce_constraints()
> 
> Don't even try to go this way, please.
> 
> Originally, the LPI constraints are there to indicate to Windows
> whether or not it should attempt to enter Connected/Modern Standby.
> 
> Because Linux doesn't do Modern Standby, it doesn't use the LPI
> constraints the way Windows does and it really shouldn't do that.
> 
> I think that the exercise here is to use the information from the
> constraints list as an indication whether or not a given PCI Root Port
> is supposed to be put into D3hot/cold on suspend-to-idle and this has
> nothing to do with enforcement.

What do you think about me making the changes to pci_prepare_to_sleep()?

Something like this:

@@ -2733,11 +2742,17 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
  {
         bool wakeup = device_may_wakeup(&dev->dev);
         pci_power_t target_state = pci_target_state(dev, wakeup);
+       pci_power_t constraint;
         int error;

         if (target_state == PCI_POWER_ERROR)
                 return -EIO;

+       /* if platform indicates device constraint for suspend, use it */
+       constraint = platform_check_constraint(dev, target_state);
+       if (constraint != PCI_POWER_ERROR)
+               target_state = constraint;
+
         pci_enable_wake(dev, target_state, wakeup);

         error = pci_set_power_state(dev, target_state);
