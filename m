Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF944F0E7
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 00:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfFUW6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 18:58:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:38953 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfFUW6y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 18:58:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5LMwGXK028050;
        Fri, 21 Jun 2019 17:58:35 -0500
Message-ID: <4d758a3bfff0fbcec94f51cf1872b649108170db.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/4] arm64: pci: acpi: Use
 pci_assign_unassigned_root_bus_resources()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 22 Jun 2019 08:58:16 +1000
In-Reply-To: <20190621204839.GF127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
         <20190621204839.GF127746@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-21 at 15:48 -0500, Bjorn Helgaas wrote:
> On Sat, Jun 15, 2019 at 10:23:56AM +1000, Benjamin Herrenschmidt
> wrote:
> > Instead of the simpler
> > 
> > 	pci_bus_size_bridges(bus);
> > 	pci_bus_assign_resources(bus);
> > 
> > Use pci_assign_unassigned_root_bus_resources(). This should have no
> > effect
> > as long as we are reassigning everything. Once we start honoring FW
> > resource allocations, this will bring up the "reallocation" feature
> > which can help making room for SR-IOV when necessary.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> I applied these to pci/resource, with my comments and acks from
> Lorenzo and Ard.  Let me know if I was too aggressive or got
> something
> wrong; I consider these branches malleable until the merge window.
> 
> Thanks for the first step on this long journey :)

Heh thanks :-)

Cheers,
Ben.

> > ---
> >  arch/arm64/kernel/pci.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index bb85e2f4603f..1419b1b4e9b9 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -193,8 +193,7 @@ struct pci_bus *pci_acpi_scan_root(struct
> > acpi_pci_root *root)
> >  	if (!bus)
> >  		return NULL;
> >  
> > -	pci_bus_size_bridges(bus);
> > -	pci_bus_assign_resources(bus);
> > +	pci_assign_unassigned_root_bus_resources(bus);
> >  
> >  	list_for_each_entry(child, &bus->children, node)
> >  		pcie_bus_configure_settings(child);
> > -- 
> > 2.17.1
> > 

