Return-Path: <linux-pci+bounces-7028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB08BA302
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A741C22B31
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495257C9D;
	Thu,  2 May 2024 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdhEcvPL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051657C94
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687718; cv=none; b=mT1BH8T2fTWY1jiujdJR53AbcKxAjIGzdXAhGL4WqwCvfW3R/CtUZlxgEGPs3mapcipND3iY33a8yvr/+cW6a6hF+MfD+9tdrVSPXbBXFT+9Zb5cgarxl6przv3JrFg2ECNDhluztKmqMUK7ZEs7HyKkHm1u4mN2Y/6znmDOyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687718; c=relaxed/simple;
	bh=sszOxg8f1FsLKLThEfF3XhSaZxctCyjdySmRuF7oG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ptTXzpse4hFLicV/2zR8Uptjn/5kYI/qK+6O9Hu9lyNExUOnJha4A5fDTzrmyhWUZP5eKjoaFSEnErnXN2WVPqhM+bgKb1vSj+hE/eX0nLPSyeXjSyIRUcu076tBJYYnXKXlukgByZ3w/xHGAWnhlKhZ3Lq1MtrypY2cEkpO0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdhEcvPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3755C113CC;
	Thu,  2 May 2024 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714687717;
	bh=sszOxg8f1FsLKLThEfF3XhSaZxctCyjdySmRuF7oG6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AdhEcvPLtOqgmyhpJa5gmlrQhwYlKxDaV79a1UstAKOb4fpZaUVJR0zfnIiLPR4OM
	 /X30sPAQwKEoFHn4MW5ccw+Clr3nJ1CpeU8wYOKzZWH5dHxvIJxGz3x5C20MtN5YaK
	 nUYGdOPralL1rJHkKt57TVmTTUJvmkCwkXeN06F5xTwtQKhxyCAu1F78jmxPH7FICX
	 XvqgFaM07/xxQZ1vsRLRws8aojpCNgiuessfZ46siPMi94QZYwaVSAb7VAgR0WOOYh
	 spAcO8zLiYK4XME9QSTW30BB9iJlUNAgYAuo0uBQlatAYHHjQSTnoW99YwI2oVLCTA
	 fjxWIIiGRXYgA==
Date: Thu, 2 May 2024 17:08:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH v3] PCI: vmd: always enable host bridge hotplug support
 flags
Message-ID: <20240502220836.GA1550644@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408183927.135-1-paul.m.stillwell.jr@intel.com>

On Mon, Apr 08, 2024 at 11:39:27AM -0700, Paul M Stillwell Jr wrote:
> Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") added
> code to copy the _OSC flags from the root bridge to the host bridge for each
> vmd device because the AER bits were not being set correctly which was
> causing an AER interrupt storm for certain NVMe devices.
> 
> This works fine in bare metal environments, but causes problems when the
> vmd driver is run in a hypervisor environment. In a hypervisor all the
> _OSC bits are 0 despite what the underlying hardware indicates. This is
> a problem for vmd users because if vmd is enabled the user *always*
> wants hotplug support enabled. To solve this issue the vmd driver always
> enables the hotplug bits in the host bridge structure for each vmd.
> 
> Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..583b10bd5eb7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  				       struct pci_host_bridge *vmd_bridge)
>  {
> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
> +	/*
> +	 * there is an issue when the vmd driver is running within a hypervisor
> +	 * because all of the _OSC bits are 0 in that case. this disables
> +	 * hotplug support, but users who enable VMD in their BIOS always want
> +	 * hotplug suuport so always enable it.
> +	 */
> +	vmd_bridge->native_pcie_hotplug = 1;
> +	vmd_bridge->native_shpc_hotplug = 1;

Deferred for now because I think we need to figure out how to set all
these bits the same, or at least with a better algorithm than "here's
what we want in this environment."

Extended discussion about this at
https://lore.kernel.org/r/20240417201542.102-1-paul.m.stillwell.jr@intel.com

>  	vmd_bridge->native_aer = root_bridge->native_aer;
>  	vmd_bridge->native_pme = root_bridge->native_pme;
>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
> -- 
> 2.39.1
> 

