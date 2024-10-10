Return-Path: <linux-pci+bounces-14154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0E997EAF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15FC280E5B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB31BBBFD;
	Thu, 10 Oct 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfmByN0v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427B1A08BC
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543770; cv=none; b=n92hGbXAfbD7zuDjpnbHUyN34JauKHVodkpq8Jg2WchdYrzXfGpY31gga8TRqIjQC/mBgmQqv4jjpiUg5o5j6Fdy20tK00ZLLDRELKUmM3WOnX2zSSF8dcHT5rlIhZD8/BAOuxqi2HFWkZfygn51oJRu/9fT6DudLew+YQMkS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543770; c=relaxed/simple;
	bh=5jwclqPu8O+bJfJLb8ugVc+m8lCQmIuz/y18oWorWWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO4bFH7HNo0ImYlhESx7fqxOud7pZ7chL2W9i2oDs4mMX9vfDNS64B2uD8KuWyZ7Nuo4vuuD0kWDgEoO4l2ANTsN3KxASOvGBmPaRIVxDhYOjdpw2kyblOZ21GvEZiHeyM7RZH4AKkUGV2bQSYZVblQNP9LsRoVis8IaWM6MwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfmByN0v; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71df67c67fcso461823b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728543768; x=1729148568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ofdLwK0e1Hu9/kT0oZI4oEAcowiTCCVHzyg8IA1AEgg=;
        b=pfmByN0v9f6T9ekEJ+Pfa2ZktdP33qNqp29eHCV4nGA7j1KY/8QDOkHtJoN+HhtjYW
         IXbyFddaJ6o/utQR7ciwiKHlIq0npIgodbsQVxPfLUa/ADEszG/mksTqwoMEfKxKDJMu
         MxwzpFuesp1BEkXRnWm/I7kBIR0dRxNDvSEoyIEA0sg/fJV+aL+lpzRipO1erDKkPBSP
         iLa7iww1DrfQBpY6+0GD0MOhhd2m5S8s89C3zXW0j0dzfvQxtcEn39iGKTFc+7ja381W
         2PS/DcMJrLQ8cRWImIswhdvEvWwMRdSuq3rRWcu6iXCHmpHM6D1NyIWaPaDh7RfEhY2A
         HaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728543768; x=1729148568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofdLwK0e1Hu9/kT0oZI4oEAcowiTCCVHzyg8IA1AEgg=;
        b=IYiLQVOaeTb+IQ5+0UbpOEc2BcF0TkUNjLtFOhoavVGxlSWVcHAdgfyejgfHHqSKfu
         3BSXXN1ik8ud4MTUkr70yo1YDC+9dSfuO03WF6SUbBIxfTBMVyiumCrBaMEzvlXTg5I0
         Bia9Ra2fRWrJEq0L4njll7Y23Ptzs2DHLbNSO2MLikXwnXfWaroDAkklrAgLjDzgSjWt
         YE14yjQBWSYPd3N5QTSoEHJXQWzb2UmG09E9MOgstu/MX+QTmOPxF1SEnlyMAzF+uFdh
         2VYLiCkqFGBdjzo7yYA1HRHF62GBA1aVkVJGWlB7hhI9DByzceUxLn3qt/4iXm5s0TgB
         daqw==
X-Forwarded-Encrypted: i=1; AJvYcCUfKFZnMSjaRF4OpHDkiZh58NjON+0IaDvfOM5JxVlEZ209CYBvqFd/CSjWH3xhtFZSg+caZOJtjuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBksLYpuR2qj94JA02Hq8HMzraPIeAKgR9ZemgycYnP91WSYwf
	VIbA4kluQvU8FGSxbfyiDxdGx3rUL67Cyqww06zlWcg1NPlSBlj/nt7dwQQsnA==
X-Google-Smtp-Source: AGHT+IGrFANFlLTmXxVWE2c2rxdYcnB/6DqzwfWYMOWliLnPwjikVFZe+VCkCjaG/hnETvmtC6uc9g==
X-Received: by 2002:a05:6a21:8ccc:b0:1cf:38cf:df92 with SMTP id adf61e73a8af0-1d8a3c1e1cemr9627803637.30.1728543767753;
        Thu, 10 Oct 2024 00:02:47 -0700 (PDT)
Received: from thinkpad ([220.158.156.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9ea2b2sm456025b3a.3.2024.10.10.00.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:02:47 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:32:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 01/12] PCI: rockchip-ep: Fix address translation unit
 programming
Message-ID: <20241010070242.3i2f53kpdpr4fgl6@thinkpad>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007041218.157516-2-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:07PM +0900, Damien Le Moal wrote:
> The rockchip PCIe endpoint controller handles PCIe transfers addresses
> by masking the lower bits of the programmed PCI address and using the
> same number of lower bits masked from the CPU address space used for the
> mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
> the number of bits masked is the number of address bits changing in the
> address range [pci_addr..pci_addr + size - 1].
> 
> However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
> using the size of the mapping, resulting in an incorrect number of mask
> bits depending on the value of the PCI address to map.
> 
> Fix this by introducing the helper function
> rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
> mask bits to use to program the address translation unit. The number of
> mask bits iscalculated depending on both the PCI address and size of the
> mapping, and clamped between 8 and 20 using the macros
> ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS.
> 

How did you end up with these clamping values? Are the values (at least MAX
applicable to all SoCs)?

Btw, it would be helpful if you referenced the TRM and the section that
describes the outbound mapping. I'm able to find the reference:

Rockchip RK3399 TRM V1.3 Part2, Section 17.5.5.1.1

- Mani

> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 15 +++++++++++----
>  drivers/pci/controller/pcie-rockchip.h    |  4 ++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 136274533656..27a7febb74e0 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -63,16 +63,23 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
>  			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
>  }
>  
> +static int rockchip_pcie_ep_ob_atu_num_bits(struct rockchip_pcie *rockchip,
> +					    u64 pci_addr, size_t size)
> +{
> +	int num_pass_bits = fls64(pci_addr ^ (pci_addr + size - 1));
> +
> +	return clamp(num_pass_bits, ROCKCHIP_PCIE_AT_MIN_NUM_BITS,
> +		     ROCKCHIP_PCIE_AT_MAX_NUM_BITS);
> +}
> +
>  static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
>  					 u32 r, u64 cpu_addr, u64 pci_addr,
>  					 size_t size)
>  {
> -	int num_pass_bits = fls64(size - 1);
> +	int num_pass_bits =
> +		rockchip_pcie_ep_ob_atu_num_bits(rockchip, pci_addr, size);
>  	u32 addr0, addr1, desc0;
>  
> -	if (num_pass_bits < 8)
> -		num_pass_bits = 8;
> -
>  	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
>  		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
>  	addr1 = upper_32_bits(pci_addr);
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 6111de35f84c..15ee949f2485 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -245,6 +245,10 @@
>  	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
>  #define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
>  	(PCIE_EP_PF_CONFIG_REGS_BASE + 0x10000 + (((fn) << 12) & GENMASK(19, 12)))
> +
> +#define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
> +#define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
> +
>  #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
>  	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
>  #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

