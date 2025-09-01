Return-Path: <linux-pci+bounces-35286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC3B3EC02
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636F2441E0F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC272D595B;
	Mon,  1 Sep 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTQUZozb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DE2EC08D
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743058; cv=none; b=hzdrtmpGDTN3aVmu/TH3tQaaN9i+gF3b1kSzyD3n4/9ZMqnZgQOSQUw8BZZYCGV25G+/AWV4XeqsRbwe6SQ+3hPbRiSZEC/qAge3crY7C1OfYKyWd2D69+vuOcqOyltIHGsDqaLR0e85W8m+YIgGhZOL9/F48BDOX5x2Z1L4htk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743058; c=relaxed/simple;
	bh=gQwh1rzEvFJB2dOTUefQnxXZjHFQeeFmBh7IF6u/MAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sqn/7kI0pnV8esGSlRUroEuyMdVBrgh3Bbxd158boot7XVac58eqlqWB+y05zLK0vhu5rIG4Omxb8+ilRHuQfRecTJtP2h2PSIoeIpEaUhFPaqFUGfW63FWfhB8NFwFYYFGo65rfk1S/Kpv9undg8PZSheUnof+/q2ovX04GrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTQUZozb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so1992196a12.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Sep 2025 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756743056; x=1757347856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PXTq2az3fRv9KEww/9gCmzwmuP2kb4MdydgPf9aDp0=;
        b=BTQUZozbB7MMlipVT8hKh8HH0iIF92BJoq3DGHM1Xbv98r2hqDWWK7Zas1A8rBMFuF
         BrhcWGF6Uk2u1GwUfCBGkWWnRZvLf0hT+aGYHsHsJAeiP+i0fen1BQpqASX4LUrCMRLa
         K7/y+Bp7LPD79DHQiewD/k2n5nfweTPGkQffnS/kybBKVKgJq89RhGIjUI2B27lS10wz
         TgJO8Ly4JUHcTud1ASiya3F2Q4xKaAE63wngYQ87m54JFzR8R0xrIH6sECCvOaMfnYEr
         CnK4cWDaPV/gYzGZmlM/MQ6rPrfPPQGJkDm2tnkSZDAMzAcz/HC7awP9VdPmqoRqj5mm
         e4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743056; x=1757347856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PXTq2az3fRv9KEww/9gCmzwmuP2kb4MdydgPf9aDp0=;
        b=tO36IZvr2xt/8jvrxDf6iTkFIxcAWtYR2AiBXq0IX/IsG4BtWphDDdWKfxldSJYS91
         kOA6WjnR25Yvna3py+FL1sFHwbop3/OAImrFvYrsjqCaYamPpfc1pZK6e7ALPw/IFmub
         g0VOO2lF7t9kndIx2EMQgLfo7ADkgiJQlJiESmUztpwapJiqTTHg4Aq+B0joblPC7+p3
         hJBnFzp4BWlts4weDso9lbJ30DYEIxdgm/zdYXDncBT02x1l6wU4VEdJ1lsLsFIdOZpw
         bXoXSFkSriyxQ8rkpZUQm+gF9NePEGP0MHqjAWHzaSLUQ7YPMXXdA/6tUlRA2a8Iig+z
         UW7w==
X-Gm-Message-State: AOJu0YwuQqrHaD6g5UcW206PsV78hFIKDmlHYfTfxYYP+AhXuvBcVopA
	IwiMuEoF9DKKwhVai68Z1RpHP7Mmd5+OqsxyIVz0rkUHVKjmBs35IY2CG6qLyIZrHhk/yQMuRAu
	uNfc3CJ9IblG5ki4vU0CGIO8NSZXMk2a345Pi
X-Gm-Gg: ASbGncvlsSOwHx7OnlB7vQ6Xeti+MKw5RvCEyrFS2/D+zM73jJ+1a44iYOu6fqRxxem
	z7V7dun7V2ezFV94FHH9Ip0wLlBKh80D4/XWxiHi22YhcrCeGt/OlgUBU12yaXOsZXSPwhgsndN
	PCC66gjYxrF+l6H5O35vmOGv+9q2oO30ira9minLxkPa6I0XD04GBVKLtD4zMv0yvTnOMKynb/+
	mOH1w==
X-Google-Smtp-Source: AGHT+IHZU2UPDoZsUTB/ytbnJvvl9EvQwkbx/Nkc2qnUv9y1YAjvfub3Fc9132C9QPgdz5CZg+Z3KtgR5E8O4VSErRs=
X-Received: by 2002:a17:903:290:b0:249:1107:a16a with SMTP id
 d9443c01a7336-24944b401abmr93838345ad.45.1756743055924; Mon, 01 Sep 2025
 09:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com>
 <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com>
In-Reply-To: <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com>
From: Steve Oswald <stevepeter.oswald@gmail.com>
Date: Mon, 1 Sep 2025 19:10:44 +0300
X-Gm-Features: Ac12FXw9RIFm3l23Z4ZNsZ__q4_pFH0_9tx86vmBIlH3vu852BMclfJrp2N2PNY
Message-ID: <CAN95MYErrb3j0VuX+oqgjO-TwbcbvpHvKnX_Yd1bOr1cnaSDFg@mail.gmail.com>
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,
thank you very much for taking a look at this. I've added the dmesg
output with pcie=3Drealloc and with hpmmioprefsize kernel parameters,
both run into the same problem.
- gist with separate log files:
https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
- raw dmesg and lspci -vvv from pcie=3Drealloc
https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af/raw/647a94=
a1d5d40166a065343aab1be869039fe694/dmesg_linux_6.11.0_pcie=3Drealloc.log
   (please not that  # cat /proc/iomem output is at the very end
around line 3259.)
- raw dmesg from hpmmioprefsize
https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af=
/raw/647a94a1d5d40166a065343aab1be869039fe694/dmesg_linux_6.11.0_hpmm.log

