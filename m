Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3643E1342
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 12:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbhHEKuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhHEKuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 06:50:35 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CAEC061765;
        Thu,  5 Aug 2021 03:50:21 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id k124so1115954vke.5;
        Thu, 05 Aug 2021 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mM+W1j1gcQNeIiUPKnyARWmgB2Q/ZyuUq4YdxX9ILvw=;
        b=nSzkZ3mLUfzZNn3zCqt5O15rTcAA2NfAhlcxZf+GJ3DCvdU8jbKKBXK38QK2ZHxX3i
         ZizqJjye5TgX6goeM7z9xP6iR4w2OtpLuaI9jUSxSARFe8Ssz7+L7Lkwv92Kx4jdSCkU
         wxqbiTNUT9PtwZ5r7v6NVu121PVdYYxdXp39WzrRCHSBUf3uSsu0md2hjWAvqJJ5Qdx0
         dHAoWMM1A8VbqWzJ5iiogYI0CYanJ8x4fVP7ryategFtothIRyGhoSdd+KVsakDgd0JH
         VvzGKfC8qOJAJwF6kTmsZ85hC9R206c2kypd04o+dhgqzUSu9tT/Vco/waHPQuc7+5ss
         PF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mM+W1j1gcQNeIiUPKnyARWmgB2Q/ZyuUq4YdxX9ILvw=;
        b=hw8QjS0Ucn61U80gaksPJ2FiCt2BkhC0Hnh2LSKEHla9tvIZkpeEk6fv6kVm6setqS
         gFfULiw27VjDmb08pQq76U72AfVzdIqkegq/Jn7tlA6Gxb0FtPChlnTRPVGGrDYy0dDf
         VRBQxD020I/rD0qA2wdWmvIO3Z5veP4DseYGt7yPBplmsC24+5M5LW3Jru51GgnuvUuo
         OACmrmwADu52za2kRl/5aoBm3NcBC0VCYMYHSmgAd7iTAxVgZpG8iklxkYGTFMtO1/FQ
         oblVPPxmeVDNQpMGTCTU4LWPtOpyU+7ccBY+SGmWXGprH6Lq94FGiBDOcMRsIKJvbA91
         mMkg==
X-Gm-Message-State: AOAM532XLPVwZVcUMdABis+uiEJE9an02cbQHQvg6KMlg/2uGrilIzem
        7o5tVP4FAwzX8nn05LMxYMHajV3FdoPBKJmrwYI=
X-Google-Smtp-Source: ABdhPJz708bszcnb2fQpVbzdFhM8d2g+/Y7pHhe8qpRqrBe1pSwhcDy1TXYwVjS+Un9xERtp+JnNtKuuoprQ93TD0Jg=
X-Received: by 2002:a1f:a314:: with SMTP id m20mr3061629vke.14.1628160620097;
 Thu, 05 Aug 2021 03:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
 <20210609140159.20476-3-sergio.paracuellos@gmail.com> <20210805103245.GA19112@lpieralisi>
 <CAMhs-H8U2heh6jwNxpycX3m4TZjf=KODuE5c_H_Le1Q_4ZcqgQ@mail.gmail.com> <20210805104540.GA19184@lpieralisi>
