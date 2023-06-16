Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0616C733CE6
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 01:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFPXa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 19:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFPXa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 19:30:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2E3599;
        Fri, 16 Jun 2023 16:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESKK9AOSR0HbjUN8Td+07uv4ewSNX4ALq+aOUXfSiOMH5PdcMnBWhVMxmZstKrghx4e14uVANvlyptpPZxtQYWXU4bo8SyZuaYoMuyJ7p0G6hERJwSYvP4KhmSok8dphvzS3Xe1/fWO+CVpIot1zGf81JJJbTR1VVN3ZGtT5zX9rt4nJXeexftv+V/AoUVR2cev+pTPkw56kAE3BPtagbY1UsvFd9eWBdVIKHleIdK9ZnEyay5exoKjw7AweQwG4KhVbIWnqfpqrJxfaqLwgkPysxp9aQGhKXb1Wz38tKrIz7vafJXOZruVkSHqxCFPaUUd8CU/3G8TYc0KaXlZnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ub5pnk5JR1NyCf6qLFUsyxnbn5PWDNnBriliRQOo5zo=;
 b=ishYwkAdRnSkKmZtZrBRHxb3c0XxJeTE1PFC+g7zmJzdQQr1pXnxdPDu4CWdrN91KrWR+JF2THQHrpm/jG77xOMEyhg7a2VsmbsEDaAITBVCaZxQ681O/iaHs0NM8hF6kWbF6M4s8EctvDlaDm+dErYwjavoRll78CD+SF2Yh49b14EQD5aFc85pvD7o7QQemH8Y8oEXb18r8C0GWnMnEJ7zsHYMuekZmwM6Uo4arq2o0pP6sYAxv8Ps4hs6VNAEKMwby37jlJBRvkYrycgMtZ4y2M1Z4bhBdWQ/tJ86T4JKSCxkRXufrlOEl9k2DXCoy7lMSj4XYTXUpKqUoRyfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub5pnk5JR1NyCf6qLFUsyxnbn5PWDNnBriliRQOo5zo=;
 b=lmX5bv8H64eCLIu8Q6qrlNF4whVjC8YnfafiexFV2WiqUr6bE4Tv391V0kx6C72YrcIQjIk2lEU+iJukI+nVFpuyvDQWtkLB5pkWJ1mnjev4qmkmIlgmkT5NyHQ0P+Tzr7fxIejhhtEZCGJ2BsiTRomU1HUp7DW8rIdueDwf7CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 23:30:52 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 23:30:52 +0000
