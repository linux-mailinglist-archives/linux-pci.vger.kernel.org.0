Return-Path: <linux-pci+bounces-43733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40918CDF00B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 21:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FFD53005EAF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CDA26CE23;
	Fri, 26 Dec 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1+QxfaB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1732459CF;
	Fri, 26 Dec 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766782360; cv=none; b=IfTmEGOVkS0O7g4bxIUWMXgYnoJHTCICVcfUbh7cquZFECrX6Ss556UVH3mXBB9+5fLOj72TsXzGYj5Zo+bAplfFdqGG0dPHlrtX6VywjBwN7GLrCWciLUegZTuD+11zFeU4pA6yfF6QzSoR6GDLiugPDMkwOV2aqoPiDkxcs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766782360; c=relaxed/simple;
	bh=YxABnqo3hh3/es1J4ZMGy6A40pwY9UEC/V+8ahfvacw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IJpRK3maDIv6zugxIVCjMoxjfAcQCb7YJfzmmrKHtqbILqA0BF7rj4oIXE64UdJb5MQvGsLvPzfZUcMDQitJgKgZ4SgWTPr1QaT+bRimTrFfWqiGa7vvQoqqqye2358otqtXvpIMsAPDcaYPyoObvKpgjyT67eexGPZNudKoYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1+QxfaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0BFC4CEF7;
	Fri, 26 Dec 2025 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766782360;
	bh=YxABnqo3hh3/es1J4ZMGy6A40pwY9UEC/V+8ahfvacw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X1+QxfaBlThdx4EHW5+/hlrj2vYuwtbrLvg3cYSV2+TbnZ7CkYQrU4V7saKN+ZnfD
	 3xXYDhRSnU0bdvVxW7UOrBybG62y68fH477fYiFmMPPLKpUfDvoVoJcOMKXINLXPWh
	 Y9JJ4hmEQn5VPVn/QDfXtvw/lLjzcYBdrT2QK6ctIekFwEC/sZgCWX+scKrzMhneFY
	 iBGV/txZf1rLtnA40keCYB2srfDiBfkqz0rE7HDehJOM/8gJrLVrAaQW1NgJvBo2Dq
	 73aokMv6mcxnLdMgWwRlxOWd2xmxqojO+PXFPsWwTBoRaVXBvHTZIJYHwdmBYvCX8H
	 Tg6/o11DQPpTQ==
Date: Fri, 26 Dec 2025 14:52:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, macro@orcam.me.uk
Subject: Re: [PATCH 2/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Message-ID: <20251226205239.GA4138276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-ecam_io_fix-v1-2-5cc3d3769c18@oss.qualcomm.com>

On Wed, Dec 03, 2025 at 11:50:15AM +0530, Krishna Chaitanya Chundru wrote:
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access

Thanks for fixing this bug.

> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
> when ECAM is enabled.
> 
> Rename msg_atu_index to ob_atu_index to track the next available outbound
> iATU index for ECAM and MSG TLP windows. Furthermore, an error check is
> added in dw_pcie_prog_outbound_atu() to avoid programming beyond
> num_ob_windows.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  3 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 4fb6331fbc2b322c1a1b6a8e4fe08f92e170da19..22c6ec7bff8840d935803f0b96749413b1c3f905 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -433,7 +433,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
>  	 * remaining buses need type 1 iATU configuration.

Tangent: I think this comment should say "Immediate bus under Root
Port needs type 0" or "Root bus needs type 0".

>  	 */
> -	atu.index = 0;
> +	atu.index = pp->ob_atu_index;

Previously we used entries 0 and 1 for config space accesses; now we
program the entries for bridge->windows first and use later entries for
config space.  But the implicit reservation of entry 0 persists below.

>  	atu.type = PCIE_ATU_TYPE_CFG0;
>  	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
>  	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
> @@ -443,6 +443,8 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	pp->ob_atu_index++;
> +
>  	bus_range_max = resource_size(bus->res);
>  
>  	if (bus_range_max < 2)
> @@ -455,7 +457,11 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
>  	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
>  
> -	return dw_pcie_prog_outbound_atu(pci, &atu);
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (!ret)
> +		pp->ob_atu_index++;
> +
> +	return ret;

This would be better like this to match the type 0 case:

    ret = dw_pcie_prog_outbound_atu(pci, &atu);
    if (ret)
        return ret;

    pp->ob_atu_index++;
    return 0;

>  }
>  
>  static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
> @@ -630,14 +636,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_free_msi;
>  
> -	if (pp->ecam_enabled) {
> -		ret = dw_pcie_config_ecam_iatu(pp);
> -		if (ret) {
> -			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
> -			goto err_free_msi;
> -		}
> -	}
> -
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -942,7 +940,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