In-Reply-To: <20210805104540.GA19184@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 5 Aug 2021 12:50:08 +0200
Message-ID: <CAMhs-H9S3X2ogdVO+vwU4VXA_nSqA5g=Lk+MMn=pQPi7DaS=Gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
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
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 5, 2021 at 12:45 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Aug 05, 2021 at 12:40:02PM +0200, Sergio Paracuellos wrote:
> > Hi Lorenzo,
> >
> > On Thu, Aug 5, 2021 at 12:32 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Wed, Jun 09, 2021 at 04:01:58PM +0200, Sergio Paracuellos wrote:
> > > > Add driver for the PCIe controller of the MT7621 SoC.
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >  arch/mips/ralink/Kconfig                      |   2 +-
> > > >  drivers/pci/controller/Kconfig                |   8 ++
> > > >  drivers/pci/controller/Makefile               |   1 +
> > > >  .../controller}/pci-mt7621.c                  |   0
> > > >  drivers/staging/Kconfig                       |   2 -
> > > >  drivers/staging/Makefile                      |   1 -
> > > >  drivers/staging/mt7621-pci/Kconfig            |   8 --
> > > >  drivers/staging/mt7621-pci/Makefile           |   2 -
> > > >  drivers/staging/mt7621-pci/TODO               |   4 -
> > > >  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 ------------------
> > > >  10 files changed, 10 insertions(+), 122 deletions(-)
> > > >  rename drivers/{staging/mt7621-pci => pci/controller}/pci-mt7621.c (100%)
> > > >  delete mode 100644 drivers/staging/mt7621-pci/Kconfig
> > > >  delete mode 100644 drivers/staging/mt7621-pci/Makefile
> > > >  delete mode 100644 drivers/staging/mt7621-pci/TODO
> > > >  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> > > >
> > > > diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> > > > index ec4daa63c5e3..461e33d20c9c 100644
> > > > --- a/arch/mips/ralink/Kconfig
> > > > +++ b/arch/mips/ralink/Kconfig
> > > > @@ -56,7 +56,7 @@ choice
> > > >               select MIPS_GIC
> > > >               select COMMON_CLK
> > > >               select CLKSRC_MIPS_GIC
> > > > -             select HAVE_PCI if PCI_MT7621
> > > > +             select HAVE_PCI
> > > >               select SOC_BUS
> > > >  endchoice
> > > >
> > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > index 2f2c8a1729f9..6b006df87884 100644
> > > > --- a/drivers/pci/controller/Kconfig
> > > > +++ b/drivers/pci/controller/Kconfig
> > > > @@ -303,6 +303,14 @@ config PCIE_HISI_ERR
> > > >         Say Y here if you want error handling support
> > > >         for the PCIe controller's errors on HiSilicon HIP SoCs
> > > >
> > > > +config PCI_MT7621
> > > > +     bool "MediaTek MT7621 PCI Controller"
> > > > +     depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> > > > +     select PCI_DRIVERS_GENERIC
> > >
> > > Can this be selected in arch/mips rather than here ?
> >
> > No real problem for me, but I was suggested by Bjorn and Pali to put
> > all the driver inside 'drivers/pci/controller'. Do you mean to move
> > all to arch/mips or only the Kconfig part?
>
> Only:
>
> select PCI_DRIVERS_GENERIC
>
> given that's an arch/mips internal.
>

Ah, ok. I misread your comment, sorry. I will put it there and send v3.

Thanks,
    Sergio Paracuellos

