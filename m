Return-Path: <linux-pci+bounces-14378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A799B2C9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 12:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AC5283317
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06110154426;
	Sat, 12 Oct 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4xKOlZ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F3152160;
	Sat, 12 Oct 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727483; cv=none; b=ouG/kprpmUK2gURlSYHsG/B+SguEe48mzCbR7sgRtMYlKgsDJPpuhMQY4VMchUYeAWWzOESEsKKiaUa37S6r1916R4/P/9F9Vj3Q8LRSo+xH0Q4cflS1z186wLxrL8OwOZshLSFdVcFhCOuG9QzCsEusIgqtWHNUQBLvUO/XD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727483; c=relaxed/simple;
	bh=fZErET5tKNeKX5dTEtV/FXtphzZ6dYBcaPbiFTcRb7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISEh+L4w5DovE4ZU8F9FQMzbH83jdvINX1McitPxs9dIAs7QwIc/Js17qcbVK1Z+nYWzAoMFg/sQYHb5CNM/0bo1lL2M3ufz6E1UcqKxwtvxqfbrHVgSCrLbsXmjr9mcH3+WqbUUQRUS65I2jqYToHMElE8mSm3uOfr5oMxaPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4xKOlZ4; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288661760d3so1189120fac.3;
        Sat, 12 Oct 2024 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728727481; x=1729332281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjrhkihnYZF2WUCfT4mholARLNm6jt8yhmIiSWUOskc=;
        b=F4xKOlZ4MU9LSwuXJH5XpZHvDJ+oXupbx2RHsBFL9Ho8ZP8RFETDp7pcMnFkAE5KXp
         JGQXcUabtFHR/6MUHgbVmt1oW3RHaklTxQUQJnymW6giTDouPp27c/NYuvmXqCpqTkoJ
         mMrTwLnBywd59e2WgvkGHeFyG/7yy4kSlwZCezjl+/oPGbIBR2PJz3LPx/55UoXYq/ut
         fuB3G5QlG/or3pFl/JCBiZgxbEM0olgTmDvxmRDOibPJ79PX3PqNfpfeXPXR4A1/VWCD
         lcaplxe9jmXX0NarkB1IFjlWrB++drnhdW6I3dLJUyZ84XSDkjoDq8jsTUyC+RH1ANsG
         IeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727481; x=1729332281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjrhkihnYZF2WUCfT4mholARLNm6jt8yhmIiSWUOskc=;
        b=l3OXc8lu8JtvHpPg3Pr2ekFVMF2uxWDKuZt4OepCvcDdJOkNQT7gA7oe+UyTPGRuCK
         iIGUjG9GRRF2SB3ur3R1i2tFCeKhrHbkF8iM87racM4IENyr5tM18FOajumzVuNOXEgq
         bQU/gaQxBBly+3bMZZHEs2dNOvVT/2GgXJAxZRo3R+1DuRb4UZ+UUvfY+S+WDrfg5Qv3
         7w3qMQBM30mqShXAL7OkL72Y2bSNeTx+Lmq70bXTo86T9BnB2UcNGFAN5NaZNb5H/s1B
         OQOB96qRDjOKvG6FgBY4Uvmth06QDeKi36Ccnig9Kd7zIyl4uLJrLDYkg0q0n+ssWWB+
         EF7g==
X-Forwarded-Encrypted: i=1; AJvYcCWoFHjcrROQyUqW32NilVida5vH4iwX0BI/R5qsHBfjhcBygpbudjIhI20ehEum86XkyKkwLKT1H8+h@vger.kernel.org, AJvYcCXKZBvzJns1XlzntxmmGm7CLsfcJAX+9TuyjOzgKrRPN4yVRQCyl93uNBh0/3BfB8EsnyK8ey9XFlL4Kmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhm47H8vTTZwbiZOWKwSzVvPfblL6OOKhWZVV5M63iKv4Eny3u
	H921CNQQPhV8cZuvpLP09Dy2wyYcpg7DnGrB4QG3cfYRTaClrAT3VuuLuQj5lTP1KPbphSrEJyx
	Uo42YI+NTWCNUUq14wXYdmhSczlw=
X-Google-Smtp-Source: AGHT+IHubsALN4arqMFkXvL7E4wE4F9DOhX/3Upd7LlP+LifbLve3RbIeXuRN3L7pfVC9Cf1AAVnLqFSu/whRTjMz1w=
X-Received: by 2002:a05:6870:459f:b0:277:e6bc:330c with SMTP id
 586e51a60fabf-2886dfff0cemr3216031fac.29.1728727481354; Sat, 12 Oct 2024
 03:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012050611.1908-1-linux.amoon@gmail.com> <20241012050611.1908-3-linux.amoon@gmail.com>
 <20241012061834.ksbtcaw3c7iacnye@thinkpad> <CANAwSgTk2ynkuxBarvX--Qs_LTduFuSDCv3k_WNgj=za_81+kQ@mail.gmail.com>
 <20241012080019.cdgq63rwj6oi4bg7@thinkpad>
