Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93893698C27
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 06:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBPFh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 00:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPFhZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 00:37:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E0B76D;
        Wed, 15 Feb 2023 21:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZbXF151vpmACsammCwPK1iLi1Bbw4kM2WnF8jOFJyd7UVZdk8S7b9SwD0trUlTfSX5NZ56v17OBvEHUVdnC5z/s1nCqUbXn2l/B7LuLdt03P/lg4TdIYl6WmvAv+0cBQMLWnNfb8MM/ynR4VOx8MASDAQo2sOwok/4lkYO1ucNDOPzLgmY5o5Ht4swSqa59vTydZ366jc7T7fPqakZkKN3eBA5FFqgrb14poX0XqI3N6a2bhV5HEZWAmpMEcmkDLCuehNwCxWXInRahkLNyi6Xxt1jJ3Li0KJPANCUXX2TjYDH3n0ATw1Cma/gvg7P7YUvbrH1CfxQjs1kI7FwsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh3Lx1A9h5N0Y46de8xL++i4vY/8f+R01W/uE9wtWf8=;
 b=eGc2XLyyVgxPXKHajFT6Bd64ztObqfLz88IbINHvnCSmRd2y3vaEnBa42RBLlBv/FvjsW3+/tepNR1m4zsPKDK0xeYuOJx/YLpJ0z5uB7DgW9Oj/hwQpsT+7DxuVIo6unCcI2XWzwFo3+BEg1v3XQNDsXvDCJ2a7Nk/0RRRjLc2K/OEVrV19RSbx5+/2NGhYiE7riVmJGGESd92K+lJkAAs4dV5WjVSa0DbA6BrHcQDeoZN4gTEcckPMUUSDnFHfrVQPfm4gI3BtaK05s7GkHcH6prqfCVdhlAuWiP+66saMc8ROb+aDlkcpY/t4TJ8XFHj2owOB2RgLYCxB1VK5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh3Lx1A9h5N0Y46de8xL++i4vY/8f+R01W/uE9wtWf8=;
 b=vGU5+HP0XDQhFIZ+ygyEbM699xbd667fF2JTdq+IPHPCLZy3auWwjZEfRfxmDmPa1aweL3Z9ffoOeBnDDyEIQhu9P61G914DZ3wS7jX6Bk4b0qlxM7X+aZsZGKkuVhMlOfEYnDiaBIfKexStFNNz0s9ZkPFP/YpR4T9JpCx5mws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 05:37:21 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 05:37:21 +0000
