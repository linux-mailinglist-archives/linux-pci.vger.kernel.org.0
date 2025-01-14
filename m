Return-Path: <linux-pci+bounces-19750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C6A10FAD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECBE163ECE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134920CCD2;
	Tue, 14 Jan 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM2IAdYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BE20CCCF;
	Tue, 14 Jan 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878523; cv=none; b=p53avlIkjCxH7oRQPHP7fTjgbyCU4iEOpmNAt3EJyOsGKRYKkM98K2857uChKhtmc+odPhzKXh7j093uALVk8vXeY0Db/M8+ZJC2+7TpPZLH9MbbSVoeZ833wna7M/gpnA0QoeuAvAobSAD2w03XRefkgQudX4Sf2jg1x6k4Mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878523; c=relaxed/simple;
	bh=CA5obihZgaBHMiIG6XVpkvHJ8pHqg/3yvFkGjSTsiEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dihXCEgHaUhyj1f+cknjuxj2RtML62NUiE4a04T1hhffAGpBXPKca+jJpkenCP0ChNstLYCMwLLGdD/861Xdyvx+CCL8JKhCOEgznmhJ03uQD56GI6p8LLfYi0vrIcXq0Bs/00tMUaFGtbqnXCVN4yWt1ZlonRa8dfygkzEvoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM2IAdYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6E5C4CEDD;
	Tue, 14 Jan 2025 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736878522;
	bh=CA5obihZgaBHMiIG6XVpkvHJ8pHqg/3yvFkGjSTsiEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CM2IAdYJmNYJMwnKyLz3UkT/N90jBHdifjAlmm5V9kGh3g+MZ+SSBeuGHbIW/xtWP
	 J8ELdkFYRAx4DpulW2v4vftSVPz7/PqUFFG0Pr2U2mb+J+yn9nOtUCIXX/uhrDXj/1
	 mBRCBueO/UFd6pIurWvp/knAxDhd/hTfS6I9so5yoAeHoUioW4cKH4XuRWkQEx1xyA
	 ILXjK1uPQ4NErY9J9jy2sHCn18ULOviqLcaU+tECDUGcpXWY3HzdDqcM6N7n2UV7rp
	 165drfZVOCjFAjw8Sw6Dg7xhA6l45d42zO92/5v7Aybzq7Ht8ZaIdCs9+ybbKgvuRn
	 kzSQfzAsAF1dw==
Date: Tue, 14 Jan 2025 12:15:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: dlemoal@kernel.org, jingoohan1@gmail.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org, frank.li@nxp.com,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: dwc: Always stop link in the
 dw_pcie_suspend_noirq
Message-ID: <20250114181518.GA473181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210081557.163555-2-hongxing.zhu@nxp.com>

On Tue, Dec 10, 2024 at 04:15:56PM +0800, Richard Zhu wrote:
> On i.MX8QM, PCIe link can't be re-established again in
> dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
> dw_pcie_suspend_noirq().
>
> Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
> keep symmetric in suspend/resume function since there is
> dw_pcie_start_link() in dw_pcie_resume_noirq().
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f882b11fd7b94..f56cb7b9e6f99 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1001,6 +1001,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  		return ret;
>  	}
>  
> +	dw_pcie_stop_link(pci);

We should try to avoid changes to the generic DWC path just to
accommodate one controller.  Since other DWC-based controllers
apparently don't need dw_pcie_stop_link() here, this seems like it
might be the wrong place for this change.

If doing dw_pcie_stop_link() here is really helpful for all DWC
controllers, this would be fine, but the commit log should then explain
why it helps everybody, not why one particular controller benefits.

If it's only needed for i.MX8QM, we do already have a
controller-specific hook (.deinit()) just below; maybe that could be
used?

>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
>  
> -- 
> 2.37.1
> 

