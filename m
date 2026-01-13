Return-Path: <linux-pci+bounces-44621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C034D19EFD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24AD83082B0A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CB23933FA;
	Tue, 13 Jan 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyd3AN3/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF13933EA;
	Tue, 13 Jan 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318208; cv=none; b=dty8ArPNK7SDYIAIJhpu4YFEvXw8EZFg7XYxBbBWWmUwTYEFgEX2m2wEIeeiqtCVfvIfQwFYmqYYkBjnxrZkVNgfRGMajLFE7bVE0vc0W8uCypft9lkzbLE1EvYNv1qQReXKHSQYXfayhLBRRUE4ECjqkAnSPeTISJSj5hzLvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318208; c=relaxed/simple;
	bh=WgEe/MDg5GDJ9RD4sxJBGuALxPFpoPlF76iKnLPpSHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2lR9eBsQLWypYDickimwCZfFW/B5K2VyGJ+aWIbJPXGhk9NgOdOF1LtuI9gXtP9fs9VwwgJwF2o1hy2ot8lNM4dHRd7jvHWsTjcnqKZyZqpNBCBB7URdHL4NnSQGEw7eX4ziePMmVaziUyF4ufs2K+UOvHgmRYtvcxXIbSTxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyd3AN3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B2EC19421;
	Tue, 13 Jan 2026 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318207;
	bh=WgEe/MDg5GDJ9RD4sxJBGuALxPFpoPlF76iKnLPpSHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyd3AN3/NLo4E6aWTbjnhX4eVBd4vmYpuMLT4fBGFXaysXWKxqie0AZh0zVhvbJXK
	 08CzliUSNfo2vc9GA8vFE+8y2fj6HFrL+O8aT24S5dE8OSwN+nI1K44UvY//GPL6KP
	 dJh6FWvF+mr839ZCDzRlY+jKfiwX3MDCkG7Hm9U7VGPzwqbljuEAEstAmh+0eQM4iZ
	 bvZCPz2x9UpbNb02IZXmeYjGB7DRGQs5xoE3V1mOYSAtiR1N1/KUyZErtbE2ji8RNN
	 ZMnk/Ro6rBt37GFE8c7kTmORdog5LZXyxKQuMFz+CbKjL61amvu5lQixKlLWp39QkK
	 gHeBTi7H42QMw==
Date: Tue, 13 Jan 2026 20:59:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] PCI: dwc: Don't return error when wait for link
 up in dw_pcie_resume_noirq()
Message-ID: <7akwvdfve5jcj2tm7jiwowkvcctsmqeslia4pulvtdgcgicp4p@h5ztwyp4h7ft>
References: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
 <20260107024553.3307205-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107024553.3307205-3-hongxing.zhu@nxp.com>

On Wed, Jan 07, 2026 at 10:45:53AM +0800, Richard Zhu wrote:
> When waiting for the PCIe link to come up, both link up and link down
> are valid results depending on the device state.
> 
> Since the link may come up later and to get rid of the following
> mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
> outcome has already been reported in dw_pcie_wait_for_link().
> 
> PM error logs introduced by the -ETIMEDOUT error return.
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
> imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110
> 
> Cc: stable@vger.kernel.org
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 06cbfd9e1f1e..025e11ebd571 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1245,10 +1245,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(pci);

It is not safe to ignore failures during resume. Because, if a device gets
removed during suspend, the link up error will be unnoticed. I've proposed a
different logic in this series, which should address your issue:
https://lore.kernel.org/linux-pci/20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com/

Please test it out.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

