Return-Path: <linux-pci+bounces-38587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF1BED23B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51EFB4E332D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D11F4CB3;
	Sat, 18 Oct 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G+wS4fHT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120F354AF6;
	Sat, 18 Oct 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800412; cv=none; b=KSBOhRa/t14+oUopHDq9Z+hDaw1CtD9AFtw7/JntXpLmXp+EW9STR4uY1/0bhBxHyimzIPiv/+o5UIzP9zDMUTxVw97VP3kCZh4rNJKaVQ+9hU0p3dW8mero9OI9XDSEmCw3CbGpd5DJOH3XswICnSwQwivh86aoffJO/m/gymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800412; c=relaxed/simple;
	bh=WpJOk8273WarkBLeeD1/RMTorMEOzijI3jpOj3I76Rw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=K5y+c5gMKwYvu6lO32M+0MZhj7FAt0vV9ohm1zcUF5k1E0LwNzwX5K/9ft+yp4YJV7PrpaqaToKoQ8M7EOtdr3SPOMgJrdQpbfzKxShh+vRI2bcSvHzFWNQweT8vUbNQ2DeTpS/TX8DYcx/s6qyPpPzv1Fbnd1UduDkjvw+FEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G+wS4fHT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760800401; x=1761405201; i=markus.elfring@web.de;
	bh=tahaKIp2+xLMQWhA+uqytB55o4PYq7W8M97T8Hw6Pic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G+wS4fHTspmIaUbH0q5NKWLeUtI4NIy4szIMJCVtr+tV4EJMV8BUs6tfl3BEJBk4
	 p6rHIDsJeyX+t47AZajCvt9saZX0nq4K3Lcu0qRY7pQizjcg9P2LWj1YoWmZINyOl
	 UbnBMe53nArxXr+r2brreEMGkEHFW2VwqLOokPtOeWrDcjDjc4QhhVjqDB1WKPbgL
	 compY+vXaQchrkZDrB95R+x9TNopHWxt4hlcmiKsmNT9vS7iDrBNrF3/94jhhGDdb
	 DFHlsfA8nSJFC1YaNX5sAQVC8xdWkDCsQxI+YCSfpuPl5xZV3VVlEQV3afr3G3cZW
	 LRkUS2F3Ms644S0bMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS13n-1ul8jC33AB-00POkk; Sat, 18
 Oct 2025 17:13:21 +0200
Message-ID: <841b701a-ab6f-463e-b344-b3d9ffa34d76@web.de>
Date: Sat, 18 Oct 2025 17:13:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
References: <20251018070221.7872-1-linux.amoon@gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Propagate dev_err_probe return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251018070221.7872-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sfqPZqz+8StRXPekD4vxZaQB15ICeBRLtqFa54KJhXp6y+wjBCA
 /wBt3YYHvvV83ILx7JAywUQNCHM9HPqU0JI45Z4023Bs2JOcrXsqMDjNAS5/8vGdIl9CS+D
 NRmMU3eLwvCTMuplwG55R8OCG5PZSbdUkXGMf+OsILwVk+pmumcea81hLBBdmghqzVVvQW4
 PXefNnkJLAfovRD80KuAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aulaklkXjMc=;wLnqyEf4lTA5E16BJwRwC8TOy1d
 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
 sjAdA==

> Ensure that the return value from dev_err_probe() is consistently assigned
> back to return in all error paths within pci_pwrctrl_slot_probe()
> function. This ensures the original error code are propagation for
> debugging.

I find the change description improvable.


I propose to take another source code transformation approach into account.
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075

Example:
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/pwrctrl/slot.c#L30-L80

	ret = dev_err_probe(dev,
			    of_regulator_bulk_get_all(dev, dev_of_node(dev), &slot->supplies),
			    "Failed to get slot regulators\n");
	if (ret)
		return ret;


Regards,
Markus

