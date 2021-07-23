Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3917B3D3DC7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhGWQEm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 12:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGWQEl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 12:04:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85A0360E78;
        Fri, 23 Jul 2021 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058714;
        bh=EeaiKiqkSOE66DZn8QGM/HjWrJ1hV6nT2gmbudpg5B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkWLEBYoT7807f081eSKHH3uUbj2nQhLH6529HxCdsWOEDdKYdlpLmOSka3niqowZ
         2ecHZPEgB+dkNumeMisk1B07WRoOYLuBIZ68iBryZ/A+NU74d+jyJG4YgWK3xpUu7E
         YxO6uMCSXYSWvkJwi8XWEbmeY6DiKYM3VFq43bbeCszjjggz1RkmSshux4dyjyAyat
         LSc2tP7kx3aDiRaxZo4A64AayobcFovlafkDizX/guSPlrOoN8Zf6LLkuX19DtqEl5
         kgJTVID/kTmuantanbM1BIoQ0jMRBc0QR54Rfqzt5EzHTBCm3NRcqX4yiyvrAhsJqL
         rO+ui0E+ykuoA==
Received: by pali.im (Postfix)
        id 684D410D1; Fri, 23 Jul 2021 18:45:12 +0200 (CEST)
Date:   Fri, 23 Jul 2021 18:45:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     robh@kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: marvell: armada-37xx: Extend PCIe MEM
 space
Message-ID: <20210723164512.vo3scpzoodff2j33@pali>
References: <20210624215546.4015-1-pali@kernel.org>
 <20210624215546.4015-3-pali@kernel.org>
 <87pmv919bq.fsf@BL-laptop>
 <20210723141204.waiipazikhzzloj7@pali>
 <20210723155247.GB4103@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723155247.GB4103@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 23 July 2021 16:52:47 Lorenzo Pieralisi wrote:
> On Fri, Jul 23, 2021 at 04:12:04PM +0200, Pali Rohár wrote:
> > On Friday 23 July 2021 14:52:25 Gregory CLEMENT wrote:
> > > Hello Pali,
> > > 
> > > > Current PCIe MEM space of size 16 MB is not enough for some combination
> > > > of PCIe cards (e.g. NVMe disk together with ath11k wifi card). ARM Trusted
> > > > Firmware for Armada 3700 platform already assigns 128 MB for PCIe window,
> > > > so extend PCIe MEM space to the end of 128 MB PCIe window which allows to
> > > > allocate more PCIe BARs for more PCIe cards.
> > > >
> > > > Without this change some combination of PCIe cards cannot be used and
> > > > kernel show error messages in dmesg during initialization:
> > > >
> > > >     pci 0000:00:00.0: BAR 8: no space for [mem size 0x01800000]
> > > >     pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x01800000]
> > > >     pci 0000:00:00.0: BAR 6: assigned [mem 0xe8000000-0xe80007ff pref]
> > > >     pci 0000:01:00.0: BAR 8: no space for [mem size 0x01800000]
> > > >     pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x01800000]
> > > >     pci 0000:02:03.0: BAR 8: no space for [mem size 0x01000000]
> > > >     pci 0000:02:03.0: BAR 8: failed to assign [mem size 0x01000000]
> > > >     pci 0000:02:07.0: BAR 8: no space for [mem size 0x00100000]
> > > >     pci 0000:02:07.0: BAR 8: failed to assign [mem size 0x00100000]
> > > >     pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
> > > >     pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
> > > >
> > > > Due to bugs in U-Boot port for Turris Mox, the second range in Turris Mox
> > > > kernel DTS file for PCIe must start at 16 MB offset. Otherwise U-Boot
> > > > crashes during loading of kernel DTB file. This bug is present only in
> > > > U-Boot code for Turris Mox and therefore other Armada 3700 devices are not
> > > > affected by this bug. Bug is fixed in U-Boot version 2021.07.
> > > >
> > > > To not break booting new kernels on existing versions of U-Boot on Turris
> > > > Mox, use first 16 MB range for IO and second range with rest of PCIe window
> > > > for MEM.
> > > 
> > > Is there any depencey with the firs patch of this series ?
> > > 
> > > What happend if this patch is applied without the other ?
> > 
> > First patch is fixing reading and setting ranges configuration from DTS.
> > Without first patch memory windows stays as they were in bootloader or
> > in its default configuration. Which is that all 128 MB are transparently
> > mapped to PCIe MEM space.
> > 
> > Therefore this second DTS patch does not fixes issue with IO space
> > (kernel still crashes when accessing it). But allows to use all PCIe MEM
> > space (due to bootloader / default configuration) and therefore allows
> > to use more PCIe cards (which needs more PCIe MEM space).
> 
> So, the two patches are decoupled then ? We are not taking dts changes
> through the PCI tree.

