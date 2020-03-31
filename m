Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5937199FD1
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCaUM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 16:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgCaUM3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 16:12:29 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F43206EB;
        Tue, 31 Mar 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585685548;
        bh=7/omDWAID+5hcfz/WYWgmxUkv9xqXa5HemPJhM6NYEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wP/hrfALbj0aKSLxvoh+umRqrfvSP7x6pVgVmI50E6tJyUMAeUU37qGcgya1LB6Ru
         T368mYhIQrlsqN5WtwBmigCm9rtmgcpfr3ohnRobzzQVy9tIlgBWJjVOeTicX3gAqE
         YtDfNtCgydegOJdLZ9KMGaZPu0ZSFXdMqtbCh7BM=
Date:   Tue, 31 Mar 2020 15:12:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        kishon@ti.com, paul.walmsley@sifive.com
Subject: Re: [PATCH] PCI: Warn about MEM resource size being too big
Message-ID: <20200331201225.GA19649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585613987-8453-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

$ git log --oneline drivers/pci/controller/dwc/pcie-designware-host.c
7fe71aa84b43 ("PCI: dwc: Use pci_parse_request_of_pci_ranges()")
1137e61dcb99 ("PCI: dwc: Fix find_next_bit() usage")
0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
3924bc2fd1b6 ("PCI: dwc: Group DBI registers writes requiring unlocking")
ca98329d3b58 ("PCI: dwc: Export APIs to support .remove() implementation")
9d071cade30a ("PCI: dwc: Add API support to de-initialize host")
fe23274f72f4 ("PCI: dwc: Save root bus for driver remove hooks")

Please make yours match.  Please mention something about the 32-bit
limit instead of just "being too big".

Wrap the commit log to 75 columns to be consistent with the rest of
the history.

On Mon, Mar 30, 2020 at 05:19:47PM -0700, Alan Mikhak wrote:
> Output a warning for MEM resource size with
> non-zero upper 32-bits.
> 
> ATU programming functions limit the size of
> the translated region to 4GB by using a u32 size
> parameter. Function dw_pcie_prog_outbound_atu()
> does not program the upper 32-bit ATU limit
> register. This may result in undefined behavior
> for resource sizes with non-zero upper 32-bits.
> 
> For example, a 128GB address space starting at
> physical CPU address of 0x2000000000 with size of
> 0x2000000000 needs the following values programmed
> into the lower and upper 32-bit limit registers:
>  0x3fffffff in the upper 32-bit limit register
>  0xffffffff in the lower 32-bit limit register
> 
> Currently, only the lower 32-bit limit register is
> programmed with a value of 0xffffffff but the upper
> 32-bit limit register is not being programmed.
> As a result, the upper 32-bit limit register remains
> at its default value after reset of 0x0. This would
> be a problem for a 128GB PCIe space because in
> effect its size gets reduced to 4GB.
> 
> ATU programming functions can be changed to
> specify a u64 size parameter for the translated
> region. Along with this change, the internal
> calculation of the limit address, the address of
> the last byte in the translated region, needs to
> change such that both the lower 32-bit and upper
> 32-bit limit registers can be programmed correctly.
> 
> Changing the ATU programming functions is high
> impact. Without change, this issue can go
> unnoticed. A warning may prompt the user to
> look into possible issues.

So this is basically a warning, and we could actually *fix* the
problem with more effort?  I vote for the fix.

> This limitation also means that multiple ATUs
> would need to be used to map larger regions.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 395feb8ca051..37a8c71ef89a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -325,6 +325,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	struct resource *cfg_res;
> +	resource_size_t mem_size;
>  	u32 hdr_type;
>  	int ret;
>  
> @@ -362,7 +363,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		case IORESOURCE_MEM:
>  			pp->mem = win->res;
>  			pp->mem->name = "MEM";
> -			pp->mem_size = resource_size(pp->mem);
> +			mem_size = resource_size(pp->mem);
> +			if (upper_32_bits(mem_size))
> +				dev_warn(dev, "MEM resource size too big\n");
> +			pp->mem_size = mem_size;
>  			pp->mem_bus_addr = pp->mem->start - win->offset;
>  			break;
>  		case 0:
> -- 
> 2.7.4
> 
