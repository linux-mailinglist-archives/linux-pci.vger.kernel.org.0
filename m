Return-Path: <linux-pci+bounces-39940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6364C25CB5
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B20E34F7599
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC006229B2A;
	Fri, 31 Oct 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVNzPGI5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CEF1CBEAA;
	Fri, 31 Oct 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923347; cv=none; b=gMB7AC9SNzaf2EE+4v3rwO1CH7rAFSAesRHMdblGRvgjrrKzffxjYSXxYVuV/ZBEcoiWpemvNefEVaVrEUU1r3HCUEsG3Xp2tSFfAZGWb2GLPvPb18n9k20sx6Orrna7mLZ7m80aEFHPdn0zYRWcsgnJMPlbVcoT7K8YDN94KO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923347; c=relaxed/simple;
	bh=dsl1X60Vh2ZeNLMhUsaAvRkzH1LwyS7ZETYmT0LfrBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omvs0eEucmPhEBk4nt2Gyv8YE8b9lffY1e6yX98RKaXFR2YaF4ZAHDVIVVj0yJ0h4y5UsFO1El04BEjPltbd+zwJvrE1rEA04i0zAIXa06V7spBEADcOMS2eApcWZSZZSRFutRPD+ABd56Oh15UnZJgXNPcLzrD0Yv3bziud8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVNzPGI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504C7C4CEE7;
	Fri, 31 Oct 2025 15:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761923347;
	bh=dsl1X60Vh2ZeNLMhUsaAvRkzH1LwyS7ZETYmT0LfrBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVNzPGI5+ZvQlLxEGKN1nU4jZfNwbhqupe4HdsG4AaDM2QnoiW2eXYPkrOdVAkdG2
	 O7TCLv4x+g45yK9AGgO11rk7RQZ6crAss8HcYt6DMZnKb+VzIn4zRbl03HZ5OOLSZy
	 CwKaFBoDCEypMVjvqlkEwQjI75PfRxkHpMhBQwBP+96sFVmQhIp/P7VBaXroOTYuzk
	 /8hYfSK6sf80lVoVjS7LUljsnKOA6Qg3Lb638AeR4dJlkGppKLkxJLmHXrZnB3HA7I
	 RH5HVpBQxJr1hDpaoXaAJlm8IWjlKkAA6lqqgXk5WKTIpPu3Bed2fVw6KY+AFEOHez
	 DhAnnSH1ufjxA==
Date: Fri, 31 Oct 2025 20:38:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Anand Moon <linux.amoon@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for
 resource cleanup
Message-ID: <ushhqxwggsmji2vfhk2onb7yzme2ajziruvynlkvfbhaxxk3ht@5ov7qn6i3i52>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com>
 <b2micr4atfax2sgolsublmjk4kwvbmdnqjlk2lb7cflzeycm5i@bi62lg75ilo6>
 <15087240.uLZWGnKmhe@workhorse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15087240.uLZWGnKmhe@workhorse>

On Fri, Oct 31, 2025 at 01:29:25PM +0100, Nicolas Frattaroli wrote:
> On Friday, 31 October 2025 09:36:05 Central European Standard Time Manivannan Sadhasivam wrote:
> > On Mon, Oct 27, 2025 at 08:25:29PM +0530, Anand Moon wrote:
> > > Introduce a .remove() callback to the Rockchip DesignWare PCIe
> > > controller driver to ensure proper resource deinitialization during
> > > device removal. This includes disabling clocks and deinitializing the
> > > PCIe PHY.
> > > 
> > 
> > How can you remove a driver that is only built-in? You are just sending some
> > pointless patches that were not tested and does not make sense at all.
> 
> The better question would be: why does Kconfig make PCIE_ROCKCHIP_DW
> a bool rather than a tristate? I see other PCIE_DW drivers using
> tristate, so this doesn't seem like a technical limitation with the
> IP.
> 

The limitation is due to irqchip maintainers not allowing (or recommending) to
remove a controller driver which implements an irqchip. So if any controller
driver that does so, we make them built-in. Recently, I suggested some
controller drivers to be tristate, but without the remove() callback. This will
allow the controller drivers to be built as a module, but not get removed
during runtime.

The reason why an irqchip controller should not be removed during runtime is
that the concerns around disposing the IRQs consumed by the client drivers.
Current irqchip framework doesn't guarantee that all IRQs would be disposed when
the controller is removed.

But irrespective of the above explanation, my statement was correct that this
patch is pointless.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

