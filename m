Return-Path: <linux-pci+bounces-13106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C5976860
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2964D285F94
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393E1A0BE9;
	Thu, 12 Sep 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypbe6Zb/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC119C546;
	Thu, 12 Sep 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142042; cv=none; b=rQnJjqp/X3aSJCCL6s7jhLwbCnwn/BA7UM6/oEL4RSW5VHI5lymMRLT8Z5oxmK9e/qe94935Mv4kWV2x8UbE5lkiaOa2/8WI7yWxZwWO2Q6CUlXTa8hkAkD6LsnQk4pSpwNz9YQ7IsG62yNmi4rl/qGXbBjGSOdUegCERHy/n7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142042; c=relaxed/simple;
	bh=7crz9sPzwoTqsr/Iy7Pccs05zy8ttqmHkpZhV935KDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdYe+4/aHpVx4VuOIHAHKjjrOpFeE+nxbNFMpEB99bkv6MrCS7OpeL3OS30+j6ya8OSEWcyMvgqXWtN1GMnVF4EtKNnOUzuVWESmc2zpxyswuvyVMvh4cFvUYr4h4fzf7oCBmnXyPYRO3cqceCNya1186RcNrb7l7xRxl7us+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypbe6Zb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D4CC4CED0;
	Thu, 12 Sep 2024 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726142041;
	bh=7crz9sPzwoTqsr/Iy7Pccs05zy8ttqmHkpZhV935KDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ypbe6Zb/45cCv4xoiUMzZt+TarB78t+fWlPAmw2XlKrtjxX/MrStk4tqecimwkoNN
	 I9EEcIEApo2HykZ/bAqD3e2IrqUCb9CCVktBe8KlgbX0Da1unK/Kba8K6IuA2ajiSN
	 FSXbaBQK0GCq/2ne2dobeUfhK2IhCVHO4bajnOR+3lAQJ/t5viwL+YSSmc3c6Cpgod
	 sSXWRwfrxsQHqLrAdgiO6byZHX4FuHIo0jvHJAEIZZ4iJRoQsSDzYajkzIZyZhrwtV
	 SRk6hRr/eKeMIAtr5XjDC5Ro/9oSkGuwcyBPAu9c9GN54X+kP59P/gsXMvuN3VINMT
	 bfUQAnIi2EeMQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2781cb2800eso410159fac.1;
        Thu, 12 Sep 2024 04:54:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqMcWHahJuThk5P0dTJAibMeQ6US2P/05QQefk0xv0fqtcEIAeXiClCxZ/nNVlkmziyuqm2jEk3ztl5rk=@vger.kernel.org, AJvYcCWs5anlSwbat8CfH1aBnV8ClV8XwF85cum3V1E8kJoPBS1TYPjqH9R7uynTmCdpqC8VWy/wrtXM2x8=@vger.kernel.org, AJvYcCXPKS8fZZ8jFDCAu2IVUHGVEUnuJGAXq3gGjoJkZh9jgqAwhN1PzrbgjI59OTcGsm1N3Zi0pkAT7bgb@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbQmk9DXkUNDeZwwOTaDhuCgbGswEIeFkXG2cOj2V8twi+HrX
	2qCj8yPvVhTPo6fhrFxozFTsAQj1JULQ/peqo/l5DJQh0G22JiLUi4fq7IHPCk5ccYJU9i1Nrtr
	yP657h/rINKzhcQtyQKqGD5p9Us0=
X-Google-Smtp-Source: AGHT+IHuhopRHlNPUGLv1YZ3xny8F4FPihNiU3LhLdpfwi8bAGn4jXA41h0NjQPLFmgJ0nU2yjkB+zOT80KSROLRfyY=
X-Received: by 2002:a05:6870:2402:b0:260:f43e:7d89 with SMTP id
 586e51a60fabf-27c3f25645fmr1630075fac.2.1726142040742; Thu, 12 Sep 2024
 04:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240816204539.GA73302@bhelgaas> <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 13:53:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixDsQiEkzCe=SNE7Nq354KmtjF9nXL2sD3ZOrK4zwFKw@mail.gmail.com>
