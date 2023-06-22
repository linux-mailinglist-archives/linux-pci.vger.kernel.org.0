Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2138473AB2D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjFVVG6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 17:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjFVVGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 17:06:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5332688;
        Thu, 22 Jun 2023 14:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDR1i5G7wY8u6wFbBH3gS8ksaECspFtZtwqW/ImNi/a18fohu6Fzn8kBj7EUpGjYcM2i4OVztZSBDepKkiFgZgTwOYWzh9ArzKwv5sRqDqQJDWSPWJDsVct8BmiJp1COJNebki1KilcL+sFfpSulHX1CR4OYLapMk+UPUGufEBT8JDuaAYWGJnTOep6JpgOP3gqqFBaqIc1gZCYIrwcQjl+XpfzAsahah8GXoUDyMk6yYOMwem82iX8gUnJ5ltys7CqngwPbhDvPdn7zPTtWE0g9ZzRzSER+4jmNxOZLIxnK4dQNazgZU1Mqx4F+I0UtJUdGf6gWehJquSWMil5I5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS/1QYm5023d6Z2NpkBEnI9vvY8B/quHivVY3QC8RIE=;
 b=ZYDHl8NEBI2Fjq1I38B4T87glFImp3q9TIQRkj17hJncggk3CbDIwF3pr9PzD3VbqsbLoHTpe/ajO5G0zP7FGxKZUsQyIVj2uWe3wZgFM7L9to8BpjoEK4r1aYcbXaJ2mxff8r3O799+/rL46UOWuiPIFkJMdOS07FXsA1tvgUq1oFmMlRy3C8i/Tet9aavj0BzZeG83h/me2kfMNiQQw+SE5V46DC2GFGokzxMr58dwapzij2orHtSiVgBr+e6bhHb5TnT+8jALA9QOTRFYsLegE/uq4buHbAksFDjH9ZPT5z+QYFCeIW2SNrfN33jV91p9xg3OHF/WaEqPUIfWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS/1QYm5023d6Z2NpkBEnI9vvY8B/quHivVY3QC8RIE=;
 b=QPSshECj8iXu/GwkQ+IkM91uoRxUppTZJZhK9BRJWQRvMu368qENXXl/cDU71Evo8CxXKUCD9Eu968tWyaHtrsmmqelb8EWUEGpQJ+0t00R3Whve1ZXhSNHyruJepJMRZv2j7/lt005UcSzQmlii2c5/mhx9tH5L/1U/MEqmMrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:02:05 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 21:02:05 +0000
