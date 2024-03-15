Return-Path: <linux-pci+bounces-4842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA887C888
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB28E1C21BEA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C0DF51;
	Fri, 15 Mar 2024 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZ8hGpsT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B1125C1
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480554; cv=none; b=obgpX0//wwulkWKRoZ0zW2d+HREbD45KFfJtTadYZuLh+6063yrdmCZDvAyujoUoZOtOmk3E+JAPaDjNN/R4cB+dP/6AqQte7w+OmOb1/dbUgjdhlK+eqVdqBFh2ru+GpanMv1U34YY5jvA2iqVJNS09SPvy2I3Y9r65FAQkZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480554; c=relaxed/simple;
	bh=W7lg9nuvPZBu534OuW+VxXbQVt6gkYOaWjTJoUQMDII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlEELg7aHcHReyoDWYO88cL94yK4EVfdEuT3+TfkNyoqqC2y5iFr+aCCf+55CzqdYeWNXF2l/yuAYiRVD1Bws2XilACunvRkZ6s6Ho4kLWAOnAZM6sGOqvDf/mw1oQUbByMM51ukLpiUp9RMxcC0QZg9WpCmY88JohrjzK8VqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZ8hGpsT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e674136be9so601016a34.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710480552; x=1711085352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pZ8p8ekCBGokG1JevJEOCaN1eNhWTPz6UhuM1GjfgXg=;
        b=rZ8hGpsTev+1z+Y/cM9SIis8cWOQJLSbY/qJWjVMjFiEGE2RiivYq+IfZxvrYzwr4X
         1nUdCIKTyziKfe6+GEPToUTcYzQ+3kUDpiwcu5Qaqh6q+FuOfwaRpjwwUQoTuFJCJvIO
         2v/NV8oupH1i6HlOhZNMQ1Y0CmOtkVnTwYiN51zupL/mLELd4jjcE15pP2e3dN7x6fwd
         9ndYUuX+pHZdY2ior2V9b2jpGDRkuwlxWuqVI8ZAoFNlcYTW7i+lRZ6tnQnT8RhzlStl
         b/26XbDJlAxvSOblEZHr6LTumwB+mHssO/aS5oas5C8zh/Oi1DgFcfcc1/j1SHuwtf0k
         +cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710480552; x=1711085352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ8p8ekCBGokG1JevJEOCaN1eNhWTPz6UhuM1GjfgXg=;
        b=b4hyM7t+uFEU0OVOvWD1I6SotBIR36pjjw7JmvzYx669LTcS1SLbyZHp7n8pr8kCdf
         BdBfH7vCDLd2Ujm+vOlep8WHL2e9ZRNQWYZGjxJc0PQ3GefDIEglb7odSdSdcOgJwx3D
         2tX8RIswD0xH3ajUuUmbUpOt5aXFBKevsyaOa8JkAGCyhcfguP+vyX0HfK/IAZGzRZDv
         FMageZ9t2gosye/0smCJSxMNpfXXYNDBrR2m3J+pT1+IEyqsRpI1y/8dY+jlqWutv3he
         8fgb/w59Y50+qTfTHX6V2u/g6hxpVz5ewoYG34mIF2vJmIMY3iUuNmsOgQTKHQ3QGlCa
         FR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXizHJx1uyd2OT6QT83HwzZg2Vcy8yTnWm/8GE2Arxyr0eaWr2+OYI/3AemDedBqzG2wuPKWlolImGv2UuwOC84bi1zTIKvIxwa
X-Gm-Message-State: AOJu0YxVBfKx94p6Z90n7tTAjRz2y4i4Bp9p3cTYf3A0kmzBMGvJhp2d
	pt8KHvN9M0O/bjFluT+iNyntrV7x1gBNGiiq08pI1Gv0OwT7cs1MJDoGYds5xg==
X-Google-Smtp-Source: AGHT+IFHqRLQ0o5ZCCF5YH/meJHZFiLiVjc2k7sOVFjbcP5HV/8E9odYKLYXQp6SYJ6ggWCjrV6TEw==
X-Received: by 2002:a05:6830:43a2:b0:6e4:df07:9444 with SMTP id s34-20020a05683043a200b006e4df079444mr3215988otv.27.1710480552250;
        Thu, 14 Mar 2024 22:29:12 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b005dc87643cc3sm1674348pgz.27.2024.03.14.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:29:11 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:59:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/9] PCI: endpoint: pci-epf-test: Simplify
 pci_epf_test_alloc_space() loop
Message-ID: <20240315052906.GD3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-5-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:56AM +0100, Niklas Cassel wrote:
> Make pci-epf-test use pci_epc_get_next_free_bar() just like pci-epf-ntb.c
> and pci-epf-vntb.c.
> 
> Using pci_epc_get_next_free_bar() also makes it more obvious that
> pci-epf-test does no special configuration at all.
> 
> This way, the code is more consistent between EPF drivers, and pci-epf-test
> does not need to explicitly check if the BAR is reserved, or if the index
> belongs to a BAR succeeding a 64-bit only BAR.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7dc9704128dc..20c79610712d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -823,8 +823,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	size_t pba_size = 0;
>  	bool msix_capable;
>  	void *base;
> -	int bar, add;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	enum pci_barno bar;
>  	const struct pci_epc_features *epc_features;
>  	size_t test_reg_size;
>  
> @@ -849,16 +849,14 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	}
>  	epf_test->reg[test_reg_bar] = base;
>  
> -	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> -		epf_bar = &epf->bar[bar];
> -		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
> +		bar = pci_epc_get_next_free_bar(epc_features, bar);
> +		if (bar == NO_BAR)
> +			break;
>  
>  		if (bar == test_reg_bar)
>  			continue;
>  
> -		if (epc_features->bar[bar].type == BAR_RESERVED)
> -			continue;
> -
>  		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
>  					   epc_features, PRIMARY_INTERFACE);
>  		if (!base)
> @@ -871,7 +869,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		 * either because the BAR can only be a 64-bit BAR, or if
>  		 * we requested a size larger than 4 GB.
>  		 */
> -		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +		epf_bar = &epf->bar[bar];
> +		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +			bar++;
>  	}
>  
>  	return 0;
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

