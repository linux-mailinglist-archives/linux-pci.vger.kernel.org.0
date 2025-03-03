Return-Path: <linux-pci+bounces-22756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F196DA4BEE7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 12:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE913BB3D2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9631FBC8B;
	Mon,  3 Mar 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiLY0/kh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF71F8BA5;
	Mon,  3 Mar 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001540; cv=none; b=Y3+2VBT1f8ZLzNmlfOC/x/LpSzO2057bTKp0xacGMGkD0QZOEbcyhzBBWxkU8O/WKGupdffszByUr1sbfZpeAmA4Y0nH2N/58NMIkPBTAQEbXxPxISCynYjsepN9R9dAvCKefM9oVIC6o1QfoOsLrvCh5Vr1aDEomMLyLeUHnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001540; c=relaxed/simple;
	bh=gRNBoJF05jernBUeq/KfMWGP1a+nFz+D5JahRaAph9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8w1GBI3Oc4J4dLWMHlZKx2SWrX/XNHW4QCHHky+yqX4RjAYnTk5JsnZucdXBlUMzd4YSMHI/vggN5D2BnnZF1krkoWmMsAdyTRJV8Dk/Cv0JsUHDTTuXEpKaH1z/YCelwGrDiVbdWzD1o4Wr2Q894AuAwa8x4JDROX4a0l+0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiLY0/kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33938C4CED6;
	Mon,  3 Mar 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741001540;
	bh=gRNBoJF05jernBUeq/KfMWGP1a+nFz+D5JahRaAph9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiLY0/khaL2Ip+oy4IwfXwqO5ikHaoL5ZsUfOE/5XvmQ2y9IP8FjKVfIDmm96eC0a
	 yfHpmEO43PSH/mrpd3d+aD8AKA+fVWOytuM1HR3QpBSVPGiSAaTAHU+xB6rwXrrsIs
	 Jk48sJ+GKUTnBXA+FIsT4qEu57+TNJTThg3TR/NuANLQUppAKfwZcjAQmwDN45DC1H
	 2IYn3GxuHjW09NnOyZLxKWqEjd2ERGSZMz0NeE2yMOQLSE0F2rwjgHQPIHD38C2pPT
	 uBuqq+mbBeqV3FnACtw/hUBSrf7ETH2df81Ryvt+lJVXPgMLTcDbFOSRndCcxinyOv
	 XE/n4UbPMPHfg==
Date: Mon, 3 Mar 2025 12:32:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, "bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <Z8WTON2K77Q567Kg@gmail.com>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>


* Rostyslav Khudolii <ros@qtec.com> wrote:

> Hi,
> 
> > Rostyslav, I would like to ask you, do you have patches / updates for
> > enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
> > adjust my lspci changes for new machines.
> 
> Pali, sorry for the late reply. Do I understand correctly, that even
> though you have access to the ECS via
> the MMCFG you still want the legacy (direct IO) to work for the
> debugging purposes? I can prepare a
> simple patch that will allow you to do so if that's the case.
> 
> >
> > So what is the practical impact here? Do things start breaking
> > unexpectedly if CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled?
> > Then I'd suggest fixing that in the Kconfig space, either by adding a
> > dependency on ACPI_MCFG && PCI_MMCONFIG, or by selecting those
> > must-have pieces of infrastructure.
> >
> 
> Ingo, thank you for the reply.
> 
> The way I understand the access to the PCI ECS (via raw_pci_ext_ops)
> works, is the following:
> 1. If CONFIG_ACPI_MCFG or CONFIG_PCI_MMCONFIG are enabled - set the
> raw_pci_ext_ops to use
>     MMCFG to access ECS. See pci_mmcfg_early_init() / pci_mmcfg_late_init();
> 2. If CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled - set the
> raw_pci_ext_ops to use
>     the 'direct' access to ECS. See pci_direct_init(). The direct
> access is conditional on the PCI_HAS_IO_ECS
>     flag being set.
> 
> On AMD, the kernel enables the ECS IO access via the
> amd_bus_cpu_online() and pci_enable_pci_io_ecs().
> Except those functions have no desired effect on the AMD 17h+ family
> because the register (EnableCf8ExtCfg),
> they access, has been moved. What is important though, is that the
> PCI_HAS_IO_ECS flag is set unconditionally.
> See pci_io_ecs_init() in amd_bus.c
> 
> Therefore I was wondering whether we should add support for the 17h+
> family in those functions to have
> the direct access work for those families as well.

Yeah, I think so, but I'm really just guessing:

> Regarding your suggestion to address this in the Kconfig space - I'm 
> not quite sure I follow, since right now the kernel will use 
> raw_pci_ext_ops whenever access beyond the first 256 bytes is 
> requested. Say we want to make that conditional on CONFIG_ACPI_MCFG 
> and CONFIG_PCI_MMCONFIG, does it also mean then we want to drop 
> support for the 'direct' PCI IO ECS access altogether?

I thought that enabling CONFIG_ACPI_MCFG would solve the problem, and 
other architectures are selecting it pretty broadly:

 arch/arm64/Kconfig:     select ACPI_MCFG if (ACPI && PCI)
 arch/loongarch/Kconfig: select ACPI_MCFG if ACPI
 arch/riscv/Kconfig:     select ACPI_MCFG if (ACPI && PCI)

While x86 allows it to be user-configured, which may result in 
misconfiguration, given that PCI_HAS_IO_ECS is being followed 
unconditionally if a platform provides it?

Thanks,

	Ingo

