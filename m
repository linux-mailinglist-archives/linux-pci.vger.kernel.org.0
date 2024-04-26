Return-Path: <linux-pci+bounces-6706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A388B423E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9448B1F21FFD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B239856;
	Fri, 26 Apr 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffoKaCag"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72C3B79C
	for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171208; cv=none; b=VoLkWvBcW+EPEgk9I288gz2TDHNYMaKBF+urM21t/AsW0zVH60odTmlE34s6Kp5o+SwAGPNLKoQPvMYLcDuamKfaH6LrGbRzoQeSXaKN4KCIm9/Y3E8ImOhK8GVhMj+85d1X0okWUqWXQrM7vmsv8U52cofjaed94N55UrFkQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171208; c=relaxed/simple;
	bh=Z4vIo6oxvepWs2wMwGJmKWI/lutvFxAU+zCQEwqETG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I6lM6zLuU7SnUnHUgpmS/iLE2P3szunuVWZaJHOA24AVUNXnzmkRCV3QkvV6fo651BI4gLvvY6cvtITtdRZvuEt/stu934FPm1ungjTEQGiXKl6KiurR09YvylUkd/CeyZIJXeEm+FmeNjNRTu4nqpp4rSIkPbQCiDkwSR3h2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffoKaCag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F73C32783;
	Fri, 26 Apr 2024 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714171208;
	bh=Z4vIo6oxvepWs2wMwGJmKWI/lutvFxAU+zCQEwqETG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ffoKaCagS8oPUYrXZTSMqEG2pfUx2DwUqWWxkzhnhaJ/g+eErHNcoYma7nj3vxN3v
	 fJtOq45baPpF2Z6nnouPArqThWWG4bZFOcvAA4IjFgkOZDsxrBU6MPLmUC9VB8a6mL
	 Si5nwtto5OPzlv1EDLS004MWEzGpSObZ7fVHVwjHPRk9SUN/PUMGb92rljgnUo+hwz
	 Cb9Siz+L8tAh/FdC46GEgUdLSzo92ZuNsXTn42bYnVzij7TA6WjnST8INSZE8v5A0N
	 YOimDF+cHbRVNC+zoRTGIhZF581gtubet2p6pLPCC73NdIPo5zcl1CYBYKEFBMdI7e
	 ZzFqDLVZFX74w==
Date: Fri, 26 Apr 2024 17:39:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Disable MSI remap only for low MSI count
Message-ID: <20240426223957.GA609812@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418153121.291534-1-nirmal.patel@linux.intel.com>

I think this refers specifically to MSI-X, so use "MSI-X" in the
subject.

On Thu, Apr 18, 2024 at 11:31:21AM -0400, Nirmal Patel wrote:
> VMD MSI remapping is disabled by default for all the CPUs with 28c0 VMD
> deviceID. We used to disable remapping because drives supported more
> vectors than the VMD so the performance was better without remapping.
> Now with CPUs that support more than 64 (128 VMD MSIx vectors for gen5)
> we no longer need to disable this feature.

"because drives supported more vectors" ... I guess you are referring
to typical devices that might be behind a VMD?  But I assume there's
no actual requirement that those devices be "drives", right?

"CPUs that support more than 64 ... 128 VMD vectors"  Are we talking
about *CPUs* that support more vectors, or *VMDs* that support more
vectors?

I guess you probably think of CPUs here because VMD is integrated into
the same package, right?  That would explain the "CPUs with 28c0 VMD"
comment.  But the vmd driver doesn't care about that; it just claims a
PCI device.

s/MSI remapping/MSI-X remapping/ (I think?)
s/MSIx/MSI-X/ to match spec usage.

A reference to ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when
possible"), which added VMD_FEAT_CAN_BYPASS_MSI_REMAP, might be
useful because it has nice context.

IIUC this will keep MSI-X remapping enabled in more cases, e.g., on
new devices that support more vectors.  What is the benefit of keeping
it enabled?

The ee81ee84f873 commit log suggests two issues:

  - Number of vectors available to child domain is limited by size of
    VMD MSI-X table.

  - Remapping means child interrupts have to go through the VMD domain
    interrupt handler instead of going straight to the device handler.

But this commit log suggests that with more vectors, you can enable
remapping even without a performance penalty?  Maybe the VMD domain
interrupt handler was only needed because of vector sharing?

I'm just a little confused because this commit log doesn't say what
the actual benefit is, other than "keeping remapping enabled", and I
don't know enough to know why that's good.

> Note, pci_msix_vec_count() failure is translated to ENODEV per typical
> expectations that drivers may return ENODEV when some driver-known
> fundamental detail of the device is missing.
> 
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v1->v2: Updating commit message.
> v2->v3: Use VMD MSI count instead of cpu count.
> v3->v4: Updating commit message.
> ---
>  drivers/pci/controller/vmd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..ba63af70bb63 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,8 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +#define VMD_MIN_MSI_VECTOR_COUNT 64
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical location of the
> @@ -807,13 +809,20 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	sd->node = pcibus_to_node(vmd->dev->bus);
>  
> +	vmd->msix_count = pci_msix_vec_count(vmd->dev);
> +	if (vmd->msix_count < 0)
> +		return -ENODEV;
> +
>  	/*
>  	 * Currently MSI remapping must be enabled in guest passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is probably
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.

This part of the comment might need some updating.  I don't see the
connection with guest passthrough mode in the code.

> +	 * Disable MSI remapping only if supported by VMD hardware and when
> +	 * VMD MSI count is less than or equal to minimum MSI count.

Add blank line between paragraphs or rewrap into a single paragraph.

>  	 */
>  	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +	    vmd->msix_count > VMD_MIN_MSI_VECTOR_COUNT ||
>  	    offset[0] || offset[1]) {

I think this conditional might be easier to read if it were inverted:

  if (features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) && ...) {
    vmd_set_msi_remapping(vmd, false);
  } else {
    ret = vmd_alloc_irqs(vmd);
    ...
  }

Maybe a separate patch though.

>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)
> -- 
> 2.31.1
> 

