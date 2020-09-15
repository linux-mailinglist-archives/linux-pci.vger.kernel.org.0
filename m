Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1C26B5A0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 01:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIOXs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 19:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgIOOdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 10:33:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BFC061226
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 07:15:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so5349199ejb.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ww8/ONqWs5a3GRV4ALcLJTsdbuaLl21VV0p1JdUiSFA=;
        b=M5NLjlt72Gnlqh/UKAJfYSYGzJSJ+Ma3WRrLa49WdcpJzMvk+dph3R+Nz2coj/ZM9C
         GykWpdKyeE2gAD4LoDGrA9oWAZuv4D33x6TGIdx/pTe/+qsnUMohfuPIQiWv66bmHSA6
         EmXJQ2mfahIKFDVDI561yoybUUCPJ+9GLcP2upq7F200Vqchj7gAHn0Aeys0oy2OCWTB
         YFlsR7VvL1L9gFlqBjbpT+FSLAfSICOOzD3PRN5BmwsxKLaPetKcCFR2k9Dos2tCkI1/
         y/8NrJyfmrQOC/aDg3/6vn8s2uxhCJAODI1ttqX9ZhLgufLXYaIkuFog8xAg2uroLpQV
         aaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ww8/ONqWs5a3GRV4ALcLJTsdbuaLl21VV0p1JdUiSFA=;
        b=Hh5ABnHUs7ayFrF01UUZvJ6XPtfQ3DyT3RlP0Jay1u5leI17SnJBNIhCbVrBKvhsR6
         KTonPvkcSxsSRRczog6/DUGFK19HUmdBkzTQCw8aJ+YOdIO6gznkcZMh0Tl35Bgn4h5O
         /L3sDM3khTZ/iueV79DAszH/Nk9FtueRfezCWg/rMb2xtur3xibNXmsZEPu8+OjN01AG
         1GtrnsZVG15+xded6masqtKoYrqEglok7RR3kMGHGh1PwHFxSGPqhl1PbV0UZ0xuUI2W
         +Kezw4bLQlYW/9i+N5YAgsfe8Hef/88PEruhlVcUBvlmYjdg9+tPYRIqDNWQsQsa8Meq
         IgVA==
X-Gm-Message-State: AOAM532y2YNHwJRmtLK/YD+TINuPSu3DR6X7cUerUvPJ/JtAr2QSeKyx
        75RSVgQi75f/rQSo53GtLe94+4p1KwJvPt6UuUTLFhIvax9IwJF7
X-Google-Smtp-Source: ABdhPJzt408YHsl5kc64YTOpkTthCjeTJ7JAOdMMIyvD5XH/ajssiqH6PIs8tK+4QRvQe3j/jZfXnVVmfL93CUeyI3o=
X-Received: by 2002:a17:906:cd0d:: with SMTP id oz13mr20073233ejb.212.1600179327500;
 Tue, 15 Sep 2020 07:15:27 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 15 Sep 2020 16:15:15 +0200
Message-ID: <CAMGffEmrP21e_sgE8C49och1QEABTK4Fh8aVgH8qsyT9t8EJ4w@mail.gmail.com>
Subject: [RFC] pcie hotplug doesn't work with kernel 4.19
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,

We are testing PCIe nvme SSD hotplug, it works out of box with kernel 5.4.6=
2,
dmesg during the hotplug:

[  605.734513] pcieport 0000:16:00.0: pciehp: Slot(0-3): Link Down
[  605.734516] pcieport 0000:16:00.0: pciehp: Slot(0-3): Card not present
[  605.842634] blk_update_request: I/O error, dev nvme0n1, sector
205976576 op 0x1:(WRITE) flags 0x0 phys_seg 112 prio class 0
[  608.908764] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
command 0x15e1 (issued 3030 msec ago)
[  609.988759] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
command 0x15e1 (issued 4110 msec ago)
[  683.218554] pcieport 0000:16:00.0: pciehp: Slot(0-3): Card present
[  683.218555] pcieport 0000:16:00.0: pciehp: Slot(0-3): Link Up
[  683.271702] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
command 0x17e1 (issued 73280 msec ago)
[  686.301874] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
command 0x13e1 (issued 3030 msec ago)
[  686.361894] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
command 0x13e1 (issued 3090 msec ago)
[  686.521911] pci 0000:17:00.0: [1b96:2400] type 00 class 0x010802
[  686.521924] pci 0000:17:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit=
]
[  686.521934] pci 0000:17:00.0: reg 0x20: [mem 0x00000000-0x00000fff
64bit pref]
[  686.521937] pci 0000:17:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[  686.521941] pci 0000:17:00.0: enabling Extended Tags
[  686.522045] pci 0000:17:00.0: BAR 6: assigned [mem
0xc5e00000-0xc5e1ffff pref]
[  686.522046] pci 0000:17:00.0: BAR 0: assigned [mem
0xc5e20000-0xc5e27fff 64bit]
[  686.522051] pci 0000:17:00.0: BAR 4: assigned [mem
0x387ffff00000-0x387ffff00fff 64bit pref]
[  686.522055] pcieport 0000:16:00.0: PCI bridge to [bus 17]
[  686.522057] pcieport 0000:16:00.0:   bridge window [io  0x4000-0x4fff]
[  686.522059] pcieport 0000:16:00.0:   bridge window [mem
0xc5e00000-0xc5efffff]
[  686.522060] pcieport 0000:16:00.0:   bridge window [mem
0x387ffff00000-0x387fffffffff 64bit pref]
[  686.522302] nvme nvme2: pci function 0000:17:00.0
[  686.522355] nvme 0000:17:00.0: enabling device (0100 -> 0102)
[  689.072008] pcieport 0000:16:00.0: pciehp: Timeout on hotplug
command 0x12e1 (issued 2710 msec ago)
[  690.373707] nvme nvme2: 40/0/0 default/read/poll queues

But with kernel 4.19.133, pcieport core doesn't print anything, is
there known problem with kernel 4.19 support for pcie hotplug, do we
need to backport some fixes from newer kernel to make it work?

In both kernel 4.19.133 and kernel 5.4.62 following configs are enabled.

CONFIG_HOTPLUG_PCI=3Dy
CONFIG_HOTPLUG_PCI_ACPI=3Dy
CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
CONFIG_HOTPLUG_PCI_CPCI=3Dy
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dm
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dm
CONFIG_HOTPLUG_PCI_SHPC=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dy

Thanks in advance!
--=20
Jinpu Wang
Linux Kernel Developer

Application Support (IONOS Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone:
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Dr. Christian B=C3=B6ing, H=C3=BCseyin Dogan, Dr. Martin Endre=C3=
=9F,
Hans-Henning Kettler, Arthur Mai, Matthias Steinberg, Achim Wei=C3=9F
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet

Diese E-Mail kann vertrauliche und/oder gesetzlich gesch=C3=BCtzte
Informationen enthalten. Wenn Sie nicht der bestimmungsgem=C3=A4=C3=9Fe Adr=
essat
sind oder diese E-Mail irrt=C3=BCmlich erhalten haben, unterrichten Sie
bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
bestimmungsgem=C3=A4=C3=9Fen Adressaten ist untersagt, diese E-Mail zu
speichern, weiterzuleiten oder ihren Inhalt auf welche Weise auch
immer zu verwenden.

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
