Return-Path: <linux-pci+bounces-36276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F9B59D6F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D41618863A0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A623368094;
	Tue, 16 Sep 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE6EV1eM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED229B78E;
	Tue, 16 Sep 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039786; cv=none; b=auEfK2VfGvEV2bA/aj+9zI+Pch7nG/CIqwRr6hM7VbVIbgANuZsnSQh+EM0o3q48upfn4YYck1nAA702p62mFwMWxYRDj6WaBobuacVDlTJxWVSkDRNrta2HoYvNMN/RHeFKK2E7YrH+pS9oNeb/Mo2qVQnyDRHNX+I75zuOPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039786; c=relaxed/simple;
	bh=Of7CIWNaYZxVWuGrbyYy1/yauDDu4wMEV4oBct98H8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=coedIp7B9/KVuDZNZhSjDplO4H8yNoaSMY2YmsGIofpNWGytC+4j3WMdknaB6USA8exSND7b3ouIMrNOr0KcEvc5g4SyEFa3IV8LhOUE/mOoIe8lwq/hckh9OmKUnDywyBMRa18kHLfY7GtfBJT8Ujzl8kLXxvTb8/uBdMikVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE6EV1eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636B3C4CEF0;
	Tue, 16 Sep 2025 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039785;
	bh=Of7CIWNaYZxVWuGrbyYy1/yauDDu4wMEV4oBct98H8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RE6EV1eM25L5kETGdQos/HDLxe9jUhJMIKDOMHGyCCmQueKPHTd9OabSYyfmWMW94
	 F77fuzqqZ8f2/2YQkti1kXT+Uj3pM1HVF2oB17HGyJM86prukkrreCkNCK/reuXW6G
	 nZbiQuN5Q9eEQJ/IhJfHjNzYseASMOS4SgKV+8NPW1vqqwEGaaIBxpo3SAavw3AmqJ
	 rfSguHsqc3IyZlKdRhH8yLucbr5oiAbJaz6SFcYsnS5FzrBbGfc23lTpCDhbDnVpmB
	 mygEGhx70FFZSRzKKy9klTT613brhb3TZNyY1e0LAHklYwJVR3wdg8ptlznRmYzNJ2
	 09mbZ6UqYhEpw==
Date: Tue, 16 Sep 2025 11:23:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/24] PCI: Bridge window selection improvements
Message-ID: <20250916162303.GA1805891@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>

On Fri, Aug 29, 2025 at 04:10:49PM +0300, Ilpo Järvinen wrote:
> This series is based on top of the three resource fitting and assignment
> algorithm fixes already in the pci/resource branch. I've tried to compare
> these patch with the commits in the pci/resource branch to retain the minor
> spelling/grammar corrections Bjorn made while applying v1.
> 
> v2 is just to fix two small issues within the series intermediate patches.
> These corrections attempt to ensure this series is bisectable if
> troubleshooting requires that in the future.
> 
> In addition, a few corrections to changelog texts were made.
> 
> I'm left to wonder though if the added double spaces after some stops
> within the commit messages in the pci/resource branch were intentional or
> not (I did remove them for v2).
> 
> As the changes are very minimal, I'm only sending this to lists and Bjorn
> to spare people's inboxes. If somebody provides a Tested-by tag for v1, it
> should be counted in for this v2 (v1 vs v2 difference does not matter if
> testing the entire series).
> 
> v2:
> - In pci_bridge_release_resources():
>     - Keep type assignment in until removing the type hack.
>     - Introduce res_name in the patch it is used avoid compiler warning
>       about unused variable. Place it into the block that needs it.
> - Minor corrections to changelog texts
> 
> Ilpo Järvinen (24):
>   m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
>   sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
>   MIPS: PCI: Use pci_enable_resources()
>   PCI: Move find_bus_resource_of_type() earlier
>   PCI: Refactor find_bus_resource_of_type() logic checks
>   PCI: Always claim bridge window before its setup
>   PCI: Disable non-claimed bridge window
>   PCI: Use pci_release_resource() instead of release_resource()
>   PCI: Enable bridge even if bridge window fails to assign
>   PCI: Preserve bridge window resource type flags
>   PCI: Add defines for bridge window indexing
>   PCI: Add bridge window selection functions
>   PCI: Fix finding bridge window in pci_reassign_bridge_resources()
>   PCI: Warn if bridge window cannot be released when resizing BAR
>   PCI: Use pbus_select_window() during BAR resize
>   PCI: Use pbus_select_window_for_type() during IO window sizing
>   PCI: Rename resource variable from r to res
>   PCI: Use pbus_select_window() in space available checker
>   PCI: Use pbus_select_window_for_type() during mem window sizing
>   PCI: Refactor distributing available memory to use loops
>   PCI: Refactor remove_dev_resources() to use pbus_select_window()
>   PCI: Add pci_setup_one_bridge_window()
>   PCI: Pass bridge window to pci_bus_release_bridge_resources()
>   PCI: Alter misleading recursion to pci_bus_release_bridge_resources()
> 
>  arch/m68k/kernel/pcibios.c   |  39 +-
>  arch/mips/pci/pci-legacy.c   |  38 +-
>  arch/sparc/kernel/leon_pci.c |  27 --
>  arch/sparc/kernel/pci.c      |  27 --
>  arch/sparc/kernel/pcic.c     |  27 --
>  drivers/pci/bus.c            |   3 +
>  drivers/pci/pci-sysfs.c      |  27 +-
>  drivers/pci/pci.h            |   8 +-
>  drivers/pci/probe.c          |  35 +-
>  drivers/pci/setup-bus.c      | 798 ++++++++++++++++++-----------------
>  drivers/pci/setup-res.c      |  46 +-
>  include/linux/pci.h          |   5 +-
>  12 files changed, 504 insertions(+), 576 deletions(-)

Updated pci/resource with this v2, thanks for the reminder!

