Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8492F906EB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfHPRbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 13:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHPRbN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 13:31:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73EBC2086C;
        Fri, 16 Aug 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976672;
        bh=pCq0siwRZY1QgHtPHpJZgOOHgVYfdlVGKRVR33bsDN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5a+BuYqbw23LQknyMoPh7AlkC+dco33MPK0CvNHF+1i0WeDWTA6pIv7/hNRT6FIP
         keBG2N2SEr2wu92hdRLxmSMuHQGoDBZXXxQnajDoRjdX1tjQBT5JW6naCGrOokdIw9
         jjwOUfMpUKcZpayozatSDhtoor1RabQDyf/mRC3E=
Date:   Fri, 16 Aug 2019 12:31:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Message-ID: <20190816173108.GP253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3dd8c36177ac52d9a87655badb000d11785a5a4a.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815044657.GD253360@google.com>
 <20190815173003.GB139211@skuppusw-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815173003.GB139211@skuppusw-desk.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 15, 2019 at 10:30:03AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On Wed, Aug 14, 2019 at 11:46:57PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 01, 2019 at 05:05:59PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > Currently, PRI Capability checks are repeated across all PRI API's.
> > > Instead, cache the capability check result in pci_pri_init() and use it
> > > in other PRI API's. Also, since PRI is a shared resource between PF/VF,
> > > initialize default values for common PRI features in pci_pri_init().
> > > 
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > >  drivers/pci/ats.c       | 80 ++++++++++++++++++++++++++++-------------
> > >  include/linux/pci-ats.h |  5 +++
> > >  include/linux/pci.h     |  1 +
> > >  3 files changed, 61 insertions(+), 25 deletions(-)
> > > 
> > 
> > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > index cdd936d10f68..280be911f190 100644
> > > --- a/drivers/pci/ats.c
> > > +++ b/drivers/pci/ats.c
> > 
> > > @@ -28,6 +28,8 @@ void pci_ats_init(struct pci_dev *dev)
> > >  		return;
> > >  
> > >  	dev->ats_cap = pos;
> > > +
> > > +	pci_pri_init(dev);
> > >  }
> > >  
> > >  /**
> > > @@ -170,36 +172,72 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
> > >  EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
> > >  
> > >  #ifdef CONFIG_PCI_PRI
> > > +
> > > +void pci_pri_init(struct pci_dev *pdev)
> > > +{
> > > ...
> > > +}
> > 
> > > diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> > > index 1a0bdaee2f32..33653d4ca94f 100644
> > > --- a/include/linux/pci-ats.h
> > > +++ b/include/linux/pci-ats.h
> > > @@ -6,6 +6,7 @@
> > >  
> > >  #ifdef CONFIG_PCI_PRI
> > >  
> > > +void pci_pri_init(struct pci_dev *pdev);
> > 
> > pci_pri_init() is implemented and called in drivers/pci/ats.c.  Unless
> > there's a need to call this from outside ats.c, it should be static
> > and should not be declared here.
> > 
> > If you can make it static, please also reorder the code so you don't
> > need a forward declaration in ats.c.

> Initially I did implement it as static function in drivers/pci/ats.c
> and protected the calling of pci_pri_init() with #ifdef CONFIG_PCI_PRI.
> But Keith did not like the implementation using #ifdefs and asked me to
> define empty functions. That's the reason for moving it to header file.

Defining empty functions doesn't mean it has to be in a header file.
It's only needed inside ats.c, so the whole thing should be static
there.  You can easily #ifdef the implementation, e.g., do the
following in ats.c:

  static void pci_pri_init(struct pci_dev *pdev)
  {
  #ifdef CONFIG_PCI_PRI
    ...
  #endif
  }
