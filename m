Return-Path: <linux-pci+bounces-43155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C7CC64F3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C3F63016004
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3D33508E;
	Wed, 17 Dec 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDwPl1Ms"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92730335086
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954525; cv=none; b=oEe7NOS/rS9Hg4OTzWaRf8s4PJxsylryhXNJfIhRgqX358VUGWWWsEKagq02gO1bZ83JO/Nckxo2B5L+qisFv64nrSmoQsOfObm3iteG2iD0/BzmWhpJ+pw6nWSbgIUqlFx1mJaGgEQ/DAuGAV9CWYBR1598ViSRkbjtF6NqpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954525; c=relaxed/simple;
	bh=0euWenUD/rLqI7KHSnqNWVT/rtVB0phrpjP0vEqV39M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkLPhixzAKqVoMmHghnAO8t0JEHQtaDNawsaKD1yiQ1Rzvhw3Xi1Wl2LONw4dKoAtjpnuQxcJF7KB9DUTzqiQ+XUcemegxt+9Nsf1LHnzGMIG2v0O8dHQvAX23QVAKFG+OB3rhO4TLVo4b4futOAFevY4to2THHNhy7Hp0Dg6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDwPl1Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51531C2BC9E
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 06:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765954525;
	bh=0euWenUD/rLqI7KHSnqNWVT/rtVB0phrpjP0vEqV39M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UDwPl1MsHTxdQV+Ax597mgm/hZr1ynxXPC2wG2Ikizz8bE4smZn5CM21G3u6fFil+
	 3P0WbseKs3zpK96T+t6cjr5cEfoLL/CFWg8Igu/agDbyFgpu/2kvEWZz/TeOpYsPq8
	 plqzD6F6U/gBBHgZkYkokZOhXf/lSEnXdmUHQXP/H4EgrafeZifpd4To+86URlAws+
	 etppb+w6yi86+vxRlWkFmR0EmOyexvovu5nG4t75l7ZLWI1MD7wGkbMqmcSbUBvLwi
	 XM4FBBvi4KU/jfytUBv+YNkEn2L32UffYaz44FZxX7MYPPAuBTuyNfartVzfwJ3RJx
	 xrGa9SUPv4fmA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso166161566b.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 22:55:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBsG4GnGrg7LwZhbPgLq1/lQfYi+t3w3dqEBnI02b5QqCtc3h+tSPfy1jei8zHSu6RTqo7b8ig8fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBH/8gzusxfbuMfoRPKY6GhEAmt0NmvlicXpiBsWxalVVqe+Df
	1tQXpb0PrdY9wwy8DzgrZvKbKMBa5tQN0w+7fZ5PqVMTtP+fMjFLXzlaet6sX1uWcF33Qwq0FOE
	goIMVR47n3kuCH2WL79WpQ8wavGo9sV8=
X-Google-Smtp-Source: AGHT+IEORLRdPBP/v0qwTwrl9rsa2vM3x1Jalt/3BfBNuYFsSiqui/I50cEEFyEiU5SwgUbYfma1vOsgdfJqpwcGEug=
X-Received: by 2002:a17:907:1ca1:b0:b76:bfa9:5ae7 with SMTP id
 a640c23a62f3a-b7d236bcc17mr1645242166b.29.1765954523680; Tue, 16 Dec 2025
 22:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-ari_no_bus_dev-v5-0-d9a5eab67ed0@linux.ibm.com>
 <20251029-ari_no_bus_dev-v5-1-d9a5eab67ed0@linux.ibm.com> <CAAhV-H6qqppoX_G5KrWmPor16bXfvNTE2x8Xx6yajAYPqxpigw@mail.gmail.com>
 <958ef380be4ea488698fab05245d631998c32a48.camel@linux.ibm.com>
 <CAAhV-H7iMKmLnisD-874D2ZC919sDYeWy3tw=+eUqifK--6-Dg@mail.gmail.com>
 <8dd0f3df4b18a6c9f8b49ede7bc2ab71e40fd8f9.camel@linux.ibm.com>
 <CAAhV-H4MNSiUqYpE919YcCaC-_-Q3GBwxRL13ggjsyLahQ-t1A@mail.gmail.com>
 <7385677843a7790e01158644f63ae4dbb3353bfe.camel@linux.ibm.com>
 <298aaf6b2815e59d1a94efffdd0e3b002c000cea.camel@linux.ibm.com>
 <CAAhV-H7fgaZUuFSpE0VsMtptnrUTzh0TS=B9ZBUZ_=TH-XjKtg@mail.gmail.com> <ba63ea826472b4f2d2a318784b710ee91fdca202.camel@linux.ibm.com>
