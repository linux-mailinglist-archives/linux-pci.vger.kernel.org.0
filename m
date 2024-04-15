Return-Path: <linux-pci+bounces-6249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5518A5253
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5751C22909
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE478C83;
	Mon, 15 Apr 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqe4p6Tf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED778C7D;
	Mon, 15 Apr 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189117; cv=none; b=ccB0Rq3VEv7mE1vT0F1rQAnd0kzV7JsNoHYLAJ8BC1/jpVaoWxmK1zZIhYXam0UBCtFWX7aRAU8N7swsz31lLTKrqu0Hxqq0JWDPnbjvyCPtJ30V0UKxHw9P8g7aYZsaro3R+ysZGINdwDrxHlNZuNROVio055vVoKba0LP7tvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189117; c=relaxed/simple;
	bh=SzkzBFbe6c8gG4+ZL+WOY4sX6HVkU3+kdcdkXuXKNZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbZEwh9EJgX4EAmbVsDfk8Mv9k17b3390WnJhfHL1s8H8DE3whu0A0HsyOHbUpnAZVouHrBuxzj6LePLQcK+e3Xg3PKpoACMcgVxj1zjpJQsVr6J20SZLKJK6VixmD7DVJGWOjMQVzLaLP5zd+77Wmbh+S675aygQrxjaYuVCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqe4p6Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F7C2BD10;
	Mon, 15 Apr 2024 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713189117;
	bh=SzkzBFbe6c8gG4+ZL+WOY4sX6HVkU3+kdcdkXuXKNZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqe4p6TfQMQKNjnLm3WtPvKmlyes/8Yacw5p/NJKXdXlob5yIi2V5cX3EfI2jFNOt
	 a6Ks5+HKBGdrpT1/gTyWLWPd+ndyf55wCBck4PFTD2ZX02Htifn+R15Y2812Cg20TT
	 sDzwqr7z5A+yuHtSKodu1bQWxiAw+Kx5Kb2IKrHT09szT5TtT0GMTi4zh7T7i2rKsQ
	 RGX4C9Det3rZ/PJSVLj/3lsmwbW4i/lAzygGB6xht7PppPSRzPx294dGBcnnvXM5Lu
	 czUXSiO4sbKkaC1XTGhaYPBk6mb5Z0XPvPX7DpLhFa44rg30DRXe4SlEJvs9TniJb5
	 Ag26DSQPm1FKQ==
Date: Mon, 15 Apr 2024 19:21:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: tegra194: Fix probe path for Endpoint mode
Message-ID: <20240415135148.GI7537@thinkpad>
References: <20240401150116.298069-1-vidyas@nvidia.com>
 <20240408093053.3948634-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408093053.3948634-1-vidyas@nvidia.com>

On Mon, Apr 08, 2024 at 03:00:53PM +0530, Vidya Sagar wrote:
> Tegra194 PCIe probe path is taking failure path in success case for
> Endpoint mode. Return success from the switch case instead of going
> into the failure path.
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> v2:
> * Added 'Fixes' and 'Reviewed-by' from Jon Hunter
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4bba31502ce1..1a8178dc899a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  		ret = tegra_pcie_config_ep(pcie, pdev);
>  		if (ret < 0)
>  			goto fail;
> +		else
> +			return 0;

This pattern is prone to error just like how it was before this patch. You
should just return 0 at the end of the function for success case and direct all
failure cases to 'fail' label:

```
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1f7b662cb8e1..f410aae0ee7f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2236,9 +2236,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
        pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
        ret = PTR_ERR_OR_ZERO(pcie->icc_path);
        if (ret) {
-               tegra_bpmp_put(pcie->bpmp);
                dev_err_probe(&pdev->dev, ret, "failed to get write interconnect\n");
-               return ret;
+               goto fail;
        }
 
        switch (pcie->of_data->mode) {
@@ -2254,8 +2253,6 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
                ret = tegra_pcie_config_rp(pcie);
                if (ret && ret != -ENOMEDIUM)
                        goto fail;
-               else
-                       return 0;
                break;
 
        case DW_PCIE_EP_TYPE:
@@ -2278,8 +2275,11 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
        default:
                dev_err(dev, "Invalid PCIe device type %d\n",
                        pcie->of_data->mode);
+               goto fail;
        }
 
+       return 0;
+
 fail:
        tegra_bpmp_put(pcie->bpmp);
        return ret;
```

- Mani

-- 
மணிவண்ணன் சதாசிவம்

