Return-Path: <linux-pci+bounces-11797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB56956336
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 07:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EE4280D45
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 05:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3614AD2E;
	Mon, 19 Aug 2024 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pbNP/UWv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D742A8F
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045543; cv=none; b=p5IaOW7mCIFO8ojgivNRBOWOiUcu2IaI+EaNjZzY//2dN/2+53X033aM+YzXCcCLJ7pIpOMBB8AIBZVPkd0XYX4anITJX43avl30s8Mg/XH0Hm5XcCtUJRdCIobavhf73pQFGHLU13lGH9LGS4EOdTlPfCs9vjbeI+gHGtsTTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045543; c=relaxed/simple;
	bh=Yr2UJFtjMk51Pu9AFYzUDgjNMF0ekArNACfcgk2Anc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1cZz0YGfJMz2vO6qXQ6z0QNHpcRexo6+rFxpgkPoWljgiO9tns0RbQERDfAztLwkN9VDGF6y/9qjabrIbO45KhzpO4ol0j37yRlNLhTG9lE1fWDJjPIIK0+g6LtZTEE3LIk/gZVWbnfAGlwtwy2vbVGljtddvJaN+lWaZP1DNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pbNP/UWv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E9EA3F365
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724045530;
	bh=EXKeDjFAdMe+uEA7JaK4+hwIgSwG6+Aev5N69M36HiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pbNP/UWvYuEsS/U3QzenyIxViHy2V+rJ3727HYgMrs7U3BaSYwdqUU9uhjd7rlXMk
	 C+UsT8Nh+J7oKiNoT6hF0WecSiUrFJTjLU6NIV8w67+PFwaSDrnjCEpLvsf03Tfvai
	 xzXjxIUMyPYTPT9tB43zYRwo/MCyoFrjddtsnOprH6t3F522+MeKTmH4zeMAUvxDPz
	 xHT3sTJMd02XCp6j+7CVWE/VMySB4QRQkL02/3UHfG9dpMYHGeJXxeB/r/+0lw4VSf
	 T9E5muu5NL04RtCYgT7RUJHMbFfM4RVTraR50U3hKRiQnnxgaNKjXa2jkVQJ8gyGfO
	 rYp5EObKsxAHQ==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70d14709555so2983749b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 18 Aug 2024 22:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724045528; x=1724650328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXKeDjFAdMe+uEA7JaK4+hwIgSwG6+Aev5N69M36HiM=;
        b=rv3nIdnNz/PTeFzo9utQxrbVNs+1jztCNElVATxUAXA3Ss+R3ILZQpWV8/RLuAUBan
         QKoQliKOIifsMkIOtRy9CHeQzV6P948ULs20kE8ncdsMTYQiLuWo/WeZVDAKaTryiV+G
         f+bneOklgQBL5o8Lu/rg0FgrXWCcgLlaXqfTScoXw+dsZCDPZYUXfmpNwMOYTu7SdMhI
         pgmDendJh0KuqR0ylaVIZD7MosfFUg62hEtkIS/VzBt6ZVI4XMrcoEQ3UlVHek+PAROM
         PCm4HIfO6+S0IB13wIm8ef2ZxJBwUP6Mr62Z3/z1BRldcfywcugJJ7Tqii+5O1rrxZZ4
         335A==
X-Forwarded-Encrypted: i=1; AJvYcCWbWmblC3+L1+RKtoCsNRbYaCDsaM1hqpbOKJOmPvVS0YUBgV2Iyy5iTUG4Kb59+duqvFBe5cD9zlzSYcJc3du9t5qybzxC+HU5
X-Gm-Message-State: AOJu0YzL3gLsRGHs6H+vKtK3N019RENXHmiR+k+5zvflWHlQv4YXr63Z
	Hg24mU2oAFNflll+oWlmRN0A9n6ffTTEKyFThQvUK7Gf+NNE+ZiJFt3y7pVCwmMrwxMJtr9kX26
	GY7X5gi5at2gwyxiv348l076NBsMaf5R89woqzLWK/B0u7Wx0h6S78mJKPgwu0QhtnQDqgnQc7/
	+Ip+QMxvUwdgAh5Rm8PIVHR90PKSYt/mK98Z2zLUAnF+xWIYIkXIBt/M6w6z8=
X-Received: by 2002:a05:6300:4043:b0:1c6:a65f:299 with SMTP id adf61e73a8af0-1c904f90ef2mr8573474637.21.1724045528373;
        Sun, 18 Aug 2024 22:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfY1mtazXzvZPKZXXvEgIN+BPCkjkxzP+b9taeLr8aFfpOnp+saDdQQE2L5lAzaE36b0XelSvG/TaA3sAYPBU=
X-Received: by 2002:a05:6300:4043:b0:1c6:a65f:299 with SMTP id
 adf61e73a8af0-1c904f90ef2mr8573458637.21.1724045527922; Sun, 18 Aug 2024
 22:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530085227.91168-1-kai.heng.feng@canonical.com> <20240816222800.GA75500@bhelgaas>
