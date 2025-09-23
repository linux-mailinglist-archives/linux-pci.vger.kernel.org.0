Return-Path: <linux-pci+bounces-36782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E458B96AB9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D564A0465
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAEE264A92;
	Tue, 23 Sep 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB0XYEnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7416DC28;
	Tue, 23 Sep 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642886; cv=none; b=C+iY86QW4IqCp/OMmkKr2cuzVimiDemMrS9dWuInECierVRDl9uyPZGRuxQwcRBqEcXVvhO0IkExHI+zEqhIP9amZnr9849aaXdVIwMD/TCwsdgrcZslwXxcY8H922ku+aKYh3e2CBUBifh9faj5xQYvV6WulW/oK1fQY6YFaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642886; c=relaxed/simple;
	bh=9PAHk1M/py/wmr9FX/AJcB5+6ZJZbCQJMTHF0F98NFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aJhAXGoz8E0BF8obKmfCE3BTf5J9Vlp7cahWXYRDanKMZtkQdKe80zBA6SKwmmPP3ACNGTVJIoevomp8KPvh08Sfzn4WdV2+u0gQvcN0btB0t+AIaFfOr4N5iDFsxkXekZJFlUHnRKhDqywpBzIDxPnZ6MeevLeLt8YAxOimQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB0XYEnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552B6C113CF;
	Tue, 23 Sep 2025 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758642885;
	bh=9PAHk1M/py/wmr9FX/AJcB5+6ZJZbCQJMTHF0F98NFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HB0XYEnR4MNkE+vIXx7MKexzkD7sZteWlROImwjLYmOQTkC+TRO+FbdgUqwZjKTr0
	 rdPY61ShmA5mZEfCZ+nh3Vk5sJbUDb6Am8Ar30yP+v4j3hLx66DUUqA3i33LD97yEM
	 cOEP9MGIhgzOomPU26Q5Dvuyc80y9DnlBz+cyEBuJOJKnmJeAwcp9ZnA1qxBfUbwrV
	 TR+TJnaVZYVGOjFhxqRu6xwY8iG4FPm433mVuJkL5aBQZ53fpkHzfGBPOCxe8/aG8I
	 MjRySA+WP+fnJWjfcQ+ep6S00INskkZhdIZBsQeiWDVcH77tGiZSA8EbH+2zpELl7d
	 oeT+tC+hUDsQg==
Date: Tue, 23 Sep 2025 10:54:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v3 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <20250923155443.GA2041202@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923113647.895686-5-randolph@andestech.com>

On Tue, Sep 23, 2025 at 07:36:46PM +0800, Randolph Lin wrote:
> Add driver support for DesignWare based PCIe controller in Andes
> QiLai SoC. The driver only supports the Root Complex mode.

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -49,6 +49,19 @@ config PCIE_AMD_MDB
>  	  DesignWare IP and therefore the driver re-uses the DesignWare
>  	  core functions to implement the driver.
>  
> +config PCIE_ANDES_QILAI
> +	bool "ANDES QiLai PCIe controller"
> +	depends on ARCH_ANDES || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here to enable PCIe controller support on Andes QiLai SoCs,
> +	  which operate in Root Complex mode. The Andes QiLai SoCs PCIe
> +	  controller is based on DesignWare IP (5.97a version) and therefore
> +	  the driver re-uses the DesignWare core functions to implement the
> +	  driver. The Andes QiLai SoC features three Root Complexes, each
> +	  operating on PCIe 4.0.

Sort these by vendor name:

  AMD MDB Versal2 PCIe controller
  Amlogic Meson PCIe controller
  ANDES QiLai PCIe controller
  Axis ARTPEC-6 PCIe controller (host mode)

>  config PCI_MESON
>  	tristate "Amlogic Meson PCIe controller"

> + * Refer to Table A4-5 (Memory type encoding) in the
> + * AMBA AXI and ACE Protocol Specification.
> + *
> + * The selected value corresponds to the Memory type field:
> + * "Write-back, Read and Write-allocate".
> + */
> +#define IOCP_ARCACHE				0b1111
> +#define IOCP_AWCACHE				0b1111

Deserves a note about why these values are identical.

> +struct qilai_pcie {
> +	struct dw_pcie pci;
> +	struct platform_device *pdev;

"pdev" appears to be set but never used; drop it if you don't need it.

> +/*
> + * Setup the Qilai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
> + * Write-Back, Read and Write Allocate mode.

Add blank line or rewrap into single paragraph.

> + * The IOCP HW target is SoC last-level cache (L2 Cache), which serves as the
> + * system cache. The IOCP HW helps maintain cache monitoring, ensuring that
> + * the device can snoop data from/to the cache.
> + */
> +static void qilai_pcie_iocp_cache_setup(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u32 val;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	dw_pcie_read(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
> +		     sizeof(val), &val);
> +	FIELD_MODIFY(PCIE_CFG_MSTR_ARCACHE_MODE, &val, IOCP_ARCACHE);
> +	FIELD_MODIFY(PCIE_CFG_MSTR_AWCACHE_MODE, &val, IOCP_AWCACHE);
> +	FIELD_MODIFY(PCIE_CFG_MSTR_ARCACHE_VALUE, &val, IOCP_ARCACHE);
> +	FIELD_MODIFY(PCIE_CFG_MSTR_AWCACHE_VALUE, &val, IOCP_AWCACHE);
> +	dw_pcie_write(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
> +		      sizeof(val), val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}

> +static int qilai_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qilai_pcie *pcie = to_qilai_pcie(pci);
> +
> +	qilai_pcie_enable_msi(pcie);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops qilai_pcie_host_ops = {
> +	.init = qilai_pcie_host_init,
> +};
> +
> +static int qilai_pcie_probe(struct platform_device *pdev)
> +{
> +	struct qilai_pcie *pcie;
> +	struct dw_pcie *pci;
> +	struct device *dev;
> +	int ret;
> +
> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->pdev = pdev;
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pci = &pcie->pci;
> +	dev = &pcie->pdev->dev;
> +	pcie->pci.dev = dev;
> +	pcie->pci.ops = &qilai_pcie_ops;
> +	pcie->pci.pp.ops = &qilai_pcie_host_ops;
> +	pci->use_parent_dt_ranges = true;
> +
> +	dw_pcie_cap_set(&pcie->pci, REQ_RES);
> +
> +	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(pcie->apb_base))
> +		return PTR_ERR(pcie->apb_base);
> +
> +	ret = dw_pcie_host_init(&pcie->pci.pp);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to initialize PCIe host\n");
> +		return ret;
> +	}
> +
> +	qilai_pcie_iocp_cache_setup(&pcie->pci.pp);

I don't think we should be doing anything after dw_pcie_host_init()
because by the time we get here, we've already enumerated downstream
devices and potentially bound drivers to them.

If you need things done in dw_pcie_host_init() before enumeration,
qilai_pcie_host_init() and similar hooks are possibilities.

> +	return 0;
> +}

