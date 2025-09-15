Return-Path: <linux-pci+bounces-36122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16DB57321
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44486166A2D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566B2EDD57;
	Mon, 15 Sep 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/O9YIyC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D952D5C7A
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925394; cv=none; b=mGYjP1yP5YEtEVyoqt9viSDLXIglwhBHHArY1YDSoTYOnzTo7j2+DenTNCNlucCpexAJ8RVUEPeysGLylZ0ro0AIrk/6tpxb8gPmCgykSFlqHPLiFRxdqp/LzquMJrTwdlD3AnQe+gZDDLe+CMjEGDFkxsxbHPU3ZH8rx7sDz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925394; c=relaxed/simple;
	bh=oTUc05uAoj8tDOxyEV34nE5zIEyVRYInAxKt2au/nUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6E8TAtA65bqfaViGryqbc3nCw1/6V411wP7qpQEVznpX/KpGaX97GtUG0Lie0w/B1WG+NuO5qIbC1ipgPFvt9wH1VSqbNfpMSOAcn7rHcY6qNFqrfmzWpkz0QhAlV7SAFtz/MTy56sgGlCVo97rEQU1zyGjxJ+KS93FTaw3chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/O9YIyC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2f894632so17775e9.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757925391; x=1758530191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uuG6t3iAuSKi0EnadmhBvC3rHWT3Byv2xYmpCXcLPYA=;
        b=w/O9YIyCCqeV6hJT8tHBteDemBGBn/uk5yrRDmODXjY7Of1IAIOvvOpDZSAWB+UAH3
         62NBsL13BU8ofJZtaiRHVrNH7g3ke7uGiRtGbJ1+3tK82kdId1mavHgWg5eVOI12+Dly
         7FyCNrPOXb6AbrCuRpvCeRWi9mo/LYYMDY/adQrSjh27i6ctWrf2ed4y4OjVRH+RpplC
         ZMcQtqBxs6QuOqy9jwHIxT91Ohyw14xTkDuf8P8tnnFTnka+G68A6iqsdPKQR6x+HqOs
         /zTPSciIRDf0YGpwp+yxm6OaM1G6EsY6U6lzFg5JYhl98TGf7YE71QPHbAM+BDnGjCnp
         eTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925391; x=1758530191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuG6t3iAuSKi0EnadmhBvC3rHWT3Byv2xYmpCXcLPYA=;
        b=MnUnc865Kt4U/CKa8A3K8WOjVyC+xcOSI7dHHKd2O/99GqYrGGCCJmV/ivRYya8noy
         WDTARYiK99tNhafAhJhVFsozJutmfiNzrkpT3wM6rtfA40Yb4fWaPbwraVrnN7HlCZG0
         HEZt2xDY6QQfaPL2qUgLmLx7NL55KMWXfmYDymieRc75i9uNgFPWh5fs/xvxBUIeVyiL
         J2A3WmJv7uY7OkBDpQLvTK2gzRCQqmIuEXHqbfiqxhnWD2b6BEOGwvSobbEPy4OXwc7V
         KdQxqHic1RoqSIlDUExZfzUiugk+/D4XyrGqv7mHoRDNKCD8e4xIg/tG28pXcaQH51iE
         7O1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGu0IuxKDSnc5C+OWVmWCeYp4PsYZauisNnMN9uWo21jon6N28/YRWjJ4EZbRFnuXWBwPl3v9APXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CMcdEkTnRGrxxY22ZCkXQrillJ8K3kQODliOAEXqEupVEOZa
	/LXvY2w0yDR5mu73+Vpz6RFnPknZaq2/4QpDhB1Ui3i3LM7Tn0zGQ53vGU/CRse/yA==
X-Gm-Gg: ASbGncvXhonT9EOp+DRrh+tcOiC50r+FDpKIbxEmmAZV/pAwiiyYW3R63XZBNybbtae
	6tEZKGrQcrLiQ7Ih7ZwU9Up38bVUXEoLqEHnsScShDg+Kr4HQMZt2WGRvKSZ8Wq/kZNUaHztXgX
	/r052qWNXGudwvqUbuGFrt60mC6OxcVmItqtuHBBWQ2nREYcWrYyIATRLOKoJYeXpKLrnWJc9/h
	KlHCFELGWKkGASWVxxZROKxLCizTiX7hIBnKBqD4fHAC7HsF9A/vRdmTwzuO5x7E9M6u2oBQ28G
	dgIe+LZmRkrIkC8EjGb+nhrz4ayepEVzwokW9PTi5ABpSiYUIAy+FV5q4BNcOMdx5IH+7Rs6K9Q
	nwdySiilmyO8SuaGAlGRKYevWgGI7qujOwaLBjj88+N4gACEpaF+W+lckdJ2pABwrnXJQFQ==
