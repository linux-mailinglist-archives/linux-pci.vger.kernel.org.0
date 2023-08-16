Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4777EBF2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 23:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjHPVgq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 17:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346554AbjHPVgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 17:36:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD575DC;
        Wed, 16 Aug 2023 14:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr3owh5cpelAYsnPVKV2EReQ5Xa7FTZD0ado2KWnvoZBfA8IAdOe84P6g4fsOlQhYIHhN3KeWxy/G17aeLnWMuVUwmi1z9ViRaCL75vsE3PhlA1BSTa1SFrtM41Q5gNpFP7wJNHKe/S3xU9KG8LLTbyEXXm5ohb+ZyM+dBC5n7ZMRjazcdvtw6yxHqI5bNRzP/I7L0dHi7mZZ2spPn+h9ZzebHk8mWTu315iW75vwA5RfGFoYKYC9oRyxv8OiPdG0sth8aAehXBgRZF0c8xcenDlejyY/xhsC1anaGN7T8r6lOxzc5JcgZGThgq+Ces6VV4DDyRZyTiUte+Ru/raSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuR0H1VrBQi38FDyI/2Fje0hlnyTm1yEQLw2p+apXeQ=;
 b=dIPPZ15EwMpEjk2wwjveab6lvuv9A4eMSQRH6UU3LLjP9oJaDdrnWrkANWG6g08b7JlPIa199pffjRd//sheexlgsEcTMII0vgduenLczEJdHglWSyfmiInUmjPyH8NjWdb9WFQsVE1Og3GYEPTxdNK7SgzA1j6hLtEqoE7E1B2BvwbebBEoMLYM1K5MIs+dV2CUahMLFtew3giQSF+PSBHTXlnoDzFg/Su3IwmEcPA9f8AT/LW0LhMt9L2AhzlYMsvxziznPLYCM0QFDTYF5bLVYulkx9UwINGKTamb6iISp93yRag71H2wTwMdKY4D01LG1MZVltfY98cNERX3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuR0H1VrBQi38FDyI/2Fje0hlnyTm1yEQLw2p+apXeQ=;
 b=bxJFQ/72pgFl8sCB29Ky6z1tSgJi3jKuhf0r9oEKqzZUHrLJH/GguXF8k8PWraDGVuqnLVDxORNk8tufhJRHtYyQZ1snH4ajYwinzwfetS2HGKRP8iUsOV5dSc1ao1z6US4OR2drNWosxa+PnMzjB/JGyXT8BnRn6YZ/4a3vGqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:36:29 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::54fc:703:94d8:4241]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::54fc:703:94d8:4241%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 21:36:29 +0000
Message-ID: <081c0e49-89a0-199f-7bff-45fe59f238a9@amd.com>
Date:   Wed, 16 Aug 2023 14:36:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Content-Language: en-US
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230804130929.00007dfb@Huawei.com>
 <5547a005-a492-9996-2d60-6919c3a6cc05@intel.com>
 <674e6ba8-1e91-3e27-357b-c86252a1f71c@amd.com>
