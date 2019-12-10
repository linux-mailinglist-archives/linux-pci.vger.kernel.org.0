Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438D1119FA6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 00:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLJXty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 18:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLJXty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 18:49:54 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A12420663;
        Tue, 10 Dec 2019 23:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576021793;
        bh=O8g07w6nqDMkqHZMoDdxx6Q9u1cAy0psqnVVzTIGPiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=la5NazEa8jCiN8xpow1GMbHqtzlSPcvayJlXzlc0OPZhelaViQxAwI2g6eSSjIZVC
         ANXVK0kb/uZAPSxPZArh6VIy79tz3xc94Z18P+Y0QRmArXEa+vD0cLlzsikh9dWRmN
         5KgGu6fFgANshBXJQCvZ4zdq3o1uQ60sh2qRzMw4=
Date:   Tue, 10 Dec 2019 17:49:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v10 2/3] PCI: dwc: intel: PCIe RC controller driver
Message-ID: <20191210234951.GA175479@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6325a23635ca56fd3aa616160b5cf967d62d01a.1575612493.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 06, 2019 at 03:27:49PM +0800, Dilip Kota wrote:
> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
> 
> Intel PCIe driver requires Upconfigure support, Fast Training
> Sequence and link speed configurations. So adding the respective
> helper functions in the PCIe DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.
> 
> Also, mark Intel PCIe driver depends on MSI IRQ Domain
> as Synopsys DesignWare framework depends on the
> PCI_MSI_IRQ_DOMAIN.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -14,6 +14,8 @@
>  
>  #include "pcie-designware.h"
>  
> +extern const unsigned char pcie_link_speed[];

This shouldn't be needed; there's a declaration in drivers/pci/pci.h.

> +struct intel_pcie_soc {
> +	unsigned int pcie_ver;
> +	unsigned int pcie_atu_offset;
> +	u32 num_viewport;
> +};

Looks a little strange to have the fields below lined up but the ones
above not.

> +struct intel_pcie_port {
> +	struct dw_pcie		pci;
> +	void __iomem		*app_base;
> +	struct gpio_desc	*reset_gpio;
> +	u32			rst_intrvl;
> +	u32			max_speed;
> +	u32			link_gen;
> +	u32			max_width;
> +	u32			n_fts;
> +	struct clk		*core_clk;
> +	struct reset_control	*core_rst;
> +	struct phy		*phy;
> +	u8			pcie_cap_ofst;
> +};
> +
> +static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
> +{
> +	u32 old;
> +
> +	old = readl(base + ofs);
> +	val = (old & ~mask) | (val & mask);
> +
> +	if (val != old)
> +		writel(val, base + ofs);

I assume this is never used on registers where the "old & ~mask" part
contains RW1C bits?  If there are RW1C bits in that part, this will
corrupt them.

> +	if (!lpp->pcie_cap_ofst) {
> +		ret = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
> +		if (!ret) {
> +			ret = -ENXIO;
> +			dev_err(dev, "Invalid PCIe capability offset\n");

Some of your messages start with a capital letter, others not.

> +int intel_pcie_msi_init(struct pcie_port *pp)

You might add a comment here like the one at
ks_pcie_am654_msi_host_init().  Since the users of the
.msi_host_init() function pointer only call the function if the
pointer is non-NULL, it's not completely obvious why you have this
stub function.

> +{
> +	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
> +	return 0;
> +}

> +	/*
> +	 * Intel PCIe doesn't configure IO region, so set viewport
> +	 * to not to perform IO region access.

s/to not to/to not/

> +	 */
> +	pci->num_viewport = data->num_viewport;
> +
> +	dev_info(dev, "Intel PCIe Root Complex Port init done\n");

Probably superfluous.

> +
> +	return ret;

Since the return value is known here:

  return 0;

> +}