In-Reply-To: <20241012080019.cdgq63rwj6oi4bg7@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 12 Oct 2024 15:34:25 +0530
Message-ID: <CANAwSgSCfM9TUe6j6OemyMbY_NsjLNgV=rCu9jXw7u_361bE+g@mail.gmail.com>
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

On Sat, 12 Oct 2024 at 13:30, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Oct 12, 2024 at 12:55:32PM +0530, Anand Moon wrote:
> > Hi Manivannan,
> >
> > Thanks for your review comments.
> >
> > On Sat, 12 Oct 2024 at 11:48, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Sat, Oct 12, 2024 at 10:36:04AM +0530, Anand Moon wrote:
> > > > Refactor the reset control handling in the Rockchip PCIe driver,
> > > > introducing a more robust and efficient method for assert and
> > > > deassert reset controller using reset_control_bulk*() API. Using th=
e
> > > > reset_control_bulk APIs, the reset handling for the core clocks res=
et
> > > > unit becomes much simpler.
> > > >
> > >
> > > Same comments as previous patch.
> > >
> > I will explain more about this.
> > > > Spilt the reset controller in two groups as pre the RK3399 TRM.
> > >
> > > *per
> > >
> > > Also please state the TRM name and section for reference.
> > >
> > Yes
> > > > After power up, the software driver should de-assert the reset of P=
CIe PHY,
> > > > then wait the PLL locked by polling the status, if PLL
> > > > has locked, then can de-assert the reset simultaneously
> > > > driver need to De-assert the reset pins simultionaly.
> > > >
> > > >   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> > > >
> > > > - replace devm_reset_control_get_exclusive() with
> > > >       devm_reset_control_bulk_get_exclusive().
> > > > - replace reset_control_assert with
> > > >       reset_control_bulk_assert().
> > > > - replace reset_control_deassert with
> > > >       reset_control_bulk_deassert().
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> > > >         with devm_reset_control_bulk_get_exclusive()
> > > >     update the functional changes.
> > > > V6: Add reason for the split of the RESET pins.
> > > > v5: Fix the De-assert reset core as per the TRM
> > > >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RES=
ET_N
> > > >     simultaneously.
> > > > v4: use dev_err_probe in error path.
> > > > v3: Fix typo in commit message, dropped reported by.
> > > > v2: Fix compilation error reported by Intel test robot
> > > >     fixed checkpatch warning.
> > > > ---
> > > >  drivers/pci/controller/pcie-rockchip.c | 151 +++++----------------=
----
> > > >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> > > >  2 files changed, 49 insertions(+), 128 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/c=
ontroller/pcie-rockchip.c
> > > > index 2777ef0cb599..9a118e2b8cbd 100644
> > > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > > +++ b/drivers/pci/controller/pcie-rockchip.c
>
> [...]
>
> > > > @@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockchip_p=
cie *rockchip)
> > > >        * Please don't reorder the deassert sequence of the followin=
g
> > > >        * four reset pins.
> > >
> > > I don't think my earlier comment on this addressed. Why are you chang=
ing the
> > > reset order? Why can't you have the resets in below (older) order?
> > >
> > > static const char * const rockchip_pci_core_rsts[] =3D {
> > >         mgmt-sticky",
> > >         "core",
> > >         "mgmt",
> > >         "pipe",
> > > };
> >  I will add a comment on this above.

I get your point, I missed your point.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/controller/pcie-rockchip.c?h=3Dv6.12-rc2#n275

Actually I had these changes, but it got missed out in rebase.

>
> Sorry, I don't get your response. My suggestion was to keep the resets so=
rted as
> the original order (also indicated by my above snippet).

I will go through all the suggestions and modify them accordingly.

As per the RK3399 TRM
[2] https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf

17.5.2.2 Reset Application
17.5.2.2.2 System Reset (describe all the core reset feature)
(name as per the dts mapping)
RESET_N: - core
MGMT_RESET_N:- mgmt
MGMT_STICKY_RESET_N:- mgmt-sticky
PIPE_RESET_N: - pipe
AXI_RESET_N - aclk
APB_RESET_N: pclk
PM_RESET_N: - pm
PCIE_PHY_RESET_N: - phy reset (used in the phy driver).

This is the reason for the split of the clk and core reset.

Further down in
17.5.8 PCIe Operation
17.5.8.1 PCIe Initialization Sequence
17.5.8.1.1 PCIe as Root Complex

6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
simultaneously

Should I follow this order ? or the above order.
static const char * const rockchip_pci_core_rsts[] =3D {
        "pipe",
        "mgmt-sticky",
         "mgmt",
         "core",
};

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks
-Anand

