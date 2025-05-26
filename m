Return-Path: <linux-pci+bounces-28414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83885AC4300
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335233B070E
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6631C28E;
	Mon, 26 May 2025 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CERFncDI"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7023D2B5
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276818; cv=none; b=oDQ8DktyJDYeEMtpNDsvtl9+S0kP4TDZGDXIsvPder+4HlbB91DWkwHcUxMUALe2pGmz9EzX4lyeIlwPPfjEJlPlQWJvsWp98VMFG4+tMUwY82lD7A4PeWWDUQqow5fDv4MoOxecOX2HMd2VcevszgAFHKl+EpQtDqatC8yRnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276818; c=relaxed/simple;
	bh=dnZZsu478vWLbRNKoNOzt3rr317/eJYoIYuV1gAGaoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5sU6jblGVKW440S11F6mHG3DfuIbT8bS8BEywvzqiiUoLhyFSAh32lmwfu07JiJvepoaHmudn/ukqY20p/551D+4dXd8mYCKkPLxVaiwfJgztwV0go2NrEzRnUTxI1caorNmL/7bODrhdOh88YdGePDuMz9kVZM6kxW0Zg5ASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CERFncDI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YJId1Sdu07D+RP2YUj0hXICW6QboTLapD2HThscBWBo=;
	b=CERFncDIEN43wcHEmxXQP1Y9FJV1EA8Wf7DVI7a7Dh+Xy1RFkFqzI4Ix0Xtee3
	0lcXYe1KwKD3xB0o1SLqMJ2QEtl7g7idW2ZqhbbcN9aALF/spFmmjiEA6Re+kPWn
	tPvyPfXAxqv7RlwpyDHSivNfnIFO0sZJDoZJzKmjr+R4c=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB32txCljRoKyPhEA--.10427S2;
	Tue, 27 May 2025 00:26:43 +0800 (CST)
Message-ID: <2f6978b2-b103-4560-bc1f-e5b34cc77e89@163.com>
Date: Tue, 27 May 2025 00:26:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
To: Samiksha Garg <samikshagarg@google.com>, jingoohan1@gmail.com,
 manivannan.sadhasivam@linaro.org
Cc: ajayagarwal@google.com, maurora@google.com, linux-pci@vger.kernel.org,
 manugautam@google.com
References: <20250526104241.1676625-1-samikshagarg@google.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250526104241.1676625-1-samikshagarg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wB32txCljRoKyPhEA--.10427S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry5uFWUuFWkZFWftry3CFg_yoW8XryUpa
	4qyFWSyF48XrW7Zryaq3Z5uFy5tan7AryUG39Y9F17ZFZIyFnIgFWxWFya9ryxtr47tr1S
	kF1Utw13JFs8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UepBfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxxZo2g0f1UmWwABsj



On 2025/5/26 18:42, Samiksha Garg wrote:
> Hi Mani, Thanks for your response. I can see that pci-keystone driver 
> already calls this function. Does it not mean that there is already an 
> upstream user? Thanks, Samiksha On Mon, May 26, 2025 at 04:50:11PM 
> +0530, Manivannan Sadhasivam wrote:
>> On Mon, May 26, 2025 at 10:42:40AM +0000, Samiksha Garg wrote:
>>> Some vendor drivers need to write their own `msi_init` while
>>> still utilizing `dw_pcie_allocate_domains` method to allocate
>>> IRQ domains. Export the function for this purpose.
>>>
>> NAK. Symbols should have atleast one upstream user to be exported. We do not
>> export symbols for random vendor drivers, sorry.
>>
>> - Mani
>>
>>> Signed-off-by: Samiksha Garg<samikshagarg@google.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index ecc33f6789e3..5b949547f917 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -249,6 +249,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>>>   
>>>   	return 0;
>>>   }
>>> +EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
>>>   
>>>   static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>>>   {
>>> -- 
>>> 2.49.0.1151.ga128411c76-goog


