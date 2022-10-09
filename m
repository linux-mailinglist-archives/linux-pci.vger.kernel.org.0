Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB995F897B
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJIFos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 01:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJIFoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 01:44:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C03271B;
        Sat,  8 Oct 2022 22:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqoVxQrl5AVE+2K7zIAI62qtNWm5pAnaHsnba9SxtUeRtxnbkbthkzfcyyW3HG+bc2pwTydTq9/k8TP6Zn8hXNYkYjcx04c382n0zFr7fvVpfq8ScLE0fz2CNnk0vnrWUJclm53fX72y7JCyolcy/7piyWZUE8UBreyR0xMoKP05s0tHjcoYMfWAYg4Fk7WVXm5iDgZUaTzM4UefDMPfv1Q24ydO0SjkRIogYr6lzTaK77vc70WxklWO1oumy6ontASscRqzIs40nfgSTWRzLE0vepH9a+BUUS9Kw5pb8CwK6SmiWLqJlaOgrX5N1gBMZLoB5qq/DSR9lMc51mdLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbWBrS1ma6krKNDbsxngl4f486SCvF6LXSZtljeowdk=;
 b=g4Mw/TY25tL2Vzes4roApiE6F9782rQjxjQegYV24uj/z94Eqp6OBTfIoeDJZKkVX3CZpsz8e1/hyozH2M435dQ9FaltKflkZ3lf/6QiW2pSL8qafkG90CFZWtNH2sQ6aEgmK1shUMesfGnEySLp+CQwzjnZKZ+E1sGU8ayJ6U6VQUUsW1eYOMUHC83sZZo/chF0U/EgQ6Imgtg/Y0IMW/EWfFPrwubbykng+IAo0X8S/IIDwRVev2TTUWcgMp5eNCBEpoxeifVmITWZQ1ytH8B7FLZeV44zQWrG6azaAd+2RsVKBbJaC4tvR8fA4mFuGUpAJ7DuWBFvVlF4zKo7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbWBrS1ma6krKNDbsxngl4f486SCvF6LXSZtljeowdk=;
 b=Q9kttzPLefxdZ4FNi7HFgqygFU5CwXJZfNek9TK9NjPV9JpkLs9jL6ZyZ/3p3mPA+3ilTSNMyRVN8gocciVqvzWjTlStMnH4h3lIIPCu6CGa9qb2AJv9WQQf86Wn/93nNmbahG2z5rhi7GH3ql0mjdi5AzuebcUYc3iMfKyrm3mzau7qfsMf9fD3EtncZyz1gE4liQsAsm1iqBMlyQryqA+zWDoRfqdg67h+NySDw2pYENdz12EQFMLbr1GfUbmxYSoLB5snx54c3K5Ya80H2W5qhGyx2oIrAVc2vCWEtEO/2XJz1NqZdEwyzM7X8U6gSkby6Y+WFZD7DmiG0BZZqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 05:44:42 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Sun, 9 Oct 2022
 05:44:42 +0000
