Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD5665639
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAKIgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 03:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjAKIf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 03:35:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E52017;
        Wed, 11 Jan 2023 00:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaH5YqDnaJjJhgQoX5e27SfjK8PbbuBFuDzhziIwyWjK+2rc3UFMRorKGr8tMt0vLfuSCslF+YSoZFWi2cSXhmmCkJ0S+gjX4GqQcHxD3byvG4IoELRz2as1uynrbXK49oAAtFooESZu9tsdiDUbapbUTorkqFNxDlPYfSWzCpDxEN2uoHQn/zOz6BMr98GdIYszqp11sPGcEBLZQ4n/dH0zTt1pIpJ7AoYWcCiSrLynRVYo8x2G0BaeIIhMDpuUHxm4fJ/Op8u9y5CvZ6eUQ0pX8+cKpHm5py5K/ckWhFg1L4ysH0XP3LaqmYGVS+KMN9BRvRfnsGafP73kTT//bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTin1MCTXRTzIGDoaQHo+BSo2iuIku68RrcB8bV/SuQ=;
 b=Vlk+WiMy+6mMYD3eNiYjIiep2ah53dMUCJ6XICpXBF7bl4R/k2hE9DY2USc2zS9Kw9/uhXoksbhSb3TLtgzT5IHZsZ6FAp+dmd+FQUuftgWS5dutQhCiWa10xIWi6k8RisrjRxF0UGEqh9XMFgCazZCN7O9xaFRdVUrfqq78jhCXMCJl6Vv3o8NTYharFgy+mPO+qx8BJmOGyVlvk8DGhwdZl15QHZOoG/y7EGjkxWah3rg4kQU6RCO1sTp0FAlsl6Z7zneXzaV3uUKLeJB+Xklz/pcHHchDIZfoRJ9CDJg3Vxhs6DDuhhxRRPAF2HKIHuN8W4t95ef9+VmkzzPZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTin1MCTXRTzIGDoaQHo+BSo2iuIku68RrcB8bV/SuQ=;
 b=2R1EX4Javb3Mv/LG0Na1uvhChEGht5iPiAIRP+ev8C91gmlDRUuuUISNlQfzTVHSOeOM2hJGmLOTOMwI9jejRv8mKlaN+5AnsWWnExL6aOtUecbp/PtD/5DQ6nwBwwK4HfuCYiy+TsTBysZKH4vYLgKHQd/A33dIluqGyAtcF20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 08:35:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 08:35:23 +0000
