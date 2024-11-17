Return-Path: <linux-pci+bounces-16999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFEC9D0263
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 09:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139EC284D34
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134629408;
	Sun, 17 Nov 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpk7Wy5Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66579F6;
	Sun, 17 Nov 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830654; cv=none; b=DIdzNi2dT1VJTAunSfBBG7mY6gRjHni7LDSsiwnu3SC1+OIFqa3JRf4VNy4dmhlPu0T0XLCVqKN8p7pJso+DQHte9no8gkXFTtgCSn24xoHWCLemm4NHDE+LmnKvSZ293cHEHzm5kwBHtQg4yrNVE/eHBay3TItV8oVO0Lu34AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830654; c=relaxed/simple;
	bh=shLcgrgwHbmGhcP3CmHV76UlkYB1nen1PjPkGhk7H3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do2ku5eKO/SkoVhm5fmxHlXhw7QR5IV7ifqtZP/BsVAtuy0Px8ikmgMihi1Rkt3pTSdepmmZjIAbdGH7uatI5CbhsdfKJBggxZl3LVSiPXMPYHMdjThIHV0y+wDMI26/uQJmBqyjMTKC4PZjFZEIvvL9KEoc1yE/8lOYBmiiF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpk7Wy5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB5EC4CECD;
	Sun, 17 Nov 2024 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731830653;
	bh=shLcgrgwHbmGhcP3CmHV76UlkYB1nen1PjPkGhk7H3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hpk7Wy5QkEdtVH/0w4is3I9D+vQtI9spbjCPoG1LjCuu2IuCt8STHHrmBsv6p3RXj
	 uCiWR6uyxr4hHFzV98sKGUXFR0wjcb6JNywHoIGauPCDkpw0YnDsiObHFc9vzjxTGn
	 JwwASbquOAa9P+90XqDmtWxWI+deP6X86ri9wkZQzY2UYVWxZ56ws3AFPpqZgOfGKs
	 Q1JMXBQoz5byez69v4plAppd86BX2Qxuix2h47WxL7qp8Og6+4OZ8XB/8UrJ1UuK8p
	 TES/XHC45iFKHk9BywsSFF9lTIZDLuQJAQOduXwgrP/YuILoYw1jbBUaUvjpr6fixP
	 +Mwa86V1pYY/g==
Message-ID: <8054f771-d4d6-4d8d-85b6-dd22050897c9@kernel.org>
Date: Sun, 17 Nov 2024 17:04:10 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] PCI: rockchip-ep: Fix address translation unit
 programming
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241115224145.GA2064331@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241115224145.GA2064331@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/24 07:41, Bjorn Helgaas wrote:
>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>> index 136274533656..27a7febb74e0 100644
>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>> @@ -63,16 +63,23 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
>>  			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
>>  }
>>  
>> +static int rockchip_pcie_ep_ob_atu_num_bits(struct rockchip_pcie *rockchip,
>> +					    u64 pci_addr, size_t size)
>> +{
>> +	int num_pass_bits = fls64(pci_addr ^ (pci_addr + size - 1));
>> +
>> +	return clamp(num_pass_bits, ROCKCHIP_PCIE_AT_MIN_NUM_BITS,
>> +		     ROCKCHIP_PCIE_AT_MAX_NUM_BITS);
>> +}
>> +
>>  static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
>>  					 u32 r, u64 cpu_addr, u64 pci_addr,
>>  					 size_t size)
>>  {
>> -	int num_pass_bits = fls64(size - 1);
>> +	int num_pass_bits =
>> +		rockchip_pcie_ep_ob_atu_num_bits(rockchip, pci_addr, size);
>>  	u32 addr0, addr1, desc0;
>>  
>> -	if (num_pass_bits < 8)
>> -		num_pass_bits = 8;
>> -
>>  	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
>>  		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
> 
> PCIE_CORE_OB_REGION_ADDR0_NUM_BITS is 0x3f and
> rockchip_pcie_ep_ob_atu_num_bits() returns something between 8 and
> 0x14, inclusive?  So masking with PCIE_CORE_OB_REGION_ADDR0_NUM_BITS
> doesn't do anything, does it?

Indeed, we could remove that mask.

> Also, "..._NUM_BITS" is kind of a weird name for a mask.

Well, I did not change that. It was like this. Can clean that up too. Do you
want me to send a patch ?

> rockchip_pcie_prog_ob_atu() in pcie-rockchip-host.c is similar but
> different; it looks like all callers supply num_pass_bits=19.  I
> assume it doesn't need a similar change?

I did not check the TRM for host mode. But for my tests, I used 2 rockpro64, one
as RC and the other as EP, and the RC side was working just fine without any
change. So I assume it is OK as-is.

-- 
Damien Le Moal
Western Digital Research

