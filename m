Return-Path: <linux-pci+bounces-24354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1DA6BC42
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A072188D517
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090C38FB9;
	Fri, 21 Mar 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HB3nCaIB"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57412757EA;
	Fri, 21 Mar 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565541; cv=none; b=Ajc6W7vSp3LBlp7s1+8F3eada89SFEP4mVbsMX/FkR2KaYoGS+B42MVmiztOykI4YG9mH1aEMkInLJEP8GDur/3Pzd7o+WGr+Pxzplc/bJQoIGBF2P6rOO8NIr1BithZdGlqdsqV572skTQcgmxieaABalrZAebn4iC+pwxIF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565541; c=relaxed/simple;
	bh=1+xMaAvUHZ5L/ZUosrkBX9aJ4kmqhurq84tQsDKCjzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT+IdbaJ7fR5AkarePDk1OUCkyd3yNRu3MI5q3yqrt2v37NV5+nONULwwPgxk/Jta8tex4g4eydm8CBhEjBHXZQivL6/+BqKZdhSqK3xAuypsjWP0Fc5i8ivfPxx3nf4rd0nAX26sgy6OY8JuCN5B5aM1RpoTV9Km5T4oFyVMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HB3nCaIB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=nqd7e7zbDGozqcjqqiNSeyoPQECWWH4BqOaiDl5o8DE=;
	b=HB3nCaIBTOpmAUY4v/0rCBWoMiG8Rd2G/PWgvpL77gD8Avhf56R/Ruif16dOde
	4imzRDMpvS2wHLN1n4qmW87M/e0qrWVENWyD4Hlx/wthP1GOShJrlLQNVUSkDHhL
	2HCXakWLuh9GI1oZLKHq3YpdwqxpdB+pwyakfkaQ0jtOI=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD36TmLcN1nkJycAw--.26212S2;
	Fri, 21 Mar 2025 21:58:36 +0800 (CST)
Message-ID: <4a1569a4-5a84-41ea-88c0-400a72c4f0c6@163.com>
Date: Fri, 21 Mar 2025 21:58:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 3/4] PCI: cadence: Add configuration space capability search
 API
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-4-18255117159@163.com>
 <20250321130648.bnwf57qqsi7kkdby@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250321130648.bnwf57qqsi7kkdby@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD36TmLcN1nkJycAw--.26212S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4jjgUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx4Xo2fdalqunQABsJ



On 2025/3/21 21:06, Manivannan Sadhasivam wrote:
> On Fri, Mar 21, 2025 at 06:17:09PM +0800, Hans Zhang wrote:
>> Add configuration space capability search API using struct cdns_pcie*
>> pointer.
>>
> 
> Please reuse the subject and description I provided in previous patch.
> 

Hi Mani,

Thanks your for reply. Will change.

Best regards,
Hans


