Return-Path: <linux-pci+bounces-18038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1039EB84C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0333E162C8E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED51A0B13;
	Tue, 10 Dec 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7rwvAvr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63901990BA;
	Tue, 10 Dec 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851886; cv=none; b=EggjCAv1WTIK7bypZtIYVbvcEfpJZGp+g7PI4bwEu8QeHhnHOsdGq1viASKmhoBEn8Ckfy47qJQFsKwylUmiqFprTs52oFZAaXEDmxDzxDAdYNeoggsZGq/0/acGmUrpdaiLz1V/r7lrWhZq63tImQC75j6y0ZahYCsgSug5Dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851886; c=relaxed/simple;
	bh=DuBdlT+k6TDL3ybELXaf3EyWiycHlo9VKr61ZHOmzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lEn2IGX/yid9TnhzWcA3uUpOndzz5oeqAFCCLxmxCgDpVpjU0xOAS1uzhSTB9oIAUKKTLFauJypv1DXMmCyELAhR+HV//502gYoHWSc3lbeP2yZ0yM9o4PuEpFJt/Ax10VQU60C0oliky2A+3Nwg0R7jClfUkEaUXJhItbxE3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7rwvAvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F5C4CEDD;
	Tue, 10 Dec 2024 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733851885;
	bh=DuBdlT+k6TDL3ybELXaf3EyWiycHlo9VKr61ZHOmzqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u7rwvAvrDmwsGVeL9KORiux9PdU5c0Jz5MVI/MTPKUOA/8/SA2I5FiDLLrcyssx2m
	 TTTRY1hm2x5TzBu//inrGvww2OTIK4/q4vRJh6+xbkIzMzK6YKdNnU56B5MC2/fSUz
	 jLoDp8Zt7LdKbXQFipYs4Ss1g7S/wbYXMDJxiFrVG2OHhuJItj2s/Ph1cS2fGQSrF0
	 UvKGW94k3B/dXFvKP/owrasdIEnx48Wd/vIahARjJNkbd5TPzxWWD+AwnEdSYo+UYQ
	 W9jbhPX0IuGvTjGEwjtWzn9jIudc/8TAwVJhX/IrAWay6OcR9dquLF9BbhTS6vLCoJ
	 6DJV/yhON5qOw==
Date: Tue, 10 Dec 2024 11:31:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20241210173123.GA3247614@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d82eff3670f60df24228e5c83cf663c6dd61eaf.1733726572.git.unicorn_wang@outlook.com>

On Mon, Dec 09, 2024 at 03:19:57PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only.

> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
> \ No newline at end of file

Add the newline.

> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c

> +#include "../../../irqchip/irq-msi-lib.h"

This is the only file outside drivers/irqchip/ that includes this.
What's special about this driver?  Maybe this is a hint that something
here belongs in drivers/irqchip/?

> +#ifdef CONFIG_SMP

No other drivers test CONFIG_SMP, why should this be different?

> +static int sg2042_pcie_msi_irq_set_affinity(struct irq_data *d,
> +					    const struct cpumask *mask,
> +					    bool force)
> +{
> +	if (d->parent_data)
> +		return irq_chip_set_affinity_parent(d, mask, force);
> +
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_SMP */

> +static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	u32 value;
> +	int ret;
> +
> +	raw_spin_lock_init(&pcie->msi_lock);
> +
> +	/*
> +	 * Though the PCIe controller can address >32-bit address space, to
> +	 * facilitate endpoints that support only 32-bit MSI target address,
> +	 * the mask is set to 32-bit to make sure that MSI target address is
> +	 * always a 32-bit address
> +	 */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));

Not sure this is needed.  Does DT dma-ranges not cover this?

> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie, struct device_node *msi_node)

Wrap to fit in 80 columns like the rest.

> +/*
> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
> + * the PCIe controller itself, read32 is required. For non-rootbus (i.e. to read

s/PCIe controller/Root Port/

> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
> + * directly use read should be fine.

s/use read/using read/

> +static int sg2042_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct pci_host_bridge *bridge;
> +	struct device_node *np_syscon;
> +	struct device_node *msi_node;
> +	struct cdns_pcie *cdns_pcie;
> +	struct sg2042_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	struct regmap *syscon;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
> +		return -ENODEV;

I don't think this is needed since CONFIG_PCIE_SG2042 selects
PCIE_CADENCE_HOST.

Bjorn

