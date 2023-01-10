Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95B6645B1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 17:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjAJQMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbjAJQMm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 11:12:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58EF564DA;
        Tue, 10 Jan 2023 08:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IloUwU8eFLUl0t/Y/Zf7XvQbroXbtxiXppGROXy8hbv7+Z08gFTwDCbIB5Wqn7BhtZq77wxNQqRCeQMjDNkzQ7GVTF9182tWXsMk3UvXE6huPSbhU8Cvx+G/gOQJn0wC1diPv4UbQsOGjIMvxoWERIlVzS+s9mSpa8uy4gsVuHqv9bW04OF0Urn2qqLLKKfU2mMRl6DWrMk1uXAqpWcjfk/0CIxJRcwSLuAKQtq/+3vyZoIFZ6rfX+MkeJqvOIYC4Tz4DMbD9ZSIkE52LjW85Xzz6/OQKGkfekj0HbTKD7gwh8uJTnGTu/5s54EdYWm5CZSzM54jDS++x+cb97j+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UmDIc0mJ8d02puVT+VwovxQSSYhGPrEYO2ZQE6fxOY=;
 b=kzdpHZzPLtd2D/ZSFanUcepTESjL5ospcgimDgq71e48Ch3jaYOO1oAG4Xrq5+OXK7Q6fkaKU2QjmvweuVuOHuOGJUtoqdd1h713t4wse2r/LjEKFDLvOkKarrCL2rLxjPdvKecuG76h2nRDE7P2/FZQhzvVrltEb7YRs7yRrYoG2hiOhMHxL2BpvOetv4Nw9NI4eBKGKQ/E5vvPlKDM/Hxs2lO4MY8/3DJ+X8caQ/9EJfPBSjt17xsbo5pV1jJRRGblYTVD22NI/7qa1Kq/kkVdt/7nG/DZ/sRe+/b6auxObGohPaANfCGm7oslnNiY74iPIwivU+fWMXKgQbVM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UmDIc0mJ8d02puVT+VwovxQSSYhGPrEYO2ZQE6fxOY=;
 b=TTBr/PIYuUK02C7cgobEd9lU8iLb6JVMfx2DDjVgi8/0tBywdpi6ZKhua+zZIuNdv6jBSzaHxf7XyYwc1o3L/y5YwHznIYYiiakMs/rpd+QlcQ3G/wHDRUTsOC/UqmDXR+bimtPQXqPrPCEY8IJgTNgU/f5AN85AzteKagkHYP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 16:12:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:12:39 +0000
Message-ID: <d6342073-132a-4bdd-e1cb-b14f972b61c8@amd.com>
Date:   Tue, 10 Jan 2023 21:42:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     Matt Fagnani <matt.fagnani@bell.net>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <ff26929d-9fb0-3c85-2594-dc2937c1ba9a@bell.net>
 <525730fd-5982-fea7-b6d5-2da69f225f04@amd.com>
