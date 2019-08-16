Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA64F9077F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfHPSJu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 14:09:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:32583 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfHPSJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 14:09:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 11:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="182242381"
Received: from skuppusw-desk.jf.intel.com (HELO skuppusw-desk.amr.corp.intel.com) ([10.54.74.33])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2019 11:09:24 -0700
Date:   Fri, 16 Aug 2019 11:06:38 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
Message-ID: <20190816180638.GA28404@skuppusw-desk.amr.corp.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0d7e0e0d079c438897f4da8cdca4b55994b1233b.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190812200418.GJ11785@google.com>
 <09a2faf0-a26f-6374-130a-3b33b1b712d5@linux.intel.com>
 <20190813035148.GI7302@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813035148.GI7302@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 10:51:48PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 12, 2019 at 01:20:55PM -0700, sathyanarayanan kuppuswamy wrote:
> > On 8/12/19 1:04 PM, Bjorn Helgaas wrote:
> > > On Thu, Aug 01, 2019 at 05:05:58PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > Since pci_prg_resp_pasid_required() function has dependency on both
> > > > PASID and PRI, define it only if both CONFIG_PCI_PRI and
> > > > CONFIG_PCI_PASID config options are enabled.
> 
> > > I don't really like this.  It makes the #ifdefs more complicated and I
> > > don't think it really buys us anything.  Will anything break if we
> > > just drop this patch?
> 
> > Yes, this function uses "pri_lock" mutex which is only defined if
> > CONFIG_PCI_PRI is enabled. So not protecting this function within
> > CONFIG_PCI_PRI will lead to compilation issues.
> 
> Ah, OK.  That helps a lot.  "pri_lock" doesn't exist at this point in
> the series, so the patch makes no sense without knowing that.
> 
> I'm still not convinced this is the right thing because I'm not sure
> the lock is necessary.  I'll respond to the patch that adds the lock.
Its not only pri_lock. This function also uses "pri_cap" which is also
only defined for CONFIG_PCI_PRI. "pri_cap" is added by next patch in the
series which adds caching support for PRI capability check. So this
patch is still required even if we remove use of pri_lock in this
function.
> 
> > > > Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
> > > > interface.")
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > ---
> > > >   drivers/pci/ats.c       | 10 ++++++----
> > > >   include/linux/pci-ats.h | 12 +++++++++---
> > > >   2 files changed, 15 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > > index e18499243f84..cdd936d10f68 100644
> > > > --- a/drivers/pci/ats.c
> > > > +++ b/drivers/pci/ats.c
> > > > @@ -395,6 +395,8 @@ int pci_pasid_features(struct pci_dev *pdev)
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(pci_pasid_features);
> > > > +#ifdef CONFIG_PCI_PRI
> > > > +
> > > >   /**
> > > >    * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> > > >    *				 status.
> > > > @@ -402,10 +404,8 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
> > > >    *
> > > >    * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> > > >    *
> > > > - * Even though the PRG response PASID status is read from PRI Status
> > > > - * Register, since this API will mainly be used by PASID users, this
> > > > - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> > > > - * CONFIG_PCI_PRI.
> > > > + * Since this API has dependency on both PRI and PASID, protect it
> > > > + * with both CONFIG_PCI_PRI and CONFIG_PCI_PASID.
> > > >    */
> > > >   int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > >   {
> > > > @@ -425,6 +425,8 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> > > > +#endif
> > > > +
> > > >   #define PASID_NUMBER_SHIFT	8
> > > >   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
> > > >   /**
> > > > diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> > > > index 1ebb88e7c184..1a0bdaee2f32 100644
> > > > --- a/include/linux/pci-ats.h
> > > > +++ b/include/linux/pci-ats.h
> > > > @@ -40,7 +40,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
> > > >   void pci_restore_pasid_state(struct pci_dev *pdev);
> > > >   int pci_pasid_features(struct pci_dev *pdev);
> > > >   int pci_max_pasids(struct pci_dev *pdev);
> > > > -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> > > >   #else  /* CONFIG_PCI_PASID */
> > > > @@ -67,11 +66,18 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
> > > >   	return -EINVAL;
> > > >   }
> > > > +#endif /* CONFIG_PCI_PASID */
> > > > +
> > > > +#if defined(CONFIG_PCI_PRI) && defined(CONFIG_PCI_PASID)
> > > > +
> > > > +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> > > > +
> > > > +#else /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
> > > > +
> > > >   static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > >   {
> > > >   	return 0;
> > > >   }
> > > > -#endif /* CONFIG_PCI_PASID */
> > > > -
> > > > +#endif
> > > >   #endif /* LINUX_PCI_ATS_H*/
> > > > -- 
> > > > 2.21.0
> > > > 
> > -- 
> > Sathyanarayanan Kuppuswamy
> > Linux kernel developer
> > 

-- 
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
