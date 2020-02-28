Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427E817351D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 11:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1KRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 05:17:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44384 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgB1KRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 05:17:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id j23so1578195qtr.11;
        Fri, 28 Feb 2020 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7uaMNCZeASeOiOXVcNL4zVrX7ClVNCtzMIR7D9YARI=;
        b=M5jzpjhoiTL/oUp6xuFKtEY63effT2sUVgJjJmNXj3CKo4K5hId3e3NWuS4qZve423
         9sxxPP+n7VetNDTfhIA3YeUdd5eHjLJYn9Pk66qZqvLTNzjyZtTu04H3tB9Yr7oOtrhk
         BIRyEwbgA1EN/8P3zePzye49iQdtgxw382349nzurRzJSrGwJGfLCK0ZEK4lhqAwghaO
         IqmPdgyBSdW9Py6Cxaiq9kJQR6RjDd1AWsQdaMbSUL9uHGOHl8LwbIJTUf9PRVWs5bKI
         HSHrGLNx+iwdGZezp9uUuG7Bvox3UChr+g4Uz+KSTkKTjmb8zp1Cu9xnCNf1fw1zbgH8
         PdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7uaMNCZeASeOiOXVcNL4zVrX7ClVNCtzMIR7D9YARI=;
        b=QGi9q7PBk0V2B20FzB88BldbAboCTn4cDizrDo+YpVg0kEE8P/ZHOcdaoln25HVl0+
         fsJe+Q3n2+JyJYZn4NBRDQBbcPekTM+RpV1xUlDLomo/Y/eaGGVbwNcVlFuR4FidJ43d
         PQPYf1wQ/W5jkROVCWpjWukpQFXfVx44pxIDpKqDlxBF52KISZvjTXjU6AEDo4h3rScB
         0nBHR2RFrJq8kaoqhs6zPzsEjL33QqA8rX7olfbRd5y1jJrB16vQUOWEEP160gRwBxbs
         XuteVkN6w94fwQdfRBNzOUeMUqgbLUKU0eQOW81Hv9jfJVypResZohA3kG9uk9lTnj1i
         stDw==
X-Gm-Message-State: APjAAAU/SflbxNHa2/pIz9xyjcv/eI6f3ckRwX71OmoXPdrENWoyk6ki
        v+WeHqUIXYxy+736dOylp7rR2s6uBNNRyk6gX8g=
X-Google-Smtp-Source: APXvYqxweHj0HtlXLVo6Lgw13u2NbrMu5Gcgnh2LV/lpLDTC3ghCPLkqUIAwAehfrZ7V63E215bt4sUGI6E+ef3pgcU=
X-Received: by 2002:ac8:351c:: with SMTP id y28mr3392484qtb.379.1582885030664;
 Fri, 28 Feb 2020 02:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20200226232550.GA191068@google.com> <20200226232713.GA191903@google.com>
In-Reply-To: <20200226232713.GA191903@google.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Fri, 28 Feb 2020 11:16:59 +0100
Message-ID: <CAGgoGu4oyvaDmTDY337UXUyJz1vDwsKtdkqD5k9heQdPpMfmYg@mail.gmail.com>
Subject: Re: Help needed in understanding weird PCIe issue on imx6q (PCIe just
 goes bad)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your reply. Please see my comments below.

By the way, I have another development kit from "Embedded Artists"
with i.MX6Q SOM. I did similar test quickly (with WLAN attached to
PCIe root-complex _not_ PLX switch). This one also showed same
behavior though I have to confirm this properly (working on it). Then
at-least I can say its not exactly issue of Phytec SOM.

