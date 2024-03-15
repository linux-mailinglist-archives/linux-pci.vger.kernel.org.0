Return-Path: <linux-pci+bounces-4844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B74887C88F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EFA1F214C1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49E63AC;
	Fri, 15 Mar 2024 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noAVl6J3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3309FBE8
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481384; cv=none; b=jwr0POlI3TecL4sEQzRza6SzmZ73fB+VwnoejM7IqGZs+fpaHMToilyitQUUFsnqXtS/9XJ7c+698hvndAZ+SNdc4gNlVWDmUZrLhSP+4DJQS1TWn/gzB67XCx3DnW0oF8A9c0JYkkKbizpqAodOnJU5XGxcw+Jzkr2N2clPD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481384; c=relaxed/simple;
	bh=Lw0w9YL+gcPq7m+9O95Q1CqiW0HrkyaAKkxtSZOYHmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxcZYvyAGng57UInr7DvTLG9BMhEyjUYfGLv+tZ9GiL5D4Gr8HTppP616jVVcLWY+XgHBedxWzH6O0tUfxFfM8PA/8dI7SjFKTbo4u4i9raIwdYWukLs7EEB/Fw51KeU1Ji9cTZsKsY9KPD9Dr0TD1t/Qqndm+ZZQfnuLZXXSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=noAVl6J3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1def142ae7bso1615805ad.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481382; x=1711086182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lXqRjfPzN28rJ81I5h/eedfdWh+lv2P+lThu5YMqBOI=;
        b=noAVl6J3fY6aIreE0V/ldZBOpLuzwWiVFxvpgcRtoUVWPgsOAiPgQ2jZE5aD4jzl6+
         Y0BRa48v/JqGAqj0v1hWqlfduxqCfF+qO4Io1LWAEJjmrgoHNDfiNWXg8VB5KmJOMGrk
         ZZXb+D1XCI5AkBorSEu+BimJFcDgxODH5/TKPir6jJHkqmYYR4uuuo0/xiYwauj178bt
         0bwMd2dd/CTDISeEdcHyxSbIFFso6dWw69WUEiURuVCtgHE10Q3hQ2Mv2F+fV74C7of8
         8A8hbC0zGPnBIYXghuy4hFjZht4deANSiKyzjNkCgU5yco9VDdaHCdWk+2EoZf6Shvmn
         n6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481382; x=1711086182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXqRjfPzN28rJ81I5h/eedfdWh+lv2P+lThu5YMqBOI=;
        b=vTqNqGaGzZm56dof6JOCQiseKiYnsBS/SYSLI1HRE5chv2fBZ9T/JlnaWcMwnVINYI
         fqLTUaYaH8mybQECiSjSuq9UP1dSPvAd7SGCPdTqbMXqqzRNk5++wogMlZw4jM/pvx0J
         HKNxMnxakp4xg1tIa+as28QoNV22UZamn+Gw8OuTirRrE4UVStSK8mW+1eGyHJIXBG4p
         e2jZYyfBhIxOeqXB7YLEvm8uz1zzxwU2AoLSRppE1XpnkgJ+kCR++t5okC0jJn2QAM/R
         ypF1zQITxaqxC4DpOTFFaEidGPxVlpDkeytpzL1n+rdCQoeqHlHvVNBxOgnvUAk4Fg8o
         wRpA==
X-Forwarded-Encrypted: i=1; AJvYcCVnUpby9e28LJps0/w0yAIPC6B6SoFxjVWPaFBurcDpIGPTRIbt2ijeYhDlmMhLxhNNFJ11vmrKUpMWVhbG1NXmY7mb9GuNjnM6
X-Gm-Message-State: AOJu0Yyc6dWK5miucZVWqTBhxJyYddU5e1+ZTHmJNQHUpU4g0oR0H3OR
	Gdp4UZgjbhcgMYzkP/waX7v13XHLyvGx9WSDrXfOcn5/bsgg52x3qNAJGIZsFw==
X-Google-Smtp-Source: AGHT+IHWIDuB79z2FmQZ4Xws+a7UpXOyFJjihkGYu4bHvxKBsTt0OlAOwdX5m8hU6RINFmphysDrzg==
X-Received: by 2002:a17:903:230f:b0:1dd:b140:d010 with SMTP id d15-20020a170903230f00b001ddb140d010mr5115468plh.37.1710481381920;
        Thu, 14 Mar 2024 22:43:01 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001db2ff16acasm2790502plf.128.2024.03.14.22.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:43:01 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/9] PCI: endpoint: pci-epf-test: Clean up
 pci_epf_test_unbind()
Message-ID: <20240315054255.GF3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-7-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:58AM +0100, Niklas Cassel wrote:
> Clean up pci_epf_test_unbind() by using a continue if we did not allocate
> memory for the BAR index. This reduces the indentation level by one.
> 
> This makes pci_epf_test_unbind() more similar to pci_epf_test_set_bar().
> 

I've proposed to move the clear_bar and free_space code to separate helper
functions in my series [1]. If this series gets merged first (it really makes
sense), then this patch can be dropped now.

- Mani

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 91bbfcb1b3ed..fbe14c7232c7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -690,20 +690,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epc *epc = epf->epc;
> -	struct pci_epf_bar *epf_bar;
>  	int bar;
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> -		epf_bar = &epf->bar[bar];
> +		if (!epf_test->reg[bar])
> +			continue;
>  
> -		if (epf_test->reg[bar]) {
> -			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> -					  epf_bar);
> -			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> -					   PRIMARY_INTERFACE);
> -		}
> +		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> +				  &epf->bar[bar]);
> +		pci_epf_free_space(epf, epf_test->reg[bar], bar,
> +				   PRIMARY_INTERFACE);
>  	}
>  }
>  
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

