Return-Path: <linux-pci+bounces-6250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E28A5281
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857341F22E27
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DE73514;
	Mon, 15 Apr 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSbVVUT/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C773196;
	Mon, 15 Apr 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189630; cv=none; b=msfZHb0yKz0vEh4CmS6C4jg50Kesn1CucVEWeaMAihpUWm7Slw6l2TshPuyfc+h+Wrb3AHqYoRn86FbD0Ni11nLeeubc76SOrbaq4LmSGTEQT3AOGBZjkgIlX3GMsVHcwG7BxojOd80UgbAH31BzYsnzQnN08kE5u3zHWoytw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189630; c=relaxed/simple;
	bh=vUMXX+OgsKDFjriUPXzBwg0hyHz5um7sSrP3ByWxMtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT+QTQ2M9v2g1FkQx0K5rUA/G6zVY87+axuWQv9DFWrRxgc5xF8UtohvOZDiUXGiDCXHHQ8sQU+2Z5AFejTd33AJmDc4PHV2VvHDvN0ey9rRMKPPQnpSh46t1Z8zfuCsNGNIcCclM7VppkOh+6mp8lvAmb+FXaYgBdpBXICzSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSbVVUT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE32C113CC;
	Mon, 15 Apr 2024 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713189629;
	bh=vUMXX+OgsKDFjriUPXzBwg0hyHz5um7sSrP3ByWxMtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSbVVUT/4O8CWWGyMHoZTZGbTja7KlLC+eTrlDIe7uQpHmiMUwxOMo9nNqqNtBHCM
	 f0Yik9mTfrz/vmnMcHyrxCQ8WhYFMxN3fxIkqRNqPWxu0ZeIfqNcNEdZkkeMeGTOLX
	 jIOWZp/+dDcXG/znc304kX2D2TjXDBJqVy9pI4MMQVSnG+1UX8FTfk96Gq7795b6Kx
	 3EX6QiFGVPh0YCWMK+1VL8vr2s8cVUePkED2SMZYXUSRR/8Dlh3GDq1uk1fWqrdoCl
	 fTSUvxJf/lxnj1lCskcjF47NmnYnbl9ztuqRhAZxknTZhTHnFDz4Qh56YhqQiNh48J
	 7GQtk7v8ri9Ew==
Date: Mon, 15 Apr 2024 19:30:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
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
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v12 2/8] PCI: dwc: ep: Add Kernel-doc comments for APIs
Message-ID: <20240415140015.GJ7537@thinkpad>
References: <20240327-pci-dbi-rework-v12-2-082625472414@linaro.org>
 <20240412195836.GA13344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412195836.GA13344@bhelgaas>

On Fri, Apr 12, 2024 at 02:58:36PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 27, 2024 at 02:43:31PM +0530, Manivannan Sadhasivam wrote:
> > All of the APIs are missing the Kernel-doc comments. Hence, add them.
> 
> > + * dw_pcie_ep_reset_bar - Reset endpoint BAR
> 
> Apparently this resets @bar for every function of the device, so it's
> not just a single BAR?
> 

Right. It should've been 'Reset endpoint BARs'. And the API name is also
misleading, but that is not the scope of this series.

> > + * dw_pcie_ep_raise_intx_irq - Raise INTx IRQ to the host
> > + * @ep: DWC EP device
> > + * @func_no: Function number of the endpoint
> > + *
> > + * Return: 0 if success, errono otherwise.
> 
> s/errono/errno/ (another instance below)
> 

ah, thanks for spotting. Since this series is already merged, I hope Krzysztof
can ammend this.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

