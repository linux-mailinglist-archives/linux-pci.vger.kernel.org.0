Return-Path: <linux-pci+bounces-39195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E8C031A8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D4F19C495E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524734D4EE;
	Thu, 23 Oct 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="s/BqqRVh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F334D4E8;
	Thu, 23 Oct 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245843; cv=none; b=AphKSE/E8uiacKybucoDYr757qJYEllosBHZeeOeUqgvYb+pBh3BDxXVdWslxceuSMhn7efeZfOW1zMJL1F0gb8zmv61uSd5VzyhjAY/fQ2an+mGx7ykR914Czrd8JZaxZvMHGbYnNMvfM6Es06y6G1HiFl24ml4VvoovjmCIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245843; c=relaxed/simple;
	bh=6wX8LHFlafAw8mfqmlMLn51I+U9gs1h4LFipTaYP3fw=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=j/3gLH7d+bgp82lFiH0mC7VrMjtGk8vG/xZPS0KoTb1yiSPg30Uji2/Y3O7XBRqPacF2/5F/YoJ9bxcAOAIklO8y1vGsbIGJ/DWzn84Xa9M/N9lGleeLIKPXOEAhLBi2FJu2bACPJr6bV3vvsEqmptDgLzGfqNqPm3YDDZZQvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=s/BqqRVh; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 704B840D1C;
	Thu, 23 Oct 2025 20:57:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761245838; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jFoaeG/1d3oJARkrn8yECO2RwXWx0Noto3/Vpddq4gE=;
	b=s/BqqRVhShF5evNuCamVwBbWlzR1H4GanU9Rz3oGQ2MNqRTY/lk0SrY+zf/g2KUGFl6EBy
	hUqIaUJ45JG/vdg6Zv/XWm4i5sU88I5GXa7E0G2V9cPTtslidtZrwooba+6z2PGX6TAcu/
	IfQX50fnCi6r8BHx6myoT+EnVzqn3515v527cJNX7CHyodhC4Y4XFSJZ2Gd4wlnf4SoAOX
	DB8zDXT6Fbi2JWfmLmLKKnieKOQT8i5q1bIjoQ5qBZd3Gl/cOWc0wIyIuTvnOFaglSrMHQ
	9lUDjZfl0qp6dF8fW8ne7cyHDI1YwEMfeneul+gN26u/3kaU2WDYfYwa9TZQwA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <fxakjhx7lrikgs4x3nbwgnhhcwmlum3esxp2dj5d26xc5iyg22@wkbbwysh3due>
Content-Type: text/plain; charset="utf-8"
References: <20251014184905.GA896847@bhelgaas>
 <0899e629-eaaf-1000-72b5-52ad977677a8@manjaro.org> <fxakjhx7lrikgs4x3nbwgnhhcwmlum3esxp2dj5d26xc5iyg22@wkbbwysh3due>
Date: Thu, 23 Oct 2025 20:57:13 +0200
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "FUKAUMI Naoki" <naoki@radxa.com>, manivannan.sadhasivam@oss.qualcomm.com, "Bjorn Helgaas" <bhelgaas@google.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, =?utf-8?q?David_E=2E_Box?= <david.e.box@linux.intel.com>, "Kai-Heng Feng" <kai.heng.feng@canonical.com>, =?utf-8?q?Rafael_J=2E_Wysocki?= <rafael@kernel.org>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Chia-Lin Kao" <acelan.kao@canonical.com>, linux-rockchip@lists.infradead.org, regressions@lists.linux.dev, "Shawn Lin" <shawn.lin@rock-chips.com>, "Diederik de Haas" <diederik@cknow-tech.com>, "Heiko Stuebner" <heiko@sntech.de>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b3e60f4e-6351-8303-6ad2-9e72849ccd18@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 1/2] =?utf-8?q?PCI/ASPM=3A?= Override the ASPM 
 and Clock PM states set by BIOS for devicetree platforms
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Manivannan,

On Wednesday, October 15, 2025 08:22 CEST, Manivannan Sadhasivam <mani@=
kernel.org> wrote:
> On Wed, Oct 15, 2025 at 01:33:35AM +0200, Dragan Simic wrote:
> > On Tuesday, October 14, 2025 20:49 CEST, Bjorn Helgaas <helgaas@ker=
nel.org> wrote:
> > > On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > > > I've noticed an issue on Radxa ROCK 5A/5B boards, which are bas=
ed on the
> > > > Rockchip RK3588(S) SoC.
> > > >=20
> > > > When running Linux v6.18-rc1 or linux-next since 20250924, the =
kernel either
> > > > freezes or fails to probe M.2 Wi-Fi modules. This happens with =
several
> > > > different modules I've tested, including the Realtek RTL8852BE,=
 MediaTek
> > > > MT7921E, and Intel AX210.
> > > >=20
> > > > I've found that reverting the following commit (i.e., the patch=
 I'm replying
