Return-Path: <linux-pci+bounces-38666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF822BEDFD4
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 09:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75DAE4E3659
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D822541C;
	Sun, 19 Oct 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oupI/KhT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254461BC3F;
	Sun, 19 Oct 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860256; cv=none; b=VBDyIGWo1csUYSeJOZJhfLQvh9JuubXt61VcsRdEn9/m9HKaOFXj9Zj44bAiGk7d3EbUrHZakpWItx6+jM/BUMM+CczorvAJzKG6YhSSmesus6lfxDfucQAQ8+xpfIxZM2OYsn5RUMHgzqks218y66HBhg3a/6e/pAPTNwQ1oiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860256; c=relaxed/simple;
	bh=GvSwkt6lVhTuWJEGylfxc7FJevt6hW5T4Sb4DHwzf2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Voar2lJfJHU87lH9qOvcSwcoptlxAA/M8x1wItkz5mbTJko3Ea1GkcsrBbFZAWQ1gUkhWaYkuqyO2BKxtS1rldy6+mDTNMY0VKWXj5360WeX/p8kHp4r+K7ZDcKv/nDDiqmO2frPcIfp1ymWZ/tJcrFEJikw9KNb0jkS90gikY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oupI/KhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF48BC4CEE7;
	Sun, 19 Oct 2025 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760860255;
	bh=GvSwkt6lVhTuWJEGylfxc7FJevt6hW5T4Sb4DHwzf2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oupI/KhTlAO0V5ekScpTFkt6LTzwqjcDdEAptHCJfbfOX50VMYIgpfj7Dgnl/7a8Y
	 JtMg0CQv/Tm4Kxc2qSyPasjwBoMS1R9MOa9SoVJZyCvecoEIhH8jXLkomSvNV5LH3B
	 ZDvloFS4CuKDyVasgMUIOH5QutikeiHC9m7AbAbibFbmlX0AB/GkL0HRZWSfziihB0
	 Ke0prlyiZG5A7iGDc4r+zlmHqXTELEERkde0ZUF1VnOnjDcIuMQKV470uLcK6AAOnX
	 4uIANP2UvKV8PMdhcam8pCXWYDb5j+UG4goOSCmwm21exxehwASL1AG+wx90y31s6X
	 ddUo9yzV/llZw==
Date: Sun, 19 Oct 2025 13:20:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v1 3/5] PCI: tegra: Use readl_poll_timeout() for link
 status polling
Message-ID: <ose3ww7me26byqwsyk33tipylkx3kolnc3mjwrlmjwsmza2zf3@os7lkt4svaqi>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-4-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926072905.126737-4-linux.amoon@gmail.com>

On Fri, Sep 26, 2025 at 12:57:44PM +0530, Anand Moon wrote:
> Replace the manual `do-while` polling loops with the readl_poll_timeout()
> helper when checking the link DL_UP and DL_LINK_ACTIVE status bits
> during link bring-up. This simplifies the code by removing the open-coded
> timeout logic in favor of the standard, more robust iopoll framework.
> The change improves readability and reduces code duplication.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: dropped the include  <linux/iopoll.h> header file.
> ---
>  drivers/pci/controller/pci-tegra.c | 37 +++++++++++-------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 07a61d902eae..b0056818a203 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2169,37 +2169,28 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
>  	value |= RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT;
>  	writel(value, port->base + RP_PRIV_MISC);
>  
> -	do {
> -		unsigned int timeout = TEGRA_PCIE_LINKUP_TIMEOUT;
> +	while (retries--) {
> +		int err;
>  
> -		do {
> -			value = readl(port->base + RP_VEND_XP);
> -
> -			if (value & RP_VEND_XP_DL_UP)
> -				break;
> -
> -			usleep_range(1000, 2000);
> -		} while (--timeout);
> -
> -		if (!timeout) {
> +		err = readl_poll_timeout(port->base + RP_VEND_XP, value,
> +					 value & RP_VEND_XP_DL_UP,
> +					 1000,

The delay between the iterations had range of (1000, 2000), now it will become
(250, 1000). How can you ensure that this delay is sufficient?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

