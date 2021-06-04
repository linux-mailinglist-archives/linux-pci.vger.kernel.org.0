Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590C339BFD5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFDSqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDSqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 14:46:55 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4CC061766;
        Fri,  4 Jun 2021 11:44:54 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so2460860ood.2;
        Fri, 04 Jun 2021 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o3rYJ76FixDzOS9iwZUZ7yx69C717pHMadayVbZaeWc=;
        b=D8ginavGPOT6nXK5JT1A1KyH7ikEp+u3x7899Mw83emvJ8Ix1YYagtbBalHIdJn2Zc
         ySHwwpCU5AqdLGuvhHDCZ7qwJfuW8UPJO6TW4GrvF3kvSyqaAOQa9N0DQsjpWqvgW5jv
         xQFQwb/nN+3e17jkXZb36B3pI8UeuC2DNNveSYl9l//zbjLTxrQAJQuK+I0cE/h9EIjF
         C+mk7wTj+BAkmanWBcMdiKM5SUT8Oj6IhiW9D0WxKr1/NYcid34MYyl1iTzTjmXSKsSu
         UYsnVvbpNs0ntqgvsUkMwcYx8Whd8L9xfytHFkK5RRxKHeoCmLMKnm4bMvw6laoOncr3
         M3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o3rYJ76FixDzOS9iwZUZ7yx69C717pHMadayVbZaeWc=;
        b=q7+cjXRVyHQOCPLw3PvCyZwSGdP+Gf1TmIHfzxRDXaPaUCDeN8lUG0ul4egtH/74bG
         hwpQkW7jADFL+Ful4JXUweZldmqe5XyNCYcB083by0Y9TAcjaYXCV3uxOXnRYUQ25GVC
         aEbt2f+rCWAmZbRpAjz35fiHKtOV51DyshgJpGzn42WPxsqFCJOu7hSD4ZpcwtKhZts6
         Qg4x10pjxUi903UNaPX0Sn+KlBZqoQ11dvFAI/gqMWPxdP3gIo+CBqM2gHHfPEOu0suf
         qf8/d30E2o2ndH+Qkt0Yl0CcVBlPRQttXDh9sEo0gXJtXOLnG77XbAiDJ/2CyTV6wlVK
         M8Sw==
X-Gm-Message-State: AOAM531ZgveismsiEXp9dHyyGir6NvwrZQR8xmvVcuqOZtyNoNGjPkvg
        Jr2/AvNlvnAZTFBGO6bENgMnTi0w7nmTjJMdIa8=
X-Google-Smtp-Source: ABdhPJyTdvEqoVD+bZAniWjuYBvJKoGPizMFALMOjktBTgLPorCoV0FeQXuNEi//rethP6NNSlfQlnqij2qVmgJPmQE=
X-Received: by 2002:a05:6820:54e:: with SMTP id n14mr4656881ooj.49.1622832293772;
 Fri, 04 Jun 2021 11:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com> <20210531131431.bzsvmefqdyawmeo2@pali>
 <CAMhs-H80=7jctPT70rOmcwcqPw+9iUF84_ZCgGr-TKwJ4eB2Lg@mail.gmail.com>
 <20210531135041.42ovpmbwuc3yfkaw@pali> <CAMhs-H_fR5aXJ=diTm-2yhgjjv9S6N6jA-DOZ0K_BnQ4UHHh3Q@mail.gmail.com>
 <CAMhs-H8EwQDvZtzpPn2u_WOWt1wcixOvz5nVZP2miM6j0+P7EA@mail.gmail.com>
 <20210602122337.fxwaikulbawwkc2j@pali> <CAMhs-H8Gr=ObgMZAZ9VuNqHX4TaKQPPGNNMY4pzh9o=3EbAgUQ@mail.gmail.com>
 <20210604165525.ybgyusazeyzx642v@pali>
In-Reply-To: <20210604165525.ybgyusazeyzx642v@pali>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 4 Jun 2021 20:44:42 +0200
Message-ID: <CAMhs-H9d2UDZ_uSjD8D_KN5Yj4MokYZqQUSgc_-XpwqpqYRytQ@mail.gmail.com>
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

