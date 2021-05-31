Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD872395FA1
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhEaON3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 10:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhEaOLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 10:11:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB46C035433;
        Mon, 31 May 2021 06:40:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so11084485otp.11;
        Mon, 31 May 2021 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ozF7Nw0gMrrvzPjGZChhJPIjE3+nOGNmHfCPhJPHLRQ=;
        b=AnpSaFAXu0Lf0o787EGCw9Q4WRtBu2uEFo9T3b5CSo+FlZFV4Z7ooh8U9B81yPaMhl
         1rF05/vSgb0CmLrTmbUykug3Sa7TTVmyYOGQeax7aDnUQ6fBkqFGViKZwAWeOmqzXspv
         6/HfRqagSQ2G0ZYzATf1HPcZikDpx5IUy9u7vpMq9GmuLToyRSR4Rade8EwrJvfbkaJJ
         Q7ejJYb76pKVePyQF17TG7i/+k0QHdn2fH2Ifhg3/jPzrSFYGZ4a8a/W37MpeAXEfcLF
         H3e6fmXYaHs1MnDiMWx/hLvg7LUQvePyZJKCaP2K7+zpVOWJLsfsdjV3hwhEl6hHPDfg
         GyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ozF7Nw0gMrrvzPjGZChhJPIjE3+nOGNmHfCPhJPHLRQ=;
        b=pICcOiF5M1KMGZ1PhBxmg3A54NT9rLiydxQ796/rR7vNwaQSAGpDP7W3Tp4psj9nFV
         h0G+ueLN3zZrisvGLahlYjQXyrAyaTMc5VaEeanjqLODnKVXDrDPMBZ2RT80PbE8gGyJ
         LOxn7OQgQ2lD3MJp5+7fRfedSOfhlrpqW2pzxDprueP8d8knUoJguoaFxzfWjNzAWc02
         uiFpZxv/h2ETjzeXQWijiNA1hSzTDabvt3GNk2wGB0cWG4wf/8Pg8UQHxTsyQrqzLxrM
         yy4kPitNYijZPZQzyCLSOTHnRpqIGGI26sarTSJnPDTGhJnyQNnS1o6HWOajCERuznNG
         MC7w==
X-Gm-Message-State: AOAM531JPznnn2+GaYQNSyVqhJyuJZKdo8vO2DVP3wcs8ajq4bwqvvHl
        XMBVrTcHBCcv+yCb8MTqVOdMBZV+0mSlysAo36UWyesMmuWqO/bA
X-Google-Smtp-Source: ABdhPJzqgggxS8X7nyAo0DAvgmmlEzBHLmjc2yp0dBZreoZQ8hJGpTy1Bhx84M9jYQwuR3EsrX0b409L5yEU267ChAs=
X-Received: by 2002:a9d:4592:: with SMTP id x18mr7969267ote.74.1622468406360;
 Mon, 31 May 2021 06:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com> <20210531131431.bzsvmefqdyawmeo2@pali>
In-Reply-To: <20210531131431.bzsvmefqdyawmeo2@pali>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 31 May 2021 15:39:55 +0200
Message-ID: <CAMhs-H80=7jctPT70rOmcwcqPw+9iUF84_ZCgGr-TKwJ4eB2Lg@mail.gmail.com>
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

Hi Pali,

Thanks for your comments.

On Mon, May 31, 2021 at 3:14 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wrote:
> > This patch adds a driver for the PCIe controller of MT7621 SoC.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  arch/mips/pci/Makefile     |   1 +
> >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++++++++++++++++
> >  arch/mips/ralink/Kconfig   |   9 +-
> >  3 files changed, 633 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/mips/pci/pci-mt7621.c
> >
> > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> > index f3eecc065e5c..178c550739c4 100644
> > --- a/arch/mips/pci/Makefile
> > +++ b/arch/mips/pci/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    +=3D pci-ar2315.o
> >  obj-$(CONFIG_SOC_AR71XX)     +=3D pci-ar71xx.o
> >  obj-$(CONFIG_PCI_AR724X)     +=3D pci-ar724x.o
> >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       +=3D pci-xtalk-bridge.o
> > +obj-$(CONFIG_PCI_MT7621)     +=3D pci-mt7621.o
> >  #
> >  # These are still pretty much in the old state, watch, go blind.
> >  #
> > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/pci-mt7621.c
> > new file mode 100644
> > index 000000000000..fe1945819d25
> > --- /dev/null
> > +++ b/arch/mips/pci/pci-mt7621.c
> ...
> > +static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
> > +{
> > +     struct device *dev =3D pcie->dev;
> > +     struct mt7621_pcie_port *port;
> > +     u8 num_slots_enabled =3D 0;
> > +     u32 slot;
> > +     u32 val;
> > +     int err;
> > +
> > +     /* Setup MEMWIN and IOWIN */
> > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
> > +
> > +     list_for_each_entry(port, &pcie->ports, list) {
> > +             if (port->enabled) {
> > +                     err =3D clk_prepare_enable(port->clk);
> > +                     if (err) {
> > +                             dev_err(dev, "enabling clk pcie%d\n", slo=
t);
> > +                             return err;
> > +                     }
> > +
> > +                     mt7621_pcie_enable_port(port);
> > +                     dev_info(dev, "PCIE%d enabled\n", port->slot);
> > +                     num_slots_enabled++;
> > +             }
> > +     }
> > +
> > +     for (slot =3D 0; slot < num_slots_enabled; slot++) {
> > +             val =3D read_config(pcie, slot, PCI_COMMAND);
> > +             val |=3D PCI_COMMAND_MASTER;
> > +             write_config(pcie, slot, PCI_COMMAND, val);
>
> Hello! Is this part of code correct? Because it looks strange if PCIe
> controller driver automatically enables PCI bus mastering, prior device
> driver initialize itself.
>
> Moreover kernel has already function pci_set_master() for this purpose
> which is used by device drivers.
>
> So I think this code can confuse some device drivers...

I agree that we have pci_set_master() to be used in pci device driver
code. Original controller driver set this bit for enabled slots. Since
there is no documentation at all for the PCI in this SoC I have
maintained the setting in the driver in a cleaner way. See original
driver code and the setting here [0]. There is no other reason than
that. I am ok with removing this from here and testing with my two
devices that everything is still ok if having this setting in the pci
controller driver is a real problem.

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tre=
e/drivers/staging/mt7621-pci/pci-mt7621.c?h=3Dv4.18#n676

Best regards,
    Sergio Paracuellos
>
> > +             /* configure RC FTS number to 250 when it leaves L0s */
> > +             val =3D read_config(pcie, slot, PCIE_FTS_NUM);
> > +             val &=3D ~PCIE_FTS_NUM_MASK;
> > +             val |=3D PCIE_FTS_NUM_L0(0x50);
> > +             write_config(pcie, slot, PCIE_FTS_NUM, val);
> > +     }
> > +
> > +     return 0;
> > +}
