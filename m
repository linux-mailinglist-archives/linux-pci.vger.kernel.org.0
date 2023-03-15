Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098D6BBDBA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 21:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjCOUBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCOUBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 16:01:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679231E26
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 13:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehRu249R8axOxDcTef9lUSP4bAJNOfvE8qcvGQuUQpcCANJFslFOWruMGWxwwpr1IObPRQH9VuuNUXyAOU/R78L/r2RlKSBdCvR/7Ocfa4mAsbVekuYupHrqSbwHpcbrQR+bWHAtS5dilky0UG/4EVYlH98mLpDWMAytYerXGXefLjIKhD9Iv+OAYxLOeXvpHUcnjHPjNBBFgxMuScLeNv9f/ph/JEKXjg013iSkth44/8rsix2nco9t4afQG8eiEByb84pDtd5AOdx6LwM/tLSCWaSJx/gLtSArO0Q/PDU110mxyAhp4yjT+uPF2xNwueb/AYuN1N0GqdGpPtVncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko5eb/L4LUF2c+z9OmkZV53Hw3kCltDhQLwftrAm1U4=;
 b=RAxJYS8D/cbxLTfIumkSEGBX8yYazqQsm3sxKTjZ4lsY+LGLUxqHJfLyWqV32Cey8e67fQqOD6vd/ren9GcfJlFvpHmzKX1ST0F/+N7TQJVLo+f+6ygjDzJ7I2ZsHppCuaf+4xdh4GTwXZ3H0kFr/oml8VC/Mow17xo3KuyDePOXIvMw5LTw2RAFStwZErAJ7Pkc87NAdewqQ+nAlFgEDBAXbPpUyZEWXLXHXjhDp6RBu2HQ0QKfyyGyCem8uIM2vpT2O47uzMtKZDF27NzNxwBV95nBf9AJ2lObvWday5rO7+zjpggUq1CnY6FWnFbnAZyN+pPoGjTcfE1lEQeoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko5eb/L4LUF2c+z9OmkZV53Hw3kCltDhQLwftrAm1U4=;
 b=pjRnJQ4TGyblzgzX/POg/+OeE0fC7ZZzaHV1lLK4Hw/bw/zQcsBpgVBSn1VTRgkrsgYwSHNw0xQSrClv6/UDznzyTCWi6kKx2SH4caKQK2POZkZ7f+olWbePrtSlWkIK8z6tvrnc+jPW3W8Jfed5pyfwjq2bpB//1mtWNi6DmBgmTwH+fwoNBOP2Uve50QlwycOpX3mRhnYZKTc8ZuYwyLkdV4ucvbUN9f33QM47hJkVdrS++ydI14HnC1K6C917xnXGh8gyuPvqE4uj/oPrcXQsidPlL0FNMQDqvH7HSxTDWwhdL2FGubycXXFX221qZPxz13lAowMnrpqNot0zMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 20:01:32 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 20:01:32 +0000
Message-ID: <e598b84f-2f90-b29a-6209-17309763514f@nvidia.com>
Date:   Wed, 15 Mar 2023 13:01:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <c17f7476-8ed0-212e-9480-78732635ee3f@nvidia.com>
 <20230314161127.GA1648664@bhelgaas>
 <ZBCuPM0WcWaLwWXJ@kbusch-mbp.dhcp.thefacebook.com>
