Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347D539C5FA
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 07:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFEFOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 01:14:34 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:40725 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhFEFOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jun 2021 01:14:33 -0400
Received: by mail-ot1-f42.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso11174787otu.7;
        Fri, 04 Jun 2021 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bh3cNd7/8Pkf9Khr1pTv6Aqn+s5pvOt1F/ffJccp11w=;
        b=Gqo4xY93B5aukAfeBNqh62YdMSVd9cVqV3mmBHUYLfvtOWrcjWgzH981lDMLnWbx3t
         2BQHh3X/iYyj6+8zMFFRtw7V6F8n2V6LEMJhX3i9rDnfb/YMcUaE6XzFqe8dTp8Qx9NM
         D5FxOj/xGP40HPwYEZf4uQCyBHSObnsWCE58/OUxtfEnXb1CPuvVWdHx7PwzD9wBBn9j
         23kZBesCkuO8UWfaXWzSuhryO5OJV3FQ5ruINuY9UrYpBO27kdR8O/CWT+tqUyQ9rR+l
         /mL9LGHt3EKIUHno3ICtew9lnQPgqs225SkhyL9uCa+HcgfqZs5CgoxNcShdGgt9x+Ez
         CoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bh3cNd7/8Pkf9Khr1pTv6Aqn+s5pvOt1F/ffJccp11w=;
        b=uPlAU8oTAR9xKQDEQ+iCS4U7Vl1e2hiCKkbsOLESJlLa4IKGtRXW6MZorlpOvZg8eN
         ci5iWbLSEiyF1S83P8Dj5U5oCISN+fxJwpbDJem7z8ZZlUkIMWUagR5zFI+2gPoDIsy6
         EWrIMs0pLB/way+kAGl5FKzeIx+TKPwPTWJ8fFP1A9dKBxUra+QYICdcWaNXi3wbcOJ9
         4S/yWfEFdGmlSKp/AHANLnSGSrr/FBeML1Qd/WX/OowcpnEmluxr3DAINRe8QIrv+Z/t
         XTl7Ud+nn7BumjzCGRQiYDPS/ylIV8hj3N7HeenQEHZpzA5FSvquvj9SlXvAr2yXNh+D
         6IZQ==
X-Gm-Message-State: AOAM533JkjIfSfQBXD+jpaB5xa4ywZLkpTqYzlLELNUjnzWhPK+MGQFG
        sOQ+SUn8uuDWwjejrRGvdjbtCny60ZIVGkHlEQw=
X-Google-Smtp-Source: ABdhPJyf5ScajBBdCtcBjKVmQ2P5MXetnhlpCipkk7zv5SY/pqEMztbW8xJ952UGukGON0E6JriFF2GnbkghnjzUTgM=
X-Received: by 2002:a05:6830:5:: with SMTP id c5mr104517otp.72.1622869895450;
 Fri, 04 Jun 2021 22:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-3-sergio.paracuellos@gmail.com>
 <20210531131431.bzsvmefqdyawmeo2@pali> <CAMhs-H80=7jctPT70rOmcwcqPw+9iUF84_ZCgGr-TKwJ4eB2Lg@mail.gmail.com>
 <20210531135041.42ovpmbwuc3yfkaw@pali> <CAMhs-H_fR5aXJ=diTm-2yhgjjv9S6N6jA-DOZ0K_BnQ4UHHh3Q@mail.gmail.com>
 <CAMhs-H8EwQDvZtzpPn2u_WOWt1wcixOvz5nVZP2miM6j0+P7EA@mail.gmail.com>
 <20210602122337.fxwaikulbawwkc2j@pali> <CAMhs-H8Gr=ObgMZAZ9VuNqHX4TaKQPPGNNMY4pzh9o=3EbAgUQ@mail.gmail.com>
 <20210604165525.ybgyusazeyzx642v@pali> <20210604184939.GA3695694@robh.at.kernel.org>
 <20210604225844.bsol3d7la53yfhpd@pali>
