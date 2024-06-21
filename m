Return-Path: <linux-pci+bounces-9063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E991200D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074041C22FB0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7987A16D9DD;
	Fri, 21 Jun 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XSVkVAVA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2181C02;
	Fri, 21 Jun 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960739; cv=none; b=hXnh2d5+7WmW4K0azgH7LZicVIHJgbu3lscEna+ty0d3XO2kzvpr95rGeEPmMQAEBtN9iKey1zhj9LXoPmLGBL+d2FbfnvI3h/tXtMa5kOniOrjjFsEDSnk0KLyHazhGJ/5BmE3rY7yIR1idaXt15tkRWf0IKTeJVvF9YBJsZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960739; c=relaxed/simple;
	bh=u3vsruWw3m6yWhKiI6k/Bp6Kz8w7AjrzmFbFuOLhVYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3KcjybfRXq1d05YzNrV7oWNbkWgLEj/TuiodzasvSHGks1opNoISRV9RaUThRXTOCgksuTxzrOPFjBdcr4WemLoA1Rn9RPcVW9hwt8Ijanyl9nXzkeICY/fFraqxX7+2N2mOkHfeWMPiznIMFlEv5Xp4M9b4bIJEGyPM9O15yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XSVkVAVA; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=+JO4ER5bv9lk/4SoTsJyJX99aDmjGIgbmbYr1Bo8tQk=;
	b=XSVkVAVAsNqJ+96Z02pJ31GaBFNz9YN//CbiAY3xSDXlzW9DZRGpWkfLE6D4t6
	dY01mCKPdLNTRImIVZmlHRr2T4mAsCiZU1wET095pPdbUMdnFIB4fzTj6ORn8he6
	RwFAJ91fUibN1xiEzWdCOrk51MvJGOB/qS+XfaX2POMzY=
Received: from [192.168.1.26] (unknown [183.195.6.47])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDn1xgVQnVmlNLkEg--.36559S2;
	Fri, 21 Jun 2024 17:04:23 +0800 (CST)
Message-ID: <33c7587b-83a4-4be7-b00a-d30874df8c22@163.com>
Date: Fri, 21 Jun 2024 17:04:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: patchwork-bot+bluetooth@kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, kvalo@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 bhelgaas@google.com, saravanak@google.com, geert+renesas@glider.be,
 arnd@arndb.de, neil.armstrong@linaro.org, m.szyprowski@samsung.com,
 elder@linaro.org, srinivas.kandagatla@linaro.org,
 gregkh@linuxfoundation.org, abel.vesa@linaro.org, mani@kernel.org,
 lukas@wunner.de, dmitry.baryshkov@linaro.org, amit.pundir@linaro.org,
 wuxilin123@gmail.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 bartosz.golaszewski@linaro.org
References: <20240605123850.24857-1-brgl@bgdev.pl>
 <171889385036.4585.6482250630135606154.git-patchwork-notify@kernel.org>
 <0b144517-4cc5-4c23-be57-d6f5323690ec@163.com>
 <CAMRc=Mf2C4ywa+wQ6pcq5RtehQD00dDhzvS6sDcD8tAn=UypUA@mail.gmail.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <CAMRc=Mf2C4ywa+wQ6pcq5RtehQD00dDhzvS6sDcD8tAn=UypUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1xgVQnVmlNLkEg--.36559S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrW7tr1rWw15KrW8XFy3CFg_yoW5CFW5pF
	W3G3Z0kF4UJr18AF1jgw1fZFy2qw47Xw1fur1Dt3s8ZF90gr18tr1Sy34F9ry7urWI9r18
	tFWjyrySgw48urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWmhrUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiExoFNWXAlu3dLwAAsV

On 2024/6/21 14:36, Bartosz Golaszewski wrote:
> On Fri, Jun 21, 2024 at 3:14 AM Lk Sii <lk_sii@163.com> wrote:
>>
>>
>>
>> On 2024/6/20 22:30, patchwork-bot+bluetooth@kernel.org wrote:
>>> Hello:
>>>
>>> This series was applied to bluetooth/bluetooth-next.git (master)
>>> by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:
>>>
>> Hi luiz,
>>
>> i am curious why Bartosz is able to merge his changes into bluetooth
>> development tree bluetooth-next directly.
>>
> 
> This conversation is getting progressively worse...
> 
>> 1)
>> his changes should belong to *POWER* scope instead of *Bluetooth*
>> obviously, however, there are *NOT* any SOB tag from either power and
>> bluetooth maintainer. these changes currently only have below Acked-by
>> and Signed-off-by tags:
>>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
> 
> It's a new subsystem that has been discussed and reviewed for months
> and thoroughly tested. Please refer to the cover letter under v8
> linked in this thread. It's not related to power-management or
> power-supply, it's its own thing but IMO the best place to put it is
> under drivers/power/. And I will maintain it.
> 
>> 2)
>> his changes have not merged into linus mainline tree yet.
>>
> 
> This is why they are in next! They are scheduled to go in during the
> upcoming merge window. But since changes belong in multiple trees, we
> need a cross-tree merge.
> 
>> 3)
>> perhaps, it is safer to pull his changes from linus mainline tree when
>> merged than to merge into bluetooth-next firstly.
>>
> 
> It's not safer at all, why would spending less time in next be safer?
> 
it seems this patch serial(new subsystem) does not depend on bluetooth
and also does not belong to bluetooth subsystem, but have been contained
by tip of bluetooth tree.

why not follow below merging produce?
1) you send this patch serials to Linus to merge within linus mainline tree
2) luiz then pull your changes from linus mainline tree.

>>> On Wed,  5 Jun 2024 14:38:48 +0200 you wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Hi!
>>>>
>>>> These are the power sequencing patches sent separately after some
>>>> improvements suggested by Bjorn Helgaas. I intend to pick them up into a
>>>> new branch and maintain the subsystem from now on. I then plan to
>>>> provide an immutable tag to the Bluetooth and PCI subsystems so that the
>>>> rest of the C changes can be applied. This new branch will then be
>>>> directly sent to Linus Torvalds for the next merge window.
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>   - [v9,1/2] power: sequencing: implement the pwrseq core
>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/249ebf3f65f8
>>>   - [v9,2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/2f1630f437df
>>>
>>> You are awesome, thank you!
>>
> 
> Why are you top-posting anyway?
> 
it is caused by my bad mail client settings. thanks for reminder.
> Bart


