Return-Path: <linux-pci+bounces-2967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF438464BD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 01:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A4E1C2372F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28E137B;
	Fri,  2 Feb 2024 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1O0LXPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56BA4C71;
	Fri,  2 Feb 2024 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832198; cv=none; b=ZvLvFtPL76f50iY77iGChNyC9cKG45fNQwXHxLxcWlsj6EOOgB94RfBl8mWN4hT78f3ag10v5y0cKGil4zS6KAbqap3VUTB1pT8aafExvAqFNt+5RAvJE0h2PUDAEIA+ETz1pCu80QSp9lIEq1Mi/GLTWedUv6bbafd5d6xeStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832198; c=relaxed/simple;
	bh=S77eR3+aBnUK3p2BE5Am64ezv1OvD+YOIoEHYe29IuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRVTNj4KTS3xbmMJH1e9f2z8BKzdN8lEulStru61NTFKWNs53piWBTQo0K+kOlRT4ygVFLr3kLh4E72UQ4UKOjN0H+HdsTHDfvVec+NDnVaOcOK3FmMuoaVWVdoM2gKIhXues1JmogqOQPJkfLvmv8yshpaSAG7qpZixOupOF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1O0LXPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F322C433F1;
	Fri,  2 Feb 2024 00:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706832197;
	bh=S77eR3+aBnUK3p2BE5Am64ezv1OvD+YOIoEHYe29IuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1O0LXPhHzpi1Rs6bzSdUB3LcjO1MINeMXN+1VP+sLsOBbB1lmcWYZuIO4+mnQAL7
	 MpNreOS7S3fgAQVhYTOwYixsFgyWORbDq1gNT16Srdh7+9QduAlF2WLSh7ATYq9A/m
	 Y0Lm0CB7nQpLHDTRuIF6IujMeKqllKNE//q8Nn3cMmddLrW3fdHEFrHNrIdxf9+VMQ
	 1T/iRH19Hl/og9XJiEqS8kUbH26YuegOXXgC2QmD8Clxt3tze7TsIaPCE17/GfHVgz
	 xNSreoCPH085OxjKknjT/WMdY6EMheAbPZNwG25VNnB9eCHX5WAsJbaqJNBaD471hM
	 CnqXZHJo7xVJg==
Date: Thu, 1 Feb 2024 18:03:12 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	=?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: Re: Re: [PATCH 4/9] PCI: create platform devices for child OF
 nodes of the port node
Message-ID: <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh>
 <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
 <2024011836-wok-treadmill-c517@gregkh>
 <d2he3ufg6m46zos4swww4t3peyq55blxhirsx37ou37rwqxmz2@5khumvic62je>
 <CAMRc=MeXJjpJhDjyn_P-SGo4rDnEuT9kGN5jAbRcuM_c7_aDzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeXJjpJhDjyn_P-SGo4rDnEuT9kGN5jAbRcuM_c7_aDzQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 12:04:14PM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 30, 2024 at 10:54 PM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Thu, Jan 18, 2024 at 12:15:27PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 18, 2024 at 11:58:50AM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Jan 17, 2024 at 5:45 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Jan 17, 2024 at 05:07:43PM +0100, Bartosz Golaszewski wrote:
> > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > >
> > > > > > In order to introduce PCI power-sequencing, we need to create platform
> > > > > > devices for child nodes of the port node.
> > > > >
> > > > > Ick, why a platform device?  What is the parent of this device, a PCI
> > > > > device?  If so, then this can't be a platform device, as that's not what
> > > > > it is, it's something else so make it a device of that type,.
> > > > >
> > > >
> > > > Greg,
> > > >
> > > > This is literally what we agreed on at LPC. In fact: during one of the
> > > > hall track discussions I said that you typically NAK any attempts at
> > > > using the platform bus for "fake" devices but you responded that this
> > > > is what the USB on-board HUB does and while it's not pretty, this is
> > > > what we need to do.
> > >
> > > Ah, you need to remind me of these things, this changelog was pretty
> > > sparse :)
> > >
> >
> > I believe I missed this part of the discussion, why does this need to be
> > a platform_device? What does the platform_bus bring that can't be
> > provided by some other bus?
> >
> 
> Does it need to be a platform_device? No, of course not. Does it make
> sense for it to be one? Yes, for two reasons:
> 
> 1. The ATH11K WLAN module is represented on the device tree like a
> platform device, we know it's always there and it consumes regulators
> from another platform device. The fact it uses PCIe doesn't change the
> fact that it is logically a platform device.

Are you referring to the ath11k SNOC (firmware running on co-processor
in the SoC) variant?

Afaict the PCIe-attached ath11k is not represented as a platform_device
in DeviceTree.

Said platform_device is also not a child under the PCIe bus, so this
would be a different platform_device...

> 2. The platform bus already provides us with the entire infrastructure
> that we'd now need to duplicate (possibly adding bugs) in order to
> introduce a "power sequencing bus".
> 

This is a perfectly reasonable desire. Look at our PMICs, they are full
of platform_devices. But through the years it's been said many times,
that this is not a valid or good reason for using platform_devices, and
as a result we have e.g. auxiliary bus.

Anyway, (please) don't claim that "we need to", when it actually is "we
want to use platform_device because that's more convenient"!

Regards,
Bjorn

> Bart
> 
> > (I'm not questioning the need for having a bus, creating devices, and
> > matching/binding them to a set of drivers)
> >
> > Regards,
> > Bjorn
> >
> 
> [snip]

