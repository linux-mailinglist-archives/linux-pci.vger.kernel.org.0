Return-Path: <linux-pci+bounces-6202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656508A37E9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 23:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C761C214E4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88C15099F;
	Fri, 12 Apr 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhSTbhDx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61815610B;
	Fri, 12 Apr 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957610; cv=none; b=gYtMhdqm+FIZJZxhh4Y/v6yCxVfEmgUXfanti8upPkwTuqeqYZk9nEruH1qKUjXbLKgXbenuqpPW/LjV5W7thDhAzGD+GfUF7plDI2+kFNU5GfxO/K4wtfve6jbUjZr6g4LOjp4tRRCxjj2zeGUXZA2NOYA/sgTeF+zGerihXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957610; c=relaxed/simple;
	bh=CtC3I2fZQ9mZwBg/TkYlfnfS9MFN0gpK2lQ696PJfG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tDQpeCxcWK26FT8E/UshpxRx62RGr569tdfLVb2VxPr0bCyItzEXD3JrDIrsiVwLQ/p7LZs5YYhOduw5/UbExUplo80ZKYQVgXkAsUdhwcvc8HOwQJb+11eHfAm0dhMZ6HrsimcRzYc87eogRGTxkzs78Q6Vr4FpUAqqB0jUXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhSTbhDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF3C113CC;
	Fri, 12 Apr 2024 21:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957610;
	bh=CtC3I2fZQ9mZwBg/TkYlfnfS9MFN0gpK2lQ696PJfG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HhSTbhDx+UWURLfC7hyj8yyHFrTuSDmbdVUCnommqoKxlUxohFWXZfu8zZy4uL+oO
	 bNexmE9vPvhh3q/VdkYgk2zTi8NtvrRth2hbv4WSvNwDnvWnHiL6HQHAqzOScatefn
	 noUtbdiM9PKpxBqMmC54oC5bUgu6mS6n7Nymk9BuYWJpVfJA8IVYmXtfTf6K5TOMhY
	 CgM5RxS+q4mYVevj/nkmA1h/yhdDDT8DLjh5RwT08wbD4zgEjI7UpoFsTEAdUX6jwg
	 n2GnhytXq2vfNm19rt+JkfOe4dU4zR3CEpSCIRp/oXtCfaN3RNJrF/rv2x8tS4Tyc6
	 1tWYqreRv2HUw==
Date: Fri, 12 Apr 2024 16:33:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mt7621: Fix possible string truncation in snprintf
Message-ID: <20240412213328.GA19361@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111082704.2259450-1-sergio.paracuellos@gmail.com>

On Thu, Jan 11, 2024 at 09:27:04AM +0100, Sergio Paracuellos wrote:
> The following warning appears when driver is compiled with W=1.
> 
> CC      drivers/pci/controller/pcie-mt7621.o
> drivers/pci/controller/pcie-mt7621.c: In function ‘mt7621_pcie_probe’:
> drivers/pci/controller/pcie-mt7621.c:228:49: error: ‘snprintf’ output may
> be truncated before the last format character [-Werror=format-truncation=]
> 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>     |                                                 ^
> drivers/pci/controller/pcie-mt7621.c:228:9: note: ‘snprintf’ output between
> 10 and 11 bytes into a destination of size 10
> 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>     |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Clean this up increasing destination buffer one byte.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20240110212302.GA2123146@bhelgaas/T/#t
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Krzysztof applied this to pci/controller/mt7621 for v6.10, thanks!  I
just pulled that branch into "next", so it should appear in the next
linux-next.

> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 79e225edb42a..d97b956e6e57 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -202,7 +202,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
>  	struct mt7621_pcie_port *port;
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	char name[10];
> +	char name[11];
>  	int err;
>  
>  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> -- 
> 2.25.1
> 

