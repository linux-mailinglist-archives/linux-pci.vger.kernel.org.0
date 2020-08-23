Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0424EC0F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Aug 2020 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHWIBW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Aug 2020 04:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728210AbgHWIBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Aug 2020 04:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598169676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7dt9e12oNAHcRsrc3EfbIWsF++vZ65l9JEyoJZiO/4=;
        b=NEFh4pG0CxTc8eg7uY9quo0ePpBHlC+vEsfhFXFC3qqL/2b/UCTCqjEO9uW7VKEtwMM4Ve
        ueV+ocYXFqE2PZXGVBI0ptADemcmUhn3xp3AJoiH4QiUEICNvugEoMXc0CGjRQOfslTJNv
        VtOuQjP6O8K46dXjxAcnBdXwLAIWylg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-MI3YwfNeMPmW7QNEccWwFg-1; Sun, 23 Aug 2020 04:01:12 -0400
X-MC-Unique: MI3YwfNeMPmW7QNEccWwFg-1
Received: by mail-qv1-f71.google.com with SMTP id q12so4217381qvm.19
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2020 01:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t7dt9e12oNAHcRsrc3EfbIWsF++vZ65l9JEyoJZiO/4=;
        b=Ug/Ht1FlIMUxpW9mcrzsoPOmZ4IY0O4NAJLWfjkp4Z841kJcPDqkpijdtLQZWpEOP0
         NF4n2lPuuHQ7iv/fFTTZa5oBzJas/Z1CKKL1wjefi5trCeieCVs8Y+RSjRPUArXkIUCu
         N77nzrwlXd7qq8i/o/W6G5YW9hYfSAQpvi2rE767pTgueoLnw9rWGLJZNYKvUqRgeV8v
         qJ06Rk0iHMhzE93UJWRwvQuyoobikf2fqYF5Yj8ncFmwDo21WHVZrCtLCsYUr2jznQ04
         uO3FzTNcd9LVMveSWpqOVgNy1d6F03MDaQCnkQuZh6za/062yVqIMXi3DbOvEH1aBwK9
         sHig==
X-Gm-Message-State: AOAM532WgYOsluEAfOBSCp+8Hj63Xq4S3C1zGsW0bazwA8v6V9zkqkPp
        n0Wn60wq0HbiJZ1Rez/3fUMFROspme2J++UpxU53Obghw5PKqMx56TZwpu+Zll4VcyGfvqdRB4j
        gBkhoNQZbItLIJFi0t8D9
X-Received: by 2002:ac8:6793:: with SMTP id b19mr277838qtp.333.1598169672361;
        Sun, 23 Aug 2020 01:01:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynvqmEnvj7OcL2GmrCcAhd5Jc5oPt4ODjXZ9u6kWfXxmHZqtSavIhr5H31SSQ2GlRYeHU1wA==
X-Received: by 2002:ac8:6793:: with SMTP id b19mr277830qtp.333.1598169672000;
        Sun, 23 Aug 2020 01:01:12 -0700 (PDT)
Received: from redhat.com (bzq-109-67-40-161.red.bezeqint.net. [109.67.40.161])
        by smtp.gmail.com with ESMTPSA id p202sm6489989qke.97.2020.08.23.01.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 01:01:10 -0700 (PDT)
Date:   Sun, 23 Aug 2020 04:01:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     George Cherian <george.cherian@marvell.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCHv2] PCI: Add pci_iounmap
Message-ID: <20200823040008-mutt-send-email-mst@kernel.org>
References: <20200820050306.2015009-1-george.cherian@marvell.com>
 <20200820215549.GA1569713@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820215549.GA1569713@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 20, 2020 at 04:55:49PM -0500, Bjorn Helgaas wrote:
> [+cc Michael, author of 66eab4df288a ("lib: add GENERIC_PCI_IOMAP")]
> 
> On Thu, Aug 20, 2020 at 10:33:06AM +0530, George Cherian wrote:
> > In case if any architecture selects CONFIG_GENERIC_PCI_IOMAP and not
> > CONFIG_GENERIC_IOMAP, then the pci_iounmap function is reduced to a NULL
> > function. Due to this the managed release variants or even the explicit
> > pci_iounmap calls doesn't really remove the mappings.
> > 
> > This issue is seen on an arm64 based system. arm64 by default selects
> > only CONFIG_GENERIC_PCI_IOMAP and not CONFIG_GENERIC_IOMAP from this
> > 'commit cb61f6769b88 ("ARM64: use GENERIC_PCI_IOMAP")'
> > 
> > Simple bind/unbind test of any pci driver using pcim_iomap/pci_iomap,
> > would lead to the following error message after long hour tests
> > 
> > "allocation failed: out of vmalloc space - use vmalloc=<size> to
> > increase size."
> > 
> > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > ---
> > * Changes from v1
> > 	- Fix the 0-day compilation error.
> > 	- Mark the lib/iomap pci_iounmap call as weak incase 
> > 	  if any architecture have there own implementation.
> > 
> >  include/asm-generic/io.h |  4 ++++
> >  lib/pci_iomap.c          | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index dabf8cb7203b..5986b37226b7 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -915,12 +915,16 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
> >  struct pci_dev;
> >  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> >  
> > +#ifdef CONFIG_GENERIC_PCI_IOMAP
> > +extern void pci_iounmap(struct pci_dev *dev, void __iomem *p);
> > +#else
> >  #ifndef pci_iounmap
> >  #define pci_iounmap pci_iounmap
> >  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> >  {
> >  }
> >  #endif
> > +#endif /* CONFIG_GENERIC_PCI_IOMAP */
> >  #endif /* CONFIG_GENERIC_IOMAP */
> >  
> >  /*
> > diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> > index 2d3eb1cb73b8..ecd1eb3f6c25 100644
> > --- a/lib/pci_iomap.c
> > +++ b/lib/pci_iomap.c
> > @@ -134,4 +134,14 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
> >  	return pci_iomap_wc_range(dev, bar, 0, maxlen);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_iomap_wc);
> > +
> > +#ifndef CONFIG_GENERIC_IOMAP
> > +#define pci_iounmap pci_iounmap
> > +void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr);
> > +void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> > +{
> > +	iounmap(addr);
> > +}
> > +EXPORT_SYMBOL(pci_iounmap);
> > +#endif
> 
> I completely agree that this looks like a leak that needs to be fixed.
> 
> But my head hurts after trying to understand pci_iomap() and
> pci_iounmap().  I hate to add even more #ifdefs here.  Can't we
> somehow rationalize this and put pci_iounmap() next to pci_iomap()?
> 
> 66eab4df288a ("lib: add GENERIC_PCI_IOMAP") moved pci_iomap() from
> lib/iomap.c to lib/pci_iomap.c, but left pci_iounmap() in lib/iomap.c.
> There must be some good reason why they're separated, but I don't know
> what it is.

My recollection is vaguely that map code was more or less
the same across architectures, but unmap was often different,
so I only moved map into the library.

> >  #endif /* CONFIG_PCI */
> > -- 
> > 2.25.1
> > 

