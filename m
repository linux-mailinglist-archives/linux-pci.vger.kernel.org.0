Return-Path: <linux-pci+bounces-4839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34387C879
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2315F1F22792
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159CEDF58;
	Fri, 15 Mar 2024 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHC71c6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E4DF51
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480056; cv=none; b=OX3lE1CA6IFPBvuIFQp3vbVSppsVkGCgllpzpJIyPEJHrmAMHAaAz7bjRuhGAiQ5aS8AIeBwsksd5RcALz6T/fXQCb4zj+mNrxG3g28fEu3yDx/0D7s4e1lF3WEUa8h5rT4lLOMd96uJc3qmKYuFw4mbxOenYMn1UXFf2UE+5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480056; c=relaxed/simple;
	bh=GDsyzKR3i5LCsgi0D9xdia1wC47i5r/Uogz/maHS/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FokjWiCVxuHN+3TMLTPxxzkXyapfY3+y+hvChnjYlo0orA1N7eAqjZjiMKSgUsXK/knkRk6wTn/dBQJFWSTcYsm3fXONcynNDUvGY/oNd11DopML4cpaSWPCfY3SoKWwCrUgDP113T0Av3JxZX1HdjVmx+gNzc0/atgGdRWmp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHC71c6v; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6ccd69ebcso1030092b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710480054; x=1711084854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KX/lW5r1UN5lS42Y7BMSLNn6oMiwpasFwqUS4PDGYLA=;
        b=KHC71c6v6u+Z+y44zWlEdgrk43MpYf+VQljlgiKRHAlj1Jj0MA9jT4M/WnH3eS8zM2
         Ry8AJrmDMOVLilu9EHFUtrB1bht5Z3HO5LiHOXQrQEMYfn0tqElv5J9Z2rs5eRk000C4
         hRQchQ0XWFbzPHq58WM2Z3S3tuFd2fAvTrWVEKSIFIgcBtF1KoyXQ4anLyXpuCZLNfba
         hQiVZcXaf3+LSdxYVZo/yyRw71D9+uKFCOI+ak8DOpTy7v1poaiO2b8nLzvA0gNGxMIy
         6o4w4Bql41rZ0WbTBztO8XifpxRh5HmltecHA1wlg6RYFGSeeVgZXAesfCNpIj+vpNIV
         kOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710480054; x=1711084854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KX/lW5r1UN5lS42Y7BMSLNn6oMiwpasFwqUS4PDGYLA=;
        b=qzhPNXPsmaXpuqPs5UxB9eDMOqddauwx8y/ecEsf1Jnm/ZqIBCcN3MNmuB5Oo+l6S7
         w93Q26qswGcGodfd08HUFH0kDyvZhT5Xf6k03RHJ/iaTGDiQf5OFhac1g+WRrd1Ughgm
         tEhoVCcz7b18Anj45614Yx/em+1IgEued2NWSPxS1zink9LZav9cp7KOq0zXhChckfJf
         IXxevY5sJHHhKihG+8yfIUl0IcBA4DnR9DiCbn9d5l9mooPunxsxpx8jvWnr5sNdsk5j
         B3VkvZfgTsgwacNoRU4UKumYzMklZP+d072IJpThcITdYmQa/iTV1w6LUVRS+SgLUZFo
         7XHw==
X-Forwarded-Encrypted: i=1; AJvYcCXJkBdOAgPKbUwDCB0pnAdqN9yNjdZHC1Aa4VQZ5kbaHGjN9WB9pE402DbNARZVs/c6HJFV15IFN99IgrcTP9hGUGTM6yvN92UW
X-Gm-Message-State: AOJu0YxDNyC4l+Lk8N+bjVI3lDFXZfhyQax2dnM5eQBUOavL/3u0S8XU
	ALKtHQpLHI0IopJQ9cscUrFmR9KeZ20PokbkRlWqaHmyDgqmONncz968bOJbhg==
X-Google-Smtp-Source: AGHT+IGj70BMTAwUZnItGLi8iPn19bsqXw3Ldt4ssH8twPo7Bmy+ywevrCSgzuu99XajIMJ1jGyisQ==
X-Received: by 2002:a05:6a00:660c:b0:6e6:e587:3c39 with SMTP id he12-20020a056a00660c00b006e6e5873c39mr2881141pfb.24.1710480053526;
        Thu, 14 Mar 2024 22:20:53 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b006e6f0b4d950sm1510691pfb.4.2024.03.14.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:20:53 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:50:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: endpoint: pci-epf-test: Fix incorrect loop
 increment
Message-ID: <20240315052045.GA3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-2-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:53AM +0100, Niklas Cassel wrote:
> pci_epf_test_alloc_space() currently skips the BAR succeeding a 64-bit BAR
> if the 64-bit flag is set, before calling pci_epf_alloc_space().
> 
> However, pci_epf_alloc_space() will set the 64-bit flag if we request an
> allocation of 4 GB or larger, even if it wasn't set before the allocation.
> 

Max BAR size is 1MB currently, so I believe you are adding the check just for
the sake of correctness. If so, please mention it explicitly.

- Mani

> Thus, we need to check the flag also after pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index cd4ffb39dcdc..01ba088849cc 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -865,6 +865,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  			dev_err(dev, "Failed to allocate space for BAR%d\n",
>  				bar);
>  		epf_test->reg[bar] = base;
> +
> +		/*
> +		 * pci_epf_alloc_space() might have given us a 64-bit BAR,
> +		 * if we requested a size larger than 4 GB.
> +		 */
> +		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
>  	}
>  
>  	return 0;
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

