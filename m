Return-Path: <linux-pci+bounces-38202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FFBDE3F9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE6019A7A02
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA030BBA8;
	Wed, 15 Oct 2025 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="Ns/qkxdG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE022D8DD1
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527425; cv=none; b=iteWs5/yggO2iS9nz7kzLA1i+kD8jFENGMmavjXHDE0iqmEwrumJQmZ9S5bFS3UZqXuCBhOR/h5iZ4WkFhtD46C4tNH8n/tNLOXB5HEvUto0JlKSv/7JhurCOoRBCyR9Jjs01CtWgUKeVESi8lQCCJEjg8nAsSiDnKxaIMs08Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527425; c=relaxed/simple;
	bh=CpGOzMU0fwoe6i5d3r5OB2Uo9e6IHzCntzlcK873gO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Im9RLz20LfLSR7rsoNb5rdLHPTElq9qDA9PU8rOaYdQMxDygsWdYB3T1yL8isedDl1aFdQTETTD4kZA9yvLg6JBNZhlSXlOCUPilaXrpI52p9W5QKdQ3KtE3avDoMOxc0EzqRQwGBEj5lpXZAJDZaE+0Z7xl3yNTsVi85lg9ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=Ns/qkxdG; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1760527411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7suAm308V4lZ0hWGhrJ2JZyDcNujKQFY+XgzAQyH74=;
	b=Ns/qkxdG4Rn4EJ6K7SljnQBvNEjMaDrTB1/ElfNZiulj3sQwibhvq0PesIrmmY9Q+1Fjyh
	W6KEAEZMP4FHHqQXoPQkIGtpTnZTo3mGwN+zRnb9//J8E8WST3wXkpfQhVAP5YmQ4XUseb
	2ZoztiG2+qY0MkG4AoM+KPkAjPkwwWLx8yPwhvjnfrkQ8xeOEgQoyCQRF+2yAEEanIgmyb
	WbOxFaMqFU0rqn7Gs8QJBI21LssXjs1jwsEp9rMbsWRQkvhQo902VwYlMmEANvpyOsP3qP
	76AQOGgWsDq0ZZrJe2F+dNLnvCGZlyTWU2VtEEQ2Uk4m/zine4e/pTswHh4E4Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 13:23:10 +0200
Message-Id: <DDIUVHT9W10K.2SHEZ7YWCDXL3@cknow-tech.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>, "Dragan Simic"
 <dsimic@manjaro.org>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "FUKAUMI Naoki" <naoki@radxa.com>,
 <manivannan.sadhasivam@oss.qualcomm.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Rob
 Herring" <robh@kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>, "David E.
 Box" <david.e.box@linux.intel.com>, "Kai-Heng Feng"
 <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Chia-Lin Kao"
 <acelan.kao@canonical.com>, <linux-rockchip@lists.infradead.org>,
 <regressions@lists.linux.dev>
References: <20251014184905.GA896847@bhelgaas>
 <0899e629-eaaf-1000-72b5-52ad977677a8@manjaro.org>
 <fxakjhx7lrikgs4x3nbwgnhhcwmlum3esxp2dj5d26xc5iyg22@wkbbwysh3due>
In-Reply-To: <fxakjhx7lrikgs4x3nbwgnhhcwmlum3esxp2dj5d26xc5iyg22@wkbbwysh3due>
X-Migadu-Flow: FLOW_OUT

On Wed Oct 15, 2025 at 8:22 AM CEST, Manivannan Sadhasivam wrote:
> On Wed, Oct 15, 2025 at 01:33:35AM +0200, Dragan Simic wrote:
>> On Tuesday, October 14, 2025 20:49 CEST, Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
>> > On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
>> > > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on=
 the
