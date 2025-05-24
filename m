Return-Path: <linux-pci+bounces-28378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C5AC3168
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CA73BE544
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40F1DE4E6;
	Sat, 24 May 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QODOBHg9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325A1D8E07;
	Sat, 24 May 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748120270; cv=none; b=a94pGLWud9pstsX4WoKLsID9pQXyF8AGLDM2D0ZxfRbfZA/rh54AYyQ8qCrZEJsVGVqhz2zziiWz80n3Zj4UyCioxd5L8vHOqsPucTzfKrfRjbvkZVrbAo3+EkfgGfeY1bJaBfOUWOPsthK12Mai1BZCbdzFZHfd0foj2YCNXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748120270; c=relaxed/simple;
	bh=ZRgBVQ4cQLyahlJiDiZ4ANkfRyf4jQKwrcJG8gTPvI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myclq2dr6+Q5ua2Y+LjstZggwA0BeGm/pEEauv1wAx5gKQzSFeQzcQSboJnfRwWhTayVLR8/LVvENlsK7nUvu1shkdp5JeNrfR7WuMX6avwy5ZDK5eRPkNO8c18ouVofosstG8gGn0v6OF07OVpcPGsOTMlX9uPpV/NTiBjNkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QODOBHg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803B1C4CEE4;
	Sat, 24 May 2025 20:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748120269;
	bh=ZRgBVQ4cQLyahlJiDiZ4ANkfRyf4jQKwrcJG8gTPvI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QODOBHg9CAZLkFb545G6G9+TacSr/PmgssN3lUhiGZTMQisKA5J7B1gmqKNrnPVHJ
	 bl1LnS5KUwwiXzo5xK9Nufbq6ZcBIRrrbhxI47tm2Cj3JdLsifuNRCpVoxSfWr1dQv
	 UiODjZDlHBaF0hnKN3UWBT0Y0PkkeBGLmLOPFZeV8A7nQESD4KLE4m6J88NG0ljJig
	 mEn8nYSvjM/nEwhFpS3gjNKupvUlaDZuQM9mjbnd7ZANC9FCJ32+lmAZaKB1Yszrv9
	 +x4UL0tY3fCmXes7ZxJBuD+Rj8EIALQ9XApDyUNIiFVMtQd5aU5YTnEkUtm8SYQF+r
	 xWNRXuomjtgFw==
Date: Sat, 24 May 2025 22:57:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, wilfred.mallawa@wdc.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI: Rename host_bridge::reset_slot() to
 host_bridge::reset_root_port()
Message-ID: <aDIyyMvQkMC40jnQ@ryzen>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524185304.26698-3-manivannan.sadhasivam@linaro.org>

On Sun, May 25, 2025 at 12:23:04AM +0530, Manivannan Sadhasivam wrote:
> The callback is supposed to reset the root port, hence it should be named
> as 'reset_root_port'. This also warrants renaming the rest of the instances
> of 'reset slot' as 'reset root port' in the drivers.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  8 ++++----
>  drivers/pci/controller/dwc/pcie-qcom.c        |  8 ++++----
>  drivers/pci/controller/pci-host-common.c      | 20 +++++++++----------
>  drivers/pci/pci.c                             |  6 +++---
>  include/linux/pci.h                           |  2 +-
>  5 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 193e97adf228..0cc7186758ce 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -85,7 +85,7 @@ struct rockchip_pcie_of_data {
>  	const struct pci_epc_features *epc_features;
>  };
>  
> -static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
> +static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>  				       struct pci_dev *pdev);
>  
>  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
> @@ -261,7 +261,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  					 rockchip);
>  
>  	rockchip_pcie_enable_l0s(pci);
> -	pp->bridge->reset_slot = rockchip_pcie_rc_reset_slot;
> +	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_slot;

You just renamed the function to rockchip_pcie_rc_reset_root_port(),
but you seem to use the old name here, so I would guess that this will
not compile.

With the function pointer renamed, this patch looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


