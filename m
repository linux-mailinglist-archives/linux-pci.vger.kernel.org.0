Return-Path: <linux-pci+bounces-38678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB8BEE7DF
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC3B189AB32
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F562EB84C;
	Sun, 19 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UhuGRoKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DC2EB5C8;
	Sun, 19 Oct 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885644; cv=none; b=qBzJGRGLHI32bI5jaGPBnXVxc7CmOK0qAebO4BKnvjnBIUc3PEduKQ/sdH2GPa97BjHS2p5X6kO5OqtKTnUSEJX73/9BbGpdgAIqCXWw8OZeVkI8aj8n2KRYhgXD12/u3xG6hrWVjxByFRShuXvn/f7QpAdMBy4X3NgKTGD4qGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885644; c=relaxed/simple;
	bh=Fcy3UiOvMV1v627YIH3VVJY+mYw0xwJqHjOMyS0Hb/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIVDL7LDot3fCojWP8XIUOVLNrqRzG+gR8uPbJxF/OP75yShXQO59pC1VdsyoTh/8HBe86JaYsz8pRqHoEv7QFgdENG1gJiMGWKeN5NZeg9hqaKX9zcc3xJtMN9T2DKhJY8Q6wYu3YqqUbIRK/LghyXrKX+oOrNYlbQgZAlbTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UhuGRoKI; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id AUebvZVGoUjXQAUebvcVLF; Sun, 19 Oct 2025 16:45:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760885103;
	bh=GdesLHGEaV1JBZuqmJbDS/jaBfHZjxT8ElBdzLC3Tqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UhuGRoKIJrtlw0wUNoGko+gmYwvyO2Ue7rnSET3mQKJWF7PgHrnsQBQIm5ntnnAks
	 Uubj6NYKVxBD8HHQvM8NEchfP4xsXSjehpzipA2S0JRY4AfXTZO6L2zTjTrQn/P6oC
	 hWQpEJaDjzdnQ4pPZ90dzpXL79Ttiv+FA1vYtKdxnLD+whQBjsmhZ/Y2wjWc8uFphj
	 zV/ce3i10/gDpU327tMMz9w/1m6FtQxiXTP0sdSSlqqR5RWvRCMoyNZUmVk4aeUVp/
	 2ovcvr1cciV0tL0U4xhoqAx6+mfy6RzRH0MXo9tBYcequ07bul60gPvjXDca6K+/vI
	 F7rB+ZwD8sIzA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 19 Oct 2025 16:45:03 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Date: Sun, 19 Oct 2025 16:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: j721e: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20251014113234.44418-2-linux.amoon@gmail.com>
 <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
 <cf656a57-bb2f-447e-ac6c-0ab118606dc9@web.de>
 <CANAwSgT0jSQ3pFR3MQo-ENziqrm=yn-rFBTdHegmknMeFd44OQ@mail.gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <CANAwSgT0jSQ3pFR3MQo-ENziqrm=yn-rFBTdHegmknMeFd44OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/10/2025 à 12:15, Anand Moon a écrit :
> Hi Markus, Vignesh,
> 
> On Sat, 18 Oct 2025 at 16:12, Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>>> I propose to take another source code transformation approach better into account.
>>>> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075
>>>>
>>>> Example:
>>>> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller/cadence/pci-j721e.c#L444-L636
>>>>
>>>>          ret = dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie), "Failed to init phy\n");
>>>>          if (ret)
>>>>                  goto err_get_sync;
>>>>
>>> No, the correct code ensures that dev_err_probe() is only called when
>>> an actual error
>>> has occurred, providing a clear and accurate log entry. …
>>
>> Where do you see undesirable technical differences?
> 
> The primary issue I wanted to confirm was the function execution order.
> since cdns_pcie_init_phy within dev_err_probe function
> 
> If other developers agree with the approach, I will modify this in a
> separate patch

This other approach is just broken.

Using:
	ret = dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie), "Failed to 
init phy\n");

1) is hard to read and understand.

2) would log an error message even if 0 is returned. This is just wrong.

2 good reasons not to do such things.


You should ignore people that are already ignored by most people on 
these lists.

CJ

> 
> As Dan Carpenter pointed out - " Wait, no, this doesn't make sense.
> It's just assigning ret to itself."

Yes, Dan is right.

> 
> This patch seems irrelevant to me as the return value gets propagated
> to the error path.
> Sorry for the noise. Let's drop these changes.
> 
> Since I don't have this hardware for testing, I will verify it on
> another available device.
>>
>> Regards,
>> Markus
> 
> Thanks
> -Anand
> 
> 


