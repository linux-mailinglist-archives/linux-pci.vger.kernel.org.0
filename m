Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B45359C1D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 12:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhDIKaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 06:30:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhDIKaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 06:30:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E8F1FB;
        Fri,  9 Apr 2021 03:29:53 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 397DB3F73D;
        Fri,  9 Apr 2021 03:29:52 -0700 (PDT)
Date:   Fri, 9 Apr 2021 11:29:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cheol Yong Kim <ckim@maxlinear.com>,
        Qiming Wu <qwu@maxlinear.com>,
        Lei Chuan Hua <lchuanhua@maxlinear.com>
Subject: Re: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt
 lines
Message-ID: <20210409102946.GA14799@lpieralisi>
References: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
 <20210323113559.GE29286@e121166-lin.cambridge.arm.com>
 <CAFBinCBaa_uGBg8x=nPTs6sYNqv_OCU2PgCaUKLQGNSN+Up99A@mail.gmail.com>
 <MN2PR19MB36934176A011B86624E1EA2BB1739@MN2PR19MB3693.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR19MB36934176A011B86624E1EA2BB1739@MN2PR19MB3693.namprd19.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 09, 2021 at 10:17:12AM +0000, Rahul Tanwar wrote:
> On 9/4/2021 4:40 am, Martin Blumenstingl wrote:
> > This email was sent from outside of MaxLinear.
> > 
> > Hi Lorenzo,
> > 
> > On Tue, Mar 23, 2021 at 12:36 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >  >
> >  > On Wed, Jan 06, 2021 at 02:55:40PM +0100, Martin Blumenstingl wrote:
> >  > > The legacy PCI interrupt lines need to be enabled using PCIE_APP_IRNEN
> >  > > bits 13 (INTA), 14 (INTB), 15 (INTC) and 16 (INTD). The old code 
> > however
> >  > > was taking (for example) "13" as raw value instead of taking BIT(13).
> >  > > Define the legacy PCI interrupt bits using the BIT() macro and then use
> >  > > these in PCIE_APP_IRN_INT.
> >  > >
> >  > > Fixes: ed22aaaede44 ("PCI: dwc: intel: PCIe RC controller driver")
> >  > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >  > > ---
> >  > > drivers/pci/controller/dwc/pcie-intel-gw.c | 10 ++++++----
> >  > > 1 file changed, 6 insertions(+), 4 deletions(-)
> >  > >
> >  > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c 
> > b/drivers/pci/controller/dwc/pcie-intel-gw.c
> >  > > index 0cedd1f95f37..ae96bfbb6c83 100644
> >  > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> >  > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> >  > > @@ -39,6 +39,10 @@
> >  > > #define PCIE_APP_IRN_PM_TO_ACK BIT(9)
> >  > > #define PCIE_APP_IRN_LINK_AUTO_BW_STAT BIT(11)
> >  > > #define PCIE_APP_IRN_BW_MGT BIT(12)
> >  > > +#define PCIE_APP_IRN_INTA BIT(13)
> >  > > +#define PCIE_APP_IRN_INTB BIT(14)
> >  > > +#define PCIE_APP_IRN_INTC BIT(15)
> >  > > +#define PCIE_APP_IRN_INTD BIT(16)
> >  > > #define PCIE_APP_IRN_MSG_LTR BIT(18)
> >  > > #define PCIE_APP_IRN_SYS_ERR_RC BIT(29)
> >  > > #define PCIE_APP_INTX_OFST 12
> >  > > @@ -48,10 +52,8 @@
> >  > > PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
> >  > > PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
> >  > > PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
> >  > > - (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
> >  > > - (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
> >  > > - (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
> >  > > - (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
> >  > > + PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> >  > > + PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
> >  > >
> >  > > #define BUS_IATU_OFFSET SZ_256M
> >  > > #define RESET_INTERVAL_MS 100
> >  >
> >  > This looks like a significant bug - which in turn raises the question
> >  > on how well this driver has been tested.
> > to give them the benefit of doubt: maybe only MSIs were tested
> > 
> >  > Dilip, can you review and ACK asap please ?
> >  From "Re: MaxLinear, please maintain your drivers was Re: [PATCH]
> > leds: lgm: fix gpiolib dependency" [0]:
> >  > Please send any Lightning Mountain SoC related issues email to Rahul
> >  > Tanwar (rtanwar@maxlinear.com) and I will ensure that I address the
> >  > issues in a timely manner.
> > so I added rtanwar@maxlinear.com to this email
> > 
> > 
> > Best regards,
> > Martin
> > 
> > 
> > [0] https://lkml.org/lkml/2021/3/16/282 
> > <https://lkml.org/lkml/2021/3/16/282>
> 
> 
> Dilip has left the org. So not sure how exactly he tested it (maybe only 
> MSIs). But i have confirmed it to be a bug. Thanks Martin for fixing it.

Can you take on maintainership for this driver please ?

If yes please send a MAINTAINERS file patch.

Thanks,
Lorenzo

> Acked-by: Rahul Tanwar <rtanwar@maxlinear.com>
> 
> Regards,
> Rahul
> 
> 
> 
> 
> 
