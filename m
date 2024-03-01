Return-Path: <linux-pci+bounces-4353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0486EB8C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 22:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966711F21523
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C158ADD;
	Fri,  1 Mar 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKUnQHHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855745820A;
	Fri,  1 Mar 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330394; cv=none; b=FvXJkuz9pAlNP9obsHMwDDeA3InUivny6xYsgyH0mBb9lCcRnhJ/BuWRmJu6/mf/ByTsBDgSc4bLn4WQRQL7E6GIClM614CZ2Kkb7LIm7xVN7HlzSEfdf1iDbsEFHU4tZS1Bqey4qLn74UAkkpLB21v15bKfKqc1DACa4HFIZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330394; c=relaxed/simple;
	bh=Y2V62U5aslFtaRiD42vFs0nmxm2nJEvRBspXxCzXT3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dlgVNkns9ca2uh+9gCEggyLzB/w1j3thbrkUoKUrxVs/kO/sX0IcbRApmtmlfUsZPg/QgAHutX4uWLffYNCzwkt3Fd4iRfTChHIIOgQJWRiVMFy01bVeYFhIIO5fzqZo2dM6nSVxRLE8a5bRRAarC0aVOzlwbeOZBZ1QPAed4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKUnQHHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB4AC433F1;
	Fri,  1 Mar 2024 21:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709330394;
	bh=Y2V62U5aslFtaRiD42vFs0nmxm2nJEvRBspXxCzXT3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pKUnQHHN9bTho5glIL8VG0JIXfFWmHBwUDKPbK3vBWPyceGuQHYPfqSOEnNkDTxH9
	 VR075lFs8iOjitI1bYVd2MxDIdGKUfxldPF+G3URRXqrzJ97UI4IP4+f9Al8vnAFsf
	 j3swxn23xx5XDhuvwbkcHCBbK+5xHXnb8ZOXx7Vmy6vZzsVFX+2rovHQ2lczfvmNYe
	 cdw4dA548xXO7ixsXwuYhoVFc2vXdz7gvWVL2tNjWaMsvaAlIpoMvbTJXLzTo0MswZ
	 YJ7Uk/g8XI/QcNowgyXjRNhnDIN4Tw9IOrQ2oAfqt0ooc5vezwoqPtqa+Vq4U5UGBI
	 8E8amy1Q3FjGw==
Date: Fri, 1 Mar 2024 15:59:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Message-ID: <20240301215952.GA409704@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301105950.3067029-1-alexander.stein@ew.tq-group.com>

On Fri, Mar 01, 2024 at 11:59:50AM +0100, Alexander Stein wrote:
> With commit 5779dd0a7dbd7 ("PCI: endpoint: Use notification chain
> mechanism to notify EPC events to EPF") the linkup callback has been
> removed and replaced by EPC event notifications.
> With commit 256ae475201b1 ("PCI: endpoint: Add pci_epf_ops to expose
> function-specific attrs") a new (optional) add_cfs callback was added.
> Update documentation accordingly.

Add blank lines between paragraphs or rewrap if you intend a single
paragraph.

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 4f5622a655557..3961ff4e5bebf 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -172,8 +172,7 @@ by the PCI endpoint function driver.
>  	 * bind: ops to perform when a EPC device has been bound to EPF device
>  	 * unbind: ops to perform when a binding has been lost between a EPC
>  	   device and EPF device
> -	 * linkup: ops to perform when the EPC device has established a
> -	   connection with a host system
> +	 * add_cfs: optional ops to create function specific config attributes
>  
>    The PCI Function driver can then register the PCI EPF driver by using
>    pci_epf_register_driver().
> -- 
> 2.34.1
> 

