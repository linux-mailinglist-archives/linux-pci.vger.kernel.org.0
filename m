Return-Path: <linux-pci+bounces-21423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEDA356B5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 07:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF84F1890BFA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC91C8606;
	Fri, 14 Feb 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mJPoNa8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06F1C84DE
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513005; cv=none; b=oBjzoVAX3nrCgaU/Gydi28r/hhU/zTAF2eniapupdrj2m4vXEi3kqi9FmljHoTTuRmW7eEvj4SNn8TkA5+rPBTcJOi/VJb3WN0X4odKHY3INIk48oR4Ds/t8aiQvDHTJ2OrbfhR0xuB0pP58v+F8arj2TloAgH/ZR5hOP4Sq8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513005; c=relaxed/simple;
	bh=FW7Wn3LSFHK9BYXLpN+/Bk8+cLKzbsTyTU3TID3KZuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jy2eSq71cy2IapUHa/ZZvd90C8W6hk+oijKzmX3RFyURB5daLq11zAzOmx581vuiXUSMJKInvGRqRrS3XTJxDFUY5IRaiM4P5fpLyvwc+pzc2YZ1Aea4TkbfqYIagJ/FnWQITQF77JzN2aul7GWzkTH9xzRmpxOPYgaS06T+y/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mJPoNa8n; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Y3uy+jf6zj8vjb+odaDFqQkxCLEiZF/okq00bM/+Dcg=;
	b=mJPoNa8naCjHaIfQtTitgGjmgfzKiA4AcGkMqGM33oHpT1G/wH0uxV7b3L/3AP
	F7Aig8KkKQCT4l4e0l57SSmy12TlDmz9Ew+n4KW0xsKQ1yvee1f3ZQVpgPi/SY+K
	W+TGDpK5lXGrcAjDWoyP37YzOE6JhSoghyjOqP3xnEdQ0=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAnb0bn265n+XP4Lg--.8986S2;
	Fri, 14 Feb 2025 14:00:09 +0800 (CST)
Message-ID: <0ece2ad3-cd80-4339-a1ee-cf6f11810b20@163.com>
Date: Fri, 14 Feb 2025 14:00:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
To: Frank Li <Frank.li@nxp.com>, Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jon Hunter <jonathanh@nvidia.com>,
 linux-pci@vger.kernel.org
References: <20250213133913.17391-2-cassel@kernel.org>
 <Z64WkB6uiqbSRpS8@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z64WkB6uiqbSRpS8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAnb0bn265n+XP4Lg--.8986S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYT5lUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwfyo2euFGFRoQABsA



On 2025/2/13 23:58, Frank Li wrote:
> On Thu, Feb 13, 2025 at 02:39:14PM +0100, Niklas Cassel wrote:
>> Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
>> is e.g. 8 GB.
> 
> pcitest is not exist now. Does it need update to pci_endpoint_test?
> 

Hi Frank,

Mani has modified the entire pci_endpoint_test test framework, BAR test 
is still required. So Niklas may need to modify the commit message.

392188bb0f6e ("selftests: pci_endpoint: Migrate to Kselftest framework")
e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to 
Kselftests")

Best regards
Hans


