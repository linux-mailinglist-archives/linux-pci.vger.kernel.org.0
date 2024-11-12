Return-Path: <linux-pci+bounces-16596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE589C62B2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71021F245A4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B6219E34;
	Tue, 12 Nov 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff1apUwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC41FC7F8;
	Tue, 12 Nov 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443973; cv=none; b=CoiZQ+WNdpRef9lUHkOjzgEPcRvyfEUt9P1AgXGjn2FyXRT6omUYHGtG1FDsSjgKtCsOa1WMcsJg2teEXV1sJq8sXCRRLqXNd+/0/NQhg4FjJGK0OMzy3wdmuqNizOtDdzyvHaH+T3zLrP/QFDRdSxDOumEFOT6Z2HCnvpMsSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443973; c=relaxed/simple;
	bh=Cz4bRV94/5MKAskZbYAn+TUSR0LBQP5CIfaO0PQZ+eA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sp48npVFD5Gxlt19Y3Ejev9NVAjnj6ZeQfP6uoqHhryeLTZwGhEAEcLnckfTbWwBhy5AWs6VLkMWBSv4ST6nixff5oF/43m0rVHUsRocWy/hebh1baPovuHZnCV44BRPcvrzGQrOrjcIL2D+FeCw5I/LqCJri0qzQkvkXT0gxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff1apUwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B9C4CED7;
	Tue, 12 Nov 2024 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443972;
	bh=Cz4bRV94/5MKAskZbYAn+TUSR0LBQP5CIfaO0PQZ+eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ff1apUwpOiGPDm+i+5r5B3s5dmMB2dJgxctx3edd+b8FqF8Nq3n93rQlg+41y6zOA
	 EPwhloVc6oGbcSWc3w0fax5DWB8hXhLMxLQJDc4PLLIMp5u3XuwJGwYPr+k0fxj1JN
	 TvpI1koK8FK9Jz1qa6gsTyhc3PzbzilN2ZW+SDXjPgB15ms1yNhVgTOmpQE8s7gjNQ
	 CYy8yCHHLYst8fgwZop0vbGlqErCDK4gxLXQdkg4avOvz8LJtuxCVfYTHZF2biblwf
	 5JfB0NGw1U2oK8kbGhKypOx4xWcXZKafm1zqdSAGge/7VCqmssFPjEgxVbe5+4yk3k
	 Gp8simaEgiFCg==
Date: Tue, 12 Nov 2024 14:39:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
Message-ID: <20241112203931.GA1858001@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112161925.999196-6-christian.bruel@foss.st.com>

On Tue, Nov 12, 2024 at 05:19:25PM +0100, Christian Bruel wrote:
> Add myself as STM32MP25 PCIe host and PCIe endpoint drivers

s/as STM32MP25/as maintainer of STM32MP25/

> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4803908768e8..277e1cc0769e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17912,6 +17912,13 @@ L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/pci-exynos.c
>  
> +PCI DRIVER FOR STM32MP25
> +M:	Christian Bruel <christian.bruel@foss.st.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/st,stm32-pcie-*.yaml
> +F:	drivers/pci/controller/dwc/*stm32*
> +
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> -- 
> 2.34.1
> 

