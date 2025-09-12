Return-Path: <linux-pci+bounces-35994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A92B547EC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32601BC1FBA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A952848B3;
	Fri, 12 Sep 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3Mh+sVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD927B505
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669693; cv=none; b=UENMn0EL5VmNlgt0aa9kB7dGOjzgRXnJXf56njBHb6Hzao5A4IAMBndOhgWNCObApUSNpFi7mFnjkNRdfeLvepNJcxo3lIfzU74yagLkr0RwStZ0GCFba8QREKaLVq3fBH1tfX3lXyN6HykCFJnLHblBRYXY271mvUHOYEh2DEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669693; c=relaxed/simple;
	bh=2JUPNpHR8uZPua/Ocf4A06g0+dUaWRIP5CAQgui2uU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odD10b5oEq21mSxFU87c0QYRttiMst+iKK2jh+HjYm2ekaeATHaYhEQTHyJ8Y2kBce/NlYULsUpG4fLSwTzs6+PmChjxwbCT+qoepg1nO8nWdVJN9Dk/TQkxFkJf6hLT2vFWq/aeD9J27ttc/YtbD5ZTiXAsFEgwP0Ey/trTFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3Mh+sVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A545C16AAE
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757669693;
	bh=2JUPNpHR8uZPua/Ocf4A06g0+dUaWRIP5CAQgui2uU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s3Mh+sVlkgLGQrH+lPbYQ09MvdIBlTdR+rMF9Wrx6jK6UxYvbdXgZ6u1lMRVhjFwv
	 2FY+8o6iPUCkFx2WCz9cFaVazRh7ZSiSwHHWIvTjQFHiU14junGEFC7V/Ds5SIRWch
	 HEkZcaRjWsgr7NB0E04uayOdsSPf9oi/S6SQE+qiRIAkBqdQDaR61hNWdS7IZ5RdHB
	 Se6ENjwHLi7E4mauSM38udRuR0hbcdGjcT1HAOmgdGkpxFjtrTpUXDgKccwWQUV04k
	 bcddY6fA+CEz0XdabsvbJg8sghYPhufW+t3XaUVo0e4SP8qXl79VkpYej13/mXzT5o
	 rfyhwGWRbrDpA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61e74e59d8fso814069eaf.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:34:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXhqCvx6vAv2QWFqC1pskDSVRMnk6oYszUgNrx9NMdcKyovnuQP/fC0nwrTYQk9K3YhK3/oJqv7aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqshqLgZ8SwZTDqZWh4lK3I3/ep+zvO1gLCaiwWcESwJSRLcfG
	1qpPXzCMhsB4L8ZqXjFgxHWipGEjnzrHUmKazqRmz+A10knjKLa5/CIPKo+uUVQnBjz9dDtvqjk
	2yp850tpn/4thjrLPGfwnA5aDH3TgXSU=
X-Google-Smtp-Source: AGHT+IFJCL8fGugOwFnOZNvSlCpm6fvhe7cWHPzDCTKcJ/HFS1TOwSuPgcN7ZtQnaux0hwAXztuqBp5tIWpM+XoM2Vw=
X-Received: by 2002:a05:6820:516:b0:61e:16d0:9ea2 with SMTP id
 006d021491bc7-621bf8e25d0mr1041426eaf.3.1757669692525; Fri, 12 Sep 2025
 02:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
 <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org> <aMPLDLYpeVXO1y6R@wunner.de>
In-Reply-To: <aMPLDLYpeVXO1y6R@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Sep 2025 11:34:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNdLp_=GPg2AQ+r06tSdpZ1HQJMu=bBTNOyyic1no1EQ@mail.gmail.com>
X-Gm-Features: Ac12FXyZwVzqjs38BOWP1vmQYL8jZ0etA9hnTOl9TdhUXRr3ObXHBhu4JU6OIKk
Message-ID: <CAJZ5v0iNdLp_=GPg2AQ+r06tSdpZ1HQJMu=bBTNOyyic1no1EQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Timo Jyrinki <timo.jyrinki@gmail.com>, 
	Ernst Persson <ernstp@gmail.com>, Steven Harms <sjharms@gmail.com>, James Ettle <james@ettle.org.uk>, 
	Nick Coghlan <ncoghlan@gmail.com>, Weng Xuetian <wengxt@gmail.com>, 
	Andrey Rahmatullin <wrar@wrar.name>, Boris Barbour <boris.barbour@ens.fr>, 
	Vlastimil Zima <vlastimil.zima@gmail.com>, David Banks <amoebae@gmail.com>, 
	Chris Moeller <kode54@gmail.com>, Daniel Fraga <fragabr@gmail.com>, Javier Marcet <jmarcet@gmail.com>, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 9:26=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Thu, Sep 11, 2025 at 08:34:56AM -0500, Mario Limonciello wrote:
> > On 9/11/25 8:11 AM, Lukas Wunner wrote:
> > > pci_disable_device() does not clear I/O and Memory Space Enable, alth=
ough
> > > its name suggests otherwise.  The kernel has never disabled these bit=
s
> > > once they're enabled.  Doing so would avoid the need for the quirk, b=
ut it
> > > is unclear what will break if this fundamental behavior is changed.
> >
> > It's too late for this cycle to do so, but how would you feel about mak=
ing
> > this change at the start of the next cycle so it had a whole cycle to b=
ake
> > in linux-next and see if there is a problem in doing so?
>
> I can look into it.
>
> The change could be justified as a security enhancement to prevent
> unauthorized traffic between devices through peer-to-peer transactions.
>
> pci_disable_device() was introduced with v2.4.3.5 in 2002:
> https://git.kernel.org/tglx/history/c/9102e0eb3e9e
>
> I suspect back in the day, clearing Bus Master Enable seemed sufficient
> because the only concern was to prevent DMA (and by extension MSIs)
> from broken devices.  Attacks *between* devices were probably not
> considered realistic.
>
> ACS is meant to prevent such attacks, but is an optional capability
> and might be configured incorrectly.  A zero trust, defense in depth
> approach as is common today requires not leaving doors open without need.
>
> If the kernel would clear Memory Space Enable, a malicious device could
> not re-enable it on its own because "propagation of Configuration Request=
s
> from Downstream to Upstream as well as peer-to-peer are not supported"
> (PCIe r7.0 sec 7.3.3).
>
> It seemed too risky to make such a sweeping change only to get rid of
> the EHCI quirk.  The present patch is meant as a low-risk refactoring,
> but we can consider clearing IO + Memory Space Enable as a long-term
> solution.

Yes, we can.

Obviously, the additional reason for doing it, which appears to be
more significant than avoiding the EHCI quirk alone, can be regarded
as sufficient justification IMV.

