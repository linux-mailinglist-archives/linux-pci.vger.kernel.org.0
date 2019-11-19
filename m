Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62DB102CFA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSTsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 14:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKSTsE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 14:48:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C3D22448;
        Tue, 19 Nov 2019 19:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574192883;
        bh=cAv2x1VIfRqAvu828nQrCjKw3vsBDLRbeyu1OEbN3/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tRWp+Dg41oZAbbhNQeDTc4CtcR54uyH4NDkh5a3EEJxjUgHGaPZQssOYenugljM/b
         ZcGiapX3Z+gjZCXJCpjL8UPtlsVRSzZtApPIEhjrKAT78saH/xUdHgtm/hFNsy+Y4c
         7v8cytYcxwa+AQzsGaL0aN52CVbuSzv/ynd5eiAI=
Date:   Tue, 19 Nov 2019 13:48:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: of: Restore alignment/indentation in host bridge
 window table
Message-ID: <20191119194800.GA204901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119191505.25286-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

This is fine with me, and since it applies on top of 52ac576f88f9f701
(longer than the usual 12-char SHA1, BTW), which is on Lorenzo's
pci/mmio-dma-ranges branch, I assume Lorenzo will be the one to take
care of this.

pci_register_host_bridge() prints some of this info like this:

  pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
  pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0xdc800000-0xfebfffff window]

Is there any opportunity for consolidating these or at least making
the format the same?

I assume we're currently printing most of that info twice, once
in devm_of_pci_get_host_bridge_resources() and again in
pci_register_host_bridge()?

> ---
>  drivers/pci/of.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
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