Message-ID: <56608a4d-aa7e-70d0-e960-943ea9e70525@nvidia.com>
Date:   Sun, 9 Oct 2022 11:14:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 1/2] PCI/ASPM: Refactor ASPM L1SS control register
 programming
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, kai.heng.feng@canonical.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
References: <20221005023542.GA2190062@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20221005023542.GA2190062@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|DM8PR12MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d7a548-45a3-4986-e104-08daa9b95cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHsSPX3AQoQP6WvitvmXyEMMXgPJMQzRIbhhz8JiJYVdVvmWHtCfO0SoJIJR7FFNyeh6EMpKhDUnu/kQBaZUdrj9YbZVqUIPEAlB+uLO2CYwWTd4LfalnlCsgQOUdx5YrSdE98afA+77SrnZsgWHQe0Nb5eE/c7O7a/NeRyRGxQdVC1STl0+ajH3hgsixcWklUalpU/fV1i/L6+VT3BPV569HjyDdMrYPT1AEB5Qjly00XdX/W+ICn8nw74RiVsNbBNMEx34u8T5qYFC5v2Ce+jcojHMWYAh15MDIp0VPsRLRCOPlS3p/ouo1MXbJX2QlH7JaT/j1LWuCuXrgWCHZqAI+MRk6wqP/hOsAJlGlXnicDaPnYWVTrl/GX5bnRiZ0SvjUieEoL0w7N9iSMFXImwYEWBrw4oHbMfxoe6XfLE3AfAVAKo3fPcJuK1U7iWBrUz4SIxL3zqiyNfuySLBKJIyYskD81vkMDGZRvXvZjobwT/5L7P5BOTnmTvrImZ/OjkhEwtervlr8Arw3V+7RYt3i5jmwpZt0hukDeHRbUdg8W1vuoMVwpi+BEqRnU+cigZli3IjgMTXg/nvZ3VQxKsGei8f810Gs16K3242Pkf8ngLr1HMH4yHH/jhWjc+XoIaXyCZholpXYHOHKespW1+p+b1R0X+xvmLVcQV+H0ct+1m+zPDn7cP9wvczoqZdo+vJmPti/EQjoUFRy9dOr2zTATV4RSqxSAUITCPKm9njLYVqFX8lsGttnIXdSc0Xky6JyiOHY55ivY6wmtBfMN9wwVbnC7abavst1CPzitlu+gpTFl+g9zzaHW0xaCejwvPT7+L55vVwF6mwnUzhWDA4sL6MwWXG+5F3dJDrNvNgM/5dnUWgJndGdzcg4pe+lAANwplOTNKI/vUgMPgwPxT11WryPkLjTjOAERykCHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(2906002)(41300700001)(4326008)(66556008)(8676002)(66476007)(7416002)(5660300002)(8936002)(86362001)(66946007)(38100700002)(31696002)(6512007)(36756003)(6506007)(26005)(186003)(53546011)(6666004)(6486002)(966005)(478600001)(6916009)(316002)(2616005)(83380400001)(31686004)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRnTXZUMHZHYVdMUlFQSnBmT1ZwQjZrSjVWWlY1a0VjRlRyb3IxMWpQK3ZQ?=
 =?utf-8?B?Wkt1RWk0UW1yNGdyaURzWFA4bUxyUWU4VjJhWTk2Wk8rNGNLRkJRWjd1TkhR?=
 =?utf-8?B?eG9oeGRIVmRqdUlabWJTazlUeFl5TGVIbW1LU0FwQjdBWjEvZlZEdEU1MzMw?=
 =?utf-8?B?OURGMWo3NWRMNTJkdDMyb2pKYmFVMGFpTmVZajNlK0RZOEZwM3g0UzRsTmVJ?=
 =?utf-8?B?ektiRXAvd3NWOVFNR3hwS3JMejl0cXRsd3pnVnB0SWNOcmdGMkt2RDJKUUMv?=
 =?utf-8?B?V0lORVZielM1UFljSDl0elZBVWQ3UzJFZzhnVi9pS2xtSEtuT3NQdjZBR2cr?=
 =?utf-8?B?QzFrSzduUWRpQkhyaDFJbW0zUHNSWVF0cnRuNVE1WE5zUmRxN3hpb01mNzdk?=
 =?utf-8?B?eThvK0w2YWV3MHFCM0lEbWNWZnZwSkZHTG9sREtCV1dJL1VwNjBaVHV2Zkpn?=
 =?utf-8?B?QUtZSXFUWWtMdHEveWpZRWl2cFpJcnNSQlcyRDBsL2xOTnBNN00xOTVnY3J3?=
 =?utf-8?B?SXlicGRGdVJVSXZKVUxKZWRCckwxVTJOK2RNcUxMN3plbXE0QU1XZDdnZXIz?=
 =?utf-8?B?WC8zU0lMUHBFcXZyRUpDU282UjV0eFM2SjkvT0JtUm41dUJ5ZFl0L0c4dTN1?=
 =?utf-8?B?VE4yVGpiYlFEVmI0ajRMOXBCM1VlUEdDMGlqR3JINlhjYU94UnRGYlJidUhG?=
 =?utf-8?B?dzArWUFKZEMzTHM0aFBENm1CRW9zdU5mYmJ2NDhOK1FrZHZ6dW9GUmtueTVl?=
 =?utf-8?B?ckE2L29aUGJ6YlhEOHFzNURkTlBER3ZJWUxTbUpHWmQyNzAwSUx3aDBlUnpV?=
 =?utf-8?B?NnliK1kra1lNWUt5UXZCUjN5ZUNCdlY4RDFKazROTnB1cm9tUzMrZHFXN1FI?=
 =?utf-8?B?MWRQU0NGWWR5OGNHZXdnc2k5V3RyN2hsbFFqdCtOcm5sOUhZd3k5amZNY24x?=
 =?utf-8?B?NmtUT0pnY1l1NVluTEFDS2JoSVMxcm5ySm85L0xIVFVoNWFidnVkMkdQQUJr?=
 =?utf-8?B?R043MXdIZTIzdUdsQkRQY0x2dS9pa21KcnVwVi9Jb3lPcGE0MjBtOUV3R2Yv?=
 =?utf-8?B?S1pPK25LS3lUN0twNHRiaDNuTU5ZelNoYWV2VEVCOGl5WXNXV2dtN3NkbFpS?=
 =?utf-8?B?cEFxQzZHbU5WcGJRL3RBa25ZVWxIRTVTTTVDcWJaZGl0dlpYNlVjZGY2UjQ1?=
 =?utf-8?B?OGlXU1R1UzNIMkNEOHNOMkcxcVNsU3lNdmtubTJMRDBaN2Fjc1BLSGVLOVFs?=
 =?utf-8?B?NU94ZXM0cUNDK0xCVW1pU3BETUZQTjdJaHFDVHJVNnhHR2EvVFlVK0hOajhT?=
 =?utf-8?B?b2xraVM1a2ZxSGZlWjRqZ1hKTFRyWlJqMkxRTVRnMWRDbmlPaXZSWk56eHNt?=
 =?utf-8?B?a1hhQTE4TXpuM2oxQ3RjenhHM1hRdzBJVzNla1Q3ek4yRS9QZEIycXJ2MXJ3?=
 =?utf-8?B?MmFxeFRucVNFVTdoeURTMjgvSHRyZE1xTnBIZFJaWTRTbUNaTWExVDdmcERj?=
 =?utf-8?B?QkVQaVVYaldZUk5mUUp6TUtyMWhrNTJKYmFGbWx3TVNSYmNxSm4zNHB4MWdX?=
 =?utf-8?B?cmdDOUIydXNUc2kyeVdFTndTT1FmdTJSNWNWU0FFcGs3a0E2bDZDcmJXSFZP?=
 =?utf-8?B?OENXMXJuZm4xUXhjdHRIZmQ3QzZaK2svNVNWRGtSQ0M5MW5DR0pLcDlTUUZJ?=
 =?utf-8?B?MW43dzY4Q0dPMDZ6V0YvQ0RNUmx5eTZTNFBVcksvQldSY0hMUmgwQjgzdDJT?=
 =?utf-8?B?WWQ2S2NQcjZxdTNjK0JoS25WL2lFZFpjSmhLQ1dLdkZ1VXJBNVYvRDJCNWdv?=
 =?utf-8?B?ejZMTm5qNzNQeG5taW9HRDFhanlsNll1YXBvS3NyaXVlSXFYVTROeEpzam9q?=
 =?utf-8?B?dENSRFB3aTRBVjBvTER0L3VkZGJUM3Q1bjk2Yy9MdmgyWFIzRllqKzBPTGc5?=
 =?utf-8?B?SVdXeE1obTBDLzkzR0pWdGl5SmxzK2NSSHJnSmRPTmdTS0hnRTlwVnhaWTFW?=
 =?utf-8?B?b09qVlovRjdCVURuck5wUnVNMFVjaXJvdjdiY0htUnBVQVBReE5NQS92anQ2?=
 =?utf-8?B?MG1uU3FzaXUyeXhySXJmR2R2TUYvT3ZyM3AxMXBIc0duVmphNDNrRG9telo0?=
 =?utf-8?Q?lDBzyGt2DedK4gbotKIvSBByz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d7a548-45a3-4986-e104-08daa9b95cd4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 05:44:42.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJnmtGpprb0yUE4JHSOS5mLru1vSmvNXzb1EvsPsNDG0nJYMJ/6uuy+xViwY0y7HLctmNHMl2gpaAxSrVdvh9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/5/2022 8:05 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Oct 03, 2022 at 12:12:22PM +0530, Vidya Sagar wrote:
