Return-Path: <linux-pci+bounces-1953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820AC828ED5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 22:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE1284A03
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6A3D99D;
	Tue,  9 Jan 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVRh1szL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0873DB80;
	Tue,  9 Jan 2024 21:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18CBC43390;
	Tue,  9 Jan 2024 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704835408;
	bh=7w8qlm8CewmioJlCiEwlQ5fWYqSXtnF3ghDjhDZEBAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gVRh1szL4FkgxR3AP4ehd9ojCxNRmyx6v3m0VMDz+HrmSEYWRrq2uWpd3f0mOFqw5
	 N5EhjmKpPamQp5jlnkYESpZxnkEZ2cdiBOzjL3FDU7je9bp5DsebDUFy91Ihzn5AAp
	 CW8Wo4kiMJM7iJS3RPIpFohdqy/RwIuN+IAKs/Kt5BhxP7ZinpcM30rlqxIfhHvDO+
	 6vZbedeodgkuHA2Png7gX8h8NkqE1qiR89IfmwNw/wIibyx9cucWbX7yDNI4Qd1XyC
	 HCGnA97OeA4wc9jg0K6KomP9T2HgQCani3nr1HaHORbxg0AyKprfgjhyoDrP2mvMEq
	 2x2dOBHsT2nZA==
Date: Tue, 9 Jan 2024 15:23:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ilpo.jarvinen@linux.intel.com, vigneshr@ti.com,
	r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix race condition when initializing
 PHYs
Message-ID: <20240109212326.GA2018284@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927041845.1222080-1-s-vadapalli@ti.com>

On Wed, Sep 27, 2023 at 09:48:45AM +0530, Siddharth Vadapalli wrote:
> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
> function. The PHY in this case is the Serdes. It is possible that the
> PCI instance is configured for 2 lane operation across two different
> Serdes instances, using 1 lane of each Serdes. In such a configuration,
> if the reference clock for one Serdes is provided by the other Serdes,
> it results in a race condition. After the Serdes providing the reference
> clock is initialized by the PCI driver by invoking its PHY APIs, it is
> not guaranteed that this Serdes remains powered on long enough for the
> PHY APIs based initialization of the dependent Serdes. In such cases,
> the PLL of the dependent Serdes fails to lock due to the absence of the
> reference clock from the former Serdes which has been powered off by the
> PM Core.
> 
> Fix this by obtaining reference to the PHYs before invoking the PHY
> initialization APIs and releasing reference after the initialization is
> complete.
> 
> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> NOTE: This patch is based on linux-next tagged next-20230927.
> 
> v2:
> https://lore.kernel.org/r/20230926063638.1005124-1-s-vadapalli@ti.com/
> 
> Changes since v2:
> - Implement suggestion by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>   moving the phy_pm_runtime_put_sync() For-Loop section before the
>   return value of ks_pcie_enable_phy(ks_pcie) is checked, thereby
>   preventing duplication of the For-Loop.
> - Rebase patch on next-20230927.
> 
> v1:
> https://lore.kernel.org/r/20230926054200.963803-1-s-vadapalli@ti.com/
> 
> Changes since v1:
> - Add code to release reference(s) to the phy(s) when
>   ks_pcie_enable_phy(ks_pcie) fails.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 49aea6ce3e87..0ec6720cc2df 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1218,7 +1218,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		goto err_link;
>  	}
>  
> +	/* Obtain reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> +
>  	ret = ks_pcie_enable_phy(ks_pcie);
> +
> +	/* Release reference(s) to the phy(s) */
> +	for (i = 0; i < num_lanes; i++)
> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);

This looks good and has already been applied, so no immediate action
required.

This is the only call to ks_pcie_enable_phy(), and these loops get and
put the PM references for the same PHYs initialized in
ks_pcie_enable_phy(), so it seems like maybe these loops could be
moved *into* ks_pcie_enable_phy().

Is there any similar issue in ks_pcie_disable_phy()?  What if we
power-off a PHY that provides a reference clock to other PHYs that are
still powered-up?  Will the dependent PHYs still power-off cleanly?

>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
>  		goto err_link;
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

