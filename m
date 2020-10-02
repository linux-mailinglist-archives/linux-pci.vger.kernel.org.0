Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E09281DAB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgJBV3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 17:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgJBV3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 17:29:39 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A212177B;
        Fri,  2 Oct 2020 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601674179;
        bh=GMDMmF8EjWATW/8Z/8UIHDE4Py42sFgz6laFGi/LIcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F5skj99wI7R/aSIf35ffYv4vKlmTfBmKhXeWwAGbwF6msmTG0Y9J6P0QSfY/VkhQr
         h9mPgiX5ODO2fn6qRkX/ylP41GMnuLRlDos0AvQr0YHNSj0OgxreB438PKX8KiH5DW
         bKhBaxyGpetk9qQnX2IuW7ZBb4ZWHkh7kEikMw1c=
Date:   Fri, 2 Oct 2020 16:29:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201002212937.GA2829999@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001220244.1271878-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 10:02:44PM +0000, Krzysztof Wilczyński wrote:
> Unify ECAM-related constants into a single set of standard constants
> defining memory address shift values for the byte-level address that can
> be used when accessing the PCI Express Configuration Space, and then
> move native PCI Express controller drivers to use newly introduced
> definitions retiring any driver-specific ones.
> 
> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> PCI Express specification (see PCI Express Base Specification, Revision
> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> implement it the same way.  Most of the native PCI Express controller
> drivers define their ECAM-related constants, many of these could be
> shared, or use open-coded values when setting the .bus_shift field of
> the struct pci_ecam_ops.
> 
> All of the newly added constants should remove ambiguity and reduce the
> number of open-coded values, and also correlate more strongly with the
> descriptions in the aforementioned specification (see Table 7-1
> "Enhanced Configuration Address Mapping", p. 677).

> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c
> @@ -15,7 +15,7 @@
>  #include <linux/platform_device.h>
>  
>  static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
> -	.bus_shift	= 16,
> +	.bus_shift	= PCIE_CAM_BUS_SHIFT,

I'm not sure this code was safe even before you touched it.
pci_ecam_map_bus() doesn't limit "where" at all, so if we try to
access extended config space (offset 0x100 - 0xfff), I think we'll
generate

  (busnr << 16) | (devfn << 8) + where

If "where >= 0x100", we'll target the wrong device.

Even for ECAM, it doesn't look like anything prevents a defective or
malicious caller from supplying a config offset of, say, 0x2000 and
targeting the wrong device.

>  	.pci_ops	= {
>  		.map_bus	= pci_ecam_map_bus,
>  		.read		= pci_generic_config_read,

> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -60,6 +60,15 @@
>  #define XGENE_PCIE_IP_VER_1		1
>  #define XGENE_PCIE_IP_VER_2		2
>  
> +/*
> + * Enhanced Configuration Access Mechanism (ECAM)
> + *
> + * N.B. This is a non-standard platform-specific ECAM bus shift value.  For
> + * standard values defined in the PCI Express Base Specification see
> + * include/linux/pci-ecam.h.
> + */
> +#define XGENE_PCIE_ECAM_BUS_SHIFT	16

Is this even used anywhere?  xgene_pcie_map_bus() doesn't use
bus_shift.  Maybe we can just drop the .bus_shift initializers?

>  #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>  struct xgene_pcie_port {
>  	struct device_node	*node;
> @@ -257,7 +266,7 @@ static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
>  }
>  
>  const struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
> -	.bus_shift	= 16,
> +	.bus_shift	= XGENE_PCIE_ECAM_BUS_SHIFT,
>  	.init		= xgene_v1_pcie_ecam_init,
>  	.pci_ops	= {
>  		.map_bus	= xgene_pcie_map_bus,
> @@ -272,7 +281,7 @@ static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
>  }
>  
>  const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
> -	.bus_shift	= 16,
> +	.bus_shift	= XGENE_PCIE_ECAM_BUS_SHIFT,
>  	.init		= xgene_v2_pcie_ecam_init,
>  	.pci_ops	= {
>  		.map_bus	= xgene_pcie_map_bus,
