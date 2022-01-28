Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE5D49FEC0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiA1RQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 12:16:34 -0500
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:18528
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237031AbiA1RQd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 12:16:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd7cQNVdPeXCroNlCkipeI9AyGqeJL6GX6IgMadxDwYHyOQGVayCynqqn+fB4x5KLX3L7xRv/7iv9YDp0jhE4mdIeDZKtBAgsqN8IdorX8QDamlfeJkOMXhNMKl4WZTgj/XY8IUvJT3h9a95My13vD7oVu1g5ODRND7FQbI5AAKcJkQhJ1qMNVmvQXMZFxbgC6f/ppM++9tajp2sO6W4IkhWPSmBMZaZBkfrLTf9peuh40nFgCWezaxZcR/XYbJQrCA/MwHQ5XDMHPVkKF8iE8LRf4gUYEF7BIRAD7APMHoX9T3k8n5GfEC04Q6K4AIr9WUF06cju35HF1cEZHwodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThMIoxBIpFCsk3k46ZXw3MaMygYjjWz9oTdTk2bgIXQ=;
 b=h1U6GGv0YQOj4GsjYPcs+5GxXKeqM0RTVhkuaYgn5apbdWoemzjAfCNdPZ7LzOs2g8QXUUtHMMXS3cIH/yr6tccxIEMKIw6T1EU9D7gLrIFuGuJg/InmS0eMo2XBM9t1rEz0s6evn3xT9jWns/ZoSIn9Ue2D2XG8CqJrhHakp9JvYFSafL8Zt0QuhGhh6tcJCbf9NTzDf+MgTOTGIoYomm+hxBq1vclerivd+94xu0yhyJ9YpAwkw1OUCPv2A9Mn33QSoXoLw2bk19bRg4pt9m9/QQVD+CJXk8gk4tTw0zo4VyG+fe673RHfmi0CRx2U/EhUTXCR/mwhVsouO2Z/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThMIoxBIpFCsk3k46ZXw3MaMygYjjWz9oTdTk2bgIXQ=;
 b=XERiqU9B2NHWdHLez85VLII/8alK0h9xsGLcF9f3PDcz5BRq7LCuFbi+JVc6o50Q+BkJ2X6XQVdWWvNUqUVJpthLM5b8d8qlcYXeztrpaNDE2B8KLrSDHLZ8c5m42BBf1FkeRoLej4TQDvDsjVgswUX0aO3/1H48dAwqR9U79+1Z5Sz6LDbcD/OL7fga0kyTpKNSF1qLLsuuCwsOiLkRENjJQyUHQaaHZLPkp53H3v4h+ZN5wB5cBWREKBSrUuBNFsE4Z0V65IjbgTecgi/VRUXbWrBANbn/tv1NeNvgosivvLaiRWR49+NeS1BZoo0QUumTG4mdLMiP/SwO13jQNg==