In-Reply-To: <674e6ba8-1e91-3e27-357b-c86252a1f71c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:510:23c::22) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f610a3-88c7-417f-91b9-08db9ea0d9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nkzk4biqPv3P/TF/8uxIEHxnqG0volxU6kY+MbTFnYFSWbTzF/SeV1nYqpOQ5nVeknnJtDuKkmjpS8rSFPEccc1ZXYwNSOalxE9pbcDgaMEC3e8xNlnzII3is7dKNNXcW3rirtwnOoIvw5wZjIRr96Jnqw299L/OosPL9t/vvC3fgbuXXx0cifgDojqunVLi1uHK6hMvrdtK79QW12+/rli07Q3gUT1zV8F6G+jrCFHVLFQavrHXIZwvOPfopqrnpsjPxb4i4UVmNEAZqSR5bDKkVzjQV/osNdnEYfzMOmqVy3hrZUjJRmMh6Pp5+oaaYrUM7RyQExxMJCuIuZ41tfYKP7ffxS/hBZpmCUdrdSDxLAayimcLHJpSkMmSu8/iLwpj6QzbDlRQk3XsyhvlbNKMDXcvAeAZ5VlNaweYXQT+yHPDfALrlMoQVABXHSCDmgx2B410RmRR6hYDh0t++oqN4GBmi531TNZrdx2Cz4CgCPQUwovGr1zBIvaCxUbO7Cky/U9xO8OuItC78YMcFItvZ4o6cnBH5fWPfV54wBtg8wgyoNoqRvDzG0gTUqk/gjgSnj0G0UHk9CsKFW3san7Fo137a4DvbZ6vOFnGZMNBE6gPwyhJQtstYlzlFM/CF/zKlfciQs/vevRRlY8wZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(36756003)(6506007)(6486002)(2616005)(6666004)(6512007)(53546011)(31696002)(26005)(966005)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(110136005)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFrNzNRU2Qyd1VXdGVsaHhtMlpNaCtoZmFZRXVUaUtvMDIzaWgxMXRBWkkw?=
 =?utf-8?B?ZmlvcVVzMEphUitDeUd3QUZycmE2Z3NPQWFZZS9OK1FZWTR4Y1VKY0wyaklY?=
 =?utf-8?B?eXBWZzdsVnplNmk2akdvaFQrRlFuOTlZcHZwOTExTlJtelRiWE1nWVkwSERU?=
 =?utf-8?B?OGlRdDJZbFF4cTBvbDU4RzRBQU5NdEw2WWpsaGNFYWxhbmlPRXcwZndiazlv?=
 =?utf-8?B?Q3pGdjdHUTRzeU44UjE2eklFcU14Y2oxa2Z1Mndxdy9sb0NSRzkrS3Zic2E0?=
 =?utf-8?B?VHF0K0hML0xqV0t5ZDcvRjJ0WTdsdUV2cEZSRTRSaU91cG44M3U2U3FXWnRI?=
 =?utf-8?B?dUt0alVIVVJWcEJPMjlpZWU3OWYzMCtrRlpqMmlaZ2czZlpFTGVOMnhRYzZm?=
 =?utf-8?B?UWM2SWFGVEE0ckVraVZRRlVzTmdhOUltRlFXL2NPeGl6MWVvMHV1ZjZRY3kx?=
 =?utf-8?B?dDJPeHpacTlvY1Jpb2loanZUN1IwSmIxZDVEZmNEYldLbnlUVHJZVVhSNnFT?=
 =?utf-8?B?OCtrMXU4UXNmcXNSQXZLem0rYWIzOEE0VFMvK2FLTVBCRGFJUW1qWVZXTlM2?=
 =?utf-8?B?OEFPNjN6cHZTZXVPYThtcFhLUjJPem9yb3B6SGtScGJUaER0bjRvMTZxSkhK?=
 =?utf-8?B?NThrcEFCWjlUOVFJWGRPS1lqOWF5b2pySjVZeXdSUlg1VG1DZWNJOXlvYzJ1?=
 =?utf-8?B?N2pJd2VtRXVjaVNUNllsLzUvMFdZRVVRRGJHem5tRHZCTEo2VHNDdXpLYmtI?=
 =?utf-8?B?MHUveDgxUTB1WjZzVUg5Nlo0UWpTMVYvd0hmai9YMjRNL3lCUGJRaG80OUZH?=
 =?utf-8?B?SUQ5MXltejBiN2lxTmJHR211dHFSVnBoRDAxQ21RUC83ZWt5UG5yd2hmTmdG?=
 =?utf-8?B?OFBIOHJNZzFQMDU5aDUxZFZ6U3pUYUM5OENmRU5qN1F4dTJTSjkrN0tEYXNy?=
 =?utf-8?B?Wm4reG9ucDYwSlNJa05EUWZ5dUJDQjAzTWZ2VEU4OEJlMU1ESExWYUJhR0FK?=
 =?utf-8?B?NTIyaWw5ZmF0M1ppSVNGNXkxT0k5MTVUamUzVXIxOWR2Z1dpVVpmZWJmYVVB?=
 =?utf-8?B?d0pwazRSSlFtRS9XSVcrZllhaFlxRWg1NDZVUVlObGd0OGtIU1pIMzV3U3Q1?=
 =?utf-8?B?U0o2b1pOS0M5N3RuYTl6MDZBK2k4OGdMR0FBTmFtMGVQN1R1OEtYSHQ1d2ow?=
 =?utf-8?B?LzJhNzdMYW9FRnEvK1dHZmw4bnArNTZqN2M2dEgyd1huUFNqVlVCcHlDZWI1?=
 =?utf-8?B?TjZjWE5sQlMyUlZpUkxSVHJGTkhzTTI4V0d5dW9ZYzB4RHdWWDJ5bFV0WWlC?=
 =?utf-8?B?QXJQYU5kcWtPMTJjOHJMN0c3SXArWU9VUlU0VVJ3NFdmYmFuOUlPd3hCVzlh?=
 =?utf-8?B?V3JQakVEZVhBUmdvcUdQQ2ZWU3VGMGxGcFdyUm4wUE1EQTU4aUZTUTVJbEJl?=
 =?utf-8?B?UDVXZEd0VjB6RWN0SkVSY1hHblVPeC9UMzJyZHl5eXhWWDVmMlNvaHdxMzVo?=
 =?utf-8?B?V0JHZFB1YWxVc3YzU2FNakFycnExTVNNMEtDenN0dVRXOVFQdVNPYkNBeTlC?=
 =?utf-8?B?S3MxOU9jS3dmWWV3YklXcUdBZ3dDcU0yTWJRNC9sSDVDek5XQ2paS3AyT1BG?=
 =?utf-8?B?Q25qSHFMK3FpUUtnYlVYaVJzSXp5MlVOVnpjbWUrUm9XQm1GT0NseVBtVHhG?=
 =?utf-8?B?ZmNRUFprU1pjTjh5NUx0NUMzb0ExM1h5eWpKSlh4Y2FJdGdXMDhEMjhiVGdG?=
 =?utf-8?B?R3pHbVI3dk51c3lHSWJqck5CLzFid2Zrb2NTekVXenJWSVFJK1BhT2RpUm9W?=
 =?utf-8?B?Nk9uVGtNWmFsbzEyaytSTWtiUkZwLzZTeEdDZGJyQVRKNkxxaEg1Q2IwN2pm?=
 =?utf-8?B?UWxCb3JqdkNkeXVrYkJlcWc0NjVkR0FiZmZsdUVKWUlBT1J4NmxmWFRqSVlR?=
 =?utf-8?B?UUthYVprMmJFS2MyaDFqZEExY3Q3bWhnREd1V0MvbFFENUgwS2tURkFaaEsv?=
 =?utf-8?B?U3ZaOWY4RnN6MDJMaURNbG1rdVg5MzdUdHFPNGU5dEQ2a0U2VlUxNE9iREZ2?=
 =?utf-8?B?UVZjaDVGTEFMb2dmNzVwRCtoTW4ydUMxQUM2dy84YTVianBldThXL0FESFMw?=
 =?utf-8?Q?LLiYfu+aN1wD0u3ZUQK24TdyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f610a3-88c7-417f-91b9-08db9ea0d9ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:36:29.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkwCMFQZ2/0ABHcfPOx6DtqHCbmprFduxmf7Z4l0HO+VIBrfIgjLlXFzdDYkgjXkxS99dozE/6Igak4nksBh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/16/2023 2:33 PM, Smita Koralahalli wrote:
