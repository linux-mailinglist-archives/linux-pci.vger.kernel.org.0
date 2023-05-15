Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAA703D9B
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbjEOTUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbjEOTUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 15:20:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41612268F;
        Mon, 15 May 2023 12:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQFPDSO5VfEIIYKHmkzbLexKIbNnSQ8PH2oHiIZdQVqPC19DKcdYN+ndU88Syxhw1pc9+f0vT/uXCgzh6wHKmFJNT+B1acn5t64dA6Z1xKrAc9T2dpnhcWBOPmwDrCrKwzVqjH5SzFN/EFAkllsX3nt4YHglHyTuQXibbjReDbnTH/FnmKI1sZ+AKGsvHUdDeZ5PnZ99dXoQJdR6alOnwoyiXzubhqaWTTtZHOlFojLJTEiSTwZZl5vktaAvYm4/VYW7RfwYXog2+ezc4nif0N9M4TICRBoJ/NPs6UaxX688YvTRmdAl3cPDwXsLjf6Pf4Xw5RkS9IXV/VDS5T7Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuQXTLLhWPgndb+ffj1zn1z6Mgh+RcuHG480U+gLPDk=;
 b=FfS6z2ojCnCI/ixbaNNNfHUlpc8Iz7SWtTsLdHWUlo/HSgrua31yqL4ljXLeua1lxg3ttR6FtcHdvAyFHJy4cz8/q19d/K2VdE6hecyyVh5gOCdTgik0XfAVF3EI54hWvH4D0EZxQg/qOi069q4yD/pYJoGgRhFlvKw29RBARWvGQ6Ao3Wox2MGKiQKoqvXfCpRTJp0S2sbaf42tVNfIFAFVy/b6xdcqdOE9T47LYokS101Vuk41NgD9B5mfkw2Qf2/dmt1vxKh/6ilcr60VPBIegTeHl5KxxLC4IZiiHLJVVjq59GR0nLTxIAvXEDtfJO+Ee+r4Hox+dwkI4XQRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuQXTLLhWPgndb+ffj1zn1z6Mgh+RcuHG480U+gLPDk=;
 b=C49iz7Lq/rXfuBTjf/7TTZSBB6Jv5NziMgSYGs5tsiQ5DIvCRdtBQp9zveDKvOC3oZRn/usiWSBISptypP7AtdXmIXg/B+99dN+0oty0e2kdDhC2HCxts1XeOAsPGDwsnb3O5B8Z9e/p7uX3EhMCsvVoXK0Pm7qnPer/WsF7KhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 19:20:44 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::8b48:9557:ef60:f7b4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::8b48:9557:ef60:f7b4%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 19:20:44 +0000
