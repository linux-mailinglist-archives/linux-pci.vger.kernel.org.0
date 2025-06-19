Return-Path: <linux-pci+bounces-30184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6AEAE0684
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85757A760B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A523C514;
	Thu, 19 Jun 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC3DBKvG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A814F9F7;
	Thu, 19 Jun 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338411; cv=none; b=JUz2DEenAed5j53k5YUOzhIZQ285XRaOyqkjRaiBt6fZ1bGT6HjlYuDtwhAuJ/a6+USSdBbAwyxr9xxzzFJEc3iuK5same/NfwvzdG+fXGJMdQz1nh/oXJFLVt6rXmVBGuwOHaWBFd0Rml3TinrAgOGtvWzDIJwMLdaVUTyaf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338411; c=relaxed/simple;
	bh=uSL9ZGnQFzGSFlQq+vqI2UlchlcemJAv0hONIYX6tDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYPTo5Hm6ALulDHdcASsaBLi9jNJvwPv6pAKI/YPTUG9RGOxH344W4OzNsbeJ1/1ty1YtV8P9vfcZJC3ajCGoJyl7XEl3rJ/44GE+8wiY3jmBx7fvSgC8WPSMtDa2MMYaou2ZS9CaQkheSoPtF8gUIkry6HyxSiUvVg04oeGvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC3DBKvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C8DC4CEEA;
	Thu, 19 Jun 2025 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750338411;
	bh=uSL9ZGnQFzGSFlQq+vqI2UlchlcemJAv0hONIYX6tDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eC3DBKvGSQXvbA5r6xWP0HiddSA/Al/8FiBeEUDpOBM6/SehKPNXwAwHlifTQLtSG
	 u+FADHBYvp/ANrX5IJzrg5hAhBdsISj3hcMIpktlGLDSIa9fkhpPQhbtSD1c2GxnoK
	 oOYNHzMl34SMsohwh5IFfJVCrUUPrBYAbJaU33YD8ElOMZXTnSZLIMFn7Mqb193j33
	 Tnwrw+Go/CaJXG8+yOv+N1dKI4Ptn4maMgZYaheu6idQ4g+C/Ldc2TLMIj/Sh4BK4e
	 RbiIORfDd/MmdL4n+sTJQOzJMg5lTjg5GB8f/uvJauseEg/DN69y9HfSVav7y4janl
	 OqJkBtU2jSxzg==
Date: Thu, 19 Jun 2025 18:36:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: mahesh@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com, 
	manivannan.sadhasivam@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Use pci_clear_and_set_config_dword() to
 simplify mask updates
Message-ID: <zna2vcwagifaszcvrjg3o6f3kdmjc4zqzc6bh4xdqpayzbpgon@rky4zbodpadz>
References: <20250607155159.805679-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250607155159.805679-1-18255117159@163.com>

On Sat, Jun 07, 2025 at 11:51:59PM +0800, Hans Zhang wrote:
> Replace manual read-modify-write sequences in multiple functions with
> pci_clear_and_set_config_dword() to ensure atomic operations and reduce
> code duplication. 
> 

No, pci_clear_and_set_config_dword() doesn't ensure atomicity. It just provides
a helper to avoid code duplication for RMW kind of operations. Nothing
guarantees the function to be atomic.

> Signed-off-by: Hans Zhang <18255117159@163.com>

But the change LGTM. With the above wording corrected,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Changes for v2:
> - The patch commit message were modified.
> - New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
> ---
>  drivers/pci/pcie/aer.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..86cbd204a73f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -176,14 +176,13 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>  static int disable_ecrc_checking(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
> -	u32 reg32;
>  
>  	if (!aer)
>  		return -ENODEV;
>  
> -	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
> -	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
> -	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_CAP,
> +				       PCI_ERR_CAP_ECRC_GENE |
> +				       PCI_ERR_CAP_ECRC_CHKE, 0);
>  
>  	return 0;
>  }
> @@ -1101,15 +1100,12 @@ static bool find_source_device(struct pci_dev *parent,
>  static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
> -	u32 mask;
>  
> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> -	mask &= ~PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
> +				       PCI_ERR_UNC_INTN, 0);
>  
> -	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> -	mask &= ~PCI_ERR_COR_INTERNAL;
> -	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
> +				       PCI_ERR_COR_INTERNAL, 0);
>  }
>  
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
> @@ -1555,23 +1551,19 @@ static irqreturn_t aer_irq(int irq, void *context)
>  static void aer_enable_irq(struct pci_dev *pdev)
>  {
>  	int aer = pdev->aer_cap;
> -	u32 reg32;
>  
>  	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
> +				       0, ROOT_PORT_INTR_ON_MESG_MASK);
>  }
>  
>  static void aer_disable_irq(struct pci_dev *pdev)
>  {
>  	int aer = pdev->aer_cap;
> -	u32 reg32;
>  
>  	/* Disable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
> +				       ROOT_PORT_INTR_ON_MESG_MASK, 0);
>  }
>  
>  /**
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

