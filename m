Return-Path: <linux-pci+bounces-44156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269CCFCD9F
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA77530C80E7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94812FD7BE;
	Wed,  7 Jan 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6i7g2fH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F82FBDF2;
	Wed,  7 Jan 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777713; cv=none; b=R+gj1nyfuFh4x3yAnggQJmaAp6QI6G2XAso7KZ93a8iKop2I0/IhCp3Awipn1f4H5Ua1iWhz852WB4hcnjegiJnrHmBl3LFht+26lLOkRNKxbfMR9MAPzpcHwQliXtNSgye8z0GmJeFcU4f9wvlVPIr9U2Ah90/8Vx5y8+zzy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777713; c=relaxed/simple;
	bh=8DINCbuJQD5wwJWcbQ2qfTOQo9DyNZ/cR+d1iKICHx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRSGoT4fZY1qPLxPeO8L2OyRk+hSH6MOVDo6+j2GfCsTi7M2NZVXcx2CFFM/FHz9SgLGs/BRvEWn1RvGmYhiEg4VWNjjUaDbwvcyUaZAr9cTYfvMQl4eyy22aX4HZroYdMRWUCzouTEl2UN8XHyu+ATaM8aDYg5WaGwfRiFB1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6i7g2fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B99C4CEF7;
	Wed,  7 Jan 2026 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767777713;
	bh=8DINCbuJQD5wwJWcbQ2qfTOQo9DyNZ/cR+d1iKICHx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6i7g2fHcAv2ATBTCSv0FqR2vlQ505Lrja7YsyJy3Uog16uBI9cthAmju+OuOCB0b
	 8cCziRMahyuh9dHODb37OVBmEKOJSevUWrbP1+SvOz/kT/xZ/YOeBQ7CDrT2j4Lo9a
	 tqLWrUl7ejmvLweAqkIp/NbxrlLGw/WbWy2mG+sFTFYkPaQumBC98H21+6acbKwYGK
	 e3Sa8YQzzjaBFYMDZM/OiVFB58DbmnjsBsMHuekNiYh2VEwTg909mVyvt0BIwDu9tQ
	 2v9AV4p7GFWQKxsQOqJBu/EIDFX+gluLrHM7nXW6nj0FlzsDXNfAqw3Di08OHyVrVi
	 4dLreSbP3bK8w==
Date: Wed, 7 Jan 2026 14:51:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <65j2ah57lotdhzocczw4jq5zsc2w37aj6wskv6zfptpsi6kpmk@qz7oiiovzjgb>
References: <20260107081445.1100-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107081445.1100-1-atharvatiwarilinuxdev@gmail.com>

On Wed, Jan 07, 2026 at 08:14:35AM +0000, Atharva Tiwari wrote:
> Changes since v1:
> 	Transferred logic to drivers/pci/quicks.c
> 
> Disable AER for Intel Titan Ridge 4C 2018
> (used in T2 iMacs, where the warnings appear)
> that generate continuous pcieport warnings. such as:
> 
> pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
> pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
> pcieport 0000:07:00.0:    [ 7] BadDLLP
> 
> (see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)
> 
> macOS also disables AER for Thunderbolt devices and controllers in their drivers.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Discussion in v1 of this patch is not yet concluded and you have sent v2. This
is not going to help merge this patch.

Since you don't know why AER is happening, you should wait for a response from
the Intel/Thunderbolt folks who know more about the hardware.

- Mani

> ---
>  drivers/pci/pcie/aer.c     | 3 +++
>  drivers/pci/pcie/portdrv.c | 2 +-
>  drivers/pci/quirks.c       | 9 +++++++++
>  include/linux/pci.h        | 1 +
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..45604564ce6f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -389,6 +389,9 @@ void pci_aer_init(struct pci_dev *dev)
>  {
>  	int n;
>  
> +	if (dev->no_aer)
> +		return;
> +
>  	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>  	if (!dev->aer_cap)
>  		return;
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 38a41ccf79b9..ab904a224296 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -240,7 +240,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>  	    dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer))
> +	    (pcie_ports_native || host->native_aer) && !dev->no_aer)
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..d36dd3f8bbf6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6340,4 +6340,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
> +
> +static void pci_disable_aer(struct pci_dev *pdev)
> +{
> +	pdev->no_aer = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EA, pci_disable_aer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EB, pci_disable_aer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EC, pci_disable_aer);
> +
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..f447f86c6bdf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -440,6 +440,7 @@ struct pci_dev {
>  	unsigned int	multifunction:1;	/* Multi-function device */
>  
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
> +	unsigned int	no_aer:1;		/* May not use AER */
>  	unsigned int	no_msi:1;		/* May not use MSI */
>  	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
>  	unsigned int	block_cfg_access:1;	/* Config space access blocked */
> -- 
> 2.43.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

