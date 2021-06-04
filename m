Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0839BFE0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFDSv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 14:51:29 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36574 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDSv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 14:51:29 -0400
Received: by mail-ot1-f45.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10053188otl.3;
        Fri, 04 Jun 2021 11:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HYofxwMadJhca35uMZBEMl6CLIDMnDtx5P2X9vi79kk=;
        b=Ax+ZKvsDeI9msW854CCIgyjCuFV227m9uVVw3rnmLAAEz+mZU7IYQbFLRAUKl+FeOI
         KbI385L14WW8pk28WkTlJx6Adidk2zsMvPxfwv24MsyOSay7NHCU/zeM32Bmydk/WeQj
         42Xv8GnWGdNvuEJ9DD03luUeT3q3eCuPJwMIoDbU7m2AF+Es6rjSIErojvhvO2JXDBob
         LAJI46vd99QD2j+P5MufxLCNemPsz59JVLlPSRIPpNV9FYo+YEiOWhi9inuVRyIRcgmV
         fbthEKyKynggNkSVGmUD/tSfn+av+PLre1Ui2Z/VBzzgQAGtmx25vJxSoflADOGhYMhW
         Jedw==
X-Gm-Message-State: AOAM533OYKKo71GgqSavFagUqTGIGRqxlPMkThuXLJ2zWOqpi5vbhPcc
        DAviGmLxXK6h0jhfmnp73gbi1dNGjA==
X-Google-Smtp-Source: ABdhPJzN52zO88+9hLmpwSBFTD5lnEjltT0Rg2HSp894qzgBTjZCUqjcjmoluZGRJ5sv8DlEZb3NjQ==
X-Received: by 2002:a05:6830:34a7:: with SMTP id c39mr4738757otu.357.1622832582181;
        Fri, 04 Jun 2021 11:49:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e14sm574608oow.11.2021.06.04.11.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:49:41 -0700 (PDT)
Received: (nullmailer pid 3706969 invoked by uid 1000);
        Fri, 04 Jun 2021 18:49:39 -0000
Date:   Fri, 4 Jun 2021 13:49:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: Re: [PATCH 2/4] MIPS: pci: Add driver for MT7621 PCIe controller
Message-ID: <20210604184939.GA3695694@robh.at.kernel.org>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com>
 <20210531131431.bzsvmefqdyawmeo2@pali>
 <CAMhs-H80=7jctPT70rOmcwcqPw+9iUF84_ZCgGr-TKwJ4eB2Lg@mail.gmail.com>
 <20210531135041.42ovpmbwuc3yfkaw@pali>
 <CAMhs-H_fR5aXJ=diTm-2yhgjjv9S6N6jA-DOZ0K_BnQ4UHHh3Q@mail.gmail.com>
 <CAMhs-H8EwQDvZtzpPn2u_WOWt1wcixOvz5nVZP2miM6j0+P7EA@mail.gmail.com>
 <20210602122337.fxwaikulbawwkc2j@pali>
 <CAMhs-H8Gr=ObgMZAZ9VuNqHX4TaKQPPGNNMY4pzh9o=3EbAgUQ@mail.gmail.com>
 <20210604165525.ybgyusazeyzx642v@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210604165525.ybgyusazeyzx642v@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 04, 2021 at 06:55:25PM +0200, Pali Rohár wrote:
