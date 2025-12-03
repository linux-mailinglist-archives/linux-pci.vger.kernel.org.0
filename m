Return-Path: <linux-pci+bounces-42582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2330CA1002
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8563334371A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F59344025;
	Wed,  3 Dec 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7sNdIYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E97342CB6
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782194; cv=none; b=YfuUgXQttn0u/1WBcMPeZTwXvhU944gtQQtQH/jICKwaGa7Ww67SuThAwgZAGdA6UtB8j45iCZn7iVCSScyKATNQKmo3B7mjhelExDm8o4yfM/yTqKViqi8Ggkr55UqQzgLn8TM7dl0jqgOIXPCXBGg+sfSuShIJ5MvKS4lpzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782194; c=relaxed/simple;
	bh=GABPF9uM9awnwSGZww/CBInHvTEdd7OS8Lwc0tz1fWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saU8hUMrKooGM67Sh6K/MXnJJCukyhAPw7mG6V9yjAdo3Xg+VlNQgNanmvJZ9otFucY3xxb42TFGopXkgtxUV11kJvJkCaOMG0MVr61i66fBnTU4WfAl+zRugXb1dt7rLKof2mt/lN9GtXK2JBGfxPXMYfSrobqMoX9HXgJ23Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7sNdIYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DE1C16AAE
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782192;
	bh=GABPF9uM9awnwSGZww/CBInHvTEdd7OS8Lwc0tz1fWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O7sNdIYBDJhyz9BUMG0kbpF1Tytho/CvEB8acAfneQRrU9I0UeiAzmrNEsvGg2Eux
	 6VuHFY6Xm4N285sCWrzJ5uZ6xGIOd0ttnRqqYAXOMptLYKq2DdJgE9sP9ka3SIZYlL
	 Kv+so0qMCGQ1qfa1Ni4QpeFwbTG0BS0+C0GTkR9DwnSf3PwalaKCdjssfKiRuvjRTX
	 0x+5578dvKrd+krf7xhxmIv8lLtRTftjmyyg2BYXFNYqptpuZ+tzf4e2s3YINJtSmM
	 IN8SWSyWF08+WJBwsIn6sIEIWBcrqr21/fF+h5CFKBIOUeoJTTeWOAd9MFPj6OAWNS
	 GZlh8H5ZarB9A==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-657490df6f3so2991827eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 09:16:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc1H44q240Aa0yCzepI4pGUXHDaRrXGDMDlM2zcN3QRqvJBmcSWfaTfPJxnPNUc9Tr9U44WmeGaxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKIvLOVmURDHmxJbICPnWHA7bVq+MPf8nQwpIUjANfrTY6frl
	r6kCIf5fToqWtHxLAaP6hhGi6Q6c5VJ5mBoDr8My3/y5UT4hip3m9laxXfZirX46nZuTB8sIOD3
	YKWEnkkrb1WSdzS3H9qFpqvGyI4Kt7jo=
X-Google-Smtp-Source: AGHT+IELzDMoGKProzV428aVzQuDwrzUVuMseHKtjskRr6F9qsAlU4ySsY1qydoQF1Vv0y9MO6Ut6IwxcpUi1krF978=
X-Received: by 2002:a05:6820:c09c:20b0:657:6746:cd0a with SMTP id
 006d021491bc7-65972797b3cmr1189060eaf.8.1764782191643; Wed, 03 Dec 2025
 09:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas> <aS9f-K_MN0uYUCYx@google.com>
 <aS_BYeSApI2XuPcD@wunner.de> <20251203142743.GD2580184@black.igk.intel.com>
 <E5E42CF4-7D6B-4081-AD59-CAC09FCB1890@exactco.de> <CAJZ5v0ighf93oi7peW7jRf4XsvBQe3ryLcnFqkL7aWN5TmBqsw@mail.gmail.com>
 <A6C6B078-16D7-4BBB-8E9C-3F599EADF84C@exactco.de>
