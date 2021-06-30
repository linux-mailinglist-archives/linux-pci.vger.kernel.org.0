Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E603B89E3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhF3Uwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 16:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229700AbhF3Uwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 16:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625086200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8R7hHJmuAVBel6m03TZSyrzhu49GOYABeN9Y+21W5yY=;
        b=JHlqYh4DE7NwwIPY4mGMC1rXWlPTi1aPa8aL3yvBMacXF/XurnYpt0XXIwv53ixLAQvast
        wUkOQUs3MK/G9yFadCcFP2FOI6h6qv2iCEcsh4buOKx8wMPqpuFKcn9XHFAc2o184B5CZK
        k6hBElurHC9kVC83YZEfT4qZY+Zwzic=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-3ZCT8KtrM6aoGCGk5-xmww-1; Wed, 30 Jun 2021 16:49:58 -0400
X-MC-Unique: 3ZCT8KtrM6aoGCGk5-xmww-1
Received: by mail-oo1-f69.google.com with SMTP id h10-20020a4ae8ca0000b029024cdf2d6eb7so2078178ooe.22
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 13:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8R7hHJmuAVBel6m03TZSyrzhu49GOYABeN9Y+21W5yY=;
        b=oHmZWVhyBUuuym4MGFDpbteXhljzAP4u6resQT+tA6jgJegMgiTKuNzgkn5TpB4FsW
         FWNT686lCL4EU3uCTR3yBeYPm3qG8rw2WbAjBVmWKN4xFogvQsl7zvu1CCqbxWrePegK
         CKmzpBQUGrGqlwfPPvoFBQwejh62eiRZqQGWA6TLPIfmafCv+fcx2aDsR+lknpeCNa98
         infDPBYL51gqHLrsjE1XDRwftgwrpBopXGXCrkjiyb0VBYum3EgVEgL4jZ4pVtkIsAlB
         r9grr9l13C8FtXxzQHx/utLVGyw8P1gJFIDCnmljYjIzSTrwnX+XcMNbpYNzJZBAk+xw
         n3Mg==
X-Gm-Message-State: AOAM531aSPC9ph2tsTjX2PaMEL5wRR816t6eYdJwlcFpMM90xUSY5yDj
        Rd7yloG1MrsihKwFldMiy1jnzgaZsxvl00iQo3luJQS74ZgGS5RYPmYuOPV8NIBNSTsr434vUoB
        8lhGIkk2MM6zfejuC3uax
X-Received: by 2002:a9d:6a06:: with SMTP id g6mr10520074otn.310.1625086197950;
        Wed, 30 Jun 2021 13:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCADS19465If5OYHOL0to6c6RcoeNpwsg45g5B41B28u/Yb0a6zbVN2gOhn0bYwOVVgE0xOA==
X-Received: by 2002:a9d:6a06:: with SMTP id g6mr10520048otn.310.1625086197646;
        Wed, 30 Jun 2021 13:49:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u12sm262734oiu.7.2021.06.30.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 13:49:57 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:49:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210630144955.71c5abac.alex.williamson@redhat.com>
In-Reply-To: <20210630200415.h6y43akhcmln36uk@archlinux>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
        <20210629160104.2893-2-ameynarkhede03@gmail.com>
        <20210630115655.05958cfb.alex.williamson@redhat.com>
        <20210630200415.h6y43akhcmln36uk@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Jul 2021 01:34:15 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> On 21/06/30 11:56AM, Alex Williamson wrote:
