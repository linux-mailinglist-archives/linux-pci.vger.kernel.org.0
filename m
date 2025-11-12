Return-Path: <linux-pci+bounces-41010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57EFC53B8F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5914A7B07
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0021346E5E;
	Wed, 12 Nov 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2e9xUty"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9012D1F1;
	Wed, 12 Nov 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968447; cv=none; b=BGuAS/cBE7j4h3nWNPv6qohgrWiwgb+Pr2EGAjJgVh5nznmrjonH5IYNqI8R5tzIx36X+hDSKrHOqp0d8UJQca8IFe8eZ9gWC1F7itr89FNCrDB6IQm+7svVov8MOMV/IiDlVKLp+ciuFzWrkF2nR/2GRHcca8FAv1TNU78V3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968447; c=relaxed/simple;
	bh=7qJu6hxk6QNjW6m7PnkDRSFXCijC1JmS6gfHLufAYyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diyxIhCCU3iVSrqUz/u/KYJU3Rf0TDF+xpXSEMAqtuVE89HTL1XnCyNiJn50Wsd68pPsFtTyVPL40y/6b004ZjJ/fbIO/4zRTITDb/QUCTgacESGiMXJFOciKTqqLPeP5bG+46sAoJnVB6YRaMp/EYQwv8me9B/S9z9k+yqw850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2e9xUty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD1C19424;
	Wed, 12 Nov 2025 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968447;
	bh=7qJu6hxk6QNjW6m7PnkDRSFXCijC1JmS6gfHLufAYyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2e9xUty5WyHXfj+KhPSJEF8UeixC7K4OO+ydfOeq0s6rVjC/o2M7+WvW2sv00byK
	 ghoXIaNf8XRhCXwVEObGQvM/+TurALvw3OW2q4s9QEjCmlxpyh1BRMku30qd4JFUE7
	 3X87kf67iXbG8osZYowne/siQAz+U9YmDANEkGH6o9mYgjAIdicAIZk3xwmajCMIAy
	 Z934/pxNKmfJwZe/sgA1NGkAtI1iKk8MBmV55UxLZFwFg2SP9cvyHg6lS6S5YERRHb
	 2RP5IaPbA0EWpn1fwhdDXC6hGLRQoVfKGwGUjGW7oRR3UvxcFpS6ezyIrOCj0idbvV
	 pDFNEZ9Fr4nQA==
Date: Wed, 12 Nov 2025 22:57:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	mad skateman <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>, 
	Darren Stevens <darren@stevens-zone.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>, 
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au, 
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/4] PCI/ASPM: Add pcie_aspm_remove_cap() to override
 advertised link states
Message-ID: <xkrehb72sk7x5iyxbkvydu356hgo5t2xr3asnwiddvhtz5eqam@jlzd6gwg256n>
References: <20251110222929.2140564-1-helgaas@kernel.org>
 <20251110222929.2140564-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110222929.2140564-3-helgaas@kernel.org>

On Mon, Nov 10, 2025 at 04:22:26PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add pcie_aspm_remove_cap().  A quirk can use this to prevent use of ASPM
> L0s or L1 link states, even if the device advertised support for them.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h       |  2 ++
>  drivers/pci/pcie/aspm.c | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b..36f8c0985430 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -958,6 +958,7 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  
>  #ifdef CONFIG_PCIEASPM
> +void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap);
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
> @@ -965,6 +966,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  void pci_configure_ltr(struct pci_dev *pdev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
>  #else
> +static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 15d50c089070..bc3cb8bc7018 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1542,6 +1542,19 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_enable_link_state_locked);
>  
> +void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap)
> +{
> +	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
> +		pdev->aspm_l0s_support = 0;
> +	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
> +		pdev->aspm_l1_support = 0;
> +
> +	pci_info(pdev, "ASPM:%s%s removed from Link Capabilities to avoid device defect\n",
> +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L0S ? " L0s" : "",
> +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L1 ? " L1" : "");

I think this gives a false impression that the ASPM CAPs are being removed from
the LnkCap register. This function is just removing it from the internal cache
and the LnkCap register is left unchanged.

IMO, either we need to disable relevant CAPs in LnkCap register also or change
the log in this and quirks patches.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

