Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E122423D4E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhJFLuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbhJFLuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 07:50:25 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB16C061767;
        Wed,  6 Oct 2021 04:48:17 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id y28so2582470vsd.3;
        Wed, 06 Oct 2021 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RJx4MtpJONePtr/jeXTVJW67DDMR2QdgG0nS1jAcnb0=;
        b=LOmB8C8HfzXN2vIP0riZmexkBg6PZo+a8whMQlUwsY8FvtbQkMEQ24zHkg3OKQMXth
         DsfKMsqqqUrmDE3G91f1aDY1He6Z04yE8mSYKhAJa8Jwtk6Z6MgNmGI0VNrY2fSDdraK
         FTk6nYvUJunUJ0sTM0wqJ5LmaT6Nq/LfEcWmPGXVQXzjAz4za/vMQv6+0IS3mOugsFeZ
         J1xdlv1fP5pBmO/c3l2QDmeDuf7EGAAq9yFa6PcKaYiYNhXnMB3+AP15ucqbhoQHD9gb
         1ygplkR/N+KpVmuYt47GiQQGlxVUUBfxg3O9yLLwG6ksklUUhT/E3NMen6MdznTlol4Y
         +7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RJx4MtpJONePtr/jeXTVJW67DDMR2QdgG0nS1jAcnb0=;
        b=C75fdDwoEygDVK/tWnMEs0XG7CdP+xNAhzYKkyfr07SPr5GoSvlsHPGe+Cl93EB6nv
         CwMhYBXjUtZHpF5GkkLfRfPJFB5C1h/0MFC4kzRZsLYwmNkz6Y5qpjyVtlY2H46CH4Fo
         0hkE88Uy4mIcEA4nc8vKTCZ8FnPISqYDwpuUWjLYNQam6wQAf2UGoH7U4+67DYJ2g9i+
         siWvZYKsngWMI8DTix/kgDRRnR0tLpd/niYD5OmB1b1HAt9PuZK1TZGY0I8Ko3CK7+9j
         WNw9q5OFXuz0HKrGrwA07DPA5+WH6UBP6G4sUfBM+iJ4M1E9ivtD6P9lyC/XujL1HbJo
         gT5w==
X-Gm-Message-State: AOAM532tuBCHdrSOHzMmpTl/zDlME1kRp+W8s2UTJfgGkbun32tdbTNI
        J8QCY/+L4EAQCvm5A5oQpPgZJ5HeggWJ6QOC5g==
X-Google-Smtp-Source: ABdhPJwZvnBpoZ4mVhl5+gIyGr3T/Cb/JVmF4TYOakrdCAn/rg5UTEzJbpvh3vAQr48x6RvehOZSG77jnLjjHQKiPAc=
X-Received: by 2002:a67:f317:: with SMTP id p23mr24132893vsf.0.1633520897110;
 Wed, 06 Oct 2021 04:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <CALjTZvbQr+rDUCct1fH-xgLP1jKvDRW6cMxCk6UVZ6h4dTsH6w@mail.gmail.com>
In-Reply-To: <CALjTZvbQr+rDUCct1fH-xgLP1jKvDRW6cMxCk6UVZ6h4dTsH6w@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 6 Oct 2021 12:48:05 +0100
Message-ID: <CALjTZvYOTzUDtSEyPun70xe+9dj1yHnCSTtnQa03AgEMzdwdaQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     tglx@linutronix.de
Cc:     maz@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Oct 2021 at 12:44, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Just for the record (and probably stating the obvious), reverting the
> aforementioned commit fixes this system. Running Linux 5.15-rc4, at
> the moment.

However, reverting the commit, while yielding a working system, causes
these errors in the dmesg=E2=80=A6

rui@vedder:~$ dmesg | grep ata1
[    0.670087] ata1: SATA max UDMA/133 abar m8192@0xfae76000 port
0xfae76100 irq 30
[    1.009734] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.010578] ata1.00: ATA-8: Hitachi HDS721010CLA332, JP4OA3EA, max UDMA/=
133
[    1.010699] ata1.00: Read log page 0x08 failed, Emask 0x1
[    1.010707] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32)
[    1.011777] ata1.00: Read log page 0x08 failed, Emask 0x1
[    1.011791] ata1.00: configured for UDMA/133
rui@vedder:~$

I don't remember seeing those "Read log page 0x08 failed, Emask 0x1"
errors before.

Thanks,
Rui
