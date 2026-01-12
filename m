Return-Path: <linux-pci+bounces-44544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B9D14ADE
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD251307AF9B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826413806B7;
	Mon, 12 Jan 2026 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euthEPt+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2137F736
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241269; cv=none; b=Ws1fuXi+o3NQN9aiEK6xMO8CJR1wWt48mfYHC0mPVWbK702HolKZsmsZ9IL3u423safFT9/tyU4W+JCxNBB1SOSvm8h0jDYJJ7izWSDScBbGnlaV4G9mqANm0WM6Jq+kuf+noG3yXEPOkYQ6BbhFxXwQYtUAWihLiiRFMyGk3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241269; c=relaxed/simple;
	bh=GDmnYXdvHq4uW1Az2cjRJhxn2kOSku+cESL1B1kLI2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+pLjvAMltZA88ZyMF/d90/5NjdL2q5dFIWlTQ9hF7r1Fx2XYooxdrecC4cfvWlAgEJToU+5+t2+xZosZqlt/8Wuqux8GVFZ8Ruz4yEZMIULxrbJv7Oomj7rJdXmLrxX7cIt6Ajo6QG8XCw71u/7qJTjRKye4NkahWJSn4CdAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euthEPt+; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b04fb5c7a7so6065064eec.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241266; x=1768846066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jLjh1P6W/4FZXrNde0M8mZ0vPLZ29HC+C16qi1BvzVA=;
        b=euthEPt+JijU7HqBSmY+mMndMvGrXMPqW31nQUBsu/8ag7A2vvkTp9LC2u7h1QF6kd
         3uiuuuuH4MniDabXMZFYr2sGYfXxhUp3ePIioKC5L9xL7VLVe70WE+GUdLAIKnmIh7cV
         3XsQgwdhdGotyZIGF1RleMFczadZvei3V41kgFDhI/Vl6hq1+yj/Hi17YvenFa53Ur+E
         OpmcTHiln0onXYQdWCE7Iy29cqvnRpYMo7nbOwOFq7IW8ss6f+shdAwhMmwE0jLqcXek
         f3dtKN7QTzOwmePStpCKOQfIYfG6KM7cgi+/Yqj77YKc3TIyH+6r0XQmE9zNe3yzBt51
         YD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241266; x=1768846066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLjh1P6W/4FZXrNde0M8mZ0vPLZ29HC+C16qi1BvzVA=;
        b=EDQKJYrO7H6e9Bu8mo4L1UWAQYKIZ8NuBkigmrTPNxAspOU3jMBYUnzwjSYwD2bZ4D
         TgL08NbqD9ic/wN/RAoonY8trDKaFVQQm9bpljHpkfwebMxInEFA+hExLL/rZdOJ/tL+
         xPXMt3k2gRgSxfbLuabzdOE9zUQsVBhAVGKy5W4tykN9QVeWjsrT/KXyLVBeDztJLpax
         SK/TYetFmAVqYUr9O1rtrg1EQp/QnmDup6jz2Rl5Ib3fEdhKUuRaqXqXWNvZ0v7RIvix
         QEValimQJZCmlBc7kEr3xz+LojqlAwLJQ7DBEE/JtZGq+rgfIiJb93qtmVE1u+ajpg87
         FW6g==
X-Forwarded-Encrypted: i=1; AJvYcCUcHD1LPudaVuTzoVveLvcSJ3DZ6SCqyGg1IO0DuEQsCE86HW65Eyt/geHkUf36f4QT8W0AMjYO8x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgxWCuqOkSGspqXInc+z1IVyMOwKehMI9jwXId16fy/6Km4iT
	sA+zLOTAjQmivSTXGtXdUfRnYiWaEsjIBoQEbrewAOWyj0BGSQ5/TJuu
