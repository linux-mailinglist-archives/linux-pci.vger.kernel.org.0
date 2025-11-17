Return-Path: <linux-pci+bounces-41427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C85C65013
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 17:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B670520848
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3D2BE03B;
	Mon, 17 Nov 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O5EyoHLI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9124A066
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395234; cv=none; b=mi/zxdwy8HG5j8jj1cXIt1sgOhcybyPtSeR1HQ+2Qq/G3HyzAB+eim5KK2Wv/KxBTjunMEh9MVwqNVozEiznyJ5ZjO6RxM9RCpc3dDbu4UTmMpizsvBzqSoU6v143tXnQ+DfrH5nKWJwVa5smE47ZDlov7hQo//8+8ZKAyNnfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395234; c=relaxed/simple;
	bh=G7C4pAgpKtZexEHJcykCN6RuqFFJo5KbCaykefTP9os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja0VJt5H1mx3mQQUI6MYt6s4cT8hSm8c+rjqTXYrLEAHBGMPtxu6Fmwy8D60LS67Ez3RC9goNF/Zd3jQ7gYdpvqR2zHe+xbjDMAK0nbFQTJzgdWfcH13ICW5frnuMuh/iPiTOdqCsaUJvgEQ9bQC1nfQkEiIn3idILX321fYz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O5EyoHLI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee18a21886so7732531cf.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763395231; x=1764000031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFCLv8SrKLLdHd1BTr34c+OpWZv8CYrj5E911NYrygg=;
        b=O5EyoHLIhbrQuztPhtUFu74iYvDbavEgjlvI3ocBpCsWgvRTYhekXKOyBqMvrRZgS5
         XtNhz/v05SOPK6Bmy8b1MT4K+92OCcHdpXyynn27yKtp0kPfVa/IHLSeZewoV6QCLxbd
         MvN4HIIiMY0vWcBc0p8nzuyeCMkpvTtB1pQCEu5eKXqU9jRiAeDPJm44wE1iCbg7JoXw
         ZOlr7F/M3C0jBYGrBrZpLhT+2GLRIEaCRvM76q0dEv613B3JOSGmZpy1uj7v+Q0n5l9X
         th9gNsW8s8wDzeCjDu61LIPxThJSarYueYtavnLaOPFblcu9AWJvuNATHHb9AmOXfgo5
         olYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395231; x=1764000031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFCLv8SrKLLdHd1BTr34c+OpWZv8CYrj5E911NYrygg=;
        b=KSQyNShrIkS5ZX1uz9Yti9jBsWiZX1ijF1RV/W3jhc/AiT4Cnon+HtzQZlZ2M9viVz
         dRIovF7enU4YkOEcN87vFYuoGKfAm0dUr/ZbVEu1p7ZssA6n9jKKcxNpJJUyyr5/CRMO
         hXALyfNRV44uDnGqwDarauBJ31S+cUizk5XxYBae88enBcqHHCyP0Y2K9a7BzB2S6T48
         1dstpyfEWJCpv6JtkARcd/9J9EGWDAj5i+9shuVZTjT7mjkYdlExmSal6VQq7CWFnIyH
         BAkb3KpwdbwejBfdg0sZKPhKYruB5yTHxm6tmvBMIRvttp6qM8zYZEeitKgHauBqQD9U
         eOUA==
X-Forwarded-Encrypted: i=1; AJvYcCWZqHQzW+giOlxYW0TfuGGLo1m5yfucz3oN7UaEUpmZgFDofLXMwCeYuzIEbxk7MrIWxYzPKGOV2nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2YYWA3n8OLQEdBiCda5VOl7bZOz47tIsF7KIyqhVSfOjBWv1
	2hHq9zNo/UQNavy5yOX3b6o+QmMp8dDKtqg5w7lNh74cfYlkCu/zuJ/8JIkyFK069XU=
X-Gm-Gg: ASbGnctfn6cjxcAwzWDtQBPJcUWe1pNUZPt2OkaxmhSA2fx7EwObg62e1LFXjnnMZHp
	e1iVy7nXtvtYAjbbU5b34mVqunaw9DmcZvKSJyrrQJB1Ui/k5aCvs7yGurgXDp2o+Z3F6XUdWyl
	QHiO0COOeSRkNf0wsx6nv3fvsJThcVKGlQSDAWw/47TiWuFSmODgbWzfb1XC0AD7wuvVjgZDBBM
	lWD3lzdjgAN9zDQ8+vSs1ye255+w7TWmfAzrsvgCGBJF6wy4b/nGG3LbPZWgDARK8N8hpo1dM4r
	mnuLeLzdeJieF3WvwKs3KJsFpdXV8aRrDARu5ipKiHkMRaqsByJlGlnynEjNyoyXqZtZ18m6vjS
	gfPFeMwHbo0z0lvy/iV+Q/21nUn23bSdK5KpjiLelacbHIdOGinYy6XXmTbeII+e3kcgZHHsK+Q
	+EB0wZvjTq68fbHRvL/AT/sf7/ZXiN6AcybDglviOAs8Asv0T5xc8GW0/j
X-Google-Smtp-Source: AGHT+IHbSQImGkihOS5IZmENbT3R5EBp3J8G7fdTRwsSVJjLa5azC+CHu51Ebm1tLe+D3yglmQCuLw==
X-Received: by 2002:a05:622a:1453:b0:4ee:2e6e:a0f9 with SMTP id d75a77b69052e-4ee2e6ea38fmr9781441cf.35.1763395229938;
        Mon, 17 Nov 2025 08:00:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d04e1sm94957706d6.7.2025.11.17.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:00:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vL1eW-000000004wY-27Uj;
	Mon, 17 Nov 2025 12:00:28 -0400
Date: Mon, 17 Nov 2025 12:00:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20251117160028.GA17968@ziepe.ca>
References: <20251113213712.776234-1-zhipingz@meta.com>
 <20251113213712.776234-3-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113213712.776234-3-zhipingz@meta.com>

On Thu, Nov 13, 2025 at 01:37:12PM -0800, Zhiping Zhang wrote:
> RDMA: Set steering-tag value directly in DMAH struct for DMABUF MR
> 
> This patch enables construction of a dma handler (DMAH) with the P2P memory type
> and a direct steering-tag value. It can be used to register a RDMA memory
> region with DMABUF for the RDMA NIC to access the other device's memory via P2P.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  .../infiniband/core/uverbs_std_types_dmah.c   | 28 +++++++++++++++++++
>  drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
>  drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
>  include/linux/mlx5/driver.h                   |  4 +--
>  include/rdma/ib_verbs.h                       |  2 ++
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
>  7 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
> index 453ce656c6f2..1ef400f96965 100644
> --- a/drivers/infiniband/core/uverbs_std_types_dmah.c
> +++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
> @@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
>  		dmah->valid_fields |= BIT(IB_DMAH_MEM_TYPE_EXISTS);
>  	}
>  
> +	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL)) {
> +		ret = uverbs_copy_from(&dmah->direct_st_val, attrs,
> +				       UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL);
> +		if (ret)
> +			goto err;

This should not come from userspace, the dmabuf exporter should
provide any TPH hints as part of the attachment process.

We are trying not to allow userspace raw access to the TPH values, so
this is not a desirable UAPI here.

Jason

