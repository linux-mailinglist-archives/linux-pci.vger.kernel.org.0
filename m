Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1316BCDC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBYJA1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:00:27 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36135 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBYJA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:00:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id ff2so5390365qvb.3;
        Tue, 25 Feb 2020 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QzFKLT7CioGxjxI7dzMDjcHznX5Nnr+6ELaaegdUFkY=;
        b=K++mGY+kZvZ348XctWkxGdiLnzN6dwnRoGnNRDHDVHQgLIz/7T0fn00F2Ah+DwQ+OY
         9/0tU/cbwMXWl8/J54ykzB+RZSNK+DIK8TIYp2BAkxHDBrRzuioNXhsj2PO8gQI9QSZ6
         dREvlXEX4hWJHRLB/RscgGjuhpdNU5aA9Kks+UbWS7FT5ohZglXBuuYozM1WKrupfb94
         TMm6KQDRWsq6Wsy+xSjh3KyebYkqd96/ZZ3mNvWlLrOYjgArlPEEbCDI2MH0s4OfMwSA
         VxtLLv92Z4H3/G+9DcSlb1KPIpA8iAwwBEt4z28ew2UJdg05Dv3dMn9Ht7K8ETkfS9zq
         k6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QzFKLT7CioGxjxI7dzMDjcHznX5Nnr+6ELaaegdUFkY=;
        b=hbcyob6Ln/sKV631BdfXW2hD4fhgb5L43sYlaU4Yya3NtdxK4XAa2xd6VbwqeIApHB
         9hAx5RgJTa5wAlFWgWFwOivPgZNmCXz3DWspak3sYHu1EZvYzom5+HNEpT2aSZ7YPDCY
         ab3Dysy92eXxjqxpH6p/aJpiCQBIyC1CMRpB+/lAm37hrDIaB7T7hSkY4xb+QivDXj2w
         PzDLOuX4JXUvwyfQms/6NYExLnMhBcYZ2eIBNZPvl+ZlgBK5bS7lteDLSdSlFziRYY6W
         S92SGewQWeoQ2GeXTCq3vmevTe9FNsY7HXQLpG22ej5SVlzBdbP6C7ITLiawb2nKRFFL
         pryg==
X-Gm-Message-State: APjAAAWQks8dK/NVuwZY/EIicdHjnZxP1wcVyKS4COHsUqWG2Vmruxk9
        izEsGdX+usvbTDiU1jC3DBBlkEtVexcRNFZ4fU6cteO3
X-Google-Smtp-Source: APXvYqwEItTB9zvBYThitayOPuzzlG9VjbwnKhQz3AUqUPE5VAncXdb6x2Ge7Zx+7P1w66TkNonyrxwjHTgdmo44EEQ=
X-Received: by 2002:ad4:518b:: with SMTP id b11mr50461721qvp.195.1582621226162;
 Tue, 25 Feb 2020 01:00:26 -0800 (PST)
MIME-Version: 1.0
References: <CAGgoGu5u7WZUUaoVYvVWS5nuNZz25PgR=uHkqvzXV5xFOC7KuA@mail.gmail.com>
In-Reply-To: <CAGgoGu5u7WZUUaoVYvVWS5nuNZz25PgR=uHkqvzXV5xFOC7KuA@mail.gmail.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Tue, 25 Feb 2020 10:00:14 +0100
Message-ID: <CAGgoGu6xQ2aV5kcmxcOm2Q=zPEY3mu3fOaCXKPxaz17vptzcmA@mail.gmail.com>
Subject: Re: Help needed in understanding weird PCIe issue on imx6q (PCIe just
 goes bad)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi again,

Can someone guide me what is going on?

Thanks,

-- Fawad Lateef

On Sat, 22 Feb 2020 at 16:25, Fawad Lateef <fawadlateef@gmail.com> wrote:
>
> Hello,
>
> I am trying to figure-out an issue on our i.MX6Q platform based design
> where PCIe interface goes bad.
>
> We have a Phytec i.MX6Q eMMC SOM, attached to our custom designed
> board. PCIe root-complex from i.MX6Q is attached to PLX switch
> (PEX8605).
>
> Linux kernel version is 4.19.9x and also 4.14.134 (from phytec's
> linux-mainline repo). Kernel do not have PCIe hot-plug and PNP enabled
> in config.
>
> PLX switch #PERST is attached to a GPIO pin and stays in disable state
> until Linux is booted. So at boot time only PCIe root-complex is
> initialized by kernel.
>
> After boot if I do "lspci -v"  and see everything good from PCIe
> root-complex (below):
>
> ~ # lspci -v
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> [Normal decode])
> Flags: bus master, fast devsel, latency 0, IRQ 295
> Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> I/O behind bridge: None
> Memory behind bridge: None
> Prefetchable memory behind bridge: None
> [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> Capabilities: [40] Power Management version 3
> Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> Capabilities: [70] Express Root Port (Slot-), MSI 00
> Capabilities: [100] Advanced Error Reporting
> Capabilities: [140] Virtual Channel
> Kernel driver in use: pcieport
>
>
> Then I enable the #PERST pin of PLX switch, everything is still good
> (no rescan on Linux is done yet)
>
> ~ # echo 139 > /sys/class/gpio/export
> ~ # echo out > /sys/class/gpio/gpio139/direction
> ~ # echo 1 > /sys/class/gpio/gpio139/value
> ~ # lspci -v
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> [Normal decode])
> Flags: bus master, fast devsel, latency 0, IRQ 295
> Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> I/O behind bridge: None
> Memory behind bridge: None
> Prefetchable memory behind bridge: None
> [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> Capabilities: [40] Power Management version 3
> Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> Capabilities: [70] Express Root Port (Slot-), MSI 00
> Capabilities: [100] Advanced Error Reporting
> Capabilities: [140] Virtual Channel
> Kernel driver in use: pcieport
>
>
> Now just disable/put-in-reset the PLX switch (Linux don't see the
> switch yet, as no rescan on PCIe was done). Now "lspci -v" and
> root-complex goes bad.
>
> ~ # echo 0 > /sys/class/gpio/gpio139/value
> ~ # lspci -v
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> [Normal decode])
> Flags: fast devsel, IRQ 295
> Memory at 01000000 (64-bit, prefetchable) [disabled] [size=1M]
> Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
> I/O behind bridge: 00000000-00000fff [size=4K]
> Memory behind bridge: 00000000-000fffff [size=1M]
> Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
> [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> Capabilities: [40] Power Management version 3
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> Capabilities: [70] Express Root Port (Slot-), MSI 00
> Capabilities: [100] Advanced Error Reporting
> Capabilities: [140] Virtual Channel
> Kernel driver in use: pcieport
>
> ~ # uname -a
> Linux buildroot-2019.08-imx6 4.14.134-phy2 #1 SMP Thu Feb 20 12:13:33
> UTC 2020 armv7l GNU/Linux
> ~ #
>
>
> I am really not sure what is going wrong here. Did I am missing
> something basic?
>
> Thanks in advance,
>
> -- Fawad Lateef
