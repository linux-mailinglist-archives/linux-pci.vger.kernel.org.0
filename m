Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB65695F4F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjBNJeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 04:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjBNJeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 04:34:06 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666F24136;
        Tue, 14 Feb 2023 01:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEDudvlJyyiUT4rlFIDC4RLVGzoXQSkV1CSrpNW8++uE8W83or2Va6im+OKPia6KW8j4VhRFTLTSRMFrtPBjxonvnvNd72BlH3caiggK9S+0afWHMiL8Txv7ryyJ0tZCWorXBm/SUE47YaNVNyKqw5jQ28LBBb599hUBPvFLNTw3BLcpUqY1yUPuCR2Z47p1CO3F0AyTB0gZNSA7l0GgifLbnhhhBTvKMMylalnkZ1wv2rlttOm1dlRiY3uaiEQaqC7yn5OawADyGEBZYtGSh2Hh+Aj8HY8TiHHUV5YK4hMsv+0MEtzdLY1GnvQHqI1YXB+YwkCwYm4eUfquE4V30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P912S+QDz4R/+IrTbuzNC6tSp/U862/JgjUYRA+tOH8=;
 b=lYdTf+qdlmDVoySXTaG44ZOoxQqjVAoF4i4GJRs/KWrQqS6/puJmIwF42lPZCT4iDUQL02CPrTBBhFU9tONSGdq1yFyfeLhk881UHhq386QDCOwaQLFCrNCeEqb7QpgAFh9F+jE0EhRc65XdajAgE6NlK22w0viooiQ1+hETECI1eVj+kA/sYFV+4fkc5h1n5ROcC3aEng/hLDbSPSsvnt/LfkrqcFf4jhsc+8aE7Q4+3g+W6g4ovmhskiGUQhupJPDAmnI/p7Zh2ETYc5WEdOHtK61W1RQoVnXE8E5vfKuDdiNnCN+xNNnNKs+3cdg4CtlZF40Taf5jbt7xd8jrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P912S+QDz4R/+IrTbuzNC6tSp/U862/JgjUYRA+tOH8=;
 b=4BqIWqpCOWJufcm6vpp6S/C1QdJWp1bOPFNMT9SKzPS4yQDjBVXvUsW44Vte1+RYvag61+GCGfm30pcjta0wAdMI6mjZzKE+2Y9nr4F9u/Snu28Sjhklss8OmPuNHQmpXwik+FnJNn+vKqVnkWq955R/Ug3CSj+AiTkZkxt+8l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 09:33:56 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b9ce:8f83:d620:4151]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b9ce:8f83:d620:4151%4]) with mapi id 15.20.6086.017; Tue, 14 Feb 2023
 09:33:56 +0000
