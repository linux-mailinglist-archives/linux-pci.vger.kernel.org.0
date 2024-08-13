Return-Path: <linux-pci+bounces-11644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D76950AB0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543981F218F3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC01A38C8;
	Tue, 13 Aug 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGX4cBJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB419CCF2;
	Tue, 13 Aug 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567463; cv=none; b=r9jtjt888K041gUrI8zanHJ64ut30mZy24u39kga3oTNWu0+VSPxlGuigMOI5XklxwYaCAYsbTTLhUo022eJgqmDGvlIAW+2Pcv9hMuT7dPy4VpP4QXtVLxCgvTnGiu4a/QYK+Rtko0p8Vs7/OL0HCICsWfXWm+nnAoRDAsoSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567463; c=relaxed/simple;
	bh=LLBr5MXHez7WyUhvn2Md4z8ZPhxW+f8cOfnNpaZVh20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD/V4NAlndsVA5I8hKwh/ipl6wnsR5dnhhWNASQsoVhM4o8Vfch4jL3oNg12xtIqt6tJNI6vefMgPFJv9B09XalvipJipYCIT8WLAhvClVrYvz/jKaCpSXywcd8h7UcMqigYvoJWHetQt1tvz3pSFUyIYJaQ+PLM7qS9PitRU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGX4cBJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA41C4AF14;
	Tue, 13 Aug 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567463;
	bh=LLBr5MXHez7WyUhvn2Md4z8ZPhxW+f8cOfnNpaZVh20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGX4cBJl6WVeh17BdybBo5g8HPKEEtk9yIz4J7ylaAoODtoq0GBvMQ3rfNT2h2PwN
	 NX/XQ5pL8CTm+ngMyxa+ycb7EyQVqznexiCn86U8mWObNplcmx8Ycuck9bwHl41EYn
	 K6MKrUPdtCEsUhleU+k3cusyCjMLQ5RsJSH0dz16PNWkmhwU84ovsrpXqopT0sS7q+
	 LL0RPWfUusfGqCvqNHFR7l4wFBkTnm1Gcgxo1VzxmhP7n7NuXjqGjnbywobgC4rvX7
	 SHzu2QlCliAnOTwNoXfnF4JMUcDGmTHZZIDlrYdTLqBEKT3iMGd/slgAp/bN4V5sgJ
	 QIq+e8XsfJW7A==
Date: Tue, 13 Aug 2024 10:44:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Kowshik Jois B S <kowsjois@linux.ibm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Vaibhav Jain <vaibhav@linux.ibm.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Saravana Kannan <saravanak@google.com>, kvm-ppc@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Stefan Bader <stefan.bader@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>, kernel-team@lists.ubuntu.com
Subject: Re: [PATCH v3] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Message-ID: <172356746004.1187542.12106666470550470998.robh@kernel.org>
References: <20240802183327.1309020-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802183327.1309020-1-amachhiw@linux.ibm.com>


On Sat, 03 Aug 2024 00:03:25 +0530, Amit Machhiwal wrote:
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
> To fix this issue, the patch introduces a new flag OF_CREATE_WITH_CSET
> to keep track of device nodes created via `of_pci_make_dev_node()` and
> later attempt to destroy only such device nodes which have this flag
> set.
> 
> [1] commit 407d1a51921e ("PCI: Create device tree node for bridge")
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Kowshik Jois B S <kowsjois@linux.ibm.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes since v2:
>     * Drop v2 changes and introduce a different approach from Lizhi discussed
>       over the v2 of this patch
>     * V2: https://lore.kernel.org/all/20240715080726.2496198-1-amachhiw@linux.ibm.com/
> Changes since v1:
>     * Included Lizhi's suggested changes on V1
>     * Fixed below two warnings from Lizhi's changes and rearranged the cleanup
>       part a bit in `of_pci_make_dev_node`
> 	drivers/pci/of.c:611:6: warning: no previous prototype for ‘of_pci_free_node’ [-Wmissing-prototypes]
> 	  611 | void of_pci_free_node(struct device_node *np)
> 	      |      ^~~~~~~~~~~~~~~~
> 	drivers/pci/of.c: In function ‘of_pci_make_dev_node’:
> 	drivers/pci/of.c:696:1: warning: label ‘out_destroy_cset’ defined but not used [-Wunused-label]
> 	  696 | out_destroy_cset:
> 	      | ^~~~~~~~~~~~~~~~
>     * V1: https://lore.kernel.org/all/20240703141634.2974589-1-amachhiw@linux.ibm.com/
> 
>  drivers/pci/of.c   | 3 ++-
>  include/linux/of.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


