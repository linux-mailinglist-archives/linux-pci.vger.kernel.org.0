Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62E69A528
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 06:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBQFhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 00:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBQFhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 00:37:20 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517F5BDA4;
        Thu, 16 Feb 2023 21:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhSvHDB18AyJan+lOw0i7sJN4JsY3ZYLWe+rVkqw48388ijzAH6aMs50bPS42VpBmuZ5Fv845oO+ZrdMlAc8EodfAk7UiHgSeZjr8T3lhqbVCbI8pkcL36f+abmYOzsp964HXecWhefBavvHZUqsEEgjbxJ/gYxZ4q9xWCPfQiFgfEdjufAWlxRANkuVFxtCRs1zOis6nHilUsM3INZ+DnkDA65xjnhPxwVuiVAQmsoVXsCLWICc93WfCMqdWNish5hKu4fg5aSxY6OmW9X67oTPWcZiTu11oeTExcUMxDVbjAkevV1Od+e+qwVjDsobaS+7TBa7QCTZdAokyB4wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmIPqo0gRPOQzLVCO4/3NFKHW5/Gj8HOH2VVA1OE9Xk=;
 b=k9k55ICaOChigy3VRdqs7EOzrnAn+cgFukiv0lHOUl1ABCgimlIKY05rnpaxIaUYkSPPEG2PmC1YUU5oL2HXGn8WMIFgXBUMVI81GnDI+c057M6P8ZV/SJFgtcmbPaV1TyBi3qQczN14zZAmsiYn57ynUIRC4rlaVHQ4KFJTw3aBvPiLEzpet66Qnzxwq8H34mQDB01RYH2DgmdcZA/Y7Ied+dHoB3puuWB/AJPdSM4w+thnfJYfD+V9V15G6WtXuE/QNoVLOfUQzNsVcNB0nWQfASdcUFsQWY8WDN6lb//838Qs2mYHvJT9h7hhiXCO5cHF1+Z3YKTCb2P2fIPUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmIPqo0gRPOQzLVCO4/3NFKHW5/Gj8HOH2VVA1OE9Xk=;
 b=hjsFT8vjtcpbXhyHhL1OxXDlr9+Xl0TmxFJgf7mJWbe0xYYR6GnqTW9SK6k+TdrpAv8juOIRRRBE/wEapLMwHWnQGUt4OfCjez7VSH4veGV+2/gW05mjW+ocrJm85pna5B5HP8YtCyzdnYmdY4QN8avxTaMXJ5ypWFazAlWL3LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Fri, 17 Feb 2023 05:37:12 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 05:37:12 +0000
