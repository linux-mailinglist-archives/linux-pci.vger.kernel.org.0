Return-Path: <linux-pci+bounces-36533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12233B8AECC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09981CC32BB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB20211A28;
	Fri, 19 Sep 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5lhDtP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8A1EF38E;
	Fri, 19 Sep 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306764; cv=none; b=Ky61wNNq3LUXONfbMBE6kIk5K93BbgpG1aaCE8QSNxLUDQeOJkeVe9mc07g8mAS/8MywW3dX+opmkqoNUk24NW6jMdnX8rG8LLkLzwEuLZgbKYKsx4PwyK0Xy+XFbbfT8pTMZl1NEsRqdtjBSBhn4i1bkX2c4C8gtI6weArpz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306764; c=relaxed/simple;
	bh=VKgiU8c9iEOAvCN7BHO0m6A30oFDWlZgDPEVP3PArSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC4c5eJERIk5LcPsjbJQ5EYJSVp4swwawx5SzPuZ9aSPaQZgFDa/XDg8u3iDHeLHsUu3qmRiUtof6XFhbEzrlx/nZ/Qzq2GLQxqboyLEK9akh3tuQVEUa2XEzufvovZbEa/5i5KI1Es+Li/HE11aQhJOmb7tNArhmXVkNx6Hz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5lhDtP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C725C4CEFA;
	Fri, 19 Sep 2025 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758306764;
	bh=VKgiU8c9iEOAvCN7BHO0m6A30oFDWlZgDPEVP3PArSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5lhDtP9xd3iTmU9NVqk1pzPriLedbqSXptHsIofMIkKODunPAhXUZkoAY3U+1sju
	 OMNQK2S2UUlR4nVaPDlBvzz5ebfaSvbxoSS0ARHUUg7VXlU95wDlZNj44DI7bZ8wNY
	 VJ84mbJLVqGyV9Yj41vRxfJlpiEg/78k6Y/gUratYiGjOiWlvN1QbeA2kmo4ZliyBu
	 wLLBlJw33uGoy7tmGSQop7Dho3C5gE+knbIEvvcIYDoCzOD7hMG132RiM+akLSyUxy
	 E4e8tcqLwvdv9w6wTcFA/o+/YP2YU9w6GDiT6LcRGDDKXtSN8Nq/6PJEvxuIToHIpt
	 FMSBheSSAeuTw==
Date: Sat, 20 Sep 2025 00:02:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	qiang.yu@oss.qualcomm.com, mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	shradha.t@samsung.com, quic_schintav@quicinc.com, inochiama@gmail.com, 
	cassel@kernel.org, kishon@kernel.org, sergio.paracuellos@gmail.com, 
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 05/10] PCI: keystone: Add ks_pcie_free_msi_irq()
 helper for cleanup
Message-ID: <rbyukvvhzoch4p54usbrjpjlhd6qknhp2er6gfxhcj5lxpgrqh@5wnwiijn2g5f>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-6-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912122356.3326888-6-s-vadapalli@ti.com>

On Fri, Sep 12, 2025 at 05:46:16PM +0530, Siddharth Vadapalli wrote:
> Introduce the helper function ks_pcie_free_msi_irq() which will undo the
> configuration performed by the ks_pcie_config_msi_irq() function. This will
> be required for implementing a future helper function to undo the
> configuration performed by the ks_pcie_host_init() function.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v1: https://lore.kernel.org/r/20250903124505.365913-6-s-vadapalli@ti.com/
> No changes since v1.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index d03e95bf7d54..81c3686688c0 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -666,6 +666,31 @@ static void ks_pcie_intx_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void ks_pcie_free_msi_irq(struct keystone_pcie *ks_pcie)
> +{
> +	struct device_node *np = ks_pcie->np;
> +	struct device_node *intc_np;
> +	int irq_count, irq, i;
> +
> +	if (!IS_ENABLED(CONFIG_PCI_MSI))

Isn't the CONFIG_PCI_KEYSTONE_HOST always depend on PCI_MSI?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

