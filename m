Return-Path: <linux-pci+bounces-37556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A379BB78E1
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D231B21131
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E467274B59;
	Fri,  3 Oct 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBeIaDQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247622629F;
	Fri,  3 Oct 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509181; cv=none; b=CKOpx8rPcrJRgBZSZO7bf1DZHFhXqGh+OU8cdjBXgPVqzmf4GFjNBk0RKIaWjKqDBn2LKpvX0usSDXZeNbkPL+ouCP2r+0dpu1C26kyGS2dLTJdtY807IT8pMVgnXgC6ZYZECLfCPYl73NZlxgZkoBNXDzZ1v2aMdvmECGr9CZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509181; c=relaxed/simple;
	bh=xjCMZ9zx/9N/YgtUdATz1CyU1rO+qsBvdWTyI6D60Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLV0DIaMlvLEMITNqGIbq/+sP45/+aXWIpcYnkAgB8awyuKMmGHpcRgmi3eUgxuwry3a8cLB85vAKerMIb/OIEEtMIaeRydVFYdlMunvEq8F3jSPkHe9aFh4itxP3is2VR8H75psFQVUdt0J168WgJ2ymPUzf7JS4rRPG0YaPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBeIaDQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDD2C4CEF5;
	Fri,  3 Oct 2025 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759509180;
	bh=xjCMZ9zx/9N/YgtUdATz1CyU1rO+qsBvdWTyI6D60Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBeIaDQMZy5tKvwyXaY7Zy+GovegU8BGcPFoBx27LDnfz94ysV0VegYj66ySVjj+q
	 tTGmeKqjbuV/JVQoRtagA7GxrPLWO1K8bgTVztUS0ks6tSvqZOzkngZoHL6b3mth3l
	 tQ6lZRdG2fevEz9kqqYuw4QFbtvo4qTF5B9DPDEovt8o6u6me3ttx6KiLssbjUz6tn
	 JwrrSSxq5AK8AE/MmPWzOBTi4pYg+DEXQEKC5UkQjL+JG2OpAGr1o41eiyFVell/FX
	 Jox4/VnGzuvZY9POriPHvjFqwKPAgC9vvLBGUwIk2wHnW8TFtxMwhtdsfV8iiNu7/T
	 kzvxQ/HXJAvWQ==
Date: Fri, 3 Oct 2025 22:02:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Alessandro Carminati <acarmina@redhat.com>, 
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH 0/3] Enable MSI affinity support for dwc PCI
Message-ID: <wzegusdukhm4e3bogyx7lfgjvjqd342mfielw2gzynquohnugf@wzqdbycndn6i>
References: <20251003160421.951448-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003160421.951448-1-rrendec@redhat.com>

+ folks who were part of previous attempts

On Fri, Oct 03, 2025 at 12:04:18PM -0400, Radu Rendec wrote:
> Various attempts have been made so far to support CPU affinity control
> for (de)multiplexed interrupts. Some examples are [1] and [2]. That work
> was centered around the idea to control the parent interrupt's CPU
> affinity, since the child interrupt handler runs in the context of the
> parent interrupt handler, on whatever CPU it was triggered.
> 
> This is a new attempt based on a different approach. Instead of touching
> the parent interrupt's CPU affinity, the child interrupt is allowed to
> freely change its affinity setting, independently of the parent. If the
> interrupt handler happens to be triggered on an "incompatible" CPU (a
> CPU that's not part of the child interrupt's affinity mask), the handler
> is redirected and runs in IRQ work context on a "compatible" CPU. This
> is a direct follow up to the (unsubmitted) patches that Thomas Gleixner
> proposed in [3].
> 
> The first patch adds support for interrupt redirection to the IRQ core,
> without making any functional change to irqchip drivers. The other two
> patches modify the dwc PCI core driver to enable interrupt redirection
> using the new infrastructure added in the first patch.
> 
> Thomas, however, I made a small design change to your original patches.
> Instead of keeping track of the parent interrupt's affinity setting (or
> rather the first CPU in its affinity mask) and attempting to pick the
> same CPU for the child (as the target CPU) if possible, I just check if
> the child handler fires on a CPU that's part of its affinity mask (which
> is already stored anyway). As an optimization for the case when the
> current CPU is *not* part of the mask and the handler needs to be
> redirected, I pre-calculate and store the first CPU in the mask, at the
> time when the child affinity is set. In my opinion, this is simpler and
> cleaner, at the expense of a cpumask_test_cpu() call on the fast path,
> because:
> - It no longer needs to keep track of the parent interrupt's affinity
>   setting.
> - If the parent interrupt can run on more than one CPU, the child can
>   also run on any of those CPUs without being redirected (in case the
>   child's affinity mask is the same as the parent's or a superset).
> 
> Last but not least, since most of the code in these patches is your
> code, I took the liberty to add your From and Signed-off-by tags to
> properly attribute authorship. I hope that's all right, and if for any
> reason you don't want that, then please accept my apologies and I will
> remove them in a future version. Of course, you can always remove them
> yourself if you want (assuming the patches are merged at some point),
> since you are the maintainer :)
> 
> [1] https://lore.kernel.org/all/20220502102137.764606ee@thinkpad/
> [2] https://lore.kernel.org/all/20230530214550.864894-1-rrendec@redhat.com/
> [3] https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> 
> Radu Rendec (3):
>   genirq: Add interrupt redirection infrastructure
>   PCI: dwc: Code cleanup
>   PCI: dwc: Enable MSI affinity support
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 123 ++++++++----------
>  drivers/pci/controller/dwc/pcie-designware.h  |   7 +-
>  include/linux/irq.h                           |   6 +
>  include/linux/irqdesc.h                       |  11 +-
>  kernel/irq/chip.c                             |  20 +++
>  kernel/irq/irqdesc.c                          |  51 +++++++-
>  kernel/irq/manage.c                           |  16 ++-
>  7 files changed, 154 insertions(+), 80 deletions(-)
> 
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

