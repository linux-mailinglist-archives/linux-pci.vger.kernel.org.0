Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9130D75CAAC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGUOxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjGUOxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 10:53:05 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29A121;
        Fri, 21 Jul 2023 07:53:03 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5634db21a58so1352675eaf.0;
        Fri, 21 Jul 2023 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689951183; x=1690555983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxlgaC60bco0Cm1BalXqc8WdAEfbZykARIUfMKPLvhI=;
        b=fbrUOeUpu4cBkbiAZ8xkJRDFN1rcYnsMEErgzZd4XvEaBZaOATyGRd9L8p9FgGsbK8
         U+Zn+fktiRE3+uRA4yMihQ80YP4CxgZmjQta6n9UbHs0hNxDWLcNahKHgan1YZ3vaypO
         rjkhifUHytGH989tDbfhfJZAOjXBwXXf2xR1Ghwg/MH+kmbMiVQ2B7DK7XIjLCJBAUTJ
         I3huXU6GXAWeGmzh2OSV892nyKHbIl7WefxoXpNrhSVfQBS8FZZdapZDV93EyGhLxTw1
         05Clo3CyvPwJfKexVC7zk8Q+FkqVayvXRWiF18rdPm1I5eomz+HwkGYHFx47MX+E8rDh
         nwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951183; x=1690555983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxlgaC60bco0Cm1BalXqc8WdAEfbZykARIUfMKPLvhI=;
        b=DwR5JSK9rttUbl/9qYRWbd2TyytdJmrbnbx4Z1IQPM9EnT8Vy32/y/P4YrF4Gx3O/F
         J/Z/MxAlTIbypBm69Mb6qNuS5X3rQdSrXuQ3wIH22YOOyEuWlfCWFKD2PwvdwbL3mYiW
         5vaLhg+aXqmzIBsDXlKBBAkNGtvAPKGHPPu9NdZSrZ23LSBY+w9VYWNya4QnmnsGDjpB
         +QniXcEHMaOznvXrG+bLrH5YB54COdvVPVKeVcb6i/iMPEAs5fWP6v+TW1+tS33iwnna
         ztpSPKOSNC/IzQgUC8aiM1/p2UzI9BSBtvvOimeWIeMYDFfepU7b6ngJ98+qpLQ4yk/a
         o+Vg==
X-Gm-Message-State: ABy/qLYBDkQf0sLEd/4nT7EQQ+hT5CL4NKbRMYEhnELmzq1536sfzCdE
        DUoj2+jjrYPu27pokqyXuI6+OkrjJAtolqcqobc=
X-Google-Smtp-Source: APBJJlESC7Ai9Ycl0FQ+vntlvM+i6R3W0MWc3MK5MIQ1NKkGjXHAfFkEx56UUC7A/g25qJDMU+4MZ/Gil3pRk7P3MHM=
X-Received: by 2002:a4a:d1c3:0:b0:563:53fa:324f with SMTP id
 a3-20020a4ad1c3000000b0056353fa324fmr1890890oos.6.1689951182938; Fri, 21 Jul
 2023 07:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230720215550.GA554900@bhelgaas> <eff193b-31ea-5c36-cbc-6b15a477f3b1@linux.intel.com>