Message-ID: <e0c1e50d-ee6c-290a-b0bc-24fc81dde90f@amd.com>
Date:   Fri, 17 Feb 2023 11:06:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
 <51861ff2-380f-640d-d5e8-7efe979a97ea@amd.com>
 <40b2da4a-a205-3cf2-0c78-c94c28b2d3f4@bell.net>
 <9e35ba5a-bc09-30c0-462b-6b83d5edc070@amd.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <9e35ba5a-bc09-30c0-462b-6b83d5edc070@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: af58aec0-e893-4746-d580-08db10a90515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sf59kuIpOCAAGGoGycwmIDOH5++npbPQsR7DfOtJtoSIGoqUmx/Kl7jsA0lQUNCqMh6cmE9Kfch4nlw9kq7O3xgjXvcDVcZ3OgGc/6mVIuAt+YLB6o+1XuIinAfWtbmZIqhnuUZ3Dtiz1LoRLQJ4w6IYV5EKpoVoWc9+SIkWw0FOJ4XImwNc3LEqzpt0FduCdur5f7QVyndG+0ZWQaBTcB6FR4Ty76ERsItXKTOLRfAk1KOqz0YR8XIXU+jHXxEbL5xqb9M5SytXWQQ+LHzweS72uogJjfYycZmxS78z+OibTF667hW17iUaw33qe/Zrh3piHmj/1WPLydtWvxUgsgyrR8G7eZOnfPEECVNqIIKU/StaVMtz5ExrykPCTSoSwGF8DSzj4jYbaIjS4Ad3GMG8wa9g9h2l/R9KndY6NqOPPOP8pcO/lWoI6KVehh2o1dlRlXImX6f1TeaJFezj6IWYm9/MxiwrJ5I/W1O1SNrdKcQWtmgyVDbjE/7WSgcfTvpxQ3+KFSxhvw0X4AVPp3wdlhBdKm7YreAx2l2K3AXn0N1JJOm6Qw8E6ECJKmAOpWYmoDfRbSPeBnFrL+BzILKHXLMbBUk9imkbGKgUQK9/svD+dLTBzzOiy6EHlhcBwFucRP3D9A1JCr6/EijgLix4Ht43+28SpjAUNZacVxu2HdOKNXeD1YBJcu5vD35Udb+NeLUpdNW44PA8sw8v2ENVpaJcNc50GnRsnBj4cNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199018)(41300700001)(31686004)(110136005)(54906003)(316002)(66946007)(66476007)(4326008)(8936002)(5660300002)(7416002)(44832011)(2906002)(66556008)(6486002)(478600001)(6512007)(186003)(2616005)(53546011)(26005)(36756003)(6506007)(6666004)(83380400001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ZEQ2l5U0paVFh4QVZ2YjJ6ZTBzWVhwVlIxSGZoQXpJRGU3eXZwVzc2bXAw?=
 =?utf-8?B?S3ZuMDNIWmJnMXkwRk9CRldwYnlFRHI3WU9Eam5xaHNvME55ZG9xTjNEV2I4?=
 =?utf-8?B?ZDJhNXNqUFBYbHphSlEzT1hEbDFEbFM4b2l4SUVtSmdsbVFvQm9STGNERkdo?=
 =?utf-8?B?Qm9FeVphWXRURjlYZ25PeGY0cHo1UHNkSUZWamEyV3Q1RnN5MGxoMzBDd1dP?=
 =?utf-8?B?aHlVTXB2YTR0SGdsRGNna1VsRW5uZ0lNaG45VUl4cDNaSDFlMFllNTY0UUY1?=
 =?utf-8?B?TFpHYVJxUjcrK25sZXNJc1BOWXhoRlJQZlVqZGVOZ1VqcFJpWEtnTUpNdmgr?=
 =?utf-8?B?ak9kQnRFeU5CZ1ZlMjNRdTl6MFlReHZTMnhURU8yaVV1bThaMk0wVkFIQ2hu?=
 =?utf-8?B?VjdLTUdFZnFFRUFCOXlYOGthbVBTMURCaURha3lOazZiQWhxNEg5YkdtMmxm?=
 =?utf-8?B?VlB1a0dSNUpQdUxSUUh3a1Y4eThzUi9nbUV3bXdSOTNubjNoRFprNnhiOFpL?=
 =?utf-8?B?ZmRZUHZBY1hYc0pDNHhkbVpMc2t1QVNoZXZweVJNblc3MVo5bHdSc0UrQi9Z?=
 =?utf-8?B?UGwwVHlObC9ha2ZLVVNKd3F1MFpnRit5dEZ0QS8wL01WM2VOcmxXc21iNGd2?=
 =?utf-8?B?d2V3MUZGYWUzcENBRTRadUNvVW1wbTlSdE80c0tVd2wwanNaWG5sN0ltUXdJ?=
 =?utf-8?B?TXNOWFlHbGZpdC83Y3dTZ2hXTStWb25sSXNBblRPZjVMclR2REY1NDNxa3Na?=
 =?utf-8?B?Q0FEMnpaREtlWFJ6MHgvdk5SNlh0a29YODEwVkxSTGkzVGZHY3ZlejZ3cWFD?=
 =?utf-8?B?ZlRRSXN0YS9qY1pnb1haVDQ3YnR4SFhMRFlRWG1FdkQyeERIRjdWYW9iQ1VY?=
 =?utf-8?B?RURHem9CMjNsTWZBVXRTSmx0RWVpaWl0L0FpbjgwdTU0d1Y4WXg2am9JOWRU?=
 =?utf-8?B?QjZKcTZkdmtGUGtjMEduOGlVUHhxQW5JaTFNVEMrZnZjT3BCeHdMYUQvY1NU?=
 =?utf-8?B?VkdqUjBsS0padWZXaDhGT2N3QWljcjlXdnFRekdHM1RlVWVWTVhScGxUeWtq?=
 =?utf-8?B?U2NxeTh6MVF2cVgzZllZdTRMVkZaeCtpMjVSdTRXWWF1emo4NElyVHpYeU4y?=
 =?utf-8?B?b21INWxKMXFKaWJhVndtdWRPTk9pWG92bTJkT0VsYVc4TWZKTU81VXN5Vnd4?=
 =?utf-8?B?VDEwWTdBcWE1L1NodkdDbWpiY2kyK082dEc1cUJVTW9Va2tucUlnb2gxY1VZ?=
 =?utf-8?B?bjBLS01hTEVaZXdtSUk3WCtZbGRXL0tqNzdLaGJvSFRSNjhrOTd5T1J0THdS?=
 =?utf-8?B?TkNKaGVmLytmelRrUGFaQ0ozOTZ3UGhRTE5oTU9hcFhWb0lzN2p3U1pOaHBV?=
 =?utf-8?B?ME01ak5YeFFseGpjdVV6Y2tUcTI1d0FmbnZhMnVScU43OGVvTzBvOGEzMUZa?=
 =?utf-8?B?TkthRkJXVU92Q3pUaHRDWklOaUpSRzFUMHJkZHdYNzFYM2lBczVBQ0RRZHIz?=
 =?utf-8?B?ZmtML2ptT0VXTFVuWUpvNW1hSFdoRE00RzVMUExBcFR2RDZpck52MjEwbjdp?=
 =?utf-8?B?SkRaKzFOQjVxd2lUOXUxVjl2QUZNb1F0ODhyZWZ6Ymg1bmFoYkFGcVVXUDZS?=
 =?utf-8?B?ZUhUditva0JYN2g3clNHbmVabkh5eG1MTGNnV0VqM25MRzhSL3JnS29jRUNN?=
 =?utf-8?B?RzVmQjNpbncxUDVsNDluRWZqTHZ0aXEvWUpYUVN5RitlbytzZDlhcW50L0di?=
 =?utf-8?B?VWIxS0NZbTNnd2dxaVZtVW1UZjNlRFowdWVRZFFkOEJyWDc2djVvbjRvTzRZ?=
 =?utf-8?B?K2JyZ1kvTGZqckVocVhSNjQyMTV0V0FwMXZrR2tZWktQVmlaYWRWcG9GT2lW?=
 =?utf-8?B?WUl0bEVFSlkrU0ROdlBXOVRVTjV2NHg5Q0NWSnpZbXNNSXpNMFBjRFQ5TWYx?=
 =?utf-8?B?MXEzVFQ2QmJDL29vTi9jcDFqdm9WN3dpZVF1REphWk5qMGtxejkvTkd1eC9U?=
 =?utf-8?B?MEE3YVgybHMrWGVyYjhoUW9zYXdTVVBwV2V4OG52M1l2aktldDcza1ZiSzds?=
 =?utf-8?B?Z1NmeE9wazBTMXg4T2VCQXNocFd4THJqalBpbHlqRkdWNlE2cXVpa0RQL1ZC?=
 =?utf-8?Q?kDkCJ/SpbOGpVMRxlEX14hT0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af58aec0-e893-4746-d580-08db10a90515
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 05:37:12.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMTleS+ey0nWgHzGnSoxrUGWWGiS9Rl/cnfUyFD90Qqn7pdyCiunYXOTOaZiVrBfSqQFYLwvmcpbmvTtXjVvNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Felix,


On 2/17/2023 1:29 AM, Felix Kuehling wrote:
>> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: Failed to resume IOMMU for device
>> 1002:9874
>> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: device 1002:9874 NOT added due to errors 
> This look like IOMMU device initialization still fails (but more gracefully
> now). Vasant, is that expected?

My fix is to gracefully handle failure paths in IOMMU. So above logs are
expected. Basically it means IOMMU couldn't attach devices to new domain
(because it couldn't enable PASID on AMD GPU as ACS RR/UF flags are missing, see
commit 201007ef707 ) and we did fall back to old domain properly.

It also means that GPU will not be able to use PASID/PRI. If you need these
feauteres then you have to look into commit 201007ef707 and see how we can
enable PASID for GPU (without ACS UF/RR flag?).


> 
> This would lead to KFD not being available on Carrizo with this kernel, which is
> probably not a big limitation in practice. It would only affect compute
> applications using the ROCm user mode stack. I don't think anyone does that
> these days on these old APUs.
> 
> The SMU errors seem unrelated to this unless there is some subtle interaction
> I'm missing.

I have no idea about GPU warning. All I can say is IOMMU side looks good but
PASID/PRI is not enabled for GPU.

-Vasant


