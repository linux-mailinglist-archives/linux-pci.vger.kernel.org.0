Return-Path: <linux-pci+bounces-33076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FACB13D3B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84BD16830E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71CB264623;
	Mon, 28 Jul 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EugBp2bK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A13237163
	for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713202; cv=none; b=M9ia/hMq61DWkcjt0PDLAfVdPFEwpoPx2q2A0jDqiKuLQo22hcVB7nl9COHoS9eTgzFg6xewdVgszfTfoUIV68JHK1BeLegI7++asW84wtbnmWv/VlBKUFzWsd7kPjfBjZDeWFxkxdITxOSRSzuTA1L7S6Hy51vkBIYnwa3reG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713202; c=relaxed/simple;
	bh=W9cZd84LF6duF0602DMOOstiN56aNMhgPt1nX1d9jRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqHGc+EwM13oTcAoxho1Bnix+ecZARaHJzK5flK1ZnHe2/sv9ZYPj2bLtrGdD8MFf2LGRYL7zpPvNDU1fcqAMVx/IZWKMvo4hb43izWkqdVVeWfbcCpNi8HhaV2nLQUFQCDnbYeZcq3FYsI8vdTvQ0I3A1etp1Fa1Rsnq41p1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EugBp2bK; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7074bad055eso4433246d6.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Jul 2025 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753713200; x=1754318000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWXJt0ksyO0+qZpgSvPEVSB9f2WnFWOci7NBGJx/i70=;
        b=EugBp2bKZzZS1D0wsHPwDGKmbt6hCvQ0lYjaRuSyVoMbQqXNRL4KPYOSVQlz+nqN9w
         EitNkB7XMRAlfRmiX0v9POBps1zB5HCoCOvywJ2qiymUQ85UQgVNJcu0fskwuKay1YzD
         uAqC4l6m6p4AiE+JvwedqRqS38Cbk1kZ2KXlsrHRIfH69xtxI7XmWDvQSK60EzCqvkpu
         piGZfwduta7VOMAFLaYYY+DeVb+I7DS1U6a7dUBXXHj9WmFg9bueAaCVAU9FJlKXzyrl
         5KvTx9/FYvCaCd3RG9A+Edx/iZqBawjHbsDJQv3xa1NkDqAscTfbYO8rMizr+3YvTijD
         1qrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713200; x=1754318000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWXJt0ksyO0+qZpgSvPEVSB9f2WnFWOci7NBGJx/i70=;
        b=Enzu/Byt9W3f6HOXa8mUNR22YDFNkFWXa1OthMy+yZ4w/0uYLaeb0Objj0dO5DtVxn
         dx5X5gE0YnJTqLyaibuAHEXOEezHOCDzTAqpKfvO17ytSN4GSEG78XypAO/vWrjuaH8T
         NhKFJxHL17339ocwoMHI4ZKNUN/p+54ORgY5/iAnQoSnnR5viPuyNVMWrHB044tiiPGI
         tJr8jLaETjtrjUrsWgI//9pey942d4FB7wH2U6MrHjvYbaFrn9NxdLCVMOL+oSpgIF3i
         hNukZ5fbTWnqmS1N/X3zGa3s8lsm2myHGHv0tbembxdzF/vxg+M1h9hf1UbYgKrZlG2L
         7H2A==
X-Forwarded-Encrypted: i=1; AJvYcCX/tAwCvlBqdMvNMz2r+Mf7AjkgqHqYVZCN5q+6hkAiIVsxkO/e2CcAHJmFbb3VGqWEkkLavyTqcCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHrPV5Boq3bl/xiQCa83kR2eVF8vLjS3PuHMa7817YGhznBE7
	NURhLXYaUHMWmPMRhaGZ3iuEdXypzl2lgOfCFZqtJ7Zf9eyVjrdBryi7r33lB4DMrTQ=
X-Gm-Gg: ASbGnctdhFG0QODmwDUpngqP3e310elOb3Oyg0S/6OC5DYqIav7yxIOA2/Xpy4eTAB3
	6RN+DMSLI6INHNhQoO8lxQZZ0Js/yWrUrNaSLoCkaFjH7HU9b3JkqM2ZhilbihUuZoWIJRF7LvH
	EBglQ9znQK7qMkL5GtAPNbQNB7r2tQMCXtAqbWF0+2KTNpQEXgFA6rxhEC1dIHLd1yB/I4dGu/c
	T7xwNUoxXDSHcsZl+hJbWM3emP2CnzkjaJVpH9eIDxhCAS6R4+87VhffbZ+lbgbtdFe0iLIThvL
	oA+judmcZzyogmIQ3lgC0oo9duzp8Vwj1VM4+Nc1WqZfqQIgDTM6gLpxSqQpGcAv3s850c1x6Vq
	/+IexkoYXOP8MsTP7Xj/iMYtcBZJ/5xo0LKOuvv4qtGcooMUw4eZOU2LAP1X2/s0/MDcVddbsJK
	i69+c=
X-Google-Smtp-Source: AGHT+IHMY4rGulXXEHfYzZtPMGVblgwyt5UUI5t558D0JMhsu4TWVCWFWjqwz9Xtl5YNFBAdYTlQIg==
X-Received: by 2002:a05:6214:224a:b0:707:9eb:d483 with SMTP id 6a1803df08f44-707205a1bcemr162291726d6.27.1753713199708;
        Mon, 28 Jul 2025 07:33:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7074c37e84asm9044456d6.19.2025.07.28.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:33:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugOuk-00000000Ayl-2Dx4;
	Mon, 28 Jul 2025 11:33:18 -0300
Date: Mon, 28 Jul 2025 11:33:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250728143318.GD26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-5-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>  	return crypt_ops->decrypt(addr, numpages);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
> +
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	if (dev->tdi_enabled)
> +		return false;

Is this OK? I see code like this:

static inline dma_addr_t phys_to_dma_direct(struct device *dev,
		phys_addr_t phys)
{
	if (force_dma_unencrypted(dev))
		return phys_to_dma_unencrypted(dev, phys);
	return phys_to_dma(dev, phys);

What are the ARM rules for generating dma addreses?

1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
   and do "top bit IBA set"

2) Device is T=1, memory is encrypted, use the phys_to_dma() normally

3) Device it T=1, memory is uncrypted, use the phys_to_dma()
   normally??? Seems odd, I would have guessed the DMA address sould
   be the same as case #1?

Can you document this in a comment?

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4940db137fff..d62e0dd9d8ee 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -688,6 +688,7 @@ struct device {
>  #ifdef CONFIG_IOMMU_DMA
>  	bool			dma_iommu:1;
>  #endif
> +	bool			tdi_enabled:1;
>  };

I would give the dev->tdi_enabled a clearer name, maybe
dev->encrypted_dma_supported ?

Also need to think carefully of a bitfield is OK here, we can't
locklessly change a bitfield so need to audit that all members are set
under, probably, the device lock or some other single threaded hand
waving. It seems believable it is like that but should be checked out,
and add a lockdep if it relies on the device lock.

Jason


