Return-Path: <linux-pci+bounces-27640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758FBAB578A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFB77A4F87
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345B1A3160;
	Tue, 13 May 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dF7JsoBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068119CC3C;
	Tue, 13 May 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147705; cv=none; b=Ow9udJSz0NcjCDH1tHS1QCUO652D7g4VDJ6q8zcSVJPe8rE0IaEYO3bBe0fn5iC9B3zLdrUnAA4AA3c8EoPZGXk+dUbSWoTBvwNgC1VWIToEATmfe06I8D4r0jSr67HrPuIzbbHoamj/btSDIzd4emC9dAcPqujlL4nLLzV/L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147705; c=relaxed/simple;
	bh=ZEHsK/pl83AFA+KsON97PcBfz2B89dbkobgNrfUKEXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URF54Bm9XIOPjkSOSnUj5rqKSbH3YloVu7nKz6Q/sLfW+pC37Og6Bxywrh6Jkk8mGPkAh54hfcyE8/8ohg4A2sKYBMA0ddPU+4RDeg8lVkVIwU+tFJAC3ONGhJG6C/uuEeUF5+9N/m/PQEPzbvW0W0pEYrOgW1czCyDzQjdAShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dF7JsoBj; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZkHNlzyKOuNRU1rQfh++4v9cbtgPf5srCgn02AubhOg=;
	b=dF7JsoBjuVohn2pWlqveYMZq+zAdEecLOQ8WEeXEt6R2iKXuV8VUDKHj/1oZNp
	UDc8ej2Y8x4rlIr5OMIsSNcOznpUN8uKttmNO/rGsK6dGcNtD9C0h41I0z6aTtWc
	anAxpim01WZoy1l2N/U+IOo3OwVbthbs38e2rTMeSvK9k=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDX3XmNWyNog3x9BA--.5513S2;
	Tue, 13 May 2025 22:47:41 +0800 (CST)
Message-ID: <ec54f197-acfe-43f4-b5dd-d158d718c8e9@163.com>
Date: Tue, 13 May 2025 22:47:41 +0800
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250513102115.GA2003346@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3XmNWyNog3x9BA--.5513S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWrCFW7Aw1DWFWxtF1rtFb_yoWfXrgEkr
	95Ka47WF1xtrs7uF4rGrnakrWYkw4UZF4UJrW0vw1fJr95ur4SvF43Gr95W3WjqryvyF4D
	CrWSqanI934Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb38n5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw9Mo2gjWMlg0wAAsG



On 2025/5/13 18:21, Krzysztof Wilczyński wrote:
>> 1. PCI: dwc: Standardize link status check to return bool.
>> 2. PCI: mobiveil: Refactor link status check.
>> 3. PCI: cadence: Simplify j721e link status check.
> 
> Do not bother sending such cover letters.  This adds no value.
> 

Dear Krzysztof,

Thank you very much for your reply. In my future work, I will make 
improvements.



> Please read the following:
> 
>    - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>    - https://kernelnewbies.org/PatchSeries
> 
>> ---
>> Changes for RESEND:
>> - add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Resending a patch is not a place to add new tags.
> 

Sorry, this is also the first time I have done this. For other patches 
in the future, I will do this in the new version.

> Thank you!
> 
> 	Krzysztof


Best regards,
Hans