From:   Tushar Dave <tdave@nvidia.com>
In-Reply-To: <ZBCuPM0WcWaLwWXJ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bf2646-d34f-46a6-010e-08db25901262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8sCLjwFdi88AWK06oapmKZG40MnHQo9LqzD6MO7Rd0+OGL61zL5Px/fu0t97xEzHT0wxTveq/z0eh/rxw+dQgckoaVT30q3Q8syMU8SlZV3LFJFggePCqBcZY+EvSRhBcCXuulR+xqYboU/ii48WkzChRyl3CIm/S2dezSA3dCGm3vkgN/1HCuEOxYmA1j75lJepl6Z7fcyzprc59wLa/OgvGvW0IELe7pI/VsqtiRWdwHRfTYe3/6ipYvcPm7BWZA+qiB7xcl0C+hgDFvqc9eWJgW5LFyeqhYI/hT13VplMa/+MN83VLZ7ZjmjeldFbadHqqpQWENj8uyHTj7NDVxdje5vSxi7RjDb6xpixaSSaZur/LtNcCqzpiS+F35XR/E1MCzKuHjXbtA8JgTHF2EvjT/9O1ktYWwIYICWP7p5s3U3uQbeYQSSYrjSGOCzEqm6iJTeBMlSIUleYzpxTqI1KgzdnVeS7vIHXB3Pxvb1t3tM3gdBS0sTgGVWq4ncT7QPEHzVKDjSEYMWDI+iLVv/J+McC8iSAsl0pln82PLHqHMDQyEs08X7BwPVc3mQh0qzn63AoT8m1WkomoW8Z/jhFr6tw6U5+fY6p4QNdZrgGKsT7AOVT6axw5/KS65zbNEPPBGUNXK6Gku6oMDBXcPo1cd8b74ozd6N+mryQMxv5dLj7pZxrRxHs1rnNy4WXaBvBJZpqmVXYtrw40sHqz+2pAAZyaPUZHV0aEAYRnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199018)(66899018)(31686004)(41300700001)(8936002)(5660300002)(2906002)(31696002)(86362001)(36756003)(38100700002)(478600001)(6486002)(8676002)(66476007)(66556008)(4326008)(66946007)(83380400001)(54906003)(316002)(110136005)(6512007)(6506007)(26005)(186003)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU13akwyalV3enhxUmJKU2NtMmhGWlJFbGRPS1c5TTYwcmJzTDM1MGZOYkpU?=
 =?utf-8?B?YTBDRWZieklJMTA2ZHZ0SmlQS21NTWFYY0ZYbXVvbkpKR1BlSlAwRUw1UlBy?=
 =?utf-8?B?WXU5dkZGNng1MFZaQy9HL1NaNjVBV1lzMEhCbzdUQnEwcDliU1pWRTk0ZUx0?=
 =?utf-8?B?UFFtN0ZDSXFLbWl4OGJNTnhKM1lZTkpTTVBOMVBRZUptc3lVSkY0VlRkVGtW?=
 =?utf-8?B?dlR2bEdmYVZhYzdOOGhtcTd4ME00aDBjcW9xRVFyZS9nRDNWbUsrSXNtTkxX?=
 =?utf-8?B?eEVidEx0T0c0cy9kTmxZcFo5NjZHeHVYb0hUMUphaFdtNnN0NzhIeFptM2cw?=
 =?utf-8?B?ZTJTR2NTd3FiSHo0OHIreFJUZWx0QUo3ekx6bnc2RE5OUUZFcUxHajNuN281?=
 =?utf-8?B?aVVFNCtaenkrclIxT3h0NnpMQWZBYkZHNkNJZ1k5T1VlNnZIeWFjc0pIa0ls?=
 =?utf-8?B?R3NPRmE3UGZjTC80VG5HUVdnK1BEaFp3TTJublc5WFYzYlBQNnR1cE9aNFZ3?=
 =?utf-8?B?a2tTZVJhYXpKbnM3RVJ2M3B2SVM0dnB3dDBJb0gxVHJhYUtYZStNUnFJcjBV?=
 =?utf-8?B?QU04N09RSGx2cVlEYWxoTml4K2FJVElNWllFRVNQVnBWWW9ya2dneHpmZmda?=
 =?utf-8?B?YVZDYWd3MEFyYlpuOFYyY1ExRHdPUm10YmhkNEJDbmFlcU94WHhmL2p1TU5U?=
 =?utf-8?B?bktHaC95aC9DLzNwR1FrVG5TMnVSb2hqbDdJOVZCTXhMM3I2SVZQSElJa005?=
 =?utf-8?B?KzFOdGNkaEhMbk8vUnJzSU1kSDNzVFBHWHV1QTNvSDJIQjZMTlRaYmRjUmlr?=
 =?utf-8?B?Q1BEZzQvV2t4dUtqQmVyWm5RTHJrMG55MmtJMlA3cDNmVWN0K0JRRVBhMzR3?=
 =?utf-8?B?SlZHM3gwUnl6NjJsZEdZN0FFQld0Tk1TVnMwa3hRNUZCQ2FEcFB2RTJwUHVN?=
 =?utf-8?B?dmd6aEZjelpUQ3FWNFIyL2lhczhQRW1xekg5UkRpdFdqU1EyajBKWkJXQzN3?=
 =?utf-8?B?TllxbzRieTJBSlErK1hFS3E1bUVGSGl2RDBPODJFU1RRM0dpSlhGcnY4YkdL?=
 =?utf-8?B?ZTNRbmlMN3R2bmRoTnp2cGs2Y2ZHTEpQamxzRmxmUHFqUEI2QXkvQkdTUVVr?=
 =?utf-8?B?WWt3RVEvQllJY1hTcDdzZWlQY1NOeDZHVUh1L0JvMld5NGFWZWt4WUFBVjNF?=
 =?utf-8?B?RWl4UkVNMmdpbm5hTmdueEZpWTVyeFlMME43UnJ6VXR4SjN6bkN6VWJ4WmRy?=
 =?utf-8?B?azNYTEtHeUdWcHNvTFNYUTg3SnFNOThCOGQ3WEN3bVhSOFRTTHN6c3FWanl2?=
 =?utf-8?B?bDJLYzhkSWJGaUh1Z2ltSVovZ1pPM3g1bjlxSENXZ2VscUxZS0I5UzFJbTky?=
 =?utf-8?B?ZzhUSEMxSGJRRmVSejgyOG1hY3FueG1tcjkxekk5ZlR6ZUV0VkhHdlEwaVVr?=
 =?utf-8?B?QVlVVU9WaUVkNW1sb1E1Vk9zNnVreUZUZHVpdjRsZHpieW9BczZZQXJZekdr?=
 =?utf-8?B?Tkg2a2tKa0pGZkFtOGN0VFV0M3Vub1pTMmRMeE5PSzRBMHJod2dXREw4T3Bt?=
 =?utf-8?B?ZGhzOHV0VHFzaERVV01DOUpLY2sxaHJWMDdGWVo0dXJ3ZWxPZWkraVpxOEhk?=
 =?utf-8?B?N09MdW9BaUEzLytFZzFQSys5VmhaeW01MUhBV0FRakRpRGVlM1ZYM0ZGTlhy?=
 =?utf-8?B?N05PVEVMUitBcVpQWjNjcmc4UDBWWm5jc1E1S0FBckNzZVgzUE95THlDTWlt?=
 =?utf-8?B?S01qUlpqVk84ZzhmTjc1dUh6UlVvQmxDaDJyeExtRlBEc1J5T21BdkY0MVFp?=
 =?utf-8?B?OTJsYmh6WVlKUlhXU2h4RHRIdm1vVVRoWmpQOGdzNmJyZWpBZGo3akRwR1ZZ?=
 =?utf-8?B?TGh3cm1sSjdJTVVZb2xmOFhwZm9GZ29VNVNjTzBJK0I5aExJakExbWhGMExj?=
 =?utf-8?B?SmF1M1VhTm56bWI2NlVmdkU3UXpvekNxMHpyR1d4WFNhUG1hZHdtcVlCR2Ns?=
 =?utf-8?B?cDZxdVJObkV4cUw4UzdMQjQzUE5QYTZoZ2w1RFlzdlp6dkxKaXlCMk84MWdm?=
 =?utf-8?B?UmFSTUlRYnFGZlBmV3B5ejJNcFRLTjdVdjcvTnMxWkFrNHQyRUJtRndTN3pB?=
 =?utf-8?Q?G6YVUWP2pW6sP7Ss8LeMOLrYj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bf2646-d34f-46a6-010e-08db25901262
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 20:01:31.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WeXPsAIN9prrXc6Hcb8/OwwNDOYF1JvKAESUXbvmz3D/kwBXgpPvOOfcUAdCmv50gidaUvbIjBV1StyhA9URg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/14/23 10:26, Keith Busch wrote:
> On Tue, Mar 14, 2023 at 11:11:27AM -0500, Bjorn Helgaas wrote:
>> On Mon, Mar 13, 2023 at 05:57:43PM -0700, Tushar Dave wrote:
>>> On 3/11/23 00:22, Lukas Wunner wrote:
>>>> On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
>>>>> On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
>>>>>> In the log below, pciehp obviously is enabled; should I infer that in
>>>>>> the log above, it is not?
>>>>>
>>>>> pciehp is enabled all the time. In the log above and below.
>>>>> I do not have answer yet why pciehp shows-up only in some tests (due to DPC
>>>>> link down/up) and not in others like you noticed in both the logs.
>>>>
>>>> Maybe some of the switch Downstream Ports are hotplug-capable and
>>>> some are not?  (Check the Slot Implemented bit in the PCI Express
>>>> Capabilities Register as well as the Hot-Plug Capable bit in the
>>>> Slot Capabilities Register.)
>>>> ...
>>
>>>>>> Generally we've avoided handling a device reset as a
>>>>>> remove/add event because upper layers can't deal well with
>>>>>> that.  But in the log below it looks like pciehp *did* treat
>>>>>> the DPC containment as a remove/add, which of course involves
>>>>>> configuring the "new" device and its MPS settings.
>>>>>
>>>>> yes and that puzzled me why? especially when"Link Down/Up
>>>>> ignored (recovered by DPC)". Do we still have race somewhere, I
>>>>> am not sure.
>>>>
>>>> You're seeing the expected behavior.  pciehp ignores DLLSC events
>>>> caused by DPC, but then double-checks that DPC recovery succeeded.
>>>> If it didn't, it would be a bug not to bring down the slot.  So
>>>> pciehp does exactly that.  See this code snippet in
>>>> pciehp_ignore_dpc_link_change():
>>>>
>>>> 	/*
>>>> 	 * If the link is unexpectedly down after successful recovery,
>>>> 	 * the corresponding link change may have been ignored above.
>>>> 	 * Synthesize it to ensure that it is acted on.
>>>> 	 */
>>>> 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>>>> 	if (!pciehp_check_link_active(ctrl))
>>>> 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>>> 	up_read(&ctrl->reset_lock);
>>>>
>>>> So on hotplug-capable ports, pciehp is able to mop up the mess
>>>> created by fiddling with the MPS settings behind the kernel's
>>>> back.
>>>
>>> That's the thing, even on hotplug-capable slot I do not see pciehp
>>> _all_ the time. Sometime pciehp get involve and takes care of things
>>> (like I mentioned in the previous thread) and other times no pciehp
>>> engagement at all!
>>
>> Possibly a timing issue, so I'll be interested to see if 53b54ad074de
>> ("PCI/DPC: Await readiness of secondary bus after reset") makes any
>> difference.  Lukas didn't mention that, so maybe it's a red herring,
>> but I'm still curious since it explicitly mentions the DPC reset case
>> that you're exercising here.

