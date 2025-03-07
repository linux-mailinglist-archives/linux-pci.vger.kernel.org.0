Return-Path: <linux-pci+bounces-23135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BDA56E6E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73873188E9DD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB823BD13;
	Fri,  7 Mar 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkqpbqRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F023CF12;
	Fri,  7 Mar 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366668; cv=none; b=f5qGZKs8oMMgveVttmM359N8apfBxtEDNMu30pMBOCgsfhy+N8NB3IyaaZxfKDsRjbqy+36hrDwniuNjUtlw8zOTF4D+3rLuUVJbuTsEdv67jjXjE1aSKPHKNts39mnjXDqJyK9snoj7wpzGhD6mXNFme62C7MxeyvUenjfsCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366668; c=relaxed/simple;
	bh=NlNNqFjrSRtJUeDu5ipvdClweF7ueES6GoAEZKzUVtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B96SxCyXVooim3tDZ58MyDbK6O8p0be7BWdbg3NkQkXnbcXg9ejzAOy3m0fESYBDHCj0KdlppR5pfaYbfDt7XfivNRpRV20K0VUo0GgSyELgdUQ628FBfsnOclkpGRyDtlI4jBjXWknyp4/ZevHbMg0tzg7OICZ4xFB2/Hkm/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkqpbqRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727B8C4CED1;
	Fri,  7 Mar 2025 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366668;
	bh=NlNNqFjrSRtJUeDu5ipvdClweF7ueES6GoAEZKzUVtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QkqpbqRtvFDrJvSzMvTh1Wez6UMX365OTxOk/sk+y6NuMv5Vjql3bDoGXvdLo44PE
	 e8jOh7vdp0u9R2YmdCGNgCAW1LP0eb2sjQkzQ6Gp9iBII3I/0lqph6+H2l4sfTiM93
	 6ijg+dFYdPxtAme6I6pq+wV50/ix022IIbdvt6jFObPGJ1HZmanje7D6B8OWqecId3
	 SU2vHgPYyuMmbMRCazeLkrlNhCv/ZxTjnREdxC6iZgTSo7F1C2zI0I4L7/LVZyqo4i
	 RdRybDwPJe6POd6ndRR3Dn/AtrzBK8XrV35mQUFj59msy/CdJBlroHGhFCbRQ9lL0D
	 qbCsC5dUYtw0w==
Date: Fri, 7 Mar 2025 10:57:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Do not claim to release resource falsely
Message-ID: <20250307165747.GA412364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307140922.5776-1-ilpo.jarvinen@linux.intel.com>

On Fri, Mar 07, 2025 at 04:09:22PM +0200, Ilpo Järvinen wrote:
> pci_release_resource() will print "... releasing" regardless of the
> resource being assigned or not. Move the print after the res->parent
> check to avoid claiming the kernel would be releasing an unassigned
> resource.
> 
> Likely, none of the current callers pass a resource that is unassigned so
> this change is mostly to correct the non-sensical order than to remove
> errorneous printouts.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v6.15, thanks!

> ---
>  drivers/pci/setup-res.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index ca14576bf2bf..21719ae29a34 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -414,11 +414,11 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>  	struct resource *res = dev->resource + resno;
>  	const char *res_name = pci_resource_name(dev, resno);
>  
> -	pci_info(dev, "%s %pR: releasing\n", res_name, res);
> -
>  	if (!res->parent)
>  		return;
>  
> +	pci_info(dev, "%s %pR: releasing\n", res_name, res);
> +
>  	release_resource(res);
>  	res->end = resource_size(res) - 1;
>  	res->start = 0;
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> prerequisite-patch-id: e4a2c15d0cd3241e2fdb1af98510211e63ec3d06
> -- 
> 2.39.5
> 

