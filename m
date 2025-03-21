Return-Path: <linux-pci+bounces-24356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559CA6BC70
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EA71894B78
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769415CD74;
	Fri, 21 Mar 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y5TwmUny"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2381487ED;
	Fri, 21 Mar 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565594; cv=none; b=WmtbjVxOigUKtXBAeZJJCRr6arH+CgvIazoWNKt810d9hmYC135sQmVx4noZKOz5758Pa76SOadUzQQELtTfC/JtG8shChgFuSRPUrb0xWzpT+/U1sZdv79G68P59dhmu4ZHtBnEF0D690SDMeaYKNEU2/oAf5AkH/4P4f3wn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565594; c=relaxed/simple;
	bh=1d7MPKtgDtutmtajslFXutq8UFITapsyjEYV4cWt2Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfxdRlfHJe++0pKC3KB80tVTjRRTJ3bltvkTejky0Qp5U8AftcX8JXwKPjtw6mW9aS5Z7QDgrcyThJ/THg654gthPe1nRghINGMSj8BzFStg+EXKkqzQ7SdQ/rBeYmuEs79Yqt48iEx6LZwdYvwE7qguK+LI8pu9NAOsQ1YVHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y5TwmUny; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=LqKAz5HyfCeDxh55YkqRrx/1k4efwgcFkhCql8auRck=;
	b=Y5TwmUnyhlIv+Lr1Ob0J/alrmMrCWyqEKpw/Ngids1lb/Blt+i7AsLXHcBck30
	KqMjVmcgGl+8RPzLoWa2BHvp6NB4DL/SUhnBT32vKvqejrQw3Is6+a+u/quMB41h
	P06QZ7z12StL94FKWqLHiBQccoqv/kL13bgNLC3/bhIPI=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXK5a4cN1n7W6dAw--.12854S2;
	Fri, 21 Mar 2025 21:59:20 +0800 (CST)
Message-ID: <1922e611-7a28-4198-8496-7e2a3e9c48ec@163.com>
Date: Fri, 21 Mar 2025 21:59:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 4/4] PCI: cadence: Use cdns_pcie_find_*capability to find
 capability offset instead of hardcore
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-5-18255117159@163.com>
 <20250321131806.34xeuaw2itl6gilj@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250321131806.34xeuaw2itl6gilj@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXK5a4cN1n7W6dAw--.12854S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW3ZFyDGF1UAFW8Ww1rJFb_yoW3GFg_Aw
	s2qFZ29FWUKFn29a1ak345ArWfZw4jqF1jqr18J347Z34fZr4fArnrXr40yF1UJa15Jry5
	Wry5XF45G3s09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU16pBDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhUXo2fdbTxl7wAAs6



On 2025/3/21 21:18, Manivannan Sadhasivam wrote:
> On Fri, Mar 21, 2025 at 06:17:10PM +0800, Hans Zhang wrote:
>> The offset address of capability or extended capability designed by
>> different SOC design companies may not be the same. Therefore, a flexible
>> public API is required to find the offset address of a capability or
>> extended capability in the configuration space.
>>
> 
> The PCIe capability/extended capability offsets are not guaranteed to be
> the same across all SoCs integrating the Cadence PCIe IP. Hence, use the
> cdns_pcie_find_{ext}_capability() APIs for finding them.
> 
> This avoids hardcoding the offsets in the driver.
> 

Hi Mani,

Thank you very much for your advice. Will change.

Best regards,
Hans

> - Mani
> 


