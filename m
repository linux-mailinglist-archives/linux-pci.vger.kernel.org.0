Return-Path: <linux-pci+bounces-35287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC540B3EC14
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB31A20535D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5292D593C;
	Mon,  1 Sep 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7McyWCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7082D5936
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743552; cv=none; b=lL6q41ho8ud1szCuKdSaG8BLT6/RHYfqqmCgU/lrAZjRWzW7bpeM26UWgiIjWs7XRK0lvJ/bHy28pjppYuYI35W75cIY5dQYQh15V3pmgaAvjwhTBqy1s8p4aBn5r2iNlFYPNHRuVfC76vp6Zk0uV3qFQDCcFss7JukknlbPyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743552; c=relaxed/simple;
	bh=Xt+QtJV88za+y9THieuCglrH/iDT32TQY6HIFuXBXx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAkuM6ucaaVkc92XMmoB8QBf62aAXccKRppUl80Fk0N2ARZXXLi8uR3/i9xGxAAyGvUzvQyxCXz0bFAlobCL5GySPru4PTZaEQwLA/2kdNttEE8cvIwuCfGejjIihwjDQYKj0UeMaLNvNLQtlcspStU6IqZvwma9gU0R6JDX35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7McyWCN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-328015abe0bso2562103a91.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Sep 2025 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756743550; x=1757348350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9SVe9ftcJHDvTNuM64CHWxXUJpTQdyQMxuTFb+eXZ8=;
        b=c7McyWCNNBTydpUbdWodnBWuoyFJBPA0hqm81lRy8pfqrpo2ZP15rwDtf2az8Xez0L
         K17j4Ip5gKGq3CifeQfZPAhj/NptyC90XrxAyvCAFUkq32Bhj5RAsy/fbzRZBv1+JISe
         O4JXq1HmKlSxXErz7owjw3OKupxuOOSeqfGniSnOjE6S4keqJE85r65me0EYYcG8OwDw
         aybl9nnaf/cPYAkiSJAYlKyRCxr3mQ7+fwY7fCm5E09E5CffK+ynPBJ9H011PPApVTYL
         p7YHCE1IupELzuBMkCjSIn20O5ZNchXdY5foJyHfcQzLMzcIKx0VBO+gG5CGg/LWvPO1
         iq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743550; x=1757348350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SVe9ftcJHDvTNuM64CHWxXUJpTQdyQMxuTFb+eXZ8=;
        b=HkAeFqDCSSmYKoIljwkTT51V+eLET3wfim4Uf4+BTOOVWfFfKbW39FWDHobkoBrRyv
         DH3Vxzpx0or7sFqHWUZn/Yd5vticc7IaUgcQ+v3/WKIdOiYytlwCwIJorhSRE/pu0fbi
         q1eT5JlZ7wnHrBVRk86jryWhh2HCORt+fXxXJqufCy8HToPteac4+L/IQMjKRgrej+Rz
         Smwk+Ax1/O3Vmu5o3BxXcbAKeBXK4+CRuJIXggeM3Fd9JgomcfvXAY17yzhoCRHa309J
         GtM3MuvarQKYHlQZvRufD1PArytfcLbRVY1TQat+4GVs5Atp33e6lrJsdSaXZdI1aycK
         Go9g==
X-Gm-Message-State: AOJu0YyKelCrqnOxB0FOHlFiiIB9nGs7A8fI1yJ67pNvPfNKWIfvmWBN
	xXKxxvhps9M4dTlvodOgE8z4Z0nH6p1gNVrVKYh3fAktNc02rYGCx9RObrvtNs/xCxXadROFvAs
	oIGEcRvpVq2u719k2l6kzHCjhwcXg2XU=
X-Gm-Gg: ASbGncs0vopQf5yGTSZVWG/FiDQtTWd3HBq/RN2hwmL5nPp33kP2WwhUSLwQuSSlajt
	77X2/sxIxt3r9fIafoafFc0Rnp5VQncKeScYanbmHl7fWZUGEVq+wqdwBDF3SyCuKY8u3llX+tx
	a9+1DmhMxZw1WKTVqUobTMGngzxnegqsvYPL0B2IiFazmmBHAZK5++JW4wUxLKG1NJxS/c+QE4C
	SA9WggcIY/Viucp
X-Google-Smtp-Source: AGHT+IH4XIQpH8mKsTa/YvmcYJru5VJIxPzsR64cYtbvQVgLgzbEPnvTL6t1gxp47lQ8Gi37DX9VTFtFd7pC6plWen0=
X-Received: by 2002:a17:90b:4c0c:b0:313:aefa:b08 with SMTP id
 98e67ed59e1d1-328156df907mr12009053a91.16.1756743550254; Mon, 01 Sep 2025
 09:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com>
 <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com>
 <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com>
In-Reply-To: <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com>
From: Steve Oswald <stevepeter.oswald@gmail.com>
Date: Mon, 1 Sep 2025 19:18:59 +0300
X-Gm-Features: Ac12FXzE_GDYaC9WOM3p2PpVog99EZAg5LcIsAn8mkFuejkOPYt5qnBIg5ixYdk
Message-ID: <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com>
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've added the dmesg output fordyndbg=3D"file drivers/pci/*. I wasn't
sure if I added it with the escaped quotes correctly.
https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af/raw/9cf5fc=
3a8c4f13588a33d61865f804f85e50470a/dmesg_linux_6.11.0_dyndbg.log

