Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE4E4F2D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438844AbfJYOdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 10:33:24 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40995 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438752AbfJYOdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 10:33:23 -0400
Received: by mail-yb1-f196.google.com with SMTP id 206so922997ybc.8
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2019 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpLlVrXP050XVnJUIXmpDOE06SBLEojfDEDD5nCjdx8=;
        b=aXVD993EyjjlRE/4BDk931Uo2YpeNAtohcIStuXUMcmzwU+3gUHAQ4nJNTBSUOl3Wx
         MtFmyLreQ2tZgFvlv3aHSJwLX/pGtK1hyPvgo8dHWq0N1bryYpE+0ETxi2FOx2Zw4drr
         EHSBUhlfZRLBBemzPkSNwDJvLoSTvNlmdgI9YKkfADWJ8Xoe17ybwfHB5MiVAVKHBtDj
         pxGksbzwxkZtcSBNMa9SW5gnP2EGR+R2I/naLTVQ9AtEU/8h/mXV+EYxNQgVWqiFJVk9
         V0wxUIEoSuh8nrZWqW3GZ6Sc7E+HpibYvJw/Sxsho+NWasKJW5RUNR96elbrbSuVlWqo
         y2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpLlVrXP050XVnJUIXmpDOE06SBLEojfDEDD5nCjdx8=;
        b=FAOxUa7W/OJI4ebLmdqBRDg50fW7Rh/AN0LFbOAcr3oTnER7wENkgoj7v5xMkLnCfs
         DYL4AVGmAC81nd4CZ18gKiEsmXlpsGi6l9gPCCRaZXn2N3D67VOdUBfPDQkqbMo/tmwZ
         Xe/ssbb6JObSRVn33LbyepbPyC7WYkPyEd3/bS9H23Ezs3MnH7IoG8L44JAHb8mjhnPE
         gwSXoOg+M2W7awX+poYGqdLkOQhr4RCwkJijru+g9MN6ge/hO6M3RtkXLTIINi5BkGPU
         wCp/9fzRphGCMHe1aRhi4EbMQ133As0Jq9rCCbFN3dG4wy52EWky/gHBB5VKi25VgPPH
         qOIQ==
X-Gm-Message-State: APjAAAXWTGAyCffM+Un+0Et3sIVpI8XJoVTUNPlV5axGIZ7W0sO9YzIL
        IPWEIBNMOS/3VoMsBGGPRomqOhcwbb9mNov5B5wUInKZ
X-Google-Smtp-Source: APXvYqzUyqixnUEX3eyIPitt4o6OCLL0sX0/q8zK369OM2OxCQgq4yNTFjgQQMYY155qq7w/cN7UgykWwp6YvnltHHc=
X-Received: by 2002:a25:30d5:: with SMTP id w204mr3459375ybw.382.1572014002286;
 Fri, 25 Oct 2019 07:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com> <20191024171228.877974-2-s.miroshnichenko@yadro.com>
In-Reply-To: <20191024171228.877974-2-s.miroshnichenko@yadro.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Fri, 25 Oct 2019 16:33:13 +0200
Message-ID: <CA+QBN9AR+drU0zC2-C2zVetTv0GxNs0KRF1BG51mwcRyu=TxpA@mail.gmail.com>
Subject: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
pci_bus 0000:00: root bus resource [io  0x18800000-0x188fffff]
pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
pci 0000:00:04.0: BAR 0: assigned [mem 0x50000000-0x5000ffff]
pci 0000:00:05.0: BAR 1: assigned [mem 0x50010000-0x50010fff]
pci 0000:00:05.0: BAR 3: assigned [mem 0x50011000-0x50011fff]
pci 0000:00:0a.0: BAR 1: assigned [mem 0x50012000-0x50012fff]
pci 0000:00:0a.0: BAR 3: assigned [mem 0x50013000-0x50013fff]
pci 0000:00:02.0: BAR 0: assigned [io  0x18800000-0x188000ff]
pci 0000:00:02.0: BAR 1: assigned [mem 0x50014000-0x500140ff]
pci 0000:00:03.0: BAR 0: assigned [io  0x18800400-0x188004ff]
pci 0000:00:03.0: BAR 1: assigned [mem 0x50014100-0x500141ff]
pci 0000:00:05.0: BAR 0: assigned [io  0x18800800-0x1880081f]
pci 0000:00:05.0: BAR 2: assigned [io  0x18800820-0x1880083f]
pci 0000:00:0a.0: BAR 0: assigned [io  0x18800840-0x1880085f]
pci 0000:00:0a.0: BAR 2: assigned [io  0x18800860-0x1880087f]


00:00.0 Non-VGA unclassified device: Integrated Device Technology,
Inc. Device 0000
        Subsystem: Device 0214:011d
        Flags: bus master, 66MHz, medium devsel, latency 60, IRQ 140
        Memory at <unassigned> (32-bit, prefetchable)
        I/O ports at <ignored>
        I/O ports at <ignored>

00:02.0 Ethernet controller: VIA Technologies, Inc. VT6105/VT6106S
[Rhine-III] (rev 86)
        Subsystem: AST Research Inc Device 086c
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 142
        I/O ports at 18800000 [size=256]
        Memory at 50014000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
        Kernel driver in use: via-rhine

00:03.0 Ethernet controller: VIA Technologies, Inc. VT6105/VT6106S
[Rhine-III] (rev 86)
        Subsystem: AST Research Inc Device 086c
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 143
        I/O ports at 18800400 [size=256]
        Memory at 50014100 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
        Kernel driver in use: via-rhine

00:04.0 Network controller: Atheros Communications Inc. Device 0029 (rev 01)
        Subsystem: Atheros Communications Inc. Device 2091
        Flags: bus master, 66MHz, medium devsel, latency 168, IRQ 142
        Memory at 50000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2
        Kernel driver in use: ath9k

00:05.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad
16950 UART) function 0 (Uart) (rev 01) (prog-if 06 [)
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Flags: medium devsel, IRQ 143
        I/O ports at 18800800 [size=32]
        Memory at 50010000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 18800820 [size=32]
        Memory at 50011000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
        Kernel driver in use: serial

00:05.1 Non-VGA unclassified device: Oxford Semiconductor Ltd
OX16PCI954 (Quad 16950 UART) function 0 (Disabled) (rev 01)
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Flags: medium devsel, IRQ 143
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        Capabilities: [40] Power Management version 2

00:0a.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad
16950 UART) function 0 (Uart) (rev 01) (prog-if 06 [)
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Flags: medium devsel, IRQ 140
        I/O ports at 18800840 [size=32]
        Memory at 50012000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 18800860 [size=32]
        Memory at 50013000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
        Kernel driver in use: serial

00:0a.1 Non-VGA unclassified device: Oxford Semiconductor Ltd
OX16PCI954 (Quad 16950 UART) function 0 (Disabled) (rev 01)
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Flags: medium devsel, IRQ 140
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        I/O ports at <unassigned> [disabled]
        Capabilities: [40] Power Management version 2


hi guys
I have a couple of miniPCI Oxford Semiconductor Ltd OX16PCI954 cards
installed, and the dmesg looks weird

espeially these lines
pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
pci_bus 0000:00: root bus resource [io  0x18800000-0x188fffff]
pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)

besides, I am experimenting crashes happening in burn-in tests, and I
do suspect it's something related to the newly added cards

any enlightenment?
