Return-Path: <linux-pci+bounces-11330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F794820A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E33D1F23428
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6187716ABC6;
	Mon,  5 Aug 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLd76+zy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BCA2AD13;
	Mon,  5 Aug 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884729; cv=none; b=gYQiL0Pj3RQOFcsA66PrR/SCufxJLVktIHLyNx/fq80bGunM5Au9FJ/Wq7RONqTgFELLEK/oVq8pjpZLT9Mmxmz+Fsrzm58aMTRz6ZXidMK4fr0RhTqyhiP1QcWdfkKOtebMzQZy6Qw825KWlHyiRkvneViF3iVK6lN3N9ZWbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884729; c=relaxed/simple;
	bh=cPCmldVPRgFeIxgMTiKS36c+Aixa8bS03HsjdsooKlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US5yQHHPuvPUIFcYOCjxMp76pt/PrFY76qXoIGJkJqL0WUeVoUYQPTb4fRZpLHq6KuJadTS3Uz1/jWj/s4XGsvmt967U8A1TOEpAIakz2DqLLbsl8S+K9NVlMKc2vU2eKAFkrBHk/uC13vc6uDonTI9Yi5Y8+bsLhCjSoAaA/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLd76+zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C95C4AF10;
	Mon,  5 Aug 2024 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722884728;
	bh=cPCmldVPRgFeIxgMTiKS36c+Aixa8bS03HsjdsooKlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TLd76+zy5670BgKGblI39Qmaa62vVzSVaTi7TCqB5Ax3sAX92bbAkhp8AQ3TDlVA5
	 +8Q9VQAYWUD7tb1RcfX7sCz1zlkXmF9oIEK07gXHtwYAwUwrF2gNuOpPEjz72WHYS/
	 Dm6zGgWYeVHyexsd8saVdodiowLf9o/X3XJs3nyLSq2WgZMPj85g32k2KMEe++QJUa
	 i4SGIOKAQiW1l+K1QbQOIatLKX1I0I+vKOAOocwzLBqTM7X3FcPSHv4GhJOXA+lJTG
	 7APO4yabS0CR97bbmAQhrDSuvCvFPNVjooUQlVx1CBbDnSga5VGSyFI740XVmFgaSh
	 dqnF2nr5Pg1JQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so121101011fa.0;
        Mon, 05 Aug 2024 12:05:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDiVQOlIjje0VAA0tnyN1J4+TB9m/MkofZcfR61ZOfnUC1ge+3TgfYItk18VbM14HmP54rA9z/KBO3d8niwdZDYqeVmtkj+F7z/9bzipInPkLQCBWPKRX4kcQ38Ep1AtqdxBB6M2bJfEXXPcrvqdiUnIupMdlwzi8HLZDQKj3O
X-Gm-Message-State: AOJu0YxclMCV9XCATkELmLkIWqKRd6gIp97MqPcSDmLcousUa1aOLDQS
	qLxhqoPXMJuucLq0p2dwYdLR9Kj8aHO0m6RBsMYfEjOTlK4OajYoV2eBIZh+ppr3Ba72sIjQtib
	5258bnUFm6+LwEe3d6ir12a3QDQ==
X-Google-Smtp-Source: AGHT+IET6gczs3GfflEbuJJZODloldeME4HEE+ZdKsBacwO7Aftaf7g/qzwvp1wwGmaiDZFabuyXcVsRNwH0G49eiLE=
X-Received: by 2002:a2e:be2c:0:b0:2f1:8622:dc6b with SMTP id
 38308e7fff4ca-2f18622eb9dmr20197831fa.1.1722884727060; Mon, 05 Aug 2024
 12:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724065048.285838-1-s-vadapalli@ti.com> <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad> <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
 <20240726115609.GF2628@thinkpad> <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
 <20240805164519.GF7274@thinkpad>
