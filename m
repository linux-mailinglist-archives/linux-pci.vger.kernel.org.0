Return-Path: <linux-pci+bounces-27269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68483AABECE
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E21C25969
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FB2798E2;
	Tue,  6 May 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H8vvkX2G"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F799264A73;
	Tue,  6 May 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522505; cv=none; b=enhsLX+Nkej7BL0QMR1GQWErUXowsoLemtgrMcWiKQmjB90FgnLMP0AiAg/Di+wb6Cu7gE8j06Iynh7TRyXbZVALFleDgccyOPgeG6CbJdFKPknzzDDdTaxSQjufeSO/Uip0GlgpEmspa9BD0UOcJKpkPWcCFXnaBZtts2QnpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522505; c=relaxed/simple;
	bh=S1K4Z5883u+owLpW7MmSrX1qkgnjja7k3b+3zeq+uPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYeb1rXy0izMjeTl7PJQ/7n8EWyN6C9hWZb0DuM56SDyB4y5ZDRP9fQ8K8TLBa/YZ2AP0iURGB3uWi97boe35y8euPnyAz5TIRHSjYNOSaUZDd570J9n5G7rRbHKSrwBdgNdJ3VtzyVwXigUA0Bf0O/JWIPXxDJ/mH/9lI4dTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H8vvkX2G; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZN2hIZjStH5WIJVQEoZIXJHxRyKeJAZXECGdhzrLzMw=;
	b=H8vvkX2Gg33L3BwiGqWigsO24QiUA6cs5eD/HdifQz/2AzjCp38QvogdPsJDYz
	vbQGAjwVoLx+g88uWgzxrATGQc9eQkc0tXrYXHS2XW46M8yD9EigiIhf2PWMSBjD
	+IxzCqGWNEJ4aJiIJOl30KTbW0msZV89LMHwSSB1JqQDk=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnPyVN0RloeqVnEw--.51589S2;
	Tue, 06 May 2025 17:07:30 +0800 (CST)
Message-ID: <08073fba-b46f-45f1-9859-04c5ffa65994@163.com>
Date: Tue, 6 May 2025 17:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] PCI: qcom: Replace PERST sleep time with proper
 macro
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Laszlo Fiat <laszlo.fiat@proton.me>,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250506073934.433176-6-cassel@kernel.org>
 <20250506073934.433176-10-cassel@kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250506073934.433176-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnPyVN0RloeqVnEw--.51589S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1rWw4kAw45XrW8Gw4Durg_yoWDWFbE9r
	Z5WrWxurs8GryS9r12ka1fZr9aya47Xrn7CayFvF17AasxJr1UXrykZrZ8Xa98WF43JFZ5
	t3s0vF4rCFyxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjldgtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw9Fo2gZz-g0TAAAsY



On 2025/5/6 15:39, Niklas Cassel wrote:
> Replace the PERST sleep time with the proper macro (PCIE_T_PVPERL_MS).
> No functional change.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 01a60d1f372a..fa689e29145f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -289,7 +289,7 @@ static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>   static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>   {
>   	/* Ensure that PERST has been asserted for at least 100 ms */
> -	msleep(100);
> +	msleep(PCIE_T_PVPERL_MS);
>   	gpiod_set_value_cansleep(pcie->reset, 0);
>   	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>   }


Reviewed-by: Hans Zhang <18255117159@163.com>

Best regards,
Hans