Received: from BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15)
 by BYAPR12MB2950.namprd12.prod.outlook.com (2603:10b6:a03:131::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:16:31 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 17:16:30 +0000
Received: from MN2PR12MB4344.namprd12.prod.outlook.com
 ([fe80::6872:c444:d3b5:7b2e]) by MN2PR12MB4344.namprd12.prod.outlook.com
 ([fe80::6872:c444:d3b5:7b2e%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 17:16:30 +0000
Message-ID: <90168b70-cd15-9eb8-b782-9200b174a046@nvidia.com>
Date:   Fri, 28 Jan 2022 09:16:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 02/24] mm: remove extra ZONE_DEVICE struct page
 refcount
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-3-logang@deltatee.com> <20220128142138.GU8034@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
In-Reply-To: <20220128142138.GU8034@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To MN2PR12MB4344.namprd12.prod.outlook.com
 (2603:10b6:208:26e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75e764c-c983-46fb-7578-08d9e281ecd5
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:EE_|BYAPR12MB2950:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539D986383FCB391251D5A3C2229@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dBBp9t7r7eqganCAa6zHGtXK6rkXzq7pRgZCSUdFVi89XBCy9FbxhNjGtVq4iPslm38+qw4tUBji8SgU8py1XcQ8VkwA9AJ/VUTURQLWKKHI4d/U/vjJhH8bFBKtBS520TmkwaG4VVy9orZvsgCI1Spuy4lwYUXDwOc+qUnIdjHCLk7FYq/V9MK0uYteiWlVGGoap4V2ESNQoezKMpeX3K0dbF4gFMdG9+bf5stssEaNxFPFKUXF3qC9+jqGxrv0+mBdV8vJfHL9m1y9zjVVNAvd56DXB3HY6J0xdfotzH2S0f9cvv0GqH0YOmG/hftKiHXsx7AeC5drxzkJ22uKBEe5xtKlMHJ2iRhG1DK65fbqP7JLxfst8XnvlVe0GYyHv6JIBeGs/qP53YYQv8LC5/vAMaQhna9Lp2gZW4OaLJ86XYKf7zZLxXx4jXJk4GvAV8ojQH/ncB1bv4nNIv85GrV8LfeJzPCkhMAzM+I4gabqOYSR0gSbhm0vC8H2zh9maihPqP8QotYwgd0ujCYusYzL7+eH57on4hax3j2JlaM3jAQJ2XwZA4ys+ADZF5HyJ+kZleNCq8alw24EpqvEo0YpXPrsF2iPPG2fsDB/CPyJXS/eybjOspnr4tQd4ySzmMi1bv3v3xi3wgGoKEhAjITwW5gLsWd9J46FoXhNv6LoAz1cHUrlYaZhGZrIcnf6roTLKep4AhGcj24aqgXh2FMsmQS1m9smBAlqhvUaTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5539.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(86362001)(2906002)(110136005)(54906003)(316002)(5660300002)(7416002)(38100700002)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(83380400001)(6666004)(6512007)(6506007)(53546011)(36756003)(31696002)(6486002)(31686004)(186003)(2616005)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3JZRmpUekN1SkJsWmh1SnhXcmlVZU1BSFVmbVdGYk9nQW9lSDIxaFhJQzh1?=
 =?utf-8?B?ZDRCd1BKSE5UdlQ5N0J6UXVGakhHRVY2RnRrNEY4UG5vOFltd0cwcGJkSFY3?=
 =?utf-8?B?N2xCdjErajZqdmZZVExUMFhJQkFjU3JCMXBPZy9mdmRjQVcxMFdFVzRoeitI?=
 =?utf-8?B?cDYwekVSL0FxZXZVQWI2a2FOZUZxRmtRRnJTUit0NWpoaHY2N2Y1N0U4d1Nh?=
 =?utf-8?B?b2d1WHlZam9MSHdmY1ZHMzc3STN5YUVlM1Nmbm9MSjN6b29TR3pub0VtVkNJ?=
 =?utf-8?B?d1F5Y0pBdXNMVzZQUmtuR29RL2Q2bjFLOGM4T2FMT1ljdjcrMVFFc1hMejJQ?=
 =?utf-8?B?L1V5bTRzYzRaU3ZybnFPVUlidTVBZVNOZnJSZHcweGs2QUhpcVdQR1VETDVx?=
 =?utf-8?B?TWJHaitucmRLNG1zZTZQMTFhdU84NkRpZkVQR291MExqUzYrOUlCTWxGY2oz?=
 =?utf-8?B?TmxNS0h0SWxlS2tuNUxhNUhXUHkzVEVVcXdJbUNsVzJXQkkzcTBOc29uYWZo?=
 =?utf-8?B?ZzE3WVlMcUNPWlJ2bWJ1OUIzeFQ4WXMyS2NSekExazBLaXBBMmdGRVE3dW4r?=
 =?utf-8?B?bHB2MEFWaU5PbkJYYmwzRGhnbW45N2kySVZkdldFRW8vU2VzOW50TEtVRmNH?=
 =?utf-8?B?SG9RRWY0ZWxtSE5Tdk44Sm9pM0U2b1pVS09nZ0pseGZZU016eFhJaWlhc3BH?=
 =?utf-8?B?aUpPUzllM1VYdDlmSjc2aG9HaUlucm96UG9ONHlLWTl2WVd5dzF5RWF4V1d6?=
 =?utf-8?B?b1RYQ2ozZjF0UlZrcVZ5YjNIYlJNMUx4R1dBSGtKTWtlQklabnMvNnpaZGxy?=
 =?utf-8?B?SXk3Ty8vWHdPNFNHRlpDUDNZdWdpUzRqUFNCVHJCUytMeUFGR1dvbmtldnV5?=
 =?utf-8?B?aUlKOXhFV1MrQnJnZ1pZSzVEbFpvL3BOekhRTm1MMDFTL3M2TXlVSUp4WmlL?=
 =?utf-8?B?K2lERURWWnlKVDVkQm9TaS9HbzMzK1VQSlVUZWxUR2NQRXAwWXVLa3ZOTGxS?=
 =?utf-8?B?NEJpNzczQXFDM0hiUFVrRjVGaTdVOUJ0NHp6ckJ1NXRzRHV0b3NtMTNPd0lW?=
 =?utf-8?B?c3diczczWVltSnJ5L2UxNS9yVUxoWCtKa2pMNEl2QTJPTDlMTUNCZ0JiT1hv?=
 =?utf-8?B?RjBiL3JJdENQZFNKcFozWDhtaXl5d2FnU1dyWWpWbE9tcVQvS0kyWCtTUlFm?=
 =?utf-8?B?Y2pUNVp5L0xKeE1CeGVaTUhKa3BhZnhSOFFvYUw5SS9kQ3lJcEd5TG9WVzgw?=
 =?utf-8?B?d05rV1hkUFVkdkE0dWQvNGZmeHhKNDEwVWRUenRkYUZheFVGUXZzQ3RDTGNB?=
 =?utf-8?B?QUZ5M0VlTTB3dktBL2JqV3JZZ0FWREttZXFlbEdJQjNXSWZCSFVTWlpJcVBG?=
 =?utf-8?B?WnRxbWQvNi9sQkdSNTlZbXRGNFYzenFjUGR4R2ZDYmQzeGQ2WGdPRE1YeEJk?=
 =?utf-8?B?eTh4WnFQM1RsU3pocmt5a2czRC9ocThLcmlsaldndTNyTC9nZkJTM0pvVmQw?=
 =?utf-8?B?eGJ2SWVIT3RMMklvdVlmMWxXblBMcU1WWkFkS0NCNGV1YkNBYmtRampzb0NC?=
 =?utf-8?B?WkdybSs4MFI5Mkc3WG4xaEtMQk15bjhvSkcycWk2NmR2N1NxNGF2dnF3S2Jx?=
 =?utf-8?B?UDAzM3Uvd0g4NkFvMnNQTHFwSnJPa3gxUDV1eUxyVTNqMUw3ZWZ6MUN0M3FR?=
 =?utf-8?B?TEVCaWhUVThLU3BZUEgzaktDVlI2cHFwQStUZVZmRmxXWi9MNzhyRUxlOFdr?=
 =?utf-8?B?MzlIQkF2RUxXQkdtQ3gvZTdqL3NBZE5KOHdjWjJQbEFxUVJtZmJNS1htQk5x?=
 =?utf-8?B?ZGcvTEVTN3dWN2t2cHJnL01ydDNiYjNBZjhEdkoxZXhzbkdoSE16V2dWYnB6?=
 =?utf-8?B?WTQrUnk4WjhlNkY0cHJRTTRvdFhiOEVDZXVIQ1FGMHZ6ZVo0MHlxSDg1cnJx?=
 =?utf-8?B?aGM3NUJ0TjF0MnNMU093ZXl1V01DZndLUml0RUJjWGFqNDRhZUdSdXh5Zldj?=
 =?utf-8?B?ZUpCZHpDajEzV0dHZU9MSllqUEVsY1BwMWVXa2JEektOUHhsK2lSRTYycGtV?=
 =?utf-8?B?Wis3MFl2T2xRc0o5SHQ5WFcrK3Nxay9KT0prN1hhN1FDazVpZGVyMVhETlBJ?=
 =?utf-8?B?U1pZWFF6MEF2NXRBVU9rcXZSVmVlMERFWS9ZQm5FbGFnTXNidjZoN1RuYU0r?=
 =?utf-8?Q?/NoMsm6ZYVQocYU67mMHe2TVeSspbdBCNkqHBrJVVm9W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e764c-c983-46fb-7578-08d9e281ecd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4344.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 17:16:30.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0ORELQUP2BWBpddF6v2cC7japJs4HBnI7DadcYUFGuob8Q2OkYgMWqWqxwE3+KyVPYKZ/uw9uF1+oXDNysGRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2950
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/28/22 06:21, Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 05:25:52PM -0700, Logan Gunthorpe wrote:
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> ZONE_DEVICE struct pages have an extra reference count that complicates the
>> code for put_page() and several places in the kernel that need to check the
>> reference count to see that a page is not being used (gup, compaction,
>> migration, etc.). Clean up the code so the reference count doesn't need to
>> be treated specially for ZONE_DEVICE.
>>
>> [logang: dropped no longer used section from mm.h including
>>   page_is_devmap_managed, rebased on v5.17-rc1 (possibly poorly)]
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 +-
>>   drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>>   fs/dax.c                               |  4 +-
>>   include/linux/dax.h                    |  2 +-
>>   include/linux/memremap.h               |  7 +--
>>   include/linux/mm.h                     | 44 ----------------
>>   lib/test_hmm.c                         |  2 +-
>>   mm/internal.h                          |  8 +++
>>   mm/memcontrol.c                        |  6 +--
>>   mm/memremap.c                          | 70 +++++++-------------------
>>   mm/migrate.c                           |  5 --
>>   mm/page_alloc.c                        |  3 ++
>>   mm/swap.c                              | 45 ++---------------
>>   13 files changed, 46 insertions(+), 154 deletions(-)
> This patch still can't be applied until the FSDAX issues are solved,
> right? See my remarks the last time it was posted..
>
> Jason

That is my understanding too.

