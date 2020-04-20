Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048161B135C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDTRmz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 13:42:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:49434 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDTRmz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 13:42:55 -0400
IronPort-SDR: gz0hhQAtpr7Q9Pwvwx8b6bw8t63HUc9ftnAV+RMFWK/dZe37U8muwLLnlsila7TZ7+978Emxj0
 Ea8jjTkMvQdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:42:54 -0700
IronPort-SDR: eM/j/RrA0dBjUaYVKE+3++Tb85wNGqjGC5Sdurj8El2Xw1ycvBFzcuEk1vr5nmoJeb1Oix9ZJQ
 KqoHCv3cjXTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="246953658"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2020 10:42:53 -0700
Date:   Mon, 20 Apr 2020 10:48:50 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, zhangfei.gao@linaro.org,
        xuzaibo@huawei.com, jacob.jun.pan@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420104850.60531cb6@jacob-builder>
In-Reply-To: <20200420135727.GO26002@ziepe.ca>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
        <20200414170252.714402-3-jean-philippe@linaro.org>
        <20200416072852.GA32000@infradead.org>
        <20200416085402.GB1286150@myrica>
        <20200416121331.GA18661@infradead.org>
        <20200420074213.GA3180232@myrica>
        <20200420135727.GO26002@ziepe.ca>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 20 Apr 2020 10:57:27 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> > On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:  
> > > On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker
> > > wrote:  
> > > > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig
> > > > wrote:  
> > > > > > +	rcu_read_lock();
> > > > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices,
> > > > > > mm_node)
> > > > > > +		io_mm->ops->invalidate(bond->sva.dev,
> > > > > > io_mm->pasid, io_mm->ctx,
> > > > > > +				       start, end - start);
> > > > > > +	rcu_read_unlock();
> > > > > > +}  
> > > > > 
> > > > > What is the reason that the devices don't register their own
> > > > > notifiers? This kinds of multiplexing is always rather messy,
> > > > > and you do it for all the methods.  
> > > > 
> > > > This sends TLB and ATC invalidations through the IOMMU, it
> > > > doesn't go through device drivers  
> > > 
> > > I don't think we mean the same thing, probably because of my
> > > rather imprecise use of the word device.
> > > 
> > > What I mean is that the mmu_notifier should not be embedded into
> > > the io_mm structure (whch btw, seems to have a way to generic
> > > name, just like all other io_* prefixed names), but instead into
> > > the iommu_bond structure.  That avoid the whole multiplexing
> > > layer.  
> > 
> > Right, I can see the appeal. I still like having a single mmu
> > notifier per mm because it ensures we allocate a single PASID per
> > mm (as required by x86). I suppose one alternative is to maintain a
> > hashtable of mm->pasid, to avoid iterating over all bonds during
> > allocation.  
> 
> I've been getting rid of hash tables like this.. Adding it to the
> mm_struct does seem reasonable, I think PASID is a pretty broad
> concept now.
> 
Agreed, perhaps Fenghua can consider that in his patchset. It would
help align life cycles as well.
https://lkml.org/lkml/2020/3/30/910

> Jason

[Jacob Pan]
