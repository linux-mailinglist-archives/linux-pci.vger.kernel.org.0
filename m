Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622D27BA8F5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjJESUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJESUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 14:20:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5290
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 11:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta89l9V2SvqD6gshf0i1tWDynRIEXKIypFXIxjtnuxUuOCL15tFvgJhpZx7ycJXvK/JJ7aenCoxgljk76VAu20IjrNF1Sct0Jr0BGgwCDHbPV9mEYMSt0roBwmq81TluhtQuhBmmCB+Ykjq8uMzZtVDs3x5vj3rFbxeVTGwyxBjLWqlHBK2iMwG2LNLwz3ZuR/CZQKNlIDsshdexdnPlDyh8u1fEDGgVoJuBN5UadBy9543rssCSJZp0YqCjV67g+fuNlza6k4Jz709t7P3P3PKfjFKoVDl8yaAnEuOz57vjO0ee59HOnvFkVbtarwJlYU04gZrbIMufFEnelk+B3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iybSqq0MWjsjkwWYRyr4HnBQAxEVusr/an9Il3Tbx3c=;
 b=jhTV6Ib9IDSdBFrBKlHOgN2BFhnkgPax4JgllUFkjrnb7ash8ihg2LNRGX8r/EWeyfjTUwcAxHymcgAsb6S2uraO6AgnplGq5/GWZCfaCRU2hmstQjtmqP9r2u2xom6pN9ZZ6yZvQuWfSu/6lHqp5ARrTPA5LkE5bz0Zf4Ubjd0d8x+54IEp9vAOJKO1MAPLj83Gkir0aazAGz5QqLYUqO3g8/h6MWuSa9q3AhknBEjyESQKXvAixZH4UBhbF5noDFwRfh7/ktEbe1JNEzJKvL8EC6+rrraSF8hi/8proaJL16E7DySiHuNXyduJ2fQIenK1VHt/tyGxouR8t2UeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iybSqq0MWjsjkwWYRyr4HnBQAxEVusr/an9Il3Tbx3c=;
 b=wg6ct+xyxaOsZ+n++X2xkjJihYAHNcik0IPFDDh1g5tBpZ6GfzSHMWuLDPLEKbY9OLudHWBgr7rCQ3TtFXkMEEfrV5ZF9Y/t6U7JLnxrjKtiduD2B19TpkWqXoni8GLrSlhV5ou2TDJ68bIa1ua96NtCKUzmlvS2Kzh/P5kUcPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 18:20:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:20:27 +0000
