Return-Path: <linux-pci+bounces-24285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BF4A6B2A6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34FF8A5272
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92C1BBBFD;
	Fri, 21 Mar 2025 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xdx09bTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD318B46E;
	Fri, 21 Mar 2025 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742520348; cv=none; b=i1a/tRtejf3VX7hklJBxdruUqLQ5+J0X+o3hFx9iKBePWV6RV+xuSRbEuNCf9HNZFmpdlbpIksY+u2f4FHIJOF6oJM/4X05SJ1lvsG03GD3SHB2dw7yhitX5dWxKivqreSNcp+4S146THIw0y7YjE7NlT96uAhZcyDpBQsw9i3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742520348; c=relaxed/simple;
	bh=6hgxpbkpbDkO08ThuWTkTEfQW6T6S+pBE+Yj1FcHSyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MziRi7MQh4mYc36evbNdc0y8YIpxCM/abc5LloRxi1Qg7myiyHYrX2ynTUW7k+UzWNFgkOE99IkIdvZ8cIdS9n5CNMmJccKCDtPlQcepGHQUnS6sIjL1A+q+Nk8C9TzrTHq/x1z3Jei/j1m7pO1jYvkmFEDvDzLV4fEwMIbUqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xdx09bTZ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=uifaMK3p4YAnBcl9nmuoOP+YgcB1Z+c6e7VzG3GyQBU=;
	b=Xdx09bTZU0+ogotAFgMkAWY+Q6kdmizf+mBT3DkHwCEm+0ia9CM576pVxDjEx5
	3gxaDXai82xiJJjMofUPyzIAqDP1A19neDjdAR9sAnWDM6Xt/7w7CorAfZ+QJ7s0
	TxL+tFDJhyqGj6AKRiuq++v9aXzq40SSk9Wt46FkkdCiU=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXNyZPvNxn7kA7Aw--.59013S2;
	Fri, 21 Mar 2025 09:09:37 +0800 (CST)
Message-ID: <0abc7fc9-3370-4f54-a230-ecc044928fcc@163.com>
Date: Fri, 21 Mar 2025 09:09:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250320212853.GA1100504@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250320212853.GA1100504@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXNyZPvNxn7kA7Aw--.59013S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1rtryxGFW8Gw47uF18uFg_yoW8uF4xpr
	WUXa45KF48JF1fCFn7Ka10qF1fK397XF97Xan8G3yUZws09r93KFWvy34YkasrXr13ZF4j
	vF45Xas7X34YvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgAwsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwoXo2fctcL2XAAAsD



On 2025/3/21 05:28, Bjorn Helgaas wrote:
> On Sat, Mar 15, 2025 at 08:06:52AM +0800, Hans Zhang wrote:
>> On 2025/3/15 04:31, Bjorn Helgaas wrote:
>>> On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
>>>> ...
>>>
>>>> Even though this patch is mostly for an out of tree controller
>>>> driver which is not going to be upstreamed, the patch itself is
>>>> serving some purpose. I really like to avoid the hardcoded offsets
>>>> wherever possible. So I'm in favor of this patch.
>>>>
>>>> However, these newly introduced functions are a duplicated version
>>>> of DWC functions. So we will end up with duplicated functions in
>>>> multiple places. I'd like them to be moved (both this and DWC) to
>>>> drivers/pci/pci.c if possible. The generic function
>>>> *_find_capability() can accept the controller specific readl/ readw
>>>> APIs and the controller specific private data.
>>>
>>> I agree, it would be really nice to share this code.
>>>
>>> It looks a little messy to deal with passing around pointers to
>>> controller read ops, and we'll still end up with a lot of duplicated
>>> code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
>>> etc.
>>>
>>> Maybe someday we'll make a generic way to access non-PCI "config"
>>> space like this host controller space and PCIe RCRBs.
>>>
>>> Or if you add interfaces that accept read/write ops, maybe the
>>> existing pci_find_capability() etc could be refactored on top of them
>>> by passing in pci_bus_read_config_word() as the accessor.
>>
>> I have already replied to an email, please help review whether it is
>> appropriate.
> 
> URL to the email on lore.kernel.org?
> 
> If you mean this:
> https://lore.kernel.org/r/3cadf8d5-c4d8-4941-ae2e-8b00ceb83a8f@163.com,
> just post it as a v3 patch with the usual commit log and motivation
> for the change, and it will automatically get picked up in patchwork
> so it doesn't get forgotten.
> 
> Right now the urgency seems fairly low since (IIUC) it doesn't fix an
> existing bug in the upstream code.

Hi Bjorn,

Thanks your for reply. I will submit v3 patch.

Best regards,
Hans


