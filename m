Return-Path: <linux-pci+bounces-19587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB0A06BC0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 04:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11A97A01BE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB52E64A;
	Thu,  9 Jan 2025 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iX034oX/"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98319127E18;
	Thu,  9 Jan 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391625; cv=none; b=QyhcClGBInakMjzBcyDGi0JiCrjawmSg6E1euYMHkmt9yfF0CViaWMh3sd4DuHk/vSHAP7MQLqLYsAqVTM0+6mEJyPSlgRuH7jw8XdrGDHYu55V08PqlA7ROngo2DboWcz7lxZb4QV/kYm8wp8NTMl/0BsdaXj2at6qmDU4W0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391625; c=relaxed/simple;
	bh=uFBZYHiqGHT8COKtV7Pzs+ixj2vWCKMMCk+Aw7pUPS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTdITfR1IDV+AEzqzOyl5RfjgjewYRR3KEA1TXsTqGvB1EbPKWk79wpS/M70K11Y3XX5bqzfxe7n6vE+rSgGkuOaJyhWMHe7dH9hNcpIsLYxD3uuCANUDROop3BctoaZ+EmhOCw7vVa+YIJUk6JsmNJeArKPFW3WGFW5MkLSbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iX034oX/; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=vpTqfsTXhyaWmrtuW6XR+3roagzephINFr3wSZOrbos=;
	b=iX034oX/dXjvBj2zVfG0gH5R6uS4Yu+na1fWMjw8eVFD4ZyT4L0GZ7JG51ENE6
	cMvVh5J8AP9lDiA05bzmtisiatWKvg6RihhRU2fJIB1wP8MX2mojG+a6/2qbWO7F
	/h4POIuqPlZFo7beY4zYhHiD1yu2tUk3evLesgmB1xZrk=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAX0Yx0O39n3iNOEw--.16205S2;
	Thu, 09 Jan 2025 10:59:01 +0800 (CST)
Message-ID: <f2901d4f-52c8-496d-9939-3b0e113cba4b@163.com>
Date: Thu, 9 Jan 2025 10:59:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
To: Niklas Cassel <cassel@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com> <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com> <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com> <Z30UXDVZi3Re_J9p@ryzen>
 <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com> <Z31O8B14sKd5eac-@ryzen>
 <7e025613-3516-4957-b83a-70b125a24fa7@app.fastmail.com>
 <Z36IJ6ql09I_dO98@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z36IJ6ql09I_dO98@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAX0Yx0O39n3iNOEw--.16205S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWUJrW7XF15Gr1kZrW7CFg_yoWrJry5pF
	1fAryrtFWjqr15GFWvvwn5Wry5Ars7G3yavry3Jr109FWaqa4UtF4xKryfGF4vkrnFyr45
	tFnrGFW5X34xAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDZ23UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwfPo2d-NoOYqAAAs5



On 2025/1/8 22:13, Niklas Cassel wrote:
Hi Niklas,

>>> Ok. Looking at do_div(), it seems to be the correct API to use
>>> for this problem. Just change bar_size type to u64 (instead of casting)
>>> and use do_div() ? That is how it is seems to be used in other drivers.
>>
>> I think using div_u64_rem() instead of do_div() would make this
>> more readable as this is always an inline function, so the type can
>> remain resource_size_t, and the division gets optimized well when
>> that is a 32-bit type.
> 
> After patch 1/2, we no longer care about the remainder, so I guess
> div64_u64() is the correct function to use then?
> 

include/asm-generic/bitsperlong.h
#ifdef CONFIG_64BIT
#define BITS_PER_LONG 64
#else
#define BITS_PER_LONG 32
#endif /* CONFIG_64BIT */

include/linux/types.h
#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

typedef phys_addr_t resource_size_t;


include/linux/math64.h
#if BITS_PER_LONG == 64
......
static inline u64 div64_u64(u64 dividend, u64 divisor)
{
	return dividend / divisor;
}
......
#elif BITS_PER_LONG == 32
#ifndef div64_u64
extern u64 div64_u64(u64 dividend, u64 divisor);
#endif
......
#endif /* BITS_PER_LONG */

lib/math/div64.c
u64 div64_u64(u64 dividend, u64 divisor)
{
	u32 high = divisor >> 32;
	u64 quot;

	if (high == 0) {
		quot = div_u64(dividend, divisor);
	} else {
		int n = fls(high);
		quot = div_u64(dividend >> n, divisor >> n);

		if (quot != 0)
			quot--;
		if ((dividend - quot * divisor) >= divisor)
			quot++;
	}

	return quot;
}
EXPORT_SYMBOL(div64_u64);


If CONFIG_64BIT and CONFIG_PHYS_ADDR_T_64BIT are not configured. The 
resource_size_t=u32, and the first parameter of div64_u64 is u64.The 
same question is as follows:

https://patchwork.kernel.org/project/linux-pci/patch/20250102120222.1403906-1-18255117159@163.com/

config: arm-defconfig 
(https://download.01.org/0day-ci/archive/20250103/202501030414.p0DE9xNK-lkp@intel.com/config)

All error/warnings (new ones prefixed by >>):

 >> drivers/misc/pci_endpoint_test.c:311:11: warning: comparison of 
distinct pointer types ('typeof ((bar_size)) *' (aka 'unsigned int *') 
and 'uint64_t *' (aka 'unsigned long long *')) 
[-Wcompare-distinct-pointer-types]
      311 |         remain = do_div(bar_size, buf_size);
          |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
    include/asm-generic/div64.h:183:28: note: expanded from macro 'do_div'
      183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
          |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
 >> drivers/misc/pci_endpoint_test.c:311:11: error: incompatible pointer 
types passing 'resource_size_t *' (aka 'unsigned int *') to parameter of 
type 'uint64_t *' (aka 'unsigned long long *') 
[-Werror,-Wincompatible-pointer-types]
      311 |         remain = do_div(bar_size, buf_size);
          |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
    include/asm-generic/div64.h:199:22: note: expanded from macro 'do_div'
      199 |                 __rem = __div64_32(&(n), __base);       \
          |                                    ^~~~
    arch/arm/include/asm/div64.h:24:45: note: passing argument to 
parameter 'n' here
       24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
          |                                             ^
 >> drivers/misc/pci_endpoint_test.c:311:11: warning: shift count >= 
width of type [-Wshift-count-overflow]
      311 |         remain = do_div(bar_size, buf_size);
          |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
    include/asm-generic/div64.h:195:25: note: expanded from macro 'do_div'
      195 |         } else if (likely(((n) >> 32) == 0)) {          \
          |                                ^  ~~
    include/linux/compiler.h:76:40: note: expanded from macro 'likely'
       76 | # define likely(x)      __builtin_expect(!!(x), 1)
          |                                             ^
    2 warnings and 1 error generated.

Best regards
Hans


