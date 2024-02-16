Return-Path: <linux-pci+bounces-3564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0068C8573F2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7171F21F44
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 03:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B065F9EA;
	Fri, 16 Feb 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ixUUyNJH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944BDF46
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708053274; cv=none; b=jLuRXF6vzka+AqxoKigYydDEYxNWu+A/+mDVEjOazpkKfYHUzoJyzRxBvZzODYMlptG8GRxZgqczBk/Gn03Fwb+0L4LiaFmBR4vbajB2JVxPBVZ9lDX+bE39gKhokJbJgNKrZoh2Il5phgm0OWcndxcO8dRRW+/YfPMITxa1cVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708053274; c=relaxed/simple;
	bh=hk3STr7C7Sk9+wORjcSTxGk/XLqJkgiovyKOpFhJrUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZAur6VpB8D069U3qZbWK3v8wLD5vu0lDCuBX4bmN2MacDgVXg2UzNP5kLw3rXyDbYvNDlBbrjq00U/hXJcpmWOCeL0nCfSv4xyXDddy65NXO0uxyx7dW188Pv9Krhoz2wO9obz6iehuQpGuu5jCyGsnGBftrlyy7jCBYjPbiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ixUUyNJH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607e364c985so10860597b3.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 19:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708053270; x=1708658070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRN9SmDVkhI7MAu3bWHmiNzl3O+9LQAPcK5JZYt2520=;
        b=ixUUyNJHSBmSBxFYHzZTfwiM+Gmx/79tLyM6uGOdm3a4Vrn9ec2w9No8wJC3F5LT1y
         9pDgZwP++BSCVuMGA1dkZcTAA3kzaBE6oVb4mSFGgvHrH3IvqKNQR2k0pLBBfmmYQSzo
         ZJM5JIdXoneZAHA14CGgkr2hX7L3VVdekz40McY+zqlFK6LUO512YOWY2P1efz+f++P/
         m0s+ZpotHYuBZ0q578whpkisdJXHMDy8mfA/MYoZL/4+Ln+GcKDkdv9BMZj6uhdgi/fQ
         Kf7JB0wTB4XT8k1q1TS4jvKYRq6An1NF6k02aVOdYC4bMlSgcNwYWIAYDWXrvudBzndr
         wsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708053270; x=1708658070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRN9SmDVkhI7MAu3bWHmiNzl3O+9LQAPcK5JZYt2520=;
        b=qQ3lrz/A0HSWsK+ubAoE3uO/6HfkLfhR7IjjbG/A3mAM2wDGqiXWaANUsY+O+Y3dcP
         04uLq9gRFQLvkEck8cJBTkZl0CfqNMo12+8es9mRZSfA4NceryYPyG74X+hJ9H58GIoz
         lVwTMyivI+RtDU6BEofnFwXweB+cvxPqzYrE2UVhG6oMNKqcP9rHx8wEdj1Bjc5oWtKD
         WudeLousRnGae8OJUb66Oziaqmqv2wCqnH9irmiG4OHxsaTx3aVZ8XYuwXs3Yasm1ZSa
         O4IHK63cI6aGMhBY+tMUPg+JQSjzha8FKs26y3zwdgLLyPizGvZAdcULLCBhJ+WnR6CR
         bbJA==
X-Forwarded-Encrypted: i=1; AJvYcCXzevFYxsvjM0KY6sAw0N0Y1xFODNbM8RktiHFFDdXq5XRXp00DbWcx7d4ZQePWGlA3gR/tCp2/X71huNMpDZhbov5JPF5UAJxO
X-Gm-Message-State: AOJu0YzIuyS4v8e+szqiEwfSVUOF6ZhatBV/NA8/KAPPS5N10dbs6BV2
	moHbsUdb0WBUf4tcHfUTE3HMrEJFtirBVjwvZKGf5WNoinWLBZSmYdcG1csD1XG2qgUJn/mGzR9
	Nc8wf36n5Tq1mKOKAvWwkKcm+xmJhC10l3jOPrg==
