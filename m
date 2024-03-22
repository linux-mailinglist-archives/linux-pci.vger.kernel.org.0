Return-Path: <linux-pci+bounces-4992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BB886B9C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F12863CF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBED3F9E8;
	Fri, 22 Mar 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRb6+7dx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133C3FB04;
	Fri, 22 Mar 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108441; cv=none; b=Us89jVFpnnGFsNDDNbZf5sOXh+/TzNOHUd5PAfSTfZqbXNTCIBIGwpvOc6aBtaWbDTAleMdKlWFX4gCNcYhvV5Vna/iYJdo8vQjnU/Wzi2QOkNhbbtfw0nsG3Nrrs+fBbwveQmN6Eh98ATodFdTqLr8IJDywbWLPPT4aw3tzqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108441; c=relaxed/simple;
	bh=b9Cp4C1sz2JvQcloJbd1gxGs1djTlwbzJPl/7QImHrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T06KrPYnLO9kvm+1TApe0Au8HDAgy2PJCbYtm4OKK/d5yDDxV332V1rxJ2+nmjKs1jm1ZgMQWMrcEu5mqEk9GeDhFqscqdtRk9D5Zrw5GdIQ5y22LT/tBIx7t0UahW4iDUuQwmOGmltE0aeloNUjCajMww2tiiX3VUF75Bj2ZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRb6+7dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5125FC433C7;
	Fri, 22 Mar 2024 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711108440;
	bh=b9Cp4C1sz2JvQcloJbd1gxGs1djTlwbzJPl/7QImHrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRb6+7dx+JBAmmwEy/1CbdN2q2OvEsiR/RQXuB4t8hLIaNirKmj/2Trwph9TnuZnq
	 9FLsy/VthCWbXcnq09IdY81DsJdJbeXxGL5SfvszT2ZFMTMbDc4ZphVkmAkucYmB3q
	 uwRuBYE0daZ2r/KSrsMurn/OJcqc8lAmbvavkQdJ1Wal8yBkdX6WuduVDqxSSoJcep
	 46LvtW9lm7lfch2R4MktG5kQjJaFBZggm+vD7/AUSJMFAuzjpnr4w6jV02k/G30/I2
	 jYWN2TwvUDMCfeDD/vRCo2XVllTNp7SFh3RKj8+25msTV0WfF8wI4iCNU+drxf3qJI
	 lvyqUtd9CUZoA==
Date: Fri, 22 Mar 2024 12:53:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v10 8/8] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <Zf1xTkuK8yBZXmQ0@ryzen>
References: <20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org>
 <20240314-pci-dbi-rework-v10-8-14a45c5a938e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-dbi-rework-v10-8-14a45c5a938e@linaro.org>

On Thu, Mar 14, 2024 at 01:18:06PM +0530, Manivannan Sadhasivam wrote:
> "core_init_notifier" flag is set by the glue drivers requiring refclk from
> the host to complete the DWC core initialization. Also, those drivers will
> send a notification to the EPF drivers once the initialization is fully
> completed using the pci_epc_init_notify() API. Only then, the EPF drivers
> will start functioning.
> 
> For the rest of the drivers generating refclk locally, EPF drivers will
> start functioning post binding with them. EPF drivers rely on the
> 'core_init_notifier' flag to differentiate between the drivers.
> Unfortunately, this creates two different flows for the EPF drivers.
> 
> So to avoid that, let's get rid of the "core_init_notifier" flag and follow
> a single initialization flow for the EPF drivers. This is done by calling
> the dw_pcie_ep_init_notify() from all glue drivers after the completion of
> dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
> send the notification to the EPF drivers once the initialization is fully
> completed.
> 
> Only difference here is that, the drivers requiring refclk from host will
> send the notification once refclk is received, while others will send it
> during probe time itself.
> 
> But this also requires the EPC core driver to deliver the notification
> after EPF driver bind. Because, the glue driver can send the notification
> before the EPF drivers bind() and in those cases the EPF drivers will miss
> the event. To accommodate this, EPC core is now caching the state of the
> EPC initialization in 'init_complete' flag and pci-ep-cfs driver sends the
> notification to EPF drivers based on that after each EPF driver bind.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 ++
>  drivers/pci/controller/dwc/pci-imx6.c             |  2 ++
>  drivers/pci/controller/dwc/pci-keystone.c         |  2 ++
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 ++
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  2 ++
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 ++
>  drivers/pci/controller/dwc/pcie-keembay.c         |  2 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  1 -
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  1 -
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 ++
>  drivers/pci/endpoint/functions/pci-epf-test.c     | 18 +++++-------------
>  drivers/pci/endpoint/pci-ep-cfs.c                 |  9 +++++++++
>  drivers/pci/endpoint/pci-epc-core.c               | 22 ++++++++++++++++++++++
>  include/linux/pci-epc.h                           |  7 ++++---
>  15 files changed, 58 insertions(+), 18 deletions(-)

FWIW:
Tested-by: Niklas Cassel <cassel@kernel.org>



However, when looking at this, I was surprised that you never call something
that will set:
init_complete = false;
from e.g. dw_pcie_ep_deinit() or dw_pcie_ep_cleanup().

I saw that you do seem to set
init_complete = false;
in your other follow up series that is based on this one.

What will happen if you run with only this series merged (without your
follow up series), on a platform that used to have .core_init_notifier?

