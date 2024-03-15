Return-Path: <linux-pci+bounces-4840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3BC87C883
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97B31C21E22
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17271DF51;
	Fri, 15 Mar 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDwZTQHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454211C85
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480301; cv=none; b=rNZCcIayGw1axT9TNM2uP7/fcTlqw0fOrxWWQVT9f9wgW/rL4ZfJPjQW7W1Yj1RuaAFhIJdbfLl/aar67oG04EMmN4t1dN6Yg37gYOgIEvJ2J5cB1W+CyxVmE/SpcJH8kgn+rUVRZpqWG7gk0c1LVAQYZdOqAzpnDS5150TiviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480301; c=relaxed/simple;
	bh=R9uS1u0hochyoutaa/u0X3XWogxqs0S6suLWLbkqXGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/hXCjxK5h+K0g2Z3KZpTkCYFdCgZ8W0AvlVixE7ykGfx4qt8Pf0RZB40RZOIEEKcN6iqY449u3EluUbpiALtPb4XpwtrmjbBOY0suOYx1vU+VMbnmNVMg9cvnW/JHRf7pqxPQKAcVVhuV0CnX69RBrC0SRPIabjP3P7FXLCrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDwZTQHj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dde26f7e1dso12159875ad.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710480299; x=1711085099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbbZ2Udf23zmvcNyRG9GOPVBLFnSQDu0fZ4krasjzL4=;
        b=iDwZTQHjTbeNQ8dY/kFyxQNOwz7iQB+2tjY7+D8xjl14y4tAAFn9RFw/DrrdRBOr5g
         iD1yNtVe48H0MrUIh27gtC4pFrn/OkZbLAI0OGgwsSLg6DncdtWvZtddAVZ7tDNaovIR
         SaZ/wTGUV8+zXxSfz6RLlZcRXuM5VOwrdMmbsg88QUzVz9mC92OmMNqQFQGDwcU57UGB
         EncW4SZmmYknx8D3huo43Dw8/o8D8/spf1Q6f5OWPxzrSHayihBatskK8Dya3q0XdPi3
         m3W/PWQrGaG9+VW7i7nP9TsZikIJch5CQ9CXE0R41vSeipFqwUP/mHt+RR0n/xwOPFeW
         lCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710480299; x=1711085099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbbZ2Udf23zmvcNyRG9GOPVBLFnSQDu0fZ4krasjzL4=;
        b=YV1C+Vuo1JR6nv7OMPwfo9KpM7zpn+0A/qY5sn5zffK9H2hHBvFsqYgejG1eCxaRIv
         g+4vIYfx0Z2MDVX6xBe/tPe9NoEkNXG4dfzYR0LugnAoshuAYxd1/PdXsEQOS/oDP1st
         SQ+b8DDRhfqptR0Ue2stAE9LtI7iOkeTUPYBG0HIhjDfY4JCbq6rPcQUmgvAgSN1UsGN
         ZTj/EFK9zVsoKjaK1NrSuA2MPdZxcGJWia+EB8wQ7xal+JfoWICvfB2mBVS9PZeBHKlz
         27T1aD52/9zn3otEbPAfSA1u78tT6Qx4lHgJhiPoPau3BOQvxw7qOBZPdToSMyc1QCPS
         am+g==
X-Forwarded-Encrypted: i=1; AJvYcCWFcr3PSQiLzefEqlMYDhpAqkfRb4o5LHCRBgB4yLugxfshEWV7OOx8loFyhsdGgE6t+e6EoBQCNtuqBKWV9gCPRBqm8iS99LoQ
X-Gm-Message-State: AOJu0YyXB9SUX0rUlmAvtgLLFEKLyIMWgu+8SVoJaFP4DcSCCAsH0FWz
	2ittLMOODd9yqkPt/kfI40Nz7C2D1WwThr6S80V81kCUybZlwHL4AxgYFdwKzg==
X-Google-Smtp-Source: AGHT+IF7++GvHg67QJQfiZTkI62frJsd/44WPT8BDMvYsS86aHcSBBVjW3RTkeZiT+hAp9mBROYF/w==
X-Received: by 2002:a17:902:ce86:b0:1dc:90a7:660b with SMTP id f6-20020a170902ce8600b001dc90a7660bmr2512498plg.9.1710480298540;
        Thu, 14 Mar 2024 22:24:58 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001db5ecd115bsm1348685plh.276.2024.03.14.22.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:24:58 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:54:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/9] PCI: endpoint: Allocate a 64-bit BAR if that is
 the only option
Message-ID: <20240315052451.GB3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-3-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:54AM +0100, Niklas Cassel wrote:
> pci_epf_alloc_space() already sets the 64-bit flag if the BAR size is
> larger than 4GB, even if the caller did not explicitly request a 64-bit
> BAR.
> 
> Thus, let pci_epf_alloc_space() also set the 64-bit flag if the hardware
> description says that the specific BAR can only be 64-bit.
> 

Could you please update the kdoc of pci_epf_alloc_space() to reflec the same?

> Signed-off-by: Niklas Cassel <cassel@kernel.org>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
>  drivers/pci/endpoint/pci-epf-core.c           | 7 ++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 01ba088849cc..8c9802b9b835 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -868,7 +868,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  
>  		/*
>  		 * pci_epf_alloc_space() might have given us a 64-bit BAR,
> -		 * if we requested a size larger than 4 GB.
> +		 * either because the BAR can only be a 64-bit BAR, or if
> +		 * we requested a size larger than 4 GB.
>  		 */
>  		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
>  	}
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 0a28a0b0911b..e7dbbeb1f0de 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -304,9 +304,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	epf_bar[bar].addr = space;
>  	epf_bar[bar].size = size;
>  	epf_bar[bar].barno = bar;
> -	epf_bar[bar].flags |= upper_32_bits(size) ?
> -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> +	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
> +		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +	else
> +		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
>  
>  	return space;
>  }
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

