Return-Path: <linux-pci+bounces-11339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706649483AB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3782835B7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F216A395;
	Mon,  5 Aug 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCcbTKbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C514B078;
	Mon,  5 Aug 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890426; cv=none; b=jqUeDyaf2WZmAasxjbWav8JCwIW1Pd6/rlwBQm2M+/EL/ghyqMNw7RikepzFUZimrEJuDIATYaaJIcvTSqfk7aqCh1O6VKfkEYFxSE5zdLPb/upQrF6mqrYpKodZ0QyWwJdgP+tnhm+cUUC2PzHa38b1/rjeDMMLERKtdAzCrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890426; c=relaxed/simple;
	bh=wQ0L2tS6YGgDOWfYqVZFdr4iOYqhv3xXdjMPco4Spi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foWWsaWXvNGegWSiZUv5U0vTrVlzu97xu57rYmJSe1tymZ2eVi/6iQKZctSKaVz5UwO3hLrBTqdsLK9PbKXG+nrj0bqvw50kdrpYYCnD8gIyMcosGBb3g6fZOt1ArW+vw1i+v1xQ6m8oBsQ3ExBSTybnH7RN63OkMWOaoY2Hz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCcbTKbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D32C4AF10;
	Mon,  5 Aug 2024 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722890424;
	bh=wQ0L2tS6YGgDOWfYqVZFdr4iOYqhv3xXdjMPco4Spi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hCcbTKbUvhHOYqgAeTA7HwgE63Y3BQRtxFlc05/akLa5WAgs4/qpX249hr7mxHuqr
	 a5QOqq2cGuTHzJl7h3jodZ2C2mWRU9NhdKtLPPXsxyAS2Zj0iKyCz4hBzQZy8BrtXa
	 viSmlIt02jj+6dqHYaRXQxR7BjfIUT92G7ciABFoqoVYKJSx2Rw6IDpxU1wA1pBBSr
	 fqnNBqpslULCDshl3aM3nh26SHgrr783031rXoaYadIh3auZVAiwPTJfsKSi8oCc3U
	 YgMe+xa0MKVvDNRj1UE9utbdvS6SeyAcmgMPbO54P6GmtELbNFtEa8CAZmlP2y/100
	 3pxnshygYHS4A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52fcc56c882so3518052e87.0;
        Mon, 05 Aug 2024 13:40:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjVpxo28c2GA30X3UHGZBXP5Sk8Pr2y0vx5+cAOxhxxDe7TLnu9HZ+YgKqKTFK4npY66f+nshhyTDoETV3pcRUwQwVMtvu/CyJMQuhnnX8GcWUqZB1RBBHfB6ontxaHJ5MPLKMF2vl1Dmz+BY8wKGcpT3vNHaWLOgF9yTt2sgU
X-Gm-Message-State: AOJu0YyjsyBhfkDDXQC+QC0nLMP1DRFeLHQHxi8G3QoUNM04MeTQmytH
	S7dGNkQP70N5+rPRaqwzMgrCdXG2So6avkz9BXrjcqlKqBO5oM2UiqnA/gJIq7s5y0MFjPv71HN
	DK5Tt75oN5GxVSw77UiOA/RDLBA==
X-Google-Smtp-Source: AGHT+IFI5VpP5OKPPKRgAk+Oxl/O+dVv3hqIzOEENlMUX+iOnSMeGboni4k2kYsgkY9QB+g75fYFDIZgDQyyjRzx2WM=
X-Received: by 2002:a05:6512:3c89:b0:52c:72b4:1b24 with SMTP id
 2adb3069b0e04-530bb2b29b0mr3164356e87.12.1722890422333; Mon, 05 Aug 2024
 13:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724065048.285838-1-s-vadapalli@ti.com> <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad> <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
 <20240726115609.GF2628@thinkpad> <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
 <20240805164519.GF7274@thinkpad> <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>
In-Reply-To: <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Aug 2024 14:40:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLq6cwjKY8jiRmB6TYiKBEs8F3PDedwAyRW3dqTArJhUg@mail.gmail.com>
Message-ID: <CAL_JsqLq6cwjKY8jiRmB6TYiKBEs8F3PDedwAyRW3dqTArJhUg@mail.gmail.com>
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kw@linux.com, vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, ahalaney@redhat.com, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 1:05=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 5, 2024 at 10:45=E2=80=AFAM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Aug 05, 2024 at 10:01:37AM -0600, Rob Herring wrote:
> > > On Fri, Jul 26, 2024 at 5:56=E2=80=AFAM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Thu, Jul 25, 2024 at 01:50:16PM +0530, Siddharth Vadapalli wrote=
:
> > > > > On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam w=
rote:
> > > > > > On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam=
 wrote:
> > > > > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli=
 wrote:
