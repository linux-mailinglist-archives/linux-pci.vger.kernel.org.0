Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8B61B96EF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgD0GGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 02:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 02:06:04 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CBC061A0F;
        Sun, 26 Apr 2020 23:06:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 3DEEC20CF2;
        Mon, 27 Apr 2020 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587967563; bh=QAo1cw4WCgJFDVWUxM13VAcvn+SmYxagV5M4P3ljeig=;
        h=From:To:Cc:Subject:Date:From;
        b=OKelKojNCASZ2oq0SZiu0mHP7rZzWiA7Y5/50p+fmagXxuCSJScOXac5kLs5YD8CT
         BkeBdTjGGBhTAiSzynpJmr1Ra+y6DCqE6fieItbq2CJYB/daMGvEg65lZnA3SHJn2z
         AtnM5pv87sn4OafBTsvOT7rOiq8yHuVzyL9lvXQrAn/0PbiBDi5YZx+XB43Skb3z2J
         BSx4EAdmifdXb86QLuHEG3LeQfhQQH6NA4s39Z7ufiNUpdx1xjuBbz8uyxslxfnsy6
         rQ91TT4Zimvge8oJ22M2df3ZoiX2/P6YZdlpt8TUlH4yjgnpp4hpp3qvfx886lkmsx
         KUirX4FGAWnVA==
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
Subject: [PATCH v6 0/5] Loongson PCI Generic Driver 
Date:   Mon, 27 Apr 2020 14:05:37 +0800
Message-Id: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
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

