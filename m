Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDA6F9881
	for <lists+linux-pci@lfdr.de>; Sun,  7 May 2023 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEGMvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 May 2023 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGMvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 May 2023 08:51:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE71DB;
        Sun,  7 May 2023 05:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA6Y2vSIETahadTSM9qm2m4UuEsf+335cu5snqGLZNVegD4rKtqcv5UFmCjKOfBnjMapQBv5u6aeOROFfU0wAl2R3wnQTsLSfF0H8mX0zRVB2nTpclOTS+jl1cgTzkL9xDcbWZy64lQyVK7PT4hB4uticbgC9DBVKTF+c4JtKlClPvQptAYnGjRNS5pj3ZyrHfVf7ElBUqU3yB4LSaKpT0E+K3Gws0PQoZeajmvm+lngVPd9eX6FleOnu72AfpGIvLLrY1M4pJDZignKqsklhmKprHlfitS4T6WSWfUwoxA9hCYRJx3S7mUYtwttn2e/B0JcKlnEBvfafGu0N2UOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+KQ9iLeqb+Mb/FnFeH+7X5EFsicFw6ZJrVxgpO00cI=;
 b=Yv2GeKlxcGzWtvnX+f/KzQhacDL9eKrLYPh4HSy2SGLCnMWN2CfDc7LlcpfPpB5qC0+hZX7oVXTlDdmIV9gWS3N5WKIfI0AUVLks/YYTXHeIRfL5ujittWn3HovmYymk0+cY1FJ3lIKZew9BKUTUDomPtiNwLWLBy1wKn/M8li4vp3BGUqJqyXkEIeclc+0Io/uZ+Sf8/R/hqtxaTBEKtpnzRN8a89DHWhMwya2rMnYBOPsA0Dlm9gShAK8G+IP6+VP+wNz0Jo7FP8XAeLHWpeKVgNF57NPi28DPN7tNrRVeiWwtf3AdpY1vTi56BQSgJrqDGOwgRIGBQs9sjumzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+KQ9iLeqb+Mb/FnFeH+7X5EFsicFw6ZJrVxgpO00cI=;
 b=sW0I16Mxah46SyJuqW3l/8PEjNPJ8//nUL5s8PnHI8iXgQ3hOP0zmA3JkWHiz/JDFE9ELS58vw4+YdhniRtIIG+UwSvm5zSZZ8U8Sgxz+7mzNdSZDn9W4a9QA2IuIDyxSqAzlgPdlRmf2+TKkVu2+e3OJUvMFX6kGYmNQnZA5Io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.31; Sun, 7 May 2023 12:51:42 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 12:51:42 +0000