Message-ID: <579cb233-4827-2d03-56ad-1b807a189ba8@amd.com>
Date:   Mon, 15 May 2023 12:20:42 -0700
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
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
 <20230510201937.GA11550@wunner.de> <20230511152326.GA16215@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230511152326.GA16215@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3f09e1-dc61-4ee7-d10f-08db55797aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVYhZyAHSNqcX2PQLer+RlUvHUA4pFA/eJzTFdnQNvAGjMFIQaJJq6bXetuOK2ubKw8hP/j9p7oo/k5EPz1DNHfXC9LBR+pVk4gyHTTnC60Xniodudbje2//RvP4daJS++tvPNqWnLnnNC+gApAtkCnLCgbiQc17dD1KAzd7CxGs5aOoHNDcw0QlXW0Nfeog19jaU7rsztBO7hOMQ8aewgb5RaLGn5FgicygyQn/0zi0agLBbOPNwvlPHrbD9iVqnjvXXZ5qIDu6q8MhXHPEwHt0fWXVlqwi0C3TKlqPKUxzwdd3LHejGqQyOUlHaD2+FN01JWTHXAZZW6Poj8ETi7Z2flyRSuRYTNh+kdEk9aEz9C/dH2HP5OYMTMbeFDev6+ce2O8d20nRBDouNwj0+NX07KE8WgHtxi66K2pc6n21RNoIBgL05A8ErXayJPWHiENQMMKoztoGa+zUZ+6XLTZwgSuSWOMDVp73r2guBnxjYV18RvtMGRMNS2dfEiTDB4RvqgeniqDmurksA0QMytUmrdc1I98Dblm7NuZO+zRUx1/HoM1iqp82K6bcmpUTsYSEzPioMVLGpFG7PtCteYwnNTXDmG5Yr0lgA2sXhpFM+xw5bYcgtrslsFfMw4M5GQDy0hYAkLwzgMinpeHUSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(31686004)(966005)(66946007)(66476007)(66556008)(6916009)(4326008)(478600001)(6486002)(86362001)(316002)(54906003)(36756003)(83380400001)(186003)(53546011)(26005)(6512007)(2616005)(6506007)(8936002)(5660300002)(8676002)(2906002)(31696002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtCSkpKMHh3QmJmQSs4aGJlLzgwdW94K1VOeVNwQWwvU0ZnT2I1NWJ3NmpP?=
 =?utf-8?B?VWIrSXZ3d21DZGFZczY3M05QMFlTWHRiRVByWVRBcTBXMlg5amk0aDZuNk5a?=
 =?utf-8?B?SkE4N0p0WkhDR25OSnU5Zndja0lGNnlrUHk2Q0wvb2ovUVR0WXQxUW5kclhU?=
 =?utf-8?B?ZWNPNWhVaU9HM1Q2aXQ4czJWMXlxb1Fick1wUzNKcitsMFVvK1Q1eFRCcmRI?=
 =?utf-8?B?a2R0OXdEemhheXB1ZVhrQVBUaGpmR2FIM1Zxb1FCamJmZDZUL0dVWmVuZ1lX?=
 =?utf-8?B?d1JZTERtRjR0THNsUWR3Wk1xaEFoSGpKZnlMUFdhSE16MXZ3cjlCcDU5VC9P?=
 =?utf-8?B?VEZBaUJieXVlTjNxWFdmdlpnY1c1eVR0MS9sUDJobFVubjYvaEVkQlk0RWVv?=
 =?utf-8?B?ZnlVa2lGdzZGQ1JPeUdueTIrcWV6MS81UmZPNHV4TTdxUmoxQkJuOWEvOVdm?=
 =?utf-8?B?OEZlL21kUGFmSUU1NDlhazZOUWtla1hrWkdlcjFSbHJYZ0lKQlpxaDhGWkZw?=
 =?utf-8?B?VHBzLzA5NmpNVFNKQjRqMnpraDhaWjV5MkdsRG5kOFRLSzZ3SnM5Wk92RHJ6?=
 =?utf-8?B?VlRlNDc5L3Q4dDk0MmtMd0ZNQU15L09RcEhMR3ZQZXJ0bkk0NHhLY2crVitj?=
 =?utf-8?B?Y1dVd2Y0MFQvNnRCKzlTTDAzaFRidUhLbHRxSVlwTUNtYzRWVjQ0dkVtQ2xs?=
 =?utf-8?B?TG1ia3QydGZISWY3YmRkck5pOGRQS1FoT0gyRmorZWt4dVRFc3A3T3BuMmNs?=
 =?utf-8?B?cmtGbTNiM1F4N3BkMlBidHROU01nejRJbUZJTEU5a0hDbmtqZWpOYnQ0SUxk?=
 =?utf-8?B?QjlLd2pSNG5wbGRRek94ODZhVzF5cTZqY1psRFcvVHdDVEdXRXJsamVOYzFw?=
 =?utf-8?B?S1E1TU1aWUR4blBKT1hucU1ZaWp2SEwrMEpNMlN0VDI5QVBYZlFZdjdQYTVY?=
 =?utf-8?B?UHhYM1BlK3dNMEpkMVEreWd3N00yOEJUSXhNTGlUYWw0ZDVPTzdNK1pNUHBP?=
 =?utf-8?B?Tm0rNXFtYmozcll5czdQZkp6L1o3QTEzQnRiZE1xeFZOZnI4eGFJZjB4dzBw?=
 =?utf-8?B?SlowOWt5UmFrWmtIZnNEREpNOTBUczQyZE5nTVVqa2MwQVEwaDJKbEEvOUdK?=
 =?utf-8?B?bkU3ZkVaZzNzZHFjK3NVeU81c1lweERFcndENXpsbFY1QUp6NFppelRDZWxi?=
 =?utf-8?B?aUsrSHhqNzhLKzZrNTVXRnMzRE5wQkt2aUZnTFVzNVduV05weHB2a05UYUFs?=
 =?utf-8?B?U1g5VlcxQTNkRlhja1FUSkV2NmRIK28vNnBJUlMxRTJRWlpFd2dpNjlvSDAy?=
 =?utf-8?B?N1lzbG1HRk1aZ3JyS2lpN0ZwUVEvR1ZtYzR0Y0wraEdHMmQ3bGQraStkWlNl?=
 =?utf-8?B?VE83R0tNSXFiaDNmbTdhQmpDdytGaWFLQkQ5amYzTDJveDJOUGQ5K3U2ZGFK?=
 =?utf-8?B?cW5rZTgrek94MzFXaXR5aGJpVC9raS85RzFramtnUXk1Mnh2SkRHNk96bm5Y?=
 =?utf-8?B?Vk1hQWJ3L1pYcmg4U1JXcXM4TkhLMnFYVEJXM0E5MHpGS0NhMlRiZU40SFNl?=
 =?utf-8?B?bUVJOEJ2SDN6N1FnNlFBR1AxODZiYzFLM25HcFY0OXFJWDMvYnY4WkU2TWFH?=
 =?utf-8?B?Yk5EMUdPd1pSdWtSQnpzUVhtUE9lYU9EOHFibFNaZkZQRW5TeVdBY1ZWeWla?=
 =?utf-8?B?KzduVit4UGM3cE8wSkg4ZUFxT0ZvQVptS3ZTL3U3bi9IaEhLRUZiS3Q5aHNC?=
 =?utf-8?B?dSszNDB4U0FXcFd2YmJyMkEvS2R1TStWbEVHb09vRnpFREpPNzl1R3hFYm5x?=
 =?utf-8?B?NHdhMU9ESnNRbkVVTjl6YzFvNnBPdjJuSjBCeGtSY0ZGRkZhTGJJcHlSdmJ5?=
 =?utf-8?B?c3VJNndncFJCK2FIN1QzVS9hWlNGaGlRb0g1cVdVLzcwRWx3VCtsTGRTQXlK?=
 =?utf-8?B?Nk02TWNSejFwWEt0emYzNTdSeFNGRkVVcHBiNENTZUtDd3hWOGFTcVhFMzZ3?=
 =?utf-8?B?RmFkVWV0bGdISGkyWlFQUmkrRVZtWW1rekVTWVBtNEw2UGhDN0N6ZUFIMjFn?=
 =?utf-8?B?bCtQL3l5QkVhNHcxNUd2VXdCMzRUNHVVeVZIcmhSR2wxY0lOc2ZQSWR4LzZw?=
 =?utf-8?Q?ZHtydFc3N6sFO/LHNNiSrW9mn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3f09e1-dc61-4ee7-d10f-08db55797aef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 19:20:44.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0hgovEQjytXnYy2nPOYONW9bR0tTMuJSsu7BbOCABOYy0KQ9OryJVpLOwwNEnpWhNmhUmrMcwwRM8Am8jKgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On 5/11/2023 8:23 AM, Lukas Wunner wrote:
