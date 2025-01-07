Return-Path: <linux-pci+bounces-19403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC4A03E18
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C477A1D22
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CF1E9B33;
	Tue,  7 Jan 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DpnmrFus"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0591E8850;
	Tue,  7 Jan 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250291; cv=none; b=S7RNK/0ZTq/oryHJJ1PWmUNMi6VM2Arl2txpGSHjEUcN7pS/+e0MeIExd96XQhO7LoO4nnnppjmApVG/Lp6qpVo47xDkgKQUT/wFKyqziWjQfgI5px+ipgyL9P7yofm+5M9sUzcWUUQztNpS+lVgvNUrOxp3xGK5wnxsZwxhASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250291; c=relaxed/simple;
	bh=eJPhkcqvg3yC16cbwfyJ5HcpMfNZSTVVG1EfTDFVwY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejiPbOpRuYzTn7IBuKmsN06axzPqee5t3VzQgk6+5OIH5pnRUGj798Ihl1xk2MWi+vH7YecSMMrxWZtMP2t9y8oBzBoKt59kzfNZ0iePaLLTy6qQNLWDtd8Y3CW38C3U8qUZgkfjPMpjht48X0scM3Db//BRz+fPz3HAFtXFa7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DpnmrFus; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Anm5emvbmjB+N5ONWx/wzW3k6eEDQ+6NPFwHUupphJ0=;
	b=DpnmrFus1CxhK3W0oO36UXW9oDTCeHp4OK84pvy6iX1dp/MS4YkieUVaa3Er/O
	UGnYb2zDnB4Y6/XvESO9IqV78gkPz/qr+rV/S+T+RUdtVOpf8Sm7r+y5GcBVtbs5
	Fx0HXyyes7cFBvJqXMVaqpBn4nfA3KWjZhNdYQJsZfq5E=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3PDBeE31noEwKEQ--.2275S2;
	Tue, 07 Jan 2025 19:43:27 +0800 (CST)
Message-ID: <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
Date: Tue, 7 Jan 2025 19:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen> <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen> <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z30RFBcOI61784bI@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wA3PDBeE31noEwKEQ--.2275S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxCr1DGrWDZF1xWrWfZrb_yoW8ArykpF
	y5KF4ftFW2yF1xtrWIqa1vvF93AF9rJwnrZrW5G34jyF9IqF1UtF4kC3y5u3s7urs7CrnY
	vayUJa18Wr47XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTLvtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwLNo2d9DwUypgABsm



On 2025/1/7 19:33, Niklas Cassel wrote:
>> Hi Niklas,
>>
>> resource_size_t bar_size;
>> remain = do_div((u64)bar_size, buf_size);
>>
>> It works for the arm platform.
>>
>> arch/arm/include/asm/div64.h
>> static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>> {
>> 	register unsigned int __base      asm("r4") = base;
>> 	register unsigned long long __n   asm("r0") = *n;
>> 	register unsigned long long __res asm("r2");
>> 	unsigned int __rem;
>> 	asm(	__asmeq("%0", "r0")
>> 		__asmeq("%1", "r2")
>> 		__asmeq("%2", "r4")
>> 		"bl	__do_div64"
>> 		: "+r" (__n), "=r" (__res)
>> 		: "r" (__base)
>> 		: "ip", "lr", "cc");
>> 	__rem = __n >> 32;
>> 	*n = __res;
>> 	return __rem;
>> }
>> #define __div64_32 __div64_32
>>
>> #define do_div(n, base) __div64_32(&(n), base)
>>
>>
>> For X86 platforms, do_div is a macro definition, and the first parameter
>> does not define its type. If the macro definition is replaced directly, an
>> error will be reported in the ubuntu20.04 release.
> 
> What is the error?
> 
> We don't need to use do_div().
> The current code that does normal / and % works fine on both
> 32-bit and 64-bit if you just do:
> 
>   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>                                    enum pci_barno barno)
>   {
> -       int j, bar_size, buf_size, iters, remain;
> +       int j, buf_size, iters, remain;
>          void *write_buf __free(kfree) = NULL;
>          void *read_buf __free(kfree) = NULL;
>          struct pci_dev *pdev = test->pdev;
> +       u64 bar_size;
> 
> No?


Hi Niklas,

Please look at the robot compilation error.

https://patchwork.kernel.org/project/linux-pci/patch/20241231065500.168799-1-18255117159@163.com/

drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'

Best regards
Hans