On Fri, Jun 4, 2021 at 6:55 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 02 June 2021 14:43:53 Sergio Paracuellos wrote:
> > Hi Pali,
> >
> > On Wed, Jun 2, 2021 at 2:23 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > On Wednesday 02 June 2021 14:16:26 Sergio Paracuellos wrote:
> > > > Hi Pali,
> > > >
> > > > On Mon, May 31, 2021 at 4:19 PM Sergio Paracuellos
> > > > <sergio.paracuellos@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 31, 2021 at 3:50 PM Pali Roh=C3=A1r <pali@kernel.org>=
 wrote:
> > > > > >
> > > > > > On Monday 31 May 2021 15:39:55 Sergio Paracuellos wrote:
> > > > > > > Hi Pali,
> > > > > > >
> > > > > > > Thanks for your comments.
> > > > > > >
> > > > > > > On Mon, May 31, 2021 at 3:14 PM Pali Roh=C3=A1r <pali@kernel.=
org> wrote:
> > > > > > > >
> > > > > > > > On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wrote:
> > > > > > > > > This patch adds a driver for the PCIe controller of MT762=
1 SoC.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gma=
il.com>
> > > > > > > > > ---
> > > > > > > > >  arch/mips/pci/Makefile     |   1 +
> > > > > > > > >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  arch/mips/ralink/Kconfig   |   9 +-
> > > > > > > > >  3 files changed, 633 insertions(+), 1 deletion(-)
> > > > > > > > >  create mode 100644 arch/mips/pci/pci-mt7621.c
> > > > > > > > >
> > > > > > > > > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makef=
ile
> > > > > > > > > index f3eecc065e5c..178c550739c4 100644
> > > > > > > > > --- a/arch/mips/pci/Makefile
> > > > > > > > > +++ b/arch/mips/pci/Makefile
> > > > > > > > > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    +=3D pci-ar=
2315.o
> > > > > > > > >  obj-$(CONFIG_SOC_AR71XX)     +=3D pci-ar71xx.o
> > > > > > > > >  obj-$(CONFIG_PCI_AR724X)     +=3D pci-ar724x.o
> > > > > > > > >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       +=3D pci-xtalk-brid=
ge.o
> > > > > > > > > +obj-$(CONFIG_PCI_MT7621)     +=3D pci-mt7621.o
> > > > > > > > >  #
> > > > > > > > >  # These are still pretty much in the old state, watch, g=
o blind.
> > > > > > > > >  #
> > > > > > > > > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/p=
ci-mt7621.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..fe1945819d25
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/arch/mips/pci/pci-mt7621.c
> > > > > > > > ...
> > > > > > > > > +static int mt7621_pcie_enable_ports(struct mt7621_pcie *=
pcie)
> > > > > > > > > +{
> > > > > > > > > +     struct device *dev =3D pcie->dev;
> > > > > > > > > +     struct mt7621_pcie_port *port;
> > > > > > > > > +     u8 num_slots_enabled =3D 0;
> > > > > > > > > +     u32 slot;
> > > > > > > > > +     u32 val;
> > > > > > > > > +     int err;
> > > > > > > > > +
> > > > > > > > > +     /* Setup MEMWIN and IOWIN */
> > > > > > > > > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> > > > > > > > > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE)=
;
> > > > > > > > > +
> > > > > > > > > +     list_for_each_entry(port, &pcie->ports, list) {
> > > > > > > > > +             if (port->enabled) {
> > > > > > > > > +                     err =3D clk_prepare_enable(port->cl=
k);
> > > > > > > > > +                     if (err) {
> > > > > > > > > +                             dev_err(dev, "enabling clk =
pcie%d\n", slot);
> > > > > > > > > +                             return err;
> > > > > > > > > +                     }
> > > > > > > > > +
> > > > > > > > > +                     mt7621_pcie_enable_port(port);
> > > > > > > > > +                     dev_info(dev, "PCIE%d enabled\n", p=
ort->slot);
> > > > > > > > > +                     num_slots_enabled++;
> > > > > > > > > +             }
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     for (slot =3D 0; slot < num_slots_enabled; slot++) =
{
> > > > > > > > > +             val =3D read_config(pcie, slot, PCI_COMMAND=
);
> > > > > > > > > +             val |=3D PCI_COMMAND_MASTER;
> > > > > > > > > +             write_config(pcie, slot, PCI_COMMAND, val);
> > > > > > > >
> > > > > > > > Hello! Is this part of code correct? Because it looks stran=
ge if PCIe
> > > > > > > > controller driver automatically enables PCI bus mastering, =
prior device
> > > > > > > > driver initialize itself.
> > > > > > > >
> > > > > > > > Moreover kernel has already function pci_set_master() for t=
his purpose
> > > > > > > > which is used by device drivers.
> > > > > > > >
> > > > > > > > So I think this code can confuse some device drivers...
> > > > > > >
> > > > > > > I agree that we have pci_set_master() to be used in pci devic=
e driver
> > > > > > > code. Original controller driver set this bit for enabled slo=
ts. Since
> > > > > > > there is no documentation at all for the PCI in this SoC
> > > > > >
> > > > > > I see... this is really a big problem to do any driver developm=
ent...
> > > > >
> > > > > For sure it is :(.
> > > > >
> > > > > >
> > > > > > > I have
> > > > > > > maintained the setting in the driver in a cleaner way. See or=
iginal
> > > > > > > driver code and the setting here [0]. There is no other reaso=
n than
> > > > > > > that. I am ok with removing this from here and testing with m=
y two
> > > > > > > devices that everything is still ok if having this setting in=
 the pci
> > > > > > > controller driver is a real problem.
> > > > > >
> > > > > > You can run lspci -nnvv with and without PCI_COMMAND_MASTER cod=
e and
> > > > > > then compare outputs.
> > > > > >
> > > > > > Device drivers for sure enable PCI_COMMAND_MASTER at the time w=
hen it is
> > > > > > needed, so it is possible that there would be no difference in =
lspci
> > > > > > output.
> > > > >
> > > > > Thanks. I will take this into account when v2 is submitted after =
more
> > > > > review comments come :).
> > > >
> > > > I have tested to remove this and check lspci -nnvv output with and
> > > > without PCI_COMMAND_MASTER code and, as you pointed out, there is n=
o
> > > > difference between them. Also, both boards are working without
> > > > regressions at all. So I will remove this code for next version.
> > >
> > > Perfect!
> > >
> > > > Thanks,
> > > >     Sergio Paracuellos
> > > > >
> > > > > >
> > > > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/s=
taging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=3Dv4.18#n676
> > > > > > >
> > > > > > > Best regards,
> > > > > > >     Sergio Paracuellos
> > > > > > > >
> > > > > > > > > +             /* configure RC FTS number to 250 when it l=
eaves L0s */
> > > > > > > > > +             val =3D read_config(pcie, slot, PCIE_FTS_NU=
M);
> > > > > > > > > +             val &=3D ~PCIE_FTS_NUM_MASK;
> > > > > > > > > +             val |=3D PCIE_FTS_NUM_L0(0x50);
> > > > > > > > > +             write_config(pcie, slot, PCIE_FTS_NUM, val)=
;
> > >
> > > Could you look also what is doing this code (PCIE_FTS_NUM)? It is mar=
ked
> > > as MT specific register. But from this code for me it looks like that=
 it
> > > just access config space of some device and therefore it could be som=
e
> > > standard PCIe register. Just with hardcoded calculated offset.
>
> So based on your lspci output, there is no PCIe capability register at
> address PCIE_FTS_NUM (0x70c), right? It seems strange to trying access
> capability register outside of capability list.

This setting is also in the original driver code from mediatek SDK. See [0]=
.
Anyway, I have tried to remove this code and test what happens with my
two boards and both of them seem to
work properly just by deleting this code.

>
> > > Could you provide output from lspci -nnvv? So other people could look=
 at
> > > it and maybe we decode what is this code doing and if it is needed.
> >
> > # lspci -nnvv
> > 00:02.0 PCI bridge [0604]: Device [0e8d:0801] (rev 01) (prog-if 00
> > [Normal decode])
>
> Hm... Device address is 02. But in your code is:
>
>     u8 num_slots_enabled =3D 0;
>     ...
>     list_for_each_entry(port, &pcie->ports, list) {
>         if (port->enabled) {
>             ...
>             num_slots_enabled++;
>             ...
>         }
>     }
>     ...
>     for (slot =3D 0; slot < num_slots_enabled; slot++) {
>         val =3D read_config(pcie, slot, ...);
>         ...
>         write_config(pcie, slot, ...);
>     }
>
> Which means that this code writes to config space of wrong device 0
> (instead of 2)! In function write_config() can be seen that second
> parameter specify device of BDF address for bus=3D0 and function=3D0.

Bridge enumeration depends on a virtual bridge register configuration.
But at the end devices connected to the bridge
are enumerated as 01:00.0, 02:00.0 and 03:00.0. So in this case the
phy used is the one for "pcie2" (00:02.0) and the device connected to
it
is 01:00.0. For example a board using all the virtual bridges will get
an output similar to:

[   16.487166] mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
[   16.500627] mt7621-pci 1e140000.pcie:   No bus range found for
/pcie@1e140000, using [bus 00-ff]
[   16.518212] mt7621-pci 1e140000.pcie:      MEM
0x0060000000..0x006fffffff -> 0x0000000000
[   16.534531] mt7621-pci 1e140000.pcie:       IO
0x001e160000..0x001e16ffff -> 0x0000000000
[   16.786498] mt7621-pci 1e140000.pcie: PCIE0 enabled
[   16.796220] mt7621-pci 1e140000.pcie: PCIE1 enabled
[   16.805943] mt7621-pci 1e140000.pcie: PCIE2 enabled
[   16.815664] mt7621-pci 1e140000.pcie: PCI coherence region base:
0x60000000, mask/settings: 0xf0000002
[   16.834398] mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
[   16.847098] pci_bus 0000:00: root bus resource [io  0x1e160000-0x1e16fff=
f]
[   16.860806] pci_bus 0000:00: root bus resource [mem 0x60000000-0x6ffffff=
f]
[   16.874504] pci_bus 0000:00: root bus resource [bus 00-ff]
[   16.885441] pci_bus 0000:00: root bus resource [mem
0x60000000-0x6fffffff] (bus address [0x00000000-0x0fffffff])
[   16.905773] pci 0000:00:00.0: [0e8d:0801] type 01 class 0x060400
[   16.917772] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff]
[   16.930260] pci 0000:00:00.0: reg 0x14: initial BAR value 0x00000000 inv=
alid
[   16.944304] pci 0000:00:00.0: reg 0x14: [mem size 0x00010000]
[   16.955841] pci 0000:00:00.0: supports D1
[   16.963837] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[   16.975747] pci 0000:00:01.0: [0e8d:0801] type 01 class 0x060400
[   16.987772] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x7fffffff]
[   17.000273] pci 0000:00:01.0: reg 0x14: initial BAR value 0x00000000 inv=
alid
[   17.014311] pci 0000:00:01.0: reg 0x14: [mem size 0x00010000]
[   17.025838] pci 0000:00:01.0: supports D1
[   17.033828] pci 0000:00:01.0: PME# supported from D0 D1 D3hot
[   17.045699] pci 0000:00:02.0: [0e8d:0801] type 01 class 0x060400
[   17.057726] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x7fffffff]
[   17.070218] pci 0000:00:02.0: reg 0x14: initial BAR value 0x00000000 inv=
alid
[   17.084260] pci 0000:00:02.0: reg 0x14: [mem size 0x00010000]
[   17.095788] pci 0000:00:02.0: supports D1
[   17.103785] pci 0000:00:02.0: PME# supported from D0 D1 D3hot
[   17.116598] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   17.132566] pci 0000:00:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   17.148514] pci 0000:00:02.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   17.164739] pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
[   17.176775] pci 0000:01:00.0: reg 0x10: [io  0x0000-0x0007]
[   17.187892] pci 0000:01:00.0: reg 0x14: [io  0x0000-0x0003]
[   17.199009] pci 0000:01:00.0: reg 0x18: [io  0x0000-0x0007]
[   17.210130] pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x0003]
[   17.221246] pci 0000:01:00.0: reg 0x20: [io  0x0000-0x000f]
[   17.232357] pci 0000:01:00.0: reg 0x24: initial BAR value 0x00000000 inv=
alid
[   17.246411] pci 0000:01:00.0: reg 0x24: [mem size 0x00000200]
[   17.258031] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000
Gb/s with 5.0 GT/s PCIe x1 link)
[   17.317563] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[   17.328033] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[   17.340179] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff=
]
[   17.353703] pci 0000:00:00.0:   bridge window [mem
0x60000000-0x600fffff pref]
[   17.368097] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[   17.381550] pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
[   17.393573] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
[   17.404694] pci 0000:02:00.0: reg 0x14: [io  0x0000-0x0003]
[   17.415804] pci 0000:02:00.0: reg 0x18: [io  0x0000-0x0007]
[   17.426916] pci 0000:02:00.0: reg 0x1c: [io  0x0000-0x0003]
[   17.438040] pci 0000:02:00.0: reg 0x20: [io  0x0000-0x000f]
[   17.449148] pci 0000:02:00.0: reg 0x24: initial BAR value 0x00000000 inv=
alid
[   17.463193] pci 0000:02:00.0: reg 0x24: [mem size 0x00000200]
[   17.474803] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x1 link at 0000:00:01.0 (capable of 4.000
Gb/s with 5.0 GT/s PCIe x1 link)
[   17.527554] pci 0000:00:01.0: PCI bridge to [bus 02-ff]
[   17.538014] pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
[   17.550159] pci 0000:00:01.0:   bridge window [mem 0x60000000-0x600fffff=
]
[   17.563682] pci 0000:00:01.0:   bridge window [mem
0x60000000-0x600fffff pref]
[   17.578078] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[   17.591529] pci 0000:03:00.0: [1b21:0611] type 00 class 0x010185
[   17.603545] pci 0000:03:00.0: reg 0x10: [io  0x0000-0x0007]
[   17.614665] pci 0000:03:00.0: reg 0x14: [io  0x0000-0x0003]
[   17.625775] pci 0000:03:00.0: reg 0x18: [io  0x0000-0x0007]
[   17.636887] pci 0000:03:00.0: reg 0x1c: [io  0x0000-0x0003]
[   17.648009] pci 0000:03:00.0: reg 0x20: [io  0x0000-0x000f]
[   17.659119] pci 0000:03:00.0: reg 0x24: initial BAR value 0x00000000 inv=
alid
[   17.673162] pci 0000:03:00.0: reg 0x24: [mem size 0x00000200]
[   17.684777] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x1 link at 0000:00:02.0 (capable of 4.000
Gb/s with 5.0 GT/s PCIe x1 link)
[   17.737561] pci 0000:00:02.0: PCI bridge to [bus 03-ff]
[   17.748022] pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
[   17.760167] pci 0000:00:02.0:   bridge window [mem 0x60000000-0x600fffff=
]
[   17.773690] pci 0000:00:02.0:   bridge window [mem
0x60000000-0x600fffff pref]
[   17.788085] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[   17.801341] pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000]
[   17.814518] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x800000=
00]
[   17.828392] pci 0000:00:01.0: BAR 0: no space for [mem size 0x80000000]
[   17.841571] pci 0000:00:01.0: BAR 0: failed to assign [mem size 0x800000=
00]
[   17.855443] pci 0000:00:02.0: BAR 0: no space for [mem size 0x80000000]
[   17.868626] pci 0000:00:02.0: BAR 0: failed to assign [mem size 0x800000=
00]
[   17.882502] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff=
]
[   17.896028] pci 0000:00:00.0: BAR 9: assigned [mem
0x60100000-0x601fffff pref]
[   17.910419] pci 0000:00:01.0: BAR 8: assigned [mem 0x60200000-0x602fffff=
]
[   17.923951] pci 0000:00:01.0: BAR 9: assigned [mem
0x60300000-0x603fffff pref]
[   17.938353] pci 0000:00:02.0: BAR 8: assigned [mem 0x60400000-0x604fffff=
]
[   17.951879] pci 0000:00:02.0: BAR 9: assigned [mem
0x60500000-0x605fffff pref]
[   17.966273] pci 0000:00:00.0: BAR 1: assigned [mem 0x60600000-0x6060ffff=
]
[   17.979809] pci 0000:00:01.0: BAR 1: assigned [mem 0x60610000-0x6061ffff=
]
[   17.993341] pci 0000:00:02.0: BAR 1: assigned [mem 0x60620000-0x6062ffff=
]
[   18.006877] pci 0000:00:00.0: BAR 7: assigned [io  0x1e160000-0x1e160fff=
]
[   18.020408] pci 0000:00:01.0: BAR 7: assigned [io  0x1e161000-0x1e161fff=
]
[   18.033932] pci 0000:00:02.0: BAR 7: assigned [io  0x1e162000-0x1e162fff=
]
[   18.047472] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff=
]
[   18.061005] pci 0000:01:00.0: BAR 4: assigned [io  0x1e160000-0x1e16000f=
]
[   18.074540] pci 0000:01:00.0: BAR 0: assigned [io  0x1e160010-0x1e160017=
]
[   18.088070] pci 0000:01:00.0: BAR 2: assigned [io  0x1e160018-0x1e16001f=
]
[   18.101606] pci 0000:01:00.0: BAR 1: assigned [io  0x1e160020-0x1e160023=
]
[   18.115139] pci 0000:01:00.0: BAR 3: assigned [io  0x1e160024-0x1e160027=
]
[   18.128676] pci 0000:00:00.0: PCI bridge to [bus 01]
[   18.138577] pci 0000:00:00.0:   bridge window [io  0x1e160000-0x1e160fff=
]
[   18.152100] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff=
]
[   18.165627] pci 0000:00:00.0:   bridge window [mem
0x60100000-0x601fffff pref]
[   18.180030] pci 0000:02:00.0: BAR 5: assigned [mem 0x60200000-0x602001ff=
]
[   18.193566] pci 0000:02:00.0: BAR 4: assigned [io  0x1e161000-0x1e16100f=
]
[   18.207110] pci 0000:02:00.0: BAR 0: assigned [io  0x1e161010-0x1e161017=
]
[   18.220648] pci 0000:02:00.0: BAR 2: assigned [io  0x1e161018-0x1e16101f=
]
[   18.234183] pci 0000:02:00.0: BAR 1: assigned [io  0x1e161020-0x1e161023=
]
[   18.247723] pci 0000:02:00.0: BAR 3: assigned [io  0x1e161024-0x1e161027=
]
[   18.261257] pci 0000:00:01.0: PCI bridge to [bus 02]
[   18.271165] pci 0000:00:01.0:   bridge window [io  0x1e161000-0x1e161fff=
]
[   18.284695] pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff=
]
[   18.298225] pci 0000:00:01.0:   bridge window [mem
0x60300000-0x603fffff pref]
[   18.312630] pci 0000:03:00.0: BAR 5: assigned [mem 0x60400000-0x604001ff=
]
[   18.326166] pci 0000:03:00.0: BAR 4: assigned [io  0x1e162000-0x1e16200f=
]
[   18.339702] pci 0000:03:00.0: BAR 0: assigned [io  0x1e162010-0x1e162017=
]
[   18.353237] pci 0000:03:00.0: BAR 2: assigned [io  0x1e162018-0x1e16201f=
]
[   18.366775] pci 0000:03:00.0: BAR 1: assigned [io  0x1e162020-0x1e162023=
]
[   18.380311] pci 0000:03:00.0: BAR 3: assigned [io  0x1e162024-0x1e162027=
]
[   18.393841] pci 0000:00:02.0: PCI bridge to [bus 03]
[   18.403740] pci 0000:00:02.0:   bridge window [io  0x1e162000-0x1e162fff=
]
[   18.417270] pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff=
]
[   18.430801] pci 0000:00:02.0:   bridge window [mem
0x60500000-0x605fffff pref]
[   18.445529] ahci 0000:01:00.0: version 3.0
[   18.445559] pci 0000:00:00.0: enabling device (0000 -> 0003)
[   18.456853] ahci 0000:01:00.0: enabling device (0000 -> 0003)
[   18.468455] ahci 0000:01:00.0: SSS flag set, parallel bus scan disabled
[   18.481700] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 2 ports 6
Gbps 0x3 impl IDE mode
[   18.497662] ahci 0000:01:00.0: flags: 64bit ncq sntf stag led clo
pmp pio slum part ccc sxs
[   18.516777] scsi host0: ahci
[   18.523629] scsi host1: ahci
[   18.529829] ata1: SATA max UDMA/133 abar m512@0x60000000 port
0x60000100 irq 22
[   18.544447] ata2: SATA max UDMA/133 abar m512@0x60000000 port
0x60000180 irq 22
[   18.559465] pci 0000:00:01.0: enabling device (0000 -> 0003)
[   18.570786] ahci 0000:02:00.0: enabling device (0000 -> 0003)
[   18.582414] ahci 0000:02:00.0: SSS flag set, parallel bus scan disabled
[   18.595665] ahci 0000:02:00.0: AHCI 0001.0200 32 slots 2 ports 6
Gbps 0x3 impl IDE mode
[   18.611614] ahci 0000:02:00.0: flags: 64bit ncq sntf stag led clo
pmp pio slum part ccc sxs
[   18.631053] scsi host2: ahci
[   18.637983] scsi host3: ahci
[   18.644138] ata3: SATA max UDMA/133 abar m512@0x60200000 port
0x60200100 irq 23
[   18.658792] ata4: SATA max UDMA/133 abar m512@0x60200000 port
0x60200180 irq 23
[   18.673827] pci 0000:00:02.0: enabling device (0000 -> 0003)
[   18.685151] ahci 0000:03:00.0: enabling device (0000 -> 0003)
[   18.696782] ahci 0000:03:00.0: SSS flag set, parallel bus scan disabled
[   18.710025] ahci 0000:03:00.0: AHCI 0001.0200 32 slots 2 ports 6
Gbps 0x3 impl IDE mode
[   18.725972] ahci 0000:03:00.0: flags: 64bit ncq sntf stag led clo
pmp pio slum part ccc sxs

