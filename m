Return-Path: <linux-pci+bounces-38098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD5BDBCF8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 01:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F176E4E054E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2ED2BDC0E;
	Tue, 14 Oct 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vhS0cTXZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473823AB8B;
	Tue, 14 Oct 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484824; cv=none; b=RXJst8N9UcLQDJbVy/Mav304FLDR1JmQHqH3ggp1akfZtRJldFf5Jn+wjFTA/MBhIahabFJczCUcUU9p7DmQtpXMv0GORJytsxh4e0PH5SfbULkWGKlo4BZyqRC/dEev3E1uS1HlRHKCG8HLhH6ksFiINkKS77MSBRx6FzO6p7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484824; c=relaxed/simple;
	bh=FUckzT2mOKStqUfAnm09CjkDqr0yKBb2UlrR+RXVhxw=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=AjJ+r/0DftpRBgyL1PJVDymWdh/etAEaMngweZPG0k3vFu6MqwsjVrH6YZJMHCLJ7wWsAchjH4ww/IAD9djPdwOA2d5mdwBTtojwl/PjJK7Hwf8aDKgDBOaI16+dpVGDmrlqB5C/oJa7RjGtMPZH1HcxIuLV6jRi6oMtHLac7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vhS0cTXZ; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id CB9AB40C22;
	Wed, 15 Oct 2025 01:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760484819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ahRdwrjWfMe0hKH1Tt1jKBLeldYczMpX7xtNUT0Ar2o=;
	b=vhS0cTXZ1xd5DotYvzh1ii/gTMCLq3J1q+msKWoRt8k+J3S9YpBI3ZZeFoX5RRx0tgWTIU
	bNYT5/dNi1mETlfmNXXfBd7QXUtoWx7k6OJuA955cTp6LOB9HzI255LP7a+pMsnaxi3Alv
	p+dhEKd2Gysxwwu5gPOPtsj1z9AIOYxo35JrBcZmhKjtw1qTFw7Vylz4gQUSPj1C3foD+4
	8eWrst8K+SGpfXyc8AdglJF7gGgxlC+xNb3yeCzUJ1a1jzGhWBHAv3frava2krodiSW4xe
	C6+eQ+FAQBncWvr4e17sqxI8pXinVkG/3FRbJGPJv4CnehCb0hbVAMY6I75mfg==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20251014184905.GA896847@bhelgaas>
Content-Type: text/plain; charset="utf-8"
References: <20251014184905.GA896847@bhelgaas>
Date: Wed, 15 Oct 2025 01:33:35 +0200
Cc: "FUKAUMI Naoki" <naoki@radxa.com>, manivannan.sadhasivam@oss.qualcomm.com, "Bjorn Helgaas" <bhelgaas@google.com>, "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, =?utf-8?q?David_E=2E_Box?= <david.e.box@linux.intel.com>, "Kai-Heng Feng" <kai.heng.feng@canonical.com>, =?utf-8?q?Rafael_J=2E_Wysocki?= <rafael@kernel.org>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Chia-Lin Kao" <acelan.kao@canonical.com>, linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0899e629-eaaf-1000-72b5-52ad977677a8@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 1/2] =?utf-8?q?PCI/ASPM=3A?= Override the ASPM 
 and Clock PM states set by BIOS for devicetree platforms
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello all,

On Tuesday, October 14, 2025 20:49 CEST, Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based o=
n the
> > Rockchip RK3588(S) SoC.
> >=20
> > When running Linux v6.18-rc1 or linux-next since 20250924, the kern=
el either
> > freezes or fails to probe M.2 Wi-Fi modules. This happens with seve=
ral
> > different modules I've tested, including the Realtek RTL8852BE, Med=
iaTek
> > MT7921E, and Intel AX210.
> >=20
> > I've found that reverting the following commit (i.e., the patch I'm=
 replying
> > to) resolves the problem:
> > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
>=20
> Thanks for the report, and sorry for the regression.
>=20
> Since this affects several devices from different manufacturers and (=
I
> assume) different drivers, it seems likely that there's some issue
> with the Rockchip end, since ASPM probably works on these devices in
> other systems.  So we should figure out if there's something wrong
> with the way we configure ASPM, which we could potentially fix, or if
> there's a hardware issue and we need some king of quirk to prevent
> usage of ASPM on the affected platforms.
>=20
> Can you collect a complete dmesg log when booting with
>=20
>   ignore=5Floglevel pci=3Dearlydump dyndbg=3D"file drivers/pci/* +p"
>=20
> and the output of "sudo lspci -vv"?
>=20
> When the kernel freezes, can you give us any information about where,
> e.g., a log or screenshot?
>=20
> Do you know if any platforms other than Radxa ROCK 5A/5B have this
> problem?

After thinking quite a bit about it, I think we should revert this
patch and replace it with another patch that allows per-SoC, or
maybe even per-board, opting into the forced enablement of PCIe
ASPM.  Let me explain, please.

When a new feature is introduced, it's expected that it may fail
on some hardware or with some specific setups, so quirking off such
instances, as time passes, is perfectly fine.  Such a new feature
didn't work before it was implemented, so it's acceptable that it
fails in some instances after the introduction, and that it gets
quirked off as time passes and more testing is performed.

However, when some widespread feature, such as PCIe, has already
been in production for quite a while, introducing high-risk changes
to it in a blanket fashion, while intending to have the incompatible
or not-yet-ready platforms quirked off over time, simply isn't the
way to go.  Breaking stuff intentionally to find out what actually
doesn't work is rarely a good option.

Thus, I'd suggest that this patch is replaced with nother patches,
which would introduce an additional ASPM opt-in switch to the PCI
binding, allowing SoCs or boards to have it enabled =5Fafter=5F proper
testing is performed.  The PCIe driver may emit a warning that ASPM
is to be enabled at some point in the future, to "bug" people about
the need to perform the testing, etc.  With all that in place, we
could expect that in a year or two PCIe ASPM could eventually be
enabled everywhere.  Getting everything tested is a massive endeavor,
but that's the only way not to break stuff.

Biting the bullet and hoping that it all goes well, I'd say, isn't
the right approach here.