Commit 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset") 
didn't help.

[ 6265.268757] pcieport 0000:a5:01.0: EDR: EDR event received
[ 6265.276034] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
[ 6265.283780] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 
source:0x0000
[ 6265.292972] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
[ 6265.301284] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected 
(Fatal), type=Transaction Layer, (Receiver ID)
[ 6265.313569] pcieport 0000:a9:10.0:   device [1000:c030] error 
status/mask=00040000/00180000
[ 6265.323208] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
[ 6265.331084] pcieport 0000:a9:10.0: AER:   TLP Header: 6000007a ab0000ff 
00000001 629d4318
[ 6265.340536] pcieport 0000:a9:10.0: AER: broadcast error_detected message
[ 6265.348320] nvme nvme1: frozen state error detected, reset controller
[ 6265.419633] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after 
activation
[ 6265.627639] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
[ 6265.635289] nvme nvme1: restart after slot reset
[ 6265.641016] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 
0x100, writing 0x1ff)
[ 6265.651248] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 
0x0, writing 0xe0600000)
[ 6265.661739] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 
0x4, writing 0xe0710004)
[ 6265.672210] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, 
writing 0x8)
[ 6265.681897] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 
0x100000, writing 0x100546)
[ 6265.692616] pcieport 0000:a9:10.0: AER: broadcast resume message
[ 6265.716299] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 
0xa824144d)
[ 6265.725614] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading 
0x100546)
[ 6265.734657] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading 
0x1080200)
[ 6265.743824] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
[ 6265.752348] nvme 0000:ab:00.0: saving config space at offset 0x10 (reading 
0xe0710004)
[ 6265.761647] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
[ 6265.770247] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
[ 6265.778857] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
[ 6265.787450] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
[ 6265.796034] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
[ 6265.804620] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
[ 6265.813201] nvme 0000:ab:00.0: saving config space at offset 0x2c (reading 
0xa80a144d)
[ 6265.822473] nvme 0000:ab:00.0: saving config space at offset 0x30 (reading 
0xe0600000)
[ 6265.831816] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
[ 6265.840482] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
[ 6265.849037] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
[ 6275.037534] block nvme1n1: no usable path - requeuing I/O
[ 6326.920009] nvme nvme1: I/O 22 QID 0 timeout, disable controller
[ 6326.988701] nvme nvme1: Identify Controller failed (-4)
[ 6326.995253] nvme nvme1: Disabling device after reset failure: -5
[ 6327.032308] pcieport 0000:a9:10.0: AER: device recovery successful
[ 6327.039781] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
[ 6327.047687] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
[ 6327.083131] pcieport 0000:a5:01.0: EDR: EDR event received
[ 6327.090173] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
[ 6327.097816] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 
source:0x0000
[ 6327.107009] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
[ 6327.115330] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected 
(Fatal), type=Transaction Layer, (Receiver ID)
[ 6327.127640] pcieport 0000:a9:10.0:   device [1000:c030] error 
status/mask=00040000/00180000
[ 6327.137319] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
[ 6327.145236] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 
00000001 5ad65000
[ 6327.154728] pcieport 0000:a9:10.0: AER: broadcast error_detected message
[ 6327.162624] nvme nvme1: frozen state error detected, reset controller
[ 6327.183979] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after 
activation
[ 6327.387969] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
[ 6327.395596] nvme nvme1: restart after slot reset
[ 6327.401313] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 
0x100, writing 0x1ff)
[ 6327.411517] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 
0x0, writing 0xe0600000)
[ 6327.422045] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 
0x4, writing 0xe0710004)
[ 6327.432523] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, 
writing 0x8)
[ 6327.442212] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 
0x100000, writing 0x100546)
[ 6327.452933] pcieport 0000:a9:10.0: AER: broadcast resume message
[ 6327.460184] pcieport 0000:a9:10.0: AER: device recovery successful
[ 6327.467533] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
[ 6327.475367] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80

> 
> Catching the PDC event may be timing related. pciehp ignores the link events
> during a DPC event, but it always reacts to PDC since it's indistinguishable
> from a DPC occuring in response to a surprise removal, and these slots probably
> don't have out-of-band presence detection.

yeah, In-Band PD Disable bit in Slot Control register of PCIe Downstream Switch 
port is set to '0' , no idea about out-of-band presence detection!
