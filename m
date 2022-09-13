Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5DF5B6E3D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiIMNR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiIMNQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 09:16:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D190F31DDF;
        Tue, 13 Sep 2022 06:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIt3N7BxS/9imwYXwudBeTno5gn2d/G67Hn6Kib4EGJwmcy4tCOg9QgfDlNLAIYcRTQEPXzWTZaOUozYGK5HP3vnTI8qisBOAOc/hKfKSnufmprW198npc8QjxrEqY0TldA+4tdSR0fJ+0PkmSPyzuD/SsDs8VzXACgRgVU8AWK14sPzlhoIYnz0ujaJJBjEZL8C4SRz+ShWQijpObyi+pltVzYYwh6EEpGkh6I5+2pmYtJzCXxGd2YYw/0x0t10z5RVi6qT75IiFXYihdV+Wo2ZZ/AmQiXLk9RYIovfZ8G+C17n7jmZoANvtzfeBK6VfaBcfHnJtjoFJbXXQH9yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMWyY4ce/MorFi7JQTxip7XQojKwoA0c3My1XKTEsc4=;
 b=iJDhP268sCxyC+oUQtwiunQ1RO4zdvqGAoS74Cwtwrug65DydTI9AXzNSghsTXOQbXoPe8dE5S5TnGI1z99IiFm7bwZseOD76bUGT9MgVbKbcl/rXGu/9F1KnodMmyKUMu5C5gdN0M2fTHIu1nuOdFNSW62R4YZOF1/o/4XjHapKjCJPTRTinjHZUoIQ9qCtlWA1fQQ3VKmAWoccgRLk6AgUSR1IrY2hcyFi1iz/k0mBcoCoLltT3bHkr4rS3C0SaEc2wKi6rsrAnK6j4MUb+UuPuS4ytZ64eBG/ksRP8kDtoWIoVWB35DidfrYo+IAEQM3tRNeyJpLUTsr8d0bO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMWyY4ce/MorFi7JQTxip7XQojKwoA0c3My1XKTEsc4=;
 b=nHNeCUT7VhByPqJgUYRj89oM3AKq6Nj0HIanJeTAD0TXo65tOQGb87rPsEV1vTIpj5TZs8WpQwbePrTEzI1btYhJjYbp1wH1aR1SkT8Zsnx4RCz/tkT8SRtHblvOMg03yqFjV7Nd2dxLi01UQvVrSIFFn4Pejduqw8WT/gL5JKPejmd8HFrXwBNLqn4eAJkcECqQnBdTmX4jT6KZB8r009aM6GDo7dj2roufQALnLfTLL8v0iA08JnqBf2n7NwsPPNKjRLbmEHwfYKBKHTB2rxSBcQa0I75g8vYpneZFepqOEGelNjmROAabuZM0nl68USxS7yJW0PimswShp1dYDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 13:15:58 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::1d26:504d:7cde:3158]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::1d26:504d:7cde:3158%7]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 13:15:58 +0000
