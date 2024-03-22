Return-Path: <linux-pci+bounces-4990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6154886AF3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D321F23E4D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36793D977;
	Fri, 22 Mar 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBBpFH4u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5D2C18D;
	Fri, 22 Mar 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105398; cv=none; b=htFze8FEf2qUqJiR3lJVCAwGqeL8uKrdklnO9T5l3cXmwRL1LO0dAYKPnXsVH+5K8eTf2+odKIXG23Zvy2DFlbzbiW2hJPYx716uIr3RQIG6NDtxXb4EuD0dJZBQsNr15iDMLeFsSR5r9+npE37we8Dc2i0cJwyTKhXUe6NTHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105398; c=relaxed/simple;
	bh=j1bJ4w42kskV9ai5cekyhLUyNo8Ucw+qxC21MeUMMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5sNsRwy4paBfhkwY919n118xOvwwwUyFw3ydvnjAqXqvks/Rb8J8+WZaEiFcCwv6qb5JzPi6MwbQPMStrc+7NJJwX+2HSl7be87Zzb5/tAzbadiOmxUp8H5pxURguFBoBeeELIDDmZjc2WpeiF18mSCjS0FLYqPYS0ArdGPj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBBpFH4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A044CC433C7;
	Fri, 22 Mar 2024 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711105398;
	bh=j1bJ4w42kskV9ai5cekyhLUyNo8Ucw+qxC21MeUMMfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBBpFH4ubCr9UE0s7VfPsPShqTptBKiky+oxr6MYRB3RFKivrooYY4krN96Ri7nb9
	 urD0mdBEEucPD6uvIlEXYT7FWNrZaA3LNKAVdfs49lmNXxyZjQdv5t4CGTSPRvj+x/
	 AxqJDnUkGVGUBzn20ssSWcezKA+RzCbvRjOpR5zFEi9ZFxC0/Jz5zD0QzRD6jjMnFa
	 C3hwF8e5x+qwY8FuY/1g5hV0XF2NmlEy8H0/6VwdzxXTHAwMUu0XcsJ3R8Yjxe5uIl
	 3tKAR7pTiiHJnOnR8ruRAe3F67uoQtegz/o1LuZUo6PvinllofVh9ellJKuNY/K1Sr
	 cLcRfzgBZNR3Q==
Date: Fri, 22 Mar 2024 12:03:07 +0100
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
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v10 7/8] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <Zf1la9ICDCHAyOit@ryzen>
References: <20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org>
 <20240314-pci-dbi-rework-v10-7-14a45c5a938e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-dbi-rework-v10-7-14a45c5a938e@linaro.org>

On Thu, Mar 14, 2024 at 01:18:05PM +0530, Manivannan Sadhasivam wrote:
> Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> drivers requiring active refclk from host. But for the other drivers, it is
> getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> that this API initializes DWC EP specific registers and that requires an
> active refclk (either from host or generated locally by endpoint itsef).
> 
> But, this causes a discrepancy among the glue drivers. So to avoid this
> confusion, let's call this API directly from all glue drivers irrespective
> of refclk dependency. Only difference here is that the drivers requiring
> refclk from host will call this API only after the refclk is received and
> other drivers without refclk dependency will call this API right after
> dw_pcie_ep_init().
> 
> With this change, the check for 'core_init_notifier' flag can now be
> dropped from dw_pcie_ep_init() API. This will also allow us to remove the
> 'core_init_notifier' flag completely in the later commits.
> 
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

