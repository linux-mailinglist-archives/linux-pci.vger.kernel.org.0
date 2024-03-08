Return-Path: <linux-pci+bounces-4672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F987682B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB57B20E94
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A401F947;
	Fri,  8 Mar 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQW+3eVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6971DFDE;
	Fri,  8 Mar 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914413; cv=none; b=DbBadcz+c0PvCSTm5zrZlRs/C/MAShjiXmHuaq+1qq+GgleFZkxuL/Gz9fT0TU/dL4yfTXDdIwB3vXDpr6RemG3jmcN53FsCaQ2gJ3ebLBEOUh6oxE4bSpZWFhLIHpXkUHefjO5xQLVr3ZkYvwkPryBk7ECldVSZ7JayajG2rnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914413; c=relaxed/simple;
	bh=HSmK8y4wZfMaF9zPGuPkWTfpEvKg9sCf44pQ9TfKLKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a7h0O1MNu1dk0fMNOBDB1kMnMAvsEUGW8CX9ZTd9sIxenxpmM+I/vt7xzKCV8mPVugYMf8tMWXqVvAzIKlOYkTWZeVXPMw55Rt1sG0sNV0sP+JDrKATGfiJB9dKHQJRoXVDz2MyE0E1jiwbJhcmZ4Hu3B911QxidnAUDuFzkfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQW+3eVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE693C433F1;
	Fri,  8 Mar 2024 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914413;
	bh=HSmK8y4wZfMaF9zPGuPkWTfpEvKg9sCf44pQ9TfKLKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DQW+3eVHqqURvbqP0/pUlvw8/g5/RvwEORqnou2Y7p0rH5IW97csuPRMsZKHuO8wv
	 JbYEgqXWP5gzgqGWLXQJsPVRu03W4kOTpFVHf/a+NrDqQ6kTt874PTcZM7MaMCX+Wr
	 uwqk01eEt3KoUN/1g87iTSANfDlg7aknbs6mxCbl3CmXp5H2Zju1+EmAJPH+YHyGkV
	 MF1oW8QdquOCla/Ntek6cp7x9wqjh3Pse9h8rT8YwxZ9UK1XleHhpluiUFiHintIx4
	 EyV28on5q+ldFpjpbqOPwYQJVTbkv3HuKdSRFJ6MUfmv1ou5GxPiC69kjgawJlxE5E
	 EGp/9c1Tx8cfA==
Date: Fri, 8 Mar 2024 10:13:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
Message-ID: <20240308161331.GA682898@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLP=dxBb+RiMGXoaCEuRrbK387J6B+pfzWKF_F=aRgCPQ@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:49:16PM -0800, Alexei Starovoitov wrote:
> Ok. I think I figured it out.
> Please try the attached patch.

> PCI address range is managed independently from vmalloc range.

This suggests that the PCI maintainers should be aware of something,
but I don't know what this means.  Can you elaborate on what PCI
address range management this is, e.g., what functions allocate from
it?  Or how PCI should have been able to avoid this issue?

The patch is in a generic area with no obvious connection to PCI and
no obvious sign of independent management, which doesn't feel quite
right.  Maybe this is what Christoph is getting at.

> Enforce flags and range in ioremap_page_range() only when
> the start address is within vmalloc range allocated by get_vm_area().

> Fixes: 3e49a866c9dc ("mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  mm/vmalloc.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e5b8c70950bc..17eb0f974e0f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -311,16 +311,19 @@ int ioremap_page_range(unsigned long addr, unsigned long end,
>  	int err;
>  
>  	area = find_vm_area((void *)addr);
> -	if (!area || !(area->flags & VM_IOREMAP)) {
> -		WARN_ONCE(1, "vm_area at addr %lx is not marked as VM_IOREMAP\n", addr);
> -		return -EINVAL;
> -	}
> -	if (addr != (unsigned long)area->addr ||
> -	    (void *)end != area->addr + get_vm_area_size(area)) {
> -		WARN_ONCE(1, "ioremap request [%lx,%lx) doesn't match vm_area [%lx, %lx)\n",
> -			  addr, end, (long)area->addr,
> -			  (long)area->addr + get_vm_area_size(area));
> -		return -ERANGE;
> +	if (area) {
> +		if (!(area->flags & VM_IOREMAP)) {
> +			WARN_ONCE(1, "vm_area at addr %lx is not marked as VM_IOREMAP\n",
> +				  addr);
> +			return -EINVAL;
> +		}
> +		if (addr != (unsigned long)area->addr ||
> +		    (void *)end != area->addr + get_vm_area_size(area)) {
> +			WARN_ONCE(1, "ioremap request [%lx,%lx) doesn't match vm_area [%lx, %lx)\n",
> +				  addr, end, (long)area->addr,
> +				  (long)area->addr + get_vm_area_size(area));
> +			return -ERANGE;
> +		}
>  	}
>  	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>  				 ioremap_max_page_shift);
> -- 
> 2.43.0
> 