>  
>  	return 0;
>  }
> @@ -700,7 +700,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
> +static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>  				       struct pci_dev *pdev)
>  {
>  	struct pci_bus *bus = bridge->bus;
> @@ -759,7 +759,7 @@ static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
>  
>  	/* Ignore errors, the link may come up later. */
>  	dw_pcie_wait_for_link(pci);
> -	dev_dbg(dev, "slot reset completed\n");
> +	dev_dbg(dev, "Root port reset completed\n");
>  	return ret;
>  
>  deinit_clk:
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0c59030a2d55..840263c1efe0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -291,7 +291,7 @@ struct qcom_pcie {
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> -static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> +static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  				  struct pci_dev *pdev);
>  
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> @@ -1277,7 +1277,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_assert_reset;
>  	}
>  
> -	pp->bridge->reset_slot = qcom_pcie_reset_slot;
> +	pp->bridge->reset_root_port = qcom_pcie_reset_root_port;
>  
>  	return 0;
>  
> @@ -1533,7 +1533,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  	}
>  }
>  
> -static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> +static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  				  struct pci_dev *pdev)
>  {
>  	struct pci_bus *bus = bridge->bus;
> @@ -1589,7 +1589,7 @@ static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
>  
>  	qcom_pcie_start_link(pci);
>  
> -	dev_dbg(dev, "Slot reset completed\n");
> +	dev_dbg(dev, "Root port reset completed\n");
>  
>  	return 0;
>  
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index afa7b140a04a..24e357e85adb 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -99,22 +99,22 @@ void pci_host_common_remove(struct platform_device *pdev)
>  EXPORT_SYMBOL_GPL(pci_host_common_remove);
>  
>  #if IS_ENABLED(CONFIG_PCIEAER)
> -static pci_ers_result_t pci_host_reset_slot(struct pci_dev *dev)
> +static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
>  {
>  	int ret;
>  
>  	ret = pci_bus_error_reset(dev);
>  	if (ret) {
> -		pci_err(dev, "Failed to reset slot: %d\n", ret);
> +		pci_err(dev, "Failed to reset root port: %d\n", ret);
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
>  
> -	pci_info(dev, "Slot has been reset\n");
> +	pci_info(dev, "Root port has been reset\n");
>  
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> -static void pci_host_recover_slots(struct pci_host_bridge *host)
> +static void pci_host_reset_root_ports(struct pci_host_bridge *host)
>  {
>  	struct pci_bus *bus = host->bus;
>  	struct pci_dev *dev;
> @@ -124,11 +124,11 @@ static void pci_host_recover_slots(struct pci_host_bridge *host)
>  			continue;
>  
>  		pcie_do_recovery(dev, pci_channel_io_frozen,
> -				 pci_host_reset_slot);
> +				 pci_host_reset_root_port);
>  	}
>  }
>  #else
> -static void pci_host_recover_slots(struct pci_host_bridge *host)
> +static void pci_host_reset_root_ports(struct pci_host_bridge *host)
>  {
>  	struct pci_bus *bus = host->bus;
>  	struct pci_dev *dev;
> @@ -140,17 +140,17 @@ static void pci_host_recover_slots(struct pci_host_bridge *host)
>  
>  		ret = pci_bus_error_reset(dev);
>  		if (ret)
> -			pci_err(dev, "Failed to reset slot: %d\n", ret);
> +			pci_err(dev, "Failed to reset root port: %d\n", ret);
>  		else
> -			pci_info(dev, "Slot has been reset\n");
> +			pci_info(dev, "Root port has been reset\n");
>  	}
>  }
>  #endif
>  
>  void pci_host_handle_link_down(struct pci_host_bridge *bridge)
>  {
> -	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
> -	pci_host_recover_slots(bridge);
> +	dev_info(&bridge->dev, "Recovering root ports due to Link Down\n");
> +	pci_host_reset_root_ports(bridge);
>  }
>  EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d6e9ce2bbcc..154d33e1af84 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4985,16 +4985,16 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int ret;
>  
> -	if (pci_is_root_bus(dev->bus) && host->reset_slot) {
> +	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
>  		/*
>  		 * Save the config space of the root port before doing the
>  		 * reset, since the state could be lost. The device state
>  		 * should've been saved by the caller.
>  		 */
>  		pci_save_state(dev);
> -		ret = host->reset_slot(host, dev);
> +		ret = host->reset_root_port(host, dev);
>  		if (ret)
> -			pci_err(dev, "failed to reset slot: %d\n", ret);
> +			pci_err(dev, "failed to reset root port: %d\n", ret);
>  		else
>  			/* Now restore it on success */
>  			pci_restore_state(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8d7d2a49b76c..ab4f4a668f6d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -599,7 +599,7 @@ struct pci_host_bridge {
>  	void (*release_fn)(struct pci_host_bridge *);
>  	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> -	int (*reset_slot)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	int (*reset_root_port)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> -- 
> 2.43.0
> 

