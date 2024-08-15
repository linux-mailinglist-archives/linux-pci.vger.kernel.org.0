Return-Path: <linux-pci+bounces-11706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11495389F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3A1F24CD8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767091BB683;
	Thu, 15 Aug 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRrXGGKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F61AC89F;
	Thu, 15 Aug 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740897; cv=none; b=M4vmBdEtPZMCN36gsYk2ihiKJD0/Xfg49lH2FkfdUuLFsGUZKTf3aa5Z51B3+mT3Yxk7+Kh2KQxlRzZuCLtPjz6LC6Aak65b1lJncbkiiUhUVvaidsiiIcLUZ+WZMI/Pa7gCCdgFUp/9Id2RTVe4Jxm5k5buo5q5C4rVQzpdBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740897; c=relaxed/simple;
	bh=IiPzfdWFgV0eFejeB6ZgwPQvx5KEkij5IPIckyotfGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZGGyLYpFSjkHuqz//LpEfiIRAZrDz0HlCLHrUKipkU5s3ApzDlg0lXLRbFIEg6AmeKx+WU0awg1CsCBQd7cmB1x1Cy8Pc5Bea5SbDGXh/vgEpsI5GatP4NCzYs9/M+ml1ec0ZnjOotBnf+dcC5nPfxKtPa4MFRv18a280n6modY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRrXGGKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C229C32786;
	Thu, 15 Aug 2024 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723740896;
	bh=IiPzfdWFgV0eFejeB6ZgwPQvx5KEkij5IPIckyotfGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LRrXGGKv/Ob6pDzpiGhCvdq6OfYsfOVLADcN/nyjFbYAmczqidpNVYdEQUoVtQuDz
	 ChkMI67z9//iFI/QYpqw4M65OHTaMHmFh+bj0exWUxl/RxKdZSawi2GTTXZg7rApmP
	 idYeviqb4Z2sFWO19bppOfEnb+yk7rF+denFid9e+YNNrXcraFvM18rSfGwevefXOe
	 sMi28B30d/p1DWmW8YOa5+VATfU1GPzxQzy5fWIBDze4X2ncWeVNpADlF1ZcG7gm9A
	 eLw2B3e+6e69+vS+4aDay0OVH8x9DGctq7r8riOuiMA294TrXpFws8fVGZ4kmJsX+u
	 tTBBcPEXZiD/w==
Date: Thu, 15 Aug 2024 11:54:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Gong <richard.gong@amd.com>
Cc: bp@alien8.de, bhelgaas@google.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86/amd_nb: Add a new PCI ID for AMD family 1Ah model 60h
Message-ID: <20240815165454.GA49023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815151240.3132382-1-richard.gong@amd.com>

On Thu, Aug 15, 2024 at 10:12:40AM -0500, Richard Gong wrote:
> Add a new PCI ID for Device 18h and Function 4.
> 
> Signed-off-by: Richard Gong <richard.gong@amd.com>
> ---
> (Without this device ID, amd-atl driver failed to load)

"amd-atl" does not appear in the source, so I don't know what it is.

> ---
>  arch/x86/kernel/amd_nb.c | 1 +
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 61eadde08511..7566d2c079c2 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -125,6 +125,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
>  	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 91182aa1d2ec..d7abfa5beaec 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -581,6 +581,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4 0x124c

From include/linux/pci_ids.h:

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.

Maybe there's some value in having this definition in pci_ids.h as
opposed to adding a definition in amd_nb.c, where there are many
similar definitions?

Can't tell from this commit log.

Obviously this isn't adding any new *functionality*, so it would be
nice if amd_nb.c could be written so it would require updates only
when the programming model changes, not for every new chip.

Preaching to the choir, I know.

>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
> -- 
> 2.43.0
> 

