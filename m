Return-Path: <linux-pci+bounces-19253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B54A00E55
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD55F7A0562
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F31F9F7D;
	Fri,  3 Jan 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF4GQoft"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113C1B87FA;
	Fri,  3 Jan 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931615; cv=none; b=RJqz7YMis+z+BU1TsyvFOP8TnmODNzvET6/yI3vl9mMDkDwwM6qZtJJcWUZ4lGLK3CjfyjTXFfUvJDYtdPn7U1rJ/u/6s79vbznshzmA5MXkzpVlGgLfbSwNJZO0W4SxKrB+rNj+OIKtK3VGcIGtuRzm4FfAMPj8QLZx5VOl274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931615; c=relaxed/simple;
	bh=cCfjYjHS7nqZCqHD4TvPswK9EJtkGi/Z30r+QOPZ98Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hoyWRLgCg++NRiFRvfaBf7w8GHsyoIzasDG62G/wQQk1J2QJhG8sZFnlbcorrX5XD/VBIWQSe0V5iAwHH7750a/B7EqvgVenJKASMsBF94y5X8ZCjextX/n+JXAJl/l6nZgbpAvMK8JFx/Ehh9AbfdJuOo1RHDx8LCCAVbA9pCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF4GQoft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D26FC4CECE;
	Fri,  3 Jan 2025 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735931614;
	bh=cCfjYjHS7nqZCqHD4TvPswK9EJtkGi/Z30r+QOPZ98Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BF4GQoft1riJRCZ3O/4squ29/iAvQ8H8Sc7Mi6NLamy1UIArGlEvWjQyMEKsXFua7
	 lMKh5CC8cwOz3fSHeHxi4Q1obg7LsCEs6c1+UjEw+lrRU+ptZYzfM1RYjOwDMaIPiT
	 5NHk2iONweDTr1k6PhyGYSeRb+O7eM6GJiohRirXALOse56RvuhLAizxEl+WEysfQE
	 f4TSGuqxaxvranwbnVF+5P9S5dAlFjjrMG62Vqlf8PkhFIlzwQx8YFM4qGqIYPUTrC
	 l+vjUu3hruYpDfJWfW7m/aHYbEHIXFdXI3mwZZAol99wgr0S1j54/f3OFUzXTCZj3i
	 6Ay3DfgyiJKxg==
Date: Fri, 3 Jan 2025 13:13:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 5/5] PCI: mediatek-gen3: Keep PCIe power and clocks if
 suspend-to-idle
Message-ID: <20250103191331.GA4190357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060035.30688-6-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:15PM +0800, Jianjun Wang wrote:
> If the target system sleep state is suspend-to-idle, the bridge is
> supposed to stay in D0, and the framework will not help to restore its
> configuration space, so keep its power and clocks during suspend.
> 
> It's recommended to enable L1ss support, so the link can be changed to
> L1.2 state during suspend.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 48f83c2d91f7..11da68910502 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1291,6 +1291,19 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
>  	int err;
>  	u32 val;
>  
> +	/*
> +	 * If the target system sleep state is suspend-to-idle, the bridge is supposed to stay in
> +	 * D0, and the framework will not help to restore its configuration space, so keep it's
> +	 * power and clocks during suspend.

s/it's/its/

Where does the requirement for the bridge to stay in D0 come from?  Is
that part of the Linux power management framework?  Or is this
something specific to this SoC?

I guess "framework" refers to Linux power management, so maybe that
assumes nothing needs to be restored when resuming from
suspend-to-idle?

> +	 * It's recommended to enable L1ss support, so the link can be changed to L1.2 state during
> +	 * suspend.

Wrap to fit in 80 columns like the rest of the file.

s/L1ss/L1SS/

Who recommends enabling L1SS support?  I suppose enabling L1SS means
setting CONFIG_PCIEASPM=y?

What causes the transition to L1.2?  Is this done by firmware or
something else outside of Linux?

> +	if (pm_suspend_default_s2idle()) {
> +		dev_info(dev, "System enter s2idle state, keep PCIe power and clocks\n");

1) I'm a bit dubious about this since there are only two callers of
pm_suspend_default_s2idle() in the rest of the kernel.  What's unique
about this device that requires this?  Is this an indication that
we're setting mtk_pcie_pm_ops incorrectly, i.e., are we using
mtk_pcie_suspend_noirq() for a callback that is *never* supposed to
power down the device?

2) The message seems like possible overkill, maybe could be dev_dbg()?
I'm not sure the user needs this information at every suspend/resume
transition.

> +		return 0;
> +	}
> +
>  	/* Trigger link to L2 state */
>  	err = mtk_pcie_turn_off_link(pcie);
>  	if (err) {
> @@ -1316,6 +1329,11 @@ static int mtk_pcie_resume_noirq(struct device *dev)
>  	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
>  	int err;
>  
> +	if (pm_suspend_default_s2idle()) {
> +		dev_info(dev, "System enter s2idle state, no need to reinitialization\n");
> +		return 0;
> +	}
> +
>  	err = pcie->soc->power_up(pcie);
>  	if (err)
>  		return err;
> -- 
> 2.46.0
> 

