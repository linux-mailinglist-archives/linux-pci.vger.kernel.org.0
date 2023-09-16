Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94AE7A30CB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjIPOBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Sep 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbjIPOBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2023 10:01:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1404ACD4
        for <linux-pci@vger.kernel.org>; Sat, 16 Sep 2023 07:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWnxxP57lg9lSmrKqpQUpBWZQXZf98aJzmw11NFrGhmkTwDupPRj9bclWKUP4saMmbfVeGovN4W1oss9gnypMzWTsV2ewxZ34Fgp+rpUDpEOi+G9mw72ZZcXDFtzQkTWWHfOezG3BdSQM/EAZcXrW/RefQ0EQZqzC5Liwil7Alc3TDqKc5e8xlj6IqhFUbb+xx/O8vbY9Wv4IhfAXX9thdf/HC9WakaJsTXhKZ7FeBzQ46ixYhF3mtPXat9ORmKfyy1wYAezN4DsMFXByWVAa2GhaoOsuerVHUwRThkK4BSf7O59t+NxVqEOkXfQP/IQPlHVjM3eoJDlJwj50tOsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqzsU6Fqbz/GBpt4ycAw5fg35XiJbPQtN0TNb+wo6xQ=;
 b=NPmHfIVG5DoJD5zcWa7NNA+5tRN9qBnibJbTU/SiAPiWgv0aCCDFsDw52gaAdYwBzSqx5TiEIPoCfKNpsTSLGKJ1IKT0uD3WS3FpBCrYVHXS3vcAVYUNwmC9hRL7L0oJLRKA4Lcv6YAEsfL7naWig3wqKrPQjugGOLy9wLqIjqze3oHbqdD44y4xZrRMcSFE1e3XQ8fiv/3nQhjPJepibSqXKSYTp6opRX1x3scJEVMBpp4w+ATS5Ze2wDVD0mz0lTaB8TMV1eAxPGyG3Wf30yqEbYLgvfqAJ+fuGT3qlp57JuKNZgmclLVDkJBNfUdZEAKJ/tMCNeZXX7d5u5PryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqzsU6Fqbz/GBpt4ycAw5fg35XiJbPQtN0TNb+wo6xQ=;
 b=yNOlBs+7ZStQNwH9aVfgOi8b1dMDI5HV6sprnlFd4AZdwdhYJy7ZOp4T+9bldhl1FOO4OHHbFqx8mrV2mIHrv+V1pIycBdrCnuf8WXyP7jSXQ1CCrzkbi+Wp75OKNdArvVFipl64zBWHVCmhTqC+XmyK3k0OmYDbmLh0tk4alBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sat, 16 Sep
 2023 14:01:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5%2]) with mapi id 15.20.6792.024; Sat, 16 Sep 2023
 14:01:01 +0000
