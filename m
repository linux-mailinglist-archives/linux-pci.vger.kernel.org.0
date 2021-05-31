Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EBA3963B9
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhEaPbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhEaP2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 11:28:32 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DDC061346;
        Mon, 31 May 2021 07:19:36 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id w20-20020a4a35540000b02902458551c0d6so994660oog.7;
        Mon, 31 May 2021 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDfX2HSRthSAwFOhfcgrv2kIX6nUuXxqclY45+cSOZk=;
        b=RsUgQnkatkp5GYCcrb9dJT/lY0Km4Bo5ok2suTJhlSrG+ZrB4cBJKMvPzYleh7eapE
         8aP3zmUp0YJSPrfharac0vFXDLrdP4xrPvcO/+n7lma6ow+Sq3M4vYIC+/GqY0ES/l+z
         NMkIptpI1wRw+01U0XnsY5bb9LhmYY+INlz0VUunfbYHOUes7flq4tcaQI2clLXinQhG
         q/C85zC9MCg9XP9A2Oq+qYEFsYopYEjuIKTMxR6LAuLeNBYrrfgZm33iAMhkIfvfxXk3
         LlVY6vaIIo+Hg347fpDJKYdxCstCAf4lD1IBCTVyO9f4eesawITiMYadbHR+p9TsqvUF
         2kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDfX2HSRthSAwFOhfcgrv2kIX6nUuXxqclY45+cSOZk=;
        b=KdATuhU7kDCzfipH+Kl8Gpp05G2X+exgMDDWDEyHqA6PWsNMBIxI+S2B7F2BFz2Lro
         hij08o06hUByYUD+JoISoVBiakksTbDce+3GUhipwbqaNs3nQYO9nZUKAVHj6j/Zxv0/
         20s1YAuV5ZtZLobr6+mEdGGZZ/eygR1SaSijo+m0chFb6+fVXWPkjBR075BVWFgSVG2i
         +dDxWlIpcl2RguerXRPHbpfL6nwG1QQdWNJzuT+fVoR2ruD/hXQ/K5PxZMssS9KdvjrX
         K4Tq31wiLtZkKl11Ygr9jQGjVWNwOIh86jH3RSSy140sN5KcXu51YNTpqkJrCeNDpT3+
         HVUQ==
X-Gm-Message-State: AOAM531llipkLPCtKa6etlBFKkoxgM7CGJ3RjZJ+9usNcxfZRne3NVu/
        HZ2egTEPZVdiO4r1BgwrQ5AOvkPWtuBHb0+XkPs=
X-Google-Smtp-Source: ABdhPJw7i9qJfygff6IcvcF8ZMASydrDUE+wS2x3QJmfSR2snmuTklPDIxXppz5mWtXFktTUUN8Pp6kLsG7vvYJhBA0=
X-Received: by 2002:a05:6820:54e:: with SMTP id n14mr16426798ooj.49.1622470775363;
 Mon, 31 May 2021 07:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com> <20210531131431.bzsvmefqdyawmeo2@pali>
 <CAMhs-H80=7jctPT70rOmcwcqPw+9iUF84_ZCgGr-TKwJ4eB2Lg@mail.gmail.com> <20210531135041.42ovpmbwuc3yfkaw@pali>
