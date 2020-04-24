Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5D1B767D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDXNJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXNJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 09:09:42 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E0C09B045;
        Fri, 24 Apr 2020 06:09:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 08FCA2049A;
        Fri, 24 Apr 2020 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587733769; bh=nmJMIaO9S4iz7eSCHHpszDqwZBHuXACl/U+N3ZMJpSM=;
        h=From:To:Cc:Subject:Date:From;
        b=trOyHbnse5dgxLHn9kABZV9a9LO81J4vxLLDtRdA89ZFfgoG8TQVphgg5ZqYJSluD
         74ilSTzZ8au6ZtOjtpAtvjnCc76AAZqzZdNTS/Ggw7dpqSQzpqOeD624S9UYE2Ix0o
         gU6Kse6fHaZvszqshVSONVSBN0iqRemmRCp//bQEhhlYCXJDzUMLGjcO9HjP7WL1ek
         9+sVCllF8YouWHdDz+Y0L0nDw+Pfkrpi843/bT8WqN82KmS2t6NLklSf+9Vi2vo8TF
         WffUA+iyHGLOqvE+uPvSuNxSxXdG6YvpmD+7bZ8ya1BYTtSFoXM4LwIHYK0WUWoCIM
         m53qtW9X/T2AA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v5 0/6] Loongson PCI Generic Driver
Date:   Fri, 24 Apr 2020 21:08:31 +0800
Message-Id: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
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

Is it possible to let patch 1~4 go through PCI tree and patch
5~6 go through MIPS tree?

Thanks.

Jiaxun Yang (6):
  PCI: OF: Don't remap iospace on unsupported platform
  PCI: Don't disable decoding when mmio_always_on is set
  PCI: Add Loongson PCI Controller support
  dt-bindings: Document Loongson PCI Host Controller
  MIPS: DTS: Loongson64: Add PCI Controller Node
  MIPS: Loongson64: Switch to generic PCI driver

 .../devicetree/bindings/pci/loongson.yaml     |  62 +++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi   |  17 +-
 arch/mips/loongson64/Makefile                 |   2 +-
 arch/mips/loongson64/vbios_quirk.c            |  29 ++
 arch/mips/pci/Makefile                        |   1 -
 arch/mips/pci/fixup-loongson3.c               |  71 -----
 arch/mips/pci/ops-loongson3.c                 | 116 --------
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-loongson.c         | 257 ++++++++++++++++++
 drivers/pci/of.c                              |   9 +
 drivers/pci/probe.c                           |   2 +-
 13 files changed, 386 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
 create mode 100644 arch/mips/loongson64/vbios_quirk.c
 delete mode 100644 arch/mips/pci/fixup-loongson3.c
 delete mode 100644 arch/mips/pci/ops-loongson3.c
 create mode 100644 drivers/pci/controller/pci-loongson.c

-- 
2.26.0.rc2

