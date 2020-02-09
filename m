Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54E156865
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2020 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBIC3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 21:29:55 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:34514 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBIC3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 21:29:55 -0500
Received: by mail-lj1-f169.google.com with SMTP id x7so3334925ljc.1
        for <linux-pci@vger.kernel.org>; Sat, 08 Feb 2020 18:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nx/RkjGQp2URWYpqxzV14Ixfmtxdez1Qovps0w+xE50=;
        b=XkUQwQZbgu/D3qzt7/9SisB8OzhMPtIzd2ES607DGEmAmC73hHMAR0j2ir0CqEkLJ2
         4CQYnwKaH+tDRVmRdF6HSloMq9eoKYmwFf6gwi7OUnXC6p3imgZYsxk83q49WP/6Pevm
         XJ45/7ntkpUJUaSA6xAPy/PghQgxb34IwisacT9lTjak3KrFgh5d6JzR5wHSwACEjq3O
         aXA6TSeysqHE/TUILGngqgZcKyN3n7t2Sgzgv5VuuYcfN65BGbtETvUMq54jrEBV3A/1
         lMOPG/NuG2bKA7hW1n+GYhhQffrR84lH3KTvUqtLz6BJbj74f8eWdXwiOJmoRAhxf+3k
         xbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nx/RkjGQp2URWYpqxzV14Ixfmtxdez1Qovps0w+xE50=;
        b=dFpTaDU3V6FVirG9qYpc9UR+C723KKGRvGS8PMw1HLDPGkxf1D6NmVFT+J35qOk16q
         5rae0Y4pSJp+VeD8oJOLhTvPwBQV1pzIDIXAyC7NwSfhiQFKFG0DSEpSjRg7447doyOF
         xieVtoHOQ6hgJgBFzZrVjF3FTmx3pzYS9mqIlJI9HyMHFFAGnPGAZ6T5/27zasXmwJQp
         yyt5zlGuh0tQZEZm7Jlclqtnr5wrDMp3fEFY6v9T3MdekveX0lpn7bUetaG+Lu0xsKFi
         JD8krZMYqGoIMmv0Kk+ZSfSezZFHpnpUsYXKfwWpcl6bWTHVclX7WqCeDWGC+eLY36NK
         zTyg==
X-Gm-Message-State: APjAAAUc+h5i00iZ8v3Rpw99mRBA8EvImK7uuJagNH0GL0rhVXFdi+dy
        1AzoZJX1JLeXzj/9nIW+qnSnHHZx7+SSWKtGuEvpIchv
X-Google-Smtp-Source: APXvYqy7WlhV3iQnS7/8hT8JyMeoPckRy4o4wcgxUtH4IghReTBe5sMeAOIt6As70SwOCeJ1L0VaJbEK3F7ZkZCVZZU=
X-Received: by 2002:a2e:8016:: with SMTP id j22mr3882769ljg.24.1581215392822;
 Sat, 08 Feb 2020 18:29:52 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sun, 9 Feb 2020 07:59:41 +0530
Message-ID: <CAHhAz+j9ukzVia8_V3FisLCpT2GsKbmhWtJpQudtWUJcSAki+w@mail.gmail.com>
Subject: pcie: kernel log - BAR 15: no space for... BAR 15: failed to assign..
To:     linux-pci@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

After rebooting the system following messages are seen in dmesg.
Not sure if these indicate a problem. Can some one look at these and
confirm if this is problem or can be ignored ?

Also any suggestions as to what would cause this?

[    1.084728] pci 0000:00:1c.0: BAR 15: no space for [mem size
0x00200000 64bit pref]
[    1.084813] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[    1.084890] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
[    1.084949] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
[    1.085037] pci 0000:00:1c.2: BAR 15: no space for [mem size
0x00200000 64bit pref]
[    1.085108] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[    1.085199] pci 0000:00:1c.3: BAR 15: no space for [mem size
0x00200000 64bit pref]
[    1.085270] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[    1.085343] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.085403] pci 0000:00:1c.2: BAR 13: assigned [io  0x2000-0x2fff]
[    1.085470] pci 0000:00:1c.3: BAR 15: no space for [mem size
0x00200000 64bit pref]
[    1.085540] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[    1.085613] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
[    1.085672] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
[    1.085738] pci 0000:00:1c.2: BAR 15: no space for [mem size
0x00200000 64bit pref]
[    1.085808] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[    1.085884] pci 0000:00:1c.0: BAR 15: no space for [mem size
0x00200000 64bit pref]
[    1.085954] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[    1.086026] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.086083] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    1.086144] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd07fffff]


-- 
Thanks,
Sekhar
