Return-Path: <linux-pci+bounces-44662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B9D1AF25
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C4BA3019E2C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9320357A56;
	Tue, 13 Jan 2026 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5m1j6fV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D5333427
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331235; cv=none; b=lHhFpR4fUSsKjjqxiu2gW7p1+6A9gVWTo6Zq73rlQxHOp4bi7+7eKecMzSwAWDDiVP9YYQImp0laxYEDlpnBFRM3EpOY+iIQ1SAiviDcOo7xlE4TXLrqRoTofpSLMl9kJka8DQ6PAtVYKlQwP3iH009Mh1xO0kJn87YamRG6A/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331235; c=relaxed/simple;
	bh=PmZyuWsVH6oahd86vV0VMhRXGwBuARHoLrT9hUKkPmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T0kgbW+h+pIFWPLgH/WarL3PVB/umD0Kphp2h/OIy3zw1O2l7XI8/hyBSyCoi85sNAYYxIqriyLKKTmgF32pphev07CbP82CAfQI0C8KgEJvO8lx/uYn3LAwt47i+9X+48gUhOzQVpdN5oUpnIPa2798lACvDQatuliWf/kSv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5m1j6fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E684C116C6;
	Tue, 13 Jan 2026 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768331235;
	bh=PmZyuWsVH6oahd86vV0VMhRXGwBuARHoLrT9hUKkPmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D5m1j6fVtsBINM6CcA+FdKt/xxHXjb4QgVRcL6IgtU/zR/kLVhI+IHBhSNDY7gt04
	 ywJ/1/hp7+gOJwcSny9rlGydkjOHA9Az7K3a0KoHI2bbYjIvz9Jj0Wdk8gUbMyy34c
	 mS30xuo2D478/kl/2ysCxZvupRExsYYHJr//3+X6ex+lC2jPeYmfwFu812gmLqzHNL
	 bhzLtkl1bm1qGCmZl+UFNAiBqzKtvneLv88J2QOM9KhQKe2baHr9WkuM7krN+ds8dj
	 La0yL9bEsDnNvCsco+61hlK4iOEm6kOB2zJgHVqqBCW2icmC4y+2Fq40F88JV7tdkn
	 xqoLCf77td/pA==
Date: Tue, 13 Jan 2026 13:07:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, Wei <wei.huang2@amd.com>,
	Eric.VanTassell@amd.com, bhelgaas@google.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	wanghuiqiang@huawei.com, liuyonglong@huawei.com
Subject: Re: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
Message-ID: <20260113190713.GA775730@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cba9df3-8fe5-47ef-929c-6da64d31bf69@huawei.com>

On Mon, Jan 12, 2026 at 11:01:31AM +0800, fengchengwen wrote:
> Hi all,
> 
> We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
> following problem:
>
> 1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to
>    obtain the steer-tag of the CPU. According to the definition of
>    the DSM method [1], the cpu_uid should be "ACPI processor uid".

> 2. In the current implementation, the ACPI DSM method is invoked
>    directly using the logical core number, which works on the x86
>    platform but does not work on the ARM64 platform because the
>    logical core ID is not the same as the ACPI processor ID when the
>    PG exists.

PG?

> Because the ARM64 platform generates steer-tag based on the MPIDR
> information (at least for the Kunpeng platform). Therefore, we have
> two option:
>
> Option-1: convert logic core ID to ACPI process ID: use
>           get_acpi_id_for_cpu() to get ACPI process ID in
>           pcie_tph_get_cpu_st() before invoke dsm [2], and BIOS/ACPI
>           use process ID to get corresponding MPIDR, and then
>           generate steer-tag from MPIDR.
>
> Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to
>           get MPIDR in pcie_tph_get_cpu_st() before invoke dsm, and
>           BIOS/ACPI use it to generate steer-tag directly.
> 
> Option-1 complies with _DSM ECN, but requires BIOS/ACPI to maintain
> a mapping table from acpi_process_id to MPIDR.
>
> Option 2 does not comply with _DSM ECN (if extension is required).
> But it is easy to implement and can be extended to the DT system
> (ACPI is not supported) I think.

Sounds like this would be of interest to any OS, not just Linux.

Possibly a topic for the PCI-SIG firmware working group
(https://members.pcisig.com/wg/Firmware/dashboard) or the ACPI spec
working group (https://uefi.org/workinggroups)?

> [1] According to _DSM ECN, the input is defined as: "If the target
>     is a processor, then this field represents the ACPI Processor
>     UID of the processor as specified in the MADT. If the target is
>     a processor container, then this field represents the ACPI
>     Processor UID of the processor container as specified in the
>     PPTT"
>
> [2] git diff about /drivers/pci/tph.c
> @@ -289,6 +289,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
> 
>         rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> 
> +#ifdef CONFIG_ARM64
> +       cpu_uid = get_acpi_id_for_cpu(cpu_uid);
> +#endif
>         if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
>                 *tag = 0;
>                 return -EINVAL;
> 
> 

