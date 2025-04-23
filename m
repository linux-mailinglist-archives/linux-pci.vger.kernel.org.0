Return-Path: <linux-pci+bounces-26516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF918A985C9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC183BF335
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D840242D6F;
	Wed, 23 Apr 2025 09:38:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6981E0DE3;
	Wed, 23 Apr 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401138; cv=none; b=EnCMF8s3nOkIkcax7UOSn8ESBOC95pZaf3lv0jATAwFLR7UMAVYqnCSjIfx2cVnXcLZAkwPS9/qvJ+JzN+NblGxK8hpk/8nvjB/bBlM7u4eDlgJVBeu56TneGRnMtEQNopwDToov+PChXNL0lYTjpbDtIro7+j1n6bKacMcV8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401138; c=relaxed/simple;
	bh=tCMZfNnj8/b35DIr6nTU2gj4eYGVOGguexOayzdVvPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4x+HH5nIE3cw8YDNrk2xDnKIf34ysGNMfocMKumlwYB9Zn0gyGsbLUKMWs0utsVmiWU+6T8F3SBrzMWFeDMKRdDZqQU42GyaExr2NU7RV3dpngBy1wOarnmL4LzqTDxl8ZY3fMap2KS4KKgHvPzmWneERkV/qktB/Rb9iVOsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-524038ba657so906734e0c.0;
        Wed, 23 Apr 2025 02:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401134; x=1746005934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l1/Z/GDToMdcTKnifTgVrARzg4LIJ5t8Cqie4h54Ws=;
        b=AL46a82AIffkQxxJBs08Iz5t5b+ctGJtsFXNQb/Em/3jjyzWWlkAcHEa1RJIEgrTzf
         2R87Y0eIb1c/RwEWjgIi9BbyXpT2fRbH+ugdTNR/+XY9gxiwJcDytA2VMH8FacL8jag7
         ksTMDw1M7G18eR9jkq5+jglgXRA99ISlAAXkyIvn12iuyffiimDsG5vF4Hqeh3TkQqEH
         w2iieFEyCvEbh8qaRq9IPNChkCRqbtWIcvM5aGV/V1i/tY/VKzysnvtjE10w7z9xNP9X
         rkwylUv53apLguV3jICd7JiaC4cQ4iL8brnfpic9idpLCMjV9q/trXPtBGwixfKQ/Qmz
         k0sg==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZaI1aUb8X67eARwqD9zV9REztnB+64rzCXk2HDNsIqGLRTZY9Tm4QzFmNQvLioYwtXBffrHbC20G@vger.kernel.org, AJvYcCUcYiFvtTGTNdUU364ttjtHtKEsykd93UqFQ993bLm4wvQxafyTbuAsZaMx5PEstArZphNKpHQPFqfm@vger.kernel.org, AJvYcCVWkGsr18u6dYmzUXrsbsd7Jq5/+/YuqhtHK36IXK/uM7E+uWtdjZgAQk0koDPh6qA3uhws52ZurtNxLv84M+5/Pyw=@vger.kernel.org, AJvYcCVZujcr4AbYRE1Lsnv+EU3FNv1FkDIEwxVChj5F9iVqwa7GudDm1mq26nx0G9nXf6y+MSVcHG/R6BHXeIds@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEBepm/EIc/98vazjRNqs4aXJZ/oCfRnO2TMJAl4HsAATl1jF
	PPkmvQHZQrdJzL2HfBl4syA8RybqndjtsA/PAqj0fsw/fMNOsEy9VR1isRpN8u0=
X-Gm-Gg: ASbGncvbXDXXZYzC1SbJnQ+wtpd8icCzPZ8BW/gGAplK8UWpNrpMVolQZr8/uK/YVlt
	arukAfIME49pap+//4baT4x3ao0kETN6K7CpK0pmswVScmWaZFpryVjcSbs3T3ca80Q+J+iWVvu
	i59b0xthPyM0G3KzSLILoNYJ6x9E3S9z6vjC3R0iVcDDfle4zBsaK2vrzGC7PKl+8Rx6vMlGTbA
	ZHUqN0cYTw2oqovAr7xVEyQGlB9efCCxbxLMtI95K/ZktgnyWhlv6npx+LqtRrUIx2TWOk9XOgQ
	lk/iiJKNt478O+d5JA5MiDohq9CLis9sJekaApLaU7OgW7Cji+cFOik3jSbOQePVCzqo9WY+1FD
	Lva82rew=
