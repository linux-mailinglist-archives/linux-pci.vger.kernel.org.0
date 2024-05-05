Return-Path: <linux-pci+bounces-7097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7188BC06C
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5431C281AAA
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88E18046;
	Sun,  5 May 2024 12:57:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D141B7FD;
	Sun,  5 May 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714913830; cv=none; b=q9mKo+CMNHm3CyD1QqZt+JjNy91IhXtPW7PWU8O+ATj0exZzE8l5bM6UVVH4LFIkov1hUg9UhbKMatth63dXUfW6O4K5GcMZnK5y2c793k1QF+cQwIKJxMF0jzzNgdBxJQ8VDAcNW7k6eQmRpZMI+BJIgUEcCYWHGnJxu+i4OD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714913830; c=relaxed/simple;
	bh=pupk/drMuFDzWzVRhHk/tpjV03/cqF+RR5LiCJ8hyak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2PW7UkS8FtPJTBaRAunkykYYLnhlhzzI0I9R1woVPdQXIDFdP7Dzh903BMlpUJTiWF68XfymQRc3qcdjazOQ5K9euUqLQCBDcQVLfVOQ9vZydAE78ootNxroyXf5WCheQAHkvtnAEK8VYL0BHK0p4n9T1lI6l/5KiNwDnEkcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s3alS-0004dC-DW; Sun, 05 May 2024 14:14:46 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 14/14] arm64: dts: rockchip: Add rock5b overlays for PCIe
 endpoint mode
Date: Sun, 05 May 2024 14:14:45 +0200
Message-ID: <2986540.X9hSmTKtgW@diego>
In-Reply-To: <20240504173730.GK4315@thinkpad>
References:
 <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-14-a0f5ee2a77b6@kernel.org>
 <20240504173730.GK4315@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 4. Mai 2024, 19:37:30 CEST schrieb Manivannan Sadhasivam:
> On Tue, Apr 30, 2024 at 02:01:11PM +0200, Niklas Cassel wrote:
> > Add rock5b overlays for PCIe endpoint mode support.
> > 
> 
> I'm not aware of mainline using overlays. Is this a new one?

I guess you could still call it new'ish ;-)

But the mainline kernel does carry a number of overlays already [0] .
This does of course not handle the actual application of overlays,
which I guess bootloaders do only at this point.

But I think it's definitely reasonable to carry them in a "central" location
especially as for example u-boot uses the kernel as canonical source
for most of its devicetrees.


Heikoi


[0] some random examples ;-)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am-realtek.dtso
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dtso
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-wifi.dtso

> > If using the rock5b as an endpoint against a normal PC, only the
> > rk3588-rock-5b-pcie-ep.dtbo needs to be applied.
> > 
> > If using two rock5b:s, with one board as EP and the other board as RC,
> > rk3588-rock-5b-pcie-ep.dtbo and rk3588-rock-5b-pcie-srns.dtbo has to
> > be applied to the respective boards.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile              |  5 +++++
> >  .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  | 25 ++++++++++++++++++++++
> >  .../dts/rockchip/rk3588-rock-5b-pcie-srns.dtso     | 16 ++++++++++++++
> >  3 files changed, 46 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index f906a868b71a..d827432d5111 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -117,6 +117,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
> > @@ -127,3 +129,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
> > +
> > +# Enable support for device-tree overlays
> > +DTC_FLAGS_rk3588-rock-5b += -@
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso
> > new file mode 100644
> > index 000000000000..672d748fcc67
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * DT-overlay to run the PCIe3_4L Dual Mode controller in Endpoint mode
> > + * in the SRNS (Separate Reference Clock No Spread) configuration.
> > + *
> > + * NOTE: If using a setup with two ROCK 5B:s, with one board running in
> > + * RC mode and the other board running in EP mode, see also the device
> > + * tree overlay: rk3588-rock-5b-pcie-srns.dtso.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&pcie30phy {
> > +	rockchip,rx-common-refclk-mode = <0 0 0 0>;
> > +};
> > +
> > +&pcie3x4 {
> > +	status = "disabled";
> > +};
> > +
> > +&pcie3x4_ep {
> > +	vpcie3v3-supply = <&vcc3v3_pcie30>;
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso
> > new file mode 100644
> > index 000000000000..1a0f1af65c43
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * DT-overlay to run the PCIe3_4L Dual Mode controller in Root Complex
> > + * mode in the SRNS (Separate Reference Clock No Spread) configuration.
> > + *
> > + * This device tree overlay is only needed (on the RC side) when running
> > + * a setup with two ROCK 5B:s, with one board running in RC mode and the
> > + * other board running in EP mode.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&pcie30phy {
> > +	rockchip,rx-common-refclk-mode = <0 0 0 0>;
> > +};
> > 
> 
> 