Message-ID: <9103b537-62c3-d6b2-b576-713406635455@amd.com>
Date:   Thu, 16 Feb 2023 11:07:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com> <Y+18UuVTKIshk8EF@nvidia.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y+18UuVTKIshk8EF@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0fecd4-5528-4c54-a5aa-08db0fdfdfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srAtfSpFI+3MSnD3GkoAEw3SrUiDP4JMFAnoiY9w8OBcqIwZkpC2tsBu2o2qaaLux7D5hnKzc6b4a3n+bNLXLLuSg8WrLrFVMPd+vAAJvukCrD4q4xUCBYBVM7nsgs+Kz9nGQzZ5nP4i4GPM3aQldF60w/cYEh/yF1P6ow8MppVaaRwXkfTqBEtpYprpejhtZBtuCgBL5JR7GgzJW5PntXkYvLJ7dl9oxDWeG3PlNRyFyq4/d9eu0m9qtmbETVEynudGCHylpvHxU5tg2r3ETz7dBqi0O5d4GpbDG0Um7lyBc9+QqAMg4+mwNgKcElC2rcwuas3r6rkdXvnRN8BbjjzsGO8st/fIVQAg9cS7c7uMXZeo7VWK7jZ0l9GOY8hqGpGpBEOcmpO4hw4wIaQvc7rA20eWZnXrIicedBLUUnwJzRY0VXzA/0OTkuDC2JhgH/avcX8zsAHJNPndMfwSnur7+81IcABny4pA9ljLnD4FmmU/Qak4mPPpo+tykyFeP8Yaic3fLAwXHonOZPJ1bA6uTrvlxyq3feHlDzeDI5Wj49swN5DhCikHDPo73e5oEX66O2k+1i9ZpvDrB7QLNSF7P/UGVRe4pbZC2zUR/iIhy9j3X4Hxf0vW/fo/auWj7G5Tfs2vbd0h3+U96bkhcQ2Ay/1Z9IVeTJXlNUi5YNtVn2ZctX8yDnzvPphe2BmI2A5xkDFY/uxWtLBDhSHOo4xlhNYVTWC4gkfGpslaffY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(186003)(44832011)(26005)(6506007)(5660300002)(41300700001)(53546011)(6512007)(6666004)(7416002)(31696002)(86362001)(38100700002)(8936002)(36756003)(2906002)(478600001)(31686004)(110136005)(6486002)(966005)(6636002)(316002)(54906003)(2616005)(4326008)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDVPSjRqaEpsV0ppcGVneHMyUzV5VGZta3NBUWJsazJ0dTlJZEVzSVZpSTU3?=
 =?utf-8?B?aG1kV3l0bkExbGRNSERIN0xWdXFrVWVOaEhsWC9DRDFENXRjYXF3OWtVcXRQ?=
 =?utf-8?B?MkxCRyt0Z29PUXpOdTlOZ0ZSM3g2RWU4RTMxcmRYTjJkbm1ibkhaWHFaVHNO?=
 =?utf-8?B?RWlEYWp6V25CLzlxdzh6NHpBNGZxMGJqSVM2Vjd5QXN1U1NVY1BEY0hwWm9L?=
 =?utf-8?B?UlYrT05hUFdKZUJRbitXcjhnWG1nUjNJQmN4ZlNub2tXVkh6VjdiZVlmWm5h?=
 =?utf-8?B?Rk4wd0h0SExrazB5YmRDZVJjNUZpMEVuU09JeC9PTTAwU1ZvU2NjcWxoK0Ix?=
 =?utf-8?B?Z0xKUGphdkF3TGY0VGg2dWFteDIwOHN0dVN5NjFYOHlvbDZjWlllR3JKK2hS?=
 =?utf-8?B?akZLY1JYTnZSMEZHK0NMelZnaGpIRk9EclhENlBWOUV2YXQybitjL2J5Tm5C?=
 =?utf-8?B?ZU42TFdUZk9WRDYvMmlSMTJUTGZqZmlqUndyS1Q1c0h6NWZicnQ3dnVXbDR3?=
 =?utf-8?B?VndwNVJmZ0EvM3d5L1ZDV0hMa3RJQkVFdkFCS2dnT2w5UkRZQTc3S2xRS0dn?=
 =?utf-8?B?TU1IeVlXWk85R0UyT3NtV0RYWm1oTE5jTHVrTnBYbFpac0NvU0JLNFFqVitZ?=
 =?utf-8?B?MnFCbTd2b2dNWG1sa2d0K3dqeTV3RGZiUmRncFJoRWlBUkVuMGhHSkdpQzNj?=
 =?utf-8?B?azg5NElJaDd6ZkJxK3d4Y3h2MjZGTUw4alhvQWIxVjBaV2I1WmE0Wml3QVM5?=
 =?utf-8?B?djVpdWtzbWprUDVYZFNpYjk2U09iQkVkT2hoeWRINHFlVnB5ZHRBUFpzREto?=
 =?utf-8?B?eFBsLyt4WjdMSVF0YmpqcUUxV0xLaURoT0lRWnVmOFl3N1k4T2FMbU84VmM5?=
 =?utf-8?B?cFI4U0VHYk11RW1MZjJnZDZIMXRmemh6c3R3a1BpY1QybytRNHV5TEVGOHNI?=
 =?utf-8?B?aW9zM2E5WTd5R2FYNzBRTThyYWxMVlFXdzF5NWFhQVVGL1dMZzJ6QWcxTzlw?=
 =?utf-8?B?WTJYc0x5Mlg4Q0U5cElwcG4rZzlnc21VeHR0RTVpT25WV1piY1JaWlRGclJN?=
 =?utf-8?B?cWx0UHR6aUNHTHFHZ0pHekozZXpSdGpWZ29MeXRRRVR4ajVtWHZ5MTAxK0JW?=
 =?utf-8?B?SStPYk9rM2tmeHVLZXRIZUt5QUNhM29QSXc0OURvWWhULzFaMG9ZVXJnV2E2?=
 =?utf-8?B?VFNEakN2SGJRR3JkVHNqRkFlSldDNFBINmZ5UXp2SlhJRXdQNDMzWE1wRHFu?=
 =?utf-8?B?TmhoSlRVRDU3ZDM3R2YxWlc1dXRwMkNOSEZWQ05DZ3ZRdEFGU2xKSFVOcDhS?=
 =?utf-8?B?YU5TUjh5S0x1YnBSREw3a2t3RzJCd3N2SEp3YmZaNEZiSW9lSDUzTVp4Tk1l?=
 =?utf-8?B?QkRhR2k4V1huVWdyTzVVZjlkT0M3RjRBeUN0L0pxK3FiMnJNVmZzS1J6a0py?=
 =?utf-8?B?T3N6Zi9QR2ovZ1M5RVVFVlJtSHFJb1hNSUFBV1N1aU0zRGpxZG1lK3l4YVY5?=
 =?utf-8?B?VWFkRG1PdmVrWEZoVmMza1VEMzBIVVNHSm1TaDl4L0xTak0wbWhOR25lRTJS?=
 =?utf-8?B?QzdlczJtUnlWd2tOb1BEbHorM0xVUmpPR0UzNmFvTll1bjRtdlJiRVF2ZGtr?=
 =?utf-8?B?Zi9mRU82RzlRWlJCRGRwcHZBZjRFczFWQ3JxVC9ybXNVUEJQYmZuVVVHR2Nh?=
 =?utf-8?B?VnUxWnk3cnBSTkRQUC9xVTRZcFpSTjEwZU9xcGtXU3lzU2hMNy8zV3drZUxN?=
 =?utf-8?B?citDWjFzZ2hOa24xUzRHaTRmR3R6bXZPR0FHQ3RSYUppY05YckZRMFBISG4r?=
 =?utf-8?B?MHM2ZlJZSmhaRzQ2QTlBS0FBaGVzYTQ4RDNJM1UrT3haQXhKUWQ4UU9LSXJs?=
 =?utf-8?B?NERZdThuR29FVzBLRkZzMWxKT3RtNllWc0E3S0NtYWR5bUlTWmZVSGJJQlpz?=
 =?utf-8?B?TGE1WUdSbGVTN0U2N2Z0djhNOU9zKzNVSXdTbUlTVm9NcXU4WHBvK0VxOEpo?=
 =?utf-8?B?UlF0M0ZnbGFsV3FGbzRMSFN5OTBvb0krMUVGODFhVlY4UFFGNjJ4M2hJQi9Z?=
 =?utf-8?B?UVIvNFV6dEdXU0t6UHBBOE5EQ3ZSa3Q0c2ZtSzZwMlNTbWFrVDdkNWVwODV1?=
 =?utf-8?Q?g63BEMN5WSG8ZdzF44rVxM68T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0fecd4-5528-4c54-a5aa-08db0fdfdfea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 05:37:21.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnJKC/9FAv/7hmTAiOQxWIk/w3mjplnXjHBq+9iqEh/T6ecr01SG5sjX1CTv2bv77FPsgrjj8+Jvcvyd83Zxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,


