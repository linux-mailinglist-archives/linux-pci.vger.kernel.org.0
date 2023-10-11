Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063327C5EB8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjJKUv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjJKUv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 16:51:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E4B93;
        Wed, 11 Oct 2023 13:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGm5EsoIda8/yCySyJ+qy+EWUIKGa0VcFYKkNZ0orcshBXgPYdvMO3y8o2L9PtsdUvCZMgySQN8hvxbsn3+V7gRi5ilP54r+GQJTMKKjIM2FXo7XWmci5bKfmfbmT7YMvqeGTFwB4Dkvbzijca37tBrFcg/aCVbFTfUk/Z6EssF73wL2HVzjSln0yER1D62NdUw/p6DmcLiMtsBA7ekFLUhn3HJSbOzuwxTnXVFjrE8YkvhNovklEvg4LNspeCnxkz9Lqkqv8ZrEUoH3DbM4Ose5L2ZTXGp8yemmCJypAHGGt5gQts9r6GPp4iIq4EGat0BoTNOe5oyKIclED4DIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytiJJg11YjqLRqMEb5V5MR+9QTrVIPjOKW8DjfmymA8=;
 b=FVnpVvvCMlia7M8ckXUAbebluNgNCfPW5KDUmsvQbc46lUucmQ26540y66LYR0NJ6sOah7vjdRrigW4/G1CbMRiQjq7hjmZ4O2HYfnlEUdUuoEXQpJ8QpMFgdTgSf5YuihxOJGATgTKMamy330NmFh4U6Mqx3Rf294WqqjX+mdNqB5smJtjE3h7/7SGEQbHnqp6QfKY+qVz8ZI7Z//mSLkLqjnu+qpTGgC8HmIXNeOS3wHKzIK41Mxp/AYHCpmRD7M2D7ISv4moVmBubdiCz3gC1h9VICLjx0YROg8p5IUbPkpp5lAz3xZSLig1nJuMhUqEZt1YVu/Nm4IxI8H65TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytiJJg11YjqLRqMEb5V5MR+9QTrVIPjOKW8DjfmymA8=;
 b=sgErhysu9GqMBTUfdZSt+i+eWH3YLy17zyNP8pthGUneDKeZSTHyI8frvac7j1CAUGDUplZ8WZ0dMBFfYYZEXPRFogoFfTXaQvcBfiXeqsFNr/T1kewu9kO4N4eTo15vMJvDr5ObaDgtlaLnGCmshd+VkDGfJXxkbGEv52IhfIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 20:51:48 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33%5]) with mapi id 15.20.6838.028; Wed, 11 Oct 2023
 20:51:48 +0000