Message-ID: <CAJZ5v0ixDsQiEkzCe=SNE7Nq354KmtjF9nXL2sD3ZOrK4zwFKw@mail.gmail.com>
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

On Thu, Sep 12, 2024 at 1:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Aug 16, 2024 at 10:45=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> >
> > [+cc Rafael, Mayank, Markus (when people have commented on previous
> > versions, please cc them on new versions).  I'm still hoping Rafael
> > will have a chance to chime in]
> >
> > On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wro=
te:
> > > The Controller driver is the parent device of the PCIe host bridge,
> > > PCI-PCI bridge and PCIe endpoint as shown below.
> > >
> > >         PCIe controller(Top level parent & parent of host bridge)
> > >                         |
> > >                         v
> > >         PCIe Host bridge(Parent of PCI-PCI bridge)
> > >                         |
> > >                         v
> > >         PCI-PCI bridge(Parent of endpoint driver)
> > >                         |
> > >                         v
> > >                 PCIe endpoint driver
> > >
> > > Now, when the controller device goes to runtime suspend, PM framework
> > > will check the runtime PM state of the child device (host bridge) and
> > > will find it to be disabled.
> >
> > I guess "will find it to be disabled"  means the child (host bridge)
> > has runtime PM disabled, not that the child device is disabled, right?
> >
> > > So it will allow the parent (controller
> > > device) to go to runtime suspend. Only if the child device's state wa=
s
> > > 'active' it will prevent the parent to get suspended.
> >
> > Can we include a hint like the name of the function where the PM
> > framework decides this?  Maybe this is rpm_check_suspend_allowed()?
> >
> > rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> > like it could be related, and AFAICS .ignore_children =3D=3D false here=
,
> > so .child_count should be relevant.
> >
> > But I'm still confused about why we can runtime suspend a bridge that
> > leads to devices that are not suspended.
>
> That should only be possible if runtime PM is disabled for those devices.
>
> > > Since runtime PM is disabled for host bridge, the state of the child
> > > devices under the host bridge is not taken into account by PM framewo=
rk
> > > for the top level parent, PCIe controller. So PM framework, allows
> > > the controller driver to enter runtime PM irrespective of the state
> > > of the devices under the host bridge. And this causes the topology
> > > breakage and also possible PM issues like controller driver goes to
> > > runtime suspend while endpoint driver is doing some transfers.
>
> Why is it a good idea to enable runtime PM for a PCIe controller?
>
> > What does "topology breakage" mean?  Do you mean something other than
> > the fact that an endpoint DMA might fail if the controller is
> > suspended?
> >
> > > So enable runtime PM for the host bridge, so that controller driver
> > > goes to suspend only when all child devices goes to runtime suspend.
>
> This by itself makes sense to me.
>
> > IIUC, the one-sentence description here is that previously, the PCI
> > host controller could be runtime suspended even while an endpoint was
> > active, which caused DMA failures.  And this patch changes that so the
> > host controller is only runtime suspended after the entire hierarchy
> > below it is runtime suspended?  Is that right?
> >
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > > Changes in v4:
> >
> > (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> > offset).
> >
> > > - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested =
by mayank)
> > > - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3=
d0460b49d60@quicinc.com/
> > > Changes in v3:
> > > - Moved the runtime API call's from the dwc driver to PCI framework
> > >   as it is applicable for all (suggested by mani)
> > > - Updated the commit message.
> > > - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-=
v2-1-a849b74091d1@quicinc.com
> > > Changes in v2:
> > > - Updated commit message as suggested by mani.
> > > - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1=
-1-d39660310504@quicinc.com
> > > ---
> > >
> > > ---
> > >  drivers/pci/probe.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 8e696e547565..fd49563a44d9 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bri=
dge)
> > >       }
> > >
> > >       pci_bus_add_devices(bus);
> > > +
> > > +     pm_runtime_set_active(&bridge->dev);
> > > +     devm_pm_runtime_enable(&bridge->dev);
> > > +
> > >       return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_host_probe);
>
> This will effectively prevent the host bridge from being
> runtime-suspended at all IIUC, so the PCIe controller will never
> suspend too after this change.

Actually, scratch this.  rpm_idle() will suspend the host bridge when
its last child suspends.

However, how is it going to be resumed?

