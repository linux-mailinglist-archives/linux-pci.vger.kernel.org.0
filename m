Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86906997BE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfHVPH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 11:07:56 -0400
Received: from foss.arm.com ([217.140.110.172]:47826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbfHVPH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 11:07:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC521337;
        Thu, 22 Aug 2019 08:07:55 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7F93F718;
        Thu, 22 Aug 2019 08:07:55 -0700 (PDT)
Date:   Thu, 22 Aug 2019 16:07:53 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 3/7] PCI/VPD: Add VPD release quirk for Amazon's
 Annapurna Labs Root Port
Message-ID: <20190822150752.GQ23903@e119886-lin.cambridge.arm.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821153545.17635-4-jonnyc@amazon.com>
 <20190822114146.GP23903@e119886-lin.cambridge.arm.com>
 <5a2c0097471e933d6f6a3964ac9fba9520994991.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2c0097471e933d6f6a3964ac9fba9520994991.camel@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 02:36:24PM +0000, Chocron, Jonathan wrote:
> On Thu, 2019-08-22 at 12:41 +0100, Andrew Murray wrote:
> > On Wed, Aug 21, 2019 at 06:35:43PM +0300, Jonathan Chocron wrote:
> > > The Amazon Annapurna Labs PCIe Root Port exposes the VPD
> > > capability,
> > > but there is no actual support for it.
> > > 
> > > The reason for not using the already existing quirk_blacklist_vpd()
> > > is that, although this fails pci_vpd_read/write, the 'vpd' sysfs
> > > entry still exists. When running lspci -vv, for example, this
> > > results in the following error:
> > > 
> > > pcilib: sysfs_read_vpd: read failed: Input/output error
> > 
> > Oh that's not nice. It's probably triggered by the -EIO in
> > pci_vpd_read.
> > A quick search online seems to show that other people have
> > experienced
> > this too - though from as far as I can tell this just gives you a
> > warning and pcilib will continnue to give other output?
> > 
> Correct.
> 
> > I guess every vpd blacklist'd driver will have the same issue. And
> > for
> > this reason I don't think that this patch is the right solution - as
> > otherwise all the other blacklisted drivers could follow your lead.
> > 
> I think that going forward, they should follow my lead, I just didn't
> want to possibly break any assumptions other vendors' tools might have
> regarding the existence/non-existence of the vpd sysfs entry.
> 
> > I don't think you need to fix this specifically for the AL driver and
> > so
> > I'd suggest that you can probably drop this patch. (Ideally pciutils
> > could be updated to not warn for this specific use-case).
> > 
> I don't think that solution should be implemented in pcituils. It
> rightfully warns when it fails to read from the vpd sysfs file - it
> first 'open's the file which succeeds, and then fails when trying to
> 'read' from it.

Indeed - this is correct.

> I don't think that it should specifically "mask" out
> -EIO, since it shouldn't have to "know" that the underlying reason is a

You're probably right - I guess the kernel should document somewhere
(ABI/testing/sysfs-bus-pci?) what the kernel does when such a quirk exists,
then userspace can conform. For example if -EIO cannot be returned any
other way then it would be OK for pciutils to mask it out - but its
ambigious at the moment.

> VPD quirk (or more precisely vpd->len == 0). Furthermore, it is
> possible that this error code would be returned for some other reason
> (not sure if currently this occurs).
> 
> I think that if the device doesn't properly support vpd, the kernel
> shouldn't expose the "empty" sysfs file in the first place.
> 
> In the long run, quirk_blacklist_vpd() should probably be modified to
> do what our quirk does or something similar (and then the al quirk can
> be removed). What do you think?

When I first saw your quirk, I did wonder why quirk_blacklist_vpd doesn't
do what your quirk does. Perhaps there isn't a reason. It was first
introduced in 2016:

7c20078a8197 ("PCI: Prevent VPD access for buggy devices")

Some may argue that actually because your hardware has a VPD capability
it should have the sysfs file - but the capability doesn't work and so
the sysfs file should return an error.

I'd be keen to change quirk_blacklist_vpd - Babu, Bjorn any objections?

Thanks,

Andrew Murray

> 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > 
> > > This quirk removes the sysfs entry, which avoids the error print.
> > > 
> > > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > > Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  drivers/pci/vpd.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > > index 4963c2e2bd4c..c23a8ec08db9 100644
> > > --- a/drivers/pci/vpd.c
> > > +++ b/drivers/pci/vpd.c
> > > @@ -644,4 +644,20 @@ static void quirk_chelsio_extend_vpd(struct
> > > pci_dev *dev)
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> > >  			quirk_chelsio_extend_vpd);
> > >  
> > > +static void quirk_al_vpd_release(struct pci_dev *dev)
> > > +{
> > > +	if (dev->vpd) {
> > > +		pci_vpd_release(dev);
> > > +		dev->vpd = NULL;
> > > +		pci_warn(dev, FW_BUG "Releasing VPD capability (No
> > > support for VPD read/write transactions)\n");
> > > +	}
> > > +}
> > > +
> > > +/*
> > > + * The 0031 device id is reused for other non Root Port device
> > > types,
> > > + * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI
> > > class.
> > > + */
> > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS,
> > > 0x0031,
> > > +			      PCI_CLASS_BRIDGE_PCI, 8,
> > > quirk_al_vpd_release);
> > > +
> > >  #endif
> > > -- 
> > > 2.17.1
> > > 
