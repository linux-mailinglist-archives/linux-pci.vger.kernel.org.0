Return-Path: <linux-pci+bounces-4841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E087C884
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689F71F2297A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA4DF58;
	Fri, 15 Mar 2024 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0hN3g/G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F7DF51
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480337; cv=none; b=R7K9AKJT6KZU9Udg7f76HaAGQqgCMkOWH699qNmy2tYwyK+f3R4qzTr0Jx1ErrKXo30izLpY5oi3TzTb6vMn6Q3Q2Lf5OvllJPs0M9oBBtAdTfzoLE/agcR3SKf8z6afX/S0sEq5t08xq3ZKkTwEJGhvkvbe1tZHUK1XDaZbOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480337; c=relaxed/simple;
	bh=n7S2M3axVNGhpCuahYEp/h25OEX82dpbLj6miDkbra8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzX5xKJB3SP6mqQ959YPzzhCv8iyFz8Im7VKQ9+On6Fs96NcF6vC0dBhKG5N2eMvM5D9CfcGGMpHIBIjofLuNc+Ux3ResM1jOZoU2b4L+PEcc0CUIQdfJ7KA18VOPkt/coGON4Da/+TvbjMGO6H0RBnlQjoAuPz2y3UROklOX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K0hN3g/G; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ddbad11823so16434095ad.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710480335; x=1711085135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/uQbjG0sMdsu1lFcPBdOV7AGoyEk+SFe8i+s1BmJns=;
        b=K0hN3g/G3b4deNunwrcgZJ1i5jox/uUYwtL2FUFqRWbPnrxkzXnWiMdUH3LpBEyUyc
         OypjTShUzbfPDufrTcCO74DL82EsDpd7EN4bD3Wz/3V+N1LHL+l3NUG60YrwezWIGWMQ
         Q8W0m6tfJ5ikJODLD2ny5UNjv37zS0g+qZip7AMzZ8305/YGOh4ymGZkl1JYtzkKH22+
         XYa4SBQIUBOkwb620uMCsdxnQ2KVpFBAH8WFI62bcXYMNjMoWXjpqglugCrzLZmqtJDP
         t1OIDdqslT+dsry7TCX6JoG3BTPQzJV4/fMxhhdfgilE2zXGr6LhYrabcktF0eyAn1gU
         HouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710480335; x=1711085135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/uQbjG0sMdsu1lFcPBdOV7AGoyEk+SFe8i+s1BmJns=;
        b=D54S55IrDOLrCEfrA2X5BIw3maKDHWVcDAcESvUdKFrAMQcqCbswjqL8ssUYufSWoL
         gn5Ykrasb/RWYayowje9lQVGtKV2a7U8U3NiNRiZLguIbV/OhCBiooJjgwloeSsU7T/u
         3FljoLUXsBrLHG1A62+UfIkprNl7s7cT581M/DDVwlDVm2iEfdXP0c/NLZRJgY4iYI1O
         zoMy2cMAw8gVIU0lYdyDj7DpMAWXZ6Cyt/WhB3+8LJz0xPIdcRwEr3fTzoDaxL8RyNGp
         2MR7rg3W4SE1u9CbDShn2yY52wqrnO/JS1IHs+NxYC97Om7EaSEFvHeXBj7X2SBktZvQ
         +NIw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8XhpXisE6XyFnS1sq1+KL1ulm2ASqy2tVBVLXebd5yi123ADx43G2QBRFBfKb9nrCQPPMGMpWZ60O9UD6ehILRg8jyiYbyLf
X-Gm-Message-State: AOJu0YzFGcoGkAf0p+qxRtHTn7dCnoi/hMTJDXm2B/aq6kN1rHHYJ4SS
	H8/aOoh5Ute8lcLVXvTCoXUAM0a3Iy0bwydjZu1VPwENlcjTWVvFgRSwV4zGuA==
X-Google-Smtp-Source: AGHT+IHtnRA2tX3vDhJDg2jF69Bn+dxm3bjCko15esfMZe2qSmFZ6EFHPhqEg29ZnkLjdIa9PSUzPw==
X-Received: by 2002:a17:902:e74f:b0:1dd:8c28:8a8d with SMTP id p15-20020a170902e74f00b001dd8c288a8dmr4742930plf.68.1710480334970;
        Thu, 14 Mar 2024 22:25:34 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e20300b001dcb654d1a5sm2776549plb.21.2024.03.14.22.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:25:34 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:55:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/9] PCI: endpoint: pci-epf-test: Remove superfluous
 code
Message-ID: <20240315052529.GC3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-4-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:55AM +0100, Niklas Cassel wrote:
> The pci-epf-test does no special configuration at all, it simply requests
> a 64-bit BAR if the hardware requires it. However, this flag is now
> automatically set when allocating a BAR that can only be a 64-bit BAR,
> so we can drop pci_epf_configure_bar() completely.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 8c9802b9b835..7dc9704128dc 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -877,19 +877,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	return 0;
>  }
>  
> -static void pci_epf_configure_bar(struct pci_epf *epf,
> -				  const struct pci_epc_features *epc_features)
> -{
> -	struct pci_epf_bar *epf_bar;
> -	int i;
> -
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		epf_bar = &epf->bar[i];
> -		if (epc_features->bar[i].only_64bit)
> -			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -	}
> -}
> -
>  static int pci_epf_test_bind(struct pci_epf *epf)
>  {
>  	int ret;
> @@ -914,7 +901,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
>  	if (test_reg_bar < 0)
>  		return -EINVAL;
> -	pci_epf_configure_bar(epf, epc_features);
>  
>  	epf_test->test_reg_bar = test_reg_bar;
>  	epf_test->epc_features = epc_features;
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

