Return-Path: <linux-pci+bounces-22372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D16A448E3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04FD167FAE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720A199FD0;
	Tue, 25 Feb 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN957pH2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDED19992C;
	Tue, 25 Feb 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505627; cv=none; b=lTrq43o2mUUuc7OUBqHuiH9ePphIpXFBaAPRNhEm2yhAG1+58P/jena6QV8ijM6VVk7JlBM6QVe2/fBZtWYY7R4wcQ3xOt3idsV2R4saeXU7L2TZLi5ETkO60X/lsTvuLca8iCDlGjCEoo7Kjq/NS4efODgi5wn8BoNOph5qJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505627; c=relaxed/simple;
	bh=yJ9AFWppODyVrEr9uR6wXcH0kti09dQZ8V0up06BTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ROr4kCkh24/R418sCVyZrY4Y0UsyS88UL6aaCGwU8MmvwGLi76SEOLUvVWDeHXhCYVgzHIt4Tl/tZuVujcfD/I8Z1tJRI9Q4C0pHJ78wO5i2vXZo8Vsl8Us1DHsUj0ZOiQrStd5C7GiSp0wY9HWdM7RuC1WJq6IWmRxQRup4RZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN957pH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6EFC4CEDD;
	Tue, 25 Feb 2025 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505626;
	bh=yJ9AFWppODyVrEr9uR6wXcH0kti09dQZ8V0up06BTsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nN957pH2SprSYJYtzecqNvmYr1xfpKShwYCQ2XRLS6+UM4JCpBi0befIteGe+92se
	 ctjouRWIqnpO9MFEpR8MBFtFRSoIXzG9DSWngiNb8OIhatYB0SYCAspA61xY5GxO9e
	 CPG3Et/RWGbCY2LaLcANCkNojaxC/vbmPToWYzcruc9RR6eHqPsp1BDZD+otkeM4Al
	 43tXKWg9COmTRrn+OgoK1iGCOsSBVKbNmvaVqhreyxg2T2o5/4uqEXgxdK+GYKWF1r
	 0V30/Gezrav9lTAiCAVZjiTAEMzz/ea0d6PHMz3HF1wBiHMnC03JFLnNargzkrrf7X
	 O40w2GbccO4pg==
Date: Tue, 25 Feb 2025 11:47:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 3/3] arm64: dts: mba8xx: Remove invalid propert
Message-ID: <20250225174705.GA511096@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102726.654070-4-alexander.stein@ew.tq-group.com>

Subject line could include 'disable-gpio'

And s/propert/property/

On Tue, Feb 25, 2025 at 11:27:23AM +0100, Alexander Stein wrote:
> disable-gpio is an (old) downstream kernel property, which slipped into
> DT. Remove it.

I guess the implication is that the driver has never used this.

> Fixes: c01a26b8897a ("arm64: dts: mba8xx: Add PCIe support")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/mba8xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> index 117f657283191..c4b5663949ade 100644
> --- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
> @@ -328,7 +328,6 @@ &pcieb {
>  	pinctrl-0 = <&pinctrl_pcieb>;
>  	pinctrl-names = "default";
>  	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> -	disable-gpio = <&expander 7 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcie_1v5>;
>  	status = "okay";
>  };
> -- 
> 2.43.0
> 

