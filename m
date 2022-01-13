Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF448DC2C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiAMQri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 11:47:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:22127 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234714AbiAMQri (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 11:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642092458; x=1673628458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yC1aTVPT0hdsL/SN5OhB5oxW83SlaYQWk3o87ylsEKk=;
  b=PdlRsv7zG0J5wRAmX3JtAxFm2DSUQ7W6KeUJauOGKFJsQ2I0yxiJH8xM
   JCB16e543pBk/ZL09Hc/TE5p6G+r8ppvJ1NZ21B61WALnI/PWbfYI2QOI
   CG34c0jsDqFKeEEms9FagQyvrKSaOJi8U1xjsdBFEKpBbcNWb2TkrWD2i
   2xeKMKpJC9S1FbieBoN8SPJS/AoaDixJ2jto7EgbH5FHJE89fa26OHSIt
   ODgUvVIbksmnCfBcDffwOOhj478E6bbt9dcpDuYr+OohHpQZQsW4FvYez
   kqcfu1Yn06/fziTYOtkgH+VSkaYmIdzyXGE7qoQz4EU7D7QLj/M6ZS2bv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244255008"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244255008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 08:47:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691860033"
Received: from lmaniak-dev.igk.intel.com ([10.55.249.72])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 08:47:36 -0800
Date:   Thu, 13 Jan 2022 17:45:38 +0100
From:   Lukasz Maniak <lukasz.maniak@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?=C5=81ukasz?= Gieryk <lukasz.gieryk@linux.intel.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
Message-ID: <20220113164538.GA577231@lmaniak-dev.igk.intel.com>
References: <20211222191958.955681-1-lukasz.maniak@linux.intel.com>
 <20220112144903.GA253960@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112144903.GA253960@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
> > As per PCI Express specification, FLR to a PF resets the PF state as
> > well as the SR-IOV extended capability including VF Enable which means
> > that VFs no longer exist.
> 
> Can you add a specific reference to the spec, please?
> 
Following the Single Root I/O Virtualization and Sharing Specification:
2.2.3. FLR That Targets a PF
PFs must support FLR.
FLR to a PF resets the PF state as well as the SR-IOV extended
capability including VF Enable which means that VFs no longer exist.

For PCI Express Base Specification Revision 5.0 and later, this is
section 9.2.2.3.

> > Currently, the IOV state is not updated during FLR, resulting in
> > non-compliant PCI driver behavior.
> 
> And include a little detail about what problem is observed?  How would
> a user know this problem is occurring?
> 
The problem is that the state of the kernel and HW as to the number of
VFs gets out of sync after FLR.

This results in further listing, after the FLR is performed by the HW,
of VFs that actually no longer exist and should no longer be reported on
the PCI bus. lspci return FFs for these VFs.

sriov_numvfs in sysfs returns old invalid value and does not allow
setting a new value before explicitly setting 0 in the first place.

> > This patch introduces a simple function, called on the FLR path, that
> > removes the virtual function devices from the PCI bus and their
> > corresponding sysfs links with a final clear of the num_vfs value in IOV
> > state.
> > 
> > Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
> > ---
> >  drivers/pci/iov.c | 21 +++++++++++++++++++++
> >  drivers/pci/pci.c |  2 ++
> >  drivers/pci/pci.h |  4 ++++
> >  3 files changed, 27 insertions(+)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 0267977c9f17..69ee321027b4 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
> >  	return max ? max - bus->number : 0;
> >  }
> >  
> > +/**
> > + * pci_reset_iov_state - reset the state of the IOV capability
> > + * @dev: the PCI device
> > + */
> > +void pci_reset_iov_state(struct pci_dev *dev)
> > +{
> > +	struct pci_sriov *iov = dev->sriov;
> > +
> > +	if (!dev->is_physfn)
> > +		return;
> > +	if (!iov->num_VFs)
> > +		return;
> > +
> > +	sriov_del_vfs(dev);
> > +
> > +	if (iov->link != dev->devfn)
> > +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> > +
> > +	iov->num_VFs = 0;
> > +}
> > +
> >  /**
> >   * pci_enable_sriov - enable the SR-IOV capability
> >   * @dev: the PCI device
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 3d2fb394986a..535f19d37e8d 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> >   */
> >  int pcie_flr(struct pci_dev *dev)
> >  {
> > +	pci_reset_iov_state(dev);
> > +
> >  	if (!pci_wait_for_pending_transaction(dev))
> >  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 3d60cabde1a1..7bb144fbec76 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
> >  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
> >  void pci_restore_iov_state(struct pci_dev *dev);
> >  int pci_iov_bus_range(struct pci_bus *bus);
> > +void pci_reset_iov_state(struct pci_dev *dev);
> >  extern const struct attribute_group sriov_pf_dev_attr_group;
> >  extern const struct attribute_group sriov_vf_dev_attr_group;
> >  #else
> > @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
> >  {
> >  	return 0;
> >  }
> > +static inline void pci_reset_iov_state(struct pci_dev *dev)
> > +{
> > +}
> >  
> >  #endif /* CONFIG_PCI_IOV */
> >  
> > 
> > base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> > -- 
> > 2.25.1
> > 
