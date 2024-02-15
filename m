Return-Path: <linux-pci+bounces-3550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51B856F22
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA73285A58
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AC13B78E;
	Thu, 15 Feb 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZcJ/QPl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E713B78A;
	Thu, 15 Feb 2024 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031624; cv=none; b=mnxmwn+6A3/K39YPaNO3dtRwBW6TWow/ubkmeaaPxKdtg7KR4onRgIhezPNsSGHWuKlBQcH+XFS4d6FTKwfL+VT+4iGtxs0ApBNhNByIvW5HoTj4n+hlolKfMA5l4QOg/JfRZ9u4atMs/B74OaUFa1KBZG6zW1lemmtWN6yiQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031624; c=relaxed/simple;
	bh=uOmvcLZkQKdHR5lFbKTF7DiuzuqvvncHkZ3CE3c67nM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h0yEKOwBLAzca+Wup31sNNdDnIgMJ2WWUftqlsv6fnIqXBf9nSDwBt019rK+SFWz5sU56NI02LXZHcwpGqMmPde+WdGJCDWVqxpHIofohEMvO21rQpxW2YsDn4IjgFSDrmHd14KGZcZpksqy4M0DPz098VTDWV/KtOrNJ2C7PZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZcJ/QPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB64CC433C7;
	Thu, 15 Feb 2024 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708031624;
	bh=uOmvcLZkQKdHR5lFbKTF7DiuzuqvvncHkZ3CE3c67nM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PZcJ/QPlcf4ctaDOzTbXLVtTptbwy3AFVp5abehGao5b51GudSMvzNloxdD61Q8i9
	 f3k1L9c5co3C+TKeMGWTBwIhQempG6Jgd9MVOHFz9PcpTGJt4ddAF+1J0T5Tvph4qp
	 k0Iz8dxpXUlKXz6GMlIB8pE2KMYMcGcUWKneb2XtuYgrrM6Hg3JdNBOQ9J37vZze7D
	 eq3GEEkE72gQzvDHy4JlbDY5GrT/A545rbt8oA4u+QX2OQgsYD/+v4y10soLKeQAu3
	 w3ENw0vBdFrcx/2adXlK5wKlP384Jt7YfXSPz1kTdwswgD1Gi5CV8SbLVj/xWMUFp9
	 MgOD2UwEINWgQ==
Date: Thu, 15 Feb 2024 15:13:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 2/6] pcie/cxl_timeout: Add CXL Timeout & Isolation
 service driver
Message-ID: <20240215211342.GA1304889@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215194048.141411-3-Benjamin.Cheatham@amd.com>

Follow drivers/pci/ subject line convention.  Suggest

  PCI/CXL: Add CXL Timeout & Isolation service driver

On Thu, Feb 15, 2024 at 01:40:44PM -0600, Ben Cheatham wrote:
> Add a CXL Timeout & Isolation (CXL 3.0 12.3) service driver to the
> PCIe port bus driver for CXL root ports. The service will support
> enabling/programming CXL.mem transaction timeout, error isolation,
> and interrupt handling.
> ...

>  /* CXL 3.0 8.2.4.23 CXL Timeout and Isolation Capability Structure */
>  #define CXL_TIMEOUT_CAPABILITY_OFFSET 0x0
> +#define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP BIT(4)
> +#define CXL_TIMEOUT_CONTROL_OFFSET 0x8
> +#define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
>  #define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10

Weird lack of alignment makes these #defines hard to read, but kudos
for following the local style ;)

>  /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */

Update to current CXL spec, please.  In r3.0, it looks like this is
sec 8.2.4.16.  Updating everything to r3.1 references would be even
better.

