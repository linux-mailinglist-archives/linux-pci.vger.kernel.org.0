Return-Path: <linux-pci+bounces-814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C087B80F73F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 20:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B528281FB6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95A6359C;
	Tue, 12 Dec 2023 19:53:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200DA1;
	Tue, 12 Dec 2023 11:53:24 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5907b9c3fd6so531896eaf.0;
        Tue, 12 Dec 2023 11:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410804; x=1703015604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75CeVcCRwUty+KpM8QpE5QSGDTdGQa8ndaCOmWHQyH0=;
        b=Kdk3djBHHqwbB29ljV07wj0Z3g3waSDBT9f/DXPKybLtmNI6tnMT/4PHazzwMzNszm
         KL1Fuqu0s6p9i4oCytZxjYWu/k7+AdASPMxobEUm+DuLjmBIIpPwt3+0v+GKX1Q6q9A9
         Wbkon2ZX1+VE0SRdPCnVppeyoepVGdCL0wqfhhheI9ydFsHEez4/7sRPZIdxha81qvRl
         pF8WuijwGibS/Z59NYUQiImRn9iWaRrh7AnhJmFbY+eyERrQZEMd+hBNQhL3dH5Jhw/2
         +DnKrclaMT9FLgvici/CEX/ZS3OcEj65zhHicZ3WbeeszKI9oGRf0Rrk7o4GjpLdAmRZ
         cmhA==
X-Gm-Message-State: AOJu0Yyxk2nzB0IVEFQnABo7ux/3ju8WpplQAPf/UWiM0weMjBou6X09
	1lbzPoFhXm+NmpM9gRrl1WwWkct7oCC+wGwvGdU=
X-Google-Smtp-Source: AGHT+IEQ7HQc7LHf4b0yqJ5xEdkrUXhbc2igJHPd8dbYUbUlIWpcTc9bu+wd/O5lkVv+pDyNVlRwro0x0Ux6j2fvVME=
X-Received: by 2002:a4a:d130:0:b0:590:5de3:cca6 with SMTP id
 n16-20020a4ad130000000b005905de3cca6mr10413258oor.0.1702410803778; Tue, 12
 Dec 2023 11:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203041046.38655-1-mario.limonciello@amd.com>
 <20231203041046.38655-3-mario.limonciello@amd.com> <CAJZ5v0g_HWFnt0a5fDnb73Q14C84O+RPYVF104TDK7T_Ox3_EA@mail.gmail.com>
 <d61a0a3d-2adc-402f-be4c-2f99a65f5b04@amd.com>
In-Reply-To: <d61a0a3d-2adc-402f-be4c-2f99a65f5b04@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 20:53:12 +0100
Message-ID: <CAJZ5v0gDp6XqoL+VHc1GjuA_iG9jS+z+LRFMR9L6tyyvd2bjNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI: Refresh root ports in pci_bridge_d3_update()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/12/2023 13:25, Rafael J. Wysocki wrote:
> > On Mon, Dec 4, 2023 at 7:07=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> If pci_d3cold_enable() or pci_d3cold_disable() is called on a root
> >> port it is ignored because there is no upstream bridge.
> >
> > The kerneldoc comment of pci_bridge_d3_update() explains what that
> > function is for which also covers why it does not take effect when
> > called on root ports.
>
> I'm sorry but can you clarify the intent of your comment?
>
> Are you suggesting we should introduce a different function/logic for
> root ports, kernel doc should be updated, or root ports should be
> special cased in that function?

They are special-cased in that function already, because it updates an
upstream port for a change in a downstream device.

There are only 2 places really affected by no_d3cold:
pci_dev_check_d3cold() and the ACPI power state selection for PCI
devices. where the former is used for checking whether or not it is
valid to put an upstream bridge into D3hot/cold (which depends on
whether or not the downstream devices below it are allowed to use
D3cold).

The only place where no_d3cold affects root ports is the ACPI power
state selection, because the only way to program a root port into
D3cold is via ACPI.

> >
> >> If called on a root port, use `no_d3cold` variable to decide policy
> >
> > It is unclear that this is about pci_bridge_d3_possible() which
> > applies to both D3hot and D3cold, not just D3cold AFAICS.  I don't
> > think that no_d3cold should affect the D3hot behavior.
>
> IMO the semantics are confusing depending upon what device you called
> pci_d3cold_disable()/pci_d3cold_enable() with as an argument.
>
> Both devices and root ports are used by existing driver in the kernel.
>
> If you called pci_d3cold_disable() with a device, that actually prevents
> the /bridge above it/ from going to D3hot as well (bridge_d3 is set to
> the result)

Right, because (as per the PCI PM spec) putting an upstream bridge
into D3hot/cold effectively removes power from the bus segment below
it, so the devices on that bus segment go into D3cold.  If they are
not allowed to go into D3cold, the bridge needs to stay in a shallower
power state either.

> >
> >> and also immediately refresh whether D3 is possible.
> >
> > Which isn't correct AFAICS.
>
> Why?

Because it makes no_d3cold affect the ability of the given root port
to be programmed into D3hot via PMCSR.

> >
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/pci/pci.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 72505794cc72..3d4aaecda457 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3023,6 +3023,9 @@ bool pci_bridge_d3_possible(struct pci_dev *brid=
ge)
> >>                  if (pci_bridge_d3_disable)
> >>                          return false;
> >>
> >> +               if (bridge->no_d3cold)
> >> +                       return false;
> >> +
> >>                  /*
> >>                   * Hotplug ports handled by firmware in System Manage=
ment Mode
> >>                   * may not be put into D3 by the OS (Thunderbolt on n=
on-Macs).
> >> @@ -3098,7 +3101,11 @@ void pci_bridge_d3_update(struct pci_dev *dev)
> >>          bool d3cold_ok =3D true;
> >>
> >>          bridge =3D pci_upstream_bridge(dev);
> >> -       if (!bridge || !pci_bridge_d3_possible(bridge))
> >> +       if (!bridge) {
> >> +               dev->bridge_d3 =3D pci_bridge_d3_possible(dev);
> >> +               return;
> >> +       }
> >> +       if (!pci_bridge_d3_possible(bridge))
> >>                  return;
> >>
> >>          /*
> >> --
> >> 2.34.1
> >>
> >>
>

