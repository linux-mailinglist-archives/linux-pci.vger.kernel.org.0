Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E6371F69
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhECSS3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:18:29 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:48849
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhECSS3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9ih7UiYAku1hwiRzFYusEHnrjOhPZhxacOq7hV9c/s/PsvgrgkuoMzdA2wTh2Eqr4fmUevcKj98QKAgmAIVd8bYTH7CMVQSSZdi6OMn2569MgGTr4Qiz6VkO/ATbwCUI6n4odRtM4Ix/LUZ727qR2Gw0iuBr6Nr2Aj8BCN7VOlf0jxRYSLB449Ahx45+rt/9UMCRd1p/NvcNmrhXtCY1rJ2vUnFMVYGZRblxP1BXkOVTdCqdwHOTgYoKimRVT/NHUb6NKoMXx6p3L1+1BZa+ElN9vDUw8uceewctyeTorchJnWOGIv9pj9IfA5croTNMLHI6QWAqD2NS9i0wCyIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhdsM6ptptZjDHTPQp+0BXC6o9D8azUBX2/CIw9ghjs=;
 b=WUH7vjfjg2ip+eR7/3PUyfV+J8Assb9XbUWvwvtl7Zoov60KG+aH3bkq0JD5ybJQYbpZzLRkKI+2Gm//rrroAD8CDJGfIZ1G+LhmulFmIZQAg2xgNOyce0YqBsh5k1f/v1sKS3uUy3HSET2zxw0nCHdl/sRj/nacpSdbXPoG4hMOslw54VdsaLuoDC42NLZvaZq+7MHqJdbD3MI8EslpTKhXY+Agb4FCUJw1E6ZD2Ye7qdziAgh47mTu60sTjitKLNS1ow8gy2Rt0CA/VY1yD+CK/Eo5+px1IhLwPHw5AeG5INQ8JntcEn3suxAmW7es4405psUpVetyhbvXKnSRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhdsM6ptptZjDHTPQp+0BXC6o9D8azUBX2/CIw9ghjs=;
 b=majOZlYYN6+zR5Vi2YPxtrWQznGboCVZaLL0lbI8Pp2ouYk/352pDsCK38HNVl/XKK4p0TB+KB8L+C20DCjqk2/AAKALDSbsdou5NQX9BCZsVNg8OmiKrzYl1LdIEPo9d5XltuqZPPszhFoaZCwoAvgJQIdcSfoD+pEH7vWJ8CT0+Y3RwbIWJGYzQLMiPFiG7BEEXHNXT8NC55OHTxOz8e7TUyeL0v7vhK/iDNl2JG/TIu4/w9I24FlwOYzrWffXFMeT7heDYpmSRIOr7GzwVKtRccGJOyDLB1+cB5ufoQEjqG5HUy5veVhcEzapTt3MZltJ3Pcxk3w2copkSUqd6g==
