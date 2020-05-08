Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F151CB5AC
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 19:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHRRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 13:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEHRRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 13:17:33 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253BE21775;
        Fri,  8 May 2020 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958252;
        bh=AmScCZpZxiRrJNvHWkz9TKJv6t/f/ZRNkLLPkkZ3I8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UJRtPzmVwMWVnflrX3KDmQSe9RghPB6FFqzryHss0CmhasZffpCJ6w7TrGX91nj0t
         h1Px988c9VKfcx2bSGVHdGHjXSco6eahi9hxaDwfTOjjfnksyMZYJfddu7O5c0vD9p
         nI3RS0gDNSuAXsGv8bG79vY/AsMZ2P8uFEfJeuJA=
Date:   Fri, 8 May 2020 12:17:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     maz@kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v8 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200508171730.GA77036@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508113414.3091532-2-jiaxun.yang@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 07:34:02PM +0800, Jiaxun Yang wrote:
> This controller can be found on Loongson-2K SoC, Loongson-3
> systems with RS780E/LS7A PCH.
> 
> The RS780E part of code was previously located at
> arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> driver implementation.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

> +static void system_bus_quirk(struct pci_dev *pdev)
> +{
> +	u16 tmp;
> +
> +	/* 
> +	 * System buses on Loongson system contain garbage in BARs
> +	 * but their decoding need to be enabled to ensure devices
> +	 * under system buses are reachable. In most cases it should
> +	 * be done by the firmware.

This isn't a very satisfying explanation because devices that have
decoding enabled can interfere with other devices in the system, and I
can't tell whether that's a problem here.

What happens when you turn on MEM/IO decoding below?  Does the device
decode any address space?  How do we know what it is?  Is it related
to the BAR contents?

I'm a little dubious about the need for the PCI_COMMAND write because
the previous version didn't do it (since it incorrectly wrote to
PCI_STATUS), and I assume that version worked.

> +	pdev->mmio_always_on = 1;
> +	pdev->non_compliant_bars = 1;
> +	/* Enable MEM & IO Decoding */
> +	pci_read_config_word(pdev, PCI_COMMAND, &tmp);
> +	tmp |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
> +	pci_write_config_word(pdev, PCI_COMMAND, tmp);


> +}
> +

Omit this blank line.

> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS2K_APB, system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_CONF, system_bus_quirk);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_LPC, system_bus_quirk);
> +
> +static void loongson_mrrs_quirk(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> +		{ 0, },
> +	};
> +
> +

Remove one of these blank lines.

> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +		/*
> +		 * Some Loongson PCIe ports have a h/w limitation of
> +		 * 256 bytes maximum read request size. They can't handle
> +		 * anything larger than this. So force this limit on
> +		 * any devices attached under these ports.
> +		 */
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(dev) > 256) {
> +				pci_info(dev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(dev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);

> +void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where)
> +{
> +	unsigned char busnum = bus->number;
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +
> +	/*
> +	 * Do not read more than one device on the bus other than
> +	 * the host bridge.

s/host bridge/root bus/ ?

IIUC, the test below assumes the root bus is bus 0, which is not
necessarily the case.  Many other .*_map_bus() implementations have
similar tests for devices on the root bus:

  al_pcie_map_bus(...)
  {
    if (bus->number == cfg->busr.start) {

> +	if (priv->flags & FLAG_DEV_FIX && bus->primary != 0 &&
> +		PCI_SLOT(devfn) > 0)
> +		return NULL;
