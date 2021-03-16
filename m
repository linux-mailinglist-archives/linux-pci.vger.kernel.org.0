Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6333D893
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhCPQDB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 12:03:01 -0400
Received: from ale.deltatee.com ([204.191.154.188]:35412 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbhCPQCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 12:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=vqqIJKKtZ0Pg96LQ/1Z1q/KlFFpVkNAe+8aEWrs/hj4=; b=aLfuYJGuyB5Vf3NXBbVi7orqFM
        EDGLeXMnQdoQH9BV1vcMoXyuK9z93wWuPACR4VyTKSTtxBcCGLJv06fHAktuwiezT1YitAoW6wR1X
        HvT8pZhWTDbPTx4/Yx8zliILh8pVR2V/Q/NfhhuJH6rkKu0rh+ZWSfM71udHN10RroyIwvdLBmi/x
        JowULXwT9MOdkxVUpQ3witDiL5FZ4SD+ANuLnpzEKngB+XqRkzhMd/UwHnEqGWuGSt5KcVGSR2qz2
        Hoa0CJ4Ud/gwHBkjHMtsgrO77SVKESL0pH0xqOtjxAQukb1UQXUpq3zW9dr/Uu471yKxzBc7lV11d
        3TDfQv2Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lMC9R-0001Oz-Na; Tue, 16 Mar 2021 10:02:34 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-10-logang@deltatee.com> <20210316080051.GD15949@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <52a9e6e3-fc00-495a-69bb-26ff0b22775a@deltatee.com>
Date:   Tue, 16 Mar 2021 10:02:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316080051.GD15949@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 09/11] block: Add BLK_STS_P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-16 2:00 a.m., Christoph Hellwig wrote:
> On Thu, Mar 11, 2021 at 04:31:39PM -0700, Logan Gunthorpe wrote:
>> Create a specific error code for when P2PDMA pages are passed to a block
>> devices that cannot map them (due to no IOMMU support or ACS protections).
>>
>> This makes request errors in these cases more informative of as to what
>> caused the error.
> 
> I really don't think we should bother with a specific error code here,
> we don't add a new status for every single possible logic error in the
> caller.

I originally had BLK_STS_IOERR but those errors suggested to people that
the hardware had failed on the request when in fact it was a user error.
I'll try BLK_STS_TARGET unless there's any objection or someone thinks
another error code would make more sense.

Logan
