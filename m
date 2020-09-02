Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDB25B631
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBVzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVzu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 17:55:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D5C061244
        for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2020 14:55:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u13so417188pgh.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2020 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LXiY5kS1Y9MQnVOqRh0ScGfWORVrrq9QSAIIDWzHNxg=;
        b=Rwj440buyjtJKQBlKQGKQVr7arRWqlyOs0VOlaUMAyBPxUgYNaON2DXFG84YN/AEHx
         lhnNnsnizA308AoSyQj1+NYkMi0FatnQNoCsMAg7kAPWoVfeaBkT1sNTK1pb6bkgm1zs
         BpIBr4dPgVV4XHLKsdfJ7Nm8qyDivzZ8UBil/RwpVxTEvHI98gM5TGnbKDY1ZmIccSF9
         jfGId8A38s6cwuyaz3Tw02b0dLbKyGD2MSmMtICpPnyQLq8nPWncRhsy2EsmRM3pNtBc
         wS2IcOYfmvnQuCb0sPYCDbztP7sG9USZmg3fLr+I39taXrx9sb4E3r7BmgoYjUqjEhRW
         SIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LXiY5kS1Y9MQnVOqRh0ScGfWORVrrq9QSAIIDWzHNxg=;
        b=COWWiVoet/ILpTDO0VRjAGgOrYfCx3ijdvOBXqN0tPbddfXb7BmRzk3HfzjzoMAsAq
         RxjXhs6ryPOfgAhQsN1hIpIWmhMBSYrq7uzEjI0H9L+WHXr+2h/huxoCT872BPFk0SSj
         1IzxrokLi6+QExghqVf7xNuvzFqhDSkiN8caf0gqb5a6qwR2xKlfmthaISzGn2pFzkMw
         /PR445DzCpSPzpn3VzuFXaUCZQaxVBgHbpWP61m6JIH3ssXkwsEH/htSEMPK73Gq5j8R
         KpQZdKnS2GTE8hTEgbGiQTVKnfn+nfeBOrMZg482PDquJgNxZGJOe0Ez9FaqS6RWCRA0
         FbgA==
X-Gm-Message-State: AOAM533A+tz4AbnG+pcUc3gueB/c5rhxSKIw1ZclztCimpbg5P036Fe0
        t72a3UjkWa3hacjjN9tRcX+tWg==
X-Google-Smtp-Source: ABdhPJzzDtHomdpi0SeCtj0I7kLSHCEWQcu9xH6WnaWo2vE3KMOFP6wunvWgiKleJLDx5C6hyFQBbw==
X-Received: by 2002:a05:6a00:1344:: with SMTP id k4mr434236pfu.131.1599083749528;
        Wed, 02 Sep 2020 14:55:49 -0700 (PDT)
