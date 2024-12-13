Return-Path: <linux-pci+bounces-18401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3D9F1396
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE918891C3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB371E47C5;
	Fri, 13 Dec 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfB2uES2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF057C9F;
	Fri, 13 Dec 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110882; cv=none; b=DzrZDHxN/vP1AVPXEgiSgaWPwaZaqe7M0gdqEi5hw5y6FLu4yBHRfE0bmhhNOUWRRpdbwWk7YDkNM4WzMgZqwPhcryYnnyPdnxtQgUC2TRkau9dAve9cDvy72QX5nL1YI2LA8XlB8NS2xcywijhvmRfk/CRF5Zf5dnak3wRUTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110882; c=relaxed/simple;
	bh=bLCKsDCiBo0kNuLFovfzPV3Qx9RxoALs0B0RMVkjEPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u9sbfEBGh26y7OHEi2ZUNi7UoFUtAvpjPiNT8+HtIiSLOehgNHhrWKISIsc617P+3OIoTABRrvpiKRYar+w89fz4oTDHkmmx5iRFg6bXq8P5qYz7FnpoYUpm5XJWb0Ydq2+m+yUCq7gEvrZBprLSFAZyxorcPxhOYbIVKvnVmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfB2uES2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20A6C4CED0;
	Fri, 13 Dec 2024 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734110882;
	bh=bLCKsDCiBo0kNuLFovfzPV3Qx9RxoALs0B0RMVkjEPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PfB2uES2XZZecOqIkIVdAG+6Kb3t5Oq46kKPQn5Gieh9OvL+FfcYJwFn1CT7FZ9XB
	 nbwhVN5dD7zgUQ7Z8SzZeIEe6/H+WrWZd7MAjrHROLnc9F51s7EZdyaugE2faPh0pZ
	 //rNghc3Gnb4+0ae2j6uy5Pt46T9ZOaKf7j87iwWTU8TL1zcCl+7yM7HI2tReCVFC/
	 byFdjIRV/1IJS17P7X0qfAP61UmM8quvNeTA/1L0wlanEpyhaWRjCAqWEWDpi6TSnV
	 OjLmRKcrDSiUTX1Gkn03w0UnplG5XEB3HKiExdRgohWFdH1Z1Px1BxNwVFGLJfWVtQ
	 TAJdUoM+keauA==
Date: Fri, 13 Dec 2024 11:27:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [RESEND PATCH v5 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20241213172759.GA3418116@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213064035.1427811-4-thippeswamy.havalige@amd.com>

On Fri, Dec 13, 2024 at 12:10:35PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB(Multimedia DMA Bridge) IP core as Root Port.

Add space before "(".

> +config PCIE_AMD_MDB
> +	bool "AMD PCIe controller (host mode)"

Seems too generic to describe this as "the AMD PCIe controller".
Perhaps at least "AMD MDB PCIe controller"?  And/or include "Versal2"?

> +	depends on OF || COMPILE_TEST
> +	depends on PCI && PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here to enable PCIe controller support on AMD SoCs. The
> +	  PCIe controller is based on DesignWare Hardware and uses AMD
> +	  hardware wrappers.

Make this help text a little more specific, too.

> + * struct amd_mdb_pcie - PCIe port information
> + * @pci: DesignWare PCIe controller structure
> + * @mdb_base: MDB System Level Control and Status Register(SLCR) Base

Add space before "(".

Thanks for expanding this initialism.  Capitalize it in the text of
other patches so it's obvious that it's an initialism, not a word.

> + * @intx_domain: Legacy IRQ domain pointer

Just say "INTx IRQ domain pointer".  No point in using two terms when
we use "INTx" everywhere else.

> + * @mdb_domain: MDB IRQ domain pointer
> + */
> +struct amd_mdb_pcie {
> +	struct dw_pcie			pci;
> +	void __iomem			*mdb_base;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*mdb_domain;
> +};

> + * amd_mdb_pcie_init_port - Initialize hardware
> + * @pcie: PCIe port information
> + * @pdev: platform device
> + */
> +static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie,
> +				  struct platform_device *pdev)

"pdev" is unused, why include it?

> +static irqreturn_t amd_mdb_pcie_event_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val =  pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);

Spurious extra space.

> +static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
> +					 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node = of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -EINVAL;
> +	}
> +
> +	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
> +						 &event_domain_ops,
> +					       pcie);

Fix whitespace.  "pcie" would fit on the previous line.

Bjorn

