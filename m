Return-Path: <linux-pci+bounces-4431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B038704C7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 16:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00FDB25168
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C34653A;
	Mon,  4 Mar 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxfxPZyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF345945;
	Mon,  4 Mar 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564674; cv=none; b=MyarseT0/NJWJ8Es/f4QhcWN2W3sptd667CvDPvHRXq7IruECMXRP3PMwBnssMFwlpilQ+wzaqQPg4Jts185f5SucGkgytyIVqt1ii62g/CmFdN5HG7JEM5dywpx0qA9/+/vYfzfJKmaIW3sEBapWM3k2lGxVmFARpC6514VQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564674; c=relaxed/simple;
	bh=JQ0+zqW2caSPP+fUJhGdRNpSWxMzAFd26SsP97GqJ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR1moOY0oYBeeXjlCVW+u9KRBSycn/7+bQijEVwIhHWLa+IUE5JlTSFIrgDS+1dIrxcdorg9hzfeS91qWVWusT++M+T1dhAlmO8KJ6SXBTjj5DNMY8Miagx25mE91Asv3/uW444ZYMSAiB5WV7YLku6uBA1lI6IbVoZSdx++HBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxfxPZyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC42C433F1;
	Mon,  4 Mar 2024 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564673;
	bh=JQ0+zqW2caSPP+fUJhGdRNpSWxMzAFd26SsP97GqJ5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxfxPZyTJCmJ5mZxVgiJqCzXofUHAoQs7mRC4KDObSN4wZYzCp+or22QBaGGe5t9d
	 pLbvJc3JLMFgeoU1w44VMTP8tAduMKv6D3daCt6OZvQd6ZtM5E/Z97noo5A7eDc0s2
	 W+ig+U1dUuuB06z3B0xWfblUl4Qt+mYQ4jEyGRB7YwL+af8wnuI87t37LKaJhjrGoW
	 ub8JQUD6sglgIwv+HwJS9neFZqPR7gHY6wjCaYatMgn1yMmWuoNgu/qGBQDEDJSnwJ
	 1Wcb5mT3qEHKZKholtNHLHRLkFh6GvNDPtCqpZMBtwoYo84wi/8B185vMWK2kovBNR
	 BuM6Fu1YvISvg==
Date: Mon, 4 Mar 2024 20:34:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <20240304150417.GK2647@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-3-64c7fd0cfe64@linaro.org>
 <ZeB7PQtkDSoCzE1Z@fedora>
 <20240304081713.GH2647@thinkpad>
 <ZeWnmLjS0O8CYQYg@fedora>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeWnmLjS0O8CYQYg@fedora>

On Mon, Mar 04, 2024 at 11:51:04AM +0100, Niklas Cassel wrote:
> On Mon, Mar 04, 2024 at 01:47:13PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 29, 2024 at 01:40:29PM +0100, Niklas Cassel wrote:
> > > On Sat, Feb 24, 2024 at 12:24:09PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > Since e.g. qcom-ep.c does a reset_control_assert() during perst
> > > assert/deassert, which should clear sticky registers, I think that
> > > you should let dw_pcie_ep_cleanup() clean up the BARs using
> > > dw_pcie_ep_clear_bar().
> > > 
> > 
> > As I mentioned earlier, it is the job of the EPF drivers to clear the BARs since
> > they allocate them. I'm trying to reduce the implicit resetting wherever we
> > could.
> > 
> > The proper fix is to add the LINK_DOWN callback to EPF drivers and do cleanup.
> > I'm planning to submit a series for that after this one.
> 
> Currently, pci-epf-test allocates memory for the BARs in .bind().
> Likewise it frees the memory for the BARs in .unbind().
> 
> AFAICT, most iATU registers, and most BAR registers are sticky registers,
> so they will not get reset on link down.
> (The currently selected BAR size, in case of Resizable BAR is an exception.)
> 
> That means that even on link down, we do not need to free the memory,
> or change the iATU settings. (This applies to all drivers.)
> 
> 
> 
> However, on PERST (for the drivers call dw_pcie_ep_cleanup()), they call
> reset_control_assert(), so they will clear sticky registers, which means
> that they need to at least re-write the iATU and BAR registers.
> (I guess they could free + allocate the memory for the BARs again,
> but I don't think that is strictly necessary.)
> That is why I suggested that you call dw_pcie_ep_clear_bar() from
> dw_pcie_ep_cleanup().
> 

Sorry, I keep assuming the flow w.r.t PERST# supported platforms :/

My bad!

> 
> 
> If you free the memory for the BARs in link_down() (this callback exists
> for many drivers, even drivers without a PERST handler), where are you
> supposted to alloc the memory for the BARs again?
> 
> Allocating them at link_up() is too late (because as soon as the link is
> up, the host is allowed to enumerate the EP BARs.) The proper place is to
> allocate them when receiving PERST, but not all drivers have a PERST handler.
> 
> (My understanding is that 1) PERST assert 2) PERST deassert 3) link is up.)
> 
> 
> 
> unbind() undos what was done in bind(), so shouldn't link_down() undo what was
> done in link_up()? With that logic, if you move the alloc to .core_init(),
> should we perhaps have a .core_deinit() callback for EPF drivers?
> (I guess only drivers which perform a reset during PERST would call this.)
> 
> But considering that free+alloc is not strictly needed, why not just keep
> the allocation + free in .bind()/.unbind() ?
> (To avoid the need to create a .core_deinit()), and let dw_pcie_ep_cleanup()
> call dw_pcie_ep_clear_bar() ?
> 
> I guess my point is that it seems a bit pointless for drivers that do not
> clear sticky registers to free+alloc memory on link down, for no good
> reason. (Memory might get fragmented over time, so it might not be possible
> to perform a big allocation after the device has been running for a really
> long time.)
> 
> 
> 
> So I'm thinking that we either
> 1) Keep the alloc/free in bind/unbind, and let dw_pcie_ep_cleanup() call
> dw_pcie_ep_clear_bar(),
> or
> 2) Introduce a .deinit_core() callback which will free the BARs.
> (Because I don't see how you will (re-)allocate memory for all drivers
> if you free the memory in link_down().)
> 

I think option 2 is the better solution. In my view, calling
dw_pcie_ep_clear_bar() from EPC drivers is a layering violation since the
allocation happens from EPF drivers.

So clearing the BARs during the deinit() callback that gets called when PERST#
assert happens is the way to go.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

