Return-Path: <linux-pci+bounces-4411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC986FF77
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 11:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6776B23555
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEAB374DE;
	Mon,  4 Mar 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUdmHlqm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF737179;
	Mon,  4 Mar 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549475; cv=none; b=SJeo26ych6EY9cio9pW+GJcXDJCs9FMMCAgdIeQXsC1/FLnKCyrlz7b+M89jVJ1H7uWLP35l0D3kLGRCd1itT3Okw60Brl2ux6qKTv4AoGM1HTPZhBn/R/Z0LqZ9k6tOi5hKDSjQmLXSEo2e4kSAmO553+haNqqSmQFdiPj8FRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549475; c=relaxed/simple;
	bh=1zd3GVu3Rm2C+KWSEoGXpIwLN5A0GfhS1q9Aw+9W7rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsUQsjq6UZEDVIxOkSKPP0PsimzuKjbz6a8F3nMUWLxxmQIGQCN0qjuQR2a5re6T27Ur6ZcwixLICy8VFFlDHjKiBgvXquP0mkQPH4LB/uB/MG0nvEajr5CVWPE90xZ3DLGySFc0/VE6B+y+8bG93xnw18SsTuyR1m9RaFRDmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUdmHlqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB22C433F1;
	Mon,  4 Mar 2024 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709549475;
	bh=1zd3GVu3Rm2C+KWSEoGXpIwLN5A0GfhS1q9Aw+9W7rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUdmHlqmjdF9sVcEjisGPLRse7lw64LkirsFmw8ShEDmhnEjzp+/xEafNTJlZcV0Y
	 dZe7GxwvZCcDsFMuNpeI/TBwtkXIQfhyEmx2XSYukzbvJ2wo7p+6JOKdVe9r9toohS
	 NlTeaFLYq74S/3aEiVdhGrcxHA+8HRd3jOHW7ID/kFX181CUuQt3Af87RQlcW0AV8Y
	 8kdxJIksuaKE5Ts22TYEpnkd0vBxLtG3xh0tytDO0EoHd+LsQIFDr+ctBOLe3l4hdx
	 K6a+Q6vuqbd6IvLegVq8GqYu9Apf58BPfO3BJ5lX9OF7SPNebpBmSvqGTFOLTQKZJX
	 LXYTijmD2A6Xw==
Date: Mon, 4 Mar 2024 11:51:04 +0100
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
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 03/10] PCI: dwc: ep: Introduce dw_pcie_ep_cleanup()
 API for drivers supporting PERST#
Message-ID: <ZeWnmLjS0O8CYQYg@fedora>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-3-64c7fd0cfe64@linaro.org>
 <ZeB7PQtkDSoCzE1Z@fedora>
 <20240304081713.GH2647@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304081713.GH2647@thinkpad>

On Mon, Mar 04, 2024 at 01:47:13PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 29, 2024 at 01:40:29PM +0100, Niklas Cassel wrote:
> > On Sat, Feb 24, 2024 at 12:24:09PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Since e.g. qcom-ep.c does a reset_control_assert() during perst
> > assert/deassert, which should clear sticky registers, I think that
> > you should let dw_pcie_ep_cleanup() clean up the BARs using
> > dw_pcie_ep_clear_bar().
> > 
> 
> As I mentioned earlier, it is the job of the EPF drivers to clear the BARs since
> they allocate them. I'm trying to reduce the implicit resetting wherever we
> could.
> 
> The proper fix is to add the LINK_DOWN callback to EPF drivers and do cleanup.
> I'm planning to submit a series for that after this one.

Currently, pci-epf-test allocates memory for the BARs in .bind().
Likewise it frees the memory for the BARs in .unbind().

AFAICT, most iATU registers, and most BAR registers are sticky registers,
so they will not get reset on link down.
(The currently selected BAR size, in case of Resizable BAR is an exception.)

That means that even on link down, we do not need to free the memory,
or change the iATU settings. (This applies to all drivers.)



However, on PERST (for the drivers call dw_pcie_ep_cleanup()), they call
reset_control_assert(), so they will clear sticky registers, which means
that they need to at least re-write the iATU and BAR registers.
(I guess they could free + allocate the memory for the BARs again,
but I don't think that is strictly necessary.)
That is why I suggested that you call dw_pcie_ep_clear_bar() from
dw_pcie_ep_cleanup().



If you free the memory for the BARs in link_down() (this callback exists
for many drivers, even drivers without a PERST handler), where are you
supposted to alloc the memory for the BARs again?

Allocating them at link_up() is too late (because as soon as the link is
up, the host is allowed to enumerate the EP BARs.) The proper place is to
allocate them when receiving PERST, but not all drivers have a PERST handler.

(My understanding is that 1) PERST assert 2) PERST deassert 3) link is up.)



unbind() undos what was done in bind(), so shouldn't link_down() undo what was
done in link_up()? With that logic, if you move the alloc to .core_init(),
should we perhaps have a .core_deinit() callback for EPF drivers?
(I guess only drivers which perform a reset during PERST would call this.)

But considering that free+alloc is not strictly needed, why not just keep
the allocation + free in .bind()/.unbind() ?
(To avoid the need to create a .core_deinit()), and let dw_pcie_ep_cleanup()
call dw_pcie_ep_clear_bar() ?

I guess my point is that it seems a bit pointless for drivers that do not
clear sticky registers to free+alloc memory on link down, for no good
reason. (Memory might get fragmented over time, so it might not be possible
to perform a big allocation after the device has been running for a really
long time.)



So I'm thinking that we either
1) Keep the alloc/free in bind/unbind, and let dw_pcie_ep_cleanup() call
dw_pcie_ep_clear_bar(),
or
2) Introduce a .deinit_core() callback which will free the BARs.
(Because I don't see how you will (re-)allocate memory for all drivers
if you free the memory in link_down().)


Kind regards,
Niklas

