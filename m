Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064370CDCD
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjEVWYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjEVWYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 18:24:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33EEC4;
        Mon, 22 May 2023 15:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQvxMgqm/7cKHI56Ma3Evl9zasdlFmktaIrIViL/lVlMlxQgc9EIqoWTwl6XjQeuw3hisEHaESuQ0ghMZ+9JzcTNQg5npy+4vyGRjbbxEQmqYR57pcRUVBJ0KlF03U1CMuxCXaM63UmBUMJUztMZEKNj6WvcL5JQhTX2RRupSJ20pLIg6/UEJSlNgBEjV7nsySlmrU/9quB9KCC6439cbQXD/fl9MJGQpwxvyTwjEin9wUDhPIk8ayiM+rpWe6usFvey9J8Xy90kbU62SyjipLtn6JBcog7j/Dm5dBdi6Zer4Dns7JUABZAdcROsCpuNTf7sgYgBalrKEabmDvjQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEdV8fqtiXk3qPZtEWzE5Y0+/Q/5OYJChPkO/w/MVYk=;
 b=ClHhAbC5Cdyyk+/bgq2LPVesarX9779zAbQVm6QWJmlMFhXSXnCjD1nrmGnOofJy09fmtQia+Xq/afZtrD70YWy15nSix1Q0g2Hde6c+2fq/Ixl3HgfBpZ2VSGkQYtqj4hO64mSe53+Ppeqlx66yLzHENXw//FwdqVmxLZKDlwNQTwsZ3eooCBBFTkHrmFaYNkRd336ePsz+iJRdcKW3sBzTU2BN/O4MUHSCI+96jwY8y+Q9aQGLZAeQu3lQYIJAaNPB9BeeeapSE396A0VFKFzwY+NkOc/FWfzUPWy4dOOjFs8y51PSykaXL1hjrVdikoKFcJmRc04tM5Fjm206NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEdV8fqtiXk3qPZtEWzE5Y0+/Q/5OYJChPkO/w/MVYk=;
 b=0WmXY1kuo8IlO5kZO28QlrqE4FaSMW8u5NUuNDqEiqDADjPOCz+oxYccwD87fKw0rihL/ZXbFKPVMKcJOkBfMf1jt3xt1o3zHA0+RIX5wko5D81QzVtH7y8yqwqY3egZ7qZ/QkfA+QfYLkUfV5QJ++ZqMwGCHSyMhptKUzmdkb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:24:02 +0000
