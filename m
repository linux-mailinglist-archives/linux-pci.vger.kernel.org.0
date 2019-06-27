Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3A5852B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0PFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 11:05:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33717 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0PFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 11:05:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so2629139otl.0;
        Thu, 27 Jun 2019 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O0XCxuorjswkPplhsmn/HBnujxspqXsxXtYmC3LOHTg=;
        b=h7EOGaZKupRttL09s5vsxfmmaShXoYqW8jvA34nqdjHdO3z0vgm3C4zP5EGoH9zbKZ
         7e9qhkfEDFh4so7r7GFX/lluZrb3yUcB6S+KJXnGCLXEGK4pxj263zlZzTkpqtxfWsQZ
         Rrr6Lnk96a55+fhqxrjFFPBgdGDGnK/5Nj+IrGTUsfVzgUHurS2bbXfKwcQuevS/ihX4
         Bigv26+NrZZwgUNts6h46a8Nz+KV/1TWCs/rUZgSN1OBHyUBwwBfEpEW8XwUvLVlr7IS
         d6hZ8Rgu+dciJf2RxIwF2iYl8wLIWyVqglLoxxPJCowL8yc0Bomq70kQGgn95Z3mT38+
         Cf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O0XCxuorjswkPplhsmn/HBnujxspqXsxXtYmC3LOHTg=;
        b=O10OYewpHLdek4UBiQCHZ/1/QWE3xl6QaeALb8t5ZmBqTwB94C6YrbRXiZbeEerL4p
         WnjIMd7jb2d7Z2bNd0MdSAFF5hz61lNzMDMZ4sOn6O/Pdh06rao03bT8YevKqMrCabUy
         VCyoyJGGOAIEL4GHGU1ccxwqJTjS7Oq63J7F3dKN3G1QmCgdjYi9FeeVKrLWsoxBAoI5
         FhPQ5FwOlLcvaL8HsK3xrHgVFNQ5ExjcqfInczPQ6NmEnHH3XX3JBgaL6x51sxa2LlP8
         M/LhJtDzT0jVmjxl+AtaIR43bkqzpMV4xfprcAyCNzzzK38blw4sr2Jg2cA9OjJB4atx
         gxNw==
X-Gm-Message-State: APjAAAWr0MAka+UdAMm8E1dy/+gnLjugVVElfdtBTxpzGKXWuGaU5LWw
        uriH7FEXFwAKmCJsO0Po1S+LULXrwH848lrDPS8=
X-Google-Smtp-Source: APXvYqzDwII9OX7NR63qQoDiNn2ivK6Zdyi51dEiq6A7pBKZLJnzZidQVf/+rRFhnulTyR1gmcWFSKaqKIIk4FJHeZE=
X-Received: by 2002:a9d:7b4d:: with SMTP id f13mr3589359oto.164.1561647950972;
 Thu, 27 Jun 2019 08:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <1542633272-16161-1-git-send-email-sundeep.lkml@gmail.com> <20190417201645.GR126710@google.com>
