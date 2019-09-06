Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F711AB9BF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391948AbfIFNuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 09:50:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37999 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391827AbfIFNuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 09:50:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so7187106wme.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2019 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrYX6Q/LeSVDnxpxfV2uN5QLi2+c+z0J+TjzkFIN0Fc=;
        b=dTKytgdTPeYLmGHfgGyuJ4gHDsBA88t0GaqfFy3KJSzw1grNzTF8bHCl4EsBTg7uo/
         Vdscq0BFMxUIAA4MGalbd0RSAsvdpql9MVo2nujiAO+Chbp/hsWpuJz1+bgaAo7oGkcN
         MWUlnZArwvVWxG00Oeb6rSgQfQRJZ2D763X5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrYX6Q/LeSVDnxpxfV2uN5QLi2+c+z0J+TjzkFIN0Fc=;
        b=mSOuukkONy+Zn4zXCECBA/5FUNlmBq6dcmbZf4np1u/96mxuJdoo66Ol5fbxCefVYP
         VykgcYniHb/0/FYQvG5AGSXCVjmr/BITuemZ5nxQ4OW7OYO4wYU8D+nPYs8kxcAlyV8T
         NGur8bQrTjiIcFlryhvhLPuW8x8VgcoYzCKA375FCau6GhTBzQDQgx86trFFfjVUF9Vo
         lnr93nPtBSaEGoqxwq3oeKKf2fl3MG7ecxZWuNG4cbZgbLA9GhsJlVFggmXeYC3QnfC6
         tJ7M0SqtZFtVRtEZ0xvxlGJbfDn0K2CzXeb8wijMUIrvJ2Dks35rBeQz+kgdzqPA35Jc
         elpA==
X-Gm-Message-State: APjAAAWbeUnlDchy9wcArat20rF/PR+C8TqY0u74mBKzFNg+ELHl0yFD
        CixEnr9dWF0ZQdORf12gvC0EOX6om87lEayS2+TLYA==
X-Google-Smtp-Source: APXvYqxU9LVVRhlbWADFqDWPsgI5B12obV4dqUR9JZ3Z6uPq60OE8Cz65ZO/IZ+QTP/vT+9EPMbOAc/F220BbvmL1Ms=
X-Received: by 2002:a1c:f016:: with SMTP id a22mr7494148wmb.170.1567777819341;
 Fri, 06 Sep 2019 06:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com> <20190905222649.GK103977@google.com>
In-Reply-To: <20190905222649.GK103977@google.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 6 Sep 2019 19:20:08 +0530
Message-ID: <CABe79T6Ve_j17fDNZ=2u2Yzq+tD1PjU-PZFHTQRK3siLGt5C-A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add PCIE ACS quirk for IPROC PAXB
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the improvements. With the changes, comments and commit
message exactly describes the purpose.
I tested the code changes and works fine.

Thanks again,
Srinath

On Fri, Sep 6, 2019 at 3:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alex]
>
> On Tue, Aug 20, 2019 at 10:09:45AM +0530, Srinath Mannam wrote:
> > From: Abhinav Ratna <abhinav.ratna@broadcom.com>
> >
> > IPROC PAXB RC doesn't support ACS capabilities and control registers.
> > Add quirk to have separate IOMMU groups for all EPs and functions connected
> > to root port, by masking RR/CR/SV/UF bits.
> >
> > Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>
> I tentatively applied this to pci/misc with Scott's ack for v5.4.
>
> I tweaked the patch itself to follow the style of similar quirks
> (interdiff is below, plus a diff of the commit log).  Please make sure
> I didn't break it.
>
> I also went out on a limb and reworded the comment to give what I
> *think* is the justification for this patch, as opposed to merely a
> description of the code.  I'm making a lot of assumptions there, so
> please confirm that they're correct, or supply alternate justification
> if they're not.
>
> > ---
> >  drivers/pci/quirks.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 0f16acc..f9584c0 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4466,6 +4466,21 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
> >       return acs_flags ? 0 : 1;
> >  }
> >
> > +static int pcie_quirk_brcm_bridge_acs(struct pci_dev *dev, u16 acs_flags)
> > +{
> > +     /*
> > +      * IPROC PAXB RC doesn't support ACS capabilities and control registers.
> > +      * Add quirk to to have separate IOMMU groups for all EPs and functions
> > +      * connected to root port, by masking RR/CR/SV/UF bits.
> > +      */
> > +
> > +     u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
> > +     int ret = acs_flags & ~flags ? 0 : 1;
> > +
> > +     return ret;
> > +}
> > +
> > +
> >  static const struct pci_dev_acs_enabled {
> >       u16 vendor;
> >       u16 device;
> > @@ -4559,6 +4574,7 @@ static const struct pci_dev_acs_enabled {
> >       { PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
> >       { PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
> >       { PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
> > +     { PCI_VENDOR_ID_BROADCOM, 0xD714, pcie_quirk_brcm_bridge_acs },
> >       { 0 }
> >  };
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 77c0330ac922..2edbce35e8c5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4466,21 +4466,19 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>         return acs_flags ? 0 : 1;
>  }
>
> -static int pcie_quirk_brcm_bridge_acs(struct pci_dev *dev, u16 acs_flags)
> +static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>  {
>         /*
> -        * IPROC PAXB RC doesn't support ACS capabilities and control registers.
> -        * Add quirk to to have separate IOMMU groups for all EPs and functions
> -        * connected to root port, by masking RR/CR/SV/UF bits.
> +        * iProc PAXB Root Ports don't advertise an ACS capability, but
> +        * they do not allow peer-to-peer transactions between Root Ports.
> +        * Allow each Root Port to be in a separate IOMMU group by masking
> +        * SV/RR/CR/UF bits.
>          */
> +       acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>
> -       u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
> -       int ret = acs_flags & ~flags ? 0 : 1;
> -
> -       return ret;
> +       return acs_flags ? 0 : 1;
>  }
>
> -
>  static const struct pci_dev_acs_enabled {
>         u16 vendor;
>         u16 device;
> @@ -4574,7 +4572,7 @@ static const struct pci_dev_acs_enabled {
>         { PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
>         { PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
>         { PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
> -       { PCI_VENDOR_ID_BROADCOM, 0xD714, pcie_quirk_brcm_bridge_acs },
> +       { PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
>         { 0 }
>  };
>
>
>
>
> @@ -1,49 +1,49 @@
> -commit b50ae502eff0
> +commit 46b2c32df7a4
>  Author: Abhinav Ratna <abhinav.ratna@broadcom.com>
>  Date:   Tue Aug 20 10:09:45 2019 +0530
>
> -    PCI: Add PCIE ACS quirk for IPROC PAXB
> +    PCI: Add ACS quirk for iProc PAXB
>
> -    IPROC PAXB RC doesn't support ACS capabilities and control registers.
> -    Add quirk to have separate IOMMU groups for all EPs and functions connected
> -    to root port, by masking RR/CR/SV/UF bits.
> +    iProc PAXB Root Ports don't advertise an ACS capability, but they do not
> +    allow peer-to-peer transactions between Root Ports.  Add an ACS quirk so
> +    each Root Port can be in a separate IOMMU group.
>
> +    [bhelgaas: commit log, comment, use common implementation style]
>      Link: https://lore.kernel.org/r/1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com
>      Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
>      Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> +    Acked-by: Scott Branden <scott.branden@broadcom.com>
>
