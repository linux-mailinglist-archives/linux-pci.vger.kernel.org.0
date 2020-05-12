Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED971CFCCD
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgELSGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 14:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgELSGE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 May 2020 14:06:04 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4FD720720;
        Tue, 12 May 2020 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306764;
        bh=u6F9DLRbr9iVJIIz0f3H5qz89UqdlJ6qKaSYphCX6ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2bwY1ea4D1zVQuZSsqjre852YXMAh6qn1U4AxMFwEpVakTIAx3F7MvxvEccTa7HqG
         0ipEmFqpAqPt7kskzY3xT2LdKxbAyYWAoffOBznznFDRWntjKrn5FCidcUJekMvi62
         ZyD3pQqwt6R9ROxTSRhmRqnp1uB+r7/ppVV7NQa0=
Date:   Tue, 12 May 2020 13:06:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v9 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200512180602.GA273658@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512074413.3557835-2-jiaxun.yang@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 12, 2020 at 03:43:56PM +0800, Jiaxun Yang wrote:
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
> +	 * These devices are not sharing resouces with rest of devices
> +	 * on host bus and firmware will ensure their BARs are placed
> +	 * in safe ranges. Also there might be some config registers
> +	 * in their config space so kernel shouldn't ignore them.

"Firmware ensuring BARs are placed in 'safe' ranges" is not a
sufficient answer.  As I said before, Linux needs to know both the
ADDRESS and the SIZE of whatever non-standard BARs these are.
Otherwise, we're liable to assign that space to a different device.

If you have to hard-code the size, so be it.  That would mean the
hardware is completely broken, but at least we could make Linux deal
with it.  If the hardware consumes address space we don't know about,
we can't deal with that.

> +	 */
> +	pdev->mmio_always_on = 1;
> +	pdev->non_compliant_bars = 1;
> +}

> +void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where)
> +{
> +	unsigned char busnum = bus->number;
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct loongson_pci *priv =  pci_host_bridge_priv(bridge);
> +
> +	/*
> +	 * Do not read more than one device on the bus other than
> +	 * the host bus 0.
> +	 */

If the hardware is restricted such that the root bus number must be
zero, pleae say that explicitly here.  Otherwise, it just looks like
a bug.

> +	if (priv->flags & FLAG_DEV_FIX && busnum != 0 &&
> +		PCI_SLOT(devfn) > 0)
> +		return NULL;
> +
> +	/* CFG0 can only access standard space */
> +	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
> +		return cfg0_map(priv, busnum, devfn, where);
> +
> +	/* CFG1 can access extended space */
> +	if (where < PCI_CFG_SPACE_EXP_SIZE && priv->cfg1_base)
> +		return cfg1_map(priv, busnum, devfn, where);
> +
> +	return NULL;
> +}
