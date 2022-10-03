Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B35F289E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJCGml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJCGmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 02:42:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB53AE71;
        Sun,  2 Oct 2022 23:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxGLBwLZDmoO3DPEi5A1+ih+EZqN8ZWPttJY7i81/b4qy5tI7q1OI5qbxHGgPGYtEW/whNuJoreLnR8FM/b2RvOEWR41OHBvMt3hvSOd+pV4aByQn9G5zoGPgD5QG5EBvEy374elSIBqF6f4FXZoJ1JH8MR1F0R/KaOKUTxZ5f7T7z4BPfURvh7TP2LglisefnAbhBLajBxCli/9gK6HA5Q1dgvWtAF/Af3Tieenxqi4yt+qUoshGGS/X80GJ0hxrN/HPljh99ZgtDnJB1OOBTqZEz+b2nMwPn+iyr74J5rY2SbZtNPKAVzRqbBClhtBJxXaLqcTjGqzwWLQARWz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSKHWH+ggb2AMJKYCKMllylsbk2xV1TLBw01ljfc5f4=;
 b=He7TldgSZFjfPFuRpueNzfStSzGag0agCIGuunD1r8Nw3qmQhasIClDqH2zf3PEEi+WiZ89PlprtctwzJ7UF9CTAcMZPJrNJoWuBV+Tf7z1ezR5NKdUFcLnXuG7Yl0FpqVHo8b8iZDB3KnwWDAglpsrEQzxWyTmxmMuE2g11oQd6SyoVcuE99/LGfQ9ojBDeBbId/XGuXuu78fTFQMpKavjAdy3oZBJfIbJRfgZI3duz7dsI5qRSgaDmPapFzjXaUvzriQG06HmHt8ohHVANdefgfqZ04sjuLR03/ULe0sz2+FXrPmAyWwz8zXS5vmpl+auFkfUzQtwLb3tTJMqBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSKHWH+ggb2AMJKYCKMllylsbk2xV1TLBw01ljfc5f4=;
 b=GiZIbSt3rKkPSy+OByLNswRKo4OH1cM86L5doIk38FEIif3vqZXCYUWgxYQUaevAAxmGmSP4El+iY3LrB5r1aNgnol56dslO4qgw4HilueIsieJaAZqxHB5kyNd9jNnaex3XoBi+au/mOgsWAjn1Cg96GDm8jB6fS0rDn0l0DpIjCh3n503doGsWV2VTTqzyk6JQE9j9lKta3VyMRh2gIn04+NSf3SGbrRjLB3hcJFOnFlO4D0slPYE0KA8tkMoNAYXaVxGpm/HD+kS7XSJ6b0EVWJjTv/0t3jy7L73L5qhi4RhIm9SgSq9YMP0VUocLHZwmWjRUc9HBqxcc3Icu/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 06:42:37 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 06:42:36 +0000