In-Reply-To: <A6C6B078-16D7-4BBB-8E9C-3F599EADF84C@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Dec 2025 18:16:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jr9LQcnbS_VxwgRvSqb3ULwJZOcNYYCTMJ=t5GUrsjRg@mail.gmail.com>
X-Gm-Features: AWmQ_bk1cM3tHudr2cZmHoLFgPgjHwZ4MRJ65S5kF9E6BvvoFZdtL5oXcwC_cjw
Message-ID: <CAJZ5v0jr9LQcnbS_VxwgRvSqb3ULwJZOcNYYCTMJ=t5GUrsjRg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC systems
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Brian Norris <briannorris@chromium.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Riccardo Mottola <riccardo.mottola@libero.it>, Manivannan Sadhasivam <mani@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:26=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wro=
te:
>
> Hi,
>
> > On 3. Dec 2025, at 16:22, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Dec 3, 2025 at 3:48=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de>=
 wrote:
> >>
> >> Hi,
> >>
> >>> On 3. Dec 2025, at 15:27, Mika Westerberg <mika.westerberg@linux.inte=
l.com> wrote:
> >>
> >> =E2=80=A6
> >>
> >>>> A Thunderbolt controller exposes a PCIe switch.  Daisy-chained
> >>>> Thunderbolt devices are thus visible to the OS as nested switches.
> >>>> If we followed the approach you're suggesting, users would have to
> >>>> manually allow runtime PM on every Switch Upstream and Downstream Po=
rt
> >>>> as well as the Root Port and they'd have to do that upon hotplugging
> >>>> a device.  Yes, yes, users could add a udev rule to allow runtime PM
> >>>> automatically by default, but that's exactly the policy we have hard=
coded
> >>>> in the kernel right now, so why the change?
> >>>>
> >>>> I expect massive power regressions for users (not least Chromebook
> >>>> users) if we made that change.
> >>>>
> >>>> The discrete Thunderbolt controller in my machine consumes 1.5W
> >>>> when nothing is attached.  Some laptops have multiple of these.
> >>>> Recent CPUs with integrated Thunderbolt/USB4 may fail to transition
> >>>> the package to a low power state unless the Thunderbolt ports go
> >>>> to D3hot.
> >>>>
> >>>> So I don't think this approach is a viable option.
> >>>
> >>> I agree.  If this is limited to some older RISC machines (based on th=
e
> >>> $subject) perhaps this could be solved by adding udev rules to block
> >>> runtime PM on those certain ports?
> >>
> >> Let=E2=80=99s not overcomplicate it for now. All we have are a couple =
of old Unix
> >> RISC workstations. Let=E2=80=99s see if we can somehow fix them for re=
al first.
> >>
> >> Given the feedback that D3Hot =E2=80=9Cshould=E2=80=9D more often work=
 I went ahead
> >> and changed the patch in T2/Linux removing the 2015 check and all arch
> >> except SPARC and let our prosumer enthusiast users find out if somethi=
ng
> >> else breaks first to gather more data points.
> >>
> >> I=E2=80=99ll try to find time to debug the SPARC64 Sun Blade 1K issue,=
 but I have
> >> some other TODO first, so it might be January for more work on that.
> >>
> >> Maybe we should push a patch to only disable this for SPARC64 to stabl=
e
> >> In the meantime?
> >>
> >> https://svn.exactcode.de/t2/trunk/package/kernel/linux/hotfix-legacy-p=
ci-bridge-d3.patch
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 2b53219fda3b..869d204a70a3 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3067,10 +3067,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bri=
dge)
> >>                        return false;
> >>
> >>                /*
> >> -                * Out of caution, we only allow PCIe ports from 2015 =
or newer
> >> -                * into D3 on x86.
> >> +                * It should be safe to put PCIe ports to D3.
> >>                 */
> >> -               if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=
=3D 2015)
> >> +               if (!IS_ENABLED(CONFIG_SPARC64))
> >>                        return true;
> >>                break;
> >>        }
> >
> > I would prefer
> >
> > if ((IS_ENABLED(CONFIG_X86) && dmi_get_bios_year() >=3D 2015) ||
> > !IS_ENABLED(CONFIG_SPARC64))
> >         return true;
>
> Sorry for any confusion, I did not mean the above for upstream, but as I
> tried to express for us downstream in T2 to gather more data (if any) fro=
m
> our users for for pre 2015 x86 machines.
>
> Should I send your proposal which matches mine for stable in the
> meantime?

Yes, you can do this, as far as I'm concerned.