Message-ID: <b1933ca4-13a8-83a0-d9f3-1ecea467948d@nvidia.com>
Date:   Tue, 13 Sep 2022 18:45:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, kai.heng.feng@canonical.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        benchuanggli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220907210540.GA140988@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220907210540.GA140988@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e01790-c64e-4eb1-dafd-08da958a1886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TxXQtEx33qUE4QQgsxeiYrDyjc4+sVcaWsvdXelHO3RL5Ue4TphwKiDbegqtz4wEyMy+Y956zfqCva5U9DF2UI5uhbU0pVzlkVWg4suDuQRev65LVI9WqWSLgveM7D2PDt0UHapxugOpVwpgsxSA21/dpGlOcU25SHfXVFEOT9F3uWeMUvRxAdLyj1p0uqkJlp3MpnTr2myx3d8CP+X4GjJ/2RAM0GFu6mXbVxEGN0Vi/ZOlup7D0/OHurzpHeLf7yUTvCzyza7mtOOsBVD5ZdlBV6wnURfDOUwX/l8LRhVIv+p+NxLzr7H19aH5aVVjsYqToKZuLxP5hKDFzRvS6ZcB3dlKkOcRnrL6USgwrxeUYhyUVbf6cv23cSgQTDY62+t7eXoRUIpJyco9nWwNbSSWrgkf7iL3cVP8RtS9zDHVp8YWElJBfFFqJZC1TSdAhKPC3ULoIWujUZllIbAbEcF52vKcsg18AcqIvS2UgI4GhTtEiApxORfVtABk2VAqpInP+0rFa2VYCmRU5o6Dot7zSNsNDmRbx6PH1/Wo+klmmXuuPzILpj7sXp8YE09Dax+hM5pxWXtHoDHi4r9TU7X4+pMFxBj2MG+0syElqj9b9jVL2Zr/azokY3CZur4KckkSrexxcpwsJDFKSDpQjNDo/WYrmmLJGTotvZzFBTK3cEg7szPKL5/yIkwrEevXDo3LQjjCBkOirDqaiQEhjbG9HfJB6p1C866v6FGymyj32krtx2gmZmz8P0bHgLldlx0vVhO1BRH7xMhBLKhue4+0FYZLOOPbo4q6rFHOyhBBQ1Xj5/A29k/3iD5WTLgubgzYdGrI1egwujDd3dzI1KTT36ozaVHJlvbk/TBZ/MxTV1aJTs0FR9fkIH9yqZNoCCOPAHwkVssNnE0Q3kFwRv4hCSvYHMZFScNraytbJEy3dp5TBo8AYTHeGkoG0Nk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(6916009)(36756003)(8936002)(8676002)(7416002)(66556008)(66476007)(31696002)(478600001)(41300700001)(316002)(66946007)(966005)(53546011)(6506007)(6512007)(5660300002)(6666004)(15650500001)(6486002)(26005)(86362001)(2906002)(186003)(2616005)(83380400001)(31686004)(38100700002)(4326008)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTMyQVZDZmQzcExIQzN4dWVaM0luMmZpVU5URUx2NTUvMnhYOUlVcFNhQTky?=
 =?utf-8?B?RlpHeVJxT0lpaUVpdU5VM3NncVN6L21VMUpoN0Rlb3hKMUNNL0pNTm9rNnJT?=
 =?utf-8?B?SkwzZ3o2TFlvbkFOc0M3bXNiOUhaN0wyM0krbTl3cm1Bc0F6WGp2Qnl4M3FK?=
 =?utf-8?B?SU5WOGxxNktod3huTVh0b2FUY1M0MHhhUjZGcmt6UHdEeGtGVDNJYXJSN1kz?=
 =?utf-8?B?N3BjTjNOVTF1L3BhY2NRZWQ2elNzU01mQVlHemtuaHY4VmEwQ2tWOE5DVUR2?=
 =?utf-8?B?SUp5RHYyd2ZRVU5Fem1OZU03TEVTNlo0MElXZm5UT0doVzgzMEZ4WTJPQ3R4?=
 =?utf-8?B?Tmgwd2lDVFhIM2RHNzZ5a0dlNkg1b3dMcDlFRXpqN2NQM2FGRnYwRXlXUlc0?=
 =?utf-8?B?UHl3aDlVTjBIckdxNUxrYU5tZWZMeENQZWt1a0RObXBaSDV2a2tpbW5QNDZD?=
 =?utf-8?B?cDV0U3k0Sjl5SlNGdGticFdENlVUNVNMVjAyRGowYi9jT2ViTDExZ3doV3VP?=
 =?utf-8?B?L0dnY2ZVL2ovSkNWWXNrWnk3bmQwYmZPUG9HQkNCR21qTEtZMktQclJwRWp4?=
 =?utf-8?B?M1oxUjZxdkVMWm9rQXhtYmJMdHA3Z0Q2R1J0bkxEaHEzdkRUMGZ5VEJXek12?=
 =?utf-8?B?d1FZcldJQ25Va1Z3amRnUURLRlBVMEwwblJ1dUgxRnFRWHdWTm5KOHc3SU5a?=
 =?utf-8?B?RDN6QUEyN0VNYWJnYnBLUVZ6UDgwMUNxTzlWbzMrVDQvVEdUZG5NdmZWK2N6?=
 =?utf-8?B?NnBCREpRdzRndm52VjQvc2hiUXRzcGdjL1ZGV1pCQ1FCWjFDckF5L3NSMXd6?=
 =?utf-8?B?cUE0VW8vck1Kc24rN01zR3NRMU9HaE9pTHNlclB3TFlqRS9jQjV6aHNFMFBO?=
 =?utf-8?B?Rk5qejhLeXNNdlgzeHFtZmpXMDB3MFRrTy82R2FZQ0tFWTNBK3pqSmU3VHJL?=
 =?utf-8?B?ZTdTZmlFSTI2K2JxdWFaMHVTUVpLSm91VnIzeStlR0xEVFJPemdEclNOQ1Nu?=
 =?utf-8?B?cm81cmdJejZTRWZIUVZjcTgzakFEbVdBVThqSlljQVhPT29GR2NmQXQ1RjF3?=
 =?utf-8?B?VXR4ZzZyUGJlZFg4dXJoeVpVOUZzM2V2TkE3L0VhdGpRMnVOVXB4K3pPczZM?=
 =?utf-8?B?SjJ0bVNPb3lGUjEzOWNJSVlqTHpmblREVHltaWg4bVJEZUNxbzNBV0Rla1Ny?=
 =?utf-8?B?NVp3dGRJYWg2aTBvUkJnWnBNbzU0VTVxaE9VRG82VjVDakxJUnoxbkZtQWxQ?=
 =?utf-8?B?UkFhb3dMVlZSSkVQdmhJN2pSRGM3WjZGVEVxdGNjZXhLazYrdjlRanNKbzVE?=
 =?utf-8?B?dGkzUjd6aDQxNTQ4VmEydjhxdjJyV0FNRzNHUGVZQlRTQmMxazlMVnBZbGNT?=
 =?utf-8?B?MGJON0ZscWZUbEVkOExGS1l3UDFteEJFeUFBU29Uak13cVJTM1c2NGVyMTZl?=
 =?utf-8?B?YnZZMUhpTHJRTGo5U0dUOWpQRDFNZDFvOHcyOTZuUi94OWhTVldQNzhJUHhl?=
 =?utf-8?B?UDBXZlB2dkN5QzAxQXp6RWZwcFdOUG9mS3Q2MTMwZUdlWGFYeUZ6OFFaYVlF?=
 =?utf-8?B?MWZVc3QxZWppelVPZ0ZBdkhpdjRZRWJRTlhCcS9UL2FoU2lGNDdzUnczcjJ2?=
 =?utf-8?B?Y2g5ZVhXN2V5eTlZRFlPSHV2RW5oc3lDamVXemg0RVVkMXJqblRjSDZheUN2?=
 =?utf-8?B?VWkzTW9IK2ZReG5DckxqcFRDT011UHI3cXhnTE1qQlhtaXlLazdXeDJyeXJ1?=
 =?utf-8?B?ZWFWYnlTSzBhZ1ZaMVpXczZmT2F6Y3lTRWlDbzRMYTY0WFQyQnNTTXRnWTRh?=
 =?utf-8?B?M3p5WmZsOUpCL0xVMGVDOWFHalQyQUZJdzh3VCtPZUxiaVgxUjVzbk1MOXJ6?=
 =?utf-8?B?dC90dlEwUitFQ0oxZGlFUURWandVdGpFSUs2d0lVbG55SDB3TkNER2hTSkV2?=
 =?utf-8?B?N2xIWG1oWUlzS1luQkNZeC9HN3h1RHNTM1J6MkNUTTBlcC9vbFhpUlJvTU1H?=
 =?utf-8?B?bTZxNDR1dktIUmhobXRFa1huK0NJZVpwVTF1OEZUWktEYWtlRzBlT3ZIbkkv?=
 =?utf-8?B?eUtHeVVSTXFVd1g3YkRvS1VOSG5JZ3N5ZWgzVmVvOUlJdTdFTWRIRTgrWVhY?=
 =?utf-8?Q?jzbz6rcgpPqkf5CxRlw+dsDms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e01790-c64e-4eb1-dafd-08da958a1886
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 13:15:58.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4E1PSynndHYacbtKvTX5RykPxNyE+GVEcTW53p9wJnbWVVAl5KUVGzJSInzdfvrqnszfx9dUk+wj811olHgdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/8/2022 2:35 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Aug 26, 2022 at 06:25:26PM +0530, Vidya Sagar wrote:
>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
>> saved and restored during suspend/resume leading to L1 Substates
>> configuration being lost post-resume.
>>
>> Save the L1 Substates control registers so that the configuration is
>> retained post-resume.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V3:
>> * Disabled L1.2 enable fields while restoring Control-1 register
> 
> This really looks promising!  Has somebody confirmed that the
> disappearing L1SS capability problem doesn't happen here?

