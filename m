Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9466330A4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 00:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKUXSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 18:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKUXSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 18:18:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A02C67F7;
        Mon, 21 Nov 2022 15:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7156614FD;
        Mon, 21 Nov 2022 23:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02B5C433D6;
        Mon, 21 Nov 2022 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669072729;
        bh=4habRl7EWY7Q2b/7QkEy7kBg7npss/byERgceP+MyTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mkq5WKle3ER8xnEodSsXb1DUDoRujLzzH9a2OxVc4x4V37xNqqtK7BHJEPPvce76e
         aaawRGgi3jW8PYFzTMRKU3yl1UC9iMfPWiSI7Xm/G6pj11RSVtf4WY5K/DlsmX0gFP
         mIzqxDiro+Q7WuTVW4fROCNDnEOwOSCH4XMoOdeYHy6ijp+/zONbUi81GFmDTYXMIx
         jECDROG8WMyoC+giltpQiR7HwhgA4sGW6/MJh9JHEiDHczdDKx/PJSA1qUBlidOXaZ
         QA1Gjs4BNTzhLGDH/XHijxXjIWd08garnjmVK1yXEGZxIwTkxzBDn/uqJkITRK2gBC
         Uoe3+qeU7HmnQ==
Date:   Mon, 21 Nov 2022 17:18:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 3/6] PCI: dwc: fsd: Add FSD PCIe Controller driver support
Message-ID: <20221121231847.GA141229@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121105210.68596-4-shradha.t@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 04:22:07PM +0530, Shradha Todi wrote:
> Add PCIe controller driver file for PCIe controller
> found in fsd SoC family. This driver adds support for both RC
> and EP mode.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Would be much, much better if drivers can be combined as Krzysztof
suggests.  Superficial comments below if not.

> +config PCIE_FSD
> +	bool "Samsung FSD PCIe Controller"
> +	default n

Unnecessary since "default n" is the default.  Please read and learn
from the existing Kconfig for other drivers.

> +config PCIE_FSD_HOST
> +	bool "PCIe FSD Host Mode"
> +	depends on PCI

Shouldn't be necessary because the entire menu depends on PCI:

  menu "DesignWare PCI Core Support"
	  depends on PCI

> +	depends on PCI_MSI_IRQ_DOMAIN || PCI_DOMAIN
> +	select PCIE_DW_HOST
> +	select PCIE_FSD
> +	default n

Unnecessary.

> +config PCIE_FSD_EP
> +	bool "PCIe FSD Endpoint Mode"
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_FSD
> +	default n

Unnecessary.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Tesla fsd SoC
> + *
> + * Copyright (C) 2017-2022 Samsung Electronics Co., Ltd. http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Unnecessary copyright text since you have SPDX at the top.

> + * struct fsd_pcie - representation of the pci controller

s/pci/PCI/ in English text (you do it inconsistently)
s/pcie/PCIe/ same

> + * @pci: representation of dwc pcie device structure
> + * @pdata: private data to determine the oprations supported by device

s/oprations/operations/

> + * @appl_base: represent the appl base
> + * @sysreg: represent the system register base
> + * @sysreg_base: represents the offset of the system register required

"representation", "represent", "represents"?  Pick one.

> + * @phy: represents the phy device associated for the controller

s/phy/PHY/ in English text

> +	/* External Local Bus interface(ELBI) Register */

Space before "(" in English text.

> +		dev_err(dev, "failed to map dbi_base\n");
> +		dev_err(dev, "Sysreg regmap lookup failed.\n");
> +		dev_err(dev, "Couldn't get the register offset for syscon!\n");
> +		dev_err(dev, "couldn't get aux clock\n");

Random capitalization of driver messages.  Pick one.

> +	/* assert LTSSM enable */
> +		/* Return success as link might come up later */

Random capitalization of comments.  Pick one.

> +			case RADM_VENDOR_MSG:
> +				pr_info("Interrupt received for\n");

Must include device identification.  This one also looks incomplete
("for ..."?)

> +			/* To indicate that controller has accepted to send
> +			 * Latency Tolerance reporting message

Use standard multi-line comment format.

> +			dev_err(dev, "failed to get msi irq\n");

s/msi/MSI/ in English text.
s/irq/IRQ/ also

> +	.start_link	= fsd_pcie_establish_link,

fsd_pcie_start_link() to match function pointer name.

> +	pci->dbi_base2 = NULL;
> +	pci->dbi_base = NULL;
> +	pci->atu_base = NULL;

Unnecessary since you used kzalloc().

> +	dev_info(dev, "FSD PCIe probe completed successfully\n");

Questionable utility.  Most drivers don't emit this, or if they do,
they include some useful information like address, IRQ, etc.

> +	dev_err(dev, "PCIe Failed to set 36 bit dma mask\n");

s/dma/DMA/ in English text.