In-Reply-To: <20190417201645.GR126710@google.com>
From:   sundeep subbaraya <sundeep.lkml@gmail.com>
Date:   Thu, 27 Jun 2019 20:35:39 +0530
Message-ID: <CALHRZupnBFHfiLJcyi5589HPB_MZbQnv1FEQXzYypO_LTezXjQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: assign bus numbers present in EA capability for bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Stalley, Sean" <sean.stalley@intel.com>, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Apr 18, 2019 at 1:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 19, 2018 at 06:44:32PM +0530, sundeep.lkml@gmail.com wrote:
> > From: Subbaraya Sundeep <sbhatta@marvell.com>
> >
> > As per the spec, bridges with EA capability work
> > with fixed secondary and subordinate bus numbers.
> > Hence assign bus numbers to bridges from EA if the
> > capability exists.
> >
> > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>
> I applied this with minor revisions to pci/enumeration for v5.2,
> thanks!
>
> > ---
> > Changes for v2:
> >       No changes just added Sean Stalley who did EA support for BARs.
> >
> >  drivers/pci/probe.c           | 58 +++++++++++++++++++++++++++++++++++=
+++++---
> >  include/uapi/linux/pci_regs.h |  6 +++++
> >  2 files changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b1c05b5..f41d2e6 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1030,6 +1030,40 @@ static void pci_enable_crs(struct pci_dev *pdev)
> >
> >  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> >                                             unsigned int available_buse=
s);
> > +/*
> > + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> > + * numbers from EA capability.
> > + * @dev: Bridge with EA
> > + * @secondary: updated with secondary bus number in EA
> > + * @subordinate: updated with subordinate bus number in EA
> > + *
> > + * If it is a bridge with EA capability then fixed bus numbers are
> > + * read from EA capability list and secondary, subordinate reference
> > + * variables will be updated. Otherwise secondary and subordinate refe=
rence
> > + * variables will be zeroed.
> > + */
> > +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *secondary,
> > +                             u8 *subordinate)
> > +{
> > +     int ea;
> > +     int offset;
> > +     u32 dw;
> > +
> > +     *secondary =3D *subordinate =3D 0;
> > +
> > +     if (dev->hdr_type !=3D PCI_HEADER_TYPE_BRIDGE)
> > +             return;
> > +
> > +     /* find PCI EA capability in list */
> > +     ea =3D pci_find_capability(dev, PCI_CAP_ID_EA);
> > +     if (!ea)
> > +             return;
> > +
> > +     offset =3D ea + PCI_EA_FIRST_ENT;
> > +     pci_read_config_dword(dev, offset, &dw);
> > +     *secondary =3D  dw & PCI_EA_SEC_BUS_MASK;
> > +     *subordinate =3D (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHI=
FT;
> > +}
> >
> >  /*
> >   * pci_scan_bridge_extend() - Scan buses behind a bridge
> > @@ -1064,6 +1098,8 @@ static int pci_scan_bridge_extend(struct pci_bus =
*bus, struct pci_dev *dev,
> >       u16 bctl;
> >       u8 primary, secondary, subordinate;
> >       int broken =3D 0;
> > +     u8 fixed_sec, fixed_sub;
> > +     int next_busnr;
> >
> >       /*
> >        * Make sure the bridge is powered on to be able to access config
> > @@ -1163,17 +1199,25 @@ static int pci_scan_bridge_extend(struct pci_bu=
s *bus, struct pci_dev *dev,
> >               /* Clear errors */
> >               pci_write_config_word(dev, PCI_STATUS, 0xffff);
> >
> > +             /* read bus numbers from EA */
> > +             pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> > +
> > +             next_busnr =3D max + 1;
> > +             /* Use secondary bus number in EA */
> > +             if (fixed_sec)
> > +                     next_busnr =3D fixed_sec;
>
> I initially thought this was not quite safe because EA could supply a
> secondary bus number of 0, in which case we would erroneously ignore
> it. But it's actually not possible for a PCI-to-PCI bridge to have a

When EA supplies secondary bus number as 0 then we
should proceed with normal sequence where we scan with max + 1
as bus number for next round. Otherwise subordinate bus number
will always be returning zero.

As per the spec, regd. Fixed Secondary Bus Number and
Fixed Subordinate Bus Number:

"If at least one Function that uses EA is located behind this function,
 then this field must be set to indicate the bus number of the PCI bus segm=
ent
 to which the secondary interface of this Function is connected.
 If no Function that uses EA is located behind this function,
 then this field must be set to all 0=E2=80=99s."
which implies that normal enumeration should take place behind this
last EA bridge.

Shall I revert your changes which returns bool ?
Or simply add a check  if (fixed_buses && fixed_sec) ?

Sorry for the trouble.

Thanks,
Sundeep

> secondary bus number of 0, so it *is* safe.
>
> But it's still a little subtle and since I've already done the work to
> add a bool return value from pci_ea_fixed_busnrs(), maybe it will be
> OK to keep that.  The patch as applied is below, let me know if you
> have any comments.
>
> > +
> >               /*
> >                * Prevent assigning a bus number that already exists.
> >                * This can happen when a bridge is hot-plugged, so in th=
is
> >                * case we only re-scan this bus.
> >                */
> > -             child =3D pci_find_bus(pci_domain_nr(bus), max+1);
> > +             child =3D pci_find_bus(pci_domain_nr(bus), next_busnr);
> >               if (!child) {
> > -                     child =3D pci_add_new_bus(bus, dev, max+1);
> > +                     child =3D pci_add_new_bus(bus, dev, next_busnr);
> >                       if (!child)
> >                               goto out;
> > -                     pci_bus_insert_busn_res(child, max+1,
> > +                     pci_bus_insert_busn_res(child, next_busnr,
> >                                               bus->busn_res.end);
> >               }
> >               max++;
> > @@ -1234,7 +1278,13 @@ static int pci_scan_bridge_extend(struct pci_bus=
 *bus, struct pci_dev *dev,
> >                       max +=3D i;
> >               }
> >
> > -             /* Set subordinate bus number to its real value */
> > +             /*
> > +              * Set subordinate bus number to its real value.
> > +              * If fixed subordinate bus number exists from EA
> > +              * capability then use it.
> > +              */
> > +             if (fixed_sub)
> > +                     max =3D fixed_sub;
> >               pci_bus_update_busn_res_end(child, max);
> >               pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
> >       }
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index e1e9888..c3d0904 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -372,6 +372,12 @@
> >  #define PCI_EA_FIRST_ENT_BRIDGE      8       /* First EA Entry for Bri=
dges */
> >  #define  PCI_EA_ES           0x00000007 /* Entry Size */
> >  #define  PCI_EA_BEI          0x000000f0 /* BAR Equivalent Indicator */
> > +
> > +/* EA fixed Secondary and Subordinate bus numbers for Bridge */
> > +#define PCI_EA_SEC_BUS_MASK  0xff
> > +#define PCI_EA_SUB_BUS_MASK  0xff00
> > +#define PCI_EA_SUB_BUS_SHIFT 8
> > +
> >  /* 0-5 map to BARs 0-5 respectively */
> >  #define   PCI_EA_BEI_BAR0            0
> >  #define   PCI_EA_BEI_BAR5            5
> > --
> > 1.8.3.1
> >
>
> commit 2dbce5901179
> Author: Subbaraya Sundeep <sbhatta@marvell.com>
> Date:   Mon Nov 19 18:44:32 2018 +0530
>
>     PCI: Assign bus numbers present in EA capability for bridges
>
>     The "Enhanced Allocation (EA) for Memory and I/O Resources" ECN, appr=
oved
>     23 October 2014, sec 6.9.1.2, specifies a second DW in the capability=
 for
>     type 1 (bridge) functions to describe fixed secondary and subordinate=
 bus
>     numbers.  This ECN was included in the PCIe r4.0 spec, but sec 6.9.1.=
2 was
>     omitted, presumably by mistake.
>
>     Read fixed bus numbers from the EA capability for bridges.
>
>     Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>     [bhelgaas: add pci_ea_fixed_busnrs() return value]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 012250a78da7..a6874c306908 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1086,6 +1086,36 @@ static void pci_enable_crs(struct pci_dev *pdev)
>
>  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>                                               unsigned int available_buse=
s);
> +/**
> + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> + * numbers from EA capability.
> + * @dev: Bridge
> + * @sec: updated with secondary bus number from EA
> + * @sub: updated with subordinate bus number from EA
> + *
> + * If @dev is a bridge with EA capability, update @sec and @sub with
> + * fixed bus numbers from the capability and return true.  Otherwise,
> + * return false.
> + */
> +static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
> +{
> +       int ea, offset;
> +       u32 dw;
> +
> +       if (dev->hdr_type !=3D PCI_HEADER_TYPE_BRIDGE)
> +               return false;
> +
> +       /* find PCI EA capability in list */
> +       ea =3D pci_find_capability(dev, PCI_CAP_ID_EA);
> +       if (!ea)
> +               return false;
> +
> +       offset =3D ea + PCI_EA_FIRST_ENT;
> +       pci_read_config_dword(dev, offset, &dw);
> +       *sec =3D  dw & PCI_EA_SEC_BUS_MASK;
> +       *sub =3D (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> +       return true;
> +}
>
>  /*
>   * pci_scan_bridge_extend() - Scan buses behind a bridge
> @@ -1120,6 +1150,9 @@ static int pci_scan_bridge_extend(struct pci_bus *b=
us, struct pci_dev *dev,
>         u16 bctl;
>         u8 primary, secondary, subordinate;
>         int broken =3D 0;
> +       bool fixed_buses;
> +       u8 fixed_sec, fixed_sub;
> +       int next_busnr;
>
>         /*
>          * Make sure the bridge is powered on to be able to access config
> @@ -1219,17 +1252,24 @@ static int pci_scan_bridge_extend(struct pci_bus =
*bus, struct pci_dev *dev,
>                 /* Clear errors */
>                 pci_write_config_word(dev, PCI_STATUS, 0xffff);
>
> +               /* Read bus numbers from EA Capability (if present) */
> +               fixed_buses =3D pci_ea_fixed_busnrs(dev, &fixed_sec, &fix=
ed_sub);
> +               if (fixed_buses)
> +                       next_busnr =3D fixed_sec;
> +               else
> +                       next_busnr =3D max + 1;
> +
>                 /*
>                  * Prevent assigning a bus number that already exists.
>                  * This can happen when a bridge is hot-plugged, so in th=
is
>                  * case we only re-scan this bus.
>                  */
> -               child =3D pci_find_bus(pci_domain_nr(bus), max+1);
> +               child =3D pci_find_bus(pci_domain_nr(bus), next_busnr);
>                 if (!child) {
> -                       child =3D pci_add_new_bus(bus, dev, max+1);
> +                       child =3D pci_add_new_bus(bus, dev, next_busnr);
>                         if (!child)
>                                 goto out;
> -                       pci_bus_insert_busn_res(child, max+1,
> +                       pci_bus_insert_busn_res(child, next_busnr,
>                                                 bus->busn_res.end);
>                 }
>                 max++;
> @@ -1290,7 +1330,13 @@ static int pci_scan_bridge_extend(struct pci_bus *=
bus, struct pci_dev *dev,
>                         max +=3D i;
>                 }
>
> -               /* Set subordinate bus number to its real value */
> +               /*
> +                * Set subordinate bus number to its real value.
> +                * If fixed subordinate bus number exists from EA
> +                * capability then use it.
> +                */
> +               if (fixed_buses)
> +                       max =3D fixed_sub;
>                 pci_bus_update_busn_res_end(child, max);
>                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
>         }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 5c98133f2c94..c51e0066de8b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -372,6 +372,12 @@
>  #define PCI_EA_FIRST_ENT_BRIDGE        8       /* First EA Entry for Bri=
dges */
>  #define  PCI_EA_ES             0x00000007 /* Entry Size */
>  #define  PCI_EA_BEI            0x000000f0 /* BAR Equivalent Indicator */
> +
> +/* EA fixed Secondary and Subordinate bus numbers for Bridge */
> +#define PCI_EA_SEC_BUS_MASK    0xff
> +#define PCI_EA_SUB_BUS_MASK    0xff00
> +#define PCI_EA_SUB_BUS_SHIFT   8
> +
>  /* 0-5 map to BARs 0-5 respectively */
>  #define   PCI_EA_BEI_BAR0              0
>  #define   PCI_EA_BEI_BAR5              5
