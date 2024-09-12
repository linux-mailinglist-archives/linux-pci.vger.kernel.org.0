Return-Path: <linux-pci+bounces-13102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8897680F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F5283A35
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACEC18A6A9;
	Thu, 12 Sep 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnSDEhqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08F224CF;
	Thu, 12 Sep 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141379; cv=none; b=gruNpE37jAmlZuCfpFSXLo5ilg3ur1eS+NVC1nfWuaAVp0sfWk0s4C7QEVmf9NUMZNUtYrq9t8EHNN8QcEdF8G6fyN52Ydt1MIMHueqz2EE3cTA2dtMR+AAUyUS9uhmwMnaiqnrDMyPmMuPHVctVEdgaxz6guBdFShMplLiBK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141379; c=relaxed/simple;
	bh=74t/6Lr2+3xfoJLQZ5kG3OSTE3ec884oIFiAxXwJ8yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejvD86IkC5dSZhclTbS/OjgAA3NSIyW9vx961/AhI/DL2l64JEBNKSjxxlhdIzggdxsPT2FSH8FBdUrEH0c2zHDuGT7WY4dFB0XAeZpyVXZ7l7xcdsRBZ9LVBZqmd/ot2lMQwzP6CCY4Z/iq7oHCfJN10XKZ1t7V4jX1VVO+ZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnSDEhqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D09AC4CECD;
	Thu, 12 Sep 2024 11:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726141379;
	bh=74t/6Lr2+3xfoJLQZ5kG3OSTE3ec884oIFiAxXwJ8yg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AnSDEhqzH4TVXXkmAmOnIQAofLz8MMX5loMctL64+MKmO7qXd+39QnX3dFnqb3Aax
	 VfBa3c8Tyn9fRNhQxoV/3vnKi9qiqEyp7S1Ny+yyFkL/rRcB+vm69k1ekJJjTW1k+H
	 GI4DQDlOwrPlY8kCvvsg9HhFnmZzzOtOrkvofglxdWTzg3rKRLb1O45zYEHNzk4ILg
	 b1YMruKjH31GViZ7uvRUjyit5PDOnCYVc+GMj/S3QUNPLXi04gcnleyx/vD44/sRDO
	 NQBLp2LjA3WN09uFUccw9zqh3GqetvV+pQBDnWCL3dKZKSr0orgthNNJvdXKQMlvtT
	 GaQRnE//BtuWA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2705d31a35cso387618fac.0;
        Thu, 12 Sep 2024 04:42:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/+276++IGKTb5V3gQU1X+18p8b5lwun+92rGhODhMnaIHBpI9gfN9rmQIXrZOd40ZIOQ7hKV++p8=@vger.kernel.org, AJvYcCWW+q5lPrlKxHrgHqXVTiNTDEu3IVahAl5idL2TYmqTsrWk5szb+7SPUtD8xK0u3iubonfyoJ3MUZ9Fmbw=@vger.kernel.org, AJvYcCWataEGK8fu8a8E9kHaWLWALBqLTX9Tuygex6l/G54t0oDhj2lOvqEwCwdfF73Ep5QlvCs4SUgeo3Ms@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VjyyEkEqWerGzNCm9cfHWd9nsreBskRYMMw9LNcfnsitAAvk
	QatV11yQjupGOVWHRro7fZAV6WSrjaOkMx+7NkORrQWFlkN4sQoo7lhmY+06vNq5MfhTckyC7UN
	3RioHbUJtoQjVOZFxBIHHwhwz288=
X-Google-Smtp-Source: AGHT+IHi5GsHgUbSckGcFqwpFN8cp7ELgXQ6onRMbQE3zE++4MDsI48Be+sbaHhtk6yYbf/5v1BXIYRW1MyecHWrTvs=
X-Received: by 2002:a05:6870:972c:b0:270:4d48:6be2 with SMTP id
 586e51a60fabf-27c3f411895mr1650155fac.26.1726141378394; Thu, 12 Sep 2024
 04:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com> <20240816204539.GA73302@bhelgaas>