> > On Tue, 29 Jun 2021 21:30:57 +0530
> > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> >  
> > > Add has_flr bitfield in struct pci_dev to indicate support for pcie flr
> > > to avoid reading PCI_EXP_DEVCAP multiple times and get rid of
> > > PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr().
> > >
> > > Currently there is separate function pcie_has_flr() to probe if pcie flr is
> > > supported by the device which does not match the calling convention
> > > followed by reset methods which use second function argument to decide
> > > whether to probe or not.  Add new function pcie_reset_flr() that follows
> > > the calling convention of reset methods.
> > >
> > > Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> >
> > There are some non-trivial changes here vs previous, should probably
> > drop this.
> >  
> > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > ---
> > >  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
> > >  drivers/pci/pci.c                          | 62 +++++++++++-----------
> > >  drivers/pci/pcie/aer.c                     | 12 ++---
> > >  drivers/pci/probe.c                        |  6 ++-
> > >  drivers/pci/quirks.c                       | 11 ++--
> > >  include/linux/pci.h                        |  7 ++-
> > >  6 files changed, 47 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> > > index facc8e6bc..15d6c8452 100644
> > > --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> > > +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> > > @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
> > >  		return -ENOMEM;
> > >  	}
> > >
> > > -	/* check flr support */
> > > -	if (pcie_has_flr(pdev))
> > > -		pcie_flr(pdev);
> > > +	pcie_reset_flr(pdev, 0);
> > >
> > >  	pci_restore_state(pdev);
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 452351025..28f099a4f 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4611,32 +4611,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
> > >  }
> > >  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> > >
> > > -/**
> > > - * pcie_has_flr - check if a device supports function level resets
> > > - * @dev: device to check
> > > - *
> > > - * Returns true if the device advertises support for PCIe function level
> > > - * resets.
> > > - */
> > > -bool pcie_has_flr(struct pci_dev *dev)
> > > -{
> > > -	u32 cap;
> > > -
> > > -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > > -		return false;
> > > -
> > > -	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > > -	return cap & PCI_EXP_DEVCAP_FLR;
> > > -}
> > > -EXPORT_SYMBOL_GPL(pcie_has_flr);
> > > -
> > >  /**
> > >   * pcie_flr - initiate a PCIe function level reset
> > >   * @dev: device to reset
> > >   *
> > > - * Initiate a function level reset on @dev.  The caller should ensure the
> > > - * device supports FLR before calling this function, e.g. by using the
> > > - * pcie_has_flr() helper.
> > > + * Initiate a function level reset unconditionally on @dev without
> > > + * checking any flags and DEVCAP
> > >   */
> > >  int pcie_flr(struct pci_dev *dev)
> > >  {
> > > @@ -4659,16 +4639,35 @@ int pcie_flr(struct pci_dev *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pcie_flr);
> > >
> > > +/**
> > > + * pcie_reset_flr - initiate a PCIe function level reset
> > > + * @dev: device to reset
> > > + * @probe: If set, only check if the device can be reset this way.
> > > + *
> > > + * Initiate a function level reset on @dev.
> > > + */
> > > +int pcie_reset_flr(struct pci_dev *dev, int probe)
> > > +{
> > > +	if (!dev->has_flr)
> > > +		return -ENOTTY;
> > > +
> > > +	if (probe)
> > > +		return 0;
> > > +
> > > +	return pcie_flr(dev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pcie_reset_flr);
> > > +
> > >  static int pci_af_flr(struct pci_dev *dev, int probe)
> > >  {
> > >  	int pos;
> > >  	u8 cap;
> > >
> > > -	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> > > -	if (!pos)
> > > +	if (!dev->has_flr)
> > >  		return -ENOTTY;
> > >
> > > -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > > +	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> > > +	if (!pos)
> > >  		return -ENOTTY;
> > >
> > >  	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);  
> >
> >
> > How can has_flr encompass both methods of invoking FLR?  PCIe FLR is
> > not a prerequisite to AF FLR.
> >  
> I see. Does this mean that there should be a separate flag for disabling
> AF FLR?

There hasn't been a need so far.  Per the ECN, the AF capability is
meant to make select PCIe features available on conventional PCI
devices.  It seems like it would be against the spirit of the AF
capability to implement both an AF capability and a PCIe capability,
but I don't see that it's definitively addressed by the spec.

AF FLR is sufficiently rare that it's probably reasonable to make a
has_pcie_flr bit on the device and leave AF FLR alone.  I can't really
say that I'm in favor of assigning a has_flr bit the double duty of
also quirking broken FLR, if nothing else it's inconsistent with our
other means of quirking resets.

> > > @@ -5139,11 +5138,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
> > >  	rc = pci_dev_specific_reset(dev, 0);
> > >  	if (rc != -ENOTTY)
> > >  		return rc;
> > > -	if (pcie_has_flr(dev)) {
> > > -		rc = pcie_flr(dev);
> > > -		if (rc != -ENOTTY)
> > > -			return rc;
> > > -	}
> > > +	rc = pcie_reset_flr(dev, 0);
> > > +	if (rc != -ENOTTY)
> > > +		return rc;
> > >  	rc = pci_af_flr(dev, 0);
> > >  	if (rc != -ENOTTY)
> > >  		return rc;
> > > @@ -5174,8 +5171,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
> > >  	rc = pci_dev_specific_reset(dev, 1);
> > >  	if (rc != -ENOTTY)
> > >  		return rc;
> > > -	if (pcie_has_flr(dev))
> > > -		return 0;
> > > +	rc = pcie_reset_flr(dev, 1);
> > > +	if (rc != -ENOTTY)
> > > +		return rc;
> > >  	rc = pci_af_flr(dev, 1);
> > >  	if (rc != -ENOTTY)
> > >  		return rc;
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index ec943cee5..98077595a 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> > >  	}
> > >
> > >  	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> > > -		if (pcie_has_flr(dev)) {
> > > -			rc = pcie_flr(dev);
> > > -			pci_info(dev, "has been reset (%d)\n", rc);
> > > -		} else {
> > > -			pci_info(dev, "not reset (no FLR support)\n");
> > > -			rc = -ENOTTY;
> > > -		}
> > > +		rc = pcie_reset_flr(dev, 0);
> > > +		if (!rc)
> > > +			pci_info(dev, "has been reset\n");
> > > +		else
> > > +			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
> > >  	} else {
> > >  		rc = pci_bus_error_reset(dev);
> > >  		pci_info(dev, "%s Port link has been reset (%d)\n",
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 3a62d09b8..862d91615 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1487,6 +1487,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
> > >  {
> > >  	int pos;
> > >  	u16 reg16;
> > > +	u32 reg32;
> > >  	int type;
> > >  	struct pci_dev *parent;
> > >
> > > @@ -1497,8 +1498,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
> > >  	pdev->pcie_cap = pos;
> > >  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
> > >  	pdev->pcie_flags_reg = reg16;
> > > -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> > > -	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> > > +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
> > > +	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
> > > +	pdev->has_flr = reg32 & PCI_EXP_DEVCAP_FLR ? 1 : 0;  
> >
> > We only set has_flr for PCIe FLR, so I think this effectively kills AF
> > FLR.  The ternary should be unnecessary here.
> >  
> I believe only one of the PCIe FLR and PCI AF FLR will be available at a time.

Likely, possibly required depending on spec interpretation.

> So I think it should be okay to check for PCI_AF_CAP_FLR and set
> pdev->has_flr accordingly.

AF FLR is rare, are the reasons we're wanting to cache its availability
as relevant as they are for PCIe FLR?

> One question though, what is PCI_AF_CAP_TP

Transaction Pending

> and how is it related to PCI AF FLR?

It's required to be implemented if AF FLR is implemented.  We're
supposed to wait for TP to clear before issuing an FLR to avoid an
issue with stale completions of outstanding transactions.  Thanks,

Alex