In-Reply-To: <ba63ea826472b4f2d2a318784b710ee91fdca202.camel@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Dec 2025 14:55:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6GE3q4qaPo9OvNkYOzatR-8BMYeGQ8hdmvKVZXbQF2rw@mail.gmail.com>
X-Gm-Features: AQt7F2qiIW0tFThs3sCWqUchKuIiqrXyQONRE7SXBTuAyRJjZ97vPUQx-OL6RF0
Message-ID: <CAAhV-H6GE3q4qaPo9OvNkYOzatR-8BMYeGQ8hdmvKVZXbQF2rw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: Fix isolated PCI function probing with ARI
 and SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev, 
	Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 5:45=E2=80=AFAM Niklas Schnelle <schnelle@linux.ibm.=
com> wrote:
>
> On Mon, 2025-12-01 at 22:45 +0800, Huacai Chen wrote:
> >
> --- snip ---
> > You said that "it feels like this is just a hack to probe an odd
> > topology". Yes, to some extent you are right.
> >
> > 1, One of our SoC (LS2K3000) has a special device which has func1 but
> > without func0. To let the PCI core scan func1 we can only make
> > hypervisor_isolated_pci_functions() return true.
> > 2, In the above case, PCI_SCAN_ALL_PCIE_DEVS has no help.
> > 3, Though we change hypervisor_isolated_pci_functions() to resolve the
> > above problem, it also lets us pass isolated PCI functions to a guest
> > OS instance.
> >
> > As a summary, for real machines commit a02fd05661d73a850 is a hack to
> > probe an odd device, for virtual machines it allows passing isolated
> > PCI functions.
>
> Ok, thanks for the answer. So let's see how we can debug this and get
> to a solution that works for both of us. Looking around a bit I see
> that your pci_loongson_map_bus() has some special handling for trying
> not to access non-existent devices added by your commit 2410e3301fcc
> ("PCI: loongson: Don't access non-existent devices"). I wonder if with
> this patch applied we're running into this same issue but with a devfn
> that was previously not tried and is not covered by your checks? And
> maybe since your root complex doesn't return 0xff for these non-
> existent devices we could end up trying to probe AHCI on such an empty
> slot misinterpreting whatever it returns as matching device/vendor?
Commit 2410e3301fcc seems to have no relationship with current problems.

The LS2K3000 problem that commit a02fd05661d73 want to resolve is we
have such a device:
bus=3D0, device=3D6,  fun=3D0,  GPU
bus=3D0, device=3D6,  fun=3D1,  DC
The GPU part can be disabled and in which case there is a device
without func0, so need a hack.

>
> And looking at pdev_may_exist() does the "device <=3D 20" really make
> sense with 20 in decimal? If I pull in the negation I get "device > 19"
> But if it was 0x20 I'd get "device > 0x1f" which would match the
> maximum value of PCI_SLOT(), though then the check would be redundant
> since the device value already comes out of PCI_SLOT().
I have confirmed that 20 in decimal is right. Devices between dev-20
and dev-0x20 are completely sane.

>
> Could you try redoing the test with the AHCI hang but add a print of
> the affected bus/device/function that AHCI thinks it is probing? Then
> if the above theory applies we should see it trying to probe on a
> device that is missing in the correctly booted case and got past your
> existing checks.
By redoing this test we found there is only one AHCI detected, and the
BDF is: bus=3D0, device=3D8, fun=3D0.

With or without this patch, only one AHCI. But without this patch, the
AHCI initialization doesn't hang.

Huacai

>
> Thanks,
> Niklas Schnelle