Based on the update from Lukasz in 
https://patchwork.kernel.org/project/linux-pci/patch/20220705060014.10050-1-vidyas@nvidia.com/ 
(last update), the L1SS capability registers disappearing issue is not 
due to this change and they are working on it seems.

> 
>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>> +{
>> +     int aspm_l1ss;
>> +     struct pci_cap_saved_state *save_state;
>> +     u32 *cap;
>> +
>> +     if (!pci_is_pcie(dev))
>> +             return;
>> +
>> +     aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>> +     if (!aspm_l1ss)
>> +             return;
> 
> Isn't it enough to check this?

Yup. I'll address it in the next version.

> 
>    if (!dev->l1ss)
>      return;
> 
>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>> +{
>> +     int aspm_l1ss;
>> +     struct pci_cap_saved_state *save_state;
>> +     u32 *cap, l1_2_enable;
>> +
>> +     if (!pci_is_pcie(dev))
>> +             return;
>> +
>> +     aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>> +     if (!aspm_l1ss)
>> +             return;
>> +
>> +     save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>> +     if (!save_state)
>> +             return;
>> +
>> +     cap = (u32 *)&save_state->cap.data[0];
>> +     pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>> +     /* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
>> +     l1_2_enable = *cap & PCI_L1SS_CTL1_L1_2_MASK;
>> +     pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1,
>> +                            (*cap & ~PCI_L1SS_CTL1_L1_2_MASK));
>> +     if (l1_2_enable)
>> +             pci_clear_and_set_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, 0,
>> +                                     l1_2_enable);
>> +}
> 
> What if we did something like the following?  Then we wouldn't have to
> duplicate the fancy logic in aspm_calc_l1ss_info() and
> pci_restore_aspm_l1ss_state(), and we'd only need the big comment in
> one place.

I'll refactor the existing code accommodating this suggestion and push 
L1SS save/restore change on top of it in the next version.

Thanks for your review comments.

> 
> +static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
> +{
> +       u16 l1ss = dev->l1ss;
> +       u32 l1_2_enable;
> +
> +       /*
> +        * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
> +        * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
> +        */
> +       pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
> +
> +       /*
> +        * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
> +        * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
> +        * enable bits, even though they're all in PCI_L1SS_CTL1.
> +        */
> +       l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> +       ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
> +
> +       pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
> +       if (l1_2_enable)
> +               pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
> +                                      ctl1 | l1_2_enable);
> +}
> 
> (This is somewhat simplified from what aspm_calc_l1ss_info() does
> today.  It looks to me like aspm_calc_l1ss_info() does more config
> reads than necessary.)
> 
