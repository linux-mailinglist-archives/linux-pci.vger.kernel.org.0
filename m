Return-Path: <linux-pci+bounces-22718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99401A4B252
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 15:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0583AD772
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0231D5166;
	Sun,  2 Mar 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O+FjuFP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763A182D7;
	Sun,  2 Mar 2025 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926501; cv=none; b=MPpo24XK0w1ekjaUUmxdvSzbO3sKSjnkFpk2OHhl3hflrcxNuCA9NaRNNx9a40r0UWv0jv1HVXjduWZPd3knj5UkBAv/S2+i+05bWw/j7VeVIebkdTOT2LdRp18dBTFrhfm+nv9+86oCzSX4UBFKxdC89XniOUDQXYGhCxQoyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926501; c=relaxed/simple;
	bh=GRlMheDReycCviW+fQurBRQGEioTQ3C6orvIa2EkbnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTZ/KFIxt56rkBA+gbjIENXhqVtpPloPphAb7IWNimZkUkgmnVZJtCU/r/XtJ0TgZ/rMxDarTMZJpiWB/amRpgnTASN4Rx+XTneeyCcai7D4tTvwjHFCXG+xLmkLP0+dcBzacZag/Chqw5/ODc6Z1OxX7z5JMB/ZJC/09WuBBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O+FjuFP6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wAkIyPtRtMjcXj5+bNVpLP3WTBKmv43Mltx8AWZztzg=;
	b=O+FjuFP6blm4sXW0eU5HNk0AEzwmho2+0pgTkk6gBYqIWKI5e3/JrqZhVnEHVS
	0KFqp38axO4LgNe44uZQjcsQYSefayty2zhDjNRUaxSq+RzkD6oxlWKk8k9vjpEl
	WNWfwIPqlCGm7+4+ZTW6a+AOvWYSdIvepNoocwm/5Yytk=
Received: from [192.168.71.45] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnIY3ebcRnhxGGPg--.51424S2;
	Sun, 02 Mar 2025 22:40:30 +0800 (CST)
Message-ID: <b4473e85-4695-473f-ae62-8d152df4585e@163.com>
Date: Sun, 2 Mar 2025 22:40:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] genirq/msi: Add the address and data that show MSI/MSIX
To: Thomas Gleixner <tglx@linutronix.de>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kwilczynski@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250302020328.296523-1-18255117159@163.com>
 <87ldtncyge.ffs@tglx>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <87ldtncyge.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBnIY3ebcRnhxGGPg--.51424S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45Zw4fuFykKr4DCr4xXrb_yoWxZwcE9w
	s8tr1Durn8uan2ka15K3WYkF9Ika129Fy8XF1xtr1ayFn8A347GFsakrn8Jwn3WrnYqr4q
	k398ZwnFvw1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbfWrtUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUEo2fEaZRdiQAAs3



On 2025/3/2 22:13, Thomas Gleixner wrote:
> On Sun, Mar 02 2025 at 10:03, Hans Zhang wrote:
> 
> Previous comments still apply.
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202503020812.PKZf7JBa-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202503020807.c3MhmbJh-lkp@intel.com/
> 
> That's wrong. You are not submitting this patch as a response to a
> report from the test robot. Reported/Closes makes only sense for a patch
> which fixes something existing, but not for a new feature or functionality.
> 
> Thanks,
> 
>          tglx

Oh, I misunderstood. Thank you for reminding me.

Best regards
Hans


