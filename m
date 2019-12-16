Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38DD1208E0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfLPOtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 09:49:36 -0500
Received: from foss.arm.com ([217.140.110.172]:57802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfLPOtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 09:49:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6271C1FB;
        Mon, 16 Dec 2019 06:49:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDCA93F718;
        Mon, 16 Dec 2019 06:49:34 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:49:33 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 05/13] PCI: cadence: Add read and write accessors to
 perform only 32-bit accesses
Message-ID: <20191216144932.GY24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-6-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-6-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:39PM +0530, Kishon Vijay Abraham I wrote:
> Certain platforms like TI's J721E allow only 32-bit register accesses.

When I first read this I thought you meant only 32-bit accesses are allowed
and not other sizes (such as 64-bit). However the limitation you address
here is that the J721E allows only 32-bit *aligned* register accesses.

It would be helpful to make this clearer in the commit message.

You can also shorten the commit subject to 'PCI: cadence: Add read/write
accessors for 32-bit aligned accesses' or similar.

> Add read and write accessors to perform only 32-bit accesses in order to
> support platfroms like TI's J721E.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence.c | 40 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h |  2 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index cd795f6fc1e2..de5b3b06f2d0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -7,6 +7,46 @@
>  
>  #include "pcie-cadence.h"
>  
> +u32 cdns_pcie_read32(void __iomem *addr, int size)

Given there is already a cdns_pcie_readl in pcie-cadence.h it may help
to name this in a way that doesn't cause confusion. Here 32 is perhaps
being used to suggest the size of the actual read performed, the
maximum size of 'size' or the alignment.


> +{
> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
> +	unsigned int offset = (unsigned long)addr & 0x3;
> +	u32 val = readl(aligned_addr);
> +
> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> +		pr_err("Invalid Address in function:%s\n", __func__);

Would this be better as a BUG? Without a BUG this error could get ignored
and yet the device may not behave as expected.


> +		return 0;
> +	}
> +
> +	if (size > 2)
> +		return val;

I think you make the assumption here that if size > 2 then it's 4. It could
be 3 (though unlikely) in which case you'd want to fall through to the next
line.

> +
> +	return (val >> (8 * offset)) & ((1 << (size * 8)) - 1);
> +}
> +
> +void cdns_pcie_write32(void __iomem *addr, int size, u32 value)
> +{

And same feedback for this function.

Thanks,

Andrew Murray

> +	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
> +	unsigned int offset = (unsigned long)addr & 0x3;
> +	u32 mask;
> +	u32 val;
> +
> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> +		pr_err("Invalid Address in function:%s\n", __func__);
> +		return;
> +	}
> +
> +	if (size > 2) {
> +		writel(value, addr);
> +		return;
> +	}
> +
> +	mask = ~(((1 << (size * 8)) - 1) << (offset * 8));
> +	val = readl(aligned_addr) & mask;
> +	val |= value << (offset * 8);
> +	writel(val, aligned_addr);
> +}
> +
>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
>  				   u32 r, bool is_io,
>  				   u64 cpu_addr, u64 pci_addr, size_t size)
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f0395eaf9df5..5171d0da37da 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -498,6 +498,8 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
>  void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
>  int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
>  int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
> +u32 cdns_pcie_read32(void __iomem *addr, int size);
> +void cdns_pcie_write32(void __iomem *addr, int size, u32 value);
>  extern const struct dev_pm_ops cdns_pcie_pm_ops;
>  
>  #endif /* _PCIE_CADENCE_H */
> -- 
> 2.17.1
> 
