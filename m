Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98607B8EEC
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 13:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393616AbfITLXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 07:23:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393566AbfITLXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2019 07:23:35 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iBH0f-0002aN-C7
        for linux-pci@vger.kernel.org; Fri, 20 Sep 2019 11:23:33 +0000
Received: by mail-ot1-f72.google.com with SMTP id z24so3432490otq.6
        for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2019 04:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iV27nI8Jtkumr2nEeO8gy6V9pQ8fT+/smrbZCaOLJgg=;
        b=gUaxiSqO69nbiqK5Jz3nTxFtdl3d5SDVW8Ob8CA5ztXRtXAWMigiHA8bICwFldM6mR
         ceAVx7zIBR//dil9Pn53byp+7DxsjK0duOVg/3LqzLJ1w/TmRM2clFo6bb+02FkFbHcz
         WkkVOzbZYJN+Mu0deiEuP7Scd9ej4p9dCpw6VMk8v5WDrTWTWdv86qnAFG9/tGNU4Cvd
         V+KclFUo8t6fR6WQSFOzt/uq0NTQXiC5nVcvyo+E6V0goJ4Ova/Xt7P6xtRCX4eUeTT7
         COcXQKoOy3BnppjCYqd9fJfIkYP7wRvyR6wMsJe6C7DLieZ/YtQaQGEV/h4svnsduh/q
         Bx6w==
X-Gm-Message-State: APjAAAXOYCHor6917AsEmIVRDr6r0TRV7NSq6dwMuPwMBEUVVHXTwtIs
        /6mIPJkiDmafM69umJFwjuYf4Ft4Rg5QUkDfX0kQX/DcfX5D6OPqJMJ2vnw1xXp9yzIuVgKtd+c
        j1eujtkDx0jc3ZonB1t/gxP/NNzb+A5ACayC6kyHeG2rUN+EfDgSPEA==
X-Received: by 2002:aca:d9c3:: with SMTP id q186mr2385457oig.53.1568978612344;
        Fri, 20 Sep 2019 04:23:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGE0CXP73wztiKAwRdZskwBr2gJgJJW4tcjb56ypIA/roYner5Ad1WU7kgluJgxuZoVUwvadLKzGua+CFsLXU=
X-Received: by 2002:aca:d9c3:: with SMTP id q186mr2385434oig.53.1568978612029;
 Fri, 20 Sep 2019 04:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134756.10807-1-kai.heng.feng@canonical.com> <20190909114129.GT103977@google.com>
In-Reply-To: <20190909114129.GT103977@google.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 20 Sep 2019 13:23:20 +0200
Message-ID: <CAAd53p4mc0tgCBiwfZRowr4os_bqDP+7Ko=d+do8OW2aH1Whzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     tiwai@suse.com, Linux PCI <linux-pci@vger.kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I didn't find your reply in my mailbox earlier.

On Mon, Sep 9, 2019 at 1:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Maybe:
>
>   PCI: Add pci_pr3_present() to check for Power Resources for D3hot

Ok, this is a good title.

>
> On Tue, Aug 27, 2019 at 09:47:55PM +0800, Kai-Heng Feng wrote:
> > A driver may want to know the existence of _PR3, to choose different
> > runtime suspend behavior. A user will be add in next patch.
>
> Maybe include something like this in the commit lot?
>
>   Add pci_pr3_present() to check whether the platform supplies _PR3 to
>   tell us which power resources the device depends on when in D3hot.

Ok.

>
> > This is mostly the same as nouveau_pr3_present().
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci.c   | 20 ++++++++++++++++++++
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 1b27b5af3d55..776af15b92c2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5856,6 +5856,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
> >       return 0;
> >  }
> >
> > +bool pci_pr3_present(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > +     struct acpi_device *parent_adev;
> > +
> > +     if (acpi_disabled)
> > +             return false;
> > +
> > +     if (!parent_pdev)
> > +             return false;
> > +
> > +     parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> > +     if (!parent_adev)
> > +             return false;
> > +
> > +     return parent_adev->power.flags.power_resources &&
> > +             acpi_has_method(parent_adev->handle, "_PR3");
>
> I think this is generally OK, but it doesn't actually check whether
> *pdev* has a _PR3; it checks whether pdev's *parent* does.  So does
> that mean this is dependent on the GPU topology, i.e., does it assume
> that there is an upstream bridge and that power for everything under
> that bridge can be managed together?

Yes, the power resource is managed by its upstream port.

>
> I'm wondering whether the "parent_pdev = pci_upstream_bridge()" part
> should be in the caller rather than in pci_pr3_present()?

This will make the function more align to its name, but needs more
work from caller side.
How about rename the function to pci_upstream_pr3_present()?

>
> I can't connect any of the dots from _PR3 through to
> "need_eld_notify_link" (whatever "eld" is :)) and the uses of
> hda_intel.need_eld_notify_link (and needs_eld_notify_link()).
>
> But that's beyond the scope of *this* patch and it makes sense that
> you do want to discover the _PR3 existence, so I'm fine with this once
> we figure out the pdev vs parent question.

Thanks for your review.

Kai-Heng

>
> > +}
> > +EXPORT_SYMBOL_GPL(pci_pr3_present);
> > +
> >  /**
> >   * pci_add_dma_alias - Add a DMA devfn alias for a device
> >   * @dev: the PCI device for which alias is added
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 82e4cd1b7ac3..9b6f7b67fac9 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
> >
> >  void
> >  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> > +bool pci_pr3_present(struct pci_dev *pdev);
> >  #else
> >  static inline struct irq_domain *
> >  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> > +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> >  #endif
> >
> >  #ifdef CONFIG_EEH
> > --
> > 2.17.1
> >