> On Wed, May 10, 2023 at 10:19:37PM +0200, Lukas Wunner wrote:
>> Below please find a patch which
>> sets the Surprise Down Error mask bit.  Could you test if this fixes
>> the issue for you?
> 
> Sorry, I failed to appreciate that pcie_capability_set_dword()
> can't be used to RMW the AER capability.  Replacement patch below.
> 
> -- >8 --
> 
> From: Lukas Wunner <lukas@wunner.de>
> Subject: [PATCH] PCI: pciehp: Disable Surprise Down Error reporting
> 
> On hotplug ports capable of surprise removal, Surprise Down Errors are
> expected and no reason for AER or DPC to spring into action.  Although
> a Surprise Down event might be caused by an error, software cannot
> discern that from regular surprise removal.
> 
> Any well-behaved BIOS should mask such errors, but Smita reports a case
> where hot-removing an Intel NVMe SSD [8086:0a54] from an AMD Root Port
> [1022:14ab] results in irritating AER log messages and a delay of more
> than 1 second caused by DPC handling:
> 
>    pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
>    pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>    pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>    pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
>    pcieport 0000:00:01.4:    [ 5] SDES (First)
>    nvme nvme2: frozen state error detected, reset controller
>    pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
>    pcieport 0000:00:01.4: AER: subordinate device reset failed
>    pcieport 0000:00:01.4: AER: device recovery failed
>    pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>    nvme2n1: detected capacity change from 1953525168 to 0
>    pci 0000:04:00.0: Removing from iommu group 49
> 
> Avoid by masking Surprise Down Errors on hotplug ports capable of
> surprise removal.
> 
> Mask them even if AER or DPC is handled by firmware because if hotplug
> control was granted to the operating system, it owns hotplug and thus
> Surprise Down events.  So firmware has no business reporting or reacting
> to them.
> 
> Reported-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Link: https://lore.kernel.org/all/20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Thanks for the patch. I tested it and I notice that the AER status 
registers will still be set. I just don't see a DPC event with these 
settings.

