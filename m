Return-Path: <linux-pci+bounces-42921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36BCB4599
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 01:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D41CC3008883
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BDE1CDFCA;
	Thu, 11 Dec 2025 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7kxp+4u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D718A6DB;
	Thu, 11 Dec 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765413059; cv=none; b=Mhvy3/fHCMSq0pIjJo5PTMCY6/U4eFJWEYqtBC1HNLgznFR1KmlSoabiBo3LDmrUK+GJ8t02aAih3YElKUrTrYRYYOt0sWq2efRwyXx5bLZ8RiShNEAqzEQu304qwHVf8bD3QoNEFJyt6b2S2cFrimxe+r7xGhijkgJm36Zt8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765413059; c=relaxed/simple;
	bh=2IiEqbrbD9E1LgXnoV6os/1h4Z5se5TKtvgyklwKCR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qVN4CXuuz8nEwUssMislyDCODEAn4zovcDcHIIQJ8tpw1Zz+Kc2ZFBbrONvn9V0IWG26u+FWE/bv4RRhieecsiAEH7VOfh6LhFdWcFsIiJa0ih4JBo/X3WGDPATsiuCitT2zVTvNU4xzWBhpL+KmRh2awMVLMapwFntKZs2DmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7kxp+4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E3C19421;
	Thu, 11 Dec 2025 00:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765413058;
	bh=2IiEqbrbD9E1LgXnoV6os/1h4Z5se5TKtvgyklwKCR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R7kxp+4u67uW6XifPdxDbg5eE28OYJ+mk0XP2Li1/G0e0zXmyRaQMPVFYtrGXKHr1
	 rrbWavPH1MuPGK9SbGsxoACs/znM6MFmLU6GnhC35Q8msOYTVa/arKmM/8NcJaV8KH
	 VMi4PoF+ZdXJMyrwOqL3avavKKTs403n+rP25ogA48NnT+lK46YM8EwR0A0AaR/UWC
	 BKCglWAxRVE3iRsEP6hjBWM3VX0YE3uZwlkWEa9n7paZso9jmq483k91xSXTjv8IOR
	 mYb2CRgKeM28yRSfVDoHvmEwLAVpnKHIqlrgjyfJXOWATG0NY2tSR+l1jJur+lVQEp
	 9ww8vt0d+WY8Q==
Date: Wed, 10 Dec 2025 18:30:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com, Jonathan.Cameron@huawei.com,
	alok.a.tiwari@oracle.com, bhelgaas@google.com, tony.luck@intel.com,
	bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v14 0/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <20251211003057.GA3553594@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210132907.58799-1-xueshuai@linux.alibaba.com>

On Wed, Dec 10, 2025 at 09:29:04PM +0800, Shuai Xue wrote:
> changes since v13:
> - fix doc typos per ALOK TIWARI
> 
> changes since v12:
> - add Reviewed-by tag for PATCH 1 from Steve
> - add Reviewed-by tag for PATCH 1-3 from Ilpo
> - add comments for why use string to define tracepoint per Steve
> - minor doc improvements from Ilpo
> - remove use pci_speed_string to fix PCI dependends which cause build error on sparc64
> 
> changes since v11:
> - rebase to Linux 6.18-rc1 (no functional changes)
> 
> changes since v10:
> - explicitly include header file per Ilpo
> - add comma on any non-terminator entry  per Ilpo
> - compile trace.o under CONFIG_TRACING per Ilpo
> 
> changes since v9:
> - add a documentation about PCI tracepoints per Bjorn
> - create a dedicated drivers/pci/trace.c that always defines the PCI tracepoints per Steve
> - move tracepoint callite into __pcie_update_link_speed() per Lukas and Bjorn
> 
> changes since v8:
> - rewrite commit log from Bjorn
> - move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
> - rename hotplug event strings per Bjorn and Lukas
> - add PCIe link tracepoint per Bjorn, Lukas, and Ilpo
> 
> changes since v7:
> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
> - pick up Reviewed-by from Lukas Wunner
> 
> Hotplug events are critical indicators for analyzing hardware health, and
> surprise link downs can significantly impact system performance and reliability.
> In addition, PCIe link speed degradation directly impacts system performance and
> often indicates hardware issues such as faulty devices, physical layer problems,
> or configuration errors.
> 
> This patch set add PCI hotplug and PCIe link tracepoint to help analyze PCI
> hotplug events and PCIe link speed degradation.
> 
> Shuai Xue (3):
>   PCI: trace: Add a generic RAS tracepoint for hotplug event
>   PCI: trace: Add a RAS tracepoint to monitor link speed changes
>   Documentation: tracing: Add documentation about PCI tracepoints
> 
>  Documentation/trace/events-pci.rst |  74 +++++++++++++++++
>  drivers/pci/Makefile               |   3 +
>  drivers/pci/hotplug/pciehp_ctrl.c  |  31 +++++--
>  drivers/pci/hotplug/pciehp_hpc.c   |   3 +-
>  drivers/pci/pci.c                  |   2 +-
>  drivers/pci/pci.h                  |  21 ++++-
>  drivers/pci/pcie/bwctrl.c          |   4 +-
>  drivers/pci/probe.c                |   9 +-
>  drivers/pci/trace.c                |  11 +++
>  include/trace/events/pci.h         | 129 +++++++++++++++++++++++++++++
>  include/uapi/linux/pci.h           |   7 ++
>  11 files changed, 279 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/trace/events-pci.rst
>  create mode 100644 drivers/pci/trace.c
>  create mode 100644 include/trace/events/pci.h

Applied to pci/trace for v6.20, thanks!  This will be rebased after
v6.19-rc1.

