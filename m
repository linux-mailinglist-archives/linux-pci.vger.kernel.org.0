Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FA3AD074
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhFRQej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhFRQei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 12:34:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B0DC061574;
        Fri, 18 Jun 2021 09:32:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w31so8211250pga.6;
        Fri, 18 Jun 2021 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A1PqtztDnmaYUFUfgBGqvyIO9ZWU5/9IhdtC/jeTJ5I=;
        b=uxNAziOevP8WBfuLwv0XkO7m2M++JDDMUW2ZIKOZIRYqBMW2asEahVymrhZQ2okhSq
         LPcKN0gvw7HtvXyuzTXeQnE1Nh4/nr3N5qM61z93JFgd1jyCQWgLJbQpcDCdtXyvCjBW
         kZu14QXmvwmBvgV8I5u2hvFwZ6+6endaufSNhu2rhoBYJZb10fBDZGvxA3w/EewlUCk5
         dSml94I6ueTjIAK+WjzSjEBuLEZVcYNlXJ70Gz794Bnes7pL5x438qiMjjmLpTPIww4B
         aPa6WZpOHmnw0kOods+8iZ6rSKdZkOU7rvllNYrd07cZun1k+qq39YIlgaOIBPeGt0RE
         Ne0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1PqtztDnmaYUFUfgBGqvyIO9ZWU5/9IhdtC/jeTJ5I=;
        b=rrN4xYQZPAprKcOtNGujbxXR72LKeYXG6rdM9lJ6xdEwZuYyBjqFGoUFfDryPDCiIY
         hdWydNrqmN3e4XCiaMGTSR+3cwLU8Y4PoJBH7uX644l3ZtvanRkZRX9gPpwCWtUAZZFd
         63Hcs6nge6KQhknVh/gP3pYsL2HPjLiJtHV+iiib1UPespq+b+x3w9xWZdL1nUnj4BaS
         EZIe1VElQ7TMw6HBk1LZ1eDwNUHu4B8HvChGANDvlT4s+Vg4aPLSTuFmut9JiJUIsOkS
         JcchPCDFDqVPMW26n2g5lKNmtuJzHXjgZV1uEK5+1+G3P1kHtP+5hyXxFeMoZ43Oc8wp
         ESsg==
X-Gm-Message-State: AOAM532cJhXKLmh7Xpv+dQQ4uV7GAa2c7FBDAfb7Q+q02KhfH/osxVVh
        2XnU2Ony8dV+M6SBeryLPng=
X-Google-Smtp-Source: ABdhPJy44RMj2aKnG6pOxBOxTVJT7kDLfH08utfo2EilSBdMXQsJksWpzrbqj0wzewxan4UpbyL77A==
X-Received: by 2002:aa7:9983:0:b029:2e9:e086:7917 with SMTP id k3-20020aa799830000b02902e9e0867917mr5804870pfh.57.1624033946445;
        Fri, 18 Jun 2021 09:32:26 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id x143sm1147841pfc.6.2021.06.18.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:32:26 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:02:23 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J .Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210618163223.otdhrkxnyng32okp@archlinux>
References: <20210608054857.18963-2-ameynarkhede03@gmail.com>
 <20210617215734.GA3135430@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617215734.GA3135430@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/17 04:57PM, Bjorn Helgaas wrote:
