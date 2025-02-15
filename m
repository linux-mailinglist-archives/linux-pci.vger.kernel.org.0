Return-Path: <linux-pci+bounces-21541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0793A36CB0
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7022F1895DB8
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982319CD0E;
	Sat, 15 Feb 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AqWtYMvx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CB18A6B2;
	Sat, 15 Feb 2025 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739609878; cv=none; b=SX4PwO50FfXnN8e83P9rYWwYN1cV7tM7ODJrS+y+0vxh6WHvNUr6Y/BdVKVKZU9jGCrSKIpO5sSloVp0KcKrV2J5+lvlxkdLzopJY3aKmga5YLfVpxbo4J7kZgjwsYv2sx+Ps/xWvVF7iesA3jPqj9ygsrcQBeK6Ph2Y957ezrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739609878; c=relaxed/simple;
	bh=sbwGZyv9X0Po+KkuluhniU/1WUmWid6BRFjGaL526F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI56uQs06Wc+lQtJP6di04tcDj8KHknvEUwRtQ3y5La7cjzU5da+ga6YbBm0cgVLttl20BmSAwmzQ3NtXAPSnMWpuvQKUxqeghbRfSp3jntl1MyJcjXFJxhJauaQqpI9pXuLimtsLRE5xTG2ZUqL3iyMxuPcNTiAonVqmumsQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AqWtYMvx; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id jDyatDMKf7l8CjDydtPWfW; Sat, 15 Feb 2025 09:56:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739609804;
	bh=cDNKpgF1HWWNXJE5an9qyoAV+9AWpgKwxsYibXyf3gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AqWtYMvxx7m8Fe1xTn36MenTl3g6GgZoKn1Ov9XqPlwI53tbW1rAJ7H3grjgey4Fq
	 EXJsYqtuTuMfkHIRIkxfCmVjFUm1xp7KahNo1TBNkNBLXb9QkWJIwulG8cpVNwEqKp
	 BhYwQwUWQ8Lcs35kabVQVY+VM/ddSzRT7RxNOIjY4vqPAxxViRmgQaq8WAOa00XTr3
	 zRBUAYUHSCMYFygTzQlgD6I3zQ2y8FSgJyoXJRSSlx4rVf0eSrooNUiG+tRgEefpcr
	 5BucV9Hp0tiW3Qor1z3vHoJAE4DNUbHmH5Oz1OMUKJE2KwjGu88P+3gjIoQwtTpXcV
	 +8/ZzoL/XvB8w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 15 Feb 2025 09:56:44 +0100
X-ME-IP: 90.11.132.44
Message-ID: <ebf3ee33-3958-43a7-8bd9-fe6169ad6a9f@wanadoo.fr>
Date: Sat, 15 Feb 2025 09:56:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] PCI: cpci: remove unused fields
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, scott@spiteful.org
References: <a1af3a07-1e76-488b-82f7-87b3a4907f26@wanadoo.fr>
 <20250215021054.222787-1-trintaeoitogc@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250215021054.222787-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/02/2025 à 03:10, Guilherme Giacomo Simoes a écrit :
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>> If neither get_power nor set_power where defined in any driver, then
>> cpci_get_power_status() was always returning 1.
>>
>> IIUC, now it may return 1 or 0 depending of if enable_slot() or
>> disable_slot() have been called.
> You is right... ever return 1, but, this is a expected behavior?
> Don't seems for me, that ever return 1 is the right way.
> 
>> I don't know the impact of this change and I dont know if it is correct,
>> but I think you should explain why this change of behavior is fine.
> I submitt this patch only with intention that save resources removing the
> get_power and set_power pointers and yours calls.

So, if unsure if the change of behavior you introduce is correct, you 
should only do what you wanted to do.

If you still want to propose the other change, you should do the 2 
things in 2 different steps.

CJ

> 
> Thoughts ??
> 
> Thanks,
> Guilherme
> 
> 


