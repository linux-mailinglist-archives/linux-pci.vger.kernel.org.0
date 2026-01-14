Return-Path: <linux-pci+bounces-44767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A279CD200A6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D07A30FB138
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31F3A1CE4;
	Wed, 14 Jan 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur3U5zKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B853A1A4B;
	Wed, 14 Jan 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406296; cv=none; b=EqlJmTv+Tkqg16iFoV0gqkISplzL8K4ZkiskmBCcvty4QMGhpzSbUDq00er9apFKoAI2riDGb7jJY5JO53WoQ8wrUaMh/hAqXNfrN9UM0ifEe/nx6BFZPvaZGvOzT+1JW8sdpUsiW/w+6t/EQnwAkw2kxsY+oJEQlPzBNY+yw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406296; c=relaxed/simple;
	bh=QanyVSWBKe+JzUOUmqB7BTbGxRlV2DYOfGGSfkoxW/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8oCQGimH9+dticGNnuulnDtrRP7XGP8ZhwPfuLWo3eoIbpwjrTNl7RGtCrDdDN46GxAGUyfWEV+CngHZp6zy+GX3LFWzW6P33TGHDTz6mXdFD3x9Gw4mpceDy0mT/NaXoiAgciva44KUTfl28UXz1qqWF3JS0FMRqSI2oD7a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur3U5zKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E54C2BC86;
	Wed, 14 Jan 2026 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406296;
	bh=QanyVSWBKe+JzUOUmqB7BTbGxRlV2DYOfGGSfkoxW/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur3U5zKd022GEGRb35k3dsX/tO52q0f3pgneM/wQUcB9PpHxHRTRQtfjlAQ3+qFlE
	 ItIDvKE6ABHe/VW87R1pES/MnSr7CcPkuNs/FW7k7bqF8lNba8t5TB2khwQUMhdnRg
	 WurWq/sGkak85C5s65HIalRX21bpmTR0attY8YyeiS8Yl2xLYHQ0KY93/3RxRt16fo
	 WAlH4LQv8i8+uda+N6kp9oHJXHwxhKIF1QmUInreUXKEhJW97shC8W40dlEif/XBPD
	 ZsqwZGarT1b+8buck8v7R/kyzSwQlfYl9fpgTgz0+MSVdZ1rd96IAyU9M0LriKip2F
	 FYVUTKvMXBHsw==
Date: Wed, 14 Jan 2026 21:27:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
Message-ID: <ulj3qaurlauut76oyatdtkbo22jqsll43kzu272y2j32753ac6@gwmolgrilxeh>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
 <CAMRc=McDvQoqfH0Gy-wzbcEGvNCZACSACCcviwpCc4YNSpKYrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McDvQoqfH0Gy-wzbcEGvNCZACSACCcviwpCc4YNSpKYrw@mail.gmail.com>

On Tue, Jan 13, 2026 at 08:54:55AM -0500, Bartosz Golaszewski wrote:
> On Mon, 12 Jan 2026 17:26:01 +0100, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
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
> 
> Please also say that the caller is responsible for calling
> serdev_controller_put() on the returned object.
> 

Ack.

- Mani

> Bart
> 
> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> > +{
> > +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> > +
> > +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> > +
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
> > +#endif /* CONFIG_OF */
> > +
> >  #endif /*_LINUX_SERDEV_H */
> >
> > --
> > 2.48.1
> >
> >
> >

-- 
மணிவண்ணன் சதாசிவம்

