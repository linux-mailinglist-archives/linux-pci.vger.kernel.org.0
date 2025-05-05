Return-Path: <linux-pci+bounces-27169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D8AA9911
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2B01888B1B
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DC267703;
	Mon,  5 May 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMeVruwr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C51A5B82
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462727; cv=none; b=PCKt1JJiotDZiwF+xMh+zwBQAkEuS2beREbb3Icc6kV3FyVyoxzCC3ahN6DcR/nAfYRvs3Yz/viWbCfVRE04psO+VytyVfV/8g0I1b0xSNaZAxb1E2RpdKy4quo5d3Z9sx5TD9aPvIbKKwHFDqwvlysBOc/9TUNJpI0GNEorrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462727; c=relaxed/simple;
	bh=shkAZuvCH2RU/ckc8VuwX9a+2DZnjJ7l1ZckrK9OVyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVHFhLsmBk1Jbp8PY7mhid568GCRnqetufYJm6hz+ARlgClQxsqlavZHbi0W/k+WbHrdVIrwXowX1tHTs9tokQDOIsHfMSNVlOrux5YBDRNjmJ1fJ8GdNK4Tv2/CmqJCYSVK+YI1rH1ruFcQOMEuAOS8gH6sNpQZrBrlIPMVB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMeVruwr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5586629a12.2
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746462725; x=1747067525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P8zp6pDtJvcq027DnBZDXmCmCGpXlaf9vo9MS7U/Xtg=;
        b=PMeVruwrOGDyctAeFNqflnY/WkCJi87BWj9pvpDrCllzWm0IeTmZIVQTfPgohdAUtW
         NMV/WV2s3q61ItxnNfcKfeDusJ7K5vgaqHIg8ypJSnfTiPvWPB3Ts0G9s9pec3yTAJkJ
         WxY+y20LkKEC/yPPuLXrTYULeC5zLuD7wYlhHWKWLoCPhPRH11P7AKjVL3ECDCnpkdMO
         Uar/cLBlvgvYp5cVejUV8R/OO/vXT6OhovycqJ5VSPawMQinQnkPJqGSDApNceJV2Dpg
         oIXsu7/pMEW/XC8H/T29NWuAFreVTBUQcCEsTmZWX8TgtSyClulOt3+z+z0ZtoilfgFf
         99Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462725; x=1747067525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8zp6pDtJvcq027DnBZDXmCmCGpXlaf9vo9MS7U/Xtg=;
        b=ZJGju19vwOYuMrpxc/3RueRmpUQXR0mIyRsv5cAs/mhmEqMh8vuGlZ3GziITbWHwGt
         cjMMXOzQ4M8UWrGoDUbjAGGTBu0hwIqzzayILqE1Ft20zPjQ5DuhryZi2qO/wUfyJxQz
         d3ChGfpq2xF1ODlVtEy/8SJtJ9dEjsdfvmGDUxyZfTTYqUeTtA0HDhx5YAXKjXZ+QqME
         8zw9SKnt3YkGJWd2+BbdsQqJB0C6ZGwhHiUlwbft78ZVYEl+G6qE6BNS7u8lSLRIenaS
         JpfBQgiI6/IiisvZqJAVpfz4+Sh/cYsHpCUL/nPB38NYdi+ciTcLLm6fNlttYuyBAbOK
         4Vfw==
X-Forwarded-Encrypted: i=1; AJvYcCVs/YMKIPZxLB0bpuoLpvcr0jVsl1izr+Bk4uUVmBKZE4bdtxlPZkoZTGJev6UYEv+kD3MV+E5JywE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjo3Ll5W5S5lIeYFJyJzpFVc6XnRIe4qLAAg4kbam7XIbli4+
	IuvCaRf6fXdBlMv43Ml4dp8haUQ0JPqKMjIi2QjSGb4x7T+weLQxD4mYYjLYaQ==
X-Gm-Gg: ASbGncvlHRTBGpOaKAkC6X1QTLOmmejwWaYJFfqqirzTHoU4kc0jq805nZ11xdwSE3D
	9vkMJUtt0trLdi2Sk9sFXOIdotJ+veGWFN4ST16ok1YRZTPd1pOU6BrEafNtV5NNHk/wtVDv7PR
	C8j5C0HqTNQ9I16NcPVJSd+gDXFd7DK62u7eDskPwTNAMo1RLAm7wWJhfFbXgg5I5RV236fuiex
	S7M1wY+2H7zIjPNpeNgPrrjDPIXKpJ1pXEt0uOTckR4tf+KuIAiibQpr2VUXje4XPihS7L4QD8g
	nOsPsPigyPByn3Hp59x/F3e2tmk3krZPE4nnRdIuGWpvlUHyd/U=
X-Google-Smtp-Source: AGHT+IFmJNMq5Zm0Lx/iI+jAiEoLSglq132RPDiKeb9iy7s27eldL13qMLmaPmS7wnylnwCLW1L1wQ==
X-Received: by 2002:a05:6a21:3a4a:b0:1f5:9175:2596 with SMTP id adf61e73a8af0-20e9660571emr11256518637.13.1746462725573;
        Mon, 05 May 2025 09:32:05 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c3d6bcsm5794666a12.61.2025.05.05.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:05 -0700 (PDT)
Date: Mon, 5 May 2025 22:01:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
Message-ID: <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>

On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Debugfs cleanup is moved to a new shutdown callback to ensure the
> debugfs nodes are properly cleaned up on shutdown and reboot.
> 

Both are separate changes. You should remove the .remove() callback in the
previous patch itself and add .shutdown() callback in this patch.

And the shutdown callback should quiesce the device by putting it in L2/L3 state
and turn off the supplies. It is not intended to perform resource cleanup.

- Mani

> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 1539d172d708c11c3d085721ab9416be3dea6b12..cc9ca4305ea2072b7395ee1f1e979c24fdea3433 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2674,27 +2674,12 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static void tegra_pcie_remove(struct platform_device *pdev)
> +static void tegra_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
> -	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> -	struct tegra_pcie_port *port, *tmp;
>  
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_pcie_debugfs_exit(pcie);
> -
> -	pci_stop_root_bus(host->bus);
> -	pci_remove_root_bus(host->bus);
> -	pm_runtime_put_sync(pcie->dev);
> -	pm_runtime_disable(pcie->dev);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		tegra_pcie_msi_teardown(pcie);
> -
> -	tegra_pcie_put_resources(pcie);
> -
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> -		tegra_pcie_port_free(port);
>  }
>  
>  static int tegra_pcie_pm_suspend(struct device *dev)
> @@ -2800,7 +2785,7 @@ static struct platform_driver tegra_pcie_driver = {
>  		.pm = &tegra_pcie_pm_ops,
>  	},
>  	.probe = tegra_pcie_probe,
> -	.remove = tegra_pcie_remove,
> +	.shutdown = tegra_pcie_shutdown,
>  };
>  builtin_platform_driver(tegra_pcie_driver);
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> 
> -- 
> 2.48.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

