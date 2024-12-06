Return-Path: <linux-pci+bounces-17827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28AD9E6722
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 07:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C28D18856FF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6C51D88C4;
	Fri,  6 Dec 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrwUSdsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62B13AD0;
	Fri,  6 Dec 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465120; cv=none; b=DLUzZ8SeeiwkhJy+SfMn3dH7og9219T66fLcZSjd7CIjAGZ85E836aSxKNI8pVeCl2IH84OtowtfSLJ10BQSJfjyfmikEZ0bGlkEc+g9302M5CAruXByfKDhtHzYnhm6Ms4lM3NJuoQtbYNNfAVTMxd3M3+GLqfY8RpMavFSoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465120; c=relaxed/simple;
	bh=6Ri12HKLVSBvwN+t+sSnHgbkV9vrXYvjDK7jLXFLZJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p42g1+sSoVyLJIU0qiRq+ciq2hhaGadsZGHayvwQzReEhwFegZ+y2urMNHXCoUi/ZTROO/PJAANQ8VAOZgvk3htG80OUwjjriDXxjT9IPRRMI7gUaMH0nKO4hI0jzx/QJoC0NYgJH5DDgXaA1TTha3FJJMeynXhCgsldUQSTXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrwUSdsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F13C4CED2;
	Fri,  6 Dec 2024 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733465118;
	bh=6Ri12HKLVSBvwN+t+sSnHgbkV9vrXYvjDK7jLXFLZJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrwUSdsiQXWcDSwOJ+EXtaq5uUbLt+N41KLKja7LcPfhf/jODLj2bVpLa0yvXlfgp
	 hFfN0f5NfqdwC+7/pAWA8orzAaOwJNK8BE2LCs9Ksea7jK1pGR4Q8LPK2rAfBehO85
	 2R07CzqDvmmYIrYXVDVJfbzOUyixKHRKxZleq9oc=
Date: Fri, 6 Dec 2024 07:05:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Isaku Yamahata <isaku.yamahata@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Wu Hao <hao.wu@intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>,
	Sami Mujawar <sami.mujawar@arm.com>,
	Steven Price <steven.price@arm.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, Yilun Xu <yilun.xu@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>, John Allen <john.allen@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/11] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
Message-ID: <2024120625-baggage-balancing-48c5@gregkh>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 05, 2024 at 02:23:15PM -0800, Dan Williams wrote:
> Changes since the RFC [1]:
> - Wording changes and cleanups in "PCI/TSM: Authenticate devices via
>   platform TSM" (Bjorn)
> - Document /sys/class/tsm/tsm0 (Bjorn)
> - Replace the single ->exec(@op_code) operation with named operations
>   (Alexey, Yilun)
> - Locking fixup in drivers/pci/tsm.c (Yilun)
> - Drop pci_tsm_devs xarray (Alexey, Yilun)
> - Finish the host bridge stream id allocator implementation (Alexey)
> - Clarify pci_tsm_init() relative to IDE && !TEE devices (Alexey)
> - Add the IDE core helpers
> - Add devsec_tsm and devsec_bus sample driver and emulation
> 
> [1]: http://lore.kernel.org/171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com
> 
> ---
> 
> Trusted execution environment (TEE) Device Interface Security Protocol
> (TDISP) is a chapter name in the PCI specification. It describes an
> alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
> software uses to establish trust in a device and assign it to a
> confidential virtual machine (CVM). It is protocol for dynamically
> extending the trusted computing boundary (TCB) of a CVM with a PCI
> device interface that can issue DMA to CVM private memory.
> 
> The acronym soup problem is enhanced by every major platform vendor
> having distinct TEE Security Manager (TSM) API implementations /
> capabilities, and to a lesser extent, every potential endpoint Device
> Security Manager (DSM) having its own idiosyncratic behaviors around
> TDISP state transitions.

Wow, you aren't kidding about the acronym soup problem, this is a mess.
And does any of this relate to the existing drivers/tee/ subsystem in
any way?

Anyhow, this patch series looks sane, nice work.

> Note that devsec_tsm is for near term staging of vendor TSM
> implementations. The expectation is that every piece of new core
> infrastructure that devsec_tsm consumes must also have a vendor TSM
> driver consumer within 1 to 2 kernel development cycles.

How are you going to enforce this?  By removing infrastructure?
Normally we can't add infrastructure unless there's a real user, and
when you add a real user then you see all the things that need to be
chagned.

So are you ok with the apis and interfaces moving around over time here?
I think I only see sysfs files being exported so hopefully this
shouldn't be that big of a deal for userspace to deal with, but I don't
know what userspace is supposed to do with any of this, is there
external tools to talk to / set up, these devices?

thanks,

greg k-h

