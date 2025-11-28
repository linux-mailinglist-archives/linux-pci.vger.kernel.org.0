Return-Path: <linux-pci+bounces-42235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C27C90845
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 02:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD4D2350B21
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4A25394A;
	Fri, 28 Nov 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FmbyETUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963852522B6;
	Fri, 28 Nov 2025 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294111; cv=none; b=e9WhKqf9mVw69yKkTPLEcDN7ieqlGydhYuff91B+tfqP63lnpAY2nEZNjSY7DdpiEXYRZC+xxWvsMF0nke70SuW+pXSZvbPEHMc4lSYOjqZHcs26AvM3wcCxl5HkrqtYIhpR8IlL0B63Ie19h6crENVropUQurE9a+FauCKj6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294111; c=relaxed/simple;
	bh=0wDiS+BN/rTBUoa9oiwKomP92jTLbrXU1GyGnUYbJNA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AYc/xm3gJI/lEHrzN1Z0zWKPkymwjWzC0nFInRXrQs2MS7FEd/eETnN3J8BN0KX07lp4xDFSeo/EPqlkSMwnnFIPUoci0unNo9HaysFQDl7hegCthphch2WK4t4/aKo5sbD3N1tE6v1DrvACqccVSmW8iVRXqZXaR10g/UYfIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FmbyETUi; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2b2e92628;
	Fri, 28 Nov 2025 09:06:16 +0800 (GMT+08:00)
Message-ID: <dbe6975d-9b99-4493-9145-b2db382fd468@rock-chips.com>
Date: Fri, 28 Nov 2025 09:06:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, FUKAUMI Naoki <naoki@radxa.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Make Link Up IRQ logic handle already powered
 on PCIe switches
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <20251127134318.3655052-2-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251127134318.3655052-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ac7ff1dd209cckunmb69f50316946c2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklMTVYYSExOHkxKTEsaTBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FmbyETUih0zC01PvdaA7bUcXVK9lGATf0na3P/WE2HDqlcEHBgkENNEJDTNEXHOPEV7T8YcLkLJj/UuZg+eJsI4jI9+Ve6zNR+eO5KE9Vvmy+nRGtk4Rmj6K6oEXy7S8/3vhuaKXAy1NHx/MZxRm8SVoLqpnf0HgUMle4FsWG4o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=cbz0T3Pb1Oli5KHPUp2Dx7P8QO+RzTOk0Et4ZiYbRK8=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/27 星期四 21:43, Niklas Cassel 写道:
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

Thanks for fixing this, I'v tested it on RK3588S-EVB1 with both of PCIe
switch + 2 NVMe and NVMe directly connected.

FWIW,
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
> Fixes: 0e0b45ab5d77 ("PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ")
> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Closes: https://lore.kernel.org/linux-pci/1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 70 ++++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c |  5 +-
>   drivers/pci/controller/dwc/pcie-qcom.c        |  5 +-
>   4 files changed, 68 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda51..8654346729574 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -565,6 +565,59 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>   	return 0;
>   }
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
>   int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -669,18 +722,17 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	 * If there is no Link Up IRQ, we should not bypass the delay
>   	 * because that would require users to manually rescan for devices.
>   	 */
> -	if (!pp->use_linkup_irq)
> +	if (!pp->use_linkup_irq) {
>   		/* Ignore errors, the link may come up later */
>   		dw_pcie_wait_for_link(pci);
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
> +	}
>   
>   	return 0;
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ecd..a31bd93490dcd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -427,6 +427,7 @@ struct dw_pcie_rp {
>   	int			msg_atu_index;
>   	struct resource		*msg_res;
>   	bool			use_linkup_irq;
> +	bool			initial_linkup_irq_done;
>   	struct pci_eq_presets	presets;
>   	struct pci_config_window *cfg;
>   	bool			ecam_enabled;
> @@ -807,6 +808,7 @@ void dw_pcie_msi_init(struct dw_pcie_rp *pp);
>   int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
>   void dw_pcie_free_msi(struct dw_pcie_rp *pp);
>   int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> +void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp);
>   int dw_pcie_host_init(struct dw_pcie_rp *pp);
>   void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
>   int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
> @@ -844,6 +846,9 @@ static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	return 0;
>   }
>   
> +static inline void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
> +{ }
> +
>   static inline int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   {
>   	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd096..8f2cc1ef25e3d 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -466,10 +466,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>   		if (rockchip_pcie_link_up(pci)) {
>   			msleep(PCIE_RESET_CONFIG_WAIT_MS);
>   			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> -			/* Rescan the bus to enumerate endpoint devices */
> -			pci_lock_rescan_remove();
> -			pci_rescan_bus(pp->bridge->bus);
> -			pci_unlock_rescan_remove();
> +			dw_pcie_handle_link_up_irq(pp);
>   		}
>   	}
>   
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c48a20602d7fa..2d8aca6630949 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1617,10 +1617,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>   	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>   		msleep(PCIE_RESET_CONFIG_WAIT_MS);
>   		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> -		/* Rescan the bus to enumerate endpoint devices */
> -		pci_lock_rescan_remove();
> -		pci_rescan_bus(pp->bridge->bus);
> -		pci_unlock_rescan_remove();
> +		dw_pcie_handle_link_up_irq(pp);
>   
>   		qcom_pcie_icc_opp_update(pcie);
>   	} else {


