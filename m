Return-Path: <linux-pci+bounces-17395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39389DA2E4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4070CB20D41
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C3148FF6;
	Wed, 27 Nov 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hm6+4qeU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125A81AD7
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691669; cv=none; b=XE5AhyBUDY7UMd90xgn8NTuknT+Pb4vzmWQbng2s5tTUuPhp264Zq1uckhSIQ82iU3Xu3NkgbJqflKdS/jkmgOHPz3aypIamPxdiZHWkIFN6J7CcZGQsaOoVWTSD3xGPrBFx1SBg2bYL2fx750Gmka/zZ7sAVsRJpP26jL3t+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691669; c=relaxed/simple;
	bh=Y8NkSS6IsRUsnW3Oet45HmU5SJScm9VC72bS0rg0vW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnFeStfuFia4N+oXvjJFn8iGo1OwobHFC1+1PgBWDm67b9MVRf8LnsKiWhf4Ey9WjSyhZaerpdkdJMMZCg5yZjd+DE3TBjIPufVX+Vx+Z+WQ7+PjRkpfmuU349H7ATTy37eW3N0qmNxTbalCKPdxjIXN3fdUDtDKVvGw09htFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hm6+4qeU; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d537b50beso1299696a34.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 23:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732691666; x=1733296466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnQGTYgeHlpuTVGQOKayGlMc3QeZMzRcW7bcrGz8zS8=;
        b=Hm6+4qeUtpsZWIfyhd35UwhHigRETMM3x2Juta0yV5xV18FSfBNfwNA8aDvxFr5LqL
         rFhbm+lxR3SABGt/QYSV7Rh1qJ+TrEG+NUG1C6Y+eImZnDxBnZwdpDPsQPRCJ8cqtxh8
         U3sAo5b0iNMtluwjjceG8q/WZz9DYvW2ru5tPCTlMA22+ng5VJEYpb4R87uo8Yw4qw/c
         LKNsi8WXvs/HIJK+1wR9xx3xXenDoFXFC9ddkkQgqC517UEDSTz8VsdkJnKmUMTZ2O5U
         RNyFs+QNkJBpORyIYLtlAVcleHTVAWgZbb2UuqKRi1qkNTWXb+0hYyCN5EnjniPHS4pU
         gxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691666; x=1733296466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnQGTYgeHlpuTVGQOKayGlMc3QeZMzRcW7bcrGz8zS8=;
        b=Cyh7jjxxt6VmGuiZzZv2ABWWKW/AiLqKgYrOaxqnfb7IbH2d42nFAiWMiJi43N5/iH
         +D9v5AZeP8uBGSrlQaFGw4qwIqM63cfUN5Qi1Z/i5fOcA1TTWGyurioM08yU2SxLy5/U
         biTCGeHZUSpLONuhm+cbf5EqgnFp50rX8X7NgV5Dd7+GrDnWh5hnbStXGviHVTccR0UR
         eFKzG3aWVTVtgmDSYHFlsMYVcbO1/ZWYMKtT+kE5X4WrWhw0yA2CdKv3sl2SLU6H5VrY
         f74UfAUKHjcMeHSPQjHqXqtrgB3yx0Kfj4h234sPw5Sjakbfbcl5PTY1VkUdc3s0E4yF
         IybQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAvnDt97si9xzK3W6KzLXMjq80I0jQiZ4UbTmFh8eBSiJX6BpuWsH/RBiH1f1gKRkpZe0rseW+v6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLRsA9DCqu6tyXQBmS7N0qjAu9YHIv5ASoAKqw+qd9WWS/aHN
	H+mbCILQU0j3NakDNvYExbNtTYne2mDLVLv5qMCfV2XytUpZWrREhvqrRHeeuw==
X-Gm-Gg: ASbGnctfCvlIT+8VWfDNGgr4aP1ah6q807Z+8/n0JHNmTBTcTuZ7JZVM7wMTzOd/MkY
	fs/BaRX4DbAAtiQErr8IJsjLCuJXRwAGyiOFY1IgFupHdrXf3/5tGEhMZmJ4foIf+h1Su1TfcNy
	LagGRJvAEnuvxhriFt4vX0ru5DzVSrcE0AnGAiw2pI9zJjR/s+LfUq/l05Lr3Umvl8Rkpd7+O4V
	37MKNsEb3WQXX2reH7+fQmtag+eEM4WWYu406pWSyvwKEYwkBdLJ2pfgE47
X-Google-Smtp-Source: AGHT+IH4n9fQC0irNVt1HjBN+j/LBn/UMGpEw2JT7AWT4NQaf9ZGMbtXGu/9VIlPUPQxX7Q+Xz1XUA==
X-Received: by 2002:a05:6808:210c:b0:3ea:64cc:4954 with SMTP id 5614622812f47-3ea6dda0ce1mr1943890b6e.35.1732691666046;
        Tue, 26 Nov 2024 23:14:26 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de4786a1sm9524006b3a.51.2024.11.26.23.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:14:25 -0800 (PST)
Date: Wed, 27 Nov 2024 12:44:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/5] PCI: endpoint: Verify that requested BAR size is
 a power of two
Message-ID: <20241127071420.ggvyg5djkctoo33t@thinkpad>
References: <20241122115709.2949703-7-cassel@kernel.org>
 <20241122115709.2949703-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122115709.2949703-12-cassel@kernel.org>

On Fri, Nov 22, 2024 at 12:57:14PM +0100, Niklas Cassel wrote:
> When allocating a BAR using pci_epf_alloc_space(), there are checks that
> round up the size to a power of two.
> 
> However, there is no check in pci_epc_set_bar() which verifies that the
> requested BAR size is a power of two.
> 
> Add a power of two check in pci_epc_set_bar(), so that we don't need to
> add such a check in each and every PCI endpoint controller driver.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index c69c133701c9..6062677e9ffe 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -622,6 +622,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	    (epc_features->bar[bar].fixed_size != epf_bar->size))
>  		return -EINVAL;
>  
> +	if (!is_power_of_2(epf_bar->size))
> +		return -EINVAL;
> +
>  	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
>  	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
>  	     flags & PCI_BASE_ADDRESS_IO_MASK) ||
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