In-Reply-To: <eff193b-31ea-5c36-cbc-6b15a477f3b1@linux.intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jul 2023 10:52:51 -0400
Message-ID: <CADnq5_MUyjAZoRBDvdBFDYdiA6nwsaup+MKM+ajo7HKTtez9DQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm/amdgpu: Use RMW accessors for changing LNKCTL
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ken Wang <Qingqing.Wang@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 4:18=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 20 Jul 2023, Bjorn Helgaas wrote:
>
> > On Mon, Jul 17, 2023 at 03:04:57PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > Don't assume that only the driver would be accessing LNKCTL. ASPM
> > > policy changes can trigger write to LNKCTL outside of driver's contro=
l.
> > > And in the case of upstream bridge, the driver does not even own the
> > > device it's changing the registers for.
> > >
> > > Use RMW capability accessors which do proper locking to avoid losing
> > > concurrent updates to the register value.
> > >
> > > Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK parts")
> > > Fixes: 62a37553414a ("drm/amdgpu: add si implementation v10")
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Cc: stable@vger.kernel.org
> >
> > Do we have any reports of problems that are fixed by this patch (or by
> > others in the series)?  If not, I'm not sure it really fits the usual
> > stable kernel criteria:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/stable-kernel-rules.rst?id=3Dv6.4
>
> I was on the edge with this. The answer to your direct question is no,
> there are no such reports so it would be okay to leave stable out I think=
.
> This applies to all patches in this series.
>
> Basically, this series came to be after Lukas noted the potential
> concurrency issues with how LNKCTL is unprotected when reviewing
> (internally) my bandwidth controller series. Then I went to look around
> all LNKCTL usage and realized existing things might alreary have similar
> issues.
>
> Do you want me to send another version w/o cc stable or you'll take care
> of that?
>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/cik.c | 36 +++++++++---------------------=
--
> > >  drivers/gpu/drm/amd/amdgpu/si.c  | 36 +++++++++---------------------=
--
> > >  2 files changed, 20 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/a=
mdgpu/cik.c
> > > index 5641cf05d856..e63abdf52b6c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> > > @@ -1574,17 +1574,8 @@ static void cik_pcie_gen3_enable(struct amdgpu=
_device *adev)
> > >                     u16 bridge_cfg2, gpu_cfg2;
> > >                     u32 max_lw, current_lw, tmp;
> > >
> > > -                   pcie_capability_read_word(root, PCI_EXP_LNKCTL,
> > > -                                             &bridge_cfg);
> > > -                   pcie_capability_read_word(adev->pdev, PCI_EXP_LNK=
CTL,
> > > -                                             &gpu_cfg);
> > > -
> > > -                   tmp16 =3D bridge_cfg | PCI_EXP_LNKCTL_HAWD;
> > > -                   pcie_capability_write_word(root, PCI_EXP_LNKCTL, =
tmp16);
> > > -
> > > -                   tmp16 =3D gpu_cfg | PCI_EXP_LNKCTL_HAWD;
> > > -                   pcie_capability_write_word(adev->pdev, PCI_EXP_LN=
KCTL,
> > > -                                              tmp16);
> > > +                   pcie_capability_set_word(root, PCI_EXP_LNKCTL, PC=
I_EXP_LNKCTL_HAWD);
> > > +                   pcie_capability_set_word(adev->pdev, PCI_EXP_LNKC=
TL, PCI_EXP_LNKCTL_HAWD);
> > >
> > >                     tmp =3D RREG32_PCIE(ixPCIE_LC_STATUS1);
> > >                     max_lw =3D (tmp & PCIE_LC_STATUS1__LC_DETECTED_LI=
NK_WIDTH_MASK) >>
> > > @@ -1637,21 +1628,14 @@ static void cik_pcie_gen3_enable(struct amdgp=
u_device *adev)
> > >                             msleep(100);
> > >
> > >                             /* linkctl */
> > > -                           pcie_capability_read_word(root, PCI_EXP_L=
NKCTL,
> > > -                                                     &tmp16);
> > > -                           tmp16 &=3D ~PCI_EXP_LNKCTL_HAWD;
> > > -                           tmp16 |=3D (bridge_cfg & PCI_EXP_LNKCTL_H=
AWD);
> > > -                           pcie_capability_write_word(root, PCI_EXP_=
LNKCTL,
> > > -                                                      tmp16);
> > > -
> > > -                           pcie_capability_read_word(adev->pdev,
> > > -                                                     PCI_EXP_LNKCTL,
> > > -                                                     &tmp16);
> > > -                           tmp16 &=3D ~PCI_EXP_LNKCTL_HAWD;
> > > -                           tmp16 |=3D (gpu_cfg & PCI_EXP_LNKCTL_HAWD=
);
> > > -                           pcie_capability_write_word(adev->pdev,
> > > -                                                      PCI_EXP_LNKCTL=
,
> > > -                                                      tmp16);
> > > +                           pcie_capability_clear_and_set_word(root, =
PCI_EXP_LNKCTL,
> > > +                                                              PCI_EX=
P_LNKCTL_HAWD,
> > > +                                                              bridge=
_cfg &
> > > +                                                              PCI_EX=
P_LNKCTL_HAWD);
> > > +                           pcie_capability_clear_and_set_word(adev->=
pdev, PCI_EXP_LNKCTL,
> > > +                                                              PCI_EX=
P_LNKCTL_HAWD,
> > > +                                                              gpu_cf=
g &
> > > +                                                              PCI_EX=
P_LNKCTL_HAWD);
> >
> > Wow, there's a lot of pointless-looking work going on here:
> >
> >   set root PCI_EXP_LNKCTL_HAWD
> >   set GPU  PCI_EXP_LNKCTL_HAWD
> >
> >   for (i =3D 0; i < 10; i++) {
> >     read root PCI_EXP_LNKCTL
> >     read GPU  PCI_EXP_LNKCTL
> >
> >     clear root PCI_EXP_LNKCTL_HAWD
> >     if (root PCI_EXP_LNKCTL_HAWD was set)
> >       set root PCI_EXP_LNKCTL_HAWD
> >
> >     clear GPU  PCI_EXP_LNKCTL_HAWD
> >     if (GPU  PCI_EXP_LNKCTL_HAWD was set)
> >       set GPU  PCI_EXP_LNKCTL_HAWD
> >   }
> >
> > If it really *is* pointless, it would be nice to clean it up, but that
> > wouldn't be material for this patch, so what you have looks good.
>
> I really don't know if it's needed or not. There's stuff which looks hw
> specific going on besides those things you point out and I've not really
> understood what all that does.
>
> One annoying thing is that this code has been copy-pasted to appear in
> almost identical form in 4 files.
>
> I agree it certainly looks there might be room for cleaning things up her=
e
> but such cleanups look a bit too scary to me w/o hw to test them.
>
> > >                             /* linkctl2 */
> > >                             pcie_capability_read_word(root, PCI_EXP_L=
NKCTL2,
> >
> > The PCI_EXP_LNKCTL2 stuff also includes RMW updates.  I don't see any
> > uses of PCI_EXP_LNKCTL2 outside this driver that look relevant, so I
> > guess we don't care about making the PCI_EXP_LNKCTL2 updates atomic?
>
> Currently no, which is why I left it out from this patchset.
>
> It is going to change soon though as I intend to submit bandwidth
> controller series after this series which will add RMW ops for LNKCTL2.
> The LNKCTL2 RMW parts are now in that series rather than in this one.
>
> After adding the bandwidth controller, this driver might be able to use
> it instead of tweaking LNKCTL2 directly to alter PCIe link speed (but I
> don't expect myself to be able to test these drivers and it feels too
> risky to make such a change without testing it, unfortunately).

Thanks for the background.  It was not clear what the point of this
patch set was.  This code and the similar code in radeon is just to
change the link speed of the GPU.  Some older platforms used default
to slower link on boot so we added this code to renegotiate the link
to a faster speed when the driver loaded.  If you are adding core
infrastructure to do that, we can switch to that.  This was just the
programming sequence I got from the hardware team back when this code
was written.  Most platforms I've seen these days come up at the max
supported speed of the platform and endpoint so I don't think the code
actually gets used much anymore.

Taking a step back, what is the end goal of the bandwidth controller
changes?  The reason I ask is that today, we look at the currently
negotiated speed of the link and use that for the baseline in the
driver.  The driver then enables PCIe dynamic power management where
the system management unit on the GPU dynamically adjusts the link
speed, width, and clock on demand based on the PCIe bandwidth
requirements of the currently executing GPU jobs to save power.  This
might conflict with software if the goal is for some software
component to do something similar.

Alex
