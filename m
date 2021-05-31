Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC01395B21
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 15:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEaNQP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 09:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhEaNQP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 09:16:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1367A60FE8;
        Mon, 31 May 2021 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622466875;
        bh=ijtUyUMIwjDtjTIX9JOuxobyfw9oYEhVyr+3OgdRpdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUVJSxJeeNkOZ4lVAaSuUoCzwFPtldSxUUM2kwe2O1/IPfbQioE3WzDuQgN24EuR2
         Am/KlWHZh6C0RK1SLOD6X56fT1xXDI7JfK4m5UK/loHshN7vDTReUr/65qGKhCcg/o
         ss9Jbifvj3oC7w7vjPZsIZGA+HjlpY/hqF8E6sKWDExvRT3tfpNb6HMP3oUFQwiMwv
         OTCI0ltai+uesmVSLl1mEIBbiQYTbqJIwcP9Y790u+wYlX547hbeik1xovL8vYi+Jd
         8Kw8tkwoiC5KvukH0kWfyu8TiIKnklvi209rVEBdmha+y1BMn2z7kUbNstGrrZ8gOo
         6tpx1D27Rrd3g==
Received: by pali.im (Postfix)
        id CC1D3B84; Mon, 31 May 2021 15:14:31 +0200 (CEST)
Date:   Mon, 31 May 2021 15:14:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        john@phrozen.org, bhelgaas@google.com, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] MIPS: pci: Add driver for MT7621 PCIe controller
Message-ID: <20210531131431.bzsvmefqdyawmeo2@pali>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515124055.22225-3-sergio.paracuellos@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 15 May 2021 14:40:53 Sergio Paracuellos wrote:
> This patch adds a driver for the PCIe controller of MT7621 SoC.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/pci/Makefile     |   1 +
>  arch/mips/pci/pci-mt7621.c | 624 +++++++++++++++++++++++++++++++++++++
>  arch/mips/ralink/Kconfig   |   9 +-
>  3 files changed, 633 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/pci/pci-mt7621.c
> 
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index f3eecc065e5c..178c550739c4 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_PCI_AR2315)	+= pci-ar2315.o
>  obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
>  obj-$(CONFIG_PCI_AR724X)	+= pci-ar724x.o
>  obj-$(CONFIG_PCI_XTALK_BRIDGE)	+= pci-xtalk-bridge.o
> +obj-$(CONFIG_PCI_MT7621)	+= pci-mt7621.o
>  #
>  # These are still pretty much in the old state, watch, go blind.
>  #
> diff --git a/arch/mips/pci/pci-mt7621.c b/arch/mips/pci/pci-mt7621.c
> new file mode 100644
> index 000000000000..fe1945819d25
> --- /dev/null
> +++ b/arch/mips/pci/pci-mt7621.c
...
> +static int mt7621_pcie_enable_ports(struct mt7621_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct mt7621_pcie_port *port;
> +	u8 num_slots_enabled = 0;
> +	u32 slot;
> +	u32 val;
> +	int err;
> +
> +	/* Setup MEMWIN and IOWIN */
> +	pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
> +	pcie_write(pcie, pcie->io.start, RALINK_PCI_IOBASE);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		if (port->enabled) {
> +			err = clk_prepare_enable(port->clk);
> +			if (err) {
> +				dev_err(dev, "enabling clk pcie%d\n", slot);
> +				return err;
> +			}
> +
> +			mt7621_pcie_enable_port(port);
> +			dev_info(dev, "PCIE%d enabled\n", port->slot);
> +			num_slots_enabled++;
> +		}
> +	}
> +
> +	for (slot = 0; slot < num_slots_enabled; slot++) {
> +		val = read_config(pcie, slot, PCI_COMMAND);
> +		val |= PCI_COMMAND_MASTER;
> +		write_config(pcie, slot, PCI_COMMAND, val);

Hello! Is this part of code correct? Because it looks strange if PCIe
controller driver automatically enables PCI bus mastering, prior device
driver initialize itself.

Moreover kernel has already function pci_set_master() for this purpose
which is used by device drivers.

So I think this code can confuse some device drivers...

> +		/* configure RC FTS number to 250 when it leaves L0s */
> +		val = read_config(pcie, slot, PCIE_FTS_NUM);
> +		val &= ~PCIE_FTS_NUM_MASK;
> +		val |= PCIE_FTS_NUM_L0(0x50);
> +		write_config(pcie, slot, PCIE_FTS_NUM, val);
> +	}
> +
> +	return 0;
> +}
