Return-Path: <linux-pci+bounces-22135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E3A411FB
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 23:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706FF1701D8
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23051779AE;
	Sun, 23 Feb 2025 22:04:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4B39FD9;
	Sun, 23 Feb 2025 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740348268; cv=none; b=tp3cZp7W0Pd/Qihd4O1lKzphhLou/tAPcia1/v1anFGQI/JBU445Vu4EwCcshju6s0Te1cKJwxg0K6d+AxKNG88cr0mSLDynaHMNI3LoAyc0QMU54gEtNYhS6W/Xneh9R+7UQ9Mor7OMNixEdx5Hp/xtT6bEkZ0L/+DNrOGvc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740348268; c=relaxed/simple;
	bh=p9IxLekkjWvLHDuZZHTCsKA8qGYl9JXM6hV77OoFUgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmvGtrE2usC7LwLcVxW5m58BlFf8VW9v9jAp1KR7KdN21Y/PW8tJmqWr0ST2tivgKg0u1NTzTnZOUZ9coMz706LKd4g5tvEAKvxgo+RkDmkK+wS66KtU5V6nm4wEl83NPSicpbovkBx/H1pSovc0uJP+zNXOQTpqNyhWoouSUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2a7.dynamic.kabel-deutschland.de [95.90.242.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4ED9661E64788;
	Sun, 23 Feb 2025 23:04:06 +0100 (CET)
Message-ID: <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
Date: Sun, 23 Feb 2025 23:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
 <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bortosz,


Am 23.02.25 um 21:54 schrieb Bartosz Golaszewski:
> On Fri, Feb 21, 2025 at 10:02 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>>> What GPIO driver is it using? It's likely that it's not using the
>>> provider API correctly and this change uncovered it, I'd like to take
>>> a look at it and fix it.
>>
>> How do I find out? The commands below do not return anything.
>>
>>       $ lsmod | grep gpio
>>       $ lspci -nn | grep -i gpio
>>       $ sudo dmesg | grep gpio
>>       [    5.150955] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
>>       [Just these lines match.]

> If you have libgpiod-tools installed, you can post the output of
> gpiodetect here.

     $ sudo gpiodetect
     gpiochip0 [INT344B:00] (152 lines)

(In Debian the package name is *gpiod*.)


Kind regards,

Paul

