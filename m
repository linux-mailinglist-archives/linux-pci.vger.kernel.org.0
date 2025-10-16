Return-Path: <linux-pci+bounces-38383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1657BE4E36
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C87C5049F8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BB20E032;
	Thu, 16 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="QI/JRjrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99004EED8
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636363; cv=none; b=C0J3OXz/Rp0ZcrhNChLSje/UQRaP8Y3lt8fDihKWiOAYmxKbHDhPgAGrpqs8xWEx8vt/rdR5asnogdDTGqHC6OdrrvFR92Jps/Vl8Egkqw0soClJu6O5YnriPyTlhMR6ilfRXDmK4aQMJJt+qqxrO7Wel+lQDBMGxJLpSTixQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636363; c=relaxed/simple;
	bh=LbYf6I98/WH0RIxNWHEI4QVgY4YtUTKk80hGt/CmH5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dRDwO8Li3NfP98NElpvrAH8frriMjT5agCXfDKehSME9lEOgoInfZIJzWQre+FAc+Gk0GLas+7E4n4DKCwX+zujDogRhRG8xvsIsxHEaW+hVdQ/Q+jNL3iorR64cJxdAWZ8RZIFPRWjMm8OnuMAzt3viSjNnBTEIsqnp4octgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=QI/JRjrJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1760636348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxNz2ubVhmwaha5Dqcv6zgBsEC/I+M6eOK/y6A/nxQo=;
	b=QI/JRjrJcWwm7qCShTbcH1hAx/WOPeP9mCfiyD27m2c29VqT1yZhG7vae0/qHoRYSf1Icd
	mgq+glxC/dq6OQ05VctLPoDzYQ2feuIx7C7wtpO9IRufsqnwq3TRM/epaKQtdOeiUJS8Ju
	3FN8/dvb9cshxlJOAz1Lcf2XiGShgLp7PTQna+rg1nIS+pMBLb71oh5UUh/hwAL1YPO0bv
	1j9bHXdIF/x15JE2q+f7P8Ao9E0guri6YdR7ny3s+la0DByxYdXb0wcb2KTpkqYG3BEkgN
	Qq/lcGJLlVpfAWZemabMQeZjl53GCKeNqT4CrlAwoeNIl2nT8EsajYTHACCT6w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 19:38:57 +0200
Message-Id: <DDJXHRIRGTW9.GYC2ULZ5WQAL@cknow-tech.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "FUKAUMI Naoki" <naoki@radxa.com>,
 <manivannan.sadhasivam@oss.qualcomm.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, "David E. Box"
 <david.e.box@linux.intel.com>, "Kai-Heng Feng"
 <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Chia-Lin Kao"
 <acelan.kao@canonical.com>, "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>, <regressions@lists.linux.dev>, "Ulf
 Hansson" <ulf.hansson@linaro.org>
References: <DDIW7ZP5K1VR.2I7VW56B9CZLF@cknow-tech.com>
 <20251015225033.GA945930@bhelgaas>
In-Reply-To: <20251015225033.GA945930@bhelgaas>
X-Migadu-Flow: FLOW_OUT

On Thu Oct 16, 2025 at 12:50 AM CEST, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2025 at 02:26:30PM +0200, Diederik de Haas wrote:
>> On Tue Oct 14, 2025 at 8:49 PM CEST, Bjorn Helgaas wrote:
>> > On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
>> >> I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on =
the
>> >> Rockchip RK3588(S) SoC.
>> >>=20
>> >> When running Linux v6.18-rc1 or linux-next since 20250924, the kernel=
 either
>> >> freezes or fails to probe M.2 Wi-Fi modules. This happens with severa=
l
>> >> different modules I've tested, including the Realtek RTL8852BE, Media=
Tek
>> >> MT7921E, and Intel AX210.
>> >>=20
>> >> I've found that reverting the following commit (i.e., the patch I'm r=
eplying
>> >> to) resolves the problem:
>> >> commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
>> >
>> > Can you collect a complete dmesg log when booting with
>> >
>> >   ignore_loglevel pci=3Dearlydump dyndbg=3D"file drivers/pci/* +p"
>> >
>> > and the output of "sudo lspci -vv"?
>>=20
>> I have a Rock 5B as well, but I don't have a Wi-Fi module, but I do have
>> a NVMe drive connected. That boots fine with 6.17, but I end up in a
>> rescue shell with 6.18-rc1. I haven't verified that it's caused by the
>> same commit, but it does sound plausible.
>
> FWIW, my expectation is that booting with "pcie_aspm=3Doff" should
> effectively avoid the ASPM enabling and behave similarly to reverting
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms").  My hope was that we could boot that way and
> incrementally enable ASPM via sysfs a device at a time for testing.
>
> [Moved last lines up here]
> Bottom line, I don't think I can get any further with this particular
> issue until we confirm that f3ac2ff14834 ("PCI/ASPM: Enable all
> ClockPM and ASPM states for devicetree platforms") is the cause.

I built a 6.18-rc1 kernel with that commit reverted and when booted up,
I could mount my NVMe drive. Next I removed the 'noauto' from /etc/fstab
and rebooted and that succeeded as well.
So I think we can conclude that commit f3ac2ff14834 is the cause.

>> On this device, the NVMe isn't strictly needed (I used it to compile my
>> kernels on), so I added 'noauto' to the NVMe line in /etc/fstab ... and
>> that made it boot successfully into 6.18-rc1. Then running the 'mount'
>> command wrt that NVMe drive failed with this message:
>>=20
>>   EXT4-fs (nvme0n1p1): unable to read superblock
>>=20
>> The log of my attempts can be found here:
>> https://paste.sr.ht/~diederik/f435eb258dca60676f7ac5154c00ddfdc24ac0b7
>
> Thanks for the log, it's very useful.  This is pieced together from
> the serial console log and the "dmesg --level" output, but I think
> it's all the same boot:

Correct.

>   ...
>   [   18.921811] rockchip-pm-domain fd8d8000.power-management:power-contr=
oller: sync_state() pending due to fdad0000.npu
>   [   18.922737] rockchip-pm-domain fd8d8000.power-management:power-contr=
oller: sync_state() pending due to fdb50000.video-codec
>   ...
>
> The earlydump info shows the 00:00.0 Root Port had I/O+ Mem+
> BusMaster+ (0x0107) and the 01:00.0 NVMe initially had I/O- Mem-
> BusMaster- (0x0000).  We were able to enumerate the NVMe device and
> assign its BAR, and the nvme driver turned on Mem+ (0x002).
>
>   nvme_timeout
>     csts =3D readl(dev->bar + NVME_REG_CSTS)
>     if (nvme_should_reset(csts))
>       nvme_warn_reset(csts)
>         result =3D pci_read_config_word(PCI_STATUS)
>         "controller is down; will reset: CSTS=3D0xffffffff, ... failed (1=
34)"
>     nvme_dev_disable
>
> But I think the NVMe device was powered down to D3cold somewhere
> before 39.971050.  I don't know if the power-controller messages at
> 18.921811 have any connection, and I don't know why ASPM would be
> related.

I highly doubt they're connected. These threads are relevant:
https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
https://lore.kernel.org/all/20250909111130.132976-1-ulf.hansson@linaro.org/
https://lore.kernel.org/all/20251007094312.590819-1-ulf.hansson@linaro.org/

TL;DR: Those warnings will (likely) be downgraded to 'info'.

Cheers,
  Diederik

