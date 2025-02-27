Return-Path: <linux-pci+bounces-22596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDC8A48B03
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCED188D9E1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC8C225A50;
	Thu, 27 Feb 2025 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7YeA3Sg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BF18FC84;
	Thu, 27 Feb 2025 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693687; cv=none; b=Wpa9JMtCvsiebzaY1tMrnXXh1t7gvjzBUEg77+jx2ByErMQieyHB4jnZj520Rim9SyBirB+XPEE7OPEEYEFHysqeXzrZCtKOaLoRmso9d37oO59xANQOFFQmoRtmpVrgcnn8V1E9RsqUrDa0ziFwSvJC6r2FfWNrorqyhlyOxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693687; c=relaxed/simple;
	bh=n+nsNyzVYt0dGUwRTjntRGMbO9gWCDmvdA6CBZ+1otk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JpzgbQs5iMvwy/BR9wcIaTIrqBKQRVh5OyD67UBjsaA5OFhgAGrztAEP2xoNJOq46AgN3DhPOniMtkqlg2E5yAidW9LNLtlwJdT81TafuabnJnhkRUZyxXB9TqIOlovGe1UF6rtgoSUPWEQfpHhtclK+YGkOT570QCZ6iStFteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7YeA3Sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8FC4CEE5;
	Thu, 27 Feb 2025 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693686;
	bh=n+nsNyzVYt0dGUwRTjntRGMbO9gWCDmvdA6CBZ+1otk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A7YeA3SgizLL7kDNc9pSlfu1Mm6EA3ZuyKp6Nw9UEASA4RN9VaxLVS49xkRwCI1A1
	 TTUGcmdC06/HFCjveUkwOBCdUsW4ACZiillh2hzdRHR2wj1thfn9idibzf9jVBPtXM
	 lOwedUmYW3jym8s4tQXykrQOQiwfyIjLa1NuoaYEAI+OXmtCRkdZxL+05giGVjA9am
	 r24F0ciwzJd1je3VWod/6ca68X0ix5L1BQDzHcMNpnY5/tCJAaC5w11JpJux4pxVxn
	 T8AEjGGXFcxSWJKnGDrtmfeRlpkKWYHPnkuAsVRvGqGLHaw8uuXepGXOycwyu4kM6k
	 rQkSSp8S5iDcQ==
Date: Thu, 27 Feb 2025 16:01:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: bhelgaas@google.com, arnd@arndb.de, treding@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] PCI: fix reference leak in
 pci_register_host_bridge()
Message-ID: <20250227220124.GA19560@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225021440.3130264-1-make24@iscas.ac.cn>

On Tue, Feb 25, 2025 at 10:14:40AM +0800, Ma Ke wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Applied to pci/enumeration for v6.15, thanks!

> ---
> Changes in v2:
> - modified the patch description.
> ---
>  drivers/pci/probe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 246744d8d268..7b1d7ce3a83e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1018,8 +1018,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	name = dev_name(&bus->dev);
>  
>  	err = device_register(&bus->dev);
> -	if (err)
> +	if (err) {
> +		put_device(&bus->dev);
>  		goto unregister;
> +	}
>  
>  	pcibios_add_bus(bus);
>  
> -- 
> 2.25.1
> 

