Return-Path: <linux-pci+bounces-42094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F161CC87BEE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 02:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4A3ABC28
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267FB30B505;
	Wed, 26 Nov 2025 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="eSKtMKOe"
X-Original-To: linux-pci@vger.kernel.org
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3A3093DD;
	Wed, 26 Nov 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764121540; cv=none; b=seSNhgR9Wgdo6lDlj9eneXpdZpBOboTHtctRiHsuMPi7gfeG9A2Rrg/EQwXStkfnS6PhkZcQG5JE2Wejm7KrbNjCmizw84zFIE7c8YTyzQA6lGukQuX218XqeNjcs1LqYg1O5yXbK+rRLhBEHHQV1zDjDA/eZjWFfFmthYRO8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764121540; c=relaxed/simple;
	bh=qiWgpYn16Mf+RYWUWbQFq+6Clsq9w5kNRva8GD5GeDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdjVYDecVUaxcwcG6nUPtvHZGoQGQ3ZWJgOi9I09bCCS9Y8I/tgtN4JukTzhe/aiG9WaoLcE5AzzXUHsh4t5yk01ZmJNcFtZxGUrSPmGp2mNz7928DMVlNlecmf5RGad4MN3GI9k2Bu5eg+1OhueM4yAkF6c52K2LejYGT0Tgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=eSKtMKOe; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1764121510;
	bh=6jZ3fYnM1SUryJBt+UAWY3sfU2Uv3tDGw4uMv3KY72g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eSKtMKOengyYwTaQaIyLUovIJwqZvdod8idCJH7/x8q4GJtfgvFXh8Q+fw3SaieXS
	 6xpCvoOGspt3m6EPdgTfuZug1hiTaSl0qsRp8A6Pz8oOCbizsEdhuBBRJmQ7nz3BA2
	 tHKCy3JE3ooGD0JnmtMM+3YzIVCcx+roAS0N3XsG3DC94fIYMzi9rs2rXDXOwkFNVo
	 lZZI74EbQni1RzMZW6pp1JJbctLvzzKg3lNBZ8Nj3ePlRK9T8qoXCU0h6eOIQ8qHk5
	 S/UnANE0lU/Nqyg5cJ+WyPT/g69NudN8YYJg8oFAURDqzxUxwPYSKXfeaJ5XwwkGKy
	 KUJbk4VYW2waA==
Received: from [192.168.2.54] (unknown [98.97.63.250])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 136F8B2204B1;
	Wed, 26 Nov 2025 02:45:05 +0100 (CET)
Message-ID: <8e422318-1600-4321-928e-1033190d5890@freeshell.de>
Date: Tue, 25 Nov 2025 17:45:04 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] riscv: dts: starfive: Add VisionFive 2 Lite eMMC
 board device tree
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
 <20251125075604.69370-7-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251125075604.69370-7-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/25 23:56, Hal Feng wrote:
> VisionFive 2 Lite eMMC board uses a non-removable onboard 64GiB eMMC
> instead of the MicroSD slot.
> 
> Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Tested-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  ...jh7110-starfive-visionfive-2-lite-emmc.dts | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 2b1e7fcd6f84..a640ed5dc5a1 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-lite.dtb
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-lite-emmc.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts
> new file mode 100644
> index 000000000000..e27a662d4022
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts
> @@ -0,0 +1,22 @@
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
> +	model = "StarFive VisionFive 2 Lite eMMC";

> +	compatible = "starfive,visionfive-2-lite-emmc", "starfive,jh7110s";

Add "starfive,jh7110" to the compatible list as the least-compatible
(left-to-right order last item):

compatible = "starfive,visionfive-2-lite-emmc", "starfive,jh7110s",
"starfive,jh7110";

or if there is review feedback that no new compatible should be added,
then as usual for new JH-7110 boards:

compatible = "starfive,visionfive-2-lite-emmc", "starfive,jh7110";

> +};
> +
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};

-E