> [+cc Christoph, since he added pcie_flr()]
>
> On Tue, Jun 08, 2021 at 11:18:50AM +0530, Amey Narkhede wrote:
> > Currently there is separate function pcie_has_flr() to probe if pcie flr is
> > supported by the device which does not match the calling convention
> > followed by reset methods which use second function argument to decide
> > whether to probe or not.  Add new function pcie_reset_flr() that follows
> > the calling convention of reset methods.
>
> I don't like the fact that we handle FLR differently from other types
> of reset, so I do like the fact that this makes them more consistent.
>
> > Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
> >  drivers/pci/pci.c                          | 62 ++++++++++++----------
> >  drivers/pci/pcie/aer.c                     | 12 ++---
> >  drivers/pci/quirks.c                       |  9 ++--
> >  include/linux/pci.h                        |  2 +-
> >  5 files changed, 43 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> > index facc8e6bc..15d6c8452 100644
> > --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> > +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> > @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
> >  		return -ENOMEM;
> >  	}
> >
> > -	/* check flr support */
> > -	if (pcie_has_flr(pdev))
> > -		pcie_flr(pdev);
> > +	pcie_reset_flr(pdev, 0);
> >
> >  	pci_restore_state(pdev);
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 452351025..3bf36924c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4611,32 +4611,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> >
> > -/**
> > - * pcie_has_flr - check if a device supports function level resets
> > - * @dev: device to check
> > - *
> > - * Returns true if the device advertises support for PCIe function level
> > - * resets.
> > - */
> > -bool pcie_has_flr(struct pci_dev *dev)
> > -{
> > -	u32 cap;
> > -
> > -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > -		return false;
> > -
> > -	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > -	return cap & PCI_EXP_DEVCAP_FLR;
> > -}
> > -EXPORT_SYMBOL_GPL(pcie_has_flr);
> > -
> >  /**
> >   * pcie_flr - initiate a PCIe function level reset
> >   * @dev: device to reset
> >   *
> > - * Initiate a function level reset on @dev.  The caller should ensure the
> > - * device supports FLR before calling this function, e.g. by using the
> > - * pcie_has_flr() helper.
> > + * Initiate a function level reset unconditionally on @dev without
> > + * checking any flags and DEVCAP
> >   */
> >  int pcie_flr(struct pci_dev *dev)
> >  {
> > @@ -4659,6 +4639,31 @@ int pcie_flr(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pcie_flr);
> >
> > +/**
> > + * pcie_reset_flr - initiate a PCIe function level reset
> > + * @dev: device to reset
> > + * @probe: If set, only check if the device can be reset this way.
> > + *
> > + * Initiate a function level reset on @dev.
> > + */
> > +int pcie_reset_flr(struct pci_dev *dev, int probe)
> > +{
> > +	u32 cap;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > +		return -ENOTTY;
> > +
> > +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	return pcie_flr(dev);
>
> Christoph added pcie_flr() with a60a2b73ba69 ("PCI: Export
> pcie_flr()"), where the commit log says he split out the probing
> because "non-core callers already know their hardware."
>
> It *is* reasonable to expect that drivers know whether their device
> supports FLR so they don't need to probe.
>
> But we don't expose the "probe" argument outside the PCI core for any
> other reset methods, and I would like to avoid that here.
>
> It seems excessive to have to read PCI_EXP_DEVCAP every time.
> PCI_EXP_DEVCAP_FLR is a read-only bit, and we should only need to look
> at it once.
>
> What I would really like here is a single bit in the pci_dev that we
> could set at enumeration-time, e.g., something like this:
>
>   struct pci_dev {
>     ...
>     unsigned int has_flr:1;
>   };
>
>   void set_pcie_port_type(...)    # during enumeration
>   {
>     pci_read_config_word(dev, pos + PCI_EXP_DEVCAP, &reg16);
>     if (reg16 & PCI_EXP_DEVCAP_FLR)
>       dev->has_flr = 1;
>   }
>
>   static void quirk_no_flr(...)
>   {
>     dev->has_flr = 0;             # get rid of PCI_DEV_FLAGS_NO_FLR_RESET
>   }
>
>   int pcie_flr(...)
>   {
>     if (!dev->has_flr)
>       return -ENOTTY;
>
>     if (!pci_wait_for_pending_transaction(dev))
>       ...
>   }
>
> I think this should be enough that we could get rid of pcie_has_flr()
> without having to expose the "probe" argument outside drivers/pci/.
>
> Procedural note: if we *do* have to expose the "probe" argument, can
> you arrange it to have the correct type before touching the drivers, so
> we only have to touch the drivers once?
>
Thanks for the details. I'll add dev->has_flr check in pcie_reset_flr.
[...]

Thanks,
Amey
