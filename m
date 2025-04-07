Return-Path: <linux-pci+bounces-25411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835FA7E52F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5DB16883F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C82036EB;
	Mon,  7 Apr 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZEvPhcAe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250D1E5B6E
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040587; cv=none; b=RCc1a/J8aHcpYLpIJFNcfyHFmEbBFZvc5etj6BD3c+3okTkJNzC8cJ3Frlr8lDEgkHsmT0fVfrJOtI2mishEsMr3Di74oId4ccwzPjbBm+rHpvoCoks5HqLxVfC0PW+UdSqT8ZHyAfgiIXNaw8Q9UqWBRTGPxwIPJmtv1ECtX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040587; c=relaxed/simple;
	bh=icEhyVJTzHXg7jgkZ1zmlJ9l7uEXbXUXe7dmfY43wT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XbKK+SxAOUIZV+q5A7e0HQoH1QodV4Sc/hpwKKeVcGuZ5Ml0JkrkC8gmGKuuqWAAA31VCwGaKPvosdSQhNuUhSjAfcifsbBr+2iHztapA+tTrCqV6g+lVn+XW2Y/x8TPfzIDdgsSxuLguF0Rkit4WL20auQATx/oOa7e2yZ0nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZEvPhcAe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39bf44be22fso3062214f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Apr 2025 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744040582; x=1744645382; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=;
        b=ZEvPhcAeF+3s9zScpS/aFZxoQOF5wYYe0MF4AYUscD+mwoWcoAt5f2w73VTB6fUrCC
         wGaOHxaGvIh8YTwoHv2AFBt0B2frQMje4cCh2BOj8YoB2SnWc9zeTwi38FGMJACeyr9L
         eFoCtJD7PYDd3RvlalyNLuQqeFwqGLTwK8K9ObV/UNVLTiI4D0WypretjJlwOQX1pG32
         4sgh40Z6sPeQ/EtQOuft/oZs8GW84LanBZhuul5Ncmq3LErgvZgK+mH67Unzo9iPluCW
         qiLwh/iRAJermdFO9UCg6SiYrDjAP62uUVv5kXnyDXQN6V/LMdmW6JzBcJdPBe3ElkRN
         o7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744040582; x=1744645382;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=;
        b=LrwnVGZO6SiFx/358+CcKwqzopQuPk14acUItZE2VoPOg6QBuVj13fQ+jz667KXN8N
         mAupaoYwf1qA0f+ajaUdWjWmfi+Q87kM3rL6c0eK5AIZt7HT/665fCUEMR2Z0VGPFn46
         XRO8I87ZmnoOQ9zOVpdUl8QBcrxfiEvAtM0PttbKMH5QM+igtbp6LZ8qecoxVhRO7vFn
         MPTBBMhL9Jwp0pLLApI89YzkzehQGIwCNyCnccdWUfELcHBPN4E93obGOMebHh+r7CVY
         cpA0o8LABA0ssrZYsyOO+QTdtlSzGytLBTaru+8aQb+4Syy3UScX7QVm29bIv8EB8l/M
         3Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCXuTZ7h4bqN/OgUo+3mJaYhPTJ0N58wD9CX25wSTyNc3UUMfAWBo9GsXpMctFNMZ7lhcxqqP5SEvQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rKFjPuJhNIUqmOp2En6WYa1cOAcspQ5Z/SBp7fdglbjSllDk
	w3yu5wRDw6wxb952ITPj0wqP53I4X6G+dMwbHG6cG6MNXKei0BF+RHQFyfZAXLzoW3yVfwZZ9cV
	G
X-Gm-Gg: ASbGncuXQWgjyQci/XUwqvrQwuVou4Mv23vwkwFDoVt2k7NQnwu5QuHTmMrD62dkJ3O
	74/KAkpJJscTDHRcl4MU/Q6DS8vOXJVJeUH++u2esLnXiM4oOBUtClo6a63kLQLhPzNl7zhDlfg
	DjO+6pfDYGyXKXVJ9RF+0IMGmckhGfcdGK0HFLfdkA/MAlGIQ/g6h6KZ1fQ9SvjbaqjaWfXIYZQ
	MmhJNmUb3PeI4E8xDqN0c2/59tUeiqlMzwnhMZjf8Op4Ij5mK6cNws0VF5CQHc+jQYmXj0zZ8d7
	ynUUFP9wfMN7ASUV613WVA+Pz5CKJu2rmP2TL4oV81jV90ZZbc+6HkI=