Received: from DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::b5cb:8d62:c2c7:c4ad]) by DM6PR12MB2876.namprd12.prod.outlook.com
 ([fe80::b5cb:8d62:c2c7:c4ad%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:24:02 +0000
Message-ID: <8ab986f2-6aa5-401a-aa21-e8b21f68eaad@amd.com>
Date:   Mon, 22 May 2023 15:23:57 -0700
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
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230516101001.GA18952@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0015.prod.exchangelabs.com (2603:10b6:5:296::20)
 To DM6PR12MB2876.namprd12.prod.outlook.com (2603:10b6:5:15d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2876:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: e65a659e-570d-4f18-6454-08db5b133ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rilSyE6PpOcIsloJIAqIGuSXwhBx7ha3P+39X6/imqgjiHZ/bPNdvDjecf7KOV2tWgxBTGvYqaLj7WHGtGTZy3psZ/l+4px51zKkOcrWpBRxVkcJ97VsRcm3LXelgkCM4cOOAVLnUtcG4mQkwgCE3C8oE0XGro3xZUqBWK1wKTbWFG0SDcSNXGu8nhybqv9L8KPRWxhf/QcMfIAoIywDHIuMAHKf9984ZzytAkQmLXfzQAHB1es65CRjFWuxsep02+u35Hw3m9rNOUErjSI6+WXy43c99VowL1iYn4isoNLvXEAqbBO4yicAx4PQzbdEviJnUyL+mvou9QT54j6RtJbdg6knDLpr0J2hLodu2sOd3Nh+lqFuDQ2et0lKUgBpScnhhdVnb4m6xr0puj7WXHHxNAPbmgIpTbTQCFzaW+SLa06sAvSMl1XP26+pbfIAEn7cyHgQQHXZfFiVvNt++9Wa6oghN5WplOyssl3XqjG4gU2AgSNkc76pqmOogZytYOSclfIFX4F/f47fk+OB0R7f7uLCF3CVxC8m+pANqSAESGR8g0vunB67IxRx265oNvrqaNSNbXgBfd8kzq3SON9ZcGawZzrk42W8d2+EyJPv/Gc0ORPiIpvOld0ntZf0+VxlvfBd8k/qfANGWPx+zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(8936002)(8676002)(5660300002)(83380400001)(186003)(6506007)(6512007)(53546011)(31696002)(86362001)(2616005)(26005)(38100700002)(41300700001)(6666004)(6486002)(966005)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BvZVh4di90MUV4T3kwek9vb1BBUXVjaW1YaS9qMUp6RkpQZ05hcUpPcCsz?=
 =?utf-8?B?RldGWVRFRmpHM2VQbDhCbXJlTUttVmxGcWVoZmZhWjh0ZHhkckoyYXllMWZ6?=
 =?utf-8?B?cWhGN2g3eFVkRmF5dEl1Mk1hb3M0eko1TVJnVTBJK1gwVnlsekd0L3llaXEz?=
 =?utf-8?B?UmRRQzViVDdXd3E0YjQzcHFjS0ZSM2ZYWUlIUlZ2anlpS0trUklpZmNQeEhW?=
 =?utf-8?B?VU90eDJaejFDdkxWVmZlTnVRWHBZSjZzb0x2eUdxcU9ia0RHMjVnRG5Rb2N6?=
 =?utf-8?B?SHNWTzgxTXlVM2pSc21BbHVKZFhpS2FUYTY5c2pZeFpVU25BMkg5Z2toWFI2?=
 =?utf-8?B?eU4waUF6Q3huc09xdU1OaEpSNjRsUW9QUnZBN25SVUg3aXptN00xQWU0WC84?=
 =?utf-8?B?NkRraTZQYTJjRVg0dVljNnZvL0h1TnQwMzhSL0Nhd1hvOHpvRmlWTDQ5RHRm?=
 =?utf-8?B?TmxXYU5naGZjRklHS1A4azJUY1Z1NXozeXoyY1JDZjBKTmg4eXgyQnhyU01u?=
 =?utf-8?B?eFBDS0VMNkp5cDhNcmk1MGZ3S3FZM3I5OHhEMzUyeWZvYVhjc25vWjV6R1Bt?=
 =?utf-8?B?ajFWWUs0L0ZUYnp0WXdBNGUzRkl0VlI4bXBDMUpQbUxuR2pvZHlwSlhnRjQ0?=
 =?utf-8?B?MUJUdVZMUG8yRXArZGZ3RHhsMmJYY2VHbVRWV2JST0RGc2d0ZzlNZGhxcWRp?=
 =?utf-8?B?dnZtTi9VWldsZTFIanQxVmNPQWdZUnVyWnF2cmtjM2dXYUovS1F0dWVSZUlV?=
 =?utf-8?B?VVh3ZzZBa21mS0wzLzFHbnpNYmR5bUh6L2llZVU3RXZFU2R4UGJmZy9FcXJO?=
 =?utf-8?B?R09UZ2ttVmxjQnFlWkZXcktLK3VnV3M2TXJUdnMwOWZWanE3RUtaK04vNFdB?=
 =?utf-8?B?bzU3MUZMckp2OFdhR0NNN2NsRWpOUkJYQmFkRVpmV2lKaXJMWkNCSWlLNmVC?=
 =?utf-8?B?NzJ1aUEvZU1BZ3UrK1lhL2lMcDRoV0xMS3VKNWJkNjg0ZXBRd3ZHcEc2YTIz?=
 =?utf-8?B?LytlbzBmUlZGVDFkWnR6Zk5MVTJXQUVPUDdYYTJmbll6S2JDTGdIOHlNZ2pk?=
 =?utf-8?B?WktxV0ZvVnJsMWJPdmlHZWtwUngrQUV5SjgxTkpXdE0weGg0cjJMNGNqSjNN?=
 =?utf-8?B?SjREdDdnSWNoNHFyWS9NQWV3eS93L3RWWlBxRm01RCtCbHY0T3FJT3VPbUtz?=
 =?utf-8?B?ZzZ4Z0kvTkNzSnRPVzZXVTg1MVF0ckxnLzRLeHhUUlJ0WDZid2NZNVRUenlp?=
 =?utf-8?B?SDltNGRGRVVTUzlNOWRnVk80UnJxUkxIWVpFWk95elM2cmRmZldreThodGZN?=
 =?utf-8?B?NExHUlh1WG1aV0hUUDkvVXdHRW02TUlXaXBQNUhPRHV3b3BER3dhb3NTRnlS?=
 =?utf-8?B?djA1YWZ1ekNvdGdZV2lQQm9FWkc5d0tIamljbXpTcDZvUUxtT0JmOE9TSFA1?=
 =?utf-8?B?bmc2UERtMTdaaFJBVlR0aVFyZTJaTWxsL1JERlhmZk5UUzFtb3JndE51WVZq?=
 =?utf-8?B?QkQ4SkFXQnJkd2pHVU1wWng2MDFmdDhuV1lyWlB4OGpqcHhXS0NKVFlNeG1x?=
 =?utf-8?B?L0Y3Q1JpUDlveUs3bnNsdTkweUE4ZlJvc1FQekRwcmZXckJoWDMyRm9VWjBk?=
 =?utf-8?B?M1lEWjd1eGhOSnhUQWF6c0hyU1lZZUdZUTg5SGhudnR5UWlLekNNbXgwbkZ2?=
 =?utf-8?B?N3M2U1JnVGowL1Q0Y3RwQzNpUktzekJrNDZtVXBkSmorNDJXYnoyanZQMnhq?=
 =?utf-8?B?YXRJc2Fza3ZSL0xVR2grZ29aSWlvdTN5YWViSjFGaUpJVWdtVWUrOWUyVmYx?=
 =?utf-8?B?WWpDaHdmV3VlbWJQZE5ScmRaOXFMMGdqaFN4bWQycnVHSmZ4QjQxOFVhWHYw?=
 =?utf-8?B?TlFJTXZPenFhQlBoY3M3MXFYQVhRRWFxTzNxM0h1RTdRMDlXNlFlQ2txUjdE?=
 =?utf-8?B?RzRLT0Z2dE5YL3JBZ0o3YWZOZ0FNb2JIcXZVYm90MzYyaDA0cEMrQVNINzhW?=
 =?utf-8?B?V0Jjb0NDSTdidk5mQXVWY1BMVXh2Q3NkZ0t2Q3JFNkVjYkJOVHdhM1lNRlJY?=
 =?utf-8?B?RndhT1Q0MDNpWVRsckhKMFQzWmN0cGQ1cjJScVZQdkZWUlNOVG1CVU9Ya1Zo?=
 =?utf-8?Q?MPg5tQYn2EIzyj9XkzkEPuqog?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65a659e-570d-4f18-6454-08db5b133ddf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:24:02.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ5YcReznUlmcHnsEsD3KDrMJ7OUeLciElxWp8jQeUG6veTLWBJuEd7Mfi5vPALSa8SvGRSH/qQ59OMkOd6f2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/16/2023 3:10 AM, Lukas Wunner wrote:
> On Tue, Apr 18, 2023 at 09:05:25PM +0000, Smita Koralahalli wrote:
>> According to Section 6.7.6 of PCIe Base Specification [1], async removal
>> with DPC and EDR may be unexpected and may result in a Surprise Down error.
>> This error is just a side effect of hot remove. Most of the time, these
>> errors will be abstract to the OS as current systems rely on Firmware-First
>> model for AER and DPC, where the error handling (side effects of async
>> remove) and other necessary HW sequencing actions is taken care by the FW
>> and is abstract to the OS. However, FW-First model poses issues while
>> rolling out updates or fixing bugs as the servers need to be brought down
>> for firmware updates.
>>
>> Add support for async hot-plug with native AER and DPC/EDR. Here, OS is
>> responsible for handling async add and remove along with handling of AER
>> and DPC events which are generated as a side-effect of async remove.
> 
> I think you can probably leave out the details about Firmware-First.
> Pointing to 6.7.6 and the fact that Surprise Down Errors may occur as
> an expected side-effect of surprise removal is sufficient.  They should
> be treated as such.
> 
> You also want to point out what you're trying to achieve here, i.e. get
> rid of irritating log messages and a 1 sec delay while pciehp waits for
> DPC recovery.

Okay.

> 
> 
>> Please note that, I have provided explanation why I'm not setting the
>> Surprise Down bit in uncorrectable error mask register in AER.
>> https://lore.kernel.org/all/fba22d6b-c225-4b44-674b-2c62306135ed@amd.com/
> 
> Add an explanation to the commit message that masking Surprise Down Errors
> was explored as an alternative approach, but scrapped due to the odd
> behavior that masking only avoids the interrupt, but still records an
> error per PCIe r6.0.1 sec 6.2.3.2.2.  That stale error is going to be
> reported the next time some error other than Surprise Down is handled.
> 
> 

Okay.

>> Also, while testing I noticed PCI_STATUS and PCI_EXP_DEVSTA will be set
>> on an async remove and will not be cleared while the device is brought
>> down. I have included clearing them here in order to mask any kind of
>> appearance that there was an error and as well duplicating our BIOS
>> functionality. I can remove if its not necessary.
> 
> Which bits are set exactly?  Can you constrain the register write to
> those bits?
>
Hmm, I was mostly trying to follow the similar approach done for AER.
pci_aer_raw_clear_status(), where they clear status registers 
unconditionally. Also, thought might be better if we are dealing with 
legacy endpoints or so.

I see these bits set in status registers:
PCI_ERR_UNCOR_STATUS 0x20 (Surprise Down)
PCI_EXP_DPC_RP_PIO_STATUS 0x10000 (Memory Request received URCompletion)
PCI_EXP_DEVSTA 0x604 (fatal error detected)

> 
>> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
>> +		return;
> 
> Emit an error message here?

Okay

> 
> 
>> +	/*
>> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
>> +	 * removal might be unexpected, errors might be reported as a side
>> +	 * effect of the event and software should handle them as an expected
>> +	 * part of this event.
>> +	 */
> 
> I'd move that code comment to into dpc_handler() above the
> "if (dpc_is_surprise_removal(pdev))" check.

Okay.

> 
> 
>> +	pci_aer_raw_clear_status(pdev);
>> +	pci_clear_surpdn_errors(pdev);
>> +
>> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>> +}
> 
> Do you need a "wake_up_all(&dpc_completed_waitqueue);" at the end
> of the function to wake up a pciehp handler waiting for DPC recovery?

I don't think so. The pciehp handler is however getting invoked 
simultaneously due to PDSC or DLLSC state change right.. Let me know if 
I'm missing anything here.

> 
> 
>> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	u16 status;
>> +
>> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
>> +
>> +	if (!(status & PCI_ERR_UNC_SURPDN))
>> +		return false;
>> +
> 
> You need an additional check for pdev->is_hotplug_bridge here.
> 
> And you need to read PCI_EXP_SLTCAP and check for PCI_EXP_SLTCAP_HPS.
> 
> Return false if either of them isn't set.

Return false, if PCI_EXP_SLTCAP isn't set only correct? 
PCI_EXP_SLTCAP_HPS should be disabled if DPC is enabled.

Implementation notes in 6.7.6 says that:
"The Hot-Plug Surprise (HPS) mechanism, as indicated by the Hot-Plug
Surprise bit in the Slot Capabilities Register being Set, is deprecated
for use with async hot-plug. DPC is the recommended mechanism for 
supporting async hot-plug."

Platform FW will disable the SLTCAP_HPS bit at boot time to enable async 
hotplug on AMD devices.

Probably check if SLTCAP_HPS bit is set and return false?

> 
> 
>> +	dpc_handle_surprise_removal(pdev);
>> +
>> +	return true;
>> +}
> 
> A function named "..._is_..." should not have any side effects.
> So move the dpc_handle_surprise_removal() call down into dpc_handler()
> before the "return IRQ_HANDLED;" statement.

Okay.

> 
> 
> What about ports which support AER but not DPC?  Don't you need to
> amend aer.c in that case?  I suppose you don't have hardware without
> DPC to test that?

Yeah right. Also, if DPC isn't supported we leave HPS bit set and we 
won't see the DPC event at that time.

Thanks,
Smita

> 
> Thanks,
> 
> Lukas