>> On 9/30/2022 3:30 AM, Bjorn Helgaas wrote:
>>> On Tue, Sep 13, 2022 at 06:48:21PM +0530, Vidya Sagar wrote:
>>>> Refactor the code to extract the command code out to program
>>>> Control Registers-1 & 2 of L1 Sub-States capability to a new function
>>>> aspm_program_l1ss() and call it for both parent and child devices.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> V4:
>>>> * New patch in this series
>>>>
>>>>    drivers/pci/pcie/aspm.c | 63 +++++++++++++++++++----------------------
>>>>    1 file changed, 29 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>> index a8aec190986c..ecbe3af4188d 100644
>>>> --- a/drivers/pci/pcie/aspm.c
>>>> +++ b/drivers/pci/pcie/aspm.c
>>>> @@ -455,6 +455,31 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
>>>>         pci_write_config_dword(pdev, pos, val);
>>>>    }
>>>>
>>>> +static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
>>>> +{
>>>> +     u16 l1ss = dev->l1ss;
>>>> +     u32 l1_2_enable;
>>>> +
>>>> +     /*
>>>> +      * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
>>>> +      * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
>>>> +      */
>>>> +     pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
>>>> +
>>>> +     /*
>>>> +      * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
>>>> +      * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
>>>> +      * enable bits, even though they're all in PCI_L1SS_CTL1.
>>>> +      */
>>>> +     l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
>>>> +     ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
>>>> +
>>>> +     pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
>>>> +     if (l1_2_enable)
>>>> +             pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
>>>> +                                    ctl1 | l1_2_enable);
>>>> +}
>>>> +
>>>>    /* Calculate L1.2 PM substate timing parameters */
>>>>    static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>>                                 u32 parent_l1ss_cap, u32 child_l1ss_cap)
>>>> @@ -464,7 +489,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>>         u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>>>>         u32 ctl1 = 0, ctl2 = 0;
>>>>         u32 pctl1, pctl2, cctl1, cctl2;
>>>> -     u32 pl1_2_enables, cl1_2_enables;
>>>>
>>>>         if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>>>>                 return;
>>>> @@ -513,39 +537,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>>             ctl2 == pctl2 && ctl2 == cctl2)
>>>>                 return;
>>>>
>>>> -     /* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
>>>> -     pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
>>>> -     cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
>>>> -
>>>> -     if (pl1_2_enables || cl1_2_enables) {
>>>> -             pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
>>>> -                                     PCI_L1SS_CTL1_L1_2_MASK, 0);
>>>> -             pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>>>> -                                     PCI_L1SS_CTL1_L1_2_MASK, 0);
>>>> -     }
>>>> -
>>>> -     /* Program T_POWER_ON times in both ports */
>>>> -     pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
>>>> -     pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
>>>> -
>>>> -     /* Program Common_Mode_Restore_Time in upstream device */
>>>> -     pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>>>> -                             PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
>>>> -
>>>> -     /* Program LTR_L1.2_THRESHOLD time in both ports */
>>>> -     pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>>>> -                             PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>>>> -                             PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
>>>> -     pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
>>>> -                             PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>>>> -                             PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
>>>> -
>>>> -     if (pl1_2_enables || cl1_2_enables) {
>>>> -             pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
>>>> -                                     pl1_2_enables);
>>>> -             pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
>>>> -                                     cl1_2_enables);
>>>> -     }
>>>> +     aspm_program_l1ss(parent,
>>>> +                       ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
>>>> +     aspm_program_l1ss(child,
>>>> +                       ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
>>>
>>> This doesn't seem right to me.  I think the intent is to update
>>> LTR_L1.2_THRESHOLD and Common_Mode_Restore_Time, which are encoded in
>>> "ctl1".  It does do that, but it looks like it *also* clears
>>> everything except PCI_L1SS_CTL1_L1_2_MASK, i.e., the L1.1 Enable bits,
>>> the Link Activation bits, and the RsvdP bits, which I don't think we
>>> should be clearing.  Am I missing something?
>>
>> Agree. Instead of updating some of the register fields with new values while
>> keeping other fields intact, this code programs the register fields with
>> only new values and also programming all other fields to zero which is
>> wrong.
>> Thanks for catching this. I missed it as the card with which I had tested
>> didn't have L1.1 support.
> 
>> I think the following modification should fix this issue.
>>
>>
>> @@ -537,10 +537,23 @@ static void aspm_calc_l1ss_info(struct pcie_link_state
>> *link,
>>              ctl2 == pctl2 && ctl2 == cctl2)
>>                  return;
>>
>> -       aspm_program_l1ss(parent,
>> -                         ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
>> -       aspm_program_l1ss(child,
>> -                         ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
>> +       pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
>> +                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>> +                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
>> +       pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
>> +                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>> +                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE)
>> +                );
>> +       aspm_program_l1ss(parent, pctl1, ctl2);
>> +
>> +       cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
>> +                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>> +                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
>> +       cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
>> +                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>> +                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE)
>> +                );
>> +       aspm_program_l1ss(child, cctl1, ctl2);
>>   }
>>
>>   static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>
>> But, given that you mentioned we shouldn't be touching Rsvd also, I'm
>> wondering if the following can cause any issue?
>> With the top of the tree code, the CMRT in ctrl1 register is updated only
>> for the upstream device whereas with my change, it gets updated even for the
>> downstream device. Although spec says that it is Rsvd for a downstream
>> device (i.e. upstream port), I'm wondering if we should really avoid
>> touching it?
> 
> I'm not sure it's worth bothering about at this point.  It feels a
> little OCD right now.
> 
>> If the answer is yes, I think it is better to drop the modifications done to
>> aspm_calc_l1ss_info() function and just proceed with rest of the
>> modifications given the way it is differentiating between upstream and
>> downstream devices while updating the registers.
>> What are your comments on this?
> 
> I thought we had some indication that Common_Mode_Restore_Time and
> LTR_L1.2_THRESHOLD should be programmed *before* setting the L1.2
> enable bits, even though they're all in PCI_L1SS_CTL1.
> 
> The first place that comment appears is
> https://lore.kernel.org/linux-pci/20220907210540.GA140988@bhelgaas/,
> but I can't remember if it actually solved a problem or if it was just
> more OCD reading of the spec, which says "This field must only be
> modified when the ASPM L1.2 Enable bit is Clear".
> 
> I'm inclined to keep the aspm_program_l1ss() changes unless we think
> they're risky, because I think it is a small step forward, at least in
> terms of reducing the number of config accesses.
> 
> On pci/aspm, I currently have your v4 patches plus these tweaks:

Thanks Bjorn for pushing these modifications and I'm fine with the below 
changes.

> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index dc2e21c7a9d4..016d222b07c7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -537,10 +537,21 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>              ctl2 == pctl2 && ctl2 == cctl2)
>                  return;
> 
> -       aspm_program_l1ss(parent,
> -                         ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> -       aspm_program_l1ss(child,
> -                         ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> +       pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
> +       pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
> +       aspm_program_l1ss(parent, pctl1, ctl2);
> +
> +       cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
> +       cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
> +       aspm_program_l1ss(child, cctl1, ctl2);
>   }
> 
>   static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> @@ -727,9 +738,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>          u16 l1ss = dev->l1ss;
>          u32 *cap;
> 
> -       if (!pci_is_pcie(dev))
> -               return;
> -
>          if (!l1ss)
>                  return;
> 
> @@ -748,9 +756,6 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>          u32 *cap, ctl1, ctl2;
>          u16 l1ss = dev->l1ss;
> 
> -       if (!pci_is_pcie(dev))
> -               return;
> -
>          if (!l1ss)
>                  return;
> 
