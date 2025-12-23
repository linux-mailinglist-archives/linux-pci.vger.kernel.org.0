Return-Path: <linux-pci+bounces-43598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED9CD9DA2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BAF3082ACB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA432E6B5;
	Tue, 23 Dec 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUVBe1kC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE9285CB2;
	Tue, 23 Dec 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766504329; cv=none; b=HS1Vn6MI08w82t1/kD721+yvllo8W5LXwggJS76G3m+qviQRaWmET5dtjn+QMe6r15ZlydXFFgktHDhKYbZbo09HGFdBNTEVdm01hLiCDDbp8nbuO5nrlj4BkuIN2QRg1WGZKrbgy2w6X4zFEl9FzXBLg+5ARt7AWuR0gTY6Ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766504329; c=relaxed/simple;
	bh=+TcYH6TIplkug/gQDHnsv7nQ7tnduk4LL2LEZzCzTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE8PGfGT/izocNGQaavIfJ4kd+MmgmpyQro8dxuXZZCVLE9uiqlK7Uq9NmjQt7MLgsg4396psgFrBXMWz+dQ3+mPe3Jcp/Pcsaw9A3qKzEkVSr+ABiDM44v6Eg7QfdrrtGQEVdqUHqYuKFz9nea41zkFeLQaJANOYWpw5XieH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUVBe1kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03767C113D0;
	Tue, 23 Dec 2025 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766504328;
	bh=+TcYH6TIplkug/gQDHnsv7nQ7tnduk4LL2LEZzCzTXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUVBe1kCA7fLdvKrVG0h5qsIh/rC+egrV6e7Up8wRserT+b4oT/cWBgXvVYtRkJLx
	 XXmXOeV3PxUG3J6sTPqcRTPX6LN057jv6T2BTlX/9rvwal2APvWfFe+BdErlJyDw2/
	 AdgMW+/5AJFvJXeW+knuJIjBvt1lFeHqRZtfjjN77djedCv8pi6aVbcEpHrgQoZWxa
	 tzBOBqGG5uOt/ASGMox4RtJLubgZXl89Hd6b3x5sbC9M2QvYme51dj+U2EYfFZi87X
	 raWvWn/d6vOn0FQPFRvGcHrgW9bENrAKpJLfdCk792XxCYhGdFOgxeBqhFZ8siwtx0
	 zd+8TbCtNY6rg==
Date: Tue, 23 Dec 2025 21:08:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 4/7] PHY: aspeed: Add ASPEED PCIe PHY driver
Message-ID: <aUq3hF7Xfk-f35Nh@vaman>
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
 <20251216-upstream_pcie_rc-v7-4-4aeb0f53c4ce@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-upstream_pcie_rc-v7-4-4aeb0f53c4ce@aspeedtech.com>

On 16-12-25, 09:50, Jacky Chou wrote:
> Introduce support for Aspeed PCIe PHY controller available in
> AST2600/2700.

What is with the uppercase "PHY" in patch title instead of lowercase
'phy' as is the convention

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/phy/Kconfig                  |   1 +
>  drivers/phy/Makefile                 |   1 +
>  drivers/phy/aspeed/Kconfig           |  15 +++
>  drivers/phy/aspeed/Makefile          |   2 +
>  drivers/phy/aspeed/phy-aspeed-pcie.c | 209 +++++++++++++++++++++++++++++++++++
>  5 files changed, 228 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 678dd0452f0a..f6a8f06fd244 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -103,6 +103,7 @@ config PHY_NXP_PTN3222
>  
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
> +source "drivers/phy/aspeed/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
>  source "drivers/phy/cadence/Kconfig"
>  source "drivers/phy/freescale/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index bfb27fb5a494..18990c87dfb0 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
>  obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
>  obj-y					+= allwinner/	\
>  					   amlogic/	\
> +					   aspeed/	\
>  					   broadcom/	\
>  					   cadence/	\
>  					   freescale/	\
> diff --git a/drivers/phy/aspeed/Kconfig b/drivers/phy/aspeed/Kconfig
> new file mode 100644
> index 000000000000..6aeeca84091f
> --- /dev/null
> +++ b/drivers/phy/aspeed/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Phy drivers for Aspeed platforms
> +#
> +config PHY_ASPEED_PCIE
> +	tristate "ASPEED PCIe PHY driver"
> +	select GENERIC_PHY
> +	depends on ARCH_ASPEED
> +	default y

NO! why should this driver be default!

> +	help
> +	  This option enables support for the ASPEED PCIe PHY driver.
> +	  The driver provides the necessary interface to control and
> +	  configure the PCIe PHY hardware found on ASPEED SoCs.
> +	  It is required for proper operation of PCIe devices on
> +	  platforms using ASPEED chips.
> \ No newline at end of file

??

> diff --git a/drivers/phy/aspeed/Makefile b/drivers/phy/aspeed/Makefile
> new file mode 100644
> index 000000000000..7203152f44bf
> --- /dev/null
> +++ b/drivers/phy/aspeed/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PHY_ASPEED_PCIE)		+= phy-aspeed-pcie.o
> \ No newline at end of file

Are we expecting more drivers for aspeed, if not move it to drivers/phy/
once we have couple of them we can add a directory

> diff --git a/drivers/phy/aspeed/phy-aspeed-pcie.c b/drivers/phy/aspeed/phy-aspeed-pcie.c
> new file mode 100644
> index 000000000000..3de43a86ac17
> --- /dev/null
> +++ b/drivers/phy/aspeed/phy-aspeed-pcie.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 Aspeed Technology Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>

why do you need this

> +#include <linux/phy/pcie.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>


Do you need all headers here?

-- 
~Vinod

