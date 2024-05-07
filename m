Return-Path: <linux-pci+bounces-7207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB88BF336
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF4F1F231F6
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292686628;
	Tue,  7 May 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCt7rlYP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE038615A;
	Tue,  7 May 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125941; cv=none; b=qLjszl9SZ5ncyhmtPqxsx2hJt9I2mbavghNoc68IL64KKIG1+4gpNciZebcMEE0/D8Z+2CuapgNxYUG9Ykup6IczbsbKY0d2YEfNq2/dq2+sJxr6GDZTQ1kHDWbbqg58/2deFTPNL/6mj4U1pAZSPboiqKMXpEoxmnwcWpebCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125941; c=relaxed/simple;
	bh=flVj7RZb0AT5hfErHsd362JN98Gup7/B3ZzRrEJKWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJDOSOncfnnkRnoNKEbcf0e4eV7/EWHgX0QuJ9jFIPipWu8k3t6y3//CovCUM7KmZh2HQqRC9UXbbJIv2bFEoFtqAqOBgBvLoGQy5wtpwGhZ/3O8719PjdzRCNMcT83xe9Z0St9fxygqLX7i8k0JJpT/OI/8/wJiliCtaJx82LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCt7rlYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2D4C2BBFC;
	Tue,  7 May 2024 23:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125940;
	bh=flVj7RZb0AT5hfErHsd362JN98Gup7/B3ZzRrEJKWBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCt7rlYPdGVR3gfL7yhbSKdrP3rjNiKyJ+kXXvhPVuBYLnyHn/QJRlcsl5CNddrb2
	 R/BoFsyGgpmZKiyuSKwTE1Kg4/k3jf7OHX+kHUMqKWR/CYl7dAcpBCCKUZpFvsiy39
	 IsD7Hblx8upmbmil4PsAibENqtxrAGBVbQYd1PxOvW+5MA9wDVfefIkx/VEJrESDB9
	 TXGgAiDNb78rVZQOod00NkCSElkjh2chYpjRIeheO78skN0KWNVn9JaySZ2qYlKjzp
	 BuZrJZGbamCSgwoKajDx6tL5c+qivWVglBzJuexqeFQzBT4RRX0J3c8gdCHblIII/y
	 ksCBwYGdiQBVA==
Date: Wed, 8 May 2024 01:52:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 14/14] arm64: dts: rockchip: Add rock5b overlays for
 PCIe endpoint mode
Message-ID: <Zjq-rqVdL0r-Wque@ryzen.lan>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-14-a0f5ee2a77b6@kernel.org>
 <20240504173730.GK4315@thinkpad>
 <2986540.X9hSmTKtgW@diego>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2986540.X9hSmTKtgW@diego>

On Sun, May 05, 2024 at 02:14:45PM +0200, Heiko Stübner wrote:
> Am Samstag, 4. Mai 2024, 19:37:30 CEST schrieb Manivannan Sadhasivam:
> > On Tue, Apr 30, 2024 at 02:01:11PM +0200, Niklas Cassel wrote:
> > > Add rock5b overlays for PCIe endpoint mode support.
> > > 
> > 
> > I'm not aware of mainline using overlays. Is this a new one?
> 
> I guess you could still call it new'ish ;-)
> 
> But the mainline kernel does carry a number of overlays already [0] .
> This does of course not handle the actual application of overlays,
> which I guess bootloaders do only at this point.

Yes, AFAICT, the actual application is handled by bootloaders.
(Well, there is a "Overlay in-kernel API", but not a user API.)


> > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > index f906a868b71a..d827432d5111 100644
> > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > @@ -117,6 +117,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
> > > @@ -127,3 +129,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
> > > +
> > > +# Enable support for device-tree overlays
> > > +DTC_FLAGS_rk3588-rock-5b += -@

Note that this DTC compiler flag is needed for the overlay for the
bootloader to be able to apply the overlay successfully.

(In order to supply the .dtbo compiled by the kernel directly to u-boot.)

I'm not sure how the other rockchip overlays compiled by the kernel can
work when suppling them to u-boot.

I'm guessing that they compile them externally/manually outside the source
tree with the -@ flag enabled.


If we look at other arm64 device tree overlays in the kernel, e.g. TI,
they seem to supply -@ for all their .dtso files:

$ git grep -- "-@" arch/arm64/


Kind regards,
Niklas

