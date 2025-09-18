Return-Path: <linux-pci+bounces-36435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38210B86AC3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED60D1C88345
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB76296BBC;
	Thu, 18 Sep 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX531q6R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342935947;
	Thu, 18 Sep 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223736; cv=none; b=KY0hvqlf7GqUp1KiGVY8CRbSEiPBuR/28fhvpeKAidyx/msWVMhiioz3yBLaHg5leqwu1CPO40Acs2BGy214cd8HE9eZ7warf0hIU89zFStW9SZnoJWXVQqTR9TfvxF1ypo2JRTlMIgtJ5VFKLdYDJkhp6UtR5D/dr37hjDfSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223736; c=relaxed/simple;
	bh=gYMuW0dZsMGQD0qefNZ1sbRCf1NIH0tjuo5RmuqPOjc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bKMgl0i7kYGyGebm4655GJ8aaVddSV6znwpebF/Px5s3wf8Ev7Au0h+sFfvLFuzY8UDOOhcNBsX5I3f0CwzD0fvSFW4rB1naew8WYEHB9FuXxbZvu3ji7mSTU1y6PKUTXLuxPYzmg4x/CZXw8Y3uBXcE0/PyA6j+wHvJjEhxjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX531q6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664FDC4CEE7;
	Thu, 18 Sep 2025 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223735;
	bh=gYMuW0dZsMGQD0qefNZ1sbRCf1NIH0tjuo5RmuqPOjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lX531q6RZBl8J0iqrcj8qiYOaIpSgWhsptzweWGqhN2XDeYoTOsclnMx2f1FQzPEK
	 RwZIYTim7i+vyKxjPug1cE1S2KzTpuBPnL1idIH28qOTOm/06ekMQwlvYxPDDYubwW
	 U0npmCL+5XnhOsR3869BUOXYR8KgV3Vs/QyXrVCXQ1YO0tNpA696Dt+B/a0airxeT8
	 3CZEJ/NA3NmyG8c0X+Ph1bjFhn5knlgEgfP+UXGEejZEGvfwFp9rZpzLrdsotWphSj
	 0kv+uL+/ekUACxkHHszcs4bHuUedlwAlJjum/279b+l43fkMMdNPBzWCpv2lsO/Cit
	 h/5pI66il75og==
Date: Thu, 18 Sep 2025 14:28:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: George Abraham P <george.abraham.p@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, giovanni.cabiddu@intel.com,
	Wei Huang <wei.huang2@amd.com>, Jing Liu <jing2.liu@intel.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] PCI/TPH: Skip Root Port completer check for RC_END
 devices
Message-ID: <20250918192854.GA1916809@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918084940.1334124-1-george.abraham.p@intel.com>

[+cc authors of TPH support]

On Thu, Sep 18, 2025 at 02:19:40PM +0530, George Abraham P wrote:
> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
> directly integrated into the root complex and do not have an
> associated Root Port in the traditional PCIe hierarchy. The current
> TPH implementation incorrectly attempts to find and check a Root Port's
> TPH completer capability for these devices.
> 
> Add a check to skip Root Port completer type verification for RC_END
> devices, allowing them to use their full TPH requester capability
> without being limited by a non-existent Root Port's completer support.
> 
> For RC_END devices, the root complex itself acts as the TPH completer,
> and this relationship is handled differently than the standard
> endpoint-to-Root-Port model.

I thought maybe the spec would mention TPH Completer Supported for a
Root Complex in an RCRB, but I looked through PCIe r7.0 and didn't see
anything in RCRB related to the Root Port TPH Completer Supported
field in Device Capabilities 2.

It seems sort of surprising that Root Ports have to advertise what
kinds of TPH Completers they support, but we can assume that Root
Complexes support both TPH and Extended TPH Completers.  Do you have
any insight into that?

But I certainly agree that as-is, TPH is useless for RCiEPs since
there's no Root Port, so we assume the completer has no TPH Completer
support at all.

Do you think we should add a Fixes: tag for f69767a1ada3 ("PCI: Add
TLP Processing Hints (TPH) support"), where the TPH support was added?

> Signed-off-by: George Abraham P <george.abraham.p@intel.com>
> ---
>  drivers/pci/tph.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index cc64f93709a4..c61456d24f61 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -397,10 +397,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	else
>  		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
>  
> -	rp_req_type = get_rp_completer_type(pdev);
> +	/* Check if the device is behind a Root Port */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
> +		rp_req_type = get_rp_completer_type(pdev);
>  
> -	/* Final req_type is the smallest value of two */
> -	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +		/* Final req_type is the smallest value of two */
> +		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +	}
>  
>  	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
>  		return -EINVAL;
> 
> base-commit: c29008e61d8e75ac7da3efd5310e253c035e0458
> -- 
> 2.40.1
> 