Message-ID: <e967608f-ac8a-7a9c-35c5-821b6842653c@amd.com>
Date:   Fri, 16 Jun 2023 16:30:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
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
 <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230516101001.GA18952@wunner.de>
 <8ab986f2-6aa5-401a-aa21-e8b21f68eaad@amd.com>
 <20230616173140.GA6417@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230616173140.GA6417@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 994185a9-6e3a-4b71-6452-08db6ec1b921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/oxONrOwudhTg6QZ8eMKsjJ6Zd2saVtej87PR9GZyLOkmhOWvTEQH3i++O7P+u96uim5i7XcZ5HNQDltij14Aajy5+ezhqQvzezKCsZHdkqaLOQ1WmlqrJMXyc1FaGxMsZ1axeIwuXz6DoWRoefl4oS0GBZY2BnYTxtd2WR16WjJdVR5/PysoOhgMI8cbt6d/yMOHtI1DgOUhHozyOTzFv+0+Kuvkd3oHesK9JJW7iGDJ9L2Wh5oYcjXzm8xNX2zajNyXDL2PH8t9v4PbHrU6GxpKjWHxKTyg/3qnRHDjGvFsQkhXuXYx1xhRSU61sabQnp6cqFuq6jANZeIY6xhnn3VxANBOp5xKlo0A3UwUlY6+KpidTfPN3rnDv224ZK9AZJCHssmBNd4uRicZwAdUyoVUqbkTIuNRR3rP8MPXBB9e8IqvdW6t5DhGq4v0fWtvdgt/V41+05wHFZUM/U0nSQbl/Jcb+NEb6kvrX3tXFTLQvhX2Kx6d10aK6shFc26OgA3aLg9y110gbRaTodktiHeSaavQWdltXFYVgAvpFGg7FAqia/ik+aQ8sMsKq2pWTvtqlP+8bkkg1mogVmCBcIB7p+x95c/uTZaEznPEg55bP5Q9WKX+kL1YtwtF4Kciu+jTsuf0MlSGHPDT7NvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(31686004)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(41300700001)(8676002)(66556008)(6916009)(4326008)(66946007)(83380400001)(54906003)(2616005)(66476007)(53546011)(186003)(6512007)(6506007)(478600001)(36756003)(26005)(2906002)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE13K3N4SjhpZVdFOUxuUFFZVGV4b1lPTXE1Ny9oRzlXTUlkQmUwVW1WRTgx?=
 =?utf-8?B?NWh6b3liVmtURWtZV0drV1NoQlRsYjlobGJ0bGxQeC9PajlBNzlXU0dYNXVo?=
 =?utf-8?B?amswenVvanpRZUIrM0RZYW0xRTBTNHVjUXBSUFAzc0ZKaHEzYlV4K3htSUlQ?=
 =?utf-8?B?WG1IcGxWUFR5QzhxMjhxK1ByUEpRb2xUVkFVRFAwYVpQYllQWUx6VGYxdGFG?=
 =?utf-8?B?L1lVRTAxSzl1SlVTL29lekk5TjE2T2p3VUNpbVB3T0U4TldUQkxrNkVQVzB4?=
 =?utf-8?B?MjdoWjlxUGVneUVmbi9FV0gwMEsyNEF6ZkNldnNIVlE0eTZIRTRDcmxzN2sw?=
 =?utf-8?B?NEtjMDZEeUNHSTdwOVgwcmprbnpjcEZtR3lCN2p3QUZURkJjcEh6WS9OK09M?=
 =?utf-8?B?UlRQR0hDcE5rZ09ZV240ZXdNcWJodWY3ZHdQb1RKd1NnaU5GQ1h0WVRvd292?=
 =?utf-8?B?T2JTS1dNZDRYMFdzZnVQZC9uV1lCcFBKUFhwMUNLT3M4ek81MDdTcmJmV0pa?=
 =?utf-8?B?VllmOFBhcURLVXZaSW1JS2RMelRKY2tvbkxST1pZTHBSTWgzeHhoUm5BaEpk?=
 =?utf-8?B?NGVObVZrOTA2K0VSbEd0RGc4VE83OCtCaytEWk0wUWlaa292dGFhbFFtVkVq?=
 =?utf-8?B?UW15WnQwRkg5eXZXbFdLb0N1QVNKZzNtYWNEdytvV0lxbi9uWVd4bjByUkJx?=
 =?utf-8?B?c01FMU1JZFA0YVRsRytwZFBKRm8xSGlRdmQrZDg1OUszcnc3VGZPSUNFZExz?=
 =?utf-8?B?U0tXTjVqMHR6ZkhQQUNQUVA4T052UDZTN0syZ2E2M0NjaXJqQ1ZRVlUydERa?=
 =?utf-8?B?SUNmbFl4Y3FDVzJsRnRVcC9aMzBNcFBFWUlHeU85bGIvS0NlMkJzS29WdXpw?=
 =?utf-8?B?RWVVQlZ2ZFk0UjREZ21CVnhYVjRvSkVLdzdIZDBiRXdHSkNGZ3l4TFMwQi9z?=
 =?utf-8?B?S3FCWmdCVGxuZWRLTEJwRW5ZbzYrL016bEtYTjUvdHZqQWx4ZWpTSEsrMC9T?=
 =?utf-8?B?b1dXczBHVEF5TE1xS1dnSTZGYnZ6MVBHMVhuSmhTaWltQ09OY2ZnbUhwZlU4?=
 =?utf-8?B?YmUveG4raWRBOEJ4OFN5VHlqVDlta0tid3VSTll4TlhvS3BOWm1YNmcvSkpw?=
 =?utf-8?B?VGsyaHlrZWVYa1J3OGNidDhqZ1RlaGM0WFIzc21LM0QyOHUybjd0MzZjZjNM?=
 =?utf-8?B?bFNnTnpHWDhFVzl3alkvRFl0MUxQSFJTK0ZjbWpZM2t4aXI2S3dxYXh6RWI1?=
 =?utf-8?B?cmgwSStKY0xReEVDdEFDVGNldk5IZEMwKy83anZ6QzNpUXBqTERERmhLbkFa?=
 =?utf-8?B?WG5WdjlqRGNNZjBNS2pOcWp0ZzZwUlppN2tQa3NENVBEVVV5aDZ5L3R0NHFa?=
 =?utf-8?B?bThUVlZwUnFJaEE5WjRaTFBvd2VtS0twVHl5YjZmNnNXeWx0dnRxTGx2L0ho?=
 =?utf-8?B?M1hGZ0thQVh3TEtNMEw0ZFk2eFBIeTFQZ202dU5LOWxzY2ZqcnlqRE9wUi8v?=
 =?utf-8?B?eUpZSmQwdzEzcVV3YXplaTR4Y1ZlQm1JalNJYVFaazVvby92WmNJcy90Nm00?=
 =?utf-8?B?Snh6UnIrYnhWUU5XMC9rU1VEM3RwQWozWEVRU1AyVWk4Z0dRbzRmNkxvQ29T?=
 =?utf-8?B?SmNUaXdFQ1ZDMDNYM0kzY3dNUDlQM2V6akN0c1liTGcxY240QzU0YVJURjhr?=
 =?utf-8?B?UGNYWUtVZklSb2Q2SmZqWGwrOVRGRGNtdnpQWGsyUW1PZWJKakMrSDdtYkRs?=
 =?utf-8?B?Zk9HS2orUWRXWVB2eVRGWHIvMnRTbFU4eW9haHRvY0NYUWZxK3Q5akJ6SDlm?=
 =?utf-8?B?Rk9LVXBONFVDSm16cjlmcDEyOUhEekY1U2lBdHhtNzVpNUQ1L2YyMmtVWEx0?=
 =?utf-8?B?YWNubVRYVGpLTk1wNk0rLzBJcUZnUlhESnVWMmc3djRwTEZ2VzJkWEZuelNz?=
 =?utf-8?B?alg2ZklRWkR1amRrVVdXODdRVmUvWGNVMHI5LzJxWUdOTkxiZFBHa01qY00y?=
 =?utf-8?B?bitIcFVhajRIemRGZi9oQjM0V0RwUnAzWW1SUUFnT09CZWl3RWRyTnZ1bnl3?=
 =?utf-8?B?NXIvaGtYSzdjak02ZHhVV3VGMHlRTFZzVlpWTDlDekl5eFlMbTJvbFlhL1B0?=
 =?utf-8?Q?o6AyEuw6F7cBJkKDnfbaB/mR7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994185a9-6e3a-4b71-6452-08db6ec1b921
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 23:30:51.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqlJcfzYPeaCtL4w64AqKr/bZawB8aX/3hfm3agqM5fl0YntfKkC7ITM5bmgPIreQyjZyXG2hK8o6tdJ7III/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

