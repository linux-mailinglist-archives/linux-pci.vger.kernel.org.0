Return-Path: <linux-pci+bounces-20885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4454DA2C118
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DE7166C5B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844D1A76AE;
	Fri,  7 Feb 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jo+mV9y8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4718FDD5;
	Fri,  7 Feb 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925977; cv=none; b=DZDnGxFx5BGQrtwbQ37OKgopKOL3ymBXxkb7Ec5no78RUvQ3A1cU6sCWGcBSYhA/z92o5EmYxNzNgpkZFEKR/eQrzDlSbO8PPKldTRxjO2065zSyZg0VPyNIO6iPEswT/U/sMQW8e/Vly9/j4JLMYOz0CJmqAwW7FUbbfkU5A7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925977; c=relaxed/simple;
	bh=09GEDZOBjJebNIp9BxeX+G4r6l6zI1/5kwZj27WKTCE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BF7tl/n48ct5Jo7YCGaYw3PE8SG86jyN5I/HpSVIfuEDfgUU0luC5VRR5B5Y5zOT3IBiDV6R9+mII3g3undUBxQkQSXnEKGtSWTlrpoqNZJ77bBpZ7VTOoWbVIXi3s9r5hJOMBb+hu9AsZI96ldb7sNT4sMjzj3RcwlR8OQBd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jo+mV9y8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=+gT7krOuH2+RgpEMb8xy3/JNXgH+wrXNxHLDB4T4b+o=;
	b=jo+mV9y8F1LxRJOs/GpvpUI9smsOopaATolG8vi/wF2CbEqSdvO6eGBBaEXK5Z
	LfD9TdV4tbYzJY//hBVS12oyEWmVc5tYoj6+0nnZJJRRQ1M5sxePHZ3iRmmcudtr
	dFR+Wpzn5+P/AM1DojO+29nRtJvBedGxhkXCawEK016Q4=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v7Bu56VnFvRUKQ--.7416S2;
	Fri, 07 Feb 2025 18:58:55 +0800 (CST)
Message-ID: <acf18b4c-8ad5-48ea-9767-5383b138ca74@163.com>
Date: Fri, 7 Feb 2025 18:58:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fix sending message with data or without
 data
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250207103101.31287-1-18255117159@163.com>
Content-Language: en-US
In-Reply-To: <20250207103101.31287-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v7Bu56VnFvRUKQ--.7416S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1UCFyfJrWkJrWfCFWUCFg_yoW8uF1fpF
	W8Ga4Sy3WIqrWavan5Za1UAF13J3Z3tF9rX3yv934fuFnru34UGr129Fy5GFW7GrWkWr1x
	A3WDtF9rKF4fAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJ73kUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxnso2el4eZdYwAAs2



On 2025/2/7 18:31, Hans Zhang wrote:
> From: "hans.zhang" <hans.zhang@cixtech.com>

I'm so sorry, guys.
The correct email address should be: Hans Zhang <18255117159@163.com>

> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> Registers below:
> 
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> 
> Signed-off-by: hans.zhang <hans.zhang@cixtech.com>

The correct Signed-off should be: Hans Zhang <18255117159@163.com>

> ---
>   drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>   drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index e0cc4560dfde..0bf4cde34f51 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>   	spin_unlock_irqrestore(&ep->lock, flags);
>   
>   	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> -		 CDNS_PCIE_MSG_NO_DATA;
> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
>   	writel(0, ep->irq_cpu_addr + offset);
>   }
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..39ee9945c903 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
>   #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
>   #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
>   	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> +#define CDNS_PCIE_MSG_DATA			BIT(16)
>   
>   struct cdns_pcie;
>   


