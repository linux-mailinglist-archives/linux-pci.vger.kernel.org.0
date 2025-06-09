Return-Path: <linux-pci+bounces-29188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE3AD16D5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02663AA6B0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75302157A67;
	Mon,  9 Jun 2025 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=r26.me header.i=@r26.me header.b="mGPh25wP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968922459C9
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436460; cv=none; b=Q6Kgfr2ToCtVQuz4+o5qc7PI1+5rpICsl97XZfvEe8ilUEnrRv4LW8S6gBQtuvx+WvtbwkHEuPxdKZyiJCswq5oSed/cx9iEmtyUUMz8iGc8z62oikrRxM5pJtWHPrRZJsT+JrJO2mCi2DJZPAhuYN0uk2zJu0MkrLfVizSmZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436460; c=relaxed/simple;
	bh=cF91nALyo98uqnpCdLscnnoeoPwnYEha9V/7Ylv8reU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bqwqbeGOqFuNKOSob+Ae99GrZuwCNSlABjqj6d1QOqDkVjJuv0UAb+xViR+t86fvhRAnPRZ0ZeFEjcnY8EGtX4CxYIRp9FY1XyhNdpcj9sY6sd7yTOfoSWhQOyu/WgsDR6hBmY2WBpt4Xjlr5xhik2BQNw4NDgfY1FadRINS4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=mGPh25wP; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail3; t=1749436448; x=1749695648;
	bh=E4/0V+ScOCL1YWcOZGl7HNDKRjUxzVbzYhoKPTQdams=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=mGPh25wPJfJTplQIWmRv7Nv/GcvxOl5TKzK7dyZXG1+6qY4bot6UP9/vsa1+qA8K/
	 xAGRD/ATtBExc2HLBbbkXMOW7V7ESd9jtTjiV7mZLSnLglbXUXC3D5XW5VUCLaHz1h
	 89cY798xsjTf5lQS/sbEEBbCgb2HMFb8SLoFsJ63+NCAWCjeNkub8o8ekvfKaK8umK
	 7bm/fF686Cc95ThQrAPw/1I6hYzKuCM32PXVl5IjZVmfuqUqMNcNR+iNm6TycERDUs
	 WLtnNkv1fQ0e03vfnuAlqhvaQewjr2vMs3QhvDXHLWw04+NUdkXZ0RvweXSEjBJY9v
	 DamKbrP+eAHIg==
Date: Mon, 09 Jun 2025 02:34:02 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: rio@r26.me
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [REGRESSION] amdgpu fails to load external RX 580 since PCI: Allow relaxed bridge window tail sizing for optional resources
Message-ID: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: a555cdadbafdaf62f831901f8970a7dd72bc3e2f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I have an external Radeon RX580 on my machine connected via Thunderbolt, an=
d
since upgrading from 6.14.1 the setup stopped working. Dmesg showed warning=
 from
resource sanity check, followed by a stack trace https://pastebin.com/njR55=
rQW.
Relevant snippet:

[   12.134907] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001fffff 64=
bit pref]: releasing
[   12.134910] [drm:amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* Problem r=
esizing BAR0 (-16).
[   12.135456] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001fffff 64=
bit pref]: assigned
[   12.135524] amdgpu 0000:06:00.0: amdgpu: VRAM: 8192M 0x000000F400000000 =
- 0x000000F5FFFFFFFF (8192M used)
[   12.135527] amdgpu 0000:06:00.0: amdgpu: GART: 256M 0x000000FF00000000 -=
 0x000000FF0FFFFFFF
[   12.135536] resource: resource sanity check: requesting [mem 0x000000000=
0000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0x0=
00a0000-0x000bffff window]
[   12.135542] ------------[ cut here ]------------
[   12.135543] WARNING: CPU: 6 PID: 599 at arch/x86/mm/pat/memtype.c:721 me=
mtype_reserve_io+0xfc/0x110
[   12.135551] Modules linked in: ccm amdgpu(+) snd_hda_codec_realtek ...
[   12.135652] CPU: 6 UID: 0 PID: 599 Comm: (udev-worker) Tainted: G S     =
             6.15.0-13743-g8630c59e9936 #16 PREEMPT(full)  3b462c924b3ffd81=
56fc3b77bcc8ddbf7257fa57
[   12.135654] Tainted: [S]=3DCPU_OUT_OF_SPEC
[   12.135655] Hardware name: COPELION INTERNATIONAL INC. ZX Series/ZX Seri=
es, BIOS 1.07.08TCOP3 03/27/2020
[   12.135656] RIP: 0010:memtype_reserve_io+0xfc/0x110
[   12.135659] Code: aa fb ff ff b8 f0 ff ff ff eb 88 8b 54 24 04 4c 89 ee =
48 89 df e8 04 fe ff ff 85 c0 75 db 8b 54 24 04 41 89 16 e9 69 ff ff ff <0f=
> 0b e9 4b ff ff ff e8 b8 5c fc 00 0f 1f 84 00 00 00 00 00 90 90

Bisecting the stable branch pointed me to the following commit:

commit 22df32c984be9e9145978acf011642da042a2af3 (HEAD)
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Date:   Mon Dec 16 19:56:11 2024 +0200

    PCI: Allow relaxed bridge window tail sizing for optional resources
   =20
    [ Upstream commit 67f9085596ee55dd27b540ca6088ba0717ee511c ]

I've tested on stable (as of now 8630c59e99363c4b655788fd01134aef9bcd9264),=
 and
the issue persists. Reverting the offending commit via `git revert -n
22df32c984be9e9145978acf011642da042a2af3` allowed amdgpu to load again.
Dmesg: https://pastebin.com/xd76rDsW.

Additional information
   - Distribution: Artix
   - Arch: x86_64
   - Kernel config: https://pastebin.com/DWSERJL5
   - eGPU adapter: https://www.adt.link/product/R43SG-TB3.html
   - Booting with pci=3Drealloc,hpbussize=3D0x33,hpmmiosize=3D256M,hpmmiopr=
efsize=3D1G

I'm reporting here as these are the contacts from the commit message. Pleas=
e let me know if there's a more appropriate place for this, as well as any =
more information I can provide.

Thanks,
Rio


