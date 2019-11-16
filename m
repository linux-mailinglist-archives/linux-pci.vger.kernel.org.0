Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB7FF5D5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 22:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKPVmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Nov 2019 16:42:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32842 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPVmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Nov 2019 16:42:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so7648355pgn.0;
        Sat, 16 Nov 2019 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQhXYCohXzHB1bZ2481yJdBtaYvkE/AnjVLZI+F8BEk=;
        b=mhBwANIWPAUMbiXbLLg/F437gJADuhe/M8UHHEaA7XNVpIyvbP11KzZHaaB+hfoPdk
         HBYS+o0u0FdKRlL236vJVwh2URceG+eabRGqNjKhTD7/gaUBewZ4+fME5ySbtc/8e9S/
         uTFmSIogQBxF3doFloWPU16EHos7MBALmweEML5B0CvSz8iCkojsgtqP/GBNivqbu1w3
         Fmpq//AlXnXQtmUCThgNVq0OpMUGDKrzemBHbVeuJysdsccdTBkcdB9L56is5ghyeSZl
         FsU+CSB1XcIBkefNRHMgOGB660Z6Fx13jk3k8CnSyIelzQxyNzlEjsl0GUN6A0f28/3X
         wdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQhXYCohXzHB1bZ2481yJdBtaYvkE/AnjVLZI+F8BEk=;
        b=ddlDuzywH+UMaGf7z2SPPThohc9X5OAVMlE488qTtE1/z0mpjXRrIJJ5Kgaljq+sJq
         Ra1Kw0F5fKroWsr4s6XSFiL9IcFojJQVBU4hm4/ZhfMaXGxyZ1MTsDMGCQfZFeoWeo3f
         coi3XIi3HG7SW7h6+3urdafhxlMjIKmPhrFur8s78dxTAqpu6xArhmJbjUkllVQah/7R
         nlfoPTpbEGw2/X0RjZqTIi1mFe+ttuYl93BOvPGaH6jb1ViO9HRmRioa1S/r6uY21tRb
         zZcQTyUuWJSO+CcwGXw1hLgi5AaaBiOmENpeHzE3lVFQ6SPiYWrfgGYw8w2CMudsuvlI
         c95w==
X-Gm-Message-State: APjAAAVhqXoqUkjSoWVOk9JD9+w9aDIBtu8Z7Mi7AvWDbpduCFXNYq+l
        WeBDuTjltanPrANYMq32X6I=
X-Google-Smtp-Source: APXvYqw+QwWHibUtTfkKh8QSJINImEotEo9kySGeB/ewfTe9u3hve15Y0ZC9vtlOwDtxF9CMocfZDw==
X-Received: by 2002:a63:ec4e:: with SMTP id r14mr24780542pgj.235.1573940531922;
        Sat, 16 Nov 2019 13:42:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s15sm9729415pjp.3.2019.11.16.13.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 13:42:10 -0800 (PST)
Subject: Re: watchdog: how to enable?
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
        wim@linux-watchdog.org
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
 <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net>
 <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
 <e5b24949-5215-9d3d-ca45-cab221d4f58a@roeck-us.net>
 <CAHhAz+i83WoGyNwF_sjN+rVH812Nvm=U8ddbv-gWuNbD05HPdg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e4147248-b710-6c8f-530c-1dd6672da8ab@roeck-us.net>
Date:   Sat, 16 Nov 2019 13:42:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+i83WoGyNwF_sjN+rVH812Nvm=U8ddbv-gWuNbD05HPdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/16/19 10:34 AM, Muni Sekhar wrote:
> On Sat, Nov 16, 2019 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 11/15/19 7:03 PM, Muni Sekhar wrote:
>> [ ... ]
>>>>
>>>> Another possibility, of course, might be to enable a hardware watchdog
>>>> in your system (assuming it supports one). I personally would not trust
>>>> the NMI watchdog because to detect a system hang, after all, there are
>>>> situations where even NMIs no longer work.
>>>
>>> >From dmesg , Is it possible to know whether my system supports
>>> hardware watchdog or not?
>>> I assume that my system supports the hardware watchdog , then how to
>>> enable the hardware watchdog to debug the system freeze issues?
>>>
>>
>> Hardware watchdog support really depends on the board type. Most PC
>> mainboards support a watchdog in the Super-IO chip, but on some it is
>> not wired correctly. On embedded boards it is often built into the SoC.
>> The easiest way to see if you have a watchdog would be to check for the
>> existence of /dev/watchdog. However, on a PC that would most likely
>> not be there because the necessary module is not auto-loaded.
>> If you tell us your board type, or better the Super-IO chip on the board,
>> we might be able to help.
> 
> I’m having two same configuration systems, in one system I installed
> the Vanilla kernel and I see the /dev/watchdog and /dev/watchdog0
> nodes. In other system I’m running with ubuntu distribution kernel,
> but I don’t see any watchdog device node. So it looks like I need to
> manually load the kernel module in distro kernel. Is there a way to
> know what is the corresponding kernel module for  /dev/watchdog node?
> 
> # ls -l /dev/watchdog*
> crw------- 1 root root  10, 130 Nov 15 17:15 /dev/watchdog
> crw------- 1 root root 248,   0 Nov 15 17:15 /dev/watchdog0
> 
> # ps -ax | grep watchdog
>    678 ?        S      0:00 [watchdogd]
> 
> Regarding Super-IO chip, how to find out the Super-IO chip model?
> 
You could try to run sensors-detect (from the "sensors" package).

If you can boot a system with /dev/watchdog0, you should see the type
in /sys/class/watchdog/watchdog0/identity.

Also, you can test if the watchdog works with "sudo cat /dev/watchdog",
assuming the watchdog daemon is not running. The watchdog works if the
system reboots after the watchdog times out (/sys/class/watchdog/watchdog0/timeout
is the timeout in seconds).

>>
>> Note though that this won't help to debug the problem. A hardware
>> watchdog resets the system. It helps to recover, but it is not intended
>> to help with debugging.
> How do I use the hardware watchdog to reset my system when system is
> frozen? It helps me to collect the crashdump and finally helps me to
> find the root cause for the system frozen issue.
> 
There won't be a crashdump. It just hard-resets the system.

Guenter