In-Reply-To: <525730fd-5982-fea7-b6d5-2da69f225f04@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 6991a81b-81b2-407f-2a15-08daf3257e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPDG2Uuj0Ut9+hbB68CyAveoGaML3uGkRp5cOcJCREUbmGw0ghje+QAT7BmB18FSX5qS7+QGS7VSTaMhOtCXRvPLtMFf8EkdpkNMUlBvkUng2Xypw2PVu9oIQWHH4R3lvT1lP2mPmygWz+K8N/9RpwUl+9Edoq7caJUJkbX5B0K084nj7xTW3kb3IDJzeMKEDt/xyjdagnzh5Jn6C7ubpl51NiwZ8F2DAs3BcyM/aWJVi+nTy/Bo/HuczJ59IBBgmohZknw/pO3UnK2+Px5IxBBAc4RH4cMHtOrDsY2aPUkjKOB3mc5chQwkA4wKZUETdJKKzbcS+Wm10dTRU3A5KKNc3hwOdXAe89reOX+zAVtDRE3tpAVKsh7ziI/igELzW/ZH7plZ7rdP2ecFXi5AHKZ2odh8cll1uUNM56SIDPQ4zxjU0MNLSc/0zuXI425CDjDn/bFUbzHiuqtUIDKuGn8PIepmMNeTfYfEy8eBw02DIneVXKmIx3NfHKYGx+MOMtXDn3XRA7x/RNlzHlxsmDjvwOiOu1Qubr+6zojagKQKXGq5fw8fnGaeVxYq2qTAsNhzIt0eMhF8H+biSKt+OoApoRRusuTPCMZEtmxuXPwN5HEOmcMH4P0XieptJvh5o0vsLOTaQF0W7Zms25L+yVYXkvT7eTUwq5uRUSHPd9U4WeZkRxAJv5iI9cVfTn0I0z0HiC4tbeDjp0GBlzrOxNTU3Kps5moHzMdV6V3HJz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(41300700001)(54906003)(316002)(110136005)(2616005)(66476007)(66556008)(4326008)(36756003)(66946007)(86362001)(31696002)(5660300002)(83380400001)(38100700002)(44832011)(8936002)(2906002)(66899015)(6506007)(53546011)(31686004)(6486002)(6512007)(6666004)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEl1M1ZMdFFzbzA5WVQ1NmROM3lvcEtVOHdvSGhWeGdYZWJRc2xTb0hCenlu?=
 =?utf-8?B?QVlscWNheU4xTXhMbTZuNHNPSU5yUUtuSE9nMkVQY2JmOUNNdCtOYTBLNXBi?=
 =?utf-8?B?TXBiS2V4TnpHZjZNMllRbTJkdHVZak43a3BpRjZJbEVRQlcxRzhDa0haL0Zj?=
 =?utf-8?B?eFNkWmkzVXM2ejVGZlBJQXFJcDByVHg4TzNkU2VGdDBlVXB3cUdhOHRkS0dC?=
 =?utf-8?B?bEdHSlFVVE9WQmpzdUxQRUJJeWNmSThwQWhlbGJMMmdYajlxQTdFdWMzSUZM?=
 =?utf-8?B?MHo2c29pQVNyUTRFV1ZmMnZVYXVUWVZoOVNBVmFqTWFTOUNkbVV3M0dWVUVq?=
 =?utf-8?B?UmRyMEZKMTlWVzUyZXUrKzVSV1ZrajJkUDc3RzhZelNSbERFUG9DZW5UZkhP?=
 =?utf-8?B?cm1JdnRlY2xsN1dXbzltaTRHTGc4alh1em9za2JjRzZmeFZsVTFiNUdpWWRS?=
 =?utf-8?B?Mlplem14MWRQdXE3WkRXNUNMQ0I2cldvNTg3MVFLZ2FUUXFrd044aEZWR2o5?=
 =?utf-8?B?WWNuQWNZeDVsMVlYeTdTWlBzengwNWo3NENRaGt6bmRDNkpiMTlhVmlHUWdN?=
 =?utf-8?B?dU1wbWhVUlJWTllrTCtOeGNhOHR4dFgzSnA1SjJQVFFDMjRja2kxclhqZVk0?=
 =?utf-8?B?KzhlVGN3clZIT1lZVG1BM1JaS0lqU2dwcW5XMGpSYW5VT3F1UnNJblVNeUxF?=
 =?utf-8?B?aXdzWksvOFVkbU53eThsUno0aVdkVURqbDRrL0xVSUVyT29aZHVxOEgwTEk1?=
 =?utf-8?B?ZThVUkJQTHFyTHJBWTd5NHVBMUtrdWo3ZmUycHJ5ZVFVQ2VEajAxYzQxTEQ1?=
 =?utf-8?B?aS95N3VJNUZMMElKMW5vMDBRRXY2dzJJVHpHWFBkbXZKV0E0S1dEejhJMHl6?=
 =?utf-8?B?THUxV09BTGtDZUJEVGJETmdiS2o4TG1wK0U5MHpDdFdpdUNsQXIzaWR4NnFR?=
 =?utf-8?B?dFNQQjVaWS9DbXZyNFBoUk83R1lnTEFKWjAyZjVUQXE5SElBYUpZUlUxdjNG?=
 =?utf-8?B?ZTJVY2U4L2JOUnJMcm5wU1N3T3RyckV1NHJkRjRDd3ljOVpuZUlVVGhJWlJQ?=
 =?utf-8?B?S21XUXdFWHZGR0RZd051TWhCbXZ2VUpVMlN5bDN3bWVldDU4aE5PN0VqSXA0?=
 =?utf-8?B?TG1uS0FyR0hLcUlEYnFiUUo4Qzl6Vmw0dDJ3TXY4OFVEb3Q1a1NqQ2JkQ3F5?=
 =?utf-8?B?NHFIaFNTOGIxWTRuenpRY2RacGVLb0RJS0l1ajZzdkZHaWpTcHR6Si8vdU1F?=
 =?utf-8?B?UTExZUxJYjJHTjZPczgwVzlYU2NJTDdCcEI0bUMydis3Q0YrcVdNUCtvSEha?=
 =?utf-8?B?Z1RFa25XT1NnMzBqZzNXVnlwa1QvSVU5Q0czZWI3T3Y3dVA5VXBUMjNHNCtV?=
 =?utf-8?B?KzhRSUxJR1Rsakh0SHViUS83MTVXaHEzSG94bWIxRXlyQld2T1lvK0lUZjJY?=
 =?utf-8?B?WnN6d2g2djYzWjdIRVpaZy9RTy83d1BQQVJtUlNDZmxoL0xxSEkrVUQ3YmZt?=
 =?utf-8?B?RVI5bWRGa0RHMm52dDhTWkVKajV0WDBvWEI4Q0RVdFlJRjJjV1k0QU1EeEFB?=
 =?utf-8?B?YUw3bVhRQ2t1Syt2MTNNZisva2gvYnpOZlVxUDFIaDZ5ZUlBYUZHWjVpR1RD?=
 =?utf-8?B?RmVSUGVUb0JDYlBRR01GUENHaWluWkxCc0tmUXRIZFVobmhPcFZjOThCMDl0?=
 =?utf-8?B?bGJNd1pUNUhRNDEzOTFRWWhUOGZpbm05UW1WUHRMQjhxQ0Jla044SWlRK1dY?=
 =?utf-8?B?KzRaSW1VbkcxSFo4ZVVPRnVmZHc4TWwrZFlFc3djdjhPYWNVZUxpTTJjV3A4?=
 =?utf-8?B?UkhnVFBYVlpGV0xHdHZVZVcrajhRL3BSdkJTNmZlUGlpaTl3eVIwTjJjZjhY?=
 =?utf-8?B?Z0tvbWdUQktIeU9zS1dhbmhIeUMvVWRmcm16eHNiZDdwOVRBRXJpUXppVE5F?=
 =?utf-8?B?djJINkM4bTNHbm5McHpPb2Exa1JLSTduWkFhUEQzbTNLcy9CUlppSTZKTWdF?=
 =?utf-8?B?d2F2bm1xNmhlWitjb1g3YkRQWEQvUHZjeEN1Sjh1cTVBOENlSllRNnZhVjNL?=
 =?utf-8?B?b1BmdXUwUFdIY2ovcnNzTVBSMy8xTmRlZU95ZnRjeUVCM0NTZ1h2TnJ1UklP?=
 =?utf-8?B?ZmVHcUdRK2hjNFRlWUc2ZHIwYnREaFFxSWNyd3kxRjBYSWhRVWpEVjJhbFRa?=
 =?utf-8?Q?jDIk7Xtcwn0I0tZe1wmV2+fa36vA+v8TLOs+FmIX97aQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6991a81b-81b2-407f-2a15-08daf3257e6d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:12:39.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCZ4wCnXVg2KQ0G0CyiYraIv6k3Cjf1XCsZPlM+HWVhOe5RN9YYQq4M/13jxUaFcfG5J4GiwF6imjgZGyeFFVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/10/2023 9:38 PM, Vasant Hegde wrote:
