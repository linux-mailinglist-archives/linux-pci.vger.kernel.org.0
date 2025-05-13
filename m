Return-Path: <linux-pci+bounces-27645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD8AB5822
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1CE4630CC
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0324EA90;
	Tue, 13 May 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZC+pplT4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089491A3A8D;
	Tue, 13 May 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149067; cv=none; b=I09xBiJprpMoXookqFW4c6quJzZsmxEw+aPShPaya1Pe2JrkQKCpLMN2DghA9El6zOOjCpTk4Wip+LidNJx3y4x0gLTLh00XFa4Vw8sWk5iifEk3aL3kEZCZix3krtGJTgF73lnM/L6Hl9COEEUWhfPsw1Ke5hmLqLxDr6T8Dyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149067; c=relaxed/simple;
	bh=sOE3+LQPlRTUTq5gjfSQebJdFikAobWQ8szKGLW2O8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QehQtJviR3+ytladmUvXbaxbKZ4XNeZzFJS6xO7dbTDxiQ63ItnNFI3FSNl7ZKvtKXe9RHqyo5UoumvdkcJOd1Reoy4UzZgPB/4Z6dg5+PgXntI4BebqpRCWPmX54E1A/rpNtFfxHjjvYplMApY05ay13WmkoD09ewVXzbThvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZC+pplT4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=2ftD5vPPe+JU/1F4I2WDh4q678k384aFdLnLsOpPTK8=;
	b=ZC+pplT4JQNW5M5E6ShrRnoX4JD2gQqfjFJHhwP8akzXMfavD3IjLznlukqmrN
	fKBLhEUL5JP047kcuzGb52lULs5Cga4T4iVeuWvkwhwaxayjcqghZmRsbqAXg3Ak
	MBi376ayEDlKPhAG0aGlEeIGp/yx0rsRixK+bsQgvVln4=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCXn7TGYCNoqIKIBA--.5938S2;
	Tue, 13 May 2025 23:09:58 +0800 (CST)
Message-ID: <d484701c-8a58-4249-a647-d7f06075f7b6@163.com>
Date: Tue, 13 May 2025 23:09:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 manivannan.sadhasivam@linaro.org, cassel@kernel.org, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250510160710.392122-1-18255117159@163.com>
 <20250513102115.GA2003346@rocinante>
 <ec54f197-acfe-43f4-b5dd-d158d718c8e9@163.com>
 <20250513150423.GB3513600@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250513150423.GB3513600@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXn7TGYCNoqIKIBA--.5938S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFmiiDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxpMo2gjWgT49AAAs3



On 2025/5/13 23:04, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
>> Sorry, this is also the first time I have done this. For other patches in
>> the future, I will do this in the new version.
> 
> See the following:
> 
>    - https://lore.kernel.org/linux-pci/20250513145728.GA3513600@rocinante
> 
> While I cannot speak for other maintainers, I am going to change the
> approach to the "RESEND" patches that I used to personally have.
> 
> But, if in doubt, it's always fine to send another version.
> 


Dear Krzysztof,

Ok. From now on, I will handle similar problems in the new version.

Best regards,
Hans