Received: from arch-ashland-svkelley ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id v18sm527270pfu.15.2020.09.02.14.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 14:55:48 -0700 (PDT)
Message-ID: <0e5fc6cb29c22497e23ce5574ba613129a6a415b.camel@intel.com>
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 14:55:08 -0700
In-Reply-To: <20200902190000.GA204399@bjorn-Precision-5520>
References: <20200902190000.GA204399@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, 2020-09-02 at 14:00 -0500, Bjorn Helgaas wrote:
> On Wed, Aug 12, 2020 at 09:46:53AM -0700, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > When an RCEC device signals error(s) to a CPU core, the CPU core
> > needs to walk all the RCiEPs associated with that RCEC to check
> > errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> > associated with the RCEC device.
> > 
> > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/pci.h       |  4 +++
> >  drivers/pci/pcie/rcec.c | 76
> > +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index bd25e6047b54..8bd7528d6977 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct pci_dev
> > *pdev) {}
> >  #ifdef CONFIG_PCIEPORTBUS
> >  void pci_rcec_init(struct pci_dev *dev);
> >  void pci_rcec_exit(struct pci_dev *dev);
> > +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev
> > *, void *),
> > +		    void *userdata);
> >  #else
> >  static inline void pci_rcec_init(struct pci_dev *dev) {}
> >  static inline void pci_rcec_exit(struct pci_dev *dev) {}
> > +static inline void pcie_walk_rcec(struct pci_dev *rcec, int
> > (*cb)(struct pci_dev *, void *),
> > +				  void *userdata) {}
> >  #endif
> >  
> >  #ifdef CONFIG_PCI_ATS
> > diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> > index 519ae086ff41..405f92fcdf7f 100644
> > --- a/drivers/pci/pcie/rcec.c
> > +++ b/drivers/pci/pcie/rcec.c
> > @@ -17,6 +17,82 @@
> >  
> >  #include "../pci.h"
> >  
> > +static int pcie_walk_rciep_devfn(struct pci_bus *bus, int
> > (*cb)(struct pci_dev *, void *),
> > +				 void *userdata, const unsigned long
> > bitmap)
> > +{
> > +	unsigned int devn, fn;
> > +	struct pci_dev *dev;
> > +	int retval;
> > +
> > +	for_each_set_bit(devn, &bitmap, 32) {
> > +		for (fn = 0; fn < 8; fn++) {
> > +			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));
> 
> Wow, this is a lot of churning to call pci_get_slot() 256 times per
> bus for the "associated bus numbers" case where we pass a bitmap of
> 0xffffffff.  They didn't really make it easy for software when they
> added the next/last bus number thing.
> 
> Just thinking out loud here.  What if we could set dev->rcec during
> enumeration, and then use that to build pcie_walk_rcec()?


I think follow what you are doing.

As we enumerate an RCEC, use the time to discover RCiEPs and associate
each RCiEP's dev->rcec. Although BIOS already set the bitmap for this
specific RCEC, it's more efficient to simply discover the devices
through the bus walk and verify each one found against the bitmap. 

Further, while we can be certain that an RCiEP found with a matching
device no. in a bitmap for an associated RCEC is correct, we cannot be
certain that any RCiEP found on another bus range is correct unless we
verify the bus is within that next/last bus range. 

Finally, that's where find_rcec() callback for rcec_assoc_rciep() does
double duty by also checking on the "on-a-separate-bus" case captured
potentially by find_rcec() during an RCiEP's bus walk.

 
> 
>   bool rcec_assoc_rciep(rcec, rciep)
>   {
>     if (rcec->bus == rciep->bus)
>       return (rcec->bitmap contains rciep->devfn);
> 
>     return (rcec->next/last contains rciep->bus);
>   }
> 
>   link_rcec(dev, data)
>   {
>     struct pci_dev *rcec = data;
> 
>     if ((dev is RCiEP) && rcec_assoc_rciep(rcec, dev))
>       dev->rcec = rcec;
>   }
> 
>   find_rcec(dev, data)
>   {
>     struct pci_dev *rciep = data;
> 
>     if ((dev is RCEC) && rcec_assoc_rciep(dev, rciep))
>       rciep->rcec = dev;
>   }
> 
>   pci_setup_device
>     ...
>       if (dev is RCEC) {
> 	pci_rcec_init(dev)		# cache bitmap, next/last bus
> #
> 	pci_walk_bus(root_bus, link_rcec, dev); # link any RCiEP
> already found
>       }
>       if (dev is RCiEP) {
> 	pci_walk_bus(root_bus, find_rcec, dev); # link any RCEC already
> found
>       }
> 
> Now we should have a valid dev->rcec for everything we've enumerated.
> 
>   struct walk_rcec_data {
>     struct pci_dev *rcec;
>     ... user_callback;
>     void *user_data;
>   };
> 
>   pcie_rcec_helper(dev, callback, data)
>   {
>     struct walk_rcec_data *rcec_data = data;
> 
>     if (dev->rcec == rcec_data->rcec)
>       rcec_data->user_callback(dev, rcec_data->user_data);
>   }
> 
>   pcie_walk_rcec(rcec, callback, data)
>   {
>     struct walk_rcec_data rcec_data;
>     ...
>     rcec_data.rcec = rcec;
>     rcec_data.user_callback = callback;
>     rcec_data.user_data = data;
>     pci_walk_bus(root_bus, pcie_rcec_helper, &rcec_data);
>   }
> 
> I hate having to walk the bus so many times, but I do like the fact
> that in the runtime path (pcie_walk_rcec()) we don't have to do 256
> pci_get_slot() calls per bus, almost all of which are going to fail.


That's really the trade-off and it's slightly harder to follow.

Will implement and see how it looks / tests.


> 
> > +			if (!dev)
> > +				continue;
> > +
> > +			if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END)
> > {
> > +				pci_dev_put(dev);
> > +				continue;
> > +			}
> > +
> > +			retval = cb(dev, userdata);
> > +			pci_dev_put(dev);
> > +			if (retval)
> > +				return retval;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and
> > call callback.
> > + * @rcec     RCEC whose RCiEP devices should be walked.
> > + * @cb       Callback to be called for each RCiEP device found.
> > + * @userdata Arbitrary pointer to be passed to callback.
> > + *
> > + * Walk the given RCEC. Call the provided callback on each RCiEP
> > device found.
> > + *
> > + * We check the return of @cb each time. If it returns anything
> > + * other than 0, we break out.
> > + */
> > +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev
> > *, void *),
> > +		    void *userdata)
> > +{
> > +	u8 nextbusn, lastbusn;
> > +	struct pci_bus *bus;
> > +	unsigned int bnr;
> > +
> > +	if (!rcec->rcec_cap)
> > +		return;
> > +
> > +	/* Find RCiEP devices on the same bus as the RCEC */
> > +	if (pcie_walk_rciep_devfn(rcec->bus, cb, userdata, rcec-
> > >rcec_ext->bitmap))
> > +		return;
> > +
> > +	/* Check whether RCEC BUSN register is present */
> > +	if (rcec->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
> > +		return;
> > +
> > +	nextbusn = rcec->rcec_ext->nextbusn;
> > +	lastbusn = rcec->rcec_ext->lastbusn;
> > +
> > +	/* All RCiEP devices are on the same bus as the RCEC */
> > +	if (nextbusn == 0xff && lastbusn == 0x00)
> > +		return;
> > +
> > +	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
> 
> I think we also need to skip the RCEC bus here, don't we?  7.9.10.3
> says the Associated Bus Numbers register does not indicate
> association
> between an EC and any Function on the same bus number as the EC
> itself.  Something like this:
> 
>   if (bnr == rcec->bus->number)
>     continue;

Correct. Although it is permitted to include the bus number for the
RCEC in that range (not sure why), skipping the RCEC's should be done.

Will do.

> 
> > +		bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> > +		if (!bus)
> > +			continue;
> > +
> > +		/* Find RCiEP devices on the given bus */
> > +		if (pcie_walk_rciep_devfn(bus, cb, userdata,
> > 0xffffffff))
> > +			return;
> > +	}
> > +}
> > +
> >  void pci_rcec_init(struct pci_dev *dev)
> >  {
> >  	u32 rcec, hdr, busn;
> > -- 
> > 2.28.0
> > 

