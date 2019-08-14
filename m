Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3C8D784
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 17:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHNP6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 11:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfHNP6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 11:58:20 -0400
Received: from localhost (unknown [104.133.9.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31EFE2083B;
        Wed, 14 Aug 2019 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565798300;
        bh=n4ZEBe452gAKtMljXMdXe16lsMLEEOZehc4jHOnIKAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnCPCiT2W4dJvwbcIUqXLcF2DB+Km3eoi5BJrq3fouoa4kGMa+pstuVudykKKIcjn
         XPyhhQxc3jhKbqikB5ySEkT1f1JnwnS49YieTe1PI/ICm/eGWEWHlEX4lZXzZT15rH
         Ic9/bKKjVxrqYUCwV6L145ew0Y778Ut4xUnmVJn8=
Date:   Wed, 14 Aug 2019 10:58:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Message-ID: <20190814155819.GC253360@google.com>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
 <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190713150353.GF10104@sasha-vm>
 <20190723212107.GB9742@google.com>
 <20190814101409.GB29414@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814101409.GB29414@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 11:14:09AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 23, 2019 at 04:21:07PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 13, 2019 at 11:03:53AM -0400, Sasha Levin wrote:
> 
> [...]
> 
> > > > > v3: corrected Fixes: tag [Dexuan Cui <decui@microsoft.com>]
> > > > >     This is the Microsoft-preferred version of the patch.
> > > > > 
> > > > >  drivers/pci/Kconfig |    2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > --- lnx-52.orig/drivers/pci/Kconfig
> > > > > +++ lnx-52/drivers/pci/Kconfig
> > > > > @@ -181,7 +181,7 @@ config PCI_LABEL
> > > > > 
> > > > >  config PCI_HYPERV
> > > > >          tristate "Hyper-V PCI Frontend"
> > > > > -        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
> > > > > && X86_64
> > > > > +        depends on X86_64 && HYPERV && PCI_MSI &&
> > > > > PCI_MSI_IRQ_DOMAIN && SYSFS
> > > > >          help
> > > > >            The PCI device frontend driver allows the kernel to import arbitrary
> > > > >            PCI devices from a PCI backend to support PCI driver domains.
> > > > > 
> > > > 
> > > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > 
> > > Queued up for hyperv-fixes, thank you!
> > 
> > What merge strategy do you envision for this?  Previous
> > drivers/pci/controller/pci-hyperv.c changes have generally been merged
> > by Lorenzo and incorporated into my PCI tree.
> > 
> > This particular patch doesn't actually touch pci-hyperv.c; it touches
> > drivers/pci/Kconfig, so should somehow be coordinated with me.
> 
> Bjorn please let me know if you can pick this up or I should, thanks.

Would you mind picking it up?  Then we can sort of keep all the
Hyper-V-related changes together.