If you do remove and recreate the symlink on a platform with external
refclk, since you never set init_complete to false, you could trigger
EPF core_init callback, e.g. pci_epf_test_core_init() to be called,
which will do DBI writes even when there is no refclk.

E.g. (on a platform with external refclk):
1) Create symlink to pci-epf-test in configfs.
2) Start RC, your EPC driver will call ep_init_notifiy() when perst
deasserts.
3) Run pci-epf-test.
4) Remove the pci-epf-test symlink
5) Shutdown RC
6) Create symlink to pci-epf-test in configfs.
   This will see that init_complete is true, and will do DBI writes
   which will crash your system, since you don't have a refclk.

Perhaps you should move the patch that calls a function that sets
init_complete = false;
to this series, so that this crash is not possible?


> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 395042b29ffc..d2d17d37d3e0 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -474,6 +474,8 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>  		return ret;
>  	}
>  
> +	dw_pcie_ep_init_notify(ep);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bfcafa440ddb..894b5de76e3a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1144,6 +1144,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  		return ret;
>  	}
>  
> +	dw_pcie_ep_init_notify(ep);
> +
>  	/* Start LTSSM. */
>  	imx6_pcie_ltssm_enable(dev);
>  
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 093dbb725e41..b7b30470b394 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1293,6 +1293,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  			goto err_ep_init;
>  		}
>  
> +		dw_pcie_ep_init_notify(&pci->ep);
> +
>  		break;
>  	default:
>  		dev_err(dev, "INVALID device type %d\n", mode);
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index b712fdd06549..c513598a46d7 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -283,6 +283,8 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dw_pcie_ep_init_notify(&pci->ep);
> +
>  	return ls_pcie_ep_interrupt_init(pcie, pdev);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index a6095561db4a..a4630b92489b 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -452,6 +452,8 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  
> +		dw_pcie_ep_init_notify(&pci->ep);
> +
>  		break;
>  	default:
>  		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index ca9b22e654cd..8490c5d6ff9f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -154,6 +154,8 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  			dw_pcie_ep_deinit(&pci->ep);
>  		}
>  
> +		dw_pcie_ep_init_notify(&pci->ep);
> +
>  		break;
>  	default:
>  		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 250d6acf16dc..9fa9354a5f48 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -438,6 +438,8 @@ static int keembay_pcie_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  
> +		dw_pcie_ep_init_notify(&pci->ep);
> +
>  		break;
>  	default:
>  		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 3697b4a944cc..2fb8c15e7a91 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -775,7 +775,6 @@ static void qcom_pcie_ep_init_debugfs(struct qcom_pcie_ep *pcie_ep)
>  
>  static const struct pci_epc_features qcom_pcie_epc_features = {
>  	.linkup_notifier = true,
> -	.core_init_notifier = true,
>  	.msi_capable = true,
>  	.msix_capable = false,
>  	.align = SZ_4K,
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index fb7c03639a53..0448928017f3 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -435,6 +435,8 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  		rcar_gen4_pcie_ep_deinit(rcar);
>  	}
>  
> +	dw_pcie_ep_init_notify(ep);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 264ee76bf008..e02deb31a72d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2006,7 +2006,6 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.linkup_notifier = true,
> -	.core_init_notifier = true,
>  	.msi_capable = false,
>  	.msix_capable = false,
>  	.reserved_bar = 1 << BAR_2 | 1 << BAR_3 | 1 << BAR_4 | 1 << BAR_5,
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 82ccaea089be..eb1d79fdb1f1 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -410,6 +410,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dw_pcie_ep_init_notify(&priv->pci.ep);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 18c80002d3bd..fc0282b0d626 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -753,6 +753,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
> +	bool linkup_notifier = false;
>  	bool msix_capable = false;
>  	bool msi_capable = true;
>  	int ret;
> @@ -795,6 +796,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
>  		}
>  	}
>  
> +	linkup_notifier = epc_features->linkup_notifier;
> +	if (!linkup_notifier)
> +		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
> +
>  	return 0;
>  }
>  
> @@ -901,8 +906,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	const struct pci_epc_features *epc_features;
>  	enum pci_barno test_reg_bar = BAR_0;
>  	struct pci_epc *epc = epf->epc;
> -	bool linkup_notifier = false;
> -	bool core_init_notifier = false;
>  
>  	if (WARN_ON_ONCE(!epc))
>  		return -EINVAL;
> @@ -913,8 +916,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	linkup_notifier = epc_features->linkup_notifier;
> -	core_init_notifier = epc_features->core_init_notifier;
>  	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>  	if (test_reg_bar < 0)
>  		return -EINVAL;
> @@ -927,21 +928,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	if (!core_init_notifier) {
> -		ret = pci_epf_test_core_init(epf);
> -		if (ret)
> -			return ret;
> -	}
> -

While you did fix up all DWC based drivers, the non-DWC EPC drivers that
did not have epc_features->core_init_notifier before this patch:

drivers/pci/controller/cadence/pcie-cadence-ep.c:#include <linux/pci-epc.h>
drivers/pci/controller/pcie-rcar-ep.c:#include <linux/pci-epc.h>
drivers/pci/controller/pcie-rockchip-ep.c:#include <linux/pci-epc.h>

I don't think that they will work with pci-epf-test anymore, since AFAICT,
you did not add a call to: pci_epc_init_notify() or similar in these EPC drivers.
(Like this patch does to all the DWC-based drivers without a core_init_notifier.)


Kind regards,
Niklas

