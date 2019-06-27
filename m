Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB73587DF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0RBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 13:01:51 -0400
Received: from verein.lst.de ([213.95.11.210]:40323 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfF0RBv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 13:01:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4B57968C4E; Thu, 27 Jun 2019 18:53:49 +0200 (CEST)
Date:   Thu, 27 Jun 2019 18:53:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 12/25] memremap: add a migrate_to_ram method to struct
 dev_pagemap_ops
Message-ID: <20190627165349.GB10652@lst.de>
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-13-hch@lst.de> <20190627162439.GD9499@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627162439.GD9499@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 04:29:45PM +0000, Jason Gunthorpe wrote:
> I'ver heard there are some other use models for fault() here beyond
> migrate to ram, but we can rename it if we ever see them.

Well, it absolutely needs to migrate to some piece of addressable
and coherent memory, so ram might be a nice shortcut for that.

> > +static vm_fault_t hmm_devmem_migrate_to_ram(struct vm_fault *vmf)
> >  {
> > -	struct hmm_devmem *devmem = page->pgmap->data;
> > +	struct hmm_devmem *devmem = vmf->page->pgmap->data;
> >  
> > -	return devmem->ops->fault(devmem, vma, addr, page, flags, pmdp);
> > +	return devmem->ops->fault(devmem, vmf->vma, vmf->address, vmf->page,
> > +			vmf->flags, vmf->pmd);
> >  }
> 
> Next cycle we should probably rename this fault to migrate_to_ram as
> well and pass in the vmf..

That ->fault op goes away entirely in one of the next patches in the
series.