In-Reply-To: <20240816222800.GA75500@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 19 Aug 2024 13:31:55 +0800
Message-ID: <CAAd53p7bdcJNH_XNNvSjon_=S_q-xaUBuctxXGabb7BKKh9eZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: ASPM: Allow OS to configure ASPM where BIOS is
 incapable of
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com, 
	david.e.box@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 6:28=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, May 30, 2024 at 04:52:26PM +0800, Kai-Heng Feng wrote:
> > Since commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM
> > and LTR"), ASPM is configured for NVMe devices enabled in VMD domain.
> >
> > However, that doesn't cover the case when FADT has ACPI_FADT_NO_ASPM
> > set.
> >
> > So add a new attribute to bypass aspm_disabled so OS can configure ASPM=
.
> >
> > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LT=
R")
> > Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83d=
d48@panix.com/
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 8 ++++++--
> >  include/linux/pci.h     | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index cee2365e54b8..e719605857b1 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1416,8 +1416,12 @@ static int __pci_enable_link_state(struct pci_de=
v *pdev, int state, bool locked)
> >        * the _OSC method), we can't honor that request.
> >        */
> >       if (aspm_disabled) {
> > -             pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have=
 ASPM control\n");
> > -             return -EPERM;
> > +             if (aspm_support_enabled && pdev->aspm_os_control)
> > +                     pci_info(pdev, "BIOS can't program ASPM, let OS c=
ontrol it\n");
> > +             else {
> > +                     pci_warn(pdev, "can't override BIOS ASPM; OS does=
n't have ASPM control\n");
> > +                     return -EPERM;
>
> 1) I dislike having this VMD-specific special case in the generic
> code.

This can be generalized to "FDAT doesn't want OS to touch ASPM but
exceptions should be made" like external PCIe devices connected via
Thunderbolt:
https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@ca=
nonical.com/

>
> 2) I think the "BIOS can't program ASPM ..." message is a little bit
> misleading.  We're making the assumption that BIOS doesn't know about
> devices below the VMD bridge, but we really don't know that.  BIOS
> *could* have a VMD driver, and it could configure ASPM below the VMD.
> We're just assuming that it doesn't.
>
> It's also a little bit too verbose -- I think we get this message for
> *every* device below VMD?  Maybe the vmd driver could print something
> about ignoring the ACPI FADT "PCIe ASPM Controls" bit once per VMD?
> Then it's clearly connected to something firmware folks know about.

Will do in next revision.

>
> 3) The code ends up looking like this:
>
>   if (aspm_disabled) {
>     if (aspm_support_enabled && pdev->aspm_os_control)
>       pci_info(pdev, "BIOS can't program ASPM, let OS control it\n");
>     else {
>       pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM cont=
rol\n");
>       return -EPERM;
>     }
>   }
>
> and I think it's confusing to check "aspm_support_enabled" and
> "pdev->aspm_os_control" after we've already decided that ASPM is
> sort of disabled by "aspm_disabled".
>
> Plus, we're left with questions about all the *other* tests of
> "aspm_disabled" in pcie_aspm_sanity_check(),
> pcie_aspm_pm_state_change(), pcie_aspm_powersave_config_link(),
> __pci_disable_link_state(), etc.  Why do they *not* need this change?

They all need similar change, yes.

>
> And what about pcie_aspm_init_link_state()?  Why doesn't *it* pay
> attention to "aspm_disabled"?  It's all very complicated.

It's already very complicated by aspm_disabled, aspm_force and
aspm_support_enabled.
We should define the relation between _OSC/FADT/driver/user override, etc.

Probably some helper functions to determine the ASPM status, instead
of checking aspm_disabled and aspm_support_enabled directly.

>
> This is similar in some ways to native_aer, native_pme, etc., which we
> negotiate with _OSC.  I wonder if we could make something similar for
> this, since it's another case where we want to make something specific
> to a host bridge instead of global.

I thinks it's possible by adding a new flag, but how should
pcie_aspm_init_link_state() check it? Adding a new parameter or find
the host bridge to check the new flag?

>
> > +             }
> >       }
> >
> >       if (!locked)
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index fb004fd4e889..58cbd4bea320 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -467,6 +467,7 @@ struct pci_dev {
> >       unsigned int    no_command_memory:1;    /* No PCI_COMMAND_MEMORY =
*/
> >       unsigned int    rom_bar_overlap:1;      /* ROM BAR disable broken=
 */
> >       unsigned int    rom_attr_enabled:1;     /* Display of ROM attribu=
te enabled? */
> > +     unsigned int    aspm_os_control:1;      /* Display of ROM attribu=
te enabled? */
>
> Comment is wrong (but I hope we can avoid a per-device bit anyway).

Will make it right in next revision.

Kai-Heng

>
> >       pci_dev_flags_t dev_flags;
> >       atomic_t        enable_cnt;     /* pci_enable_device has been cal=
led */
> >
> > --
> > 2.43.0
> >

