Return-Path: <linux-pci+bounces-6431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FB48A9B9C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9541E1C21356
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F61635BD;
	Thu, 18 Apr 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9VtkE4e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B0160790;
	Thu, 18 Apr 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448166; cv=none; b=tAdQeIh5fU/s2MgqoJPY5epiPlEKESR3eUu2qHh4l4brDTTQN3udXQL2VLIu5D3guMd7M14d0SD/n+5sbzx/tDJbhRfFJfL8yVhBdPER0u6HmB6icTRJIyhA00rCMi035q4SokOVmjPgiPYvoXgkdEhtPkT1YO/Zg+2TnSIhmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448166; c=relaxed/simple;
	bh=jfOQXsG4f9jvja2w3Ld4pdH6HBJIb87wPUxNL/nBu08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5YmvLJ4bVwfU6ASQXopUK/5X9x5nD612pYkhZzLv9qC2/yUkLfphF4FCKqmI/yto+sOgOSK9N+2BRLK9DAxtwAYtdpUHkUQY3qcUTIHMs8gldbQwAw4sjBX/RLGry2WgtMEVV5UCLQWefyWBJFaYD8O9ks99PgCPPChy5bcLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9VtkE4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2064AC113CC;
	Thu, 18 Apr 2024 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713448165;
	bh=jfOQXsG4f9jvja2w3Ld4pdH6HBJIb87wPUxNL/nBu08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o9VtkE4ePs1Kn8oRF5n8WcljMFlRPUrOeX0M2eFt0VjvDoYupdqg+8AAQrh6yexev
	 Yy4qSEQp7xvRGROpudXwJrLUR149J8R9gYOiw3nsbjzxYJ3S6lqVZztdQ/QuTYpdJ3
	 AMxVbS9TxBORXr4RfAOXu4hhzDZeiulUkhE2sSM9J2hTdFIwYuZMSLwTSbCRcTseiL
	 /XcdKDNoV3E0Vbyw8q4L+3DqVfDwkbwaSK7Hv6I3jlJoEKmPAla7ufnGJiEbeGcaSr
	 ANdzPRoT333poFim3YKZJqvnXp8FyB3JQxICibj2Ch6VqjQHtbbu4ituRhMns1bgrS
	 7POoB7ZWa0Rrg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, Thomas Gleixner
 <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, Robert
 Moore <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>, Conor
 Dooley <conor.dooley@microchip.com>, Andrew Jones
 <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, Andrei
 Warkentin <andrei.warkentin@intel.com>, Marc Zyngier <maz@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Date: Thu, 18 Apr 2024 15:49:22 +0200
Message-ID: <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sunil V L <sunilvl@ventanamicro.com> writes:

> This series adds support for the below ECR approved by ASWG.
> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7=
zR/view?usp=3Dsharing
>
> The series primarily enables irqchip drivers for RISC-V ACPI based
> platforms.
>
> The series can be broadly categorized like below.=20
>
> 1) PCI ACPI related functions are migrated from arm64 to common file so
> that we don't need to duplicate them for RISC-V.
>
> 2) Added support for re-ordering the probe of interrupt controllers when
> IRQCHIP_ACPI_DECLARE is used.
>
> 3) To ensure probe order between interrupt controllers and devices,
> implicit dependency is created similar to when _DEP is present.
>
> 4) When PNP devices like Generic 16550A UART, have the dependency on the
> interrupt controller, they will not be added to PNP data structures. So,
> added second phase of pnpacpi_init to handle this.
>
> 5) ACPI support added in RISC-V interrupt controller drivers.
>
> This series is still kept as RFC to seek feedback on above design
> changes. Looking forward for the feedback!
>
> Changes since RFC v3:
> 	1) Moved to _DEP method instead of fw_devlink.
> 	2) PLIC/APLIC driver probe using namespace devices.
> 	3) Handling PNP devices as part of clearing dependency.
> 	4) Rebased to latest linux-next to get AIA DT drivers.
>
> Changes since RFC v2:
> 	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> 	2) Dropped patches in drivers which are not required due to
> 	   fw_devlink support.
> 	3) Dropped pci_set_msi() patch and added a patch in
> 	   pci_create_root_bus().
> 	4) Updated pnp_irq() patch so that none of the actual PNP
> 	   drivers need to change.
>
> Changes since RFC v1:
> 	1) Abandoned swnode approach as per Marc's feedback.
> 	2) To cope up with AIA series changes which changed irqchip driver
> 	   probe from core_initcall() to platform_driver, added patches
> 	   to support deferred probing.
> 	3) Rebased on top of Anup's AIA v11 and added tags.
>
> To test the series,
>
> 1) Qemu should be built using the riscv_acpi_namespace_v1 branch at
> https://github.com/vlsunil/qemu.git
>
> 2) EDK2 should be built using the instructions at:
> https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

Hi Sunil,

I started playing with your work, and FYI: Using U-boot instead of EDK2
works out of the box (with acpi.config added to U-boot).

I changed my rootfs/boot tooling like [1], and it boots.

(For those who prefer working with U-boot UEFI instead of EDK2.)


Bj=C3=B6rn

[1] https://github.com/bjoto/riscv-rootfs-utils/commit/c0c620131f04d0c25df1=
504af4d0629a420b097e

