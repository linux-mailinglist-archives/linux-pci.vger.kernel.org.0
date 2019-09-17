Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA7B4FE0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfIQOFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 10:05:43 -0400
Received: from foss.arm.com ([217.140.110.172]:56556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfIQOFn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 10:05:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E72028;
        Tue, 17 Sep 2019 07:05:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70FEA3F575;
        Tue, 17 Sep 2019 07:05:42 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:05:33 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Message-ID: <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
 <20190916135435.5017-3-jonathan.derrick@intel.com>
 <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
 <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 17, 2019 at 01:55:59PM +0000, Derrick, Jonathan wrote:
> On Tue, 2019-09-17 at 11:41 +0100, Lorenzo Pieralisi wrote:
> > On Mon, Sep 16, 2019 at 07:54:35AM -0600, Jon Derrick wrote:
> > > The shadow offset scratchpad was moved to 0x2000-0x2010. Update the
> > > location to get the correct shadow offset.
> > 
> > Hi Jon,
> > 
> > what does "was moved" mean ? Would this code still work on previous HW ?
> > 
> The previous code won't work on (not yet released) hw. Guests using the
> domain will see the wrong offset and enumerate the domain incorrectly.

That's true also for new kernels on _current_ hardware, isn't it ?

What I am saying is that there must be a way to detect the right
offset from HW probing or firmware otherwise things will break
one way of another.

> > We must make sure that the address move is managed seamlessly by the
> > kernel.
> If we need to avoid changing addressing within stable, then that's
> fine. But otherwise is there an issue merging with 5.4?

See above. Would 5.4 with this patch applied work on systems where
the offset is the same as the _current_ one without this patch
applied ?

> > For the time being I have to drop this fix and it is extremely
> > tight to get it in v5.4, I can't send stable changes that we may
> > have to revert.
> Aren't we in the beginning of the merge window?

Yes and that's the problem, patches for v5.4 should have already
being queued a while ago, I do not know when Bjorn will send the
PR for v5.4 but that's going to happen shortly, I am making an
exception to squeeze these patches in since it is vmd only code
but still it is very very tight.

Thanks,
Lorenzo

> > Thanks,
> > Lorenzo
> > 
> > > Cc: stable@vger.kernel.org # v5.2+
> > > Fixes: 6788958e ("PCI: vmd: Assign membar addresses from shadow registers")
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index 2e4da3f51d6b..a35d3f3996d7 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -31,6 +31,9 @@
> > >  #define PCI_REG_VMLOCK		0x70
> > >  #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
> > >  
> > > +#define MB2_SHADOW_OFFSET	0x2000
> > > +#define MB2_SHADOW_SIZE		16
> > > +
> > >  enum vmd_features {
> > >  	/*
> > >  	 * Device may contain registers which hint the physical location of the
> > > @@ -578,7 +581,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >  		u32 vmlock;
> > >  		int ret;
> > >  
> > > -		membar2_offset = 0x2018;
> > > +		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
> > >  		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
> > >  		if (ret || vmlock == ~0)
> > >  			return -ENODEV;
> > > @@ -590,9 +593,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > >  			if (!membar2)
> > >  				return -ENOMEM;
> > >  			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
> > > -						readq(membar2 + 0x2008);
> > > +					readq(membar2 + MB2_SHADOW_OFFSET);
> > >  			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
> > > -						readq(membar2 + 0x2010);
> > > +					readq(membar2 + MB2_SHADOW_OFFSET + 8);
> > >  			pci_iounmap(vmd->dev, membar2);
> > >  		}
> > >  	}
> > > -- 
> > > 2.20.1
> > > 
