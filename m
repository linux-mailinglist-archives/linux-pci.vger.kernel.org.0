Return-Path: <linux-pci+bounces-32971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597AB12C75
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 22:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCEC16926D
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC215155C97;
	Sat, 26 Jul 2025 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrhJCMtt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983467DA9C
	for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563147; cv=none; b=JpVkIGmTxbuTJ+RsUxtySE8xaB4m/eBZHBCxm6pNHBfeexCJY1KEg9RWfdMP7OAg4b0x2qiylmJRwNq8LDkE48HtS9rBym5jHCdcpH8ETJLWxf9b4fxr7FpnWZwtm8jFT+aow90ZcvzaKrrbG/NpSeO5nt4HCFn6b9t7O4hrRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563147; c=relaxed/simple;
	bh=B3qFfTn5lgisFwjU62KCXjdjsTN2GvixDzA4KFMnbpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV4iLjNjMnl96QJ5kARNF5jM3FHytkYVOv8HYt2kgG8JJsaUSon1cHOWzBf0f/PKHuiXJOZjq2Srtun/c4VSt4tQKK/ib1fypf9NCs9mywdSpIWGLYiHWbQ426xjMIcy0LmwY2avyD64VF0AcjahECFPVzkzqRa3wCehx+sgLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrhJCMtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EDCC4CEF5
	for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753563147;
	bh=B3qFfTn5lgisFwjU62KCXjdjsTN2GvixDzA4KFMnbpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rrhJCMttv8Tz0LY4t0i8o4lbbKAN1RiVqzy60w72ehjL5IfHeldrSglUbLYYa9tyK
	 DBCvuAadnLFlaetxoWwiXPTPbKEAbr0nYO8kTVBhBzW8hyd14BIh//OtC7d6ie3acB
	 Cfi5nklvcGc/hs5+66agn99VsclJv7MzX0jmvU+DSgJESUg1f0c/eIzPh81+kzefc8
	 cDf64Chdw3FYEuSjV24pNKpqrCkvfy9XjGAdZBYgBWAP7Ib966ILEdhC6IPxsV8rht
	 uqjDSvB4S2d0QfbAihH0rhfG6FyZZtT0pplfiv9yYLHOAItE1Q+QwrVq3Sn4vcIqna
	 O8Mk0RE13BVAw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61593d5f92bso1691886eaf.1
        for <linux-pci@vger.kernel.org>; Sat, 26 Jul 2025 13:52:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRdYpuAq3w+ppEIbqPNEzKkDonmKGlvXmV2IMXEzaTKt3P7v70Jek+2IwSJaTV5QIQ8tHbKFyZ7Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4I0DX+t6xj74fpwim315VV25xjVDPBi6GlZdfSe52U1Zbr0PV
	oQiRgKi3bRxi/M0WkflBVfxrJxSfT2F5lAvV1AOAJ237OVTUNII6O5WqOdbyngdsa2tF4ZTxLev
	W3UNzP5lcdawHIn9rn7LerkrqJY45n2g=
X-Google-Smtp-Source: AGHT+IF30nvzNqG/3v909Kwq975L95TG3KUMK80+DUPNdtgpuIdmCWZVXrK489s8rV/u9H3oSUnyZPowMOX5YdHNfiI=
X-Received: by 2002:a05:6820:2103:b0:611:5a9e:51c4 with SMTP id
 006d021491bc7-618fe208078mr6926721eaf.4.1753563146389; Sat, 26 Jul 2025
 13:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIM99vImO6kwAkO2@wunner.de> <20250725193319.GA3104836@bhelgaas>
In-Reply-To: <20250725193319.GA3104836@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 26 Jul 2025 22:52:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPVT19vjYo+EwT=SaQwxC7F4NhV-W6denMCuuM0eFVGA@mail.gmail.com>
X-Gm-Features: Ac12FXy11Szsy1YkClirotJ15ieXHBgh--s2umpPrvoKvjJpwaCDiUk9WZvUn9g
Message-ID: <CAJZ5v0hPVT19vjYo+EwT=SaQwxC7F4NhV-W6denMCuuM0eFVGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PCI: Clean up and fix is_hotplug_bridge usage
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mika Westerberg <westeri@kernel.org>, 
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, 
	Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [-> to: Rafael for possible ack]
>
> On Fri, Jul 25, 2025 at 10:19:02AM +0200, Lukas Wunner wrote:
> > On Tue, Jul 22, 2025 at 05:35:22PM -0500, Bjorn Helgaas wrote:
> > > On Sun, Jul 13, 2025 at 04:31:00PM +0200, Lukas Wunner wrote:
> > > >   PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
> > > >   PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge
> > > >   PCI: pciehp: Use is_pciehp instead of is_hotplug_bridge
> > > >   PCI: Move is_pciehp check out of pciehp_is_native()
> > > >   PCI: Set native_pcie_hotplug up front based on pcie_ports_native
> > >
> > > Thanks!  I applied these to pci/hotplug, hoping to put them in v6.17.
> > >
> > > I moved the previous pci/hotplug branch to pci/hotplug-pnv_php.
> >
> > Just a heads-up in case it's unintentional, pci/next as of 10 hours ago
> > does not include the following pci.git branches:
> >
> > - hotplug
>
> Thanks for the reminder, I did miss it.  Rafael, would be glad for
> your ack on this one if you have time:
>
>   PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports

ACKed, thanks!

