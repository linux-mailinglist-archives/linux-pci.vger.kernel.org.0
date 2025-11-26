Return-Path: <linux-pci+bounces-42114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D4C89F3B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B1DE346022
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545327C162;
	Wed, 26 Nov 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNffL5KT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCE26CE36
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162773; cv=none; b=hqF8kWe8eLZ3i3io6vYGcd9vtNT7XlkIRWEt2irq53cPmgfxbCzJZ1E3dJBzaB4eRco+wpd9cNmhB+etZVL15iFPacrbZsWByeqnaV/En0hQkTWH2ssrTCPNF9edqEVCMgK3QlVcmaXB77yeSHaqxfqVu2EPqk5YliewMB+jyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162773; c=relaxed/simple;
	bh=Jo1hwBQ1OAKjPw3AJMr/P9Kbq4e9sCgCina51O06nNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=finB+m5AvrhPK93QVwXEehGxz1JtKFJvslV8S+Vs8wtwVZBfr2nEpc5Yw9qLIKf5r7utxJTBrEsoA223ym5J6YNB6pwUsjgE1FPVnMv12BUob7xmc2nVAGXiATaUBAYmYEnIFDDcJ5MXcfWJRplJbrp/B3w1GjDsrJEvxSf4SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNffL5KT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so202965ad.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 05:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764162770; x=1764767570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=dNffL5KTXy9vmcr7Dvl9zEXcTnC1oet8hlQpSQcJkPBVCZzGG6coWdrCyxxnWQtK3l
         Xhv3sYAtIl4jfSNszMDmJvkCrdHCcevlkaEE3+QKISZnkNh239hTj091qTKAeLRvIzej
         oMcow5HB11eBD3t4BHi+XiGHi+4k9hU+tLW+BxjKSrpjVziaFbx6vybuWcSsannc//Wk
         SiJn7azY6uCF6D0FNRoIRbztuq0QXQ9ZEYRwC4l47yoqw54dRJDAX77jE/MxAIAgl0tT
         dypc0gwY/OKSAKJRoOL5J4+x7Jb4hVOS8QGdL8QndejcmzHeVZVyI1bgusnEHVdhZkVd
         jOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162770; x=1764767570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=FkgPOARv3Si2fN+W2nOc7ViaTwQkssTsB4lLzdZJtEy2sK2LZ8taD6ZlPcu7zrMsC4
         DjqUONUbrfL/qqW8j+mQyj9tD6+5PFAIDQ8hPfIn7byi08tE+fL9JJ1xp0lH1M5pbbNi
         4zHUHacva3Lto05xCasN4UCAXbHKv9AcBCz2mlEXB1YcTGHyHS+YVj2kPw4s8HiL5fJJ
         Lq0dgi7MrW/JaivBHyoEiYbOp++mliOPNN6vTYer5zeRsiTOwiRLn2ubzHn2h21dTXjf
         i/vNbfyTshejh0KHMQ/65KdP0j76DFOppFRWaaombbxCXTcj+3tgVnZmb8W2V26BKWpZ
         zINg==
X-Forwarded-Encrypted: i=1; AJvYcCUM58DyL4cJW59FEWmTiNerT1ktDQdmOeSzXKxZ3HCDgEzd9b9XVohFzzgEKf3tRYHF1gC7G65k5dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqn5dNKSUDMd8SZs6htt1yHrRCnGBpQpvA1suXeHW59ifBXc2x
	mHI3loTIEBOgtM/YZMYXwgGn8OgujHCAaLsEhvq+guJqYusxOVLEvmNqtHVi2vMGmA==
X-Gm-Gg: ASbGncuITPx+mluVB/LULLI3M3+vYb+8/RvM+NkGqLKM/PyKgy2mPHvgmkoontY8Ymj
	ehdzLD5PwGRNMvjDBdIhBLhIbh9BUs7MjAkclc2e0iDySGnasrQRAYJzk4Aioj45GsesGLbnBqF
	3sTpljCkyEcfJ46IiiocfEu01xQYn4RH5Xl+HGQcbCnTIisomL9reLA9UBu927M2ndy70CJ/X44
	1ZqXKVXrTVeqYaBUQ7tThUWg9SEmhyJTbgfm9g1JFQB00XY3MZpF+hD8lHh3hJPyL+RT1XrmlcQ
	yWdYQOCKJ2U2lvBfCoiizn2UqZmgW7S2pZ8FBGd03mGs2ZDwpjMc6F3EXde4kos4wM6r+n+NiL2
	vkPW1VQbVcJu8hAjww1BqLt1BPMAlsiW8Gc29x3Ztr+QVTGmLN1aWSFpZBvIo28t9+HPdK9ZVs9
	EWwjdcr5Y4niscqeOWCDWLcRftZO0Acn0PciEEcV6KGeuBI5PM
X-Google-Smtp-Source: AGHT+IHJIOBgKlL+CS0ZpKtYX5Djx07PEo4PrDI8k+TVBWbcqpi0p7MakMMReKQUlItaKRJKERuBaA==
X-Received: by 2002:a17:902:cf07:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-29bba9e8a00mr1709325ad.13.1764162769984;
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105e4csm194769895ad.2.2025.11.26.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Date: Wed, 26 Nov 2025 13:12:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <aSb8yH6fSlwk1oZZ@google.com>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-6-d7f71607f371@nvidia.com>
 <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>

On Tue, Nov 25, 2025 at 04:18:03PM -0800, Alex Mastro wrote:
> On Thu, Nov 20, 2025 at 11:28:25AM +0200, Leon Romanovsky wrote:
> > +static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
> > +					 dma_addr_t addr)
> > +{
> > +	unsigned int len, nents;
> > +	int i;
> > +
> > +	nents = DIV_ROUND_UP(length, UINT_MAX);
> > +	for (i = 0; i < nents; i++) {
> > +		len = min_t(size_t, length, UINT_MAX);
> > +		length -= len;
> > +		/*
> > +		 * DMABUF abuses scatterlist to create a scatterlist
> > +		 * that does not have any CPU list, only the DMA list.
> > +		 * Always set the page related values to NULL to ensure
> > +		 * importers can't use it. The phys_addr based DMA API
> > +		 * does not require the CPU list for mapping or unmapping.
> > +		 */
> > +		sg_set_page(sgl, NULL, 0, 0);
> > +		sg_dma_address(sgl) = addr + i * UINT_MAX;
> 
> (i * UINT_MAX) happens in 32-bit before being promoted to dma_addr_t for
> addition with addr. Overflows for i >=2 when length >= 8 GiB. Needs a cast:
> 
> 		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> 
> Discovered this while debugging why dma-buf import was failing for
> an 8 GiB dma-buf using my earlier toy program [1]. It was surfaced by
> ib_umem_find_best_pgsz() returning 0 due to malformed scatterlist, which bubbles
> up as an EINVAL.
>

Thanks a lot for testing & reporting this!

However, I believe the casting approach is a little fragile (and
potentially prone to issues depending on how dma_addr_t is sized on
different platforms). Thus, approaching this with accumulation seems
better as it avoids the multiplication logic entirely, maybe something
like the following (untested) diff ?

--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -252,14 +252,14 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
 		len = min_t(size_t, length, UINT_MAX);
-		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
 		 * that does not have any CPU list, only the DMA list.
 		 * Always set the page related values to NULL to ensure
 		 * importers can't use it. The phys_addr based DMA API
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+
+		addr += len;
+		length -= len;
 		sgl = sg_next(sgl);
 	}

Thanks,
Praan

