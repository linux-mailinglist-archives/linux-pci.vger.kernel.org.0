Return-Path: <linux-pci+bounces-4987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19015886A5D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5201C20BA6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CA26AE8;
	Fri, 22 Mar 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rm8RYO6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51017575
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103523; cv=none; b=D6w26b6n0Xrr6EsKoMmxTW385qDhNYQoJsyq1v7OwofjQ0WPqEBfOQ7KxyIM7mR+FK3IA7tECOvb4WcpeHO+Bnuu/r+0niQcD6LKoDWL+g+Q7uyXwQPP2bizR5aSj4lGZOafnqDfbakwqJDGJny2Y3tU5Ndrx0hI4RX5vCCeX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103523; c=relaxed/simple;
	bh=mGwvEu8saiMnA2nThHL7kOdUPsbhBwWyqALeXK+fcw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuSmQ7tcwfytdJHWjcBAP3BURjlPFMaBrqKgHrfouIjwc8UkY0ws5UYwD+6nhyO+kf/jNcCGJ+oPbHXgHpLSv8cZgeZrv+aP3v75dHyley7W0SWVLWbTzNjeXMQjT4yajHis1se3xi56rbPgQr/wSmzoy1qFqeB6Ktb/nPvkBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rm8RYO6k; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso1658885b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711103522; x=1711708322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6eUFmEdp40liDMXjMWuvMqXebyHq2fGLWmgIYE5E6EI=;
        b=Rm8RYO6khBTT5kqt+s68GRgIf9+YGAs0Da13+tGhYVSIHu9Gp/BOMxO6jB0vAMVlBW
         cz7dT2sTdPkAq2YwvKX7RQVdLKeMwikwpHv7TzhuqFjTJHiJCqkOx5LOqaZ5qAhHpiaJ
         09e1u1uVYaZmW9t/OfLF9VpVChvsrrq7hCxnKfEyFjNiUaS9yvDt/YgScr5gKsk8ydFw
         b0diGFWGJoRH1w1bwMGMzyNCDMZkZNn8fqjXURpr4BkYUUog3glKZJwBLFiKWJfwWIdx
         4Kg5IsIUI8ju5sQVbMoCsC9xuQ9ISc50pmnAx4OFPh9tkoUQJXZpOEw80T7MZZkxNX0f
         dfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103522; x=1711708322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eUFmEdp40liDMXjMWuvMqXebyHq2fGLWmgIYE5E6EI=;
        b=C9UInqYcdBzfZo1PZbN9S+53FaTZiAHWBfDPcuJ7BPBds0IzeVMXDM9QHxkhvYhI/b
         UMQctFO0tMqdU6fPTbhKS989uH4zxzxH91cQbloDh/KQ+G3PLCgQctXccp++9wscx1mx
         rUzq1c56WDrDrLGhkFoFDXCCglydqgXZ1gAY4tBbvjI90M+DEdjh44Yqa5z5PS/vJEub
         6q/dIgtZA0QklkkIy1zL3T2WYEBpUloz55Z7L6EbHP5sW/v6EZoaUlW+YGreEB+y0omM
         sJm7bXC81qn6lmyv+AiCSWOQK1mO7YGCDy2GHGnyxCKtfgHGj3qVGrBQDzKPmFYhE665
         a/iA==
X-Forwarded-Encrypted: i=1; AJvYcCVKEGGu4C3q3T/r2Ufgd7NLfbOFFJp6ZSlWN4zhRw0q3S5bASjvcUgdxY+oLc43uwHQ5HyfcfOf9szqDdfV5w/zAivNpNVuBu1f
X-Gm-Message-State: AOJu0YypkyKOOgVJnxqWFjhUR+X0LGd3FBspt4xZ0bD32ByGOJ8W81Wr
	hwNoLCXGqucA08ZKVf2lz2eexEIsZxe7eWfCf6kqG2MQJHKDWqd0nQ/kDUUUWA==
X-Google-Smtp-Source: AGHT+IFOHHAdPeibxLTQZsTWN5nfhB9MtVfx9JxIWNg1uRi+5S53iNhZaeP+oYxGN9sUUwBBeYFwjA==
X-Received: by 2002:a05:6a00:2384:b0:6e3:c568:47aa with SMTP id f4-20020a056a00238400b006e3c56847aamr2409864pfc.24.1711103521652;
        Fri, 22 Mar 2024 03:32:01 -0700 (PDT)
Received: from thinkpad ([2409:40f4:101a:4667:2dab:fb9d:47a0:28fe])
        by smtp.gmail.com with ESMTPSA id e23-20020aa78c57000000b006e6686effd7sm1348636pfd.76.2024.03.22.03.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:32:01 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:01:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: endpoint: pci-epf-test: Clean up
 pci_epf_test_unbind()
Message-ID: <20240322103156.GC3638@thinkpad>
References: <20240320113157.322695-1-cassel@kernel.org>
 <20240320113157.322695-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320113157.322695-6-cassel@kernel.org>

On Wed, Mar 20, 2024 at 12:31:52PM +0100, Niklas Cassel wrote:
> Clean up pci_epf_test_unbind() by using a continue if we did not allocate
> memory for the BAR index. This reduces the indentation level by one.
> 
> This makes pci_epf_test_unbind() more similar to pci_epf_test_set_bar().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index faf347216b6b..d244a5083d04 100644
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