Well, both patches are required to fix setup and use of PCIe ranges on
A3720 platforms. But I would say they are independent and you can apply
them in any order. So Gregory, feel free to take DTS change in your tree
and Lorenzo can review other patch.

I sent these two patches in one series as they are fixing one common
issue. It is common that for fixing one common issue it is required to
touch more subsystems / trees.

> Besides: these dts patches are a nightmare for backward compatibility,
> hopefully Rob can shed some light on whether what you are doing here
> is advisable and how to sync the changes with kernel changes.

As written in comment for armada-3720-turris-mox.dts file, there are
specific requirements what needs to be put into ranges section. And
version of this file without applying this patch and also version of
this file with applied patch matches these requirements.

So I would say that this DTS change is backward and also forward
compatible.

But I agree that DTS changes are lot of time nightmare...

> Lorenzo
> 
> > > Could you test it to see if any regression occure ?
> > > 
> > > Thanks,
> > > 
> > > Grégory
> > > 
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Fixes: 76f6386b25cc ("arm64: dts: marvell: Add Aardvark PCIe support for Armada 3700")
> > > > ---
> > > >  .../boot/dts/marvell/armada-3720-turris-mox.dts | 17 +++++++++++++++++
> > > >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi    | 11 +++++++++--
> > > >  2 files changed, 26 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > > > index 53e817c5f6f3..86b3025f174b 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > > > @@ -134,6 +134,23 @@
> > > >  	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
> > > >  	status = "okay";
> > > >  	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
> > > > +	/*
> > > > +	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
> > > > +	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
> > > > +	 * 2 size cells and also expects that the second range starts at 16 MB offset. If these
> > > > +	 * conditions are not met then U-Boot crashes during loading kernel DTB file. PCIe address
> > > > +	 * space is 128 MB long, so the best split between MEM and IO is to use fixed 16 MB window
> > > > +	 * for IO and the rest 112 MB (64+32+16) for MEM, despite that maximal IO size is just 64 kB.
> > > > +	 * This bug is not present in U-Boot ports for other Armada 3700 devices and is fixed in
> > > > +	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one contains fix):
> > > > +	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
> > > > +	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297ad7391fc6df8ecd73bf
> > > > +	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081fc132a591ebd99ba02ee33
> > > > +	 */
> > > > +	#address-cells = <3>;
> > > > +	#size-cells = <2>;
> > > > +	ranges = <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
> > > > +		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 MEM */
> > > >  
> > > >  	/* enabled by U-Boot if PCIe module is present */
> > > >  	status = "disabled";
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > > > index 7a2df148c6a3..dac3007f2ac1 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > > > @@ -488,8 +488,15 @@
> > > >  			#interrupt-cells = <1>;
> > > >  			msi-parent = <&pcie0>;
> > > >  			msi-controller;
> > > > -			ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
> > > > -				  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> > > > +			/*
> > > > +			 * The 128 MiB address range [0xe8000000-0xf0000000] is
> > > > +			 * dedicated for PCIe and can be assigned to 8 windows
> > > > +			 * with size a power of two. Use one 64 KiB window for
> > > > +			 * IO at the end and the remaining seven windows
> > > > +			 * (totaling 127 MiB) for MEM.
> > > > +			 */
> > > > +			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
> > > > +				  0x81000000 0 0xefff0000   0 0xefff0000   0 0x00010000>; /* Port 0 IO */
> > > >  			interrupt-map-mask = <0 0 0 7>;
> > > >  			interrupt-map = <0 0 0 1 &pcie_intc 0>,
> > > >  					<0 0 0 2 &pcie_intc 1>,
> > > > -- 
> > > > 2.20.1
> > > >
> > > 
> > > -- 
> > > Gregory Clement, Bootlin
> > > Embedded Linux and Kernel engineering
> > > http://bootlin.com
