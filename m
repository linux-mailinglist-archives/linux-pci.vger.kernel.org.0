Return-Path: <linux-pci+bounces-33649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B119B1F155
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 01:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F68A0729D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B628EA4D;
	Fri,  8 Aug 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYwhqwmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365128DB7E;
	Fri,  8 Aug 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754696255; cv=none; b=efH806xoxZPVr6kBBhPECS2GkCZkbhhDYO3U0q06MKDUURl/QhxnY4jlQIOHmMBoTSXBbnNbqdWwsgAhdlPV8oWQHu+0kK+sKhKZMO8ADChV3+g0niKD/Iyzbpr4bfrb6FhOjjLXbq7RR8nB1WWIn8UnGSk3DxNz9snT8+Pv3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754696255; c=relaxed/simple;
	bh=T+sq90fZbAHQa4cXxatq1af0mUJVgnCR3V/n7FvtWb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWjyGewtUOeksSoeu+mpedm89lJxjiZA8b6kGdS2IQQutxIsdLacKe8LFivUkRr8lwtEtoT4SyKQoKdpf3+ooypkLwoQ854553DQEYWRdJ9F9r+h6paYNkEyFejjxM8OPFHw3E3dOpVlXpFYhmDWUl0YGlAa0E/fPrU/vRGtsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYwhqwmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D35C4CEED;
	Fri,  8 Aug 2025 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754696255;
	bh=T+sq90fZbAHQa4cXxatq1af0mUJVgnCR3V/n7FvtWb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYwhqwmLswXF1VCFh0EFkpAQ+ydMyosA7S3qRVKzDFgO9U9fh0YTf1Yloq+n8RgVA
	 xDH+2NoDkNAzdnx0J44/GwdmjXzSVpMVsKUYnI5g76kc7fDASjNAeAJaDKdAseI80E
	 Aq3X+o/QdlWja4NNojIsQt/CRlr+fRVKSeo322RF8red0q66zqYL8H3Z++GJZsT6sb
	 odPAclk9UcXqzjOkHB2JFYk3Tbcm0QexujEWlti6LHTgTywbNIgoJ9F6crNxT2GtEM
	 aQXFBi1KYyRxWqQyiohfIFbT/KJ/0qXVYysFOOHYIqj0+rGm4AuFh0BSrMiI6DQy6X
	 4ONklFiNV68Lg==
Date: Fri, 8 Aug 2025 23:37:33 +0000
From: Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [RFC PATCH v1 38/38] coco: guest: arm64: Add support for
 fetching device info
Message-ID: <20250808233733.GA3119612@google.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-39-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-39-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:22:15PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -5,6 +5,8 @@ config ARM_CCA_GUEST
>  	tristate "Arm CCA Guest driver"
>  	depends on ARM64
>  	depends on PCI_TSM
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
>  	select TSM_REPORTS
>  	select TSM

CRYPTO_LIB_SHA256 and CRYPTO_LIB_SHA512

> +	if (dsm->dev_info.hash_algo == RSI_HASH_SHA_256) {
> +		hash_alg_name = "sha256";
> +		digest_size = SHA256_DIGEST_SIZE;
> +	} else if (dsm->dev_info.hash_algo == RSI_HASH_SHA_512) {
> +		hash_alg_name = "sha512";
> +		digest_size = SHA512_DIGEST_SIZE;
> +	} else {
> +		pci_err(pdev, "unknown realm hash algorithm!\n");
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	alg = crypto_alloc_shash(hash_alg_name, 0, 0);
> +	if (IS_ERR(alg)) {
> +		pci_err(pdev, "cannot allocate %s\n", hash_alg_name);
> +		return PTR_ERR(alg);
> +	}
> +
> +	sdesc_size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
> +	shash = kzalloc(sdesc_size, GFP_KERNEL);
> +	if (!shash) {
> +		pci_err(pdev, "cannot allocate sdesc\n");
> +		ret = -ENOMEM;
> +		goto err_free_shash;
> +	}
> +	shash->tfm = alg;
> +
> +	for (i = 0; i < ARRAY_SIZE(reports); i++) {
> +		ret = crypto_shash_digest(shash, reports[i].report,
> +					  reports[i].size, digest);
> +		if (ret) {
> +			pci_err(pdev, "failed to compute digest, %d\n", ret);
> +			goto err_free_sdesc;
> +		}

Use sha256() and sha512().

- Eric

