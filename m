Return-Path: <linux-pci+bounces-44768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D325AD20034
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C67D3001BC1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758063A1CFB;
	Wed, 14 Jan 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv6Jwqug"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9112459D9;
	Wed, 14 Jan 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406441; cv=none; b=QyV/DhZKwoAWoO+CQt4qwjUpHovs9CX1ZJVyDt7FMcUDSn4EmSNEiPKdf5LPX1ZnnNAZT0esmYid8EfdPg0yzT62CBhsKAlSM4XOo75qFJuR9Nz/tPjRkzMaHBQrANV4SJR3fF6UsLINXmVymBkufr3xe4zhA71HAwUJ1tAHbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406441; c=relaxed/simple;
	bh=UQRJ5fcHhllBfv67yGhnNCJ+Tsu6dEXBnujxEqv1usA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orlmbs7Eg7Bum23WhjgieQd2FaQ6l+D9NERRIiedn9Du5kg5/BbQxKnu+myAFj8ADfcBvmt+ChZGHc+EeFYHIecTC6cDmjSrTcMgWADO+oPJLFn19Oa371UjJQRi/03W9roHqc7TOFtvPsu4446KyUuOhCuqLMvVcLpzif1xYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv6Jwqug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9C0C4CEF7;
	Wed, 14 Jan 2026 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406440;
	bh=UQRJ5fcHhllBfv67yGhnNCJ+Tsu6dEXBnujxEqv1usA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv6Jwqughj9EJzqz+t+wK38BiQT/64D4Qc8eIsadsxCORoTCISzN9YG1rpQ3yTsGQ
	 N9jVj96OzvxxpXvncaXTTFORVsaKTgOA4IgARR3sKY46Ha5ZUGe2EV4SuRMN7Db1BY
	 ZbkAbcJM5lukvvtC9yO3CLZB3Pf1bJOHkinkUmXV8hcSv0vwzrrWqePlk4vphhZdXl
	 jGGePLJWeJmv/UaNwiI3dWS4ZHFhtFiRwliITrQvQc8rx+BF8H8R90Ih6Vpym27tsm
	 bk4VdHbxA7U7J7IXJ6G7BaD2cTxScUXatw7hyIDWpQps6KXTcF15s9N8iA18mBwifw
	 MxrCfGmDVzgNw==
Date: Wed, 14 Jan 2026 21:30:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
Message-ID: <jngg3qmacno5obsz3ksaggt2pg5btrtuwjwuzrqr7x6timnm5n@ez6ta7uvql7i>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
 <2a44e967-ebae-4641-88d7-ccb4536ee3b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a44e967-ebae-4641-88d7-ccb4536ee3b7@kernel.org>

On Wed, Jan 14, 2026 at 03:01:51PM +0100, Hans de Goede wrote:
> Hi Mani,
> 
> Thank you for your work in this.
> 
> On 12-Jan-26 17:26, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Add of_find_serdev_controller_by_node() API to find the serdev controller
> > device associated with the devicetree node.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/tty/serdev/core.c | 16 ++++++++++++++++
> >  include/linux/serdev.h    |  9 +++++++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index b33e708cb245..25382c2d63e6 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -504,6 +504,22 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_controller_alloc);
> >  
> > +/**
> > + * of_find_serdev_controller_by_node() - Find the serdev controller associated
> > + *					 with the devicetree node
> > + * @node:	Devicetree node
> > + *
> > + * Return: Pointer to the serdev controller associated with the node. NULL if
> > + * the controller is not found.
> > + */
> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> > +{
> > +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> > +
> > +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> > +
> 
> This new of_find_serdev_controller_by_node() function needs:
> 
> #ifdef CONFIG_OF ... #endif
> 
> around it, to match the stubbing you are doing in serdev.h
> 

Ack.

> >  static int of_serdev_register_devices(struct serdev_controller *ctrl)
> >  {
> >  	struct device_node *node;
> > diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> > index ecde0ad3e248..db9bfaba0662 100644
> > --- a/include/linux/serdev.h
> > +++ b/include/linux/serdev.h
> > @@ -333,4 +333,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
> >  }
> >  #endif /* CONFIG_ACPI */
> >  
> > +#ifdef CONFIG_OF
> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
> > +#else
> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> > +{
> > +	return NULL;
> > +}
> 
> stubs like this one should be static inline to avoid warnings like this one:
> 
> In file included from drivers/tty/serdev/core.c:21:
> ./include/linux/serdev.h:339:27: warning: no previous prototype for ‘of_find_serdev_controller_by_node’ [-Wmissing-prototypes]
>   339 | struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Darn... Will fix it. Thanks for spotting!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

