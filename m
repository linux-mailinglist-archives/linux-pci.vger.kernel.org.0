Return-Path: <linux-pci+bounces-42093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A81C87BA6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 02:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5E24E137A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 01:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCA306B06;
	Wed, 26 Nov 2025 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="KcFDFjZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D11F4CB3;
	Wed, 26 Nov 2025 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764121489; cv=none; b=qKfa2HyjaUm6NizmAA6/T0UKb/4tGj2wop66TnSO8p3OSeJktPFUmU/jpgQ50vxaYl/ges82S35d9bhIIVn/jWesJqALkRCbXIHHFjj4rta67FnCJ4ENmJOrIc5KlEjNc3LAfFeCk8klK3KtDMczfLf5IgWJ2zi7MGg66j3/HX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764121489; c=relaxed/simple;
	bh=/6Os4pdgO4a25ZgyAJu//NzyxI8ObyZOvvKIbqErUvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cezvCh5lrWJxHnaK/aYjQkDLmwyMRKZHJG9F4wjThTEHW+4eVH6q11id9LD2vje9usn5l9yMM0tHjtdpc94513Iuw0XB+2JljyHikYaNlXE0G9XiznUVi55NCIJ/wSgijct1vCIkqu6NQ9g9vCFt6lrBHTy+DRV0xDgpmjvb3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=KcFDFjZd; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1764121449;
	bh=WQXerLQfEzkCxOdDOg6Z8yEdERJE0Z5dvD249YR9kqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KcFDFjZdicn3B2fyU1iRSfw/X3bUf1zMLbVL/fVnetFWDlKZV+b6QDpG1Z8al+8+n
	 suguKOxWOjnW87Jgrcu/S/3t+SP+loLpPbAgLxFM2dc5KiXXIrNnZdkQMpnccHpa0z
	 UrJiLFPOBnU3cKXNERyaBICh0S+Z0RYrRTPN4Ru947jYSxvMuYi6OJffIwxvxkIZDZ
	 ZOL/SqTuJUEOJyluxDokqrW2AYoqtJx1gu8UhbkRMHsCxOsdEOsFMKzNcLXrcG55Xo
	 DrMCW+Vh5MSuFRJC3iVUcWMZhvkTaoTgHyVDpFzg5S9sNrkqOTlkHwxkKFJ49iyosI
	 b0YCttHUxFGGA==
Received: from [192.168.2.54] (unknown [98.97.63.250])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 2C58AB2203E8;
	Wed, 26 Nov 2025 02:44:04 +0100 (CET)
Message-ID: <24150aee-368b-41e5-bcca-b60c561e31ec@freeshell.de>
Date: Tue, 25 Nov 2025 17:44:02 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
 <20251125075604.69370-6-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251125075604.69370-6-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/24/25 23:56, Hal Feng wrote:
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> 
> Board features:
> - JH7110S SoC
> - 4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 
> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
> More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html
> 
> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../jh7110-starfive-visionfive-2-lite.dts     | 20 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 62b659f89ba7..2b1e7fcd6f84 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -13,5 +13,6 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-lite.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts
> new file mode 100644
> index 000000000000..b96eea4fa7d5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-starfive-visionfive-2-lite.dtsi"
> +
> +/ {
> +	model = "StarFive VisionFive 2 Lite";

> +	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";

Add "starfive,jh7110" to the compatible list as the least-compatible
(left-to-right order last item):

compatible = "starfive,visionfive-2-lite", "starfive,jh7110s",
"starfive,jh7110";

or if there is review feedback that no new compatible should be added,
then as usual for new JH-7110 boards:

compatible = "starfive,visionfive-2-lite", "starfive,jh7110";

> +};
> +
> +&mmc0 {
> +	bus-width = <4>;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +};

-E

