Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4454C34C4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJAMuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 08:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAMuM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 08:50:12 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5192190F;
        Tue,  1 Oct 2019 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569934211;
        bh=/fWs0Dn9H5ufh6uVeJFS5qzH9dfJHbHa3AsDZ9j3174=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nKYjehPUKg3g4VuLaS02T4X7cS2ykVhYOWudr134ZsfhvjqoOu+BaEcs1d5tHta4+
         hxzx34lRga0pnp12ZYb++KbuAeSDjoFqO67Rz7OpRozH0VdSLf8/6uZwzF58Ltb7R7
         LUd4puYZrupigG9yimYXFv7YLnTUoOLIdQl/WDLI=
Date:   Tue, 1 Oct 2019 07:50:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andrew Murray <andrew.murray@arm.com>, zenglu@loongson.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add Loongson vendor ID and device IDs
Message-ID: <20191001125010.GA38575@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cde609-7918-6b1c-940d-29ecaf7e5cbb@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 01, 2019 at 10:53:44AM +0800, Tiezhu Yang wrote:
> On 09/30/2019 10:02 PM, Andrew Murray wrote:
> > On Mon, Sep 30, 2019 at 12:55:20PM +0800, Tiezhu Yang wrote:
> > > Add the Loongson vendor ID and device IDs to pci_ids.h
> > > to be used in the future.
> > > 
> > > The Loongson IDs can be found at the following link:
> > > https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
> > > 
> > > Co-developed-by: Lu Zeng <zenglu@loongson.cn>
> > > Signed-off-by: Lu Zeng <zenglu@loongson.cn>
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >   include/linux/pci_ids.h | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index 21a5724..119639d 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -3111,4 +3111,23 @@
> > > 
> > >   #define PCI_VENDOR_ID_NCUBE            0x10ff
> > > 
> > > +#define PCI_VENDOR_ID_LOONGSON                 0x0014
> > > +#define PCI_DEVICE_ID_LOONGSON_HT              0x7a00
> > > +#define PCI_DEVICE_ID_LOONGSON_APB             0x7a02
> > > +#define PCI_DEVICE_ID_LOONGSON_GMAC            0x7a03
> > > +#define PCI_DEVICE_ID_LOONGSON_OTG             0x7a04
> > > +#define PCI_DEVICE_ID_LOONGSON_GPU_2K1000      0x7a05
> > > +#define PCI_DEVICE_ID_LOONGSON_DC              0x7a06
> > > +#define PCI_DEVICE_ID_LOONGSON_HDA             0x7a07
> > > +#define PCI_DEVICE_ID_LOONGSON_SATA            0x7a08
> > > +#define PCI_DEVICE_ID_LOONGSON_PCIE_X1         0x7a09
> > > +#define PCI_DEVICE_ID_LOONGSON_SPI             0x7a0b
> > > +#define PCI_DEVICE_ID_LOONGSON_LPC             0x7a0c
> > > +#define PCI_DEVICE_ID_LOONGSON_DMA             0x7a0f
> > > +#define PCI_DEVICE_ID_LOONGSON_EHCI            0x7a14
> > > +#define PCI_DEVICE_ID_LOONGSON_GPU_7A1000      0x7a15
> > > +#define PCI_DEVICE_ID_LOONGSON_PCIE_X4         0x7a19
> > > +#define PCI_DEVICE_ID_LOONGSON_OHCI            0x7a24
> > > +#define PCI_DEVICE_ID_LOONGSON_PCIE_X8         0x7a29
> > Hi Tiezhu,
> > 
> > Thanks for the patch - however it is preferred to provide new PCI
> > definitions along with the drivers that use them. They don't
> > provide any useful value without drivers that use them.
> 
> Thanks for your reply. This is the first step of the Loongson kernel
> team, we will submit other related individual driver patches step by
> step in the near future, these small patches make an easily
> understood change that can be verified by reviewers.

There are two opposing goals here:

  1) The "publish early, publish often" idea that posting small things
  early helps get useful feedback.

  2) The idea of waiting until things can be published in logical
  units so readers can see context and how things fit together.

I think Andrew's point (which I agree with) is that an individual
trivial patch like this is not enough to give meaningful feedback.  I
think you'll get better feedback if you wait and collect things until
you can post a series that actually fixes a bug or adds a small
feature.  It also makes it easier for me to track patches if I can
deal with a whole series at once instead of trying to figure out which
individual patches are related.

So I'd encourage you to think in terms of a series of 3-10 patches
that are all related and together produce something useful.  That's
easier for readers to digest than the same patches posted
incrementally over several days or weeks.

Bjorn
