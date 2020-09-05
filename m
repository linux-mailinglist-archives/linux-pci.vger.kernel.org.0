Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB425E50D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Sep 2020 04:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIECXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 22:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgIECXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 22:23:10 -0400
Received: from localhost (227.sub-72-105-116.myvzw.com [72.105.116.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A031320791;
        Sat,  5 Sep 2020 02:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599272589;
        bh=WCtm2UmWU8qgNv7O8zpLAkulc+vdzdX4jMDuCdvk39A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SD0bpRN6tARd1pDUKMSKmPspzn3fxzd0jM68ayzWXm55F8pkSrVRTSUb+MkDV2zB5
         KhukNGi3SbTN6a+qJphtI6Uo5SZXMf83/MIFfCw808Qvu7JwYZRhtAUEBayaj0Z7Ev
         0n+ycxS7PAlmyychENEWArkBr41fFn3U57/U77pA=
Date:   Fri, 4 Sep 2020 21:23:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Message-ID: <20200905022308.GA379055@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1885fcb2dd5f174c8e5f94d1fd31f389776807.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 10:18:30PM +0000, Kelley, Sean V wrote:
> Hi Bjorn,
> 
> Quick question below...
> 
> On Wed, 2020-09-02 at 14:55 -0700, Sean V Kelley wrote:
> > Hi Bjorn,
> > 
> > On Wed, 2020-09-02 at 14:00 -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 12, 2020 at 09:46:53AM -0700, Sean V Kelley wrote:
> > > > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > > 
> > > > When an RCEC device signals error(s) to a CPU core, the CPU core
> > > > needs to walk all the RCiEPs associated with that RCEC to check
> > > > errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> > > > associated with the RCEC device.
> > > > 
> > > > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  drivers/pci/pci.h       |  4 +++
> > > >  drivers/pci/pcie/rcec.c | 76
> > > > +++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 80 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index bd25e6047b54..8bd7528d6977 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct
> > > > pci_dev
> > > > *pdev) {}
> > > >  #ifdef CONFIG_PCIEPORTBUS
> > > >  void pci_rcec_init(struct pci_dev *dev);
> > > >  void pci_rcec_exit(struct pci_dev *dev);
> > > > +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct
> > > > pci_dev
> > > > *, void *),
> > > > +		    void *userdata);
> > > >  #else
> > > >  static inline void pci_rcec_init(struct pci_dev *dev) {}
> > > >  static inline void pci_rcec_exit(struct pci_dev *dev) {}
> > > > +static inline void pcie_walk_rcec(struct pci_dev *rcec, int
> > > > (*cb)(struct pci_dev *, void *),
> > > > +				  void *userdata) {}
> > > >  #endif
> > > >  
> > > >  #ifdef CONFIG_PCI_ATS
> > > > diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> > > > index 519ae086ff41..405f92fcdf7f 100644
> > > > --- a/drivers/pci/pcie/rcec.c
> > > > +++ b/drivers/pci/pcie/rcec.c
> > > > @@ -17,6 +17,82 @@
> > > >  
> > > >  #include "../pci.h"
> > > >  
> > > > +static int pcie_walk_rciep_devfn(struct pci_bus *bus, int
> > > > (*cb)(struct pci_dev *, void *),
> > > > +				 void *userdata, const unsigned long
> > > > bitmap)
> > > > +{
> > > > +	unsigned int devn, fn;
> > > > +	struct pci_dev *dev;
> > > > +	int retval;
> > > > +
> > > > +	for_each_set_bit(devn, &bitmap, 32) {
> > > > +		for (fn = 0; fn < 8; fn++) {
> > > > +			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));
> > > 
> > > Wow, this is a lot of churning to call pci_get_slot() 256 times per
> > > bus for the "associated bus numbers" case where we pass a bitmap of
> > > 0xffffffff.  They didn't really make it easy for software when they
> > > added the next/last bus number thing.
> > > 
> > > Just thinking out loud here.  What if we could set dev->rcec during
> > > enumeration, and then use that to build pcie_walk_rcec()?
> > 
> > I think follow what you are doing.
> > 
> > As we enumerate an RCEC, use the time to discover RCiEPs and
> > associate
> > each RCiEP's dev->rcec. Although BIOS already set the bitmap for this
> > specific RCEC, it's more efficient to simply discover the devices
> > through the bus walk and verify each one found against the bitmap. 
> > 
> > Further, while we can be certain that an RCiEP found with a matching
> > device no. in a bitmap for an associated RCEC is correct, we cannot
> > be
> > certain that any RCiEP found on another bus range is correct unless
> > we
> > verify the bus is within that next/last bus range. 
> > 
> > Finally, that's where find_rcec() callback for rcec_assoc_rciep()
> > does
> > double duty by also checking on the "on-a-separate-bus" case captured
> > potentially by find_rcec() during an RCiEP's bus walk.
> > 
> >  
> > >   bool rcec_assoc_rciep(rcec, rciep)
> > >   {
> > >     if (rcec->bus == rciep->bus)
> > >       return (rcec->bitmap contains rciep->devfn);
> > > 
> > >     return (rcec->next/last contains rciep->bus);
> > >   }
> > > 
> > >   link_rcec(dev, data)
> > >   {
> > >     struct pci_dev *rcec = data;
> > > 
> > >     if ((dev is RCiEP) && rcec_assoc_rciep(rcec, dev))
> > >       dev->rcec = rcec;
> > >   }
> > > 
> > >   find_rcec(dev, data)
> > >   {
> > >     struct pci_dev *rciep = data;
> > > 
> > >     if ((dev is RCEC) && rcec_assoc_rciep(dev, rciep))
> > >       rciep->rcec = dev;
> > >   }
> > > 
> > >   pci_setup_device
> > >     ...
> 
> I just noticed your use of pci_setup_device(). Are you suggesting
> moving the call to pci_rcec_init() out of pci_init_capabilities() and
> move it into pci_setup_device()?  If so, would pci_rcec_exit() still
> remain in pci_release_capabilities()?
> 
> I'm just wondering if it could just remain in pci_init_capabilities().

Yeah, I didn't mean in pci_setup_device() specifically, just somewhere
in the callchain of pci_setup_device().  But you're right, it probably
would make more sense in pci_init_capabilities(), so I *should* have
said pci_scan_single_device() to be a little less specific.

Bjorn
