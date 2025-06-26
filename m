Return-Path: <linux-pci+bounces-30697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0012AE9A63
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C91C2155C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F71215F5C;
	Thu, 26 Jun 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+xAJWcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8D2153ED
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931241; cv=none; b=HSVc97SPNV481Zw4MDyM0wsWE9goDdJQT7Lks1rmnokYC4j/2/5GURKzK7SWk9UQ1dsDVoeJlpcxBCYUmVe2RAOZyAn488w++nLsBq5G75UOkuV2XpM+gusS5TTULlSpGe8bfZzuoZG5VfsJKD/rt88TnlHYO3F7oesPyXivFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931241; c=relaxed/simple;
	bh=S1OdVDiNdscAC1sB5SJOm+0v48HtXVFOr+uVL9/btPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty/HlswyjZlFgMiKHlxsQzBZyeOWb5KrFXXwSS/JKPrjyQOYsG4QCQWp1XMMPco79c/U8skCYpaYeWc4vYKdrQHOb8gFKdi/+f2rgYkD2kUqajE9q5WhZlj2BYzSx2yAp+U1eR/hOWm9OAOYZoO9p0ndDrtGvpZ9NttNgqlq0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+xAJWcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809C3C4CEEF
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 09:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750931240;
	bh=S1OdVDiNdscAC1sB5SJOm+0v48HtXVFOr+uVL9/btPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k+xAJWcwHjEtn6fXh7k3pG29zHcjJiAHstYFbESOVQXO+flbsWLNt3q4zOmbxBAuh
	 QVWxt24jtgYF/q2m0OX72BbAOD29VVau9jbi0n/yRJwvUH8uPpTGZDa3PFfalNtW4r
	 9Da/EBf/ve5Cxm67mlC9a0c7Mkox5PrKo9GBHlPGAdbQ3v99FJnGuoyxK4Wl/su06i
	 7+6QfcyapvbtTLrXldRORH10ulc3MovDMuS337pOG8nmMlIk39MaYJWUKZmKuIsAEw
	 Ui2oMv+1ymngvLztKCObo/wzcRiRL0ZFmWZh2N8Ha/by2Yuxru+HZPsvZmBFkE0HKi
	 /XndfTjq930/w==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-611a7c617a7so177808eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:47:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXYovy66CZwEc2biyKxIbbn3qKSknT5xnrn7dnwlSbC9mmtn3NszN9PgAOuIYhfiFKQtPMeGScqEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzx4JM9ez27C6cHOBVztsNXL5l4HhT/SbvBo2gmeyNaF5SQKH0
	8rMLeWtUZnJc2pru9V8yyNDFzcN+wxnpUlQOwDYGneLnE+SA9YSlS+iRNzDv1jFdTZzSJc3XKIB
	mtmMeNgoZubc/DYWos4+hnI1mgwS5H7A=
X-Google-Smtp-Source: AGHT+IGMw83F2/tWS7EHRQUk2nS1K/x7b0tzp1bA6dF1oYpUZFzDWw5vimClQ1m54F5WnE0mZFTNU0h6YRwvo/zuSsg=
X-Received: by 2002:a05:6870:219c:b0:2c2:5c26:2d8e with SMTP id
 586e51a60fabf-2efb26d1fe8mr4324406fac.16.1750931239831; Thu, 26 Jun 2025
 02:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
 <20250624142407.GA1473261@bhelgaas> <aFzbALxN4jliWtmb@wunner.de>
In-Reply-To: <aFzbALxN4jliWtmb@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 11:47:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-3VpAp1G8AsP3EMaBsVAQRF5TRyr4Se95Wheaz67G3g@mail.gmail.com>
X-Gm-Features: Ac12FXwV_eUre2flVs9jw9Wub6aSZXDmSwtpKMoLJ6FK1jFRoOnyiAbs9Dy-dqM
Message-ID: <CAJZ5v0h-3VpAp1G8AsP3EMaBsVAQRF5TRyr4Se95Wheaz67G3g@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Laurent Bigonville <bigon@bigon.be>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:30=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Tue, Jun 24, 2025 at 09:24:07AM -0500, Bjorn Helgaas wrote:
> > On Mon, Jun 23, 2025 at 07:08:20PM +0200, Lukas Wunner wrote:
> > > pcie_portdrv_probe() and pcie_portdrv_remove() both call
> > > pci_bridge_d3_possible() to determine whether to use runtime power
> > > management.  The underlying assumption is that pci_bridge_d3_possible=
()
> > > always returns the same value because otherwise a runtime PM referenc=
e
> > > imbalance occurs.
> > >
> > > That assumption falls apart if the device is inaccessible on ->remove=
()
> > > due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native()=
,
> > > which accesses Config Space to determine whether the device is Hot-Pl=
ug
> > > Capable.   An inaccessible device returns "all ones", which is conver=
ted
> > > to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> > > longer seems Hot-Plug Capable on ->remove() even though it was on
> > > ->probe().
> >
> > This is pretty subtle; thanks for chasing it down.
> >
> > It doesn't look like anything in pci_bridge_d3_possible() should
> > change over the life of the device, although acpi_pci_bridge_d3() is
> > non-trivial.
> >
> > Should we consider calling pci_bridge_d3_possible() only once and
> > caching the result?  We already call it in pci_pm_init() and save the
> > result in dev->bridge_d3.  That member can be changed by
> > pci_bridge_d3_update(), but we could add another copy that we never
> > update after pci_pm_init().
> >
> > I worry a little that the fix is equally subtle and we could easily
> > reintroduce this issue with future code reorganization.
>
> I think this fix makes sense regardless of whether or not
> the return value of pci_bridge_d3_possible() is cached:
>
> Right now pciehp_is_native() reads the Hot-Plug Capable bit from
> the register even though the bit is cached in pci_dev->is_hotplug_bridge
> and pci_bridge_d3_possible() only calls pciehp_is_native() if that flag
> is set.  In other words, pciehp_is_native() is re-checking the condition
> under which it was called.  That's just nonsensical and superfluous.

Agreed.

> There's only one other caller of pciehp_is_native() and that's
> hotplug_is_native().  Only that other caller needs the register read,
> so it should be moved there.
>
> So I think the question of whether the pci_bridge_d3_possible() return
> value should be cached is orthogonal to this patch.

+1

