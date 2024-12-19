Return-Path: <linux-pci+bounces-18774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA469F7B46
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 13:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86C81671F7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD0221DAD;
	Thu, 19 Dec 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lS5lFzRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D8223E86
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611336; cv=none; b=Su/PcUAd/C/DbVwaBGmLyxF+7M+tJ6sl/B4ijHhxXyzRjgCDxXjNhln17gAeIXfPCuhjBpVPhwm9lP7rQWnex3ZV15es2FxBcBP6t3lDutx09O/pe5cVOOkoRGXOdgv9xQKdbbxBfPtud5Qt1tt83fKUizFpPhAZjUaBs2s+gKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611336; c=relaxed/simple;
	bh=82sMUBPYcO0Cy77hyMBZw0PLNcRr260a0bqTkIQiUTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BijQF/JdMZFFwEy8M4wxwIhLQ47i4vo8Xjlqetpb8j9NQGsc98m/lrowDdTMnW592LFFBCH6qmdRSFrQBJ/zo7WSCDUVQaGlxzr5MpPk+PQNtyYLRwxmVDEceVACbWwd2gqvdlmzmvgqmTf/9byxFB9T/hLd+BvAUp+/Br5kVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lS5lFzRy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=9DayRwtrHrSJgB6MtTy0yBayfDnpD/La1EMM4D0bM98=;
	b=lS5lFzRysNqNY6UP24vEVkjTx/m5v+jUMrSn0t9HiQt1idvNzW/7BqUHtm+m3T
	oktxbN7Ig6hqCVSWmXADZVZiyFTY7/htXu1yWL9U0EdIN4leAAimvoD0Pq5eiRul
	btD3hTb8U+SPzjOwWc4Nf7mNsz+9YUf0Vz3b8dpHQ0RM4=
Received: from [192.168.60.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHcbFeEWRnBXFuBw--.56245S2;
	Thu, 19 Dec 2024 20:28:15 +0800 (CST)
Message-ID: <ca7e3d52-c60d-ee19-ca6b-8fa5674197c2@163.com>
Date: Thu, 19 Dec 2024 07:28:13 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] misc: pci_endpoint_test: fixed pci_resource_len return
 value out of bounds.
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-pci@vger.kernel.org, inux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20241217121220.19676-1-18255117159@163.com>
 <4ed0496c-329b-ae7e-dce4-5d822e652d46@linux.intel.com>
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <4ed0496c-329b-ae7e-dce4-5d822e652d46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHcbFeEWRnBXFuBw--.56245S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDVT5UUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwO6o2dkD0os0AAAsv



On 12/18/24 10:00, Ilpo Järvinen wrote:

> I'm not sure how out-of-bounds access would happen. On which line you see
> that possibility?
Please see #L291
https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/misc/pci_endpoint_test.c#L291

> 
>> If the bar size of the EP device exceeds
> 
> BAR size
> 
>> 4G, this bar_Size will be equal to 0.
> 
> bar_size
> 
> I think bar0 and bar1 information could simply be dropped since they're
> unrelated. I think this would be enough information:
> 
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 

Do I need to add the patch version?

Regards
Hans