X-Google-Smtp-Source: AGHT+IES1LLzq7c3lBUFH3NSLQEDlTWVp4rYhFtTKHHRrpjtw81gWoMvXC0yI1h0RuRuw16pt5EY/78gXwVURqK7Iss=
X-Received: by 2002:a0d:cbd0:0:b0:607:a98c:81a1 with SMTP id
 n199-20020a0dcbd0000000b00607a98c81a1mr3633313ywd.28.1708053270014; Thu, 15
 Feb 2024 19:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207111854.576402-2-jhp@endlessos.org> <0e7944d410664153b506ea584d92cd6bb0a93f6a.camel@linux.intel.com>
In-Reply-To: <0e7944d410664153b506ea584d92cd6bb0a93f6a.camel@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 16 Feb 2024 11:13:54 +0800
Message-ID: <CAPpJ_edMhGY+4ULvhV0r5TLZ_QyLCNRewTVHdQcjCv--Qa4X+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI/ASPM: Fix L1SS parameters & only enable
 supported features when enable link state
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B42=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:02=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Wed, 2024-02-07 at 19:18 +0800, Jian-Hong Pan wrote:
> > The original __pci_enable_link_state() configs the links directly witho=
ut:
> > * Check the L1 substates features which are supported, or not
> > * Calculate & program related parameters for L1.2, such as T_POWER_ON,
> >   Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD
> >
> > This leads some supported L1 PM substates of the link between VMD remap=
ped
> > PCIe Root Port and NVMe get wrong configs when a caller tries to enable=
d
> > them.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> >
> > Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+
> >                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D1=
0us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >         L1SubCtl2: T_PwrOn=3D10us
> >
> > This patch initializes the link's L1 PM substates to get the supported
> > features and programs relating paramters, if some of them are going to =
be
> > enabled in __pci_enable_link_state(). Then, enables the L1 PM substates=
 if
> > the caller intends to enable them and they are supported.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v2:
> > - Prepare the PCIe LTR parameters before enable L1 Substates
> >
> > v3:
> > - Only enable supported features for the L1 Substates part
> >
> >  drivers/pci/pcie/aspm.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a39d2ee744cb..c866971cae70 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1389,14 +1389,16 @@ static int __pci_enable_link_state(struct pci_d=
ev
> > *pdev, int state, bool locked)
> >                 link->aspm_default |=3D ASPM_STATE_L0S;
> >         if (state & PCIE_LINK_STATE_L1)
> >                 link->aspm_default |=3D ASPM_STATE_L1;
> > -       /* L1 PM substates require L1 */
> > -       if (state & PCIE_LINK_STATE_L1_1)
> > +       if (state & ASPM_STATE_L1_2_MASK)
> > +               aspm_l1ss_init(link);
>
> This mixes ASPM_STATE flags with PCIE_LINK_STATE register mapping. This m=
ay work
> but I don't know if it's intended to. Rather do,
>
>     if (link->default & ASPM_STATE_L1_2_MASK)
>
> after collecting all of the states to be enabled.
>
> I understand that you are calling aspm_l1ss_init() to do the L1.2 calcula=
tions
> but it does more than this that you don't need. Maybe it would be more
> appropriate to call aspm_calc_l12_info() directly through an additional f=
unction
> that finds the parent and determines both ends of the link support L1SS.

After think & check twice, focusing on fixing the L1.2 parameters makes sen=
se.

I am preparing a new patch.  Thanks!

Jian-Hong Pan

> > +       /* L1 PM substates require L1 and should be in supported list *=
/
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_1)
> >                 link->aspm_default |=3D ASPM_STATE_L1_1 | ASPM_STATE_L1=
;
> > -       if (state & PCIE_LINK_STATE_L1_2)
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_2)
> >                 link->aspm_default |=3D ASPM_STATE_L1_2 | ASPM_STATE_L1=
;
> > -       if (state & PCIE_LINK_STATE_L1_1_PCIPM)
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_1_PCIPM)
> >                 link->aspm_default |=3D ASPM_STATE_L1_1_PCIPM | ASPM_ST=
ATE_L1;
> > -       if (state & PCIE_LINK_STATE_L1_2_PCIPM)
> > +       if (state & link->aspm_support & PCIE_LINK_STATE_L1_2_PCIPM)
> >                 link->aspm_default |=3D ASPM_STATE_L1_2_PCIPM | ASPM_ST=
ATE_L1;
> >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >
>
> I don't think these changes are necessary. pcie_config_aspm_link() alread=
y
> checks link->aspm_capable which was initialized from link->aspm_support.
>
> David

