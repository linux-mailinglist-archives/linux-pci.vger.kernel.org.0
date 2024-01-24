Return-Path: <linux-pci+bounces-2526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAC83AD8F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0021F23703
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB67C09A;
	Wed, 24 Jan 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yly5wDB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3207A73A;
	Wed, 24 Jan 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110848; cv=none; b=RQ3qmGgsjSNPv1VwzPTFw4guYxHhssITUkfxsmHG8aJx+wrUarDzrLbzf6SHzdI96zN9jeqUYM6KY9fKRiRKF1byP0wP4OVLoLlgM2hzjR2nHWdpfW7BsfIrpng17AB9GRIJ3hjE8wVcCUbUN5taaraHSYbWBCMpxcHQpBWYLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110848; c=relaxed/simple;
	bh=VqpleTLhuvFRc9potlgECTlRx8Wy9YNqUOuKN2i6GvY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gf7MbY4+MngVI6pJPkQjYlp008pdlVoZ+4Y/RP/Sn8XldmwfMDDkE0ZfaRWcyBYo7VRYMZppMJ+gefpp4IEZtgb3derSWyTCrNa11uVA5SG/1gFLHw0nSsa4EpDbqxsjlvM1I9FjZA1qwnCOdM0j1B7Hm5BVyscu4NOIjq8kb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yly5wDB0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706110847; x=1737646847;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VqpleTLhuvFRc9potlgECTlRx8Wy9YNqUOuKN2i6GvY=;
  b=Yly5wDB0WzjrzJMvoosBt2qx5Qn9Y/rrb7ya2dJVzRnzL9LFZ4yjzUO4
   uyfVECsfRG3o2XSFdOhWOAaX/rcciYOsxzJc6Gkc4hxzmfQBX6lgzwWLi
   d4FC4DsOSg3PZjaX0/Iv3ZdqxCCSvXQaDIA97yhKMrjxAjNH7QnJCJMsy
   8DYid0eHCMhiLItnyrVHu3XDPMoLv57zVLY0i8hkGJ4uv+swrKzg+hC5h
   MqLScX+Yvmr1h2vP6L7a0cmNBgs3FV1wuQe9RiQUbiGk/Por/0qBYQ2FN
   1NK9nxXGnV9Wprsc0VNOl+BO+BpkusIzWL6psp+ZN/nGqszfy9/5s5+u2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8985204"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8985204"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1938318"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 07:40:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 17:40:39 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Niklas Cassel <niklas.cassel@wdc.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
In-Reply-To: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
Message-ID: <98ad8aad-ba7c-7689-3286-bc1f4afec943@linux.intel.com>
References: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Jan 2024, Dan Carpenter wrote:

> The "msg_addr" variable is u64.  However, the "aligned_offset" is an
> unsigned int.  This means that when the code does:
> 
>         msg_addr &= ~aligned_offset;
> 
> it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN()
> to do the alignment instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> v4: Add stable and r-b from Niklas
> v3: Use ALIGN_DOWN()
> v2: fix typo in commit message
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..51679c6702cf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -551,7 +551,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  
>  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr &= ~aligned_offset;
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)

Hi Dan,

You should also add the include for it:

#include <linux/align.h>


-- 
 i.


