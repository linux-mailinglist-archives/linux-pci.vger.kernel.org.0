Return-Path: <linux-pci+bounces-17911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C1D9E8DCE
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C3D2813A6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ECB2156EB;
	Mon,  9 Dec 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV7FM2ju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7971EB3D;
	Mon,  9 Dec 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734187; cv=none; b=Rcu9BtaMkPu0ROl3MxNODolSZNYLyeYqirjCFucPFDd9vltCFPFxuvwcwgOChWxc08EDbGRBDYXSLJnJ7wqTC09JzwrJ7V6oUj523XoHSBcQchxpIu8+5/WFsEcGfDAyNXWNbKul6G3NGKxVKY8mrRq07xGUeF/0wbQ1EXQluHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734187; c=relaxed/simple;
	bh=hVLxRe9v7B/Z66hnq8XNYrWyj73y6nZAh4fRU1c249k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+bchX6D+QRVRPltVJvPgl5Exy6bHv5rFNIOsSiquXFjkjvBWPEoo42sA63XhIwrZl2JTuxcLZO4aRsGp8FmoebSDIWsScKyiHYjxzmI1RgMzvlG1SejT+UIYyKK22H+zLdHXXQZ02meaoAZggkB3teWZbIW+D/01IDlp/jUqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV7FM2ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E880C4CED1;
	Mon,  9 Dec 2024 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734187;
	bh=hVLxRe9v7B/Z66hnq8XNYrWyj73y6nZAh4fRU1c249k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tV7FM2julmGJwDnihmy9NQmGz8cTzzIDdKinoNqkhlPFCpqw69xfdnFVDIF6fmfA+
	 w69G2oQg7mppLWHs8ggKCYuyvQqVIhBZyToEUzX1ooEAj/bd/TP/vTyQAZMkFn1ObZ
	 veUa/NDyMi7qAcDmo9InXwiQ4H4WDLsX6S2MbtTj67hFHiUSZlJSw0F2wNlNG6zj30
	 KrFxPb6TS8i4L+c8bvUtVeSlX3QfgTjRckpxSrKCj/HQn5JWfD18USJzQz0mVguVmL
	 V1cXaT/l6XFm+CVaOeY6Z8LrmomQdhzuaSM8nvZBLqOcRnT/MdgJ/XHsM37orXbCGO
	 dG3U4pJrH9KIw==
Message-ID: <ca93bfaa-0b7e-4335-87e0-5f4133efad6a@kernel.org>
Date: Mon, 9 Dec 2024 17:49:43 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: dwc: Fix resume failure if no EP is connected
 on some platforms
To: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
 bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, frank.li@nxp.com,
 quic_krichai@quicinc.com
Cc: imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
 <20241209073924.2155933-2-hongxing.zhu@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241209073924.2155933-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 16:39, Richard Zhu wrote:
> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms,
> power loss occurs during suspend, causing dw_resume() to do nothing in
> this case. This results in a system halt because the DWC controller is
> not initialized after power-on during resume.
> 
> Call deinit() in suspend and init() at resume regardless of whether
> there are EP device connections or not. It is not harmful to perform
> deinit() and init() again for the no power-off case, and it keeps the
> code simple and consistent in logic.
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f882b11fd7b94..11563402c571b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,23 +982,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> -		return 0;
> -
> -	if (pci->pp.ops->pme_turn_off)
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	else
> -		ret = dw_pcie_pme_turn_off(pci);
> +	/* Only send out PME_TURN_OFF when PCIE link is up */
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> +		if (pci->pp.ops->pme_turn_off)
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		else
> +			ret = dw_pcie_pme_turn_off(pci);
>  
> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;

Same comment as for patch 3. This "if (ret) return ret;" can go inside the else.
It is harmless, but there is also no point in having it here.

>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	if (pci->pp.ops->deinit)


-- 
Damien Le Moal
Western Digital Research

