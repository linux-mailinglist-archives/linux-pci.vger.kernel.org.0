Return-Path: <linux-pci+bounces-11318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B203947EE7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B11F22293
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCD13C827;
	Mon,  5 Aug 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi/lQ76t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB64D8B7;
	Mon,  5 Aug 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873712; cv=none; b=G+q9u67vrtpY19C/5FSKCdut9Vy33FFSAIVnw/FfYo3Sihr6K9AHqyZ8kpLQ7vLYhxCe9jyD5M8tWk78bEDymkUGFkRcrgjAg/r8a8dU5ljmeg+eWzdb8i0xmnomqoOgqT9igXArxGVe+O3DQJXXbaZlr3RgyHBxiSIvj6M0JWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873712; c=relaxed/simple;
	bh=wQlaWS+ZJw+znmW/REtXUrDGbAzMh8uUsewhxjdkwIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6OxXHjR0XNne1UTxwKBlO6epmBicC4Z9txChZ7xVi39SzuPuMAqLadAUgxwIn0G8unCLIV/0unlqR8emSsxzd+nGwmSyxryvdZe1DODIV4EKrf0l73uUXQ8wWDK8k6EwchKb0WZ7uemXUX2yRQLKHKwtA0dgQvEB2n7uQlBsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi/lQ76t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A712BC32782;
	Mon,  5 Aug 2024 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722873711;
	bh=wQlaWS+ZJw+znmW/REtXUrDGbAzMh8uUsewhxjdkwIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xi/lQ76trQtHCxk7rjn10khILW1A3BwjI4ze73DdvzYH00ssbgkJhFzSAO1KIdV+T
	 l9o8sekqfaIs9E2WsdOuy/x7mDaZgCBNkyO0l+94u5vqkZYroJlBoNSPiC20Isc2hi
	 lNb/KBXkNqaYcpgCH4CLKKCQiasCHb3nPTivxozIsNRpH7YuWSzn0jJoqndtq/Msd0
	 60pJ4Lot/TZaqNjTCi0ObJB6mjX7F62lsEW0o44BXqXRWQLQWOroYOpRBXIgpx1iF0
	 yxbMFewg1bUPcAX1boJ3fYSgNqCKmwysDPGUQRcCeqiDhX3Sd1vgRLZLcZ48zLL3Lj
	 ICKBdzUEgVXKQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f16767830dso30468011fa.0;
        Mon, 05 Aug 2024 09:01:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDoHLQmQgpxOVTVOuoj6shc/HKZyZ9ID82qMdQ3nHkxz6cz6pN3gSbG2jSOdEYQAzG1uQHDDfkzWTfiOComkjCE18Ncsbldo9qY0cJoaFECpADXfTjm5tbdrSPQjGRDMRyvV4MQ44vVkYR2GoWA/ts4wJYIBGnADaargFHbQy+
X-Gm-Message-State: AOJu0YyWBChKDj2qGPNQVawGAjrSH1YUeyCVB3n7ZmkjvsT1j/Tzvz+w
	tlto4orRhZO0E0WA5m+HVrietxVi3xC7daU/v/1pKHx1lKQ0nvGzSNndYnc1QyHCX5HPQGV1Fgh
	mpgRMCbIxdTXgIwyKXpglp1H2Aw==
X-Google-Smtp-Source: AGHT+IF1QA0WkvZdYK3NgKnb5MSPFABqtD9PrMB9+H/W4psXiYBBzJeuRnqchv3x9eFCYkaDnOsHnRQmvcJbJ6tn/NI=
X-Received: by 2002:a2e:8096:0:b0:2ef:3250:d0d4 with SMTP id
 38308e7fff4ca-2f15ab5c7c8mr77836851fa.48.1722873710032; Mon, 05 Aug 2024
 09:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724065048.285838-1-s-vadapalli@ti.com> <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad> <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
 <20240726115609.GF2628@thinkpad>