Message-ID: <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
Date:   Tue, 14 Feb 2023 01:33:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221104101536.GA11363@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20221104101536.GA11363@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f8cb5c-59f7-4a74-849b-08db0e6e97f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erojz9TrPVy/XXI71grrm6jGMooiGrbDGX53DymxJRgVFYgpB8GONwK6ZPYjqQ0SnEql/vKOQt/qmeefoqo9zYTKcvRD9OP4ExLwvIN6fFjGGPnzQtn0ySnE9Nofa2t330O1LCqfmxE7EN4q0gmxgYFFIWbxBoAf0UQUHlaHe2LavrZaubeDW3r1lpLbnmfcVuSxyMhDMfauuERQRtqWx0g1oxQV7pxmGm8fsnCEC8ZmVS6/aWU9x1AuqwAdm7kNfPrOtBP+WyYE7tRGMKMd6SOgcT0D5WLhP4QezrFFEOAIaK9i0/LIgCy0b4AuDLg31uWwdmEW+m8HpZ3QOP4DYrzq2zEoCW00COFsyJ8kYpiKCYdZZKnVtFeuNKHphQYis4geimimKjB9V2NUgHsQlBN10jXSgyVAEmbh8TkScpvq0cisDiYwwoF7bZoytVna6I9KIzJ1ubUvEOqm7QC9T80X7YvLTu4SOFCiw1IKm1JHGqJoNj9hnopT4IcuOgIWF5BEVbM3l0om8DQqJFM8LHwEV+NriUsqfYU2tkIA0myLXqG1Iz3OmSSYxHukBTjUcj44ezbcAkyWvHzgU/CmdfFo374NV7ptdBa0VYjwiAeYsniA7HeQbrVTuy50X355WKe5FGZNz//CuzEcjL9KqEsc1rdkeujmJCPR+B3eOS3Lc3TPIH7fbRoHrWo+0/zcTGda2sS1UCOEkXcR/2I29xOXKl4MjLbnK3ePV1kvv/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(36756003)(2906002)(5660300002)(31696002)(83380400001)(26005)(186003)(2616005)(54906003)(38100700002)(66476007)(4326008)(8676002)(6916009)(66946007)(66556008)(316002)(8936002)(41300700001)(478600001)(6506007)(6512007)(86362001)(53546011)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGoya0lnRFVnaTV2bmVzbEhoREFPWDdhb2JvTXJGcjgrMzVkdFBTaThUSE1z?=
 =?utf-8?B?OWZPajdQYk5LMHhLM2dpWDNSa29jNFdRc2J2cjFIajBKS2pFWVV0U1ZzcDR4?=
 =?utf-8?B?dFV2eFQzSUkxQi9jSGtoZ0pKMTYyQTNJd0VwWWtxbyt6azlXNzFGYXBYRUcr?=
 =?utf-8?B?by94ZjlTdXlOVVRlZXJmM1p5QzdaWm03TVlBUjZpZlIyWEZzeTZwUFBKcldB?=
 =?utf-8?B?K1ZzVFdHT2ExS25ZUERzWEhhWTJ2UzVDYUlvNFZSRTNOMW9uZm5MR2ZNMGhz?=
 =?utf-8?B?aTBWK04xL1Y2cUE2d3J1ZUpGSE1sWFdNTll2TEwzcmQ5V2lTalJOUUZrNmtv?=
 =?utf-8?B?Z3hoaWxIYnNVbThPOXJjWGh2bXFJZEJNSmU2YmFydm1CbWNIL25xN09SSGpx?=
 =?utf-8?B?citEZzRzQmQ1YmhxWWtRUzNNNUtFYTZxT3Vac0NRUmdKa3h1SzBhVGI0YUZs?=
 =?utf-8?B?Umd4RzlhY1QvUGlaK0J6bytEQWtnTVg3NTVKbFpqUnB0aGV4LzFvcG9HMEpq?=
 =?utf-8?B?eCtydEhGUzQ1ZVREM3orTmNDaG1HRDV4dkRvK25PWUd2TjRhbnFzRG05cFFP?=
 =?utf-8?B?Q1BqTnBTSnJ0ZUtyUjVtTnJhUlVDdlcvdndsZjFCSU4xVzlwemR6OTFpWUZz?=
 =?utf-8?B?QnJEZnh2bE5tbWRDcE9XVnMrb0VsbFp1M3ZQbHZDcElQMFlHR2FHWHRTb1M5?=
 =?utf-8?B?eld1TnZyUzgraCtTcFpldFRXejNieFU5QkVUeUxuSWVhK1pkS1NaY3pENjI3?=
 =?utf-8?B?TFVuZWZTZ2F3TG5mR0lEZEtNT0tEektkSnVlSU9pYWkvUTdNRWsramVCd3By?=
 =?utf-8?B?azExZzI5dGZaQ2VybG1iTEJaZW5NQVB0dGZ1YjVuTEg1T3gzSDlBdUUrbUEw?=
 =?utf-8?B?eGFMRjVENnorUWpoN0paaGF1dDMxSzlDMVZjWHVlcTEvay9Nb1AwRXlyaVp3?=
 =?utf-8?B?cGlrczlrS3NyeVBGOUtDbUtzSlZzYlR3bEFiSmJCMUlvTVFYK3plbUZubjJF?=
 =?utf-8?B?MmladlBISnNldGpWMUlwMExSMU9zWFFCTHZVVXZkNHcxd3g0UStuVXJ0bUQx?=
 =?utf-8?B?dXljUG9HRXkwVUg5eHhYdWNud0YzdVFYSTBGNEJ4WCtESUt1OU5zWmJ2cW42?=
 =?utf-8?B?N21YVU4zZWFkeE1vNHlvcDU3MEoyY29peDkwd2N3YnczS0FQRFFzdGttZ3Ez?=
 =?utf-8?B?QzFRNGVBbk9JbU9pTXpIN0h2M1prSDY0SjdEaGlZY29OdUp4UWlmTU9WS0JP?=
 =?utf-8?B?eWxxaGVsVWVSZUk0eTR3YkRkUDRvWVl3KzFnVm1vYjJBNE4wVkZtaDVVZHNj?=
 =?utf-8?B?cktFWFJDaE5FdW82c25LdVBySE5uMzFqOHlNRVMxY1RyV2NoRnFOQ2twMmps?=
 =?utf-8?B?QStFajdOWVUxVE16Y05xUTlNT0YwWEZWMlcxWE1LVUFISkREYzNEL0o5NjJR?=
 =?utf-8?B?cVVlTTZBMDIwbXIvQkNGTnA3TGZRbkJZdVlDVjhNZllsU2tzVVlzM0tOWEZZ?=
 =?utf-8?B?NFVjdjRLUnF5b2E5QTRneXlncmFRVXBXUDdTZjU5SXRtU0k3KzJaUndJczdi?=
 =?utf-8?B?akpTL0FyZkZzMGRWSGRBVUVNdXpGenVpWFZ0bnhNRFluS2FhOHJrSUxWeWNN?=
 =?utf-8?B?cVFVWXlHR0pVNE9wY2dYNWd0dUtZcU5jc3lUSStwSnFEMTNzL0FobkxFaUNm?=
 =?utf-8?B?VDBuU05XWDg0RU9OTFVrdVJzRjFYbXVVRTRaRjdHdEtpMGJ5NXNqemg1UFlo?=
 =?utf-8?B?WDJmL0RYL0s5aUlLVXRZbXhaczFRdGQvQjBQZzhVYmtnR0NPTEdIUmdUKzVF?=
 =?utf-8?B?azZyMm85UzZiMnk4bURXN0ovQ1B5Rk45b0dkZHdHbktOd3ZKVUY4c2FrQXJB?=
 =?utf-8?B?aktRa2RKMHE5elkvNFFpWDZZVUlXcTZ3UzFXUkJnZlZBNkxIblRuc04yRkxZ?=
 =?utf-8?B?QzVnTm92L1hQQnBsYld4YnpOTE5ReFlNcXVlT2ZsQTVtZkdpV0RlT3hORVdG?=
 =?utf-8?B?ZWlsVVZsYmt6dlY1Y05udS9BcEtRWE5PNjZxL283NVNVUkwxVWgxSjY3K3hl?=
 =?utf-8?B?OGowZkdaRUxNUVg0bVgzS1cxYTBOVUd2a1oxb2RvRitxSzQ0dkZCcnNHR1RW?=
 =?utf-8?Q?hX8af+/eiynJNJytL2TV9lmuq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f8cb5c-59f7-4a74-849b-08db0e6e97f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 09:33:56.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqweDdDAReAHaCHN+j0fcNF413yH50ZcWyhm1DOSfbO1SbiJQm1ha1BSNr3VpjW0csE92ZfqCtBWo3TDzoYfhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/4/2022 3:15 AM, Lukas Wunner wrote:
