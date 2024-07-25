Return-Path: <linux-pci+bounces-10807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8793CA02
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09481F21CFF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC722D05E;
	Thu, 25 Jul 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsNTZmT5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3F225D9;
	Thu, 25 Jul 2024 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941218; cv=none; b=cdr5ejMdFdE27oQ4AAvQKa2/oXSO7qxC8pzog84GvxdVS2irUhsxf3RHxFYECX6oQk2l6geNkxB5v6T1wE5nZk93jvIp9dOaU4BOaMBn8YkWIYHTQJqFTSLch9P6fGLcDkhCyCiC+imjrc3uYPSwjMAxzWN20J1JR46NIfrGmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941218; c=relaxed/simple;
	bh=d82TzPmf1GFgbEQwl4JV+d0VZLw0hz4hcnslcwaoSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E01JP1zG1WBFA+oJbI36XQGjE7BRMo3E6knrmpFgMYGHU3LQG0ZWDkIye8Ww4tiMG/g2Ghp+Fa0evKb3Wwk6o8THe2rK2dUEvs1t0v+yJcu2f/9UDZVqco9nNI7szClKWwxZMe4ICt2lrJWJPR20iD0wqBi5IKkhvOP2BL3Ebs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsNTZmT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86AAC4AF0A;
	Thu, 25 Jul 2024 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721941218;
	bh=d82TzPmf1GFgbEQwl4JV+d0VZLw0hz4hcnslcwaoSwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HsNTZmT5o2TWMgYnetJ4RaZzEeVAKej/WlnTqMoHuZ1+3nyP8UXf0/w7WfjnI2J9z
	 Y6qsJhbpC+YCtywKRpLzfgasalSGXOxYGwXiNXpg4M2VeCkb4oEKdTNBc5rQPhOmgW
	 RN1KhBBufYS8tnkki+9c16Z70gYy1ZvUm2lz4kbYDBzcEAViQpCDYFXQaKua+kxF4b
	 4nsk/cJ0dE5fLpZRZenZrY5HWO3ofUuGNvXwnV6zggQyucT37maeM7bpMyc78I1ToD
	 unPFpMYI12Va4MNrt4wdn6msQ1hVGywssXuTeMGjqyTjufySGnmUPy9Ydm4u/RKUPl
	 mxXA0MBKc03eg==
Date: Thu, 25 Jul 2024 16:00:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240725210016.GA859301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725120729.59788-2-pstanner@redhat.com>

[+cc Christoph]

On Thu, Jul 25, 2024 at 02:07:30PM +0200, Philipp Stanner wrote:
> pci_intx() is a function that becomes managed if pcim_enable_device()
> has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
> pcim_intx()") changed this behavior so that pci_intx() always leads to
> creation of a separate device resource for itself, whereas earlier, a
> shared resource was used for all PCI devres operations.
> 
> Unfortunately, pci_intx() seems to be used in some drivers' remove()
> paths; in the managed case this causes a device resource to be created
> on driver detach.
> 
> Fix the regression by only redirecting pci_intx() to its managed twin
> pcim_intx() if the pci_command changes.
> 
> Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
> Reported-by: Damien Le Moal <dlemoal@kernel.org>
> Closes: https://lore.kernel.org/all/b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org/
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Applied to for-linus for v6.11, thanks!

> ---
> Alright, I reproduced this with QEMU as Damien described and this here
> fixes the issue on my side. Feedback welcome. Thank you very much,
> Damien.
> 
> It seems that this might yet again be the issue of drivers not being
> aware that pci_intx() might become managed, so they use it in their
> unwind path (rightfully so; there probably was no alternative back
> then).
> 
> That will make the long term cleanup difficult. But I think this for now
> is the most elegant possible workaround.
> ---
>  drivers/pci/pci.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3a49f66982d..ffaaca0978cb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4477,12 +4477,6 @@ void pci_intx(struct pci_dev *pdev, int enable)
>  {
>  	u16 pci_command, new;
>  
> -	/* Preserve the "hybrid" behavior for backwards compatibility */
> -	if (pci_is_managed(pdev)) {
> -		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
> -		return;
> -	}
> -
>  	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
>  
>  	if (enable)
> @@ -4490,8 +4484,15 @@ void pci_intx(struct pci_dev *pdev, int enable)
>  	else
>  		new = pci_command | PCI_COMMAND_INTX_DISABLE;
>  
> -	if (new != pci_command)
> +	if (new != pci_command) {
> +		/* Preserve the "hybrid" behavior for backwards compatibility */
> +		if (pci_is_managed(pdev)) {
> +			WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
> +			return;
> +		}
> +
>  		pci_write_config_word(pdev, PCI_COMMAND, new);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pci_intx);
>  
> -- 
> 2.45.2
> 

