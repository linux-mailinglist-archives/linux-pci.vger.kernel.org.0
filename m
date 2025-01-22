Return-Path: <linux-pci+bounces-20253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96DA19AB6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 23:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61D4188ACED
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 22:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C81CAA62;
	Wed, 22 Jan 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfXSh62g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E31C9DC6;
	Wed, 22 Jan 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584030; cv=none; b=fBY/4lDlbFhU5CKzrkaWgLwokF5r/qN2J/B0/OTO1/VUy4pyZ4CR8OQqKoBnYU5f7IiMSyRhYBb1NejKryQK9SmZDmCl7F07BILC1r1yQ+vk39WSEqyn/G49MkIRsJRX5siwa2zxzEhbBXUCCUyVATVQGto/F9lv4bnV1eFH6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584030; c=relaxed/simple;
	bh=9G83G8eJ1h/OJVxOtV5CXUvo+dOioCmI/kulXR7ZPlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f43qOpRfgpOqN5KPemBbRb8X0Uilv/SiyNsHC9ZqKHwyKfWca6baLoaks3tgq1EHLZFkn9jD7NmWaSS11uZnptZMjrM05XEO4SBW+dUL/anT5UEhFsITqsdn2mJt9E9v8HHEmShPASgKXNqj58tkvfl6KwfSPhX4/i2th+jL1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfXSh62g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B2BC4CED2;
	Wed, 22 Jan 2025 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737584030;
	bh=9G83G8eJ1h/OJVxOtV5CXUvo+dOioCmI/kulXR7ZPlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfXSh62gEaHE8dj7dJbF7VjzwW/6LVzv3Vu1wxe5i5CPd8kAS4cA2OFCXj7Y6JY5/
	 ++Yd7uMa1Bcal3Zdhu6RXC+KpAgidbT74VR3e8uhi7NoUTt0x0nBDcT9cPQnIHB4qC
	 aylOLl+APbadrTFdBnRh0T8pY0sqFNE05CRGnGaufcC5157fz24wKXLF3Pn/YfTFAE
	 v8cZsgUffZu/r+Mmj2WtiYbZ3uQipYhXRCbZ0HCHzmqMMfogwUyf29Lk9NimK7/Hwx
	 2OliisxHgfW2v4AOnRpKx5/wldDKc5K/ay0EO4ym6EFzjnD0J8cQ25eDh7wH1ud3mD
	 Nm6goQ+1ynetA==
Received: by pali.im (Postfix)
	id A20228B8; Wed, 22 Jan 2025 23:13:38 +0100 (CET)
Date: Wed, 22 Jan 2025 23:13:38 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250122221338.dw6z65m276xci62b@pali>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Monday 16 December 2024 14:15:26 Rostyslav Khudolii wrote:
> Hi all,
> 
> I am currently working on a custom AMD Ryzen™ Embedded R2000 (AMD
> Family 17h) device and have discovered that PCI IO Extended
> Configuration Space (ECS) access is no longer possible.
> 
> Consider the following functions: amd_bus_cpu_online() and
> pci_enable_pci_io_ecs(). These functions are part of the
> amd_postcore_init() initcall and are responsible for enabling PCI IO
> ECS. Both functions modify the CoreMasterAccessCtrl (EnableCf8ExtCfg)
> value via the PCI device function or the MSR register directly (see
> the "BIOS and Kernel Developer’s Guide (BKDG) for AMD Family 15h",
> Section 2.7). However, neither the MSR register nor the PCI function
> at the specified address (D18F3x8C) exists for AMD Family 17h. The
> CoreMasterAccessCtrl register still exists but is now located at a
> different address (see the "Processor Programming Reference (PPR) for
> AMD Family 17h", Section 2.1.8).
> 
> I would be happy to submit a patch to fix this issue. However, since
> the most recent change affecting this functionality appears to be 14
> years old, I would like to confirm whether this is still relevant or
> if the kernel should always be built with CONFIG_PCI_MMCONFIG when ECS
> access is required.
> 
> Linux Kernel info:
> 
> root@qt5222:~# uname -a
> Linux qt5222 6.6.49-2447-qtec-standard--gef032148967a #1 SMP Fri Nov
> 22 09:25:55 UTC 2024 x86_64 GNU/Linux
> 
> Best regards,
> Ros

Hello,

For a longer time I have patches for pciutils project which allows to
query PCIe devices via this AMD ECS I/O API. lspci provides more options
how to query PCI and PCIe devices and one option is raw cf8/cfc I/O
access (via ioport/iopl syscalls), which is useful for debugging
purposes. The disadvantage is that this method provides access only to
PCI registers. And that is why this AMD ECS I/O API can be useful as it
extends lspci raw cf8/cfc I/O to access also PCIe registers.

My implementation in those lspci patches follows the linux kernel logic,
but for unknown reason it do not want to work. Upper cf8 (ECS) bits are
ignored when accessing register value via cfc. Filip retested it today
on AMD 19h family machine, that it really does not work.

Now when I found and read this Rostyslav's email I understood why it
does not work.

Rostyslav, I would like to ask you, do you have patches / updates for
enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
adjust my lspci changes for new machines.

Anyway, if you are interesting in lspci patches for my WIP AMD ECS, I
can send them.

Pali

