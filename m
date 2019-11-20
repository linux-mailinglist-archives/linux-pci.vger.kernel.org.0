Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D136E1040C3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 17:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfKTQ15 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 11:27:57 -0500
Received: from foss.arm.com ([217.140.110.172]:42262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729857AbfKTQ15 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 11:27:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8079E1FB;
        Wed, 20 Nov 2019 08:27:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3148F3F703;
        Wed, 20 Nov 2019 08:27:55 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:27:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: of: Restore alignment/indentation in host bridge
 window table
Message-ID: <20191120162750.GA3279@e121166-lin.cambridge.arm.com>
References: <20191119191505.25286-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119191505.25286-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 08:15:05PM +0100, Geert Uytterhoeven wrote:
> Since the printing of the inbound resources was added, alignment and
> indentation of the host bridge window table is broken because of two
> reasons:
>   1. The "IB MEM" row header is longer than the other headers,
>   2. Inbound ranges typically extend beyond 32-bit address space, and thus
>      don't fit in "#010llx".
> 
> Fix this by extending the row header field to 6 characters, and the
> format string to 40-bit addresses.
> 
> Use "%6s" to handle field size and right-alignment, instead of manual
> preparation using error-prone snprintf() calls.  Use the exact same
> format string for both cases, to allow sharing.
> 
> Impact on kernel boot log on r8a7791/koelsch:
> 
>      rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
>     -rcar-pcie fe000000.pcie:    IO 0xfe100000..0xfe1fffff -> 0x00000000
>     -rcar-pcie fe000000.pcie:   MEM 0xfe200000..0xfe3fffff -> 0xfe200000
>     -rcar-pcie fe000000.pcie:   MEM 0x30000000..0x37ffffff -> 0x30000000
>     -rcar-pcie fe000000.pcie:   MEM 0x38000000..0x3fffffff -> 0x38000000
>     -rcar-pcie fe000000.pcie: IB MEM 0x40000000..0xbfffffff -> 0x40000000
>     -rcar-pcie fe000000.pcie: IB MEM 0x200000000..0x2ffffffff -> 0x200000000
>     +rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fffff -> 0x0000000000
>     +rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fffff -> 0x00fe200000
>     +rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffffff -> 0x0030000000
>     +rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
>     +rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x00bfffffff -> 0x0040000000
>     +rcar-pcie fe000000.pcie:   IB MEM 0x0200000000..0x02ffffffff -> 0x0200000000
> 
> Fixes: 52ac576f88f9f701 ("PCI: of: Add inbound resource parsing to helpers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/of.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Hi Rob,

do you mind if I squash this patch in the Fixes: above ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index e7e12adcff3a3836..81ceeaa6f1d5a2c5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -265,7 +265,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  	struct resource *bus_range;
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
> -	char range_type[4];
> +	const char *range_type;
>  	int err;
>  
>  	if (io_base)
> @@ -299,12 +299,12 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  	for_each_of_pci_range(&parser, &range) {
>  		/* Read next ranges element */
>  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
> -			snprintf(range_type, 4, " IO");
> +			range_type = "IO";
>  		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
> -			snprintf(range_type, 4, "MEM");
> +			range_type = "MEM";
>  		else
> -			snprintf(range_type, 4, "err");
> -		dev_info(dev, "  %s %#010llx..%#010llx -> %#010llx\n",
> +			range_type = "err";
> +		dev_info(dev, "  %6s %#012llx..%#012llx -> %#012llx\n",
>  			 range_type, range.cpu_addr,
>  			 range.cpu_addr + range.size - 1, range.pci_addr);
>  
> @@ -359,8 +359,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  		    range.cpu_addr == OF_BAD_ADDR || range.size == 0)
>  			continue;
>  
> -		dev_info(dev, "IB MEM %#010llx..%#010llx -> %#010llx\n",
> -			 range.cpu_addr,
> +		dev_info(dev, "  %6s %#012llx..%#012llx -> %#012llx\n",
> +			 "IB MEM", range.cpu_addr,
>  			 range.cpu_addr + range.size - 1, range.pci_addr);
>  
>  
> -- 
> 2.17.1
> 
