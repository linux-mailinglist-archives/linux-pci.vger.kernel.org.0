Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F128559C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgJGAvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 20:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgJGAvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 20:51:21 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E63C2078E;
        Wed,  7 Oct 2020 00:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602031880;
        bh=i8I4wCGU4c5vQJVMhh90gjLnO/BjDbzPHoYO2I3rz+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OUgBiL8D4O68b1nQY4R/mN4/qMpwpG01E9VVwcBt+QZYPpTtu87bP7WC0XadViHzh
         AbHBI9A6ss6lwF/OI/gvMdVdLMp4xYTZKGFJD011IKhRR9GkGn2WeGiXwm7FNPq43U
         aMfDjensh0hWhIBx9VrRi1R9RnxFuj0Cy+GApKPA=
Date:   Tue, 6 Oct 2020 19:51:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, dvhart@infradead.org, andy@infradead.org,
        bhelgaas@google.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 1/5] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
Message-ID: <20201007005118.GA3230211@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75c3ff53dbe26ee0c6825e8d1f5f10489a5722c.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 06, 2020 at 03:45:54PM -0700, David E. Box wrote:
> Hi Bjorn,
> 
> This patch has been acked and unchanged for weeks. Is it possible to
> get this pulled into next? We have SIOV and CXL related work that is
> using these definitions. Thanks.

I acked it because I expected you to merge it along with the rest of
the series.

I guess I could merge this patch via the PCI tree if you really want,
but that ends up being a hassle because we have to worry about which
order things get merged to Linus' tree.  Better if the whole series is
merged via the same tree.

> On Fri, 2020-10-02 at 18:31 -0700, David E. Box wrote:
> > Add PCIe Designated Vendor-Specific Extended Capability (DVSEC) and
> > defines
> > for the header offsets. Defined in PCIe r5.0, sec 7.9.6.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  include/uapi/linux/pci_regs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h
> > b/include/uapi/linux/pci_regs.h
> > index f9701410d3b5..beafeee39e44 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -720,6 +720,7 @@
> >  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port
> > Containment */
> >  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
> >  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement
> > */
> > +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific 
> > */
> >  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> >  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer
> > 16.0 GT/s */
> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> > @@ -1062,6 +1063,10 @@
> >  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /*
> > LTR_L1.2_THRESHOLD_Scale */
> >  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register
> > */
> >  
> > +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > +#define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-
> > Specific Header1 */
> > +#define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-
> > Specific Header2 */
> > +
> >  /* Data Link Feature */
> >  #define PCI_DLF_CAP		0x04	/* Capabilities Register */
> >  #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link
> > Feature Exchange Enable */
> 