>> > > Rockchip RK3588(S) SoC.
>> > >=20
>> > > When running Linux v6.18-rc1 or linux-next since 20250924, the kerne=
l either
>> > > freezes or fails to probe M.2 Wi-Fi modules. This happens with sever=
al
>> > > different modules I've tested, including the Realtek RTL8852BE, Medi=
aTek
>> > > MT7921E, and Intel AX210.
>> > >=20
>> > > I've found that reverting the following commit (i.e., the patch I'm =
replying
>> > > to) resolves the problem:
>> > > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
>> >=20
>> > <snip>
>> >=20
>> > Do you know if any platforms other than Radxa ROCK 5A/5B have this
>> > problem?
>> >=20
>> After thinking quite a bit about it, I think we should revert this
>> patch and replace it with another patch that allows per-SoC, or
>> maybe even per-board, opting into the forced enablement of PCIe
>> ASPM.  Let me explain, please.
>
> ASPM is a PCIe device specific feature, nothing related to SoC/board. Eve=
n if
> you limit it to certain platforms, there is no guarantee that it will be =
safe as
> the users can connect a buggy device to the slot and it could lead to the=
 same
> issue.
>
>> When a new feature is introduced, it's expected that it may fail
>> on some hardware or with some specific setups, so quirking off such
>> instances, as time passes, is perfectly fine.  Such a new feature
>> didn't work before it was implemented, so it's acceptable that it
>> fails in some instances after the introduction, and that it gets
>> quirked off as time passes and more testing is performed.
>
> ASPM is not a new feature. It was introduced more than a decade before. B=
ut we
> somehow procastinated the enablement for so long until we realized that i=
f we
> don't do it now, we wouldn't be able to do it anytime in the future.

Do you mean literally *now* or more like "we need to do it sometime"?

>> However, when some widespread feature, such as PCIe, has already
>> been in production for quite a while, introducing high-risk changes
>> to it in a blanket fashion, while intending to have the incompatible
>> or not-yet-ready platforms quirked off over time, simply isn't the
>> way to go.  Breaking stuff intentionally to find out what actually
>> doesn't work is rarely a good option.
>
> The issue is due to devices exposing ASPM capability, but behaving errati=
cally
> when enabled. Until, we enable ASPM on these devices, we cannot know whet=
her
> they are working or not. To avoid mass chaos, we decided to enable it onl=
y for
> devicetree platforms as a start.
>
>> Thus, I'd suggest that this patch is replaced with nother patches,
>> which would introduce an additional ASPM opt-in switch to the PCI
>> binding, allowing SoCs or boards to have it enabled _after_ proper
>> testing is performed.  The PCIe driver may emit a warning that ASPM
>> is to be enabled at some point in the future, to "bug" people about
>> the need to perform the testing, etc.
>
> Even if we emit a "YOUR DEVICE MAY BREAK" warning, nobody would care as l=
ong as
> the device works for them. We didn't decide to enable this feature overni=
ght to
> trouble users. The fact that ASPM saves runtime power, which will benefit=
 users
> and ofc the environment as a whole, should not be kept disabled.
>
> But does that mean, we wanted to have breakages, NO. We expected breakage=
s as
> not all devices will play nicely with ASPM, but there is only one way to =
find
> out. And we do want to disable ASPM only for those devices.

I understand this logic. And I'm very much in favor of changes that
reduce power usage.
I suspect that 6.18 will become a LTS kernel, so introducing a change
which may break many devices, sounds less then ideal for such a kernel.
Kernel 6.19 OTOH sounds perfect for that. Then there's plenty of time to
encounter and fix issues which may/will come up before there is another
LTS kernel, namely ~ a year.

My 0.02.

Cheers,
  Diederik

PS: will send my bug/debug report separately

>> With all that in place, we could expect that in a year or two PCIe ASPM
>> could eventually be enabled everywhere. Getting everything tested is a
>> massive endeavor, but that's the only way not to break stuff.
>>=20
>> Biting the bullet and hoping that it all goes well, I'd say, isn't
>> the right approach here.
>
> Your two year phased approach would never work as that's what we have hop=
ed for
> more than a decade.
>
> - Mani


