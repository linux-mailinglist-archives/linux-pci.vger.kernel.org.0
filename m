Return-Path: <linux-pci+bounces-10730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2193B4C5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6206D28155B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4415B134;
	Wed, 24 Jul 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMUolZob"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF02595
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837963; cv=none; b=c2JmfFlRDiFWjypFmqtY/eyIupPJh30yOD0BnNkYdtwM1xwTRSD82p5SwlLzJ1VKqzbiD93NYwZ/gTk6rVJiwGzs3phDYW0SwNKMsNQz2puW6stseIvYKrBOwPP7oRbxnmRe0e7MRy7CqfAs4dRfXY/ZlzeJgg99jlVZ45XcKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837963; c=relaxed/simple;
	bh=f30zFParFK142Sof6KuO+fMd1kxpq+GScyC9c1ue9Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUoKw/Ao0RcJkxJh0cGNf2CKYUZqEy9f8UJS99mX9npwKvzVsKsCQ/6v+DMnu+h3GRh5AF1NUHpkpKWAmzKXzv/2N5BUlNIXFGY0Gy3CaaTJnRlP5YfnrxakdvoHW0NKuCPxQ9Q3GiLrr4H7tEt/PfphB1Dp1AdT54Qw/34T3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMUolZob; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso13510695ad.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721837961; x=1722442761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uk6VvkGCsbeQVal54C7Yzy20X2Egh4+UujE84uvAe84=;
        b=uMUolZob77SBgvA8j2JRDYrU5kfmPoCw5R1Cl6Y0Ar55kxLyUkMS4DVygYQwiRTgHw
         +zTW4u8eb/HbNj0jAiYNpfNPOpvz8tstVJLC6iJ64QANpVysfTa7PryCY281x3/6uAcD
         kLVQ6Cqz3LDVs9zCBpLxwv8au/HyrqHsniBq9tvchHjEnbw9bhLvt2TEbJol9TAw7oOc
         mSyoV1GGsnBE6qYXktvW7aWKf3xvXkElpP7FM+QAJf31LNILynQFKCBbXAmJkoVC4bX6
         oYjkpaPtdga97WETNdODHodbARJci0LOuQg+i6Oi+89ig9EdYoYsZq6mb1E1udx+nx3+
         ctsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837961; x=1722442761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk6VvkGCsbeQVal54C7Yzy20X2Egh4+UujE84uvAe84=;
        b=S9B7ZZiK4yAWBcusKlbcqjl/geTEEYWRC2KcDgVTSCnTf1D5TMjxPgqs3n5WYjCH09
         Oj1WCShhIuoIL95/7OB4Z/85Zd816jVWjRN00O591l20ySZVA+zy8U1fRSV2GjG+zec/
         EF+1iGAk1UJbButPlDfr2JOZNO9XYROVV2ULJlr9tC1lQpT5Y3gChlwK6zrOaknNkl0A
         PiWswp98o168oKm8GKNTrSMDlWRAqt4a8Z7to+SPZaRKRH+1beJbiOsurwTWdlMVrjX8
         ViaQrrCfntsaIU2uYfPT5Y/BKDKWo3IFL3+e4Vvtzl8Ku1Bm7O8HXyp8NO6eFGnaq76w
         ReYw==
X-Forwarded-Encrypted: i=1; AJvYcCUR7yiY46mOhm1klmOM58iTzrDG3b1cxjYa4RVA0v786cLryj3ehl8a1P29JBBphN885C95j5VVTZSkygFNMi1cX1vTmlakDwzr
X-Gm-Message-State: AOJu0YzcsK89Exm2hynFUsMD32sBHhQaFClKfSrn+sjXQHpEkw6SxMWW
	K530/Lp7V9ihAxkXasmk0tBxQuGRcgLLDNlkeUBrmwLnxU7yMhmSJCBFqzmArg==
X-Google-Smtp-Source: AGHT+IHIrTkDS2WCnTKJAArgrlpe4xhHZbFrE+hRGnbRw/giY7CXM7xCg5WsJLXv0yC3yxVxg2OLJA==
X-Received: by 2002:a17:903:228d:b0:1fb:719a:28e2 with SMTP id d9443c01a7336-1fed387086fmr850095ad.21.1721837961184;
        Wed, 24 Jul 2024 09:19:21 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fdd4c62d9dsm18029785ad.159.2024.07.24.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:19:20 -0700 (PDT)
Date: Wed, 24 Jul 2024 21:49:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240724161916.GG3349@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724065048.285838-1-s-vadapalli@ti.com>

On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> Since the configuration of Legacy Interrupts (INTx) is not supported, set
> the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
>   of_irq_parse_pci: failed with rc=-22
> due to the absence of Legacy Interrupts in the device-tree.
> 

Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
if 'map_irq' is set to NULL.

- Mani

> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
> of Mainline Linux.
> 
> Patch has been tested on J784S4-EVM and J721e-EVM, both of which have
> the PCIe Controller configured by the pci-j721e.c driver.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..5372218849a8 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -417,6 +417,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		if (!bridge)
>  			return -ENOMEM;
>  
> +		/* Legacy interrupts are not supported */
> +		bridge->map_irq = NULL;
> +		bridge->swizzle_irq = NULL;
> +
>  		if (!data->byte_access_allowed)
>  			bridge->ops = &cdns_ti_pcie_host_ops;
>  		rc = pci_host_bridge_priv(bridge);
> -- 
> 2.40.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

