Return-Path: <linux-pci+bounces-6494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D618AB714
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EF4B2138D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7713D25B;
	Fri, 19 Apr 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFmPXU6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD912DD97;
	Fri, 19 Apr 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564452; cv=none; b=hhGUd2b5SE8MoBJn37mlzTk2HuwxMabw+MRm5oElIY6YCP2meUOV9g8P5n6cWzDxVujqkAImN7OKeqBr06LsKwF6YNjqwpL3a8+ZHP5koUxA5VgJSwLyMOfXrJwM0shyyjv8LPQuqeZ3wN4gNmG0bBH1xbS8mx9WbwB69/61tiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564452; c=relaxed/simple;
	bh=0HB+VSrg3fy+9fA+uyGYMZ9i5rgFhbUhobjGB8kHAE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l/w6aE0l3yRGeKJjbAChu5ayQouAgazKiCl56xPBksUbkkr8lS3MGnNlspPjwFRVIOpDauBvvC/yiXG9XFKDg4SEZGVqaskpDeDrVH1j6NJ8QkXwOixP1G/uKVNzUHcY+rADoQYsjZcHRnrCO3Rg2dT12WwuFt7sBIde+uugH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFmPXU6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34563C072AA;
	Fri, 19 Apr 2024 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713564451;
	bh=0HB+VSrg3fy+9fA+uyGYMZ9i5rgFhbUhobjGB8kHAE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DFmPXU6vV2QYdlwB6/cusdPrw8iXj4keVBYNfCEIwtJpdhOGUo0UsRmOrNsEML16w
	 j5/ZxChqkBAY1Op2EOxo+TXTTfw9x646z1V94WdNKXyi6LkdSM1hIK3qrY8eRJF0Rm
	 ndZoeriyRk26dsCuuov0nX3s5K3lKvtNBsDupXwBva8m3vjJ/rUmb0S0xLyCTHjaiT
	 oKHZDTZydofYog/8txpsY5djG0PoMkUxbgK06hdjlJxgiKQj+KS4JnrrchokR/M6KJ
	 8wvLfcW7zBqInp+GdjvMa3qFaPW9PIYL4Evo6TscKtBBu31w/3ShEM4kOrVWE37VHo
	 iTQUnfF0+JY/g==
Date: Fri, 19 Apr 2024 17:07:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Wu Hao <hao.wu@intel.com>,
	Yilun Xu <yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kevin.tian@intel.com,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20240419220729.GA307280@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>

On Fri, Apr 12, 2024 at 01:52:13AM -0700, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> interface definition builds upon Component Measurement and
> Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> adds support for assigning devices (PCI physical or virtual function) to
> a confidential VM such that the assigned device is enabled to access
> guest private memory protected by technologies like Intel TDX, AMD
> SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> attribute, and add more properties + controls in a tsm/ subdirectory of
> the PCI device sysfs interface. Unlike CMA that can depend on a local to
> the PCI core implementation, PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. Consider that the TSM driver may
> itself be a PCI driver. Userspace can depend on the common TSM device
> uevent to know when the PCI core has TSM services enabled. The PCI
> device tsm/ subdirectory is supplemented by the TSM device pci/
> directory for platform global TSM properties + controls.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'enum pci_tsm_cmd'. For now only connect and disconnect are defined for
> establishing a trust relationship between the host and the device,
> securing the interconnect (optionally establishing IDE), and tearing
> that down.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem flushes
> all inflight commands when a TSM low-level driver/device is removed.
> 
> In addition to commands submitted through an 'exec' operation the
> low-level TSM driver is notified of device arrival and departure events
> via 'add' and 'del' operations. With those it can setup per-device
> context, or filter devices that the TSM is not prepared to support.
> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# PCI parts

> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		March 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a device supports CMA and IDE,
> +		and only after a TSM driver has loaded and evaluated this
> +		PCI device. All present devices shall be dispositioned
> +		after the 'add' event for /sys/class/tsm/tsm0 triggers.

What does "dispositioned" mean?

What devices does "all present devices" cover?

Is "tsm0" a special global thing?  Is there doc for
/sys/class/tsm/...?

> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,8 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o

Maybe put it next to CONFIG_PCI_DOE or at least not off in a special
separate list?

Bjorn