Message-ID: <08f2f79f-e79f-f2d8-2fa8-2cfd59004507@amd.com>
Date:   Wed, 11 Jan 2023 09:35:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Matt Fagnani <matt.fagnani@bell.net>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        amd-gfx@lists.freedesktop.org
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com> <2d1b2183-7e93-f8a5-3c74-8f66824bc8f2@amd.com>
 <Y71tTdm/f+uxsTKj@nvidia.com> <35b0f7db-e248-18ed-3e26-3f9f4f14f8c4@amd.com>
 <134da31d-2cf4-431f-2739-aa2940087245@bell.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <134da31d-2cf4-431f-2739-aa2940087245@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: defc5d06-785c-4e0c-163d-08daf3aec823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkMv5bc/TIv6YXEaP/BtAbEysl1MADrOty/ankUe8kHg18STA2q/cvoQF3EGrHW2yuD0tK8IByPjf4EhgP/VJCvD7vh72WcIKLG1L+Hsmc/HRCznmOkD/yNyFad/Xq5ZpKlfnI1iP8xjBDeXNfQ8wil2wEh0j+mtp6OdLsQzTpGhJPRqF5cf0ehxi5vE/BKdlubj0kj/9k0TLcSnSEcvoNGkQHWXqeDiQonW9U12lIsWB1eWaqa+aP4mXBzo7TdyQSjA9taXHaVlJEu+5WGcDqPG0mngt3tjxjlbd3I7Sxb8pNAhNXrshK7MhFBEEu9oa1oaZBkwsel2nDcnF9eKa7fSgGBeLXgxFY3KqQG9tfp+5ljU4X9GXPZUHwC7Le8EhyupBHrQNAydNi55vSMhLxYoHdPB6D174gEf9frIU+//msl6w/jm4pQxl3PK39ES2iEJiF1pPuNMK0Za6w51KD0EbepEFgPaziMGM5L0qjhlwwbv/wL7HEYCh9LoZF96GPrNyGpFOiGA9/+t5P/fGtSKF3OO4lh8wnQV1JrUQ1VmNpPS7Igf50WoueH00MBvySMu+cC54Th7ldkRYtj+9+oJvM8H+l8FETONMLM1+N06CGa0mjJkU5AIGUSjGu9JdknSqEYQVz/Wn88Coo20EdTjQwUtyma9x5oAOejqznQFzQ1tRvsCBYbvXoBl+tXWfx8c+t+oS0k556UHXLYBf9juyJeKfsmbY5o3vkxdPUakTL0jYTm1nidOBdyjRqrNNDjM5ZA/93V6iS3YLBMmRJ+qZqNHCsGBFqR+PN/g8tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(7416002)(316002)(5660300002)(6512007)(186003)(6486002)(966005)(478600001)(2616005)(45080400002)(31696002)(41300700001)(66574015)(66556008)(54906003)(66946007)(66476007)(4326008)(110136005)(8936002)(83380400001)(86362001)(36756003)(6666004)(53546011)(31686004)(6506007)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5IV1o4elVMaGlDS3BQZ1hLdlcyekUzekJHc0tFQ2xyZzc4WFlrYUYwbU9I?=
 =?utf-8?B?dHJ6aEhFR0ZudWI3Y01IUWdPbWpEeCs0UzJNeUJLS0hlU2EydGJFbnlCRVUz?=
 =?utf-8?B?b25lOE1oeDdOYzdidFNGR29EUXhGYnczbmV2bEFodXpIQnYrY29zZStzMk1T?=
 =?utf-8?B?eUNLRDFTMHpuMitZamVDVlVNa0liaG9rZzNrd2JnREJlRUhvY1o1Z0tsUEU5?=
 =?utf-8?B?SjYzY0dQS3V5dVlXZVoxeVJmRTQ5bzVFOEtWZTBSSWV2U2pNU2l0MEtDeVJI?=
 =?utf-8?B?dWtabUEvMFBtNGM1dTVqbmlQQVFsUDBvaDQra2poY0h0czZJQkVqcWhSQytO?=
 =?utf-8?B?czZwWlpKcTJjdGx4L253b0d0SVk2SzQ1TjJKZXd2K1ZaVVpONm1xdDhlVUVI?=
 =?utf-8?B?Nm1sSDcwWXIrcTZQWXN5TEQvN0lrMllyOUYvQ3ArWmQ4ZllkQ0JHWTVCWC9m?=
 =?utf-8?B?Zm8yWitjYUNYZ0F0ZGJUSjZOMWdic21GNkc2dU56aWFPZmtEVTkvdXA2dCs5?=
 =?utf-8?B?UWsxWUhFQ2REdUZuRGRvVHhkUDVTSHppRDU3aXU4UHhWZ3pnK2c2blZUcGxF?=
 =?utf-8?B?czdudHJkQjZ4aFVpcHAxYUlLWGRlRGhKOWJHMGZaSnZCVmdCN1BxYWRQbzRC?=
 =?utf-8?B?VUZ0VEFFZGRETDZzL0IvTFR2U1pKZnlGZmZLY0dDdGZMdkR2b1Zhai9IWHk3?=
 =?utf-8?B?aDFQNGRteWNXcDJEeFREZEZHUWZRZXJSYkFSTFUxNFlpNTA0N0drdkRpdmlH?=
 =?utf-8?B?MmhYVUFPbytzVG1pbWg1dURoendkMnlGNGJhanRHTzlnZVV1Q3FzdThJNXQz?=
 =?utf-8?B?WnFhMzlmUHJxNzhlbTZ6Rkt1WEZiWkZnUnJlWnBiRVlWK1NuOVRnSk1HNkZQ?=
 =?utf-8?B?ZnlKOUVDSVBCYkUvL1B6aVhvOGVyN2JDZmhJUmNXek8xUFo0cm0zM1I3V1hK?=
 =?utf-8?B?S1JCSmRGUFVqZFNpdGkvano3UnV5SnJySU9TSFliTW1jeDdRUVVhc2YxRmtG?=
 =?utf-8?B?UWx1cHVabDQxQlFBOGphUHppQlAybnpKR0pGUStuNTBiYW4wbXlUd3NKVmFD?=
 =?utf-8?B?bG5qSloyTkR6c084RHB4aDFXdW8zdnVTN3YzVC9MYTVlS2UwYU5VUUtoeS91?=
 =?utf-8?B?NHZzeVljelMwL1hvckt5b3ZBUXpwSDN3UGMzRFcxQmgya3ZLSHhZOVlvRnNL?=
 =?utf-8?B?YzJyL1RDYnluaWlncG9mclh3MWRHS0RDYlV3bmVsaU8zTUY2UTMwU3hUYVlv?=
 =?utf-8?B?MVNDVGNUZkt6RHhUYW8wK1dsMm40ZzB5dWhRKzZqU2trS1l3Ynp1and1dUhC?=
 =?utf-8?B?UnYycVVHbGduWERoMmFUaGx1T3JFcEc0RWJ2QndmV1ZkV0J5K3dyYmhpWFVU?=
 =?utf-8?B?T2pvM2RBT1F4blhtRDNZaVZpNStTWUQ1SkhCTWtMOG5weHF0dSsxU2w2cWtT?=
 =?utf-8?B?bE5VNmkxWDEwb1k0UG40Z25sMFFlTzZtOCtqWEQvc3g4RlFHRDQxYmwvL2lM?=
 =?utf-8?B?UWFxVEp5VEhHdlpoYVNEQVBtUWtxTmdVYjE3TjNJSFEzZ3hJdVNONCtLWVpa?=
 =?utf-8?B?MjY2eTYwZzlFMG1BWlVlNVRFeGNpMWcwMVhPTWV5UUU4OHFJalI4U1VxQU9K?=
 =?utf-8?B?K3pTV2ZVWURrZUJSZjFlK3orZVQwVHNWZ0U0dE9hckZoTVUraHpMODZISG5X?=
 =?utf-8?B?UjZOTG16bThBNU16YmlXMm9OVFgxRmVBU0lJYmRaMDJ6ZUhOMUVPSElJM3Jr?=
 =?utf-8?B?dzJ4c2NQK05GM0dpWEJCbVpUczRtNUFmQzNER25MY2tKMW9GdXQ1T2ttRTYr?=
 =?utf-8?B?YWhPNG5TUWdpVkxiOVBPRjRqZ1ptcU1tUVkweEMwdjJkWHFWL2JHK2I0aTJt?=
 =?utf-8?B?Y256SkxFaFNRQ3IyUjBpUGNQYXlodjFGYy8rWkpQdVhDcTQ3VDZ5SnhrTTBi?=
 =?utf-8?B?bk5DeVdHVFRHK1U1RFdjMUJGVWFza3hOVnhoeFNaT0pPYmdQR2g2Q1NDWHZS?=
 =?utf-8?B?S0d4b2RUSzRtcktXd1p0eGNPSUYraVYydkdIWmk5L0p0N3lHdzRoTlB5bmM3?=
 =?utf-8?B?YkZrMUlRQldydGdsVVUrZGdYUjRvUFhkanhUR0FSekRWVzJFcWJERE9zMHd0?=
 =?utf-8?B?MXRmSnpzM04reE5ZY3I0bUJNclhPM3NFTStWQ3M0WFNKT0ptV0w1TU5hZHkz?=
 =?utf-8?Q?WLI1AE6lizQ8xaT7gbfhaEnm48XFRFO7T1rrNNG4RmVe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defc5d06-785c-4e0c-163d-08daf3aec823
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 08:35:23.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hqb5KaWxV+k+u/hs2Q/ypd130tSW2rfPsuqrrN4G+EMQRHJCMVKIynRC7v5g2/Q/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matt,

