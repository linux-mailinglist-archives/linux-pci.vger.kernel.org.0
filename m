Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A12FCB0B5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 23:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfJCVBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 17:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfJCVBb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 17:01:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3EC20862;
        Thu,  3 Oct 2019 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570136490;
        bh=B8+adM7hxMw6G43sPG0uzO+Wnf1dj2aZNxz2yxmNHrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A7GofkGDKPMFc9KmRt9LHxIN+iTgM+0bbZUL8rII+T7zvKgosbX6oaYrgUXn8XkuL
         Flg5H02RdJAlwL5DK6LX9sR6Hh8EigB5q0LVefP8rrK1WEvlYjlnuGldK8Ndygp/gI
         KO1MRfB/crDP6Jbptn0vc1a1MmyEK0CXB6GUikYk=
Date:   Thu, 3 Oct 2019 16:01:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v7 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
Message-ID: <20191003210128.GA200289@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003203726.GA14637@skuppusw-desk.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 01:37:26PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On Thu, Oct 03, 2019 at 02:04:13PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 03, 2019 at 10:20:24AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > Hi Bjorn,
> > > 
> > > Thanks for looking into this patch set.
> > > 
> > > On 9/5/19 12:18 PM, Bjorn Helgaas wrote:
> > > > On Wed, Aug 28, 2019 at 03:14:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > 
> > > > > Since pci_prg_resp_pasid_required() function has dependency on both
> > > > > PASID and PRI, define it only if both CONFIG_PCI_PRI and
> > > > > CONFIG_PCI_PASID config options are enabled.
> > > > > 
> > > > > Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
> > > > > interface.")
> > > > [Don't split tags, including "Fixes:" across lines]
> > > > 
> > > > This definitely doesn't fix e5567f5f6762.  That commit added
> > > > pci_prg_resp_pasid_required(), but with no dependency on
> > > > CONFIG_PCI_PRI or CONFIG_PCI_PASID.
> > > > 
> > > > This patch is only required when a subsequent patch is applied.  It
> > > > should be squashed into the commit that requires it so it's obvious
> > > > why it's needed.
> > > > 
> > > > I've been poking at this series, and I'll post a v8 soon with this and
> > > > other fixes.
> > > In your v8 submission you did not merge this patch. You did not use
> > > pri_cap or pasid_cap cached values. Instead you have re-read the
> > > value from register. Is this intentional?
> > > 
> > > Since this function will be called for every VF device we might loose some
> > > performance benefit.
> > 
> > This particular patch doesn't do any caching.  IIRC it fiddles with
> > ifdefs to solve a problem that would be introduced by a future patch.
> > I don't remember the exact details, but I think the series I merged
> > doesn't have that problem.  If it does, let me know the details and we
> > can fix it.
> This patch by itself does not do any caching. But your caching patch
> missed modifying this function to use cached values. Please check the
> current implementation of this function. It still reads
> PCI_EXT_CAP_ID_PRI register instead of using cached value. Please let
> me know your comments.
> 
> int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> {
>     u16 status;
>     int pri;
> 
>     if (pdev->is_virtfn)
>         pdev = pci_physfn(pdev);
> 
>     pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>     if (!pri)
>         return 0;
> 
>     pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
> 
>     if (status & PCI_PRI_STATUS_PASID)
>         return 1;
> 
>     return 0;
> }
> EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> 
> If caching is applied to this function then we need this #ifdef
> dependency correction patch.

IIRC this #ifdef patch wasn't connected to the actual *need* for the
#ifdef, so it was very difficult to review.  I thought this function
would be infrequently used and it wasn't worth trying to sort out the
#ifdef muddle to do the caching.  But it does seem sort of pointless
to chase the capability list again here, so maybe it *is* worth
optimizing.

The PRG Response PASID Required bit is read-only, so I wonder if it
would be simpler if we just read PCI_PRI_STATUS once and save the bit
in the struct pci_dev?  We could do that in pci_enable_pri(), or if we
might need the value before that's called, we could add a
pci_pri_init() and do it there.

> > I did include the caching patches for both PRI and PASID capabilities,
> > but they're only performance optimizations so I moved them to the end
> > so the functional fixes would be smaller and earlier in the series.
> > 
> > > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > ---
> > > > >   drivers/pci/ats.c       | 10 ++++++----
> > > > >   include/linux/pci-ats.h | 12 +++++++++---
> > > > >   2 files changed, 15 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > > > index e18499243f84..cdd936d10f68 100644
> > > > > --- a/drivers/pci/ats.c
> > > > > +++ b/drivers/pci/ats.c
> > > > > @@ -395,6 +395,8 @@ int pci_pasid_features(struct pci_dev *pdev)
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(pci_pasid_features);
> > > > > +#ifdef CONFIG_PCI_PRI
> > > > > +
> > > > >   /**
> > > > >    * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> > > > >    *				 status.
> > > > > @@ -402,10 +404,8 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
> > > > >    *
> > > > >    * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> > > > >    *
> > > > > - * Even though the PRG response PASID status is read from PRI Status
> > > > > - * Register, since this API will mainly be used by PASID users, this
> > > > > - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> > > > > - * CONFIG_PCI_PRI.
> > > > > + * Since this API has dependency on both PRI and PASID, protect it
> > > > > + * with both CONFIG_PCI_PRI and CONFIG_PCI_PASID.
> > > > >    */
> > > > >   int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > > >   {
> > > > > @@ -425,6 +425,8 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> > > > > +#endif
> > > > > +
> > > > >   #define PASID_NUMBER_SHIFT	8
> > > > >   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
> > > > >   /**
> > > > > diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> > > > > index 1ebb88e7c184..1a0bdaee2f32 100644
> > > > > --- a/include/linux/pci-ats.h
> > > > > +++ b/include/linux/pci-ats.h
> > > > > @@ -40,7 +40,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
> > > > >   void pci_restore_pasid_state(struct pci_dev *pdev);
> > > > >   int pci_pasid_features(struct pci_dev *pdev);
> > > > >   int pci_max_pasids(struct pci_dev *pdev);
> > > > > -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> > > > >   #else  /* CONFIG_PCI_PASID */
> > > > > @@ -67,11 +66,18 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
> > > > >   	return -EINVAL;
> > > > >   }
> > > > > +#endif /* CONFIG_PCI_PASID */
> > > > > +
> > > > > +#if defined(CONFIG_PCI_PRI) && defined(CONFIG_PCI_PASID)
> > > > > +
> > > > > +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> > > > > +
> > > > > +#else /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
> > > > > +
> > > > >   static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> > > > >   {
> > > > >   	return 0;
> > > > >   }
> > > > > -#endif /* CONFIG_PCI_PASID */
> > > > > -
> > > > > +#endif
> > > > >   #endif /* LINUX_PCI_ATS_H*/
> > > > > -- 
> > > > > 2.21.0
> > > > > 
> > > -- 
> > > Sathyanarayanan Kuppuswamy
> > > Linux kernel developer
> > > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