X-Gm-Gg: AY/fxX66/uMtiWAens8dUdYJ8jxNWOUQifKIJ8mavOy3n5ZmMZiymYZFeQ+UnLVYdiF
	WzUXNP6o73ntQ8h7Qa+LpsHWkzi9c7yVLIq/u0z6NwJU+TafBFlFRdfvIyrpqeUK/xEjkSTqoqG
	mHDlVfr56RpHZs1yakZv/UkLIFD8RfZ9D94i3uO/l4USKcH6ClqNiSn/Ec3pTGIPxKnkAoSW+W4
	tkGjYPukR0IgR8Uo+ewYgfL08Qvir5f7APd+8s6Dydy7UvQ40xT9Ht/CZfJzU/ZyMxNIvPQ0b0i
	fiuD4jwfjiBGfWnGbfjFj7JGEeqp2ehIUOdaDqGp/BK8UXJXci6yErdJywtRJbQ0sFa/GdofGwQ
	fxJHXpI0ksGE0B8oRcxj5byqMkkvoo+ULCiZpbXiMTG11e3foAt6he1KPQHkkcZAl9WTjWpI+xf
	t2JaAck/cmnULkFUURxoIWUvonMVaf4iaidIlUOQ0SedUwe5MJGOrzlHv9hegL
X-Google-Smtp-Source: AGHT+IEq8llJoSkp6xKGWa1lTBFBhXra0w2au9jKVfJm2Zx4SMyFukCn7Xrwe+tloV96m93ssiYOOQ==
X-Received: by 2002:a05:7301:711:b0:2b0:4ae1:b4ad with SMTP id 5a478bee46e88-2b17d238b4bmr12209580eec.3.1768241265602;
        Mon, 12 Jan 2026 10:07:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b3c44sm18319019eec.28.2026.01.12.10.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:07:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9ace6290-8ef8-4158-b48d-fcd841910a23@roeck-us.net>
Date: Mon, 12 Jan 2026 10:07:43 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: spd5118: Do not fail resume on temporary I2C
 errors
To: Armin Wolf <W_Armin@gmx.de>, TINSAE TADESSE <tinsaetadesse2015@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20260110172003.13969-1-tinsaetadesse2015@gmail.com>
 <d08f3edd-f5bd-4e6b-b174-e768d42df281@gmx.de>
 <CAJ12PfOP_ddk=nqaSDrravpgOYK3eTND24MaXo9RyzdN7cXLfA@mail.gmail.com>
 <1a107aaf-c1c1-46af-98a8-03eae1bb9db2@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <1a107aaf-c1c1-46af-98a8-03eae1bb9db2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 09:41, Armin Wolf wrote:
