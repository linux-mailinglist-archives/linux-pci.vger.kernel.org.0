Return-Path: <linux-pci+bounces-34135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CDB29089
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 22:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F105A5640
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276F2F39CA;
	Sat, 16 Aug 2025 20:25:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA924468A;
	Sat, 16 Aug 2025 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755375909; cv=none; b=Pq/IbP8nsn73f5cpkEO4I/udKBnT/C0Q9doQ+oeEku+mxopg7hoJKDF5CY8njwQQ5aACQsJ0boZB7CLE6PjteG9v3kFDEr3cTxVJJx1EjXBuazZHJ+PsJOCHgGdNe4RRdDZqZYoxMgJjPq/7w+aq/Y1kFhWOw1ePmIPF0G2s/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755375909; c=relaxed/simple;
	bh=gGd1IsHKmICZGVHaYOMbFP5E2InbgsRRTy5GYybFW6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLBxH0q2DbXDFOOs2t9LwoZyGjRRB7XXhTU2gHF7d2cby8ZWSRFqM6yKSyXa3cZThKp785ZIqTphTQ2v5BQkg07NeU7YxO+QtyWOrfTWBYSodAyrgKiLRXd6jjEBwoxleCq+5RtBdRoEGh4BgzIUlLyP5Yz6NzRI+A4LHtCT2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 319F62008037;
	Sat, 16 Aug 2025 22:25:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1A2332ED3FD; Sat, 16 Aug 2025 22:25:05 +0200 (CEST)
Date: Sat, 16 Aug 2025 22:25:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans Zhang <18255117159@163.com>
Cc: mahesh@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com,
	mani@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/AER: Use pci_clear_and_set_config_dword() to
 simplify mask updates
Message-ID: <aKDpIeQgt7I9Ts8F@wunner.de>
References: <20250816161743.340684-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816161743.340684-1-18255117159@163.com>

On Sun, Aug 17, 2025 at 12:17:43AM +0800, Hans Zhang wrote:
> Replace manual read-modify-write sequences in multiple functions with
> pci_clear_and_set_config_dword() helper to reduce code duplication.

None of the occurrences you're replacing is clearing *and* setting
bits at the same time.  They all either clear or set bits, but not both.

For the PCIe Capability, there are pcie_capability_clear_dword()
and pcie_capability_set_dword() helpers.

It would arguably be clearer and less confusing to introduce similar
pci_clear_config_dword() and pci_set_config_dword() helpers and use
those, instead of using pci_clear_and_set_config_dword() and setting
one argument to 0.

Thanks,

Lukas

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d716..3d37e2b7e412 100644
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
> @@ -1102,15 +1101,12 @@ static bool find_source_device(struct pci_dev *parent,
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
> @@ -1556,23 +1552,19 @@ static irqreturn_t aer_irq(int irq, void *context)
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