In-Reply-To: <20240805164519.GF7274@thinkpad>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Aug 2024 13:05:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>
Message-ID: <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kw@linux.com, vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, ahalaney@redhat.com, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:45=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Aug 05, 2024 at 10:01:37AM -0600, Rob Herring wrote:
> > On Fri, Jul 26, 2024 at 5:56=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Thu, Jul 25, 2024 at 01:50:16PM +0530, Siddharth Vadapalli wrote:
> > > > On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam wro=
te:
> > > > > On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam w=
rote:
> > > > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli w=
rote:
> > > > > > > Since the configuration of Legacy Interrupts (INTx) is not su=
pported, set
> > > > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes t=
he error:
> > > > > > >   of_irq_parse_pci: failed with rc=3D-22
> > > > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > > > >
> > > > > >
> > > > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq=
() will bail out
> > > > > > if 'map_irq' is set to NULL.
> > > > > >
> > > > >
> > > > > Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the =
INTx interrupts
> > > > > are described in DT? Then why are they not supported?
> > > >
> > > > No, the INTx interrupts are not described in the DT. It is the pcie=
port
> > > > driver that is attempting to setup INTx via "of_irq_parse_and_map_p=
ci()"
> > > > which is the .map_irq callback. The sequence of execution leading t=
o the
> > > > error is as follows:
> > > >
> > > > pcie_port_probe_service()
> > > >   pci_device_probe()
> > > >     pci_assign_irq()
> > > >       hbrg->map_irq
> > > >         of_pciof_irq_parse_and_map_pci()
> > > >         of_irq_parse_pci()
> > > >           of_irq_parse_raw()
> > > >             rc =3D -EINVAL
> > > >             ...
> > > >             [DEBUG] OF: of_irq_parse_raw: ipar=3D/bus@100000/interr=
upt-controller@1800000, size=3D3
> > > >             if (out_irq->args_count !=3D intsize)
> > > >               goto fail
> > > >                 return rc
> > > >
> > > > The call to of_irq_parse_raw() results in the Interrupt-Parent for =
the
> > > > PCIe node in the device-tree being found via of_irq_find_parent(). =
The
> > > > Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
> > > > msi-map =3D <0x0 &gic_its 0x0 0x10000>;
> > > > and the parent of GIC_ITS is:
> > > > gic500: interrupt-controller@1800000
> > > > which has the following:
> > > > #interrupt-cells =3D <3>;
> > > >
> > > > The "size=3D3" portion of the DEBUG print above corresponds to the
> > > > #interrupt-cells property above. Now, "out_irq->args_count" is set =
to 1
> > > > as __assumed__ by of_irq_parse_pci() and mentioned as a comment in =
that
> > > > function:
> > > >       /*
> > > >        * Ok, we don't, time to have fun. Let's start by building up=
 an
> > > >        * interrupt spec.  we assume #interrupt-cells is 1, which is=
 standard
> > > >        * for PCI. If you do different, then don't use that routine.
> > > >        */
> > > >
> > > > In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
> > > > device-tree node, the following doesn't apply:
> > > >   dn =3D pci_device_to_OF_node(pdev);
> > > > and we skip to the __assumption__ above and proceed as explained in=
 the
> > > > execution sequence above.
> > > >
> > > > If the device-tree nodes for the INTx interrupts were present, the
> > > > "ipar" sequence to find the interrupt parent would be skipped and w=
e
> > > > wouldn't end up with the -22 (-EINVAL) error code.
> > > >
> > > > I hope this clarifies the relation between the -22 error code and t=
he
> > > > missing device-tree nodes for INTx.
> > > >
> > >
> > > Thanks for explaining the logic. Still I think the logic is flawed. B=
ecause the
> > > parent (host bridge) doesn't have 'interrupt-map', which means INTx i=
s not
> > > supported. But parsing one level up to the GIC node and not returning=
 -ENOENT
> > > doesn't make sense to me.
> > >
> > > Rob, what is your opinion on this behavior?
> >
> > Not sure I get the question. How should we handle/determine no INTx? I
> > suppose that's either based on the platform (as this patch did) or by
>
> Platform !=3D driver. Here the driver is making the call, but the platfor=
m
> capability should come from DT, no? I don't like the idea of disabling IN=
Tx in
> the driver because, the driver may support multiple SoCs and these capabi=
lity
> may differ between them. So the driver will end up just hardcoding the in=
fo
> which is already present in DT :/

Let me rephrase it to "a decision made within the driver" (vs.
globally decided). That could be hardcoded (for now) or as match data
based on compatible.

> Moreover, the issue I'm seeing is, even if the platform doesn't support I=
NTx (as
> described by DT in this case), of_irq_parse_pci() doesn't report correct
> error/log. So of_irq_parse_pci() definitely needs a fixup.

Possibly. What's correct here?

There was some rework in 6.11 of the interrupt parsing. So it is
possible something changed here. There's also this issue still
pending:

https://lore.kernel.org/all/2046da39e53a8bbca5166e04dfe56bd5.squirrel@_/

> > or by
> > failing to parse the interrupts. The interrupt parsing code is pretty
> > tricky as it has to deal with some ancient DTs, so I'm a little
> > hesitant to rely on that failing. Certainly I wouldn't rely on a
> > specific errno value. The downside to doing that is also if someone
> > wants interrupts, but has an error in their DT, then all we can do is
> > print 'INTx not supported' or something. So we couldn't fail probe as
> > the common code wouldn't be able to distinguish. I suppose we could
> > just check for 'interrupt-map' present in the host bridge node or not.
>
> Yeah, as simple as that. But I don't know if that is globally applicable =
to
> all platforms.

There's a lot of history and the interrupt parsing is fragile due to
all the "interesting" DT interrupt hierarchies. So while I think it
would work, that's just a guess. I'm open to trying it and seeing.

Rob