> Thanks,
> Lorenzo
>
> >
> > Thanks,
> >     Sergio Paracuellos
> >
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > > +     default SOC_MT7621
> > > > +     help
> > > > +       This selects a driver for the MediaTek MT7621 PCI Controller.
> > > > +
> > > >  source "drivers/pci/controller/dwc/Kconfig"
> > > >  source "drivers/pci/controller/mobiveil/Kconfig"
> > > >  source "drivers/pci/controller/cadence/Kconfig"
> > > > diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> > > > index 63e3880a3e87..ac902dc4e1a9 100644
> > > > --- a/drivers/pci/controller/Makefile
> > > > +++ b/drivers/pci/controller/Makefile
> > > > @@ -36,6 +36,7 @@ obj-$(CONFIG_VMD) += vmd.o
> > > >  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
> > > >  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
> > > >  obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
> > > > +obj-$(CONFIG_PCI_MT7621) += pci-mt7621.o
> > > >  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
> > > >  obj-y                                += dwc/
> > > >  obj-y                                += mobiveil/
> > > > diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/pci/controller/pci-mt7621.c
> > > > similarity index 100%
> > > > rename from drivers/staging/mt7621-pci/pci-mt7621.c
> > > > rename to drivers/pci/controller/pci-mt7621.c
> > > > diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> > > > index b7ae5bdc4eb5..9a21d730ab2b 100644
> > > > --- a/drivers/staging/Kconfig
> > > > +++ b/drivers/staging/Kconfig
> > > > @@ -86,8 +86,6 @@ source "drivers/staging/vc04_services/Kconfig"
> > > >
> > > >  source "drivers/staging/pi433/Kconfig"
> > > >
> > > > -source "drivers/staging/mt7621-pci/Kconfig"
> > > > -
> > > >  source "drivers/staging/mt7621-dma/Kconfig"
> > > >
> > > >  source "drivers/staging/ralink-gdma/Kconfig"
> > > > diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> > > > index 075c979bfe7c..b7b4916761d4 100644
> > > > --- a/drivers/staging/Makefile
> > > > +++ b/drivers/staging/Makefile
> > > > @@ -33,7 +33,6 @@ obj-$(CONFIG_KS7010)                += ks7010/
> > > >  obj-$(CONFIG_GREYBUS)                += greybus/
> > > >  obj-$(CONFIG_BCM2835_VCHIQ)  += vc04_services/
> > > >  obj-$(CONFIG_PI433)          += pi433/
> > > > -obj-$(CONFIG_PCI_MT7621)     += mt7621-pci/
> > > >  obj-$(CONFIG_SOC_MT7621)     += mt7621-dma/
> > > >  obj-$(CONFIG_DMA_RALINK)     += ralink-gdma/
> > > >  obj-$(CONFIG_SOC_MT7621)     += mt7621-dts/
> > > > diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
> > > > deleted file mode 100644
> > > > index ce58042f2f21..000000000000
> > > > --- a/drivers/staging/mt7621-pci/Kconfig
> > > > +++ /dev/null
> > > > @@ -1,8 +0,0 @@
> > > > -# SPDX-License-Identifier: GPL-2.0
> > > > -config PCI_MT7621
> > > > -     tristate "MediaTek MT7621 PCI Controller"
> > > > -     depends on RALINK
> > > > -     select PCI_DRIVERS_GENERIC
> > > > -     help
> > > > -       This selects a driver for the MediaTek MT7621 PCI Controller.
> > > > -
> > > > diff --git a/drivers/staging/mt7621-pci/Makefile b/drivers/staging/mt7621-pci/Makefile
> > > > deleted file mode 100644
> > > > index f4e651cf7ce3..000000000000
> > > > --- a/drivers/staging/mt7621-pci/Makefile
> > > > +++ /dev/null
> > > > @@ -1,2 +0,0 @@
> > > > -# SPDX-License-Identifier: GPL-2.0
> > > > -obj-$(CONFIG_PCI_MT7621)       += pci-mt7621.o
> > > > diff --git a/drivers/staging/mt7621-pci/TODO b/drivers/staging/mt7621-pci/TODO
> > > > deleted file mode 100644
> > > > index d674a9ac85c1..000000000000
> > > > --- a/drivers/staging/mt7621-pci/TODO
> > > > +++ /dev/null
> > > > @@ -1,4 +0,0 @@
> > > > -
> > > > -- general code review and cleanup
> > > > -
> > > > -Cc: NeilBrown <neil@brown.name>
> > > > diff --git a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt b/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> > > > deleted file mode 100644
> > > > index 327a68267309..000000000000
> > > > --- a/drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> > > > +++ /dev/null
> > > > @@ -1,104 +0,0 @@
> > > > -MediaTek MT7621 PCIe controller
> > > > -
> > > > -Required properties:
> > > > -- compatible: "mediatek,mt7621-pci"
> > > > -- device_type: Must be "pci"
> > > > -- reg: Base addresses and lengths of the PCIe subsys and root ports.
> > > > -- bus-range: Range of bus numbers associated with this controller.
> > > > -- #address-cells: Address representation for root ports (must be 3)
> > > > -- pinctrl-names : The pin control state names.
> > > > -- pinctrl-0: The "default" pinctrl state.
> > > > -- #size-cells: Size representation for root ports (must be 2)
> > > > -- ranges: Ranges for the PCI memory and I/O regions.
> > > > -- #interrupt-cells: Must be 1
> > > > -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties.
> > > > -  Please refer to the standard PCI bus binding document for a more detailed
> > > > -  explanation.
> > > > -- status: either "disabled" or "okay".
> > > > -- resets: Must contain an entry for each entry in reset-names.
> > > > -  See ../reset/reset.txt for details.
> > > > -- reset-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
> > > > -  root ports.
> > > > -- clocks: Must contain an entry for each entry in clock-names.
> > > > -  See ../clocks/clock-bindings.txt for details.
> > > > -- clock-names: Must be "pcie0", "pcie1", "pcieN"... based on the number of
> > > > -  root ports.
> > > > -- reset-gpios: GPIO specs for the reset pins.
> > > > -
> > > > -In addition, the device tree node must have sub-nodes describing each PCIe port
> > > > -interface, having the following mandatory properties:
> > > > -
> > > > -Required properties:
> > > > -- reg: Only the first four bytes are used to refer to the correct bus number
> > > > -      and device number.
> > > > -- #address-cells: Must be 3
> > > > -- #size-cells: Must be 2
> > > > -- ranges: Sub-ranges distributed from the PCIe controller node. An empty
> > > > -  property is sufficient.
> > > > -- bus-range: Range of bus numbers associated with this port.
> > > > -
> > > > -Example for MT7621:
> > > > -
> > > > -     pcie: pcie@1e140000 {
> > > > -             compatible = "mediatek,mt7621-pci";
> > > > -        reg = <0x1e140000 0x100    /* host-pci bridge registers */
> > > > -               0x1e142000 0x100    /* pcie port 0 RC control registers */
> > > > -               0x1e143000 0x100    /* pcie port 1 RC control registers */
> > > > -               0x1e144000 0x100>;  /* pcie port 2 RC control registers */
> > > > -
> > > > -             #address-cells = <3>;
> > > > -             #size-cells = <2>;
> > > > -
> > > > -             pinctrl-names = "default";
> > > > -             pinctrl-0 = <&pcie_pins>;
> > > > -
> > > > -             device_type = "pci";
> > > > -
> > > > -             bus-range = <0 255>;
> > > > -             ranges = <
> > > > -                     0x02000000 0 0x00000000 0x60000000 0 0x10000000 /* pci memory */
> > > > -                     0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
> > > > -             >;
> > > > -
> > > > -             #interrupt-cells = <1>;
> > > > -             interrupt-map-mask = <0xF0000 0 0 1>;
> > > > -             interrupt-map = <0x10000 0 0 1 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> > > > -                             <0x20000 0 0 1 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> > > > -                             <0x30000 0 0 1 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> > > > -
> > > > -             status = "disabled";
> > > > -
> > > > -             resets = <&rstctrl 24 &rstctrl 25 &rstctrl 26>;
> > > > -             reset-names = "pcie0", "pcie1", "pcie2";
> > > > -             clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
> > > > -             clock-names = "pcie0", "pcie1", "pcie2";
> > > > -
> > > > -             reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>,
> > > > -                             <&gpio 8 GPIO_ACTIVE_LOW>,
> > > > -                             <&gpio 7 GPIO_ACTIVE_LOW>;
> > > > -
> > > > -             pcie@0,0 {
> > > > -                     reg = <0x0000 0 0 0 0>;
> > > > -                     #address-cells = <3>;
> > > > -                     #size-cells = <2>;
> > > > -                     ranges;
> > > > -                     bus-range = <0x00 0xff>;
> > > > -             };
> > > > -
> > > > -             pcie@1,0 {
> > > > -                     reg = <0x0800 0 0 0 0>;
> > > > -                     #address-cells = <3>;
> > > > -                     #size-cells = <2>;
> > > > -                     ranges;
> > > > -                     bus-range = <0x00 0xff>;
> > > > -             };
> > > > -
> > > > -             pcie@2,0 {
> > > > -                     reg = <0x1000 0 0 0 0>;
> > > > -                     #address-cells = <3>;
> > > > -                     #size-cells = <2>;
> > > > -                     ranges;
> > > > -                     bus-range = <0x00 0xff>;
> > > > -             };
> > > > -     };
> > > > -
> > > > --
> > > > 2.25.1
> > > >
