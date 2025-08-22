Return-Path: <linux-pci+bounces-34599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4CB31FE3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067AF685F1F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA73207;
	Fri, 22 Aug 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l7xrQHdp"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E46FBF;
	Fri, 22 Aug 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878018; cv=none; b=ozzESMSHgPLzObPAc7gFPXf603Qgi2T9th9Z8L/BKNAZWe9svNdzvKtwczkz0dHTQk0nwnorzZM6gSnRWBSd7dMW22/79k6Hulw/IyPnVUeBYdpf0Ayye302uzru5+8T1y7jsEF23EUfWHpWrqBxwd0zwfrdJD5lOBId3taUXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878018; c=relaxed/simple;
	bh=U+03gEcGnhbmwEIWYOsCA/gAQzaOeGwJAlax+uCxNgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMEFqAOVwKa2pciWT30ifpxFX6KJNyiEzFe92p3ZrSULNK6NM4MaFKHAbLWEBF39ErsAatbSjk0z9M5uIqkfVTP7f68ra04uoB+28TBQjFtzI/leZ9PWNID7x+dEQNRsubGFTGm6Hort3rnVWaAr+un6G25K4BzTQbinM4baX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l7xrQHdp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AcGCWcu7W/vQZ3k6aJxHhigNgbLUrJBaOFG5K5UXqtU=;
	b=l7xrQHdpFN24m73ohlNLcFzio4wacaGl1plqPQuRI2Jx04skPm6w65EWwL07mm
	GfmSrWu1Z6NDZuBtiuCy6IIgM1XsYN9/QJgV2/Q+VeGIm3Vmr8kl4VeESoNFnjP/
	NY7lH4SXcW1DLh5ZH23Inke86sgvPFtVsMgoAR/vIrk+A=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3lTZwkqhoBOrNAA--.31090S2;
	Fri, 22 Aug 2025 23:53:21 +0800 (CST)
Message-ID: <4002ce40-56bc-4a89-a4bf-7da28c94f7db@163.com>
Date: Fri, 22 Aug 2025 23:53:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Replace msleep(2) with usleep_range() for precise
 delay
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250820180651.GA631082@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250820180651.GA631082@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgC3lTZwkqhoBOrNAA--.31090S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrykAF1kurW7GFyfGrWfXwb_yoW8ZFWxpF
	WkGr1jyr4rJrW3Jr4xAa1xZas5Ca4xXF4rAF95W34q9ayYqa4IgFyxCFWYqr1UZr4kA342
	qan0yrs3Aa1qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziLvtNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxOxo2iokSoZSwAAsz

Dear Bjorn,

Thank you very much for your reply. I'll try to understand your meaning 
and then submit the next version.

If I haven't fully understood your meaning yet, please continue to help
correct the mistakes.

Best regards,
Hans

On 2025/8/21 02:06, Bjorn Helgaas wrote:
> On Thu, Aug 21, 2025 at 12:09:44AM +0800, Hans Zhang wrote:
>> The msleep(2) may sleep up to 20ms due to timer granularity, which can
>> cause unnecessary delays. According to PCI spec v3.0 7.6.4.2, the minimum
>> Trst is 1ms and we doubled that to 2ms to meet the requirement. Using
>> usleep_range(2000, 2001) provides a more precise delay of exactly 2ms.
>> ...
> 
> Please cite a recent spec version, i.e., r7.0.  I see this probably
> came from the comment at the change; I wouldn't object to updating
> the comment, too.
> 
>> WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
>> #4630: FILE: drivers/pci/pci.c:4630:
>> +		msleep(1);
>> ...
>> WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
>> #3970: FILE: drivers/pci/quirks.c:3970:
>> +		msleep(10);
> 
>> +++ b/drivers/pci/pci.c
>> @@ -4967,7 +4967,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>>   	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
>>   	 * this to 2ms to ensure that we meet the minimum requirement.
>>   	 */
>> -	msleep(2);
>> +	usleep_range(2000, 2001);
> 
> IMO the most valuable thing here would be to replace the hard-coded
> "2" with some kind of #define explicitly tied to the spec.  Similarly
> for the other cases.
> 
> There is some concern [1] about places that say "msleep(1)" but
> actually rely on the current behavior of a longer sleep.
> 
> Apart from that concern, I think fsleep() would be my first choice.
> usleep_range(x, x+1) defeats the purpose of the range, which is to
> reduce interrupts; see 5e7f5a178bba ("timer: Added usleep_range
> timer").
> 
> Bjorn
> 
> [1] https://lore.kernel.org/all/20070809001640.ec2f3bfb.akpm@linux-foundation.org/


