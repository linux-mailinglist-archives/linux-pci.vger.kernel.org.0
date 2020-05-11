Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0117A1CD5D9
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgEKKGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 06:06:14 -0400
Received: from foss.arm.com ([217.140.110.172]:55264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgEKKGO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 06:06:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C351FB;
        Mon, 11 May 2020 03:06:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AB6F3F305;
        Mon, 11 May 2020 03:06:12 -0700 (PDT)
Date:   Mon, 11 May 2020 11:06:10 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Message-ID: <20200511100610.GB24149@e121166-lin.cambridge.arm.com>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
 <20200414203005.5166-4-jonathan.derrick@intel.com>
 <20200416073004.GB32000@infradead.org>
 <47e4b64208ec1f8400a420db434cbbd8322cbbd8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e4b64208ec1f8400a420db434cbbd8322cbbd8.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 16, 2020 at 02:35:59PM +0000, Derrick, Jonathan wrote:
> On Thu, 2020-04-16 at 00:30 -0700, Christoph Hellwig wrote:
> > On Tue, Apr 14, 2020 at 04:30:03PM -0400, Jon Derrick wrote:
> > > In order to make pci-bridge-emul easier to keep up-to-date with new PCIe
> > > features, convert all named register bits to GENMASK and BIT pairs. This
> > > patch doesn't alter any of the PCI configuration space as these bits are
> > > fully defined.
> > > 
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/pci-bridge-emul.c | 17 ++++++-----------
> > >  1 file changed, 6 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> > > index c00c30ffb198..bbcccadca85e 100644
> > > --- a/drivers/pci/pci-bridge-emul.c
> > > +++ b/drivers/pci/pci-bridge-emul.c
> > > @@ -221,11 +221,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
> > >  		 * as reserved bits.
> > >  		 */
> > >  		.rw = GENMASK(12, 0),
> > > -		.w1c = (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
> > > -			PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
> > > -			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
> > > -		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
> > > -		       PCI_EXP_SLTSTA_EIS) << 16,
> > > +		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
> > > +		.ro = GENMASK(7, 5) << 16,
> > 
> > FYI, I find the previous version a lot more readable.  Or rather I find
> > it readable while the new one looks like intentionally obsfucated
> > garbage to me.
> 
> Well I guess that's entirely subjective. But I do think if all the
> existing BIT and GENMASK were converted to named registers instead, it
> would be a lot easier to overlook mistakes.

Hi Jon,

where are we with this patch ? If we drop it I assume you will have
to rebase subsequent patches - I do think Christoph has a point here.

Thanks,
Lorenzo
