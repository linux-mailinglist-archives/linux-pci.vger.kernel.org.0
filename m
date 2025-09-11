Return-Path: <linux-pci+bounces-35909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59981B533BD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90A2161CE6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88F31DDAB;
	Thu, 11 Sep 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbtUKVwz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6E31B131;
	Thu, 11 Sep 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597304; cv=none; b=MOCW6XHfJhbI/9faNcIIlQUb5Eh8TRdyqW6ULlyciGONDD6NRhGRC9ahXjgfC4EG37WO7Pzh47bdq5DV2RFm3to2Dqc4waJw6FU3uWUf78VpM7vW9uwSfyWiEA01g64ceVSa8muqy9gmHeJuNFq5tgan1jJlXLMvyeCQk4I+x1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597304; c=relaxed/simple;
	bh=fPx85/aFDzwCcwCyQ19LWpNCSSA1hJtvXfkEByr6oQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6XiEiE3QRqHVtla8QuvXUpcQoIMoJW3v673VUltIfQqNsys8jGSNjFp48TktLi9OuCHYnqgKWUyvRIP6yEqpMoVqGVCtF5y2OJ5jAEwMNbJM5/e/6Ins9RgPvOkr71iMqMwNDqBftDjM2dgw2/d/cw4VGtXoiLy2ip72e2Oafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbtUKVwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78605C4CEFE;
	Thu, 11 Sep 2025 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757597303;
	bh=fPx85/aFDzwCcwCyQ19LWpNCSSA1hJtvXfkEByr6oQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IbtUKVwzkN+yXjhG1Z+s1VkgSlaWG6PP5PA56WXrL5hZWuKNQ3JmiGO2HW2q8zMgj
	 0TVIKlu1IhX6ZxyxZs0/j9f/dR9VQOP+Hej0y1t1Z0IFBbc1lILO/3yASxXD5dcLTp
	 7Or2lQgKST1SsD48xb7Li38rKEk5/UjTFBQc/+cYTiQoj7TxbfEohVy0ZQ4YkrYQUi
	 lck9Q6c5ZF5FnWxeTTr+FRUwWCdvkhVK5nwK6Nkb6fckXFuJumL6xtDvg1X4hSn1Rv
	 bK+KIZ6L+oQiJRJZUWAftD7BCPGGHGbSb82SU0inoEHo2w4uFtpoVchUc1geJ0w529
	 eeICI3xWjfFqA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-439aeec33e1so891420b6e.0;
        Thu, 11 Sep 2025 06:28:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQjv/pY5niArXQbdplEbmH7+Cl9R9B0LeVriadXYrSkoK64q1k+pFBEt2Saui0OmmIFoyCZ7HhwS8=@vger.kernel.org, AJvYcCUdqsB4yTEOzJ+01uyPihjUduMPMlSCrbGfs/wvw7yNPbmI6vE8N+CgfpYacVPXnEO0Kx4Xiqk5nH/2@vger.kernel.org, AJvYcCWzNn15XTWst25Uk/M+eXVfFdbKYg3v4/2D/mM7OP4qbEwDwTJ+ETlKRFwr93xjJ00M4skECduKnSKHgAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLF//neYvLfg1uUrPgzFdz/Gqia7k2PrTHgWm1ad9PVsVwD8S
	/STjPSPAMscLbuQq7Js6cgcL0cU5eQlhN7dor2bykChNlky43dD80EyiA15v5NSP4mOFv+ak4Gb
	BIrFAAQEeytXWW3IsdeLdp4iYNEBGas8=
X-Google-Smtp-Source: AGHT+IEpHkNINAHftZkyD8MVlHBbKqRlu2LS5AS5u62lCuSqF/OfeH8D8tAq6knhyYgHdZGhu7s787JohFi1YynsF6I=
X-Received: by 2002:a05:6808:158d:b0:438:37ee:345f with SMTP id
 5614622812f47-43b7bbdf2d2mr1356515b6e.18.1757597302640; Thu, 11 Sep 2025
 06:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