In-Reply-To: <20210604225844.bsol3d7la53yfhpd@pali>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Jun 2021 07:11:24 +0200
Message-ID: <CAMhs-H-=a69hrL0cNjTFiMA0g=Uf35NeDamonAjL_U-SeiLkBA@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: pci: Add driver for MT7621 PCIe controller
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Sat, Jun 5, 2021 at 12:58 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 04 June 2021 13:49:39 Rob Herring wrote:
> > On Fri, Jun 04, 2021 at 06:55:25PM +0200, Pali Roh=C3=A1r wrote:
> > > On Wednesday 02 June 2021 14:43:53 Sergio Paracuellos wrote:
> > > > Hi Pali,
> > > >
> > > > On Wed, Jun 2, 2021 at 2:23 PM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
> > > > >
> > > > > On Wednesday 02 June 2021 14:16:26 Sergio Paracuellos wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Mon, May 31, 2021 at 4:19 PM Sergio Paracuellos
> > > > > > <sergio.paracuellos@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, May 31, 2021 at 3:50 PM Pali Roh=C3=A1r <pali@kernel.=
org> wrote:
> > > > > > > >
> > > > > > > > On Monday 31 May 2021 15:39:55 Sergio Paracuellos wrote:
> > > > > > > > > Hi Pali,
> > > > > > > > >
> > > > > > > > > Thanks for your comments.
> > > > > > > > >
> > > > > > > > > On Mon, May 31, 2021 at 3:14 PM Pali Roh=C3=A1r <pali@ker=
nel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wro=
te:
> > > > > > > > > > > This patch adds a driver for the PCIe controller of M=
T7621 SoC.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos=
@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  arch/mips/pci/Makefile     |   1 +
> > > > > > > > > > >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++=
++++++++++++++++++
> > > > > > > > > > >  arch/mips/ralink/Kconfig   |   9 +-
> > > > > > > > > > >  3 files changed, 633 insertions(+), 1 deletion(-)
> > > > > > > > > > >  create mode 100644 arch/mips/pci/pci-mt7621.c
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/M=
akefile
> > > > > > > > > > > index f3eecc065e5c..178c550739c4 100644
> > > > > > > > > > > --- a/arch/mips/pci/Makefile
> > > > > > > > > > > +++ b/arch/mips/pci/Makefile
> > > > > > > > > > > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    +=3D pc=
i-ar2315.o
> > > > > > > > > > >  obj-$(CONFIG_SOC_AR71XX)     +=3D pci-ar71xx.o
> > > > > > > > > > >  obj-$(CONFIG_PCI_AR724X)     +=3D pci-ar724x.o
> > > > > > > > > > >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       +=3D pci-xtalk-=
bridge.o
> > > > > > > > > > > +obj-$(CONFIG_PCI_MT7621)     +=3D pci-mt7621.o
> > > > > > > > > > >  #
> > > > > > > > > > >  # These are still pretty much in the old state, watc=
h, go blind.
> > > > > > > > > > >  #
> > > > > > > > > > > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/p=
ci/pci-mt7621.c
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 000000000000..fe1945819d25
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/arch/mips/pci/pci-mt7621.c
> > > > > > > > > > ...
> > > > > > > > > > > +static int mt7621_pcie_enable_ports(struct mt7621_pc=
ie *pcie)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct device *dev =3D pcie->dev;
> > > > > > > > > > > +     struct mt7621_pcie_port *port;
> > > > > > > > > > > +     u8 num_slots_enabled =3D 0;
> > > > > > > > > > > +     u32 slot;
> > > > > > > > > > > +     u32 val;
> > > > > > > > > > > +     int err;
> > > > > > > > > > > +
> > > > > > > > > > > +     /* Setup MEMWIN and IOWIN */
> > > > > > > > > > > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE=
);
> > > > > > > > > > > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOB=
ASE);
> > > > > > > > > > > +
> > > > > > > > > > > +     list_for_each_entry(port, &pcie->ports, list) {
> > > > > > > > > > > +             if (port->enabled) {
> > > > > > > > > > > +                     err =3D clk_prepare_enable(port=
->clk);
> > > > > > > > > > > +                     if (err) {
> > > > > > > > > > > +                             dev_err(dev, "enabling =
clk pcie%d\n", slot);
> > > > > > > > > > > +                             return err;
> > > > > > > > > > > +                     }
> > > > > > > > > > > +
> > > > > > > > > > > +                     mt7621_pcie_enable_port(port);
> > > > > > > > > > > +                     dev_info(dev, "PCIE%d enabled\n=
", port->slot);
> > > > > > > > > > > +                     num_slots_enabled++;
> > > > > > > > > > > +             }
> > > > > > > > > > > +     }
> > > > > > > > > > > +
> > > > > > > > > > > +     for (slot =3D 0; slot < num_slots_enabled; slot=
++) {
> > > > > > > > > > > +             val =3D read_config(pcie, slot, PCI_COM=
MAND);
> > > > > > > > > > > +             val |=3D PCI_COMMAND_MASTER;
> > > > > > > > > > > +             write_config(pcie, slot, PCI_COMMAND, v=
al);
> > > > > > > > > >
> > > > > > > > > > Hello! Is this part of code correct? Because it looks s=
trange if PCIe
> > > > > > > > > > controller driver automatically enables PCI bus masteri=
ng, prior device
> > > > > > > > > > driver initialize itself.
> > > > > > > > > >
> > > > > > > > > > Moreover kernel has already function pci_set_master() f=
or this purpose
> > > > > > > > > > which is used by device drivers.
> > > > > > > > > >
> > > > > > > > > > So I think this code can confuse some device drivers...
> > > > > > > > >
> > > > > > > > > I agree that we have pci_set_master() to be used in pci d=
evice driver
> > > > > > > > > code. Original controller driver set this bit for enabled=
 slots. Since
> > > > > > > > > there is no documentation at all for the PCI in this SoC
> > > > > > > >
> > > > > > > > I see... this is really a big problem to do any driver deve=
lopment...
> > > > > > >
> > > > > > > For sure it is :(.
> > > > > > >
> > > > > > > >
> > > > > > > > > I have
> > > > > > > > > maintained the setting in the driver in a cleaner way. Se=
e original
> > > > > > > > > driver code and the setting here [0]. There is no other r=
eason than
> > > > > > > > > that. I am ok with removing this from here and testing wi=
th my two
> > > > > > > > > devices that everything is still ok if having this settin=
g in the pci
> > > > > > > > > controller driver is a real problem.
> > > > > > > >
> > > > > > > > You can run lspci -nnvv with and without PCI_COMMAND_MASTER=
 code and
> > > > > > > > then compare outputs.
> > > > > > > >
> > > > > > > > Device drivers for sure enable PCI_COMMAND_MASTER at the ti=
me when it is
> > > > > > > > needed, so it is possible that there would be no difference=
 in lspci
> > > > > > > > output.
> > > > > > >
> > > > > > > Thanks. I will take this into account when v2 is submitted af=
ter more
> > > > > > > review comments come :).
> > > > > >
> > > > > > I have tested to remove this and check lspci -nnvv output with =
and
> > > > > > without PCI_COMMAND_MASTER code and, as you pointed out, there =
is no
> > > > > > difference between them. Also, both boards are working without
> > > > > > regressions at all. So I will remove this code for next version=
.
> > > > >
> > > > > Perfect!
> > > > >
> > > > > > Thanks,
> > > > > >     Sergio Paracuellos
> > > > > > >
> > > > > > > >
> > > > > > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/greg=
kh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=3Dv4.18#n676
> > > > > > > > >
> > > > > > > > > Best regards,
> > > > > > > > >     Sergio Paracuellos
> > > > > > > > > >
> > > > > > > > > > > +             /* configure RC FTS number to 250 when =
it leaves L0s */
> > > > > > > > > > > +             val =3D read_config(pcie, slot, PCIE_FT=
S_NUM);
> > > > > > > > > > > +             val &=3D ~PCIE_FTS_NUM_MASK;
> > > > > > > > > > > +             val |=3D PCIE_FTS_NUM_L0(0x50);
> > > > > > > > > > > +             write_config(pcie, slot, PCIE_FTS_NUM, =
val);
> > > > >
> > > > > Could you look also what is doing this code (PCIE_FTS_NUM)? It is=
 marked
> > > > > as MT specific register. But from this code for me it looks like =
that it
> > > > > just access config space of some device and therefore it could be=
 some
> > > > > standard PCIe register. Just with hardcoded calculated offset.
> > >
> > > So based on your lspci output, there is no PCIe capability register a=
t
> > > address PCIE_FTS_NUM (0x70c), right? It seems strange to trying acces=
s
> > > capability register outside of capability list.
> >
> > Looks like a DW PCIe port logic register:
> >
> > drivers/pci/controller/dwc/pcie-designware.h-/* Synopsys-specific PCIe =
configuration registers */
> > drivers/pci/controller/dwc/pcie-designware.h:#define PCIE_PORT_AFR     =
                 0x70C
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_N_FTS_MAS=
K                GENMASK(15, 8)
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_N_FTS(n) =
         FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_CC_N_FTS_=
MASK             GENMASK(23, 16)
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_CC_N_FTS(=
n)               FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, n)
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_ENTER_ASP=
M                BIT(30)
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L0S_ENTRA=
NCE_LAT_SHIFT    24
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L0S_ENTRA=
NCE_LAT_MASK     GENMASK(26, 24)
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L1_ENTRAN=
CE_LAT_SHIFT     27
> > drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L1_ENTRAN=
CE_LAT_MASK      GENMASK(29, 27)
> >
> > Rob
>
> Rob: nice catch!
> Does it mean that this MT7621 SoC has dwc controller and driver can be
> theoretically in future rewritten to use common dwc code?
>
> Sergio: I have tried to find some information about it and seems that
> MT7620, MT7621 and MT7628 SoC are really using some designware dwc IP.
> Some details are available in section "Embedded/kernel developer
> friendliness" in following blog post:
> https://www.abclinuxu.cz/blog/GardenOfEdenConfiguration/2019/10/opus-magn=
um

Thanks. For what see in the datasheet linked there some of the
registers looks pretty similar. It also defines registers taking in
account three root ports but in mt7628 and mt7620 there is only one
available. It seems tons of things are not listed there but it is
better than nothing.

>
> And seems that "programming guide" documentation for MT7620 is available
> on internet with description of PCIe registers. I do not know how MT7620
> and MT7621 are different but maybe it could help to develop or understand
> driver.

Yes, it is available but none of the dwc stuff is inside. Only the
main register as the mt7628 datasheet has.

Best regards,
    Sergio Paracuellos
