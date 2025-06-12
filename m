Return-Path: <linux-pci+bounces-29547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EEFAD70F9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC81BC6968
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB723BF91;
	Thu, 12 Jun 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFwezS59"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9D23ABAD
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733246; cv=none; b=IX/t1jGIZWhZiQqQa0NXHLEzwpUjMjXd0Njy7unqnRroCj4ioVe7X9z5XlZNCBq3FxQTUP3kI1p1+yEIB3V8j1ZxDufV6MdQyZwiG9Tk8glkJOKOPerLQc/9zhHFtXUThPC+HvnJsqV+RGJDD5CRsQywNnZsKGjdgzWbRTiqmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733246; c=relaxed/simple;
	bh=98J4zwVuQp/nbB05Jiw3q7/W838MgXOQSKEV80NOtco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRy8f5803xc2nw2bAkt1ZzebAOLYUGympdcQ4ilX0kC3XC0Dv+nT4h/orf0AYYINxfWMeQg3KM6HqXGUWn5wmB2Quv7NuaOm4gTXavOrRPp8QvL7nE+kw/cqk/ar4FRrD3rEc1AYA2uXksXHET09T4C0JO81OJV3uqhkDWf0OJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFwezS59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97055C4CEEA;
	Thu, 12 Jun 2025 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749733246;
	bh=98J4zwVuQp/nbB05Jiw3q7/W838MgXOQSKEV80NOtco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFwezS59tRXNI07znkqsGmf11eibxUmJ5WAEOCUQNxsdiVh8uUUbkBCWCuyBHBeHa
	 0Y1M4y5lvUb8GEQ4p0gZ8vtrGlzLnhgtGY8k7DlduItEx+B8IpVpBJbHbDB1rL35wS
	 HQoD/H49516e6BP4JggsLnBhRJOly71NSZ/k75QOUjAL2XYdiq/OaRBIDp5QCriqlw
	 yhnibje7Apf1SyXtYkhFl3rbU3aRF79hRHwSOTFYB4aV8ISLzkqZxhoKwmmFPrcRT2
	 S1XF1r0Mo5TPHYgsy1kNALIAAur9YJZFl8fFGTiHyUPOwMAD//EM0yDJDm5qJnPSrm
	 52ggHCrbOx54A==
Date: Thu, 12 Jun 2025 18:30:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <apkamrd6ty2km7mjwz4mpe2xhewxgd3crmeqdmnj7wn6jl4emv@3nwrt43u2ons>
References: <aEq8pxE45PmeXN_W@ryzen>
 <20250612122108.GA901642@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612122108.GA901642@bhelgaas>

On Thu, Jun 12, 2025 at 07:21:08AM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 12, 2025 at 01:40:23PM +0200, Niklas Cassel wrote:
> > On Thu, Jun 12, 2025 at 06:38:27AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Jun 12, 2025 at 01:19:45PM +0200, Niklas Cassel wrote:
> > > > On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > > > > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > > > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > > > > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > > > > > 
> > > > > > This means that there is no longer any delay between link up and the bus
> > > > > > getting enumerated.
> > > 
> > > > > I think the comment at the PCIE_T_RRS_READY_MS definition should be
> > > > > enough (although it might need to be updated to mention link-up).
> > > > > This delay is going to be a standard piece of every driver, so it
> > > > > won't require special notice.
> > > > 
> > > > Looking at pci.h, we already have a comment mentioning exactly this
> > > > (link-up):
> > > > https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63
> > > > 
> > > > I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.
> > > 
> > > I'll more closely later, but I think PCIE_T_RRS_READY_MS and
> > > PCIE_RESET_CONFIG_DEVICE_WAIT_MS are duplicates and only one should
> > > exist.  It looks like they got merged at about the same time by
> > > different people, so we didn't notice.
> > 
> > I came to the same conclusion, I will send a patch to remove
> > PCIE_T_RRS_READY_MS and convert the only existing user to use
> > PCIE_RESET_CONFIG_DEVICE_WAIT_MS.
> 
> I think PCIE_T_RRS_READY_MS expresses the purpose of the wait more
> specifically.  It's not that the device is completely ready after
> 100ms; just that it should be able to respond with RRS if it needs
> more time.

Yes, but none of the drivers are checking for the RRS status currently. So using
PCIE_T_RRS_READY_MS gives a wrong impression that the driver is waiting for the
RRS status from the device.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

