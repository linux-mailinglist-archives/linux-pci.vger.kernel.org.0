Return-Path: <linux-pci+bounces-35466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608BCB4440C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69C6188AB8A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E431987B;
	Thu,  4 Sep 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPSwdcJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD7319866;
	Thu,  4 Sep 2025 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005786; cv=none; b=QOEoznD5XlvvLBFGW+qi/UGvDoHPfYdZb75N0zBE4aOp8dZGkMQpKsa31WZn/hNSCkVIhJCWJye7TJwTR19LR/mOxOqY0+sua/y0+h/Z48FRieV+0wCBwXu+nTCSIfhCv8gLBHNJ1kBhODIu6aWPRCW1cFm4CMhmLBTIQiAHWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005786; c=relaxed/simple;
	bh=Kb5OEk6CH681dR8WwdpshUf8PEmUll6MbXBONva8auo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW3Vlf9U2HdaU4Xt8PUiFxJ6uqawztnZ+R9yqXmigK7yGrJ43OYJ3qgdyv3V+Ai0ftn1k47rmP0176EIuzfRBjf1Uy5Pm6SkI/Wj/SJeRdkI5FG5NN+S2AGTvlOfgQjZ8WavDCU55cxvEfqqfCQf+3qlaKPYHnXc+BQ6KSHFo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPSwdcJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9297BC4CEF0;
	Thu,  4 Sep 2025 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757005786;
	bh=Kb5OEk6CH681dR8WwdpshUf8PEmUll6MbXBONva8auo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPSwdcJP4MCiJ8QOfsVD77rIQdkXbfYiHaf4DPc/qOL1RGsR7t1mB26BNa/wvie6/
	 ts8MIC5y8oLbQYvx0SMK33g32n5jSPH56QYrTHBu58/OwGaH4ZukJobGqMjoJfrDIL
	 eIi1ufaEBTSeaoJQ1Ob4zLrTGy+/35sR7cL2JoNSPhdlU8Lrll1PsE86mPd9dxw1X1
	 VsUcDNGjRIGA7Ti6yC45ONK39KNjqcXDi71D4bz33iTtNq6s/A+P/Kcuf5z57Ds/QV
	 afQ/Sn8+EkWLyvj5vV81lEF2v2UuedyRrmT89OraQjWTmYe2ZW5/pFcMeANV7zKhPt
	 aQ1vSw3Vn+lCg==
Date: Thu, 4 Sep 2025 22:39:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: imx6: Enable the vpcie3v3aux regulator when
 fetch it
Message-ID: <piirka3qlna6k33r2eutg26s2iepnvubzbdps6rh5b2tzhxxmg@c7nv3jgkwxpw>
References: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820022328.2143374-1-hongxing.zhu@nxp.com>

On Wed, Aug 20, 2025 at 10:23:28AM GMT, Richard Zhu wrote:
> Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> asserted by the Add-in Card when all its functions are in D3Cold state
> and at least one of its functions is enabled for wakeup generation. The
> 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> process.
> 
> When the 3.3V auxiliary power is present, fetch this auxiliary regulator
> at probe time and keep it enabled for the entire PCIe controller
> lifecycle. This ensures support for outbound wake-up mechanism such as
> WAKE# signaling.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v5 changes:
> - Use the vpcie3v3aux property instead of adding a duplicated one.
> - Move the comments from the code changes into the description of
>   commit.
> 
> v4 changes:
> Move the dt-binding to snps,dw-pcie-common.yaml.
> 
> v3 changes:
> Add a new vaux power supply used to specify the regulator powered up the
> WAKE# circuit on the connector when WAKE# is supported.
> 
> v2 changes:
> Update the commit message, and add reviewed-by from Frank.
> https://patchwork.kernel.org/project/linux-pci/patch/20250619072438.125921-1-hongxing.zhu@nxp.com/
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b1..5067da14bc053 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1739,6 +1739,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>  
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable pcie3v3vaux");
> +

So if Vaux is available, do we still need the IMX95_PCIE_SYS_AUX_PWR_DET setting
in imx95_pcie_init_phy()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

