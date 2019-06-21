Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EFF4EFCC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 22:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUUGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 16:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUUGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 16:06:44 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F36620673;
        Fri, 21 Jun 2019 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561147603;
        bh=4Q+RFCpdW2sWFHYDR6CaEb8dLMWyiQ24AKk3JVhgTc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niInD/1ACc2tCSDVeaqiAMarUOMqAUFTDnSdC2VuCBdoSt83DJwWtg+RwP1CoAbXB
         MYdKJKyDuvdUesMUQHgKBLBYEPrcdwVh7mq5CHbRPGdNW7WIrRevMyidGrqqg2Gp4o
         aX7baCouS+jszHQECG1ZwtOuubQkBo59I4wI+7Ug=
Date:   Fri, 21 Jun 2019 15:06:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] arm64: pci: acpi: Use
 pci_assign_unassigned_root_bus_resources()
Message-ID: <20190621200641.GB127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615002359.29577-1-benh@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Match the subject line convention, e.g.,

  arm64: PCI: Use pci_assign_unassigned_root_bus_resources()

But the function name doesn't really tell us anything unless we already
know how everything works.  I think the point is that
pci_assign_unassigned_root_bus_resources() gives us the possibility of
reallocating things if necessary.  A subject that hints at that would be
good.

On Sat, Jun 15, 2019 at 10:23:56AM +1000, Benjamin Herrenschmidt wrote:
> Instead of the simpler
> 
> 	pci_bus_size_bridges(bus);
> 	pci_bus_assign_resources(bus);
> 
> Use pci_assign_unassigned_root_bus_resources(). This should have no
> effect as long as we are reassigning everything. 

  pci_bus_size_bridges(bus) == __pci_bus_size_bridges(bus, NULL)
  pci_bus_assign_resources(bus) == __pci_bus_assign_resources(bus, NULL, NULL)

and we have:

  pci_assign_unassigned_root_bus_resources()
  {
    ...
    __pci_bus_size_bridges(bus, add_list);
    __pci_bus_assign_resources(bus, add_list, &fail_head);

so I guess this should have no effect as long as we were able to
assign everything.  If we were unable to assign something, previously
we did nothing and left it unassigned, but after this patch, we will
attempt to do some reallocation.  Right?

> Once we start honoring FW resource allocations, this will bring up
> the "reallocation" feature which can help making room for SR-IOV
> when necessary.

I think this should be reordered so it's immediately before the patch
that checks hb->preserve_config, i.e., the patch that honors FW
assignments.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm64/kernel/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index bb85e2f4603f..1419b1b4e9b9 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -193,8 +193,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> -	pci_bus_size_bridges(bus);
> -	pci_bus_assign_resources(bus);
> +	pci_assign_unassigned_root_bus_resources(bus);
>  
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
> -- 
> 2.17.1
> 
