Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712154629D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfFNPXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 11:23:43 -0400
Received: from foss.arm.com ([217.140.110.172]:36598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfFNPXn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 11:23:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E62344;
        Fri, 14 Jun 2019 08:23:42 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3D43F718;
        Fri, 14 Jun 2019 08:23:41 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:23:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     bhelgaas@google.com, sthemmin@microsoft.com, sashal@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix build error without CONFIG_SYSFS
Message-ID: <20190614152336.GA26846@e121166-lin.cambridge.arm.com>
References: <20190531150923.12376-1-yuehaibing@huawei.com>
 <6c97b2ae-b151-5610-d8d5-ef626d1f9bbb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c97b2ae-b151-5610-d8d5-ef626d1f9bbb@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 10:19:10PM +0800, Yuehaibing wrote:
> Hi all,
> 
> Friendly ping...

We should address Michael's question:

https://lore.kernel.org/linux-pci/BYAPR21MB12211EEA95200F437C8E37ECD71A0@BYAPR21MB1221.namprd21.prod.outlook.com/

Lorenzo

> On 2019/5/31 23:09, YueHaibing wrote:
> > while building without CONFIG_SYSFS, fails as below:
> > 
> > drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_assign_slots':
> > pci-hyperv.c:(.text+0x40a): undefined reference to 'pci_create_slot'
> > drivers/pci/controller/pci-hyperv.o: In function 'pci_devices_present_work':
> > pci-hyperv.c:(.text+0xc02): undefined reference to 'pci_destroy_slot'
> > drivers/pci/controller/pci-hyperv.o: In function 'hv_pci_remove':
> > pci-hyperv.c:(.text+0xe50): undefined reference to 'pci_destroy_slot'
> > drivers/pci/controller/pci-hyperv.o: In function 'hv_eject_device_work':
> > pci-hyperv.c:(.text+0x11f9): undefined reference to 'pci_destroy_slot'
> > 
> > Select SYSFS while PCI_HYPERV is set to fix this.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/pci/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 2ab9240..6722952 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -182,6 +182,7 @@ config PCI_LABEL
> >  config PCI_HYPERV
> >          tristate "Hyper-V PCI Frontend"
> >          depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> > +	select SYSFS
> >          help
> >            The PCI device frontend driver allows the kernel to import arbitrary
> >            PCI devices from a PCI backend to support PCI driver domains.
> > 
> 
