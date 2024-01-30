Return-Path: <linux-pci+bounces-2843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82293842F31
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 22:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52F11C2480E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671FF7D3E9;
	Tue, 30 Jan 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9uVnBa8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278457D3E3;
	Tue, 30 Jan 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651656; cv=none; b=MSLRyESbpHNIekqzJ5IvSWjRxsruUR4iZl1wd/yB4d5k/aGuohLAIbraLWvLHnVCoBat/KLsWzSq0QtFoGYu1K7INRH0oi0RHzjKffhINu9vXTPmZ+zgA6u5d620Qa9+mpxwdEi4ctQy82Cd5ZdlTrmK5+DvwtR6DBJrJePZVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651656; c=relaxed/simple;
	bh=LTMVYrnQ0Ac5UrUfHkqd52vj2qm9n46fuacsL4mVVR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT5c683JYJ/sloXDikQCsJ9kI1N9+q+5z6aaLXVtoSsjJWHN6I5WOEHfTWdTjBIYci3CM40L5d4kSMOEKp7Lhfyif39km5fwc23zSqUztDWdVvQknPw+93o2jpSTsA85G0lIXDhtrfGwxe6yM/XdBWvMEPcbOgxqzBDqtxs0uJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9uVnBa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482CC433F1;
	Tue, 30 Jan 2024 21:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706651655;
	bh=LTMVYrnQ0Ac5UrUfHkqd52vj2qm9n46fuacsL4mVVR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9uVnBa8V4EX3P0L1wK1PVj+miY4+RIkfPIpH2K9TfKIAIQN9ZgpI+Ru+O9K0+Cde
	 YKHMlEpMJ3tf1RwQ90YWtoBLJvxkS5uP5vAO914uS1bErG4AX1gB3ja33Nnpb8obPw
	 vvomTc7HUQSZ3vqbhEm7l3Jq0JrL5ZmjRchPK+b+pRY1DLx2gnBBjVc+9hgleG3odt
	 JXOwZu8e7iPvzuvHTQZV9CTGrBAIVR0aNv6qwPnyfu3foshVlhkE6Hrh4Q7dgbloL8
	 cBFVhghTwNmG/tvmyoVAbKAXhwG1H9IdWkfbUz/WvPYTgDCqUybPNsVpRTzqeQLBfL
	 7Eh52wD8vn8hQ==
Date: Tue, 30 Jan 2024 15:54:10 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: [PATCH 4/9] PCI: create platform devices for child OF nodes
 of the port node
Message-ID: <d2he3ufg6m46zos4swww4t3peyq55blxhirsx37ou37rwqxmz2@5khumvic62je>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh>
 <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
 <2024011836-wok-treadmill-c517@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024011836-wok-treadmill-c517@gregkh>

On Thu, Jan 18, 2024 at 12:15:27PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 11:58:50AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Jan 17, 2024 at 5:45 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 17, 2024 at 05:07:43PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > In order to introduce PCI power-sequencing, we need to create platform
> > > > devices for child nodes of the port node.
> > >
> > > Ick, why a platform device?  What is the parent of this device, a PCI
> > > device?  If so, then this can't be a platform device, as that's not what
> > > it is, it's something else so make it a device of that type,.
> > >
> > 
> > Greg,
> > 
> > This is literally what we agreed on at LPC. In fact: during one of the
> > hall track discussions I said that you typically NAK any attempts at
> > using the platform bus for "fake" devices but you responded that this
> > is what the USB on-board HUB does and while it's not pretty, this is
> > what we need to do.
> 
> Ah, you need to remind me of these things, this changelog was pretty
> sparse :)
> 

I believe I missed this part of the discussion, why does this need to be
a platform_device? What does the platform_bus bring that can't be
provided by some other bus?

(I'm not questioning the need for having a bus, creating devices, and
matching/binding them to a set of drivers)

Regards,
Bjorn

> > Now as for the implementation, the way I see it we have two solutions:
> > either we introduce a fake, top-level PCI slot platform device device
> > that will reference the PCI host controller by phandle or we will live
> > with a secondary, "virtual" platform device for power sequencing that
> > is tied to the actual PCI device. The former requires us to add DT
> > bindings, add a totally fake DT node representing the "slot" which
> > doesn't really exist (and Krzysztof already expressed his negative
> > opinion of that) and then have code that will be more complex than it
> > needs to be. The latter allows us to not change DT at all (other than
> > adding regulators, clocks and GPIOs to already existing WLAN nodes),
> > reuse the existing parent-child relationship between the port node and
> > the instantiated platform device as well as result in simpler code.
> > 
> > Given that DT needs to be stable while the underlying C code can
> > freely change if we find a better solution, I think that the second
> > option is a no-brainer here.
> 
> Ok, I remove my objections, sorry about that, my confusion.
> 
> greg k-h