Message-ID: <2cb632d1-a433-4133-b5c3-062c360e0fd3@amd.com>
Date:   Sat, 16 Sep 2023 09:00:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20230915023354.939-1-mario.limonciello@amd.com>
 <20230915023354.939-3-mario.limonciello@amd.com>
 <20230915070802.GA5934@wunner.de>
 <5a562f6b-6e4d-42a1-bbc1-08f7f3279dfd@amd.com>
 <20230916044851.GA8280@wunner.de>
 <a2db379c-b5e4-4ccb-9f5d-15dd94600c84@amd.com>
 <20230916133650.GA26241@wunner.de>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230916133650.GA26241@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:806:f3::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: e4229b2f-72b7-4830-f118-08dbb6bd5b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41+Dx2cy5rkVvdgjOgNSyYhdcvMgOd581h0FXJ46XmMLayWQXO2Sinj+AiuoEp7DY1VnrR+zP7hg+6tHWEUPwe3rppEf/jFmf6K9NANhre/tBHceTFHjQ+8tUOUFLgX+SFclqTj9JjlaPptO4UBdgw8CJyK4AlfLtEiNxoSCJsTfFrFfyzOSN1aShsr4oSc7cMpqFM1ruOuzktlsbHO2Pb4giAnyaEvh+6hDq5ZUzuGUdlr5cGhLD9y8vYtHX73dfrJWN1Zm5N7OoBIHyQEE9B3aEIqXuv2RMaKktEgLJ5+rJHv+ASzOSmeqSqM2sKssvs8f7hf13qmyzcjrl9H3xwXwjT3vUZTnhOHdykNSN41004+cEfn4xGqCBpTvfvjhvZ3NadmzXiXfuZP7flYW884i9nFRZ8NjIC/7/4PPdofif0/FktoA0SuRua8VFKtl3117+T6rGRr4I5jBv2YLQkaplAlqgfzElXVoj+ehhq6vusSh4LeN86Zz+FnBxjoNyFbd+/ci2ZiSCe8dM01PIWHglN8yvgsg7Vcv52j3IPY0ahECwWEG8ln1KoIQttT854/3kDAkaa006Se/Nq+aAEqD/Z1p/og9p/dMNR8sd3O9NVkuvOBHVSApS5yByFtpkBU3XZPS4gRtS8jQ4fzn4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(186009)(451199024)(1800799009)(316002)(66556008)(8936002)(6506007)(41300700001)(8676002)(54906003)(4326008)(6486002)(966005)(66946007)(6666004)(6916009)(2616005)(26005)(6512007)(53546011)(36756003)(5660300002)(66476007)(2906002)(44832011)(86362001)(31696002)(38100700002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFUVDh6K3lxN1h5SzV0anFrNThvMURqYnR4ZXNKUzBkS2NHeXZnTEZhUU9U?=
 =?utf-8?B?blFWOUVWRi9ab0VlUlJBOEtKY2RQYlYwM2Ivcm9XbHpLWXAvOVQ2OElmZWR2?=
 =?utf-8?B?bGhqT2dEVjdIakNQRFRnRlRodUFVTXdGU0RpNTU5Si9FUGJRSXV3SjEyK0ZW?=
 =?utf-8?B?cTRSZUlmaUNrNXdkQ3RmQmc0MGxJWXg3UklEZnVjOTNiT2R5dEVadkFOZUNr?=
 =?utf-8?B?L2VLK3RQL2hoOVhHblBpdkFtOUk4dDJWbVJ2Mml4SFlvSmlQcjJrUlhyWVFz?=
 =?utf-8?B?bzM0a3lwamc1QnZaNmZGYTQyaklVWVc2SnF6OFhITTFkVDdCbEdIeVZ4YjQz?=
 =?utf-8?B?NGlGanRHVk5BZ2trRzVudUZGc0ZCK3JyRkZBZ255b0lNRzlQZU4yendPdmhY?=
 =?utf-8?B?ZEtUUkF4cnk1TWNaZHlmMzVBUDlEbmxEbFI5Q3JBWk5PcUpSU3Z0U2FJOUdU?=
 =?utf-8?B?SGhzS2x1cTltdGRtNllBRWJ2cHNzZTJEYUZrQW9Bb2lJWnhta3ByZ0xHV0ov?=
 =?utf-8?B?dTVKdUFXM2tuZlZBeStjWE04TXhNTjdtaHY2SWxsNXZYUzUxQXdYWE8xaEtn?=
 =?utf-8?B?YWR0QmRNTlIrcGo3ZWQ2ZCtwdWw2TTREeVJMNzdDZVdCbGhJdktudmRpOVpr?=
 =?utf-8?B?TkZRZFc5dHh4dTh5S1M3RFVtL3JlOWRnM2tvcUZuUUFQK014Z2NvWDZUUmhm?=
 =?utf-8?B?eGVHYmVXdkxKM3Ywak81aXdZQXBtN2RwUldJRXF1cVFrcGpjSEszajVxaDNi?=
 =?utf-8?B?Q3pXdGdaWWc4U2kzUXowYUQ5b3JSamVWcDZtZUpobEFtdWlFYUdmeXpEN1ZP?=
 =?utf-8?B?TDYxZGtteHpjY1plYWRyKzNIazhsZDcwL1Npcm90OHpMci9nNjh6SC9zV3M5?=
 =?utf-8?B?SllqOUNVa3R4RXE2c1pJVFN6V1JXSXdreCs3Y3ZIcXlwMkFLdW1DKzhTTTVn?=
 =?utf-8?B?R2xNNm9PQ0kzZDRDNk5INjlvUit2STEyNDQ4K0Nya2RWbXQ4b1NLbTBvZVdy?=
 =?utf-8?B?RktWc29LaVoxMUxOTDR5K3VXMzR2NW1wV1JZazFQNGt0UVRTVDBabkRQMnVi?=
 =?utf-8?B?UlJDamRwQlRKV0dCZVp0QkxJWm1wQytBUWc3QS95L2U4Z0JGSU5KeDFvQU5w?=
 =?utf-8?B?b2tZQ2ZrWUticTMzZ2VsdUF3NjhDeHRzRUZwcmpwMGl5QXhLZ0hJRUxZYkgw?=
 =?utf-8?B?azN2M2FnbUJXbk1wbXlpM2p2T0ZuUUcwRWpEZkdSQmphdVZ0TFRkV0ZNMjBn?=
 =?utf-8?B?RC9yRzVKbTJWMi9Qb2VXU0hyT2pWMDhRRmlzZHFaUmpBK2FUdlJUYjlTZkQ2?=
 =?utf-8?B?bHNjSkVYaTUwR2xSbS9uRzZEaGpXaDdnaStDMFV5UllKbDdwL2VLVjNDTGdv?=
 =?utf-8?B?RXpYSDJxSlNBS01xY3VVRHQ4eUdYeUFVcTlPK2ZHSHdlMUZrbjdBTmZVTi9t?=
 =?utf-8?B?M2ZUbEtraVlQNVJidUpHQWc1ak1rdzlTSXN0dmFUWFRqZUNaTWxPN1dKdHhX?=
 =?utf-8?B?ZklCNWRVVmFtYTR6SEVOc1RZM2VOZVBiZzIybTVISTExV1B3M3RiR09NeU1L?=
 =?utf-8?B?SU1Rd0dMWkJiTUM0cFUyVkd4Nzcxc3IyWHlydWxtenUrWWpHQkEyK1F0OXdD?=
 =?utf-8?B?RDU1V2RyRG5zaHp6LzlNMlhURHZNcExqVVRZS3ZZL24yV1hBRGhkMEpTWURv?=
 =?utf-8?B?Qkw5aEFTK25sYWxFYThPb0huQ01xWEowc1YySEJVNU9rajhvMmtXckU2SjZt?=
 =?utf-8?B?RzJ1NXZGaWE1VUxtM1hXWWtqMDd5c2JNY3A4ZVdWRnUxK0JHR0NGZHU5NUIz?=
 =?utf-8?B?QUs1VU1XWEQ0K1BwR3VkZDRac0l6NHVmNGIxSnpSNkYzR1BqZ2RuQWlaQzl2?=
 =?utf-8?B?UjZrdDJ6SGtHbUYrNFE3NW5RMjFrSk5UZTlPR2lRQVQyemhVeEwyVXBXaVpV?=
 =?utf-8?B?R2ZMcVdIV05yMGZlcmZmZ1orWk12TVpRQUgxb3lsUUlxczh5Z1JYTFR6aitt?=
 =?utf-8?B?N3QydGJZcGxnakFLVklrVVUwdFJVMVhQeDFsbUo4TVRkNDE5MmxNMHB5R1gx?=
 =?utf-8?B?M3hybUw0aTVkQmRrZHUxYnRoUFdvZUJCTGk1M1lHZGZFLy9XNFVYUDlLWDM5?=
 =?utf-8?Q?mMMJuQiIuZKAhcREhQpAZ3xAv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4229b2f-72b7-4830-f118-08dbb6bd5b9c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 14:01:01.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yuvc7JHjxaHzuxOz5sF7k5KD6K/sFZCIUc+jPV5Y1f8Y0NnWtEKIxvS9J8aW/M4tINSb04ZiCS9KXqBR49v+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/16/2023 08:36, Lukas Wunner wrote:
> On Sat, Sep 16, 2023 at 08:09:19AM -0500, Mario Limonciello wrote:
>> On 9/15/2023 23:48, Lukas Wunner wrote:
>>> On Fri, Sep 15, 2023 at 07:04:11AM -0500, Mario Limonciello wrote:
>>>> On 9/15/2023 02:08, Lukas Wunner wrote:
>>>>> On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
>>>>>> +static bool child_has_amd_usb4(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +	struct pci_dev *child = NULL;
>>>>>> +
>>>>>> +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
>>>>>> +		if (child->vendor != PCI_VENDOR_ID_AMD)
>>>>>> +			continue;
>>>>>> +		if (pcie_find_root_port(child) != pdev)
>>>>>> +			continue;
>>>>>> +		return true;
>>>>>> +	}
>>>>>> +
>>>>>> +	return false;
>>>>>> +}
>>>>>
>>>>> What's the purpose of the pcie_find_root_port() check?  PCI is a hierarchy,
>>>>> not a graph, so a device cannot have any other Root Port but the one below
>>>>> which you're searching.
>>>>>
>>>>> If the purpose is to check that the port is a Root Port (if the PCI IDs
>>>>> you're using in the DECLARE_PCI_FIXUP_* clauses match non-Root Ports),
>>>>> check for pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT.  (No need to
>>>>> check for that in every loop iteration obviously, just check once in
>>>>> the fixup.)
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Lukas
>>>>
>>>> The reason to look for it the way that I did was that there are multiple
>>>> root ports with the exact same PCI ID.
>>>>
>>>> The problem only occurs on the root port that happens to have an AMD USB4
>>>> controller connected.
>>>
>>> Yes but what's the purpose of the pcie_find_root_port(child) check
>>> quoted above?
>>
>> You're right that if you look at this system alone that the check isn't
>> strictly necessary.  It's to future proof the quirk.  If a discrete USB4
>> controller was connected to the system it would be connected to a different
>> root port (the one that is used for PCI tunneling).
>>
>> AMD doesn't have any of these devices, but if some day one was created it
>> could trip this codepath.
>>
>> If you feel it's better to remove the check unless such a device is created
>> sure I can drop it.
> 
> PCIe ports used for Thunderbolt tunneling are Downstream Ports or
> Upstream Ports (depending on which of the two ends of the tunnel
> you're looking at).

Let me explain the topology from an actual system with PCIe tunneling 
active and a dock connected downstream.

-[0000:00]-+-00.0
            +-04.1-[33-62]----00.0-[34-36]--+-02.0-[35]----00.0
            |                               \-04.0-[36]--
            +-08.3-[64]--+-00.0
            |            +-00.3
            |            +-00.4
            |            +-00.5
            |            \-00.6


This is the root port that tunneled devices will connect to:
$ sudo lspci -s 0000:00:04.1 -v | grep "Capabilities: \[58\]"
         Capabilities: [58] Express Root Port (Slot+), MSI 00

This is the root port that the USB4 controllers are connected to that is 
problematic:
$ sudo lspci -s 0000:00:08.3 -v | grep "Capabilities: \[58\]"
         Capabilities: [58] Express Root Port (Slot-), MSI 00

Here's a downstream connected dock from tunneling:
33:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 
Bridge [Titan Ridge DD 2018] [8086:15ef] (rev 06)
34:02.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 
Bridge [Titan Ridge DD 2018] [8086:15ef] (rev 06)
34:04.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 
Bridge [Titan Ridge DD 2018] [8086:15ef] (rev 06)

Here's the USB4 controllers connected to 08.3:
64:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:161f]
64:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:15d6]
64:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:15d7]
64:00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:162e]
64:00.6 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device 
[1022:162f]

If an AMD USB4 controller happened to be connected, it would have shown 
up connected to 04.1 as it's root port.

> 
> The "pcie_find_root_port(child) != pdev" check is always false:
> 
> You're searching for a USB controller below a Root Port and
> check whether the Root Port in the USB controller's ancestry
> is the Root Port below which you're searching.  That's a
> tautology.

The search doesn't start at pdev, it starts at NULL.

struct pci_dev *child = NULL;

> 
> I'm guessing what you really mean is:
> 
> 		if (pci_upstream_bridge(child)) != pdev)
> 			continue;
> 
That's exactly what I had before and Rafael suggested [1]
to change it to pcie_find_root_port().

[1] 
https://lore.kernel.org/linux-usb/20230913040832.114610-1-mario.limonciello@amd.com/T/#m66acb79a13d314b5e868993b1611266a968cf064
> Thanks,
> 
> Lukas

