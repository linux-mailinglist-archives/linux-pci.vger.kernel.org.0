Return-Path: <linux-pci+bounces-44527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E3D1416B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6F930A21A5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17341365A11;
	Mon, 12 Jan 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3QyeSil"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4780332EB3;
	Mon, 12 Jan 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235499; cv=none; b=Z5b4DdCR1ACXZaIQmkx3LfN8bt05H6UD6OFO32/IELaQxtBay2G/eY7uoxF4530an+urWwRAEU4uSFPciLbyhkCgaJTCXRb2yyqdYbt8vzQBn4ydBlkxxPogAN0e+lg7wSwdNNNH+8KHv8L4XSE1f+ZjvBSzI4zvWQKJuf1jsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235499; c=relaxed/simple;
	bh=CjrbP1mEaA5EQy2+OvYojgdtdzWXcCxBpcTAwZUK588=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooRPE3+9pLRb6YDXheeMQxICkAKVuxjMcCaHhlI2qVCsAsYKJMCQeV2HNUVw1HhupwsQpnqLCxBcyuU/T8RB5jGn4hmi0VQooEAs8/dY5mno+hVz1v0SUpT1cffBfbDuPSZSi0GRlWpLt1B5nEhA8D013Gnp/NIdXsw8fdmYiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3QyeSil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF7C116D0;
	Mon, 12 Jan 2026 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235498;
	bh=CjrbP1mEaA5EQy2+OvYojgdtdzWXcCxBpcTAwZUK588=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3QyeSilxBh+qsAUfVisRQ1SDImbABzyRrTqnuC3U6hyfJKfCokpRv4K194UfUg2P
	 IAIboMOGC0qiUk5Aytg0oQCtXJIrRGAlJ0yiy6hFT7TPWBv+Uu1jeeqocry4Rs83Uv
	 G8NkqFeGoZNkb1dXiumN5dcVaGhR+yKsSqbHg2unHJOWZWe9TKtjP/FBv5lGQxkUbc
	 VloyXrPlK5XGTfWRmtkv/uBq3rZbZutqCDg0DfCZjBx00oLRe57b9HCGBquuN2f7nJ
	 D1f2DTW1LfJIlmDs1bADpaFdFJyVvbs1SCYeKd4hV79YTAGUFgY2DqvBEdvXBBGaXa
	 QuAFdy06RAzKg==
Date: Mon, 12 Jan 2026 22:01:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <ljqd5ovcsg7t62tdzd77w5mv5buawm3x7xyapy7n7l7azcaorh@tytj46t2lxyb>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
 <aWSwgRiEkT9unYw9@smile.fi.intel.com>
 <6peb6afhpm4l7opxbdt3b5sx32longevwds5c3dlqji2hr5dlh@kxuvj55jkqgi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6peb6afhpm4l7opxbdt3b5sx32longevwds5c3dlqji2hr5dlh@kxuvj55jkqgi>

On Mon, Jan 12, 2026 at 02:32:21PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 12, 2026 at 10:27:45AM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > > + Dmitry Torokhov (who was against this patch previously)
> > > 
> > > On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> > > > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > 
> > > > > Because the software node backend of the fwnode API framework lacks an
> > > > > implementation for the .device_get_match_data function callback.
> > > > 
> > > > Maybe this is done on purpose. Have you thought about this aspect?
> > > 
> > > IMO, software nodes were introduced to add sub-properties to the existing
> > > firmware nodes, but it has usecase/potential to go beyond that. More below.
> > 
> > Potential doesn't mean the necessity.
> > 
> > > > > This makes it difficult to use(and/or test) a few drivers that originates
> > > > > from DT world on the non-DT platform.
> > > > 
> > > > How difficult? DSA implementation went to the way of taking DT overlay
> > > > approach. Why that one can't be applied here?
> > > 
> > > Sometimes you do not have any DT node at all.
> > 
> > Yes, that is exactly the case I have referred to. The PCI core (in Linux)
> > is able to create DT subtree on non-OF based platforms.
> > 
> 
> Maybe I should look into creating dynamic DT node for the device and insert it
> to the uart node. Theoretically it should work.
> 

It worked flawlessly. So I sent v4 incorporating this design:
https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