In-Reply-To: <20210531135041.42ovpmbwuc3yfkaw@pali>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 31 May 2021 16:19:23 +0200
Message-ID: <CAMhs-H_fR5aXJ=diTm-2yhgjjv9S6N6jA-DOZ0K_BnQ4UHHh3Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: pci: Add driver for MT7621 PCIe controller
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 31, 2021 at 3:50 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Monday 31 May 2021 15:39:55 Sergio Paracuellos wrote:
> > Hi Pali,
> >
> > Thanks for your comments.
> >
> > On Mon, May 31, 2021 at 3:14 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wrote:
> > > > This patch adds a driver for the PCIe controller of MT7621 SoC.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >  arch/mips/pci/Makefile     |   1 +
> > > >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++++++++++++=
++++
> > > >  arch/mips/ralink/Kconfig   |   9 +-
> > > >  3 files changed, 633 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/mips/pci/pci-mt7621.c
> > > >
> > > > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> > > > index f3eecc065e5c..178c550739c4 100644
> > > > --- a/arch/mips/pci/Makefile
> > > > +++ b/arch/mips/pci/Makefile
> > > > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    +=3D pci-ar2315.o
> > > >  obj-$(CONFIG_SOC_AR71XX)     +=3D pci-ar71xx.o
> > > >  obj-$(CONFIG_PCI_AR724X)     +=3D pci-ar724x.o
> > > >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       +=3D pci-xtalk-bridge.o
> > > > +obj-$(CONFIG_PCI_MT7621)     +=3D pci-mt7621.o
> > > >  #
> > > >  # These are still pretty much in the old state, watch, go blind.
> > > >  #
> > > > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/pci-mt7621.=
c
> > > > new file mode 100644
> > > > index 000000000000..fe1945819d25
> > > > --- /dev/null
> > > > +++ b/arch/mips/pci/pci-mt7621.c
> > > ...
> > > > +static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
> > > > +{
> > > > +     struct device *dev =3D pcie->dev;
> > > > +     struct mt7621_pcie_port *port;
> > > > +     u8 num_slots_enabled =3D 0;
> > > > +     u32 slot;
> > > > +     u32 val;
> > > > +     int err;
> > > > +
> > > > +     /* Setup MEMWIN and IOWIN */
> > > > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> > > > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
> > > > +
> > > > +     list_for_each_entry(port, &pcie->ports, list) {
> > > > +             if (port->enabled) {
> > > > +                     err =3D clk_prepare_enable(port->clk);
> > > > +                     if (err) {
> > > > +                             dev_err(dev, "enabling clk pcie%d\n",=
 slot);
> > > > +                             return err;
> > > > +                     }
> > > > +
> > > > +                     mt7621_pcie_enable_port(port);
> > > > +                     dev_info(dev, "PCIE%d enabled\n", port->slot)=
;
> > > > +                     num_slots_enabled++;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     for (slot =3D 0; slot < num_slots_enabled; slot++) {
> > > > +             val =3D read_config(pcie, slot, PCI_COMMAND);
> > > > +             val |=3D PCI_COMMAND_MASTER;
> > > > +             write_config(pcie, slot, PCI_COMMAND, val);
> > >
> > > Hello! Is this part of code correct? Because it looks strange if PCIe
> > > controller driver automatically enables PCI bus mastering, prior devi=
ce
> > > driver initialize itself.
> > >
> > > Moreover kernel has already function pci_set_master() for this purpos=
e
> > > which is used by device drivers.
> > >
> > > So I think this code can confuse some device drivers...
> >
> > I agree that we have pci_set_master() to be used in pci device driver
> > code. Original controller driver set this bit for enabled slots. Since
> > there is no documentation at all for the PCI in this SoC
>
> I see... this is really a big problem to do any driver development...

For sure it is :(.

>
> > I have
> > maintained the setting in the driver in a cleaner way. See original
> > driver code and the setting here [0]. There is no other reason than
> > that. I am ok with removing this from here and testing with my two
> > devices that everything is still ok if having this setting in the pci
> > controller driver is a real problem.
>
> You can run lspci -nnvv with and without PCI_COMMAND_MASTER code and
> then compare outputs.
>
> Device drivers for sure enable PCI_COMMAND_MASTER at the time when it is
> needed, so it is possible that there would be no difference in lspci
> output.

Thanks. I will take this into account when v2 is submitted after more
review comments come :).

>
> > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git=
/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=3Dv4.18#n676
> >
> > Best regards,
> >     Sergio Paracuellos
> > >
> > > > +             /* configure RC FTS number to 250 when it leaves L0s =
*/
> > > > +             val =3D read_config(pcie, slot, PCIE_FTS_NUM);
> > > > +             val &=3D ~PCIE_FTS_NUM_MASK;
> > > > +             val |=3D PCIE_FTS_NUM_L0(0x50);
> > > > +             write_config(pcie, slot, PCIE_FTS_NUM, val);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