X-Google-Smtp-Source: AGHT+IGhw7FjFgBAENHxwqNBn+q5TwhC7OvA4GcuoSnWIVBJGcdJW/TW82vig7dbFCs8/b6w3sEoaQ==
X-Received: by 2002:a05:600c:a10c:b0:45f:2db6:5202 with SMTP id 5b1f17b1804b1-45f2db65722mr740645e9.3.1757925390598;
        Mon, 15 Sep 2025 01:36:30 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ebc49f7ebbsm397501f8f.51.2025.09.15.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:36:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:36:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <aMfQCoLuVeR0nf02@google.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728135216.48084-5-aneesh.kumar@kernel.org>

Hi Aneesh,

On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Currently, we enforce the use of bounce buffers to ensure that memory
> accessed by non-secure devices is explicitly shared with the host [1].
> However, for secure devices, this approach must be avoided.


Sorry this might be a basic question, I just started looking into this.
I see that “force_dma_unencrypted” and “is_swiotlb_force_bounce” are only
used from DMA-direct, but it seems in your case it involves an IOMMU.
How does it influence bouncing in that case?

Thanks,
Mostafa

> 
> To achieve this, we introduce a device flag that controls whether a
> bounce buffer allocation is required for the device. Additionally, this flag is
> used to manage the top IPA bit assignment for setting up
> protected/unprotected IPA aliases.
> 
> [1] commit fbf979a01375 ("arm64: Enforce bounce buffers for realm DMA")
> 
> based on changes from Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/mem_encrypt.h |  6 +-----
>  arch/arm64/mm/mem_encrypt.c          | 10 ++++++++++
>  drivers/pci/tsm.c                    |  6 ++++++
>  include/linux/device.h               |  1 +
>  include/linux/swiotlb.h              |  4 ++++
>  5 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
> index 314b2b52025f..d77c10cd5b79 100644
> --- a/arch/arm64/include/asm/mem_encrypt.h
> +++ b/arch/arm64/include/asm/mem_encrypt.h
> @@ -15,14 +15,10 @@ int arm64_mem_crypt_ops_register(const struct arm64_mem_crypt_ops *ops);
>  
>  int set_memory_encrypted(unsigned long addr, int numpages);
>  int set_memory_decrypted(unsigned long addr, int numpages);
> +bool force_dma_unencrypted(struct device *dev);
>  
>  int realm_register_memory_enc_ops(void);
>  
> -static inline bool force_dma_unencrypted(struct device *dev)
> -{
> -	return is_realm_world();
> -}
> -
>  /*
>   * For Arm CCA guests, canonical addresses are "encrypted", so no changes
>   * required for dma_addr_encrypted().
> diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
> index ee3c0ab04384..279696a8af3f 100644
> --- a/arch/arm64/mm/mem_encrypt.c
> +++ b/arch/arm64/mm/mem_encrypt.c
> @@ -17,6 +17,7 @@
>  #include <linux/compiler.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> +#include <linux/device.h>
>  
>  #include <asm/mem_encrypt.h>
>  
> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
>  	return crypt_ops->decrypt(addr, numpages);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
> +
> +bool force_dma_unencrypted(struct device *dev)
> +{
> +	if (dev->tdi_enabled)
> +		return false;
> +
> +	return is_realm_world();
> +}
> +EXPORT_SYMBOL_GPL(force_dma_unencrypted);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index e4a3b5b37939..60f50d57a725 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -120,6 +120,7 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
>  
>  	tsm_ops->disconnect(pdev);
>  	tsm->state = PCI_TSM_INIT;
> +	pdev->dev.tdi_enabled = false;
>  
>  	return 0;
>  }
> @@ -199,6 +200,8 @@ static int pci_tsm_accept(struct pci_dev *pdev)
>  	if (rc)
>  		return rc;
>  	tsm->state = PCI_TSM_ACCEPT;
> +	pdev->dev.tdi_enabled = true;
> +
>  	return 0;
>  }
>  
> @@ -557,6 +560,9 @@ static void __pci_tsm_init(struct pci_dev *pdev)
>  	default:
>  		break;
>  	}
> +
> +	/* FIXME!! should this be default true and switch to false for TEE capable device */
> +	pdev->dev.tdi_enabled = false;
>  }
>  
>  void pci_tsm_init(struct pci_dev *pdev)
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
>  
>  /**
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..61e7cff7768b 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -173,6 +173,10 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  
> +	if (dev->tdi_enabled) {
> +		dev_warn_once(dev, "(TIO) Disable SWIOTLB");
> +		return false;
> +	}
>  	return mem && mem->force_bounce;
>  }
>  
> -- 
> 2.43.0
> 

