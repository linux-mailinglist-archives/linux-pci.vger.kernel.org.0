Return-Path: <linux-pci+bounces-8912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDE90CA82
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4DF1F2167C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017C1514FF;
	Tue, 18 Jun 2024 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3lQCGfK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBF1BF38
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710634; cv=none; b=WOWfN67Slyd1NT4hYubgZs8f3rBr4ynJlBa1FdGufMeC9w+1k3kCa8fSXdBZTXvkoKTXMokHIS2XEiXYVxX8BfRD799u44cz9sC3bsHqwP4z1NtRChkvpQST282euIAf7G+Eso60Qgn8nolFLV3yzAGhGKw10GK0070T4Hiygbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710634; c=relaxed/simple;
	bh=GTMec+hcXfr1Ive4z4tyXIjmGWjXePImfo4Im3UDn8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoK8kszKY2W4Z6x53/C5RFHhb4UeRt/C0zqK82zW0LOcDOwx5DIgdwb8/0yEKAZjXQ5J1r/d7dnVGNKls7DlrRzfaGHTtcbHHh1C/adHNARxOlrssfgU2jo7wqPxzvKG1PSdcFHFT77xBHGgR5u66JHNTY83By0EUvlBNZBAK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3lQCGfK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718710633; x=1750246633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GTMec+hcXfr1Ive4z4tyXIjmGWjXePImfo4Im3UDn8s=;
  b=f3lQCGfKFSClM6AUtEh+78sIlLBw33Xw7X7LeijgRlyMOjZZM/+WgX4M
   1inIh0k9Zyy2QR9dGfgG0LPkj5cEXkq2+OxlpgoHYsID0+p54CRYffvLT
   A6dObjvI82UfjAvHK/N0PQoy6JaNq68tOoj5OtCE3nrw9XotTuVn6JTng
   aTLZCLlc+LqCBxPoSCopagYQE9QXoMA2IRsp9JQ0tUFJXxmt4i/kB+LXV
   8q5HcWjq6VbPl+tCTOWwubQvk42iz6rzSHWPuCgyfmE2K8bMg5LqZTIEx
   dX7niCFoRlhA5L0W4wpSzV0S5lYhOnWO4OxpvRcMYBpgYBVXtatvkQ6eJ
   A==;
X-CSE-ConnectionGUID: nXWsIyrcQaSfEXnPeVueWw==
X-CSE-MsgGUID: bBR0Ut2+RROYFpcNDX37Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26262604"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26262604"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:37:12 -0700
X-CSE-ConnectionGUID: +p43JqnjSTazAOZ5tC3k3Q==
X-CSE-MsgGUID: 95BPoNAYTiuAWb11f8H0pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41631986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2024 04:37:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B9BC6241; Tue, 18 Jun 2024 14:37:09 +0300 (EEST)
Date: Tue, 18 Jun 2024 14:37:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and
 hot-removal
Message-ID: <20240618113709.GB1532424@black.fi.intel.com>
References: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>

On Tue, Jun 18, 2024 at 12:54:55PM +0200, Lukas Wunner wrote:
> Keith reports a use-after-free when a DPC event occurs concurrently to
> hot-removal of the same portion of the hierarchy:
> 
> The dpc_handler() awaits readiness of the secondary bus below the
> Downstream Port where the DPC event occurred.  To do so, it polls the
> config space of the first child device on the secondary bus.  If that
> child device is concurrently removed, accesses to its struct pci_dev
> cause the kernel to oops.
> 
> That's because pci_bridge_wait_for_secondary_bus() neglects to hold a
> reference on the child device.  Before v6.3, the function was only
> called on resume from system sleep or on runtime resume.  Holding a
> reference wasn't necessary back then because the pciehp IRQ thread
> could never run concurrently.  (On resume from system sleep, IRQs are
> not enabled until after the resume_noirq phase.  And runtime resume is
> always awaited before a PCI device is removed.)
> 
> However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
> called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
> of secondary bus after reset"), which introduced that, failed to
> appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
> reference on the child device because dpc_handler() and pciehp may
> indeed run concurrently.  The commit was backported to v5.10+ stable
> kernels, so that's the oldest one affected.
> 
> Add the missing reference acquisition.
> 
> Abridged stack trace:
> 
>   BUG: unable to handle page fault for address: 00000000091400c0
>   CPU: 15 PID: 2464 Comm: irq/53-pcie-dpc 6.9.0
>   RIP: pci_bus_read_config_dword+0x17/0x50
>   pci_dev_wait()
>   pci_bridge_wait_for_secondary_bus()
>   dpc_reset_link()
>   pcie_do_recovery()
>   dpc_handler()
> 
> Fixes: 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Closes: https://lore.kernel.org/r/20240612181625.3604512-3-kbusch@meta.com/
> Tested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

