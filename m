Return-Path: <linux-pci+bounces-11379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ABC94981C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B588B28492A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5C13AD20;
	Tue,  6 Aug 2024 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/1M8oTe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5213AA38;
	Tue,  6 Aug 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971877; cv=none; b=O4uA7vvAMyc85L3RJj+mUmJ63ILSdCA8XGVwbFoU0SLtBiCP0yoqRmQRySKdrXVvDX0JxCxTmv8B7Su7vorQCi7suDRQZZZCTzvIoddDQAQI6l0HlLN9hBY74IHBNFynd7gpXyV5KkxESNiHx/yeAtNMz63SPo5oqe+imz7WjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971877; c=relaxed/simple;
	bh=9y3h/bFfjfawoG3TlsCAvL7qmyVcXWNJW88IOSauxpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r2DqaJaMRix5dWLWVgp0xUO1VfHE88GIx23JBrYM6V7tpE8W+JTnkUcdaZRFN7vNQIeyZtjLSMl5BYNP7sbCEXaRfVKMFQrwsIYYm1/rqGTXyv/I/Wpxo/gtdiiM9JGJwMTG4qnFf7xTClrrZ+RAL5I6coO0bPrrbQGYoasCnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/1M8oTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC2C32786;
	Tue,  6 Aug 2024 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722971876;
	bh=9y3h/bFfjfawoG3TlsCAvL7qmyVcXWNJW88IOSauxpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c/1M8oTeDtAz0hE5gva99J6EUlNCL7mY1LhGgbBayaTganh6WCgVGXxKv1KsDXEZp
	 NLfodigA9jyvqH8ax8ysVqTNjke5AGr4h7edb7LRD8aCM0WPjh2pvQ0IwPe31MoW1w
	 Se5PSp6eWvueSA4OyPbI2VmzoycZvFxZYpYdpLd88bhu1mUQOxv6Y0YQUhLWEF+lqh
	 YLQOO9wmItFMoQU8CAbcuPl1SwaR+Ajsc8o4EwoSi07yix4RojX0VbDOEUilJo0FAS
	 PYM5jP7zUB1zb+Wks7uyjl/YVAnc2QZiwF3hw0oWKXteDO4R99Cfpzr/o2eISdT80f
	 ZxEM0GIAeTZYQ==
Date: Tue, 6 Aug 2024 14:17:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: 412574090@163.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH] PCI/ERR: Use PCI_POSSIBLE_ERROR() to check config reads
Message-ID: <20240806191754.GA73658@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806065050.28725-1-412574090@163.com>

On Tue, Aug 06, 2024 at 02:50:50PM +0800, 412574090@163.com wrote:
> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> Use PCI_POSSIBLE_ERROR() to check the response we get when we read data
> from hardware.  This unifies PCI error response checking and makes error
> checks consistent and easier to find.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>

Thanks, applied to pci/hotplug for v6.12.

> ---
>  drivers/pci/hotplug/cpqphp_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index e9f1fb333a71..718bc6cf12cb 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -138,7 +138,7 @@ static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 o
>  
>  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
>  		return -1;
> -	if (vendID == 0xffffffff)
> +	if (PCI_POSSIBLE_ERROR(vendID))
>  		return -1;
>  	return pci_bus_read_config_dword(bus, devfn, offset, value);
>  }
> @@ -253,7 +253,7 @@ static int PCI_GetBusDevHelper(struct controller *ctrl, u8 *bus_num, u8 *dev_num
>  			*dev_num = tdevice;
>  			ctrl->pci_bus->number = tbus;
>  			pci_bus_read_config_dword(ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
> -			if (!nobridge || (work == 0xffffffff))
> +			if (!nobridge || PCI_POSSIBLE_ERROR(work))
>  				return 0;
>  
>  			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
> -- 
> 2.25.1
> 

