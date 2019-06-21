Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2104B4F01F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUUsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 16:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUUsm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 16:48:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05922070B;
        Fri, 21 Jun 2019 20:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561150121;
        bh=UARkIfuRiTv1x4Vk35qpvirV8jE6wnx9e7VMEObMkz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHwjHIU6xRF5auZ52FutTR1fB/ccIOlGU8fKnV63z+BOvcVim5oDP9rvl+8sCovYQ
         uBRhBA4p+W0AQ9c9yxrunjyqSB8Qp6wHxdM6Ty1+z16/drVnlXsraza6rK3yfoPd5z
         7+5FoQybKAQwgk3llwZqUYVnt21zucF3ih44WLV0=
Date:   Fri, 21 Jun 2019 15:48:39 -0500
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
Message-ID: <20190621204839.GF127746@google.com>
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

On Sat, Jun 15, 2019 at 10:23:56AM +1000, Benjamin Herrenschmidt wrote:
> Instead of the simpler
> 
> 	pci_bus_size_bridges(bus);
> 	pci_bus_assign_resources(bus);
> 
> Use pci_assign_unassigned_root_bus_resources(). This should have no effect
> as long as we are reassigning everything. Once we start honoring FW
> resource allocations, this will bring up the "reallocation" feature
> which can help making room for SR-IOV when necessary.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I applied these to pci/resource, with my comments and acks from
Lorenzo and Ard.  Let me know if I was too aggressive or got something
wrong; I consider these branches malleable until the merge window.

Thanks for the first step on this long journey :)

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
