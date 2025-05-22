Return-Path: <linux-pci+bounces-28282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D8AC114A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5829718887C1
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D3248862;
	Thu, 22 May 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kLIRa3hU"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69815ECDF;
	Thu, 22 May 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932002; cv=none; b=eMxQXccekOe8xM4aGm01f2HbZpc3b+/jz8s3FcYKdPTefXyi6ZR90d0757pL7s0OR24v4rmRGZzxlfE9qkn2L+pwNVc6FjRPJ32fBScJ0/3jeCmsu7HbccKJCLsWNjfkQrNs7mVA2HUQJzKdvgcoObpKyGmOIR7JJO840EAVGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932002; c=relaxed/simple;
	bh=FhjossyuaKS53OSpIpJOEfYW0bmBkJpYEYU/a9A9JP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ev42OWE6XSlqf6sO9L+ZfVc/ylttOrE0cqkcertiO8l6ju9fOD7Sv3NjgjhrgKR+7QSSiyQ34/IK5Uhtlqb9dmof6CiYDoLxX5vcpqBT92aqnoGfq1Dy309nhj3zpjTzBDpK9T+mc0E8uP23r2Eyde8HDcQvzwamdeyqh9uArpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kLIRa3hU; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EOa2PHhz/IkKHlh5GLuGk826myB32r8ilrMA9CVWfQo=;
	b=kLIRa3hUUmVdFRV6tx3xM+pUvNyBtnKVCBZRQYEFezYf+qogsVdqIPKc3OG/qZ
	1iWW9ja25wpV5KbULBGNxsYcjvsudObBDZdgoZZhM6vNodAPFgkA3iAUCmN/0Fju
	/8Xu+GHGltsPKdtJDHeM8ioBRvHg/uv+isbn7gZ2KVtsM=
Received: from [192.168.71.93] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnh5pJUy9oliAoAQ--.41517S2;
	Fri, 23 May 2025 00:39:38 +0800 (CST)
Message-ID: <8472c23c-167f-4e77-bc04-a9498fd41fa8@163.com>
Date: Fri, 23 May 2025 00:39:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: tegra: Add missing kernel-doc for dma_dev member
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
 ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250522163251.399223-1-18255117159@163.com>
 <20250522163535.GA3558378@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250522163535.GA3558378@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnh5pJUy9oliAoAQ--.41517S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0F4iUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxRVo2gvTnlybwAAsU



On 2025/5/23 00:35, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
>>   drivers/i2c/busses/i2c-tegra.c | 1 +
> 
> I think you got a wrong set of maintainers here. :)
> 
> Thank you!
> 
> 	Krzysztof

Dear Krzysztof,

Yes, I just found out. I'm very sorry.

Best regards,
Hans


