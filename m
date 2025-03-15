Return-Path: <linux-pci+bounces-23804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F5A62307
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 01:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66BF19C733D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C922E3388;
	Sat, 15 Mar 2025 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fUEXWE0Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3756AA7;
	Sat, 15 Mar 2025 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741998165; cv=none; b=YBb9OzTpVgsgzPwZ+62Vv7e++yRfaVrBBj4kpPahoXXAzk9uyX1ysA3EhDoYtnmKtvpi8JGSTC46BoOe60XvzCaYwy5ZIkFrAQr+isPX7zKrdg7e+6Y/ZKK6abyeg2C7ct8vdu2ciZn82OYPseziSHp+oqiDNi90MwadHJX3cqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741998165; c=relaxed/simple;
	bh=u8l3PPVo1Iiwb1ppHvpxF+S0AOUWGysoAo1JGL6uZZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqY7/BxdsaaxfCtgZjfZdVpZa4Bsg9Uv2eQMYLjhfd33FtZFKYbg7fEJYgMlUJRvs3RKg+YQB8moPptSzpKpZTUS/vSyGB+D4Ns+NFiYFErPLFQo6uv7UB4iqTH8JhUCXYhOqKyKSB572gepZbwWctcpN0nZIuqzYOgP0HO5qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fUEXWE0Z; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=109cFpcIHKvu71FujjmyGI5jYN6yUHpbo8pR6s+BNkA=;
	b=fUEXWE0Z09WGc3M4wIMUbUjVKHU3sXa5Bon5RARqBp8quXhrJclZdTDB6Q2u3F
	GA65sPiqd5eSghFK8+VIItlm1EB3Q8MQ2L5y72iCcvI7G7YHwf83TkVibukw2YF6
	/u02GfCuD/BMf3H8OSowNMCX3PyuzB7B4nVMo1obPx+XU=
Received: from [192.168.71.45] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3VwCcxNRnRjVaLA--.1942S2;
	Sat, 15 Mar 2025 08:06:53 +0800 (CST)
Message-ID: <88a44822-9b1a-4d59-a4ce-926d12f73147@163.com>
Date: Sat, 15 Mar 2025 08:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250314203157.GA793598@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250314203157.GA793598@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgD3VwCcxNRnRjVaLA--.1942S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryUuFW8Wr4UZF1xGFW3Wrg_yoW8Xry8pr
	W2qry3tF48JF43CFn7tay8tFySgwsrXasrtan5CrWDZws8W3saqFWvy345tFZrJr1rZr4Y
	vFWUWa4kJ3s0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9vtZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxQRo2fUwmM+BQAAsU



On 2025/3/15 04:31, Bjorn Helgaas wrote:
> On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
>> ...
> 
>> Even though this patch is mostly for an out of tree controller
>> driver which is not going to be upstreamed, the patch itself is
>> serving some purpose. I really like to avoid the hardcoded offsets
>> wherever possible. So I'm in favor of this patch.
>>
>> However, these newly introduced functions are a duplicated version
>> of DWC functions. So we will end up with duplicated functions in
>> multiple places. I'd like them to be moved (both this and DWC) to
>> drivers/pci/pci.c if possible. The generic function
>> *_find_capability() can accept the controller specific readl/ readw
>> APIs and the controller specific private data.
> 
> I agree, it would be really nice to share this code.
> 
> It looks a little messy to deal with passing around pointers to
> controller read ops, and we'll still end up with a lot of duplicated
> code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
> etc.
> 
> Maybe someday we'll make a generic way to access non-PCI "config"
> space like this host controller space and PCIe RCRBs.
> 
> Or if you add interfaces that accept read/write ops, maybe the
> existing pci_find_capability() etc could be refactored on top of them
> by passing in pci_bus_read_config_word() as the accessor.
> 

Hi Bjorn,

I have already replied to an email, please help review whether it is 
appropriate.

Best regards,
Hans


