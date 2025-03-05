Return-Path: <linux-pci+bounces-22968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D7A500C0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20DF3A2370
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0DB248890;
	Wed,  5 Mar 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWvcVARn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA023372D;
	Wed,  5 Mar 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182099; cv=none; b=GpbcBenAylEbm7kYN/39bTtx2mk1H0UJqXOQzaT6/j+rFnAt8l49CCs7RB10fwjKGqy2caT1Y2EaRxh7M6WSTfbSu+8oU+sMX0A28Zvql5WaOxal7HcBtrTwZQLcBdDzFgtZ32uLMLIHCzFyVQ/n/aZ3aCpaMXSK7ecYE+gCJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182099; c=relaxed/simple;
	bh=PO4Jsj4JkP9gtVNS500UraGCc0IXgiDkg5KwFz7FGp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBMmruQ+pP1EFNkS9AtmaqKrSq9SckmEKBbxKPnN/Lj7UzUYLGDY4KnyjHWMWga9I03qb3/oTcGJfYS9HOEcL0mNYB/9HqFnx7GeXN6mnT53/bLqNfcEUV1FvJgPhA/LZA00kzrb1LzqpPrgagq43VXrKc94WUZfTvDdgxyACCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWvcVARn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D975C4CEEB;
	Wed,  5 Mar 2025 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741182098;
	bh=PO4Jsj4JkP9gtVNS500UraGCc0IXgiDkg5KwFz7FGp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aWvcVARnA7fd8YWUBmT1HN8/fVMwWIkoCf3Q+QiRDKokF0+N5OBdbpD29PJHk/zkt
	 Qfc5nroy/v48smGrRV68B7TDubZ6yba9xnMgfJtuqWImlkewSGNS5iEPGN7vQO/E4c
	 rsHA/BFQFMu0/jbtYOJEpPaKeNGgWB5tezft2yePbf40aqmbrMdIKhOgBq5yJP6lTu
	 999KHoBm3lNxsnsLcfuGSUDREmqcxOBq4TDAn+zakH54MpPpBguwlg4ADZ4XQETc+Z
	 hNJoBH9snv4sgDSeBfBg3FqQo2cRcnLqkH/q1Ml5A7PzHEel+2iOI3Rd9Vdn3nptLz
	 R8JJXx12MiVzg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fc6fe05460so3881077eaf.1;
        Wed, 05 Mar 2025 05:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPbl/Ynz3ZR4Nnok4C+mDSk1P2/8YL0qvNyjy6+FK80MKMONMsBm0XQmWl8uT9uO9WjH/AdqqTWMYnaJmk@vger.kernel.org, AJvYcCW32u10CLLLpaXfuZzM2L+ojcEX7nH7VBqX3+8PIHJm9JAtC6eexKMfQ/z+R+6oeg/7/xO8s7zhmpXH@vger.kernel.org, AJvYcCXbRq1dxpAR1GcpGQN7PxKrWm8YdGrPEbxpMPb4VjTadLkBxsaL+4VpN9o9C0paONQObHEnWrft22W/@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8VYOPXeQrBy7iRKSZS5EybgiiQJxuk4wpwlXNQacc0QbyrH7
	t69cP7XjHQTmdP3s1EYjpaA8aed1clfugbUDHUWEpeJetnuthpJoy67ewzO1QlJcBN9gtivaoG9
	ZakvIN5s4HXKcFug2sPfeJv9Q7kg=
X-Google-Smtp-Source: AGHT+IGPcCMLMQ2WrDCUyi/KjmpInyphx17IJnhTjXeEgLDqgtxF59DgweVVnVJ78q+UA0HlQWD5DVuGCMM18IdLS1g=
X-Received: by 2002:a05:6820:1b1a:b0:5fc:b7f4:c013 with SMTP id
 006d021491bc7-6003358e57dmr1360365eaf.5.1741182097752; Wed, 05 Mar 2025
 05:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas> <Z8IC_WDmix3YjOkv@google.com>
In-Reply-To: <Z8IC_WDmix3YjOkv@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Mar 2025 14:41:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>
X-Gm-Features: AQ5f1JppUE7nECQCq6b9InHWQuU6lOpah0GYGxjTM0WTAGA_910spDA_NjX67D8
Message-ID: <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 7:40=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Hi Bjorn,
>
> On Fri, Feb 28, 2025 at 11:45:09AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > Unlike ACPI based platforms, there are no known issues with D3Hot for
> > > the PCI bridges in Device Tree based platforms.
> >
> > Can we elaborate on this a little bit?  Referring to "known issues
> > with ACPI-based platforms" depends on a lot of domain-specific history
> > that most readers (including me) don't know.
>
> Well, to me, the background here is simply the surrounding code context,
> and the past discussions that I linked:
>
> https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/
>
> The whole reason we need this patch is that:
> (a) there's some vaguely specified reason this function (which prevents
>     standard-specified behavior) exists; and
> (b) that function includes a condition that allows all systems with a
>     DMI/BIOS newer than year 2015 to use this feature.
>
> Digging a bit further, it seems like maybe the only reason this feature
> is prevented on DT systems is from commit ("9d26d3a8f1b0 PCI: Put PCIe
> ports into D3 during suspend"), where the subtext is that it was written
> by and for Intel in 2016, with an arbitrary time-based cutoff ("year
> this was being developed") that only works for DMI systems. DT systems
> do not tend to support DMI.
>
> If any of this is what you're looking for, I can try to
> copy/paste/summarize a few more of those bits, if it helps.
>
> > I don't think "ACPI-based" or "devicetree-based" are good
> > justifications for changing the behavior because they don't identify
> > any specific reasons.  It's like saying "we can enable this feature
> > because the platform spec is written in French."
>
> AIUI, It's involved because of the general strategy of this function
> (per its comments, "recent enough PCIe ports"). So far, it sounds like
> that reason (presumably, old BIOS with poor power management code)
> doesn't really apply to a system based on device tree, where the power
> management code is mostly/entirely in the OS.

No, it was about PCIe hardware failing to handle PM correctly on ports.

> But really, the original commit doesn't actually state reasons, so maybe
> the "known issues" phrasing could be weakened a bit, to avoid implying
> there were any stated reasons.

There were hardware issues related to PM on x86 platforms predating
the introduction of Connected Standby in Windows.  For instance,
programming a port into D3hot by writing to its PMCSR might cause the
PCIe link behind it to go down and the only way to revive it was to
power cycle the Root Complex.  And similar.

Also, PM has never really worked correctly on PCI (non-PCIe) bridges
and there is this case where the platform firmware handles hotplug and
doesn't want the OS to get in the way (the bridge->is_hotplug_bridge
&& !pciehp_is_native(bridge) check in pci_bridge_d3_possible()).

The DMI check at the end of pci_bridge_d3_possible() is really
something to the effect of "there is no particular reason to prevent
this bridge from going into D3, but try to avoid platforms where it
may not work".

Basically, as far as I'm concerned, this check can be changed into
something like

if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=3D 2015)
        return true;

which also requires updating the comment above it accordingly.

This would have been better than the check added by the $subject patch IMV.