In-Reply-To: <20240816204539.GA73302@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 13:42:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
Message-ID: <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, 
	quic_parass@quicinc.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Mayank Rana <quic_mrana@quicinc.com>, Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:45=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Rafael, Mayank, Markus (when people have commented on previous
> versions, please cc them on new versions).  I'm still hoping Rafael
> will have a chance to chime in]
>
> On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wrote=
:
> > The Controller driver is the parent device of the PCIe host bridge,
> > PCI-PCI bridge and PCIe endpoint as shown below.
> >
> >         PCIe controller(Top level parent & parent of host bridge)
> >                         |
> >                         v
> >         PCIe Host bridge(Parent of PCI-PCI bridge)
> >                         |
> >                         v
> >         PCI-PCI bridge(Parent of endpoint driver)
> >                         |
> >                         v
> >                 PCIe endpoint driver
> >
> > Now, when the controller device goes to runtime suspend, PM framework
> > will check the runtime PM state of the child device (host bridge) and
> > will find it to be disabled.
>
> I guess "will find it to be disabled"  means the child (host bridge)
> has runtime PM disabled, not that the child device is disabled, right?
>
> > So it will allow the parent (controller
> > device) to go to runtime suspend. Only if the child device's state was
> > 'active' it will prevent the parent to get suspended.
>
> Can we include a hint like the name of the function where the PM
> framework decides this?  Maybe this is rpm_check_suspend_allowed()?
>
> rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> like it could be related, and AFAICS .ignore_children =3D=3D false here,
> so .child_count should be relevant.
>
> But I'm still confused about why we can runtime suspend a bridge that
> leads to devices that are not suspended.

That should only be possible if runtime PM is disabled for those devices.

> > Since runtime PM is disabled for host bridge, the state of the child
> > devices under the host bridge is not taken into account by PM framework
> > for the top level parent, PCIe controller. So PM framework, allows
> > the controller driver to enter runtime PM irrespective of the state
> > of the devices under the host bridge. And this causes the topology
> > breakage and also possible PM issues like controller driver goes to
> > runtime suspend while endpoint driver is doing some transfers.

Why is it a good idea to enable runtime PM for a PCIe controller?

> What does "topology breakage" mean?  Do you mean something other than
> the fact that an endpoint DMA might fail if the controller is
> suspended?
>
> > So enable runtime PM for the host bridge, so that controller driver
> > goes to suspend only when all child devices goes to runtime suspend.

This by itself makes sense to me.

> IIUC, the one-sentence description here is that previously, the PCI
> host controller could be runtime suspended even while an endpoint was
> active, which caused DMA failures.  And this patch changes that so the
> host controller is only runtime suspended after the entire hierarchy
> below it is runtime suspended?  Is that right?
>
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> > Changes in v4:
>
> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> offset).
>
> > - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by=
 mayank)
> > - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0=
460b49d60@quicinc.com/
> > Changes in v3:
> > - Moved the runtime API call's from the dwc driver to PCI framework
> >   as it is applicable for all (suggested by mani)
> > - Updated the commit message.
> > - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2=
-1-a849b74091d1@quicinc.com
> > Changes in v2:
> > - Updated commit message as suggested by mani.
> > - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1=
-d39660310504@quicinc.com
> > ---
> >
> > ---
> >  drivers/pci/probe.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 8e696e547565..fd49563a44d9 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridg=
e)
> >       }
> >
> >       pci_bus_add_devices(bus);
> > +
> > +     pm_runtime_set_active(&bridge->dev);
> > +     devm_pm_runtime_enable(&bridge->dev);
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_host_probe);

This will effectively prevent the host bridge from being
runtime-suspended at all IIUC, so the PCIe controller will never
suspend too after this change.

If this is the intended behavior, I would suggest saying that
explicitly in the changelog.