> On 8/16/2023 11:06 AM, Dave Jiang wrote:
>>
>>
>> On 8/4/23 05:09, Jonathan Cameron wrote:
>>> On Thu, 3 Aug 2023 23:01:27 +0000
>>> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
>>>
>>>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>>>> of AER should also own CXL Protocol Error Management as there is no
>>>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>>>> reported on Protocol errors should check for AER _OSC rather than CXL
>>>> Memory Error Reporting Control _OSC.
>>>>
>>>> The CXL Memory Error Reporting Control _OSC specifically highlights
>>>> handling Memory Error Logging and Signaling Enhancements. These 
>>>> kinds of
>>>> errors are reported through a device's mailbox and can be managed
>>>> independently from CXL Protocol Errors.
>>>>
>>>> This change fixes handling and reporting CXL Protocol Errors and RAS
>>>> registers natively with native AER and FW-First CXL Memory Error 
>>>> Reporting
>>>> Control.
>>>>
>>>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>>>
>>>> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
>>>> Signed-off-by: Smita Koralahalli 
>>>> <Smita.KoralahalliChannabasappa@amd.com>
>>>> Reviewed-by: Robert Richter <rrichter@amd.com>
>>>
>>> I'd be tempted to add a comment on why this returns 0 rather than an
>>> error.  I think that makes sense but it isn't immediately obvious from
>>> the local context.
>>>
>>> Otherwise LGTM
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Echo Jonathan's comment.
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Yes, and Dan is probably against returning error code.

Against returning zero. My bad sorry!
> https://lore.kernel.org/all/64d1b3e78629f_5ea6e2944@dwillia2-xfh.jf.intel.com.notmuch/ 
> 
> 
> But I think returning zero is required as we don't want to interfere 
> with cxl device access when operating in native cxl memory error 
> reporting. Returning error code will basically fail cxl_pci_probe() and 
> thus fail to create a cxl device node.
> 
> I was thinking a single line comment as: "Return zero to not block the 
> communication with the cxl device when in native memory error reporting 
> mode".
> 
> Agree? Or anything more that needs to be added?
> 
> Thanks,
> Smita
>>
>>>
>>>
>>>> ---
>>>> v2:
>>>>     Added fixes tag.
>>>>     Included what the patch fixes in commit message.
>>>> v3:
>>>>     Added "Reviewed-by" tag.
>>>> ---
>>>>   drivers/cxl/pci.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>> index 1cb1494c28fe..2323169b6e5f 100644
>>>> --- a/drivers/cxl/pci.c
>>>> +++ b/drivers/cxl/pci.c
>>>> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>>           return 0;
>>>>       }
>>>> -    /* BIOS has CXL error control */
>>>> -    if (!host_bridge->native_cxl_error)
>>>> -        return -ENXIO;
>>>> +    /* BIOS has PCIe AER error control */
>>>> +    if (!host_bridge->native_aer)
>>>> +        return 0;
>>>>       rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>>>       if (rc)
>>>
> 

