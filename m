Return-Path: <linux-pci+bounces-26985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72DFAA0589
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7BD7B394D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49142820B3;
	Tue, 29 Apr 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HTQfy4fe"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48422C322;
	Tue, 29 Apr 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914913; cv=none; b=CdOX7DjGbUdp8YLMV6QE7qmAn1jiNzXp50BbesUgrk2fwy6fVN3HVFVA/UA4vryEfU5qd1/PhpuFUexHqJy6he9sprNag6ZDSXlf+r17UPEo5IzZgWQQWZvc3RMvMnit31aIRejpReFyi0zT1i2DrXiyDw2P7RYBViZP+tE1JZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914913; c=relaxed/simple;
	bh=hfARJH+hb2C8pVvsDrTYbRabCTh7pbTKHY20yzTw0l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPaMea+irAQRqzeKIbn9XTI+WuYR7TGnjPm4ITbu8JdKakKnm2R1LK2DKfPY8Uu3mevVKjZwAZ+TgHsMItBc3HmwD1lhatqBVgMFcg2HJ0Aa4qpYxmQJqMahGGP8jkmRrCfwOGEj5+N7j7TrHFUeIUl/rTf/7FW4Dn1TZhGCL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HTQfy4fe; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=nuxH+Of8rRFTD2XqTg1Wf3quV0CTP4pYPBGmAXtMjxc=;
	b=HTQfy4feNPXIgLOXt9fV4rusLSYGDRcwhU7OtjOZL4mtuS4NFfFusN4anQZOvg
	18wv/E/NrnKcD3wEQfw76dI20VoApk1W1xYl/6c5jm2+HPhhGAFnOMIrDcJ6rDvA
	g1VhxmWyuV7YPZvhYPvw5PmL5mSyIv12V0Cq5w0AVuZu4=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3F5X+ixBoNdwxDQ--.6758S2;
	Tue, 29 Apr 2025 16:21:21 +0800 (CST)
Message-ID: <cce60805-55e5-4fb8-9f71-7afcc496c689@163.com>
Date: Tue, 29 Apr 2025 16:21:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: dwc: Standardize link status check to return
 bool
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250428171027.13237-1-18255117159@163.com>
 <20250428171027.13237-2-18255117159@163.com> <aBCIXPc24daPPIxY@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aBCIXPc24daPPIxY@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3F5X+ixBoNdwxDQ--.6758S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWfXr45ZF1DuFyDtr48Crg_yoW5ur1Dpa
	y5tFWIyF18tF45ua1Yv3Wrur1Yv3ZrAFyDG393u342vFy29ayUJFyrJFyfta4ftr4UWr13
	KF15ta47JFsxJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHOJ5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx4+o2gQh+qXPgAAsk



On 2025/4/29 16:05, Niklas Cassel wrote:
> Hello Hans,
> 
> On Tue, Apr 29, 2025 at 01:10:25AM +0800, Hans Zhang wrote:
>> Modify link_up functions across multiple DWC PCIe controllers to return
>> bool instead of int. Simplify conditional checks by directly returning
>> logical evaluations. This improves code clarity and aligns with PCIe
>> status semantics.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pci-dra7xx.c       | 2 +-
>>   drivers/pci/controller/dwc/pci-exynos.c       | 4 ++--
>>   drivers/pci/controller/dwc/pci-keystone.c     | 5 ++---
>>   drivers/pci/controller/dwc/pci-meson.c        | 6 +++---
>>   drivers/pci/controller/dwc/pcie-armada8k.c    | 6 +++---
>>   drivers/pci/controller/dwc/pcie-designware.c  | 2 +-
>>   drivers/pci/controller/dwc/pcie-designware.h  | 4 ++--
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>>   drivers/pci/controller/dwc/pcie-histb.c       | 9 +++------
>>   drivers/pci/controller/dwc/pcie-keembay.c     | 2 +-
>>   drivers/pci/controller/dwc/pcie-kirin.c       | 7 ++-----
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     | 4 ++--
>>   drivers/pci/controller/dwc/pcie-qcom.c        | 2 +-
>>   drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 2 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c   | 7 ++-----
>>   drivers/pci/controller/dwc/pcie-tegra194.c    | 2 +-
>>   drivers/pci/controller/dwc/pcie-uniphier.c    | 2 +-
>>   drivers/pci/controller/dwc/pcie-visconti.c    | 2 +-
>>   18 files changed, 30 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index 33d6bf460ffe..4ef25d14312b 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -118,7 +118,7 @@ static u64 dra7xx_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
>>   	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;
>>   }
>>   
>> -static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>> +static bool dra7xx_pcie_link_up(struct dw_pcie *pci)
>>   {
>>   	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>>   	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
>> index ace736b025b1..d4a25d376b11 100644
>> --- a/drivers/pci/controller/dwc/pci-exynos.c
>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
>> @@ -209,12 +209,12 @@ static struct pci_ops exynos_pci_ops = {
>>   	.write = exynos_pcie_wr_own_conf,
>>   };
>>   
>> -static int exynos_pcie_link_up(struct dw_pcie *pci)
>> +static bool exynos_pcie_link_up(struct dw_pcie *pci)
>>   {
>>   	struct exynos_pcie *ep = to_exynos_pcie(pci);
>>   	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
>>   
>> -	return (val & PCIE_ELBI_XMLH_LINKUP);
>> +	return !!(val & PCIE_ELBI_XMLH_LINKUP);
> 
> !! is not needed here, or in other places.
> 
> When assigning to the bool any non-zero value becomes 1.
> 
> !! is usually only needed when needing to store an explicit 1 or 0 in an int.
> 

Dear Niklas,

Thank you very much for your reply and reminder. The next version will 
be modified.

Best regards,
Hans



