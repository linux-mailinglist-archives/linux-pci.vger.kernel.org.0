Return-Path: <linux-pci+bounces-12944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB39712DF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525EC1C2216E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA91B29C0;
	Mon,  9 Sep 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4rPJh2v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA241B29AA;
	Mon,  9 Sep 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872626; cv=none; b=LPwFrCJTkHs+MOagmPx/AfKJ8F/ACQGgT1tpexL8kuBbH6VSSInRor37s+9S58KPZUF3w6n6EIyOyxKlKZpmfvPuNq9L8LRMZ5JDvq8NydjVCPMEUd1aNv8WmadfCqXiVx24x8QtFCYNGZ1sL9VfD/LHOT1A2R0qMSxgL/xKpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872626; c=relaxed/simple;
	bh=21jNyjkbDAwB0gHxBn2d6ckzlzOlfipq+AF+WbSEHmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZHFLddLcgFRwgz/qFogjUrYvarzSLMjipej8L2Cxqqg25L2VMRAlYPDFohSMElN5E7cnuGOMBxEsoBOGFP3M3hg++jSm3zieCBYUG5MmjD3yyI/f+gLLCXcF4A7JdK/XJfezOtrExUM4Va64xzRiVSrtYIi8ac+HLBcvRR61SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4rPJh2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7B5C4CEC5;
	Mon,  9 Sep 2024 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872626;
	bh=21jNyjkbDAwB0gHxBn2d6ckzlzOlfipq+AF+WbSEHmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4rPJh2vR1xMDjkpABfD+X2bg3huGInWSQKG9eMErrq8N7tVQDdKamG1u6d99uDcp
	 lDulgdff1izLriJzRkI739H6L4/jZ9Pd+W77OLS7AT13dJ4Ih/LPQKjRdpR/sw5pa3
	 t3nPe6aWbeDrDZyHiBNWSrFw+8LBHLIUeGa2iHtYydYOcNlXDFJIK8A7tHRq12czTw
	 iOkZLqitvR+TvTt4z3h2RpzdPq67l8I6R3ZSwg/DS5+hZnhC7E4PYj5cTXdb2zLFQ4
	 kt2ZFoxUEqWukXh4w99XYVTnNin94KxOMBavDd67AmyFCPHKzK8cqcR4wkhUSe8Q60
	 FfutYzk/8OhHg==
Date: Mon, 9 Sep 2024 10:03:40 +0100
From: Lee Jones <lee@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 1/3] leds: Init leds class earlier
Message-ID: <20240909090340.GA6556@google.com>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
 <20240904104848.23480-2-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904104848.23480-2-mariusz.tkaczyk@linux.intel.com>

On Wed, 04 Sep 2024, Mariusz Tkaczyk wrote:

> NPEM driver will require leds class, there is an init-order conflict.
> Make sure that LEDs initialization happens first and add comment.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>

Do you have a link to this discussion?

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> ---
>  drivers/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fe9ceb0d2288..45d1c3e630f7 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -17,6 +17,9 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
>  obj-$(CONFIG_GPIOLIB)		+= gpio/
>  obj-y				+= pwm/
>  
> +# LEDs must come before PCI, it is needed by NPEM driver

This seems very fragile.

Isn't there a better way to describe the dependency in Kconfig etc?

> +obj-y				+= leds/
> +
>  obj-y				+= pci/
>  
>  obj-$(CONFIG_PARISC)		+= parisc/
> @@ -130,7 +133,6 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
>  obj-y				+= mmc/
>  obj-y				+= ufs/
>  obj-$(CONFIG_MEMSTICK)		+= memstick/
> -obj-y				+= leds/
>  obj-$(CONFIG_INFINIBAND)	+= infiniband/
>  obj-y				+= firmware/
>  obj-$(CONFIG_CRYPTO)		+= crypto/
> -- 
> 2.35.3
> 

-- 
Lee Jones [李琼斯]

