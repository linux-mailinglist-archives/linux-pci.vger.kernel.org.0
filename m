Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496276B9FCD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCNTbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCNTbc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 15:31:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A023402B;
        Tue, 14 Mar 2023 12:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNZhNhO2Xc2+BX7TY3tZAb45Z7n0kvZjwG/APSp2rBnt+D8ic0lgptuOvUg+s8v3AJ3mEIF35UQvVoAkYgDud692RYhHPow/RiACujpXKDQFwnzJ6USSzhr3wwAP5dp2n0n7NlxRqMtIRDzRGlF/L4MVqngVskzZ5GFey0QioL48IcOiiLNXH82wshbY+z0WKWgs6qO92t5RnMBD0VBaXfwMgV/W13V6ojbGh3Qt+YI+Cn/Xg/gj7pZ11aWWCUWrgarrkEohQVwHVmwR2bRRVOZyAcNGQwh4ga4Eq7DP1Iu5EH1twtXUT67t+KO2sB3xKIwVMWHR6TGQERHLM6WmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgZwmCcF+BYpoxGF7DW1UprGZxvNJw7iO3GuPFl/abw=;
 b=YFrY8VAdeA+Y4UiLgzn2KRRsh4OFni3pWAX+M3+5hE3cvanmplNwBWaHQoxXsUmze1Xc6OiqbrkHKcOuJAucnskGF61yCDiBeXsI9wdv6IQVp7V9XYojiwZnGVOOG8nIBcS8yO+j8A+RxcaXmNVpzxhZjLWfLjp4mq3UVTt4C8uv/AUGXNQcJQT5sZ5GKaLXp3lvYUcmnb5RW1DFze4J9YWEmD0KCaM5F5o7k7PBsxUBVLJx5/bzClpVXXRWw8KQ5Z88vUswBhOdxGqltgnbluvUInfhwhOJMqk6thCNYFl+FO37hP/O/KbKDGQNzD71c9sW/y/RoT+pvgoABJ0YGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgZwmCcF+BYpoxGF7DW1UprGZxvNJw7iO3GuPFl/abw=;
 b=MRatMdCfR/gREQhxd9cBTYVI0CxPTXYf4C6uZW5GDNJuVE6SjfK104drOCmxm+BO3fcsytBUB8s9xi727bOHYq0ZzVCFXq8Z1nkQwUf6iu/1yuaVfhLTIgnC3Lh0PTBPm3jkYZZblfHgZcrne99CJh55HIyjDjE+1oEBWmcvhCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 19:31:13 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::621d:41fe:f851:fd7a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::621d:41fe:f851:fd7a%4]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 19:31:13 +0000