> Am 12.01.26 um 12:48 schrieb TINSAE TADESSE:
> 
>> On Sun, Jan 11, 2026 at 1:27 AM Armin Wolf <W_Armin@gmx.de> wrote:
>>> Am 10.01.26 um 18:19 schrieb Tinsae Tadesse:
>>>
>>>> SPD5118 DDR5 temperature sensors may be temporarily unavailable
>>>> during s2idle resume. Ignore temporary -ENXIO and -EIO errors during resume and allow
>>>> register synchronization to be retried later.
>>> Hi,
>>>
>>> do you know if the error is caused by the SPD5118 device itself or by the underlying
>>> i2c controller? Please also share the output of "acpidump" and the name of the i2c
>>> controller used to communicate with the SPD5118.
>>>
>>>> Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
>>>> ---
>>>>    drivers/hwmon/spd5118.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
>>>> index 5da44571b6a0..ec9f14f6e0df 100644
>>>> --- a/drivers/hwmon/spd5118.c
>>>> +++ b/drivers/hwmon/spd5118.c
>>>> @@ -512,9 +512,15 @@ static int spd5118_resume(struct device *dev)
>>>>    {
>>>>        struct spd5118_data *data = dev_get_drvdata(dev);
>>>>        struct regmap *regmap = data->regmap;
>>>> +     int ret;
>>>>
>>>>        regcache_cache_only(regmap, false);
>>>> -     return regcache_sync(regmap);
>>>> +     ret = regcache_sync(regmap);
>>>> +     if(ret == -ENXIO || ret == -EIO) {
>>>> +             dev_warn(dev, "SPD hub not responding on resume (%d), deferring init\n", ret);
>>>> +             return 0;
>>>> +     }
>>> The specification says that the SPD5118 might take up to 10ms to initialize its i2c interface
>>> after power on. Can you test if simply waiting for 10ms before syncing the regcache solves this
>>> issue?
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>>>> +     return ret;
>>>>    }
>>>>
>>>>    static DEFINE_SIMPLE_DEV_PM_OPS(spd5118_pm_ops, spd5118_suspend, spd5118_resume);
>> Hi Armin,
>>
>>> Do you know if the error is caused by the SPD5118 device itself or by the underlying i2c controller?
>> The error appears to be caused by the underlying I2C controller and platform
>> power sequencing rather than by the SPD5118 device itself.
>>
>> The failure manifests as a temporary -ENXIO occurring only during s2idle
>> resume. The SPD5118 temperature sensor works correctly before suspend and
>> after resume once the bus becomes available again. This indicates that the
>> driver’s resume callback may be invoked before the I2C controller or firmware
>> has fully re-enabled access to the SPD hub.
>>
>>> Please also share the output of "acpidump" and the name of the i2c
>> controller used to communicate with the SPD5118.
>>
>> I have attached the output of acpidump as requested.
>> The SPD5118 is connected via I2C bus 14 and accessed through the Intel
>> I801 SMBus controller (0000:00:1f.4), which is ACPI-managed.
> 
> Interesting, the ACPI code seems to do two things when the i2c controller suspends (aka is put into D3):
> 
> 1. A unknown register 0x84 ("PMEC") is modified
> 2. The PCI BAR of the i2c controller is disabled
> 
> Since the PCI bar is not re-enabled during resume, i suspect that either the firmware
> is buggy or that the firmware relies on the operating system to restore any BAR settings
> when resuming.
> 
> I do not know how the PCI core handles suspend, so i CCed the associated maintainers.
> 
>>> Can you test if simply waiting for 10ms before syncing the regcache solves this
>> issue?
>>
>> I tested adding an explicit msleep(10) in spd5118_resume() before calling
>> regcache_sync(), for the I2C interface to become ready after power-on.
>> With this delay in place, the resume failures (-ENXIO during regcache sync)
>> no longer occur, and repeated suspend/resume cycles are completed successfully.
>>
>> However, relying on a fixed delay in the resume path is not robust and would
>> not be suitable across platforms with different firmware and power sequencing.
>> It also still performs hardware I/O during PM resume.
> 
> In this case the 10 ms delay is OK since the specification of the SPD5118 device explicitly
> states that the device needs those 10ms to become operational after loosing power.
> 

I would agree, but it seems to be quite unlikely that this is the actual problem
since that would mean that the SPD1118 is actually accessed less than 10ms after
it was powered on. That is unlikely even if the power rail to the SPD chip is separate
from the power rail to the DDR itself. On top of that, pretty much every chip has
similar restrictions. I really don't want to have to add similar code to every driver
because a power sequencer somewhere has a problem and doesn't add the required delay
after enabling power to a chip (or disables power to a chip before it is properly
suspended). We have to make _some_ assumptions in the kernel, and one of those
assumptions is that the chip is still accessible on suspend, and that it is accessible
on resume.

Worse - if the problem is the i2c controller, there is no guarantee that the 10ms
delay is sufficient. It may be sufficient in this case, but if the resume order changes
and the i2c controller is re-enabled even later than it is today, we'd end up in the
same situation. Either case, if the i2c controller is indeed the problem, trying to
work around that problem in the driver of a device attached to it is just wrong.

Guenter


