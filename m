Return-Path: <linux-pci+bounces-34464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767DB2FE0A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC711C8192E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020820B218;
	Thu, 21 Aug 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQu2IUt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793E2E3B0E;
	Thu, 21 Aug 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789094; cv=none; b=kgpgH2K8uK4m+Y/dGDZx7aH0jr4JhV87Djeb2q+suJD7YyyJxGPIZCHCFsLVXeQX5vVpy5X8G5ErvNc9gtxrcn8a9G9OdxyPWKFhpatqhNzAeA/IDATG8csPJIvPxXWMakPJ4y4/VxE/Gx7SMO6cq8DhlNvvHm6C1ZTE9Hsok58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789094; c=relaxed/simple;
	bh=VRY5/t9bBx5F1ZJ3h2WUXpcGEFMoaQ/KLoUkTd93Dc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MwsS2g7PMjNbrRjDiGue5yIuTB93e8ODlbBFo982Xb4o6VG/6jFzQDd1lxS1cWkbzL2dzFLe8Y6Pwdt9h62juVUI4GoyNPQdqaRjIFgdmcqKcEsNQh7Szh5AQMG4Xyeyx5SDO1IKXfsoGZG1V619AR/47OeUwIPa3ijXQYu9m3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQu2IUt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E104FC4CEEB;
	Thu, 21 Aug 2025 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789094;
	bh=VRY5/t9bBx5F1ZJ3h2WUXpcGEFMoaQ/KLoUkTd93Dc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fQu2IUt363kg7f3k7qtdmvSCtqHijJq99NfY96PQdJhtSpHX6YqPbdDNNoNbd+NYg
	 bvoy4Tzx6pX1h3UEXAMmI6g0Whp23ceyqrpDvtOCKRzCFDMt+Owl2pAaHkfrjHjeyP
	 +nNL218Fs8XNEL4kKixho8c04NDy7+qHbgynP/NWoDw5i4dcEXy53s0vItsAHQDJIH
	 Liy2qI/lb4SdgPL+UN6mFgQpeDR/wwIZ8JTPFCUOE064skdFKTA8fdbnOfglKnrgzH
	 BI3Z3Fhe467MfAx164Q+wjjx0R4RH8ZRWeS/OidBTBVyKhhiv38fxYt7yq6ZOl8PWP
	 SWjQtEjaurR0g==
Date: Thu, 21 Aug 2025 10:11:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: Fix pdev_resources_assignable() disparity
Message-ID: <20250821151132.GA674480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630142641.3516-3-ilpo.jarvinen@linux.intel.com>

On Mon, Jun 30, 2025 at 05:26:40PM +0300, Ilpo Järvinen wrote:
> pdev_sort_resources() uses pdev_resources_assignable() helper to decide
> if device's resources cannot be assigned. pbus_size_mem(), on the other
> hand, does not do the same check. This could lead into a situation
> where a resource ends up on realloc_head list but is not on the head
> list, which is turn prevents emptying the resource from the
> realloc_head list in __assign_resources_sorted().
> 
> A non-empty realloc_head is unacceptable because it triggers an
> internal sanity check as show in this log with a device that has class
> 0 (PCI_CLASS_NOT_DEFINED):

Is the class relevant here?

> pci 0001:01:00.0: [144d:a5a5] type 00 class 0x000000 PCIe Endpoint
> pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> pci 0001:01:00.0: enabling Extended Tags
> pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0001:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
> pcieport 0001:00:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
> pcieport 0001:00:00.0: bridge window [mem 0x40000000-0x401fffff]: assigned
> ------------[ cut here ]------------
> kernel BUG at drivers/pci/setup-bus.c:2532!
> Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> ...
> Call trace:
>  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
>  pci_rescan_bus+0x28/0x48
> 
> Use pdev_resources_assignable() also within pbus_size_mem() to skip
> processing of non-assignable resources which removes the disparity in
> between what resources pdev_sort_resources() and pbus_size_mem()
> consider. As non-assignable resources are no longer processed, they are
> not added to the realloc_head list, thus the sanity check no longer
> triggers.
> 
> This disparity problem is very old but only now became apparent after
> the commit 2499f5348431 ("PCI: Rework optional resource handling") that
> made the ROM resources optional when calculating bridge window sizes
> which required adding the resource to the realloc_head list.
> Previously, bridge windows were just sized larger than necessary.
> 
> Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
> Reported-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Any URL we can include here for the report?

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/setup-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f90d49cd07da..24863d8d0053 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1191,6 +1191,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			resource_size_t r_size;
>  
>  			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
> +			    !pdev_resources_assignable(dev) ||
>  			    ((r->flags & mask) != type &&
>  			     (r->flags & mask) != type2 &&
>  			     (r->flags & mask) != type3))
> -- 
> 2.39.5
> 

