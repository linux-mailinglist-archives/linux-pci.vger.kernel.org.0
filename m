Return-Path: <linux-pci+bounces-20701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51BA27576
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 16:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0180316584D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B375213E76;
	Tue,  4 Feb 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0X9vjul"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5132135D1;
	Tue,  4 Feb 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681860; cv=none; b=pYF2xMUf7YQ31i5+2qeNZv29rMxJacFWZCfhNU9cW4R5mvijbGotoCiW1e3R1H1Ltbl9wtDcNCLIubVExiJMHGCVwKSTwznb85BkPYAwrwDWLXTSQzleulADUuzejjsCt51UarMv0Sm5sNn9PKNoDCmKjTkPkXKvVQ96my6dg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681860; c=relaxed/simple;
	bh=Bzu4jtQIUnIF8X4IR31+HofzpffJIQYmIBgKgA2+fO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqCR3af7O07EqxlXiQ3jZS3ckqHOu3WmFlABUtb+O9e1V9WGRZZqZhlhvn0a6wAmEmdG9iKTdb/mCyAnUwXUcmJV/b6asa/7AvkYfw/BzMIW803+V/CtdqpKY/47FdwU5DG/wTfXHgz9JfieqX3E8RlaNaYMYsJnn8A6LlPwuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0X9vjul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1042C4CEE9;
	Tue,  4 Feb 2025 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738681859;
	bh=Bzu4jtQIUnIF8X4IR31+HofzpffJIQYmIBgKgA2+fO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b0X9vjulsBaGpMeKOu2J/+tjRqQ8yeAb6yzDQvv265BDEER9fgBSE1lvT++F6Z3Rf
	 3gDviT9zN8Je7742jAP52p8plZ4v3GOu9N/QyGadWZXP7CU0ugFhHpUSelL9YILmrB
	 OPgeddJKbZRzJFFp0eXTPHjwfOzSM8COs8Kd+JkYpsNpGMfoC6iTTcZ/L3nipEhyUF
	 Yeuh425D/zFXRokdXCW5LxOs+txL4c8t5u+ufx624wS9EOKaSjyPhmZKgTPgToSXUp
	 qM3sxJ6AORc0XdX4GGYFXY9VaGa0EEQzAehPOUb9BUapnYGOROB2eKVzjidGyeYueL
	 Npfws2dBVij/w==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb8db8ae9aso2384228b6e.1;
        Tue, 04 Feb 2025 07:10:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5k0wK6itZRf9+dfriVU3wheq9/R3MJOkR007qRRt4H97KGGpQP+l/kT70qni0b3eRKz3jXcnk+BOM@vger.kernel.org, AJvYcCWKldRY4KcQO+NeTD8c++mPEtWUfizelmqH+SwZsHJdv697E4c+xnNX4keAtRsVdrn4Y/AyWElQHjVeuFE=@vger.kernel.org, AJvYcCX2oOSZNA7raN8B4otblEoyiI8RJdSJmTqUYc48cjVgAjLyBKfnZJNnnn4Z9prAJdyj8GpNky7rWTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDSTGwv/rOp7nYfjyat9+V3fjUhAOSMhDMUVo/LzI965w7V0Y
	S2lMNTIeZzxMVkoKEsKcwXvx+p/AfOcCdQTOHhtc264YKnARJocTIiHA5j2AwJU4zimGZ9CwCxW
	Zrha9Fys90AIkj0g0+6EleBD9HXE=
X-Google-Smtp-Source: AGHT+IGd7nEAjJRKGOJuEdhdnKBoJU/T/F7ZhSfENXDZPw2xh36kHN/a8fzVyl8RsbVmv800Yz99C3pZxsEaXQQO4m8=
X-Received: by 2002:a05:6808:3307:b0:3eb:84f6:923a with SMTP id
 5614622812f47-3f323a91921mr17333887b6e.22.1738681858808; Tue, 04 Feb 2025
 07:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iKmynOQ5vKSQbg1J_FmavwZE-nRONovOZ0mpMVauheWg@mail.gmail.com>
 <CAJZ5v0i=yBSFW82E=s=mx7ztVzmnoUwbxkDRnYyDztAWK9VcsQ@mail.gmail.com> <9aa469fd-da5b-70fc-147e-dd4a50cf5af6@linux.intel.com>
