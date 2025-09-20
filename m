Return-Path: <linux-pci+bounces-36561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE1B8C0AC
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186CD587CE3
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8C23D7D6;
	Sat, 20 Sep 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXHssqsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747C2405E3;
	Sat, 20 Sep 2025 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349815; cv=none; b=sJqpcW8tXXkUyZsOrmwDR1y20ksxJtpn32oX0GarIgMMi1F+r0bB7n7bIpMFxONIIt6l++gmHdW8gssfHl6jJ1y/AAflUOcNpN8ZYtEhs/f0hW5OM/riBJrRnV4qxH1q6/zm7jhPKesh5MYUeHOiKH7KdqrOcKrVgl88IuS2Yk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349815; c=relaxed/simple;
	bh=2k5IAu27hx+JRHKzZ8QOmu78VZOavxLARXFZgcU9fYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGjTGDWDhSQ8rf2QmzdqRZl0bZON2EcaushFYJPtalbW3v0W+U5QsO9A2JAYmaLyLFRqPSNMervWhze3zcl8Gd6LH9oL4k18w5Pnntyz8ohCU3icqCZATmqspjxV2WBaKhvdsyj/vavePaBtXTBSamVFHvUVLC7DaVU+sil3Jhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXHssqsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C2FC4CEEB;
	Sat, 20 Sep 2025 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758349814;
	bh=2k5IAu27hx+JRHKzZ8QOmu78VZOavxLARXFZgcU9fYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXHssqsiBIowA8JUuWIXSrjdL5B9O09OGaKPzRIp5uFgELwA335L63yPiaqCW9pHq
	 gi+ExuCPgiLttYYWNLoMhjLw0VPwECdPOyoM5fYWmdeZ1yALzQrMZoimYEC98ddTyb
	 pl1TFHgwel2klKU5Bk+LsbglO6nPlK9GLcmrjsibJ9JAKo0vcIoVCMxzs2SzcANm6D
	 rvmOyfqOSCWVdfsPtR3KiHWdE0+hxdZkF9j1IgP5hEQhBUJhzBtIxxnOaHcoJYqsFF
	 ihMfe76aMzqKBLA3RIwteKNpGbhdsnKY4J2zl0Ds7+nBvGpv9hRHX8HZK8TWYu9Obn
	 Lo2H+XNLpMNRw==
Date: Sat, 20 Sep 2025 12:00:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe
 in PM operations
Message-ID: <jwvprh7rvvzwxb5bsny5h3s74srbifurlusbpniupf4uujkflk@caaxxgw7xebq>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902080151.3748965-4-hongxing.zhu@nxp.com>

On Tue, Sep 02, 2025 at 04:01:48PM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> 
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
> 
> The LTSSM states of i.MX6QP PCIe are inaccessible after the PME_Turn_Off
> is kicked off. To handle this case, don't poll L2 state and add one max
> 10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Squash this patch with the previous one.

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80e48746bbaf..18b97bd0462b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
>  	enum imx_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
>  	u32 flags;
> +	u32 quirk;
>  	int dbi_length;
>  	const char *gpr;
>  	const u32 ltssm_off;
> @@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pci->quirk_flag = imx_pcie->drvdata->quirk;
>  	pci->use_parent_dt_ranges = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
> @@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  		.core_reset = imx6qp_pcie_core_reset,
>  		.ops = &imx_pcie_host_ops,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

