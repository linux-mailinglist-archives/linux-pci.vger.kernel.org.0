Return-Path: <linux-pci+bounces-33498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B2B1CF4F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 01:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C267A1CC0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CA263F49;
	Wed,  6 Aug 2025 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXSdvPd9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEF223301;
	Wed,  6 Aug 2025 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522296; cv=none; b=o2Geu78Fe1qki5yss+71FEG64KP3mqHTz6wLCY5QfNfWGXENmf8UA5LtiFIgpMrvm3SSWL2p8DIs4rYAqERPevblTcwllJX7GU1rreFKK1c+b2INg0J0FCa7ptRRqLpNcZBnfZOK9frK/NEVMSCi1ukMd7T4UZ3V0BMwzpiYWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522296; c=relaxed/simple;
	bh=LSjLsRiIKAeVQBEup9B6gwCf8DTsf9NA+YYnAYB1K1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jy0wRdYsQCP+l17RrRRd86Ue5ke5ZSL+IfhXzKCGt3x0vTevDbFNcCOzEYRpxHIejty298NNx3APKBKlBCVpAcMHJhc0/XVqUaf2cZUGws52C90woj9XVx4e/y1dE/M70fGdw95SwhkiZEyXisAloY13eWpw6OuyhAfOmOMcDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXSdvPd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FC9C4CEE7;
	Wed,  6 Aug 2025 23:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754522296;
	bh=LSjLsRiIKAeVQBEup9B6gwCf8DTsf9NA+YYnAYB1K1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nXSdvPd9dAgpQdwdaOYDfbfUTBc0ohbdt/L/68ow51GTXBDFETZCDPx8ixYRDu+mk
	 koD0aj9kF1NPMqllZDUPK4DUhCoCJqB5yPyp+EuT4bQldEScIw6hdXsXpkQrA0pVqi
	 VQ1rBB+zFxCseF0FvHwDylDYOqhsnjEw3rp28n+lYs5DJ8wmoVbXG9tM24aeYrR83v
	 Znac1VvpoqR9em15oDzZWepj1nS8essVM3QQ8JthRxHaqKj3Mr6CA8S86nMyMaj0Fm
	 mZf9m0nJVEzBeihH+L2q286xSiMFP8P7AJLBb9UVN+BGrvpqMl3L4haxAfKbd3IQNj
	 DiYyvyvzJUaGw==
Date: Wed, 6 Aug 2025 18:18:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <20250806231814.GA25892@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610114802.7460-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jun 10, 2025 at 02:48:02PM +0300, Ilpo Järvinen wrote:
> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel). While those can be configured to the recommended values by FW,
> kernel may decide to overwrite the initial values.
> 
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port
> is bifurcated to x2. Use the host bridge's enable_device hook to
> overwrite MRRS if it's set to >128B for the device to be enabled.
> 
> The earlier attempts to implement this quirk polluted PCI core code
> with the checks necessary to support this quirk. Using the
> enable_device hook keeps the quirk well-contained, away from the PCI
> core code.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/enumeration for v6.18, thanks.

> ---
> 
> Ingo gave his Ack on v2 but since the used approach has once again
> changed, I didn't add his Ack.
> 
> Mani did express his concern on using enable_device hook but suggested
> I send the patch anyway.

Yeah, I kind of agree, and there's also nothing that enforces
ownership of the .enable_device() pointer.  But it feels like it might
be overengineering to deal with all that.

> We're also looking into using _HPX Type 3 (suggested by Bjorn) eventually
> for this class of problems where FW settings get overwritten by the
> kernel (but it will take time to make it the sanctioned solution). In
> the meantime, this is a real problem for Xeon 6 out there so it warrants
> adding the quirk (which is now pretty well-contained).
> 
> v3:
> - Use enable_device hook to overwrite MRRS to 128B if needed. (Lukas)
> - Typo fix to comment (Ingo)
> 
> v2:
> - Explain in changelog why FW cannot solve this on its own
> - Moved the quirk under arch/x86/pci/
> - Don't NULL check value from pci_find_host_bridge()
> - Added comment above the quirk about the performance degradation
> - Removed all setup chain 128B quirk overrides expect for MRRS write
>   itself (assumes a sane initial value is set by FW)
> 
> 
>  arch/x86/pci/fixup.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index e7e71490bd25..38369124de45 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -294,6 +294,46 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_r
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk);
>  
> +/*
> + * PCIe devices underneath Xeon6 PCIe Root Port bifurcated to 2x have slower
> + * performance with Extended Tags and MRRS > 128B. Work around the performance
> + * problems by disabling Extended Tags and limiting MRRS to 128B.
> + *
> + * https://cdrdv2.intel.com/v1/dl/getContent/837176
> + */
> +static int limit_mrrs_to_128(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	int readrq = pcie_get_readrq(pdev);
> +
> +	if (readrq > 128)
> +		pcie_set_readrq(pdev, 128);
> +
> +	return 0;
> +}
> +
> +static void quirk_pcie2x_no_tags_no_mrrs(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> +	u32 linkcap;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &linkcap);
> +	if (FIELD_GET(PCI_EXP_LNKCAP_MLW, linkcap) != 0x2)
> +		return;
> +
> +	bridge->no_ext_tags = 1;
> +	bridge->enable_device = limit_mrrs_to_128;
> +	pci_info(pdev, "Disabling Extended Tags and limiting MRRS to 128B (performance reasons due to 2x PCIe link)\n");
> +}
> +
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db0, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db1, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db2, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db3, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db6, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db7, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db8, quirk_pcie2x_no_tags_no_mrrs);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0db9, quirk_pcie2x_no_tags_no_mrrs);
> +
>  /*
>   * Fixup to mark boot BIOS video selected by BIOS before it changes
>   *
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.39.5
> 

