Return-Path: <linux-pci+bounces-31643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCDDAFBE37
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 00:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3091BC15B7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF522B8CB;
	Mon,  7 Jul 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfKa/VY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390161CAA6C;
	Mon,  7 Jul 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926933; cv=none; b=iEfFnIwY8K9BK1r8FcoKJSxv/w3yuyr2U5crlIuC+Wn+XyokdI2FDxygApZI7nVdmsMeEeywkg0HmBWiG6ffrNSHzeAbkvk+/5+JtAU/q5QpCcB4QsO+tRXv5ekYzrwmblP9vhotjm2FNm5cvBr9o4n3TYbhlhyY96oXTIEv7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926933; c=relaxed/simple;
	bh=VKmtbfxhoTD48D/ekjwLMwNv+Dp8aDndHjI4BucvUmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZiKjDWwhCm6MbJU3D827mo2Xf00iY029CNacF17nCbVpaz1XF9ZfryVWqercTXl2TCPVm/0qwycIsk6e4Fka2cFaLvvjBwnyPbdQVb4s87zPvrOAm9r3xUS3xbIKN1HF4//lw1oAkH5YAkHOXYqjFSioBbXT9m4oNlySyhTPsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfKa/VY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690CEC4CEE3;
	Mon,  7 Jul 2025 22:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751926932;
	bh=VKmtbfxhoTD48D/ekjwLMwNv+Dp8aDndHjI4BucvUmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MfKa/VY/D8o8WU7cbff2usg9a9qVjvAGjstrw4JfKOUNiEmnK9naUFS4mixRLJPk1
	 jJ2V7GtmTRQ3z95LkSEx6PD8pJAAcx4qR8ZhIMV1HFBPkGP/b1MEqj9rlfp7YHZ1go
	 6s6D8X/Im9CgH+leQZTYV+lNEyL1w0QCOBu7n3Q57j6qrpdNPviZpzpFwRtaJRZzWO
	 wEm0LUHD4zVPrPrnc1B+Zs5qHC73U5SR19nj3EGKXpRLurHN7xTlvB4T7xcLT6kHUr
	 KxemPjXfbUU7B6+tUQRp49II+xFWg0p5Zhs8v/PjK57RzlYWvDbxivuRx8EETx3jLh
	 rb+BuzBG+NS3A==
Date: Mon, 7 Jul 2025 17:22:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v9 1/4] PCI: rockchip: Use standard PCIe defines
Message-ID: <20250707222210.GA2114615@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>

On Mon, Jun 30, 2025 at 07:24:41PM -0300, Geraldo Nascimento wrote:
> Current code uses custom-defined register offsets and bitfields for
> standard PCIe registers. Change to using standard PCIe defines. Since
> we are now using standard PCIe defines, drop unused custom-defined ones,
> which are now referenced from offset at added Capabilities Register.

> @@ -278,10 +278,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
>  		power = power / 10;
>  	}
>  
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
> -	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
> -		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
> +	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
> +	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);

Added #include <linux/bitfield.h> for this:

  CC      drivers/pci/controller/pcie-rockchip-host.o
drivers/pci/controller/pcie-rockchip-host.c: In function ‘rockchip_pcie_set_power_limit’:
drivers/pci/controller/pcie-rockchip-host.c:272:24: error: implicit declaration of function ‘FIELD_MAX’ [-Werror=implicit-function-declaration]
  272 |         while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
      |                        ^~~~~~~~~
drivers/pci/controller/pcie-rockchip-host.c:282:19: error: implicit declaration of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
  282 |         status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
      |                   ^~~~~~~~~~


