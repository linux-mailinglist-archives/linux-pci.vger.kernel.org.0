Return-Path: <linux-pci+bounces-18050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217339EBA77
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 20:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065861888FFD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DC22ACF8;
	Tue, 10 Dec 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHRwmL5K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6C22A1FB;
	Tue, 10 Dec 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860589; cv=none; b=jo9O2rf80ZcfdIk/1yrw/wz+pjSyToUb1V0uT2y5/xkQVqtMngsQ4/bd/PUopoupCUvlEqcxkb6O3wzlOXDQIrrOKpoWE7JzBq05b+tpz/0kM2GXRA5feQAKLYEPzf2ofTqDu9/LPmOaK83kAcx2VwhhigTsEFxgiHMHK12YoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860589; c=relaxed/simple;
	bh=TN49SkV3Q2NAbIusEHwgWMfJZk5D1+79QAs+gi2Q9W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7cil74vOqTiSGH+tc+qfW6aOW3Ui0ZpSA048IBk5u2m2pwBVJnUz0poXZtX02AKhk2eWjvmn9KG3I8acLVC3Im1ey0EoJHfilifbDbyLB5PAEzsDCR9KEn/9ab8ZB8MHhEOZoi+fGesHHW/elQ5CT3sGEqnHsTCxsbakzjDdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHRwmL5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD499C4CEE2;
	Tue, 10 Dec 2024 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733860586;
	bh=TN49SkV3Q2NAbIusEHwgWMfJZk5D1+79QAs+gi2Q9W4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHRwmL5Khwz8NewLBLZtrHTh8I8BnZ5O15622gsAM/SNmaDa58QBlXDUwvUvXelsi
	 eZ8TCFYFGjMz5OWH8R7nnX/X00bJGlb17lNAqRvBBQqf0ox+Zrfil6IYg2DJH/GlnW
	 qci6SUZa1xYUj2aZz0TEoE6vnMIWYtMKii3eSbG0yt+3uflbxDKRjD5cnPCNyaqLRO
	 bxSV9ivk3BnOk0XiDKY2Evk/LOUM2zh5OtFKKq8gBnqAG/Tx4YTK/EzgSNFmkihc3W
	 Go49hJoRogJTHU8bEM0tNozQ77HCq38Rj9fF/kDI5+5sowY9VGdHfLYH4bhJ1EbZJN
	 /svSesQhsg7Kw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e1728c307so137662a34.2;
        Tue, 10 Dec 2024 11:56:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6WpLaVkY/t3Cya0X0MrBYlAVrDBXA1/dbnqLg3IGA/sd/T+QkiEUr+YuB0ifSgckmmCPPixP5TPdO@vger.kernel.org, AJvYcCW6zNuai8tQQywyrs9uYqYgbMBImG0XAgb52BHVT9xHvgo5NHpHC5ha8mxUJ1Zh9HG1EABwe0dRi0f4z28l@vger.kernel.org, AJvYcCXlnVNJCc7VygTx5WohLMlL2TzQ9sITI6PMC1dVLHmeNeMyC3JS0Nzmk3XRHMUNDl52F1tSeUmb8gAi@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZZ40jgeC5WkXR/nBA0H48xjpAIB5uKTAniW/7M3np4LR1gKE
	MuaADDfWMD+vjDIlSm01C7FVkFIfs6zulXw15/0Dy9QFsu+7c6b2r16Mv1QFkE2a2UbrsiOlDYB
	+3RCEtoF/2wSx6DFxWCaJyvgfQ/E=
X-Google-Smtp-Source: AGHT+IF58PAttsbbmJ/Rov0YEMNJsP/Y44yag8OUwwhu58IcZU7Aq2+zXt+OkF2Mesyw9I+Sfy+BL43vDIgAJ01JPbM=
X-Received: by 2002:a05:6830:6c10:b0:71d:5084:3223 with SMTP id
 46e09a7af769-71e197dee93mr81708a34.15.1733860586092; Tue, 10 Dec 2024
 11:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114030424.45074-1-zhoushengqing@ttyinfo.com> <20241210195001.GA3254053@bhelgaas>
In-Reply-To: <20241210195001.GA3254053@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 20:56:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g66WmqeouN6AWADE+J3e-f30wMGyLX-Upk+w7Y+i2OxA@mail.gmail.com>
Message-ID: <CAJZ5v0g66WmqeouN6AWADE+J3e-f30wMGyLX-Upk+w7Y+i2OxA@mail.gmail.com>
Subject: Re: [PATCHv2] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id
 doesn't match with spec.
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Zhou Shengqing <zhoushengqing@ttyinfo.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 8:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Ben, original author of a78cf9657ba5]
>
> On Thu, Nov 14, 2024 at 03:04:24AM +0000, Zhou Shengqing wrote:
> > Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> > for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
> > the code is 1.
>
> This _DSM function 5 was added in PCI Firmware r3.1, released Dec 13,
> 2010.  It's listed in sec 4.6 with Revision 2 (as *all* the defined
> functions are, even functions 1-4, which were included in r3.0 with
> Revision 1).
>
> But the actual definition that was added in r3.1 is in sec 4.6.5,
> which specifies Revision ID 1.
>
> PCI Firmware r3.2, released Jan 26, 2015, was the newest available at
> the time Ben implemented a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot
> Configuration _DSM"), and sec 4.6.5 still specified Revision ID 1.
>
> So I think Ben's addition used the correct Revision ID (1).
>
> PCI Firmware r3.3, released Jan 20, 2021, changed sec 4.6.5 to say
> "lowest valid Revision ID value: 2"
>
> I think it's a mistake to make the kernel change below because
> platforms in the field implemented function 5 with revision 1 (per the
> r3.1 and r3.2 specs), and we have no idea whether they implement
> function 5 revision 2.
>
> It's quite likely that newer platforms following r3.3 will implement
> function 5 revision 2, but NOT revision 1, and the existing code won't
> work for them.
>
> I think the fix is to try revision 1 and, if that isn't implemented,
> we should try revision 2.  The semantics stayed the same, so they
> should both work the same.

Or call Function 0 with the new revision and check the result?

> > Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to=
 pci_register_host_bridge()")
> > Origin fixes: a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot Configuration =
_DSM")
> >
> > Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> > ---
> >  drivers/pci/pci-acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index af370628e583..7a4cad0c1f00 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -132,7 +132,7 @@ bool pci_acpi_preserve_config(struct pci_host_bridg=
e *host_bridge)
> >                */
> >               obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge-=
>dev),
> >                                             &pci_acpi_dsm_guid,
> > -                                           1, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
> > +                                           2, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
> >                                             NULL, ACPI_TYPE_INTEGER);
> >               if (obj && obj->integer.value =3D=3D 0)
> >                       return true;
> > --
> > 2.39.2
> >

