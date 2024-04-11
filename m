Return-Path: <linux-pci+bounces-6125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98C8A15A2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EDA284BCA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA51514D3;
	Thu, 11 Apr 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js1uhFjg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505561514E0;
	Thu, 11 Apr 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842431; cv=none; b=SI5QDiJklmleld58NzJBMjTG+BhVl4G4TN8sE4jJ6KgB3oc0Y9aIDHvRukntm0k/ZqnVFep7O5/Y9HW4q2NUrkkfHB5uv3KUE6Um62fK0xtQjLq8w+hwD4rSPkhN0bqafrEyMbZPU6eg3MkQ4LA7JnmlkcFmjkpVyugkVAQQ3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842431; c=relaxed/simple;
	bh=IsdcePQGmtwf23Dn6ZnBklfJevHVN5lRzy64rGYlrRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD/usqhYzNBKHYQs2r8eNzZSd6PZvOcLrfysyMnYz+QmPtqXYpKUFW8OLyp6FfqJgJMXsfx/RN/GpHpI5/jI1Rts8oiL0b+omu/vJZBxSmmdoWvs4h00ZRfK4s3IeFP5RTpf+YkLzhI43LvEB2ROs+cKMclqTzcOtoAflRZ6EF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js1uhFjg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a49261093cso4007544eaf.3;
        Thu, 11 Apr 2024 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842429; x=1713447229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbcCaa8DX09SvsMoBHm+TyAMbhm9qLZzeE5P/R6GO7M=;
        b=Js1uhFjgMFdtEGeQzgkjk/l/2w54FrgIHPZQsZ+KzHmXFWTNuzOQyNqPGoiugd/QzX
         JlS9//xxaSFGWExtD86/a7fEsk1LZXsautey1Qsto3lt1M65XHigrRSG1Iq0z47DNj1u
         juQvx4pJ+mwF7oY3kDl7H6ymZyWfOAjKDepLxBw+X17tiUiop3mB075qjIOnGix871Wb
         Jc8bqrg3ncgjUlvrgssCiKEYkB9UWDBP3aHMcF4nk1fNxS9A//hDfAKLpTyhLjHy3vXd
         bTtAGiH2VibZhO4AVRLXJPc9FRZfD8ynZ40Z5Zy2i7mI18T24CIKB3miMbv3jNR29xhp
         c3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842429; x=1713447229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbcCaa8DX09SvsMoBHm+TyAMbhm9qLZzeE5P/R6GO7M=;
        b=fAVzGBLV/JUM6dvyWp7qWcGbKsaf1vJ5uqZPpD07UnVmCArFA+R9FzFZmg4YsvHz7D
         +AaXmnrpj+/1efEZuQKLMhHS/yrYH56CXmGUkT8ZjVFHY8aZnv3+XrbZmxNbAxEwFBWV
         0aBALQredgzOqQ65Ua8Upo4QWzN5v+0SmkG34yrrtc1AC6oSIgkcI4ukr8z/1HsIyTp7
         sfpDqQdNojBI0ncbbUVSi+EHR6VOHlKX3cvrm7wI7R5Gs9kAF2n/a6hT7k2ZEHjdB8sB
         t7bUMH6pCDhbNsQgQQY6qhgdiJ3To90v9h89b5mxqIuDbgqABAgOF5U//3sBWeckQ4U7
         ianQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2//Lc6Tk0VZY2L4/fphfeK2kj/ChS7p/lMnpZVNjOmQSBidDePq20Hoz4s682jU3kieXcvqRWZ2sJsu/pfSufrSzue76cAmo9rXq3Wf8ytTBVhSF0pwV87YmwIgVTkH2IeUKXgnzpRr91FI0vdbQDORIbdgVKpJFi7qTgl0OD2ef8ISxAB15mqlbb0ENiluml5Xy37DC6lCVtEI5RceCBzqzKF5fkgnz3ONp0y8PK8pEX/2TVK6B2szI77lMkWUADScOdA==
X-Gm-Message-State: AOJu0YyuF0luFDI92wH0kBm0u7Tx9B3O+sl0t7RGVXp4EgET3uGMbqcA
	MS6gjMvEfAa85EtYot6hq18keOa9xyHJt/JoYwfp+kK4XXrB59bGaItC1BIj5JkTLggeHqHIRBT
	sFvi8A5NP2BXNgTn2vsdhf2LBvMU=
