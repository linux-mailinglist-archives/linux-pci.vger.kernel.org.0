Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36E1AC0D5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 14:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635068AbgDPMNk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635002AbgDPMNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 08:13:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB8C061A0C;
        Thu, 16 Apr 2020 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hp6+eCj2O2nxWa/wGv8G7WCsIo0VMT1PsA9CYyFBw9A=; b=uPEh7nQY1JKkhF8C0Y4y2Gmad+
        0Lh9YxbB3n3bpZKSCTfe6apdDsHEJQ8+1fnAfMJYOQ7Ql+RYgwCiCPEay95+4hAhiUPJevlzeX1fJ
        juawpIUiGFu5mfa45bPWKqLkW/n9s5rroA3MynnjLIq7Qat6n1jaBQx75J3NNZelUA4YrqkUuGVcz
        H4Y2Zaeu42mCsHRkgGXpP+lVm6OKcx1KkTmiiHaNW3oV6yz92qPAmnFt+DrohrYDUCVX35t3XPvgO
        I1F0/d5RJPxCiBLE4f1cc1WmYObAzPqAFWgla4SAq3SvBWHFY87AaCOmi+Lt3b0XoTejUhCJEzA40
        t2381FKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP3Oe-0002ua-05; Thu, 16 Apr 2020 12:13:32 +0000
Date:   Thu, 16 Apr 2020 05:13:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200416121331.GA18661@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416085402.GB1286150@myrica>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > > +	rcu_read_lock();
> > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > > +				       start, end - start);
> > > +	rcu_read_unlock();
> > > +}
> > 
> > What is the reason that the devices don't register their own notifiers?
> > This kinds of multiplexing is always rather messy, and you do it for
> > all the methods.
> 
> This sends TLB and ATC invalidations through the IOMMU, it doesn't go
> through device drivers

I don't think we mean the same thing, probably because of my rather
imprecise use of the word device.

What I mean is that the mmu_notifier should not be embedded into the
io_mm structure (whch btw, seems to have a way to generic name, just
like all other io_* prefixed names), but instead into the
iommu_bond structure.  That avoid the whole multiplexing layer.
