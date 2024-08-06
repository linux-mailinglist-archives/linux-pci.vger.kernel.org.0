Return-Path: <linux-pci+bounces-11386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E19498BC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 22:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C801F2305D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042D7D40B;
	Tue,  6 Aug 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YirUaony"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10338DD8;
	Tue,  6 Aug 2024 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974462; cv=none; b=uiawXHNKnnhZT7wnYgkpmKN2BXI7fMxxgXSM89ScUMlW3Hzy6Oa7FZTOfrvCAsDKV4tUK2Q0PBYTvdHkLNlQMIhMayM7eRwcenNEEts8nhogVE2nF36dt9S7MW+BleNbehbZrY7TapZWojy62nm1nE9KMhau7Fn3N3++EzCksJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974462; c=relaxed/simple;
	bh=t/hN2y1XYKOsn2IY/TkVfglq3EKviiTjFSjUkFXXSXA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d7w3gccldK/LY/prCr/NSh+uBPkkgw7Ete5TXNDBFeTjn9s3DENRI9WCrl5XhfKs97jFekX0HTbOgB7XYV+EPvt3U/U8AA1c641V8ht/1SiOZaNrhspFqx5apK3kFENdn+L37xwOQJFpxIr+804GUWp31ORKULtZ5itsZwElaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YirUaony; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54973C4AF0C;
	Tue,  6 Aug 2024 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722974461;
	bh=t/hN2y1XYKOsn2IY/TkVfglq3EKviiTjFSjUkFXXSXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YirUaonym+NqN0rn16gxCaQZnUdURBfBbcCtm04Th4BJn6KIoX/5HL8SMT0Ani+tV
	 3Z9Z48AFin+sbKkc6+MdfBdBuWxqCGysVXgsHafFmqh9n1gi2iPEnyTbuT0gWPx5tK
	 Dj0rjzr4MMd4FRrRU9ePNjJrRDRL/hmHk5VDzemdUNxHPzRcJ5iVoa2uHb8Lgkw1NF
	 2rZlSRWiCHINPSFjKBxWVYYp5JOS7G1lpmrZ+gEh+RifTI/GzNEDCtc5wXeE59BpXC
	 5J51YO0gLxSo0r5h/JXKyUmK2Rca8+IZNyfIoBXMrb8ID2Pg/UdEnkbJH3Kj/WS81k
	 gEHnuoZcQSURA==
Date: Tue, 6 Aug 2024 15:00:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Kowshik Jois B S <kowsjois@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>, kernel-team@lists.ubuntu.com,
	Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [PATCH v3] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Message-ID: <20240806200059.GA74866@bhelgaas>
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

On Sat, Aug 03, 2024 at 12:03:25AM +0530, Amit Machhiwal wrote:
> With CONFIG_PCI_DYNAMIC_OF_NODES [1], a hot-plug and hot-unplug sequence
> of a PCI device attached to a PCI-bridge causes following kernel Oops on
> a pseries KVM guest:

What is unique about pseries here?  There's nothing specific to
pseries in the patch, so I would expect this to be a generic problem
on any arch.

>  RTAS: event: 2, Type: Hotplug Event (229), Severity: 1
>  Kernel attempted to read user page (10ec00000048) - exploit attempt? (uid: 0)
>  BUG: Unable to handle kernel data access on read at 0x10ec00000048

Weird address.  I would expect NULL or something.  Where did this
non-NULL pointer come from?

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

I'm sure this description is 100% correct, but it's at such a low
level that it doesn't really help understand the underlying design
problem.

Will need an ack from Rob.

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
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index dacea3fc5128..bc455370143e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -653,7 +653,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	struct device_node *np;
>  
>  	np = pci_device_to_OF_node(pdev);
> -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> +	if (!np || !of_node_check_flag(np, OF_CREATE_WITH_CSET))
>  		return;
>  	pdev->dev.of_node = NULL;

of_pci_remove_node() goes on to call of_changeset_revert() and
of_changeset_destroy().  of_pci_remove_node() has nothing PCI-specific
in it.

There are a few other callers of of_changeset_destroy(), but they
don't look anything like of_pci_remove_node().  Seems like there
should be some similarity across the callers, so it makes me a little
nervous that there isn't.

> @@ -712,6 +712,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_free_node;
>  
> +	of_node_set_flag(np, OF_CREATE_WITH_CSET);
>  	np->data = cset;
>  	pdev->dev.of_node = np;
>  	kfree(name);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 85b60ac9eec5..5faa5a1198c6 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -153,6 +153,7 @@ extern struct device_node *of_stdout;
>  #define OF_POPULATED_BUS	4 /* platform bus created for children */
>  #define OF_OVERLAY		5 /* allocated for an overlay */
>  #define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
> +#define OF_CREATE_WITH_CSET	7 /* Created by of_changeset_create_node */

Follow existing capitalization style.

