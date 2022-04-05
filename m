Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7374F471D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiDEU7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457743AbiDEQir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 12:38:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D265D4451;
        Tue,  5 Apr 2022 09:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTlxJuNHC/O/8/LRMT5R/eqi9av0BlINycJmv7uqmN10VtOWlFNBo068GLgVsqUVVyKsmiZIRou6PtMEfaTLsn8I48ZQVwEk193lZcbMITg18kl2bnk6MaTmyHC21wkan9WOf42Sg0CYl1J1BVLfI9A8Olg6Qi8DrZ1JQMK9tkhGpF56yfJ0fen6Zu83E9un/dlt+f1Q4nmufddNi3g1PA0gY3Tu1T6WnF8GcTfvRD/UW1G7DL/9t5o5En+DUpbyNt+T3s5rZbXjZP42ZCmjUdOtzAM5RpOcy3RxLtrc10dVmQN49gRLDM2sDaP60ghnbj00IbkAlOIKYftb3/lLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6hVGc2gU/a9KMJpvw+RbZvm9Vumy07Yh1x3RM2Y+1g=;
 b=L632ZsQhnFtHV0QmhZhDK+n1JZPOQ1nsRo7QNR2xSOAEFtsu6T5PZezGNfJ6sLGMv04ibujxiD4DyZMG3/Lo+AxBGMGOXE/KrlmhDWjlh1I/SIGCw6JiddDLTqscYjRWF+mu9wOJrdBFt7R7iYSejbWvpXknShhIJtw8bM+kVuP/NsxSswY2UtcGDVLkO9UEBMUkzb0JsSUwGk4yM/tJm6JQb21jLqE6rYkBJFck+Lo5eSvnTQ3B9fg3XMNwyFTBFQMAr2BqkXtZJDyQxRSDDlrcmN4efcQ6yzxCR6jfz93Mg47wO/+aQBV2l+w/1nMB7IF3Z8nVJDLtkX3H7Cx8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6hVGc2gU/a9KMJpvw+RbZvm9Vumy07Yh1x3RM2Y+1g=;
 b=F+nxGy80Hfx3kd2GUG6cljsO5fl2FEULm5Dh296yiqINOrOYgNqEBkI918Zom+ZW+hPU1Yp58J4VbxXjI4ku8sTFNsuN4pe4M1nolx3UWAiVfkdRQ1o59pc9QoN6QO8heWtH60xaXW+wXBMx3dOLH3vqvxdL5FIg96icsXgIWKELgYqtC6y2/AVe+oi4vEm7EoSaXjEeDasFJTn1fDb6t+U9beqx9jGyxjiap23JAtjxfO0NBKEPs0+TqAh62Gba9zjSzib6/I791Rk8YXQwPusz8zb5SVGZqFjwyN7+EU025lLwGeF73gcFDumpd3G8sbeQBPX+7q7cyKUooj0Jfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by CY4PR12MB1701.namprd12.prod.outlook.com (2603:10b6:903:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 16:36:46 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::d1ee:362f:4337:d03b]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::d1ee:362f:4337:d03b%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 16:36:45 +0000
Message-ID: <469a9db5-9868-cb17-dd5c-96ef29193fda@nvidia.com>
Date:   Tue, 5 Apr 2022 22:06:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Content-Language: en-US
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220204233219.GA228585@bhelgaas> <2249802.ElGaqSPkdT@kreacher>
 <8f89131c-41a2-02e4-1427-8a5b1704e0ea@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <8f89131c-41a2-02e4-1427-8a5b1704e0ea@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::21) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82ce7464-f157-40a8-ff49-08da17227928
