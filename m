Return-Path: <linux-pci+bounces-4646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF2876011
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027CA1F262B9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 08:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AFB23768;
	Fri,  8 Mar 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acgWSAny"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276941CA9A;
	Fri,  8 Mar 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887699; cv=none; b=ARHgPKiciQ6bX2lb+QeHfHiaaHCtntYHsfcEYBvqLTnwc2lQyUr+AS1CXpRWXUmIl4gk2wjgTWsLX6aB3cSetpSNfVf3uk7Iw5UVoSimOFZE/gMWiatYSBVdbxp1L3CEjgspgTxGFbN3MTowklKJWZ8peR01FeiQRgPZ6Hz9RMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887699; c=relaxed/simple;
	bh=Os46CKddDWTirtB0sWeRcEab98vw5dx34ifSSInDtrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEFKzwgbMkc//7WGlb5mBWWAnACs6kNvmh75CIv7itvOgNPk0F4sZfwbIE/rrXxU6Jy3UJ/T6S4HhmnD55jAi2k6AGfOzg3B/U8bqDFywZXkwZWbDpkHxaYzKcLtJG4HN9JXJjsekPSrPGAScWzmDhQQbp2fulUtpqjHAlYC5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acgWSAny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED92CC433C7;
	Fri,  8 Mar 2024 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709887698;
	bh=Os46CKddDWTirtB0sWeRcEab98vw5dx34ifSSInDtrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acgWSAnyntQI7YWkNBHe6teZXBzI+ut6mvemDrUzDs+pe3VOXto4DGWOz0dJDP3nh
	 B7lKYknLYn1z0fr85u+hCeBSHgq3TG7m8UwP77ZSlBu3bdlmkCUnnAlPGE45GjZ1A/
	 NqOlGZuJjarMerfBcmzyaGjCs/uZVvG1Uutrd7OjM/LgxcZIWlJ3PJRk/Uu4sCTTpV
	 IC3myDAxuOvPxCMsQItoG6hQETn3bK2mvnxHhylRJ32inW3B3NPoEycGeFn6bi7v+m
	 17e1XVd06boVRH7eL5z5lL0F1wAq5XsPqFzxlJi5wXVe/WDpZ97W8GgU4DCIzZs69N
	 A/tDo9imbZViQ==
Date: Fri, 8 Mar 2024 09:48:07 +0100
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
Subject: Re: [PATCH v9 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <ZerQxxfUvFm2MjqV@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>
 <Zeos8kVxgchH9veF@ryzen>
 <20240308053829.GC3789@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308053829.GC3789@thinkpad>

On Fri, Mar 08, 2024 at 11:08:29AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 07, 2024 at 10:09:06PM +0100, Niklas Cassel wrote:
> > On Mon, Mar 04, 2024 at 02:52:19PM +0530, Manivannan Sadhasivam wrote:
> > > "core_init_notifier" flag is set by the glue drivers requiring refclk from
> > > the host to complete the DWC core initialization. Also, those drivers will
> > > send a notification to the EPF drivers once the initialization is fully
> > > completed using the pci_epc_init_notify() API. Only then, the EPF drivers
> > > will start functioning.
> > > 
> > > For the rest of the drivers generating refclk locally, EPF drivers will
> > > start functioning post binding with them. EPF drivers rely on the
> > > 'core_init_notifier' flag to differentiate between the drivers.
> > > Unfortunately, this creates two different flows for the EPF drivers.
> > > 
> > > So to avoid that, let's get rid of the "core_init_notifier" flag and follow
> > > a single initialization flow for the EPF drivers. This is done by calling
> > > the dw_pcie_ep_init_notify() from all glue drivers after the completion of
> > > dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
> > > send the notification to the EPF drivers once the initialization is fully
> > > completed.
> > > 
> > > Only difference here is that, the drivers requiring refclk from host will
> > > send the notification once refclk is received, while others will send it
> > > during probe time itself.
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > 
> > You have removed the .core_init_notifier from EPC drivers,
> > but the callback in EPF drivers is still called .core_init.
> > 
> > Yes, this was a confusing name even before this patch, but
> > after this patch, it is probably even worse :)
> > 
> > The callback should be named from the perspective of EPF drivers IMO.
> > .core_init sounds like a EPF driver should initialize the core.
> > (But that is of course done by the EPC driver.)
> > 
> > The .link_up() callback name is better, the EPF driver is informed
> > that the link is up.
> > 
> > Perhaps we could rename .core_init to .core_up ?
> > 
> > It tells the EPF drivers that the core is now up.
> > (And the EPF driver can configure the BARs.)
> > 
> 
> I don't disagree :) I thought about it but then decided to not extend the scope
> of this series further. So saved that for next series.
> 
> But yeah, it is good to clean it up here itself.

If you intend to create a .core_deinit or .core_down (or whatever name
you decide on), perhaps it is better to leave this cleanup to be part
of that same series?


Kind regards,
Niklas