Message-ID: <31064f33-2a34-1855-6729-a4efe32b10e8@amd.com>
Date:   Tue, 14 Mar 2023 12:31:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Content-Language: en-US
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
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
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
In-Reply-To: <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f1be5c-af55-4edd-975b-08db24c2ac1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkBf3DFXbe2IVblwGkcHeag1xI1wkWuBjrEMZLAmbS8B6+8E2ztBYikdBKu12pPeLCXsb3GEj8kcNwXYbrDvq+vOXqeNQwX5//0BiPwvJXF8WoxTId6aPY26YF8PJsv62iBXAlb+iFMkCrld6O4VXYw3EK5hESVlZKWulXc95iAoPND0XdfIx+Ooc0lPNNhR9nwW8Ka4Uje7gTiU7iRv9A3vs9/wH0EkO4Txon56RZzsNP7mT+kC6mBcNvEUqLxYp19+53P8u7xk51HjOwP/tUIcYay7ClltYpEChXNVCBGfHvqi+csrSEN90UCJFROm/Z1UL6HqD9t/xrNk161kMuDfQSJH/ppjgf4alq7Z3MoRa1Yx/Przq+l7HTPaRhF+7s6fiA6SYcT6c54Ox9G5xACyahinW6h6i49CgdGgs+8DGacECiNm7czV19GW2l2wpDNEMLosw+ZpsWg6O8LZ/7PZLcI8kZ49WALqxg71G2maunKm/YcXRN4OYGdiTo9B9g8i/iOeI2PQzVlzPEt4IklqLMxAN0301VVLlDx3Vs+XdwpEOTD2YzTbz9qiCE1fEdNVC+Jatkml+R5p//MFO0scJsM1l/sXkTZ4P74GYQ/+Wqainvf/30SjU+hVbblhuvMgk29p1Wl+IIbUnuNkQJj/DBMZ2DfHj1lWLWyboMpRHdcGYJ1iGeWItsHsUQWyj4+fuS+SuHdJXT8gNqO/Y0URT0bVPrMJsyk8rYlbYWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199018)(31686004)(6486002)(66946007)(66556008)(66476007)(478600001)(26005)(6506007)(6512007)(36756003)(8936002)(41300700001)(2616005)(5660300002)(316002)(83380400001)(8676002)(6916009)(4326008)(53546011)(31696002)(186003)(86362001)(38100700002)(2906002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJ6eFB3c0FXMytmQm91bTdJTVNBWTFwckNUWE02eGNRblJUYmc3YjFHdC92?=
 =?utf-8?B?OU1JT0FXODYwSkMwclEvamUwS3pFeXNUOFg2VTNYQzY1MXpMbXNPcWM2Rllt?=
 =?utf-8?B?anpvRUdzd3hlYVlJbjBNb1Z4UDAvRWVjS1ZKUCsvOE83U045czhuUVZyQWlR?=
 =?utf-8?B?MExuNFFFUGdzcDFEalJPR3VWSnhmaHFhRENMd0hCbGdtSENVRVA4L0dITjBn?=
 =?utf-8?B?cW9LTWhBNUF4U2hiSVF5WUdONWhyb0hzUG16SkFyN3VhbUF3U1ZPYTAxQkk4?=
 =?utf-8?B?ZzI3K2prWFkvdHptald1OXkzK3RVSGZ0OWcrZ0xMK2ZWTlN5MlBFRmZNL3Qy?=
 =?utf-8?B?ZlFVMDh0ZXlpK3JxbWxpV3NoaysvZ1A3TnozN1MwMGZDSElEbWl6Z1ZJYnBo?=
 =?utf-8?B?OWlMaXdEUGdDRktmRkQrVFJXWVhDTTc0THpjeDZpcjYxOVVPRWNqalhLUEFJ?=
 =?utf-8?B?STczY0xrVXYwUWtRZURLSkhQb3p3K0VDYWUzSVJKcVpacE9JMWFFRnl4d2ly?=
 =?utf-8?B?QWloQURqVDE4SXliRC9TL2k0ekpYa3Rnb0ZWTXRRYlRpTmt2dGh2cGoyTU1N?=
 =?utf-8?B?U3gwTk5MeFJXN1dzV2tJeUxkT1VhQVVTVnFQeDR4Y3cza2lSQlFTenowekVv?=
 =?utf-8?B?d1NieUVwUmhOOVlnUE90ellxMmNFWGlKL3BDSEhMZGkwcjZ5ZStUN2N6NHRB?=
 =?utf-8?B?RVhVQytGQkxjL1phUXJoMDNrMnpZWG5aRE5NRm4rdGJ3RUxRM29DdXRRNW5B?=
 =?utf-8?B?dVlDZk5GUlQzSG5UdkxIVVZYS0N5YkNYeDFLbnUyUEczL2dNQWg3NEVpeXVU?=
 =?utf-8?B?QUNGZGZnWGNzMkZ5Z1duODR6V0J2cWpoR1dSK3JXR2QwazR2MVlnMmZhMFVI?=
 =?utf-8?B?dHFiNUYzWjlNRFJNWW5LMmQ2Vis2bUtqOFRDVUJnS2FqOFpQS2U4cHB4WUZG?=
 =?utf-8?B?aTFXNTRWZVAzTFoybjJ2OUk5MFVzdk92OC9lVC9TbjArTXdsalYwQ0xSSVFP?=
 =?utf-8?B?blExUDVXUnczYXFIdEFKMmhDUWJndjRxZHlKTVk5eCs1S0p4Wmtuc21FVGJu?=
 =?utf-8?B?QzFvaDRxbDlzcXhrYy8xNTN2UjVHZlJ3VnI0ZHY5ZFdFWmp6OXJCbnhac0k4?=
 =?utf-8?B?MythdUl3SWNkdk8zM1E4TUs0d2owdkFzbEVJSzVKcE1odkFIa3UvY3VQVThK?=
 =?utf-8?B?d29MOG90ZGphTytwRmNGU2hYQ200NWVOY1RpUlZ6S3hnay9VOVk5QXhaYlJN?=
 =?utf-8?B?UFN4U3krZGJvMjlHZUVEK1YwK29wZFNJeHB5TytpOWN6dmlQbWNKOHRIclMr?=
 =?utf-8?B?Ni9ZV2tGLzNzbHd6d0E5NVJPdmhvRDdzUnNrbDFqVTUyalMrbktOdVZrZEkw?=
 =?utf-8?B?Wnpjb0pqSnhabFl0THpOR1lYMGdKemZLMG9seFNOUXR0MmhrZjBHOTJhOXQx?=
 =?utf-8?B?dVNURG9tQVF2V09PNUF3R2tNdHBzS0N5YzJ1ZGpHeGgwN0hLMDgyYmVDaHBC?=
 =?utf-8?B?bm5acmxySmdxSGpMTkgwcW9TNnM2RXlvVExEeTFibEh4aWhDZlpTZmRBUDRt?=
 =?utf-8?B?MlBucG9KaWNLZU5CVTg5MmJMWXhseEVCTHluQ1lyUFNFSWdBMDM4R3pxUDVs?=
 =?utf-8?B?cjVXWFpXUWxEOVYrTU01bXRUTXZLaW85emZGWktaS1ZMR3JHL2pMM2NpNUpY?=
 =?utf-8?B?TnpiSUE3RFVSWXcyS3BQNFdDaFFncGl1TmZHZHdCZTk0dTJmMTY1cU9zaDUw?=
 =?utf-8?B?dUV3NFlEYStUektBMkZ2dlJtK2F6SjA0blJJMWF0MlpIeVRjVlJtSk9QU2d4?=
 =?utf-8?B?RkQ3VmVLOG04NnVpRDkyVkNMZE82R1B2ZnRObmFHbS9XS2FHd3ZXQndZazZx?=
 =?utf-8?B?SEN6K0YyQlVVeXY3N2g0dFVlc1JYSWJGczBnVkROanFWUjUvRlczUU1rRWUz?=
 =?utf-8?B?TzNhYll1RWJ6V0FmZWEyejF4eUs3bFZLWmc5Q1g5VkZXQkRQZTVhMVQ0Zlow?=
 =?utf-8?B?bnIwMXZOOUZ5OXdIc2NHb3Iwa3N5WThjdWVrWEFqZUlTRHlDT1pMTlpFaHNw?=
 =?utf-8?B?TWM0Z1pMQzFPVGR3S3I3WTRzL2RudE05aGJLbHFoMkRxdjdWcWRQZFZxZzEw?=
 =?utf-8?Q?NcluOHxdj8mf0Ius+aSarKqS3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f1be5c-af55-4edd-975b-08db24c2ac1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 19:31:13.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cys1ymrYggJZMJRHaBLzZaIKAZrwkke0NP9TSBVur2PXl1IMMMv0PSecr177VTNV0nZ06tBjo+g31hBjb4HYRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Please let me know if I should redo this on latest tree and discuss my 
