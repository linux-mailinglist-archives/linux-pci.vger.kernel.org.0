Return-Path: <linux-pci+bounces-16087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775CA9BD9B2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 00:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7861F21A1B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20BA216A1A;
	Tue,  5 Nov 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItX1lqbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DE1D415B;
	Tue,  5 Nov 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849223; cv=none; b=ogu/DaJJHgOR4I4qn13Q7KwWHbgA7ECyKbtoIstlewQD4ac3IG/hqo9P/XkiTDTMEx9TyU+ts0FK0mZwac1AOP2WJ7zexq3hh03Cze9qQ5eRHWNh8sZgP2xRhXIoQjAqGaS0+JYNSOsth0ugiyuQ5JKEKO4y+GoFfT1kqLYDQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849223; c=relaxed/simple;
	bh=UkvquMl7XDzAUrgt8bEdxCreNSRkuPZxntXUk0Q5qT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=klHP8CB5No80jxZvBQSur4PH9427xiE6F+LIBRd4PmlnV7k9hWvRs+qeES5FbkN/DkNmdZMY7lOvn4VipNDKAWTtVeFYQO6raxG86hbYh7JXlV1cpVqbntp2n0TOt/Zpjpohm+jH6sxfPVYi+E3O2/HZy6A9adQKtdyoLFqi6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItX1lqbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219AFC4CECF;
	Tue,  5 Nov 2024 23:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730849223;
	bh=UkvquMl7XDzAUrgt8bEdxCreNSRkuPZxntXUk0Q5qT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ItX1lqbddjjJBLKfroS5uE/8N6rGlilUk0vqQmKsqt3ZQFip037N+gV6rUt8GbS4N
	 NG+xvj5Eybh67ymoaYzjRVS/MmEHcPM/56mGv7R9MkER8wwp6kruNsw7+4Ro23/iZk
	 Vl6XA1c9so009WImSIdyDnlRZTID2yj9VV9wXnT0qKTn7f2mp+Nda8rnoB/vjLLHqi
	 zJAXSQD0FQYvlHlaooc4+Cyno+w+c7XIfXStgzFov96do97p46huWe0p/YBDeJjSNr
	 cMRRthfXWLe+ZinbqnM4BIMfsY8iRHVtU5UEuewz4MvFQkxE+09zYv5yomE93b1pk/
	 EJYktAZBv6o1g==
Date: Tue, 5 Nov 2024 17:27:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kwilczynski@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	frank.li@nxp.com, mani@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Message-ID: <20241105232701.GA1495103@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>

On Mon, Jul 22, 2024 at 02:15:13PM +0800, Richard Zhu wrote:
> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms, power
> loss occurs during suspend, causing dw_resume() to do nothing in this case.
> This results in a system halt because the DWC controller is not initialized
> after power-on during resume.

dw_resume() doesn't exist.  What function did you mean?

System halt?  In dw_pcie_resume_noirq()?  What causes the halt?  A
NULL pointer dereference?  A CPU hang because a read of some
controller register never completes?  Feels a little hand-wavy.

Another comment below.

> Change call to deinit() in suspend and init() at resume regardless of
> whether there are EP device connections or not. It is not harmful to
> perform deinit() and init() again for the no power-off case, and it keeps
> the code simple and consistent in logic.
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a0822d5371bc5..cb8c3c2bcc790 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> +		/* Only send out PME_TURN_OFF when PCIE link is up */
> +		if (pci->pp.ops->pme_turn_off)
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		else
> +			ret = dw_pcie_pme_turn_off(pci);

This looks possibly racy since the link can go down at any point.

> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
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
> -- 
> 2.37.1
> 

