Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6452CDF36
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 20:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLCTyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 14:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgLCTyr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 14:54:47 -0500
Date:   Thu, 3 Dec 2020 13:54:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607025246;
        bh=m8ZjqwDEcv6sovp8C5+pMQmjlRzo8NG4L7K7lJK+EEg=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=GAyiSr/PlQlKLaoR2pU96UlWn2Zqc0TT/eXL2AZL4t//6GoVr9po4KBSKCzxqSyt3
         SD8lD+Jasjo+FpzoRUzA0/+J1YSb/GMt5Owu+FuEI1T0go/H07y1NNfO4CYxjXRL9g
         RzGtU6IQsEOIdqdC4DnnGwBHqEzVrYdKUUe5uCB/x8tH+1XSKB44PnXpaPLh0MxlV0
         WCBfDbKfnZaTTAjxwT40klPX6qLpeZcV9jYt+nHfjDKujQiHM5JCctV5FCp1TImVlv
         w4W4gqt2TJFyLUxaU3HWqjELEnFjmQshkPPaDmiEyBhc69bW8NWFoVxtI6M+XSjTbU
         nAiIbIffJURfw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
Message-ID: <20201203195404.GA1587879@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75de8b9d-b4f1-5a68-8510-019017163baa@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 12:33:45AM +0530, Vidya Sagar wrote:
> On 12/3/2020 11:54 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 24, 2020 at 04:20:35PM +0530, Vidya Sagar wrote:
> > > There are devices (Ex:- Marvell SATA controller) that don't support
> > > 64-bit MSIs and the same is advertised through their MSI capability
> > > register. Set no_64bit_msi flag explicitly for such devices in the
> > > MSI setup code so that the msi_verify_entries() API would catch
> > > if the MSI arch code tries to use 64-bit MSI.
> > 
> > This seems good to me.  I'll post a possible revision to set
> > dev->no_64bit_msi in the device enumeration path instead of in the IRQ
> > allocation path, since it's really a property of the device, not of
> > the msi_desc.
> > 
> > I like the extra checking this gives us.  Was this prompted by
> > tripping over something, or is it something you noticed by code
> > reading?  If the former, a hint about what was wrong and how it's
> > being fixed would be useful.
> I observed functionality issue with Marvell SATA controller (1b4b:9171) when
> the allocated MSI target address was a 64-bit address. I mentioned the
> Marvell SATA controller as an example in the commit message.

I know you mentioned the Marvell controller, but apparently that
device is working perfectly correctly: it does not support 64-bit MSI,
and it does not advertise support for 64-bit MSI.

So if there's a functionality issue, that means something is wrong in
Linux that caused us to assign a 64-bit MSI address to it.  *That*
issue is what I want to know about.  Your patch only warns about the
issue; it doesn't fix it.

I don't think there's any point in specifically mentioning the Marvell
device if it is working correctly, because the same issue should
affect *any* device that doesn't support 64-bit MSI.  But if there's
some arch code that incorrectly assigns a 64-bit address, it would
definitely be useful to specify the arch.  And hopefully there's a fix
for that arch code, too.

> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > V2:
> > > * Addressed Bjorn's comment and changed the error message
> > > 
> > >   drivers/pci/msi.c | 11 +++++++----
> > >   1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > index d52d118979a6..8de5ba6b4a59 100644
> > > --- a/drivers/pci/msi.c
> > > +++ b/drivers/pci/msi.c
> > > @@ -581,10 +581,12 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
> > >        entry->msi_attrib.multi_cap     = (control & PCI_MSI_FLAGS_QMASK) >> 1;
> > >        entry->msi_attrib.multiple      = ilog2(__roundup_pow_of_two(nvec));
> > > 
> > > -     if (control & PCI_MSI_FLAGS_64BIT)
> > > +     if (control & PCI_MSI_FLAGS_64BIT) {
> > >                entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> > > -     else
> > > +     } else {
> > >                entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
> > > +             dev->no_64bit_msi = 1;
> > > +     }
> > > 
> > >        /* Save the initial mask status */
> > >        if (entry->msi_attrib.maskbit)
> > > @@ -602,8 +604,9 @@ static int msi_verify_entries(struct pci_dev *dev)
> > >        for_each_pci_msi_entry(entry, dev) {
> > >                if (!dev->no_64bit_msi || !entry->msg.address_hi)
> > >                        continue;
> > > -             pci_err(dev, "Device has broken 64-bit MSI but arch"
> > > -                     " tried to assign one above 4G\n");
> > > +             pci_err(dev, "Device has either broken 64-bit MSI or "
> > > +                     "only 32-bit MSI support but "
> > > +                     "arch tried to assign one above 4G\n");
> > >                return -EIO;
> > >        }
> > >        return 0;
> > > --
> > > 2.17.1
> > > 
