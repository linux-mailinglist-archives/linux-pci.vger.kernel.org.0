Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2650100716
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 15:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKROKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 09:10:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34285 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfKROKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 09:10:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so9717462pgb.1;
        Mon, 18 Nov 2019 06:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lmlVDywEYFjZdutJ5LSZXl5yRlzxkCwshYQVJXG5zro=;
        b=UHM2HVj+peWbJ2wZezWpaM6zjll4T3de0VQoL4ggcWL5sJtQQKeR0euuCXM7lyKDTe
         C4gnShtkS7+MRGwlmgLUB0KfII8e7liZA358RUdiX76kSeAvaiF4H0h8TaMzotjkUm2S
         GWwOt51BuhNC0neuZUquykcOoM9V9LN+c4XlU3j/Vrj6eBe70QYqg8CAJ5VD0xeTT2cA
         yPgCDsVpoufeP0w0xpudlfT+zC9fffXgj5CI2BEtCgSEGCqvb+4wpchbK6zZ0Pbn2nz0
         y034X7FCc2YRgSKls04wMNP6pWjK+GyXFBfIdgoyC4zkQTyvxc7egG1wHFUbZht8iqvD
         w8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmlVDywEYFjZdutJ5LSZXl5yRlzxkCwshYQVJXG5zro=;
        b=Bb8gxx8TVBgiuf8YlfdfBNeubrDe/rDDMY/e/tMk6RPFPKfJ9nP1kIyrTKX+hBsDpE
         2V5Vr9zqFL+RbBIYEBwtZ0t3MoWtIHh5JvKA1gTf8J4697HpB9XY0NkTWZynoFXcTSNd
         MCoY7pxo5lvcVV20alhfLcRuNeKRw1Cw0x+6I91vGd8c/wi6xqlntVRkuiwVO7PsW54o
         8MYI4dtZ6cufsAS9uSks1/aSu+PdnYDLKh7ffzymVyS8B4H8H3ToxU113LsA1sOVNgF5
         LnBs5aj6c4UYoq1jBOvcC3BksrFesxhPR4iDbpDPZN2Tz1sonRFPmciMDWvpeB2QK6N4
         VL7g==
X-Gm-Message-State: APjAAAUDUIoMMZZgBbVrIuvUk34BdA2Xj/X5KRmaZekEzzBAGx+EzhKv
        LhtELD552T5ptLoXC5UqBYaroGZo
X-Google-Smtp-Source: APXvYqxAFFAESoiX7OprWtitXe1TnTb+KTJCr8xdUnJ17b8/nWgKpUrmck+FCmiPUSdXqGjlGJAmvw==
X-Received: by 2002:a63:b502:: with SMTP id y2mr1896306pge.317.1574086229526;
        Mon, 18 Nov 2019 06:10:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1sm19665549pgp.88.2019.11.18.06.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:10:28 -0800 (PST)
Subject: Re: watchdog: how to enable?
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
        wim@linux-watchdog.org
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
 <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net>
 <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
 <e5b24949-5215-9d3d-ca45-cab221d4f58a@roeck-us.net>
 <CAHhAz+i83WoGyNwF_sjN+rVH812Nvm=U8ddbv-gWuNbD05HPdg@mail.gmail.com>
 <e4147248-b710-6c8f-530c-1dd6672da8ab@roeck-us.net>
 <CAHhAz+gGPaNTO1VR2iBBDFEdJ+cJx6+CNoAneLj6yTW0hgEfkA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <da120ac6-062a-3dcc-e635-979fdd021592@roeck-us.net>
