Return-Path: <linux-pci+bounces-6201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86888A37E0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 23:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2A51C212D4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AE152160;
	Fri, 12 Apr 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvCl0MJg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13A2F875;
	Fri, 12 Apr 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957497; cv=none; b=JQ1YMCqTJMruQI3xYchdt6bIdPigVb7rW+3HetdAFg+3IX0XUI2jcnrnrhq01HM1NUZ0q5ezfERCT135+FnxisBYKQfsEORR/Tx0Zs+joOyOj5K8gmByH1xGe3nrmYf/uCy8iJ9d5WOiRUgWxA4zeddfiZUlxXqBFsx+jzuoM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957497; c=relaxed/simple;
	bh=ObWfLvWBq6s8s6uqs5mSK6jOY0sHRmTty6j0VqL6iHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I7qEiwnLK0GCMQ/oCfIhFj54yaEPTT9Ahw3p0czWMrqP5CupR8xw6tnvBDZRhfVHBKt7vNmrEJOnChhPORr8ibYMwD2nhRZtETWyOjJfebRzwXnRRgm0/9lVnHDGtbJtXBJyzPnrceGk7F3SHP5vaiOw08PpKQiY0bvlcPbr4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvCl0MJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891D7C113CC;
	Fri, 12 Apr 2024 21:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957496;
	bh=ObWfLvWBq6s8s6uqs5mSK6jOY0sHRmTty6j0VqL6iHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hvCl0MJgkzpgVnvrmbBdafROrWJnurNYNDoN3iLzVlKXXmSWHvYLVTQIboHDuaII5
	 0cs/meBAWzu/nfQUtrSYwUNwMi2SuCqBbeVc6Y6m3VUD8ddoq3QdvyYYGNZzmZQdmX
	 NrHPDKMPJgOR3t9UQmOk2QTWXvHjVl9krrbzXeMWAnPHfTj3n6Wxa89mQHIXnZ0OYA
	 ZpxPLSPyd6BsiAFd6R+xqImO/SqrN8xOnETgYN4e5ZXheRk1yuVYbshk7KhTiNcAUi
	 K/dUBAA6TH/2Wz1Qn93FQfrskac4VV/hpt3NeNHn8/lTtG6CNp5hDQkrQZ6tO3ZGkh
	 +JtRLymU0gKWA==
Date: Fri, 12 Apr 2024 16:31:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/7] PCI/MSI: Remove IMS (Interrupt Message Store)
 support for now
Message-ID: <20240412213134.GA19180@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410221307.2162676-1-helgaas@kernel.org>

On Wed, Apr 10, 2024 at 05:13:00PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
> 
> Remove it for now.  We can add it back when a user comes along.
> 
> I propose to merge this via the PCI tree unless somebody else wants it.
> 
> 
> Changes since v1 (https://lore.kernel.org/linux-pci/20240401232326.1794707-1-helgaas@kernel.org/):
>   - Revert other IMS commits in IOMMU, apic, genirq, suggested by Kevin
> 
> Bjorn Helgaas (7):
>   Revert "PCI/MSI: Provide stubs for IMS functions"
>   Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
>   Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
>   Revert "iommu/amd: Enable PCI/IMS"
>   Revert "iommu/vt-d: Enable PCI/IMS"
>   Revert "x86/apic/msi: Enable PCI/IMS"
>   Revert "genirq/msi: Provide constants for PCI/IMS support"
> 
>  arch/x86/kernel/apic/msi.c          |  5 ---
>  drivers/iommu/amd/iommu.c           | 17 +--------
>  drivers/iommu/intel/irq_remapping.c | 19 ++--------
>  drivers/pci/msi/api.c               | 50 ------------------------
>  drivers/pci/msi/irqdomain.c         | 59 -----------------------------
>  include/linux/irqdomain_defs.h      |  1 -
>  include/linux/msi.h                 |  2 -
>  include/linux/msi_api.h             |  1 -
>  include/linux/pci.h                 | 26 -------------
>  9 files changed, 5 insertions(+), 175 deletions(-)

I applied this to pci/ims-removal for v6.10.