> > > > > > > > Since the configuration of Legacy Interrupts (INTx) is not =
supported, set
> > > > > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes=
 the error:
> > > > > > > >   of_irq_parse_pci: failed with rc=3D-22
> > > > > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > > > > >
> > > > > > >
> > > > > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_i=
rq() will bail out
> > > > > > > if 'map_irq' is set to NULL.
> > > > > > >
> > > > > >
> > > > > > Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So th=
e INTx interrupts
> > > > > > are described in DT? Then why are they not supported?
> > > > >
> > > > > No, the INTx interrupts are not described in the DT. It is the pc=
ieport
> > > > > driver that is attempting to setup INTx via "of_irq_parse_and_map=
_pci()"
> > > > > which is the .map_irq callback. The sequence of execution leading=
 to the
> > > > > error is as follows:
> > > > >
> > > > > pcie_port_probe_service()
> > > > >   pci_device_probe()
> > > > >     pci_assign_irq()
> > > > >       hbrg->map_irq
> > > > >         of_pciof_irq_parse_and_map_pci()
> > > > >         of_irq_parse_pci()
> > > > >           of_irq_parse_raw()
> > > > >             rc =3D -EINVAL
> > > > >             ...
> > > > >             [DEBUG] OF: of_irq_parse_raw: ipar=3D/bus@100000/inte=
rrupt-controller@1800000, size=3D3
> > > > >             if (out_irq->args_count !=3D intsize)
> > > > >               goto fail
> > > > >                 return rc
> > > > >
> > > > > The call to of_irq_parse_raw() results in the Interrupt-Parent fo=
r the
> > > > > PCIe node in the device-tree being found via of_irq_find_parent()=
. The
> > > > > Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
> > > > > msi-map =3D <0x0 &gic_its 0x0 0x10000>;
> > > > > and the parent of GIC_ITS is:
> > > > > gic500: interrupt-controller@1800000
> > > > > which has the following:
> > > > > #interrupt-cells =3D <3>;
> > > > >
> > > > > The "size=3D3" portion of the DEBUG print above corresponds to th=
e
> > > > > #interrupt-cells property above. Now, "out_irq->args_count" is se=
t to 1
> > > > > as __assumed__ by of_irq_parse_pci() and mentioned as a comment i=
n that
> > > > > function:
> > > > >       /*
> > > > >        * Ok, we don't, time to have fun. Let's start by building =
up an
> > > > >        * interrupt spec.  we assume #interrupt-cells is 1, which =
is standard
> > > > >        * for PCI. If you do different, then don't use that routin=
e.
> > > > >        */
> > > > >
> > > > > In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
> > > > > device-tree node, the following doesn't apply:
> > > > >   dn =3D pci_device_to_OF_node(pdev);
> > > > > and we skip to the __assumption__ above and proceed as explained =
in the
> > > > > execution sequence above.
> > > > >
> > > > > If the device-tree nodes for the INTx interrupts were present, th=
e
> > > > > "ipar" sequence to find the interrupt parent would be skipped and=
 we
> > > > > wouldn't end up with the -22 (-EINVAL) error code.
> > > > >
> > > > > I hope this clarifies the relation between the -22 error code and=
 the
> > > > > missing device-tree nodes for INTx.
> > > > >
> > > >
> > > > Thanks for explaining the logic. Still I think the logic is flawed.=
 Because the
> > > > parent (host bridge) doesn't have 'interrupt-map', which means INTx=
 is not
> > > > supported. But parsing one level up to the GIC node and not returni=
ng -ENOENT
> > > > doesn't make sense to me.
> > > >
> > > > Rob, what is your opinion on this behavior?
> > >
> > > Not sure I get the question. How should we handle/determine no INTx? =
I
> > > suppose that's either based on the platform (as this patch did) or by
> >
> > Platform !=3D driver. Here the driver is making the call, but the platf=
orm
> > capability should come from DT, no? I don't like the idea of disabling =
INTx in
> > the driver because, the driver may support multiple SoCs and these capa=
bility
> > may differ between them. So the driver will end up just hardcoding the =
info
> > which is already present in DT :/
>
> Let me rephrase it to "a decision made within the driver" (vs.
> globally decided). That could be hardcoded (for now) or as match data
> based on compatible.
>
> > Moreover, the issue I'm seeing is, even if the platform doesn't support=
 INTx (as
> > described by DT in this case), of_irq_parse_pci() doesn't report correc=
t
> > error/log. So of_irq_parse_pci() definitely needs a fixup.
>
> Possibly. What's correct here?
>
> There was some rework in 6.11 of the interrupt parsing. So it is
> possible something changed here. There's also this issue still
> pending:
>
> https://lore.kernel.org/all/2046da39e53a8bbca5166e04dfe56bd5.squirrel@_/

I meant this rework was in 6.10.

Rob

