Return-Path: <linux-pci+bounces-3454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD88854CED
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FA91F219DA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64A5D75E;
	Wed, 14 Feb 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icQpm+WR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E95C911;
	Wed, 14 Feb 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924861; cv=none; b=l5dbOGSG6VkEyU/Qlst8WBfMdlavVZeDDn8NpQ9VjTTX7r1inSoOEWST5NX9Kdlyy1jG6ZcHv2WjZPqBN8YRczvr9X7/eEJ9Hv/zA22aEwJpr5rYO98EbJFtMiZaUs//5S0Xhukt6kCRZW6EWJ0q1rKLf4MyMU8nwTGtAyeBloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924861; c=relaxed/simple;
	bh=RKBYgy5uDM/vBCiN9tBiPR2VpHrXnY5fjxo9XKnCKHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPpBQIPzdhETCMZWjvAcYR/1GtygqJBmxmgMNPy5VjB8Sm5Q5pc6CGT6xiVr3pbgJr12y4gTL7tHVoeNeet6U6ukd0LZSlwreNDOyjAwxxHwjiMvWVArzlFmwOp6ZYrd8Rt2hudaYOTQfrAaoPArWQPVPFtigeVhP/ZrvNRMSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=icQpm+WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB29C433C7;
	Wed, 14 Feb 2024 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924860;
	bh=RKBYgy5uDM/vBCiN9tBiPR2VpHrXnY5fjxo9XKnCKHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icQpm+WRIBCwFmc6GMZyzD7hfrgvougrzlFkQQkENhX2hhFv4tKvrybec2LZPF0p2
	 g4w+i5vJ2cylBctHyW7nrVqW6KPr/tAxRaWjizo57DBTGi3DOfHaFJKv8GA3osWQx5
	 zkW+b+wjJITdz0ojCZY2Ccjx1teFWK8MymvaLyFA=
Date: Wed, 14 Feb 2024 16:34:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: Re: Re: [PATCH 4/9] PCI: create platform devices for child OF
 nodes of the port node
Message-ID: <2024021413-grumbling-unlivable-c145@gregkh>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh>
 <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
 <2024011836-wok-treadmill-c517@gregkh>
 <d2he3ufg6m46zos4swww4t3peyq55blxhirsx37ou37rwqxmz2@5khumvic62je>
 <CAMRc=MeXJjpJhDjyn_P-SGo4rDnEuT9kGN5jAbRcuM_c7_aDzQ@mail.gmail.com>
 <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za>
 <CAMRc=McT8wt6UbKtyofkJo3WcyJ-S4d2MPp8oZmjWbX6LGbETQ@mail.gmail.com>
 <CAMRc=MeWgp27YcS=-dbYdN1is1MEuZ2ar=pW_p9oY0Nf1EbFHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeWgp27YcS=-dbYdN1is1MEuZ2ar=pW_p9oY0Nf1EbFHA@mail.gmail.com>

On Wed, Feb 07, 2024 at 05:32:38PM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 2, 2024 at 11:02 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Fri, Feb 2, 2024 at 1:03 AM Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> >
> > [snip]
> >
> > > > >
> > > > > I believe I missed this part of the discussion, why does this need to be
> > > > > a platform_device? What does the platform_bus bring that can't be
> > > > > provided by some other bus?
> > > > >
> > > >
> > > > Does it need to be a platform_device? No, of course not. Does it make
> > > > sense for it to be one? Yes, for two reasons:
> > > >
> > > > 1. The ATH11K WLAN module is represented on the device tree like a
> > > > platform device, we know it's always there and it consumes regulators
> > > > from another platform device. The fact it uses PCIe doesn't change the
> > > > fact that it is logically a platform device.
> > >
> > > Are you referring to the ath11k SNOC (firmware running on co-processor
> > > in the SoC) variant?
> > >
> > > Afaict the PCIe-attached ath11k is not represented as a platform_device
> > > in DeviceTree.
> > >
> >
> > My bad. In RB5 it isn't (yet - I want to add it in the power
> > sequencing series). It is in X13s though[1].
> >
> > > Said platform_device is also not a child under the PCIe bus, so this
> > > would be a different platform_device...
> > >
> >
> > It's the child of the PCIe port node but there's a reason for it to
> > have the `compatible` property. It's because it's an entity of whose
> > existence we are aware before the system boots.
> >
> > > > 2. The platform bus already provides us with the entire infrastructure
> > > > that we'd now need to duplicate (possibly adding bugs) in order to
> > > > introduce a "power sequencing bus".
> > > >
> > >
> > > This is a perfectly reasonable desire. Look at our PMICs, they are full
> > > of platform_devices. But through the years it's been said many times,
> > > that this is not a valid or good reason for using platform_devices, and
> > > as a result we have e.g. auxiliary bus.
> > >
> >
> > Ok, so I cannot find this information anywhere (nor any example). Do
> > you happen to know if the auxiliary bus offers any software node
> > integration so that the `compatible` property from DT can get
> > seamlessly mapped to auxiliary device IDs?
> >
> 
> So I was just trying to port this to using the auxiliary bus, only to
> find myself literally reimplementing functions from
> drivers/of/device.c. I have a feeling that this is simply wrong. If
> we're instantiating devices well defined on the device-tree then IMO
> we *should* make them platform devices. Anything else and we'll be
> reimplementing drivers/of/ because we will need to parse the device
> nodes, check the compatible, match it against drivers etc. Things that
> are already implemented for the platform bus and of_* APIs.
> 
> Greg: Could you chime in and confirm that it's alright to use the
> platform bus here? Or maybe there is some infrastructure to create
> auxiliary devices from software nodes?

Note, I HATE the use of the platform bus here, but I don't have a better
suggestion.

I'd love for the auxbus to work, and if you can create that from
software nodes, all the better!  But I don't think that's possible just
yet, and you would end up implementing all the same stuff that the
platform bus has today for this functionality, so I doubt it would be
worth it.

thanks,

greg k-h