In-Reply-To: <20240726115609.GF2628@thinkpad>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Aug 2024 10:01:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
Message-ID: <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kw@linux.com, vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, ahalaney@redhat.com, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:56=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Jul 25, 2024 at 01:50:16PM +0530, Siddharth Vadapalli wrote:
> > On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote=
:
> > > > > Since the configuration of Legacy Interrupts (INTx) is not suppor=
ted, set
> > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the e=
rror:
> > > > >   of_irq_parse_pci: failed with rc=3D-22
> > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > >
> > > >
> > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() w=
ill bail out
> > > > if 'map_irq' is set to NULL.
> > > >
> > >
> > > Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx=
 interrupts
> > > are described in DT? Then why are they not supported?
> >
> > No, the INTx interrupts are not described in the DT. It is the pcieport
> > driver that is attempting to setup INTx via "of_irq_parse_and_map_pci()=
"
> > which is the .map_irq callback. The sequence of execution leading to th=
e
> > error is as follows:
> >
> > pcie_port_probe_service()
> >   pci_device_probe()
> >     pci_assign_irq()
> >       hbrg->map_irq
> >         of_pciof_irq_parse_and_map_pci()
> >         of_irq_parse_pci()
> >           of_irq_parse_raw()
> >             rc =3D -EINVAL
> >             ...
> >             [DEBUG] OF: of_irq_parse_raw: ipar=3D/bus@100000/interrupt-=
controller@1800000, size=3D3
> >             if (out_irq->args_count !=3D intsize)
> >               goto fail
> >                 return rc
> >
> > The call to of_irq_parse_raw() results in the Interrupt-Parent for the
> > PCIe node in the device-tree being found via of_irq_find_parent(). The
> > Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
> > msi-map =3D <0x0 &gic_its 0x0 0x10000>;
> > and the parent of GIC_ITS is:
> > gic500: interrupt-controller@1800000
> > which has the following:
> > #interrupt-cells =3D <3>;
> >
> > The "size=3D3" portion of the DEBUG print above corresponds to the
> > #interrupt-cells property above. Now, "out_irq->args_count" is set to 1
> > as __assumed__ by of_irq_parse_pci() and mentioned as a comment in that
> > function:
> >       /*
> >        * Ok, we don't, time to have fun. Let's start by building up an
> >        * interrupt spec.  we assume #interrupt-cells is 1, which is sta=
ndard
> >        * for PCI. If you do different, then don't use that routine.
> >        */
> >
> > In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
> > device-tree node, the following doesn't apply:
> >   dn =3D pci_device_to_OF_node(pdev);
> > and we skip to the __assumption__ above and proceed as explained in the
> > execution sequence above.
> >
> > If the device-tree nodes for the INTx interrupts were present, the
> > "ipar" sequence to find the interrupt parent would be skipped and we
> > wouldn't end up with the -22 (-EINVAL) error code.
> >
> > I hope this clarifies the relation between the -22 error code and the
> > missing device-tree nodes for INTx.
> >
>
> Thanks for explaining the logic. Still I think the logic is flawed. Becau=
se the
> parent (host bridge) doesn't have 'interrupt-map', which means INTx is no=
t
> supported. But parsing one level up to the GIC node and not returning -EN=
OENT
> doesn't make sense to me.
>
> Rob, what is your opinion on this behavior?

Not sure I get the question. How should we handle/determine no INTx? I
suppose that's either based on the platform (as this patch did) or by
failing to parse the interrupts. The interrupt parsing code is pretty
tricky as it has to deal with some ancient DTs, so I'm a little
hesitant to rely on that failing. Certainly I wouldn't rely on a
specific errno value. The downside to doing that is also if someone
wants interrupts, but has an error in their DT, then all we can do is
print 'INTx not supported' or something. So we couldn't fail probe as
the common code wouldn't be able to distinguish. I suppose we could
just check for 'interrupt-map' present in the host bridge node or not.
Need to check the Marvell binding which is a bit weird with child
nodes.

Rob