Received: from DM5PR13CA0058.namprd13.prod.outlook.com (2603:10b6:3:117::20)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 18:17:33 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::c6) by DM5PR13CA0058.outlook.office365.com
 (2603:10b6:3:117::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Mon, 3 May 2021 18:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Mon, 3 May 2021 18:17:32 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:17:31 +0000
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
Date:   Mon, 3 May 2021 11:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667131e9-b486-446f-90c4-08d90e5fb869
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4429CA1B7774ECE5A728EE98A85B9@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOxYYyZSSup6bE1XnbFwRgJwT+skUiNLjReGl0n+fKYmHVLCstxZCAqJvgjoqFyX4t4EMkDfSNPXdIaztt6KArkzTUv87mJcCPvy/3U01GDI3CwNL4XR7kivPlAKwqPBjma3eBqlG8fQevrdyk93O2Tu99MxS5rYKJFTS7su4vCH/1Uy4ndzdKUVE8HXRBZlXGfIX3fmgGOdLZiM9SAAARjdFW4RTel5LqMIBNeYqs0E48ModUQBLop3liI5LEqM/hEQ/LpII+Nu58lu2ZJ4U62oZMz7GYUk7/rMJ//9AD0yAA6C4jHNdKiU0met7RXEyTxK8z5vDkDhtRD+BPPcilMNwwbMkYvbYhVu+v9Xyl7B3x77ffnVu/4ATP1qpr+w6ksTqHbmSHohoDfCruxI8l4f2c6nmwcfetgqhUUniodF2PZnJYXRXbAUp7+Vz/CKx9SsmrNFlIitaDATEc5OssIeLwgEintkK0G8TWL8yRovT6K2tXcBwQI5E4bBimm8DT5JZt1J1/jJoN+NieZVVgfF8AZsEHa8F6VmrzhtSiMtP5Z2RG9f+QZM9SrfI6lLckEbtIVZdsWlupQvl/4CSgRA2m41chgmNUgtb7nx0sphjoSXs5Hs9VD/aZY2L2Q3qQa+wvgyKr36vYYlKd2KkABuB2Wkea1ciDLsCrMbbELBuAamfLofInxhAqKLxyhnt9ocD7BqHskKubgGLqkQ7Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(53546011)(31686004)(70206006)(36756003)(2906002)(5660300002)(82310400003)(4326008)(83380400001)(70586007)(478600001)(7416002)(16526019)(336012)(186003)(426003)(26005)(36860700001)(356005)(86362001)(8676002)(54906003)(2616005)(316002)(47076005)(31696002)(16576012)(82740400003)(8936002)(7636003)(36906005)(110136005)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:17:32.7214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667131e9-b486-446f-90c4-08d90e5fb869
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 8:57 AM, Logan Gunthorpe wrote:
> 
> 
> On 2021-05-01 9:58 p.m., John Hubbard wrote:
>> Another odd thing: this used to check for memory failure and just give
>> up, and now it doesn't. Yes, I realize that it all still works at the
>> moment, but this is quirky and we shouldn't stop here.
>>
>> Instead, a cleaner approach would be to push the memory allocation
>> slightly higher up the call stack, out to the
>> pci_p2pdma_distance_many(). So pci_p2pdma_distance_many() should make
>> the kmalloc() call, and fail out if it can't get a page for the seq_buf
>> buffer. Then you don't have to do all this odd stuff.
> 
> I don't really agree with this assessment. If kmalloc fails to
> initialize the seq_buf() (which should be very rare), the only thing
> that is lost is the one warning print that tells the user the command
> line parameter needed disable the ACS. Everything else works fine,
> nothing else can fail. I don't see the need to add extra complexity just
> so the code errors out in no-mem instead of just skipping the one,
> slightly more informative, warning line.

That's the thing: memory failure should be exceedingly rare for this.
Therefore, just fail out entirely (which I don't expect we'll likely
ever see), instead of doing all this weird stuff to try to continue
on if you cannot allocate a single page. If you are in that case, the
system is not in a state that is going to run your dma p2p setup well
anyway.

I think it's *less* complexity to allocate up front, fail early if
allocation fails, and then not have to deal with these really odd
quirks at the lower levels.

> 
> Also, keep in mind the result of all these functions are cached so it
> only ever happens once. So for this to matter, the user would have to do
> their first transaction between two devices exactly at the time memory
> allocations would fail.
> 
> 
>> Furthermore, the call sites can then decide for themselves which GFP
>> flags, GFP_ATOMIC or GFP_KERNEL or whatever they want for kmalloc().
>>
>> A related thing: this whole exercise would go better if there were a
>> preparatory patch or two that changed the return codes in this file to
>> something less crazy. There are too many functions that can fail, but
>> are treated as if they sort-of-mostly-would-never-fail, in the hopes of
>> using the return value directly for counting and such. This is badly
>> mistaken, and it leads developers to try to avoid returning -ENOMEM
>> (which is what we need here).
> 
> Hmm? Which functions can fail? and how?
> 

Let's defer that to the other patches, I was sort of looking ahead to
those, sorry.

thanks,
-- 
John Hubbard
NVIDIA