X-Google-Smtp-Source: AGHT+IG525FFbMbsm9efSCrv2KXUqFOj0YhoVxH+Cl2iHx5VYUfIZRxfPUChUh11UqyLT5/SR86etSAM7EFlCNkHgHs=
X-Received: by 2002:a05:6870:b411:b0:22e:e6:673 with SMTP id
 x17-20020a056870b41100b0022e00e60673mr5611022oap.37.1712842429406; Thu, 11
 Apr 2024 06:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMhs-H82Ymc=isxu6AX4_s1QnNpSSNt74--ED1j7JxpzE=eCRg@mail.gmail.com>
 <20240411123917.GA2180141@bhelgaas>
In-Reply-To: <20240411123917.GA2180141@bhelgaas>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 11 Apr 2024 15:33:37 +0200
Message-ID: <CAMhs-H_imwV4__G4_pt7eWHdyLPe9_fttWJ2a3x1ESP=B6bb_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: mediatek,mt7621: add missing
 child node reg
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Tom Joseph <tjoseph@cadence.com>, Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:39=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Apr 11, 2024 at 08:13:18AM +0200, Sergio Paracuellos wrote:
> > On Thu, Apr 11, 2024 at 8:01=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 10/04/2024 23:26, Bjorn Helgaas wrote:
> > > > On Wed, Apr 10, 2024 at 08:15:19PM +0200, Krzysztof Kozlowski wrote=
:
> > > >> MT7621 PCI host bridge has children which apparently are also PCI =
host
> > > >> bridges, at least that's what the binding suggest.
> > > >
> > > > What does it even mean for a PCI host bridge to have a child that i=
s
> > > > also a PCI host bridge?
> > > >
> > > > Does this mean a driver binds to the "parent" host bridge, enumerat=
es
> > > > the PCI devices below it, and finds a "child" host bridge?
> >
> > Yes, that is exactly what you can see on enumeration.
> >
> > The following is a typical boot trace where all bridges has a device al=
so below:
> >
> > mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
> > mt7621-pci 1e140000.pcie:   No bus range found for /pcie@1e140000, usin=
g [bus 00-ff]
> > mt7621-pci 1e140000.pcie:      MEM 0x0060000000..0x006fffffff -> 0x0060=
000000
> > mt7621-pci 1e140000.pcie:       IO 0x001e160000..0x001e16ffff -> 0x0000=
000000
> > mt7621-pci 1e140000.pcie: PCIE0 enabled
> > mt7621-pci 1e140000.pcie: PCIE1 enabled
> > mt7621-pci 1e140000.pcie: PCIE2 enabled
> > mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
>
> 1e140000.pcie is a host bridge.  It has some CPU-specific bus on the
> upstream side, standard PCI (domain 0000, buses 00-ff) on the
> downstream side.
>
> > pci 0000:00:00.0: [0e8d:0801] type 01 class 0x060400
> > pci 0000:00:01.0: [0e8d:0801] type 01 class 0x060400
> > pci 0000:00:02.0: [0e8d:0801] type 01 class 0x060400
>
> > pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
>
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
>
> 00:00.0 looks like a PCIe Root Port to bus 01.  This is not a host
> bridge; it's just a standard PCI-to-PCI bridge with PCI on both the
> upstream and downstream sides.
>
> > pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
>
> > pci 0000:00:01.0: PCI bridge to [bus 02-ff]
> > pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff pref]
>
> 00:01.0 is another Root Port to bus 02.
>
> > pci 0000:03:00.0: [1b21:0611] type 00 class 0x010185
>
> > pci 0000:00:02.0: PCI bridge to [bus 03-ff]
> > pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff pref]
> > pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
>
> And 00:02.0 is a third Root Port to bus 03.
>
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> > pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
> > pci 0000:00:01.0: PCI bridge to [bus 02]
> > pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> > pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff]
> > pci 0000:00:01.0:   bridge window [mem 0x60300000-0x603fffff pref]
> > pci 0000:00:02.0: PCI bridge to [bus 03]
> > pci 0000:00:02.0:   bridge window [io  0x2000-0x2fff]
> > pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
> >
> > > I think the question should be towards Mediatek folks. I don't know w=
hat
> > > this hardware is exactly, just looks like pci-pci-bridge. The driver
> > > calls the children host bridges as "ports".
> >
> > You can see the topology here in my first driver submit cover letter
> > message [0].
> >
> >  [0]: https://lore.kernel.org/all/CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBv=
T4R4MEOUB=3DWQ1g@mail.gmail.com/t/
>
> Nothing unusual here, this looks like the standard PCIe topology.
>
> What *might* be unusual is describing the Root Ports in DT.  Since
> they are standard PCI devices, they shouldn't need DT description
> unless there's some unusual power/clock/reset control or something
> that is not discoverable via PCI enumeration.

It looks like it is necessary since every port has its own
configuration registers, phy, clock, reset and interrupt.

Thanks,
    Sergio Paracuellos

> Bjorn