On 6/16/2023 10:31 AM, Lukas Wunner wrote:
> On Mon, May 22, 2023 at 03:23:57PM -0700, Smita Koralahalli wrote:
>> On 5/16/2023 3:10 AM, Lukas Wunner wrote:
>>> On Tue, Apr 18, 2023 at 09:05:25PM +0000, Smita Koralahalli wrote:

> 
> I'd recommend clearing only PCI_EXP_DEVSTA_FED in PCI_EXP_DEVSTA.
> 
> As for PCI_EXP_DPC_RP_PIO_STATUS, PCIe r6.1 sec 2.9.3 says that
> during DPC, either UR or CA completions are returned depending on
> the DPC Completion Control bit in the DPC Control register.
> The kernel doesn't touch that bit, so it will contain whatever value
> the BIOS has set. It seems fine to me to just clear all bits in
> PCI_EXP_DPC_RP_PIO_STATUS, as you've done in your patch.
> 
> However, the RP PIO Status register is present only in Root Ports
> that support RP Extensions for DPC, per PCIe r6.1 sec 7.9.14.6.
> So you need to constrain that to "if (pdev->dpc_rp_extensions)".
>

Okay will make changes.

> 
>>>> +	pci_aer_raw_clear_status(pdev);
>>>> +	pci_clear_surpdn_errors(pdev);
>>>> +
>>>> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
>>>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>>>> +}
>>>
>>> Do you need a "wake_up_all(&dpc_completed_waitqueue);" at the end
>>> of the function to wake up a pciehp handler waiting for DPC recovery?
>>
>> I don't think so. The pciehp handler is however getting invoked
>> simultaneously due to PDSC or DLLSC state change right.. Let me know if I'm
>> missing anything here.
> 
> I think you need to follow the procedure in dpc_reset_link().
> 
> That function first waits for the link to go down, in accordance with
> PCIe r6.1 sec 6.2.11:
> 
> 	if (!pcie_wait_for_link(pdev, false))
> 	...
> 
> Note that the link should not come back up due to a newly hot-added
> device until DPC Trigger Status is cleared.
> 
> The function then waits for the Root Port to quiesce:
> 
> 	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> 	...
> 
> And only then does the function clear DPC Trigger Status.
> 
> You definitely need to wake_up_all(&dpc_completed_waitqueue) because
> pciehp may be waiting for DPC Trigger Status to clear.
> 
> And you need to "clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags)"
> before calling wake_up_all().
> 
>

