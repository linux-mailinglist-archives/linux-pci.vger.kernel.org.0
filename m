Return-Path: <linux-pci+bounces-37435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA00BB42D7
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7662732718E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8285312805;
	Thu,  2 Oct 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxYLLKgp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3F3126A2;
	Thu,  2 Oct 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415790; cv=none; b=ATZP7cXj/+LmMYTAXjz1N4wyNv3GywK27RvXwgGo5bialVobbPG3PcvwfkAaLUKrIV03Xg15+WYSOuZu6MXZY+33336N1bo+1bLVGUosZD6uW+J4IT/zHRloT2uYpi8csfIXUTfD5e75BoyxRwsn4xR+o6kkbZ3/J1kxx5RT1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415790; c=relaxed/simple;
	bh=B3aUqt3yFL4cHWEvV1ArHNkFI5dahy1JTP0dauqet8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KFEdqClkfVn0SO7ip1jA2sIrYcq5XnOxRP+/Pxw7d8aM+6aZ9lrFv5yg+/lLw8lA20PoqjH4okCp6SMoCoZiQSfAhIRRdvsmYZR6E4KuHFgL8jk9w6QX1B4Da2DUZ/yKtj688m7JR3C1aGv0c/JtRyxazzONcv1HVwc9k1WJgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxYLLKgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1FEC4CEF4;
	Thu,  2 Oct 2025 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759415790;
	bh=B3aUqt3yFL4cHWEvV1ArHNkFI5dahy1JTP0dauqet8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZxYLLKgpgek07MIpQs+oWR3QIZ/0+t6zS5HO7VL5SSUaky6Wqsoy6MYs0UJlG0qd/
	 KfSfck/b9VZhYxoHARfeiJ+XfMQTaYHgb74w/SjBgKEONHvWDJyXoG/HlaU8ztW1HT
	 OpAeKa+4TFTNbgdoI7bOuqRySqL281bRPtXbJEtTbgFrdsclVZPv2Li0I0xuBdvGiR
	 uE4AETG1j+75R7mXo0YFDE86MIpMhnAXETIE4NNkBbWPq7rvl0kKT/LCvYq/v7GEb9
	 7UrFoYgh4imcXqLY94kp07jKJoHvOzRQhqlc9CKvqEDfrRys5UxJtBN0TEppGL8WqJ
	 GyHfKVXCLxj2A==
Date: Thu, 2 Oct 2025 09:36:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, cassel@kernel.org,
	kishon@kernel.org, sergio.paracuellos@gmail.com,
	18255117159@163.com, jirislaby@kernel.org, m-karicheri2@ti.com,
	santosh.shilimkar@ti.com, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH 2/2] PCI: keystone: Remove the __init macro for the
 ks_pcie_host_init() callback
Message-ID: <20251002143627.GA267439@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912100802.3136121-3-s-vadapalli@ti.com>

On Fri, Sep 12, 2025 at 03:37:59PM +0530, Siddharth Vadapalli wrote:
> The ks_pcie_host_init() callback registered by the driver is invoked by
> dw_pcie_host_init(). Since the driver probe is not guaranteed to finish
> before the kernel initialization phase, the memory associated with
> ks_pcie_host_init() may already be freed by free_initmem().
> 
> It is observed in practice that the print associated with free_initmem()
> which is:
> 	"Freeing unused kernel memory: ..."
> is displayed before the driver is probed, following which an exception is
> triggered when ks_pcie_host_init() is invoked which looks like:
> 
> 	Unable to handle kernel paging request at virtual address ...
> 	Mem abort info:
> 	...
> 	pc : ks_pcie_host_init+0x0/0x540
> 	lr : dw_pcie_host_init+0x170/0x498
> 	...
> 	ks_pcie_host_init+0x0/0x540 (P)
> 	ks_pcie_probe+0x728/0x84c
> 	platform_probe+0x5c/0x98
> 	really_probe+0xbc/0x29c
> 	__driver_probe_device+0x78/0x12c
> 	driver_probe_device+0xd8/0x15c
> 	...
> 
> Fix this by removing the "__init" macro associated with the
> ks_pcie_host_init() callback and the ks_pcie_init_id() function that it
> internally invokes.
> 
> Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

I dropped this from pci/controller/keystone because of the resulting
section mismatch:

  https://lore.kernel.org/r/202510010726.GPljD7FR-lkp@intel.com

ks_pcie_host_init() calls hook_fault_code(), which is __init, so we
can't make ks_pcie_host_init() non-__init.

Both are bad problems, but there's no point in just swapping one
problem for a different one.

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 21808a9e5158..c6e082dcb3bc 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -799,7 +799,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
>  }
>  #endif
>  
> -static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
> +static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
>  {
>  	int ret;
>  	unsigned int id;
> @@ -831,7 +831,7 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
>  	return 0;
>  }
>  
> -static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
> +static int ks_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> -- 
> 2.43.0
> 

