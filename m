Return-Path: <linux-pci+bounces-14366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7499B186
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8191C21A6C
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6B13B7BC;
	Sat, 12 Oct 2024 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU31/eU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB5BE65;
	Sat, 12 Oct 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717950; cv=none; b=LVmtKVfDq4QUCPWgSs04Yb75X4BHaQQkR02pSb1JSkfuKhJ46/mU3Mx+IMQpBcRuQC0zy+v+Cb5mnsd056Itye5bhtTJlnVOupipEW9EkQKxEyVLKs3Ls1oCSFQ48h3DisV/a/bM8EW0+v3J4ptoM36MDAO9HfSesi7A3TPERos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717950; c=relaxed/simple;
	bh=p7RaWNZNcHo9lcXZqi8k2uwxT03aaMwOi/kW0DESVwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4sJKzkFCrZgvy4P8gK2nzCCpj7GehGjKuP0HvkLPlMj2PZOAlWNmprZF5m68SfSH8AC2bS+k6ROVhOZulZI0GCewtHp5byg/MKU17mfQSjMy1GxHIYtVJBmMQWzlGAE1dVOiNDho+EZLj3fzSnmi+TXqnbOiBEIrPN0YO5od3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU31/eU6; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e7ffcd95c1so1400736eaf.2;
        Sat, 12 Oct 2024 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717948; x=1729322748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7x2Riz9fOdB+v8xtvZbjrMEInDLCLHNkcSKslT3a7c=;
        b=aU31/eU6MZvcuwvgthJN8CJcP9FQhmoCmhhA2rTiE0iv3TBGwDqOnc6MgYWpB8UlsU
         lmgRjMVQPJutHac2DP9Y72aC64DHuAADTtBUa7lP7M0yi7l7dbfehNC+/uZjCwlOCwm1
         SKieVqIcDGBn3PDxz/QILMSJPTCZZycCjEFHoS1b8H2EyIjH4VBnWHWooy0OUAe+h8qp
         nvX1DngSH1CRASBUJGEMg9IKrGcMic5mFadR+E9nWpFyW6QnH+mXGo7H6/DbTMsuEynP
         zut0zUPObNQ9DsPRp6tanSCsuGeo9HcuoUoThcTpvlvYQiqQCLpgnx+6bnAiGsaR5A5Q
         rAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717948; x=1729322748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7x2Riz9fOdB+v8xtvZbjrMEInDLCLHNkcSKslT3a7c=;
        b=C+GrEwXtFBAgPqWF+k9l/+2GtQlSBPGZVW0gJy8XRng65dfsh8BUFgYcAL5ExqxDod
         f/W2pf7JJW+mllZR2ge60bm2x4iSyc5u40EuADtpq6gGHexQ5Jci+gZHrmjMqBeb1xV/
         8iOoL2irbFhJ0d2ev4Af3Ce+VuzZDVVNGVgAH+5Ux4Ju4c2Qhtu6gCPy6H3zqyIaglzs
         KW4PIf22N8EaMqfVRweZ8iwsmCkohIIK+ybXp9dDRtJdWtiMEBT//2qnoeq925b/KV/p
         q8kSR1vhjW0GPtFc/BlJxUq12tAFnlna5TMGZ+1qrwHbmO42qg+O5ESOwRg7cfg1Vo6i
         mP8g==
X-Forwarded-Encrypted: i=1; AJvYcCWGsXinJiUkaHWOf/dgc5dSLX+OQnTA25hZ/J0/gLd+/QstclRYd4uDKO7DppUvt+Rvg7vTfh+7O5ak0g8=@vger.kernel.org, AJvYcCXvQiaKhPdYvHzS0lBRVy+Y6v38nlK28ID1FHilZU7q6SNwfEfzpxaJZIs1gfnDGcuRFHtVznUDroip@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XpGepLkbSSzRhan1pwebqAJtsUtU/VP0NkHIS/aFJG7c3Qny
	aXbbQHkwHwcWdfwnnhc9NfLieTLnhm7Hb0cXVtpVTtjhtiFDZ9+sK7uG/4sHzNt0kbHdNKyydPV
	9xE11F2yRBRETor8JzyUJS3cDTlk=
X-Google-Smtp-Source: AGHT+IFF8b7t1elz+9tSeHeuk8QScStItx+7TzgXVzweXMAnHfn4VcFGQtjaOOfTOxn23vBcXfF3ZjWWrvrWDGe0A9A=
X-Received: by 2002:a05:6870:5b85:b0:288:563b:e48d with SMTP id
 586e51a60fabf-2886dce75cbmr4468337fac.10.1728717947845; Sat, 12 Oct 2024
 00:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012050611.1908-1-linux.amoon@gmail.com> <20241012050611.1908-3-linux.amoon@gmail.com>
 <20241012061834.ksbtcaw3c7iacnye@thinkpad>
