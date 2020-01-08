Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5973913497A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgAHRjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 12:39:22 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39475 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgAHRjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 12:39:22 -0500
Received: by mail-il1-f195.google.com with SMTP id x5so3345876ila.6;
        Wed, 08 Jan 2020 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+v8AezFlGdBI4UBOo3gWVVo1rHFZPhrTFBZe8wNUus=;
        b=qPa4Qa1uYRuf96EMzDrn7JNukRAyeQwC/VNjUR0la/iUuG/QLLyRtxAHvTWi4tsTbM
         O7S7za2abCqvwBoOPfIOwFNFUVhOxxrKSriPCCc8oqtSHXY/7wn+tJQ1aWDS7CRQzSIV
         5Ubik6F/HSUt1ZJTwTk30b2xlPbdttuefDsH5xj4JOJQYwfA6WHQrD2086/nGn3+7NWP
         Zd736YrN+EmNLKtWECiF0ypATSdmYQ2bSjsjymH1IXhGE9uy4L0e7kczKVuFWisgPEpi
         tO9Aw45Ej9d5BMj6BeiiYm7kS/GAh32XC2gjd+FsVZRlgTHt45NRcK5Cj8Lb4mUMo4Xk
         cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+v8AezFlGdBI4UBOo3gWVVo1rHFZPhrTFBZe8wNUus=;
        b=il1bP+qiQIwT5Mg707jHr2U6/Z8tGrdq4jsw3LBSRGtwgIK7NvwTnvQXs2mkmah+QK
         iui7Kfs9F/RK1u4pY8lbivxFHxhrJJqKe1WUrYHnjZ6CRxKelJdmpyXvtTuBgtL9GMdA
         upKTnEYFVsKQ9FTD6+4Gyl8LLUPZEhkhiQwyOWzvTpuvOiNmN2RgrdzrjGyQSir57nm6
         ho7L7RUhUL3G2Nz7IB/sif5RkKzQ4mcBWTsCzOzyX1JFQN+fodcJttESw5w+1kxAWKoC
         TjNccc/v/8FdavcuLEBI9RXcOy8LhYTEPIh29SRuV4LgYikxHRfj3jiOkv/DSPV7C6dq
         pqrA==
X-Gm-Message-State: APjAAAXY5Zb2OeEYcDOl0daE0TcB+/xQoxeaplvS+WrvwM2gbJ4MfZ34
        iAX0SNoJQ4Ui/lTWr6IMvabA3EN92BSh5Dc8JEY=
X-Google-Smtp-Source: APXvYqwKGw0/OzUfb9T6q4NZ/Xb/CGDJvDes5D41RPL1TvFbw180YF0dbqEP33yDHdQy26bLVJ2NfglsNxhLh744NS4=
X-Received: by 2002:a92:48c2:: with SMTP id j63mr4725684ilg.153.1578505161303;
 Wed, 08 Jan 2020 09:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20200104225149.27342-1-deepa.kernel@gmail.com> <20200106143832.GA108920@google.com>
In-Reply-To: <20200106143832.GA108920@google.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 8 Jan 2020 09:39:09 -0800
Message-ID: <CABeXuvp4+GGsUvBwcTmR7949cFhw6pY_LMBRCr1_eh18gBvWnA@mail.gmail.com>
Subject: Re: [PATCH] drivers: pci: Clear ACS state at kexec
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 6, 2020 at 6:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Jan 04, 2020 at 02:51:49PM -0800, Deepa Dinamani wrote:
> > ACS bits remain sticky through kexec reset. This is not really a
> > problem for Linux because turning IOMMU on assumes ACS on. But,
> > this becomes a problem if we kexec into something other than
> > Linux and that does not turn ACS on always.
>
> "Sticky" in the PCIe spec specifically describes bits that are
> unaffected by hot reset or FLR (see PCIe r5.0, sec 7.4), but the
> PCI_ACS_CTRL register contains no RWS bits, so I don't think that's
> what you mean here.
>
> I suspect you mean something like "kexec doesn't reset the device, so
> the new kernel inherits the PCI_ACS_CTRL settings from Linux"?

Yes, I was using "sticky through kexec reset" as a phrase. I will make
this more clear to read that the PCI_ACS_CTRL settings are not cleared
during kexec.

> So it looks like you're unconditionally disabling ACS during kexec.
> The comment in pci_enable_acs() suggests that ACS may have been
> enabled by platform firmware.  Maybe we should *restore* the original
> ACS settings from before Linux enabled ACS rather than clearing them?

I thought about this. I considered following scenarios:

