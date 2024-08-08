Return-Path: <linux-pci+bounces-11512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5294C585
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE461F22BFD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF871146A61;
	Thu,  8 Aug 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7g3CyU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E754A1E;
	Thu,  8 Aug 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147851; cv=none; b=ST/ZyVVmRLXJWb1hCv/aUDUvlVZ8EwaJYQonTKCY3XODLqBN6Cx/Phsa+6kKGBzS3ENM1FGztC2W33vaYugqJ8tfyZu7le1fPw4FYmuGea9mWLanZ9S9s/SSkDYcDcBHH1I8pG91rGLrH0WbNT/9LBRV7vH4DNnHe3It4EXHS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147851; c=relaxed/simple;
	bh=fZ+glFhG10pq+CGs532gxBEKs+f6eJvEdJZOh66ZT0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZBzxCwm/h2bAw4Yd7ATqYN3c4q2D4C7ooPp0S7Fu+6ri/APhlNPzOJvSxqpry1DXUnI5QsusSLrI1crPtJ6cAw8HmLjBKLRDx4qo5Tu7aU9efH8aMfQXcU4WPYbnmkkfw58EZ32IonRKzdvHwN5/+WHNwpyECuNb5VTQly78DPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7g3CyU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B3AC32782;
	Thu,  8 Aug 2024 20:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723147851;
	bh=fZ+glFhG10pq+CGs532gxBEKs+f6eJvEdJZOh66ZT0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V7g3CyU9Nbmo5hcYkSP+f2WHIKpc/fTejVt1hGda6kEuxlZsPmMXntmoH8dj/kpbX
	 dCm4iXPi79xIX6wDX/heIItcUZGEb58escG76upaWXM11/Qbjq2axEI/RP0zzMZzmD
	 GQNQPjgqHWAq6LXEmFjSQIK4yAsyRfaStnEZ1sTcG9Xbb+HX21ULbfq4qKlM7rFOdm
	 709Fm7snksjKEtkA7IiUhqqO8C+20s9zw/qRDV0KoQCimauCwd9ilq0KJ3jQOk2Wmh
	 Y9rb/Ax74BLU5RcMGQc9SOvOMQj+RQz45sYHySj+8/NNHGnWC5L16zVzQx6xVrtoa0
	 R4+VCOAFNIaoQ==
Date: Thu, 8 Aug 2024 15:10:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stewart Hildebrand <stewart.hildebrand@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Yongji Xie <elohimes@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] x86/PCI: Preserve IORESOURCE_STARTALIGN alignment
Message-ID: <20240808201048.GA157414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807151723.613742-6-stewart.hildebrand@amd.com>

On Wed, Aug 07, 2024 at 11:17:14AM -0400, Stewart Hildebrand wrote:
> There is a corner case in pcibios_allocate_dev_resources() where the
> IORESOURCE_STARTALIGN alignment of memory BAR resources gets
> overwritten. This does not affect bridge resources. The corner case is
> not yet possible to trigger on x86, but it will be possible once the
> default resource alignment changes, and memory BAR resources will start
> to use IORESOURCE_STARTALIGN. 

I see from [8/8] that "Changing pcibios_default_alignment() results in
the second method of alignment with IORESOURCE_STARTALIGN", but that
connection is not at all obvious, and there's no patch in this series
that sets IORESOURCE_STARTALIGN, so it's kind of hard to connect all
the dots here.

The only caller of pcibios_default_alignment() is
pci_specified_resource_alignment(), and that doesn't mention
IORESOURCE_STARTALIGN either.

Neither does pcibios_allocate_dev_resources().

I feel like we've had this conversation before; apologies if so.  But
we need to figure out to make this more explicit and less magic.

> Account for IORESOURCE_STARTALIGN in
> preparation for changing the default resource alignment.
> 
> Skip the pcibios_save_fw_addr() call since the resource doesn't contain
> a valid address when alignment has been requested. The impact of this is
> that we won't be able to restore the firmware allocated BAR, which does
> not meet alignment requirements anyway.
> 
> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
> ---
> v2->v3:
> * no change
> 
> v1->v2:
> * capitalize subject text
> * clarify commit message
> * skip pcibios_save_fw_addr() call
> ---
>  arch/x86/pci/i386.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index 3abd55902dbc..13d7f7ac3bde 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -256,7 +256,7 @@ static void alloc_resource(struct pci_dev *dev, int idx, int pass)
>  		if (r->flags & IORESOURCE_PCI_FIXED) {
>  			dev_info(&dev->dev, "BAR %d %pR is immovable\n",
>  				 idx, r);
> -		} else {
> +		} else if (!(r->flags & IORESOURCE_STARTALIGN)) {
>  			/* We'll assign a new address later */
>  			pcibios_save_fw_addr(dev, idx, r->start);
>  			r->end -= r->start;
> -- 
> 2.46.0
> 

