Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC51BB34D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 03:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgD1BQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 21:16:27 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:60258 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgD1BQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 21:16:27 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id D7F792049E;
        Tue, 28 Apr 2020 01:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588036582; bh=YpbKFu2GtHuJRM3elJ1UDPWZ42z5iYMpD3wZVprdR/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpvpSpyyHeInj2hqGchbkiq09c63G1ENf9haGk7dFZPGammg8EawvRr/YwVlxJooX
         kxJlHf0Y9TGG5/uFX8jLJU1WPUgMA7/Fdfiysfm54tYp0n737kCdNQ+cVlewm+RDLo
         /bmg6AcNc4aNmPuvfyPhxBE7ppHaiZsPgYb3o/GWd57D07ndZ/IX0MBMekLGjnJdkB
         PpM1TQmjDeUQj/ECZAjncTEvhB9NyobtCgmrIvCiEvWlYX2H8wkz4PzQr2jhEiaw26
         Ej+bD6lnA6cHQTeF91p+x/9LE15Xd8+YrQ7lX54Axpmd7x0hB8L0prOpVwbCCp8fDg
         xZ+shF5SWa8mg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Loongson PCI Generic Driver 
Date:   Tue, 28 Apr 2020 09:14:15 +0800
Message-Id: <20200428011429.1852081-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series converts Loongson PCI into a generic PCI controller
driver and adds support for LS2K SoC and LS7A PCH's PCI support.

Is it possible to let patch 1~3 go through PCI tree and patch
4~5 go through MIPS tree?

Thanks.

v6: Drop first the patch of previous versions. Driver code clean-ups
according to rob's suggestion.

It looks like I had a wrong impression on generic IO port handeling
and now the issue has been fixed, I implemented PCI_IOBASE for MIPS[1].
Now the address is uniform here.

[1]: https://patchwork.kernel.org/cover/11510499/

v7: Fix some minor issues.

Jiaxun Yang (5):
  PCI: Don't disable decoding when mmio_always_on is set
  PCI: Add Loongson PCI Controller support
  dt-bindings: Document Loongson PCI Host Controller
  MIPS: DTS: Loongson64: Add PCI Controller Node
  MIPS: Loongson64: Switch to generic PCI driver

 .../devicetree/bindings/pci/loongson.yaml     |  62 +++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  12 +
 arch/mips/loongson64/Makefile                 |   2 +-
 arch/mips/loongson64/vbios_quirk.c            |  29 ++
 arch/mips/pci/Makefile                        |   1 -
 arch/mips/pci/fixup-loongson3.c               |  71 -----
 arch/mips/pci/ops-loongson3.c                 | 116 --------
 drivers/pci/controller/Kconfig                |  10 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-loongson.c         | 251 ++++++++++++++++++
 drivers/pci/probe.c                           |   2 +-
 12 files changed, 368 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
 create mode 100644 arch/mips/loongson64/vbios_quirk.c
 delete mode 100644 arch/mips/pci/fixup-loongson3.c
 delete mode 100644 arch/mips/pci/ops-loongson3.c
 create mode 100644 drivers/pci/controller/pci-loongson.c

-- 
2.26.0.rc2

