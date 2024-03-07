Return-Path: <linux-pci+bounces-4625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A48759D0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B412844C7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B360139597;
	Thu,  7 Mar 2024 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxaaxpXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64B131E3C;
	Thu,  7 Mar 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848703; cv=none; b=jvmNF+X99akSIi2LUPQ6wOo+NOzpWofo51jmjevuszYyI4SyiJEmzzqUZg/i8jve4Tj7ro+MZLX0OMddtR83y3BnvH140eDpmfE9z8+l1774J1uGnHJhhZXpHHg4w4WfWot5SnOs2KNjAVmddmr7Un01XtloFNa/9WwTVCarL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848703; c=relaxed/simple;
	bh=IpMGeN0v86/rzAMDiUJQ+cVemf+jJKKFwIKCFoUkZTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI1XDzAvL6IpgTgkRAchJVbTM9o5YEYgsHJnR5jp3eq4L/6yAjflTvwdorsWnwrrUaIS60cAbNjwwkqGk7aEgKnBaBElYqc02YIuY87To8Xgb+wXe8nJR9AYT3Ru7CPzWWrJm6IUbf65FMqWapQdW87HBuJ31U4AS7iQ9nqSpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxaaxpXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0467CC433C7;
	Thu,  7 Mar 2024 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848702;
	bh=IpMGeN0v86/rzAMDiUJQ+cVemf+jJKKFwIKCFoUkZTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxaaxpXHbcwdgPBCqzL3ip4FfS+wwgyZXqW8N8LcK6fP7E3VpoZqDHneR1dd1Xrej
	 WlhBbqSPrM8jK9BJ2CNbm0PQxpC2owo7XLjSqOdrLbuwv5hYXvRYOCPbR1lseTm+lm
	 VqRwXX89Ybnc+o3+MwNbgMhEL3RoQsE5RCRDUDwhBk88OxG95EAluIIMxeXPJNzTfJ
	 xn5x8uaGoDrlqvoXzTQH3DobEay96Lt8ukZK4sO6AxfMPbTZXLi096HQUATFULKEAk
	 NN3FHdZNMxE7mUyR2y+Hg6twSl77vAinM6S2WxrzEAkUA9Ziwka71eJzu4vJy7VSud
	 o4JGQD6O5Yeew==
Date: Thu, 7 Mar 2024 22:58:12 +0100
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
Subject: Re: [PATCH v9 10/10] PCI: dwc: ep: Add Kernel-doc comments for APIs
Message-ID: <Zeo4dJGZYLnLfzjm@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-10-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-10-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:22PM +0530, Manivannan Sadhasivam wrote:
> All of the APIs are missing the Kernel-doc comments. Hence, add them.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

For the functions that you added in this series, e.g.
dw_pcie_ep_cleanup(), dw_pcie_ep_init_non_sticky_registers(),
and dw_pcie_ep_linkdown(), I think that it would have been
better if you actually added the kdoc in the same commit that
added the respective function.


For the existing functions that did not have a kdoc, I think
it would have been better if you fixed this as patch 1/10 in
this series. (Or 2/10, in case you keep the Fixes tag for the
"PCI: dwc: ep: Fix DBI access failure for drivers requiring
refclk from host" patch.)

Yes, I know that you rename some of these functions that
lacked kdoc later in the series, but the whole kdoc description
would be the same, the kdoc parameters would be the same, and the
kdoc return value would be the same.

If you later rename a function, you would only need to change
the kdoc function name (in addition to the function declaration
itself).


Kind regards,
Niklas