> On Tue, Nov 01, 2022 at 12:07:18AM +0000, Smita Koralahalli wrote:
>> The implementation is as follows: On an async remove a DPC is triggered as
>> a side-effect along with an MSI to the OS. Determine it's an async remove
>> by checking for DPC Trigger Status in DPC Status Register and Surprise
>> Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
>> treat the DPC event as a side-effect of async remove, clear the error
>> status registers and continue with hot-plug tear down routines. If not,
>> follow the existing routine to handle AER/DPC errors.
> Instead of having the OS recognize and filter Surprise Down events,
> it would also be possible to simply set the Surprise Down bit in the
> Uncorrectable Error Mask Register.  This could be constrained to
> Downstream Ports capable of surprise removal, i.e. those where the
> is_hotplug_bridge in struct pci_dev is set.  And that check and the
> register change could be performed in pci_dpc_init().
>
> Have you considered such an alternative approach?  If you have, what
> was the reason to prefer the more complex solution you're proposing?

By setting the Surprise down bit in Uncorrectable Error Mask register we 
will
not get a DPC event. What I know so far is, we cannot set this bit at 
run-time
after we determine its a surprise down event or probably I don't know
enough how to do it! (once an pciehp interrupt is triggered..).

And setting this bit at initialization might not trigger true DPC events..