In-Reply-To: <20241012061834.ksbtcaw3c7iacnye@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 12 Oct 2024 12:55:32 +0530
Message-ID: <CANAwSgTk2ynkuxBarvX--Qs_LTduFuSDCv3k_WNgj=za_81+kQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

Thanks for your review comments.

On Sat, 12 Oct 2024 at 11:48, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Oct 12, 2024 at 10:36:04AM +0530, Anand Moon wrote:
> > Refactor the reset control handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for assert and
> > deassert reset controller using reset_control_bulk*() API. Using the
> > reset_control_bulk APIs, the reset handling for the core clocks reset
> > unit becomes much simpler.
> >
>
> Same comments as previous patch.
>
I will explain more about this.
> > Spilt the reset controller in two groups as pre the RK3399 TRM.
>
> *per
>
> Also please state the TRM name and section for reference.
>
Yes
> > After power up, the software driver should de-assert the reset of PCIe =
PHY,
> > then wait the PLL locked by polling the status, if PLL
> > has locked, then can de-assert the reset simultaneously
> > driver need to De-assert the reset pins simultionaly.
> >
> >   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> >
> > - replace devm_reset_control_get_exclusive() with
> >       devm_reset_control_bulk_get_exclusive().
> > - replace reset_control_assert with
> >       reset_control_bulk_assert().
> > - replace reset_control_deassert with
> >       reset_control_bulk_deassert().
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> >         with devm_reset_control_bulk_get_exclusive()
> >     update the functional changes.
> > V6: Add reason for the split of the RESET pins.
> > v5: Fix the De-assert reset core as per the TRM
> >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> >     simultaneously.
> > v4: use dev_err_probe in error path.
> > v3: Fix typo in commit message, dropped reported by.
> > v2: Fix compilation error reported by Intel test robot
> >     fixed checkpatch warning.
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
> >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> >  2 files changed, 49 insertions(+), 128 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/contr=
oller/pcie-rockchip.c
> > index 2777ef0cb599..9a118e2b8cbd 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> > @@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rock=
chip)
>
> [...]
>
> > +     err =3D reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
> > +                                     rockchip->pm_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "reset bulk assert pm rese=
t\n");
>
> 'Couldn't assert PM resets'
>
> >
> >       for (i =3D 0; i < MAX_LANE_NUM; i++) {
> >               err =3D phy_init(rockchip->phys[i]);
> > @@ -173,47 +128,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
*rockchip)
> >               }
> >       }
> >
> > -     err =3D reset_control_assert(rockchip->core_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert core_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->mgmt_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert mgmt_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->mgmt_sticky_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_assert(rockchip->pipe_rst);
> > -     if (err) {
> > -             dev_err(dev, "assert pipe_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > +     err =3D reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
> > +                                     rockchip->core_rsts);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "reset bulk assert core re=
set\n");
>
> 'Couldn't assert Core resets'
>
> >
> >       udelay(10);
> >
> > -     err =3D reset_control_deassert(rockchip->pm_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert pm_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->aclk_rst);
> > +     err =3D reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> > +                                       rockchip->pm_rsts);
> >       if (err) {
> > -             dev_err(dev, "deassert aclk_rst err %d\n", err);
> > -             goto err_exit_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->pclk_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert pclk_rst err %d\n", err);
> > +             dev_err(dev, "reset bulk deassert pm err %d\n", err);
>
> 'Couldn't deassert PM resets'
>
> >               goto err_exit_phy;
> >       }
> >
> > @@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie =
*rockchip)
> >        * Please don't reorder the deassert sequence of the following
> >        * four reset pins.
>
> I don't think my earlier comment on this addressed. Why are you changing =
the
> reset order? Why can't you have the resets in below (older) order?
>
> static const char * const rockchip_pci_core_rsts[] =3D {
>         mgmt-sticky",
>         "core",
>         "mgmt",
>         "pipe",
> };
 I will add a comment on this above.
>
> Also, this comment should be removed now.
>
> >        */
> > -     err =3D reset_control_deassert(rockchip->mgmt_sticky_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->core_rst);
> > +     err =3D reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> > +                                       rockchip->core_rsts);
> >       if (err) {
> > -             dev_err(dev, "deassert core_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->mgmt_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert mgmt_rst err %d\n", err);
> > -             goto err_power_off_phy;
> > -     }
> > -
> > -     err =3D reset_control_deassert(rockchip->pipe_rst);
> > -     if (err) {
> > -             dev_err(dev, "deassert pipe_rst err %d\n", err);
> > +             dev_err(dev, "reset bulk deassert core err %d\n", err);
>
> 'Couldn't deassert Core resets'
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Ok,I will try to improve this in the next version.

Thanks

-Anand

