Return-Path: <linux-pci+bounces-1873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23B827F9F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E361F21E2B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898EB67F;
	Tue,  9 Jan 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rzR+v8jR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA09476
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28cb3bc3fe7so1800331a91.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 23:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704786179; x=1705390979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hbh9aOHx7+CSCvz+p9Wnk1Alp9/EgNmTd2TSmQXJErs=;
        b=rzR+v8jRYlcV6Du2wjV9SWn/leGlSxC2xqyL2rlmiqdSltIK5DjRyYmjpE/pmpJK+O
         sydKGwyjCh4x6VFYcjoKMhTXDZlJj9k1+ttsomsQxlGv2k8mI5j1nqlxeGIGORjfPq7d
         JLhDFFHFU1d957w5czZAy/H68MUIK7COMZsSXXn2w2MlrFxq1ERIoWZUfrw3QWfiPdPp
         U6QWmOWa6jDNlPT0zVTjRFzS2vZWeh/GfW125WTC4ltk7LQ5/Y6R2Xm5zsxLEgGGNpAP
         d3jQLu4SHPkh+dju8hNV7IiQDsXDzOFzKxRRWlk1pjj73nn/0SiobOs+x7MwDNEyxTaa
         +A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704786179; x=1705390979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbh9aOHx7+CSCvz+p9Wnk1Alp9/EgNmTd2TSmQXJErs=;
        b=dRRLLPTt10hWXZTPov9soe7GLgdrakRU29aqAvvx0bq1YnojIX72EJQfzS9Kvth6Ui
         rCQozr1ggyx3wFit7IU/IinY8utsSLZgJ8L0lvCFoJh4jMVlXQ7t8LvnGFZ6b6Bmqeem
         Lz+OwuQA699kQQirZ+cu92ZtPncmXtoYP951vkHzDSqY4cUE9JtXcISUpcAhWj4ewqYo
         18iXeGh8yQWVYWOQdrtmUSp+GY88FNX6WoBiyFu/GtdyhNz/sPOFyQk/pSuudwWyh20X
         t3LbbzfnrATyhvDfpx6yU0y1ehgnqYoso6eIUIbyWGi2SLS+zMEsqYXZJwpBFpyKg33W
         2Qsg==
X-Gm-Message-State: AOJu0YwUaeo/NQN2ybUq97YObTS/mdTuYhgTPFSXq8t7WXN6gggD1niM
	V58MLd7dggjWy6LNdeqMtbyEXshogWHa
X-Google-Smtp-Source: AGHT+IFcxvhYW0JAZdJq+N+9m95XOtUpUXsjOgoxUB/mRwSbbeb71nZBw7f0ddc9ml/vx8VlhUFUbA==
X-Received: by 2002:a17:90b:f0f:b0:28d:9b5b:e70b with SMTP id br15-20020a17090b0f0f00b0028d9b5be70bmr429191pjb.0.1704786178748;
        Mon, 08 Jan 2024 23:42:58 -0800 (PST)
Received: from thinkpad ([117.213.102.45])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709029f8700b001d425d495c9sm1083349plq.190.2024.01.08.23.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:42:57 -0800 (PST)
Date: Tue, 9 Jan 2024 13:11:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
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
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jim Quinlan <jim2101024@gmail.com>, james.quinlan@broadcom.com,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe
 devices
Message-ID: <20240109074124.GA3303@thinkpad>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com>
 <CAGXv+5EtvMgbr9oZ7cfnDCDN15BKqgpuiacHHf8_T5kLqYJpJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EtvMgbr9oZ7cfnDCDN15BKqgpuiacHHf8_T5kLqYJpJw@mail.gmail.com>

On Tue, Jan 09, 2024 at 03:08:32PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 9, 2024 at 12:09 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > Hello,
> >
> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > During last year's Linux Plumbers we had several discussions centered
> > > around the need to power-on PCI devices before they can be detected on
> > > the bus.
> > >
> > > The consensus during the conference was that we need to introduce a
> > > class of "PCI slot drivers" that would handle the power-sequencing.
> > >
> > > After some additional brain-storming with Manivannan and the realization
> > > that the DT maintainers won't like adding any "fake" nodes not
> > > representing actual devices, we decided to reuse the existing
> > > infrastructure provided by the PCIe port drivers.
> > >
> > > The general idea is to instantiate platform devices for child nodes of
> > > the PCIe port DT node. For those nodes for which a power-sequencing
> > > driver exists, we bind it and let it probe. The driver then triggers a
> > > rescan of the PCI bus with the aim of detecting the now powered-on
> > > device. The device will consume the same DT node as the platform,
> > > power-sequencing device. We use device links to make the latter become
> > > the parent of the former.
> > >
> > > The main advantage of this approach is not modifying the existing DT in
> > > any way and especially not adding any "fake" platform devices.
> >
> > There is prior work in that area which was applied, but eventually reverted:
> >
> > https://www.spinics.net/lists/linux-pci/msg119136.html
> >
> > and finally re-applied albeit in a different shape:
> >
> > https://lore.kernel.org/all/20220716222454.29914-1-jim2101024@gmail.com/
> >
> > so we might want to think about how to have pcie-brcmstb.c converted
> > over your proposed approach. AFAIR there is also pcie-rockchip.c which
> > has some rudimentary support for voltage regulators of PCIe end-points.
> 
> I think the current in-tree approaches mostly target either PCIe slots,
> whether full size or mini-PCIe or M.2, or soldered-on components that
> either only have a single power rail, have internal regulators, or have
> surrounding circuitry that would be incorporated on a PCIe card.
> 
> These all have standardized power rails (+12V, +3.3V, +3.3V aux, etc.).
> 

Right. But ideally, they should also be converted to use this power sequencing
driver at some point in the future.

> > What does not yet appear in this RFC is support for suspend/resume,
> > especially for power states where both the RC and the EP might be losing
> > power. There also needs to be some thoughts given to wake-up enabled
> > PCIe devices like Wi-Fi which might need to remain powered on to service
> > Wake-on-WLAN frames if nothing else.
> >

I don't think it is necessary to add PM support in this series itself. Even
though PM support is always nice to have or even necessary for controllers
pulling the power plug during suspend, it makes sense to merge this basic
implementation and add features on top.

It should be noted that both the controller drivers and the power sequencing
drivers should be in sync during suspend i.e., if the controller driver decides
to put the device into D3Cold and turning off the controller power supplies,
then this driver should also power off the device. But if the controller driver
decides to keep the device in low power states (ASPM), then this driver
_should_not_ turn off the device power.

Right now, there is no global policy for controller drivers and each one does a
different job. IMO this should also be fixed, but that also requires an
agreement from PM folks.

(Well there is one more entity in this loop, PCIe device drivers... sigh)

> > I sense a potential for a lot of custom power sequencing drivers being
> > added and ultimately leading to the decision to create a "generic" one
> > which is entirely driven by Device Tree properties...
> 
> We can have one "generic" slot power sequencing driver, which just
> enables all the power rails together. I would very much like to see that.
> 

Yeah. And that "generic" driver could be used for simple usecases mentioned
above.

> I believe the power sequencing in this series is currently targeting more
> tightly coupled designs that use power rails directly from the PMIC, and
> thus require more explicit power sequencing.
> 

Precisely!

- Mani

> ChenYu
> 
> 
> > Thanks for doing this!
> > --
> > Florian
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
மணிவண்ணன் சதாசிவம்

