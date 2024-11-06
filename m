Return-Path: <linux-pci+bounces-16089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00AE9BDABE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 01:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2DC1C22CAD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744212B17C;
	Wed,  6 Nov 2024 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUCcH9hs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81A2D613;
	Wed,  6 Nov 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854681; cv=none; b=INAQywllj79RWmoqLQ/JiyOQ3UwPtfZnC+zS0x57qt/IRNg6dNGwfvPC66YL6fM6SAW5N3y+uDdrAqtUOCKvSVA0NOsrg3kaWZ5FanoN2iAIX6XQd+dDYWzF/e04CObgyKTL0RMd1PjXYbSRn03Y93LrzJj590tPuwDzvmez1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854681; c=relaxed/simple;
	bh=yNQ9oZI1LY0D3fQ4q4pt0Z8IWksfEtyB2tsRgj/DkR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IdIJLIngT2S/oGTCUTBn6tfwqUhKY+TqvxzgCiGudfeFsWaJWIJoyVLQrTOh9AlCF93iCRtJLOjIgxEEElVq8lVlqUMfcg2rHyzGU01rWjWuDgX/+zdlZwUOyzVki7hYXrRUp1oyJL1yEvaZp5mrhdsF7PUlAUF70NTdnHMu3SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUCcH9hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C91C4CECF;
	Wed,  6 Nov 2024 00:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730854680;
	bh=yNQ9oZI1LY0D3fQ4q4pt0Z8IWksfEtyB2tsRgj/DkR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WUCcH9hsRpWToVrU9NgS9cJN80oTS5l23JIyQZdjctDJTXgjCN+5GIFJox+8ZK6fu
	 h+us217VSnCtx9rGlMtvwMpNlxE5wJFBCxgUoOIHXxOOgPZwbTTSiN/EH6a8ZHYdJt
	 boBceX/R24+JOtLVKoMjPMOPDlOiytDelhOv4c5jfcv6GTYD5XdyW4+H7leofzX0w8
	 CeCBPhXQdxlnRmpX4QemxcdKOM8+68kdoU1Yl3rGSM6wrYHlxtYdZWzxj+V0Fvjppp
	 f8HQ10NQifujNR26e9r0+9dEi9NWrUXNwIWangZRjae+0fpLGDfD2Iby6Zph7dWcUa
	 bz3ov2QdeW7Ww==
Date: Tue, 5 Nov 2024 18:57:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	kishon@kernel.org, u.kleine-koenig@pengutronix.de,
	cassel@kernel.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <20241106005758.GA1498067@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105714.191642-2-s-vadapalli@ti.com>

On Fri, May 24, 2024 at 04:27:13PM +0530, Siddharth Vadapalli wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
> Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
> device data ("struct ks_pcie_of_data"). However it failed to set mode
> for "ti,keystone-pcie" compatible. Set mode as RootComplex for
> "ti,keystone-pcie" compatible here.

23284ad677a9 appeared in v5.10.  

But I guess RC support has not been broken since v5.10 because we
never used ks_pcie_rc_of_data.mode anyway?

It looks like the only use is here:

  #define DW_PCIE_VER_365A                0x3336352a
  #define DW_PCIE_VER_480A                0x3438302a

  ks_pcie_probe
  {
    ...
    mode = data->mode;
    ...
    if (dw_pcie_ver_is_ge(pci, 480A))
      ret = ks_pcie_am654_set_mode(dev, mode);
    else
      ret = ks_pcie_set_mode(dev);

so we don't even look at .mode unless the version is v4.80a or later,
and this is v3.65a?

So this is basically a cosmetic fix (but still worth doing for
readability!) and doesn't need a stable backport, right?

If so, I might amend the commit log to mention the fact that this
doesn't actually fix a functional issue.

> Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index d3a7d14ee685..3184546ba3b6 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1064,6 +1064,7 @@ static int ks_pcie_am654_set_mode(struct device *dev,
>  
>  static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
>  	.host_ops = &ks_pcie_host_ops,
> +	.mode = DW_PCIE_RC_TYPE,
>  	.version = DW_PCIE_VER_365A,
>  };
>  
> -- 
> 2.40.1
> 

