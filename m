Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09FB1B0857
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDTLzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726893AbgDTLzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 07:55:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1967C061A0C;
        Mon, 20 Apr 2020 04:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=u/v02NGC1oFgel1iBcflEpVS3DgIiIJMM0PTdku3nhQ=; b=CZBJhyvq0qUv3KTenjC17+groE
        HnljLoftFJKoNw5UOVlCYJYof/UFLtQmL5/bX9LjqyUMTo4QRE86om9NvcRONyDDMnOGVceoX+gxR
        7skTn5ckWCZHYOoqhWpc3hd4V0HDNyIsFAeYa6bSvpq+bEiu36bK96SxuGk8hfmwqr6BmJyvF1Agl
        HpKhYqUL4S0RwC/jfr0C4LVaGSMhF+rV//Dtv4Y+Z4h74jcigb+DMo9NGcvEiyfLss4bI4oEpwBN3
        Xpok6CGILMN9GEeWX+JNL2XSTrGhDYNJ1ex2JKAcJsF3nBgda4YwkG6sQ2olGScYX1ORh8O6xszEf
        Esp1wo2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQV0y-0006P9-DC; Mon, 20 Apr 2020 11:55:04 +0000
Date:   Mon, 20 Apr 2020 04:55:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, zhangfei.gao@linaro.org,
        jgg@ziepe.ca, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420115504.GA20664@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 01:44:56PM +0200, Christian König wrote:
> Am 20.04.20 um 10:10 schrieb Christoph Hellwig:
> > On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> > > Right, I can see the appeal. I still like having a single mmu notifier per
> > > mm because it ensures we allocate a single PASID per mm (as required by
> > > x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
> > > to avoid iterating over all bonds during allocation.
> > Given that the PASID is a pretty generic and important concept can
> > we just add it directly to the mm_struct and allocate it lazily once
> > we first need it?
> 
> Well the problem is that the PASID might as well be device specific. E.g.
> some devices use 16bit PASIDs, some 15bit, some other only 12bit.
> 
> So what could (at least in theory) happen is that you need to allocate
> different PASIDs for the same process because different devices need one.

This directly contradicts the statement from Jean-Philippe above that
x86 requires a single PASID per mm_struct.  If we may need different
PASIDs for different devices and can actually support this just
allocating one per [device, mm_struct] would make most sense of me, as
it doesn't couple otherwise disjoint state.
