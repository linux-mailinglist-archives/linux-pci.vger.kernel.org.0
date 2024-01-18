Return-Path: <linux-pci+bounces-2317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8E831844
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 12:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00451F2300C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33722376E;
	Thu, 18 Jan 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RDlOUNNR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3123760;
	Thu, 18 Jan 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576530; cv=none; b=nB3fJEDyLjZzzsZS6iRyHD+rLkbR0nJLCAwtNdcw/aarR1PqvUBcADcJeNcL76q8ctnkwec7Bt65BVtV0PiCJz7umebKJ5Z7+iq6Krk0IdVpdQv+wvfHfCVIPNdIyTtT9Vw70thfq5VLh4iIY9ZPITEtMEClHWBB7mPsWhZI4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576530; c=relaxed/simple;
	bh=w0FBrm4sVu/DLk+0aSDbplyxxPuYJ1uOLaE9EFkd7dc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=ou3syrqEV/+QTF+prdRg8op3aF4sQxlCpDwkGLaJmIVA3NBj5BiRoY+mlwhgvbuHqfy611o7vLb+KHw7kmpKTpNczxJplDflwzp/B/hAhC9OJNrGls/C/2LW1fO/d+dM9NNd+d1Nug6KDKUYay+XMrC93dBW7Ud5wrNuRLmcR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RDlOUNNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67825C433F1;
	Thu, 18 Jan 2024 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705576529;
	bh=w0FBrm4sVu/DLk+0aSDbplyxxPuYJ1uOLaE9EFkd7dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDlOUNNRGsPbYHC1L726WS5dkr3VOCBjd+MqAQ3JUuhv4MGJkXgYEYB+5YyQ6MDp6
	 NB6nu7QYWRq3V7fuP2fZxIS74bHee+zZbKSxRibWClXO4RxoPVbNRHIvtWjRA0ba7D
	 gXUqRp/5zTN7aJpa6bWv04Guwid8cuyD5nfl4a9Y=
Date: Thu, 18 Jan 2024 12:15:27 +0100
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
Message-ID: <2024011836-wok-treadmill-c517@gregkh>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh>
 <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>

On Thu, Jan 18, 2024 at 11:58:50AM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 17, 2024 at 5:45 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 17, 2024 at 05:07:43PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > In order to introduce PCI power-sequencing, we need to create platform
> > > devices for child nodes of the port node.
> >
> > Ick, why a platform device?  What is the parent of this device, a PCI
> > device?  If so, then this can't be a platform device, as that's not what
> > it is, it's something else so make it a device of that type,.
> >
> 
> Greg,
> 
> This is literally what we agreed on at LPC. In fact: during one of the
> hall track discussions I said that you typically NAK any attempts at
> using the platform bus for "fake" devices but you responded that this
> is what the USB on-board HUB does and while it's not pretty, this is
> what we need to do.

Ah, you need to remind me of these things, this changelog was pretty
sparse :)

> Now as for the implementation, the way I see it we have two solutions:
> either we introduce a fake, top-level PCI slot platform device device
> that will reference the PCI host controller by phandle or we will live
> with a secondary, "virtual" platform device for power sequencing that
> is tied to the actual PCI device. The former requires us to add DT
> bindings, add a totally fake DT node representing the "slot" which
> doesn't really exist (and Krzysztof already expressed his negative
> opinion of that) and then have code that will be more complex than it
> needs to be. The latter allows us to not change DT at all (other than
> adding regulators, clocks and GPIOs to already existing WLAN nodes),
> reuse the existing parent-child relationship between the port node and
> the instantiated platform device as well as result in simpler code.
> 
> Given that DT needs to be stable while the underlying C code can
> freely change if we find a better solution, I think that the second
> option is a no-brainer here.

Ok, I remove my objections, sorry about that, my confusion.

greg k-h

