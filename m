Return-Path: <linux-pci+bounces-30584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE1AE7B48
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8AD7A5792
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE920DD40;
	Wed, 25 Jun 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy7n3BJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A51FBE9B
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841807; cv=none; b=QAqleHrYdQN2eMghOObL9EPbolAlhVXfiVIudmeag1ONPpdr9HRd1DZnrcOYnwj9Y9O92OZY0WoYU7HOhFVsDyq4LhcSCbWa/o7n4QjG3WbqCXNBtweYF2AM/UUCDp/xHKETO69R0nkS0abFChz+Ud8Uim0aQK4PixomI6dqk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841807; c=relaxed/simple;
	bh=zO69UkzGKJha8QhPvZueZjURt8TlwyYoRghEMovlwSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN0w2yggvouQQrYSgVicK+n7NuoIpzzKlZQ941yUu3iDnZmK3+x9zuuj2FPyy6/oRyHW7jDNjTYfbHdl17QdKLL2GTnAFHj5K5OjHc0d3HkicA1mGsKrrvISJFVH/K3mUgTVD1vcHP1gDbdU3zKOn4gr3fWIpTJoF9qBaqYhSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy7n3BJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2874DC4CEF3
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750841807;
	bh=zO69UkzGKJha8QhPvZueZjURt8TlwyYoRghEMovlwSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wy7n3BJN+HfNkaCf+YohTC/mZCjpCxhk91VckhiNJkqAcjFqT6Zkji9rsjtcvSpmI
	 B/W5NUZT2uTRkCXzb86UZGlmLh497xrh9svDGYhqAwqtkuwIFksZ9R2tmDmz3+NL0S
	 AfFdMPqdgXLQDEqfqEkJ17thCIq5ZIWT5hWvU8uidXdcv3XHfiNl4zeFt9zHdPm99H
	 GXm7QL9gtMQ10kko7Xls+nl/yXSnT6ssVRtBb5gT5yWh/HjsRxuDWUvyGds0kqXb+k
	 O+zQaQo3f8RoujfvRb75PqUCMWwSCdfa/7GuaPevtgCn0jN0D7ZHJUrnLXVkuoNKSC
	 DPfq4bceKiNgA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ef891cd058so1593816fac.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 01:56:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5ZSBkAXOjDfZ9JqUmpC5BLukdLrTf/ii5pX8f6jPggG4b1abDtZewOP7+dkYZ9HvCX7MonYJwl+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHKXlCI5ufcavel0RYwPco27X3uF6QYKeoQp1A34/+sPsDcxL
	8DgVNncDILuF8729GXlAGehrWnWjWmpM1JxlXIPUTh4qYDOK/+CVttU3AmtX57kZ0JAOkf9ZFll
	QPsXY+mC6+resw1rhCGBb8GNAn0/Y1qs=
X-Google-Smtp-Source: AGHT+IHpITz6giHTujR2exkzneh08LzqNgKmhnz00FEhIXReP0m1FK3vl+C+3jWsQ0gB1HHz5JAYRBsAO4hdKV4OMyo=
X-Received: by 2002:a05:6870:819d:b0:2e8:ed1c:ae61 with SMTP id
 586e51a60fabf-2efb2436e08mr1440352fac.37.1750841806355; Wed, 25 Jun 2025
 01:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
 <20250624142407.GA1473261@bhelgaas> <aFunQlDHNyQV4S_W@wunner.de>
In-Reply-To: <aFunQlDHNyQV4S_W@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Jun 2025 10:56:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hbNsErz-VMt2a3-VeWEdgpJbrjf0S+xpsb113At=y3bA@mail.gmail.com>
X-Gm-Features: Ac12FXyBPsn8w1qHXDeSzlPPGNzDKHrTZlxtemLd4mwr4XnWXEdIn_6Zk7OVqtc
Message-ID: <CAJZ5v0hbNsErz-VMt2a3-VeWEdgpJbrjf0S+xpsb113At=y3bA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Laurent Bigonville <bigon@bigon.be>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 9:37=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
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
>
> If we did that, I think we'd still want to have a WARN_ON() like this in
> pcie_portdrv_remove():
>
> +       WARN_ON(dev->bridge_d3_orig !=3D pci_bridge_d3_possible(dev));
> +
> +       if (dev->bridge_d3_orig) {
> -       if (pci_bridge_d3_possible(dev)) {
>
> Because without the WARN_ON(), such bugs would fly under the radar.
>
> However currently we get the WARN_ON() for free because of the runtime PM
> refcount underflow.
>
> So caching the original return value of pci_bridge_d3_possible(dev)
> wouldn't be a net positive.
>
> Also note that the bug isn't catastrophic:  The struct device is about
> to be free()'d anyway because it's been hot-removed.  It's just the
> annoying warning message that we want to get rid of.
>
> But maybe we should amend the kernel-doc of pci_bridge_d3_possible()
> to clearly state that the return value must be constant across the
> entire lifetime of the device.

Yes, please!