1. Old Linux Kernel (IOMMU on) - > New Linux Kernel (IOMMU on)  - ACS
bits that the kernel touches are unaffected whether or not firmware
has enabled these.
2. Old Linux Kernel (IOMMU on) - > New Linux Kernel (IOMMU off)  - ACS
bits that the kernel touches are cleared even if the firmware has
enabled these. But, we already do pci_disable_acs_redir() when we boot
with IOMMU off. So this is similar. Also, if the IOMMU is off, I do
not see how ACS is useful unless we kexec a second time and turn the
IOMMU on again. And, if we are kexec-ing into Linux again, we know
that this is a no-op for ACS as in [1].
3. Old Linux Kernel(IOMMU on) -> New Kernel(not Linux) (IOMMU on/ off)
- This just matters if the new kernel even does a read/modify/write.
We really can define no policy here unless we can invent a signalling
mechanism from BIOS.

> > Reset the ACS bits to default before kexec or device remove.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> >  drivers/pci/pci-driver.c |  4 ++++
> >  drivers/pci/pci.c        | 39 +++++++++++++++++++++++++++------------
> >  drivers/pci/pci.h        |  1 +
> >  3 files changed, 32 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 0454ca0e4e3f..bd8d08e50b97 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -453,6 +453,8 @@ static int pci_device_remove(struct device *dev)
> >
> >       /* Undo the runtime PM settings in local_pci_probe() */
> >       pm_runtime_put_sync(dev);
> > +     /* Undo the PCI ACS settings in pci_init_capabilities() */
> > +     pci_disable_acs(pci_dev);
>
> Can this be a separate patch?  It doesn't seem to have anything to do
> with kexec, so a different patch with (presumably) a different
> rationale would be good.

We call device_shutdown() during kexec. If the devices are removed,
then the pci_device_shutdown() is not called on such devices. Hence,
the ACS settings we set during the probe() are still active. This is
trying to clear that state. This should be part of the same patch for
completeness, I think. Although this should be moved up as the first
thing this function does. And, a check for the power state you
suggested below.

Also I noticed another thing(when testing) that is ommited in the
patch is that this is not sufficient for bridge devices(without a
driver). I'm thinking pci_remove_bus_device() is a good place for such
devices. Let me know if you have a better recommendation.

> >       /*
> >        * If the device is still on, set the power state as "unknown",
> > @@ -493,6 +495,8 @@ static void pci_device_shutdown(struct device *dev)
> >        */
> >       if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> >               pci_clear_master(pci_dev);
> > +     if (kexec_in_progress)
> > +             pci_disable_acs(pci_dev);
>
> Shouldn't this be in the same "if" block as pci_clear_master()?  If
> the device is in D3cold, it's not going to work to disable ACS because
> config space isn't accessible.

Thanks. This is something I had missed. I will add this in v2.

> >  }
> >
> >  #ifdef CONFIG_PM
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index da2e59daad6f..8254617cff03 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3261,15 +3261,23 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
> >       pci_info(dev, "disabled ACS redirect\n");
> >  }
> >
> > +
> > +/* Standard PCI ACS capailities
> > + * Source Validation | P2P Request Redirect | P2P Completion Redirect | Upstream Forwarding
>
> Please make this comment fit in 80 columns.

Will do.

> > + */
> > +#define PCI_STD_ACS_CAP (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> > +
> >  /**
> > - * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> > + * pci_std_enable_disable_acs - enable/disable ACS on devices using standard
> > + * ACS capabilities
> >   * @dev: the PCI device
> >   */
> > -static void pci_std_enable_acs(struct pci_dev *dev)
> > +static void pci_std_enable_disable_acs(struct pci_dev *dev, int enable)
>
> Maybe you could split this refactoring into its own patch that doesn't
> actually change any behavior?  Then the kexec patch would be a
> one-liner and the device remove patch would be another one-liner, so
> it's obvious where the important changes are.

Sure, I can do it that way.

> >  {
> >       int pos;
> >       u16 cap;
> >       u16 ctrl;
> > +     u16 val = 0;
> >
> >       pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> >       if (!pos)
> > @@ -3278,19 +3286,26 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >       pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> >       pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> >
> > -     /* Source Validation */
> > -     ctrl |= (cap & PCI_ACS_SV);
> > +     val = (cap & PCI_STD_ACS_CAP);
> >
> > -     /* P2P Request Redirect */
> > -     ctrl |= (cap & PCI_ACS_RR);
> > +     if (enable)
> > +             ctrl |= val;
> > +     else
> > +             ctrl &= ~val;
> >
> > -     /* P2P Completion Redirect */
> > -     ctrl |= (cap & PCI_ACS_CR);
> > +     pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> > +}
> >
> > -     /* Upstream Forwarding */
> > -     ctrl |= (cap & PCI_ACS_UF);
> > +/**
> > + * pci_disable_acs - enable ACS if hardware support it
>
> s/enable/disable/ (in comment)
> s/support/supports/

OK.