Earlier in dw_pcie_iatu_setup(), we have this:

    i = 0;
    resource_list_for_each_entry(entry, &pp->bridge->windows) {
        if (pci->num_ob_windows <= ++i)
            break;

        atu.index = i;
        dw_pcie_prog_outbound_atu(pci, &atu);

I think this starts at 1 because of the implicit reservation of entry
0 for config access, so now I think entry 0 is never used.

Since dw_pcie_prog_outbound_atu() now checks against
pci->num_ob_windows, I don't think we should also do it here.

The use of preincrement also makes this harder to read than it should
be.  You could do something like this:

    i = 0;
    resource_list_for_each_entry(entry, &pp->bridge->windows) {
        atu.index = i++;   # i++ better matches inbound ATU setup
        ret = dw_pcie_prog_outbound_atu(pci, &atu);
        if (ret)
            return ret;
        pci->ob_atu_index = i;
    }

>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  
> -	pp->msg_atu_index = ++i;
> +	pp->ob_atu_index = ++i;
>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> @@ -1084,14 +1082,23 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means
>  	 * the platform uses its own address translation component rather than
> -	 * ATU, so we should not program the ATU here.
> +	 * ATU, so we should not program the ATU here. If ECAM is enabled, config
> +	 * space access goes through ATU, so setup ATU here.

Wrap comment to fit in 80 columns.

s/setup ATU/set up ATU/

>  	 */
> -	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> +	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
>  		ret = dw_pcie_iatu_setup(pp);
>  		if (ret)
>  			return ret;
>  	}
>  
> +	if (pp->ecam_enabled) {
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
> +			return ret;
> +		}
> +	}
> +
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
>  
>  	/* Program correct class for RC */
> @@ -1113,7 +1120,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  	void __iomem *mem;
>  	int ret;
>  
> -	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> +	if (pci->num_ob_windows <= pci->pp.ob_atu_index)
>  		return -ENOSPC;

You added basically the same check in dw_pcie_prog_outbound_atu(), so
I don't think this check is needed, is it?

>  	if (!pci->pp.msg_res)
> @@ -1123,7 +1130,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  	atu.routing = PCIE_MSG_TYPE_R_BC;
>  	atu.type = PCIE_ATU_TYPE_MSG;
>  	atu.size = resource_size(pci->pp.msg_res);
> -	atu.index = pci->pp.msg_atu_index;
> +	atu.index = pci->pp.ob_atu_index;
>  
>  	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;

It worries me a bit that we don't log any messages when this function
fails.  If it ever does fail, whether we failed to allocate pp.msg_res
or there are no available ATU entries, it looks like suspend might
silently fail with no clue in the logs, which sounds like a hassle to
debug.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f69cbf065e61a0392bf1e5e32cf56e..f9f3c2f3532e0d0e9f8e4f42d8c5c9db68d55272 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -476,6 +476,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>  
> +	if (atu->index > pci->num_ob_windows)
> +		return -ENOSPC;
> +
>  	limit_addr = parent_bus_addr + atu->size - 1;
>  
>  	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ecd10130d3be3358827f801811387f..69d0bd8b3c57353763f98999e5d39527861fe1a7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -423,8 +423,8 @@ struct dw_pcie_rp {
>  	struct pci_host_bridge  *bridge;
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> +	int			ob_atu_index;

The number of outbound ATU entries (num_ob_windows) is apparently a
Root Complex property, not a Root Port property, so it's in struct
dw_pcie.  If ob_atu_index tracks how many of those entries are in use,
I think it should be in struct dw_pci too instead of being in struct
dw_pcie_rp.

>  	bool			use_atu_msg;
> -	int			msg_atu_index;
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
>  	struct pci_eq_presets	presets;
> 
> -- 
> 2.34.1
> 

