Return-Path: <linux-pci+bounces-20364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F82FA1C86B
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 15:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AD618866B1
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3770838;
	Sun, 26 Jan 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f1CMTGVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E283C6BA;
	Sun, 26 Jan 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737901902; cv=none; b=qBFLvZxq0FfG+e9DP1u50CvJsH9vR7SK+CZd3DuFYSiNXthRr6RLPV2D0ObRwGiVGGvC99dIuRI8mu//nknej6lADPXYPhgHxF22DtfdDC/4tH8yMvlQqwFQd9rNPXHtue+HjEo0kBZ9LqubAcMYqv1iAUyuuM0gZ+4qm4o2aMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737901902; c=relaxed/simple;
	bh=HB2lN5d0SuVD+cOMzSEDJtUpamrurHr61EOgl0US3QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAypfYdz3tIJS3fJ/rtkwJ/u89Ab2xYwp9bb+lyCI5diWCAEamaLJOZFDLCdJTSkZYdPepow+dTzBbAmHrgVeYhlkeUeX9vYxk4s5PyIOh6rAJxWSmIQZ+fpWnW7Pj1Ru1hcoqwffsz+0p/gLlZOHK1bThtBD+7gqcFJea0Z3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f1CMTGVc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=9zj5YLlC6MuqAHM+6WlEjPhhtNgrnfLSEGTKpQ3uVoU=;
	b=f1CMTGVcu7p2vwK/9Uafvmu94jrtWXnMsM/FlP79j2nQ0qoZDQ5BeKKUQx70Ku
	FpiAgfN4Y1ULCKUJdcwLa6C5kzJ8AnA9HDQUmIws5T3lIQm8h/3qnz+eeXYMjidH
	3zJFdSRHRXHf1ftZ2Qhb1Lv2+HeFGI4C7JUlLTYhdK1nY=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn3x8SR5Zn1JEVIg--.20587S2;
	Sun, 26 Jan 2025 22:30:43 +0800 (CST)
Message-ID: <bfd2b930-d18d-4ab4-a5b5-aef22fd068ab@163.com>
Date: Sun, 26 Jan 2025 22:30:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Add the sysfs property to provide the LTSSM
 status of the PCIe link
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250123071326.1810751-1-18255117159@163.com>
 <Z5JrXsDDM2IManp+@lizhi-Precision-Tower-5810>
 <54428aa3-2178-45d0-83d3-0b6254347bb5@163.com>
 <Z5O5VsMLYE9R+loz@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z5O5VsMLYE9R+loz@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDn3x8SR5Zn1JEVIg--.20587S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13Aw1xKF43CrWUCrW3KFg_yoW8Aw4rpr
	W8AayjyF42vw1jy3WYq3Z5XF4Dt3WSyF4qkr45XFWxJa4vyrnxKFW5Jr4jkrykGr17Kr42
	yw13ZFn3GryrG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOzV8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxPgo2eWQlUrRwAAsB



On 2025/1/25 00:01, Frank Li wrote:
> On Fri, Jan 24, 2025 at 09:12:49PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/1/24 00:16, Frank Li wrote:
>>>> +static char *dw_ltssm_sts_string(enum dw_pcie_ltssm ltssm)
>>>> +{
>>>> +	char *str;
>>>> +
>>>> +	switch (ltssm) {
>>>> +#define DW_PCIE_LTSSM_NAME(n) case n: str = #n; break
>>>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_QUIET);
>>>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_DETECT_ACT);
>>>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_ACTIVE);
>>>> +	DW_PCIE_LTSSM_NAME(DW_PCIE_LTSSM_POLL_COMPLIANCE);
>>>> +	...
>>>> +	default:
>>>> +		str = "DW_PCIE_LTSSM_UNKNOWN";
>>>> +		break;
>>>
>>> I prefer
>>> const char * str[] =
>>> {
>>> 	"detect_quitet",
>>> 	"detect_act",
>>> 	...
>>> }
>>>
>>> 	return str[ltssm];
>>>
>>> Or
>>> 	#define DW_PCIE_LTSSM_NAME(n) case n: return #n;
>>> 	...
>>> 	default:
>>> 		return "DW_PCIE_LTSSM_UNKNOWN";
>> Hi Frank,
>>
>> I considered the two methods you mentioned before I submitted this patch.
>>
>> The first, I think, will increase the memory overhead.
>>
>> +static const char * const dw_pcie_ltssm_str[] = {
>> +	[DW_PCIE_LTSSM_DETECT_QUIET] = "DETECT_QUIET",
>> +	[DW_PCIE_LTSSM_DETECT_ACT] = "DETECT_ACT",
>> +	[DW_PCIE_LTSSM_POLL_ACTIVE] = "POLL_ACTIVE",
>> +	[DW_PCIE_LTSSM_POLL_COMPLIANCE] = "POLL_COMPLIANCE",
>> 	...
>>
>>
>> The second, ./scripts/checkpatch.pl checks will have a warning
>>
>> WARNING: Macros with flow control statements should be avoided
>> #121: FILE: drivers/pci/controller/dwc/pcie-designware.h:329:
>> +#define DW_PCIE_LTSSM_NAME(n) case n: return #n
>>
> 
> Okay, it is not big deal
> can you return
> 	str + strlen("DW_PCIE_LTSSM_");
> 
> Or trim useless "DW_PCIE_LTSSM_" information.

Ok, thanks Frank for the advice.

Best regards
Hans