I have logged in the status registers after the device is removed in
pciehp_handle_presence_or_link_change().

[  467.597119] PCI_ERR_COR_STATUS 0x0
[  467.597119] PCI_ERR_UNCOR_STATUS 0x20
[  467.597120] PCI_ERR_ROOT_STATUS 0x0
[  467.597121] PCI_EXP_DPC_RP_PIO_STATUS 0x10000
[  467.597122] PCI_STATUS 0x10
[  467.597123] PCI_EXP_DEVSTA 0x604

Section 6.2.3.2.2 in PCIe Spec v6.0 has also mentioned that:
"If an individual error is masked when it is detected, its error status 
bit is still affected, but no error reporting Message is sent to the 
Root Complex, and the error is not recorded in the Header Log, TLP 
Prefix Log, or First Error Pointer"..

So we think, masking will not help in not logging errors in status 
registers..

Let me know what you think..

Thanks,
Smita

> ---
>   drivers/pci/hotplug/pciehp_hpc.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index f8c70115b691..40a721f3b713 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -984,8 +984,9 @@ static inline int pcie_hotplug_depth(struct pci_dev *dev)
>   struct controller *pcie_init(struct pcie_device *dev)
>   {
>   	struct controller *ctrl;
> -	u32 slot_cap, slot_cap2, link_cap;
> +	u32 slot_cap, slot_cap2, link_cap, aer_cap;
>   	u8 poweron;
> +	u16 aer;
>   	struct pci_dev *pdev = dev->port;
>   	struct pci_bus *subordinate = pdev->subordinate;
>   
> @@ -1030,6 +1031,17 @@ struct controller *pcie_init(struct pcie_device *dev)
>   	if (dmi_first_match(inband_presence_disabled_dmi_table))
>   		ctrl->inband_presence_disabled = 1;
>   
> +	/*
> +	 * Surprise Down Errors are par for the course on Hot-Plug Surprise
> +	 * capable ports, so disable reporting in case BIOS left it enabled.
> +	 */
> +	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> +	if (aer && slot_cap & PCI_EXP_SLTCAP_HPS) {
> +		pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, &aer_cap);
> +		aer_cap |= PCI_ERR_UNC_SURPDN;
> +		pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, aer_cap);
> +	}
> +
>   	/* Check if Data Link Layer Link Active Reporting is implemented */
>   	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
>   

