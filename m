Return-Path: <linux-pci+bounces-37373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DEBB1DC2
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 23:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D0A4A51A7
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865322D8379;
	Wed,  1 Oct 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epLMtl+x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541632C11E7;
	Wed,  1 Oct 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354619; cv=none; b=dVj/Q6hvNWgzP1Q4N9nawbTwFDsX79tyUoLhrTbwH/KNn63Zjdz85osp/9K2d++zEkX1/bPYtWCvhDQt9TmjUtbY6yM/82xcQuhl2M0xyd0cOS4Yf/LY1+Wajx+7rzTuFwv/MEB8HxfX7GG6dvXJGqxuOVi30R0OAkEEYmr4UWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354619; c=relaxed/simple;
	bh=l882ipq009bfLKB8e6Q2lXRfa0190MoH1YGIaQSesJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FAfGCx18S+mgADGSbqCeSG8zSZK2+MQ7CK5hefFQkHndN1AR1zqUJ1D2Dbg6AmwCFiQOSbcOr2g44Dz0gIH5x7uubxbCOGeHskHi8h8M99MYCDuoLg3cL9jnPfdHJXDo7t4GkZuGipwk0BfODrenPUwCnO3PwTwk4bdKrJl6WLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epLMtl+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A74C4CEF1;
	Wed,  1 Oct 2025 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759354618;
	bh=l882ipq009bfLKB8e6Q2lXRfa0190MoH1YGIaQSesJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=epLMtl+xhETPWKTnxwZv67J+cv3OVQpeTmHQE2ZJCughJAVB6ShIUgR7CP8WRPx+O
	 G1U+nxtL79Y0BxZffm/M6mc4Y20fL/0tJLyd63Dg+KoD5b0rgjadiXWsgk/ru2wNrX
	 k9GIA//tusinr20t93XVPBoKeqg7hc/QoeWXuCB6oOyg1WRnUUzFw392s3yGGRRyLW
	 4H4lVTtH1mJTEo8heZwQmzWORNuI3nSH7R2M6hiA6t4YiAe1wb7b9Mza6pwe+iUiTQ
	 BuwWI1WZiufIN4q96XSQLI5lGR0xUiVIvwiA6VehO3oE08LdnIHXfIVfuTAzMei3vd
	 8rX/TBRr7TopA==
Date: Wed, 1 Oct 2025 16:36:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Message-ID: <20251001213657.GA241794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>

On Mon, Sep 29, 2025 at 02:15:47AM -0700, Breno Leitao wrote:
> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> does not rate limit, given this is fatal.
> 
> This prevents a kernel crash triggered by dereferencing a NULL pointer
> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> which already performs this NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks, Breno, I applied this to pci/aer for v6.18.  I added a little
more detail to the commit log because the path where we hit this is a
bit obscure.  Please take a look and see if it makes sense:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=451f30b97807

> ---
> - This problem is still happening in upstream, and unfortunately no action
>   was done in the previous discussion.
> - Link to previous post:
>   https://lore.kernel.org/r/20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org
> ---
>  drivers/pci/pcie/aer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d7167..55abc5e17b8b1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  
>  static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>  {
> +	if (!dev->aer_info)
> +		return 1;
> +
>  	switch (severity) {
>  	case AER_NONFATAL:
>  		return __ratelimit(&dev->aer_info->nonfatal_ratelimit);
> 
> ---
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> change-id: 20250801-aer_crash_2-b21cc2ef0d00
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

