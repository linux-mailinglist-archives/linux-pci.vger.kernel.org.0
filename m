Return-Path: <linux-pci+bounces-4843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DB87C88A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784D0282C64
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667BCDF51;
	Fri, 15 Mar 2024 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDIdOhbB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35611C85
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481152; cv=none; b=HQa5E8I4iVbGiOvO8nC0IfesMH26Y77ccUvVJA/d6US9yj8bGTN4qRlbE0DslsomPf4d7dh86xVn/xC+eV86ogBNEI9BNiG9Vb9IsZSDZsP205Lt5YcQEwbOhlbSyfZS6kt+yJx/MWGi+T+sqebm7klYnMMQ1dCFqS7yrrzGNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481152; c=relaxed/simple;
	bh=df6QO/ng+1gy12xAP89QPA+vy+OpHqGtwni1Oe2xzmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCclpiE41c728SySnKYDP7Japvcls8NpqANkEI1CUz56SRVY47Iphgoh+X3gS4a54moy+NmoRhZKaoYmuOaOhHgih4R1MsGGx8vi3LmxGsHSjv6/fl6/YJRYjW+SaUJ95CNggxVCyNq8t7UAplJyf/k6SUI8CKMZ5GTVpggiI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tDIdOhbB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b5aa0b52so1559488b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481150; x=1711085950; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHuwPSG2RLD4RYlv+BbvJyMG9NU2ts4sM0dfVuvpJyY=;
        b=tDIdOhbBjwXALUTHig6n2tmdVO1BC4FzuMOfVnA5Q6Rx3kFHQDU+PVlF+IiN2r7/iP
         vFeajgY2hOdqU2nbQSrHiisVJIXxSxbhZeK+EKrcSFOgKmnRCKYcuv013j5vvZiHdhZs
         ozzvpjtMG8Ykj3DyOt7oPDji3QqVKb7l4rkIbVmX5JxxCHx6LJ7D10sxPBmdYL8Nb4Ac
         ciRzNp459YjGzxrBvPzY3E/E5Y8xsMZQcPPMePrDmd86BgSAAVM24N9zhEubJrAxLGIn
         KBfutdKU5HOqY3CeiMg/6GHDyYYI2fxLiWXdSPnx8TybJCKCMgn0muUg7ZzGL/uGtUji
         TQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481150; x=1711085950;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHuwPSG2RLD4RYlv+BbvJyMG9NU2ts4sM0dfVuvpJyY=;
        b=pfo+HcRctsqW8y58iQCXaI+Q2qCbG1SvvWLRyKNqskFgoPhNSClF1KuDEACBzKr17z
         912gUheIjkVOsSf5dNnKqBa2aQUH8ChUEzialoQUYEndm0nb+OPOrdmnisytLCXppSnG
         vsujLS/nzHL9vPwg5i/HsV9IyAdI7v9ixe7Y3/5YMgEVTI98vKzw8/qwpJkPzX9lmQy6
         PCKr8a5SvFejBd6F7pK9B5G2bur222+6x9AHuExpkpgNTTngrmN2c7VPjKjQb+kUpsf5
         nHUj3xB4eG7PDCjEU8WfDG6UblSZEc9YU58sF4yKWAr2NUfPZ+kCeAm6YFHpGPziYl8C
         W/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjNTrCbpdjOwx+HTiBGtt5NtrpJJICarFe5grSUU+WMo3qokber+6XV7mFECsL4FPqgAmkrrjRuym5DzBmbn1aYueTKWpuZ3O0
X-Gm-Message-State: AOJu0YzI2NrkphHWMU/gdepYPrBQWQQQrqPpHK48IhgMcP1VxDNwaj+8
	+f0GwOIGc//rq3aAXawBvgVmuQEkFcKmLfr6m1G7is21cvTL54Jwh5vAT5MPVl2eLLdZ0DUeQ5k
	=
X-Google-Smtp-Source: AGHT+IGXenRszOzkAX8TOYIVLVbVI99vAXFDkpMKTNW8QQ05Y3gIXjAWIstAA8KS0JxT7bgAlnQM/g==
X-Received: by 2002:a05:6a20:6c88:b0:1a3:2f9e:c611 with SMTP id em8-20020a056a206c8800b001a32f9ec611mr3482290pzb.49.1710481149852;
        Thu, 14 Mar 2024 22:39:09 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id kn5-20020a170903078500b001dee4a22c2bsm1501708plb.34.2024.03.14.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:39:09 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:09:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/9] PCI: endpoint: pci-epf-test: Simplify
 pci_epf_test_set_bar() loop
Message-ID: <20240315053903.GE3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-6-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:57AM +0100, Niklas Cassel wrote:
> Simplify the loop in pci_epf_test_set_bar().
> If we allocated memory for the BAR, we need to call set_bar() for that
> BAR, if we did not allocated memory for that BAR, we need to skip.
> It is as simple as that. This also matches the logic in
> pci_epf_test_unbind().
> 
> A 64-bit BAR will still only be one allocation, with the BAR succeeding
> the 64-bit BAR being null.
> 
> While at it, remove the misleading comment.
> A EPC .set_bar() callback should never change the epf_bar->flags.
> (E.g. to set a 64-bit BAR if we requested a 32-bit BAR.)
> 
> A .set_bar() callback should do what we request it to do.
> If it can't satisfy the request, it should return an error.
> 

That's a valid assumption. But...

> If platform has a specific requirement, e.g. that a certain BAR has to
> be a 64-bit BAR, then it should specify that by setting the .only_64bit
> flag for that specific BAR in epc_features->bar[], such that
> pci_epf_alloc_space() will return a epf_bar with the 64-bit flag set.
> (Such that .set_bar() will receive a request to set a 64-bit BAR.)
> 

Looks like pcie-cadence-ep is setting the PCI_BASE_ADDRESS_MEM_TYPE_64 flag if
the requested size is >2GB (I don't know why 2GB instead of 4GB in the first
place).

- Mani

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++---------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 20c79610712d..91bbfcb1b3ed 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -709,31 +709,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>  {
> -	int bar, add;
> -	int ret;
> -	struct pci_epf_bar *epf_bar;
> +	int bar, ret;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	const struct pci_epc_features *epc_features;
> -
> -	epc_features = epf_test->epc_features;
>  
> -	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> -		epf_bar = &epf->bar[bar];
> -		/*
> -		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> -		 * if the specific implementation required a 64-bit BAR,
> -		 * even if we only requested a 32-bit BAR.
> -		 */
> -		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> -
> -		if (epc_features->bar[bar].type == BAR_RESERVED)
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		if (!epf_test->reg[bar])
>  			continue;
>  
>  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> -				      epf_bar);
> +				      &epf->bar[bar]);
>  		if (ret) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar,
>  					   PRIMARY_INTERFACE);
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

