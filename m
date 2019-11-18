Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35621001CB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 10:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRJwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 04:52:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33324 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfKRJwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 04:52:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so13968982ote.0;
        Mon, 18 Nov 2019 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h9px4Tbhb7SK5B37JXGZ/LmRFUWqGW7A+insOgwLMlM=;
        b=tnSirZrGregVKARHSO63sSEzwQbMdEnA7OQMLKKfmculhYtD8o7iIKlMsTAl76G9tH
         YgurUB8LfySGxq4aE3OgpII04ZMTuJ8CUY58C9Dh0YcLfeF4Mmims6UydOxyYeTM3GvS
         86QIiEMl+xLk4SfbFMtxsx0F05mK3nqBH9jNCmUCgg/dILnk2lz2hrlLcM1G5wxIq0Z1
         z6rXiH4ZdNwSYf7VEAWO7qdp5JXpGO2mk3CYbpT/z2zd74hWREv+AU9R4V6bfAlsARr4
         QO0/eih+ft2nV5hb3pWOm1iMtxmGdYuu5rR6tbOu0+Yu/LctQA6rcSezu3HEzkYsWmpg
         un+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h9px4Tbhb7SK5B37JXGZ/LmRFUWqGW7A+insOgwLMlM=;
        b=mp8W803OWGqFQd/UMIo0dIY87Ba/HbIbQvEa1gvzI9Nz5aBc7O7LRast5oOkCIPHtb
         PSr9J+u0CQTbafJC909XxTqDo+e8j7QHYv6ELYyGDBw1v6H7el4mbFtK5SiJKwq1tdOE
         Oelcya7rDL9WRHqrRbh4v5SyO0GbM67waatCPP/jq8+5IQ+/mF5BN628gwHskhSe9T0u
         OtYb3KLD3imDgpM/phQZpq/dqiwflSyzumuPWIy9pqGJ4NJfM1vNvGNKOShVUeSuNCgH
         IENCDfn9W750qzwJAZ2ms/8Uor8nHBzxQGZIsrN30alq5gjk2yn/1axfDLqM+E1OqsJT
         hCgA==
X-Gm-Message-State: APjAAAV4SryGa81CdQU3G4mAc5Ep9cijM4SOil4dy7rgvfLAz4JD2HXl
        9R9Pzc2UPf//YYaYuo73GGjnaljh6PPdoGm/YnO+cP80WJ4=
X-Google-Smtp-Source: APXvYqz2vnaO8XzH+8lzHgklMAeZmAYOHMzQ+1RmpA1u/000zrPgInR3SmUskvrz2qdOCPhCS0MbucsazWaxQtZT9lY=
X-Received: by 2002:a05:6830:1b68:: with SMTP id d8mr13342462ote.203.1574070749105;
 Mon, 18 Nov 2019 01:52:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
 <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net> <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
 <e5b24949-5215-9d3d-ca45-cab221d4f58a@roeck-us.net> <CAHhAz+i83WoGyNwF_sjN+rVH812Nvm=U8ddbv-gWuNbD05HPdg@mail.gmail.com>
 <e4147248-b710-6c8f-530c-1dd6672da8ab@roeck-us.net>
In-Reply-To: <e4147248-b710-6c8f-530c-1dd6672da8ab@roeck-us.net>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Mon, 18 Nov 2019 15:22:17 +0530
Message-ID: <CAHhAz+gGPaNTO1VR2iBBDFEdJ+cJx6+CNoAneLj6yTW0hgEfkA@mail.gmail.com>
Subject: Re: watchdog: how to enable?
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
        wim@linux-watchdog.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 17, 2019 at 3:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/16/19 10:34 AM, Muni Sekhar wrote:
> > On Sat, Nov 16, 2019 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> >>
> >> On 11/15/19 7:03 PM, Muni Sekhar wrote:
> >> [ ... ]
> >>>>
> >>>> Another possibility, of course, might be to enable a hardware watchd=
og
> >>>> in your system (assuming it supports one). I personally would not tr=
ust
> >>>> the NMI watchdog because to detect a system hang, after all, there a=
re
> >>>> situations where even NMIs no longer work.
> >>>
> >>> >From dmesg , Is it possible to know whether my system supports
> >>> hardware watchdog or not?
> >>> I assume that my system supports the hardware watchdog , then how to
> >>> enable the hardware watchdog to debug the system freeze issues?
> >>>
> >>
> >> Hardware watchdog support really depends on the board type. Most PC
> >> mainboards support a watchdog in the Super-IO chip, but on some it is
> >> not wired correctly. On embedded boards it is often built into the SoC=
.
> >> The easiest way to see if you have a watchdog would be to check for th=
e
> >> existence of /dev/watchdog. However, on a PC that would most likely
> >> not be there because the necessary module is not auto-loaded.
> >> If you tell us your board type, or better the Super-IO chip on the boa=
rd,
> >> we might be able to help.
> >
> > I=E2=80=99m having two same configuration systems, in one system I inst=
alled
> > the Vanilla kernel and I see the /dev/watchdog and /dev/watchdog0
> > nodes. In other system I=E2=80=99m running with ubuntu distribution ker=
nel,
> > but I don=E2=80=99t see any watchdog device node. So it looks like I ne=
ed to
> > manually load the kernel module in distro kernel. Is there a way to
> > know what is the corresponding kernel module for  /dev/watchdog node?
> >
> > # ls -l /dev/watchdog*
> > crw------- 1 root root  10, 130 Nov 15 17:15 /dev/watchdog
> > crw------- 1 root root 248,   0 Nov 15 17:15 /dev/watchdog0
> >
> > # ps -ax | grep watchdog
> >    678 ?        S      0:00 [watchdogd]
> >
> > Regarding Super-IO chip, how to find out the Super-IO chip model?
> >
> You could try to run sensors-detect (from the "sensors" package).
>
> If you can boot a system with /dev/watchdog0, you should see the type
> in /sys/class/watchdog/watchdog0/identity.
I could not find the /sys/class/watchdog/watchdog0/identity and
/sys/class/watchdog/watchdog0/timeout files.
$ ls -l /sys/class/watchdog/watchdog0/
total 0
-r--r--r-- 1 root root 4096 Nov 18 15:12 dev
lrwxrwxrwx 1 root root    0 Nov 18 15:12 device -> ../../../iTCO_wdt.0.auto
drwxr-xr-x 2 root root    0 Nov 18 15:12 power
lrwxrwxrwx 1 root root    0 Nov 18 14:53 subsystem ->
../../../../../../class/watchdog
-rw-r--r-- 1 root root 4096 Nov 18 14:53 uevent

>
> Also, you can test if the watchdog works with "sudo cat /dev/watchdog",
> assuming the watchdog daemon is not running. The watchdog works if the
> system reboots after the watchdog times out (/sys/class/watchdog/watchdog=
0/timeout
> is the timeout in seconds).
sudo cat /dev/watchdog perfectly rebooted my system. I don't see
timeout node, how do I configure the timeout value?
>
> >>
> >> Note though that this won't help to debug the problem. A hardware
> >> watchdog resets the system. It helps to recover, but it is not intende=
d
> >> to help with debugging.
> > How do I use the hardware watchdog to reset my system when system is
> > frozen? It helps me to collect the crashdump and finally helps me to
> > find the root cause for the system frozen issue.
> >
> There won't be a crashdump. It just hard-resets the system.
So is there any other solution to capture the crashdump or trigger
soft reboot once kernel is lockedup?
>
> Guenter



--=20
Thanks,
Sekhar
