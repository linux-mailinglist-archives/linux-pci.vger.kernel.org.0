Return-Path: <linux-pci+bounces-7272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245AF8C0732
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 00:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F3A281B1A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6C132C1A;
	Wed,  8 May 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HND831Ze"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B821373;
	Wed,  8 May 2024 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206211; cv=none; b=WSy4Kd67tPslG2xkD/DlooPoYk6jQayrqb22m4bpeLk8nev6UtY16lvo9N4K4y/Fn+7pDkaHmNirSVfRbVXuBpiA7a6ZRf31LDj4jRINFgSpcCuRvzeKov8qIrhf364pxm0disAd5pS0cemZ4SiACIW0Yx5QjfBVqEMS8VWZgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206211; c=relaxed/simple;
	bh=oJS1b9ugkLC7Q0oR7pdegtmRBU1Nam419JR29IfIvfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OjO5OK287yjpqaEI3CMMSeeKv7z0zIjC5PfTUoDpwmT3zk0NtLMNoSmteM6Y+M6UH5Tv4s0YPQCqq3AgZBckOTgeoscvgZago/qG04SL3QX0a6lQfMrcGu/fJL5TwUpRqHY8TYUxg0Iv6CRux/mAHb8M9993qH+3isDpW0RdHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HND831Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045F1C113CC;
	Wed,  8 May 2024 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715206211;
	bh=oJS1b9ugkLC7Q0oR7pdegtmRBU1Nam419JR29IfIvfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HND831Ze4xj8nuBTXOelFk8NhKmiT3Vm++Gjz95ZQr+7H/nv8dUIEqXQrpZvcp78b
	 F39ss/EdnUYrjhMyCU5hXJNnFWp2Bf5ICrFMQuvG8p724QF7FsMI2O4gTXsXqvyoJW
	 3mzorrmic3trDKdoj92d1IKsdUsDCaWUAzAR82Xgj524JC0fR6dCZkwhffc7WBJp7q
	 VmYRlAI/bQOmKfwGKQGzW9yKDAvFn9Nxp/kcLC7XGJpuy2USwD2wQOvNNoLxzb2vmB
	 FNUOAUtPlqS6GpqeGlaN0OvUkvi7mfqQnI1KzpqdthCJUww4m3TYtfPNjG/Un97rfr
	 7j12I3tjPdrTw==
Date: Wed, 8 May 2024 17:10:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH v2 2/3] PCI: Add AER bits #defines for PCIe to PCI/PCI-X
 Bridge
Message-ID: <20240508221009.GA1791183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218030430.783495-3-LeoLiu-oc@zhaoxin.com>

On Mon, Dec 18, 2023 at 11:04:29AM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Define secondary uncorrectable error mask register, secondary
> uncorrectable error severity register and secondary error capabilities and
> control register bits in AER capability for PCIe to PCI/PCI-X Bridge.
> Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
> 5.2.3.3 and 5.2.3.4.

Please include the spec revision.  The only one I'm aware of is r1.0.

> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> ---
>  include/uapi/linux/pci_regs.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..987c513192e8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -802,6 +802,9 @@
>  #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
>  #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
>  #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
> +#define PCI_ERR_UNCOR_MASK2	0x30    /* PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_UNCOR_SEVER2	0x34    /* PCIe to PCI/PCI-X Bridge */
> +#define PCI_ERR_CAP2	0x38    /* PCIe to PCI/PCI-X Bridge */
>  
>  /* Virtual Channel */
>  #define PCI_VC_PORT_CAP1	0x04
> -- 
> 2.34.1
> 

