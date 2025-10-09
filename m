Return-Path: <linux-pci+bounces-37768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECDDBC9D92
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 17:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27F73A464A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32521B9C0;
	Thu,  9 Oct 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ILY2B3C7"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0F21ABC1;
	Thu,  9 Oct 2025 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024869; cv=none; b=S+RhSZXIT8LPhIi0CEsJnZUXuQh9iCOcsSuJ5QxB6OX1/A6thrNYlsr1FXzs1qA0aWP+EMulLyuySrwibOReKF8A7JjEitSqqZ99o7Aj9finDWpv5O/PINpk2B8VETuoNdWq+H7SfxxEO9ODf9FjaQcu+06yQ3wqCJ6VlhOBIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024869; c=relaxed/simple;
	bh=oD2yGOAOIsWuOKYqIVdN60o8NIuQOmas2HY6/unTn0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKpW2lJ3hOotdab2xWznk2HZYtJ8G/VqIRyVarambxhsUoaVS9KM+ai/tU3U2zm8n+gbDP5gx1G1uNNoOOojKOuf0t+1ZfLeouWaXzhmjx8pPy5r5deDaDm47kzyQGO/oK4lhjfVYmIeftlhU/R6K6QO+XO2NVkwDCwnwmvWRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ILY2B3C7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=PMxA8swDCe6T3oUEni2WosZmiK984oa3wqohv6h9KBM=;
	b=ILY2B3C7SoA2MBvONGC++ptQVWNf0LK3V/wW0RILvBAn+qtTT9GMZWtaJ/6GCh
	HRgC6pjymwy6U2UtfKwkmyF4XSX7n3R3GtqaGU5P/jKDAdmPRg0w1/9017En68cJ
	y0TI8s9ydwVZ9QZSttnC0v5oySTWDdQ6zowOGE0nWuayY=
Received: from [IPV6:240e:b8f:927e:1000:2cf9:d1b6:c3dd:cffe] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3dxb02Odo9CfDBg--.26554S2;
	Thu, 09 Oct 2025 23:47:02 +0800 (CST)
Message-ID: <c0d37604-edf7-4b9b-a3b2-9c5402ed579d@163.com>
Date: Thu, 9 Oct 2025 23:47:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 6/6] PCI: cadence: Use cdns_pcie_find_*capability() to
 avoid hardcoding offsets
To: Sasha Levin <sashal@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 helgaas@kernel.org, jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
 ilpo.jarvinen@linux.intel.com, schnelle@linux.ibm.com, gbayer@linux.ibm.com,
 lukas@wunner.de, arnd@kernel.org, geert@linux-m68k.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813144529.303548-1-18255117159@163.com>
 <20250813144529.303548-7-18255117159@163.com> <aOfMk9BW8BH2P30V@laps>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aOfMk9BW8BH2P30V@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3dxb02Odo9CfDBg--.26554S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrXw4xZr1rZF13ZFyxJF4ktFb_yoWxWFgEq3
	yIy397Cw4DXFs5Can8Ar13JayDA3yaqFsF9F4fAry3X3Z5Gr18AFW3C3Z7JF97GayFgF15
	Wwn0kayYyas8tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU1SotUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDw7ho2jny74X6gABsF



On 2025/10/9 22:54, Sasha Levin wrote:
> On Wed, Aug 13, 2025 at 10:45:29PM +0800, Hans Zhang wrote:
>> @@ -249,9 +252,10 @@ static int cdns_pcie_ep_get_msi(struct pci_epc 
>> *epc, u8 fn, u8 vfn)
>> {
>>     struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>     struct cdns_pcie *pcie = &ep->pcie;
>> -    u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>>     u16 flags, mme;
>> +    u8 cap;
>>
>> +    cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
> 
> We should be passing PCI_CAP_ID_MSI, not PCI_CAP_ID_MSIX here, right?
> 

Hi Sasha,

Yes, thank you very much for pointing it out. Sorry, it's my fault. I 
will submit a patch to fix it.

Best regards,
Hans


