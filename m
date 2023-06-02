Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A953720B4A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjFBV5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFBV5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 17:57:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75201A5;
        Fri,  2 Jun 2023 14:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4dC45oQkmuOhYUj6MKKECgScXbanHWwYuwd/E0QwvGFtg4gwe1PiK5sRqF/nUEMGY7L+1VMmugnPw75WvR64/VfTYfz4eZgv8BRTX+M5DSgtQW3He6Zbp0UjWrhNOHmVg0A90Gb+YqaccIcRjUojMdAaZNswRYFHlbgmo4Wx8FHeTZjUCIE57biF0hF8SUMMefkzg+fQ8prf9+iXmmvpG4aE9oMlepBh4uXfNWq0+vPteNavoZcufStEkmlFCyBfEwDY+2zWRLBJS3PI2gkffBHwsbbiSu8RiMy7V01Ymou2sOFvY8ohYWs5I2jMEILbYodn9k1014hwl71nTJVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvn7Z5wiC2g/vY2+ej4namyaIY6J8phwPfyEsrP+MVs=;
 b=IxmoSaxM3LBwhqkn+2Kjx2vM8ON/tB1Khv9Opb/0BB6ZLzX8wOgyhnHFV1ypsvSMPCDKrHIxv6VUgOwyVLXMZ2T3Fq4gh6TeVDveiw9VArsvsWN/jVYFfHcC+u7QPz2Mhb7TZqCTA9jFtfAUwSUshNwkV6pkYP4JhWLwDsHKVpMTe7KwaFof7ZWCiIyp1JrBfGDcEMTb2dLQE/cBRmzKi52Ja0lOlkZVrxlw3y7zro4redFHPEpAxC13SGBBWUKONBDOhoQq+hj+3EZ1/dQ8NGlBZ5tFXagSYV5yDbntPR5dZzJKovsKopQYY6SL73IMawnjXezN4084r/gFX9sSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvn7Z5wiC2g/vY2+ej4namyaIY6J8phwPfyEsrP+MVs=;
 b=FFamkhlCKHK93h8uLPNbzgu75zLZX25xQ8192nOjQbkZ8pis41BzMUZcH6M09+PEdZrTd79RfTL0NjPUXMdAqYrptwkACXDy7WdmkFglEitkk0JPjJsyFWaX/eS6Ugmvmdm+3zpHvy/BbUyo+aI6UWpI114CDRmeMlKr2IqXESY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 2 Jun
 2023 21:57:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 21:57:28 +0000
