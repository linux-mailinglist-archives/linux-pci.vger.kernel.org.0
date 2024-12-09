Return-Path: <linux-pci+bounces-17910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12D9E8DC6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 09:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0550118858B4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13883214A7F;
	Mon,  9 Dec 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWgfa3uO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A341EB3D;
	Mon,  9 Dec 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734075; cv=none; b=cc2CUm34k/P55NbQBxWjGwyuu+KcKoRB2R6cr6L26dpmzLhHYoXyC2vNsVjeqZP0faOWZALTIphyFyWgDWWYC6jvI6+iXwnjX2nNZnP/MWgs6xtBT1+n+n11P6xXDWEHBWiIoLjjnt2QZtoCaYx+j6SQ7DB9xo0cxlps+TnrLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734075; c=relaxed/simple;
	bh=MgUCcyHZmhoyWplc1YUsmOsXZYib9lqKSt3lEQKaSYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIuwA4JsSrDq7kKvF+ANJJvUwbjMWh9ceMSJaTvQ6DkSbKvG7AT7vaok5y01cSlmCYx2BdRauCSlbBfMfG62Qvsar5gZloV8emRLzZmUJ4GbepF95t06XcPo7vN3ry9ZH+QSqBbeEKQ6vQXs8WmX9F6EOpnBa82wiZlXTFh31RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWgfa3uO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A37C4CED1;
	Mon,  9 Dec 2024 08:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734074;
	bh=MgUCcyHZmhoyWplc1YUsmOsXZYib9lqKSt3lEQKaSYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UWgfa3uOhyHie63mC/kMEM4hrtMmch7j1xGAeIAAqj9diWni7FbORuiA+wCISS1C6
	 D6Y0nQ7cgF86bK1YGRKKSSVxlCfxnDc+d/r9wPChj1QSQxeXhj/kwJtQxh3rwUdtaU
	 5LRFAx7SFjjLPjvdmgBWRdjkvdapWFk2gpI9EMu5Bl5BC2JaXsjLdPm1XWfeH8lVaI
	 GPxpn77tOdi497BRTHrHVSrHWVMYSZ1qbG01ZOkeT9DtQBSD383LRAjp1NMmm+SlGV
	 KbWE+a3/9mWQ9dE8W+3OxtHYvKvKXaFmYBvq8ORlW+52PfjjIUHxLFfqH7rsOhGTrb
	 Kz2mKPeGefDBw==
Message-ID: <48988ec4-06a9-447b-bdd5-be35f31a5488@kernel.org>
Date: Mon, 9 Dec 2024 17:47:51 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
To: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
 bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, frank.li@nxp.com,
 quic_krichai@quicinc.com
Cc: imx@lists.linux.dev, kernel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
 <20241209073924.2155933-4-hongxing.zhu@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241209073924.2155933-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 16:39, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM state before sending
> PME_TURN_OFF message.
> 
> Only print the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't an error message when no endpoint is
> connected at all.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 14e95c2952bbe..02e0e8c255c70 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,25 +982,31 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	/* Only send out PME_TURN_OFF when PCIE link is up */
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> -		if (pci->pp.ops->pme_turn_off)
> -			pci->pp.ops->pme_turn_off(&pci->pp);
> -		else
> -			ret = dw_pcie_pme_turn_off(pci);
> -
> -		if (ret)
> -			return ret;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
> +	if (ret)
> +		return ret;

ret is always 0 for the "if (pci->pp.ops->pme_turn_off)" case. So this test of
"if (ret) return ret" should really go inside the "else", and the initialization
of ret to 0 on declaration can be removed too.

>  
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret;
> -		}
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +				val == DW_PCIE_LTSSM_L2_IDLE ||
> +				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret) {
> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +		return ret;
>  	}
>  
> +	/*
> +	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +	 * 100ns after L2/L3 Ready before turning off refclock and
> +	 * main power. It's harmless too when no endpoint connected.
> +	 */
> +	udelay(1);
> +
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5c14ed2cb91ed..7efcb4af66da3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
>  	DW_PCIE_LTSSM_L0 = 0x11,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
>  


-- 
Damien Le Moal
Western Digital Research