> Matt,
> 
> 
> On 1/6/2023 12:58 PM, Matt Fagnani wrote:
>> I booted 6.2-rc2 + patch with rd.driver.blacklist=amdgpu on the kernel command
>> line to prevent amdgpu from being started while the initramfs was in use. The
>> black screen problem happened later in the boot. I pressed sysrq+alt+s,u,b to do
>> an emergency sync, remount read-only, and reboot. The journal for that boot was
>> shown on the next boot. The two warnings which I previously reported weren't
>> shown in the journal, but the same null pointer dereference which made amdgpu
>> crash happened. I'm attaching the kernel log from the journal of that boot.
>>
> 
> Thanks for your effort to get boot log. This is helpful.
> 
> Looking into the code further,
>   iommu_detach_group() didn't attach devices back to default_domain.

... because iommu_detach_group() expects new domain should be different from
group->domain.

-Vasant


> So IOMMU
> point of view device group was left in inconsistent state. This resulted in
> IOMMU throwing page fault errors and amd IOMMU event handler code always assumes
> that domain is setup properly. That resulted in below NULL pointer dereference
> issue.
> 
>   Jan 06 02:07:52 kernel: BUG: kernel NULL pointer dereference, address:
> 0000000000000058
>   Jan 06 02:07:52 kernel: #PF: supervisor read access in kernel mode
>   Jan 06 02:07:53 kernel: #PF: error_code(0x0000) - not-present page
>   Jan 06 02:07:53 kernel: PGD 0 P4D 0
>   Jan 06 02:07:53 kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
>   Jan 06 02:07:53 kernel: CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Not tainted
> 6.2.0-rc2+ #89
>   Jan 06 02:07:53 kernel: Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52
> 12/03/2019
>   Jan 06 02:07:53 kernel: RIP: 0010:report_iommu_fault+0x11/0x90
> 
> Ideally if domain attach fails (in this case its because pasid capability check
> returned error) we should put devices back to original domain.. so that it can
> continue without PASID capability.
> 
> I have a patch to handle these error conditions (not the fix for original
> issue). I will try to post it soon.
> 
> -Vasant