Message-ID: <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
Date:   Sun, 7 May 2023 07:51:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:4:ad::21) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4862c393-bcf2-486b-0b9b-08db4ef9ce57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOyN24Y3EVcMFe6AUhdDALL420NL6wXMc5YHeh8gfJOFWI+LR4/8f6eXgktCiSzfCMyvVp5kkJahediIM77bVxGbUqNBlp6b6U94vokTozYABd+dNH3Z3BH0gbsigIKLoBgn9gKssjnpghi0NZeoqrdzhEFf17sh5wy5+2REvVUC1cttT7jZzych7X9hUiraE/hdDQih4HZeqvfRil59CW2E1eYM1dqagLlA+jDdMSMjA64CkCTa0si091jq6b2dl/hMncw07gLWIizq/i+k7GtBlkdSz18ZI7Oso9dN/yAPxfZ+z4xqFe2wZhAnf0PzF3O8ozJ00eR1HzziHtGI5eMAXjYmQzDiGCL1dtCyn+6PQ0krfXsH/C11YVcIVKoMkvWRS6Lex1vm4Q1eyJuXV1LY63icJn8nDzsFu+y7CsV/fa363NdKaGLhMtvvNKZ7L24+dgmkmww+5mcksmBno6mjmaVoN+e52PLmHp5JMoHnszR49TvJlFTv50nbWqf+hpQJA3rFhtAVrx5OIgbL/sVp6ZeFQvcwFQt8K+f9jCA7P51pkFZl+iFioAexFr2OHF0G3oY7Q6hJgO5ztdW5+tg6Dn/5nsSU8sf6u0heGvmEGG81i91e3FxY+izTNW5DujYT1xOvqoLmWwE4XpBwgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(83380400001)(478600001)(6486002)(54906003)(110136005)(2616005)(6512007)(6506007)(53546011)(186003)(44832011)(7416002)(2906002)(36756003)(38100700002)(66476007)(66556008)(66946007)(4326008)(41300700001)(5660300002)(8676002)(8936002)(31696002)(86362001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmY2UEoyL0tMTGEybWgxWVZQK0poYzNMQTZWS1kwejhEcFRxUGlEWjQzeG5T?=
 =?utf-8?B?MDZiWnowdk5lRXFRbU5BTTNZYUNhaW9lY0xrQlM3MkkxMm9ZQkZUUkFQOHMr?=
 =?utf-8?B?ZnFtZlJTZXd1RHhZSktCZ1FjV2NMa3g4T1BGMS9DKzdpeXRKV1VXM25qais0?=
 =?utf-8?B?WXJ0U1hzZVFEYnBUVFBYaFc4VEZ5L0hWUkExQjIyeUpEV0JSVTdvSTVXT1NO?=
 =?utf-8?B?NUQ4UkMrUDVCNzY3ZzZJTEcwSUtyY2sxUDZycDhuZ1hOSXpiaS9Pd2YyTmhs?=
 =?utf-8?B?akZRY0Q4VmQ4TGVBOFpXTE9LT1Q3V0c0Vk5seU1JVWZ0RTE2MUREWjRKZjln?=
 =?utf-8?B?aUxFQ2dPK1UzL09CUnNpZnhVQ05JVXhhQzRNYWhmVis1ZjdUN3VEWEIreHJN?=
 =?utf-8?B?NTI2Z2haMnplY0lmVmVORW9LUVlyT3R5aUV2cXRrd2tBaDlRc3RxK25veUs0?=
 =?utf-8?B?b3VVSjhHT3FYcEdWZVMyNk52Rk91Y2dsSEVrQzJ5WGJZV091UXBuT2xCdnky?=
 =?utf-8?B?Q3pFM1JIVHhrLzVaS2Y3SHVOa0k2bDlCRWIwNmFFazZsNGh3TERpUnp3YnJ1?=
 =?utf-8?B?bjU3MlhvR2lLaEs0S094TXEyaUhzL2J5TUlnVGJLV2hnWkZRYU9SNFVRRDBo?=
 =?utf-8?B?eWhobmxQQmhMZW43SEF6bk90dFIrb0Vna0Z4dkVSQytKV2lxc0NEeEFreU0y?=
 =?utf-8?B?emZwWDNScjF3U2kzZldZcmg2QjRXbElOV2EzRDYrcFVCUk9BVWRBWjRVWTE3?=
 =?utf-8?B?Z292bDdPVWVpZEV0NXJYUUZtbmxPMUdOSENrSXJUOWNFUVBleFNHV3FlR1Br?=
 =?utf-8?B?b01lUDNGM0MvMTJsNTlkalc2Tjh0QTFpcFFwdHM3b1dDWVhkcmpUd3g0ejQv?=
 =?utf-8?B?ejRiRU81bzhoenA1YkVqand5bkUzbkFldC9ZUUpFQ0dSNkRhdTIvT1FicjZX?=
 =?utf-8?B?MzRPbFNCd3JKNDhWUnVhQlF1bEFIRkFIVlB6Y2RoL0Z1eFZMNk5FaWVINFF6?=
 =?utf-8?B?RmJUYkswTmdNUk9Fa3NQaGJxOXBDY0ZJd013dXJBYVVLSUJFS1NrMGNZelQ5?=
 =?utf-8?B?dVJ3T2pPbTg3a3V3ckJsczNacEhVVktKTXhnejBVZDhBOFJoakJPOFZoQ3pH?=
 =?utf-8?B?WjB3K0pwbmlYRzVHVFE0aVJlZDdmV1R1K3R0VHRsZkVQdm5zRUhGSTRsa3hs?=
 =?utf-8?B?UVFqRkZqZTNVVVFsUXRvaFFKVWRuZ2xoQjRBNUFoU3FKOWF4alVYYVBNS2xO?=
 =?utf-8?B?Nm9YK0NCb0pjRUpKN0xTSG1DdVpuREQwalh0UFc1SjA3Z1pGY1RQRVV4M3Ew?=
 =?utf-8?B?NlJQSk9MSTBweVVrZWM2b2JtNHVDeDZyUm5tRU5Zd05LeUR0eE85eFo1Y091?=
 =?utf-8?B?d3JkdllGSVNOQkVadzBOUnhiZG9hekpiSWFibkphZWNUa0JRV1AvWU1jcmg3?=
 =?utf-8?B?K2xKdUhNejcraVJOaElueEY5cUQ2eko3cUMzZmd6SDlEdEMvRnR0eW1mT0dK?=
 =?utf-8?B?UFhXN012Ykd5OTlYSTJ4V3dPeEJyb0ZDYkNseXBCSTVOWHZTTkJnbjhNSHN6?=
 =?utf-8?B?VFdHMnEzeExPTWdNdlVvOVNPU0FrSjUrem8vWGx3bjU3MENSWmgzYU9EK0pE?=
 =?utf-8?B?SzZIOExqNlp6L1VQbC9sNVVMY1hzVnNvL2VLTHIxSUNqZjZCY2pVT1BDa2s3?=
 =?utf-8?B?OTFPSVhReXQvMEUxVmU3ZndBQWVBYkVvamFDUnRqcmhLa3VNNkJyVUluNCtS?=
 =?utf-8?B?Yk94QjJrcFdwTVJLUkx6MnNFTVk3UkJOWUVTSmFsUWlRVEQvOUZJYjVyZkZE?=
 =?utf-8?B?WXJnTFBhcDNYd3BobDNEa2Naa05MMnl2eHAyTWlOU2llczlwS09wbU5GbktW?=
 =?utf-8?B?VWNzQlk4dWRPN3JPNVpvcmY1SzR2Vjd5R2VYUDZPa20xdlBRcE84VzJ5Y21W?=
 =?utf-8?B?dFllN0ZQRDErR2luWFhPWkNoZzlydW5rQ2ZYK3U0YitZQUNvT21yMU43RG9z?=
 =?utf-8?B?dWM1U0hhVFBNTVpmTWZiQkRERHA0SFN4YmhkbFMyckV2cE5MMGliNTE5RmF0?=
 =?utf-8?B?Y3hBZE5jZnY1WkIrZE90Ri9kTUlvdTFoL1d3blpJVmNDMjFPQmhtTXowOFh3?=
 =?utf-8?B?dGZKellMUFV3d3dFTW9sRDh6eUFTZFBkUkR3ajQxSXBFM2tOdWRYZmo0OFZl?=
 =?utf-8?Q?0MSrwSUXnExTWz4De6Fz82epvW9q36ADl2kWikWzf+Up?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4862c393-bcf2-486b-0b9b-08db4ef9ce57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 12:51:42.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAdr9Jo7IvjaIfEn/114TpuvHS2XJ/zZV4PsfHKJSXtRUVz01rHlpclXtJ3sfaoV8lj+laCpXm3euauKF8mDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/6/23 09:05, Guenter Roeck wrote:
> On Thu, Apr 27, 2023 at 12:33:36AM -0500, Mario Limonciello wrote:
>> s2idle previously worked on this system, but it regressed in kernel
>> 6.4 due to commit 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN
>> index 0 for driver probe").
>>
>> The reason for the regression is that before this commit the SMN
>> communication was hardcoded, but after amd_smn_read() is used which
>> relies upon the misc PCI ID used by DF function 3 being included in
>> a table.  The ID was missing for model 78h, so this meant that the
>> amd_smn_read() wouldn't work.
>>
>> Add the missing ID into amd_nb, restoring s2idle on this system.
>>
>> Fixes: 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> FWIW:
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> Note that this patch is not upstream, meaning the second patch
> in the series can not be applied either. I am not sure if that is
> because of "regressed in kernel 6.4" - after all, that kernel does not
> exist yet. The offending patch _is_ in the upstream kernel, though.
> It might make sense to inform the regression bot if the problem is
> not fixed when v6.4-rc1 is made available.

You're right; the commit message should:

s,but it regressed in kernel 6.4 due,but it regressed in,


Boris told me that he's waiting for 6.4-rc1 to pick this series up.

#regzbot ^introduced 310e782a99c7

>
> Guenter
>
>> ---
>>   arch/x86/kernel/amd_nb.c | 2 ++
>>   include/linux/pci_ids.h  | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 4266b64631a4..7e331e8f3692 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -36,6 +36,7 @@
>>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>>   #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
>>   #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
>> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
>>   
>>   /* Protect the PCI config register pairs used for SMN. */
>>   static DEFINE_MUTEX(smn_mutex);
>> @@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>>   	{}
>>   };
>>   
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 45c3d62e616d..95f33dadb2be 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -567,6 +567,7 @@
>>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>>   #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
>>   #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
>> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>>   #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>>   #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>>   #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
>> -- 
>> 2.34.1
>>