And you are totally right, the setting is writing in the wrong place.
I changed the device tree and the way interrupts are mapped
to avoid using a custom 'map_irq' function [1]. Before that commit the
pci virtual bridge register was reordering the
buses enumeration depending on link status, so there I should also
properly rewrite the code in question.

I can rewrite the code to read and write config properly using the
slot moving the code into 'mt7621_pcie_enable_port' as follows:

static void mt7621_pcie_enable_port(struct mt7621_pcie_port *port)
{
    struct mt7621_pcie *pcie =3D port->pcie;
    u32 slot =3D port->slot;
    u32 offset =3D MT7621_PCIE_OFFSET + (slot * MT7621_NEXT_PORT);
    u32 val;

    /* enable pcie interrupt */
    val =3D pcie_read(pcie, RALINK_PCI_PCIMSK_ADDR);
    val |=3D PCIE_PORT_INT_EN(slot);

    /* map 2G DDR region */
    pcie_write(pcie, PCIE_BAR_MAP_MAX | PCIE_BAR_ENABLE,
           offset + RALINK_PCI_BAR0SETUP_ADDR);

    /* configure class code and revision ID */
    pcie_write(pcie, PCIE_CLASS_CODE | PCIE_REVISION_ID,
           offset + RALINK_PCI_CLASS);

    /* configure RC FTS number to 250 when it leaves L0s */
    val =3D read_config(pcie, slot, PCIE_FTS_NUM);
    val &=3D ~PCIE_FTS_NUM_MASK;
    val |=3D PCIE_FTS_NUM_L0(0x50);
    write_config(pcie, slot, PCIE_FTS_NUM, val);
}

