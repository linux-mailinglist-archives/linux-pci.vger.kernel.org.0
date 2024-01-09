Return-Path: <linux-pci+bounces-1917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB8682832C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099B51C24B0E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC61328DF;
	Tue,  9 Jan 2024 09:29:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E02E840;
	Tue,  9 Jan 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so1740857a91.0;
        Tue, 09 Jan 2024 01:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792579; x=1705397379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiE9JhZtKhaS/KxqbPfpfOX4N5rDOmwf01u4q8UXOQE=;
        b=b+BXsGnikaQqti8A4F83LKul2u+/a6u3mWzTMLb1mBdypqpb3ihHEEJ48JDgeccl97
         5OfyEDBqHIVx2fsMbHXRVCq2fi/1HBbXe/MU1hECOqHOgv2guI9cXKYWhuLK0laX5bQp
         EhRF3F6LAEC99+hXLwrKbBXiKMjAZrwp8TVfj87P8RCgfkwcgS9lr7qqlvrShr/Psfk2
         CEYXQMChMnt9N3vaDr71xEGGTDZ6roZmlK9ke7WO7OS7yevv/7v/woPAR0mq2E5BfjP+
         DujHF1RSvmFSPz76lmyKQKJwTJXNmPd9XwOZrAxckcH9810859pdZpHK6cDjW8tQ3met
         aK4w==
X-Gm-Message-State: AOJu0YyaswCch2rZ6TYYrZCjoFIxfXMc9JWtXkN/HGMBhXquC5BTJhq7
	xR2FA2oLn+BF1AEnfeSAtSPjKAtyqfSbQTEK
X-Google-Smtp-Source: AGHT+IHBcFvFoOETrm48MVZ6LivrWHHGUpA0ptze/XO7HFdUGNL4cBOcKvHeyhUgPPGVac96WU9Gbw==
X-Received: by 2002:a17:90a:8001:b0:28b:fdf0:6aa7 with SMTP id b1-20020a17090a800100b0028bfdf06aa7mr1971970pjn.51.1704792578583;
        Tue, 09 Jan 2024 01:29:38 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id d88-20020a17090a6f6100b0028d42741efasm1582006pjk.43.2024.01.09.01.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 01:29:38 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d542701796so10046925ad.1;
        Tue, 09 Jan 2024 01:29:38 -0800 (PST)
X-Received: by 2002:a25:9389:0:b0:d9a:cd62:410c with SMTP id
 a9-20020a259389000000b00d9acd62410cmr2548564ybm.4.1704792556992; Tue, 09 Jan
 2024 01:29:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <a85dbfc3-e327-442a-9aab-5115f86944f7@gmail.com>
 <CAGXv+5EtvMgbr9oZ7cfnDCDN15BKqgpuiacHHf8_T5kLqYJpJw@mail.gmail.com>
In-Reply-To: <CAGXv+5EtvMgbr9oZ7cfnDCDN15BKqgpuiacHHf8_T5kLqYJpJw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jan 2024 10:29:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7YJZTPFL+ECLh3f9jAuaxqnuooggjHp-QLLxsrMu1Mw@mail.gmail.com>
Message-ID: <CAMuHMdV7YJZTPFL+ECLh3f9jAuaxqnuooggjHp-QLLxsrMu1Mw@mail.gmail.com>
Subject: Re: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe devices
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jim Quinlan <jim2101024@gmail.com>, 
	james.quinlan@broadcom.com, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ChenYu,

CC wsa + renesas-soc

On Tue, Jan 9, 2024 at 8:08=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
> On Tue, Jan 9, 2024 at 12:09=E2=80=AFPM Florian Fainelli <f.fainelli@gmai=
l.com> wrote:
> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > During last year's Linux Plumbers we had several discussions centered
> > > around the need to power-on PCI devices before they can be detected o=
n
> > > the bus.
> > >
> > > The consensus during the conference was that we need to introduce a
> > > class of "PCI slot drivers" that would handle the power-sequencing.
> > >
> > > After some additional brain-storming with Manivannan and the realizat=
ion
> > > that the DT maintainers won't like adding any "fake" nodes not
> > > representing actual devices, we decided to reuse the existing
> > > infrastructure provided by the PCIe port drivers.
> > >
> > > The general idea is to instantiate platform devices for child nodes o=
f
> > > the PCIe port DT node. For those nodes for which a power-sequencing
> > > driver exists, we bind it and let it probe. The driver then triggers =
a
> > > rescan of the PCI bus with the aim of detecting the now powered-on
> > > device. The device will consume the same DT node as the platform,
> > > power-sequencing device. We use device links to make the latter becom=
e
> > > the parent of the former.
> > >
> > > The main advantage of this approach is not modifying the existing DT =
in
> > > any way and especially not adding any "fake" platform devices.
> >
> > There is prior work in that area which was applied, but eventually reve=
rted:
> >
> > https://www.spinics.net/lists/linux-pci/msg119136.html
> >
> > and finally re-applied albeit in a different shape:
> >
> > https://lore.kernel.org/all/20220716222454.29914-1-jim2101024@gmail.com=
/
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

Indeed. E.g. R-Car PCIe just got support for that in commit
6797e4da2dd1e2c8 ("PCI: rcar-host: Add support for optional regulators")
in pci/next.

> > What does not yet appear in this RFC is support for suspend/resume,
> > especially for power states where both the RC and the EP might be losin=
g
> > power. There also needs to be some thoughts given to wake-up enabled
> > PCIe devices like Wi-Fi which might need to remain powered on to servic=
e
> > Wake-on-WLAN frames if nothing else.
> >
> > I sense a potential for a lot of custom power sequencing drivers being
> > added and ultimately leading to the decision to create a "generic" one
> > which is entirely driven by Device Tree properties...
>
> We can have one "generic" slot power sequencing driver, which just
> enables all the power rails together. I would very much like to see that.
>
> I believe the power sequencing in this series is currently targeting more
> tightly coupled designs that use power rails directly from the PMIC, and
> thus require more explicit power sequencing.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

