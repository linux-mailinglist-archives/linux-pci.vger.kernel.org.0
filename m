Return-Path: <linux-pci+bounces-33376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951BB1A574
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 17:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4415218A0405
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A12217F36;
	Mon,  4 Aug 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z4nm3Ekd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3121421D;
	Mon,  4 Aug 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319936; cv=none; b=LZmcRe0+Me66bKHPRTs5CFoX7nACyUGv4JFY8/chczV67HaB6M5Co8L3JqrFuKMNTaTH4Ifo6ZXy8iZ0p8nSJnxeSZGoRkv+p5XIgLjZ1zapA8V0OsO2reqiL7akYxsj9DnGReZgfp4g9mhOIK6xvIoIVDfIzX7vtF1ZM9uiEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319936; c=relaxed/simple;
	bh=w4o+sZu3r/al9qNNdqgyQOw7OmxvM4RVKLSSpyUPXLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwFa9qBIk3A/AGxIXaPmT1pAewNJWWBPsFzuIOdGg36WEFJmoeynPLnTLf8AfL2RukSOlBAoaxNb+DSp2Im66xIGhP4J6nlf5q1e0OE22fQrPVVZzlXoEu8pkey/p7vLfS9AV96wbV3kIvxPNi5978LpdQCpVhjNSuO5l40xzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z4nm3Ekd; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Rt2ga71sRvEoE+eMHbF1P6C8pCr7yGyyXy+c7pka4Xc=;
	b=Z4nm3EkdNLfRro70O9dzOUGnt6SR6zjawMaTXAXw0MiSJgudChTcscjNNq1cH+
	oXaVVJHc71ADG67JOd5PGA4jF36RrlBUgPzxRsmkk6YG+27c57KiRd3Av5pC1SK/
	Qky0bwHiKGiFGUZ4Lm5BDLL6FLY1r7R5ZRewpfu10xLD4=
Received: from [IPV6:240e:b8f:919b:3100:ecd9:c243:2a5f:12dd] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3lozny5Bo+VLrJg--.22748S2;
	Mon, 04 Aug 2025 23:04:08 +0800 (CST)
Message-ID: <6628a4b9-befe-4bb1-a72a-4e9085338598@163.com>
Date: Mon, 4 Aug 2025 23:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>,
 Arnd Bergmann <arnd@kernel.org>, bhelgaas@google.com,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 geert@linux-m68k.org
References: <20250804143313.GA3624395@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250804143313.GA3624395@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wB3lozny5Bo+VLrJg--.22748S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4rAw18JFyfJF47Kw48WFg_yoW8JFW5p3
	yIyFsxtFs7GFZ2yay8Wr4jqF17u3yvyry3J34rG3sxJ3Z8KrykJrs3ZF4jgFZrurZ7uF1a
	vw12qrW5Z34qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtuciUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwWfo2iQgPKsBgACsA



On 2025/8/4 22:33, Bjorn Helgaas wrote:
> On Mon, Aug 04, 2025 at 11:06:36AM +0800, Hans Zhang wrote:
>> ...
> 
>> According to the issue mentioned by Lukas and Mani. Gerd has already been
>> tested on the s390. I have tested it on the RK3588 and it works fine. RK3588
>> uses Synopsys' PCIe IP, that is, the DWC driver. Our company's is based on
>> Cadence's PCIe 4.0 IP, and the test function is normal. All the platforms I
>> tested were based on ARM.
>>
>> The following is the patch based on the capability-search branch. May I ask
>> everyone, do you have any more questions?
>>
>> Gerd, if there's no problem, I'll add your Tested-by label.
>>
>> Branch: ttps://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search
> 
> Since this series will now target v6.18, I'll watch for a complete v15
> series based on v6.17-rc1, with this fix and any typo or other fixes
> from pci/capability-search fully integrated.
> 
> Then that series can be tested and completely replace the current
> pci/capability-search branch.
> 

Dear Bjorn,

Here is the patch based on pci/capability-search branch. It's to discuss 
clearly how the final v15 should be modified. The final plan has been 
confirmed. I will submit the v15 version of this series based on v6.17-rc1.

Best regards,
Hans


