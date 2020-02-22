Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AD168FC2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2020 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBVPZz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Feb 2020 10:25:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38533 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBVPZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Feb 2020 10:25:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id z19so4779948qkj.5;
        Sat, 22 Feb 2020 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZG5hRcyWVVqkC4F/dn/YObRHxUhmkezvdHoGQ54qJ9w=;
        b=J5hED42DZ8hYQ54gzaRNllbjyjBIOF9o9d+FPHUh6PQ37uHPgMw+GeoHKtdvv7OEDD
         QBD62hjINZJmm2NrnVoj7CVLU/MnCiRZrRs7g0W+eVSC6gQADnkr5J3qDpLoEXpAxR9J
         ItaNJ2/gcSevXOP9Arj5YmfzEAxt2YHksQsZiRUtzw3+ZyzMQhMJTEVt2Kvi1RrYicB/
         51Yadr6Aj6xeaG3GS4qfRi7vERxPAUVmqHwYPPwcWc4lZisPEdp5zCc+5ktGSK4ZOcgq
         XLadmMxHAwpSYNeDM5iqmu0eIJZG26SFd4RKq7bpXH/M5YBfULsvQ7/lejvx3q+AhhJT
         I63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZG5hRcyWVVqkC4F/dn/YObRHxUhmkezvdHoGQ54qJ9w=;
        b=iXjdHo+jhFcptOMM+MzcSfu5pO2ySrIkgFpJ7tVKNC9c0uASKF2G6/V/q5k+q+N4Wv
         SvyNCQ0PRTBzVGbU5imRSUQMP95YynBhvxGinadffEEEI4QAvLkgDgPx239y1Lnem5zB
         jRvgUVtRC6mDvD6q8oh5prmmYODXQRJ806R5Hk8QGPuT/4zujIBAc6yCA0JdfRZq6txC
         0SMQJy1uLWsuWPCCt0kgvfp6gnzj5av9d6hF9oofDXYngksDT3uDm01kAiPP4S9f42y7
         3ozf1X9YLQV89a0IzsLfUf7ZLsRh/UF9pdUDshT6B7bRv6iBRLi5mxE5TLsXHmrs1a8F
         VyYA==
X-Gm-Message-State: APjAAAW/05fkTroilz3KGVOpfmCxBi0xwPaPC5mfwRtTFOqriQUpBJ2i
        euO0KcI24VL5mmKyrIWHtZWEEeEpTiTGHZ1AeYpSNgpgmt0=
X-Google-Smtp-Source: APXvYqywKqyK7zUE57w6QzwmxZzRLgc2OQoiYt4ZBoM0wp7Iq7zDs7d+/CuzJqCQnFweSi6S0586RKseCnpFsJgf7MU=
X-Received: by 2002:a37:742:: with SMTP id 63mr40047459qkh.31.1582385152175;
 Sat, 22 Feb 2020 07:25:52 -0800 (PST)
MIME-Version: 1.0
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Sat, 22 Feb 2020 16:25:41 +0100
Message-ID: <CAGgoGu5u7WZUUaoVYvVWS5nuNZz25PgR=uHkqvzXV5xFOC7KuA@mail.gmail.com>
Subject: Help needed in understanding weird PCIe issue on imx6q (PCIe just
 goes bad)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I am trying to figure-out an issue on our i.MX6Q platform based design
where PCIe interface goes bad.

We have a Phytec i.MX6Q eMMC SOM, attached to our custom designed
board. PCIe root-complex from i.MX6Q is attached to PLX switch
(PEX8605).

Linux kernel version is 4.19.9x and also 4.14.134 (from phytec's
linux-mainline repo). Kernel do not have PCIe hot-plug and PNP enabled
in config.

PLX switch #PERST is attached to a GPIO pin and stays in disable state
until Linux is booted. So at boot time only PCIe root-complex is
initialized by kernel.

After boot if I do "lspci -v"  and see everything good from PCIe
root-complex (below):

~ # lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
[Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 295
Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
I/O behind bridge: None
Memory behind bridge: None
Prefetchable memory behind bridge: None
[virtual] Expansion ROM at 01100000 [disabled] [size=64K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
Capabilities: [70] Express Root Port (Slot-), MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [140] Virtual Channel
Kernel driver in use: pcieport


Then I enable the #PERST pin of PLX switch, everything is still good
(no rescan on Linux is done yet)

~ # echo 139 > /sys/class/gpio/export
~ # echo out > /sys/class/gpio/gpio139/direction
~ # echo 1 > /sys/class/gpio/gpio139/value
~ # lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
[Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 295
Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
I/O behind bridge: None
Memory behind bridge: None
Prefetchable memory behind bridge: None
[virtual] Expansion ROM at 01100000 [disabled] [size=64K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
Capabilities: [70] Express Root Port (Slot-), MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [140] Virtual Channel
Kernel driver in use: pcieport


Now just disable/put-in-reset the PLX switch (Linux don't see the
switch yet, as no rescan on PCIe was done). Now "lspci -v" and
root-complex goes bad.

~ # echo 0 > /sys/class/gpio/gpio139/value
~ # lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
[Normal decode])
Flags: fast devsel, IRQ 295
Memory at 01000000 (64-bit, prefetchable) [disabled] [size=1M]
Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
I/O behind bridge: 00000000-00000fff [size=4K]
Memory behind bridge: 00000000-000fffff [size=1M]
Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
[virtual] Expansion ROM at 01100000 [disabled] [size=64K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
Capabilities: [70] Express Root Port (Slot-), MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [140] Virtual Channel
Kernel driver in use: pcieport

~ # uname -a
Linux buildroot-2019.08-imx6 4.14.134-phy2 #1 SMP Thu Feb 20 12:13:33
UTC 2020 armv7l GNU/Linux
~ #


I am really not sure what is going wrong here. Did I am missing
something basic?

Thanks in advance,

-- Fawad Lateef