Message-ID: <ece443d2-69cf-4887-8af1-a421f9348667@amd.com>
Date:   Thu, 5 Oct 2023 13:20:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20231005181440.GA783423@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231005181440.GA783423@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 55adc826-1677-46e4-9fcb-08dbc5cfbfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xn+ubEa6wYiQln0RoVb1PG7BBLyZ+s7/w1ZKPDyjsta0VoeayTpYeIkvNiqD00AxNuP7pPzt8AYdv0p2wwLM+7wdmHXykjIy8++eAYsp+hxrJh+ZNdG5v3p5qQ/pngDh3Ipzu32uSqd6/Iqabv8D6SN2MoqrXyfTGtbfnbpHeiM7lDteorPaoxJieCKwQP3Lekmo/CPZzoBiDxuJ5MbQLqetVrUyxxp657JSLczfGAuXUdGORRIBQ6U1Tr5HHHNvI/wWb7NeWKFIbAaGtfU1F629ffH07eoESDQTU2mAHjGfZkwd1prlP68Az6dH9PTvJxGv+I2kEdDLGz0nIAMfPfRfx/ZBQ0DcsbQsvsamEyMdhUzoziCnqNTTLcURGUFgxAJZQFa95ZU1cY+bcDYYFhuHwezFOJKng/woxVXO9ggZAuzO4M9fGLJyp6NWty1DKa8FF3X2JX83OdPtHLbABPMwq+n/sGkKhJ3MZd9yCMSg1qyCOxZAp4qPhx8JCSBV+4SgmUAu0qE7OG05B1xsXd8EL+ltsE3uznGt9BN67KLjLCPDg3aln8jefRS8qETn1jayhNBJ8CP9WEwL8+mar4e3qeIKtrX0ZN85UgXO7ANesfEZ5aI5LaqN9uP2k6O/WYHRb0nXTcYkuPZlT+Q4lYwiE2l+tI760v5goUpFG+w9/bU/dzUQ96bg/jjNCM4i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(53546011)(6506007)(2616005)(66574015)(478600001)(966005)(6486002)(6512007)(45080400002)(6666004)(41300700001)(54906003)(66946007)(6916009)(66476007)(66556008)(83380400001)(316002)(26005)(31686004)(8936002)(5660300002)(44832011)(15650500001)(2906002)(38100700002)(4326008)(8676002)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFVNHZ4N3A1ZVFPajRjRWcvbjhWQlhoWkFvVHd0R0RTL0hvbGVrTnFiYWtK?=
 =?utf-8?B?eEp6TEZ4SUZWWHQvSG8rblU2QWg0Z1ZSdjQ4VnlncVpWTjNUSGRwamc0akxa?=
 =?utf-8?B?dHEwT1FYWDVNaU96NmR5Y3VVWUduTFQ4QVBRQjlzc2NUUm1ReW02cStiaXRK?=
 =?utf-8?B?ZDcrNDRjVTc0UGYyRGdUaEJYSjZERDlnTWJvUVVyK2szUlZwbW5qbEdwYTJS?=
 =?utf-8?B?SnM0c3d1S2ZFVkhKQnp1eHNnZTBKVUpEaE8xT3FZdkpWcGlaRytJWEp5UnZP?=
 =?utf-8?B?Q3Z2S21td0lXYkRLK0NLU1JDM2o1WVZtVVU1d2JCVWlQeXJJeDRXejNTSDlN?=
 =?utf-8?B?d0IwYUVVYkFUaHgxM0tjbGQrRHdTcXJadHlkMmg1d0tGY1ZGTkhKM285emdU?=
 =?utf-8?B?QW8vQ29uQXZ1MnRiQVFyWFlFOXRmUzFORUk3SVc5WmJUaitHUmJKNWl6ZHlO?=
 =?utf-8?B?YWJ2R0QrVTkrZ0dlc3JoaG5qUG1yY1BqYVZlNVFkcHl1NVZORXJEdGtkS0da?=
 =?utf-8?B?WEcrRGhzMjVzQit0WnFQYmlkQ3cxdWdVVE91T1FTKzNhUlBOR2x4T2ZDZ1Rw?=
 =?utf-8?B?MjVDWGFVNE92NitHOE0rNEFka1Y4aUd2S2w1TzYzQVNjNFZlMlMzcVIxT2FP?=
 =?utf-8?B?ZEFON2VyWjlSZzIrLzRFNmk3UVZNeFVOUFJ6U3Evei9iKzRXMDE3YWVHSHFD?=
 =?utf-8?B?SmpPQVZycmdrTUltTTRkK2JhRGw0cXAyTDRiZFRvSGExNm90TG1wUWZNc241?=
 =?utf-8?B?WVN2akRTV2l4aWx5NDBWSmY0L2I3VEFRNjRreWRUNWw3VDhzeXRvUk9tZWhi?=
 =?utf-8?B?cFBDQVBWWHlBQlhtQXZxRXdxVVVWS085VFlvdXBMRmdZd1RLY0tiYjJTME5Z?=
 =?utf-8?B?WjFJeEkzVzhPRWhaTEc3MmhOVHFZbGxUUENsMjBtb0VkVFc1aVRoRDY4VDVE?=
 =?utf-8?B?R1ZnMmpCOEpnVDRPT04vZEVBWnhKbU1BVVRjOFdhbCtZRFh1TmdQTkk1NVJo?=
 =?utf-8?B?RVdBWEM0UHZUWWd2TXhvYnhsMFBDRE1Sa0k3WU0wZC9PV0s1VmF2TjNWOUJp?=
 =?utf-8?B?QjJnZ0FRb1lVak0xRE53WFZ6cWJxRzFiUWN5MUU4R0k2RnQ2clRvWWhxYW4y?=
 =?utf-8?B?OENaakx0UktzM0taY2tJUXJ4ajJZSkEwQmpyZzJxKzlrelo5QWxtbUN0d2dQ?=
 =?utf-8?B?dXF5T1Y2ZWw5WHBvbVRNZHZwR1VjeGdzUThFTXQ3c3BFdDNqK2EvNG1wWlIz?=
 =?utf-8?B?MEMrUUlSRnk3OUdOWWxGWVVJL3ZHTUU4bHZaVS9TNDlma2c1OTZHcmZSbFlv?=
 =?utf-8?B?Ujc2QkYwSWVvQ2gyb3NETG5kNTdiLy9IZUo2U2JBVmlmVGtUenhZcFlSb0lh?=
 =?utf-8?B?OUhuMUg1QkJpZ3RJRDVQRTZJWGttbHdTMWcrSFp5TUlHTGpKKzVTaFIyTjBJ?=
 =?utf-8?B?di9nb3ViZEVrZTNySHpSQkc5WjBtc1cva055YmRxUzFRYUVUdHVaVlMzdVNF?=
 =?utf-8?B?eGozUlRGekJZSnNYZGRBNUk0TG5LOXdGYXhTT3BaWHNBNG4xRzRMeE9rMktZ?=
 =?utf-8?B?S2VDOU55M0FOcGRiSm95QTBXTlBhZzZKcENkYWpuUzQ5aDNNYkFKeWlyMFZP?=
 =?utf-8?B?NTBCN3BqNDV6VFBIZ2crNysveWx6ZXpsaTNMVCtJVUxNSDdlaTh1V21Yd09U?=
 =?utf-8?B?em1mNU8wZWNMbEV3VE9VTkFsR0dsdVNGZ1NGUDVOL3dIbGxkelRkOC95bnhK?=
 =?utf-8?B?MEhmVWl4RDRDTjlPTm1sbkNQSzZhS0pMbHNVVUVCTGZLNTZySDdIdmRlWWhT?=
 =?utf-8?B?UkxVRW1OT2dRbFp2Y2ZhR3VrUXFoUlRlQ3plL1ZRaDAzUjdDT3ZaelRaOFlB?=
 =?utf-8?B?ckIwUnJCZlNkTTFCbmpPaUFWbGswVHFmWTQ1USt0Rk5MYUtRWndaVGNyOGdi?=
 =?utf-8?B?eXhTU092STFZY1lnbHM1ZEkvenRVT0ZlZHhEM0I2UmZzOHVBMWUvdVJNVkR0?=
 =?utf-8?B?d3NpcVdkNEcvVGNlaklZUXE4NXZNRm9WYWc5OGFheXZxSFJHMTlEK012dTRq?=
 =?utf-8?B?OGZyWkNXV3U2MXRGY3FCK1Zxb1l5TXhJemdPaDlyNmhXdEdoVllycEszUEJs?=
 =?utf-8?Q?pEK30yy7S18WUmMxR2mJCjpsH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55adc826-1677-46e4-9fcb-08dbc5cfbfc2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:20:27.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po0b4AhjnGRunLclvCT9aJrH9fJGnSYCk68a15mUjPUOeNm3icxJiTcXRmwXvW9uQuyjXG0925d/XDgPtf4pqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/5/2023 13:14, Bjorn Helgaas wrote:
