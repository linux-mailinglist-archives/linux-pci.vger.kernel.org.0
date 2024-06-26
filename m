Return-Path: <linux-pci+bounces-9330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D4918E0A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718061C2129E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E1190477;
	Wed, 26 Jun 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezj+YOU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC3190468;
	Wed, 26 Jun 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425644; cv=none; b=EbI3qEFGWO/xmf1+mOAfLXageUct2kJ9LbS62r5VtoduDYT1SMsXUL4WecUScZJVaIa8qon9mWPLWPir6ABAQrN0XwyTrtwvCtjtk8cJGODaIDm9x79OPYlhyvtsMNgK9ywl3o7V8GEkAAj+WRHBA03IOFxoHCQCQgefu2xQlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425644; c=relaxed/simple;
	bh=rnYZvmGyDNq8xfBi6C7Yxb+Ot23j2bg3S2904FoWIz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov1EJXTBxQOF6YRfOpp3V44Js/WDGwRqjG9GcgBRm977Y88wvKOpMCKFKuu0Zk2X0/ZziHjVmWFhgfSkhX1InQuTuemNAPmYFL0xsZaIqv6miYSgnz40MwVguLAZd3r6q52PAXHrFBzJpmT6oSbHNqdnm11QmdMurKsaRCToDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezj+YOU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E47C32789;
	Wed, 26 Jun 2024 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719425643;
	bh=rnYZvmGyDNq8xfBi6C7Yxb+Ot23j2bg3S2904FoWIz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ezj+YOU8QS9xtM8Dxi7avmcuTdWtrh7flAeUkWzTLDDrt14PzQ4HSjKuhahZenZqr
	 IhOCN5GEigHuSGrqZ8eY1RFSJaF7GxDVZ+yRA9ohklwP0cLhe0XzmZ1jG9vz2p6qLl
	 cuygSPKlJvwzxooZBlPvrWJtfYotHtwR4lS/00Q6GDnwV4oXZ7O79mPkGkvRGcTQ/m
	 M9xlUMjH+sTKqiiAQgIDrqcbORNzPqroZ76lRdhi0sW5u+iMun+xBXWpQY35qWsaVi
	 ONTrTeyWBxgpBiOZ9Zxwm2jt1+Se3Qkglf3cdWpH5945mnoVg0xZ16IHEowB68HFg7
	 Tcb27QsF3RN1g==
Date: Wed, 26 Jun 2024 20:13:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode
 support
Message-ID: <ZnxaXuWaQgDr0p8e@ryzen.lan>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
 <171941553475.921128.9467465539299233735.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171941553475.921128.9467465539299233735.b4-ty@sntech.de>

On Wed, Jun 26, 2024 at 05:32:49PM +0200, Heiko Stuebner wrote:
> On Fri, 07 Jun 2024 13:14:20 +0200, Niklas Cassel wrote:
> > This series adds PCIe endpoint mode support for the rockchip rk3588 and
> > rk3568 SoCs.
> > 
> > This series is based on: pci/next
> > (git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)
> > 
> > This series can also be found in git:
> > https://github.com/floatious/linux/commits/rockchip-pcie-ep-v5
> > 
> > [...]
> 
> Applied, thanks!
> 
> [12/13] arm64: dts: rockchip: Add PCIe endpoint mode support
>         commit: 2fe9fe4e54f5763b8b681478dda9ac61fd42ecaf
> [13/13] arm64: dts: rockchip: Add rock5b overlays for PCIe endpoint mode
>         commit: 41367db58cbf51ecb89ca017b7473688345caa7b
> 
> I've dropped the overlay-symbol-enablement for now.
> As this creates massive size increases there have actually
> been concerns of things like TF-A getting overwhelmed by
> the size if I remember correctly.
> 
> In any case, right now we don't have an established way on
> how to handle overlay symbold for Rockchip boards.
> 
> For example broadcom enables symbols for all DTs, Nvidia and TI do
> it for select boards only, while for example Mediatek and Freescale
> do not handle symbols at all right now.
> 
> So I'll just postpone that decision for a bit.

Okay, I see your argument.


Thank you for applying, I just realized that rk3588.dtsi has been renamed to
rk3588-extra.dtsi, so I was about to rebase and resend these two patches.
The conflict was trivial, and it looks correct in your tree, so thanks a lot
for fixing this up!


Kind regards,
Niklas

