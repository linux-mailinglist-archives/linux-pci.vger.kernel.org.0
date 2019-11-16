Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50531FEA53
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKPDDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 22:03:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33846 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKPDDY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 22:03:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 5so9782683otk.1;
        Fri, 15 Nov 2019 19:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+PKkfyo30L01h9oQ5rnPd8gcgGv49l0ZSJaKPx8vEoE=;
        b=Bleoc43et0DzOAt+JkT60HD6Brzb9ykgPO16OxB7nuNmNSqgTnbXFE5aUpU7zqi8J7
         E1SBqBJXTevQAs4NTG8wo0BZNekBKlEow83Z5a1l04XcmzILjCdv9OAb/jNpKpj5dFB7
         mLkX1TYmWg9fFmkH/qhWuBz4MHMkW+8BGXVdRmX2xnrgZ2b8c1dXNMYKH61ehtufhFcu
         zpSCD2mE9+9LJE8xeym64TsPv0Labowkx3piIbTg3tKb6OPhdzgd2ijJDISUnkBN/09L
         +piTIoCQwW7fPQEpao5emzml0Rc4Hn3blegQ249aZ5kq/glnigB60u0phs9MLhTLPLtX
         qcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+PKkfyo30L01h9oQ5rnPd8gcgGv49l0ZSJaKPx8vEoE=;
        b=mQumZuWz7q0aTFyfOUKZToXCLS3uR/dh85TTlsFd6cjQQGVwYsYEzw66m2GLrloQLR
         K2SW6mAWKZvzCBv1nsRO4Zx5ZJZmTiPFxCYD+ZuqdU4bENkcUgRcCfgQH8gvNWqfH36+
         uoTUG+OSScQgo2YzG7496PdoECKo+sfs74vMJYt2MYGfj6KM5zTV791SRSUynLNPJWfv
         qAWzMgn5cGixka3RUrtVKVnBCm4TZpLvtWqTlyynY5TvT7AZGS/4QtdiOOShRhBGmJL3
         0yxNnWsthUYdjmm4/rWPH01IsHiR3W+4cxbodpd0Yyxgyh5sEXRuIFVK6/oYeRwfXitA
         KXzA==
X-Gm-Message-State: APjAAAXFYYolPb5LMUcgEOBGJhxCL8cWlSDTBx0SVNN4FV5qTuPAdIRT
        buKbPKonqb8oE9RHc4AFk1OF8q9y5k50PWqzi8lNRdbBvJaqUQ==
X-Google-Smtp-Source: APXvYqxN9QwTQS59vEiVHgDbHSYVDvuqlbJ33mTDJZkd55qzg0DRqjh/VJhYCN1W0AhxFwNHxHxrRX6Bny+TXmEqyC8=
X-Received: by 2002:a9d:7588:: with SMTP id s8mr3064399otk.300.1573873403960;
 Fri, 15 Nov 2019 19:03:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
 <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net>
In-Reply-To: <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sat, 16 Nov 2019 08:33:12 +0530
Message-ID: <CAHhAz+iSXZSY012-jNx_wmNmgx_UiHZ4rjxkCUcHk3CjLc9gDg@mail.gmail.com>
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

On Sat, Nov 16, 2019 at 6:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/15/19 4:35 PM, Muni Sekhar wrote:
> > [ Please keep me in CC as I'm not subscribed to the list]
> >
> > Hi All,
> >
> > My kernel is built with the following options:
> >
> > $ cat /boot/config-5.0.1 | grep NO_HZ
> > CONFIG_NO_HZ_COMMON=3Dy
> > CONFIG_NO_HZ_IDLE=3Dy
> > # CONFIG_NO_HZ_FULL is not set
> > CONFIG_NO_HZ=3Dy
> > CONFIG_RCU_FAST_NO_HZ=3Dy
> >
> > I booted with watchdog enabled(nmi_watchdog=3D1) as given below:
> >
> > BOOT_IMAGE=3D/boot/vmlinuz-5.0.1
> > root=3DUUID=3Df65454ae-3f1d-4b9e-b4be-74a29becbe1e ro debug
> > ignore_loglevel console=3DttyUSB0,115200 console=3Dtty0 console=3Dtty1
> > console=3DttyS2,115200 memmap=3D1M!1023M nmi_watchdog=3D1
> > crashkernel=3D384M-:128M
> >
> > When the system is frozen or the kernel is locked up(I noticed that in
> > this state kernel is not responding for ALT-SysRq-<command key>) but
> > watchdog is not triggered. So I want to understand how to enable the
> > watchdog timer and how to verify the basic watchdog functionality
> > behavior?
> >  > Any pointers on this will be greatly appreciated.
> >
> Sorry, I do not have an answer. Please note that you are talking about
> the NMI watchdog, which is completely unrelated to hardware watchdogs
> and not handled by the watchdog subsystem. I would suggest to send
> your question to the Linux kernel mailing list and clearly state
> that you are talking about the NMI watchdog.
>
> Please note that, for the NMI watchdog to do anything, you must have
> CONFIG_HARDLOCKUP_DETECTOR enabled in your kernel configuration. I don't
> know what if anything the configuration options you listed above have
> to do with the NMI watchdog.

Thank you for your response. I enabled hard\soft\lockup detector
config options. My kernel is built with the following .config options:

CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
CONFIG_HARDLOCKUP_DETECTOR=3Dy
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D1

Also I enabled the following stuff in /proc/sys/ directory.

kernel.softlockup_panic =3D 1
kernel.hardlockup_panic =3D 1
kernel.unknown_nmi_panic =3D 1
kernel.softlockup_all_cpu_backtrace =3D 1
kernel.hardlockup_all_cpu_backtrace =3D 1
kernel.panic =3D 3
kernel.panic_on_io_nmi =3D 1
kernel.panic_on_oops =3D 1
kernel.panic_on_stackoverflow =3D 1
kernel.panic_on_unrecovered_nmi =3D 1
kernel.panic_on_rcu_stall =3D 1
kernel.panic_print =3D 31
kernel.sysrq=3D0x1FF


The https://www.kernel.org/doc/Documentation/lockup-watchdogs.txt
Says =E2=80=9CBy default, the watchdog runs on all online cores.  However, =
on a
kernel configured with NO_HZ_FULL, by default the watchdog runs only
on the housekeeping cores, not the cores specified in the "nohz_full"
boot argument.=E2=80=9D, so I just mentioned my kernel CONFIG_NO_HZ* option=
s.

>
> Another possibility, of course, might be to enable a hardware watchdog
> in your system (assuming it supports one). I personally would not trust
> the NMI watchdog because to detect a system hang, after all, there are
> situations where even NMIs no longer work.

From dmesg , Is it possible to know whether my system supports
hardware watchdog or not?
I assume that my system supports the hardware watchdog , then how to
enable the hardware watchdog to debug the system freeze issues?


>
> Guenter



--=20
Thanks,
Sekhar