static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
{
    struct device *dev =3D pcie->dev;
    struct mt7621_pcie_port *port;
    int err;

    /* Setup MEMWIN and IOWIN */
    pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
    pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);

    list_for_each_entry(port, &pcie->ports, list) {
        if (port->enabled) {
            err =3D clk_prepare_enable(port->clk);
            if (err) {
                dev_err(dev, "enabling clk pcie%d\n",
                    port->slot);
                return err;
            }

            mt7621_pcie_enable_port(port);
            dev_info(dev, "PCIE%d enabled\n", port->slot);
        }
    }

    return 0;
}

Or just delete the setting and the read and write config functions
since they are not being used in any other place. My two boards work
without this setting but I don't know about other boards.

What do you think?

Best regards,
    Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tre=
e/drivers/staging/mt7621-pci/pci-mt7621.c?h=3Dv4.18#n663
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/com=
mit/drivers/staging/mt7621-pci?h=3Dstaging-testing&id=3Db99cc3a2b6b62cf994a=
cac5cced03298d9908c9b

>
> >         Device tree node: /sys/firmware/devicetree/base/pcie@1e140000/p=
cie@2,0
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 255
> >         Region 1: Memory at 60200000 (32-bit, non-prefetchable) [size=
=3D64K]
> >         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latenc=
y=3D0
> >         I/O behind bridge: 00000000-00000fff [size=3D4K]
> >         Memory behind bridge: 60000000-600fffff [size=3D1M]
> >         Prefetchable memory behind bridge: 60100000-601fffff [size=3D1M=
]
> >         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- <SERR- <PERR-
> >         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- Fas=
tB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [40] Power Management version 3
> >                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D375mA
> > PME(D0+,D1+,D2-,D3hot+,D3cold-)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
> >         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >                 Address: 0000000000000000  Data: 0000
> >         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
> >                 DevCap: MaxPayload 128 bytes, PhantFunc 0
> >                         ExtTag- RBE+
> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> >                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq-
> > AuxPwr- TransPend-
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> > Exit Latency L0s <512ns, L1 <64us
> >                         ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp=
-
> >                 LnkCtl: ASPM Disabled; RCB 128 bytes, Disabled- CommClk=
-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
> >                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgm=
t-
> >                 RootCap: CRSVisible-
> >                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> > PMEIntEna- CRSVisible-
> >                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >                 DevCap2: Completion Timeout: Not Supported,
> > TimeoutDis+ NROPrPrP- LTR-
> >                          10BitTagComp- 10BitTagReq- OBFF Not
> > Supported, ExtFmt- EETLPPrefix-
> >                          EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >                          FRS- LN System CLS Not Supported, TPHComp-
> > ExtTPHComp- ARIFwd-
> >                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS=
-
> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> > LTR- OBFF Disabled, ARIFwd-
> >                          AtomicOpsCtl: ReqEn- EgressBlck-
> >                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink-
> > Retimer- 2Retimers- DRS-
> >                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-
> >                          Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance De-emphasis: -6dB
> >                 LnkSta2: Current De-emphasis Level: -6dB,
> > EqualizationComplete- EqualizationPhase1-
> >                          EqualizationPhase2- EqualizationPhase3-
> > LinkEqualizationRequest-
> >                          Retimer- 2Retimers- CrosslinkRes: unsupported
> >         Capabilities: [100 v1] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> >                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+
> >                 AERCap: First Error Pointer: 00, ECRCGenCap+
> > ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLog=
Cap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >                 RootCmd: CERptEn- NFERptEn- FERptEn-
> >                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> >                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> >                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> >         Capabilities: [140 v1] Virtual Channel
> >                 Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
> >                 Arb:    Fixed- WRR32- WRR64- WRR128-
> >                 Ctrl:   ArbSelect=3DFixed
> >                 Status: InProgress-
> >                 VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoo=
pTrans-
> >                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- W=
RR256-
> >                         Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=
=3Dff
> >                         Status: NegoPending- InProgress-
> > lspci: Unable to load libkmod resources: error -12
> >
> > 01:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7612]
> >         Subsystem: MEDIATEK Corp. Device [14c3:7612]
> >         Device tree node:
> > /sys/firmware/devicetree/base/pcie@1e140000/pcie@2,0/wifi@0,0
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 20
> >         Region 0: Memory at 60000000 (64-bit, non-prefetchable) [size=
=3D1M]
> >         Expansion ROM at 60100000 [virtual] [disabled] [size=3D64K]
> >         Capabilities: [40] Power Management version 3
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
> >         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >                 Address: 0000000000000000  Data: 0000
> >         Capabilities: [70] Express (v2) Endpoint, MSI 00
> >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> > unlimited, L1 unlimited
> >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> > FLReset- SlotPowerLimit 0.000W
> >                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> >                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > AuxPwr+ TransPend-
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> > Exit Latency L0s <2us, L1 unlimited
> >                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp=
+
> >                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgm=
t-
> >                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> > NROPrPrP- LTR-
> >                          10BitTagComp- 10BitTagReq- OBFF Not
> > Supported, ExtFmt- EETLPPrefix-
> >                          EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >                          FRS- TPHComp- ExtTPHComp-
> >                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> > LTR- OBFF Disabled,
> >                          AtomicOpsCtl: ReqEn-
> >                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink-
> > Retimer- 2Retimers- DRS-
> >                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
> >                          Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance De-emphasis: -6dB
> >                 LnkSta2: Current De-emphasis Level: -3.5dB,
> > EqualizationComplete- EqualizationPhase1-
> >                          EqualizationPhase2- EqualizationPhase3-
> > LinkEqualizationRequest-
> >                          Retimer- 2Retimers- CrosslinkRes: unsupported
> >         Capabilities: [100 v2] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> >                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> >                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+
> >                 AERCap: First Error Pointer: 00, ECRCGenCap+
> > ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLog=
Cap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-0=
0-00
> >         Capabilities: [158 v1] Latency Tolerance Reporting
> >                 Max snoop latency: 0ns
> >                 Max no snoop latency: 0ns
> >         Capabilities: [160 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > ASPM_L1.1+ L1_PM_Substates+
> >                           PortCommonModeRestoreTime=3D50us PortTPowerOn=
Time=3D10us
> >                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1=
.1-
> >                            T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >                 L1SubCtl2: T_PwrOn=3D10us
> >         Kernel driver in use: mt76x2e
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > >
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     return 0;
> > > > > > > > > +}