X-MS-TrafficTypeDiagnostic: CY4PR12MB1701:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1701BC0CE58E85EF5B428FAACCE49@CY4PR12MB1701.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUw6MXSCqf7aZrl2PAc0WuAmB0wQWukyIqv8L/X7HhDxVR3CBp1tSB1o8UZi7EbwZuQGVvD1iVcyX8h4w7HLIrDq35EJjjSS3n5+7E5/vfGpJU12mzUei1k6p6yA0a9ZM3d5fjHSSHTfx+rMgmBkixUuwVGWPRO5CRlspVwsETwfWiAWW/7BKgJL6J8QxVYXfTrxndcITQ6wCxul+GF6x8v8YB1gXuoEM+GN4lYiwxBwr5rxk1rmN6MJFxW/hCI/YWm+Nhz/Voi45p5Vs8T89N68kaGmzkPocSS74IG/gCFGfCE+XovrgolsOmqUNxQqrmADdUjk3II0dFvnZlS9wGP5oL609SalLmL+QleqZFta7n94tNfYb9y5vHQLCphlSeOFsDJq0JOTvf6xhi3xrLsY4eDq07ufyhxeyFlYhIkhhLeQ/0qG8FswQBVSGjGlmZQ5pMOy9knrbBPHUX1xm2JdCmvHnb4xAZI3ya8tz9twUXGcJ1o+zLojIPB6LLPDdN+Rh0ZtHvcte9vxkYQwEiAX9zNDr4vmSCNuajmMGhFKQEDF7yRgkg0IXuh8s0yKGDtyFaTtdJhVPJ1jjqq0uibYUasLsUQCg4dkMIqt0d0mn69xROd2tnMI6kT+CithRovOKHZq8LfIL39jO+Lo5wEn8GB+J3WqNYOwE1Gy3L3055e9NhM6jjiwYaxtw5fehnBaqSxCOzQ0pcASoSIQjuvPCKpEK3C3lTpCZhhDzcIOSwo4LBbZlFV/WSLSvLAb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5304.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(26005)(6506007)(8936002)(53546011)(6666004)(31686004)(6512007)(110136005)(186003)(36756003)(54906003)(2906002)(2616005)(55236004)(6486002)(83380400001)(86362001)(508600001)(316002)(38100700002)(4326008)(66946007)(66476007)(8676002)(66556008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXdkUGdnN1BJQXRqajRyT0dZdUlXQUZoZFF4Z2VYelROV2owYnZ2eWN3c1pP?=
 =?utf-8?B?VnNQQVlLTlB2RVoxYUFmVXJwbDhTVTNuKzhZeUZTUXg3OFRhUnBsb09UNllD?=
 =?utf-8?B?WEloSDIzcUxmOHg3anYxbGtCVXFNVVFmMDFCWlEvREQ0bFgzZktoTUxZTjlr?=
 =?utf-8?B?Yk1IcWVJWWJJU3h0bGNnWUVESXE1NlFNZXF5enFVMVJuWVdZbGU1WlplOWRH?=
 =?utf-8?B?TkYvRkt5MEJqWWdWclZwdTZxblM2VGJReEhFS3Zwc0RSTG9nTW8zT3Z3d0pq?=
 =?utf-8?B?Y3dqaFNFT252NTRXcmgwMFEvNHgzY205WjgwWnBneVFsQzJKQ212T0l5TnY2?=
 =?utf-8?B?UnAzZkVZNmkvbTAyQ2ZoRnpsdXRWMWw2TzZDeEZPVDlkRWNlNE54RmExTkFU?=
 =?utf-8?B?amZ6aWwzVWQ4Tkl3SEpva29yVmd1UFBGUmZrcDFhYndRa2gydDVrRHFwVDYx?=
 =?utf-8?B?UzkyQlRlSDFHS0NuZDQ4SFMwaGlWcU5IcDFtK1prTjA0MlZ4WDVTYUtWQVVF?=
 =?utf-8?B?Q1FnTDk1UUhYM0drQStyckIvbWlaV2J3U0N5TlQwczNQM21uYThraG9UUzQv?=
 =?utf-8?B?dVZIZkJkTlJqclUycFk3ZjcwYmc4V0dYSXp3eXR6M3NFNHI3VENKTDFNaU9Y?=
 =?utf-8?B?UWhxL2FJZGxWTnpXUDYxa3JSV3pvVEcxRWQ3QWNrS2pobmVFME5MdzM5SDAr?=
 =?utf-8?B?RWdabG8rblRDYTQwbzI1eitZNHRtcHlPclFBUHcwd1RJU3YzR0pPWGU2WEdx?=
 =?utf-8?B?a29rbFU2TTlybzRrdHIyRi9SZnhmL1ZUM2V2YXNBU1IyMm1SNUlPbUljdkgr?=
 =?utf-8?B?Z3FRZnhkSVZmUDd5aDRrS1hhYlYxd2NmMTZHQTh3UHltMnFCNy9QN0lmeUN1?=
 =?utf-8?B?VUtLdDJyWmZwQXQzVUY1OUZOYVZucXZwQ25xcldHbzJYbGVLU3FhWUJRYjdW?=
 =?utf-8?B?ZFJucnlzZ01iSnl2NGtGOWJTakVSZ25tcWxmRERieEtYb2UyN1hSMVZVVFVj?=
 =?utf-8?B?ejduWkltTFZsNUFhR2tTVGgwZGhweFpQWEhVQ2s2blJDQVZFc1RqK29WdFdh?=
 =?utf-8?B?VTVSaG9BNXJiZHY1N05GME1ONzAzd0NMSjJBWlVHcnNISDhWSlpRVzczZitw?=
 =?utf-8?B?elFyQ3NVUTl3VHhrL0ZUaWkycStacXFiaEFnQm9sMnBZTVBJVjhSb3R6RW1R?=
 =?utf-8?B?Y0Y3Q21IRVRNTmdQWlFJMXRvNW51YWhTMDVPd1JRR3UxYUhsVE4veW90MWd1?=
 =?utf-8?B?SndYeHQ2UUFubUVpZFBZUEZJTEdYYm10aFlzaFpNZjhCbTUvSjdhYmh1SE5S?=
 =?utf-8?B?QXFUR1JEVmFZREpSRFNDZWxEQ3ZlcFZNRXJNZ29FSHkzSklJWUNxUlhLcFNM?=
 =?utf-8?B?NGZXdDJjdTF0bVZFcGplWVhEd1ZOa2UrS2VFbWR3M21ibmNWelNnR0NtMFlN?=
 =?utf-8?B?Qzh3NitRQ2swL09kNk9HUm1VQmdUUklvY2dPRVVGVUhkUzFZcFE2Z3Bqdkxj?=
 =?utf-8?B?Yy9jdWtINVBJS0VFVXEya0RkTjdIaVFpdXAxUkFvd1F6QjZkaCs4eGxxTFd3?=
 =?utf-8?B?aFVKUlZVNWFhcno0ZHYxLzRJTm5iaGFWbzYwMncyc0ZSWk1LcjRVVE9KWjZi?=
 =?utf-8?B?MkZEOVVEMTFnU3c5QzQvTitIVzVXS2lyYWdMR1c5SGZlS0VtZjhxdldUY0V4?=
 =?utf-8?B?Z0IzN2FCaFlmY0c4eDNnN1hOYWQ5SWhucGlKK0lXOVFRKzQ5c002Q2N0WWFt?=
 =?utf-8?B?WlAwcEIxSnRtNzZScHJwT01kNXo2M2VxL05sNDdMeCtSZnZCMk51Y3kwUWp3?=
 =?utf-8?B?UE5oczN6SG04Wkp4THA2aXQzOC9uVkRETGd6L2YraFl6eGN5bUd4THZhd0dK?=
 =?utf-8?B?dElUQkJ4WGRPRXQyWUFiczV4RGtOekNSbjFxbElDd0tpUU1tTTFoVUNrMWRm?=
 =?utf-8?B?ZkZtR2ZvaGs3Nk9wNHpSYjNDdzNRVXM1U2ptYjNncUpPbUc0WHN0RWdLUG1s?=
 =?utf-8?B?RWtPTG1FQzZyc0NCVmhDWnhhTXBpOEhLVzE3WFNEYUdDMk9CR1FDNm8rWjl4?=
 =?utf-8?B?VCtXOHQvVkdqZk5IQ0tCa1hDOW03RXE2M0xBeG5tYTBlVkdIOFlPZ0FrL3hv?=
 =?utf-8?B?eFBhdTliL2JPeXdKQW8rczJYYzhLRlAxc2xnR2NDSkU4SFBiM3RKNk1HeEUy?=
 =?utf-8?B?Y0Jxck5CeHc5RmNHbWpBZzAzZVk2RzFGdVRqZFBvUTgxNDZLZmR5aGgyQzYz?=
 =?utf-8?B?TVA3aThsdnZMTXhwV25vVEE2UEY0blV6Q3pYY3p3bmRPTUw5OUhnMWloQ1ZI?=
 =?utf-8?B?eXRoY0tEZURiSWJJSURWOWNQbTZpeVU2eWl4V2dVbjUrbjRYS3dXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ce7464-f157-40a8-ff49-08da17227928
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 16:36:45.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fwqb07wyb+2V42gxNnSl+8jQ8oguYAImqycJVB9lOb0fbybe0LYCzAd+Ku+zP3+R5bxLV5HyMAYOM0Ag4U5KAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/8/2022 4:00 PM, Abhishek Sahu wrote:
> On 2/8/2022 12:28 AM, Rafael J. Wysocki wrote:
>> On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
>>> [+cc Rafael, hoping for your review :)
>>
>> +Mika
>>
>>> Wonder if we should add something like this to MAINTAINERS so you get
>>> cc'd on power-related things:
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ea3e6c914384..3d9a211cad5d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15422,6 +15422,7 @@ F:    include/linux/pm.h
>>>  F:   include/linux/pm_*
>>>  F:   include/linux/powercap.h
>>>  F:   kernel/configs/nopm.config
>>> +K:   pci_[a-z_]*power[a-z_]*\(
>>
>> It seems so, but generally PM patches should be CCed to linux-pm anyway.
>>
>>>
>>>  DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
>>>  M:   Daniel Lezcano <daniel.lezcano@kernel.org>
>>> ]
>>>
>>> On Mon, Jan 24, 2022 at 05:51:07PM +0530, Abhishek Sahu wrote:
>>>> Consider the following sequence during PCI device runtime
>>>> suspend/resume:
>>>>
>>>> 1. PCI device goes into runtime suspended state. The PCI state
>>>>    will be changed to PCI_D0 and then pci_platform_power_transition()
>>>>    will be called which changes the ACPI state to ACPI_STATE_D3_HOT.
>>
>> You mean PCI_D3hot I suppose?
>>
> 
>  Yes. It should be PCI_D3hot here. 
> 
>>>> 2. Parent bridge goes into runtime suspended state. If parent
>>>>    bridge supports D3cold, then it will change the power state of all its
>>>>    children to D3cold state and the power will be removed.
>>>>
>>>> 3. During wake-up time, the bridge will be runtime resumed first
>>>>    and pci_power_up() will be called for the bridge. Now, the power
>>>>    supply will be resumed.
>>>>
>>>> 4. pci_resume_bus() will be called which will internally invoke
>>>>    pci_restore_standard_config(). pci_update_current_state()
>>>>    will read PCI_PM_CTRL register and the current_state will be
>>>>    updated to D0.
>>>>
>>>> In the above process, at step 4, the ACPI device state will still be
>>>> ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
>>>> invoked.
>>
>> I'm not quite following.
>>
>> I'm assuming that this description applies to the endpoint device that was
>> previously put into D3_hot.
>>
> 
>  Yes. This is applicable for endpoint devices which was previously put
>  into D3hot.
> 
>> Since its current state is D3_hot, it is not D0 (in particular) and the
>> pci_set_power_state() in pci_restore_standard_config() should put int into
>> D0 proper, including the platform firmware part.
>>
> 
>  The pci_restore_standard_config() for endpoint devices are being called
>  internally during wake-up of upstream bridge. 
> 
>  pci_power_up(struct pci_dev *dev)
>  {
>       ...
>       if (dev->runtime_d3cold) {
>         /*
>          * When powering on a bridge from D3cold, the whole hierarchy
>          * may be powered on into D0uninitialized state, resume them to
>          * give them a chance to suspend again
>          */
>         pci_resume_bus(dev->subordinate);
>     }
>     ...
>  }
> 
>  For the upstream bridge, the above code will trigger the wake-up of
>  endpoint devices and then following code will be executed for the
>  endpoint devices:
> 
>  pci_update_current_state(struct pci_dev *dev, pci_power_t state)
>  {
>     if (platform_pci_get_power_state(dev) == PCI_D3cold ||
>         !pci_device_is_present(dev)) {
>         dev->current_state = PCI_D3cold;
>     } else if (dev->pm_cap) {
>         u16 pmcsr;
> 
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>     } else {
>         dev->current_state = state;
>     }
>  }
> 
>  In the above code, the current_state will be set to D0 for the
>  endpoint devices since it will go into second block where
>  it will read the PM_CTRL register.
>  
>>>> We need call the pci_platform_power_transition() with state
>>>> D0 to change the ACPI state to ACPI_STATE_D0.
>>>>
>>>> This patch calls pci_power_up() if current power state is D0 inside
>>>> pci_restore_standard_config(). This pci_power_up() will change the
>>>> ACPI state to ACPI_STATE_D0.
>>>>
>>>> Following are the steps to confirm:
>>>>
>>>> Enable the debug prints in acpi_pci_set_power_state()
>>>>
>>>> 0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device
>>>>
>>>> Before:
>>>>
>>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>>> 0000:00:01.0: power state changed by ACPI to D0
>>>>
>>>> After:
>>>>
>>>> 0000:01:00.0: power state changed by ACPI to D3hot
>>>> 0000:00:01.0: power state changed by ACPI to D3cold
>>>> 0000:00:01.0: power state changed by ACPI to D0
>>>> 0000:01:00.0: power state changed by ACPI to D0
>>>>
>>>> So with this patch, the PCI device ACPI state is also being
>>>> changed to D0.
>>>>
>>>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>> ---
>>>>  drivers/pci/pci-driver.c | 14 +++++++++++---
>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index 588588cfda48..64e0cca12f16 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
>>>>   */
>>>>  static int pci_restore_standard_config(struct pci_dev *pci_dev)
>>>>  {
>>>> +   int error = 0;
>>>>     pci_update_current_state(pci_dev, PCI_UNKNOWN);
>>>>
>>>>     if (pci_dev->current_state != PCI_D0) {
>>>> -           int error = pci_set_power_state(pci_dev, PCI_D0);
>>>> -           if (error)
>>>> -                   return error;
>>>> +           error = pci_set_power_state(pci_dev, PCI_D0);
>>>> +   } else {
>>>> +           /*
>>>> +            * The platform power state can still be non-D0, so this is
>>>> +            * required to change the platform power state to D0.
>>>> +            */
>>
>> This really isn't expected to happen.
>>
>> If the device's power state has been changed to D3hot by ACPI, it is not in D0.
>>
>> It looks like the state tracking is not working here.
>>
> 
>  The state setting to D0 is happening due to the current logic present in
>  pci_update_current_state(). If we can fix the logic in
>  pci_update_current_state() to detect this condition and return state D3hot,
>  then it should also fix the issue. 
> 
>  Thanks,
>  Abhishek
> 

 Hi Rafael/Mika,

 Could you please help regarding the correct way to fix this issue.
 I can update the patch accordingly.
 
 Thanks,
 Abhishek

>>>> +           error = pci_power_up(pci_dev);
>>>>     }
>>>>
>>>> +   if (error)
>>>> +           return error;
>>>> +
>>>>     pci_restore_state(pci_dev);
>>>>     pci_pme_restore(pci_dev);
>>>>     return 0;
>>>
>>
>>
>>
>>
> 

