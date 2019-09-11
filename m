Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07A6AF8CE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfIKJXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 05:23:14 -0400
Received: from foss.arm.com ([217.140.110.172]:44230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfIKJXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 05:23:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F0FB337;
        Wed, 11 Sep 2019 02:23:13 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA1923F71F;
        Wed, 11 Sep 2019 02:23:12 -0700 (PDT)
Date:   Wed, 11 Sep 2019 10:23:11 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Add support to disable GEN3 equalization
Message-ID: <20190911092310.GN9720@e119886-lin.cambridge.arm.com>
References: <CGME20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f@epcas5p4.samsung.com>
 <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
 <20190910135813.GK9720@e119886-lin.cambridge.arm.com>
 <CAGcde9F6dTGga6Rxo62PPk3AMb3tK8oqo9K6Zi=0TbnFktmQQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGcde9F6dTGga6Rxo62PPk3AMb3tK8oqo9K6Zi=0TbnFktmQQw@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 10, 2019 at 09:46:28PM +0530, Pankaj Dubey wrote:
> On Tue, 10 Sep 2019 at 19:56, Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Sep 10, 2019 at 05:55:01PM +0530, Pankaj Dubey wrote:
> > > From: Anvesh Salveru <anvesh.s@samsung.com>
> > >
> > > In some platforms, PCIe PHY may have issues which will prevent linkup
> > > to happen in GEN3 or high speed. In case equalization fails, link will
> > > fallback to GEN1.
> >
> > When you refer to "high speed", do you mean "higher speeds" as in GEN3,
> > GEN4, etc?
> >
> 
> Yes. Will reword the commit message as "higher speeds"
> 
> > >
> > > Designware controller has support for disabling GEN3 equalization if
> > > required. This patch enables the designware driver to disable the PCIe
> > > GEN3 equalization by writing into PCIE_PORT_GEN3_RELATED.
> >
> > Thus limiting to GEN2 speeds max, right?
> >
> > Is the purpose of PORT_LOGIC_GEN3_EQ_DISABLE to disable GEN3 and above
> > even though we advertise GEN3 and above speeds? I.e. the IP advertises
> > GEN3 but the phy can't handle it, we can't change what the IP advertises
> > and so we disable equalization to limit to GEN2?
> >
> > I notice many of the other dwc drivers (dra7xx, keystone, tegra194, imx6)
> > seem to use the device tree to specify a max-link-speed and then impose
> > that limit by changing the value in PCI_EXP_LNKCAP. Is your
> > PORT_LOGIC_GEN3_EQ_DISABLE approach and alternative to the PCI_EXP_LNKCAP
> > approach, or does your approach add something else?
> >
> 
> No, max speed will be still as per advertised by link or it will be
> equal to the limited speed as per DT property if any.
> This register will prohibit to perform all phases of equalization and
> thus allowing link to happen in maximum supported/advertised speed.
> 
> This is not to limit max link speed, this register helps link to
> happen in higher speeds (GEN3/4) without going through equalization
> phases. It is intended to use only if at all link fails to latch up in
> GEN3/4 due to failure in equalization phases.

I thought that for GEN3 and beyond equalization was *required* - with only
phases 2 and 3 being optional. Therefore I'm suprised to see that if
equalization does fail we continue to train the link anyway. Have I
understood this correctly?

Also are there any plans to provide patches to use this quirk on any
drivers?

> 
> > >
> > > Platform drivers can disable equalization by setting the dwc_pci_quirk
> > > flag DWC_EQUALIZATION_DISABLE.
> > >
> > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h | 7 +++++++
> > >  2 files changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 7d25102..bf82091 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -466,4 +466,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >               break;
> > >       }
> > >       dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > +
> > > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > > +
> > > +     if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> > > +             val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > > +
> > > +     dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> >
> > The problem here is that even when DWC_EQUALIZATION_DISABLE is not set
> > the driver will read and write PCIE_PORT_GEN3_RELATED when it is not
> > needed. How about something like:
> >
> > > +
> > > +     if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE) {
> > > +             val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > > +             val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > > +             dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > > +     }
> >
> 
> Yes, before posting we taught about it, but then next patchset is
> adding one more quirk and in that case we need to repeat read and
> write under each if condition. I hope that repetition should be fine.

I understand. I think the repetition is prefered over needlessly reading and
writing registers.

Given these quirks are so similar, I wouldn't have a problem with them being
in the same patch.

Thanks,

Andrew Murray

> 
> > >  }
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index ffed084..a1453c5 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -29,6 +29,9 @@
> > >  #define LINK_WAIT_MAX_IATU_RETRIES   5
> > >  #define LINK_WAIT_IATU                       9
> > >
> > > +/* Parameters for PCIe Quirks */
> > > +#define DWC_EQUALIZATION_DISABLE     0x1
> >
> > How about using BIT(1) instead? Thus implying that you can combine
> > quirks.
> >
> 
> Agreed.
> 
> > Thanks,
> >
> > Andrew Murray
> >
> > > +
> > >  /* Synopsys-specific PCIe configuration registers */
> > >  #define PCIE_PORT_LINK_CONTROL               0x710
> > >  #define PORT_LINK_MODE_MASK          GENMASK(21, 16)
> > > @@ -60,6 +63,9 @@
> > >  #define PCIE_MSI_INTR0_MASK          0x82C
> > >  #define PCIE_MSI_INTR0_STATUS                0x830
> > >
> > > +#define PCIE_PORT_GEN3_RELATED               0x890
> > > +#define PORT_LOGIC_GEN3_EQ_DISABLE   BIT(16)
> > > +
> > >  #define PCIE_ATU_VIEWPORT            0x900
> > >  #define PCIE_ATU_REGION_INBOUND              BIT(31)
> > >  #define PCIE_ATU_REGION_OUTBOUND     0
> > > @@ -244,6 +250,7 @@ struct dw_pcie {
> > >       struct dw_pcie_ep       ep;
> > >       const struct dw_pcie_ops *ops;
> > >       unsigned int            version;
> > > +     unsigned int            dwc_pci_quirk;
> > >  };
> > >
> > >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> > > --
> > > 2.7.4
> > >
