Return-Path: <linux-pci+bounces-9081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF7F912880
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF31281669
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7E3D967;
	Fri, 21 Jun 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRkhnmnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075C40856;
	Fri, 21 Jun 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981498; cv=none; b=u+noky3VHdYlZ77RaXbEz/hbW5nrhY9NSdyu4FfWoL1UhSTZsDWXfnXfM1TIg+eCMLNOB64h574lBf1zXAAdmmkkeqyUo9MCpIqlVqC0p4DAkv5wa0uWnQSY2k3L7eVpZfX+dg16EFfLZy6zkdsE6lKkUEP8/aHP1/8uC6GYcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981498; c=relaxed/simple;
	bh=PWBnsEgyaL0bjk7qBCzE5I/+8Xv0QHE5d/sqa4h1zPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k++Pn9bpFKbzto85Ho5xM5wuoa746scS7Y/FMfKkHKc7s0lL+rFolKaLOBvLCe6807rlkilSljcy5de5mNHygaltm/esTjhX2KlWwTQmlmTH0cRSislU3YmTPg6v3TdMLYFRut3Of1b7jG9QCQvAs9YHbr5Ukghaaf1q1mE0/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRkhnmnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A0BC2BBFC;
	Fri, 21 Jun 2024 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981497;
	bh=PWBnsEgyaL0bjk7qBCzE5I/+8Xv0QHE5d/sqa4h1zPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRkhnmnS6CfFLtlnO3HtF8upTistPGil7dXFYtmncde0D1Gtbfe8a2SsWApXco8Om
	 Q0hvJNHMoeAOtJfuS+E0pJ9nAH0fgcWpePytj88zHlL2zTKxbzDyKzrkTlA0aFtXTQ
	 nMxozbWi5Z0sOvywYttURAhhmFjVxbZcIKkitWBlOTzQWHGu5cjaug4VIkcmuCJHgD
	 +M276skqav2Deq6H0hI6X6Brscw/7iDN7IyWfhqaV8Wy5kqA9q/V6GGTWFbevW9aYE
	 6Wm+013DCA9nAR/oqtM10UROLPOf8NPGcJsNW4xtWVaPXINaJIZsh5phpoVDggNang
	 tIvAu8Pm8q7fw==
Message-ID: <47d156dc-0b80-4e87-9fba-4232ee8235b9@kernel.org>
Date: Fri, 21 Jun 2024 16:51:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
To: Lk Sii <lk_sii@163.com>, Bartosz Golaszewski <brgl@bgdev.pl>
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
 <33c7587b-83a4-4be7-b00a-d30874df8c22@163.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <33c7587b-83a4-4be7-b00a-d30874df8c22@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/06/2024 11:04, Lk Sii wrote:
> On 2024/6/21 14:36, Bartosz Golaszewski wrote:
>> On Fri, Jun 21, 2024 at 3:14 AM Lk Sii <lk_sii@163.com> wrote:
>>>
>>>
>>>
>>> On 2024/6/20 22:30, patchwork-bot+bluetooth@kernel.org wrote:
>>>> Hello:
>>>>
>>>> This series was applied to bluetooth/bluetooth-next.git (master)
>>>> by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:
>>>>
>>> Hi luiz,
>>>
>>> i am curious why Bartosz is able to merge his changes into bluetooth
>>> development tree bluetooth-next directly.
>>>
>>
>> This conversation is getting progressively worse...
>>
>>> 1)
>>> his changes should belong to *POWER* scope instead of *Bluetooth*
>>> obviously, however, there are *NOT* any SOB tag from either power and
>>> bluetooth maintainer. these changes currently only have below Acked-by
>>> and Signed-off-by tags:
>>>
>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>
>> It's a new subsystem that has been discussed and reviewed for months
>> and thoroughly tested. Please refer to the cover letter under v8
>> linked in this thread. It's not related to power-management or
>> power-supply, it's its own thing but IMO the best place to put it is
>> under drivers/power/. And I will maintain it.
>>
>>> 2)
>>> his changes have not merged into linus mainline tree yet.
>>>
>>
>> This is why they are in next! They are scheduled to go in during the
>> upcoming merge window. But since changes belong in multiple trees, we
>> need a cross-tree merge.
>>
>>> 3)
>>> perhaps, it is safer to pull his changes from linus mainline tree when
>>> merged than to merge into bluetooth-next firstly.
>>>
>>
>> It's not safer at all, why would spending less time in next be safer?
>>
> it seems this patch serial(new subsystem) does not depend on bluetooth
> and also does not belong to bluetooth subsystem, but have been contained
> by tip of bluetooth tree.
> 
> why not follow below merging produce?
> 1) you send this patch serials to Linus to merge within linus mainline tree
> 2) luiz then pull your changes from linus mainline tree.

This is not how Linux kernel development works. Read process documents
before interfering with people's work.

Best regards,
Krzysztof


