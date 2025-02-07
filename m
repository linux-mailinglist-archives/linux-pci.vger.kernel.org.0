Return-Path: <linux-pci+bounces-20886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ABA2C11D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401CA188D044
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8811A2645;
	Fri,  7 Feb 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nyIMq1L0"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C91A0BE1;
	Fri,  7 Feb 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926034; cv=none; b=uAoGYqGFxNZHE+Uzz4FWyeSX6pudMFjDbwTWHnGliHT0Qyt6EAS3cUQdLsI+NQVKGIwhrdv1B2SHmGO4eHRB0x8I8/hf0YxNOhchghntB2FWe/hrk6v2N5G9HuTUvqY804UxvRHFUwQ0q8ObNkBXaetdhWoHEX4W5/CSJzwaKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926034; c=relaxed/simple;
	bh=L8vvMrHqXLuRIWhjPqJkNJ5PayyKWV2E94TOwWeQJqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7EixwqbD+QLMRvSu2AZ/73RZ6t09u2yiQSraColZehxVEtZiuk+jCLRPHPm3OubJkvMr01LoNZCV94zj/DAa/+/Wa7/DkMjrC7JNX5JHWCCv+aDh3kHujMwtf94czbqEz0WTTS5Go5ihhBLpYveeGRnPkbtZau1cOoSS4779rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nyIMq1L0; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Q+3SYsBr294PAVI7H7PNiNYZ1DD9Gyw0/GPNKUH8NjM=;
	b=nyIMq1L0m6GkNYYbb2gJ2XXV2rCnDfi3LzktELM9TmBCpCTtmd7cvFQNC558x9
	NY739kEhOPtlVtN7d3PgH5OwUrbY0CA2DO2U+1TqY0m0XYDTdKDVk9IjAPGvzyxJ
	dOxuCxDCOg1YF2TSn0WWRX33WY2ephZSpXQfXKgQbf/5I=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBXn0aV56VnXQ1VKQ--.4483S2;
	Fri, 07 Feb 2025 18:59:34 +0800 (CST)
Message-ID: <c1f39ecf-0c2d-4c04-9681-fc8ca5b41334@163.com>
Date: Fri, 7 Feb 2025 18:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Fix sending message with data or without data
To: lpieralisi@kernel.org
Cc: kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250207103757.31958-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250207103757.31958-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXn0aV56VnXQ1VKQ--.4483S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw43JryDKF1rJryUCFykZrb_yoW8Zw15pF
	y8Ga4Sy3WIqrWavan5Za1UZF13J3ZxtF97Ww4v934fuFnru34UGF12kFy5GFW5GrWkXr17
	A3WDtF9rKFs3AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpnmiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx7so2el4eZgNAAAsb



On 2025/2/7 18:37, Hans Zhang wrote:
> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> Registers below:
> 
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> 
> Signed-off-by: hans.zhang <hans.zhang@cixtech.com>

I'm so sorry, guys.
The correct Signed-off should be: Hans Zhang <18255117159@163.com>

> ---
> Changes since v1:
> - Change email number
> ---
>   drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>   drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
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
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b


