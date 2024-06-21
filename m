Return-Path: <linux-pci+bounces-9051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E59117EE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 03:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA1D28395A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F774D5A5;
	Fri, 21 Jun 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SK5Ji/kn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFD3214;
	Fri, 21 Jun 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932557; cv=none; b=neMPkMe+l1VeAsJKD1jNO6lBpmfhpMHh/Ll0Se5i9GEnD8NR5iQjtVpPdlpN18hpMxGuKcKD+IT3NawUd848TJprOSG80zU6q9m4s8bZMjzQKsjUk1GVuFvN15EoimcTGsgumtp7fJOGr7iLRcrULB/yaPR7+CAMqBEEZf6cxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932557; c=relaxed/simple;
	bh=IABB4tHTtsIHnF9E/p0KMPVd0BwdXUuqJPhJoQzkufw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa1Zp0Bl9IcPFojM/ybZFFS/ui1cQcyHq2sgeb9tytBXPzWUVAaxacuN+yQFApr9gZ4kiGfHN+iqD1DPCafLyvag+0Xqrjrcw7bJ1pPNWTYRVGv97rFomkko3ZleAfj8OX7t2k57BzT3lJ8yjGDFEkttEL52AO5FO0AX9pegpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SK5Ji/kn; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=uKgyUTPoIa0HOFwQLliApvt6PD0XnAuEcNuHZ585raA=;
	b=SK5Ji/kn4sI1W96ZdXt9fW1P5hOX4F2KHB22JEH3nru2ent6WnGuiVcUM3+v0a
	bz9M9Qf+J4VL5kkplzHMaz4Y0yy0w64OlFXuFeXgwHfk4GUOyJ9cw9g4q51ZaSCI
	CqKwtoz8Qd3UzzG9zobudai70VLBl+CvzNMiIi4Bazkpg=
Received: from [192.168.1.26] (unknown [183.195.6.47])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wDnT3z203RmODBWCQ--.32395S2;
	Fri, 21 Jun 2024 09:14:32 +0800 (CST)
Message-ID: <0b144517-4cc5-4c23-be57-d6f5323690ec@163.com>
Date: Fri, 21 Jun 2024 09:14:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
To: patchwork-bot+bluetooth@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
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
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <171889385036.4585.6482250630135606154.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnT3z203RmODBWCQ--.32395S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur18uFykGryxtFW7AF17trb_yoW8Aw48pF
	W3K3Z0kF48Jr1UJF4DKw1fXFy2gw43Xw1xCr4Dtr98Xa4Ygr48tw1FvwnYgr17urWI9w42
	yFWftryfKw48urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWmhrUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiExkFNWXAluX0pAAAs8



On 2024/6/20 22:30, patchwork-bot+bluetooth@kernel.org wrote:
> Hello:
> 
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Bartosz Golaszewski <bartosz.golaszewski@linaro.org>:
> 
Hi luiz,

i am curious why Bartosz is able to merge his changes into bluetooth
development tree bluetooth-next directly.

1)
his changes should belong to *POWER* scope instead of *Bluetooth*
obviously, however, there are *NOT* any SOB tag from either power and
bluetooth maintainer. these changes currently only have below Acked-by
and Signed-off-by tags:

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

2)
his changes have not merged into linus mainline tree yet.

3)
perhaps, it is safer to pull his changes from linus mainline tree when
merged than to merge into bluetooth-next firstly.

> On Wed,  5 Jun 2024 14:38:48 +0200 you wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Hi!
>>
>> These are the power sequencing patches sent separately after some
>> improvements suggested by Bjorn Helgaas. I intend to pick them up into a
>> new branch and maintain the subsystem from now on. I then plan to
>> provide an immutable tag to the Bluetooth and PCI subsystems so that the
>> rest of the C changes can be applied. This new branch will then be
>> directly sent to Linus Torvalds for the next merge window.
>>
>> [...]
> 
> Here is the summary with links:
>   - [v9,1/2] power: sequencing: implement the pwrseq core
>     https://git.kernel.org/bluetooth/bluetooth-next/c/249ebf3f65f8
>   - [v9,2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
>     https://git.kernel.org/bluetooth/bluetooth-next/c/2f1630f437df
> 
> You are awesome, thank you!


