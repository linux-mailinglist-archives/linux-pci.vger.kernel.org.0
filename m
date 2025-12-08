Return-Path: <linux-pci+bounces-42783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC04CAE00F
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 621703095E5E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669B1D88B4;
	Mon,  8 Dec 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6z7oDXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4262AF00;
	Mon,  8 Dec 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219070; cv=none; b=D5RvPkHSVZd30XRe0IQaywqM4oUkia7ZxAGdyh+726sZqQ3GI+VTGgz8o0VI2eOykaV9z4YAPBZ7o4Gm+56bPGtMMuq1eOlVLf5SgOObAK9QOeNNiH1vfAdIiyiQkrKZLYl7ftZdJMCYytcb6nYMz6uY/JW/rEvfquItaj6aLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219070; c=relaxed/simple;
	bh=hi9gRa6o37XxNGib7CawRtphGJivyzFOSr/XvNdW4B0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U7g8b5/jCoU0X474JoD+Q7O0ICDkUwFAXXZLwgm1GqGUv1HpBBS/4eqJgFStSUmQHqIqI/3E/zqtdRuyIRJ8qNWbAq0AeEh/IJ/Zi/B7fctodzoOhQcEQt8Z0Rph+zokvTGxI5ocy+rZlq2Vfby1DpN6cXPBkDg8GQn9XPJLgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6z7oDXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1BC4CEF1;
	Mon,  8 Dec 2025 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765219070;
	bh=hi9gRa6o37XxNGib7CawRtphGJivyzFOSr/XvNdW4B0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=B6z7oDXFhdanIzaYqRFT0yrHq3xVM5bXUOK120dHnGI+C4CsrhMWh1EJFyENqMrxr
	 G3mf1rVIqILwWcNlHAyumFwoTEXskjFu+XVjTwC3DiTU2WDHjwYS2XrpRzj6Iukyn8
	 OUGhcka1pj0vSDJELlW/0xvCqIzstrSPGWThXzzF+021OsKQdF2lMvqzXAxpOJ5WBk
	 hgnKNBM9YgQcmgS+//Q86GalHX73O0fm1zjdkEBlDCfX9UeDLJy1+fLF2PGkefNy1K
	 QC8MttqLh1wii1w8idL6j8BPwjyg+c7WqxjY2HzXI5fPENh9nduvxonXQTvChukMrZ
	 QDNPKRdDKzCVQ==
Date: Mon, 8 Dec 2025 12:37:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 20/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
Message-ID: <20251208183749.GA3302551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-21-terry.bowman@amd.com>

On Mon, Nov 03, 2025 at 06:09:56PM -0600, Terry Bowman wrote:
> Add CXL protocol error handlers for CXL Port devices (Root Ports,
> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
> and cxl_port_error_detected() to handle correctable and uncorrectable errors
> respectively.
> 
> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
> address for a given CXL port. This function supports CXL Root Ports,
> Downstream Ports, and Upstream Ports by returning their previously mapped
> RAS register addresses.
> 
> Add device lock assertions to protect against concurrent device or RAS
> register removal during error handling. The port error handlers require
> two device locks:
> 
> 1. The port's CXL parent device - RAS registers are mapped using devm_*
>    functions with the parent port as the host. Locking the parent prevents
>    the RAS registers from being unmapped during error handling.
> 
> 2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
>    to the PCI device structure during error handling.
> 
> The lock assertions added here will be satisfied by device locks introduced
> in a subsequent patch.

Weird.  Can't you add the lock assertions at the same time you add the
locks?

> Introduce get_pci_cxl_host_dev() to return the device responsible for
> managing the RAS register mapping. This function increments the reference
> count on the host device to prevent premature resource release during error
> handling. The caller is responsible for decrementing the reference count.
> For CXL endpoints, which manage resources without a separate host device,
> this function returns NULL.
> 
> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
> addition to CXL Endpoints, as both now have CXL-specific error handlers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> @@ -1573,6 +1573,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  		return to_cxl_port(dev);
>  	return NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");

The usual export question: is there a modular caller()?

> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));

Maybe "%#x" (add 0x prefix and use lower-case hex, unless there's a
different CXL convention)?