On 2/16/2023 6:14 AM, Jason Gunthorpe wrote:
> On Wed, Feb 15, 2023 at 07:35:45PM -0500, Felix Kuehling wrote:
>>
>> If I understand this correctly, the HW or the BIOS is doing something wrong
>> about reporting ACS. I don't know what the GPU driver can do other than add
>> some quirk to stop using AMD IOMMUv2 on this HW/BIOS.
> 
> How about this:
> 
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 864e4ffb6aa94e..cc027ce9a6e86f 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -732,6 +732,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
>  
>  int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>  {
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
>  	struct device_state *dev_state;
>  	struct iommu_group *group;
>  	unsigned long flags;
> @@ -740,6 +741,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>  
>  	might_sleep();
>  
> +	if (!dev_data->ats.enabled)
> +		return -EINVAL;
> +

Thanks for the proposed fix. But aactually this will not solve the issue because
current flow is :
  - in this function it tries to allocate new domain
  - Calls iommu_attach_group() which will call attach_device. In that path
    it will try to enable ATS/PASID and hitting error.

As I mentioned in other reply I think even current code returns error from
amd_iommu_init_device() to GPU. But the issue is, in __iommu_attach_group() path
it detached device from current domain, failed to attach to new domain and
returned error. We didn't put the device back to old domain thats causing the
issue. Below series should fix this issue.

https://lore.kernel.org/linux-iommu/20230215052642.6016-1-vasant.hegde@amd.com/

-Vasant