Message-ID: <e44b7361-41cb-62fa-bbcf-45e63844ede1@amd.com>
Date:   Wed, 11 Oct 2023 13:51:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] PCI/DPC: Ignore Surprise Down error on hot removal
Content-Language: en-US
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20231011204554.120574-1-Smita.KoralahalliChannabasappa@amd.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20231011204554.120574-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::21) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 519b41d6-d2d0-4b8b-dc9f-08dbca9be32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5vauevA2jOv1lLWZ1bl5Ij5mfWxpYn8eO58WDvDL/g2Y+XNw7zvK7N36ZEutH9PlnUqDBsyYCU/YVOEjeWf/3oUyS08b//8SHEcmDplipSo76WHjUIdmtD5RdGmwIUdNW/mLTBrvDydSMUJ2gY5ODTUd5J/UUAzlvtniNDh5l73HP8FEcgISMOA+e1aVNPk5sdoVRhJ+dgKQxj+eONXrWwdte9GycVX1H0627PAeslCBBu+GYcq23nvMh9XCXw/1FRttJJA21o0sgUOL8NhHNNifM0DW6R/ge+xCuXPaf9B2AyrRHZ5EQCxSREitLC4uK0OfGFSgPRrle8Zeu2RFr6cH/ZXuPqTtnHbOUUuhM/Xo2aiCiip6hFwS/36RIXxBqGvwuFLjbqX5/KX/+ZHOr2l7IScYgd5dlUOwlVacIM/2GWEpjf2IpEYnG91yzeqBj3WVYq1CSAPN8YtG7fRRRpRcgrN5eHew9zD9zmF2/6382LwFyhFbJujTK6eeF02XPnYGAc5ZNZpcenWMF5qCGHTjY1qiWL61bww+JL4yLPHqK8uV5QsUQg+NuDWkHXaNeqi076cKjO69KvUnBNTVJy34jKsPOfefcOxo59ZJZgJSBnZU9hQUwGoU2wzYZdWP8ru53eZRxifchvRsDNTIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6512007)(26005)(6506007)(53546011)(83380400001)(2616005)(31686004)(6666004)(6486002)(966005)(478600001)(36756003)(8936002)(41300700001)(5660300002)(38100700002)(4326008)(31696002)(2906002)(86362001)(8676002)(66476007)(54906003)(66556008)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRKUlJZNFlUZ084N3VoVjJIRGdESS96UTNBRjRCTkl6ZjJwelJZWXNwZXI5?=
 =?utf-8?B?TG84K0UxdC9VVGVFSzdJaHRuSjN6TGxDWkgxQmZnWHlkY2E1dXgrTjNXb1hN?=
 =?utf-8?B?cTZXVG1MeXNNMEFYY2s0aDlrekRxU014NXluWUl6NCtURHZ2M0RYd3BNdlNX?=
 =?utf-8?B?YTBPSUhiWXNjWFNzU0xZVXN0SmpOVWJ2VEJZOGVQWkNLM0FJQWFtN3ROc0VP?=
 =?utf-8?B?a1VmVUV4SklENVVzS281UVU1NVNMeWt4bkhpdjlrZ3hvRHBPVk1BNEtLWlZV?=
 =?utf-8?B?UWovRzlFNkdma0NCZUtveGlrWG5BNkVUclpZQXgvamV4M3FtVzgyamFJckhI?=
 =?utf-8?B?dTA4a1JHU0xvY3I0RUIxZUt6VjZkelNZY2FheDVBM3BFS1o5TmdqbUhFWkgy?=
 =?utf-8?B?SW54Uy9TUFk0M21vYnkrK2tLNWZ1c0FUMkF3L2NtQlhRZzRTR1FTY1VTOXBL?=
 =?utf-8?B?UVRueEtuOTBJVDhLQjNZMUxzdGJCTmU4MUdVKzRWUm9tdk1PVjlHMmlRZVI4?=
 =?utf-8?B?cTQ1djgvY044eERUVDdLdVUyNnVVZkh3WE5BbmJFNnhRZ0JMSjRwbk03V09P?=
 =?utf-8?B?MURpUGkvTW0rajhWMGNPNU5aV0NnRVo3Vm8wN3doeW9IdkZnSHR4WjRsNXhC?=
 =?utf-8?B?ajBHN0x6YjcrRTkxbEN0a0pvWFRuSVgxMmFGSyszb1BadnlIUVdMTDdzdkZv?=
 =?utf-8?B?bjN5NkJCbkxnWFdiVHBqU2pLZ0xoL0xVRkRUNkc1eC8vWXYzTHgvalBSdU9C?=
 =?utf-8?B?TVY5VzdidWZOdFNVV2dZdTFSQVNaSW90OFBaaTYzejNxL0dWMkRCSmFTUUpG?=
 =?utf-8?B?OG5ZZ1gxMUh1MzFpQUx5SmNjTVFXanVlbXFyYkdyNHRVT1J0cThSQkxqaWlU?=
 =?utf-8?B?MDgxSStyazVPSTJvYXRHa0tmY0c0Tld3YXJuUU9yNzRCSEVwbitOVEdpMzEr?=
 =?utf-8?B?QUZ1LzNySHQ3NTFFcStwNlYzK2NxcEtLUTIyOGdvSDJjcjN3eG1kN3dIS3Bz?=
 =?utf-8?B?bzhFNEpSZkVqYyswcW8ySk1HaDRmRTlFd1cwWFZVV09QdkxHUUw4Mk5oSHFt?=
 =?utf-8?B?a00yY3ZrMXdCbjVWVTQ0VHJJR1poSFdDaFQvMW9mbG11QWppTCt3TlhCV3I1?=
 =?utf-8?B?Y0p6dmNNazBvZXlldXdtSzA1K1A0U05uSEtFUlhIZDREZjRzTnFhRjRwK0F4?=
 =?utf-8?B?YmhBKzNieGZDa2o5aHErQXB4Z1R5a1Z3QnZBeWk1eGZ0aERUci81cEJGMnc1?=
 =?utf-8?B?LytKQzk3Nm8zSTZwajlGdkxxcHpPVFZOTndmams0ODcyL0RNVXVtTzVBd0ZP?=
 =?utf-8?B?NlFQbllId0toLzdjcFZTaUpIMzJQQk5iaFM3Yk9waUtHak04N2ptTnBGblZT?=
 =?utf-8?B?SzVCOWJRVXZMV1ltMmc0cFY4YlZjM0dlOWhkRU1pYXk1UGpLeS81NTZ5R2FE?=
 =?utf-8?B?ZU8zOUdPU3ZyRVoyTThTSmVyTmxIcUVnNkJYOUtZaHRER1hFNjdrb0xKWGd2?=
 =?utf-8?B?VDBiU1lwZDFCNzdUV3FESENqSTNucWNyQklhOG1HbVFlZXRId2oyK3JUd1NQ?=
 =?utf-8?B?Y1MyZU1BV0l4Q1QvSm95ZEs4aWdKM25mWmxJbGsyUEczMDFENkxRT3FiV1hZ?=
 =?utf-8?B?clhRZVMvUEh0NmdKRXJhd3RvMzhZRm9TMkEwRERSVlhaNHF6NHUzVlV3N0Vo?=
 =?utf-8?B?eEU1cGVPajBZTTE0VVhyTW5tWXYxMXcwb3ZHbUdWTDAvMS8rRFp0OWIzeFFv?=
 =?utf-8?B?NC9pa3J1OWN1NDREeW5tME5QTFFwQ2d5ZTFlL2F4c3dORjRRcUpTMjh0Nkpj?=
 =?utf-8?B?Tm1qdHBPV1JQYk5iU2pKVXNQditpNjJBc3J2YkExWi9IeW0rcXFJYnhMVjVP?=
 =?utf-8?B?c2gybHVDaG43WnFydUtkRStYL3YvbUwxUXdMZUl2a2RaUjF6SUJvVUREUGt4?=
 =?utf-8?B?dkE3b29MQ2RwY0FnTC9WdHhxWlpqZ2JVU0dmWnlQQThLNk1NTVVwUk5CZS81?=
 =?utf-8?B?MzlDT3pSVUZTNGRYR1VLMWZ3cVhkeTlCc3dndVE2dEdhd1hmSE9aSFIyMTJu?=
 =?utf-8?B?c3cwV3cyQTZGSjE4aEVFc09DQXVldDh3NDBEeEx5UHVmNGJBWllDWkdDVzIx?=
 =?utf-8?Q?yd7Ep3d3aozP6VlLp2YcQ1hh5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519b41d6-d2d0-4b8b-dc9f-08dbca9be32d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:51:48.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXIKdTrQ/0qErjoZv1ZvUgcCMFcLhz2dEUFPAiDkH6/xlB2ZMdVRWY0BBzTNTRuxTbOMq+y2p+BeTg76pZGK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No code changes, rebased on latest tree to seek Bjorn's attention with 