Date:   Mon, 18 Nov 2019 06:10:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+gGPaNTO1VR2iBBDFEdJ+cJx6+CNoAneLj6yTW0hgEfkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/19 1:52 AM, Muni Sekhar wrote:
> On Sun, Nov 17, 2019 at 3:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 11/16/19 10:34 AM, Muni Sekhar wrote:
>>> On Sat, Nov 16, 2019 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 11/15/19 7:03 PM, Muni Sekhar wrote:
>>>> [ ... ]
>>>>>>
>>>>>> Another possibility, of course, might be to enable a hardware watchdog
>>>>>> in your system (assuming it supports one). I personally would not trust
>>>>>> the NMI watchdog because to detect a system hang, after all, there are
>>>>>> situations where even NMIs no longer work.
>>>>>
>>>>> >From dmesg , Is it possible to know whether my system supports
>>>>> hardware watchdog or not?
>>>>> I assume that my system supports the hardware watchdog , then how to
>>>>> enable the hardware watchdog to debug the system freeze issues?
>>>>>
>>>>
>>>> Hardware watchdog support really depends on the board type. Most PC
>>>> mainboards support a watchdog in the Super-IO chip, but on some it is
>>>> not wired correctly. On embedded boards it is often built into the SoC.
>>>> The easiest way to see if you have a watchdog would be to check for the
>>>> existence of /dev/watchdog. However, on a PC that would most likely
>>>> not be there because the necessary module is not auto-loaded.
>>>> If you tell us your board type, or better the Super-IO chip on the board,
>>>> we might be able to help.
>>>
>>> I’m having two same configuration systems, in one system I installed
>>> the Vanilla kernel and I see the /dev/watchdog and /dev/watchdog0
>>> nodes. In other system I’m running with ubuntu distribution kernel,
>>> but I don’t see any watchdog device node. So it looks like I need to
>>> manually load the kernel module in distro kernel. Is there a way to
>>> know what is the corresponding kernel module for  /dev/watchdog node?
>>>
>>> # ls -l /dev/watchdog*
>>> crw------- 1 root root  10, 130 Nov 15 17:15 /dev/watchdog
>>> crw------- 1 root root 248,   0 Nov 15 17:15 /dev/watchdog0
>>>
>>> # ps -ax | grep watchdog
>>>     678 ?        S      0:00 [watchdogd]
>>>
>>> Regarding Super-IO chip, how to find out the Super-IO chip model?
>>>
>> You could try to run sensors-detect (from the "sensors" package).
>>
>> If you can boot a system with /dev/watchdog0, you should see the type
>> in /sys/class/watchdog/watchdog0/identity.
> I could not find the /sys/class/watchdog/watchdog0/identity and
> /sys/class/watchdog/watchdog0/timeout files.
> $ ls -l /sys/class/watchdog/watchdog0/
> total 0
> -r--r--r-- 1 root root 4096 Nov 18 15:12 dev
> lrwxrwxrwx 1 root root    0 Nov 18 15:12 device -> ../../../iTCO_wdt.0.auto
> drwxr-xr-x 2 root root    0 Nov 18 15:12 power
> lrwxrwxrwx 1 root root    0 Nov 18 14:53 subsystem ->
> ../../../../../../class/watchdog
> -rw-r--r-- 1 root root 4096 Nov 18 14:53 uevent
> 

Presumably CONFIG_WATCHDOG_SYSFS is not enabled in your configuration.

>>
>> Also, you can test if the watchdog works with "sudo cat /dev/watchdog",
>> assuming the watchdog daemon is not running. The watchdog works if the
>> system reboots after the watchdog times out (/sys/class/watchdog/watchdog0/timeout
>> is the timeout in seconds).
> sudo cat /dev/watchdog perfectly rebooted my system. I don't see
> timeout node, how do I configure the timeout value?

sudo apt-get install watchdog
man watchdog

should tell you. Alternatively, enable CONFIG_WATCHDOG_SYSFS.

>>
>>>>
>>>> Note though that this won't help to debug the problem. A hardware
>>>> watchdog resets the system. It helps to recover, but it is not intended
>>>> to help with debugging.
>>> How do I use the hardware watchdog to reset my system when system is
>>> frozen? It helps me to collect the crashdump and finally helps me to
>>> find the root cause for the system frozen issue.
>>>
>> There won't be a crashdump. It just hard-resets the system.
> So is there any other solution to capture the crashdump or trigger
> soft reboot once kernel is lockedup?

Not that I know of. I suspect, though, that you either have a hard lockup
where even NMI is non-operational, or NMI doesn't work in your system
to start with.

If you have nmi_watchdog=1 in your kernel command line, /proc/interrupts
should show a non-zero number of NMI interrupts. Do you see that in your system ?

Guenter
