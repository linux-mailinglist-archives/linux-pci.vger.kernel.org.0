Return-Path: <linux-pci+bounces-27100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E464AA76CC
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2374A5744
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82125D21F;
	Fri,  2 May 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GOfa8Qgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCF25D1F8;
	Fri,  2 May 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202275; cv=none; b=hTFl65rHX1wNh3lZ6KAAxUx0xLjuwWVXBEqDDXqPrFRLlIgiRXByfxwP2+C275U1fNJZBL4tEfE8+k2cEaIKjYd23famRh4wk3WP/axqLBXpaPWY1VbFSsaPAPR+zaPowZNdQ/HzuBWNmuavXCc9kpUNktnWcdcs34nuBLvl0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202275; c=relaxed/simple;
	bh=DPug44X9dHryGwrzjaKdUAfjFQzgEW4o8Y6DNXDGvWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEzaw2dfVE1l/rtfx5yn3nXteFy5BTcx4rcjQZNddLZdTKE6fMQRQORffaE+M6JrtY2R5FWkG8M73P+Ux/ZNlba8eWh8hh7BzAS7shDnSKqfTka6hDNmY7/cFtU53eqrBJq2+MAWMEsB4qLabi6xuiiQc2jCNMg4XOxSVqCILk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GOfa8Qgn; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=8E3jSyTAqXG9hYae4q67c9mUvB58U8oFjHxwj1NgMfE=;
	b=GOfa8QgnA6p/P2afJUuIdU0JcM5ELU4Ulabyv5hhh2ET00b//T59Jxtbf/cjHg
	Lk2gtzk5vYkYn1voRfa+Wo5mS/bL84w9N3vvSqiZySFJnl/caqBJVwETjgQPvb37
	CjosNkveiIe7NBbwvjL7Z3PlEwklmvsSjQ2zQWqUfsUGs=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAHZCl57hRox3kxEA--.23916S2;
	Sat, 03 May 2025 00:10:34 +0800 (CST)
Message-ID: <d4adb108-5762-41d3-897f-217b8e7666e5@163.com>
Date: Sat, 3 May 2025 00:10:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Standardize link status check to return bool
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 jingoohan1@gmail.com, cassel@kernel.org, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250428171027.13237-1-18255117159@163.com>
 <7oxb4uviwnpnkdjacihwjrzqhxpd7nk244ivpwml5372jsiimm@5hgnnfjlfkr3>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <7oxb4uviwnpnkdjacihwjrzqhxpd7nk244ivpwml5372jsiimm@5hgnnfjlfkr3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHZCl57hRox3kxEA--.23916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry8Jw4rCFy5ZF47KFWrAFb_yoW8trW5pa
	45tayIyF18tF4Y9a1Yq3WDCw15tFn7Aa4DJ395u3W7XFy29FW7Xry3GFyftasxJFW5Xr13
	KF15t3W7JFsxJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3rchUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxZBo2gUgt812AACsh



On 2025/5/2 23:36, Manivannan Sadhasivam wrote:
> On Tue, Apr 29, 2025 at 01:10:24AM +0800, Hans Zhang wrote:
>> 1. PCI: dwc: Standardize link status check to return bool.
>> 2. PCI: mobiveil: Refactor link status check.
>> 3. PCI: cadence: Simplify j721e link status check.
>>
> 
> Thanks for the cleanup. Looks good to me except the redundancy conversion that
> Niklas noted. So with that change,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Dear Mani,

Thank you very much for your reply. I have sent version v2 to resolve 
Niklas' review opinions.

Best regards,
Hans

> - Mani
> 
>> Hans Zhang (3):
>>    PCI: dwc: Standardize link status check to return bool.
>>    PCI: mobiveil: Refactor link status check.
>>    PCI: cadence: Simplify j721e link status check.
>>
>>   drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
>>   drivers/pci/controller/dwc/pci-dra7xx.c                | 2 +-
>>   drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
>>   drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
>>   drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
>>   drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
>>   drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
>>   drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
>>   drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
>>   drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
>>   drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c              | 4 ++--
>>   drivers/pci/controller/dwc/pcie-qcom.c                 | 2 +-
>>   drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
>>   drivers/pci/controller/dwc/pcie-tegra194.c             | 2 +-
>>   drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
>>   drivers/pci/controller/dwc/pcie-visconti.c             | 2 +-
>>   drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
>>   drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
>>   21 files changed, 34 insertions(+), 53 deletions(-)
>>
>>
>> base-commit: 286ed198b899739862456f451eda884558526a9d
>> -- 
>> 2.25.1
>>
> 