after reading a bit into the topic I think I know what's going on here.

The assumption that you need ACS to enable PASID handling is simply 
incorrect.

Going to send a revert of the offending patch with an in deep 
description of the problem.

Thanks,
Christian.

Am 10.01.23 um 21:51 schrieb Matt Fagnani:
> Christian,
>
> I'm attaching the output of sudo lspci -vvvv. I'm not sure what 
> $bus_id is in this case. I guess it might be 00 in 00:00.0. I attached 
> the dmesg from previous boots with 6.2-rc1 at 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216865%23c2&data=05%7C01%7Cchristian.koenig%40amd.com%7Cc14ca7b3ead040ee279f08daf34c8687%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638089808663927196%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=iFHmme68OeqRpw7zlSPp%2F1mB95DKCR%2FTAsjTcjT6S1s%3D&reserved=0 
> as I mentioned at 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F52583644-d875-a454-7288-8b00ea0566ae%40bell.net%2F&data=05%7C01%7Cchristian.koenig%40amd.com%7Cc14ca7b3ead040ee279f08daf34c8687%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638089808663927196%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=j8ZppuXkhw4dD9HS6OwsvulZaV1R3W8Hu%2BW11%2BxMCuE%3D&reserved=0 
> and 6.2-rc2 + Vasant's patch with rd.driver.blacklist=amdgpu on the 
> kernel command line at 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2Fff26929d-9fb0-3c85-2594-dc2937c1ba9a%40bell.net%2F&data=05%7C01%7Cchristian.koenig%40amd.com%7Cc14ca7b3ead040ee279f08daf34c8687%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638089808663927196%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=i6fxlEn74v86MnFfgCmtYQ2JCql0sVsimZqioBiDyPk%3D&reserved=0 
> I'm using the Radeon R5 integrated GPU which is called Wani in lspci 
> and Carrizo in dmesg. The CPU is AMD A10-9620P which is Bristol Ridge 
> or Excavator+ according to 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FList_of_AMD_accelerated_processing_units&data=05%7C01%7Cchristian.koenig%40amd.com%7Cc14ca7b3ead040ee279f08daf34c8687%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638089808664083434%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=Ywp7MnbjYMeyXGGNFHOyn2A45IZSLIsShkIPEC4GB48%3D&reserved=0 
> I'm using the internal Elan touchscreen in the laptop. I'm not using 
> the HDMI port for an external monitor or audio which I think is called 
> Kabini HDMI/DP Audio in lspci
>
> Thanks,
>
> Matt
>
> On 1/10/23 08:56, Christian König wrote:
>> Am 10.01.23 um 14:51 schrieb Jason Gunthorpe:
>>> On Tue, Jan 10, 2023 at 02:45:30PM +0100, Christian König wrote:
>>>
>>>> Since this is a device integrated in the CPU it could be that the 
>>>> ACS/ATS
>>>> functionalities are controlled by the BIOS and can be enabled/disabled
>>>> there. But this should always enable/disable both.
>>> This sounds like a GPU driver bug then, it should tolerate PASID being
>>> unavailable because of BIOS issues/whatever and not black screen on
>>> boot?
>>
>> Yeah, potentially. Could I get a full "sudo lspci -vvvv -s $bus_id" + 
>> dmesg of that device?
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Jason
>>

