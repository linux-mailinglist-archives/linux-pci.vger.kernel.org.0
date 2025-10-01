Return-Path: <linux-pci+bounces-37352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEDDBB0E62
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C3E19C0A60
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4252274FDF;
	Wed,  1 Oct 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbLGX5a5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5126FDBD;
	Wed,  1 Oct 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330346; cv=none; b=kwK+D+j+W0rGs+YuCp7V+L+M/VU26CbEUnCWVpiVsbXiPBmy8EkPjaJBBtATmsSToAQblN1j4MiVFRmAcsKJvNrVJ8Lvded1gwAlRmGtUp4mOWUP/qEgdjG7VUlrj8d5ds0n8w7lmVw3skoMzTXpnrg8LUY8yRKdkFxBWiJ+kDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330346; c=relaxed/simple;
	bh=ZLuAJtf5Ay5V3wJzzmRXG3Pw3uAXV9z6Fj6IMRT0cJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iPZtqPDqH81CWxCLpjyPmx01Z0G0slCdMfju9C08FA8iOGBeNJpvLIq6/uw8H8/Sw9b2+4mOa8pc2eWn1Rweew4IV32XI/Ln4+aLdbWr4pHjB/yalwg0g9dm9mHOZgqrsA5WePNzWmO4AC0PDsqw8NW/LPd7iwJe6WTdL+mUnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbLGX5a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB8C4CEF9;
	Wed,  1 Oct 2025 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330346;
	bh=ZLuAJtf5Ay5V3wJzzmRXG3Pw3uAXV9z6Fj6IMRT0cJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VbLGX5a5HziGndAsvgrxLMIOrlcpzm8thMULLWEGLhtnECk4IVmzjC8XTXci/YarC
	 QOyjqQFLeVq70nfhAYnh+YiN0wt9/1Slt9zCEBBnzWTSpqJKC0i88d7THX+nEE7+jn
	 JNl7OskrE87jgKcrq8mPO4X5az4kxQrHy2uidsRNVXXelmpVMpbhwmxQsyRSGDvuAF
	 DgiQNLkhP1J83Dtk0r+5xzmuqmvkzunT42Z4qfwu3JahHU7BPrqmM7U8FbV9YDoSz5
	 Eri2WcVFLxX8kG8nfTQHoCpmw3MFlhxUXE5qWuYNoQw2NqiEZ7qH/wmsQs051iWvoF
	 QyKK0wMf9/lvw==
Date: Wed, 1 Oct 2025 09:52:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: stm32: Re-use existing error handling path in
 stm32_pcie_probe()
Message-ID: <20251001145223.GA226169@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69ade3edcec4da2d5bfc66e0d03bbcb5a857021.1759169956.git.christophe.jaillet@wanadoo.fr>

On Mon, Sep 29, 2025 at 08:19:30PM +0200, Christophe JAILLET wrote:
> An error handling path is already available, so use it instead of hand
> writing the same code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The stm32 driver hasn't been merged upstream yet, so I squashed this
into it:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=fd486e67e88c

Thank you!

> ---
>  drivers/pci/controller/dwc/pcie-stm32.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
> index 964fa6f674c8..96a5fb893af4 100644
> --- a/drivers/pci/controller/dwc/pcie-stm32.c
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -287,18 +287,16 @@ static int stm32_pcie_probe(struct platform_device *pdev)
>  
>  	ret = pm_runtime_set_active(dev);
>  	if (ret < 0) {
> -		clk_disable_unprepare(stm32_pcie->clk);
> -		stm32_remove_pcie_port(stm32_pcie);
> -		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
> +		dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
> +		goto err_disable_clk;
>  	}
>  
>  	pm_runtime_no_callbacks(dev);
>  
>  	ret = devm_pm_runtime_enable(dev);
>  	if (ret < 0) {
> -		clk_disable_unprepare(stm32_pcie->clk);
> -		stm32_remove_pcie_port(stm32_pcie);
> -		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +		dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +		goto err_disable_clk;
>  	}
>  
>  	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);
> -- 
> 2.51.0
> 
> 