In-Reply-To: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 15:28:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQsYzudLGbbyhsBbBUwv9c5uQZpUCBCOcOTG=-vPiVgw@mail.gmail.com>
X-Gm-Features: Ac12FXyDJB6aHtPW3aLRKsVD42emm2RndwMlC49HoA75vNU6Jcai7ZXgdbP8UiM
Message-ID: <CAJZ5v0iQsYzudLGbbyhsBbBUwv9c5uQZpUCBCOcOTG=-vPiVgw@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Mario Limonciello <superm1@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Timo Jyrinki <timo.jyrinki@iki.fi>, Ernst Persson <ernstp@gmail.com>, Steven Harms <sjharms@gmail.com>, 
	James Ettle <james@ettle.org.uk>, Nick Coghlan <ncoghlan@gmail.com>, Weng Xuetian <wengxt@gmail.com>, 
	Andrey Rahmatullin <wrar@wrar.name>, Boris Barbour <boris.barbour@ens.fr>, 
	Vlastimil Zima <vlastimil.zima@gmail.com>, David Banks <amoebae@gmail.com>, 
	Michal Jaegermann <michal@harddata.com>, Chris Moeller <kode54@gmail.com>, Daniel Fraga <fragabr@gmail.com>, 
	Javier Marcet <jmarcet@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:12=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> In 2012, commit dbf0e4c7257f ("PCI: EHCI: fix crash during suspend on ASU=
S
> computers") amended pci_pm_suspend_noirq() to work around a BIOS issue by
> clearing the Command register if the suspended device is a USB EHCI host
> controller.
>
> Commit 0b68c8e2c3af ("PCI: EHCI: Fix crash during hibernation on ASUS
> computers") subsequently amended pci_pm_poweroff_noirq() to do the same.
>
> Two years later, commit 7d2a01b87f16 ("PCI: Add pci_fixup_suspend_late
> quirk pass") introduced the ability to execute arbitrary quirks
> specifically in pci_pm_suspend_noirq() and pci_pm_poweroff_noirq().
>
> This allows moving the ASUS workaround out of generic code and into a
> proper quirk to improve maintainability and readability.  Constrain to x8=
6
> since the ASUS BIOS doesn't seem to have been used on other arches.
>
> lspci output of affected EHCI host controllers reveals that the only bits
> set in the Command register are Memory Space Enable and Bus Master Enable=
:
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D658778
>
> The latter is cleared by:
>   hcd_pci_suspend()
>     suspend_common()
>       pci_disable_device()
>
> pci_disable_device() does not clear I/O and Memory Space Enable, although
> its name suggests otherwise.  The kernel has never disabled these bits
> once they're enabled.  Doing so would avoid the need for the quirk, but i=
t
> is unclear what will break if this fundamental behavior is changed.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  arch/x86/pci/fixup.c     | 19 +++++++++++++++++++
>  drivers/pci/pci-driver.c | 19 -------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index e7e71490bd25..c34ff72434f2 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1041,3 +1041,22 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev=
)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
>  #endif /* CONFIG_SUSPEND */
> +
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's Com=
mand
> + * register is not 0 on suspend, the BIOS assumes that the controller ha=
s not
> + * been quiesced and tries to turn it off.  If the controller is already=
 in D3,
> + * this can hang or cause memory corruption.
> + *
> + * Since the value of the Command register does not matter once the devi=
ce has
> + * been suspended, it can safely be set to 0.
> + */
> +static void quirk_clear_command_reg(struct pci_dev *pdev)
> +{
> +       pci_write_config_word(pdev, PCI_COMMAND, 0);
> +}
> +DECLARE_PCI_FIXUP_CLASS_SUSPEND_LATE(PCI_ANY_ID, PCI_ANY_ID,
> +                                    PCI_CLASS_SERIAL_USB_EHCI, 0,
> +                                    quirk_clear_command_reg);
> +#endif /* CONFIG_PM_SLEEP */
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 63665240ae87..e1089dfeb419 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -914,18 +914,6 @@ static int pci_pm_suspend_noirq(struct device *dev)
>
>         pci_pm_set_unknown_state(pci_dev);
>
> -       /*
> -        * Some BIOSes from ASUS have a bug: If a USB EHCI host controlle=
r's
> -        * PCI COMMAND register isn't 0, the BIOS assumes that the contro=
ller
> -        * hasn't been quiesced and tries to turn it off.  If the control=
ler
> -        * is already in D3, this can hang or cause memory corruption.
> -        *
> -        * Since the value of the COMMAND register doesn't matter once th=
e
> -        * device has been suspended, we can safely set it to 0 here.
> -        */
> -       if (pci_dev->class =3D=3D PCI_CLASS_SERIAL_USB_EHCI)
> -               pci_write_config_word(pci_dev, PCI_COMMAND, 0);
> -
>  Fixup:
>         pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>
> @@ -1205,13 +1193,6 @@ static int pci_pm_poweroff_noirq(struct device *de=
v)
>         if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
>                 pci_prepare_to_sleep(pci_dev);
>
> -       /*
> -        * The reason for doing this here is the same as for the analogou=
s code
> -        * in pci_pm_suspend_noirq().
> -        */
> -       if (pci_dev->class =3D=3D PCI_CLASS_SERIAL_USB_EHCI)
> -               pci_write_config_word(pci_dev, PCI_COMMAND, 0);
> -
>         pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>
>         return 0;
> --
> 2.51.0
>