> On Wednesday 02 June 2021 14:43:53 Sergio Paracuellos wrote:
> > Hi Pali,
> > 
> > On Wed, Jun 2, 2021 at 2:23 PM Pali Rohár <pali@kernel.org> wrote:
> > >
> > > On Wednesday 02 June 2021 14:16:26 Sergio Paracuellos wrote:
> > > > Hi Pali,
> > > >
> > > > On Mon, May 31, 2021 at 4:19 PM Sergio Paracuellos
> > > > <sergio.paracuellos@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 31, 2021 at 3:50 PM Pali Rohár <pali@kernel.org> wrote:
> > > > > >
> > > > > > On Monday 31 May 2021 15:39:55 Sergio Paracuellos wrote:
> > > > > > > Hi Pali,
> > > > > > >
> > > > > > > Thanks for your comments.
> > > > > > >
> > > > > > > On Mon, May 31, 2021 at 3:14 PM Pali Rohár <pali@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wrote:
> > > > > > > > > This patch adds a driver for the PCIe controller of MT7621 SoC.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  arch/mips/pci/Makefile     |   1 +
> > > > > > > > >  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++++++++++++++++
> > > > > > > > >  arch/mips/ralink/Kconfig   |   9 +-
> > > > > > > > >  3 files changed, 633 insertions(+), 1 deletion(-)
> > > > > > > > >  create mode 100644 arch/mips/pci/pci-mt7621.c
> > > > > > > > >
> > > > > > > > > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> > > > > > > > > index f3eecc065e5c..178c550739c4 100644
> > > > > > > > > --- a/arch/mips/pci/Makefile
> > > > > > > > > +++ b/arch/mips/pci/Makefile
> > > > > > > > > @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)    += pci-ar2315.o
> > > > > > > > >  obj-$(CONFIG_SOC_AR71XX)     += pci-ar71xx.o
> > > > > > > > >  obj-$(CONFIG_PCI_AR724X)     += pci-ar724x.o
> > > > > > > > >  obj-$(CONFIG_PCI_XTALK_BRIDGE)       += pci-xtalk-bridge.o
> > > > > > > > > +obj-$(CONFIG_PCI_MT7621)     += pci-mt7621.o
> > > > > > > > >  #
> > > > > > > > >  # These are still pretty much in the old state, watch, go blind.
> > > > > > > > >  #
> > > > > > > > > diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/pci-mt7621.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..fe1945819d25
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/arch/mips/pci/pci-mt7621.c
> > > > > > > > ...
> > > > > > > > > +static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
> > > > > > > > > +{
> > > > > > > > > +     struct device *dev = pcie->dev;
> > > > > > > > > +     struct mt7621_pcie_port *port;
> > > > > > > > > +     u8 num_slots_enabled = 0;
> > > > > > > > > +     u32 slot;
> > > > > > > > > +     u32 val;
> > > > > > > > > +     int err;
> > > > > > > > > +
> > > > > > > > > +     /* Setup MEMWIN and IOWIN */
> > > > > > > > > +     pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> > > > > > > > > +     pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
> > > > > > > > > +
> > > > > > > > > +     list_for_each_entry(port, &pcie->ports, list) {
> > > > > > > > > +             if (port->enabled) {
> > > > > > > > > +                     err = clk_prepare_enable(port->clk);
> > > > > > > > > +                     if (err) {
> > > > > > > > > +                             dev_err(dev, "enabling clk pcie%d\n", slot);
> > > > > > > > > +                             return err;
> > > > > > > > > +                     }
> > > > > > > > > +
> > > > > > > > > +                     mt7621_pcie_enable_port(port);
> > > > > > > > > +                     dev_info(dev, "PCIE%d enabled\n", port->slot);
> > > > > > > > > +                     num_slots_enabled++;
> > > > > > > > > +             }
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     for (slot = 0; slot < num_slots_enabled; slot++) {
> > > > > > > > > +             val = read_config(pcie, slot, PCI_COMMAND);
> > > > > > > > > +             val |= PCI_COMMAND_MASTER;
> > > > > > > > > +             write_config(pcie, slot, PCI_COMMAND, val);
> > > > > > > >
> > > > > > > > Hello! Is this part of code correct? Because it looks strange if PCIe
> > > > > > > > controller driver automatically enables PCI bus mastering, prior device
> > > > > > > > driver initialize itself.
> > > > > > > >
> > > > > > > > Moreover kernel has already function pci_set_master() for this purpose
> > > > > > > > which is used by device drivers.
> > > > > > > >
> > > > > > > > So I think this code can confuse some device drivers...
> > > > > > >
> > > > > > > I agree that we have pci_set_master() to be used in pci device driver
> > > > > > > code. Original controller driver set this bit for enabled slots. Since
> > > > > > > there is no documentation at all for the PCI in this SoC
> > > > > >
> > > > > > I see... this is really a big problem to do any driver development...
> > > > >
> > > > > For sure it is :(.
> > > > >
> > > > > >
> > > > > > > I have
> > > > > > > maintained the setting in the driver in a cleaner way. See original
> > > > > > > driver code and the setting here [0]. There is no other reason than
> > > > > > > that. I am ok with removing this from here and testing with my two
> > > > > > > devices that everything is still ok if having this setting in the pci
> > > > > > > controller driver is a real problem.
> > > > > >
> > > > > > You can run lspci -nnvv with and without PCI_COMMAND_MASTER code and
> > > > > > then compare outputs.
> > > > > >
> > > > > > Device drivers for sure enable PCI_COMMAND_MASTER at the time when it is
> > > > > > needed, so it is possible that there would be no difference in lspci
> > > > > > output.
> > > > >
> > > > > Thanks. I will take this into account when v2 is submitted after more
> > > > > review comments come :).
> > > >
> > > > I have tested to remove this and check lspci -nnvv output with and
> > > > without PCI_COMMAND_MASTER code and, as you pointed out, there is no
> > > > difference between them. Also, both boards are working without
> > > > regressions at all. So I will remove this code for next version.
> > >
> > > Perfect!
> > >
> > > > Thanks,
> > > >     Sergio Paracuellos
> > > > >
> > > > > >
> > > > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/mt7621-pci/pci-mt7621.c?h=v4.18#n676
> > > > > > >
> > > > > > > Best regards,
> > > > > > >     Sergio Paracuellos
> > > > > > > >
> > > > > > > > > +             /* configure RC FTS number to 250 when it leaves L0s */
> > > > > > > > > +             val = read_config(pcie, slot, PCIE_FTS_NUM);
> > > > > > > > > +             val &= ~PCIE_FTS_NUM_MASK;
> > > > > > > > > +             val |= PCIE_FTS_NUM_L0(0x50);
> > > > > > > > > +             write_config(pcie, slot, PCIE_FTS_NUM, val);
> > >
> > > Could you look also what is doing this code (PCIE_FTS_NUM)? It is marked
> > > as MT specific register. But from this code for me it looks like that it
> > > just access config space of some device and therefore it could be some
> > > standard PCIe register. Just with hardcoded calculated offset.
> 
> So based on your lspci output, there is no PCIe capability register at
> address PCIE_FTS_NUM (0x70c), right? It seems strange to trying access
> capability register outside of capability list.

Looks like a DW PCIe port logic register:

drivers/pci/controller/dwc/pcie-designware.h-/* Synopsys-specific PCIe configuration registers */
drivers/pci/controller/dwc/pcie-designware.h:#define PCIE_PORT_AFR                      0x70C
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_N_FTS_MASK                GENMASK(15, 8)
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_N_FTS(n)          FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_CC_N_FTS_MASK             GENMASK(23, 16)
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_CC_N_FTS(n)               FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, n)
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_ENTER_ASPM                BIT(30)
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L0S_ENTRANCE_LAT_SHIFT    24
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L0S_ENTRANCE_LAT_MASK     GENMASK(26, 24)
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L1_ENTRANCE_LAT_SHIFT     27
drivers/pci/controller/dwc/pcie-designware.h-#define PORT_AFR_L1_ENTRANCE_LAT_MASK      GENMASK(29, 27)

Rob