Message-ID: <fda371a2-da84-c764-c809-2a361418b4ef@amd.com>
Date:   Fri, 2 Jun 2023 16:57:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI: Call _REG when saving/restoring PCI state
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <ZHpPOzT0nm+vddPq@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZHpPOzT0nm+vddPq@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0076.namprd06.prod.outlook.com
 (2603:10b6:5:336::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cd83b5-2945-4ca3-eb98-08db63b45b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MJ+bW8IQl3Pk2LVc1Lt7syBm3Lnj9a+v0DUAklCHtep/fJTWauLD9n2YhdYpgFT+/GBwtiy1Pf2p5SGRr+kIIAXgbGEdV0zGfrmqJFkEV3BaBLtMphzXx0p31kDirsCjKp7be06ykihX3oqBthw3U39ZpIpkldIMT/GiEOAC6sAcB71H1JnQVr620ZPSXaaKomm1Ow1KYvoyyFVgmuBRa0RlMsm+CL8bWTtYiH9HKj7SyTvP9iJBWVSWPHZP0VZNh9EjGhpy8Gj6g5jyugLYJwgjsm81nMpUIIqmvX5dZtjUuF+z/Lr+y0g32NCfx2JRGtVQWHVPI7eq/oFiiyd5SkEV8BQP/EZiKVu3ssl46321KeayfrH72j2+lDKzOKBSpc8wrz8TjOBuqEeURu/EA76C1w1Sv0hVC/2tYHW62xfyVc857ckpvPr3udDk8sei2TfFUK11QVWmAuq4zjfWhJSjye45xY1sc1qDtZSl6gMkmmlDAx5/Vac2/frwnPI/xt0ox6ws4WweFK1pFSafpagld5m/aha+fU2mYvKC5PZd5WPLQEJVK1kQt1jZGh7CfBriXv4iPrdT8PtWdYvQw5fRYX2VjSOAmbRS6WuCJKLMPuxfliSu8G69IHGNOMlcjnXAfRlJas2dGApDYtzqq4yj2ZOdKW0BdQepSwhC+3xiLjlpazslTybggANACm8BpyJTVnIJSGulhv+by0CJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(186003)(5660300002)(2616005)(2906002)(478600001)(316002)(4326008)(31696002)(6916009)(6486002)(31686004)(86362001)(41300700001)(966005)(38100700002)(54906003)(8936002)(8676002)(53546011)(6506007)(6512007)(36756003)(66946007)(66476007)(66556008)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpBOERqWlZYVzdma3dOK1RJSDE0Z3FlbUh5R0dVVEQzRkxMd1VjVDZyM0lv?=
 =?utf-8?B?WEZBNExhY2tPU2Q3UHFaMkw1L1FpNzBETVdjV29jbDZlVkVSMWUxRjZqcVZy?=
 =?utf-8?B?eEJ1REZaVmV2QzV5blh5QWZYd3pGRi9SVm8raVdSS0hTMThHUDk4TGZyQ2Zz?=
 =?utf-8?B?WVVFM1Z2RkQ4bXB5NHdtd2hoN0hWOStjb1NEZWMwQXVrbng3enlWK1JzUFlj?=
 =?utf-8?B?UVlxakx4NExSWTlqWFJLaE1iUVpMVG5oWFBUa0xib1diclNXbFdjUFV6VEE4?=
 =?utf-8?B?QnFaMDhiMFYwd3EwdnBFNDhyNnZ4RDhGOVVUZC9LdFdkVFYyRmpIbnNiTWdq?=
 =?utf-8?B?ZzNRTkxQWFhRSlJNcXJ6dy8vNGdoSmI5N3VwTG1rcjVEQ3hTZDlXc01lZzlo?=
 =?utf-8?B?a1IyaUgxT0Jod0NLVTY0YjV5blI0bytRRXg1d1BWajk4STZENlFsTWRiS3VB?=
 =?utf-8?B?Nk0yd1dtd2ZSejhzWmtqd1JWODdMTWoyVEFFZTBiRjFQZndQMENRbTltQmd0?=
 =?utf-8?B?anBGc1ovN3Rwb1V5aXZoeklGc0l3UWU5T3hsREQ1dHFKakgzY3JzelhaK3R0?=
 =?utf-8?B?cHM5cWhCbEhkY1JBaUNid1F1N3Z0bEdYbGV3aWIySldzLzVSZnI2cS9sSEpK?=
 =?utf-8?B?b1dWczBqVjN3UVNhYkgvZHpYL3ZuNWU0azhqTzl1empZZ3g1OXAxdjhKOFcw?=
 =?utf-8?B?UHJXZjlwdm1mUThuQXhHQ3Bic2RmMENrTmtqRC9LbUZNKzZOL2dqMGhjMTFj?=
 =?utf-8?B?OUliTE9QamJMS0M3b3B3REdNdXBER2lHTEwyS3FPS21VNmJ0Z1BDek9mYUl1?=
 =?utf-8?B?RkRrZjlBWW9rK2NxcVZTQ252MTlBZXBkaGtHZU1lUHFiWVdxK0E4emhEbU0x?=
 =?utf-8?B?Uno2WVl6c043NHlPVVJ4Tmg4M2FWVlNyZ2ltdlArenRVeGM3MHZYQkZzZDdr?=
 =?utf-8?B?a3JLOEtXU3lPQ3E5aXpZTGo0eDRHS2pGeWpZK0lSb0pESTV5dEpvbTJiR2kw?=
 =?utf-8?B?cXcvaVRhWE9uYzlQVGlzRlliR3FVd01mVU1Zb3RIVUNWeG9NWFlua3VTZks3?=
 =?utf-8?B?aGJ2SWZJbG9DczB1MHJBYnVBNVhrRHl0S2ZoMW80QlR2bGF3WCs3Y0FvSnoz?=
 =?utf-8?B?TzRHSWpXcUJKcFdJc09lZkFGVVJyOVlVVXczWEZ6WCtxZGgzVkFCbFQzNVRv?=
 =?utf-8?B?NDAwbXNkKytYSW5yY3Fab1lleEduZVpoN1hjM3lieU05RktFRWdQVURoMmll?=
 =?utf-8?B?dk1aMGU4dW43YzJ2OXA0Q28wVmNoU2lmaVpEbVEzNi9PdnJnODJmYmRSWVI2?=
 =?utf-8?B?aVpFOVZCWjMzQmQxTURNa3R3T0JqYXZocGZmUDZCSkR0Umtsb1FFUXpmRW1s?=
 =?utf-8?B?ZFptaWtaM0paTXJ6SVFCMjRoaExrSERqWXRUYmlhSzlWcXlyU2t1d3k2K2No?=
 =?utf-8?B?U25jQUdHb0pCVnRHSFhGWUppelZYUGYyUVIvSExnRlpiYkNyVUcwOGVLcGMr?=
 =?utf-8?B?Sk01SkRDN0VFVXZpZVcvTXhZNWdjSG1VTFM3dXF1d3ZoU25iU3Jiei81TElu?=
 =?utf-8?B?UlNObWhJSTc0Yk5SeUNYZjl2UWdBekpHaVpGelFCZ1NCWEhNd3cxbStSNWlt?=
 =?utf-8?B?M2p4Q1AzalU5eXFpTllpS2l5SEwvcXRMMWkzaEJSZ2N0cjhEdGhOZlE4YWRy?=
 =?utf-8?B?c0RzQ25GQ0IrNmQ2ZWJ6cW45ZGF0Q3BVVXVzSzdMQjV2VXY3S1pJd2w4YnFY?=
 =?utf-8?B?Q0hCbDM2UVdQWFJmazVoRW1iTE9JWiswc1V4aXhxUS92VTdzOWxuQ2phMkh4?=
 =?utf-8?B?REY2UmhxcGFqUGloaWNhY3FqV0N5Tm5PMU5FN1p3QXZEeUJqcGJHVTBQRVJI?=
 =?utf-8?B?L3E4ckFmWWprK0Q2aVd3Zy8yNGlIanFKM0xWK001djZ6SUNzSnVySENqRHBR?=
 =?utf-8?B?Q2xSQkJsWVVVRDdNaWFTYmhwOUFIQktNYXhVczZwNzRZYmMrWXNpK0RJajAx?=
 =?utf-8?B?SXZ1UDh6enQyN2czdTJYYUtXTVNCZ25PeldDak1PeVU2dzBBNS9BZXhPbXAx?=
 =?utf-8?B?OG9rY096YTEyNEpDdDJCNXlLajBLMkIreUZyZU8xNkp2MzN1ZC9wbktrT2RC?=
 =?utf-8?B?a0JaR1FEZmw4T2RtUUNjYXI4YTFxTU8yL3R6RnFLWnBWQ2Y2Z3dyMHlvRWZI?=
 =?utf-8?Q?7FA/vtfLl39rPKG1DaaPsZsZX58sSlwhpkjhTrdMbLe8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cd83b5-2945-4ca3-eb98-08db63b45b8e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:57:28.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BssF+9f6b7RPidOfFUswQcpnp899XRRVBoVXrIqpMyJA7luY/tjn4KkUt/EWornqZ5zkBqoalMNQgN0pH4EONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/2/2023 3:21 PM, Bjorn Helgaas wrote:
> [+cc Rafael, Len, linux-acpi]
>
> Hi Mario,
>
> On Thu, Jun 01, 2023 at 10:11:22PM -0500, Mario Limonciello wrote:
>> ASMedia PCIe GPIO controllers connected to AMD SOC fail functional tests
>> after returning from s2idle. This is because the BIOS checks whether the
>> OSPM has called the _REG method to determine whether it can interact with
>> the OperationRegion assigned to the device.
> "s2idle" is a Linux term; I'd prefer something that we can relate to
> the ACPI spec.
It's important for the symptoms of this issue though, this
problem doesn't trigger "just" by moving D-states.

It happens as a result of system suspend.

>
> Maybe a pointer to the specific function in the driver that has a
> problem?  Based on the patch, I assume the driver uses some control
> method that looks at PCI config space?

The issue isn't in anything Linux code "does"; it's in the "lack"
of Linux code doing what it needs to IE using _REG.

At least for this issue _REG is treated like a lock mechanism.
In the spec it says specifically:

"When an operation region handler is unavailable, AML cannot access
data fields in that region".

That is it's to ensure that OSPM and AML don't both simultaneously
access the same region.

What happens is that AML normally wants to access this region during
suspend, but without the sequence of calling _REG it can't.

>
>> To fix this issue, call acpi_evaluate_reg() when saving and restoring the
>> state of PCI devices.
> Please include the spec citation: ACPI r6.5, sec 6.5.4.  The URL has
> changed in the past and may change in the future, but the name/section
> number will not.
Sure.
>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e38c2f6eebd4..071ecba548b0 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1068,6 +1068,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>   	return acpi_pci_bridge_d3(dev);
>>   }
>>   
>> +static inline int platform_toggle_reg(struct pci_dev *dev, int c)
>> +{
>> +	return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
>> +				 ACPI_ADR_SPACE_PCI_CONFIG, c);
>> +}
> You never check the return value, so why return it?

