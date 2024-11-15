Return-Path: <linux-pci+bounces-16866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF49CDD6A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2757B23F32
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63D1B4F02;
	Fri, 15 Nov 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc6dPKfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B81B2195
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669914; cv=none; b=LwKbVfcLBDD32VJeH7t8IV94NE/rUPi/IMJRlLSpBVWfIWLxI9dwh1W8OdWQz0RkdIL7ru07EhYxu2E6BYtC+wptERs2hdm8HMyxUTauQze8BF4hfB+PRBxSezLXnkcXrvfJKSEMl3mhZdiYgsvewdHu098EzYtd+UfjAGhev7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669914; c=relaxed/simple;
	bh=FCKY1eD04I5Z3uVFWPqntsNBMF1+X8iJFFBU/nIcbio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQFsfgnrURoLsAkib0YMzNNGbIJNBcrVo4rQ22Jea8tSnj8pq7W3rCJTPAXRKVVTqvFfIjoJKYbr2Scn1FxBdhqH9WnlsLwHGXFhmdOAJI1mR2NEDs5GNZ1+rgKbfru4DXhbRXBZHvgnjWldsI/bYFbT/ze/HtTtCRI/xTKnBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jc6dPKfy; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e6104701ffso975492b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 03:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731669912; x=1732274712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0ID6LGyvQNAjf20EM8AU6orAPT1m416dbiwXz3DRXI=;
        b=Jc6dPKfy4IFHXYd0JSOBWh2UQ11FDgmaH5VwgDdxc9LB53S0k3gjnRIYl9x/BCqX5c
         VEQzbTOEpGQftkGsex/NdGrOruYGTDqGBIs2rdQtX5SSi441W4xXV46cQh6+aCf7h0z4
         U8gRddA4p+b7s+n23e3hA6GWh68gfCXWGH05SdQGdj/hX6JlQJBZar2YAHyM58dyV8Ps
         vHNAOK6bYuVsg80ekYxogdyAOBXJqebALwIqjMmshLTVm9jflAhvy7f6tQF4aPwHjQUZ
         xLsmfVysQ6FGyTfSlg90Gm0Fd1XbxX/8HF8SCwweiVMLp9azxYCWVRQeGFTu0UdmOY9B
         rapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731669912; x=1732274712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0ID6LGyvQNAjf20EM8AU6orAPT1m416dbiwXz3DRXI=;
        b=jAu5y4B1AVn4+tLiQWzkrPiDeV4wCUgQVpQUDro/BryxAOi3Ppz9xxt+y4cdrde0Ov
         sm32KBSMwsp3xecf+nKHk2GoZoVrojoxvi6mWt4EsQOOrJK0O8XB+RQOv6GmwoXOoarI
         CSYErxtQ/EGAwf3XYz0blXuA1y9DYT9TbKO3yKzwT586YI7r0o9Vka0DHDhl2OfnXqLy
         6/Jpa0gfZt07YWL79Wl9fehrvKdpDgJEKIKOyqKsFHZnGEX0OQ3iRp+pJAOu0OQz7CuO
         SrLkUnrazRjyQ4bkuSzObPp2KfcjqR2/K6HcrHTozQxMmquccUgd/mGi1L8TEnVuelvo
         s6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6W5Nnz5KsTfZaIOCyFGOLTup3mxorYib5WzdyrllNDzJ98PkuIwgfJH4xTQPqhicjxOGFFQ7F0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNBACzebaP98BEs9fcm8S/J3VZZfVrndcWOAje9Uhj9ycvTwP
	Ha0rl841iD8dI+wzLgBoTDRoSCBlZtmnjtm0r27InL2UCs8JxK8/3jPSmlVxjA==
X-Google-Smtp-Source: AGHT+IFpZg539it1BfGL4KI3yO9IXU1yUG5k4Sss5OebPIZ+F3teAQBNcSqyZsp7sjkXoLsd1CMR1A==
X-Received: by 2002:a05:6808:320d:b0:3e6:3205:1a71 with SMTP id 5614622812f47-3e7bc7bb0a0mr2480605b6e.15.1731669912170;
        Fri, 15 Nov 2024 03:25:12 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c15227sm921010a12.13.2024.11.15.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:25:11 -0800 (PST)
Date: Fri, 15 Nov 2024 16:55:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root
 complex functionality
