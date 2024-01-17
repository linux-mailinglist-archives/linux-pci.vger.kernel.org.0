Return-Path: <linux-pci+bounces-2293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8D830B5F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17381C2437E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190F225AA;
	Wed, 17 Jan 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kM7tz1pD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D9225A4;
	Wed, 17 Jan 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509940; cv=none; b=YtXqddKbOowCt+SG0bd0oA3zUjjpunGTjBQj1D5E09XdKiBEseC+HYxuhAUpUF3m0GNu/k2RgWbQc8XKiRKKmBdPMa/wMHY5KuHpeQvC9Ah0CUKvquJIdEPmW2E0Fr6tUe8l6bKaZVsX/K7QHmwGweErYIzVW+MBEvCzlhJse/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509940; c=relaxed/simple;
	bh=hVbWnNSrHPz6xmHHdaijIuBxcIYaNIZiLi6H6j9b2J8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Pn9TlKFYlC2VoL6UcUnQprMtoqEr5D1a/5SDuLf9PFOlOTmGSUOk7NbXyP/vTFa+8OBDqgs+GWacxMEftU5YOMC45lNjvEAUM2HWQ69ELBlJLz7l9j0uaBWEoOf8C4FS2XmReTvNUyuAVI/9CF9HqxKlU8pIiMMhNtbGNXNayJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kM7tz1pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836F9C433F1;
	Wed, 17 Jan 2024 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705509940;
	bh=hVbWnNSrHPz6xmHHdaijIuBxcIYaNIZiLi6H6j9b2J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM7tz1pDpbypmhPtl655KElT8jZAi+laLUKl4QYPvddIPRavpQM/a0i+LU6Qszs+j
	 EFdz379WU3S/6+gee09gcNF54Sl1uznjojKmOK5BL8nRBXxYoDnQEHOqvIRtpV9i42
	 DSWx2hFRx4cewa515Or2c+bJxRSarzDFcJB1/3To=
Date: Wed, 17 Jan 2024 17:45:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 4/9] PCI: create platform devices for child OF nodes of
 the port node
Message-ID: <2024011707-alibi-pregnancy-a64b@gregkh>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117160748.37682-5-brgl@bgdev.pl>

On Wed, Jan 17, 2024 at 05:07:43PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to introduce PCI power-sequencing, we need to create platform
> devices for child nodes of the port node.

Ick, why a platform device?  What is the parent of this device, a PCI
device?  If so, then this can't be a platform device, as that's not what
it is, it's something else so make it a device of that type,.

> They will get matched against
> the pwrseq drivers (if one exists) and then the actual PCI device will
> reuse the node once it's detected on the bus.

Reuse it how?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/bus.c    | 9 ++++++++-
>  drivers/pci/remove.c | 3 ++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 9c2137dae429..8ab07f711834 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  
> @@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 */
>  	pcibios_bus_add_device(dev);
>  	pci_fixup_device(pci_fixup_final, dev);
> -	if (pci_is_bridge(dev))
> +	if (pci_is_bridge(dev)) {
>  		of_pci_make_dev_node(dev);
> +		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
> +					      &dev->dev);

So this is a pci bridge device, not a platform device, please don't do
this, make it a real device of a new type.

thanks,

greg k-h

