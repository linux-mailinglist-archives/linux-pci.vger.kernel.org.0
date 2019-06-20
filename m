Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB04DD91
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 00:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFTW4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 18:56:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:36329 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTW4D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 18:56:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5KMthDS002646;
        Thu, 20 Jun 2019 17:55:44 -0500
Message-ID: <a2ab2f2e6588fa12642dc16fbe908de55ba7b684.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/4] arm64: pci: acpi: Use
 pci_assign_unassigned_root_bus_resources()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 21 Jun 2019 08:55:43 +1000
In-Reply-To: <20190620171357.GD18771@e121166-lin.cambridge.arm.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
         <20190620171357.GD18771@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-20 at 18:13 +0100, Lorenzo Pieralisi wrote:
> On Sat, Jun 15, 2019 at 10:23:56AM +1000, Benjamin Herrenschmidt wrote:
> > Instead of the simpler
> > 
> > 	pci_bus_size_bridges(bus);
> > 	pci_bus_assign_resources(bus);
> > 
> > Use pci_assign_unassigned_root_bus_resources(). This should have no effect
> > as long as we are reassigning everything. Once we start honoring FW
> > resource allocations, this will bring up the "reallocation" feature
> > which can help making room for SR-IOV when necessary.
> 
> I would like to add more details on why we want to make this change,
> I will update the log when we merge it, it is a bit too late for v5.3,
> even if in theory no functional change is intended.

Ok. The why is that a subsequent patch will turn the code into

	if (claim)
		claim()
	pci_assign_unassigned*

And I wanted the patch replacing the existing 2 calls with the above
separate and bisectable in case we missed some odd effect of the
change.

Cheers,
Ben.

> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  arch/arm64/kernel/pci.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index bb85e2f4603f..1419b1b4e9b9 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -193,8 +193,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >  	if (!bus)
> >  		return NULL;
> >  
> > -	pci_bus_size_bridges(bus);
> > -	pci_bus_assign_resources(bus);
> > +	pci_assign_unassigned_root_bus_resources(bus);
> 
> These hunks should be identical, minus the additional resource size
> handling and realloc policy (which are *missing* features in current
> code). We must document this change in the log.
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> >  	list_for_each_entry(child, &bus->children, node)
> >  		pcie_bus_configure_settings(child);
> > -- 
> > 2.17.1
> > 

