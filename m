Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB23DFF4C2
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKPSfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Nov 2019 13:35:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32968 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfKPSfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Nov 2019 13:35:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id u13so10935271ote.0;
        Sat, 16 Nov 2019 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TauIVFq9myp8ieU5XDbC8SrqOKGttflVYf6grCInZi8=;
        b=FsoSYe6TRvBl3hIf89z9nWZ2BBO9FMPaMbYlweu+WFm1Rj+/lH7KSUIGtIIXLbdn0T
         dkbEzSN54tkREdIJ8pi6zUfi0Y0dJ9xVbWM6GOhrn9GdSbmjePuTeQ6VLLV5ve+OfaQa
         dkt9a6o7IEJRKtHupNpopAZXF3Dl1brjIy8Hu0Y8Z7VPOr+aIXA3PHu3nhXXvESBAYGh
         lyiWCEKhuamENwV5YRvdRk4X2t/r9JlEf1pMrmiYrYKGPJglxWic5jAdCMjEvRYM00k/
         xkRJH1uAp6DscsYVAuYE9vuLsmfGioydQnYAasGDjYPBmm4gQVuFxGPl+mHWI/lel5r0
         8DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TauIVFq9myp8ieU5XDbC8SrqOKGttflVYf6grCInZi8=;
        b=ViTlSOFshzoynbPik6bDEkVkMnp01p+MeekVKJ+n/7h6OH8BWIYBAezZYYHY8qDJt5
         3KkNfCpYNpj/zOWg+XBimdNRHmEXWb6Wntrfj7ICbIlPFHrWP152BUeHBV7ZBDteB+jn
         7zt21oHjyPgTpRY4vlHPzOIYy4Ee/YI7CxbuPYHJThKowVHp92hgPeGUeUNEJGPecz4Q
         fV0bJYasaaVlWXfZzSPsuBDM6DqX67Jd9ETPpAgHccfoKq5WmWAnJiw2mw49cMrg2n3s
         hgkA18t9Ftlrn/OLmd3po2gOJwTpGWUYEqMCfhjxpm43Wc1LX/JoKLdsDmXhwH21oL/F
         lzlw==
X-Gm-Message-State: APjAAAXA+Sx17j4j25YM2umVlNHVDFRMrNq2bAx0L4RONC1+yEXET0EB
        5cnL97Dr3wtZCwa0549VwcNWb/L0lkpjBreWv4iY90fVLbQ=
X-Google-Smtp-Source: APXvYqxK8IdHCHg5hbwHWcsfdUht1uScQ4Flo0b7XW4V7m/3gT66g1MnRCDfy22v0eDLgjiQYyUc8rsqK3vQOXJR310=
X-Received: by 2002:a9d:7314:: with SMTP id e20mr16615654otk.273.1573929299439;
 Sat, 16 Nov 2019 10:34:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
 <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net> <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
 <e5b24949-5215-9d3d-ca45-cab221d4f58a@roeck-us.net>
In-Reply-To: <e5b24949-5215-9d3d-ca45-cab221d4f58a@roeck-us.net>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sun, 17 Nov 2019 00:04:47 +0530
Message-ID: <CAHhAz+i83WoGyNwF_sjN+rVH812Nvm=U8ddbv-gWuNbD05HPdg@mail.gmail.com>
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

On Sat, Nov 16, 2019 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/15/19 7:03 PM, Muni Sekhar wrote:
> [ ... ]
> >>
> >> Another possibility, of course, might be to enable a hardware watchdog
> >> in your system (assuming it supports one). I personally would not trus=
t
> >> the NMI watchdog because to detect a system hang, after all, there are
> >> situations where even NMIs no longer work.
> >
> >>From dmesg , Is it possible to know whether my system supports
> > hardware watchdog or not?
> > I assume that my system supports the hardware watchdog , then how to
> > enable the hardware watchdog to debug the system freeze issues?
> >
>
> Hardware watchdog support really depends on the board type. Most PC
> mainboards support a watchdog in the Super-IO chip, but on some it is
> not wired correctly. On embedded boards it is often built into the SoC.
> The easiest way to see if you have a watchdog would be to check for the
> existence of /dev/watchdog. However, on a PC that would most likely
> not be there because the necessary module is not auto-loaded.
> If you tell us your board type, or better the Super-IO chip on the board,
> we might be able to help.

I=E2=80=99m having two same configuration systems, in one system I installe=
d
the Vanilla kernel and I see the /dev/watchdog and /dev/watchdog0
nodes. In other system I=E2=80=99m running with ubuntu distribution kernel,
but I don=E2=80=99t see any watchdog device node. So it looks like I need t=
o
manually load the kernel module in distro kernel. Is there a way to
know what is the corresponding kernel module for  /dev/watchdog node?

# ls -l /dev/watchdog*
crw------- 1 root root  10, 130 Nov 15 17:15 /dev/watchdog
crw------- 1 root root 248,   0 Nov 15 17:15 /dev/watchdog0

# ps -ax | grep watchdog
  678 ?        S      0:00 [watchdogd]

Regarding Super-IO chip, how to find out the Super-IO chip model?

>
> Note though that this won't help to debug the problem. A hardware
> watchdog resets the system. It helps to recover, but it is not intended
> to help with debugging.
How do I use the hardware watchdog to reset my system when system is
frozen? It helps me to collect the crashdump and finally helps me to
find the root cause for the system frozen issue.

>
> Guenter



--=20
Thanks,
Sekhar