Message-ID: <36fa13c5-e0f8-022f-77f7-7908e4df98b8@nvidia.com>
Date:   Mon, 3 Oct 2022 12:12:22 +0530
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
References: <20220929220018.GA1927153@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220929220018.GA1927153@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 14196400-c847-4f7d-e566-08daa50a7559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZb3GKFhLQDVqQc7PMo2unCdgKGqtO/ULtTOfhNuDIEF7rkuIVhD6ZKEe96iuE4xbU5+cQ1uE9wdVhOZPY/NZcZY3Ar5hWWoSeJ28YKYrVXGlVXha3xyG76gBWDOgaHgEi4ocz8AOU7U2WjDUjmAAQtQ2zkvPaM4uUOfkL/iWLgrNFhiOBi1tkV1E4BqqCQ5HZaTRs1F63pBGhqhBjm+vIKDzfKHD21TMPwgUQPUaTxaE9XOX9YoxEKesDauTFZ09BQMJp57Fyqdnv7Fs8iCQ2VDrElX7IOdvMsOUfBELck7La9ZkiKPeW0jHQ7VjL/jroUs9h87wA7D9wViZwcwB/N8YHLl2CxUohQpaMVxj8zzMXp9divg2F7p89F2+Kz7Pr1j4iBUi8NfauThSOoNgTMXJOdaA75AtJnEmBJ0l/Dh95PhTnbspuXPay5uFTGTfk7SJughq/SKuIWgxtDLGWQ8Cq/h6CF/JUiTV9YZfH1vSoQVBztqcqKnlfeeZTR8olNFe0aru/yCTV/TL/jbIE7470a4tW5ywoBC+lUooYozcLp4O9kyqtukNC+osX5ZRontNt2b3O7sJ9xIlf40otzdZ9jqqJC01X0KYiFAI8CTlp97wQt/43PgQ1sQ8Ua71M8xhVTP1bEtAxb8SAuXMXEIlchoz5lLHzV6OcmxOg06YPPy8TjcHwPnP1o8YIHXscEpUKh3djO8EF/CjtLZ1nKCEyo216YESt3wSlltoHr7Ofoy0bhXQi3l8PDvrbMdXKmoByllAvcJOBGZ0kGox0dgqZ5O40xB7VcmoXRsXtR3Q5vTuK2WAnayMq7iIWbpDAbVdCefvXZ8kDmXUP7eVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(36756003)(5660300002)(478600001)(86362001)(83380400001)(38100700002)(6666004)(4326008)(41300700001)(6506007)(53546011)(7416002)(66476007)(66556008)(8676002)(6512007)(26005)(8936002)(6486002)(31696002)(6916009)(66946007)(316002)(2616005)(186003)(2906002)(31686004)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJiWGRMNTFJU0tnREpqY0NJTHAxb3FpZnFsNkRjWGdYLzdRU09nK2VQaEpl?=
 =?utf-8?B?WkxMek9pRFN6NEdraURIcElaRThpRFFLYjVRdXIvcU1kaW54dDJPVW5ORTVX?=
 =?utf-8?B?RlBLVEVOWnl5UktJMDRrcFAvZGMzQzJUZWFCRTZUOTU2T3poSkY4eXFaVThv?=
 =?utf-8?B?UFB6bllzNG1DVCtwVFcvVm82enV6TnBETlcyMDRoZTBXUDdaVlVVYjAzYUdz?=
 =?utf-8?B?TmRXWG9BYnc3ejhmanY0bjJMNXQwNzIvbTdTQWJGU0JIeVdjTzNwd0lUbW93?=
 =?utf-8?B?bHFmOGZKWDU2aE54ajJ3ZERiMmpqZU81TVpCRDNxQjQ5dGFya2xsWUNSNjNM?=
 =?utf-8?B?Tlhka0Y4ZHZLRERrblM0WXI5cnl5UUZJcXdsTHpQMTNkOFhINVRUcm5BRWtH?=
 =?utf-8?B?M2psd1VLL013VmplVndlSVd3a0FxQ1Q2dGJ5VDlsZlZKNnZxRVBJVXlVdXJK?=
 =?utf-8?B?QlJ5bWFBYndpL1NreG9qb0FUN1kwSUZ1eVVqbE55UExVVHBOTW1aaXFUdThV?=
 =?utf-8?B?R3VaR1p5OHk2djc5V3h1bXZsb0dhQXcwUDJQd1puRi9OdHA3MUIyMFUvTWdP?=
 =?utf-8?B?VUlPWDRJWnlvNHlNVWJadHcwNlRBSytPN3oySHBxb1RXWDNXTURyRU5VN3BT?=
 =?utf-8?B?ZnMwVktidVR5ck5SN2RpVkdCTUE2N0dqR01NU0JWc0ZTd0xKTDFCb1luOWN1?=
 =?utf-8?B?L0J1M2VJN2ZSclJrUHlkTU5FeU04TDdRUzdHc2ZrSk1YZEo3MmxxZHFVdGVJ?=
 =?utf-8?B?S0NXU2RwT3VpTTZGcDF5MUYrUVQ0MDUvMFJLMkM2cjdxL1RmTnRJUXZCK3Fv?=
 =?utf-8?B?QVhuQ2tSdE14QXFxOGFZazJmZlJMRlFqZEE0amhEUTkyY2FUTWVyc2Ztang5?=
 =?utf-8?B?TUFtbGJkaW05NTVndmRzYTV2SFo1WmVzLzJ2UnN2c0FqdHZQb09JOW8xb0N5?=
 =?utf-8?B?ejQ5M014SEcreENhREVwb21NRjVuNU9pTk04ZVo1TFh1MFhOR0xnMVpaL2RQ?=
 =?utf-8?B?dWgvNkUvbTNTelBXYXBtZFlpeXBCY21RYnJJTUZDczYxUVROTE5uZitTSG1w?=
 =?utf-8?B?KzY4K0kvQ0hVTFNhQVN6aU9sNk5YOTU1dlZ6M0FLWG9aR0kyOEJ6dUwxajVK?=
 =?utf-8?B?MWwveUd2anNIVkE1ZTNHTkdmTXRXYVRGQVc5TmlOTmFYd1JzN040Z2Y0bk1T?=
 =?utf-8?B?ZURmVXdmdXdOVFBQQWNsZFBRYUFUZFJiV3gxS2ppS0lJUW1POWpVV0tsTG5L?=
 =?utf-8?B?U0RrQTFyY2Y3VFQwMmdDcEdmbUtyYVhkemgrQm1XU2x3a2pqaFZLdDZIYmFL?=
 =?utf-8?B?R1FUWVJxZ0NVTlllZ3NxL2NoTFh0VFdta3B6eEszQ2VscHJUMUdzc0phbTBQ?=
 =?utf-8?B?Uk50eFB0U1QvTzdyS1VtNGY1WWNVTTNyemplRnNOeGM0U3dRNGNuZFg1SWJq?=
 =?utf-8?B?dVlKV3lZelduQ1E3RkYyZ1M3TVRlcTUxQ2NNNkJ2ZGhxOWpibXdicy9sS3JO?=
 =?utf-8?B?UzFCcjNpWXIyVDJtTHlKYkRIWHFWOEYwU2kwVlNxTmxVdjNpaHY5NkFiNmdP?=
 =?utf-8?B?T3JhU1pTeURTaE5UYnlMc2NmRTYrYjdGNHZZNW5IZGJ1WWsvelRXUWdhY3k0?=
 =?utf-8?B?SkxhUnN3bGhMWDRsaGRGZWZoQm5MOEppdlFoRHQ1cyswdmRGYkFNVkRoT2Jl?=
 =?utf-8?B?Qlk3UGFyL0ZjcmxQbDhnMng5R2Z2a3V2UldnVDU1Q0xXYmZiaG1CbDdhTFJH?=
 =?utf-8?B?bkk0cWdvbFo4eWNNMjNDZ0g1ZGZ1RUh1NkNxN3k0SmtBWmRYYmJONTRXVWdT?=
 =?utf-8?B?MHpuaFh4SThkcXNtY2FhWTUwQ1R3Wkw3SnlnTllZSk5WTjE5R1dmc2x2WmRv?=
 =?utf-8?B?QVVKZzQvMWJFZmhOdFdTVHNOakh4YjlHeHpKZkhzZXlaNFVadi9hK1RFbEZC?=
 =?utf-8?B?WHpkNVFGTnh0emNQWS9kdGg3SmViZzQvM0RWSS95V2tVOS8wRXlodjV5UGxB?=
 =?utf-8?B?NW03TGpKam53MDlpSGIrUk5NbzFRZEFlNk1iK1h5ckdpL0owVSt5Z3RsOTJE?=
 =?utf-8?B?UWdyN2pnVGZ4aWxLbDZHTjlEL3kra1lLbG8vZ1JIQU9xWm1FbXdWYXJsWHB0?=
 =?utf-8?Q?pAKy2netZdEB49s4KO9J7S4yw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14196400-c847-4f7d-e566-08daa50a7559
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 06:42:36.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ARf9gmOP8+bwS2nErI50irV5Obj8EuAlj1wvxXm7PQ4N0wG3uYybY6o+Yxm+6w/peo37C4eprB1UJZu1Fl2Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/30/2022 3:30 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Krishna]
> 
> On Tue, Sep 13, 2022 at 06:48:21PM +0530, Vidya Sagar wrote:
>> Refactor the code to extract the command code out to program
>> Control Registers-1 & 2 of L1 Sub-States capability to a new function
>> aspm_program_l1ss() and call it for both parent and child devices.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V4:
>> * New patch in this series
>>
>>   drivers/pci/pcie/aspm.c | 63 +++++++++++++++++++----------------------
>>   1 file changed, 29 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index a8aec190986c..ecbe3af4188d 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -455,6 +455,31 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
>>        pci_write_config_dword(pdev, pos, val);
>>   }
>>
>> +static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
>> +{
>> +     u16 l1ss = dev->l1ss;
>> +     u32 l1_2_enable;
>> +
>> +     /*
>> +      * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
>> +      * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
>> +      */
>> +     pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
>> +
>> +     /*
>> +      * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
>> +      * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
>> +      * enable bits, even though they're all in PCI_L1SS_CTL1.
>> +      */
>> +     l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
>> +     ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
>> +
>> +     pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
>> +     if (l1_2_enable)
>> +             pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
>> +                                    ctl1 | l1_2_enable);
>> +}
>> +
>>   /* Calculate L1.2 PM substate timing parameters */
>>   static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>                                u32 parent_l1ss_cap, u32 child_l1ss_cap)
>> @@ -464,7 +489,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>        u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>>        u32 ctl1 = 0, ctl2 = 0;
>>        u32 pctl1, pctl2, cctl1, cctl2;
>> -     u32 pl1_2_enables, cl1_2_enables;
>>
>>        if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>>                return;
>> @@ -513,39 +537,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>            ctl2 == pctl2 && ctl2 == cctl2)
>>                return;
>>
>> -     /* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
>> -     pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
>> -     cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
>> -
>> -     if (pl1_2_enables || cl1_2_enables) {
>> -             pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
>> -                                     PCI_L1SS_CTL1_L1_2_MASK, 0);
>> -             pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>> -                                     PCI_L1SS_CTL1_L1_2_MASK, 0);
>> -     }
>> -
>> -     /* Program T_POWER_ON times in both ports */
>> -     pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
>> -     pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
>> -
>> -     /* Program Common_Mode_Restore_Time in upstream device */
>> -     pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>> -                             PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
>> -
>> -     /* Program LTR_L1.2_THRESHOLD time in both ports */
>> -     pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
>> -                             PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>> -                             PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
>> -     pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
>> -                             PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
>> -                             PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
>> -
>> -     if (pl1_2_enables || cl1_2_enables) {
>> -             pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
>> -                                     pl1_2_enables);
>> -             pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
>> -                                     cl1_2_enables);
>> -     }
>> +     aspm_program_l1ss(parent,
>> +                       ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
>> +     aspm_program_l1ss(child,
>> +                       ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> 
> This doesn't seem right to me.  I think the intent is to update
> LTR_L1.2_THRESHOLD and Common_Mode_Restore_Time, which are encoded in
> "ctl1".  It does do that, but it looks like it *also* clears
> everything except PCI_L1SS_CTL1_L1_2_MASK, i.e., the L1.1 Enable bits,
> the Link Activation bits, and the RsvdP bits, which I don't think we
> should be clearing.  Am I missing something?

Agree. Instead of updating some of the register fields with new values 
while keeping other fields intact, this code programs the register 
fields with only new values and also programming all other fields to 
zero which is wrong.
Thanks for catching this. I missed it as the card with which I had 
tested didn't have L1.1 support.
I think the following modification should fix this issue.


@@ -537,10 +537,23 @@ static void aspm_calc_l1ss_info(struct 
pcie_link_state *link,
             ctl2 == pctl2 && ctl2 == cctl2)
                 return;

-       aspm_program_l1ss(parent,
-                         ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
-       aspm_program_l1ss(child,
-                         ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
+       pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
+                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
+       pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
+                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE)
+                );
+       aspm_program_l1ss(parent, pctl1, ctl2);
+
+       cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
+                  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+                  PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
+       cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
+                         PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+                         PCI_L1SS_CTL1_LTR_L12_TH_SCALE)
+                );
+       aspm_program_l1ss(child, cctl1, ctl2);
  }

  static void pcie_aspm_cap_init(struct pcie_link_state *link, int 
blacklist)

But, given that you mentioned we shouldn't be touching Rsvd also, I'm 
wondering if the following can cause any issue?
With the top of the tree code, the CMRT in ctrl1 register is updated 
only for the upstream device whereas with my change, it gets updated 
even for the downstream device. Although spec says that it is Rsvd for a 
downstream device (i.e. upstream port), I'm wondering if we should 
really avoid touching it?
If the answer is yes, I think it is better to drop the modifications 
done to aspm_calc_l1ss_info() function and just proceed with rest of the 
modifications given the way it is differentiating between upstream and 
downstream devices while updating the registers.
What are your comments on this?

Thanks,
Vidya Sagar

> 
> Bjorn
> 
