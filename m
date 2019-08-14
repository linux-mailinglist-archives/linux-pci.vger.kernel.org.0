Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF38D06D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfHNKOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 06:14:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfHNKON (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 06:14:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C9D328;
        Wed, 14 Aug 2019 03:14:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3C0E3F706;
        Wed, 14 Aug 2019 03:14:11 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:14:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Message-ID: <20190814101409.GB29414@e121166-lin.cambridge.arm.com>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
 <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190713150353.GF10104@sasha-vm>
 <20190723212107.GB9742@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723212107.GB9742@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 04:21:07PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 13, 2019 at 11:03:53AM -0400, Sasha Levin wrote:

[...]

> > > > v3: corrected Fixes: tag [Dexuan Cui <decui@microsoft.com>]
> > > >     This is the Microsoft-preferred version of the patch.
> > > > 
> > > >  drivers/pci/Kconfig |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > --- lnx-52.orig/drivers/pci/Kconfig
> > > > +++ lnx-52/drivers/pci/Kconfig
> > > > @@ -181,7 +181,7 @@ config PCI_LABEL
> > > > 
> > > >  config PCI_HYPERV
> > > >          tristate "Hyper-V PCI Frontend"
> > > > -        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
> > > > && X86_64
> > > > +        depends on X86_64 && HYPERV && PCI_MSI &&
> > > > PCI_MSI_IRQ_DOMAIN && SYSFS
> > > >          help
> > > >            The PCI device frontend driver allows the kernel to import arbitrary
> > > >            PCI devices from a PCI backend to support PCI driver domains.
> > > > 
> > > 
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > 
> > Queued up for hyperv-fixes, thank you!
> 
> What merge strategy do you envision for this?  Previous
> drivers/pci/controller/pci-hyperv.c changes have generally been merged
> by Lorenzo and incorporated into my PCI tree.
> 
> This particular patch doesn't actually touch pci-hyperv.c; it touches
> drivers/pci/Kconfig, so should somehow be coordinated with me.

Bjorn please let me know if you can pick this up or I should, thanks.

Lorenzo

> Does this need to be tagged for stable?  a15f2c08c708 appeared in
> v4.19, so my first guess is that it's not stable material.
> 
> Bjorn
