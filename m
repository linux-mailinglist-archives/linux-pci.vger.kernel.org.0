Return-Path: <linux-pci+bounces-42779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D28CADF5A
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC5C30505A2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820E23D7D2;
	Mon,  8 Dec 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2bl04yD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A6770FE;
	Mon,  8 Dec 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217157; cv=none; b=m/9WNqdSeuVDqJwQbd2jOxABfT5rXXqGCU+U/KaiGfjlVOsqtGeKjrrezgESfEFkqWROAEQEvBFfo3YHT4HOGO2JpYjGw1qf3YzOKqxEyULJyzZHCOu4GZjixdseFzGLzJ80sCG+fdKK5FPiHduZ70P3TIEy7nzvSkGi1xtmDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217157; c=relaxed/simple;
	bh=CrjLRrbnJFqFyI6pg+42Uh4bZv6Rqw60ANZsc9xBeuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jej2yuz3LfVNqu3VpJS6KGGzwkrGatqe0e/Tq+uyFbntt+BAT2rFUdBwgHYV8xkbrctaygHk6zZSBECjJYCTglpR+K1EmUsuey2QN3fxl7waFrz3Q4ONgIY8xH9QytdGB9qdPuYAzFERkYVS7ZqtfTuAScVZimBQTJwtjFq548A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2bl04yD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CD7C4CEF1;
	Mon,  8 Dec 2025 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765217157;
	bh=CrjLRrbnJFqFyI6pg+42Uh4bZv6Rqw60ANZsc9xBeuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N2bl04yDZKXwqJjtS3w66qAyBaRWt+3QAc81zz/aKklw6qsRHM4nSHW2e5PdTZFKX
	 iZV5Y0mT+eLNGSnKaOGJGDk6vagvX+oogcXAfhV2+tUcRgCmn1uHQtmC6nVmS3pxht
	 45GYVMI+OEisijiK8/QaEah58NBPMtG1Bnb4iVHdd4IfzJL3NoVXXiwpQwIwBU0Ryv
	 PRP+xnT91weCYYTeJt7613QgYPBgo8PEhbWhqucqk1Lj73vx/DDGaNJ641Pr3edR7i
	 d8+XUF/RAYVxRqJszaM2t0DSXqrV8dN3aWDRHybCZCUjZ7ZciND6HHWyZqO57uIaBi
	 CikAJOlcCi0xw==
Date: Mon, 8 Dec 2025 12:05:55 -0600
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
Subject: Re: [PATCH v13 07/25] CXL/AER: Replace device_lock() in
 cxl_rch_handle_error_iter() with guard() lock
Message-ID: <20251208180555.GA3300834@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-8-terry.bowman@amd.com>

On Mon, Nov 03, 2025 at 06:09:43PM -0600, Terry Bowman wrote:
> cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
> for multiple return paths. Improve readability and maintainability by
> using the guard() lock variant.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I would reorder this patch to be after you move the function to
aer_cxl_rch.c.  Then the subjects could be more like this, which would
be a better match for the history:

  PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
  PCI/AER: Use guard() in cxl_rch_handle_error_iter()

I expect CXL content in drivers/pci/ to be mostly incidental, so I
think prefixes like "PCI/AER" or "PCI/ERR" are probably appropriate,
and "CXL" can appear in the rest of the line if relevant.

> +++ b/drivers/pci/pcie/aer.c
> @@ -1187,12 +1187,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> -	/* Protect dev->driver */

The comment seems worth keeping.

> -	device_lock(&dev->dev);
> +	guard(device)(&dev->dev);
>  
>  	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>  	if (!err_handler)
> -		goto out;
> +		return 0;
>  
>  	if (info->severity == AER_CORRECTABLE) {
>  		if (err_handler->cor_error_detected)
> @@ -1203,8 +1202,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  		else if (info->severity == AER_FATAL)
>  			err_handler->error_detected(dev, pci_channel_io_frozen);
>  	}
> -out:
> -	device_unlock(&dev->dev);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

