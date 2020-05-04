Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA631C3E4E
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgEDPQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 11:16:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:13492 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgEDPQv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 11:16:51 -0400
IronPort-SDR: ThhQkoA9DM+IK0u2CaRztYCz002y6ksx8kEym5QWpEP/jlvgjwJrJkuudt9V0oi1zqmHrQrcQf
 B2e0ow154bQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 08:16:50 -0700
IronPort-SDR: lbqFDd9ohl9UbGCAK3Z4qWu4DHUOOqZWdbnTKo7EqSLIl5b7BXj9EsadFkTvIWkTXLcabMfBey
 htWBEGm4tgiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="295526651"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 04 May 2020 08:16:49 -0700
Date:   Mon, 4 May 2020 08:22:54 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504082254.58fc6365@jacob-builder>
In-Reply-To: <20200504143932.GC170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
        <20200430143424.2787566-3-jean-philippe@linaro.org>
        <20200430113931.0fbf7a37@jacob-builder>
        <20200430134842.74e596b8@jacob-builder>
        <20200504143932.GC170104@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 May 2020 16:39:32 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Apr 30, 2020 at 01:48:42PM -0700, Jacob Pan wrote:
> > On Thu, 30 Apr 2020 11:39:31 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > > -void ioasid_free(ioasid_t ioasid)
> > > > +bool ioasid_free(ioasid_t ioasid)
> > > >  {  
> > Sorry I missed this in the last reply.
> > 
> > I think free needs to be unconditional since there is not a good
> > way to fail it.
> > 
> > Also can we have more symmetric APIs, seems we don't have
> > ioasid_put() in this patchset.  
> 
> Yes I was thinking of renaming ioasid_free() to ioasid_put() but got
> lazy. 
> 
> > How about?
> > ioasid_alloc()
> > ioasid_free(); //drop reference, mark inactive, but not reclaimed if
> > 		refcount is not zero.
> > ioasid_get() // returns err if the ioasid is marked inactive by
> > 		ioasid_free()  
> 
> How does the caller know that the ioasid is in active/inactive state,
> and not freed/reallocated?
> 
In inactive state, callers of ioasid_find(), ioasid_get() would all
fail. Only ioasid_put can still operate on it.

In freed state (i.e. not allocated), it will be the same as above with
the exception that ioasid_put has no effect.

> > ioasid_put();// drop reference, reclaim if refcount is 0.  
> 
> I'll add ioasid_put() for now. I'd like to avoid introducing the
> inactive state in this patch,
Sounds good. I just wanted to consult with you about the above APIs. I
will introduce the state when we have a real use.

> so shall I change the calls in the
> Intel driver to ioasid_put(), and not introduce a new ioasid_free()
> for the moment?
> 
Sounds good. 

> Thanks,
> Jean
> 

[Jacob Pan]
