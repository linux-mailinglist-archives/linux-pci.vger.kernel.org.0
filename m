Return-Path: <linux-pci+bounces-4615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7C875798
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B0B23DE0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6E1386B9;
	Thu,  7 Mar 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZm2YSwS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF6137C42;
	Thu,  7 Mar 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841162; cv=none; b=hb8hODoA+whsFIAgnMGa4gGnyMWtTeqNoJIEu9g7XvM9OXqoyx5l9mdXcz+JyW7A830HjC8/gwKsU9b5i1rZ2xp1+/q6si+embIMj+seHKzyBNF0ruQBuBajkrX1Dk5DLnoE85Ir0OvwV6/7F3Tq8aZTCz+9nqEtPEKNRWI+fxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841162; c=relaxed/simple;
	bh=abVM7Az8c+fwhJYNf8SjY0MPBlfozwtnuPRGUqiuFH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejbGhXuIsYrpA+6VzfyjocJNZUAKMGufA+5bdAEnnSm7W0aWbCFrVZBAkzTIqQGaVtl0aHJUOB0gAKl4KhYU4yugbUXtw2k/7AKIx8Kybsd5Tgei3VtlQylmEAxiTCujg9/gEn76mSIN9ZYu0QL4wivX6J1aqRXfyczFG8shlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZm2YSwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C0C433F1;
	Thu,  7 Mar 2024 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841161;
	bh=abVM7Az8c+fwhJYNf8SjY0MPBlfozwtnuPRGUqiuFH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZm2YSwSeAjDl/IxeY39+GMpbM8g/8yLdpNPzBh9Kp9OI7lIHdGVkI0W/SiXGXlVY
	 8Ye4MdEO3tCq/Rskx6KQb/6n0TYuz5hgFRUTqcPq5lMDRZ4e68xdlI+OtljF8BrAhW
	 uU3G/XKfd2W+GAEpIvJOH8/VjiPRvy3xkmXqZ6ZJN16Jj5szHjOqM4WehX4qqAwgUo
	 lK6yFgKRk4vAkGPgD4jvralrfWKvR87DyZ2a62ltCqD/q4ZXANAZfTOlh9cdeyaotn
	 gMKzIMKEyAbzGgl9wgZHgDfKWgZnsBm8mLkobnvwBY2pLtH90c8M7zCL36b5O9cGzO
	 9MQH5Xf1EoKww==
Date: Thu, 7 Mar 2024 20:52:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 01/10] PCI: dwc: ep: Remove deinit() callback from
 struct dw_pcie_ep_ops
Message-ID: <ZeoaOn2dekvBD8ae@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-1-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-1-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:13PM +0530, Manivannan Sadhasivam wrote:
> deinit() callback was solely introduced for the pcie-rcar-gen4 driver where
> it is used to do platform specific resource deallocation. And this callback
> is called right at the end of the dw_pcie_ep_exit() API. So it doesn't
> matter whether it is called within or outside of dw_pcie_ep_exit() API.
> 
> So let's remove this callback and directly call rcar_gen4_pcie_ep_deinit()
> in pcie-rcar-gen4 driver to do resource deallocation after the completion
> of dw_pcie_ep_exit() API in rcar_gen4_remove_dw_pcie_ep().
> 
> This simplifies the DWC layer.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

