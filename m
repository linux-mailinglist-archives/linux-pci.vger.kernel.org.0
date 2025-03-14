Return-Path: <linux-pci+bounces-23781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C4A61CC0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 21:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D74F460C92
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEB1A2872;
	Fri, 14 Mar 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T77BRoue"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48732194C61;
	Fri, 14 Mar 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984319; cv=none; b=L2R7c/7oCt38DttOp4vCAByQLnpe9E4+ip8CGa0gMn3zRLbHFow/FEcXZRTjCQhUoZYXWIDumvMXvDKPQPpPZzRB35Iw7P0e7SKgcSjP0rXDz3XLCWCHiEwET96aLLRkxmJyjkdBOqX3i6eynamyl8U1S6e0oFDBGO34xQzRo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984319; c=relaxed/simple;
	bh=dK2VQ/TYldEsotPwKFrO5mL+jDRi63pFE0jLy3hBuqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YEWp4oUObf3KBRKbBbvDCN4+PrzjQUw2LajfNFrr1e45G3MJfwblXfdTDNGFslhMbQfngqCcMr2YjtOROfJR0sinAbpKkHBSDPyNXpzpKsY9ay5/SDhFnzayxOPXaHVccID7mTNVMf9/FDrZ+8nfBRlUCWfozhZQEEhOxqmTNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T77BRoue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8DAC4CEE3;
	Fri, 14 Mar 2025 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741984318;
	bh=dK2VQ/TYldEsotPwKFrO5mL+jDRi63pFE0jLy3hBuqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T77BRouesIl5IzYgwjCWBfpVtr2moZdpMFZo5s2vRYeQO2tx4Yfe9lvjlURB+hY+9
	 c0pRZP/v5xgwH6QSLpkB80stHfq/Xfe8468rlPvuNsak7DXBcRYvuTyhtQoAQYGWxf
	 hjUpZl2UjXaFwfCZwVEAqky3OwnCjU4jFYmk8NzNL1uLa277JiEYnC5jFW3jfUsYY/
	 Q0dBZEok/mhnnt4AS5Yn18zPjy05ZS1b2/vSqJGyndhkT+KH5UNN/wPZIGpuDIipx8
	 weemJ+V1AVsDrDIHr2nGfBT8k82Sb++O2WVQ/bdYgJ8Jxs+4ngnQXTBG2W6LpvGyLf
	 hSpTrDe+VQ46A==
Date: Fri, 14 Mar 2025 15:31:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Hans Zhang <18255117159@163.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	bwawrzyn@cisco.com, thomas.richard@bootlin.com,
	wojciech.jasko-EXT@continental-corporation.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
Message-ID: <20250314203157.GA793598@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314130511.hmceagpx5oq5gvrr@thinkpad>

On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
> ...

> Even though this patch is mostly for an out of tree controller
> driver which is not going to be upstreamed, the patch itself is
> serving some purpose. I really like to avoid the hardcoded offsets
> wherever possible. So I'm in favor of this patch.
> 
> However, these newly introduced functions are a duplicated version
> of DWC functions. So we will end up with duplicated functions in
> multiple places. I'd like them to be moved (both this and DWC) to
> drivers/pci/pci.c if possible. The generic function
> *_find_capability() can accept the controller specific readl/ readw
> APIs and the controller specific private data.

I agree, it would be really nice to share this code.

It looks a little messy to deal with passing around pointers to
controller read ops, and we'll still end up with a lot of duplicated
code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
etc.

Maybe someday we'll make a generic way to access non-PCI "config"
space like this host controller space and PCIe RCRBs.

Or if you add interfaces that accept read/write ops, maybe the
existing pci_find_capability() etc could be refactored on top of them
by passing in pci_bus_read_config_word() as the accessor.

Bjorn

