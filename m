Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E432177F9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 21:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGGTaR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 15:30:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgGGTaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 15:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594150215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=01varJ2me0tZRb1RA3CrsAfeu4lanBS1IdqwDINnieI=;
        b=iRdnvEllSDOlGg7JLLU2+UNKbi3bRSxpw7s8awKxefSSv8NxoKwZfOETpN6uLYL59bjUw7
        3ZtDEl1ptJd3lBH/YqVGQURg++t8zLTAgvkLDDjC0xlZordvUZD7FM7PuKAnveYRmqXSla
        GDfJLvQ4gCaN7lLJNOM/8tv0yFs1MNs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-JV7DPAt1OSe2mFgvDhQTVw-1; Tue, 07 Jul 2020 15:30:12 -0400
X-MC-Unique: JV7DPAt1OSe2mFgvDhQTVw-1
Received: by mail-qk1-f199.google.com with SMTP id g12so29304699qko.19
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2020 12:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=01varJ2me0tZRb1RA3CrsAfeu4lanBS1IdqwDINnieI=;
        b=uGC35rLq0XWzhOZ8QmEXlA8lsYVhJwXqvzXT6z/p8QCY/hXXRYoKy6BFj7wAGmXqz+
         tyuyoMK3/rxwcTakzLkq8SKLT+ygri0w2N6phR7XGBY7qupP9RTJ1inHrPgnXEYd3NwL
         57vdi/v9h7bJCilbjPSS7zpzcf2fUuNrJRjVXP9tNiVo/uXL3f2/RYDYMNufCMv6mXNJ
         Lf8fDerGOmgO7J9M5NMQvswpCOeGu6WkZuR+zn+8zUpGJYM7ltqxSgBOchFKtfrkdosE
         OdRE66zuKDMD6tEGzaOT6j5bbRSd25yYeQ+9KT5ykLRchWehYTQ0xcS3ETfNSgHg26R7
         ou1g==
X-Gm-Message-State: AOAM532+wdb29LXv1uVTF1O9kNoOxVMnf9s9ZYZDaST+G75V4ezLh2jA
        pc6S5kI303AHNYraIrgf6Dy8fQk8SxvU5yxpT28IiTWD8wc1qOxMwlL5Xh3mVYcGzjImyVmu2/j
        YsWef3/ieD9tibmg7ldxx46YFJfaGTJItvF2f
X-Received: by 2002:a37:bc07:: with SMTP id m7mr42065259qkf.381.1594150211992;
        Tue, 07 Jul 2020 12:30:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhr/AYWU9/v6yT0D8nQ5071qK657Spoxv8rwcHHbjJzBu3qFSGO3VZL3ae2nm+OKmNcElROG8wmv/HMPp6//c=
X-Received: by 2002:a37:bc07:: with SMTP id m7mr42065242qkf.381.1594150211723;
 Tue, 07 Jul 2020 12:30:11 -0700 (PDT)
MIME-Version: 1.0
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 7 Jul 2020 21:30:00 +0200
Message-ID: <CACO55tsAEa5GXw5oeJPG=mcn+qxNvspXreJYWDJGZBy5v82JDA@mail.gmail.com>
Subject: nouveau regression with 5.7 caused by "PCI/PM: Assume ports without
 DLL Link Active train links in 100 ms"
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi everybody,

with the mentioned commit Nouveau isn't able to load firmware onto the
GPU on one of my systems here. Even though the issue doesn't always
happen I am quite confident this is the commit breaking it.

I am still digging into the issue and trying to figure out what
exactly breaks, but it shows up in different ways. Either we are not
able to boot the engines on the GPU or the GPU becomes unresponsive.
Btw, this is also a system where our runtime power management issue
shows up, so maybe there is indeed something funky with the bridge
controller.

Just pinging you in case you have an idea on how this could break Nouveau

most of the times it shows up like this:
nouveau 0000:01:00.0: acr: AHESASC binary failed

Sometimes it works at boot and fails at runtime resuming with random
faults. So I will be investigating a bit more, but yeah... I am super
sure the commit triggered this issue, no idea if it actually causes
it.

git bisect log (had to do a second bisect, that's why the first bad
and good commits appear a bit random):

git bisect start
# bad: [a92b984a110863b42a3abf32e3f049b02b19e350] clk: samsung:
exynos5433: Add IGNORE_UNUSED flag to sclk_i2s1
git bisect bad a92b984a110863b42a3abf32e3f049b02b19e350
# good: [4da858c086433cd012c0bb16b5921f6fafe3f803] Merge branch
'linux-5.7' of git://github.com/skeggsb/linux into drm-fixes
git bisect good 4da858c086433cd012c0bb16b5921f6fafe3f803
# good: [d5dfe4f1b44ed532653c2335267ad9599c8a698e] Merge tag
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good d5dfe4f1b44ed532653c2335267ad9599c8a698e
# good: [b24e451cfb8c33ef5b8b4a80e232706b089914fb] ipv6: fix
IPV6_ADDRFORM operation logic
git bisect good b24e451cfb8c33ef5b8b4a80e232706b089914fb
# good: [d843ffbce812742986293f974d55ba404e91872f] nvmet: fix memory
leak when removing namespaces and controllers concurrently
git bisect good d843ffbce812742986293f974d55ba404e91872f
# good: [be66f10a60e3ec0b589898f78a428bcb34095730] staging: wfx: fix
output of rx_stats on big endian hosts
git bisect good be66f10a60e3ec0b589898f78a428bcb34095730
# good: [a4482984c41f5cc1d217aa189fe51bbbc0500f98] s390/qdio:
consistently restore the IRQ handler
git bisect good a4482984c41f5cc1d217aa189fe51bbbc0500f98
# good: [bec32a54a4de62b46466f4da1beb9ddd42db81b8] f2fs: fix potential
use-after-free issue
git bisect good bec32a54a4de62b46466f4da1beb9ddd42db81b8
# bad: [044aaaa8b1b15adb397ce423a6d97920a46b3893] habanalabs: increase
timeout during reset
git bisect bad 044aaaa8b1b15adb397ce423a6d97920a46b3893
# good: [6fe8ed270763a6a2e350bf37eee0f3857482ed48] arm64: dts: qcom:
db820c: Fix invalid pm8994 supplies
git bisect good 6fe8ed270763a6a2e350bf37eee0f3857482ed48
# good: [363e8bfc96b4e9d9e0a885408cecaf23df468523] tty: n_gsm: Fix
waking up upper tty layer when room available
git bisect good 363e8bfc96b4e9d9e0a885408cecaf23df468523
# bad: [afaff825e3a436f9d1e3986530133b1c91b54cd1] PCI/PM: Assume ports
without DLL Link Active train links in 100 ms
git bisect bad afaff825e3a436f9d1e3986530133b1c91b54cd1
# good: [be0ed15d88c65de0e28ff37a3b242e65a782fd98] HID: Add quirks for
Trust Panora Graphic Tablet
git bisect good be0ed15d88c65de0e28ff37a3b242e65a782fd98
# first bad commit: [afaff825e3a436f9d1e3986530133b1c91b54cd1] PCI/PM:
Assume ports without DLL Link Active train links in 100 ms

