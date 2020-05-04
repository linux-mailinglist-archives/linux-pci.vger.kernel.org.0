Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07E81C3E5C
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgEDPU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 11:20:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:65017 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgEDPU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 11:20:59 -0400
IronPort-SDR: +pz4vvpzKslHP5KDw38Y9OyB8eRHj2A39JwaN4t3cozLB1F62sha+i2tyxS7SPCJENMLwAHvEs
 048ayvfbTQTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 08:20:59 -0700
IronPort-SDR: DhyAxpzPRY/Tebzamw5nV/OXd83VAZRNIf4QKSKn9BLW4Q4E1kjVLjHW+nXqmurbxOZK0rot2h
 utpob8xZoQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="460700180"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 08:20:58 -0700
Date:   Mon, 4 May 2020 08:27:03 -0700
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
Message-ID: <20200504082703.2ecc03c1@jacob-builder>
In-Reply-To: <20200504142548.GB170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
        <20200430143424.2787566-3-jean-philippe@linaro.org>
        <20200430113931.0fbf7a37@jacob-builder>
        <20200504142548.GB170104@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 4 May 2020 16:25:48 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Apr 30, 2020 at 11:39:31AM -0700, Jacob Pan wrote:
> > > +/**
> > > + * ioasid_get - obtain a reference to the IOASID
> > > + */
> > > +void ioasid_get(ioasid_t ioasid)  
> > why void? what if the ioasid is not valid.  
> 
> My intended use was for the caller to get an additional reference when
> they're already holding one. So this should always succeed and I'd
> prefer a WARN_ON if the ioasid isn't valid rather than returning an
> error. But if you intend to add a state to ioasids between dropping
> refcount and free, then a return value makes sense.
> 
Yes, a WARN_ON will do. No need for return value for now.

> Thanks,
> Jean
> 
> >   
> > > +{
> > > +	struct ioasid_data *ioasid_data;
> > > +
> > > +	spin_lock(&ioasid_allocator_lock);
> > > +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > > +	if (ioasid_data)
> > > +		refcount_inc(&ioasid_data->refs);
> > > +	spin_unlock(&ioasid_allocator_lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(ioasid_get);
> > > +
> > >  /**
> > >   * ioasid_free - Free an IOASID
> > >   * @ioasid: the ID to remove
> > > + *
> > > + * Put a reference to the IOASID, free it when the number of
> > > references drops to
> > > + * zero.
> > > + *
> > > + * Return: %true if the IOASID was freed, %false otherwise.
> > >   */
> > > -void ioasid_free(ioasid_t ioasid)
> > > +bool ioasid_free(ioasid_t ioasid)
> > >  {
> > > +	bool free = false;
> > >  	struct ioasid_data *ioasid_data;
> > >  
> > >  	spin_lock(&ioasid_allocator_lock);
> > > @@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
> > >  		goto exit_unlock;
> > >  	}
> > >  
> > > +	free = refcount_dec_and_test(&ioasid_data->refs);
> > > +	if (!free)
> > > +		goto exit_unlock;
> > > +  
> > Just FYI, we may need to add states for the IOASID, i.g. mark the
> > IOASID inactive after free. And prohibit ioasid_get() after freed.
> > For VT-d, this is useful when KVM queries the IOASID.
> >   
> > >  	active_allocator->ops->free(ioasid,
> > > active_allocator->ops->pdata); /* Custom allocator needs
> > > additional steps to free the xa element */ if
> > > (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) { @@ -369,6
> > > +396,7 @@ void ioasid_free(ioasid_t ioasid) 
> > >  exit_unlock:
> > >  	spin_unlock(&ioasid_allocator_lock);
> > > +	return free;
> > >  }
> > >  EXPORT_SYMBOL_GPL(ioasid_free);
> > >    
> > 
> > [Jacob Pan]  

[Jacob Pan]
