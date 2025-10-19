Return-Path: <linux-pci+bounces-38669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFDBEE14C
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28DDB4E0617
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3326159E;
	Sun, 19 Oct 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sycJXp1Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BE21A95D;
	Sun, 19 Oct 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864214; cv=none; b=EhUQkpFENFY/QaNaR/rDLQh7QG1wqxeBXiaAtvvysjX3IAutTKm4et1vxKfG03yzwIm/IjsYmmtC9HL9KdtdguVjiFD4Sd2JlBBJCtbguL1Xe9FIbPhLbW77VrjyNrOLYPOVRyXUqRat0w1LEEP8eZh51lDok4to5hOObIpDDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864214; c=relaxed/simple;
	bh=F4yNjb7tI1ozvJkQhdHpKPYkGxJeJtHnhFQ6CudX4oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHSPUCJbSiqpHP6Ii+UEHgz6hEENQekOcqpUQWKP2rXBCmi7HUZ0eApooAYAytxzyFIW7nBML3opSn6mVKM01ei0xWANOF5xQQ72r1BhIVBdKwk/2cTwM0SiYPUBXb/zn+dMJxjWIQL2AHwQTMw4ZkFHmMkHo7YowhBz73R5mO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sycJXp1Q; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760864188; x=1761468988; i=markus.elfring@web.de;
	bh=F4yNjb7tI1ozvJkQhdHpKPYkGxJeJtHnhFQ6CudX4oA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sycJXp1QNgy2N+NycQdc7mdlVfje1TCEMCbfpvCtRztQNGQREdp//HBziPZ3HN/G
	 tnSMkky5lCN3pIGrii9W9mnzkl82mFJUgz68nTDi36JNouBsUPrXom3Y86GnL5n5l
	 MYwh8RN7lvVd3RHr6RD/c+S6oWtLZQBwKxRAhrfiKhEWoMhumUimoPKzBakREa16I
	 Oxu1bXNg01OLbGBJVZObuIsRmhQoNy0iI0Omce9uoCkzsvCBWptXzu+FiKpMbUAXC
	 Hd4Pr/KygvwohkRQ5ezrLqGYj5e4R6y8F9OOEQKP8g8fnDbTgPVW3BkJPJoIjipee
	 MBt6tAxdsiwOLSciow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1uT3df0E5r-00cOON; Sun, 19
 Oct 2025 10:56:28 +0200
Message-ID: <e88cb990-bf11-40f7-9c71-b14614fe53bf@web.de>
Date: Sun, 19 Oct 2025 10:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI/pwrctrl: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr>
 <03a8fd58-cce5-4b84-adef-6cec235c582b@web.de>
 <CANAwSgRv6J864HF4Qqab_6qq96=8oKn0aHT5WjypUykgTJFmzw@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgRv6J864HF4Qqab_6qq96=8oKn0aHT5WjypUykgTJFmzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:naT4Lj7VTUsUfQDgQpc7P2+WPxQX8V1KWQKmnHQ17jXmTYQu/uG
 ouGO4PCS0OQyE8vMEeFMUeUFD7AcR2g4XjXP/eW47B1KaOgriTAS6aJQQBzx89QHfm2JfSY
 ocH8iabFOV2VQLKG2i90Y5vd26yNnCgWu0GuuHFObPR7KcqvJW5FcaBqd00e1ugQjp23r8n
 46I53EwzLOMXjYwCA6QCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P2SYemCjHaA=;i+mPjUcSs/DrtlHJPf/aHdkRnrz
 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

>> How does this view fit to the commit ab81f2f79c683c94bac622aafafbe8232e547159
>> ("PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure")
>> from 2025-08-13?
>>
> Thank you for your guidance. My previous understanding was incorrect.

Will an adjusted software understanding influence further collateral evolutions?

Regards,
Markus