Message-ID: <15248fe6-9b82-7135-4bb7-73667aaec604@amd.com>
Date:   Thu, 22 Jun 2023 14:02:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with
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
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230622090403.GA21721@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230622090403.GA21721@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf46e2d-33ce-4c12-5611-08db7363eefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWypERmwodZPaVWtQC7Srqw/5Ahi2fCll6IVv8qYQ/fcitvnj9HcbIR2KiNhd6ZPBsKYh8TdvjzJKAC6oeYV4glAdm+InYtT3sB3Xj/VkSBI9skCu036YFmC7+3BfYrGhFiI25MuuO9I2fSqg5UxL+DF8IZbWxPJZywgMjEzx9GuOj3Bw/ht0cfC5eWgJIR4nZvsVgCe0Eh3Fz80IrDQX3lhiN17/fXXRuAKYB2lB045yxiDfkTz/kqWGmNL3T6rrJfnDbqG0nTVnM/gDkP2EGLcKB9DlwArHFIf1YI0/sXD3OojAukUczIkPnyIRgPlNo9sLrFOHOBTCto5k1wekzdwbR+w3VWwSq5cBsp5frJ63YabXVhU3roMr1tN9t2AYi7Ew8PFsRG5yZ/MAPAgC6Jygupwux6Zwj/J+9+byy0VQi6eSZV8tDj+HHCKW0/stCZVlpp/h3IRSMqR2Xx5qjJZ5ATC5uocL9oqhyVYo7AFzMWZN5W+9OcPxpFu8lkCvYNUH9W3+jlT2+P/VpbdAuY7/N0rw7lluHJtkUPE6xWAVA3eqL0U8KtThgbeoglf82J15HFO1A55WjmamdTDMm+Zo7ZgXVxRMYRppLBXtaJNNRt1goQJa6NwnKj80LBBMmvm7MpLpk4qGtzIxr3/8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(4326008)(2906002)(478600001)(54906003)(86362001)(31696002)(6486002)(316002)(41300700001)(38100700002)(66946007)(83380400001)(36756003)(6916009)(2616005)(66556008)(66476007)(6512007)(8676002)(8936002)(6506007)(26005)(186003)(5660300002)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05PeC94T3laRFM2SmV2RUZRQmtoRnRYTVV3SlB3ZlRSOTE4eTl5Q2NoT0Z1?=
 =?utf-8?B?eEtySWxUVkRIWFdReGN0SXl1R3haeFZOY2ZheHY2dTA2RmpscmlMczhSdjV5?=
 =?utf-8?B?VWdEM0xHQWRDRHdVT01wS0xhT0NxbUZTN0cxdU0xT3pYcEpoWkg5eWJONmFp?=
 =?utf-8?B?aTFyKytCMGRIUVFZcVhySFBPOXhLMm1wdUpyU2JoQ3NQOEVBYW0xWHZpNnF5?=
 =?utf-8?B?UER3ZGVsZkR3aVBWU24vUW44cXdoUDRZOUtQeDlJcTN5cmYrdmFxRWJGNUpi?=
 =?utf-8?B?UmxuaTh4QTA1cjZsUDN4NG5UYmhNaXpFdkhFSkw4ZU1KaHhhZUhrTnA4OFc1?=
 =?utf-8?B?MWxLd2l6aHlOMUZnMlBJMUJoRnJIZGk4ODZkVUVBMGo3UFBPYkN3cER2cVJy?=
 =?utf-8?B?d0hGWGFQSXI5Rkl6SWdxUkxkVDNPVzduM0tIRTRGN0krR2N1ZUxOT1dUY2o2?=
 =?utf-8?B?aVlWSHg5WHgyWHdWWnd4cTZ0NDlUbGtSYlpIVkVEb29QUWJrTm5oRHoyYXdo?=
 =?utf-8?B?ZWdSa1lFd1pqWmV0M3d0cklpL3lmUjVRbUpkM3FVREo1dVdtc2N2c2p2emdz?=
 =?utf-8?B?UXNUNzdPTWVsYnpJTWI0a0JGWWhFenlmYU1sOVVSSjNQOWJheEJ6MGNYYXZK?=
 =?utf-8?B?cHU0WWs1ZTlmV3lxRXRrRGVWK2VhN3hFRGJ6MGlOZFJTd1lVSW9weVJaZldm?=
 =?utf-8?B?cEZqdFBpNHIvdFVISkl5ckN3UStZMjg2a0dIcnpPbWRQTkg0Y2xTZ0czQ0Zn?=
 =?utf-8?B?bmkzdUNqZmNBNkVubGorRmQ0UnNydWdvWW1wL2h3WmxEaDFQUmxnelhVZ1pv?=
 =?utf-8?B?ZGhuVGx3Z2lVRXBXaXU5akM3YktmR0JveFlpRFBncnNqWWlvZThyaVdGeDJU?=
 =?utf-8?B?cGtQaFNFT01zeC80aGd3M2J4d3k4TWZNNWtDZkVrWE0wNTVObDNXYnNWeENy?=
 =?utf-8?B?N0drcW1GVHhXbjlhYXBvc0ZHSHk4OVVSajVOVXBoTTZQeDJVZ00wQ09ySVN2?=
 =?utf-8?B?enVFYTYzWUYzcXV2ODJZR1BHUzAwa2ZxcWRJWXlJRmtmcDhZUWt1MTJyNTNm?=
 =?utf-8?B?MUNUYUdqUVk0YW1jd2UwcmovMC9OdmN5TzV6bld3UWIzL0Vhd2NtTHZwbmxP?=
 =?utf-8?B?QWVlRnFxcm5KaXN1S2dBbzFhVDdPem8yMGtSbGlKcnkwd0JTM29QdTBQTDZL?=
 =?utf-8?B?V0hNUmNhamVvKzJoUlhYNW5LV2JKRkpTRmJiSmJaV1dtT3pUc0EwVnRVVWJk?=
 =?utf-8?B?QmVlRk1yc1Z4MDVObGZvdlhhNHBXT3RRNHVRc0RoWHg5Q2hjTExZTFFyeE03?=
 =?utf-8?B?WkZ1cVFPRU4yWE0xSUovQ2pVQ3pBUnYrS1BUQW9lOWVaSy92Rmw4TjQ1a2ho?=
 =?utf-8?B?YklLTzlrR2xEa3NrOGdwam5RRFhTeE1wdm5kQnRWc0MvWWt3Sk5GVFFzU3FV?=
 =?utf-8?B?TmZ4b0pRUVgxZFVrTWpma1VhZmRoNjJtcGdad2RDVDdOczdFSlpod21BbjNH?=
 =?utf-8?B?RSs0bDJLM1B4RzNieURpVWkwQ041UnB0UXN2TXgydTlvbUl2RFdUOS8vS3BR?=
 =?utf-8?B?WERrU3Q3cGdUQmU1SytsVnoyL1B5NVRKa0YvUGUwY0lsV1A3NHhsSDRKc29S?=
 =?utf-8?B?MDJUb282cG9DOVA1cno3dTFkVGdtWXI0WUtSdjBrakM5M0piUjRrN3k2YkNp?=
 =?utf-8?B?QStXeGdQOXVlTVVFQzF2YVhaRGVRUVBaaVdaTWdOTCtqeXQwUmxpL1FESEM4?=
 =?utf-8?B?MGRFek9qRnh4RkN5UEdrdmkzSEZ3TDBCQkhidWU1d29PMWdBL1NjU3l0U2My?=
 =?utf-8?B?OHlIcHQwcGdwZWxibFJqS3I4ci81T1NMcm4yeTJFUEk0dXZXUVJLV3RuUTZL?=
 =?utf-8?B?M3JMODZXUktrWjVkVmdtM2tTaUlVYUJ0VU5vL1BPaVFPZXBpNkNBaWZXNEZv?=
 =?utf-8?B?cXpkODFMS0ZJRTgrWlNFeTBEQUhJNVlGL2xiT1dEb00yNVZjbGxyRmZWemZj?=
 =?utf-8?B?V21vK3NwRThhNVlhNDdXaFJtQ1pMK1Exd2p0c3JSbFVqZXdMNFRQYWJjMWx0?=
 =?utf-8?B?Rmh3a0dIWHhIRXoyd1VpeWczVUlVSVZNZWxFZ2lVK2xCVnA3YzRqSzI3bXhH?=
 =?utf-8?Q?wY2kwd1eJUsMKUK0wh2l7onPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf46e2d-33ce-4c12-5611-08db7363eefb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:02:05.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CYmul3eyHya3QPPOuky5kV6Sn7FVJ9y6pxyBmg7l8V2KcVxC+S1XLUAFZZPjc0TFxu60l/4z1w8Fz1mdijyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/22/2023 2:04 AM, Lukas Wunner wrote:
