Return-Path: <linux-pci+bounces-42710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765BCA9C5D
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 01:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9D7324AF8A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791141EB5C2;
	Sat,  6 Dec 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCIZsR9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7917BA2;
	Sat,  6 Dec 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981952; cv=none; b=rq8nGwxZLUUfAxe40QOTAOs6tiDHYkKGLSp+Oi3N2yOEWfyXMZaW2WIHkFxOm2mPuk+oOrQQ4T3FWHkyenbd/Fv6hxBhfdG7A8PWKMyuyeQ9706fVWcjwCXD9Hfyt0XD4KW6duwtUadquDNSyhdf7v/suozAeUpV8GCxt6hu9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981952; c=relaxed/simple;
	bh=ky1GQuKDJK58iC5WB0rubjlaBcnddSUkeFTX3aSXMbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I5ryrQOzgpHIvtmGzIoYI3YBMh4SxQu6/ulVm88w6x6OwhjTpYKTjEIMaLcDeOhxEghWKGXtAEKjozghPEIBlvjDgnN+BqpjGi0hVdDFKnrqDFou3E49G7PhIbVQMAVqRmposu+yr7FNPZJWXlWX//ELnG/RybAU3sPe1xlqyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCIZsR9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53E3C4CEF1;
	Sat,  6 Dec 2025 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764981951;
	bh=ky1GQuKDJK58iC5WB0rubjlaBcnddSUkeFTX3aSXMbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tCIZsR9HQej0VK8CdNYie88t6iuX7B3maRuyXdoKqiQX7YqmN7DuNRNBVrjWboKht
	 uWj++jxOOBxONKnB2knvq1c0zDuTmqy20E87ClVMWSZ/yRKji/F6S64s2yRrIK6ovR
	 N70XthZsxfbMjyIsX3YptC5KOJnB+5kOpiziLCV36fphRInXT7IgjjRbCaTHbo9yu3
	 LoMEJNYPAOeI/Dp8QAmkAcVF082g2ZoPfFnKr4R6fIj4qyXifkvfLeh0idg64SY7bM
	 AAJbmSue9i1vS50doBqkHsBfOTegRaLuJYgUqWaf/neJMkjC5qquNXfYNisImK4HVj
	 d8dwUElPW3/mg==
Date: Fri, 5 Dec 2025 18:45:50 -0600
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
Subject: Re: [PATCH v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <20251206004550.GA3300344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-3-terry.bowman@amd.com>

On Mon, Nov 03, 2025 at 06:09:38PM -0600, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
> 
> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
> the parent downstream device. Once a device is created there is
> possibilty the parent training or CXL state was updated as well. This
> will make certain the correct parent CXL state is cached.

See question at comment below.

s/on behalf of the parent downstream device/for the parent bridge/
s/possibilty/possibility/

> +++ b/drivers/pci/probe.c
> @@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> +	if (dvsec) {
> +		u16 cap;
> +
> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> +
> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);

Wrap to fit in 80 columns like the rest of the file.

Not sure the "_MASK" and "_OFFSET" on the end of all these #defines is
really needed.  Other items in pci_regs.h typically don't include
them, and these names get really long.  

> +	}
> +
> +	if (!pci_is_pcie(dev) ||
> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
> +		return;

Maybe could do the pci_is_pcie() check first, before the
pci_find_dvsec_capability(), so we could avoid that search, e.g.,

  if (!pci_is_pcie(dev))
    return;

  dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL, ...);

> +	/*
> +	 * Update parent's CXL state because alternate protocol training
> +	 * may have changed

What is the event that changes alternate protocol training?  The
commit log says "once a device is created", but I don't know what that
means in terms of hardware.

> +	 */
> +	parent = pci_upstream_bridge(dev);
> +	set_pcie_cxl(parent);
> +}

