Return-Path: <linux-pci+bounces-3831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033E85E118
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 16:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C47285DDA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6967FBC3;
	Wed, 21 Feb 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTr+ZjQq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77367F7FD
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529342; cv=none; b=XVmWXGI0fLmibjW+EtCGuDHQ32d0wDZxp3WeZ//gyXLN4IhK1lB8Wc1lrLGPPcp04jcl/WcOT5XQinO70of6Pa3YsaDzVr1CXdHc9mRVTKGEfPw7AYioiyfecFhwPoTUNJdEQi5knsZH9DDmdre5rWNLqmVwwJLauNWX+RzaGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529342; c=relaxed/simple;
	bh=7lc3/qNnC7r1ZaTxVwxtEXiP8tM431u7YzOgbKbiR9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVRvrDzxlqvwGAlwqfhSmrVaMfYQwy0ZG75K8l5InFKW/wyjN3xQ0LVNDnuHcc9rWtsI4JHe9qnHqTZsdNYVKdPC0y0Uvz2GOKjO05+oU3FPctmV/0Z5LYmYZE8jS13MZDHjVeMKCmahLVxNS1FgRJSkqp2Q+inkDAM9v3phD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTr+ZjQq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so2420241b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708529340; x=1709134140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiQPIBOu4Gs/I308UF7B7RX18pmBLVdtstHOqkEYGys=;
        b=kTr+ZjQq83To8XHG2b61xhu0R8Wl77wxJRn2eQBS2AU4dZh7RWCEEjKbIBid36E5Vv
         CzsBIk04Yy4DQLcWSMVET+f/3BXnC4n1cV5CDCqurXYBuTYpoVNNTlpSg/q9jixZiTZC
         ZuSsAWvBIs9P2wMcQ0BlHvWslg0h6lcXPUWlA/eHyJlEglgQSYeTjfIHjWYAh13GrOXV
         Ewtiw3xZxraKP8Xc0+vZV6F1/oeIy4W2mSh3JmZPQcXYiyXcdfyA17qMGWm8EXnvjZ/W
         ANz3SZyYLwAVN5+Qx6crtXZpQ5DCxj0Oshn964ODAODdShKVn7ISwvUoXDmhdSsH9+qW
         HtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529340; x=1709134140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiQPIBOu4Gs/I308UF7B7RX18pmBLVdtstHOqkEYGys=;
        b=Xn/59FjJL1i2yctivsypVQSgWQ75kil7cqW2lddGjbdF5XYVLZEtyObd5406xPPt+L
         Vjg78AmZ1c+maC2X1tJXHZh4EdV9ALC0kJGZQ5e7k/0nLChgdEhcdxOtMqbj6yDeuBcY
         nR+4wYbAFp2J7PtnZT93ZVvTKA/bO2+olg5VKGP+aCtlnZsKcYYXNaFIDMj1oULu3zyT
         7quSova3TGU2wwz1n+zcHvCLCZZ6Ln5DfXvTzYhZ0VnfwQFE4+M+J526svKj47EY43r9
         QdHt2hSu7C89oMa5/lbAS2crOyjVkS8b6Pb3sgS4R7gopnUkMEHGqqKRu2FS92GT+J5V
         WFVw==
X-Forwarded-Encrypted: i=1; AJvYcCWBfFa9RmdfJVRbLlYIXpABd9T/X0JZ4IAUR83ibca73yWhyIYOzDi9S/7ynw6s7HuJuGWj8KodmQv9fvyoq3H6mBpx03c7nuga
X-Gm-Message-State: AOJu0Yxdoec/lbX6g8ytuEG8umw2YHszawyV4Pd+MUEtyqSQiCWVHjL5
	UFWbB+KCYtSjwrh6o4s3UynEDZUkp4XWgH9GZXjkcjBp4EVTU9YrIBQVTm1OUg==
X-Google-Smtp-Source: AGHT+IHvnng52SZ6b21T2opuLYZFMcT878NhB59bam9D4zlsLtJ54qrFXZ5mtV6dd+to4BUH+RsWKw==
X-Received: by 2002:a05:6a21:3405:b0:19f:c0d3:42c3 with SMTP id yn5-20020a056a21340500b0019fc0d342c3mr22440084pzb.4.1708529339757;
        Wed, 21 Feb 2024 07:28:59 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id z16-20020aa791d0000000b006e141794208sm9051548pfa.165.2024.02.21.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:28:59 -0800 (PST)
Date: Wed, 21 Feb 2024 20:58:51 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZdYWs3aGSfzVQp4B@google.com>
References: <20240221064846.3798047-1-ajayagarwal@google.com>
 <aje3eeeey7v4jafcad6beeee4xxev6pbnsdqbpv3f4fmn2zi4k@7qv6vvngxs53>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aje3eeeey7v4jafcad6beeee4xxev6pbnsdqbpv3f4fmn2zi4k@7qv6vvngxs53>

On Wed, Feb 21, 2024 at 03:52:43PM +0300, Serge Semin wrote:
> On Wed, Feb 21, 2024 at 12:18:46PM +0530, Ajay Agarwal wrote:
> > There can be platforms that do not use/have 32-bit DMA addresses.
> > The current implementation of 32-bit IOVA allocation can fail for
> > such platforms, eventually leading to the probe failure.
> > 
> > Try to allocate a 32-bit msi_data. If this allocation fails,
> > attempt a 64-bit address allocation. Please note that if the
> > 64-bit MSI address is allocated, then the EPs supporting 32-bit
> > MSI address only will not work.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v4:
> >  - Remove the 'DW_PCIE_CAP_MSI_DATA_SET' flag
> >  - Refactor the comments and msi_data allocation logic
> > 
> > Changelog since v3:
> >  - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
> >  - Refactor the comments and print statements
> > 
> > Changelog since v2:
> >  - If the vendor driver has setup the msi_data, use the same
> > 
> > Changelog since v1:
> >  - Use reserved memory, if it exists, to setup the MSI data
> >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > 
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index d5fc31f8345f..9c905e5c4904 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -379,15 +379,22 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	 * memory.
> >  	 */
> >  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > -	if (ret)
> > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> 
> > +	if (!ret)
> > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +						GFP_KERNEL);
> 
> msi_vaddr will be left uninitialized if the mask setting fails. Robin
> had it initialized in v2 discussion:
> https://lore.kernel.org/linux-pci/7cd42851-37cc-49d6-b9ad-74a256a73904@arm.com/
> 
ACK. Will initialize to NULL in the next version.

> 
> >  
> > -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > -					GFP_KERNEL);
> >  	if (!msi_vaddr) {
> > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > -		dw_pcie_free_msi(pp);
> > -		return -ENOMEM;
> 
> > +		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");
> 
> Can we short it up already? I suggested something like "Failed to
> allocate 32-bit MSI target address" in v2. It means the problem with
> 32-bit MSIs which can be perceived as the possible reason of the
> respective peripheral devices not working correctly.
>
ACK. Will shorten the message in the next version.

> > +		ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > +		if (!ret)
> 
> Redundant check. It was discussed some time ago. See the comment from
> Robin:
> https://lore.kernel.org/linux-pci/335d730d-529e-7ce0-8bac-008a4daa6e3c@arm.com/
> 
ACK. Will remove the check in the next version.

> -Serge(y)
> 
> > +			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +							GFP_KERNEL);
> > +
> > +		if (!msi_vaddr) {
> > +			dev_err(dev, "Failed to configure MSI address\n");
> > +			dw_pcie_free_msi(pp);
> > +			return -ENOMEM;
> > +		}
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.44.0.rc0.258.g7320e95886-goog
> > 

