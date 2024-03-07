Return-Path: <linux-pci+bounces-4621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E287590B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7651F250D5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621A13A27E;
	Thu,  7 Mar 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uphpTuhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7D12BE9A;
	Thu,  7 Mar 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845758; cv=none; b=O28tHCZMVKxiyqqtFYUBcbYRWrg2YnWkylHodQ+GxreG+7PSy2H+LstzsETW0URSG9CEw2BdPj+33fmGL/XZOl3EI0OX4iQzNNbK3wvkMZxcwO1VhOxKHPPhDMxROHAepl0JoIGCVbJLIiJ+71wvByx3yfBytzHITAd0es1B92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845758; c=relaxed/simple;
	bh=x7qhL0+safPdNgJNsRsxVMft7a6MYJn2kbDJJU6030c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ1o9mw0qYUio4D1El1vzaqzLAZBBrwkgSn8Hcrsu7znwAmTiB4lznAsiBZCYa2aDbkGJ+u+1wbBni9huYMzRHdBnXxf5KoMI0n271fyanuZLj+Mv84I8SbWyHBYl1pbjhYb2v8lFzEXgEYPYf31vbAc5MBmui7IIVIgA0ySLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uphpTuhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125A9C433F1;
	Thu,  7 Mar 2024 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709845757;
	bh=x7qhL0+safPdNgJNsRsxVMft7a6MYJn2kbDJJU6030c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uphpTuhlD5OPOMRvy9lge5bafam+otT0YytPtZQK/FyriaS55FiTX6G7Nn2qGjvdc
	 IIWvg5Oo3xznyGBP/6Nk1rgf7lPR0xR7CwV8v3JZq+seM6NIq4XCFwwu8rShA4KbsY
	 97+Ieb66fBKAEoPbnmBNuY7+LL61FOjf68d1wPnYX8ZsxCxRaMrr4F95CiOfasMtte
	 JtP0yamORfamOObBNlRnoza4jXckh3dQCjYDHU6zZTOql6um/J7Dgx+UhkxqvT5T1V
	 IvDgDi2O3QnFnLrLLLSx4azOsqi+b/S7O/ntH6YDYLmskuJPnekIAkbbrWNGLoKD/u
	 1loGhWdx7fEEw==
Date: Thu, 7 Mar 2024 22:09:06 +0100
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
Message-ID: <Zeos8kVxgchH9veF@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:19PM +0530, Manivannan Sadhasivam wrote:
> "core_init_notifier" flag is set by the glue drivers requiring refclk from
> the host to complete the DWC core initialization. Also, those drivers will
> send a notification to the EPF drivers once the initialization is fully
> completed using the pci_epc_init_notify() API. Only then, the EPF drivers
> will start functioning.
> 
> For the rest of the drivers generating refclk locally, EPF drivers will
> start functioning post binding with them. EPF drivers rely on the
> 'core_init_notifier' flag to differentiate between the drivers.
> Unfortunately, this creates two different flows for the EPF drivers.
> 
> So to avoid that, let's get rid of the "core_init_notifier" flag and follow
> a single initialization flow for the EPF drivers. This is done by calling
> the dw_pcie_ep_init_notify() from all glue drivers after the completion of
> dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
> send the notification to the EPF drivers once the initialization is fully
> completed.
> 
> Only difference here is that, the drivers requiring refclk from host will
> send the notification once refclk is received, while others will send it
> during probe time itself.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

You have removed the .core_init_notifier from EPC drivers,
but the callback in EPF drivers is still called .core_init.

Yes, this was a confusing name even before this patch, but
after this patch, it is probably even worse :)

The callback should be named from the perspective of EPF drivers IMO.
.core_init sounds like a EPF driver should initialize the core.
(But that is of course done by the EPC driver.)

The .link_up() callback name is better, the EPF driver is informed
that the link is up.

Perhaps we could rename .core_init to .core_up ?

It tells the EPF drivers that the core is now up.
(And the EPF driver can configure the BARs.)


Considering that you are not changing the name of the callback,
and that it was already confusing before this patch:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

