Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E855249FE68
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 17:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350295AbiA1Qw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 11:52:26 -0500
Received: from ale.deltatee.com ([204.191.154.188]:39474 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245532AbiA1Qw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 11:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=b3irqWqF076Mlc+LOntCm6p6KSLN91UqQqA+8Wh01Qc=; b=NHvfIEhF0/ixtc4kadk8afYyfv
        EmK2moGf6H0lAvy8u0DbEMxKPWG6tkBbObYC2jdqi1BKFMztCPS/5/jPCS4dmimuj6Ls4WHvjpUke
        sg5zypcVuYlHzobtsvL/RaLwz6aXglMWIrfa47RaTf943xxLqnVdzYhdrL9aPCKHh3Zqzr42Ccqmv
        m/ilLAMU7wkZ+KQldW2wmsfHg9AWOPN/WUzRFymSWJgUyuysY7Vw3jMQ+svdQK9bVuCk8VNgfYJWn
        s3uSXiff2qj52lDsdz+bmYd1jd/3Bpiysle+0j0eVgxMIjayh+GpH1awjFx1fNx2dCE4civRe8Pl3
        A5rYWRhw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nDUTZ-0068W2-0N; Fri, 28 Jan 2022 09:51:54 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-3-logang@deltatee.com> <20220128142138.GU8034@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <11f86dfe-cd3b-e807-8546-bffb3a0b2d1d@deltatee.com>
Date:   Fri, 28 Jan 2022 09:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220128142138.GU8034@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: alex.sierra@amd.com, rcampbell@nvidia.com, ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v5 02/24] mm: remove extra ZONE_DEVICE struct page
 refcount
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-01-28 7:21 a.m., Jason Gunthorpe wrote:
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
>>  page_is_devmap_managed, rebased on v5.17-rc1 (possibly poorly)]
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 +-
>>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>>  fs/dax.c                               |  4 +-
>>  include/linux/dax.h                    |  2 +-
>>  include/linux/memremap.h               |  7 +--
>>  include/linux/mm.h                     | 44 ----------------
>>  lib/test_hmm.c                         |  2 +-
>>  mm/internal.h                          |  8 +++
>>  mm/memcontrol.c                        |  6 +--
>>  mm/memremap.c                          | 70 +++++++-------------------
>>  mm/migrate.c                           |  5 --
>>  mm/page_alloc.c                        |  3 ++
>>  mm/swap.c                              | 45 ++---------------
>>  13 files changed, 46 insertions(+), 154 deletions(-)
> 
> This patch still can't be applied until the FSDAX issues are solved,
> right? See my remarks the last time it was posted..

Yes. As I mentioned in the cover, this is just to show that this
patchset is compatible with the direction this patch goes.

Logan
