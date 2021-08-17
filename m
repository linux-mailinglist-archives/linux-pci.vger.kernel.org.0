Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF563EF054
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhHQQn1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 17 Aug 2021 12:43:27 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:55557 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 12:43:26 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 3DEB6C3EB6
        for <linux-pci@vger.kernel.org>; Tue, 17 Aug 2021 16:40:14 +0000 (UTC)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 70C36FF802;
        Tue, 17 Aug 2021 16:39:51 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: marvell: armada-37xx: Extend PCIe MEM
 space
In-Reply-To: <20210624215546.4015-3-pali@kernel.org>
References: <20210624215546.4015-1-pali@kernel.org>
 <20210624215546.4015-3-pali@kernel.org>
Date:   Tue, 17 Aug 2021 18:39:50 +0200
Message-ID: <87bl5wyqi1.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> Current PCIe MEM space of size 16 MB is not enough for some combination
> of PCIe cards (e.g. NVMe disk together with ath11k wifi card). ARM Trusted
> Firmware for Armada 3700 platform already assigns 128 MB for PCIe window,
> so extend PCIe MEM space to the end of 128 MB PCIe window which allows to
> allocate more PCIe BARs for more PCIe cards.
>
> Without this change some combination of PCIe cards cannot be used and
> kernel show error messages in dmesg during initialization:
>
>     pci 0000:00:00.0: BAR 8: no space for [mem size 0x01800000]
>     pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x01800000]
>     pci 0000:00:00.0: BAR 6: assigned [mem 0xe8000000-0xe80007ff pref]
>     pci 0000:01:00.0: BAR 8: no space for [mem size 0x01800000]
>     pci 0000:01:00.0: BAR 8: failed to assign [mem size 0x01800000]
>     pci 0000:02:03.0: BAR 8: no space for [mem size 0x01000000]
>     pci 0000:02:03.0: BAR 8: failed to assign [mem size 0x01000000]
>     pci 0000:02:07.0: BAR 8: no space for [mem size 0x00100000]
>     pci 0000:02:07.0: BAR 8: failed to assign [mem size 0x00100000]
>     pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
>     pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
>
> Due to bugs in U-Boot port for Turris Mox, the second range in Turris Mox
> kernel DTS file for PCIe must start at 16 MB offset. Otherwise U-Boot
> crashes during loading of kernel DTB file. This bug is present only in
> U-Boot code for Turris Mox and therefore other Armada 3700 devices are not
> affected by this bug. Bug is fixed in U-Boot version 2021.07.
>
> To not break booting new kernels on existing versions of U-Boot on Turris
> Mox, use first 16 MB range for IO and second range with rest of PCIe window
> for MEM.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory

> Fixes: 76f6386b25cc ("arm64: dts: marvell: Add Aardvark PCIe support for Armada 3700")
> ---
>  .../boot/dts/marvell/armada-3720-turris-mox.dts | 17 +++++++++++++++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi    | 11 +++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 53e817c5f6f3..86b3025f174b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -134,6 +134,23 @@
>  	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
>  	status = "okay";
>  	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
> +	/*
> +	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
> +	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
> +	 * 2 size cells and also expects that the second range starts at 16 MB offset. If these
> +	 * conditions are not met then U-Boot crashes during loading kernel DTB file. PCIe address
> +	 * space is 128 MB long, so the best split between MEM and IO is to use fixed 16 MB window
> +	 * for IO and the rest 112 MB (64+32+16) for MEM, despite that maximal IO size is just 64 kB.
> +	 * This bug is not present in U-Boot ports for other Armada 3700 devices and is fixed in
> +	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one contains fix):
> +	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
> +	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297ad7391fc6df8ecd73bf
> +	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081fc132a591ebd99ba02ee33
> +	 */
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +	ranges = <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
> +		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 MEM */
>  
>  	/* enabled by U-Boot if PCIe module is present */
>  	status = "disabled";
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 7a2df148c6a3..dac3007f2ac1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -488,8 +488,15 @@
>  			#interrupt-cells = <1>;
>  			msi-parent = <&pcie0>;
>  			msi-controller;
> -			ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
> -				  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> +			/*
> +			 * The 128 MiB address range [0xe8000000-0xf0000000] is
> +			 * dedicated for PCIe and can be assigned to 8 windows
> +			 * with size a power of two. Use one 64 KiB window for
> +			 * IO at the end and the remaining seven windows
> +			 * (totaling 127 MiB) for MEM.
> +			 */
> +			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
> +				  0x81000000 0 0xefff0000   0 0xefff0000   0 0x00010000>; /* Port 0 IO */
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0 0 0 1 &pcie_intc 0>,
>  					<0 0 0 2 &pcie_intc 1>,
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
