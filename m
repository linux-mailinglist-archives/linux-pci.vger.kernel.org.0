Return-Path: <linux-pci+bounces-42077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB5C86CBD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 20:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F814353E33
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D78287246;
	Tue, 25 Nov 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG2/IxkA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD12D29C3;
	Tue, 25 Nov 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098481; cv=none; b=j1ccMC15TVNjFDISumisWI3Jh73eSL2vaxfYJOBa4m+ChCjp6cxv83PmhQcmODKMnhaNnL3RaJyO9UgmVVwf91Q90tGFizYfteIYwG4GlgvWh57qOXW0A5gF/Is6EHDDX2sREgznF7ZHQ1LB9wptH1WAILf/MScbeZpuTrU5eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098481; c=relaxed/simple;
	bh=PXaLfSUsuiuasxe8ptDZqo4sRgBk2ZXuALsf7QVCuE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rY22WP5F3lwer0kcSi953OSsNoU00NzIb4Td2CKu1Oe/lBdWX7iYoNhmoE9DEMdHCbM47VVUlizZvVAIXf236RtqF0uxe/oV1XE3QYA891FNeuJU1FzcI4zUAKY6xZT9DZQRK2yDk/YL7uEhOEY8aP2pTxecTQjqHK8W45hGW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG2/IxkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6871BC4CEF1;
	Tue, 25 Nov 2025 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764098480;
	bh=PXaLfSUsuiuasxe8ptDZqo4sRgBk2ZXuALsf7QVCuE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kG2/IxkADqb5FQMH0ZNvEne5eExlYkB9BxCdsLPKZ0R1x6U5p8Q+e/G99iz8R7gNb
	 rIjRCk5pklp168zSMPOh56TVmcGFDeoH+GTj8bnmY/awFj04R1/KK7C2aFxMd6vt+6
	 ALnCNr3KbtbzNp0iId/Bia4e8F2Izpgk53UsI6zHZP7ZYYAByceMDPDmQ+WnkuoKck
	 w4WLcMnmUJSWsDetaV/F6X3w5ISKZTIzGbAKmYkeKnXgDtpNICtEmemA0LtWSWUbe+
	 2reFteRwqJRoBVqILlw+MzmJSJM7wHn0Jb1iRJRughegNo7iqLDFOFEKS4KvrRd4zb
	 jx03grabuD6UQ==
Date: Tue, 25 Nov 2025 13:21:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
Message-ID: <20251125192119.GA2760316@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121164920.2008569-5-vincent.guittot@linaro.org>

On Fri, Nov 21, 2025 at 05:49:20PM +0100, Vincent Guittot wrote:
> Add a new entry for S32G PCIe driver.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64b94e6b5a9..bec5d5792a5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
>  F:	drivers/pinctrl/nxp/
>  F:	drivers/rtc/rtc-s32g.c
>  
> +ARM/NXP S32G PCIE CONTROLLER DRIVER
> +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>

Would be good to have Ghennadi's ack here.  Don't want to sign people
up for work they're not expecting.

> +R:	NXP S32 Linux Team <s32@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> +F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
> +
>  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>  M:	Jan Petrous <jan.petrous@oss.nxp.com>
>  R:	s32@nxp.com
> -- 
> 2.43.0
> 