comments there.

Thanks,
Smita

On 2/14/2023 1:33 AM, Smita Koralahalli wrote:
> On 11/4/2022 3:15 AM, Lukas Wunner wrote:
>> On Tue, Nov 01, 2022 at 12:07:18AM +0000, Smita Koralahalli wrote:
>>> The implementation is as follows: On an async remove a DPC is 
>>> triggered as
>>> a side-effect along with an MSI to the OS. Determine it's an async 
>>> remove
>>> by checking for DPC Trigger Status in DPC Status Register and Surprise
>>> Down Error Status in AER Uncorrected Error Status to be non-zero. If 
>>> true,
>>> treat the DPC event as a side-effect of async remove, clear the error
>>> status registers and continue with hot-plug tear down routines. If not,
>>> follow the existing routine to handle AER/DPC errors.
>> Instead of having the OS recognize and filter Surprise Down events,
>> it would also be possible to simply set the Surprise Down bit in the
>> Uncorrectable Error Mask Register.  This could be constrained to
>> Downstream Ports capable of surprise removal, i.e. those where the
>> is_hotplug_bridge in struct pci_dev is set.  And that check and the
>> register change could be performed in pci_dpc_init().
>>
>> Have you considered such an alternative approach?  If you have, what
>> was the reason to prefer the more complex solution you're proposing?
>
> By setting the Surprise down bit in Uncorrectable Error Mask register 
> we will
> not get a DPC event. What I know so far is, we cannot set this bit at 
> run-time
> after we determine its a surprise down event or probably I don't know
> enough how to do it! (once an pciehp interrupt is triggered..).
>
> And setting this bit at initialization might not trigger true DPC 
> events..
>
> Second thing, is masking Surprise Down bit has no impact on logging 
> errors in
> AER registers.
>
> So, I think that approach probably will not resolve the issue of 
> clearing the logs
> in AER registers and complicate things while differentiating true 
> errors vs surprise
> down events. Please correct me if I'm wrong!!
>
> I did few testing after I read your comments.  What I realized is 
> that, these DPC
> events (side effects of hot remove) are actually benign on AMD 
> systems. On a hot
> remove I see a Presence Detect change and a DPC event. This PD state 
> change
> will trigger a pciehp isr and calls 
> pciehp_handle_presence_or_link_change()
> and disables the slot normally. So essentially, this patch will boil 
> down to the point
> to clearing the logs in AER registers and also handling those error 
> messages ("device
> recovery failed"....) in dmesg which might confuse users on a hot remove.
> What do you think?
>
> Now, I'm not sure whether there will be a PD state change across other 
> systems on a
> hot remove when AER/DPC is native (OS First) in which case we should 
> call the
> pciehp_disable_slot() from dpc handler as well.. Any inputs would be
> appreciated here..
>>
>>
>>> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>>> +{
>>> +    u16 reg16;
>>> +    u32 reg32;
>>> +
>>> +    pci_read_config_dword(pdev, pdev->dpc_cap + 
>>> PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
>>> +    pci_write_config_dword(pdev, pdev->dpc_cap + 
>>> PCI_EXP_DPC_RP_PIO_STATUS, reg32);
>>> +
>>> +    pci_read_config_word(pdev, PCI_STATUS, &reg16);
>>> +    pci_write_config_word(pdev, PCI_STATUS, reg16);
>>> +
>>> +    pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
>>> +    pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
>>> +}
>> I don't understand why PCI_STATUS and PCI_EXP_DEVSTA need to be
>> touched here?
>
> This is just to mask any kind of appearance that there was an error since
> the errors would have been induced by the hot plug event (just 
> duplicating
> our BIOS functionality here..).  But, please let me know if OS is already
> handling the things here and if it is not required.
>>
>>
>>> +static void pciehp_handle_surprise_removal(struct pci_dev *pdev)
>> Since this function is located in dpc.c and is strictly called from
>> other functions in the same file, it should be prefixed dpc_, not
>> pciehp_.
>
> Sure, will fix in v2.
>>
>>
>>> +    /*
>>> +     * According to Section 6.13 and 6.15 of the PCIe Base Spec 6.0,
>>> +     * following a hot-plug event, clear the ARI Forwarding Enable bit
>>> +     * and AtomicOp Requester Enable as its not determined whether the
>>> +     * next device inserted will support these capabilities. AtomicOp
>>> +     * capabilities are not supported on PCI Express to PCI/PCI-X 
>>> Bridges
>>> +     * and any newly added component may not be an ARI device.
>>> +     */
>>> +    pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
>>> +                   (PCI_EXP_DEVCTL2_ARI | 
>>> PCI_EXP_DEVCTL2_ATOMIC_REQ));
>> That looks like a reasonable change, but it belongs in a separate
>> patch.  And I think it should be performed as part of (de-)enumeration,
>> not as part of DPC error handling.  What about Downstream Ports which
>> are not DPC-capable, I guess the bits should be cleared as well, no?
>
> AFAIK, DPC will work on all AMD root ports. I'm not sure how could we 
> handle
> on a per port basis if the bridges/ports downstream to root ports 
> don't support
> DPC..
>>
>> How about clearing the bits in pciehp_unconfigure_device()?
>
> Okay.
>
> Thanks,
> Smita
>>
>> Thanks,
>>
>> Lukas
>
>