In-Reply-To: <9aa469fd-da5b-70fc-147e-dd4a50cf5af6@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Feb 2025 16:10:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j157A=v6S8X4+QXRrmUfk2uN5DkRJ5RXd4e4o3hVucqg@mail.gmail.com>
X-Gm-Features: AWEUYZlS4aGIFuwoDNhbxBZ986dhW5tdw0Z6J7ryEiKR2Y-8ET-o7hvETdycpIQ
Message-ID: <CAJZ5v0j157A=v6S8X4+QXRrmUfk2uN5DkRJ5RXd4e4o3hVucqg@mail.gmail.com>
Subject: Re: [Regression in 6.14-rc1] System suspend/resume broken by PCI
 commit 1db806ec06b7c
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jian-Hong Pan <jhp@endlessos.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Tue, Feb 4, 2025 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 3 Feb 2025, Rafael J. Wysocki wrote:
>
> > On Mon, Feb 3, 2025 at 9:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > Hi,
>
> Hi Rafael,
>
> > > The following commit:
> > >
> > > commit 1db806ec06b7c6e08e8af57088da067963ddf117
> > > Author: Jian-Hong Pan <jhp@endlessos.org>
> > > Date:   Fri Nov 15 15:22:02 2024 +0800
> > >
> > >    PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
> > >
> > >    After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> > >    suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS sta=
te for
> > >    "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for=
 both
> > >    "dev" and its parent.
> > >
> > >    The problem is that unless pci_save_state() has been used in some =
other
> > >    path and has already saved the parent L1SS state, we will restore =
junk to
> > >    the parent, which means the L1 Substates likely won't work correct=
ly.
> > >
> > >    Save the L1SS config for both the device and its parent in
> > >    pci_save_aspm_l1ss_state().  When restoring, we need both because =
L1SS must
> > >    be enabled at the parent (the Downstream Port) before being enable=
d at the
> > >    child (the Upstream Port).
> > >
> > >    Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endless=
os.org
> > >    Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability fo=
r
> > > suspend/resume")
> > >    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > >    Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > >    Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > >    [bhelgaas: parallel save/restore structure, simplify commit log, p=
atch at
> > >    https://lore.kernel.org/r/20241212230340.GA3267194@bhelgaas]
> > >    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >    Tested-by: Jian-Hong Pan <jhp@endlessos.org> # Asus B1400CEAE
> > >
> > > broke system suspend/resume on my Dell XPS13 9360.  It doesn't even
> > > pass suspend/resume testing after "echo devices > /sys/power/pm_test"=
.
> > >
> > > It looks like PCIe links are all down during resume after the above
> > > commit, but it is rather hard to collect any data in that state.
> > >
> > > Reverting the above commit on top of 6.14-rc1 makes things work again=
,
> > > no problem.
> > >
> > > I'm unsure what exactly the problem is ATM, but I'm going to check a
> > > couple of theories.
> >
> > The attached change makes it work again, FWIW, but moving the
> > parent->l1ss check alone below the pdev l1ss saving doesn't help.
> >
> > So it is either the parent check against NULL or the
> > pcie_downstream_port(pdev) one that breaks it.  I guess the former,
> > but I'll test it tomorrow.
>
> Neither of those is the root cause

Well, not quite.

> but it's bit hard to see from the code
> itself because the parent->saved_state check your test patch also removed

My patch hasn't removed that check.

Besides, suspend/resume works on my system without commit
1db806ec06b7c6e0 and the parent->saved_state only affects the parent,
so it clearly cannot be the culprit here.

> looks very logical on a glance (but that's the problematic line).
>
> The fix is already here with the explanation:
>
> https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@lin=
ux.intel.com/T/#u

So it turns out that the minimum fux that works here is what I posted.
That is, the upfront pcie_downstream_port(pdev) check needs to be
dropped and the !parent check needs to be moved after saving the
pdev's state.

IOW, it looks like on this platform, it is necessary to save the l1ss
state for a Root Port.