X-Google-Smtp-Source: AGHT+IEvLb0NTyDHj4c780QWtXn9xkplpLX5dvvjj3YvSoxW0R3QPk0BF940mrnTtyAAxjx1VydCvA==
X-Received: by 2002:a05:6000:2a5:b0:39a:ca04:3e4d with SMTP id ffacd0b85a97d-39d6fc00aabmr7580240f8f.7.1744040581642;
        Mon, 07 Apr 2025 08:43:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c301a0a90sm12335092f8f.21.2025.04.07.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:43:01 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Christoph
 Hellwig <hch@lst.de>,  Sagi Grimberg <sagi@grimberg.me>,  Chaitanya
 Kulkarni <kch@nvidia.com>,  Marek Vasut <marek.vasut+renesas@gmail.com>,
  Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev,
  linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
In-Reply-To: <Z_Pw3I2xO7BMSGWW@ryzen> (Niklas Cassel's message of "Mon, 7 Apr
	2025 17:35:56 +0200")
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
	<20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
	<Z_Pw3I2xO7BMSGWW@ryzen>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 07 Apr 2025 17:43:00 +0200
Message-ID: <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:

> Hello Jerome,
>
> On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
>> When trying to allocate space for an endpoint function on a BAR with a
>> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
>> size. This is expected by pci_epc_set_bar().
>> 
>> However, if the fixed_size is smaller that the alignment, the size saved
>> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
>> pci_epc_set_bar().
>> 
>> To solve this, continue to allocate space that match the iATU alignment
>> requirement but save the size that matches what is present in the BAR.
>> 
>> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>>  	struct device *dev;
>>  	struct pci_epf_bar *epf_bar;
>>  	struct pci_epc *epc;
>> +	size_t size;
>>  
>>  	if (!addr)
>>  		return;
>> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>>  		epf_bar = epf->sec_epc_bar;
>>  	}
>>  
>> +	size = epf_bar[bar].size;
>> +	if (epc_features->align)
>> +		size = ALIGN(size, epc_features->align);
>
> Personally, I think that you should just save the aligned_size / mem_size /
> backing_mem_size as a new struct member, as that avoids the risk that someone
> later modifies pci_epf_alloc_space() but forgets to update
> pci_epf_free_space() accordingly.

I tried but it looked a bit silly to store that when it was only a
matter of calling ALIGN() with parameters we already had, and it is
supposed to be only used in those two functions.

>
> But I will leave the decision to the PCI endpoint maintainers.
>

Ultimately, I do not have a strong opinion on this. Either way is fine
by me.

>
> Kind regards,
> Niklas
>
>
>> +
>>  	dev = epc->dev.parent;
>> -	dma_free_coherent(dev, epf_bar[bar].size, addr,
>> -			  epf_bar[bar].phys_addr);
>> +	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
>>  
>>  	epf_bar[bar].phys_addr = 0;
>>  	epf_bar[bar].addr = NULL;
>> @@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  			  enum pci_epc_interface_type type)
>>  {
>>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
>> -	size_t align = epc_features->align;
>> +	size_t aligned_size, align = epc_features->align;
>>  	struct pci_epf_bar *epf_bar;
>>  	dma_addr_t phys_addr;
>>  	struct pci_epc *epc;
>> @@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  			return NULL;
>>  		}
>>  		size = bar_fixed_size;
>> +	} else {
>> +		/* BAR size must be power of two */
>> +		size = roundup_pow_of_two(size);
>>  	}
>>  
>> -	if (align)
>> -		size = ALIGN(size, align);
>> -	else
>> -		size = roundup_pow_of_two(size);
>> +	/*
>> +	 * Allocate enough memory to accommodate the iATU alignment requirement.
>> +	 * In most cases, this will be the same as .size but it might be different
>> +	 * if, for example, the fixed size of a BAR is smaller than align
>> +	 */
>> +	aligned_size = align ? ALIGN(size, align) : size;
>>  
>>  	if (type == PRIMARY_INTERFACE) {
>>  		epc = epf->epc;
>> @@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  	}
>>  
>>  	dev = epc->dev.parent;
>> -	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
>> +	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
>>  	if (!space) {
>>  		dev_err(dev, "failed to allocate mem space\n");
>>  		return NULL;
>> 
>> -- 
>> 2.47.2
>> 

-- 
Jerome

