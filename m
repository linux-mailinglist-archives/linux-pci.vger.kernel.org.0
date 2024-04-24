Return-Path: <linux-pci+bounces-6647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799258B1181
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 19:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE061C22EF6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F516D4F4;
	Wed, 24 Apr 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o90A0dji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974E16C855;
	Wed, 24 Apr 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981354; cv=none; b=IOitGWHCEauCEapJ3QgR7cpa6r4d6WUq5SlU/VBJ5TLBJxe3dMUAWtZCzQ5qWp/wc0X2sCJGQobijC4QDY6jnoGM4HsIaPxf0mTfEM21Jo/IG07xCJ4W+RkA1FPHJ3LJIwCMsbEGd0k1lWiJnGFNHQTwlgVJPyVWKz3ErhUqasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981354; c=relaxed/simple;
	bh=R4CYpHlj8jEVfIevCJyMoADNlNhxgxYKx+hnKC/6ZHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWh5QbQceOg18/LjGMJfMmAPLs92RJNn9a0knv04ZTVSRomN2R1ncPU3orQoc3Burkqs2LLG+IcT6xUFLujR1dj9Q88R1Qg4Hx2b9cT0R4SDzOAP/dK6H/OU1Vbb+1TCs9hHYAV/esYhriih8ZLJe6Y6J1uu/gjO8W0M68Th/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o90A0dji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237D7C2BD10;
	Wed, 24 Apr 2024 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713981353;
	bh=R4CYpHlj8jEVfIevCJyMoADNlNhxgxYKx+hnKC/6ZHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o90A0dji/1C/nj8o2so91Qf2gUBarrMOTde/k9C3QoyX+SPqyPj5Rl0J4CAjtDPFv
	 ubbWx4NO7WFN5DxKr7dtMjXqL3ifQV9ZDEk9/E1heWe6mZNCR3tAkbzNz+d03g+0BC
	 zhW5Qh+mMI/dbfxC5jak+61K8KAWmZm2QipBZDFOJaxHU3oYUnGE53WJHMqiMA8Wln
	 CZnyVTlkM6DAQ/XVxoGGhSPFJKd5LRyybY0tP5A/QZNStYy/3YS1hDvFw4EGJg1UXu
	 Z8G/GpZzpGRZNQ88h30w7vNI+z8rhH0gNd5Or4YxleSamM9mFDlFo1Y4rW+NQiv4rm
	 upnSXlJDq9F+g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Anup Patel
 <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel
 Holland <samuel.holland@sifive.com>, Robert Moore
 <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Andrei Warkentin
 <andrei.warkentin@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
In-Reply-To: <CAJZ5v0gTzn3TDoh0+0UQjMeJVdU+z16dDOT_fKMhr0XrOxyRtA@mail.gmail.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <CAJZ5v0gTzn3TDoh0+0UQjMeJVdU+z16dDOT_fKMhr0XrOxyRtA@mail.gmail.com>
Date: Wed, 24 Apr 2024 19:55:50 +0200
Message-ID: <871q6uir15.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Apr 15, 2024 at 7:01=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.c=
om> wrote:
>>
>> This series adds support for the below ECR approved by ASWG.
>> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia=
7zR/view?usp=3Dsharing
>>
>> The series primarily enables irqchip drivers for RISC-V ACPI based
>> platforms.
>>
>> The series can be broadly categorized like below.
>>
>> 1) PCI ACPI related functions are migrated from arm64 to common file so
>> that we don't need to duplicate them for RISC-V.
>>
>> 2) Added support for re-ordering the probe of interrupt controllers when
>> IRQCHIP_ACPI_DECLARE is used.
>>
>> 3) To ensure probe order between interrupt controllers and devices,
>> implicit dependency is created similar to when _DEP is present.
>>
>> 4) When PNP devices like Generic 16550A UART, have the dependency on the
>> interrupt controller, they will not be added to PNP data structures. So,
>> added second phase of pnpacpi_init to handle this.
>>
>> 5) ACPI support added in RISC-V interrupt controller drivers.
>>
>> This series is still kept as RFC to seek feedback on above design
>> changes. Looking forward for the feedback!
>
> I've looked at the patches and I don't see anything deeply concerning
> in them from the ACPI core code perspective.
>
> The changes look reasonably straightforward to me.

Sunil, given Rafael's input, it sounds like it's time for a patch
proper. This is really the missing piece to make ACPI usable on RISC-V!

Thanks for the nice work!
Bj=C3=B6rn

FWIW,
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>



