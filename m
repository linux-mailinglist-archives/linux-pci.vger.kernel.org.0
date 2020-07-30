Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CFE233659
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgG3QKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 12:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3QKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 12:10:01 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75EB220829;
        Thu, 30 Jul 2020 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596125400;
        bh=FAeJmqJWUwun8tkRthozqocoLOawjcpNH+44TDl/UnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BOSve1uri58VZSQ/Ky+ZrJuqsF12h7bv4c4Xw/nLmhKh0tCdoxJlfFHN068iAt9Lf
         DOS14cK8OlWc/day8ilhyEHUYv9MclMdvwap3XKhHz/cEdLceQ4+/R/oDXjeXIBxHc
         5josqv9rJ4GVKZqOxdkGt4bZMaCFe775I+xKP9TQ=
Date:   Thu, 30 Jul 2020 11:09:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] PCI: iproc: Stop using generic config read/write
 functions
Message-ID: <20200730160958.GA2038661@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730033747.18931-2-mark.tomlinson@alliedtelesis.co.nz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, Rob]

On Thu, Jul 30, 2020 at 03:37:46PM +1200, Mark Tomlinson wrote:
> The pci_generic_config_write32() function will give warning messages
> whenever writing less than 4 bytes at a time. As there is nothing we can
> do about this without changing the hardware, the message is just a
> nuisance. So instead of using the generic functions, use the functions
> that have already been written for reading/writing the config registers.

The reason that pci_generic_config_write32() message is there is
because, as the message says, a read/modify/write may corrupt bits in
adjacent registers.  

It makes me a little queasy to do these read/modify/write sequences
silently.  A generic driver doing an 8- or 16-bit config write has no
idea that the write may corrupt an adjacent register.  That leads to
bugs that are very difficult to debug and only reproducible on iProc.

The ratelimiting on the current pci_generic_config_write32() message
is based on the call site, not on the device.  That's not ideal: we
may emit several messages for device A, trigger ratelimiting, then do
a write for device B that doesn't generate a message.

I think it would be better to have a warning once per device, so if
XYZ device has a problem and we look at the dmesg log, we would find a
single message for device XYZ as a hint.  Would that reduce the
nuisance level enough?

So I think I did it wrong in fb2659230120 ("PCI: Warn on possible RW1C
corruption for sub-32 bit config writes").  Ratelimiting is the wrong
concept because what we want is a single warning per device, not a
limit on the similar messages for *all* devices, maybe something like
this:

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..e5f956b7e3b7 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 	 * write happen to have any RW1C (write-one-to-clear) bits set, we
 	 * just inadvertently cleared something we shouldn't have.
 	 */
-	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
+	if (!(bus->unsafe_warn & (1 << devfn))) {
+		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
 			     size, pci_domain_nr(bus), bus->number,
 			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
+		bus->unsafe_warn |= 1 << devfn;
+	}
 
 	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 	tmp = readl(addr) & mask;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e52..264b009fa4a6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -613,6 +613,7 @@ struct pci_bus {
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
+	u8		unsafe_warn;	/* warned about R/M/W config write */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
 #endif

> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/pci/controller/pcie-iproc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 2c836eede42c..68ecd3050529 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -709,12 +709,13 @@ static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  {
>  	int ret;
>  	struct iproc_pcie *pcie = iproc_data(bus);
> +	int busno = bus->number;
>  
>  	iproc_pcie_apb_err_disable(bus, true);
>  	if (pcie->iproc_cfg_read)
>  		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
>  	else
> -		ret = pci_generic_config_read32(bus, devfn, where, size, val);
> +		ret = iproc_pci_raw_config_read32(pcie, busno, devfn, where, size, val);
>  	iproc_pcie_apb_err_disable(bus, false);
>  
>  	return ret;
> @@ -724,9 +725,11 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
>  				     int where, int size, u32 val)
>  {
>  	int ret;
> +	struct iproc_pcie *pcie = iproc_data(bus);
> +	int busno = bus->number;
>  
>  	iproc_pcie_apb_err_disable(bus, true);
> -	ret = pci_generic_config_write32(bus, devfn, where, size, val);
> +	ret = iproc_pci_raw_config_write32(pcie, busno, devfn, where, size, val);
>  	iproc_pcie_apb_err_disable(bus, false);
>  
>  	return ret;
> -- 
> 2.28.0
> 