> > > > to) resolves the problem:
> > > > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> > >=20
> > > Thanks for the report, and sorry for the regression.
> > >=20
> > > Since this affects several devices from different manufacturers a=
nd (I
> > > assume) different drivers, it seems likely that there's some issu=
e
> > > with the Rockchip end, since ASPM probably works on these devices=
 in
> > > other systems.  So we should figure out if there's something wron=
g
> > > with the way we configure ASPM, which we could potentially fix, o=
r if
> > > there's a hardware issue and we need some king of quirk to preven=
t
> > > usage of ASPM on the affected platforms.
> > >=20
> > > Can you collect a complete dmesg log when booting with
> > >=20
> > >   ignore=5Floglevel pci=3Dearlydump dyndbg=3D"file drivers/pci/* =
+p"
> > >=20
> > > and the output of "sudo lspci -vv"?
> > >=20
> > > When the kernel freezes, can you give us any information about wh=
ere,
> > > e.g., a log or screenshot?
> > >=20
> > > Do you know if any platforms other than Radxa ROCK 5A/5B have thi=
s
> > > problem?
> >=20
> > After thinking quite a bit about it, I think we should revert this
> > patch and replace it with another patch that allows per-SoC, or
> > maybe even per-board, opting into the forced enablement of PCIe
> > ASPM.  Let me explain, please.
>=20
> ASPM is a PCIe device specific feature, nothing related to SoC/board.=
 Even if
> you limit it to certain platforms, there is no guarantee that it will=
 be safe as
> the users can connect a buggy device to the slot and it could lead to=
 the same
> issue.

I'm hoping that it's clear by now that the theory and practice
actually diverge in this case, requiring certain level of support
for different SoCs and boards, which makes ASPM more than just
a device feature that's simply expected to work by default.

Dealing with buggy PCIe devices is, of course, another part of
the entire endeavor.

> > When a new feature is introduced, it's expected that it may fail
> > on some hardware or with some specific setups, so quirking off such
> > instances, as time passes, is perfectly fine.  Such a new feature
> > didn't work before it was implemented, so it's acceptable that it
> > fails in some instances after the introduction, and that it gets
> > quirked off as time passes and more testing is performed.
>=20
> ASPM is not a new feature. It was introduced more than a decade befor=
e. But we
> somehow procastinated the enablement for so long until we realized th=
at if we
> don't do it now, we wouldn't be able to do it anytime in the future.

To clarify, I referred to PCIe as the already established feature,
which evidently became broken on some SoCs and boards with the
initial blanket enabling of ASPM.

> > However, when some widespread feature, such as PCIe, has already
> > been in production for quite a while, introducing high-risk changes
> > to it in a blanket fashion, while intending to have the incompatibl=
e
> > or not-yet-ready platforms quirked off over time, simply isn't the
> > way to go.  Breaking stuff intentionally to find out what actually
> > doesn't work is rarely a good option.
>=20
> The issue is due to devices exposing ASPM capability, but behaving er=
ratically
> when enabled. Until, we enable ASPM on these devices, we cannot know =
whether
> they are working or not. To avoid mass chaos, we decided to enable it=
 only for
> devicetree platforms as a start.

As mentioned above, dealing with buggy PCIe devices is something
to be covered separately, and wasn't the subject of my complaint.
I referred to the SoC and board specifics.

> > Thus, I'd suggest that this patch is replaced with nother patches,
> > which would introduce an additional ASPM opt-in switch to the PCI
> > binding, allowing SoCs or boards to have it enabled =5Fafter=5F pro=
per
> > testing is performed.  The PCIe driver may emit a warning that ASPM
> > is to be enabled at some point in the future, to "bug" people about
> > the need to perform the testing, etc.
>=20
> Even if we emit a "YOUR DEVICE MAY BREAK" warning, nobody would care =
as long as
> the device works for them. We didn't decide to enable this feature ov=
ernight to
> trouble users. The fact that ASPM saves runtime power, which will ben=
efit users
> and ofc the environment as a whole, should not be kept disabled.
>=20
> But does that mean, we wanted to have breakages, NO. We expected brea=
kages as
> not all devices will play nicely with ASPM, but there is only one way=
 to find
> out. And we do want to disable ASPM only for those devices.

I see, and it has turned out rather well in the end.  I totally
understand the frustration that may come out of people not caring
for something until it actually breaks, but as you can see, the
Rockchip community, including people from Rockchip itself, actually
cares quite a lot and is willing to help in different ways.

> >  With all that in place, we
> > could expect that in a year or two PCIe ASPM could eventually be
> > enabled everywhere.  Getting everything tested is a massive endeavo=
r,
> > but that's the only way not to break stuff.
> >=20
> > Biting the bullet and hoping that it all goes well, I'd say, isn't
> > the right approach here.
>=20
> Your two year phased approach would never work as that's what
> we have hoped for more than a decade.

Totally understood, but again, perhaps you haven't knocked at the
right doors.  The Rockchip community cares, for example. :)


