Return-Path: <linux-pci+bounces-13068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8730976172
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 08:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D73A1F21FB7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 06:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF8918A6BB;
	Thu, 12 Sep 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUTly5UI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26222146A6F;
	Thu, 12 Sep 2024 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122319; cv=none; b=RTprIwDr5BiMveSwJckEvk0Ic6nyY37KaCmiuFIRP0codZ+lbOVFPPbYhwjiNGZ9Cn2U8HbP+PQf6gzviZU0WuPcEo51Qtb3HGJZWCJr1nFOnCuQVvthWis1zm5msylKRBdiveCznvEXPYg/J2/98fA2TDV8MI3WsiDcU60oYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122319; c=relaxed/simple;
	bh=ziEohxVPR+6bo8E2GFrPEF7zYu5BBVJvQxhslGXTv9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5u1Nb3rjuaZAwv5/JCmHbmOFxVlORnILgZPbJGzVGl+Ongin0hpIE1Zsp/PF9HVy1rO++GscXyBQa2JcRU8aV7FmtNiQmVQH8NMhF2iSWwWiIaGkMJFbkvQrWOxh8hd1u/rV+ts0PlWt0K6ynMDA2zT5jQJYexk4Ig4Tsdbtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUTly5UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C52C4CEC3;
	Thu, 12 Sep 2024 06:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726122318;
	bh=ziEohxVPR+6bo8E2GFrPEF7zYu5BBVJvQxhslGXTv9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUTly5UIMz6Dw0IHDbiFScj9NujeUIwbml9jqt1KLsHAG68Ugb4gWH4JXwIOV5nMF
	 awiXUIbHHi4jprEHHd6HVDIVi5gVmLNyO5qoCysHtElQkA8H/Kti/kOG/RVm1aV9jL
	 QZjwQ5DboOgbAEoKuAnBI6jwtYxJegrCTfVWxdDw3qW7QKwZKMK8N/JATey95rnP86
	 FitucbCq56b58b3TGFNcXbSYnSzYT2XhruiSgGSfZk4nOgLs5Ickg8IFkvYEarKKks
	 5Kkw0WmFMY5h8voaTpgSyIe3Dxlv1teEhSTX0f1DIszmtOmudjlk4rQuvPi+eAgmmG
	 6vWl/02ItogQA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sodGq-0000000050K-42TT;
	Thu, 12 Sep 2024 08:25:37 +0200
Date: Thu, 12 Sep 2024 08:25:36 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, abel.vesa@linaro.org,
	johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-tegra@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: qcom: Add 16.0 GT/s equalization and
 margining settings
Message-ID: <ZuKJYGVwXrvAuRIv@hovoldconsulting.com>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>

On Wed, Sep 11, 2024 at 08:56:25PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> This series adds 16.0 GT/s specific equalization and RX lane margining settings
> to the Qcom RC and EP drivers. This series is mandatory for the stable operation
> of the PCIe link at 16.0 GT/s on the Qcom platforms.

> Manivannan Sadhasivam (2):
>       PCI: dwc: Rename 'dw_pcie::link_gen' to 'dw_pcie::max_link_speed'
>       PCI: dwc: Always cache the maximum link speed value in dw_pcie::max_link_speed
> 
> Shashank Babu Chinta Venkata (2):
>       PCI: qcom: Add equalization settings for 16.0 GT/s
>       PCI: qcom: Add RX lane margining settings for 16.0 GT/s

Thanks for respinning, Mani.

Bjorn, it would be great to have these in 6.12 since we're currently
seeing lots of NVMe link errors on x1e80100 platforms (e.g. the Lenovo
ThinkPad T14s) without them.

These errors are also blocking the enabling of using the GIC ITS for
interrupts since that will cause all these AER reports to spam the
logs. So if you pick this one up, please consider also picking up:

	https://lore.kernel.org/lkml/20240711090250.20827-1-johan+linaro@kernel.org/

[ Note that the later added PCIe5 RC does not currently support ITS. ]

Also note that users of these machines have been running with ITS
support enabled for months now when using my x1e80100 wip branches, such
as:

	https://github.com/jhovold/linux/tree/wip/x1e80100-6.11-rc7

So this is all quite well-tested by now.

Johan

