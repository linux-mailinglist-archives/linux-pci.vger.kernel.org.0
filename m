Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291A1FEA01
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 02:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKPBEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 20:04:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKPBEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 20:04:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so6752799pgh.5;
        Fri, 15 Nov 2019 17:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yZhSkrRRzDytu7r6HNwWF41M3n4sS03b4RCMRMevkbs=;
        b=AobSiE0L7QCk9OQy0CTVdmRyPDV6J5QvDRQSJ8WtZfN9x8sf4rUP08anVz+gYEQK7h
         YpPRqgS1k9T0efw8pW+DOv7zsNIvUO9bDLg8YM/eB8k9gZEXpXvrGxLrW1kAnMSPVe/V
         jwIH0O+64kZOulso/izGLVlKpfqmVxokA38TLuBYpLezBicehyWEk18SQ6C/WDtUdbUx
         R/F/0jAZ4Kfe05Db7e+NXHsUhbQMkblGRfZ9tMIMIXROikEh8TMyq2fFN3lE6Gky6XMS
         Tg3rBn5ZVfNPXcH4tllPj5g5wCHQlQU2T4PkVDZfwVaKXu9aTGa2efbmfNcd7tIiZSDR
         wHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZhSkrRRzDytu7r6HNwWF41M3n4sS03b4RCMRMevkbs=;
        b=XUm6vIZWoHznHjD12WnDp3OziljRhmsr6cUOKlIEiSYJynjqR8v2efQ8Lw4c8/9B6J
         mxouL9sVcekiAErIo4r9v+JEFNHTR+FHK8n7iljWrKzqbSmPWDgW4MRqxSMqS7mCmwS5
         N/IFmq7m0ZSWtnLJprupVXvgtbq0WdUHEaOFfnp6Mnr44qc08dpmDwrxE1h8nNcq5YyD
         pkZBwbO40BP/1Rhu+Wou7Q5pLCm6NIGCtmd9m36gX9QDMH9k+CUqg2FT8x6E8MZdLych
         xVWB+9yBkDi9BqsevXUteFozPPDinX/Mce9YNkTa/xZ91w/xOLSK2C/0hevvPqFIpOLG
         W46w==
X-Gm-Message-State: APjAAAXeDwHLp1v9iPitergwVSFkVFAC+CEbajDNB3mAS0/Z5mRieZux
        SHD98DfTmaIZYbIV6OyjfmA=
X-Google-Smtp-Source: APXvYqzZ0xkLydv05JhM34QIDe+zViYkPJDOfTzPMjgKmRPw46e7L+h4xTQzRWam3Qcr25F0o9ZRNA==
X-Received: by 2002:a63:e608:: with SMTP id g8mr19096736pgh.448.1573866292765;
        Fri, 15 Nov 2019 17:04:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10sm10903380pgs.11.2019.11.15.17.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 17:04:51 -0800 (PST)
Subject: Re: watchdog: how to enable?
To:     Muni Sekhar <munisekharrms@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-pci@vger.kernel.org,
        wim@linux-watchdog.org
References: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0d5c20b1-6b0f-430b-17b0-d3624062020d@roeck-us.net>
Date:   Fri, 15 Nov 2019 17:04:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+h6SuGKWn0qNqsCdNjDks_vHuJW-KfiQja_b3x8x=vq_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/19 4:35 PM, Muni Sekhar wrote:
> [ Please keep me in CC as I'm not subscribed to the list]
> 
> Hi All,
> 
> My kernel is built with the following options:
> 
> $ cat /boot/config-5.0.1 | grep NO_HZ
> CONFIG_NO_HZ_COMMON=y
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> CONFIG_RCU_FAST_NO_HZ=y
> 
> I booted with watchdog enabled(nmi_watchdog=1) as given below:
> 
> BOOT_IMAGE=/boot/vmlinuz-5.0.1
> root=UUID=f65454ae-3f1d-4b9e-b4be-74a29becbe1e ro debug
> ignore_loglevel console=ttyUSB0,115200 console=tty0 console=tty1
> console=ttyS2,115200 memmap=1M!1023M nmi_watchdog=1
> crashkernel=384M-:128M
> 
> When the system is frozen or the kernel is locked up(I noticed that in
> this state kernel is not responding for ALT-SysRq-<command key>) but
> watchdog is not triggered. So I want to understand how to enable the
> watchdog timer and how to verify the basic watchdog functionality
> behavior?
>  > Any pointers on this will be greatly appreciated.
> 
Sorry, I do not have an answer. Please note that you are talking about
the NMI watchdog, which is completely unrelated to hardware watchdogs
and not handled by the watchdog subsystem. I would suggest to send
your question to the Linux kernel mailing list and clearly state
that you are talking about the NMI watchdog.

Please note that, for the NMI watchdog to do anything, you must have
CONFIG_HARDLOCKUP_DETECTOR enabled in your kernel configuration. I don't
know what if anything the configuration options you listed above have
to do with the NMI watchdog.

Another possibility, of course, might be to enable a hardware watchdog
in your system (assuming it supports one). I personally would not trust
the NMI watchdog because to detect a system hang, after all, there are
situations where even NMIs no longer work.

Guenter
