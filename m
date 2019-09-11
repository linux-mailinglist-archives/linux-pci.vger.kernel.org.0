Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED0AF8DC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfIKJ1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 05:27:13 -0400
Received: from foss.arm.com ([217.140.110.172]:44278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfIKJ1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Sep 2019 05:27:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 064E0337;
        Wed, 11 Sep 2019 02:27:13 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 723133F71F;
        Wed, 11 Sep 2019 02:27:12 -0700 (PDT)
Date:   Wed, 11 Sep 2019 10:27:10 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: Re: [PATCH 2/2] PCI: dwc: Add support to disable equalization phase
 2 and 3
Message-ID: <20190911092710.GO9720@e119886-lin.cambridge.arm.com>
References: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4@epcas5p1.samsung.com>
 <1568118302-10505-2-git-send-email-pankaj.dubey@samsung.com>
 <20190910140502.GL9720@e119886-lin.cambridge.arm.com>
 <CAGcde9Fm+WGamjAC6R4jmaShMYxAoCsofggfwdJ7viYt3NE_sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGcde9Fm+WGamjAC6R4jmaShMYxAoCsofggfwdJ7viYt3NE_sQ@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 10, 2019 at 09:51:41PM +0530, Pankaj Dubey wrote:
> On Tue, 10 Sep 2019 at 19:59, Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > On Tue, Sep 10, 2019 at 05:55:02PM +0530, Pankaj Dubey wrote:
> > > From: Anvesh Salveru <anvesh.s@samsung.com>
> > >
> > > In some platforms, PCIe PHY may have issues which will prevent linkup
> > > to happen in GEN3 or high speed. In case equalization fails, link will
> > > fallback to GEN1.
> > >
> > > Designware controller gives flexibility to disable GEN3 equalization
> > > completely or only phase 2 and 3.
> >
> > Do some platforms have issues conducting phase 2 and 3 when they successfully
> > conduct phase 0 and 1?
> >
> 
> Yes, it is possible.
> 
> > >
> > > Platform drivers can disable equalization phase 2 and 3, by setting
> > > dwc_pci_quirk flag DWC_EQUALIZATION_DISABLE.
> > >
> > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 3 +++
> > >  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> > >  2 files changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index bf82091..97a8268 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -472,5 +472,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >       if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> > >               val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > >
> > > +     if (pci->dwc_pci_quirk & DWC_EQ_PHASE_2_3_DISABLE)
> > > +             val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> > > +

Also is it harmless to set both DWC_EQUALIZATION_DISABLE and
DWC_EQ_PHASE_2_3_DISABLE? (Which is permitted here).

Thanks,

Andrew Murray

> > >       dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > >  }
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index a1453c5..b541508 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -31,6 +31,7 @@
> > >
> > >  /* Parameters for PCIe Quirks */
> > >  #define DWC_EQUALIZATION_DISABLE     0x1
> > > +#define DWC_EQ_PHASE_2_3_DISABLE     0x2
> >
> > It only makes sense for either DWC_EQUALIZATION_DISABLE or DWC_EQ_PHASE_2_3_DISABLE
> > to be specified, though if dwc_pci_quirk intends to hold other quirks should these
> > be numbers and not bit fields?
> >
> Yes, you are right in a given platform it will be either
> DWC_EQUALIZATION_DISABLE or DWC_EQ_PHASE_2_3_DISABLE.
> 
> Intention behind making it bit-field was to add other quirks in future.
> 
> > Thanks,
> >
> > Andrew Murray
> >
> > >
> > >  /* Synopsys-specific PCIe configuration registers */
> > >  #define PCIE_PORT_LINK_CONTROL               0x710
> > > @@ -65,6 +66,7 @@
> > >
> > >  #define PCIE_PORT_GEN3_RELATED               0x890
> > >  #define PORT_LOGIC_GEN3_EQ_DISABLE   BIT(16)
> > > +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE BIT(9)
> > >
> > >  #define PCIE_ATU_VIEWPORT            0x900
> > >  #define PCIE_ATU_REGION_INBOUND              BIT(31)
> > > --
> > > 2.7.4
> > >