Second thing, is masking Surprise Down bit has no impact on logging 
errors in
AER registers.

So, I think that approach probably will not resolve the issue of 
clearing the logs
in AER registers and complicate things while differentiating true errors 
vs surprise
down events. Please correct me if I'm wrong!!

I did few testing after I read your comments.  What I realized is that, 
these DPC
events (side effects of hot remove) are actually benign on AMD systems. 
On a hot
remove I see a Presence Detect change and a DPC event. This PD state change
will trigger a pciehp isr and calls pciehp_handle_presence_or_link_change()
and disables the slot normally. So essentially, this patch will boil 
down to the point
to clearing the logs in AER registers and also handling those error 
messages ("device
recovery failed"....) in dmesg which might confuse users on a hot remove.
What do you think?

Now, I'm not sure whether there will be a PD state change across other 
systems on a
hot remove when AER/DPC is native (OS First) in which case we should 
call the
pciehp_disable_slot() from dpc handler as well.. Any inputs would be
appreciated here..
>
>
>> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> +{
>> +	u16 reg16;
>> +	u32 reg32;
>> +
>> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
>> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
>> +
>> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
>> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
>> +
>> +	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
>> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
>> +}
> I don't understand why PCI_STATUS and PCI_EXP_DEVSTA need to be
> touched here?

This is just to mask any kind of appearance that there was an error since
the errors would have been induced by the hot plug event (just duplicating
our BIOS functionality here..).  But, please let me know if OS is already
handling the things here and if it is not required.
>
>
>> +static void pciehp_handle_surprise_removal(struct pci_dev *pdev)
> Since this function is located in dpc.c and is strictly called from
> other functions in the same file, it should be prefixed dpc_, not
> pciehp_.

Sure, will fix in v2.
>
>
>> +	/*
>> +	 * According to Section 6.13 and 6.15 of the PCIe Base Spec 6.0,
>> +	 * following a hot-plug event, clear the ARI Forwarding Enable bit
>> +	 * and AtomicOp Requester Enable as its not determined whether the
>> +	 * next device inserted will support these capabilities. AtomicOp
>> +	 * capabilities are not supported on PCI Express to PCI/PCI-X Bridges
>> +	 * and any newly added component may not be an ARI device.
>> +	 */
>> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
>> +				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ));
> That looks like a reasonable change, but it belongs in a separate
> patch.  And I think it should be performed as part of (de-)enumeration,
> not as part of DPC error handling.  What about Downstream Ports which
> are not DPC-capable, I guess the bits should be cleared as well, no?

AFAIK, DPC will work on all AMD root ports. I'm not sure how could we handle
on a per port basis if the bridges/ports downstream to root ports don't 
support
DPC..
>
> How about clearing the bits in pciehp_unconfigure_device()?

Okay.

Thanks,
Smita
>
> Thanks,
>
> Lukas