On Thu, 27 Feb 2020 at 00:27, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Richard, Lucas]
>
> On Wed, Feb 26, 2020 at 05:25:52PM -0600, Bjorn Helgaas wrote:
> > On Sat, Feb 22, 2020 at 04:25:41PM +0100, Fawad Lateef wrote:
> > > Hello,
> > >
> > > I am trying to figure-out an issue on our i.MX6Q platform based design
> > > where PCIe interface goes bad.
> > >
> > > We have a Phytec i.MX6Q eMMC SOM, attached to our custom designed
> > > board. PCIe root-complex from i.MX6Q is attached to PLX switch
> > > (PEX8605).
> > >
> > > Linux kernel version is 4.19.9x and also 4.14.134 (from phytec's
> > > linux-mainline repo). Kernel do not have PCIe hot-plug and PNP enabled
> > > in config.
> > >
> > > PLX switch #PERST is attached to a GPIO pin and stays in disable state
> > > until Linux is booted. So at boot time only PCIe root-complex is
> > > initialized by kernel.
> > >
> > > After boot if I do "lspci -v"  and see everything good from PCIe
> > > root-complex (below):
> > >
> > > ~ # lspci -v
> > > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > > [Normal decode])
> > > Flags: bus master, fast devsel, latency 0, IRQ 295
> > > Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> > > Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > > I/O behind bridge: None
> > > Memory behind bridge: None
> > > Prefetchable memory behind bridge: None
> > > [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> > > Capabilities: [40] Power Management version 3
> > > Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> > > Capabilities: [70] Express Root Port (Slot-), MSI 00
> > > Capabilities: [100] Advanced Error Reporting
> > > Capabilities: [140] Virtual Channel
> > > Kernel driver in use: pcieport
> > >
> > >
> > > Then I enable the #PERST pin of PLX switch, everything is still good
> > > (no rescan on Linux is done yet)
> > >
> > > ~ # echo 139 > /sys/class/gpio/export
> > > ~ # echo out > /sys/class/gpio/gpio139/direction
> > > ~ # echo 1 > /sys/class/gpio/gpio139/value
> > > ~ # lspci -v
> > > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > > [Normal decode])
> > > Flags: bus master, fast devsel, latency 0, IRQ 295
> > > Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> > > Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > > I/O behind bridge: None
> > > Memory behind bridge: None
> > > Prefetchable memory behind bridge: None
> > > [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> > > Capabilities: [40] Power Management version 3
> > > Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> > > Capabilities: [70] Express Root Port (Slot-), MSI 00
> > > Capabilities: [100] Advanced Error Reporting
> > > Capabilities: [140] Virtual Channel
> > > Kernel driver in use: pcieport
> > >
> > >
> > > Now just disable/put-in-reset the PLX switch (Linux don't see the
> > > switch yet, as no rescan on PCIe was done). Now "lspci -v" and
> > > root-complex goes bad.
> > >
> > > ~ # echo 0 > /sys/class/gpio/gpio139/value
> > > ~ # lspci -v
> > > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > > [Normal decode])
> > > Flags: fast devsel, IRQ 295
> > > Memory at 01000000 (64-bit, prefetchable) [disabled] [size=1M]
> > > Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
> > > I/O behind bridge: 00000000-00000fff [size=4K]
> > > Memory behind bridge: 00000000-000fffff [size=1M]
> > > Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
> > > [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> > > Capabilities: [40] Power Management version 3
> > > Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> > > Capabilities: [70] Express Root Port (Slot-), MSI 00
> > > Capabilities: [100] Advanced Error Reporting
> > > Capabilities: [140] Virtual Channel
> > > Kernel driver in use: pcieport
> > >
> > > ~ # uname -a
> > > Linux buildroot-2019.08-imx6 4.14.134-phy2 #1 SMP Thu Feb 20 12:13:33
> > > UTC 2020 armv7l GNU/Linux
> > > ~ #
> > >
> > >
> > > I am really not sure what is going wrong here. Did I am missing
> > > something basic?
> >
> > I agree, it looks like something's wrong, but I really don't have any
> > ideas.
> >
> > I would start by using "lspci -xxxx" to see the actual values we get
> > from config space.  It looks like we're reading zeros from at least
> > the bus and window registers.

Somehow "lspci -xxxx" generate kernel crash ("imprecise external
abort") on both Phytec and Embedded Artists SOMs. lspci with -xxx (3
x) works but not 4 x. Seems like i.MX6 general issue?

> >
> > You could also instrument the i.MX config accessors in case there's
> > something strange going on there.  Maybe try to reproduce this on a
> > current upstream kernel?

I will try to read i.MX PCIe config registers, but I think those will
be read through PCIe interface and when it goes bad, devmem or any
other access to root-complex memory-address hangs the full SOM, not
even sys-rq works.

I was playing with 5.2.xx kernel earlier, but didn't try it on
recently. Will do a clean build with it again and see if I can face
similar situation.

Thanks,

Fawad Lateef

> >
> > Bjorn
