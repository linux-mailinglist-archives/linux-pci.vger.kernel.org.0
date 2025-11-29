Return-Path: <linux-pci+bounces-42280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4279C936E9
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 03:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 452654E0794
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13D9463;
	Sat, 29 Nov 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixs0BTDN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806CA79CF;
	Sat, 29 Nov 2025 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764384386; cv=none; b=H8LONDTkC89yUhO6y8MYtHvhakLrAOkmeL5dVxZmjOOwDSm5O3Ns0UJIrPN7p1tGZKA2ApLxCFRRlKMK4ehq9kKdiQzNjFeQ5v3NfS+Os4YbdUVGialfqaDd4CNlwYFBnSpeWGr6WbfEGcGvueAura1jFT3Y3ewqfmY/oa+r7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764384386; c=relaxed/simple;
	bh=8M3yX65ypMdiMxR/qKNl+diy5p+taSLqXZ3DZap8wlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olBtIwF7YAHW/aUV6FhmmPmgd0XIYhszex7rfxdQzsfNLaDHgU2XJee2548Z+91WxWBU9wgmafL1t7MTNz+2//W+YGNQ4YbfXq+dpW6n+DRCsDdcbCde5YICD4tWIVe+hfBjOyHYzKX0LeKUGPE4yu3V3oa4zZyZ7AzKO1QApQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixs0BTDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFCAC4CEF1;
	Sat, 29 Nov 2025 02:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764384386;
	bh=8M3yX65ypMdiMxR/qKNl+diy5p+taSLqXZ3DZap8wlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixs0BTDNnQoMs4wasQT1k2w3pVRZNP7mCWJC4A7dVoAS84f8d5E5DBCEogUg7Twf3
	 IeEF+7chsMhG0GGg58PGJetAJTFpRMmy7dR/YcM1KYQqxHaw7Eaaph/DqnGc+GDtCq
	 Lw6nWGKw/lMBNqpfGX4yOd6xkWRWq32Kd/orDQ92dKQjmpRf3VfZdm8yIp/7o3aLiO
	 feZiUUNaBmyS/0/c22/fv7bH+1JTOHgPuS+aQ21Ha2pBAm09WOrj+uPQfQdJPxWQM7
	 2bMa53D8ximYFvIcjBPDrLPL8WwJNERTBcWAVgKugeCfkXQ9BOv7RBSWEYr/wEbDa5
	 jgROW+sYs1fOQ==
Date: Sat, 29 Nov 2025 08:16:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Make Link Up IRQ logic handle already powered
 on PCIe switches
Message-ID: <x6nhj6maseucclrhvpyiknxqqxaobgvfuaaljohbl3hnkiwayi@elgihi5dqc5y>
References: <20251127134318.3655052-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127134318.3655052-2-cassel@kernel.org>

On Thu, Nov 27, 2025 at 02:43:18PM +0100, Niklas Cassel wrote:
> The DWC glue drivers always call pci_host_probe() during probe(), which
> will allocate upstream bridge resources and enumerate the bus.
> 
> For controllers without Link Up IRQ support, pci_host_probe() is called
> after dw_pcie_wait_for_link(), which will also wait the time required by
> the PCIe specification before performing PCI Configuration Space reads.
> 
> For controllers with Link Up IRQ support, the pci_host_probe() call (which
> will perform PCI Configuration Space reads) is done without any of the
> delays mandated by the PCIe specification.
> 
> For controllers with Link Up IRQ support, since the pci_host_probe() call
> is done without any delay (link training might still be ongoing), it is
> very unlikely that this scan will find any devices. Once the Link Up IRQ
> triggers, the Link Up IRQ handler will call pci_rescan_bus().
> 
> This works fine for PCIe endpoints connected to the Root Port, since they
> don't extend the bus. However, if the pci_rescan_bus() call detects a PCIe
> switch, then there will be a problem when the downstream busses starts
> showing up, because the PCIe controller is not hotplug capable, so we are
> not allowed to extend the subordinate bus number after the initial scan,
> resulting in error messages such as:
> 
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> While we would like to set the is_hotplug_bridge flag
> (quirk_hotplug_bridge()), many embedded SoCs that use the DWC controller
> have synthesized the controller without hot-plug support.
> Thus, the Link Up IRQ logic is only mimicking hot-plug functionality, i.e.
> it is not compliant with the PCI Hot-Plug Specification, so we cannot make
> use of the is_hotplug_bridge flag.
> 
> In order to let the Link Up IRQ logic handle PCIe switches that are already
> powered on (PCIe switches that not powered on already need to implement a
> pwrctrl driver), don't perform a pci_host_probe() call during probe()
> (which disregards the delays required by the PCIe specification).
> 
> Instead let the first Link Up IRQ call pci_host_probe(). Any follow up
> Link Up IRQ will call pci_rescan_bus().
> 
> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
> Fixes: 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ")
> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Closes: https://lore.kernel.org/linux-pci/1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 70 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  5 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  5 +-
>  4 files changed, 68 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda51..8654346729574 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -565,6 +565,59 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static int dw_pcie_host_initial_scan(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct pci_host_bridge *bridge = pp->bridge;
> +	int ret;
> +
> +	ret = pci_host_probe(bridge);
> +	if (ret)
> +		return ret;
> +
> +	if (pp->ops->post_init)
> +		pp->ops->post_init(pp);
> +
> +	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> +
> +	return 0;
> +}
> +
> +void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
> +{
> +	if (!pp->initial_linkup_irq_done) {
> +		int ret;
> +
> +		ret = dw_pcie_host_initial_scan(pp);
> +		if (ret) {
> +			struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +			struct device *dev = pci->dev;
> +
> +			dev_err(dev, "Initial scan from IRQ failed: %d\n", ret);
> +
> +			dw_pcie_stop_link(pci);
> +
> +			dw_pcie_edma_remove(pci);
> +
> +			if (pp->has_msi_ctrl)
> +				dw_pcie_free_msi(pp);
> +
> +			if (pp->ops->deinit)
> +				pp->ops->deinit(pp);
> +
> +			if (pp->cfg)
> +				pci_ecam_free(pp->cfg);
> +		} else {
> +			pp->initial_linkup_irq_done = true;
> +		}
> +	} else {
> +		/* Rescan the bus to enumerate endpoint devices */
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pp->bridge->bus);
> +		pci_unlock_rescan_remove();
> +	}
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -669,18 +722,17 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	 * If there is no Link Up IRQ, we should not bypass the delay
>  	 * because that would require users to manually rescan for devices.
>  	 */
> -	if (!pp->use_linkup_irq)
> +	if (!pp->use_linkup_irq) {
>  		/* Ignore errors, the link may come up later */
>  		dw_pcie_wait_for_link(pci);
>  
> -	ret = pci_host_probe(bridge);
> -	if (ret)
> -		goto err_stop_link;
> -
> -	if (pp->ops->post_init)
> -		pp->ops->post_init(pp);
> -
> -	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> +		/*
> +		 * For platforms with Link Up IRQ, initial scan will be done
> +		 * on first Link Up IRQ.
> +		 */
> +		if (dw_pcie_host_initial_scan(pp))
> +			goto err_stop_link;

This is causing NULL ptr dereference on Qcom platforms as 'pp->bridge->bus' is
dereferenced after dw_pcie_host_init() for registering the IRQ.

I still feel that a revert would be the safest option.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

