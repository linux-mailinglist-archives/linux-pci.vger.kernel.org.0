Return-Path: <linux-pci+bounces-19406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0487A03ED1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F4A164CCD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532CA1E633C;
	Tue,  7 Jan 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NaaW4UOW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0DB1E1A2D;
	Tue,  7 Jan 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251881; cv=none; b=MwAM+j5Hn/zgAJ6YGL3rs9cW7MIggClaiP77JC72cTaraZmjMxtFGeg2KuzjUZ27plS0gIXVOq67Bc6Mece/eCLHx7hY0OQM4baGS16RB1ibvKMCd/GgVq6r4iWRztVg3tvAjrnWHDywhuVUDCYhe2jH+mZu7BO5rpXIV3eVAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251881; c=relaxed/simple;
	bh=JJz+uD7urtJ1f9MPDdNsZdiJttbiZLIXWhg7Xyrzzr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMfDLo34yLW6ai3lp6KK2nmLJZ8SwNwJiWiAmPY9nUIpcXWc/24MsMu/XJpfZPcDDNNgWi8hgDr/U07IF582NGnYDQLWlDYKHju2etUAQtfJp6EDpcCa+ICjSGoqW9Zl/cJjRfXmmmDFn5OMCcpep+AET8QgRfM9Wuz4Y+Tz9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NaaW4UOW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Q5c29YQpqPK76jErTvd+K4YuvoRfGtkPGuh48wHmG28=;
	b=NaaW4UOWCOsyGbaeHDqGVcVUdroYsCfxOEHll6lXj9UJFun//vShmPo8bUWCk2
	OHLJNUgDrr5xij3g320qOuh12S0oeMGfeR1FJHm6bR7ElLgNEsqse+9u7bDZgEFb
	1ZxBYa94GmQ+3IXh4cmixUEhAq5paTHMdeueUACNyrBcU=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnX9KMGX1nKo_6EQ--.56066S2;
	Tue, 07 Jan 2025 20:09:49 +0800 (CST)
Message-ID: <b2781922-d536-453f-b593-880674fc8b01@163.com>
Date: Tue, 7 Jan 2025 20:09:48 +0800
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
 <Z30RFBcOI61784bI@ryzen> <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
 <Z30UXDVZi3Re_J9p@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z30UXDVZi3Re_J9p@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnX9KMGX1nKo_6EQ--.56066S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4kAFWrWr48CF1DuryrXrb_yoWrWrW8pr
	1jyFW8tFWjqry2yan2q3Wq9F9Yqry7Ar13XF98W345tFn0qF4UJr1xu3yY9347Cr4Ikr15
	tFy3Xa92g3yUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9AwxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwzNo2d9GRUMTwAAss



On 2025/1/7 19:47, Niklas Cassel wrote:
> On Tue, Jan 07, 2025 at 07:43:26PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/1/7 19:33, Niklas Cassel wrote:
>>>> Hi Niklas,
>>>>
>>>> resource_size_t bar_size;
>>>> remain = do_div((u64)bar_size, buf_size);
>>>>
>>>> It works for the arm platform.
>>>>
>>>> arch/arm/include/asm/div64.h
>>>> static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>>>> {
>>>> 	register unsigned int __base      asm("r4") = base;
>>>> 	register unsigned long long __n   asm("r0") = *n;
>>>> 	register unsigned long long __res asm("r2");
>>>> 	unsigned int __rem;
>>>> 	asm(	__asmeq("%0", "r0")
>>>> 		__asmeq("%1", "r2")
>>>> 		__asmeq("%2", "r4")
>>>> 		"bl	__do_div64"
>>>> 		: "+r" (__n), "=r" (__res)
>>>> 		: "r" (__base)
>>>> 		: "ip", "lr", "cc");
>>>> 	__rem = __n >> 32;
>>>> 	*n = __res;
>>>> 	return __rem;
>>>> }
>>>> #define __div64_32 __div64_32
>>>>
>>>> #define do_div(n, base) __div64_32(&(n), base)
>>>>
>>>>
>>>> For X86 platforms, do_div is a macro definition, and the first parameter
>>>> does not define its type. If the macro definition is replaced directly, an
>>>> error will be reported in the ubuntu20.04 release.
>>>
>>> What is the error?
>>>
>>> We don't need to use do_div().
>>> The current code that does normal / and % works fine on both
>>> 32-bit and 64-bit if you just do:
>>>
>>>    static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>                                     enum pci_barno barno)
>>>    {
>>> -       int j, bar_size, buf_size, iters, remain;
>>> +       int j, buf_size, iters, remain;
>>>           void *write_buf __free(kfree) = NULL;
>>>           void *read_buf __free(kfree) = NULL;
>>>           struct pci_dev *pdev = test->pdev;
>>> +       u64 bar_size;
>>>
>>> No?
>>
>>
>> Hi Niklas,
>>
>> Please look at the robot compilation error.
>>
>> https://patchwork.kernel.org/project/linux-pci/patch/20241231065500.168799-1-18255117159@163.com/
>>
>> drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
> 
> That error was for your patch that changed bar_size to resource_size_t,
> which is typedefed to phys_addr_t, which can be either 32-bits or 64-bits
> on 32-bit systems (depending on CONFIG_X86_PAE).
> 
> I was suggesting to just change it to u64, so it will unconditionally be
> 64-bits.

Hi Niklas,

The robot has been compiled with CONFIG_PHYS_ADDR_T_64BIT=y, so 
resource_size_t=u64


include/linux/types.h

#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 phys_addr_t;
#else
typedef u32 phys_addr_t;
#endif

typedef phys_addr_t resource_size_t;


Is my understanding wrong? Could you correct me, please? Thank you very 
much.

config: i386-randconfig-003-20250101 
(https://download.01.org/0day-ci/archive/20250101/202501011917.ugP1ywJV-lkp@intel.com/config)


I compiled it as a KO module for an experiment.
__umoddi3 and __udivdi3 is similar to __udivmoddi4.

u64 bar_size;

iters = bar_size / buf_size;
remain = bar_size % buf_size;

zhb@zhb:/media/zhb/hans/code/kernel_org/hans$ make
make -C /media/zhb/hans/code/kernel_org/linux/ 
M=/media/zhb/hans/code/kernel_org/hans modules
make[1]: Entering directory '/media/zhb/hans/code/kernel_org/linux'
make[2]: Entering directory '/media/zhb/hans/code/kernel_org/hans'
   CC [M]  pci_endpoint_test.o
   MODPOST Module.symvers
ERROR: modpost: "__umoddi3" [pci_endpoint_test.ko] undefined!
ERROR: modpost: "__udivdi3" [pci_endpoint_test.ko] undefined!
make[4]: *** 
[/media/zhb/hans/code/kernel_org/linux/scripts/Makefile.modpost:145: 
Module.symvers] Error 1
make[3]: *** [/media/zhb/hans/code/kernel_org/linux/Makefile:1939: 
modpost] Error 2
make[2]: *** [/media/zhb/hans/code/kernel_org/linux/Makefile:251: 
__sub-make] Error 2
make[2]: Leaving directory '/media/zhb/hans/code/kernel_org/hans'
make[1]: *** [Makefile:251: __sub-make] Error 2
make[1]: Leaving directory '/media/zhb/hans/code/kernel_org/linux'
make: *** [Makefile:10: kernel_modules] Error 2


Best regards
Hans


