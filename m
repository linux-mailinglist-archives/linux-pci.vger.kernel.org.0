Return-Path: <linux-pci+bounces-9856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666E4928DBD
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA41C21D26
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB501465B3;
	Fri,  5 Jul 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBwILHie"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D718AF4;
	Fri,  5 Jul 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207237; cv=none; b=NsmI3I1/q2Az1leaEyV8TjqAw0otld6k31Kc0FD33+L5l9yf0STLDQN0LLxDWeFE2b3ss1o5gGm5zIvkQ5qV51p8OpjFdWDILAdx+WdH+pCTj8z2OgpIHGJ4KpNBHa5+PXvuOlgFbXu/+bDTjBZZlfJF4x2VFbKqoh+ZyF7UCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207237; c=relaxed/simple;
	bh=HchELO8nLBln8sfZVXM5+tcXKtpO4xsgC76A+YN3J8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IBStLihpRUAhHvBeh5n0meSW/IwTuF+tVNoty1RAq/j+j/UpdWirytmfCTnGhAnM9ua0fQeY21QzUMPP3cwgnJO2me42D2CYLb8Crm9o059bwzs38VnojfE/xlBfWgYj3BjUxf6qE1qA0NxQsqBCbyfxODIUxf75NejRl6KLop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBwILHie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6141BC116B1;
	Fri,  5 Jul 2024 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720207236;
	bh=HchELO8nLBln8sfZVXM5+tcXKtpO4xsgC76A+YN3J8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kBwILHieC1Z6CJbKtY8lqZJUEsArAzL7hXxABbptIQwOhgNlWFXh9w8DeirvYXyYC
	 d/e80w4K5Dvyuiq7djURjha6yprVRBwnwpuepZYwjO8hHPM4Eky4Fw87WTZV84eHMP
	 j0QhW0xQ3idturpI38gYhlFARaO67tsFjbB+/1NZdtNNA9MdhRNhsSLS7OI2G4YpCq
	 M8rGgPPJ1aauE62olyF3L8DBMukj7fzZrNetCy92bKy21NAesRhcP9SBPDkJfsLuAR
	 dbSAp5iZtsVPGzpSCf/kxV6fF3oF2gCaMSEPQxnppoB/Oknp5hhM8vAr2BoX8qsVDf
	 3KayVZCxp5rRQ==
Date: Fri, 5 Jul 2024 14:20:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>, Vaibhav Jain <vaibhav@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Kowshik Jois B S <kowsjois@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Fix crash during pci_dev hot-unplug on pseries KVM
 guest
Message-ID: <20240705192034.GA73447@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703141634.2974589-1-amachhiw@linux.ibm.com>

[+cc Lukas, FYI]

On Wed, Jul 03, 2024 at 07:46:34PM +0530, Amit Machhiwal wrote:
> With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> of a PCI device attached to a PCI-bridge causes following kernel Oops on
> a pseries KVM guest:
> 
>  RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
>  Kernel attempted to read user page (10ec00000048) - exploit attempt? (uid: 0)
>  BUG: Unable to handle kernel data access on read at 0x10ec00000048
>  Faulting instruction address: 0xc0000000012d8728
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> <snip>
>  NIP [c0000000012d8728] __of_changeset_entry_invert+0x10/0x1ac
>  LR [c0000000012da7f0] __of_changeset_revert_entries+0x98/0x180
>  Call Trace:
>  [c00000000bcc3970] [c0000000012daa60] of_changeset_revert+0x58/0xd8
>  [c00000000bcc39c0] [c000000000d0ed78] of_pci_remove_node+0x74/0xb0
>  [c00000000bcc39f0] [c000000000cdcfe0] pci_stop_bus_device+0xf4/0x138
>  [c00000000bcc3a30] [c000000000cdd140] pci_stop_and_remove_bus_device_locked+0x34/0x64
>  [c00000000bcc3a60] [c000000000cf3780] remove_store+0xf0/0x108
>  [c00000000bcc3ab0] [c000000000e89e04] dev_attr_store+0x34/0x78
>  [c00000000bcc3ad0] [c0000000007f8dd4] sysfs_kf_write+0x70/0xa4
>  [c00000000bcc3af0] [c0000000007f7248] kernfs_fop_write_iter+0x1d0/0x2e0
>  [c00000000bcc3b40] [c0000000006c9b08] vfs_write+0x27c/0x558
>  [c00000000bcc3bf0] [c0000000006ca168] ksys_write+0x90/0x170
>  [c00000000bcc3c40] [c000000000033248] system_call_exception+0xf8/0x290
>  [c00000000bcc3e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> <snip>
> 
> A git bisect pointed this regression to be introduced via [1] that added
> a mechanism to create device tree nodes for parent PCI bridges when a
> PCI device is hot-plugged.
> 
> The Oops is caused when `pci_stop_dev()` tries to remove a non-existing
> device-tree node associated with the pci_dev that was earlier
> hot-plugged and was attached under a pci-bridge. The PCI dev header
> `dev->hdr_type` being 0, results a conditional check done with
> `pci_is_bridge()` into false. Consequently, a call to
> `of_pci_make_dev_node()` to create a device node is never made. When at
> a later point in time, in the device node removal path, a memcpy is
> attempted in `__of_changeset_entry_invert()`; since the device node was
> never created, results in an Oops due to kernel read access to a bad
> address.
> 
> To fix this issue the patch updates `pci_stop_dev()` to ensure that a
> call to `of_pci_remove_node()` is only made for pci-bridge devices.
> 
> [1] commit 407d1a51921e ("PCI: Create device tree node for bridge")
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> Tested-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks for the patch and testing!  Would like a reviewed-by from
Lizhi.

> ---
>  drivers/pci/remove.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..4e51c64af416 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -22,7 +22,8 @@ static void pci_stop_dev(struct pci_dev *dev)
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> -		of_pci_remove_node(dev);
> +		if (pci_is_bridge(dev))
> +			of_pci_remove_node(dev);

IIUC, this basically undoes the work that was done by
of_pci_make_dev_node().

The call of of_pci_make_dev_node() from pci_bus_add_device() was added
by 407d1a51921e and is conditional on pci_is_bridge(), so it makes
sense to me that the remove needs a similar condition.

>  		pci_dev_assign_added(dev, false);
>  	}
> 
> base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
> -- 
> 2.45.2
> 

