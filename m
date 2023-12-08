Return-Path: <linux-pci+bounces-691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681180A9C3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32514280993
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1B35285;
	Fri,  8 Dec 2023 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOCmgHjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FC341BA;
	Fri,  8 Dec 2023 16:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4EDC433C8;
	Fri,  8 Dec 2023 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702054241;
	bh=wlUXwlsUbGMtEcjVD5Tfu+HjZX3PCSQZUuI9/7Iqr1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BOCmgHjq9geZadOhgdjEmm/gLlEoc7P8m9wwz3PAXNl9ACl2u+7Msp41vwIdzW/Nv
	 Mp6bOHVRDwVUScivRBMmlqKtLxsgkodvUR7cfXuKgspRMz++vreENJjgqU15gGaEVa
	 TKcjvej3ywn56kfq4LrzQj+LF3/bDdO01eoyqWvPK1V41Cb8L29EPOpKqMtx4mVi/2
	 v1hWbPq7+8ztBoS70I8XQlBL7DG1QTbhXfTFd73MY4ZL4RTsFCrnyAXBYvRWlm2Y7D
	 e87GXnpOAEdOreASny4i5cq9BillFMiY8J/ZYPpufp8Rsb1pO1R7LYM8PF/QSv82WP
	 DKIRZ4R4bEzlw==
Date: Fri, 8 Dec 2023 10:50:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <20231208165039.GA796094@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201115028.84351-1-jiaxun.yang@flygoat.com>

On Fri, Dec 01, 2023 at 11:50:28AM +0000, Jiaxun Yang wrote:
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
> 
> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.
> 
> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
> 
> It must be done at device enablement stage because MRRS setting
> may get lost if the parent bridge lost PCI_COMMAND_MASTER, and
> we are only sure parent bridge is enabled at this point.
> 
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to for-linus for v6.7, thanks!

> ---
> v4: Improve commit message
> v5:
> 	- Improve commit message and comments.
> 	- Style fix from Huacai's off-list input.
> v6: Fix a typo
> ---
>  drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index d45e7b8dc530..e181d99decf1 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -80,13 +80,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, system_bus_quirk);
>  
> +/*
> + * Some Loongson PCIe ports have h/w limitations of maximum read
> + * request size. They can't handle anything larger than this.
> + * Sane firmware will set proper MRRS at boot, so we only need
> + * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
> + * won't set MRRS properly, and we have to enforce maximum safe
> + * MRRS, which is 256 bytes.
> + */
> +#ifdef CONFIG_MIPS
> +static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = pdev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(pdev) > 256) {
> +				pci_info(pdev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(pdev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_quirk);
> +#endif
> +
>  static void loongson_mrrs_quirk(struct pci_dev *pdev)
>  {
> -	/*
> -	 * Some Loongson PCIe ports have h/w limitations of maximum read
> -	 * request size. They can't handle anything larger than this. So
> -	 * force this limit on any devices attached under these ports.
> -	 */
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
>  
>  	bridge->no_inc_mrrs = 1;
> -- 
> 2.34.1
> 