X-Google-Smtp-Source: AGHT+IHI1TO/KMy5hKP1AZ+fI1da26z+jbXV6rIAkT5M+Z6xjpDJ1xfuDjb8Zvlpo9PkASGGqTgUzw==
X-Received: by 2002:a05:6122:2205:b0:51f:a02b:45d4 with SMTP id 71dfb90a1353d-52a6a0343abmr1224356e0c.1.1745401134385;
        Wed, 23 Apr 2025 02:38:54 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922dc587dsm2271396e0c.48.2025.04.23.02.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 02:38:54 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5240a432462so791171e0c.1;
        Wed, 23 Apr 2025 02:38:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2xUvrRnNfuG2YkFhU0KoMsCboPevG94+nRwIe50dwLku/DC9h16HmDpNlYRwo6KfgqyyWlbm56mWB++Hc@vger.kernel.org, AJvYcCXNwqjNkyRZMzHeJlzfDrpy2JLrL8kQgSJpLPXT+k1KnolYyBfPd71KkOJM950c/4+lEDPVmVOM9fuO@vger.kernel.org, AJvYcCXSo16ZKAQKzRiWAUL2QxiH239eeTqUXbZqNOMBisWzGDf0GdKzQ5vEZjKgyTwJtymoGl2yXTnLq/+xd0QN9jWQn4Q=@vger.kernel.org, AJvYcCXm7YevtdbycO+NfhXqUrCcMtvNXlPn7B0UsNfKJY1D99aVTNdMEhRqPQvBMVbWhWbTCeNx4pXCUcn5@vger.kernel.org
X-Received: by 2002:a05:6122:2029:b0:50d:39aa:7881 with SMTP id
 71dfb90a1353d-52a69ee4ed3mr1464819e0c.0.1745401133893; Wed, 23 Apr 2025
 02:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
 <20250406144822.21784-2-marek.vasut+renesas@mailbox.org> <20250410204845.GA1027003-robh@kernel.org>
 <40c400ab-8770-4595-9a4c-004e6157c348@mailbox.org>
In-Reply-To: <40c400ab-8770-4595-9a4c-004e6157c348@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 11:38:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0U8RjJwgMs1gqaKUXj+aP=gMZRgO6Ni5gPHr3yFa_Hg@mail.gmail.com>
X-Gm-Features: ATxdqUEdpJzlYJJPC9uQQHl7BMlq_ah4RVyU1yK01V61iQt1LxPiUJbnjP-RWIo
Message-ID: <CAMuHMdU0U8RjJwgMs1gqaKUXj+aP=gMZRgO6Ni5gPHr3yFa_Hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rob Herring <robh@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Sun, 13 Apr 2025 at 11:29, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 4/10/25 10:48 PM, Rob Herring wrote:
> > On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
> >> Document 'aux' clock which are used to supply the PCIe bus. This
> >> is useful in case of a hardware setup, where the PCIe controller
> >> input clock and the PCIe bus clock are supplied from the same
> >> clock synthesiser, but from different differential clock outputs:
> >>
> >>   ____________                    _____________
> >> | R-Car PCIe |                  | PCIe device |
> >> |            |                  |             |
> >> |    PCIe RX<|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|>=
PCIe TX     |
> >> |    PCIe TX<|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|>=
PCIe RX     |
> >> |            |                  |             |
> >> |   PCIe CLK<|=3D=3D=3D=3D=3D=3D..  ..=3D=3D=3D=3D=3D=3D|>PCIe CLK    =
|
> >> '------------'      ||  ||      '-------------'
> >>                      ||  ||
> >>   ____________       ||  ||
> >> |  9FGV0441  |      ||  ||
> >> |            |      ||  ||
> >> |   CLK DIF0<|=3D=3D=3D=3D=3D=3D''  ||
> >> |   CLK DIF1<|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D''
> >> |   CLK DIF2<|
> >> |   CLK DIF3<|
> >> '------------'
> >>
> >> The clock are named 'aux' because those are one of the clock listed in
> >> Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml which
> >> fit closest to the PCIe bus clock. According to that binding document,
> >> the 'aux' clock describe clock which supply the PMC domain, which is
> >> likely PCIe Mezzanine Card domain.
> >
> > Pretty sure that PMC is "power management controller" given it talks
> > about low power states.
> >
> >
> >>
> >> Tested-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.s=
e>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> NOTE: Shall we patch Documentation/devicetree/bindings/pci/snps,dw-pci=
e-common.yaml
> >>        instead and add 'bus' clock outright ?
> >
> > Based on the diagram, this has nothing to do with the specific
> > controller. It should also probably a root port property, not host
> > bridge.
> How would you suggest I describe the clock which supply the PCIe bus
> clock lane (CLK DIF1 in the diagram) , which have to be enabled together
> with clock which supply the PCIe controller input clock lane (CLK DIF0) ?

I think Rob wants you to add clocks/clock-names for this to
dtschema/schemas/pci/pci-bus-common.yaml.  Then you can have pcie@M,N
subnode(s) with num-lanes, clock, and clock-names describing the PCIe
endpoint(s)?

git grep "pcie*@[0-9],[0-9]" -- $(git grep -l num-lanes -- Documentation/ )

Does that make sense?
Thanks!

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

