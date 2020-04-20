Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87901B1422
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgDTSPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 14:15:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:24125 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgDTSPW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 14:15:22 -0400
IronPort-SDR: veVE+vdBnwufb+p6R7TQvMejQbVC4DT6CRqiNEU/FduGh0PJ5xok/dzYFop3/nu9ARfOcx2z74
 HDZoR7wXw62w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 11:15:21 -0700
IronPort-SDR: 8fT09weErfTNfN3mfjnYSebk8Nn+HR58tGa0lnQIUlEHvLqz6923WibZ88j62ipIrGurCIktai
 4d4uQqkvArDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="246960869"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2020 11:15:21 -0700
Date:   Mon, 20 Apr 2020 11:14:37 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, zhangfei.gao@linaro.org,
        xuzaibo@huawei.com, "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420181437.GA229170@romley-ivt3.sc.intel.com>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
 <20200420135727.GO26002@ziepe.ca>
 <20200420104850.60531cb6@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420104850.60531cb6@jacob-builder>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 10:48:50AM -0700, Jacob Pan wrote:
> On Mon, 20 Apr 2020 10:57:27 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> > > On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:  
> > > > On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker
> > > > wrote:  
> > > > > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig
> > > > > wrote:  
> > > > > > > +	rcu_read_lock();
> > > > > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices,
> > > > > > > mm_node)
> > > > > > > +		io_mm->ops->invalidate(bond->sva.dev,
> > > > > > > io_mm->pasid, io_mm->ctx,
> > > > > > > +				       start, end - start);
> > > > > > > +	rcu_read_unlock();
> > > > > > > +}  
> > > > > > 
> > > > > > What is the reason that the devices don't register their own
> > > > > > notifiers? This kinds of multiplexing is always rather messy,
> > > > > > and you do it for all the methods.  
> > > > > 
> > > > > This sends TLB and ATC invalidations through the IOMMU, it
> > > > > doesn't go through device drivers  
> > > > 
> > > > I don't think we mean the same thing, probably because of my
> > > > rather imprecise use of the word device.
> > > > 
> > > > What I mean is that the mmu_notifier should not be embedded into
> > > > the io_mm structure (whch btw, seems to have a way to generic
> > > > name, just like all other io_* prefixed names), but instead into
> > > > the iommu_bond structure.  That avoid the whole multiplexing
> > > > layer.  
> > > 
> > > Right, I can see the appeal. I still like having a single mmu
> > > notifier per mm because it ensures we allocate a single PASID per
> > > mm (as required by x86). I suppose one alternative is to maintain a
> > > hashtable of mm->pasid, to avoid iterating over all bonds during
> > > allocation.  
> > 
> > I've been getting rid of hash tables like this.. Adding it to the
> > mm_struct does seem reasonable, I think PASID is a pretty broad
> > concept now.
> > 
> Agreed, perhaps Fenghua can consider that in his patchset. It would
> help align life cycles as well.
> https://lkml.org/lkml/2020/3/30/910>

Seems we depend on each other: my patch defines pasid in mm_struct.
I can free PASID in your detach() function.

Thanks.

-Fenghua
