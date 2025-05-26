Return-Path: <linux-pci+bounces-28402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA49AC3E7F
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C8516C0C1
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD091B4138;
	Mon, 26 May 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGHdMtBT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF310FD
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258418; cv=none; b=JMQErBc+W4WONddW+ombqLBL43ss9CGSU+rQQfhhfveoM6Gh8FwI6pycm5RX2fjUw02xBgP4JdhT7JOh0Lxu/uCGFS3sfUQ8XHxpZfXFInm43fWNkQUouu188uvup0gYVJg9tyEjsvWu3E3hXgvGnCQ77K6ADntz1QiXEU9mPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258418; c=relaxed/simple;
	bh=MDXjCtL37s0PfvdtVRydMakOatPLVqq6dltIrPLTd2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOSokfids3E8of8EHamS6yTQ7E3OXmwoOUH25VDIc+ubw0vjORG6zCoWRqbTOByXwm0e9sCYGWfcGraI5RCRsFqOak60V124KyUGpdsSHlik8vDp9zUk2IyDfCBgzm4YfnPr2qxyB6wl/TnpBsQCSDCwxRpXKXSSxxqzF63NCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGHdMtBT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c9563fafso1378102b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748258415; x=1748863215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73sX7iJ5JHHWJ0xK5mbucxCPBJUUkXqhsnwIJO0JoRA=;
        b=NGHdMtBTTqsOPI7dDN+Zvn6m1Jmvy/G2cEDFovo+4OoWlYlBpai3PdGdyzjhnVZq9L
         XCT3H3LD8oSvIIveKbmoIEXqBhOnbK80iV2VY1RC37lGlIK0XsctFQ110PEkqPXRuB0L
         3eQsnSUhSXBuP1W2g2YL4yqeftyc4W+AKhXA38h5SzcNGYcSkhZcrH67VwzMREi3zY5+
         uKMbV1EyZvX6paYLevz7iP8Poz+cbAIt0Rcylz5Awx7kR0IYbqSwSpX5jpXpcvCNfFzc
         QU8j1lBlFcAtNcZX4uaJ0j5AxB3YdVEIeI7i2TmhJdW/+QCV2DfQ3JKbphPNRejwryLj
         7JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748258415; x=1748863215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73sX7iJ5JHHWJ0xK5mbucxCPBJUUkXqhsnwIJO0JoRA=;
        b=HWXM6GFxiSnfMYHCxOq+6bU8280AmFpz0L7zsf+h6oZFdeU39j2WWp2eWXKCSkxXcy
         aC1o9YaJowLazyStSq+JTTrYWgnAy96NAy0lURKjt8FJh9B0pjm+9K0oFaVxL5IrhgnX
         6nznoar1kyb8C4/v0d7qhJ11cNc7WBy5emIZXOmbIuX8X0EXETNCY06GJcb5JeedCxJR
         YLC7kTep08snlY21Dw8ePnVnEeHstuv359KXgG/gnS6ddBBJiMf59+zO3DGioWqMsLoq
         zClOACMK1rVC6iIOOBfghXzarKFu460TkdAMJzOEMogygHPo058Zpey+ZEAJ0PUVOgE+
         q9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkMB61LVXucSXrWsfkzLrT3yiel9zKVMVmj9ZmSZpFYAhP2dumkmhzPmi22+vQTQtlMEj7h3pZEMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tzf29dCIBPDq15H9h7hGY03O/a/eHbE9z4Xyt/4RTmYx6FBC
	ZiSsyY3zOoaJ3yFWBTV8dHny3cyt8gSnMFlspvnvOKSXa7B6Q08+V0MVuPV7DBBG9A==
X-Gm-Gg: ASbGnctwyZVcAklRA0RdicNreX9r5M+zDb2eBNOmu505fAqA2nbMFEYKfa1vEl71Fsu
	SEZ8nmJqrmkh7rwLLZm92YyM86Q4JIL23s6ox5PqtfcvR3zTjh0XVkORrFIsNMytXqgDj+mantA
	+ZDCR3NnL4t/rn7UBpvqTsqefeKRv2aorQCn4S9UbWRIZ3lwkz30mX2gnljth3z3rs2yBVa2knh
	tlM/BaM9J+eqoqzUy0HRaMt53yMAnu/yFIKh5wpszqGeshRX4QdwqJLciNhN39QWL17gW4RYPVP
	D4TdBUkTPs9vuT4B3CGjnmYvUq4fw1kBpT78ygGntwugMSgdor/0l/+Oe5yzonw=
X-Google-Smtp-Source: AGHT+IEtHzRmB3/H9bxYYcQJ1UUmTP1RbO2XXAniLwQluQEBWwd/5lea/BSn5A+hHCKsI1x35R/pXQ==
X-Received: by 2002:a05:6a21:9017:b0:1f5:6878:1a43 with SMTP id adf61e73a8af0-2188c2673f0mr13135303637.14.1748258415451;
        Mon, 26 May 2025 04:20:15 -0700 (PDT)
Received: from thinkpad ([120.56.205.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2982c04d12sm9828819a12.21.2025.05.26.04.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 04:20:14 -0700 (PDT)
Date: Mon, 26 May 2025 16:50:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Samiksha Garg <samikshagarg@google.com>
Cc: jingoohan1@gmail.com, ajayagarwal@google.com, maurora@google.com, 
	linux-pci@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
Message-ID: <bddr5afnyppbtpajk3wsymwnxrdvyyradxwqf2kkiahwat63av@h2kttx5blizv>
References: <20250526104241.1676625-1-samikshagarg@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526104241.1676625-1-samikshagarg@google.com>

On Mon, May 26, 2025 at 10:42:40AM +0000, Samiksha Garg wrote:
> Some vendor drivers need to write their own `msi_init` while
> still utilizing `dw_pcie_allocate_domains` method to allocate
> IRQ domains. Export the function for this purpose.
> 

NAK. Symbols should have atleast one upstream user to be exported. We do not
export symbols for random vendor drivers, sorry.

- Mani

> Signed-off-by: Samiksha Garg <samikshagarg@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ecc33f6789e3..5b949547f917 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -249,6 +249,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
>  
>  static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  {
> -- 
> 2.49.0.1151.ga128411c76-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

