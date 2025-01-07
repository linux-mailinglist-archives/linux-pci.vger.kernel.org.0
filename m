Return-Path: <linux-pci+bounces-19447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C0A045AC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7133A07E6
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A51F37BA;
	Tue,  7 Jan 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nSjOwsyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C41D8A16;
	Tue,  7 Jan 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266393; cv=none; b=lZVN+69MLrQTRP2dTiOL6tRngCIgPm76sT5X0kFr5C3mHyU1BF42rnYrngluhM2Ug8DLYCqt3WQ946T3jyMdwspYVpL/kpAY47p7Knq27VYkh0tkFSBkzSwMBTX6b/VEjR+To5whPh2OzwrqEvWKzyTx/WWfBUM5V8zbDNpH3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266393; c=relaxed/simple;
	bh=mCmKImQZ3wKS4nQFwaxRzVARWb2QABbjzcS4o4RDWZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLCRIIIbXTWjdXyumH4Uj39+ggCl83TrteWJMpgDhKtyFTDp2zGY3MLNXZKBF0UrCfoUyzjkIlpjtGKdsndOQ5XwlOGzhydGFLIIwNtbZzXwTSQHYv4NQSndBYOT8YtGd630dfaD+6Y23XAo3HwYJD2xCTfDQRpntr3+67dr1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nSjOwsyO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Lepz70U7qaEkKwGyssvZ8Fck4N7cLlwe0J2reouXAV0=;
	b=nSjOwsyOLx5JIHXOG2+fC75Cn1ubCx2CzKzTmdm72Fcan2R+HUj9pErZSbojvi
	riYTNexzFMyTWPYQKnmUikkdRXRJ+lVqSMTeiqd6cJ2m8QooZYukmsoTAoctGn0N
	j3RYJHEBBNhJ9WkRw+lUu6zl0O+O4raQvPG4XkEwsHNXE=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3Xy1wUn1niMkjEg--.4453S2;
	Wed, 08 Jan 2025 00:12:33 +0800 (CST)
Message-ID: <58a23cfb-190f-44aa-a06a-d496cc252fb0@163.com>
Date: Wed, 8 Jan 2025 00:12:32 +0800
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
 <Z30UXDVZi3Re_J9p@ryzen> <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com>
 <Z31O8B14sKd5eac-@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z31O8B14sKd5eac-@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Xy1wUn1niMkjEg--.4453S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1xAF45uryrAF1DXryUGFg_yoWkJwb_ur
	y0v3yqkw1UG3yUGFs7WrW5uFZ0qa4UWa48Aa48XrZ3G34DXrWq9F4DKr4Sqr1xCrySk3Z3
	tr4Yk39Yg3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0pwZUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxzNo2d9TGrUZgAAsz



On 2025/1/7 23:57, Niklas Cassel wrote:>>> The error:
>>> drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
>>> sounds like the compiler is using a specialized instruction to do both div
>>> and mod in one. By removing the mod in patch 1/2, I expect that patch 2/2
>>> will no longer get this error.
>>
>> The __udivmoddi4 may be the way div and mod are combined.
>>
>> Delete remain's patch 1/2 according to your suggestion. I compiled it as a
>> KO module for an experiment.
>>
>> There are still __udivdi3 errors, so the do_div API must be used.
> 
> Ok. Looking at do_div(), it seems to be the correct API to use
> for this problem. Just change bar_size type to u64 (instead of casting)
> and use do_div() ? That is how it is seems to be used in other drivers.
> 
> I still think that a patch that removes the "remainder" code is a good
> cleanup, so please send it as patch 1/2, you can be the author, just add:
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> 

Thank you very much for Niklas' discussion on this patch. I will 
resubmit two patches in the future.

Best regards
Hans