Message-ID: <20241115112504.anaatuqitdvjubyx@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-5-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106221341.2218416-5-quic_mrana@quicinc.com>

On Wed, Nov 06, 2024 at 02:13:41PM -0800, Mayank Rana wrote:
> On SA8255p ride platform, PCIe root complex is firmware managed as well
> configured into ECAM compliant mode. This change adds functionality to
> enable resource management (system resource as well PCIe controller and
> PHY configuration) through firmware, and enumerating ECAM compliant root
> complex.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig     |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
>  2 files changed, 108 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..0fe76bd39d69 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -275,6 +275,7 @@ config PCIE_QCOM
>  	select PCIE_DW_HOST
>  	select CRC8
>  	select PCIE_QCOM_COMMON
> +	select PCI_HOST_COMMON
>  	help
>  	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>  	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..2cb74f902baf 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -21,7 +21,9 @@
>  #include <linux/limits.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> @@ -254,10 +256,12 @@ struct qcom_pcie_ops {
>    * @ops: qcom PCIe ops structure
>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>    * snooping
> +  * @firmware_managed: Set if PCIe root complex is firmware managed

ecam_compliant?

>    */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	bool override_no_snoop;
> +	bool firmware_managed;
>  	bool no_l0s;
>  };
>  
> @@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.no_l0s = true,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_fw_managed = {

cfg_ecam?

> +	.firmware_managed = true,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1566,6 +1574,51 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static void qcom_pci_free_msi(void *ptr)
> +{
> +	struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
> +
> +	if (pp && pp->has_msi_ctrl)
> +		dw_pcie_free_msi(pp);
> +}
> +
> +static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct dw_pcie_rp *pp;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev = dev;
> +	pp = &pci->pp;
> +	pci->dbi_base = cfg->win;
> +	pp->num_vectors = MSI_DEF_NUM_VECTORS;
> +
> +	ret = dw_pcie_msi_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	pp->has_msi_ctrl = true;
> +	dw_pcie_msi_init(pp);
> +
> +	ret = devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);

return devm_add_action_or_reset()...

> +	return ret;
> +}
> +
> +/* ECAM ops */
> +const struct pci_ecam_ops pci_qcom_ecam_ops = {
> +	.init		= qcom_pcie_ecam_host_init,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> @@ -1580,11 +1633,52 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	char *name;
>  
>  	pcie_cfg = of_device_get_match_data(dev);
> -	if (!pcie_cfg || !pcie_cfg->ops) {
> -		dev_err(dev, "Invalid platform data\n");
> +	if (!pcie_cfg) {
> +		dev_err(dev, "No platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pcie_cfg->firmware_managed && !pcie_cfg->ops) {
> +		dev_err(dev, "No platform ops\n");
>  		return -EINVAL;
>  	}
>  
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_put;
> +
> +	if (pcie_cfg->firmware_managed) {
> +		struct pci_host_bridge *bridge;
> +		struct pci_config_window *cfg;
> +
> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
> +		if (!bridge) {
> +			ret = -ENOMEM;
> +			goto err_pm_runtime_put;
> +		}
> +
> +		of_pci_check_probe_only();

You haven't defined the "linux,pci-probe-only" property in DT. So if everything
works fine, then you can leave this call.

> +		/* Parse and map our Configuration Space windows */
> +		cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
> +		if (IS_ERR(cfg)) {
> +			ret = PTR_ERR(cfg);
> +			goto err_pm_runtime_put;
> +		}
> +
> +		bridge->sysdata = cfg;
> +		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
> +		bridge->msi_domain = true;
> +
> +		ret = pci_host_probe(bridge);

return pci_host_probe()...

> +		if (ret) {
> +			dev_err(dev, "pci_host_probe() failed:%d\n", ret);
> +			goto err_pm_runtime_put;
> +		}
> +
> +		return ret;
> +	}
> +
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
> @@ -1593,11 +1687,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> -		goto err_pm_runtime_put;
> -
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
> @@ -1739,9 +1828,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  static int qcom_pcie_suspend_noirq(struct device *dev)
>  {
> -	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct qcom_pcie *pcie;
>  	int ret = 0;
>  
> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
> +		return 0;

How about bailing out if dev_get_drvdata() returns NULL?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