> +config PCIE_CXL_TIMEOUT
> +	bool "PCI Express CXL.mem Timeout & Isolation Interrupt support"
> +	depends on PCIEPORTBUS
> +	depends on CXL_BUS=PCIEPORTBUS && CXL_PORT
> +	help
> +	  Enables the CXL.mem Timeout & Isolation PCIE port service driver. This
> +	  driver, in combination with the CXL driver core, is responsible for
> +	  handling CXL capable PCIE root ports that undergo CXL.mem error isolation
> +	  due to either a CXL.mem transaction timeout or uncorrectable device error.

When running menuconfig, it seems like both PCIEAER_CXL and
PCIE_CXL_TIMEOUT would fit more logically in the drivers/cxl/Kconfig
menu along with the rest of the CXL options.

Rewrap to fit in 78 columns.

s/PCIE/PCIe/ (also below)

> + * Implements CXL Timeout & Isolation (CXL 3.0 12.3.2) interrupt support as a
> + * PCIE port service driver. The driver is set up such that near all of the
> + * work for setting up and handling interrupts are in this file, while the
> + * CXL core enables the interrupts during port enumeration.

Seems like sec 12.3.2 is slightly too specific here.  Maybe 12.3?

> +struct pcie_cxlt_data {
> +	struct cxl_timeout *cxlt;
> +	struct cxl_dport *dport;

"dport" is not used here.  Would be better to add it in the patch that
needs it.

> +static int cxl_map_timeout_regs(struct pci_dev *port,
> +				struct cxl_register_map *map,
> +				struct cxl_component_regs *regs)
> +{
> +	int rc = 0;

Unnecessary initialization.

> +	rc = cxl_find_regblock(port, CXL_REGLOC_RBI_COMPONENT, map);
> ...

> +int cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap)
> +{
> +	struct cxl_component_regs regs;
> +	struct cxl_register_map map;
> +	int rc = 0;

Unnecessary initialization.

> +	rc = cxl_map_timeout_regs(dev, &map, &regs);
> +	if (rc)
> +		return rc;
> +
> +	*cap = readl(regs.timeout + CXL_TIMEOUT_CAPABILITY_OFFSET);
> +	cxl_unmap_timeout_regs(dev, &map, &regs);
> +
> +	return rc;

Since we already know the value:

  return 0;

> +}

Move cxl_find_timeout_cap() to the patch that needs it.  It's unused
in this one.

> +static int cxl_timeout_probe(struct pcie_device *dev)
> +{
> +	struct pci_dev *port = dev->port;
> +	struct pcie_cxlt_data *pdata;
> +	struct cxl_timeout *cxlt;
> +	int rc = 0;

Unnecessary initialization.

> +	/* Limit to CXL root ports */
> +	if (!pci_find_dvsec_capability(port, PCI_DVSEC_VENDOR_ID_CXL,
> +				       CXL_DVSEC_PORT_EXTENSIONS))
> +		return -ENODEV;
> +
> +	pdata = cxlt_create_pdata(dev);
> +	if (IS_ERR_OR_NULL(pdata))
> +		return PTR_ERR(pdata);
> +
> +	set_service_data(dev, pdata);
> +	cxlt = pdata->cxlt;
> +
> +	rc = cxl_enable_timeout(dev, cxlt);
> +	if (rc)
> +		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
> +			rc);

"(%pe)" (similar in subsequent patches)

> +	return rc;
> +}
> +

> @@ -829,6 +829,7 @@ static void __init pcie_init_services(void)
>  	pcie_pme_init();
>  	pcie_dpc_init();
>  	pcie_hp_init();
> +	pcie_cxlt_init();

"cxlt" seems slightly too generic outside cxl_timeout.c, since there
might be other CXL things that start with "t" someday.

> +#define PCIE_PORT_SERVICE_CXLT_SHIFT	5	/* CXL Timeout & Isolation */
> +#define PCIE_PORT_SERVICE_CXLT		(1 << PCIE_PORT_SERVICE_CXLT_SHIFT)

I hate having to add this to the portdrv, but I see why you need to
(so we can deal with the weirdness of PCIe feature interrupts).

Bjorn

