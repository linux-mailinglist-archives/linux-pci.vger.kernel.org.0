Return-Path: <linux-pci+bounces-19398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A85A03DA9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90FD3A45E8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A131E570E;
	Tue,  7 Jan 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V5VnlfZl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72041E3DE8;
	Tue,  7 Jan 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249303; cv=none; b=NtXhvBe439Eyuaqg1eojVjv+Ynu3NL9gsqaIBiKgOPeHXU+4hrhDyD0kvdFxGMnYXOe7TpcoxRwwmdOFirNO5tW+lLq60rxnTIWV867LPdDJcGECSU4h54zbuEuN6yeQUDisSDQNClUYOsPjMOuvHDq8K3j5gGSnqlSVkFobXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249303; c=relaxed/simple;
	bh=2Jsy14ptUvEwniOA7t/I1F6b5Vz0seLSJSLe1vRRe40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPIDA2ISvTZOPntyX7oY9mvg8fbh7xUc5ehrQl7mfninJEMywNm7J/q4sUIqE146WXTCHr2p+8IcuJD2+elHFNfSQ0DimAbd0fGq52OpK8iFK4dJdumDnoVrCF4NNV7mFTUjKUZHeF/2hv/Ap8eh1FvGVYTckIKaZBxW1CaRbRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V5VnlfZl; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=RyL7ZLpB9GQfRNru39Mn/5KSUHCmIgDmRKvxXbeOV9c=;
	b=V5VnlfZlXRDyarqaww/mD3WK7E56l+2tBA2zTMCHjWJqBwJcBLumi1eWbcI+jq
	56MCSlJ/GhoQiC+yFFTr2/QScRXNGk0mW+bIXWSN8j1Z8ZTSow7tx81LqKZJuOgl
	WRIa6/DaVrN4ksll++Iq06lLc/m/remBVP/WekL9AVq5o=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3sY2cD31ndhi3EQ--.19568S2;
	Tue, 07 Jan 2025 19:27:26 +0800 (CST)
Message-ID: <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
Date: Tue, 7 Jan 2025 19:27:24 +0800
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
 <Z30CywAKGRYE_p28@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z30CywAKGRYE_p28@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3sY2cD31ndhi3EQ--.19568S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4xXrWUZFWDGF1UCw4xXrb_yoW5Zr15pr
	ZIkF4SyF4jqF9rG392qwn0qF9ayFsrJryDXFW5Kw1Yvrn0vFyxtF1rC3yUG3yfurn7uF4a
	qFsxJa18ur17AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTJP_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwDNo2d9DwUPPgAAsA



On 2025/1/7 18:32, Niklas Cassel wrote:
>>>> ---
>>>>    drivers/misc/pci_endpoint_test.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>>> index 3aaaf47fa4ee..50d4616119af 100644
>>>> --- a/drivers/misc/pci_endpoint_test.c
>>>> +++ b/drivers/misc/pci_endpoint_test.c
>>>> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>>>>    static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>>    				  enum pci_barno barno)
>>>>    {
>>>> -	int j, bar_size, buf_size, iters, remain;
>>>>    	void *write_buf __free(kfree) = NULL;
>>>>    	void *read_buf __free(kfree) = NULL;
>>>>    	struct pci_dev *pdev = test->pdev;
>>>> +	int j, buf_size, iters, remain;
>>>> +	resource_size_t bar_size;
>>
>> Fix resource_size_t to u64 bar_size.
>> u64 bar_size;
>>
>>>>    	if (!test->bar[barno])
>>>>    		return false;
>>>> @@ -307,13 +308,18 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>>    	if (!read_buf)
>>>>    		return false;
>>>> -	iters = bar_size / buf_size;
>>>> +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT)) {
>>>> +		remain = do_div(bar_size, buf_size);
>>>> +		iters = bar_size;
>>>> +	} else {
>>>> +		iters = bar_size / buf_size;
>>>> +		remain = bar_size % buf_size;
>>>> +	}
>>
>> Removed IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT), Execute the following code.
>>
>> remain = do_div(bar_size, buf_size);
>> iters = bar_size;
> 
> Perhaps keep it as resource_size_t and then cast it to u64 in the do_div()
> call?


Hi Niklas,

resource_size_t bar_size;
remain = do_div((u64)bar_size, buf_size);

It works for the arm platform.

arch/arm/include/asm/div64.h
static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
{
	register unsigned int __base      asm("r4") = base;
	register unsigned long long __n   asm("r0") = *n;
	register unsigned long long __res asm("r2");
	unsigned int __rem;
	asm(	__asmeq("%0", "r0")
		__asmeq("%1", "r2")
		__asmeq("%2", "r4")
		"bl	__do_div64"
		: "+r" (__n), "=r" (__res)
		: "r" (__base)
		: "ip", "lr", "cc");
	__rem = __n >> 32;
	*n = __res;
	return __rem;
}
#define __div64_32 __div64_32

#define do_div(n, base) __div64_32(&(n), base)


For X86 platforms, do_div is a macro definition, and the first parameter 
does not define its type. If the macro definition is replaced directly, 
an error will be reported in the ubuntu20.04 release.

resource_size_t bar_size;
remain = do_div((u64)bar_size, buf_size);

arch/x86/include/asm/div64.h
#define do_div(n, base)						\
({								\
	unsigned long __upper, __low, __high, __mod, __base;	\
	__base = (base);					\
	if (__builtin_constant_p(__base) && is_power_of_2(__base)) { \
		__mod = n & (__base - 1);			\
		n >>= ilog2(__base);				\
	} else {						\
		asm("" : "=a" (__low), "=d" (__high) : "A" (n));\
		__upper = __high;				\
		if (__high) {					\
			__upper = __high % (__base);		\
			__high = __high / (__base);		\
		}						\
		asm("divl %2" : "=a" (__low), "=d" (__mod)	\
			: "rm" (__base), "0" (__low), "1" (__upper));	\
		asm("" : "=A" (n) : "a" (__low), "d" (__high));	\
	}							\
	__mod;							\
})


Best regards
Hans