> On Wed, Jun 21, 2023 at 06:51:51PM +0000, Smita Koralahalli wrote:
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -292,10 +292,68 @@ void dpc_process_error(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> +{
>> +	u16 reg16;
>> +	u32 reg32;
>> +
>> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
>> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
> 
> Make this read+write conditional on "if (pdev->dpc_rp_extensions)"
> as the register otherwise doesn't exist.

I'm checking for pdev->dpc_rpc_extensions inside 
dpc_handle_surprise_removal() before calling pci_clear_surpdn_errors(). 
Should I recheck it once again here?

> 
> Wrap to 80 chars per line.

Okay.

> 
> 
>> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
>> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
>> +
>> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
>> +}
> 
> A code comment might be useful here saying that in practice,
> Surprise Down errors have been observed to also set error bits
> in the Status Register as well as the Fatal Error Detected bit
> in the Device Status Register.

And probably move this code comment below to where this function is 
called inside dpc_handle_surprise_removal()..?

> 
> 
>> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>> +{
> 
> I'm wondering if we also need
> 
> 	if (!pcie_wait_for_link(pdev, false)) {
> 		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
> 		goto out;
> 	}
> 
> here, similar to dpc_reset_link() and in accordance with PCIe r6.1
> sec 6.2.11:
> 
> 	"To ensure that the LTSSM has time to reach the Disabled state
> 	or at least to bring the Link down under a variety of error
> 	conditions, software must leave the Downstream Port in DPC
> 	until the Data Link Layer Link Active bit in the Link Status
> 	Register reads 0b; otherwise, the result is undefined."

And include the above comment in code..
> 
> 
>> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
>> +		pci_err(pdev, "failed to retrieve DPC root port on async remove\n");
>> +		goto out;
>> +	}
> 
> I don't think pci_err() is needed here as dpc_wait_rp_inactive()
> already emits a message.  (I think I mistakenly gave the advice
> to emit an error here in an earlier review comment -- sorry!)

:)

Will take care of other comments below as well.

Thanks,
Smita

>>   
>>   	/* We configure DPC so it only triggers on ERR_FATAL */
>> -- 
>> 2.17.1
>>