Okay. I did not consider the fact that pciehp handler "may" wait on DPC
Trigger Status to be cleared. Because in my case both the handlers were
invoked due to their respective bit changes and I did not come across 
the case where pciehp handler was waiting on DPC to complete.


>>>> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>>>> +{
>>>> +	u16 status;
>>>> +
>>>> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
>>>> +
>>>> +	if (!(status & PCI_ERR_UNC_SURPDN))
>>>> +		return false;
>>>> +
>>>
>>> You need an additional check for pdev->is_hotplug_bridge here.
>>>
>>> And you need to read PCI_EXP_SLTCAP and check for PCI_EXP_SLTCAP_HPS.
>>>
>>> Return false if either of them isn't set.
>>
>> Return false, if PCI_EXP_SLTCAP isn't set only correct? PCI_EXP_SLTCAP_HPS
>> should be disabled if DPC is enabled.
>>
>> Implementation notes in 6.7.6 says that:
>> "The Hot-Plug Surprise (HPS) mechanism, as indicated by the Hot-Plug
>> Surprise bit in the Slot Capabilities Register being Set, is deprecated
>> for use with async hot-plug. DPC is the recommended mechanism for supporting
>> async hot-plug."
>>
>> Platform FW will disable the SLTCAP_HPS bit at boot time to enable async
>> hotplug on AMD devices.
> 
> Huh, is PCI_EXP_SLTCAP_HPS not set on the hotplug port in question?
> 
> If it's not set, why do you get Surprise Down Errors in the first place?
> 
> How do you bring down the slot without surprise-removal capability?
> Via sysfs?
>

As per SPEC 6.7.6, "Either Downstream Port Containment (DPC) or the 
Hot-Plug Surprise (HPS) mechanism may be used to support async removal 
as part of an overall async hot-plug architecture".

Also, the implementation notes below, it conveys that HPS is deprecated 
and DPC is recommended mechanism. More details can be found in Appendix 
I, I.1 Async Hot-Plug Initial Configuration:
...
If DPC capability then,
	If HPS bit not Set, use DPC
	Else attempt to Clear HPS bit (§ Section 6.7.4.4 )
		If successful, use DPC
		Else use HPS
...

So, this is "likely" a new feature support patch where DPC supports 
async remove. HPS bit will be disabled by BIOS if DPC is chosen as 
recommended mechanism to handle async removal.

I see the slot is being brought down by PDC or DLLSC event, which is 
triggered alongside DPC.

pciehp_handle_presence_or_link_change() -> pciehp_disable_slot() -> 
__pciehp_disable_slot() -> remove_board()..

But I want to clear one thing, are you implying that PDC or DLLSC 
shouldn't be triggered when HPS is disabled?

Thanks,
Smita

> 
>> Probably check if SLTCAP_HPS bit is set and return false?
> 
> Quite the opposite!  If it's not set, return false.
> 
> 
> Thanks,
> 
> Lukas