> On Wed, Oct 04, 2023 at 09:49:59AM -0500, Mario Limonciello wrote:
>> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>> suspend.  This occurs because on some AMD platforms, even though the Root
>> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
>> messages and generate wakeup interrupts from those states when amd-pmc has
>> put the platform in a hardware sleep state.
>>
>> Iain reported this on an AMD Rembrandt platform, but it also affects
>> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
>> generates the PME. To avoid this issue, disable D3 for the root port
>> associated with USB4 controllers at suspend time.
>>
>> Restore D3 support at resume so that it can be used by runtime suspend.
>> The amd-pmc driver doesn't put the platform in a hardware sleep state for
>> runtime suspend, so PMEs work as advertised.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Applied to pci/pm for v6.7, thanks for all your patience!
> 

Thanks!  🎉

Unless you have a strong opposition I plan to also work out a series 
that takes some elements from earlier versions of the series and allows 
SoCs to "opt-in" to using constraints as an alternative for the policy 
decisions.

This wouldn't replace these quirks.  The intent would be that "follow on 
SoCs" that haven't launched and would otherwise need to keep adding to 
this quirk list can instead opt-in via that.  It would make the policy 
more closely follow how the Windows ecosystem works too.

> I tweaked the commit log a bit to make it clearer that it only affects
> USB4 devices and expand on the amd-pmc connection.  I also dropped the
> microsoft.com link because I didn't see anything there that seemed
> directly related to this patch:
> 
>      PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4
>      
>      Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>      suspend.  This occurs because on some AMD platforms, even though the Root
>      Ports advertise PME_Support for D3hot and D3cold, wakeup events from
>      devices on a USB4 controller don't result in wakeup interrupts from the
>      Root Port when amd-pmc has put the platform in a hardware sleep state.
>      
>      If amd-pmc will be involved in the suspend, remove D3hot and D3cold from
>      the PME_Support mask of Root Ports above USB4 controllers so we avoid those
>      states if we need wakeups.
>      
>      Restore D3 support at resume so that it can be used by runtime suspend.
>      
>      This affects both AMD Rembrandt and Phoenix SoCs.
>      
>      "pm_suspend_target_state == PM_SUSPEND_ON" means we're doing runtime
>      suspend, and amd-pmc will not be involved.  In that case PMEs work as
>      advertised in D3hot/D3cold, so we don't need to do anything.
>      
>      Note that amd-pmc is technically optional, and there's no need for this
>      quirk if it's not present, but we assume it's always present because power
>      consumption is so high without it.
>      
>      Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>      Link: https://lore.kernel.org/r/20231004144959.158840-1-mario.limonciello@amd.com
>      Reported-by: Iain Lane <iain@orangesquash.org.uk>
>      Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>      Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Cc: stable@vger.kernel.org
>> ---
>> v21->v22:
>>   * Back to PME to avoid implications for wakeup (Bjorn)
>>   * This is the submission that Bjorn sent in the mailing in response to v21.  It
>>     tests well, so Bjorn please add a Co-Developed-by/Signed-off-by for your
>>     self if you feel it's appropriate.
>> v20-v21:
>>   * Rewrite commit message, lifting most of what Bjorn clipped down to on v20.
>>   * Use pci_d3cold_disable()/pci_d3cold_enable() instead
>>   * Do the quirk on the USB4 controller instead of RP->USB->RP
>> ---
>>   drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index eeec1d6f9023..4b601b1c0830 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -6188,3 +6188,60 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>> +
>> +#ifdef CONFIG_SUSPEND
>> +/*
>> + * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
>> + * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
>> + * Root Ports don't generate wakeup interrupts for USB devices.
>> + *
>> + * When suspending, remove D3hot and D3cold from the PME_Support advertised
>> + * by the Root Port so we don't use those states if we're expecting wakeup
>> + * interrupts.  Restore the advertised PME_Support when resuming.
>> + */
>> +static void amd_rp_pme_suspend(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *rp;
>> +
>> +	/*
>> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
>> +	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
>> +	 *
>> +	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
>> +	 * sleep state, but we assume amd-pmc is always present.
>> +	 */
>> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
>> +		return;
>> +
>> +	rp = pcie_find_root_port(dev);
>> +	if (!rp->pm_cap)
>> +		return;
>> +
>> +	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
>> +				    PCI_PM_CAP_PME_SHIFT);
>> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
>> +}
>> +
>> +static void amd_rp_pme_resume(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *rp;
>> +	u16 pmc;
>> +
>> +	rp = pcie_find_root_port(dev);
>> +	if (!rp->pm_cap)
>> +		return;
>> +
>> +	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
>> +	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
>> +}
>> +/* Rembrandt (yellow_carp) */
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_resume);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_resume);
>> +/* Phoenix (pink_sardine) */
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
>> +#endif /* CONFIG_SUSPEND */
>> -- 
>> 2.34.1
>>