I'll try to be as helpful as possible, however I haven't had success
compiling the kernel from source in the past. I'll be sure to give it
a try if you provide a patch file.
If something is missing, please let me know.

Cheers,
Steve




Am Mo., 1. Sept. 2025 um 18:50 Uhr schrieb Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com>:
>
> On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 31 Aug 2025, Steve Oswald wrote:
> >
> > > I=E2=80=99ve encountered an issue with Thunderbolt eGPU (externally c=
onnected
> > > gpu via thunderbolt 4). The change from kernel 6.10.14 to 6.11.0 brok=
e
> > > the pci memory assignment of the external pcie device. I figured out
> > > which version broke it by using ubuntu 25.04 and downgrading the
> > > kernel (https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kern=
el.sh/master/ubuntu-mainline-kernel.sh).
> > >
> > > >From the dmesg output, on the broken 6.11.0 I see 'failed to assign'=
.
> > > The issue occurs (almost never) on previous kernel version 6.10.14.
> > > Using pci=3Drealloc did not change the behavior (I can produce the dm=
esg
> > > output if necessary).
> > >
> > > The issue was tested with 2 egpus (Radeon Instinct MI50 32GB, NVIDIA
> > > 3080 10GB). Both the amd and the nvidia driver fail to initialize the
> > > device because they cannot write the pcie messages.
> > >
> > > System details:
> > > - Kernel: Linux 6.10.14-061014-generic (Ubuntu build) > 6.11.0-061100
> > > - Laptop: TUXEDO InfinityBook Pro 16 - Gen8 with Thunderbolt 4
> > > - eGPU: Radeon Instinct MI50 32GB, NVIDIA 3080 10GB
> > >
> > > Steps to reproduce:
> > > 1. Boot the system with the eGPU.
> > > 2. Observe PCI BAR message in `dmesg`.
> > >
> > > Logs:
> > > both kernel messages, lspci can be found here:
> > > https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
> > > raw files:
> > > - dmesg_linux_6.11.0.log
> > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675=
b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.11.0.log
> > > - dmesg_linux_6.10.14.log
> > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675=
b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.10.14.log
> > >
> > > If additional info is needed, I'm happy to help.
> >
> > Hi Steve,
> >
> > Thanks for the report.
> >
> > My analysis is that the problem boils down to lack of this line with 6.=
11:
> >
> > pcieport 0000:00:07.0: resource 15 [mem 0x6000000000-0x601bffffff 64bit=
 pref] released
> >
> > It means one of the upstream bridge windows could not be released for
> > resize as it is printed from pci_reassign_bridge_resources() which like=
ly
> > occurs inside pci_resize_resource() call from amdgpu(?).
> >
> > The very likely cause is this check:
> >
> >                         /* Ignore BARs which are still in use */
> >                         if (res->child)
> >                                 continue;
> >
> > ...which (until very recently) is entirely silent so there's no warning
> > whatsover what is the root cause.
>
> Hi again,
>
> Actually, scratch most of that. It's not during resize as the log should
> say "releasing" (I don't know how I got this confused). "released" is fro=
m
> pci_bridge_release_resources() which is called from
> pci_bus_release_bridge_resources() doesn't even try to walk upwards.
>
> But that begs question, why didn't also the bridge windows fail their
> assignments.
>
> Resource fitting calculates size for the bridge window:
>
> pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pref]=
 to [bus 04-2c] add_size 100000 add_align 100000
>
> ...but I cannot see assignment for that even being attempted as almost
> immediately, this occurs:
>
> pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pref=
]: assigned
>
> ...which is much less than 0x10003fffff-0x800000000. I cannot think of
> anything what could make it shrink like that.
>
> I'll have to think this more, it might require a debug patch but I'll
> think until tomorrow to see if I can understand it from the code alone.
>
> > What this means, is that there's some assigned resource underneath
> > 0000:00:07.0 with 6.11 that wasn't there with 6.10. And it is because 6=
.11
> > tried harder to get your resources assigned and was successful here and
> > there resulting in pinning the bridge window in its place, whereas 6.10
> > failed to assign the same resource.
> >
> > Could you provide /proc/iomem (it's enough to do that for 6.11 for now)=
?
> >
> >
> > You could try to use hpmmioprefsize=3D on kernel's command line to rese=
rve
> > more space for the bridge windows, the default is only 2M and these GPU=
s
> > need a magnitude more (gigabytes), you can check from 6.10 what the siz=
es
> > of the BARs on the GPU are, and round the sum upwards to the next power=
 of
> > two multiple.
> >
> > I'd also be interested to see why pci=3Drealloc failed to solve this pr=
oblem
> > as it should reconfigure the entire resource tree so if you could provi=
de
> > the logs with that. Please take lspci with -vvv.
> >
> >
> >
>
> --
>  i.