Am Mo., 1. Sept. 2025 um 19:07 Uhr schrieb Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com>:
>
> On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:
>
> > On Mon, 1 Sep 2025, Ilpo J=C3=A4rvinen wrote:
> > > On Sun, 31 Aug 2025, Steve Oswald wrote:
> > >
> > > > I=E2=80=99ve encountered an issue with Thunderbolt eGPU (externally=
 connected
> > > > gpu via thunderbolt 4). The change from kernel 6.10.14 to 6.11.0 br=
oke
> > > > the pci memory assignment of the external pcie device. I figured ou=
t
> > > > which version broke it by using ubuntu 25.04 and downgrading the
> > > > kernel (https://raw.githubusercontent.com/pimlie/ubuntu-mainline-ke=
rnel.sh/master/ubuntu-mainline-kernel.sh).
> > > >
> > > > >From the dmesg output, on the broken 6.11.0 I see 'failed to assig=
n'.
> > > > The issue occurs (almost never) on previous kernel version 6.10.14.
> > > > Using pci=3Drealloc did not change the behavior (I can produce the =
dmesg
> > > > output if necessary).
> > > >
> > > > The issue was tested with 2 egpus (Radeon Instinct MI50 32GB, NVIDI=
A
> > > > 3080 10GB). Both the amd and the nvidia driver fail to initialize t=
he
> > > > device because they cannot write the pcie messages.
> > > >
> > > > System details:
> > > > - Kernel: Linux 6.10.14-061014-generic (Ubuntu build) > 6.11.0-0611=
00
> > > > - Laptop: TUXEDO InfinityBook Pro 16 - Gen8 with Thunderbolt 4
> > > > - eGPU: Radeon Instinct MI50 32GB, NVIDIA 3080 10GB
> > > >
> > > > Steps to reproduce:
> > > > 1. Boot the system with the eGPU.
> > > > 2. Observe PCI BAR message in `dmesg`.
> > > >
> > > > Logs:
> > > > both kernel messages, lspci can be found here:
> > > > https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af
> > > > raw files:
> > > > - dmesg_linux_6.11.0.log
> > > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d56=
75b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.11.0.lo=
g
> > > > - dmesg_linux_6.10.14.log
> > > > https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d56=
75b4e4af/raw/f9470a06ff929d386c50ec6b5d07e0ff3f053dcf/dmesg_linux_6.10.14.l=
og
> > > >
> > > > If additional info is needed, I'm happy to help.
> > >
> > > Hi Steve,
> > >
> > > Thanks for the report.
> > >
> > > My analysis is that the problem boils down to lack of this line with =
6.11:
> > >
> > > pcieport 0000:00:07.0: resource 15 [mem 0x6000000000-0x601bffffff 64b=
it pref] released
> > >
> > > It means one of the upstream bridge windows could not be released for
> > > resize as it is printed from pci_reassign_bridge_resources() which li=
kely
> > > occurs inside pci_resize_resource() call from amdgpu(?).
> > >
> > > The very likely cause is this check:
> > >
> > >                         /* Ignore BARs which are still in use */
> > >                         if (res->child)
> > >                                 continue;
> > >
> > > ...which (until very recently) is entirely silent so there's no warni=
ng
> > > whatsover what is the root cause.
> >
> > Hi again,
> >
> > Actually, scratch most of that. It's not during resize as the log shoul=
d
> > say "releasing" (I don't know how I got this confused). "released" is f=
rom
> > pci_bridge_release_resources() which is called from
> > pci_bus_release_bridge_resources() doesn't even try to walk upwards.
> >
> > But that begs question, why didn't also the bridge windows fail their
> > assignments.
> >
> > Resource fitting calculates size for the bridge window:
> >
> > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pre=
f] to [bus 04-2c] add_size 100000 add_align 100000
> >
> > ...but I cannot see assignment for that even being attempted as almost
> > immediately, this occurs:
> >
> > pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pr=
ef]: assigned
> >
> > ...which is much less than 0x10003fffff-0x800000000. I cannot think of
> > anything what could make it shrink like that.
> >
> > I'll have to think this more, it might require a debug patch but I'll
> > think until tomorrow to see if I can understand it from the code alone.
>
> Only thing I can think of is something going wrong in
> adjust_bridge_window().
>
> Could you please provide a dmesg with dyndbg=3D"file drivers/pci/* +p" on
> the kernel cmdline from 6.11.
>
> > > What this means, is that there's some assigned resource underneath
> > > 0000:00:07.0 with 6.11 that wasn't there with 6.10. And it is because=
 6.11
> > > tried harder to get your resources assigned and was successful here a=
nd
> > > there resulting in pinning the bridge window in its place, whereas 6.=
10
> > > failed to assign the same resource.
> > >
> > > Could you provide /proc/iomem (it's enough to do that for 6.11 for no=
w)?
> > >
> > >
> > > You could try to use hpmmioprefsize=3D on kernel's command line to re=
serve
> > > more space for the bridge windows, the default is only 2M and these G=
PUs
> > > need a magnitude more (gigabytes), you can check from 6.10 what the s=
izes
> > > of the BARs on the GPU are, and round the sum upwards to the next pow=
er of
> > > two multiple.
> > >
> > > I'd also be interested to see why pci=3Drealloc failed to solve this =
problem
> > > as it should reconfigure the entire resource tree so if you could pro=
vide
> > > the logs with that. Please take lspci with -vvv.
> > >
> > >
> > >
> >
> >
>
> --
>  i.

