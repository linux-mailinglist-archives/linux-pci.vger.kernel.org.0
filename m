Return-Path: <linux-pci+bounces-44769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63DD20136
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6625530A18C3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD53A1D0F;
	Wed, 14 Jan 2026 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amjRuC+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C63A1CF8;
	Wed, 14 Jan 2026 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406568; cv=none; b=qwBhGO4AXz5s2xqMN3NFHJ3oruESu3WnYeqA4v5BotOxBSPA3bKy9ksfH2A1ChyYTE2VaEZpNYU8TyHOM9G2owRpr+UJgnqiIVyAeqb8nD0h3CNeHxX56CGYBninKStoiY0XLc/YRtU40RDriziIH5JHgj08R8kq9KJahkPOxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406568; c=relaxed/simple;
	bh=wV599lCJWD0emKelFhGhRgh0UvESyeT0Bez9AhUAqT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGwHdtzOWVN0hOYMDs+j5qQchkBEuiNV6y+Og+dk2LJmCIv5rsGgq8Uxar0gcPPPonuVcMNe3tk5Sqwt4nkvqTf6qwA8aWwAK48luWr/tQn0NgKew2U09p5Pb12YYGX7TGdi6+lVt8JtrLY8JlsZh+UlMvyKA1A9fvq+rt/Uyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amjRuC+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19C6C4CEF7;
	Wed, 14 Jan 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406568;
	bh=wV599lCJWD0emKelFhGhRgh0UvESyeT0Bez9AhUAqT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amjRuC+hzMMz1fjJtD3vxq0/PyncJeQaxN6oumutA9TDFFzsHXZiPRWkTyDaPx1L7
	 x60fNiIqCaukd3UJ2ypQbfqJmIvgHEqRNqnBHMdkPr1YSVvLeGRg3APG/LwMvndL7k
	 ajBfiwH18gdzIkwdV2RqFe49OsVAYEISChpUA29BDELP70bUZ0Kqpc9kOf7yme2h58
	 RGLuF90Nq/sIT8nwEiSL/e/WXx8gBr1peOR5gJgsam7O+jrFSF9XT+YwX7X89a5Nyn
	 z7518tgIzLcTQFJZJ2Hm0snF6IKFw9DQ7B6c14aydH10VFVetbjdyqXCflkaBeLZqv
	 xb+U05Wn3YWlQ==
Date: Wed, 14 Jan 2026 21:32:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 3/9] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
Message-ID: <zvwvsflb6aejqwhwbacux3v46fwlfo7m54n5apvrxdqklnq6va@qxsxhk45gopi>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-3-eff84d2c6d26@oss.qualcomm.com>
 <aWVKTnatLTGwmNVh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWVKTnatLTGwmNVh@smile.fi.intel.com>

On Mon, Jan 12, 2026 at 09:23:58PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 12, 2026 at 09:56:02PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > If an external connector like M.2 is connected to the serdev controller
> > in DT, then the serdev devices may be created dynamically by the connector
> > driver. So do not return -ENODEV from of_serdev_register_devices() if the
> > static nodes are not found and the graph node is used.
> 
> ...
> 
> > +	if (!found && !of_graph_is_present(ctrl->dev.of_node))
> 
> dev_of_node()
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

