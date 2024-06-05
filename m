Return-Path: <linux-pci+bounces-8374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9818FD96B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 23:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FC6B23106
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957771581E2;
	Wed,  5 Jun 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jynu4bSk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E03C062;
	Wed,  5 Jun 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624730; cv=none; b=P/h2P/aSoPKXlGzmTZe/17o6XRH1WjWSDVn0pt1DvAzpkyq/Nk3RVxuFAX6bVnoOsxZfsqNswr+68KUfg2l91ILI4Ct1wwM4eqTjxj1z/qnnsj36WWLh+as9IeBO2u9bL92Tb+9UMSJWMQAe5PoWr3Of75/h2a7pXUmoLcTPO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624730; c=relaxed/simple;
	bh=LWOLMGrH5N2gPZ93B8pHBq6TnKvAfq2vS3ahIjsTjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pPb/OF/0QhVmf0XefwZ9nbRRL5+N3qZwl9fjHDDB4vXUzfbKRRgoD9Lx8Squ6FZjfKNfMwgfKczLmeHZocvFMAaLtMftc4OU4eqpw9heYu7kyn+X1sVBth+fwTlyWAP8lMqe96zk+gyNBGFah6fIijL63JmZpWVPungfC/RkS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jynu4bSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E600C2BD11;
	Wed,  5 Jun 2024 21:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717624730;
	bh=LWOLMGrH5N2gPZ93B8pHBq6TnKvAfq2vS3ahIjsTjdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Jynu4bSkImO8IqHtm+3jiN9qiAD9ewBiRk0PE0yEZ+zElWILWk216XorAPgNDBENd
	 NK0xjtf8ROxwO028OP0/6en3xTOGj2EWTsNueN93OMfgH/nX30yWQpfMwg8FJgJtOw
	 PJJrsJ9uXVvTgWBO//SpM5MC9J3JF972AnDW2oKLutRHzj2o0zBip0u3fk4v6N41tm
	 muYZGCs//ESgvmeT84OzXxo3M8eQ+ea8ndE4mprl5Crie5PiA//dlMK+4SILrxQLcn
	 ksgT3rYoRj5moB9fkqk7UYLWqo4WQXSqu3JPaHgd5PSf7HpFL9qv4+CbblaY68VoFr
	 NJX9AO/b3s7SA==
Date: Wed, 5 Jun 2024 16:58:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: bhelgaas@google.com, javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
	oohall@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] PCI/AER: Print error message as per the TODO
Message-ID: <20240605215848.GA782210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605212344.21808-1-jain.abhinav177@gmail.com>

On Wed, Jun 05, 2024 at 09:23:44PM +0000, Abhinav Jain wrote:
> Print the add device error in find_device_iter()
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> 
> PATCH v1 link : https://lore.kernel.org/all/20240415161055.8316-1-jain.abhinav177@gmail.com/
> 
> Changes since v1:
>  - Replaced pr_err() with pr_notice()
>  - Removed unncessary whitespaces
> ---

Thanks for looking at this.

  - It doesn't apply to -rc1 (the TODO message is missing).  In PCI,
    we normally apply patches on topic branches based on -rc1.

  - The subject should be more specific so it makes sense all by
    itself, e.g., "Log note if we find too many devices with errors"

  - Add period at end of sentence in commit log.

  - Move historical notes (v1 URL, changes since v1) below the "---"
    line so they don't get included in the commit log.

  - __func__ is not relevant here -- that's generally a debugging
    thing.  We can find the function by searching for the message
    text.  In cases like this, I'd rather have something that helps
    identify a *device* that's related to the message, e.g., the
    pci_dev in this case.  So I'd suggest pci_err(dev, "...") here.

  - I'd keep pci_err() instead of switching to pr_notice().  If we get
    this message, we should re-think the way we collect this
    information, so I want to hear about it.

>  drivers/pci/pcie/aer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 0e1ad2998116..8b820a74dd6b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -885,8 +885,8 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>  		/* List this device */
>  		if (add_error_device(e_info, dev)) {
>  			/* We cannot handle more... Stop iteration */
> -			pr_err("find_device_iter: Cannot handle more devices.
> -					Stopping iteration");
> +			pr_notice("%s: Cannot handle more devices - iteration stopped\n",
> +					__func__);
>  			return 1;
>  		}
>  
> -- 
> 2.34.1
> 