_REG isn't mandatory for any of these uses, and I wanted to make
sure that if it does end up being mandatory in a future use that
the return code wasn't thrown away.  If you think it's better to
just throw it away now, I have no qualms making it a void instead.

>
> The function actually doesn't *toggle*; it connects or disconnects
> based on "c".
Can you suggest a better function name?
>
> This looks like it only builds when CONFIG_ACPI=y?

The prototype for acpi_evaluate_reg isn't guarded by CONFIG_ACPI
so I figured it worked both ways.

But looking again I don't see a dummy implementation version for
the lack of CONFIG_ACPI, so I'll double check it.

>
>>   /**
>>    * pci_update_current_state - Read power state of given device and cache it
>>    * @dev: PCI device to handle.
>> @@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>>   int pci_save_state(struct pci_dev *dev)
>>   {
>>   	int i;
>> +
>> +	platform_toggle_reg(dev, ACPI_REG_DISCONNECT);
> I would expect these to be in the PM code near the power state
> transitions, not in the state save/restore code.  These functions
> *are* used during suspend/resume, but are used in other places as
> well, where we probably don't want _REG executed.
>
> Cc'd Rafael and PM folks, who can give much better feedback.
My knee jerk reaction when we found the root cause for this issue
was to put the code right around the D-state transitions, but I
decided against this.

I put it in save/restore intentionally because
like I mentioned above it's treated like a locking mechanism between
OSPM and AML and it's not functionally tied to a D-state transition.

When the state is saved it's like Linux says
"I'm done using this region, go ahead and touch it firmware".
When it's restored it's like Linux says
"Don't use that region, I'm claiming it for now".

Think about that other patch I wrote recently that controls D3
availability [1].  If it was only run in the D-state transitions and
the root port stays in D0 but has a _REG method it would never get
called.

>>   	/* XXX: 100% dword access ok here? */
>>   	for (i = 0; i < 16; i++) {
>>   		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
>> @@ -1790,6 +1799,8 @@ void pci_restore_state(struct pci_dev *dev)
>>   	pci_enable_acs(dev);
>>   	pci_restore_iov_state(dev);
>>   
>> +	platform_toggle_reg(dev, ACPI_REG_CONNECT);
>> +
>>   	dev->state_saved = false;
>>   }
>>   EXPORT_SYMBOL(pci_restore_state);
>> @@ -3203,6 +3214,7 @@ void pci_pm_init(struct pci_dev *dev)
>>   	pci_read_config_word(dev, PCI_STATUS, &status);
>>   	if (status & PCI_STATUS_IMM_READY)
>>   		dev->imm_ready = 1;
>> +	platform_toggle_reg(dev, ACPI_REG_CONNECT);
>>   }
>>   
>>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>> -- 
>> 2.34.1
[1] 
https://lore.kernel.org/linux-pci/20230530163947.230418-2-mario.limonciello@amd.com/ 

