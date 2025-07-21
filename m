Return-Path: <linux-pci+bounces-32686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0FB0CCFA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475B81C23143
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124DB23A98E;
	Mon, 21 Jul 2025 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghrsl6yz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B51B4242;
	Mon, 21 Jul 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134899; cv=none; b=s1NRpiuaE/hqWPpe1tUAFZ4EM31yiQfxU7fNM0yuvfcYxATQf1Gt7bTQFshFSjeyVBtYrtRZWAIozH/L4DPWz7PhQxsLauw/XzEVhMZ57J45I4jMLWTFu/5qick2GvPh/S1Pw/57Q/c/QA9zuYjn0HJAccd1uPldlS97lKmcUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134899; c=relaxed/simple;
	bh=TGMtM0oq5q8pDi6wOyW4p0wFReNzv8+xD+zrJ9vF+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AglQ1f+62bh80znjUN343hE+M5vqrgt76VZSRQGlNjs2ZmbEFiOHqgvRVVBIfhQWkallLNRY4KtIdrVOwVojLLk+DIgZSWGJ40qSKLSziJ55qgjpyYec6wIz3nRhDA/DwAv9pt1qsN65ZcnLTd7GnubULxqzNqGqnPUMJYriRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghrsl6yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B23C4CEED;
	Mon, 21 Jul 2025 21:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753134899;
	bh=TGMtM0oq5q8pDi6wOyW4p0wFReNzv8+xD+zrJ9vF+9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ghrsl6yzBuoHPaD+rYi8qDAhd0xSipUUiAgwlRuiOyQg9wltxflDeyQdP7w1qRE/C
	 q0D1D5LXuMrYhYQBQSgI4o/dWGbL8T6+eXhQ3Zslj2cYp71yCPUrzx5thbsuWbS/vC
	 rwUsOZaiOwUZy+7OdHFyM1RhmWlrZim+K/FwxAke7jWc7AWwHpL4HzZWc74BbXUkPh
	 vzGrUToPK+wtCmQVz4RUGbMipohhd+sCnZPmoZkbkajmXJ7tssNzdZopuQUUMrPflG
	 eG7ZT40LQZUn/arxBcgQ8YW4c6gd6YAt5Opy+/OlUVU0VsLLmgjoVv4rBXO247A2i8
	 4h+AYlvEbKGuQ==
Date: Mon, 21 Jul 2025 16:54:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v6 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250721215457.GA2756536@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719030951.3616385-3-sai.krishna.musham@amd.com>

On Sat, Jul 19, 2025 at 08:39:51AM +0530, Sai Krishna Musham wrote:
> Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> signal via a GPIO by parsing the new PCIe bridge node to acquire the
> reset GPIO. If the bridge node is not found, fall back to acquiring it
> from the PCIe node.
> 
> As part of this, update the interrupt controller node parsing to use
> of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> node now has multiple children. This ensures the correct node is
> selected during initialization.

> +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct device_node *pcie_port_node;
> +
> +	pcie_port_node = of_get_next_child_with_prefix(dev->of_node, NULL, "pcie");
> +	if (!pcie_port_node) {
> +		dev_err(dev, "No PCIe Bridge node found\n");
> +		return -ENODEV;
> +	}

Sorry I didn't notice this before.   I don't think we want to emit a
message here either because existing DTs in the field will not have a
Root Port node, and we will just fall back to the 'reset' in the PCIe
node.

There's really nothing wrong in that case, so no need to annoy users
with messages they can't fix.

IIUC, PERST# in the DT is optional anyway (you use
devm_gpiod_get_optional() below).

> +	/* Request the GPIO for PCIe reset signal and assert */
> +	pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(pcie_port_node),
> +						 "reset", GPIOD_OUT_HIGH, NULL);
> +	if (IS_ERR(pcie->perst_gpio)) {
> +		if (PTR_ERR(pcie->perst_gpio) != -ENOENT) {
> +			of_node_put(pcie_port_node);
> +			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
> +					     "Failed to request reset GPIO\n");
> +		}
> +		pcie->perst_gpio = NULL;
> +	}
> +
> +	of_node_put(pcie_port_node);
> +
> +	return 0;
> +}

> @@ -444,6 +483,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct amd_mdb_pcie *pcie;
>  	struct dw_pcie *pci;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -454,6 +494,26 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	ret = amd_mdb_parse_pcie_port(pcie);
> +
> +	/*
> +	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
> +	 * PCIe Bridge node was not found in the device tree. This is not
> +	 * considered a fatal error and will trigger a fallback where the
> +	 * reset GPIO is acquired directly from the PCIe node.
> +	 */
> +	if (ret == -ENODEV) {
> +
> +		/* Request the GPIO for PCIe reset signal and assert */
> +		pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
> +							   GPIOD_OUT_HIGH);
> +		if (IS_ERR(pcie->perst_gpio))
> +			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
> +					     "Failed to request reset GPIO\n");
> +	} else if (ret) {
> +		return ret;
> +	}
> +
>  	return amd_mdb_add_pcie_port(pcie, pdev);
>  }
>  
> -- 
> 2.44.1
> 

