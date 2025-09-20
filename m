Return-Path: <linux-pci+bounces-36562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A9B8C0B2
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2886A1BC6ABA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D0234964;
	Sat, 20 Sep 2025 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3Gvx192"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1E21C163;
	Sat, 20 Sep 2025 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349868; cv=none; b=YIRXv0aKNIEUTs/n1Hh88LVPBsd2BnzKeoP/vcchLqUgr6B0wNfb0mMZ/K0+pDxShxlwmHGFrl+9iltptxcnaiFHndS2I7Wfi/vSiybzwhl4lFulbfk7UpugFb3NcMn5gi5+7Qd3iBy7pGuxPYZr7KyivYxgXQiQtBu7Efj61E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349868; c=relaxed/simple;
	bh=6m5MeUsjHwYKpcu37nk6GaAJpIuoU6LYXn0bvV59usA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqKhWUBeFFWYObnb8OfRZGGf5WjdcoAC9oCE79+xvi155nuurxYM2es/gq+x0r3jH5wINrXApBWzBab1QcjEn2bw0YtIYMtzSS5PR0PCmFC/AXKBNKv8o1zMFt2aSx0t7vkLvl9Bl93l8ICTLw4FeHSB3wvj6xixgzbmz9FDzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3Gvx192; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ADBC4CEEB;
	Sat, 20 Sep 2025 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758349868;
	bh=6m5MeUsjHwYKpcu37nk6GaAJpIuoU6LYXn0bvV59usA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3Gvx192UmTP57TK3xRcgevRDrvN9PDsEaOCrs9cmRWFIdQrDqd/ckMreS86+4pMb
	 rlT97DJCCOb+TC6+fQGsMavVS02NQLURKGReh+aw0dCucn3kk8rrponYAMyCahXVbS
	 CzJbzXCUvO8NdVnUCr5C99wr3AWbkf94/My/23M00nMDUP8OzcdW5lnqgwyzCCL7/1
	 lAwVeymOKJsWaMn/7aq+EiHDeHuxX5CTn60vLvj+bXSBTIKa1V6eb/MwogrYkX6tzW
	 jWzAabfgDow8gTmZRlIHAkbUrQf7wldTrAzS0MOQlIyOz1SpjAaS+YDUWvb6ZVUUZ6
	 RSFDUDcoP6WfA==
Date: Sat, 20 Sep 2025 12:00:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe
 in PM operations
Message-ID: <jj2zirv5d2ly2otqyiyuid7au2lw4ygthiwhp7ptqs5lmvxbve@k43sdnqrvqx7>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902080151.3748965-5-hongxing.zhu@nxp.com>

On Tue, Sep 02, 2025 at 04:01:49PM +0800, Richard Zhu wrote:
> Add a quirk flag(QUIRK_NOL2POLL_IN_PM) for i.MX7D PCIe. Don't poll the
> LTSSM states after issue the PME_Turn_Off message.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

This one too should be squashed with patch 2.

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 18b97bd0462b..a59b5282c3cc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1863,6 +1863,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  		.core_reset = imx7d_pcie_core_reset,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

