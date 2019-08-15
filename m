Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D98F245
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfHORdP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 13:33:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:31604 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfHORdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 13:33:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 10:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="176934043"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2019 10:32:49 -0700
Date:   Thu, 15 Aug 2019 10:30:03 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Message-ID: <20190815173003.GB139211@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3dd8c36177ac52d9a87655badb000d11785a5a4a.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815044657.GD253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815044657.GD253360@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 11:46:57PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 01, 2019 at 05:05:59PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Currently, PRI Capability checks are repeated across all PRI API's.
> > Instead, cache the capability check result in pci_pri_init() and use it
> > in other PRI API's. Also, since PRI is a shared resource between PF/VF,
> > initialize default values for common PRI features in pci_pri_init().
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > ---
> >  drivers/pci/ats.c       | 80 ++++++++++++++++++++++++++++-------------
> >  include/linux/pci-ats.h |  5 +++
> >  include/linux/pci.h     |  1 +
> >  3 files changed, 61 insertions(+), 25 deletions(-)
> > 
> 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index cdd936d10f68..280be911f190 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> 
> > @@ -28,6 +28,8 @@ void pci_ats_init(struct pci_dev *dev)
> >  		return;
> >  
> >  	dev->ats_cap = pos;
> > +
> > +	pci_pri_init(dev);
> >  }
> >  
> >  /**
> > @@ -170,36 +172,72 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
> >  EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
> >  
> >  #ifdef CONFIG_PCI_PRI
> > +
> > +void pci_pri_init(struct pci_dev *pdev)
> > +{
> > ...
> > +}
> 
> > diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> > index 1a0bdaee2f32..33653d4ca94f 100644
> > --- a/include/linux/pci-ats.h
> > +++ b/include/linux/pci-ats.h
> > @@ -6,6 +6,7 @@
> >  
> >  #ifdef CONFIG_PCI_PRI
> >  
> > +void pci_pri_init(struct pci_dev *pdev);
> 
> pci_pri_init() is implemented and called in drivers/pci/ats.c.  Unless
> there's a need to call this from outside ats.c, it should be static
> and should not be declared here.
> 
> If you can make it static, please also reorder the code so you don't
> need a forward declaration in ats.c.
Initially I did implement it as static function in drivers/pci/ats.c
and protected the calling of pci_pri_init() with #ifdef CONFIG_PCI_PRI.
But Keith did not like the implementation using #ifdefs and asked me to
define empty functions. That's the reason for moving it to header file.
In your previous review to this patch, since this is not used outside ats.c
you asked me to move the declaraion to drivers/pci/pci.h. So I was planing
to move it to drivers/pci/pci.h in next version. Let me know if you are in
agreement.
> 
> >  int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
> >  void pci_disable_pri(struct pci_dev *pdev);
> >  void pci_restore_pri_state(struct pci_dev *pdev);
> > @@ -13,6 +14,10 @@ int pci_reset_pri(struct pci_dev *pdev);
> >  
> >  #else /* CONFIG_PCI_PRI */
> >  
> > +static inline void pci_pri_init(struct pci_dev *pdev)
> > +{
> > +}
> > +
> >  static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> >  {
> >  	return -ENODEV;

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
