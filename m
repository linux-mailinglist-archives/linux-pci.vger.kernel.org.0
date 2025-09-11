Return-Path: <linux-pci+bounces-35918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA522B538DB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 18:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA93A6E1E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72106313E3E;
	Thu, 11 Sep 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUZScqso"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9220ADD6;
	Thu, 11 Sep 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607223; cv=none; b=KKi8qEyDv3ChMJx2tu5sm5rmmeoHc0j7Mmtpb2RVpvTiIFRDshfSFd0HIqXOKK9P6aXJD8HUAgHUzqxvTpi4fdpHTt9avyhHrWU7SodvxkdFVPighDXUJN/2NKU4Q1xG3CeLn1i0M0kLDth7E0mkMRa57QkpIKTwjUdBjz/ZL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607223; c=relaxed/simple;
	bh=1etK93HnG/U70MtpQ4yz5j14nB+hdJHjl+ApAiWS2Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ttnffz2I+IJpBEr4r+NL7yoOZrrR2hF/bVoYzSw00mToXyeCJbZ04BM14sgarN2dBLqDCrFILDnlAAH9J/9I4RpDiHpyMmsiKkUmL1dw71Oy03nFe3WBzcTvYuvgGPwqe7OLsq2/iNdbTYgZYxvhJ+yuZ+0ItHS0q8+HBE11SgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUZScqso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D28C4CEF0;
	Thu, 11 Sep 2025 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757607222;
	bh=1etK93HnG/U70MtpQ4yz5j14nB+hdJHjl+ApAiWS2Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VUZScqsox3d0qSL/0Mbgt4MPOpU/rsy7a4hdYqTV5mgagrR4cIWgFI8I2A7KD+DvG
	 uxP/vIJi0YEQ/E9sXrvNPVt1slixvGb/BThrphuGSGscOO3qxaFx0zm9PgfeMnxdqx
	 xUfiQJM2KfldAJcV5uvbI7NwX6NKZZt2Lo2FDBWHjBjDgCfNPU6GrowJnL+x8jo0ly
	 sMsve+0diToJfCtYfYYxMLwXMD/KP3r/5ZfC/YZOM+Iwqe7n3f+s+Z5cOgy9ZSr1Pt
	 6wljjrg7PAzSJiy7eqn5K/cfNkWxZA+L3+G2do+p8FU/J1j5WUGl1qjpBcZFJRvqZ6
	 jlwvQ4kGyCOcQ==
Date: Thu, 11 Sep 2025 11:13:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH] PCI: of: Update parent unit address generation in
 of_pci_prop_intr_map()
Message-ID: <20250911161341.GA1579997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818093504.80651-1-lpieralisi@kernel.org>

On Mon, Aug 18, 2025 at 11:35:04AM +0200, Lorenzo Pieralisi wrote:
> Some interrupt controllers require an #address-cells property in their
> bindings without requiring a "reg" property to be present.
> 
> The current logic used to craft an interrupt-map property in
> of_pci_prop_intr_map() is based on reading the #address-cells
> property in the interrupt-parent and, if != 0, read the interrupt
> parent "reg" property to determine the parent unit address to be
> used to create the parent unit interrupt specifier.
> 
> First of all, it is not correct to read the "reg" property of
> the interrupt-parent with an #address-cells value taken from the
> interrupt-parent node, because the #address-cells value define the
> number of address cells required by child nodes.
> 
> More importantly, for all modern interrupt controllers, the parent
> unit address is irrelevant in HW in relation to the
> device<->interrupt-controller connection and the kernel actually
> ignores the parent unit address value when hierarchically parsing
> the interrupt-map property (ie of_irq_parse_raw()).
> 
> For the reasons above, remove the code parsing the interrupt
> parent "reg" property in of_pci_prop_intr_map() - it is not
> needed and as it is it is detrimental in that it prevents
> interrupt-map property generation on systems with an
> interrupt-controller that has no "reg" property in its
> interrupt-controller node - and leave the parent unit address
> always initialized to 0 since it is simply ignored by the kernel.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Lizhi Hou <lizhi.hou@amd.com>
> Link: https://lore.kernel.org/lkml/aJms+YT8TnpzpCY8@lpieralisi/

Applied to pci/of for v6.18, thanks, Lorenzo!

> ---
>  drivers/pci/of_property.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 506fcd507113..09b7bc335ec5 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -279,13 +279,20 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>  			mapp++;
>  			*mapp = out_irq[i].np->phandle;
>  			mapp++;
> -			if (addr_sz[i]) {
> -				ret = of_property_read_u32_array(out_irq[i].np,
> -								 "reg", mapp,
> -								 addr_sz[i]);
> -				if (ret)
> -					goto failed;
> -			}
> +
> +			/*
> +			 * A device address does not affect the
> +			 * device<->interrupt-controller HW connection for all
> +			 * modern interrupt controllers; moreover, the kernel
> +			 * (ie of_irq_parse_raw()) ignores the values in the
> +			 * parent unit address cells while parsing the interrupt-map
> +			 * property because they are irrelevant for interrupts mapping
> +			 * in modern system.
> +			 *
> +			 * Leave the parent unit address initialized to 0 - just
> +			 * take into account the #address-cells size to build
> +			 * the property properly.
> +			 */
>  			mapp += addr_sz[i];
>  			memcpy(mapp, out_irq[i].args,
>  			       out_irq[i].args_count * sizeof(u32));
> -- 
> 2.48.0
> 