$SUBJECT change and "Reviewed-by" tag.

Meanwhile I will continue working on 10-bit tag enumeration.

Thanks,
Smita

On 10/11/2023 1:45 PM, Smita Koralahalli wrote:
> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
> surprise down error. This error is expected and is just a side-effect of
> async remove.
> 
> Ignore surprise down error generated as a side-effect of async remove.
> Typically, this error is benign as the pciehp handler invoked by PDC
> or/and DLLSC alongside DPC, de-enumerates and brings down the device
> appropriately. But the error messages might confuse users. Get rid of
> these irritating log messages with a 1s delay while pciehp waits for
> dpc recovery.
> 
> The implementation is as follows: On an async remove a DPC is triggered
> along with a Presence Detect State change and/or DLL State Change.
> Determine it's an async remove by checking for DPC Trigger Status in DPC
> Status Register and Surprise Down Error Status in AER Uncorrected Error
> Status to be non-zero. If true, treat the DPC event as a side-effect of
> async remove, clear the error status registers and continue with hot-plug
> tear down routines. If not, follow the existing routine to handle AER and
> DPC errors.
> 
> Please note that, masking Surprise Down Errors was explored as an
> alternative approach, but left due to the odd behavior that masking only
> avoids the interrupt, but still records an error per PCIe r6.0.1 Section
> 6.2.3.2.2. That stale error is going to be reported the next time some
> error other than Surprise Down is handled.
> 
> Dmesg before:
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
> Dmesg after:
> 
>   pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>   nvme1n1: detected capacity change from 1953525168 to 0
>   pci 0000:04:00.0: Removing from iommu group 37
> 
> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>      https://members.pcisig.com/wg/PCI-SIG/document/16609
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> v2:
> 	Indentation is taken care. (Bjorn)
> 	Unrelevant dmesg logs are removed. (Bjorn)
> 	Rephrased commit message, to be clear on native vs FW-First
> 	handling. (Bjorn and Sathyanarayanan)
> 	Prefix changed from pciehp_ to dpc_. (Lukas)
> 	Clearing ARI and AtomicOp Requester are performed as a part of
> 	(de-)enumeration in pciehp_unconfigure_device(). (Lukas)
> 	Changed to clearing all optional capabilities in DEVCTL2.
> 	OS-First -> native. (Sathyanarayanan)
> 
> v3:
> 	Added error message when root port become inactive.
> 	Modified commit description to add more details.
> 	Rearranged code comments and function calls with no functional
> 	change.
> 	Additional check for is_hotplug_bridge.
> 	dpc_completed_waitqueue to wakeup pciehp handler.
> 	Cleared only Fatal error detected in DEVSTA.
> 
> v4:
> 	Made read+write conditional on "if (pdev->dpc_rp_extensions)"
> 	for DPC_RP_PIO_STATUS.
> 	Wrapped to 80 chars.
> 	Code comment for clearing PCI_STATUS and PCI_EXP_DEVSTA.
> 	Added pcie_wait_for_link() check.
> 	Removed error message for root port inactive as the message
> 	already existed.
> 	Check for is_hotplug_bridge before registers read.
> 	Section 6.7.6 of the PCIe Base Spec 6.0 -> PCIe r6.0 sec 6.7.6.
> 	Made code comment more meaningful.
> 
> v5:
> 	$SUBJECT correction.
> 	Added "Reviewed-by" tag.
> 	No code changes. Re-spin on latest base to get Bjorn's
> 	attention.
> ---
>   drivers/pci/pcie/dpc.c | 69 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 3ceed8e3de41..25e9ddeeb271 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -292,10 +292,79 @@ void dpc_process_error(struct pci_dev *pdev)
>   	}
>   }
>   
> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +	u16 reg16;
> +	u32 reg32;
> +
> +	if (pdev->dpc_rp_extensions) {
> +		pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
> +				      &reg32);
> +		pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
> +				       reg32);
> +	}
> +
> +	/*
> +	 * In practice, Surprise Down errors have been observed to also set
> +	 * error bits in the Status Register as well as the Fatal Error
> +	 * Detected bit in the Device Status Register.
> +	 */
> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
> +
> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
> +}
> +
> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> +{
> +	if (!pcie_wait_for_link(pdev, false)) {
> +		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
> +		goto out;
> +	}
> +
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> +		goto out;
> +
> +	pci_aer_raw_clear_status(pdev);
> +	pci_clear_surpdn_errors(pdev);
> +
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> +
> +out:
> +	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +	wake_up_all(&dpc_completed_waitqueue);
> +}
> +
> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	if (!pdev->is_hotplug_bridge)
> +		return false;
> +
> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +			     &status);
> +
> +	if (!(status & PCI_ERR_UNC_SURPDN))
> +		return false;
> +
> +	return true;
> +}
> +
>   static irqreturn_t dpc_handler(int irq, void *context)
>   {
>   	struct pci_dev *pdev = context;
>   
> +	/*
> +	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
> +	 * of async removal and should be ignored by software.
> +	 */
> +	if (dpc_is_surprise_removal(pdev)) {
> +		dpc_handle_surprise_removal(pdev);
> +		return IRQ_HANDLED;
> +	}
> +
>   	dpc_process_error(pdev);
>   
>   	/* We configure DPC so it only triggers on ERR_FATAL */

