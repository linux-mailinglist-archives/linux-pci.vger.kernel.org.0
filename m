Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6230F49FE6C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350315AbiA1Qwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 11:52:38 -0500
Received: from ale.deltatee.com ([204.191.154.188]:39510 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350321AbiA1Qwh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 11:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=TwdFNzdxDdgz+26v8ucb90p5GLD0CB3VYearw7eL4TE=; b=Jjmj+T8NaOnEcL6xfeeEEnDoy1
        Jwe8ThuF6gDiurLsgr0uGnv9DtwA/YJGSAnk4YZieWRprMNN1XZTwMxLvg1xLTfdEF5shDUo1oKVB
        dGm8uPC2nP7BeAAxYGpVDjN5PUUN2dF+lmH4w3GEZWrOcUdeidJ3eaZUbWN7mRLo4ueWSGNDBPHcA
        n16IZ9yCMCIyGHmi5gDa34nnEEktr//UIijZEjTEMKttvW/djXEMc19q3vTDkuYD11X80MS+G2fw6
        WeaxTsJGGnS1Qt8qyvAZPSnnzqFXDE1edRZ8gpanjHUFDkfU4ljqOz+DMGoVetIUcDrsOOBqJRnuy
        Yyx62grQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nDUTz-0068Ws-Uv; Fri, 28 Jan 2022 09:52:20 -0700
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
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-23-logang@deltatee.com> <20220128142251.GV8034@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ca5e74e-b02b-427f-cf7b-485f8153d689@deltatee.com>
Date:   Fri, 28 Jan 2022 09:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220128142251.GV8034@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,NICE_REPLY_A,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-01-28 7:22 a.m., Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 05:26:12PM -0700, Logan Gunthorpe wrote:
>> When P2PDMA pages are passed to userspace, they will need to be
>> reference counted properly and returned to their genalloc after their
>> reference count returns to 1. This is accomplished with the existing
> 
> It is reference count returns to 0 now, right?

Right, yes.

Thanks,

Logan
